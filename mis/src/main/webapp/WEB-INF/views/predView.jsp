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
	html,body,h1,h2,h3,h4,h5 {font-family: "Raleway", sans-serif}
	
	.w3-container p {
        margin-top: 5px;
        margin-bottom: 5px;
    }
        
</style>
<script type="text/javascript">
        $(document).ready(function(){
            $('#goback').click(function(){
            	$(location).attr('href', '/mis/realTimeDust/view.mis');
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
      <c:if test="${SID eq null}">
      		<a class="w3-bar-item w3-button"><i class="fa-solid fa-user " id="login"></i></a>
      		<a class="w3-bar-item w3-button"><i class="fa-solid fa-user-plus " id="join"></i></a>
      </c:if>
      <c:if test="${SID ne null}">
      		<a class="w3-bar-item w3-button"><i class="fa-solid fa-user-xmark" id="logout"></i></a>
      		<a class="w3-bar-item w3-button"><i class="fa-solid fa-address-card" id="myPage"></i></a>
      </c:if>
    </div>
  </div>
  <hr>
  <div class="w3-container">
    <h5>Dashboard</h5>
  </div>
  <div class="w3-bar-block">
    <a href="#" class="w3-bar-item w3-button w3-padding-16 w3-hide-large w3-dark-grey w3-hover-black" onclick="w3_close()" title="close menu"><i class="fa fa-remove fa-fw"></i>  Close Menu</a>
    <a href="#" class="w3-bar-item w3-button w3-padding w3-blue"><i class="fa fa-users fa-fw"></i>  Overview</a>
    <a href="#" class="w3-bar-item w3-button w3-padding"><i class="fa fa-eye fa-fw"></i>  Views</a>
    <a href="#" class="w3-bar-item w3-button w3-padding"><i class="fa fa-users fa-fw"></i>  Traffic</a>
    <a href="#" class="w3-bar-item w3-button w3-padding"><i class="fa fa-bullseye fa-fw"></i>  Geo</a>
    <a href="#" class="w3-bar-item w3-button w3-padding"><i class="fa fa-diamond fa-fw"></i>  Orders</a>
    <a href="#" class="w3-bar-item w3-button w3-padding"><i class="fa fa-bell fa-fw"></i>  News</a>
    <a href="#" class="w3-bar-item w3-button w3-padding"><i class="fa fa-bank fa-fw"></i>  General</a>
    <a href="#" class="w3-bar-item w3-button w3-padding"><i class="fa fa-history fa-fw"></i>  History</a>
    <a href="#" class="w3-bar-item w3-button w3-padding"><i class="fa fa-cog fa-fw"></i>  Settings</a><br><br>
  </div>
</nav>


<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:300px;margin-top:43px;">

  <!-- Header -->
  <header class="w3-container">
	<h6><button id="goback" class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off">실시간 정보 보기</button></h6>
	<h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off">미세먼지 예측 하기</button></h6>
	<h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off">여행지 추천 받기</button></h6>
    
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
        <h5><b><i class="fa-solid fa-smog"></i>미세먼지 정보</b></h5>
        <img src="/mis/goo/a.jpg" style="width:100%" alt="Google Regional Map">
      </div>
      <div class="w3-twothird">
        <h5>&nbsp;</h5>
        <table class="w3-table w3-striped w3-white">
          <tr>
            <td><i class="fa-solid fa-industry w3-text-red w3-xlarge"></i></td>
            <td>PM10(미세먼지)</td>
            <td><i>${PRED.pred_pm10}</i></td>
          </tr>
          <tr>
            <td><i class="fa-solid fa-head-side-cough w3-text-orange w3-xlarge"></i></td>
            <td>PM25(초미세먼지)</td>
            <td><i>${PRED.pred_pm25}</i></td>
          </tr>
          <tr>
            <td><i class="fa-solid fa-globe w3-text-yellow w3-xlarge"></i></td>
            <td>오존(O<small>3</small>)</td>
            <td><i>${PRED.pred_oz}</i></td>
          </tr>
          <tr>
            <td><i class="fa-solid fa-skull-crossbones w3-text-green w3-xlarge"></i></td>
            <td>이산화질소(NO<small>2</small>)</td>
            <td><i>${PRED.pred_no2}</i></td>
          </tr>
          <tr>
            <td><i class="fa-solid fa-disease w3-text-blue w3-xlarge"></i></td>
            <td>일산화탄소(CO)</td>
            <td><i>${PRED.pred_co}</i></td>
          </tr>
          <tr>
            <td><i class="fa-solid fa-biohazard w3-text-purple w3-xlarge"></i></td>
            <td>아황산가스(SO<small>2</small>)</td>
            <td><i>${PRED.pred_so}</i></td>
          </tr>
        </table>
      </div>
    </div>
  </div>
  <hr>
  <div class="w3-container">
    <h5><b><i class="fa fa-bell fa-fw"></i>생활 기상 정보</b></h5>
    <p><b>불쾌 지수</b></p>
    <div class="w3-grey">
      <div class="w3-container w3-center w3-padding w3-red" style="width:${DISCOMFORT}%">${DISCOMFORT}</div>
    </div>

    <p><b>강수 확률(오전)</b></p>
    <div class="w3-grey">
      <div class="w3-container w3-center w3-padding w3-orange" style="width:${RAINP_AM}">${RAINP_AM}</div>
    </div>

    <p><b>강수 확률(오후)</b></p>
    <div class="w3-grey">
      <div class="w3-container w3-center w3-padding w3-green" style="width:${RAINP_PM}">${RAINP_PM}</div>
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
        <c:if test="${DISCOMFORT > 80}">
	        <p>오늘 불쾌지수는 [ ${DISCOMFORT} ]로 다소 불쾌감을 느낄 수 있겠습니다. 
	        	<b>기온이 과도하게 높아지면서 공격성이 증가하고, 충동적인 행동을 하게되는 경향이 생기게 되며,</b> 
	        	<b>습도가 높아질수록 집중력이 감퇴되고, 피로감을 더 느끼게 됩니다.</b> 불쾌감에 얼굴을 찌푸리며 나쁜 일들과 상처입은 일들을 떠올리며 화르 내지만 말고 깊은 호흡과 함께 지금 이 순간에 잠시 머무르며 주변을 수용하는 태도를 가져보는게 어떨까요?</p><br>
        </c:if>
        <c:if test="${DISCOMFORT < 80}">
	        <p>오늘 불쾌지수는 [ ${DISCOMFORT}% ]로 보통 사람이 불쾌지수가 80이 넘는 순간부터 주변으로부터 오는 불쾌감에 민감해 지는데요, 오늘은 <u>불쾌함으로부터 괜찮</u>을거 같군요!
	        	좋은 하루를 활기차게 시작하고 마무리해 봅시다!</p><br>
        </c:if>
      </div>
    </div>

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
        <p>마스크 껴</p><br>
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
    <h5>Recent Users</h5>
    <ul class="w3-ul w3-card-4 w3-white">
      <li class="w3-padding-16">
        <img src="/mis/avatar/img_avatar11.png" class="w3-left w3-circle w3-margin-right" style="width:35px">
        <span class="w3-xlarge">Mike</span><br>
      </li>
      <li class="w3-padding-16">
        <img src="/mis/avatar/img_avatar21.png" class="w3-left w3-circle w3-margin-right" style="width:35px">
        <span class="w3-xlarge">Jill</span><br>
      </li>
      <li class="w3-padding-16">
        <img src="/mis/avatar/img_avatar23.png" class="w3-left w3-circle w3-margin-right" style="width:35px">
        <span class="w3-xlarge">Jane</span><br>
      </li>
    </ul>
  </div>
  <hr>

  <br>
  <div class="w3-container w3-dark-grey w3-padding-32">
    <div class="w3-row">
      <div class="w3-container w3-third">
        <h5 class="w3-bottombar w3-border-green">Demographic</h5>
        <p>Language</p>
        <p>Country</p>
        <p>City</p>
      </div>
      <div class="w3-container w3-third">
        <h5 class="w3-bottombar w3-border-red">System</h5>
        <p>Browser</p>
        <p>OS</p>
        <p>More</p>
      </div>
      <div class="w3-container w3-third">
        <h5 class="w3-bottombar w3-border-orange">Target</h5>
        <p>Users</p>
        <p>Active</p>
        <p>Geo</p>
        <p>Interests</p>
      </div>
    </div>
  </div>

  <!-- Footer -->
  <footer class="w3-container w3-padding-16 w3-light-grey">
    <h4>FOOTER</h4>
    <p>Powered by <a href="https://www.w3schools.com/w3css/default.asp" target="_blank">w3.css</a></p>
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
