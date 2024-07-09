<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" type="text/css" href="/css/w3.css">
<link rel="stylesheet" type="text/css" href="/css/user.css">
<script type="text/javascript" src="/js/jquery-3.7.1.min.js"></script>
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
            max-width: 650px;
            margin: 40px auto;
            padding: 20px;
            background-color: white;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            text-align: center;
        }
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$('#home').click(function(){
			$(location).attr('href', '/main.son');
		});
		
		$('#logout').click(function(){
			$(location).attr('href', '/member/logout.son');
		});
	});
		
</script>
</head>
<body class="w3-light-grey">
  
<div class="w3-content" style="max-width:1600px">
	
	  <!-- 헤더1 -->
	<header class="w3-display-container w3-wide" id="home">
		<div class="header">
			<h1>My Info</h1>
		</div>
	</header>
	
	<!-- 버튼헤더(필요시 갯수추가) -->
	<header class="w3-container w3-center w3-padding w3-white">
	    <h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off">버튼1</button></h6>
	    <h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off">버튼2</button></h6>
	    <h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off">버튼3</button></h6>
	</header>
	
	<!-- Grid -->
	<div class="w3-row w3-padding w3-border">

		<div class="w3-container w3-padding-32 w3-white w3-center w3-margin" style="max-width:800px">
			<div class="w3-col">
				<h3 class="w3-col m3 w3-right-align w3-text-gray pdr10">이 름 : </h3>
				<h3 class="w3-col m8 w3-center w3-text-gray pdr10 membdata" id="name"></h3>
			</div>
			<div class="w3-col">
				<h3 class="w3-col m3 w3-right-align w3-text-gray pdr10">닉네임 : </h3>
				<h3 class="w3-col m8 w3-center w3-text-gray pdr10 membdata" id="nic"></h3>
			</div>
			<div class="w3-col">
				<h3 class="w3-col m3 w3-right-align w3-text-gray pdr10">아이디 : </h3>
				<h3 class="w3-col m8 w3-center w3-text-gray pdr10 membdata" id="id"></h3>
			</div>
			<div class="w3-col">
				<h3 class="w3-col m3 w3-right-align w3-text-gray pdr10">거주 지역 : </h3>
				<h3 class="w3-col m8 w3-center w3-text-gray pdr10 membdata" id="address"></h3>
			</div>
			<div class="w3-col">
				<h3 class="w3-col m3 w3-right-align w3-text-gray pdr10">호흡기질환 유무 : </h3>
				<h3 class="w3-col m8 w3-center w3-text-gray pdr10 membdata" id="sick"></h3>
			</div>
			<div class="w3-col">
				<h3 class="w3-col m3 w3-right-align w3-text-gray pdr10">가입일 : </h3>
				<h3 class="w3-col m8 w3-center w3-text-gray pdr10 membdata" id="jdate"></h3>
			</div>
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