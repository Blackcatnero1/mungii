<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html>
<head>
    <title>실시간 미세먼지 확인하기</title>
    <meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css" href="/mis/css/w3.css">
	<link rel="stylesheet" type="text/css" href="/mis/css/user.css">
	<script type="text/javascript" src="/mis/js/jquery-3.7.1.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css" integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
    <script type="text/javascript">
        $(document).ready(function(){
			$('#myPage').click(function(){
				$(location).attr('href', '/mis/member/mypage.mis');
			});
			$('#join').click(function(){
				$(location).attr('href', '/mis/member/join.mis');
			});
            $('#logout').click(function(){
                $(location).attr('href', '/mis/realTimeDust/rlogout.mis');
            });
            $('#login').click(function(){
                $(location).attr('href', '/mis/realTimeDust/rlogin.mis');
            });
            
        	var issubmit = false;
        	
            $('#home').click(function(){
                $(location).attr('href', '/mis/main.mis');
            });
            
            $('#gomis').click(function(){
                $(location).attr('href', '/mis/kpred/kpred.mis');
            });

            $('#gopark').click(function(){
                $(location).attr('href', '/mis/park/park.mis');
            });
 			
            $('#goback').click(function(){
            	$(location).attr('href', '/mis/realTimeDust/view.mis');
            });

            $('#goPred').click(function(){
				// 예측 날짜와 도시 이름 받아오기
				var date = $('#predictionDate').val();
				var name = $('#predictionDate').attr('name');
				
				// 현재 날짜 가져오기
				var toDate = new Date();
				var inputDate = new Date(date);
				
				// 날짜 비교
				var maxDate = new Date(toDate);
				maxDate.setDate(toDate.getDate() + 3);
				
				if (inputDate < toDate || inputDate > maxDate) {
				    alert('날짜를 잘못 입력하셨습니다.');
				    location.reload(true);
				    return false;
				}
			
				// 이중 서브밋 확인 및 초기화
				if (issubmit) {
				    alert("저장 데이터를 초기화 하기 위해서 새로고침을 진행합니다.");
				    location.reload(true);
				    return false;
				}
				
				// submit 되었음을 확인
				issubmit = true;
				
				// form태그에 넣는 과정
				var el_Date = document.createElement('input');
				$(el_Date).attr('type', 'hidden');
				$(el_Date).attr('name', 'date');
				$(el_Date).val(date);
				
				var el_Name = document.createElement('input');
				$(el_Name).attr('type', 'hidden');
				$(el_Name).attr('name', 'name');
				$(el_Name).val(name);
				
				$('#frm').append(el_Date);
				$('#frm').append(el_Name);
				
				// form 태그 submit
				$('#frm').attr('action', '/mis/realTimeDust/goPred.mis');
				$('#frm').submit();
            });
            
            $(document).on("click", "#mispred", function() {
                // 모달 표시
                document.getElementById('predModel').style.display = 'block';
                // 클릭된 요소의 name 속성 값 가져오기
                var getName = $(this).attr("name");
				$("#predictionDate").attr('name', getName);
                // 제목을 추가하기 전에 기존 내용을 제거
                $('#predTitle').empty(); 
                // 새로운 제목 추가
                $('#predTitle').html("<h2>" + getName + " 미세먼지 예측하기</h2>");
            });
        });
    </script>
    <script>
        let map;
        let infoWindow;
        let marker;
        let geocoder;

        function initMap() {
            const mapElement = document.querySelector('#map');

            map = new google.maps.Map(mapElement, {
                center: { lat: 36.35111, lng: 127.38500 },
                zoom: 7,
                /* disableDoubleClickZoom: true, */ // 더블 클릭 줌 비활성화
            });

            infoWindow = new google.maps.InfoWindow();
            geocoder = new google.maps.Geocoder();

         	// 지도 클릭 이벤트 리스너
            google.maps.event.addListener(map, 'click', function(event) {
                event.stop();
            });

         	// 도시 버튼 클릭 이벤트
            document.querySelectorAll('#sideButton').forEach(button => {
                button.addEventListener('click', function() {
                	const cityName_val = this.innerText.trim();
                    const cityName = this.getAttribute('name');
                    
                    if (cityName[0] !== '@') {
                        $('#'+cityName).slideToggle();
                    }
                    
                    const token = "4486804fae4637346c72b8cc4611b6dea040c64f";
                    const apiUrl = 'https://api.waqi.info/feed/' + cityName + '/?token=' + token;
                    $.ajax({
                        url: apiUrl,
                        type: "GET",
                        dataType: "json",
                        success: function(data) {
                            if (data.status === "ok" && data.data && data.data.city && data.data.city.geo && data.data.city.url) {
                                const lat = data.data.city.geo[0];
                                const lng = data.data.city.geo[1];
                                const airQualityURL = data.data.city.url;
                                
                                placeMarkerAndInfoWindow(new google.maps.LatLng(lat, lng), cityName, cityName_val, airQualityURL);
                            } else {
                                alert('데이터가 없습니다.');
                            }
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            console.error("에러 상태:", textStatus);
                            console.error("에러 발생:", errorThrown);
                            console.error("응답 텍스트:", jqXHR.responseText);
                            alert("대기질 데이터를 불러오지 못했습니다.");
                        }
                    });
                });
            });
        }

        function geocodeLatLng(latLng) {
            geocoder.geocode({ location: latLng, language: 'en' }, (results, status) => {
                if (status === 'OK') {
                    if (results[0]) {
                        const city = getCityFromResults(results);
                        if (city) {
                            placeMarkerAndInfoWindow(latLng, city);
                        } else {
                            alert('해당 위치에 대한 도시 정보가 없습니다.');
                        }
                    } else {
                        alert('결과를 찾을 수 없습니다.');
                    }
                } else {
                    alert('지오코딩에 실패했습니다. 오류: ' + status);
                }
            });
        }

        function getCityFromResults(results) {
            for (let i = 0; i < results.length; i++) {
                const addressComponents = results[i].address_components;
                for (let j = 0; j < addressComponents.length; j++) {
                    const component = addressComponents[j];
                    if (component.types.includes('locality') ||
                        component.types.includes('administrative_area_level_1') ||
                        component.types.includes('administrative_area_level_2') ||
                        component.types.includes('postal_town')) {
                        return component.long_name;  // 영어 이름으로 변경
                    }
                }
            }
            return null;
        }

        function placeMarkerAndInfoWindow(latLng, city, cityName_val, airQualityURL) {
	        const latitude = latLng.lat();
	        const longitude = latLng.lng();
	        const cctv = "";
	     	// Remove the existing marker if it exists
	        if (marker) {
	            marker.setMap(null);
	        }
	        $.ajax({
	        	url : "/mis/realTimeDust/getCCTV.mis",
	        	type : 'post',
	        	dataType: 'json',
	        	data : {
	        		name : cityName_val
	        	},
	        	success : function(obj) {
	        		const contentString =
	        	        '<div>' +
	        		     	'<div class="w3-padding-left" style="display: flex; align-items: center">' +
	        		        	'<h2><strong>' + cityName_val + '</strong></h2>' +
	        		        	'<div>' +
	        		        		'<p class="w3-btn" style="cursor:pointer;"><a href="' + airQualityURL + '/kr/m" target="iframe_a" class="w3-padding-small">미세먼지 현황 보기</a></p>' +
	        		        		'<p class="w3-btn" style="cursor:pointer;"><a href="'+obj.result+'" target="iframe_a" class="w3-padding-small">CCTV 보기</a></p>' +
	        		        		'<p id="mispred" name="'+cityName_val+'" class="w3-btn w3-padding-small" style="cursor:pointer;"><u>' + cityName_val + ' 지역 미세먼지 예측하기</u></p>' +
	        	       			'</div>' +
	        		        '</div>' +
	        		        '<iframe src="' + airQualityURL + '/kr/m" name="iframe_a" height="300px" width="100%" dtitle="Iframe Example" scrolling="no"></iframe>' +
	        		        '<h5><strong> * 주의: 한국 데이터와 단위가 다르기 때문에 아래 내용을 참고</strong></h5>' +
	        		        '<h6>&nbsp&nbsp&nbsp&nbsp 좋음( 0 ~ 100 )  : 자유로운 실외 활동 권장</h6>' +
	        		        '<h6>&nbsp&nbsp&nbsp&nbsp 보통( 101 ~ 200 ): 몸 상태에 따라 유의하여 활동</h6>' +
	        		        '<h6>&nbsp&nbsp&nbsp&nbsp 나쁨( 201 ~ 300 ): 호흡기 환자의 무리한 실외 활동은 피해야 함</h6>' +
	        		        '<h6>&nbsp&nbsp&nbsp&nbsp 매우나쁨( 300 ~ ): 기침, 목통증 있는 사람은 실외 활동을 피해야 함</h6>' +
	        	        '</div>';
	        	        
	        		// 성공적으로 데이터를 가져온 후에만 새 마커 생성
	    			marker = new google.maps.Marker({
	    			    position: latLng,
	    			    map: map,
	    			    title: city
	    			});
	    			
	    			// 정보창 설정 및 열기
	    			infoWindow.setContent(contentString);
	    			infoWindow.open(map, marker);
	             },
	        	error : function() {
	        		alert("error");
	        	}
	        });
		}
           
        function loadScript() {
            const script = document.createElement('script');
            script.src = 'https://maps.googleapis.com/maps/api/js?key=AIzaSyDd8M15yV6UPpDPJwLAOPo7GKoKjMu9ecs&callback=initMap&libraries=places&v=beta&region=KR';
            script.async = true;
            script.onload = () => console.log('Google Maps 스크립트가 로드되었습니다.');
            script.onerror = () => console.error('Google Maps 스크립트를 로드하지 못했습니다.');
            document.head.appendChild(script);
        }

        window.addEventListener('load', loadScript);
    </script>
    <style>
        html,
        body {
            height: 100%;
            margin: 0;
            display: flex;
            flex-direction: column;
        }
		.welcome-text {
		    display: inline-block;
		    white-space: nowrap;
		    overflow: hidden;
		    text-overflow: ellipsis;
		    max-width: 100%;
		  }
        /* #header {
            width: 100%;
            height: 100px;
            background-color: #007BFF;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
        } */

        #map-container {
            flex: 1;
            display: flex;
        }

        #map {
            width: 100%; /* 지도의 너비를 75%로 설정 */
            height: 100%; /* 헤더 높이를 제외한 높이 */
            display: block;
            border-left: 3px solid #fff;
            border-top: 3px solid #fff;
        }

      /*   #sidebar {
            width: 10%; /* 사이드바 너비 설정 */
            padding: 10px;
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
            background-color: #f0f0f0;
            align-items: flex-end;
        }
        
        /* #predModel{
			position: fixed;
			left: 50%;
			top: 50%;
			transform: translate(-50%, -50%);
        }
        
        .w3-btn {
        	margin-left: 5px; /* 원하는 크기로 조절 */
    	}
        .button {
            padding: 10px;
            font-size: 16px;
            background-color: #007BFF;
            color: white;
            border: none;
            cursor: pointer;
            width: 100%;
            margin-bottom: 5px;
            margin-top: 5px;
        }

        /* .sbutton {
            padding: 5px;
            font-size: 16px;
            background-color: #007BFF;
            color: white;
            border: none;
            cursor: pointer;
            width: 70%;
            margin-bottom: 5px;
            margin-left: 29px;
        } */
        
       .gm-style-iw {
	        width: 800px; /* Adjust based on iframe width plus any padding/margin */
	        height: 605px;
	        padding: 10px;
	        box-sizing: border-box;
	    }
	    
	    .sbut {
	    	display: None;
    	}
    	/* 드롭다운 콘텐츠 숨기기 */
        .w3-dropdown-hover:hover .dropdown-content {
            display: grid; /* 마우스를 올렸을 때 그리드로 변경 */
            grid-template-columns: 1fr 1fr; /* 두 열로 나눔 */
        }

        /* 드롭다운 콘텐츠 컨테이너 */
        .dropdown-content {
            display: none; /* 기본적으로 숨김 */
            width: fit-content; /* 아이템 크기에 맞게 조정 */
            padding: 0;
            box-sizing: border-box;
            position: absolute; /* 부모 요소 기준으로 절대 위치 */
            z-index: 1; /* 드롭다운이 다른 콘텐츠 위에 나타나도록 설정 */
            background-color: white; /* 드롭다운 배경색 */
        }

        /* 드롭다운 아이템 */
        .dropdown-item {
            box-sizing: border-box;
            text-align: center; /* 텍스트 가운데 정렬 */
            padding: 8px 0;
            border: 1px solid #ccc; /* 아이템 사이의 경계선 */
            margin: -1px 0 0 -1px; /* 겹치는 경계선 제거 */
        }

        /* 버튼 스타일 */
        .w3-button.w3-black {
            position: relative; /* 드롭다운 위치 설정을 위한 상대 위치 */
        }
    </style>
</head>
<body class="w3-light-grey">
	<form method="POST" id="frm">
	</form>
<!-- Top container -->
<div class="w3-bar w3-top w3-black w3-large" style="z-index:4">
  <button class="w3-bar-item w3-button w3-hide-large w3-hover-none w3-hover-text-light-grey" onclick="w3_open();"><i class="fa fa-bars"></i>  Menu</button>
  <span class="w3-bar-item w3-right w3-button w3-col" id="home"><i class="fa-solid fa-house"></i></span>
</div>
  

<!-- Sidebar/menu -->
<nav class="w3-sidebar w3-collapse w3-white w3-animate-left" style="z-index:3;width:200px;" id="mySidebar"><br>
  <div class="w3-container w3-row">
    <div class="w3-col s10 w3-bar">
		<div>&nbsp;</div>
		<div>&nbsp;</div>
		<span>Welcome,  </span>
		<p style="margin-top:5px;"><strong>${SID}</strong> 님<br></p>
	<c:if test="${SID eq 'Guest'}">
      		<a class="w3-bar-item w3-button"><i class="fa-solid fa-user " id="login"></i></a>
      		<a class="w3-bar-item w3-button"><i class="fa-solid fa-user-plus " id="join"></i></a>
	</c:if>
	<c:if test="${SID eq null}">
      		<a class="w3-bar-item w3-button"><i class="fa-solid fa-user " id="login"></i></a>
      		<a class="w3-bar-item w3-button"><i class="fa-solid fa-user-plus " id="join"></i></a>
	</c:if>
	<c:if test="${SID ne null and SID ne 'Guest'}">
      		<a class="w3-bar-item w3-button"><i class="fa-solid fa-user-xmark" id="logout"></i></a>
      		<a class="w3-bar-item w3-button"><i class="fa-solid fa-address-card" id="myPage"></i></a>
	</c:if>
    </div>
  </div>
	<hr>
	<div class="w3-container">
    	<h5><b><i class="fa fa-bars"></i> 도시 목록</b></h5>
 	</div>
 	<div class="w3-bar-block">
    <!-- 사이드 바 -->
    <div id="sidebar">
		<div id="si">        		
			<div class="w3-dropdown-hover">
			    <button id="ssideButton" class="w3-button button w3-center" name="seoul">서울</button>
			    <div class="w3-dropdown-content dropdown-content w3-border">
            <c:forEach var="DATA" items="${SLIST}">
	            	<button id="sideButton" name="@${DATA.apicode}" class="sbutton w3-bar-item w3-button w3-center"><small>${DATA.name}</small></button>
            </c:forEach>
			    </div>
			</div>
		</div>
		</div>
	</div>
</nav>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:200px;margin-top:37px;">

  <!-- Header -->
  <header class="w3-center" style="padding-bottom:10px">
     <h6 style="background-color: rgb(171, 209, 98);"><button class="w3-button w3-third w3-large w3-opacity w3-hover-opacity-off" id="goback"><b>실시간 정보 보기</b></button></h6>
     <h6 style="background-color: rgb(246, 104, 106);"><button class="w3-button w3-third w3-large w3-opacity w3-hover-opacity-off" id="gomis"><b>미세먼지 예측하기</b></button></h6>
     <h6 style="background-color: rgb(164, 125, 184);"><button class="w3-button w3-third w3-large w3-opacity w3-hover-opacity-off" id="gopark"><b>관광지 추천받기</b></button></h6>
  </header>
</div>
<div id="map"></div>	


<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>


<!-- 예측 Model창 -->
<div id="predModel" class="w3-modal">
    <div class="w3-modal-content w3-animate-zoom w3-card-4">
        <header id="modelheader" class="w3-container w3-teal"> 
            <span onclick="document.getElementById('predModel').style.display='none'" 
                class="w3-button w3-display-topright">&times;</span>
            <h2 id="predTitle">미세먼지 예측하기</h2>
        </header>
        <div class="w3-container">
            <!-- 기존 텍스트를 날짜 선택 필드로 변경 -->
            <p> </p>
            <label for="predictionDate">예측 날짜 선택:</label>
            <input type="date" id="predictionDate">
            <button id="goPred" class="w3-margin-left">확인</button>
            <p> </p>
        </div>
        <footer class="w3-container w3-teal">
            <p>금일로부터 3일뒤의 날짜만 확인 가능합니다.</p>
        </footer>
    </div>
</div>

<script>
    // 현재 날짜를 가져옵니다.
    const today = new Date();
    
    // 3일 후의 날짜를 계산합니다.
    const threeDaysLater = new Date();
    const tomorrow = new Date();
    threeDaysLater.setDate(today.getDate() + 3);
    tomorrow.setDate(today.getDate() + 1);
    // 'YYYY-MM-DD' 형식으로 날짜를 포맷팅합니다.
    const formatDate = date => date.toISOString().split('T')[0];
    
    // 날짜 선택 필드를 현재 날짜로 설정하고 최소 및 최대 날짜를 설정합니다.
    const predictionDateInput = document.getElementById('predictionDate');
    predictionDateInput.min = formatDate(tomorrow); // 오늘 날짜
    predictionDateInput.max = formatDate(threeDaysLater); // 4일 후 날짜
    predictionDateInput.value = formatDate(tomorrow); // 기본값을 오늘 날짜로 설정
</script>
<script>
// Get the Sidebar
var mySidebar = document.getElementById("mySidebar");

// Get the DIV with overlay effect
var overlayBg = document.getElementById("myOverlay");

// Toggle between showing and hiding the sidebar, and add overlay effect
function w3_open() {
  if (mySidebar.style.display === 'block') {
    mySidebar.style.display = 'none';
    overlayBg.style.display = "none";
  } else {
    mySidebar.style.display = 'block';
    overlayBg.style.display = "block";
  }
}

// Close the sidebar with the close button
function w3_close() {
  mySidebar.style.display = "none";
  overlayBg.style.display = "none";
}
</script>

<script>
  function adjustFontSize() {
    const textElement = document.getElementById('sid-text');
    const parentWidth = textElement.parentElement.offsetWidth;
    let fontSize = parseInt(window.getComputedStyle(textElement).fontSize);
    
    while (textElement.scrollWidth > parentWidth && fontSize > 8) {
      fontSize -= 1;
      textElement.style.fontSize = fontSize + 'px';
    }
  }

  document.addEventListener('DOMContentLoaded', adjustFontSize);
  window.addEventListener('resize', adjustFontSize);
</script>
</body>
</html>