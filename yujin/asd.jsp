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
  
<div class="w3-content" style="max-width:1000px">
	
	  <!-- 헤더1 -->
	<header class="w3-display-container w3-wide" id="home">
		<div class="header">
			<h1>페이지 템플릿(배경 변경 가능성 있음)</h1>
		</div>
	</header>
	
	<!-- 버튼헤더(필요시 갯수추가) -->
	<header class="w3-container w3-center w3-padding w3-white">
	    <h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off">버튼1</button></h6>
	    <h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off">버튼2</button></h6>
	    <h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off">버튼3</button></h6>
	</header>
	
	 
	<div class=" w3-content container w3-padding-16 w3-center">
		<div style="display: inline-block;">
			<span>지역 :</span>
			<select class=" pl" style="width: 100px; margin-left:3px; margin-right:3px;">
				<option selected>시/도</option>
				<option value="1">서울</option>
				<option value="1">대전</option>
				<option value="1">대구</option>
				<option value="1">부산</option>
			</select>
			<select class=" pl" style="width: 120px; margin-left:3px; margin-right:25px;">
				<option selected>시/군/구</option>
				<option value="1">강남구</option>
				<option value="1">강동구</option>
				<option value="1">강북구</option>
				<option value="1">강서구</option>
				<option value="1">관악구</option>
				<option value="1">광진구</option>
				<option value="1">구로구</option>
				<option value="1">금천구</option>
				<option value="1">광진구</option>
				<option value="1">노원구</option>
				<option value="1">도봉구</option>
				<option value="1">동대문구</option>
				<option value="1">동작구</option>
				<option value="1">마포구</option>
				<option value="1">서대문구</option>
				<option value="1">서초구</option>
				<option value="1">성동구</option>
				<option value="1">성북구</option>
				<option value="1">송파구</option>
				<option value="1">양천구</option>
				<option value="1">영등포구</option>
				<option value="1">용산구</option>
				<option value="1">은평구</option>
				<option value="1">종로구</option>
				<option value="1">중구</option>
				<option value="1">중랑구</option>
			</select>
			<span>날짜 :</span>
			<select class="m2 pl" style="width: 70px; margin-left:3px; margin-right:3px;">
				<option selected>월</option>
				<option value="1">1월</option>
				<option value="1">2월</option>
				<option value="1">3월</option>
				<option value="1">4월</option>
				<option value="1">5월</option>
				<option value="1">6월</option>
				<option value="1">7월</option>
				<option value="1">8월</option>
				<option value="1">9월</option>
				<option value="1">10월</option>
				<option value="1">11월</option>
				<option value="1">12월</option>
			</select>
			<select class="m2 pl" style="width: 70px; margin-left:3px; margin-right:25px;">
				<option selected>일</option>
				<option value="1">1일</option>
				<option value="1">2일</option>
				<option value="1">3일</option>
				<option value="1">4일</option>
				<option value="1">5일</option>
				<option value="1">6일</option>
				<option value="1">7일</option>
				<option value="1">8일</option>
				<option value="1">9일</option>
				<option value="1">10일</option>
				<option value="1">11일</option>
				<option value="1">12일</option>
				<option value="1">13일</option>
				<option value="1">14일</option>
				<option value="1">15일</option>
				<option value="1">16일</option>
				<option value="1">17일</option>
				<option value="1">18일</option>
				<option value="1">19일</option>
				<option value="1">20일</option>
				<option value="1">21일</option>
				<option value="1">22일</option>
				<option value="1">23일</option>
				<option value="1">24일</option>
				<option value="1">25일</option>
				<option value="1">26일</option>
				<option value="1">27일</option>
				<option value="1">28일</option>
				<option value="1">29일</option>
				<option value="1">30일</option>
				<option value="1">31일</option>
			</select>
			<span>시간 :</span>
			<select class="m2 pl" style="width: 80px; margin-left:3px; margin-right: 3px;">
				<option selected>시</option>
				<option value="1">0시</option>
				<option value="1">1시</option>
				<option value="1">2시</option>
				<option value="1">3시</option>
				<option value="1">4시</option>
				<option value="1">5시</option>
				<option value="1">6시</option>
				<option value="1">7시</option>
				<option value="1">8시</option>
				<option value="1">9시</option>
				<option value="1">10시</option>
				<option value="1">11시</option>
				<option value="1">12시</option>
				<option value="1">13시</option>
				<option value="1">14시</option>
				<option value="1">15시</option>
				<option value="1">16시</option>
				<option value="1">17시</option>
				<option value="1">18시</option>
				<option value="1">19시</option>
				<option value="1">20시</option>
				<option value="1">21시</option>
				<option value="1">22시</option>
				<option value="1">23시</option>
				<option value="1">24시</option>
			</select>
			<span>~</span>
			<select class="m2 pl" style="width: 80px; margin-left:3px; margin-right:15px;">
				<option selected>시</option>
				<option value="1">0시</option>
				<option value="1">1시</option>
				<option value="1">2시</option>
				<option value="1">3시</option>
				<option value="1">4시</option>
				<option value="1">5시</option>
				<option value="1">6시</option>
				<option value="1">7시</option>
				<option value="1">8시</option>
				<option value="1">9시</option>
				<option value="1">10시</option>
				<option value="1">11시</option>
				<option value="1">12시</option>
				<option value="1">13시</option>
				<option value="1">14시</option>
				<option value="1">15시</option>
				<option value="1">16시</option>
				<option value="1">17시</option>
				<option value="1">18시</option>
				<option value="1">19시</option>
				<option value="1">20시</option>
				<option value="1">21시</option>
				<option value="1">22시</option>
				<option value="1">23시</option>
				<option value="1">24시</option>
			</select>
			<div class="w3-blue w3-round w3-padding w3-margin w3-button">예측</div>
		</div>
	</div> 
	<div class="w3-white container w3-container" style="padding-bottom: 35px!important">
		<div class=" w3-round w3-margin">
			<h5 style="text-align: left!important;"><i class="fa fa-bar-chart"></i><b> PM10(미세먼지)</b></h5>
			<div class="w3-col w3-center w3-blue" style="width:25%">좋음(0~30)</div>
			<div class="w3-col w3-center w3-green" style="width:25%">보통(31~80)</div>
			<div class="w3-col w3-center w3-yellow" style="width:25%">나쁨(81~150)</div>
			<div class="w3-col w3-center w3-red" style="width:25%">매우나쁨(151~)</div>
			<div class="w3-content w3-border">내용입력</div>
	    </div>
    </div>
    <div class="w3-white container w3-container" style="padding-bottom: 35px!important">
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
