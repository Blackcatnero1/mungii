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
			console.log($(location).attr('href'));
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
		    $('.todayDate').html('(' + syear + '년 ' + smonth + '월 ' + sday + '일)');
		    
		    
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
			        $('#' + sensor).prepend('<span class="w3-right">' + 1 + ' 등급</span>');
		        } else if (integerValue <= 100) {
		        	$('#' + sensor).attr('style', 'background-color: rgb(248, 212, 97);');
			        $('#' + sensor).prepend('<span class="w3-right">' + 2 + ' 등급</span>');
		        } else if (integerValue <= 150) {
		        	$('#' + sensor).attr('style', 'background-color: rgb(251, 153, 86);');
			        $('#' + sensor).prepend('<span class="w3-right">' + 3 + ' 등급</span>');
		        } else if (integerValue <= 200) {
		        	$('#' + sensor).attr('style', 'background-color: rgb(246, 104, 106);');
			        $('#' + sensor).prepend('<span class="w3-right">' + 4 + ' 등급</span>');
		        } else if (integerValue <= 250) {
		        	$('#' + sensor).attr('style', 'background-color: rgb(164, 125, 184);');
			        $('#' + sensor).prepend('<span class="w3-right">' + 5 + ' 등급</span>');
		        } else if (integerValue <= 300) {
		        	$('#' + sensor).attr('style', 'background-color: rgb(160, 119, 133);');
			        $('#' + sensor).prepend('<span class="w3-right">' + 6 + ' 등급</span>');
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
			            $('.todayDate').html('(' + kyear + '년 ' + kmonth + '월 ' + kday + '일)');

			            // AQI 레벨에 따라 배경색과 등급을 할당합니다.
			            for (var i = 0; i < aqis.length; i++) {
			                if (!isNaN(dataList[i])) {
			                    if (dataList[i] <= 50) {
			                        $('#' + aqis[i]).attr('style', 'background-color: rgb(171, 209, 98);');
			                        $('#' + aqis[i] + ' > span').html('1 등급');
			                    } else if (dataList[i] <= 100) {
			                        $('#' + aqis[i]).attr('style', 'background-color: rgb(248, 212, 97);');
			                        $('#' + aqis[i] + ' > span').html('2 등급');
			                    } else if (dataList[i] <= 150) {
			                        $('#' + aqis[i]).attr('style', 'background-color: rgb(251, 153, 86);');
			                        $('#' + aqis[i] + ' > span').html('3 등급');
			                    } else if (dataList[i] <= 200) {
			                        $('#' + aqis[i]).attr('style', 'background-color: rgb(246, 104, 106);');
			                        $('#' + aqis[i] + ' > span').html('4 등급');
			                    } else if (dataList[i] <= 250) {
			                        $('#' + aqis[i]).attr('style', 'background-color: rgb(164, 125, 184);');
			                        $('#' + aqis[i] + ' > span').html('5 등급');
			                    } else if (dataList[i] <= 300) {
			                        $('#' + aqis[i]).attr('style', 'background-color: rgb(160, 119, 133);');
			                        $('#' + aqis[i] + ' > span').html('6 등급');
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
			                var average = sum / count;
			                $('#cai-value').html(average.toFixed(2) + ' IAQI');
			            } else {
			                $('#cai-value').html('데이터 없음');
			            }
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
		});
	</script>
</head>
<body class="w3-light-grey">
<form method="post" action="" id="kPredFrm">
	<input type="hidden" name="kdate" id="kdate" value="${MISLIST.kdate}">
</form>
<!-- Top container -->
<div class="w3-bar w3-top w3-black w3-large" style="z-index:4;">
  <button class="w3-bar-item w3-button w3-hide-large w3-hover-none w3-hover-text-light-grey" onclick="w3_open();"><i class="fa fa-bars"></i>  Menu</button>
  <span class="w3-bar-item w3-right w3-button w3-col" id="jip"><i class="fa-solid fa-house"></i></span>
</div>

<!-- Sidebar/menu -->
<nav class="w3-sidebar w3-collapse w3-white w3-animate-left" style="z-index:3;width:300px;" id="mySidebar"><br>
  <div class="w3-container w3-row">
    <div class="w3-col s3">
      <img src="https://data1.pokemonkorea.co.kr/newdata/pokedex/full/000701.png" class="w3-circle w3-margin-right" style="width:46px">
    </div>
    <div class="w3-col s9 w3-bar">
      <span><b>${SID} </b><strong class="todayDate"></strong></span><br>
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
    <h5>목차</h5>
  </div>
  <div class="w3-bar-block">
    <a href="#" class="w3-bar-item w3-button w3-padding-16 w3-hide-large w3-dark-grey w3-hover-black" onclick="w3_close()" title="close menu"><i class="fa fa-remove fa-fw"></i>  Close Menu</a>
    <a href="#" class="w3-bar-item w3-button w3-padding"><i class="fa fa-users fa-fw"></i> 단기 예측</a>
    <a href="#" class="w3-bar-item w3-button w3-padding w3-red"><i class="fa fa-eye fa-fw"></i> 중(장)기 예측</a>
    <a href="#" class="w3-bar-item w3-button w3-padding"><i class="fa fa-users fa-fw"></i> 응애</a>
  </div>
</nav>


<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:300px;margin-top:43px;">

  <!-- Header -->
	<header class="w3-container">
		<h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off">실시간 정보 보기</button></h6>
		<h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off" id="kpred">미세먼지 예측 하기</button></h6>
		<h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off" id="park">여행지 추천 받기</button></h6>
		<div class='w3-col'>
			<div class='w3-third'>
				<h5><i class="fa-solid fa-cloud-sun-rain"></i><b class="cityName">${MISLIST.city}</b><b><small class="todayDate"></small> 날씨정보</b></h5>
			</div>
			<div class="w3-third w3-center">
				<h6><b>
					<label for="city">도시 선택 : </label>
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
					<b><label for="dateSelect">날짜 선택 : </label><input type="date" id="dateSelect"></b>
					<button class="w3-margin-left" id="selCityDate">⏎</button>
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
	
  <div class="w3-panel">
    <div class="w3-row-padding" style="margin:0 -16px">
      <div class="w3-third">
        <h5>Regions</h5>
        <img src="https://data1.pokemonkorea.co.kr/newdata/pokedex/full/000701.png" style="width:100%" alt="Google Regional Map">
      </div>
      <div class="w3-twothird">
        <h5>Predicted</h5>
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
    <h5>Accuracy Rate</h5>
    <p>New Visitors</p>
    <div class="w3-grey">
      <div class="w3-container w3-center w3-padding w3-green" style="width:25%">+25%</div>
    </div>

    <p>New Users</p>
    <div class="w3-grey">
      <div class="w3-container w3-center w3-padding w3-orange" style="width:50%">50%</div>
    </div>

    <p>Bounce Rate</p>
    <div class="w3-grey">
      <div class="w3-container w3-center w3-padding w3-red" style="width:75%">75%</div>
    </div>
  </div>
  <hr>

  <div class="w3-container">
    <h5>Countries</h5>
    <table class="w3-table w3-striped w3-bordered w3-border w3-hoverable w3-white">
      <tr>
        <td>United States</td>
        <td>65%</td>
      </tr>
      <tr>
        <td>UK</td>
        <td>15.7%</td>
      </tr>
      <tr>
        <td>Russia</td>
        <td>5.6%</td>
      </tr>
      <tr>
        <td>Spain</td>
        <td>2.1%</td>
      </tr>
      <tr>
        <td>India</td>
        <td>1.9%</td>
      </tr>
      <tr>
        <td>France</td>
        <td>1.5%</td>
      </tr>
    </table><br>
    <button class="w3-button w3-dark-grey">More Countries  <i class="fa fa-arrow-right"></i></button>
  </div>
  <hr>
  <div class="w3-container">
    <h5>Recent Users</h5>
    <ul class="w3-ul w3-card-4 w3-white">
      <li class="w3-padding-16">
        <img src="https://data1.pokemonkorea.co.kr/newdata/pokedex/full/000701.png" class="w3-left w3-circle w3-margin-right" style="width:35px">
        <span class="w3-xlarge">Mike</span><br>
      </li>
      <li class="w3-padding-16">
        <img src="https://data1.pokemonkorea.co.kr/newdata/pokedex/full/000701.png" class="w3-left w3-circle w3-margin-right" style="width:35px">
        <span class="w3-xlarge">Jill</span><br>
      </li>
      <li class="w3-padding-16">
        <img src="https://data1.pokemonkorea.co.kr/newdata/pokedex/full/000701.png" class="w3-left w3-circle w3-margin-right" style="width:35px">
        <span class="w3-xlarge">Jane</span><br>
      </li>
    </ul>
  </div>
  <hr>

  <div class="w3-container">
    <h5>Recent Comments</h5>
    <div class="w3-row">
      <div class="w3-col m2 text-center">
        <img class="w3-circle" src="/mis/avatar/img_avatar13.png" style="width:96px;height:96px">
      </div>
      <div class="w3-col m10 w3-container">
        <h4>John <span class="w3-opacity w3-medium">Sep 29, 2014, 9:12 PM</span></h4>
        <p>Keep up the GREAT work! I am cheering for you!! Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p><br>
      </div>
    </div>

    <div class="w3-row">
      <div class="w3-col m2 text-center">
        <img class="w3-circle" src="/mis/avatar/img_avatar22.png" style="width:96px;height:96px">
      </div>
      <div class="w3-col m10 w3-container">
        <h4>Bo <span class="w3-opacity w3-medium">Sep 28, 2014, 10:15 PM</span></h4>
        <p>Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p><br>
      </div>
    </div>
  </div>
  <br>
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

  <!-- Footer -->
  <footer class="w3-container w3-padding-16 w3-light-grey">
    <h4>FOOTER</h4>
    <p>Powered by <a href="https://www.w3schools.com/w3css/default.asp" target="_blank">w3.css</a></p>
  </footer>

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

    };
</script>
</body>
</html>