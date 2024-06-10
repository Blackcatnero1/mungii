<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>mis Login</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="/mis/css/w3.css">
    <link rel="stylesheet" type="text/css" href="/mis/css/user.css">
    <script type="text/javascript" src="/mis/js/jquery-3.7.1.min.js"></script>
    <style>
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
            max-width: 450px;
            margin: 80px auto;
            padding: 20px;
            background-color: white;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            text-align: center;
        }
        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #5f6368;
        }
        .form-group input {
            width: calc(100% - 10px);
            padding: 10px;
            border: 1px solid #dadce0;
            border-radius: 4px;
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
            width: calc(33% - 10px);
            display: inline-block;
        }
        .button:hover {
            background-color: #357ae8;
        }
        .button.orange { background-color: #f4b400; }
        .button.green { background-color: #34a853; }
        .button.blue { background-color: #4285f4; }
    </style>
    <script type="text/javascript">
        $(document).ready(function(){
            $('#home').click(function(){
                $(location).attr('href', '/mis/main.mis');
            });
            
            $('#join').click(function(){
                $(location).attr('href', '/mis/member/join.mis');
            });
            
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
                
                $('#frm').attr('method', 'GET').attr('action', '/mis/member/loginProc.mis');
                $('#frm').submit();
            });

            // 엔터 키로 로그인 버튼 클릭 이벤트 추가
            $('#id, #pw').on('keypress', function(e) {
                if (e.which == 13) {
                    $('#login').click();
                }
            });
        });
    </script>
</head>
<body>
    <div class="container">
        <h1 class="header">mis Login</h1>
        <form id="frm" name="frm" class="form">
            <div class="form-group">
                <label for="id">ID :</label>
                <input type="text" name="id" id="id" placeholder="아이디를 입력하세요.">
            </div>
            <div class="form-group">
                <label for="pw">PW :</label>
                <input type="password" name="pw" id="pw" placeholder="비밀번호를 입력하세요.">
            </div>
            <div>
                <div class="button green" id="home">Home</div>
                <div class="button orange" id="join">회원가입</div>
                <div class="button blue" id="login">로그인</div>
            </div>
        </form>
    </div>
</body>
</html>
