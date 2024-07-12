<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>mis Main</title>
    <link rel="stylesheet" type="text/css" href="/mis/css/w3.css">
    <link rel="stylesheet" type="text/css" href="/mis/css/user.css">
    <script type="text/javascript" src="/mis/js/jquery-3.7.1.min.js"></script>
    
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css" integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style type="text/css">
        body {
            font-family: 'Roboto', Arial, sans-serif;
            background-color: #f1f3f4;
            margin: 0;
            padding: 0;
        }
        .header {
            background-color: #4285f4;
            color: white;
            padding: 20px;
            text-align: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .container {
            max-width: 950px;
            margin: 40px auto;
            padding: 15px;
            background-color: white;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            text-align: center;
        }
        .pl{
		    border: 1px solid #C4C4C4;
		    box-sizing: border-box;
		    border-radius: 10px;
		    padding: 12px 13px;
		    font-family: 'Roboto';
		    font-style: normal;
		    font-weight: 400;
		    font-size: 14px;
		    line-height: 16px;
		}
    </style>
    <script type="text/javascript">
        $(document).ready(function(){
            $('#login').click(function(){
                var sid = '${SID}';
                if(!sid || sid == 'null'){
                    $(location).attr('href', '/mis/member/login.mis');
                } else {
                    alert('이미 로그인 했습니다.');
                }
            });
            
            $('#logout').click(function(){
                $(location).attr('href', '/mis/member/logout.mis');
            });
            
            $('#join').click(function(){
                var sid = '${SID}';
                if(!sid || sid == 'null'){
                    $(location).attr('href', '/mis/member/join.mis');
                } else {
                    return;
                }
            }); 
            
        });
    </script>
</head>
<body class="w3-light-grey">
  
	
	<div class="w3-bar w3-top w3-black w3-large" style="z-index:4;">
  <button class="w3-bar-item w3-button w3-hide-large w3-hover-none w3-hover-text-light-grey" onclick="w3_open();"><i class="fa fa-bars"></i>  Menu</button>
  <span class="w3-bar-item w3-right w3-button w3-col" id="jip"><i class="fa-solid fa-house"></i></span>
</div>

<!-- Sidebar/menu -->
<nav class="w3-sidebar w3-collapse w3-white w3-animate-left" style="z-index:3;width:300px;" id="mySidebar"><br>
  <div class="w3-container w3-row">
    <div class="w3-col s3">
      <img src="https://data1.pokemonkorea.co.kr/newdata/pokedex/full/000701.png" class="w3-circle w3-margin-right" style="width:46px">
    </div>
    <div class="w3-col s9 w3-bar">
      <span><b>${SID} </b><strong class="todayDate"></strong></span><br>
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
    <h5>목차</h5>
  </div>
  <div class="w3-bar-block">
    <a href="#" class="w3-bar-item w3-button w3-padding-16 w3-hide-large w3-dark-grey w3-hover-black" onclick="w3_close()" title="close menu"><i class="fa fa-remove fa-fw"></i>  Close Menu</a>
    <a href="#" class="w3-bar-item w3-button w3-padding"><i class="fa fa-users fa-fw"></i> 단기 예측</a>
    <a href="#" class="w3-bar-item w3-button w3-padding w3-red"><i class="fa fa-eye fa-fw"></i> 중(장)기 예측</a>
    <a href="#" class="w3-bar-item w3-button w3-padding"><i class="fa fa-users fa-fw"></i> 응애</a>
  </div>
</nav>


<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:310px;margin-top:43px;">

  <!-- Header -->
	<header class="w3-container">
		<h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off">실시간 정보 보기</button></h6>
		<h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off" id="kpred">미세먼지 예측 하기</button></h6>
		<h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off" id="park">여행지 추천 받기</button></h6>
		<div class='w3-col'style="display: inline;">
			<div class='w3-quarter l3' style="margin-right: -50px!important;">
				<h5><i class="fa-solid fa-cloud-sun-rain"></i><b class="cityName"></b><b><small class="todayDate"></small> 날씨정보</b></h5>
			</div>
			<div class="w3-quarter w3-center l3" style="margin-left: -20px!important;">
				<h6><b>
					<label for="city">시/도 : </label>
					<select id="city">
						<option disabled selected>시/도.</option>
	                    <c:forEach var="DATA" items="${CITYLIST}" varStatus="st">
	                    	<option value="${DATA.city }">${DATA.city}</option>
	                    </c:forEach>
					</select>
				</b></h6>
			</div>
			<div class="w3-quarter w3-center l3" style="margin-left: -20px!important;">
				<h6><b>
					<label for="city">시/군/구 : </label>
					<select id="city">
						<option disabled selected>시/군/구.</option>
	                    <c:forEach var="DATA" items="${CITYLIST}" varStatus="st">
	                    	<option value="${DATA.city }">${DATA.city}</option>
	                    </c:forEach>
					</select>
				</b></h6>
			</div>
			<div class="">
				<h6>
					<b><label for="dateSelect">날짜 선택 : </label><input type="date" id="dateSelect"></b>
					<button class="w3-margin-left" id="selCityDate">⏎</button>
				</h6>
			</div>
		</div>
	</header>
 
	
	<div class="w3-white container w3-container" style="padding-bottom: 10px!important; margin-bottom: 30px;">
		<div class=" w3-round w3-margin">
			<h5 style="text-align: left!important;"><i class="fa fa-bar-chart"></i><b> PM10(미세먼지)</b></h5>
			<div class="w3-col w3-center w3-blue" style="width:25%">좋음(0~30)</div>
			<div class="w3-col w3-center w3-green" style="width:25%">보통(31~80)</div>
			<div class="w3-col w3-center w3-yellow" style="width:25%">나쁨(81~150)</div>
			<div class="w3-col w3-center w3-red" style="width:25%">매우나쁨(151~)</div>
			<div class="w3-content w3-border">내용입력</div>
	    </div>
    </div>
    <div class="w3-white container w3-container" style="padding-bottom: 10px!important;">
		<div class="w3-round w3-margin">
			<h5 style="text-align: left!important;"><i class="fa fa-bar-chart"></i><b> PM2.5(초미세먼지)</b></h5>
			<div class="w3-col w3-center w3-blue" style="width:25%">좋음(0~15)</div>
			<div class="w3-col w3-center w3-green" style="width:25%">보통(16~35)</div>
			<div class="w3-col w3-center w3-yellow" style="width:25%">나쁨(36~75)</div>
			<div class="w3-col w3-center w3-red" style="width:25%">매우나쁨(76~)</div>
			<div class="w3-content w3-border">내용입력</div>
	    </div>
    </div>
<!-- END w3-content -->
</div>
	
	
<!-- Footer -->
<footer class="w3-container w3-dark-grey" style="padding:32px">
	<a href="#" class="w3-button w3-black w3-padding-large w3-margin-bottom"><i class="fa fa-arrow-up w3-margin-right"></i>위로가는버튼\n필요한가요</a>
	<p>사용설명서 여기다가</p>
</footer>
    
</body>
</html>
