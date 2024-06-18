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
            transition: background-color 0.3s ease;
            font-size: 14px;
        }
        .button:hover {
            background-color: #357ae8;
        }
        .button.orange { background-color: #f4b400; }
        .button.green { background-color: #34a853; }
        .button.blue { background-color: #4285f4; }
        .button.red { background-color: #ea4335; }
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
        .avatar-group {
            display: flex;
            justify-content: space-around;
            margin-top: 10px;
        }
        .avatar-group .avtBox {
            display: inline-block;
            text-align: center;
        }
        .avatar-group img {
            width: 80px;
            height: 80px;
            border-radius: 50%;
        }
        .buttons {
            text-align: center;
            margin-top: 30px;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function(){
            $('.rdo').change(function(){
                $('#fAvt, #mAvt').stop().slideUp();
                var tag = $(this).val();
                if(tag == 'M'){
                    $('#mAvt').removeClass('w3-hide');
                    $('#mAvt').slideDown();
                } else {
                    $('#fAvt').removeClass('w3-hide');
                    $('#fAvt').slideDown();
                }
            });
            
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
                var sano = document.querySelectorAll('[name="ano"]:checked')[0].value;
                
                if(!sid || !spw || !smail || !stel || !sgen || !sano){
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
    <div class="container">
        <h1 class="header">회원가입</h1>
        <form method="GET" action="/mis/member/joinProc.mis" name="frm" id="frm" class="form">
            <div class="form-group">
                <label for="name">이름 :</label>
                <input type="text" name="name" id="name" placeholder="이름을 입력하세요.">
            </div>
            <div class="form-group">
                <label for="id">아이디 :</label>
                <input type="text" name="id" id="id" placeholder="아이디를 입력하세요.">
                <div class="button" id="chkBtn">Check</div>
                <small id="idmsg" class="w3-hide">* 이미 사용중인 아이디.</small>
            </div>
            <div class="form-group">
                <label for="pw">비밀번호 :</label>
                <input type="password" name="pw" id="pw" placeholder="비밀번호를 입력하세요.">
                <small id="pwmsg" class="w3-hide"># 비밀번호를 확인해주세요.</small>
            </div>
            <div class="form-group">
                <label for="repw">비밀번호 확인 :</label>
                <input type="password" id="repw" placeholder="비밀번호 확인 입력">
                <small id="repwmsg" class="w3-hide"># 비밀번호를 다시 확인해주세요.</small>
            </div>
            <div class="form-group">
                <label for="mail">이메일 :</label>
                <input type="text" name="mail" id="mail" placeholder="이메일을 입력하세요.">
            </div>
            <div class="form-group">
                <label for="tel">전화번호 :</label>
                <input type="text" name="tel" id="tel" placeholder="전화번호를 입력하세요.">
            </div>
            <div class="form-group">
                <label>성별 :</label>
                <div class="radio-group">
                    <label for="F">
                        <input type="radio" name="gen" id="F" class="rdo" value="F"> 
                        여자
                    </label>
                    <label for="M">
                        <input type="radio" name="gen" id="M" class="rdo" value="M"> 
                        남자
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label>아바타 :</label>
                <div id="mAvt" class="avatar-group w3-hide">
                    <div class="avtBox">
                        <label for="11">
                            <img src="/mis/image/avatar/img_avatar11.png">
                        </label>
                        <input type="radio" name="ano" id="11" class="w3-radio avtrdo" value="11" checked>
                    </div>
                    <div class="avtBox">
                        <label for="12">
                            <img src="/mis/image/avatar/img_avatar12.png">
                        </label>
                        <input type="radio" name="ano" id="12" class="w3-radio avtrdo" value="12">
                    </div>
                    <div class="avtBox">
                        <label for="13">
                            <img src="/mis/image/avatar/img_avatar13.png">
                        </label>
                        <input type="radio" name="ano" id="13" class="w3-radio avtrdo" value="13">
                    </div>
                </div>
                <div id="fAvt" class="avatar-group w3-hide">
                    <div class="avtBox">
                        <label for="21">
                            <img src="/mis/image/avatar/img_avatar21.png">
                        </label>
                        <input type="radio" name="ano" id="21" class="w3-radio avtrdo" value="21">
                    </div>
                    <div class="avtBox">
                        <label for="22">
                            <img src="/mis/image/avatar/img_avatar22.png">
                        </label>
                        <input type="radio" name="ano" id="22" class="w3-radio avtrdo" value="22">
                    </div>
                    <div class="avtBox">
                        <label for="23">
                            <img src="/mis/image/avatar/img_avatar23.png">
                        </label>
                        <input type="radio" name="ano" id="23" class="w3-radio avtrdo" value="23">
                    </div>
                </div>
            </div>
        </form>
        <div class="buttons">
            <div class="button orange w3-left" id="reset">Reset</div>
            <div class="button green w3-left" id="home">Home</div>
            <div class="button blue w3-right" id="join">회원가입</div>
        </div>
    </div>
</body>
</html>
