<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>mis 원글 작성</title>
    <link rel="stylesheet" type="text/css" href="/mis/css/w3.css">
    <link rel="stylesheet" type="text/css" href="/mis/css/user.css">
    <script type="text/javascript" src="/mis/js/jquery-3.7.1.min.js"></script>
    <style type="text/css">
        body {
            font-family: 'Roboto', Arial, sans-serif;
            background-color: #f9f9f9;
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
            max-width: 800px;
            margin: 40px auto;
            padding: 20px;
            background-color: white;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        .button {
            margin: 5px;
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
        .textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            resize: none;
            font-family: 'Roboto', Arial, sans-serif;
            margin-top: 10px;
        }
        .footer {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        .center-buttons {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }
        .center-buttons .button {
            margin: 0 10px;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function(){
            $('#home').click(function(){
                $(location).attr('href', '/mis/main.mis');
            });
            
            $('#login').click(function(){
                $(location).attr('href', '/mis/member/login.mis');
            });
            
            $('#logout').click(function(){
                $(location).attr('href', '/mis/member/logout.mis');
            });
            
            $('#join').click(function(){
                $(location).attr('href', '/mis/member/join.mis');
            });
            
            $('#reset').click(function(){
                document.frm.reset();
            });
            
            $('#list').click(function(){
            	$('#frm').attr('action', '/mis/reboard/reboard.mis');
            	$('#frm').submit();
            });
            
            $('#write').click(function(){
                var sbody = $('#body').val();
                if(!sbody){
                    $('#body').focus();
                    return;
                }
                $('#frm').attr('action', '/mis/reboard/reboardWriteProc.mis');
                $('#frm').submit();
            });
        });
    </script>
</head>
<body>
    <div class="header">
        <h1>댓글 작성</h1>
    </div>
    <div class="container">
        <div class="center-buttons">
            <button class="button" id="home">Home</button>
<c:if test="${empty SID}">
                <button class="button" id="join">회원가입</button>
                <button class="button" id="login">로그인</button>
</c:if>
<c:if test="${not empty SID}">
                <button class="button" id="logout">로그아웃</button>
</c:if>
        </div>
        <form method="POST" action="" name="frm" id="frm">
            <input type="hidden" name="nowPage" id="nowPage" value="${DATA.nowPage}">
<c:if test="${DATA.regroup ne 0}">
            <input type="hidden" name="upno" value="${DATA.upno}">
            <input type="hidden" name="regroup" value="${DATA.regroup}">
            <input type="hidden" name="level" value="${DATA.level}">
</c:if>
            <div class="w3-container w3-padding w3-margin-bottom w3-card-4">
                <div class="w3-col">
                    <label class="w3-col m3 lbl">작성자 :</label>
                    <input type="text" name="id" id="id" value="${SID}" class="w3-col m8 w3-input" readonly>
                </div>
                <div class="w3-col">
                    <label for="body" class="w3-col m3 lbl">내 용 :</label>
                    <textarea id="body" name="body" class="textarea" rows="5" placeholder="내용을 작성하세요!"></textarea>
                </div>
            </div>
            <div class="footer">
                <button class="button" id="list">목록</button>
                <button class="button" id="reset">reset</button>
                <button class="button" id="write">등록</button>
            </div>
        </form>
    </div>
</body>
</html>
