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
            font-family: 'Roboto', Arial, sans-serif;
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
	function handleClick() {
			$(location).attr('href', '/mis/');
    }
</script>
</head>
<body class="w3-light-grey">
  
<div class="w3-content" style="max-width:1000px">

	  <!-- 헤더1 -->
	<header class="w3-display-container w3-wide" onclick="handleClick()">
		<div class="header">
			<h1>마이페이지</h1>
		</div>
	</header>

  <!-- About Section -->
  <div class="w3-content w3-justify w3-text-grey w3-padding-64" id="about">
    <hr style="width:200px" class="w3-opacity">
    <h2>내 정보</h2>
    <div class="w3-row w3-center w3-padding-16 w3-section w3-light-grey">
      <div class="w3-half w3-section">
        닉네임<br>
        <span class="w3-xlarge" id="nickname">${DATA.nickname}</span>
      </div>
      <div class="w3-half w3-section">
        이름<br>
        <span class="w3-xlarge" id="name">${DATA.name}</span>
      </div>
      <div class="w3-half w3-section">
        가입일<br>
        <span class="w3-xlarge" id="sdate">${DATA.sdate}</span>
      </div>
      <div class="w3-half w3-section">
        아이디<br>
        <span class="w3-xlarge" id="id">${DATA.id}</span>
      </div>
      <div class="w3-half w3-section">
        사는 지역<br>
        <span class="w3-xlarge" id="home">${DATA.home}</span>
      </div>
      <div class="w3-half w3-section">
        성별<br>
        <span class="w3-xlarge" id="gen">${DATA.gen}</span>
      </div>
    </div>
   </div>
<!-- END PAGE CONTENT -->
</div>

</body>
</html>
