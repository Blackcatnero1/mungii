<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <title>해외 미세먼지 확인하기</title>
    <meta charset="UTF-8">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/mis/css/w3.css">
    <link rel="stylesheet" type="text/css" href="/mis/css/user.css">
    <script type="text/javascript" src="/mis/js/jquery-3.7.1.min.js"></script>
    <script>
        let map;
        let infoWindow;
        let marker;
        let geocoder;

        function initMap() {
            const mapElement = document.querySelector('#map');

            map = new google.maps.Map(mapElement, {
                center: { lat: 36.2048, lng: 138.2529 },
                zoom: 4,
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
                            if (data.status === "ok" && data.data && data.data.city && data.data.city.geo) {
                                const lat = data.data.city.geo[0];
                                const lng = data.data.city.geo[1];
                                
                                placeMarkerAndInfoWindow(new google.maps.LatLng(lat, lng), cityName, cityName_val);
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

        function placeMarkerAndInfoWindow(latLng, city, cityName_val) {
            const latitude = latLng.lat();
            const longitude = latLng.lng();
            const token = "4486804fae4637346c72b8cc4611b6dea040c64f";
            const apiUrl = 'https://api.waqi.info/feed/' + city + '/?token=' + token;

         	// Remove the existing marker if it exists
            if (marker) {
                marker.setMap(null);
            }
         	
            // 대기질 데이터 가져오기
            $.ajax({
                url: apiUrl,
                type: "GET",
                dataType: "json",
                success: function(data) {
                    if (data.status === "ok" && data.data && data.data.city && data.data.city.url) {
                        const airQualityURL = data.data.city.url;

                        const contentString = '<div>' +
                        	'<div style="display: flex; align-items: center">' +
                            '<h2 class="w3-margin"><strong>' + cityName_val + '</strong></h2>' +
                            '<p class="w3-margin"><a href="' + airQualityURL + '/kr/m" target="iframe_a" class="w3-padding-small">미세먼지 현황 보기</a></p>' +
                            '<p><a href="http://www.utic.go.kr/view/map/openDataCctvStream.jsp?key=jSCwqHY02Hb9Srt2fkSAi9gh2ldMPqgALc1YVGkLCTfErXroB9mU8eyhcVORKvpjpKuowcBBOztr7Sr8As1g&cctvid=L933089&cctvName=%EC%9D%B8%EC%B2%9C%20%EC%A4%91%EA%B5%AC%20%EC%97%B0%EC%95%88%EB%B6%80%EB%91%90&kind=KB&cctvip=9991&cctvch=null&id=null&cctvpasswd=null&cctvport=null" target="iframe_a" class="w3-padding-small">CCTV 보기</a></p>' +
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

        #header {
            width: 100%;
            height: 100px;
            background-color: #007BFF;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
        }

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

        #sidebar {
            width: 10%; /* 사이드바 너비 설정 */
            padding: 10px;
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background-color: #f0f0f0;
            align-items: flex-end;
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

        .sbutton {
            padding: 5px;
            font-size: 16px;
            background-color: #007BFF;
            color: white;
            border: none;
            cursor: pointer;
            width: 70%;
            margin-bottom: 5px;
            margin-left: 29px;
        }
        
        .gm-style-iw {
	        width: 800px; /* Adjust based on iframe width plus any padding/margin */
	        padding: 10px;
	        box-sizing: border-box;
	    }
	    
	    .sbut {
	    	display: None;
    </style>
</head>
<body>
    <div id="header">메인 배너</div>
    <!-- 버튼헤더(필요시 갯수추가) -->
	<header class="w3-container w3-center w3-white" style="background-color: #f0f0f0;">
	    <h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off">버튼1</button></h6>
	    <h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off">버튼2</button></h6>
	    <h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off">버튼3</button></h6>
	</header>
    <div id="map-container">
        <div id="sidebar">
        		<div id="si">        		
		            <button id="sideButton" class="button" name="seoul">서울</button>
		            <div id="seoul" class="sbut">
		            	<button id="sideButton" name="@1670" class="sbutton"><small>강서</small></button>
		            	<button id="sideButton" name="@1685" class="sbutton"><small>양천</small></button>
		            	<button id="sideButton" name="@1673" class="sbutton"><small>구로</small></button>
		            	<button id="sideButton" name="@1686" class="sbutton"><small>영등포</small></button>
		            	<button id="sideButton" name="@1674" class="sbutton"><small>금천</small></button>
		            	<button id="sideButton" name="@1678" class="sbutton"><small>동작</small></button>
		            	<button id="sideButton" name="@1671" class="sbutton"><small>관악</small></button>
		            	<button id="sideButton" name="@1681" class="sbutton"><small>서초</small></button>
		            	<button id="sideButton" name="@1667" class="sbutton"><small>강남</small></button>
		            	<button id="sideButton" name="@1684" class="sbutton"><small>송파</small></button>
		            	<button id="sideButton" name="@1668" class="sbutton"><small>강동</small></button>
		            </div>
		            <button id="sideButton" class="button" name="incheon">인천</button>
		            <div id="incheon" class="sbut">
		            	<button id="sideButton" name="@1670" class="sbutton"><small>인천1</small></button>
		            </div>
		            
		            <button id="sideButton" class="button" name="daejeon">대전</button>
		            <div id="daejeon" class="sbut">
		            	<button id="sideButton" name="@1670" class="sbutton"><small>대전1</small></button>
		            </div>
		            
		            <button id="sideButton" class="button" name="daegu">대구</button>
		            <div id="daegu" class="sbut">
		            	<button id="sideButton" name="@1670" class="sbutton"><small>대구1</small></button>
		            </div>
		            
		            <button id="sideButton" class="button" name="ulsan">울산</button>
		            <div id="ulsan" class="sbut">
		            	<button id="sideButton" name="@1670" class="sbutton"><small>울산1</small></button>
		            </div>
		            
		            <button id="sideButton" class="button" name="busan">부산</button>
		            <div id="busan" class="sbut">
		            	<button id="sideButton" name="@1670" class="sbutton"><small>부산1</small></button>
		            </div>
		            
		            <button id="sideButton" class="button" name="gwangju">광주</button>
		            <div id="gwangju" class="sbut">
		            	<button id="sideButton" name="@1670" class="sbutton"><small>광주1</small></button>
		            </div>
        		</div>
        </div>
        <div id="map"></div>
    </div>
</body>
</html>
