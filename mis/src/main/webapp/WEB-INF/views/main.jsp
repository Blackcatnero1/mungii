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
        .button {
            margin: 10px 5px;
            padding: 10px 20px;
            border: none;
            color: white;
            background-color: #4285f4;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-size: 14px;
        }
        .button:hover {
            background-color: #357ae8;
        }
        .button.pink { background-color: #e91e63; }
        .button.blue-gray { background-color: #607d8b; }
        .button.orange { background-color: #ff9800; }
        .button.light-green { background-color: #8bc34a; }
        .button.blue { background-color: #2196f3; }
        .button.green { background-color: #4caf50; }
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
            
            $('#myInfo').click(function(){
                var el = document.createElement('input'); 
                $(el).attr('type', 'hidden'); 
                $(el).attr('name', 'id'); 
                $(el).val('${SID}');
                $('#frm').append(el);
                $('#frm').attr('action', '/mis/member/myInfo.mis');
                $('#frm').submit();
            });
            
            $('#sdata').click(function(){
                $(location).attr('href', '/mis/survey/dataInit.mis');
            });

            $('#gallery').click(function(){
                $(location).attr('href', '/mis/gallery/galleryList.mis');
            });
            
            $('#reboard').click(function(){
                $(location).attr('href', '/mis/reboard/reboard.mis');
            });
        });
    </script>
</head>
<body class="w3-light-grey">
  
<div class="w3-content" style="max-width:1600px">
	
	  <!-- 헤더1 -->
	<header class="w3-display-container w3-wide" id="home">
		<div class="header">
			<h1>여기는 미세먼지 메인 입니다.</h1>
		</div>
	</header>
	
	<!-- 버튼헤더(필요시 갯수추가) -->
	<header class="w3-container w3-center w3-padding-48 w3-white">
	    <h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off">버튼1</button></h6>
	    <h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off">버튼2</button></h6>
	    <h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off">버튼3</button></h6>
	</header>
	
	<!-- Grid -->
	<div class="w3-row w3-padding w3-border">
	
		<!-- 좌분면 -->
		<div class="w3-col l8 s12">
		
		  <!-- 국내?순위 -->
			<div class="w3-container w3-white w3-margin w3-padding-large">
				<div class="w3-center">
					<h3>국내</h3>
				</div>
			
				<hr style="border: solid 1px black;">
				
				<div class="w3-justify">
					<p>여기다가 데이터 본문(복사해서 여러개 나열)</p>
					<p>li가 낫나?</p>
					<p class="w3-right"><button class="w3-button w3-black" id="myBtn"><b>더보기</b></button></p>
					<p class="w3-clear"></p>
				</div>
			</div>
			<hr>
		
		
			<!-- 해외순위? 더필요하면 통째로 복사 -->
			<div class="w3-container w3-white w3-margin w3-padding-large">
				<div class="w3-center">
				<h3>해외</h3>
				</div>
			  
				<hr style="border: solid 1px black;">
				
				<div class="w3-justify">
					<p>여기도 본문</p>
					<p class="w3-right"><button class="w3-button w3-black" ><b>더보기?</b></button></p>
					<p class="w3-clear"></p>
				</div>
			</div>
		<!-- 좌분면닫기태그 -->
		</div>
		
		<!-- 좌우가르는박스임중요함 -->
		<div class="w3-col l4">
		     
			<!-- 우상단 -->
			<form method="POST" id="frm">
				<div class="w3-white w3-margin">
			<c:if test="${empty SID}">
			        <div class="w3-container w3-padding w3-black">
						<h4>로그인</h4>
			        </div>
			        <div class="w3-container w3-white">
						<p><input class="w3-input w3-border" type="text" placeholder="아이디" style="padding-left: 10px"></p>
						<p><input class="w3-input w3-border" type="text" placeholder="비밀번호"></p>
						<button class="button green" id="login">로그인</button>
						<hr>
						<button class="button w3-text-blue" id="join">회원가입</button>
			        </div>
			</c:if>
			<c:if test="${not empty SID}">
			        <div class="w3-container w3-padding w3-black">
						<h4>내 정보</h4>
			        </div>
					<div class="w3-container w3-white">
						<button class="button orange" id="logout">로그아웃</button>
					</div>
			</c:if>
				</div>
			</form>
			
		    <hr>
		      
			<!-- 우하단 -->
			<div class="w3-white w3-margin">
				<div class="w3-container w3-padding w3-black">
					<h4>관련 기사</h4>
				</div>
				<div class="w3-container w3-white">
					<div class="w3-container w3-display-container w3-light-grey w3-section" style="height:200px">
						<a>기사제목</a>
						<hr style="border: solid 1px #808080;">
						<a>기사제목2</a>
					</div>
				</div>
			</div>
				     
		
		<!-- 우분면닫기태그 -->
		</div>
		
	<!-- END GRID -->
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
