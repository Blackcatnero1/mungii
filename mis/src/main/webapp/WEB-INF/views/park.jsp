<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>mis Main</title>
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
            text-align: center;
        }
		
		.fixed-size{
			height: 280px;
			text-size: 15px;
		}
		
		/* 이미지 고정 크기 및 자르기 설정 */
		.fixed-size img {
		    width: 200px;
			display: inline-block;
		    object-fit: cover;
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
            $('#login').click(function(){
                var sid = '${SID}';
                if(!sid || sid == 'null'){
                    $(location).attr('href', '/mis/member/login.mis');
                } else {
                    alert('이미 로그인 했습니다.');
                }
            });
            
            $('#logout').click(function(){
                $(location).attr('href', '/mis/member/logout.mis');
            });
            
            $('#join').click(function(){
                var sid = '${SID}';
                if(!sid || sid == 'null'){
                    $(location).attr('href', '/mis/member/join.mis');
                } else {
                    return;
                }
            });
            
            $(document).ready(function(){
            	/* 페이지 클릭이벤트 */
        		$('.pageBtn').click(function(){
        			// 이동할 페이지번호 알아내고
        			var nowPage = $(this).attr('id');
        			// 입력태그에 데이터 채우고
        			$('#nowPage').val(nowPage);
        			// 글번호 태그 사용불가처리
        			$('#bno').prop('disabled', true);
        			// 전송 주소 셋팅하고
        			$('#pageFrm').attr('action', '/mis/park/park.mis');
        			
        			// 폼태그 전송하고
        			$('#pageFrm').submit();
        		});
            });
            
        });
    </script>
</head>
<form method="post" action="/park/park.mis" id="pageFrm">
	<input type="hidden" name="nowPage" id="nowPage" value="${PAGE.nowPage}">
</form>
<body class="w3-light-grey">
  
<div class="w3-content" style="max-width:1000px">
	
	  <!-- 헤더1 -->
	<header class="w3-display-container w3-wide" id="home">
		<div class="header">
			<h1>페이지 템플릿(배경 변경 가능성 있음)</h1>
		</div>
	</header>
	
	<!-- 버튼헤더(필요시 갯수추가) -->
	<header class="w3-container w3-center w3-padding w3-white">
	    <h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off">버튼1</button></h6>
	    <h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off">버튼2</button></h6>
	    <h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off">버튼3</button></h6>
	</header>
		
		<!-- 본문박스 -->
	<div class="w3-main w3-content w3-padding" style="margin-top: 50px;">
<c:if test="${not empty LIST}">
	<c:forEach var="DATA" items="${LIST}">
				<div class="w3-quarter" style="display: inline-block; height: 380px;" id="parkList">
					<div class="fixed-size">
						<img src="${DATA.plink}" style="height:100%">
					</div>
					<h3>${DATA.pname}</h3>
					<p>${DATA.pcity}</p>
				</div>
	</c:forEach>
			
			<div class="w3-col w3-center w3-margin-top">
				<div class="w3-bar w3-border w3-border w3-border-blue w3-round">
	<c:if test="${PAGE.startPage eq 1}">
					<span class="w3-bar-item w3-pale-blue">&laquo;</span>
	</c:if>
	<c:if test="${PAGE.startPage ne 1}">
					<span class="w3-bar-item w3-btn w3-hover-blue pageBtn" 
														id="${PAGE.startPage - 1}">&laquo;</span>
	</c:if>
	<c:forEach var="pageno" begin="${PAGE.startPage}" end="${PAGE.endPage}">
		<c:if test="${PAGE.nowPage eq pageno}"><!-- 현재 보고있는 페이지인 경우 -->
					<span class="w3-bar-item w3-btn w3-pink w3-hover-blue pageBtn" 
																	id="${pageno}">${pageno}</span>
		</c:if>
		<c:if test="${PAGE.nowPage ne pageno}">
					<span class="w3-bar-item w3-btn w3-hover-blue pageBtn" 
																	id="${pageno}">${pageno}</span>
		</c:if>
	</c:forEach>
	<c:if test="${PAGE.endPage ne PAGE.totalPage}">
					<span class="w3-bar-item w3-btn w3-hover-blue pageBtn" 
														id="${PAGE.endPage + 1}">&raquo;</span>
	</c:if>
	<c:if test="${PAGE.endPage eq PAGE.totalPage}">
					<span class="w3-bar-item w3-pale-blue">&raquo;</span>
	</c:if>
				</div>
			</div>
</c:if>
	</div>
<!-- END w3-content -->
</div>

	
<!-- Footer -->
<footer class="w3-container w3-dark-grey" style="padding:32px">
	<a href="#" class="w3-button w3-black w3-padding-large w3-margin-bottom"><i class="fa fa-arrow-up w3-margin-right"></i>위로가는버튼\n필요한가요</a>
	<p>사용설명서 여기다가</p>
</footer>
    
</body>
</html>
