<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>${LNAME} 날씨 예측하기</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="/mis/css/w3.css">
<link rel="stylesheet" type="text/css" href="/mis/css/user.css">
<script type="text/javascript" src="/mis/js/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css" integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">

<style>
	.w3-container p {
        margin-top: 5px;
        margin-bottom: 5px;
    }
    #disInfo {
        position: relative;
        display: inline-block;
        cursor: pointer; /* 기본 상태에서도 커서 변경 */
    }
    #disInfo .tooltip-text {
		visibility: hidden;
		width: 700px;
		background-color: white;
		color: #000;
		text-align: left;
		border-radius: 5px;
		padding: 10px;
		box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
		position: absolute;
		z-index: 1;
		font-size: 13px;
		bottom: 100%;
		left: 50%;
		margin-left: -60px;
		opacity: 0;
		transition: opacity 0.3s;
    }
    #disInfo .tooltip-text::after {
        content: "";
        position: absolute;
        top: 100%; /* 화살표 위치 */
        left: 60px;
        margin-left: -5px;
        border-width: 5px;
        border-style: solid;
        border-color: yellow transparent transparent transparent;
    }
    #disInfo:hover .tooltip-text {
        visibility: visible;
        opacity: 1;
    }
    
    .legbutton{
    	height: 22px;
	    line-height: 10px;
	    display: flex;
	    align-items: center;
	    justify-content: center;
    }
    
    .legtext{
    	font-size: 13px;
    }
    
    #leghr {
    	margin-top: 3px;
    	margin-bottom: 5px;
	    background:pink;
	    height:1px;
	    border:0;
	}
	.treecol {
	    display: block;
	    margin-bottom: 10px;
	}
</style>
<script type="text/javascript">
        $(document).ready(function(){
        	$('#myPage').click(function(){
				$(location).attr('href', '/mis/member/mypage.mis');
			});
        	
			$('#join').click(function(){
				$(location).attr('href', '/mis/member/join.mis');
			});
			
            $('#logout').click(function(){
            	alert('회원 정보에 변화가 생겨서 이전페이지로 갑니다.');
                $(location).attr('href', '/mis/realTimeDust/rlogout.mis');
            });
            
            $('#login').click(function(){
            	alert('회원 정보에 변화가 생겨서 이전페이지로 갑니다.');
                $(location).attr('href', '/mis/realTimeDust/rlogin.mis');
            });
            
            $('#goBack').click(function(){
            	$(location).attr('href', '/mis/realTimeDust/view.mis');
            });
            $('#goPred').click(function(){
            	$(location).attr('href', '/mis/kpred/kpred.mis');
            });
            $('#goTime').click(function(){
            	$(location).attr('href', 'http://58.72.151.124:6012/pred');
            });
            $('#goPark').click(function(){
            	$(location).attr('href', '/mis/park/park.mis');
            });

            $('#home').click(function(){
            	$(location).attr('href', '/mis/main.mis');
            });

            $('#gopred').click(function(){
            	var date = $('#predictionDate').val()
            	var name = $('#lang').val()
            	
            	alert(date + ' / ' + name);
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

            $('#moreShow').click(function(){
            	window.open('https://www.google.com/search?q=${PRED.name}+%EA%B4%80%EA%B4%91%EB%AA%85%EC%86%8C&sca_esv=62f2cb7c00ed810a&sca_upv=1&sxsrf=ADLYWIKrXvG5pAvLeqVjjNNZbujx_gEtvw:1720577807961&udm=15&sa=X&ved=2ahUKEwjH5rTos5uHAxWfp1YBHZRlBAoQxN8JegQIMhAb&biw=1422&bih=996&dpr=0.9', '_blank');
            });
            
            $('.legbutton').click(function() {
            	var clickid = $(this).attr('id');
            	$('#pm10').removeClass('w3-red');
            	$('#pm25').removeClass('w3-red');
            	$('#oz').removeClass('w3-red');
            	$('#no').removeClass('w3-red');
            	$('#co').removeClass('w3-red');
            	$('#so').removeClass('w3-red');
                // 클릭된 버튼에 active 클래스를 추가합니다.
                $(this).addClass('w3-red');
            	switch(clickid){
            		case "pm10":
            			$('#good').html('<i class="fa-regular fa-circle-dot w3-text-blue"></i> 좋음(0~30)');
            			$('#middle').html('<i class="fa-regular fa-circle-dot w3-text-green"></i> 보통(31~80)');
            			$('#bad').html('<i class="fa-regular fa-circle-dot w3-text-yellow"></i> 나쁨(81~150)');
            			$('#toobad').html('<i class="fa-regular fa-circle-dot w3-text-red"></i> 매우나쁨(151~)');
                        break;
            		case "pm25":
            			$('#good').html('<i class="fa-regular fa-circle-dot w3-text-blue"></i> 좋음(0~15)');
            			$('#middle').html('<i class="fa-regular fa-circle-dot w3-text-green"></i> 보통(16~35)');
            			$('#bad').html('<i class="fa-regular fa-circle-dot w3-text-yellow"></i> 나쁨(36~75)');
            			$('#toobad').html('<i class="fa-regular fa-circle-dot w3-text-red"></i> 매우나쁨(75~)');
                        break;
            		case "oz":
            			$('#good').html('<i class="fa-regular fa-circle-dot w3-text-blue"></i> 좋음(0~0.03)');
            			$('#middle').html('<i class="fa-regular fa-circle-dot w3-text-green"></i> 보통(0.031~0.09)');
            			$('#bad').html('<i class="fa-regular fa-circle-dot w3-text-yellow"></i> 나쁨(0.091~0.15)');
            			$('#toobad').html('<i class="fa-regular fa-circle-dot w3-text-red"></i> 매우나쁨(0.151~)');
                        break;
            		case "no":
            			$('#good').html('<i class="fa-regular fa-circle-dot w3-text-blue"></i> 좋음(0~0.03)');
            			$('#middle').html('<i class="fa-regular fa-circle-dot w3-text-green"></i> 보통(0.031~0.06)');
            			$('#bad').html('<i class="fa-regular fa-circle-dot w3-text-yellow"></i> 나쁨(0.061~0.2)');
            			$('#toobad').html('<i class="fa-regular fa-circle-dot w3-text-red"></i> 매우나쁨(0.21~)');
                        break;
            		case "co":
            			$('#good').html('<i class="fa-regular fa-circle-dot w3-text-blue"></i> 좋음(0~2)');
            			$('#middle').html('<i class="fa-regular fa-circle-dot w3-text-green"></i> 보통(2.1~9)');
            			$('#bad').html('<i class="fa-regular fa-circle-dot w3-text-yellow"></i> 나쁨(9.1~15)');
            			$('#toobad').html('<i class="fa-regular fa-circle-dot w3-text-red"></i> 매우나쁨(15.1~)');
                        break;
            		case "so":
            			$('#good').html('<i class="fa-regular fa-circle-dot w3-text-blue"></i> 좋음(0~0.02)');
            			$('#middle').html('<i class="fa-regular fa-circle-dot w3-text-green"></i> 보통(0.021~0.05)');
            			$('#bad').html('<i class="fa-regular fa-circle-dot w3-text-yellow"></i> 나쁨(0.051~0.15)');
            			$('#toobad').html('<i class="fa-regular fa-circle-dot w3-text-red"></i> 매우나쁨(0.151~)');
                        break;
                }
            });
        });
</script>
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
<nav class="w3-sidebar w3-collapse w3-white w3-animate-left" style="z-index:3;width:300px;" id="mySidebar"><br>
  <div class="w3-container w3-row">
    <div class="w3-col s4">
      <img src="/mis/avatar/img_avatar12.png" class="w3-circle w3-margin-right" style="width:46px">
    </div>
    <div class="w3-col s8 w3-bar">
      <span>${SID} <strong>${PRED.date}</strong></span><br>
      <c:if test="${SID eq null or SID eq 'Guest'}">
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
    <h5><i class="fa-solid fa-list"></i> 목차</h5>
    <hr>
  </div>
  <div class="w3-bar-block">
    <a href="#" class="w3-bar-item w3-button w3-padding-16 w3-hide-large w3-dark-grey w3-hover-black" onclick="w3_close()" title="close menu"><i class="fa fa-remove fa-fw"></i>  Close Menu</a>
    <a href="#" class="w3-bar-item w3-button w3-padding w3-red" id="realTime"><i class="fa fa-eye fa-fw"></i> 단기 예측</a>
    <a id = "goPred" href="#" class="w3-bar-item w3-button w3-padding"><i class="fa fa-users fa-fw"></i> 중(장)기 예측</a>
    <a id="goTime" class="w3-bar-item w3-button w3-padding"><i class="fa fa-users fa-fw"></i> 시간별 예측</a>
  </div>
</nav>


<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:300px;margin-top:43px;">

  <!-- Header -->
  <header class="w3-container">
        <h6 style="background-color: rgb(171, 209, 98);"><button class="w3-button w3-third w3-large w3-opacity w3-hover-opacity-off" id="goback"><b>실시간 정보 보기</b></button></h6>
        <h6 style="background-color: rgb(246, 104, 106);"><button class="w3-button w3-third w3-large w3-opacity w3-hover-opacity-off" id="gomis"><b>미세먼지 예측하기</b></button></h6>
        <h6 style="background-color: rgb(164, 125, 184);"><button class="w3-button w3-third w3-large w3-opacity w3-hover-opacity-off" id="gopark"><b>관광지 추천받기</b></button></h6>
    <div class='w3-col' style="padding-top:10px">
    	<div class='w3-left'>
		    <h5><b><i class="fa-solid fa-cloud-sun-rain"></i>${PRED.name}<small>(${PRED.date})</small> 날씨정보</b></h5>	
    	</div>
    	<div class="w3-right">
		    <div style="padding-top:5px">
			    <span class="w3-bar-item w3-right w3-button w3-col" id="gopred"><i class="fa-solid fa-square-check w3-xlarge"></i></span>			     		
    		</div>
    	</div>
    	<div class="w3-right">
		    <div style="padding-top:10px">
			    <label for="lang">예측 도시</label>
			    <select name="languages" id="lang" style="width: 100px; height: 30px;">
			    	<option value="${PRED.name}">${PRED.name}</option>
	<c:forEach var="DATA" items="${LCITY}">
	            	<option value="${DATA}">${DATA}</option>
	</c:forEach>
			    </select>
    		</div>
    	</div>
    	<div class="w3-right" style="padding-left: 10px; padding-right: 10px;">
    		<div style="padding-top:10px">
			    <label for="predictionDate">예측 날짜 선택:</label>
	            <input type="date" id="predictionDate">    		
    		</div>
    	</div>
<script>
	// 현재 날짜를 가져옵니다.
	const today = new Date();
	const selectedDateStr = '${PRED.date}';
	const selectedDate = new Date(selectedDateStr);
	
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
	predictionDateInput.value = formatDate(selectedDate); // 기본값을 오늘 날짜로 설정
</script>
    </div>
  </header>

  <div class="w3-row-padding w3-margin-bottom">
    <div class="w3-quarter">
      <div class="w3-container w3-red w3-padding-16">
        <div class="w3-left"><i class="fa-solid fa-temperature-half w3-xxxlarge"></i></div>
        <div class="w3-right">
          <div>
          	<span>최고 기온 : ${PRED.temp_max} <small>°C</small></span>
          </div>
          <div>
          	<span>최저 기온 : ${PRED.temp_min} <small>°C</small></span>
          </div>
          <div>
          	<span>평균 기온 : ${PRED.temp_avg} <small>°C</small></span>
          </div>
        </div>
      </div>
    </div>
    <div class="w3-quarter">
      <div class="w3-container w3-blue w3-padding-16">
        <div class="w3-left"><i class="fa-solid fa-cloud-showers-heavy w3-xxxlarge"></i></div>
        <div class="w3-right">
          <div>
          	<span>&nbsp;</span>
          </div>
          <div>
          	<span>평균 강수량 : ${PRED.rain_avg} <small>mm</small></span>
          </div>
          <div>
          	<span>&nbsp;</span>
          </div>
        </div>
      </div>
    </div>
    <div class="w3-quarter">
      <div class="w3-container w3-teal w3-padding-16">
        <div class="w3-left"><i class="fa-solid fa-wind w3-xxxlarge"></i></div>
        <div class="w3-right">
          <div>
          	<span>평균 풍속 : ${PRED.wind_avg} <small>m/s</small></span>
          </div>
          <div>
          	<span>평균 풍향 : ${PRED.wind_deg}</span>
          </div>
          <div>
          	<span>최고 풍속 : ${PRED.wind_max} <small>m/s</small></span>
          </div>
        </div>
      </div>
    </div>
    <div class="w3-quarter">
      <div class="w3-container w3-orange w3-text-white w3-padding-16">
        <div class="w3-left"><i class="fa-solid fa-water w3-xxxlarge"></i></div>
        <div class="w3-right">
          <div>
          	<span>&nbsp;</span>
          </div>
          <div>
          	<span>평균 습도 : ${PRED.hum_avg} <small>%</small></span>
          </div>
          <div>
          	<span>&nbsp;</span>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="w3-panel">
    <div class="w3-row-padding" style="margin:0 -16px">
      <div class="w3-third">
        <h5><b><i class="fa-solid fa-smog"></i>미세먼지 예측 정보</b></h5>
        <c:if test="${PRED.pred_pm10 == 0}">
	        <img src="/mis/image/하랑이/파랑이.jpg" style="width:100%" alt="일기예보 하랑이">	        
        </c:if>
        <c:if test="${PRED.pred_pm10 == 1}">
	        <img src="/mis/image/하랑이/초록이.jpg" style="width:100%" alt="일기예보 하랑이">	        
        </c:if>
        <c:if test="${PRED.pred_pm10 == 1}">
	        <img src="/mis/image/하랑이/노랑이.jpg" style="width:100%" alt="일기예보 하랑이">	        
        </c:if>
        <c:if test="${PRED.pred_pm10 == 1}">
	        <img src="/mis/image/하랑이/빨강이.jpg" style="width:100%" alt="일기예보 하랑이">	        
        </c:if>        
      </div>
      <div class="w3-twothird">
        <h5>&nbsp;</h5>
        <table class="w3-table w3-striped w3-white">
          <tr>
        <td><i class="fa-solid fa-industry w3-text-red w3-xlarge"></i></td>
            <td>PM10(미세먼지)</td>
        <c:if test="${PRED.pred_pm10 == 0}">
	        <td><i class="fa-regular fa-face-laugh-beam w3-xlarge w3-text-blue"></i> <small>좋음<small></td>
        </c:if>
        <c:if test="${PRED.pred_pm10 == 1}">
	        <td><i class="fa-regular fa-face-laugh w3-xlarge w3-text-green"></i> <small>보통<small></td>
        </c:if>
        <c:if test="${PRED.pred_pm10 == 2}">
	        <td><i class="fa-regular fa-face-frown-open w3-xlarge w3-text-yellow"></i> <small>나쁨<small></td>
        </c:if>
        <c:if test="${PRED.pred_pm10 == 3}">
	        <td><i class="fa-regular fa-face-frown w3-xlarge w3-text-red"></i> <small>매우나쁨<small></td>
        </c:if>
          </tr>
          <tr>
            <td><i class="fa-solid fa-head-side-cough w3-text-orange w3-xlarge"></i></td>
            <td>PM25(초미세먼지)</td>
        <c:if test="${PRED.pred_pm10 == 0}">
	        <td><i class="fa-regular fa-face-laugh-beam w3-xlarge w3-text-blue"></i> <small>좋음<small></td>
        </c:if>
        <c:if test="${PRED.pred_pm10 == 1}">
	        <td><i class="fa-regular fa-face-laugh w3-xlarge w3-text-green"></i> <small>보통<small></td>
        </c:if>
        <c:if test="${PRED.pred_pm10 == 2}">
	        <td><i class="fa-regular fa-face-frown-open w3-xlarge w3-text-yellow"></i> <small>나쁨<small></td>
        </c:if>
        <c:if test="${PRED.pred_pm10 == 3}">
	        <td><i class="fa-regular fa-face-frown w3-xlarge w3-text-red"></i> <small>매우나쁨<small></td>
        </c:if>
          </tr>
          <tr>
            <td><i class="fa-solid fa-globe w3-text-yellow w3-xlarge"></i></td>
            <td>오존(O<small>3</small>)</td>
        <c:if test="${PRED.pred_oz > 0 and PRED.pred_oz <= 0.03}">
	        <td class="w3-text-blue">${PRED.pred_oz}&nbsp;<small>ppm<small></td>
        </c:if>
        <c:if test="${PRED.pred_oz >= 0.031 and PRED.pred_oz <= 0.9}">
	        <td class="w3-text-green">${PRED.pred_oz}&nbsp;<small>ppm<small></td>
        </c:if>
        <c:if test="${PRED.pred_oz >= 0.091 and PRED.pred_oz <= 0.15}">
	        <td class="w3-text-yellow">${PRED.pred_oz}&nbsp;<small>ppm<small></td>
        </c:if>
        <c:if test="${PRED.pred_oz >= 0.151}">
	        <td class="w3-text-red">${PRED.pred_oz}&nbsp;<small>ppm<small></td>
        </c:if>
        <c:if test="${PRED.pred_oz <= 0}">
	        <td>점검중...</td>
        </c:if>
          </tr>
          <tr>
            <td><i class="fa-solid fa-skull-crossbones w3-text-green w3-xlarge"></i></td>
            <td>이산화질소(NO<small>2</small>)</td>
        <c:if test="${PRED.pred_no2 > 0 and PRED.pred_no2 <= 0.03}">
	        <td class="w3-text-blue"><i>${PRED.pred_no2}</i>&nbsp;<small>ppm<small></td>
        </c:if>
        <c:if test="${PRED.pred_no2 >= 0.031 and PRED.pred_no2 <= 0.06}">
	        <td class="w3-text-green"><i>${PRED.pred_no2}</i>&nbsp;<small>ppm<small></td>
        </c:if>
        <c:if test="${PRED.pred_no2 >= 0.061 and PRED.pred_no2 <= 0.2}">
	        <td class="w3-text-yellow"><i>${PRED.pred_no2}</i>&nbsp;<small>ppm<small></td>
        </c:if>
        <c:if test="${PRED.pred_no2 >= 0.21}">
	        <td class="w3-text-red"><i>${PRED.pred_no2}</i>&nbsp;<small>ppm<small></td>
        </c:if>
        <c:if test="${PRED.pred_no2 <= 0}">
	        <td>점검중...</td>
        </c:if>
          </tr>
          <tr>
            <td><i class="fa-solid fa-disease w3-text-blue w3-xlarge"></i></td>
            <td>일산화탄소(CO)</td>
        <c:if test="${PRED.pred_co > 0 and PRED.pred_co <= 2}">
	        <td class="w3-text-blue"><i>${PRED.pred_co}</i>&nbsp;<small>ppm<small></td>
        </c:if>
        <c:if test="${PRED.pred_co >= 2.1 and PRED.pred_co <= 9}">
	        <td class="w3-text-green"><i>${PRED.pred_co}</i>&nbsp;<small>ppm<small></td>
        </c:if>
        <c:if test="${PRED.pred_co > 9.1 and PRED.pred_co <= 15}">
	        <td class="w3-text-yellow"><i>${PRED.pred_co}</i>&nbsp;<small>ppm<small></td>
        </c:if>
        <c:if test="${PRED.pred_co >= 15.1}">
	        <td class="w3-text-red"><i>${PRED.pred_co}</i>&nbsp;<small>ppm<small></td>
        </c:if>
        <c:if test="${PRED.pred_co <= 0}"> 
	        <td>점검중...</td>
        </c:if>
          </tr>
          <tr>
            <td><i class="fa-solid fa-biohazard w3-text-purple w3-xlarge"></i></td>
            <td>아황산가스(SO<small>2</small>)</td>
        <c:if test="${PRED.pred_so > 0 and PRED.pred_so <= 0.02}">
	        <td class="w3-text-blue"><i>${PRED.pred_so}</i>&nbsp;<small>ppm<small></td>
        </c:if>
        <c:if test="${PRED.pred_so >= 0.021 and PRED.pred_so <= 0.05}">
	        <td class="w3-text-green"><i>${PRED.pred_so}</i>&nbsp;<small>ppm<small></td>
        </c:if>
        <c:if test="${PRED.pred_so > 0.051 and PRED.pred_so <= 0.15}">
	        <td class="w3-text-yellow"><i>${PRED.pred_so}</i>&nbsp;<small>ppm<small></td>
        </c:if>
        <c:if test="${PRED.pred_so >= 0.151}">
	        <td class="w3-text-red"><i>${PRED.pred_so}</i>&nbsp;<small>ppm<small></td>
        </c:if>
        <c:if test="${PRED.pred_so <= 0}">
	        <td>점검중...</td>
        </c:if>
          </tr>
        </table>
        <hr id=leghr>
        <div class="w3-col w3-border-grey w3-round-xlarge w3-center">
       		<div class="w3-dark-grey w3-border w3-round-xlarge" style="margin-bottom: 5px;">
       			<Strong>범례보기</Strong>
      			</div>
       		<div class="w3-center" style="width: 70%; margin: auto; margin-bottom: 5px; display: flex; justify-content: space-between;">
       			<div id="pm10" class="w3-red legbutton w3-button w3-half w3-border" style="margin-right: 10px;">
       				미세먼지(pm10)
       			</div>
       			<div id="pm25" class="legbutton w3-button w3-half w3-border">
       				초미세먼지(pm25)
       			</div>
       		</div>
       		<div class="w3-center" style="width: 90%; margin: auto; margin-bottom: 5px; display: flex; justify-content: space-between;">
       			<div id="oz" class="legbutton legtext w3-button w3-quarter w3-border" style="margin-right: 10px;">
       				오존(O<small>3</small>)
       			</div>
       			<div id="no" class="legbutton legtext w3-button w3-quarter w3-border" style="margin-right: 10px;">
       				이산화질소(NO<small>2</small>)
       			</div>
       			<div id="co" class="legbutton legtext w3-button w3-quarter w3-border" style="margin-right: 10px;">
       				일산화탄소(CO)
       			</div>
       			<div id="so" class="legbutton legtext w3-button w3-quarter w3-border">
       				아황산가스(SO<small>2</small>)
       			</div>
       		</div>
       		<div class="w3-center" style="width: 98%; margin: auto; margin-bottom: 5px; display: flex; justify-content: space-between;">
			    <div class="w3-border" style="width: 100%; display: flex; justify-content: space-between;">
			        <div id="good" class="legtext w3-quarter" style="flex: 1; text-align: center;">
			            <i class="fa-regular fa-circle-dot w3-text-blue"></i> 좋음(0~30)
			        </div>
			        <div id="middle" class="legtext w3-quarter" style="flex: 1; text-align: center;">
			            <i class="fa-regular fa-circle-dot w3-text-green"></i> 보통(31~80)
			        </div>
			        <div id="bad" class="legtext w3-quarter" style="flex: 1; text-align: center;">
			            <i class="fa-regular fa-circle-dot w3-text-yellow"></i> 나쁨(81~150)
			        </div>
			        <div id="toobad" class="legtext w3-quarter" style="flex: 1; text-align: center;">
			            <i class="fa-regular fa-circle-dot w3-text-red"></i> 매우나쁨(151~)
			        </div>
			    </div>
			</div>
        </div>
        
      </div>
    </div>
  </div>
  <hr>
  <div class="w3-container">
    <h5><b><i class="fa fa-bell fa-fw"></i>생활 기상 정보</b></h5>
    <p><b>불쾌 지수</b> <i id="disInfo" class="fa-solid fa-circle-exclamation">
        <span class="tooltip-text">
        	<span class="treecol" style="font-size:13px;">온도, 습도, 풍속 등 여러 조건에서 인간이 느끼는 쾌적한 만족도 또는 불쾌한 정도나 스트레스를 수치화한 것.</span>
        	<span class="treecol">불쾌지수 = 0.81 X 섭씨온도 + 0.01 X 상대습도(%)(0.99 X 섭씨온도 - 14.3)+ 46.3</span>
        </span>
    </i></p>
    <div class="w3-grey">
      <div class="w3-container w3-center w3-padding w3-red" style="width:${DISCOMFORT}%">${DISCOMFORT}</div>
    </div>

    <p><b>강수 확률(오전)</b></p>
    <div class="w3-grey">
      <div class="w3-container w3-center w3-padding w3-orange" style="width:${PRED.rainp_am}">${PRED.rainp_am}</div>
    </div>

    <p><b>강수 확률(오후)</b></p>
    <div class="w3-grey">
      <div class="w3-container w3-center w3-padding w3-green" style="width:${PRED.rainp_pm}">${PRED.rainp_pm}</div>
    </div>
  </div>
  <hr>
<div class="w3-container">
    <h5><b><i class="fa-solid fa-pen-to-square"></i>날씨 한줄 평</b></h5>
    <div class="w3-row">
      <div class="w3-col m2 text-center">
        <img class="w3-circle" src="/mis/avatar/img_avatar13.png" style="width:96px;height:96px">
      </div>
      <div class="w3-col m10 w3-container">
        <h4>김불쾌 <span id="current-time-1" class="w3-opacity w3-medium">Sep 29, 2014, 9:12 PM</span></h4>
        <c:if test="${DISCOMFORT < 68}">
	        <p>오늘 불쾌지수는 [ ${DISCOMFORT} ](으)로 좋은 날씨로 <b>쾌적함</b>을 느끼실 수 있을겁니다.
	        	<b>활기찬 하루 보내세요!</b>
        </c:if>
        <c:if test="${68 <= DISCOMFORT && DISCOMFORT < 75}">
	        <p>오늘 불쾌지수는 [ ${DISCOMFORT} ](으)로 <b>일부의 사람들이 불쾌감</b>을 느낄 수 있겠습니다. 
	        	기온과 습도로 인해 몸에 찝찝함이 남아있으면서 약간의 불쾌감을 느끼실 수도 있겠습니다.
	        	사소한 일에도 짜증을 느낄 수 있으므로, <b>활동 중간 중간 적절한 휴식</b>이 필요할거 같습니다.</p><br>
        </c:if>
        <c:if test="${75 <= DISCOMFORT && DISCOMFORT < 80}">
	        <p>오늘 불쾌지수는 [ ${DISCOMFORT} ](으)로 <b>반 정도의 사람들이 불쾌감</b>을 느낄 수 있겠습니다. 
	        	정말 사소한 일에도 불쾌감을 느끼는 경우가 많을 수 있겠습니다. 때문에 <b>충분한 휴식은 물론이고, 달콤한 음식이나, 가벼운 산책등으로 감정을 제어</b>하는게 도움이 될거같습니다.</p><br>
        </c:if>
        <c:if test="${DISCOMFORT >= 80}">
	        <p>오늘 불쾌지수는 [ ${DISCOMFORT} ](으)로 <b>대부분의 사람들이 불쾌감</b>을 느낄 수 있겠습니다. 
	        	<b>기온이 과도하게 높아지면서 공격성이 증가하고, 충동적인 행동을 하게되는 경향이 생기게 되며,</b> 
	        	<b>습도가 높아질수록 집중력이 감퇴되고, 피로감을 더 느끼게 됩니다.</b> 불쾌감에 얼굴을 찌푸리며 나쁜 일들과 상처입은 일들을 떠올리며 화르 내지만 말고 깊은 호흡과 함께 지금 이 순간에 잠시 머무르며 주변을 수용하는 태도를 가져보는게 어떨까요?</p><br>
        </c:if>
      </div>
    </div>
	<div></div>
    <div class="w3-row">
      <div class="w3-col m2 text-center">
        <img class="w3-circle" src="/mis/avatar/img_avatar12.png" style="width:96px;height:96px">
      </div>
      <div class="w3-col m10 w3-container">
        <h4>이강수 <span id="current-time-2" class="w3-opacity w3-medium">Sep 29, 2014, 9:12 PM</span></h4>
        <c:if test="${RAINP_AM eq '0%'}">
	        <p>- 오늘 오전에 <b>비가 오지 않을</b> 전망입니다! 우산은 챙기지 않아도 괜찮겠네요!</p>
        </c:if>
        <c:if test="${RAINP_AM ne '0%'}">
	        <p>- 오늘 오전에 <b>비가 올수도</b> 있겠습니다! 우산은 챙겨보는게 좋을거 같군요!</p>
        </c:if>
        <c:if test="${RAINP_PM eq '0%'}">
	        <p>- 오늘 오후에 <b>비가 오지 않을</b> 전망입니다! 우산은 챙기지 않아도 괜찮겠네요!</p><br>
        </c:if>
        <c:if test="${RAINP_PM ne '0%'}">
	        <p>- 오늘 오후에 <b>비가 올수도</b> 있겠습니다! 우산은 챙겨보는게 좋을거 같군요!</p><br>
        </c:if>
      </div>
    </div>

    <div class="w3-row">
      <div class="w3-col m2 text-center">
        <img class="w3-circle" src="/mis/avatar/img_avatar22.png" style="width:96px;height:96px">
      </div>
      <div class="w3-col m10 w3-container">
        <h4>박미세 <span id="current-time-3" class="w3-opacity w3-medium">Sep 28, 2014, 10:15 PM</span></h4>
	<c:if test="${SID eq 'Guest'}">
	        <p>'Guest'계정에게는 제공되지 않는 서비스 입니다.</p>
	</c:if>
	<c:if test="${ISACHE eq 'Y'}">
		<p>호흡기 질환이 있으신 [ <b>${SID}</b> ]님께서는</p>
        <c:if test="${PRED.pred_pm25 == 0}">
	        <p>미세먼지로부터 쾌적한 날입니다! 자유로운 야외활동을 추천드립니다!</p>
        </c:if>
        <c:if test="${PRED.pred_pm25 == 1}">
	        <p>실외 활동시 특별히 행동에 제약을 받을 필요는 없지만, 몸상대에 따라 유의하시면서 활동하셔야 겠습니다.</p>
        </c:if>
        <c:if test="${PRED.pred_pm25 == 2}">
	        <p>장시간 또는 무리한 실외활동은 제한합니다.</p>
        </c:if>
        <c:if test="${PRED.pred_pm25 == 3}">
	        <p>가급적 실내활동을 권고드립니다.</p>
        </c:if>	        
	</c:if>
	<c:if test="${ISACHE eq 'N'}">
		<p>호흡기 질환이 없으신 [ <b>${SID}</b> ]님께서는</p>
        <c:if test="${PRED.pred_pm25 == 0}">
	        <p>미세먼지로부터 쾌적한 날입니다! 자유로운 야외활동을 추천드립니다!</p>
        </c:if>
        <c:if test="${PRED.pred_pm25 == 1}">
	        <p>미세먼지로부터 쾌적한 날입니다! 자유로운 야외활동을 추천드립니다!</p>
        </c:if>
        <c:if test="${PRED.pred_pm25 == 2}">
	        <p>장시간 또는 무리한 실외활동은 자제하시는게 좋을거 같습니다. 특히 눈이 아픈 증상이 있는 사람은 실외활동을 피하시는걸 추천드립니다.</p>
        </c:if>
        <c:if test="${PRED.pred_pm25 == 3}">
	        <p>실외에서의 활동을 제한하고 실내상활 권고드립니다.</p>
        </c:if>	        
	</c:if>
      </div>
    </div>
<script>
	// 현재 날짜와 시간을 구합니다.
	var now = new Date();
	var options = {
	    year: 'numeric',
	    month: 'long',
	    day: 'numeric',
	    hour: 'numeric',
	    minute: 'numeric',
	    second: 'numeric'
	};
	
	// 현재 날짜와 시간을 지정된 형식으로 변환합니다.
	var formattedDate = now.toLocaleDateString('ko-KR', options);
	
	// 첫 번째 span 요소의 텍스트를 현재 날짜와 시간으로 업데이트합니다.
	document.getElementById('current-time-1').innerText = formattedDate;
	document.getElementById('current-time-2').innerText = formattedDate;
	document.getElementById('current-time-3').innerText = formattedDate;
</script>
    
  <div class="w3-container">
  <h5 style="padding-top:30px"><b><i class="fa fa-bank fa-fw"></i>${PRED.name}의 주요 명소</b></h5>
    <table class="w3-table w3-striped w3-bordered w3-border w3-hoverable w3-white w3-card-4">
<c:forEach var="DATA" items="${ALIST}">
      <tr>
        <td>${DATA.name}</td>
        <td><i class="w3-text-yellow fa-solid fa-star"></i> ${DATA.star}</td>
      </tr>       	
</c:forEach>
    </table><br>
    <button id="moreShow" class="w3-button w3-dark-grey w3-right">더 보기  <i class="fa fa-arrow-right"></i></button>
  </div>
  <hr>
  <div class="w3-container">
    <h5 style="padding-top:30px"><b><i class="fa-solid fa-book-open"></i>미세먼지 예측 정확도</b></h5>
    <iframe class="w3-card-4" src="http://58.72.151.124:6012/showChart.tm/" name="iframe_a" height="440px" width="100%" title="Iframe Example" style= "overflow:hidden" scrolling="no"></iframe>
  </div>
  <hr>

  <br>
  <div class="w3-container w3-dark-grey w3-padding-32">
    <div class="w3-row">
      <div class="w3-container w3-third">
        <h5 class="w3-bottombar w3-border-green">Used Prediction Model</h5>
        <p>Tenserflow Regression</p>
        <p>K Nearest Neighbors</p>
      </div>
      <div class="w3-container w3-third">
        <h5 class="w3-bottombar w3-border-red">Used Library</h5>
        <p>scikit-learn</p>
        <p>TensorFlow</p>
      </div>
      <div class="w3-container w3-third">
        <h5 class="w3-bottombar w3-border-orange">Used Data</h5>
        <p>Korea WeatherForecast Data</p>
        <p>Korea FindDust Data</p>
      </div>
    </div>
  </div>

  <!-- Footer -->
  <footer class="w3-container w3-light-grey">
    <p>&nbsp;</p>
  </footer>

  <!-- End page content -->
</div>
</div>
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

</body>
</html>
