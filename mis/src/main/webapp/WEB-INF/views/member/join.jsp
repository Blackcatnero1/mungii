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
            max-width: 700px;
            margin: 10px auto;
            padding: 15px 20px;
            background-color: white;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        .form-group {
            margin-bottom: 5px;
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

            $('#home1').click(function(){
                $(location).attr('href', '/mis');
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
                
                var sname = document.frm.name.value;
                var snic = document.frm.nickname.value;
                var shome = document.frm.home.value;


                
                if(!sid || !spw || !srepw || !snic || !shome){
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
		<div class="field">
   			<img src='https://github.com/Blackcatnero1/mungii/blob/branch/yujin/Gmail/export202406271712491601.png?raw=true' style="width:700px; height:200px;">
    	</div>	
	    <div class="w3-content w3-container container w3-card-4" style='padding-top:0;'>
	        <form method="GET" action="/mis/member/joinProc.mis" name="frm" id="frm" class="form w3-padding">
	        	<div style="margin-top: 20px;">
		            <div class="form-group w3-col w3-margin-left w3-margin-right form-group">
		                <label for="name" class="w3-col m4 lbl w3-text-gray w3-right-align w3-padding" style="width: 175px; margin-top: 3px;">이름 :</label>
		                <input type="text" name="name" id="name" placeholder="이름을 입력하세요." class="w3-col l8 s8 w3-input w3-border w3-round">
		            </div>
		            <div class="w3-col w3-margin-left w3-margin-right form-group">
		                <label for="nickname" class="w3-col m4 lbl w3-text-gray w3-right-align w3-padding" style="width: 175px; margin-top: 3px;">닉네임 :</label>
		                <input type="text" name="nickname" id="nickname" placeholder="닉네임을 입력하세요." class="w3-col l8 s8 w3-input w3-border w3-round">
		            </div>
		            <div class="w3-col w3-margin-left w3-margin-right form-group">
		                <label for="id" class="w3-col m4 lbl w3-text-gray w3-right-align w3-padding" style="width: 175px; margin-top: 3px;">아이디 :</label>
		                <input type="text" name="id" id="id" placeholder="아이디를 입력하세요." class="w3-col s6 l6 w3-input w3-border w3-round">
		                <div class="w3-button w3-gray w3-round w3-center" id="chkBtn" style="width: 85px; height: 45px; margin-top: 0px; margin-right: 4%; margin-bottom: 0px; padding-top: 12px;">Check</div>
		                <small id="idmsg" class="w3-hide">* 이미 사용중인 아이디입니다.</small>
		            </div>
		            <div class="w3-col w3-margin-left w3-margin-right form-group">
		                <label for="pw" class="w3-col m4 lbl w3-text-gray w3-right-align w3-padding" style="width: 175px; margin-top: 3px;">비밀번호 :</label>
		                <input type="password" name="pw" id="pw" placeholder="비밀번호를 입력하세요." class="w3-col l8 s8 w3-input w3-border w3-round">
		                <small id="pwmsg" class="w3-hide"># 비밀번호를 확인해주세요.</small>
		            </div>
		            <div class="w3-col w3-margin-left w3-margin-right form-group">
		                <label for="repw" class="w3-col m4 lbl w3-text-gray w3-right-align w3-padding" style="width: 175px; margin-top: 3px;">비밀번호 확인 :</label>
		                <input type="password" id="repw" placeholder="비밀번호 확인 입력" class="w3-col l8 s8 w3-input w3-border w3-round">
		                <small id="repwmsg" class="w3-hide"># 비밀번호를 다시 확인해주세요.</small>
		            </div>
		            <div class="w3-col w3-margin-left w3-margin-right form-group">
		                <label for="home" class="w3-col m4 lbl w3-text-gray w3-right-align w3-padding" style="width: 175px; margin-top: 3px;">거주 지역 :</label>
		                <input type="text" name="home" id="home" placeholder="거주 지역을 입력하세요." class="w3-col l8 s8 w3-input w3-border w3-round">
		            </div>
		            <div class="w3-col w3-margin-left w3-margin-right">
		                <label class="w3-col m3 lbl w3-text-gray w3-right-align w3-padding" style="width: 175px; margin-top: 3px;">성별 : </label>
		                <div class="radio-group w3-col s6 m8 w3-margin" style="margin-top: 10px;">
		                	<div class="w3-half w3-center">
		                        <input type="radio" name="gen" id="M" class="w3-radio rdo" value="M" style="display: inline; width: 30px; position: relative; padding-top: 14px; top: 2px; font-size: 11pt; font-weight: bold; padding-left: 15px;"> <label for="M">남성</label>
		                    </div>
		                    <div class="w3-half w3-center">
			                    <input type="radio" name="gen" id="F" class="w3-radio rdo" value="F" style="display: inline; width: 30px; position: relative; padding-top: 14px; top: 2px; font-size: 11pt; font-weight: bold; padding-left: 15px;" > <label for="F">여성</label>
		                    </div>
		                </div>
		            </div>
		            <div class="w3-col w3-margin-left w3-margin-right">
		                <label class="w3-col m3 lbl w3-text-gray w3-right-align w3-padding" style="width: 175px; margin-top: 3px;">호흡기질환 유/무 : </label>
		                <div class="radio-group w3-col s6 m8 w3-margin" style="margin-top: 10px;">
		                	<div class="w3-half w3-center">
		                        <input type="radio" name="sick" id="Y" class="w3-radio rdo" value="Y" style="display: inline; width: 30px; position: relative; padding-top: 14px; top: 2px; font-size: 11pt; font-weight: bold; padding-left: 15px;"> <label for="Y">예</label>
		                    </div>
		                    <div class="w3-half w3-center">
			                    <input type="radio" name="sick" id="N" class="w3-radio rdo" value="N" style="display: inline; width: 30px; position: relative; padding-top: 14px; top: 2px; font-size: 11pt; font-weight: bold; padding-left: 15px;" > <label for="N">아니오</label>
		                    </div>
		                </div>
		            </div>
	            </div>
	        </form>
	        
	        <div class="w3-col w3-margin-top">
	            <div class="w3-button w3-blue-gray w3-center w3-third" id="reset">초기화</div>
	            <div class="w3-button w3-gray w3-center w3-third" id="home1">처음으로</div>
	            <div class="w3-button w3-dark-gray w3-center w3-third" id="join">회원가입</div>
	        </div>
	    </div>
    </div>
</body>
</html>