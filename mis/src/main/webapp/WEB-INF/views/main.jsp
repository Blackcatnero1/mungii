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
            $('#join').click(function(){
                $(location).attr('href', '/mis/member/join.mis');
            });

            // 각 버튼에 대한 클릭 이벤트 처리
            $('#login').click(function(){
                var sid = $('#id').val();
                if(!sid){
                    $('#id').focus();
                    return;
                }
                
                var spw = $('#pw').val();
                if(!spw){
                    $('#pw').focus();
                    return;
                }
                
                $('#frm').attr('method', 'POST').attr('action', '/mis/member/loginProc.mis');
                $('#frm').submit();
            });

            // 엔터 키로 로그인 버튼 클릭 이벤트 추가
            $('#id, #pw').on('keypress', function(e) {
                if (e.which == 13) {
                    $('#login').click();
                }
            });
            
            $('#logout').click(function(){
                $(location).attr('href', '/mis/member/logout.mis');
            });
            $('#park').click(function(){
                $(location).attr('href', '/mis/park/park.mis');
            });
            $('#myPage').click(function(){
                $(location).attr('href', '/mis/member/mypage.mis');
            });
        });
    </script>
</head>
<body class="w3-light-grey">
<div class="w3-content" style="max-width:1000px">
    <!-- 헤더1 -->
    <header class="w3-display-container w3-wide" id="home">
        <div class="header">
            <h1>여기는 미세먼지 메인 입니다.</h1>
        </div>
    </header>
    <!-- 버튼헤더(필요시 갯수추가) -->
    <header class="w3-container w3-center w3-padding w3-white">
        <h6><button class="w3-button w3-white w3-quarter w3-large w3-opacity w3-hover-opacity-off">광혁</button></h6>
        <h6><button class="w3-button w3-white w3-quarter w3-large w3-opacity w3-hover-opacity-off">광섭</button></h6>
        <h6><button class="w3-button w3-white w3-quarter w3-large w3-opacity w3-hover-opacity-off">민경</button></h6>
        <h6><button class="w3-button w3-white w3-quarter w3-large w3-opacity w3-hover-opacity-off" id="park">태마파크</button></h6>
    </header>
    <!-- Grid -->
    <div class="w3-row w3-padding">
        <!-- 좌분면 -->
        <div class="w3-col l8 s8">
            <!-- 국내 순위 -->
            <div class="w3-container w3-white w3-margin w3-padding-large">
                <div class="w3-center">
                    <h3>국내</h3>
                </div>
                <hr style="border: solid 1px black;">
                <ol id="domestic-ranking">
                    <c:forEach items="${linksList2}" var="link">
		            	<li class="w3-col w3-padding">
                            <a href="${link.href}" class="w3-col m5 w3-text-gray w3-left-align" style="text-decoration:none;">${link.text}</a>
                            <div class="w3-col m5">AQI : ${link.aqi}</div>
                        </li>
		            </c:forEach>
                </ol>
            </div>
            <!-- 해외 순위 -->
            <div class="w3-container w3-white w3-margin w3-padding-large">
                <div class="w3-center">
                    <h3>해외</h3>
                </div>
                <hr style="border: solid 1px black;">
                <ol id="international-ranking">
                    <c:forEach items="${linksList}" var="link">
		                <li class="w3-col w3-padding">
                            <a href="${link.href}" class="w3-col m5 w3-text-gray w3-left-align" style="text-decoration:none;">${link.text}</a>
                            <div class="w3-col m5">AQI : ${link.aqi}</div>
                        </li>
		            </c:forEach>
                </ol>
            </div>
            <!-- 좌분면 닫기 -->
        </div>
        <!-- 좌우 나누는 박스 -->
        <div class="w3-rest l3 s3">
            <!-- 우상단 -->
            <form method="POST" id="frm">
                <div class="w3-white w3-margin">
                    <c:if test="${empty SID}">
                        <div class="w3-container w3-padding w3-black">
                            <h4>로그인</h4>
                        </div>
                        <div class="w3-container w3-white" style="padding-bottom: 10px;">
                            <p><input class="w3-input w3-border" name="id" id="id" type="text" placeholder="아이디" style="padding-left: 10px"></p>
                            <p><input type="password" class="w3-input w3-border" name="pw" id="pw" placeholder="비밀번호"></p>
                            <div class="w3-half w3-button w3-green" id="login">로그인</div>
                            <div class="w3-half w3-button w3-blue" id="join">회원가입</div>
                        </div>
                    </c:if>
                    <c:if test="${not empty SID}">
                        <div class="w3-container w3-padding w3-black">
                            <h4>내 정보</h4>
                        </div>
                        <div class="w3-container w3-white" style="padding-bottom: 10px;">
                            <div class="w3-col w3-button w3-pale-red w3-margin m10" id="logout">로그아웃</div>
                            <div class="w3-col w3-button w3-gray w3-margin m10" id="myPage">마이페이지</div>
                        </div>
                    </c:if>
                </div>
            </form>
            <!-- 우하단 -->
            <div class="w3-white w3-margin">
                <div class="w3-container w3-padding w3-black">
                    <h4>관련 기사</h4>
                </div>
                <div class="w3-container w3-white">
                    <div class="w3-container w3-display-container w3-light-grey w3-section w3-padding" style="height:200px">
                        <a>기사제목</a>
                        <hr style="border: solid 1px #808080; margin: 10px;">
                        <a>기사제목2</a>
                    </div>
                </div>
            </div>
            <!-- 우하단 닫기 -->
        </div>
        <!-- 좌우 나누는 박스 닫기 -->
    </div>
    <!-- END GRID -->
<!-- END w3-content -->
<!-- Footer -->
<footer class="w3-container w3-dark-grey" style="padding:32px">
    <a href="#" class="w3-button w3-black w3-padding-large w3-margin-bottom"><i class="fa fa-arrow-up w3-margin-right"></i>위로가는버튼 필요한가요</a>
    <p>사용설명서 여기다가</p>
</footer>
</div>

</body>
</html>
