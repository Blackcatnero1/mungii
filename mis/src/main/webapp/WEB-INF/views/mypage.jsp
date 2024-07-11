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
            margin: 0;
            padding: 0;
            background-color: #f0f0f0;
        }
        .header {
            background-color: #4285f4;
            color: white;
            padding: 30px;
            text-align: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .container {
            max-width: 800px;
            margin: 40px auto;
            padding: 20px;
            background-color: white;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        .info-section {
            background-color: #4285f4;
            color: white;
            padding: 20px;
            margin: 10px 0;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .info-title {
            font-size: 1.2em;
            margin-bottom: 10px;
        }
        .info-data {
            font-size: 1.5em;
            font-weight: bold;
        }
        .info-group {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }
        .info-item {
            flex: 1 1 45%;
            margin: 10px 0;
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
<div class="w3-content" style="max-width:1000px">

    <!-- 헤더 -->
    <header class="w3-display-container w3-wide header" onclick="handleClick()">
        <h1>마이페이지</h1>
    </header>

    <!-- 내 정보 섹션 -->
    <div class="container w3-content w3-justify w3-padding-64" id="about">
        <h2 class="w3-center">내 정보</h2>
        <hr style="width:200px" class="w3-opacity">

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

</div>
</body>
</html>
