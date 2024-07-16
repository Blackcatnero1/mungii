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
	    * {
	        box-sizing: border-box;
	    }
	    
	    body {
	        background: #f6f5f7;
	        display: flex;
	        justify-content: center;
	        align-items: center;
	        flex-direction: column;
	        font-family: 'Montserrat', sans-serif;
	        height: 100vh;
	        margin: -20px 0 50px;
	    }
	    
	    h1 {
	        font-weight: bold;
	        margin: 0;
	    }
	    
	    h2 {
	        text-align: center;
	    }
	    
	    p {
	        font-size: 14px;
	        font-weight: 100;
	        line-height: 20px;
	        letter-spacing: 0.5px;
	        margin: 20px 0 30px;
	    }
	    
	    span {
	        font-size: 12px;
	    }
	    
	    a {
	        color: #333;
	        font-size: 14px;
	        text-decoration: none;
	        margin: 15px 0;
	    }
	    
	    button {
	        border-radius: 20px;
	        border: 1px solid #4CAF50; /* 변경: 초록색 */
	        background-color: #4CAF50; /* 변경: 초록색 */
	        color: #FFFFFF;
	        font-size: 12px;
	        font-weight: bold;
	        padding: 12px 45px;
	        letter-spacing: 1px;
	        text-transform: uppercase;
	        transition: transform 80ms ease-in;
	    }
	    
	    button:active {
	        transform: scale(0.95);
	    }
	    
	    button:focus {
	        outline: none;
	    }
	    
	    button.ghost {
	        background-color: transparent;
	        border-color: #FFFFFF;
	        cursor: pointer; /* 포인터 모양으로 설정 */
	    }
	    
	    form {
	        background-color: #FFFFFF;
	        display: flex;
	        align-items: center;
	        justify-content: center;
	        flex-direction: column;
	        padding: 0 50px;
	        height: 100%;
	        text-align: center;
	    }
	    
	    input {
	        background-color: #eee;
	        border: none;
	        padding: 12px 15px;
	        margin: 8px 0;
	        width: 100%;
	    }
	    
	    .container {
	        background-color: #fff;
	        border-radius: 10px;
	        box-shadow: 0 14px 28px rgba(0,0,0,0.25), 
	            0 10px 10px rgba(0,0,0,0.22);
	        position: relative;
	        overflow: hidden;
	        width: 768px;
	        max-width: 100%;
	        min-height: 480px;
	    }
	    
	    .form-container {
	        position: absolute;
	        top: 0;
	        height: 100%;
	        transition: all 0.6s ease-in-out;
	    }
	    
	    .sign-in-container {
	        left: 0;
	        width: 50%;
	        z-index: 2;
	    }
	    
	    .container.right-panel-active .sign-in-container {
	        transform: translateX(100%);
	    }
	    
	    .sign-up-container {
	        left: 0;
	        width: 50%;
	        opacity: 0;
	        z-index: 1;
	    }
	    
	    .container.right-panel-active .sign-up-container {
	        transform: translateX(100%);
	        opacity: 1;
	        z-index: 5;
	        animation: show 0.6s;
	    }
	    
	    @keyframes show {
	        0%, 49.99% {
	            opacity: 0;
	            z-index: 1;
	        }
	        
	        50%, 100% {
	            opacity: 1;
	            z-index: 5;
	        }
	    }
	    
	    .overlay-container {
	        position: absolute;
	        top: 0;
	        left: 50%;
	        width: 50%;
	        height: 100%;
	        overflow: hidden;
	        transition: transform 0.6s ease-in-out;
	        z-index: 100;
	    }
	    
	    .container.right-panel-active .overlay-container{
	        transform: translateX(-100%);
	    }
	    
	    .overlay {
	        background: #4CAF50; /* 변경: 초록색 */
	        background: -webkit-linear-gradient(to right, #4CAF50, #4CAF50); /* 변경: 초록색 */
	        background: linear-gradient(to right, #4CAF50, #4CAF50); /* 변경: 초록색 */
	        background-repeat: no-repeat;
	        background-size: cover;
	        background-position: 0 0;
	        color: #FFFFFF;
	        position: relative;
	        left: -100%;
	        height: 100%;
	        width: 200%;
	        transform: translateX(0);
	        transition: transform 0.6s ease-in-out;
	    }
	    
	    .container.right-panel-active .overlay {
	        transform: translateX(50%);
	    }
	    
	    .overlay-panel {
	        position: absolute;
	        display: flex;
	        align-items: center;
	        justify-content: center;
	        flex-direction: column;
	        padding: 0 40px;
	        text-align: center;
	        top: 0;
	        height: 100%;
	        width: 50%;
	        transform: translateX(0);
	        transition: transform 0.6s ease-in-out;
	    }
	    
	    .overlay-left {
	        transform: translateX(-20%);
	    }
	    
	    .container.right-panel-active .overlay-left {
	        transform: translateX(0);
	    }
	    
	    .overlay-right {
	        right: 0;
	        transform: translateX(0);
	    }
	    
	    .container.right-panel-active .overlay-right {
	        transform: translateX(20%);
	    }
	    
	    .social-container {
	        margin: 20px 0;
	    }
	    
	    .social-container a {
	        border: 1px solid #DDDDDD;
	        border-radius: 50%;
	        display: inline-flex;
	        justify-content: center;
	        align-items: center;
	        margin: 0 5px;
	        height: 40px;
	        width: 40px;
	    }
	    
	    footer {
	        background-color: #222;
	        color: #fff;
	        font-size: 14px;
	        bottom: 0;
	        position: fixed;
	        left: 0;
	        right: 0;
	        text-align: center;
	        z-index: 999;
	    }
	    
	    footer p {
	        margin: 10px 0;
	    }
	    
	    footer i {
	        color: green;
	    }
	    
	    footer a {
	        color: #3c97bf;
	        text-decoration: none;
	    }
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
                var csite = $(location).attr('href');
                if(csite == 'http://localhost/mis/kpred/klogin.mis'){
	                $('#frm').attr('method', 'post').attr('action', '/mis/kpred/kloginProc.mis');
                }else if(csite == 'http://localhost/mis/realTimeDust/rlogin.mis'){
    	            $('#frm').attr('method', 'post').attr('action', '/mis/realTimeDust/rloginProc.mis');
                }else{
    	            $('#frm').attr('method', 'post').attr('action', '/mis/member/loginProc.mis');
                }
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
<div class="container" id="container">
  <div class="form-container sign-up-container">
    <form action="#">
    </form>
  </div>
  <div class="form-container sign-in-container">
    <form action="#" id="frm" name="frm">
      <h2><b>로그인</b></h2>
      <input type="text" name="id" id="id" placeholder="아이디를 입력하세요.">
      <input type="password" name="pw" id="pw" placeholder="비밀번호를 입력하세요.">
      <a href="#">비밀번호를 잊으셨나요?</a>
      <button id="login" style="cursor:pointer;">로그인</button>
    </form>
  </div>
  <div class="overlay-container">
    <div class="overlay">
      <div class="overlay-panel overlay-left">
        <h1>Welcome Back!</h1>
        <p>To keep connected with us please login with your personal info</p>
        <button class="ghost" id="signIn">Sign In</button>
      </div>
      <div class="overlay-panel overlay-right">
        <h1>안녕하세요!</h1>
        <p>당신의 정보를 입력하고, 우리와 함께 멋진 여정을 시작해 보세요!</p>
        <button class="ghost" id="join">회원가입</button>
        <br>
        <button class="ghost" id="home">메인화면</button>
      </div>
    </div>
  </div>
</div>
</body>
</html>
