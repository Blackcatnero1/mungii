<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>${LNAME} 날씨 예측하기</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="/mis/css/w3.css">
<link rel="stylesheet" type="text/css" href="/mis/css/user.css">
<script type="text/javascript" src="/mis/js/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css" integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<style>
	html,body,h1,h2,h3,h4,h5 {font-family: "Raleway", sans-serif}
</style>
	<script type="text/javascript">
		$(document).ready(function(){
			$('#realTime').click(function(){
            	$(location).attr('href', '/mis/realTimeDust/view.mis');
            });
			$('#realTime2').click(function(){
            	$(location).attr('href', '/mis/realTimeDust/view.mis');
            });
			$('#park').click(function(){
				$(location).attr('href', '/mis/park/park.mis');
			});
			$('#kpred').click(function(){
            	$(location).attr('href', '/mis/kpred/kpred.mis');
            });
			$('#jip').click(function(){
            	$(location).attr('href', '/mis');
            });
			$('#myPage').click(function(){
				$(location).attr('href', '/mis/member/mypage.mis');
			});
			$('#join').click(function(){
				$(location).attr('href', '/mis/member/join.mis');
			});
            $('#logout').click(function(){
                $(location).attr('href', '/mis/kpred/klogout.mis');
            });
            $('#login').click(function(){
                $(location).attr('href', '/mis/kpred/klogin.mis');
            });
		    // 현재 날짜
		    var currentDate = new Date();
		    var currentDateString = currentDate.toISOString().split('T')[0]; // 현재 날짜 문자열 (YYYY-MM-DD 형식)
		    // 2024년 12월 31일
		    var limitDate = new Date('2024-12-31');
		    var limitDateString = limitDate.toISOString().split('T')[0]; // 2024년 12월 31일 문자열 (YYYY-MM-DD 형식)
		    
		    // input 태그에 최소 날짜와 최대 날짜를 설정합니다.
		    $('#dateSelect').attr('min', currentDateString);
		    $('#dateSelect').attr('max', limitDateString);
		    if($('#kdate').val() !== ''){
			    var currentDateString = $('#kdate').val();
		    }
		    var syear = currentDateString.substring(0,4);
		    var smonth = currentDateString.substring(5,7);
		    var sday = currentDateString.substring(8,10);
		    $('#dateSelect').val(syear + '-' +  smonth + '-' + sday);
		    $('.todayDate').html(syear + '년 ' + smonth + '월 ' + sday + '일');
		    
		    
		    var sensors = ['pm25', 'pm10', 'co', 'o3', 'so2', 'no2'];
		
		    sensors.forEach(function(sensor) {
		        // 단위로 나누기
		        var valueText = $('#' + sensor + ' span:nth-child(3)').text().trim(); // 예: "1.00 AQI"
		        var value = parseFloat(valueText); // 문자열을 소수로 변환
	
		        // 정수 형태로 변환
		        var integerValue = Math.round(value);
	
		        // 예시: 정수 형태로 변환한 값을 기준으로 클래스 추가
				if (integerValue <= 50) {
		            $('#' + sensor).attr('style', 'background-color: rgb(171, 209, 98);');
			        $('#' + sensor).prepend('<span class="w3-right">좋음</span>');
		        } else if (integerValue <= 100) {
		        	$('#' + sensor).attr('style', 'background-color: rgb(248, 212, 97);');
			        $('#' + sensor).prepend('<span class="w3-right">보통</span>');
		        } else if (integerValue <= 150) {
		        	$('#' + sensor).attr('style', 'background-color: rgb(251, 153, 86);');
			        $('#' + sensor).prepend('<span class="w3-right">나쁨</span>');
		        } else if (integerValue <= 200) {
		        	$('#' + sensor).attr('style', 'background-color: rgb(246, 104, 106);');
			        $('#' + sensor).prepend('<span class="w3-right">매우나쁨</span>');
		        } else if (integerValue <= 250) {
		        	$('#' + sensor).attr('style', 'background-color: rgb(164, 125, 184);');
			        $('#' + sensor).prepend('<span class="w3-right">심각</span>');
		        } else if (integerValue <= 300) {
		        	$('#' + sensor).attr('style', 'background-color: rgb(160, 119, 133);');
			        $('#' + sensor).prepend('<span class="w3-right">치명적</span>');
		        }
	
		        // 예시: HTML에 정수 형태로 변환한 값 표시
		    });
		    $('#selCityDate').click(function(){
		    	if(!$('#city').val()){
		    		alert('도시를 선택하세요.');
		    		return;
		    	}
			    var scity = $('#city').val();
			    var sdate = $('#dateSelect').val();
			    var data = {
						city: scity,
						kdate: sdate
				}
			    $.ajax({
			        type: "post",
			        url: "/mis/kpred/selCityDate.mis",
			        data: data,
			        success: function(obj) {
			            $('.cityName').html(obj.city);
			            var spm25 = parseFloat(obj.predicted_pm25);
			            var spm10 = parseFloat(obj.predicted_pm10);
			            var so3 = parseFloat(obj.predicted_o3);
			            var sco = parseFloat(obj.predicted_co);
			            var sno2 = parseFloat(obj.predicted_no2);
			            var sso2 = parseFloat(obj.predicted_so2);

			            var aqis = ['pm25', 'pm10', 'co', 'o3', 'so2', 'no2'];
			            var dataList = [spm25, spm10, so3, sco, sno2, sso2];

			            // AQI 값을 표시합니다.
			            for (var i = 0; i < dataList.length; i++) {
			                $('.predict_' + aqis[i]).html(dataList[i] + ' AQI');
			            }

			            // 날짜를 표시합니다.
			            var kyear = obj.kdate.substring(0, 4);
			            var kmonth = obj.kdate.substring(5, 7);
			            var kday = obj.kdate.substring(8, 10);
			            $('.todayDate').html( kyear + '년 ' + kmonth + '월 ' + kday + '일');

			            // AQI 레벨에 따라 배경색과 등급을 할당합니다.
			            for (var i = 0; i < aqis.length; i++) {
			                if (!isNaN(dataList[i])) {
			                    if (dataList[i] <= 50) {
			                        $('#' + aqis[i]).attr('style', 'background-color: rgb(171, 209, 98);');
			                        $('#' + aqis[i] + ' > span').html('좋음');
			                    } else if (dataList[i] <= 100) {
			                        $('#' + aqis[i]).attr('style', 'background-color: rgb(248, 212, 97);');
			                        $('#' + aqis[i] + ' > span').html('보통');
			                    } else if (dataList[i] <= 150) {
			                        $('#' + aqis[i]).attr('style', 'background-color: rgb(251, 153, 86);');
			                        $('#' + aqis[i] + ' > span').html('나쁨');
			                    } else if (dataList[i] <= 200) {
			                        $('#' + aqis[i]).attr('style', 'background-color: rgb(246, 104, 106);');
			                        $('#' + aqis[i] + ' > span').html('매우나쁨');
			                    } else if (dataList[i] <= 250) {
			                        $('#' + aqis[i]).attr('style', 'background-color: rgb(164, 125, 184);');
			                        $('#' + aqis[i] + ' > span').html('심각');
			                    } else if (dataList[i] <= 300) {
			                        $('#' + aqis[i]).attr('style', 'background-color: rgb(160, 119, 133);');
			                        $('#' + aqis[i] + ' > span').html('치명적');
			                    }
			                } else {
			                    // Handle NaN values (if any)
			                    $('#' + aqis[i]).attr('style', 'background-color: lightgray;');
			                    $('#' + aqis[i] + ' > span').html('데이터 없음');
			                }
			            }
			            // CAI 값을 계산하고 표시합니다.
			            var sum = 0;
			            var count = 0;
			            for (var i = 0; i < dataList.length; i++) {
			                if (!isNaN(dataList[i])) {
			                    sum += dataList[i];
			                    count++;
			                }
			            }
			            if (count > 0) {
			                var avg = sum / count;
			                $('#cai-value').html(avg.toFixed(2) + ' IAQI');
			    		    if (avg <= 50) {
			    		        $('#hrang').attr('src', '/mis/image/하랑이/초록이.jpg');
			    		    } else if (avg <= 100) {
			    		        $('#hrang').attr('src', '/mis/image/하랑이/파랑이.jpg');
			    		    } else if (avg <= 150) {
			    		        $('#hrang').attr('src', '/mis/image/하랑이/노랑이.jpg');
			    		    } else {
			    		        $('#hrang').attr('src', '/mis/image/하랑이/빨강이.jpg');
			    		    }
			            } else {
			                $('#cai-value').html('데이터 없음');
			            }
			            $('#apm25').html(obj.kpm25 + '%');
			            $('#apm10').html(obj.kpm10 + '%');
			            $('#aco').html(obj.kco + '%');
			            $('#ao3').html(obj.ko3 + '%');
			            $('#ano2').html(obj.kno2 + '%');
			            $('#aso2').html(obj.kso2 + '%');
			            $('#apm25').css('width', obj.kpm25 + '%');
			            $('#apm10').css('width', obj.kpm10 + '%');
			            $('#ano2').css('width', obj.kno2 + '%');
			            $('#aso2').css('width', obj.kso2 + '%');
			            $('#ao3').css('width', obj.ko3 + '%');
			            $('#aco').css('width', obj.kco + '%');
			            
			    	    // 배열로 변수와 요소들을 관리
			    		var kkpm25 = obj.kpm25;
			    		var kkpm10 = obj.kpm10;
			    		var kkco = obj.kco;
			    		var kko3 = obj.ko3;
			    		var kkno2 = obj.kno2;
			    		var kkso2 = obj.kso2;
			    	    var kklist = [kkpm25, kkpm10, kkco, kko3, kkno2, kkso2];
			    	    var aalist = ['apm25', 'apm10', 'aco', 'ao3', 'ano2', 'aso2'];
			    	    for(var i = 0 ; i < kklist.length ; i++){
				    	    if (kklist[i] > 80) {
				            	$('#' + aalist[i]).removeClass('w3-red w3-green w3-yellow w3-orange').addClass('w3-green');
				    	    }else if(kklist[i] > 60){
				            	$('#' + aalist[i]).removeClass('w3-red w3-green w3-yellow w3-orange').addClass('w3-yellow');
				    	    }else if(kklist[i] > 40){
				            	$('#' + aalist[i]).removeClass('w3-red w3-green w3-yellow w3-orange').addClass('w3-orange');
				    	    }else{
				            	$('#' + aalist[i]).removeClass('w3-red w3-green w3-yellow w3-orange').addClass('w3-red');
				    	    }
			    	    }
			        },
			        error: function(xhr, status, error) {
			            alert("요청이 실패하였습니다.");
			        }
			    });
			    
			    $.ajax({
			        type: "post",
			        url: "/mis/kpred/selDateRank.mis",
			        data: data,
			        success: function(obj) {
			        	for(var i = 0 ; i < 5 ; i++){
			        		$('#date' + i).html(obj[i].city);
			        		$('#adate' + i).html(obj[i].predicted_pm10 + '<small> AQI</small>');
			        	};
			        },
			        error: function(xhr, status, error) {
			            alert("요청이 실패하였습니다.");
			        }
			    });
		    });
		    var aqis = ['pm25', 'pm10', 'co', 'o3', 'so2', 'no2'];
		    var ppm25 = parseFloat($('.predict_pm25').html().substring(0, $('.predict_pm25').html().length - 4));
		    var ppm10 = parseFloat($('.predict_pm10').html().substring(0, $('.predict_pm25').html().length - 4));
		    var pno2 = parseFloat($('.predict_no2').html().substring(0, $('.predict_pm25').html().length - 4));
		    var pso2 = parseFloat($('.predict_so2').html().substring(0, $('.predict_pm25').html().length - 4));
		    var pco = parseFloat($('.predict_co').html().substring(0, $('.predict_pm25').html().length - 4));
		    var po3 = parseFloat($('.predict_o3').html().substring(0, $('.predict_pm25').html().length - 4));
		    
		    var average = (ppm25 + ppm10 + pno2 + pso2 + pco + po3) / 6;
		    $('#cai-value').html(average.toFixed(2) + ' IAQI');
		    if (average <= 50) {
		        $('#hrang').attr('src', '/mis/image/하랑이/초록이.jpg');
		    } else if (average <= 100) {
		        $('#hrang').attr('src', '/mis/image/하랑이/파랑이.jpg');
		    } else if (average <= 150) {
		        $('#hrang').attr('src', '/mis/image/하랑이/노랑이.jpg');
		    } else {
		        $('#hrang').attr('src', '/mis/image/하랑이/빨강이.jpg');
		    }
		    
		});
	</script>
</head>
<body class="w3-light-grey">
<form method="post" action="" id="kPredFrm">
	<input type="hidden" name="kdate" id="kdate" value="${MISLIST.kdate}">
</form>
<!-- Top container -->

<div class="w3-bar w3-top w3-black w3-large" style="z-index:4;">
  <button class="w3-bar-item w3-button w3-hide-large w3-hover-none w3-hover-text-light-grey" onclick="w3_open();"><i class="fa fa-bars"></i>  메뉴</button>
  <span class="w3-bar-item w3-right w3-button w3-col" id="jip"><i class="fa-solid fa-house"></i></span>
</div>

<!-- Sidebar/menu -->
<nav class="w3-sidebar w3-collapse w3-white w3-animate-left" style="z-index:3;width:300px;" id="mySidebar"><br>
  <div class="w3-container w3-row">
    <div class="w3-col s3">
      <img src="/mis/image/avatar/img_avatar11.png" class="w3-circle w3-margin-right" style="width:46px">
    </div>
    <div class="w3-col s9 w3-bar">
    <c:if test="${SID ne null}">
      <span><b>${SID} 님 환영합니다.</b></span><br>
    </c:if>
    <c:if test="${SID eq null }">
      <span><b>Guest 님 환영합니다.</b></span><br>
    </c:if>
      <c:if test="${SID eq null}">
      		<a class="w3-bar-item w3-button"><i class="fa-solid fa-user " id="login"></i></a>
      		<a class="w3-bar-item w3-button"><i class="fa-solid fa-user-plus " id="join"></i></a>
      </c:if>
      <c:if test="${SID ne null}">
      		<a class="w3-bar-item w3-button"><i class="fa-solid fa-user-xmark" id="logout"></i></a>
      		<a class="w3-bar-item w3-button"><i class="fa-solid fa-address-card" id="myPage"></i></a>
      </c:if>
    </div>
  </div>
  <hr>
  <div class="w3-container">
    <h5><i class="fa-solid fa-list"></i> 목차</h5>
    <hr>
  </div>
  <div class="w3-bar-block">
    <a href="#" class="w3-bar-item w3-button w3-padding w3-hide-large w3-dark-grey w3-hover-black" onclick="w3_close()" title="close menu"><i class="fa fa-remove fa-fw"></i>  닫기</a>
    <a href="#" class="w3-bar-item w3-button w3-padding" id="realTime2"><i class="fa fa-users fa-fw"></i> 단기 예측</a>
    <a href="#" class="w3-bar-item w3-button w3-padding w3-red"><i class="fa fa-eye fa-fw"></i> 중(장)기 예측</a>
    <a href="#" class="w3-bar-item w3-button w3-padding"><i class="fa fa-users fa-fw"></i> 응애</a>
  </div>
</nav>


<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:300px;margin-top:37px;">

  <!-- Header -->
	<header class="w3-container">
		<h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off"id="realTime">실시간 정보 보기</button></h6>
		<h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off" id="kpred">미세먼지 예측 하기</button></h6>
		<h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off" id="park">관광지 추천받기</button></h6>
		<div class='w3-col'>
			<div class='w3-third'>
				<h5><i class="fa-solid fa-play"></i><b class="cityName"> ${MISLIST.city}</b><b><small>(</small><small class="todayDate"></small><small>)</small> 대기정보</b></h5>
			</div>
			<div class="w3-third w3-center">
				<h6><b>
					<label for="city"><i class="fa-solid fa-play"></i> 도시 선택 : </label>
					<select id="city">
						<option disabled selected>시/구를 선택하세요.</option>
	                    <c:forEach var="DATA" items="${CITYLIST}" varStatus="st">
	                    	<option value="${DATA.city }">${DATA.city}</option>
	                    </c:forEach>
					</select>
				</b></h6>
			</div>
			<div class="w3-third w3-center">
				<h6>
					<b><label for="dateSelect"><i class="fa-solid fa-play"></i> 날짜 선택 : </label><input type="date" id="dateSelect"></b>
					<button class="w3-margin-left" id="selCityDate"><i class="fa-solid fa-square-check"></i></button>
				</h6>
			</div>
		</div>
	</header>

  <div class="w3-margin-bottom">
  	<div class='w3-half w3-row-padding' style='padding-right:0px'>
	    <div class="w3-third">
	      <div class="w3-container w3-padding-16" id='pm25'>
	        <div class="w3-left"><i class="fa-solid fa-temperature-low w3-xxxlarge"></i></div>
	        <div class="w3-right">
	          <div>
	          	<hr>
	          	<span>미세먼지<sub>(PM25)</sub></span>
	          	<span class="predict_pm25">${MISLIST.predicted_pm25} AQI</span>
	          </div>
	        </div>
	      </div>
	    </div>
	    <div class="w3-third">
	      <div class="w3-container w3-padding-16 aqiblock" id='pm10'>
	        <div class="w3-left"><i class="fa-solid fa-temperature-high w3-xxxlarge"></i></div>
	        <div class="w3-right">
	          <hr>
	          	<span>초미세먼지<sub>(PM10)</sub></span>
	          	<span class="predict_pm10">${MISLIST.predicted_pm10} AQI</span>
	        </div>
	      </div>
	    </div>
	    <div class="w3-third">
	      <div class="w3-container w3-padding-16 aqiblock" id='o3'>
	        <div class="w3-left"><i class="fa-solid fa-regular fa-sun w3-xxxlarge"></i></div>
	        <div class="w3-right">
	          <hr>
	          	<span class='w3-col'>오존<sub>(O3)</sub></span>
	          	<span class="predict_o3">${MISLIST.predicted_o3} AQI</span>
	        </div>
	      </div>
	    </div>
	</div>
  	<div class='w3-half w3-row-padding' style="padding-left:0px">
	    <div class="w3-third">
	      <div class="w3-container w3-padding-16 aqiblock" id='co'>
	        <div class="w3-left"><i class="fa-solid fa-cloud w3-xxxlarge"></i></div>
	        <div class="w3-right">
	          <hr>
	          	<span>일산화탄소<sub>(CO)</sub></span>
	          	<span class="predict_co">${MISLIST.predicted_co} AQI</span>
	        </div>
	      </div>
	    </div>
	    <div class="w3-third">
	      <div class="w3-container w3-padding-16 aqiblock" id='no2'>
	        <div class="w3-left"><i class="fa-solid fa-smog w3-xxxlarge"></i></div>
	        <div class="w3-right">
	          <hr>
	          	<span>이산화질소<sub>(NO2)</sub></span>
	          	<span class="predict_no2">${MISLIST.predicted_no2} AQI</span>
	        </div>
	      </div>
	    </div>
	    <div class="w3-third">
	      <div class="w3-container w3-padding-16 aqiblock" id='so2'>
	        <div class="w3-left"><i class="fa-solid fa-water w3-xxxlarge"></i></div>
	        <div class="w3-right">
	          <hr>
	          	<span>아황산가스<sub>(SO2)</sub></span>
	          	<span class="predict_so2">${MISLIST.predicted_so2} AQI</span>
	        </div>
	      </div>
	    </div>
	</div>
</div>
<div class="w3-container">
    <h5><i class="fa-solid fa-play"></i><b> 측정 기준<small>(기준 : AQI)</small></b></h5>
    <div class="w3-grey w3-margin-top">
        <div class="w3-col">
	        <div class="w3-col l2 w3-container w3-center w3-padding" style="background-color: rgb(171, 209, 98);"><b>좋음<small>(1 ~ 50)</small></b></div>
	        <div class="w3-col l2 w3-container w3-center w3-padding" style="background-color: rgb(248, 212, 97);"><b>보통<small>(51 ~ 100)</small></b></div>
	        <div class="w3-col l2 w3-container w3-center w3-padding" style="background-color: rgb(251, 153, 86);"><b>나쁨<small>(101 ~ 150)</small></b></div>
	        <div class="w3-col l2 w3-container w3-center w3-padding" style="background-color: rgb(246, 104, 106);"><b>매우나쁨<small>(151 ~ 200)</small></b></div>
	        <div class="w3-col l2 w3-container w3-center w3-padding" style="background-color: rgb(164, 125, 184);"><b>심각<small>(201 ~ 250)</small></b></div>
	        <div class="w3-col l2 w3-container w3-center w3-padding" style="background-color: rgb(160, 119, 133);"><b>치명적<small>(251 ~ )</small></b></div>
       </div>
   </div>
</div>
	
  <div class="w3-panel">
    <div class="w3-row-padding" style="margin:0 -16px">
      <div class="w3-third">
        <h5>오늘의 미세먼지는 ?!</h5>
        <img src="/mis/image/하랑이/빨강이.jpg" style="height:305px;" id="hrang">
      </div>
      <div class="w3-twothird">
        <h5>예측값</h5>
        <table class="w3-table w3-striped w3-white">
          <tr>
            <td><i class="fa-solid fa-person w3-text-green w3-xlarge"></i></td>
            <td>통합 대기질 지수 (CAI)</td>
           	<td><i id="cai-value"></i><td>
          </tr>
          <tr>
            <td><i class="fa-solid fa-temperature-low w3-text-blue w3-xlarge"></i></td>
            <td>미세먼지 (PM25)</td>
            <td><i class="predict_pm25">${MISLIST.predicted_pm25 } AQI</i></td>
          </tr>
          <tr>
            <td><i class="fa-solid fa-temperature-high w3-text-red w3-xlarge"></i></td>
            <td>초미세먼지 (PM10)</td>
            <td><i class="predict_pm10">${MISLIST.predicted_pm10 } AQI</i></td>
          </tr>
          <tr>
            <td><i class="fa-solid fa-sun w3-text-yellow w3-xlarge"></i></td>
            <td>오존 (O3)</td>
            <td><i class="predict_o3">${MISLIST.predicted_o3 } AQI</i></td>
          </tr>
          <tr>
            <td><i class="fa-solid fa-cloud w3-text-red w3-xlarge"></i></td>
            <td>일산화탄소 (CO)</td>
            <td><i class="predict_co">${MISLIST.predicted_co } AQI</i></td>
          </tr>
          <tr>
            <td><i class="fa-solid fa-smog w3-text-blue w3-xlarge"></i></td>
            <td>이산화질소 (NO2)</td>
            <td><i class="predict_no2">${MISLIST.predicted_no2 } AQI</i></td>
          </tr>
          <tr>
            <td><i class="fa-solid fa-water w3-text-red w3-xlarge"></i></td>
            <td>아황산가스 (SO2)</td>
            <td><i class="predict_so2">${MISLIST.predicted_so2 } AQI</i></td>
          </tr>
        </table>
      </div>
    </div>
  </div>
  <hr>
  <div class="w3-container">
    <h5><b>예측 정확도<small>(단위 : 단계별)</small></b></h5>

    <p style="margin:3px;"><b>PM25(미세먼지)</b></p>
    <div class="w3-grey">
      <div class="w3-container w3-center w3-padding w3-red" id="apm25" style="width:${ACCU.kpm25}%">${ACCU.kpm25}%</div>
    </div>
    <p style="margin:3px;"><b>PM10(초미세먼지)</b></p>
    <div class="w3-grey">
      <div class="w3-container w3-center w3-padding w3-red" id="apm10" style="width:${ACCU.kpm10}%">${ACCU.kpm10}%</div>
    </div>
    <p style="margin:3px;"><b>CO(일산화탄소)</b></p>
    <div class="w3-grey">
      <div class="w3-container w3-center w3-padding w3-red" id="aco" style="width:${ACCU.kco}%">${ACCU.kco }%</div>
    </div>
    <p style="margin:3px;"><b>O3(오존)</b></p>
    <div class="w3-grey">
      <div class="w3-container w3-center w3-padding w3-red" id="ao3" style="width:${ACCU.ko3}%">${ACCU.ko3 }%</div>
    </div>
    <p style="margin:3px;"><b>NO2(이산화질소)</b></p>
    <div class="w3-grey">
      <div class="w3-container w3-center w3-padding w3-red" id="ano2" style="width:${ACCU.kno2}%">${ACCU.kno2 }%</div>
    </div>
    <p style="margin:3px;"><b>SO2(아황산가스)</b></p>
    <div class="w3-grey">
      <div class="w3-container w3-center w3-padding w3-red" id="aso2" style="width:${ACCU.kso2}%">${ACCU.kso2 }%</div>
    </div>
  </div>
	<hr>
  <div class="w3-container">
    <h5><b>평균 예측률 높은 지역</b></h5>
    <table class="w3-table w3-striped w3-bordered w3-border w3-hoverable w3-white">
	      <c:forEach var="DATA" items="${RANKLIST}" varStatus="st">
      		<tr>
		        <td class="w3-half">${ DATA.city}</td>
		        <td class="w3-half">${DATA.arate }%</td>
	      </tr>
	      </c:forEach>
    </table><br>
  </div>
  <hr>
  <div class="w3-container">
    <h5><b>초미세먼지(PM25)가 제일 좋은 지역(단위 : AQI)</b> <small>(</small><small><b class="todayDate"></b></small><small>)</small></h5>
    <table class="w3-table w3-striped w3-bordered w3-border w3-hoverable w3-white">
		<c:forEach var="DATA" items="${DATERANK}" varStatus="st">
		    <tr>
		        <td class="w3-half" id="date${st.index}">${DATA.city}</td>
		        <td class="w3-half" id="adate${st.index}">${DATA.predicted_pm10}<small> AQI</small></td>
		    </tr>
		</c:forEach>
    </table><br>
  </div>
  <hr>
  <div class="w3-container w3-dark-grey w3-padding-32">
    <div class="w3-row">
      <div class="w3-container w3-third">
        <h5 class="w3-bottombar w3-border-green">Demographic</h5>
        <p>Language</p>
        <p>Country</p>
        <p>City</p>
      </div>
      <div class="w3-container w3-third">
        <h5 class="w3-bottombar w3-border-red">System</h5>
        <p>Browser</p>
        <p>OS</p>
        <p>More</p>
      </div>
      <div class="w3-container w3-third">
        <h5 class="w3-bottombar w3-border-orange">Target</h5>
        <p>Users</p>
        <p>Active</p>
        <p>Geo</p>
        <p>Interests</p>
      </div>
    </div>
  </div>

  <!-- End page content -->
</div>

<script>
	// Get the Sidebar
	var mySidebar = document.getElementById("mySidebar");
	
	// Get the DIV with overlay effect
	var overlayBg = document.getElementById("myOverlay");
	
	// Toggle between showing and hiding the sidebar, and add overlay effect
	function w3_open() {
	  if (mySidebar.style.display === 'block') {
	    mySidebar.style.display = 'none';
	    overlayBg.style.display = "none";
	  } else {
	    mySidebar.style.display = 'block';
	    overlayBg.style.display = "block";
	  }
	}
	
	// Close the sidebar with the close button
	function w3_close() {
	  mySidebar.style.display = "none";
	  overlayBg.style.display = "none";
	}
</script>
<script type="text/javascript">
	$(document).ready(function(){
	    // 배열로 변수와 요소들을 관리
	    var pollutants = [
	        { id: '#apm25', threshold: 80 },
	        { id: '#apm10', threshold: 80 },
	        { id: '#aco', threshold: 80 },
	        { id: '#ao3', threshold: 80 },
	        { id: '#ano2', threshold: 80 },
	        { id: '#aso2', threshold: 80 }
	    ];
	
	    // 반복문을 통해 각 요소에 대해 처리
	    $.each(pollutants, function(index, item) {
	        var value = $(item.id).html().substring(0, $(item.id).html().length - 1);
	        
	        if (value > item.threshold) {
	            $(item.id).removeClass('w3-red w3-green w3-yellow w3-orange').addClass('w3-green');
	        } else if (value > 60) {
	            $(item.id).removeClass('w3-red w3-green w3-yellow w3-orange').addClass('w3-yellow');
	        } else if (value > 40) {
	            $(item.id).removeClass('w3-red w3-green w3-yellow w3-orange').addClass('w3-orange');
	        } else {
	            $(item.id).removeClass('w3-red w3-green w3-yellow w3-orange').addClass('w3-red');
	        }
	    });
	});
</script>
</body>
</html>
