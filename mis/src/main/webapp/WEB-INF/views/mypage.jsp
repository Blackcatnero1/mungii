<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Mis Mypage</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://www.w3schools.com/lib/w3-colors-metro.css">
    <script type="text/javascript" src="/mis/js/jquery-3.7.1.min.js"></script>
    <style>
        body {
		    background-color: #f0f0f0;
		    font-family: Arial, sans-serif;
		    font-size: 16px;
		    line-height: 1.6;
		    margin: 0;
		    padding: 0;
		}
		
		h1, h2 {
		    text-align: center;
		    color: #333;
		}
		
		hr {
		    border-color: #333;
		    margin: 20px auto;
		    width: 200px;
		}
        .header {
		    background-color: #0d47a1;
		    color: white;
		    padding: 20px;
		    text-align: center;
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
		    cursor: pointer;
		    transition: background-color 0.3s ease;
		}
		
		.header:hover {
		    background-color: #1565c0;
		}

        .container {
		    max-width: 800px;
		    margin: 40px auto;
		    padding: 20px;
		    background-color: #f9f9f9;
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
		    border-radius: 8px;
		}
		
		.info-section {
		    background-color: #e0e0e0;
		    color: #333;
		    padding: 15px;
		    margin: 10px 0;
		    border-radius: 8px;
		    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
		}
		
		.info-title {
		    font-size: 1.1em;
		    margin-bottom: 8px;
		}
		
		.info-data {
		    font-size: 1.3em;
		    font-weight: bold;
		}

        .info-group {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }
        .info-item {
		    flex: 1 1 calc(50% - 20px); /* 각 박스의 너비를 50%로 설정하고, 간격을 빼줍니다 */
		    margin: 10px;
		    padding: 20px; /* 각 박스의 내부 여백을 추가합니다 */
		}
		
		@media (max-width: 600px) {
		    .info-item {
		        flex: 1 1 100%;
		    }
		}
    </style>
    <script type="text/javascript">
        function handleClick() {
            $(location).attr('href', '/mis/');
        }
    </script>
</head>
<body class="w3-light-grey">
<div class="w3-content" style="max-width:600px">

    <!-- 헤더 -->
    <div class="field w3-center" onclick="handleClick()">
		<img src='https://github.com/Blackcatnero1/mungii/blob/branch/yujin/Gmail/export202406271712491601.png?raw=true' style="width:600px; height:160px;">
   	</div>	

    <!-- 내 정보 섹션 -->
    <div class="container w3-content w3-justify w3-padding" id="about">
        <h2 class="w3-center"><b>내 정보</b></h2>

        <div class="info-group">
            <div class="info-item info-section">
                <div class="info-title">닉네임</div>
                <div class="info-data" id="nickname">${DATA.nickname}</div>
            </div>
            <div class="info-item info-section">
                <div class="info-title">이름</div>
                <div class="info-data" id="name">${DATA.name}</div>
            </div>
            <div class="info-item info-section">
                <div class="info-title">가입일</div>
                <div class="info-data" id="sdate">${DATA.sdate}</div>
            </div>
            <div class="info-item info-section">
                <div class="info-title">아이디</div>
                <div class="info-data" id="id">${DATA.id}</div>
            </div>
            <div class="info-item info-section">
                <div class="info-title">사는 지역</div>
                <div class="info-data" id="home">${DATA.home}</div>
            </div>
            <div class="info-item info-section">
                <div class="info-title">성별</div>
                <div class="info-data" id="gen">${DATA.gen}</div>
            </div>
        </div>
    </div>

<!-- Footer -->
<footer class="w3-container w3-dark-grey" style="padding:32px">
    <a href="#" class="w3-button w3-black w3-padding-large w3-margin-bottom"><i class="fa fa-arrow-up w3-margin-right"></i>위로가는버튼 필요한가요</a>
    <p>사용설명서 여기다가</p>
</footer>
</div>
</body>
</html>
