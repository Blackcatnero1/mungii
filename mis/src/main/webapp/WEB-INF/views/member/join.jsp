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
            max-width: 750px;
            margin: 40px auto;
            padding: 15px 20px;
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
            margin: 5px 5px;
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

            $('#home').click(function(){
                $(location).attr('href', '/main.mis');
            });
            
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
                var sgen = document.querySelectorAll('[name="sick"]:checked')[0].value;
                
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
            
        });
    </script>
</head>
<body>
	<div class="w3-content w3-center" style="max-width:1000px">
	
	  <!-- 헤더1 -->
		<header class="w3-display-container w3-wide">
			<div class="header">
				<h1>미세먼지 회원가입창</h1>
			</div>
		</header>
		
		<!-- 버튼헤더(필요시 갯수추가) -->
		<header class="w3-container w3-center w3-padding w3-white">
	        <h6><button class="w3-button w3-white w3-quarter w3-large w3-opacity w3-hover-opacity-off">광혁</button></h6>
	        <h6><button class="w3-button w3-white w3-quarter w3-large w3-opacity w3-hover-opacity-off">광섭</button></h6>
	        <h6><button class="w3-button w3-white w3-quarter w3-large w3-opacity w3-hover-opacity-off">민경</button></h6>
	        <h6><button class="w3-button w3-white w3-quarter w3-large w3-opacity w3-hover-opacity-off">한민</button></h6>
	    </header>
	
	
	    <div class="container w3-content w3-container">
	        <h1 class="header w3-round w3-margin">회원가입</h1>
	        <form method="GET" action="/mis/member/joinProc.mis" name="frm" id="frm" class="form w3-padding">
	        	<div style="margin-top: 20px;">
		            <div class="form-group w3-col w3-margin">
		                <label for="name" class="w3-col m4 lbl w3-text-gray w3-right-align w3-padding" style="width: 175px; margin-top: 3px;">이름 :</label>
		                <input type="text" name="name" id="name" placeholder="이름을 입력하세요." class="w3-col l8 s8 w3-input w3-border w3-round">
		            </div>
		            <div class="form-group w3-col w3-margin">
		                <label for="nic" class="w3-col m4 lbl w3-text-gray w3-right-align w3-padding" style="width: 175px; margin-top: 3px;">닉네임 :</label>
		                <input type="text" name="nic" id="nic" placeholder="닉네임을 입력하세요." class="w3-col l8 s8 w3-input w3-border w3-round">
		            </div>
		            <div class="form-group w3-col w3-margin">
		                <label for="id" class="w3-col m4 lbl w3-text-gray w3-right-align w3-padding" style="width: 175px; margin-top: 3px;">아이디 :</label>
		                <input type="text" name="id" id="id" placeholder="아이디를 입력하세요." class="w3-col s6 l6 w3-input w3-border w3-round">
		                <div class="w3-button w3-blue w3-round-large w3-center" id="chkBtn" style="width: 85px; height: 45px; margin-top: 0px; margin-right: 4%; margin-bottom: 0px; padding-top: 12px;">Check</div>
		                <small id="idmsg" class="w3-hide">* 이미 사용중인 아이디입니다.</small>
		            </div>
		            <div class="form-group w3-col w3-margin">
		                <label for="pw" class="w3-col m4 lbl w3-text-gray w3-right-align w3-padding" style="width: 175px; margin-top: 3px;">비밀번호 :</label>
		                <input type="password" name="pw" id="pw" placeholder="비밀번호를 입력하세요." class="w3-col l8 s8 w3-input w3-border w3-round">
		                <small id="pwmsg" class="w3-hide"># 비밀번호를 확인해주세요.</small>
		            </div>
		            <div class="form-group w3-col w3-margin">
		                <label for="repw" class="w3-col m4 lbl w3-text-gray w3-right-align w3-padding" style="width: 175px; margin-top: 3px;">비밀번호 확인 :</label>
		                <input type="password" id="repw" placeholder="비밀번호 확인 입력" class="w3-col l8 s8 w3-input w3-border w3-round">
		                <small id="repwmsg" class="w3-hide"># 비밀번호를 다시 확인해주세요.</small>
		            </div>
		            <div class="form-group w3-col w3-margin">
		                <label for="address" class="w3-col m4 lbl w3-text-gray w3-right-align w3-padding" style="width: 175px; margin-top: 3px;">거주 지역 :</label>
		                <input type="text" name="address" id="address" placeholder="거주 지역을 입력하세요." class="w3-col l8 s8 w3-input w3-border w3-round">
		            </div>
		            <div class="form-group w3-col w3-margin">
		                <label class="w3-col m3 lbl w3-text-gray w3-right-align w3-padding" style="width: 175px; margin-top: 3px;">호흡기질환 유/무 : </label>
		                <div class="radio-group w3-col s6 m8 w3-margin" style="margin-top: 20px;">
		                	<div class="w3-half w3-center">
		                        <input type="radio" name="sick" id="Y" class="w3-radio rdo" value="Y" style="display: inline; width: 30px; position: relative; padding-top: 14px; top: 8px; font-size: 11pt; font-weight: bold; padding-left: 15px;"> <label for="Y">예</label>
		                    </div>
		                    <div class="w3-half w3-center">
			                    <input type="radio" name="sick" id="N" class="w3-radio rdo" value="N" style="display: inline; width: 30px; position: relative; padding-top: 14px; top: 5px; font-size: 11pt; font-weight: bold; padding-left: 15px;" > <label for="N">아니오</label>
		                    </div>
		                </div>
		            </div>
	            </div>
	        </form>
	        
	        <div class="w3-col">
	            <div class="w3-button w3-red w3-center" id="reset">Reset</div>
	            <div class="w3-button w3-cyan w3-center" id="home">Home</div>
	            <div class="w3-button w3-indigo w3-center" id="join">회원가입</div>
	        </div>
	    </div>
    </div>
</body>
</html>