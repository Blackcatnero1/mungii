<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Join</title>
    <link rel="stylesheet" type="text/css" href="/mis/css/w3.css">
    <link rel="stylesheet" type="text/css" href="/mis/css/user.css">
    <script type="text/javascript" src="/mis/js/jquery-3.7.1.min.js"></script>
    <style type="text/css">
        body {
            font-family: 'Roboto', Arial, sans-serif;
            background-color: #e5e5e5;
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
        }
        .form-group {
            margin-bottom: 20px;
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
        .form-group small {
            display: block;
            margin-top: 5px;
            color: #d93025;
        }
        .button {
            margin: 10px 5px;
            padding: 10px 20px;
            border: none;
            color: white;
            background-color: #4285f4;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }
        .button:hover {
            background-color: #357ae8;
        }
        .radio-group {
            display: flex;
            justify-content: space-around;
            margin-top: 10px;
        }
        .radio-group label {
            display: inline-block;
            color: #5f6368;
        }
        .radio-group input {
            margin-right: 5px;
        }
        .buttons {
            text-align: center;
            margin-top: 30px;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function(){
            
            
            function tCheck(t, v){
                if(!v) {
                    t.value = '';
                    t.focus();
                }
            }
            
            $('#join').click(function(){
                var sid = $(document.frm.id).val();
                var spw = $(document.frm.pw).val();
                var srepw = $(document.frm.repw).val();
                if(spw != srepw){
                    document.frm.repw.value = '';
                    document.frm.repw.focus();
                    alert('비밀번호 불일치');
                    return;
                }
                
                var smail = document.frm.mail.value;
                var stel = document.frm.tel.value;
                var sgen = document.querySelectorAll('[name="gen"]:checked')[0].value;
                
                if(!sid || !spw || !smail || !stel || !sgen){
                    return;
                }
                
                $('#frm').submit();
            });
            
            // 아이디 체크 이벤트
            $('#chkBtn').click(function(){
                var sid = $('#id').val();
                if(!sid){
                    $('#id').focus();
                    return;
                }
                
                $('#idmsg:not(".w3-hide")').addClass('w3-hide');
                
                $.ajax({
                    url: 'http://localhost/mis/member/idCheck.mis',
                    type: 'POST',
                    dataType: 'json',
                    data: {
                        id: sid
                    },
                    success: function(obj){
                        // 태그 처리하고
                        // 꺼낸결과로 조건처리
                        if(obj.result == 'YES'){
                            // 메세지 채워넣고
                            $('#idmsg').html('* 사용 가능한 아이디입니다.');
                            // 글자색을 파란색으로 변경하고
                            $('#idmsg').removeClass('w3-text-red').addClass('w3-text-blue');
                            // 화면에 보여지게 처리하고
                            // w3-hide 클래스 제거하고
                            $('#idmsg').removeClass('w3-hide');
                        } else {
                            // 메세지 채워넣고
                            $('#idmsg').html('# 이미 사용 중인 아이디입니다.');
                            // 글자색을 빨간색으로 변경하고
                            $('#idmsg').removeClass('w3-text-blue').addClass('w3-text-red');
                            // 화면에 보여지게 처리하고
                            // w3-hide 클래스 제거하고
                            $('#idmsg').removeClass('w3-hide');
                        }
                    },
                    error: function(){
                        alert('# 서버와의 통신에 에러가 발생했습니다.');
                    }
                });
            });
            
            $('#home').click(function(){
                $(location).attr('href', '/mis/main.mis')
            });
        });
    </script>
</head>
<body>
	<div class="w3-content" style="max-width:1600px">
	
	  <!-- 헤더1 -->
		<header class="w3-display-container w3-wide" id="home">
			<div class="header">
				<h1>미세먼지 회원가입창</h1>
			</div>
		</header>
		
		<!-- 버튼헤더(필요시 갯수추가) -->
		<header class="w3-container w3-center w3-padding-48 w3-white">
		    <h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off">버튼1</button></h6>
		    <h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off">버튼2</button></h6>
		    <h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off">버튼3</button></h6>
		</header>
	</div>
	
    <div class="container w3-content w3-container">
        <h1 class="header w3-round">회원가입</h1>
        <form method="GET" action="/mis/member/joinProc.mis" name="frm" id="frm" class="form w3-padding">
        
            <div class="form-group w3-col w3-margin">
                <label for="name" class="w3-col m3 lbl w3-text-gray w3-right-align w3-padding" style="width: 140px;">이름 :</label>
                <input type="text" name="name" id="name" placeholder="이름을 입력하세요." class="w3-col l8 s8 w3-input w3-border w3-round">
            </div>
            <div class="form-group w3-col w3-margin">
                <label for="id" class="w3-col m3 lbl w3-text-gray w3-right-align w3-padding" style="width: 140px;">아이디 :</label>
                <input type="text" name="id" id="id" placeholder="아이디를 입력하세요." class="w3-col s5 m6 l6 w3-input w3-border w3-round">
                <div class="button w3-button w3-right" id="chkBtn" style="width: 85px; height: 40px; margin-top: 0px; margin-right: 5%; margin-bottom: 0px;">Check</div>
                <small id="idmsg" class="w3-hide">* 이미 사용중인 아이디.</small>
            </div>
            <div class="form-group w3-col w3-margin">
                <label for="pw" class="w3-col m3 lbl w3-text-gray w3-right-align w3-padding" style="width: 140px;">비밀번호 :</label>
                <input type="password" name="pw" id="pw" placeholder="비밀번호를 입력하세요." class="w3-col l8 s8 w3-input w3-border w3-round">
                <small id="pwmsg" class="w3-hide"># 비밀번호를 확인해주세요.</small>
            </div>
            <div class="form-group w3-col w3-margin">
                <label for="repw" class="w3-col m3 lbl w3-text-gray w3-right-align w3-padding" style="width: 140px;">비밀번호 확인 :</label>
                <input type="password" id="repw" placeholder="비밀번호 확인 입력" class="w3-col l8 s8 w3-input w3-border w3-round">
                <small id="repwmsg" class="w3-hide"># 비밀번호를 다시 확인해주세요.</small>
            </div>
            <div class="form-group w3-col w3-margin">
                <label for="mail" class="w3-col m3 lbl w3-text-gray w3-right-align w3-padding" style="width: 140px;">이메일 :</label>
                <input type="text" name="mail" id="mail" placeholder="이메일을 입력하세요." class="w3-col l8 s8 w3-input w3-border w3-round">
            </div>
            <div class="form-group w3-col w3-margin">
                <label class="w3-col m3 lbl w3-text-gray w3-right-align w3-padding" style="width: 140px;">성별 :</label>
                <div class="radio-group w3-col s8 m8">
                	<div class="w3-half w3-center">
	                    <label for="F">
	                        <input type="radio" name="gen" id="F" class="rdo" value="F"> 
	                        여자
	                    </label>
                    </div>
                    <div class="w3-half w3-center">
	                    <label for="M">
	                        <input type="radio" name="gen" id="M" class="rdo" value="M"> 
	                        남자
	                    </label>
                    </div>
                </div>
            </div>
            
        </form>
        <div class="buttons">
            <div class="button w3-red w3-left w3-button" id="reset">Reset</div>
            <div class="button w3-cyan w3-left w3-button" id="home">Home</div>
            <div class="button w3-indigo w3-right w3-button" id="join">회원가입</div>
        </div>
    </div>
</body>
</html>
