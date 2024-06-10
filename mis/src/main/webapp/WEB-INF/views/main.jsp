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
<body>
    <form method="POST" id="frm"></form>
    
    <div class="header">
        <h1>여기는 미세먼지 메인 입니다.</h1>
    </div>

    <div class="container">
        <div style="margin-top: 10px;">
            <button class="button pink" id="reboard">댓글게시판</button>
            <button class="button blue-gray" id="gallery">갤러리</button>       
            <c:if test="${not empty SID}">
                <button class="button orange" id="logout">로그아웃</button>
            </c:if>
            <c:if test="${empty SID}">
                <button class="button blue" id="join">회원가입</button>
                <button class="button green" id="login">로그인</button>
            </c:if>
        </div>
    </div>
</body>
</html>
