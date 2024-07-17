<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mis Park</title>
    <link rel="stylesheet" type="text/css" href="/mis/css/w3.css">
    <link rel="stylesheet" type="text/css" href="/mis/css/user.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css" integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script type="text/javascript" src="/mis/js/jquery-3.7.1.min.js"></script>
    <style type="text/css">
        body {
            font-family: 'Roboto', Arial, sans-serif;
            margin: 0;
            padding: 0;
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
        
		.labelPark {
		    font-weight: bold;
		    font-size: 20px;
		    margin-right: 20px;
		    text-align: right;
		    color: gray;
		}
		.spanPark{
		    font-weight: bold;
		    font-size: 20px;
		    margin-right: 20px;
		    text-align: right;
		    color: black;
		}
		
		 /* 텍스트 스타일 설정 */
        h3 {
            font-size: 1.2em; /* 제목 텍스트 크기 줄이기 */
            margin: 0.5em 0 0.2em 0; /* 상단 및 하단 마진 조정 */
        }

        p {
            font-size: 0.9em; /* 본문 텍스트 크기 줄이기 */
            margin: 0; /* 마진 제거 */
        }
        
    </style>
    <script type="text/javascript">
     $(document).ready(function(){
    	 
    	// 현재 날짜
	    var currentDate = new Date();
	    var currentDateString = currentDate.toISOString().split('T')[0]; // 현재 날짜 문자열 (YYYY-MM-DD 형식)
	    // 2024년 12월 31일
	    var limitDate = new Date('2024-12-31');
	    var limitDateString = limitDate.toISOString().split('T')[0]; // 2024년 12월 31일 문자열 (YYYY-MM-DD 형식)
	    
	    // input 태그에 최소 날짜와 최대 날짜를 설정합니다.
	    $('#dateSelect').attr('min', currentDateString);
	    $('#dateSelect').attr('max', limitDateString);
	    
    	 if($('#pdate').val() == ''){
		    // 초기 값으로 오늘 날짜를 설정합니다.
		    $('#dateSelect').val(currentDateString);
    	 }else{
    		 $('#dateSelect').val($('#pdate').val());
    	 }
    	 if($('#standard').val() !== ''){
    		 if($('#standard').val() == 'pmis'){
	    		 $('#sort option:selected').html('대기질순');
    		 }else if($('#standard').val() == 'pkreview'){
	    		 $('#sort option:selected').html('리뷰순');
    		 }else if($('#standard').val() == 'rec'){
	    		 $('#sort option:selected').html('추천순');
    		 }
    		 $('#sort option:selected').val($('#standard').val());
    	 }
	    
	    
     	/* 페이지 클릭이벤트 */
 		$('.pageBtn').click(function(){
 			var stand1 = $('#standard').val();
 			// 이동할 페이지번호 알아내고
 			var nowPage = $(this).attr('id');
 			// 입력태그에 데이터 채우고
 			$('#nowPage').val(nowPage);
 			// 글번호 태그 사용불가처리
 			$('#bno').prop('disabled', true);
 			// 전송 주소 셋팅하고
 			if(stand1 == ''){
	 			$('#pageFrm').submit();
 			}else if(stand1 !== "goods"){
	 			$('#pageFrm').attr('action', '/mis/park/'+ stand1 +'Sort.mis');
	 			$('#pageFrm').submit();
 			}
 			// 폼태그 전송하고
 		});
     	
 		$('#kpred').click(function(){
 			$(location).attr('href', '/mis/kpred/kpred.mis');
 		});
 		$('#park').click(function(){
 			$(location).attr('href', '/mis/park/park.mis');
 		});
        $('#realTime').click(function(){
        	$(location).attr('href', '/mis/realTimeDust/view.mis');
        });
 		$('.kpred').click(function(){
 			var scity = $(this).attr('id');
 			var sdate = $('#dateSelect').val();
 			$('#pcity').val(scity);
 			$('#pdate').val(sdate);
 			$('#pageFrm').attr('action', '/mis/park/parkPred.mis');
			$('#pageFrm').submit();
 		});
 		
 		
 		$('#selCityDate').click(function(){
 			var stand = $('#sort option:selected').val();
 			var sdate = $('#dateSelect').val();
 			$('#pdate').val(sdate);
			$('#standard').val(stand);
			
			if(stand == 'pmis'){
				$('#pageFrm').attr('action', '/mis/park/pmisSort.mis');
			}else if(stand == 'pkreview'){
				$('#pageFrm').attr('action', '/mis/park/pkreviewSort.mis');
			}else if(stand == 'rec'){
				$('#pageFrm').attr('action', '/mis/park/recSort.mis');
			}else{
				$('#pageFrm').attr('action', '/mis/park/recSort.mis');
			}
			$('#nowPage').val(1);
			$('#pageFrm').submit();
 		});
		$('#myPage').click(function(){
			$(location).attr('href', '/mis/member/mypage.mis');
		});
		$('#join').click(function(){
			$(location).attr('href', '/mis/member/join.mis');
		});
        $('#logout').click(function(){
            $(location).attr('href', '/mis/park/parkLogout.mis');
        });
        $('#login').click(function(){
            $(location).attr('href', '/mis/park/parkLogin.mis');
        });
        $('.hrefTag').click(function(){
        	var sid = $(this).attr('id');
        	$(location).attr('href', 'https://search.naver.com/search.naver?where=nexearch&sm=top_sug.pre&fbm=0&acr=1&acq=tjfdkrzpdl&qdt=0&ie=utf8&query=' + sid);
        })
     });
 		function handleClick() {
 			$(location).attr('href', '/mis/');
        }
    </script>
</head>
<form method="post" action="/mis/park/park.mis" id="pageFrm">
	<input type="hidden" name="nowPage" id="nowPage" value="${PAGE.nowPage}">
	<input type="hidden" name="pcity" id="pcity" value="">
	<input type="hidden" name="pdate" id="pdate" value="${PAGE.pdate }">
	<input type="hidden" name="standard" id="standard" value="${PAGE.standard}">
</form>
<body class="w3-light-grey">
  
<div class="w3-content" style="max-width:1000px">
	
	  <!-- 헤더1 -->
	<header class="w3-display-container w3-wide" id="home" onclick="handleClick()">
		<div class="header">
    		<img src='https://github.com/Blackcatnero1/mungii/blob/branch/yujin/Gmail/export202406271712491601.png?raw=true' style="width:1000px; height:250px;">
		</div>
	</header>
	
	<!-- 버튼헤더(필요시 갯수추가) -->
	<header class="w3-container w3-center w3-white">
	    <h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off" id="realTime">실시간 정보 보기</button></h6>
	    <h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off" id="kpred">미세먼지 예측 하기</button></h6>
	    <h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off" id="park">관광지 추천 받기</button></h6>
	</header>
		<!-- 본문박스 -->
	
	<div class="w3-main w3-content w3-center">
		<div class='w3-col'>
			<div class='w3-third' style="margin-top:3px;">
				<h6 class="w3-left-align">&nbsp;&nbsp;<i class="fa-solid fa-user"></i>
			      	<c:if test="${SID eq null}">
						<b> Guest </b> 님 환영합니다.
			     		<a class="w3-bar-item w3-button"><i class="fa-solid fa-user " id="login"></i></a>
			     		<a class="w3-bar-item w3-button"><i class="fa-solid fa-user-plus " id="join"></i></a>
			     </c:if>
			     <c:if test="${SID ne null}">
						<b> ${SID} </b> 님 환영합니다.
			     		<a class="w3-bar-item w3-button"><i class="fa-solid fa-user-xmark" id="logout"></i></a>
			     		<a class="w3-bar-item w3-button"><i class="fa-solid fa-address-card" id="myPage"></i></a>
			     </c:if>
				</h6>
			</div>
			<div class="w3-third w3-center" style="margin-top:10px;">
				<h6 class="w3-right-align"><b>
					<label for="city">정렬 기준 : </label>
					<select class="" id="sort">
						<option disabled selected value="rec">정렬</option>
						<option value='rec'>추천순</option>
						<option value="pkreview">리뷰순</option>
						<option value="pmis">대기질순</option>
					</select>
				</b></h6>
			</div>
			<div class="w3-third w3-center" style="margin-top:8px;">
				<h6 class=" w3-right-align">
					<b><label for="dateSelect">날짜 선택 : </label><input type="date" id="dateSelect"></b>
					<button class="w3-margin-left"><i class="fa-solid fa-square-check" id="selCityDate"></i></button>
				</h6>
			</div>
		</div>
		
		
			<c:if test="${not empty LIST}">
<div class="w3-col">
    <!-- Assuming LIST is your list of DATA objects -->
    <c:forEach var="DATA" items="${LIST}">
        <li style="list-style-type: none; /* 순서 없는 목록의 기본 마커 숨김 */">
            <div class="w3-col w3-margin-bottom w3-border w3-card-4 w3-padding" style="display: inline-block;">
                <img class="w3-col l2 m2 w3-left hrefTag" src="${DATA.plink}" style="height: 135px; width: 200px; cursor:pointer;" id="${DATA.pname }">
                <div class="w3-col l7 m7 w3-left-align w3-padding">
					<c:if test="${fn:length(DATA.pname) > 10}">                	
	                	<label for="location" class="w3-col s3 m3 labelPark">관광지명</label><span class="spanPark l7 m7" id="location"><small>${DATA.pname}</small></span><br>
	                </c:if>
					<c:if test="${fn:length(DATA.pname) <= 10}">                	
	                	<label for="location" class="w3-col s3 m3 labelPark">관광지명</label><span class="spanPark l7 m7" id="location">${DATA.pname}</span><br>
	                </c:if>
	                <c:choose>
	                    <c:when test="${DATA.pkreview == 999}">
	                        <label for="location" class="w3-col s3 m3 labelPark">리뷰</label><span class="spanPark l7 m7" id="location">${DATA.pkreview}+</span><br>
	                    </c:when>
	                    <c:otherwise>
	                    	<label for="location" class="w3-col s3 m3 labelPark">리뷰</label><span class="spanPark l7 m7" id="location">${DATA.pkreview}</span><br>
	                    </c:otherwise>
	                </c:choose>
	                <label for="location" class="w3-col s3 m3 labelPark">위치</label><span class="spanPark l7 m7" id="location">${DATA.pcity}</span><br>
	                <label for="location" class="w3-col s3 m3 labelPark">미세먼지 농도</label><span class="spanPark l7 m7" id="location"> ${DATA.pmis} AQI</span><br>
                </div>
                <div id="${DATA.city}" class="w3-padding w3-button w3-gray kpred l2 m2 w3-right" style="margin-top:50px">예측 정보 보러가기</div>
            </div>
        </li>
    </c:forEach>
</div>


			
			<div class="w3-col w3-center">
				<div class="w3-bar w3-round">
	<c:if test="${PAGE.startPage ne 1}">
					<span class="w3-bar-item w3-btn pageBtn w3-light-gray w3-hover-blue" 
														id="${PAGE.startPage - 1}">&laquo;</span>
	</c:if>
	<c:forEach var="pageno" begin="${PAGE.startPage}" end="${PAGE.endPage}">
		<c:if test="${PAGE.nowPage eq pageno}"><!-- 현재 보고있는 페이지인 경우 -->
					<span class="w3-bar-item w3-pink" 
																	id="${pageno}">${pageno}</span>
		</c:if>
		<c:if test="${PAGE.nowPage ne pageno}">
					<span class="w3-bar-item w3-btn w3-hover-blue pageBtn" 
																	id="${pageno}">${pageno}</span>
		</c:if>
	</c:forEach>
	<c:if test="${PAGE.endPage ne PAGE.totalPage}">
					<span class="w3-bar-item w3-btn pageBtn w3-light-gray w3-hover-blue" 
														id="${PAGE.endPage + 1}">&raquo;</span>
	</c:if>
				</div>
			</div>
</c:if>
	</div>
<!-- END w3-content -->
  <div class="w3-col w3-padding-16 w3-dark-gray">
    <div class="w3-row">
      <div class="w3-container w3-col">
      	<img class="w3-col l2 m2 w3-right w3-round-large" src="/mis/image/LOGO.png" style="height: 80px; width: 72px; margin-top:30px;">
      	<div>
	        <h6> Team. 먼지가 되어 leader. 전민경 . 02) 3667-3688 business</h6>
			<h6> Team member. 김광섭, 김한민, 김유진, 허광혁</h6>
			<h6> AI데이터플랫폼(with Python, JAVA, Spring)을 이용한 빅데이터 분석 전문가 과정(8회차)</h6>
      	</div>
      </div>
    </div>
  </div>
</div>
    
</body>
</html>