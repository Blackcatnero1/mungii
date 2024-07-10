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
	
	<!-- Blog entries -->
	<div class="w3-col">
<!-- Blog entry -->
		<div class="w3-card-4 w3-margin w3-white">
			<img src="/w3images/woods.jpg" alt="Nature" style="width:100%">
			<div class="w3-container">
				<h3><b>TITLE HEADING</b></h3>
				<h5>Title description, <span class="w3-opacity">April 7, 2014</span></h5>
			</div>
		
			<div class="w3-container">
				<p>tellus ut rutrum. Sed vitae justo condimentum, porta lectus vitae, ultricies congue gravida diam non fringilla.</p>
				<div class="w3-row">
					<div class="w3-col m8 s12">
						<p><button class="w3-button w3-padding-large w3-white w3-border"><b>READ MORE »</b></button></p>
					</div>
					<div class="w3-col m4 w3-hide-small">
						<p><span class="w3-padding-large w3-right"><b>Comments  </b> <span class="w3-tag">0</span></span></p>
					</div>
				</div>
			</div>
		</div>
		
	</div>

</div>

<button class="w3-button w3-black w3-disabled w3-padding-large w3-margin">Previous</button>
<button class="w3-button w3-black w3-padding-large w3-margin w3-right">Next »</button>	
	
<!-- Footer -->
<footer class="w3-container w3-dark-grey" style="padding:32px">
	<a href="#" class="w3-button w3-black w3-padding-large w3-margin-bottom"><i class="fa fa-arrow-up w3-margin-right"></i>위로가는버튼\n필요한가요</a>
	<p>사용설명서 여기다가</p>
</footer>
    
</body>
</html>
