<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reboard</title>
    <link rel="stylesheet" type="text/css" href="/mis/css/w3.css" />
    <link rel="stylesheet" type="text/css" href="/mis/css/user.css" />
    <link rel="stylesheet" href="/mis/css/font-awesome-4.7.0/css/font-awesome.min.css">
    <script type="text/javascript" src="/mis/js/jquery-3.7.1.min.js"></script>
    <style type="text/css">
    	.goods {
    		cursor: pointer;
    	}
        body {
            font-family: 'Roboto', Arial, sans-serif;
            background-color: #f9f9f9;
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
            max-width: 800px;
            margin: auto;
            padding: 20px;
        }
        .button {
            margin: 5px;
            padding: 10px 20px;
            border: none;
            color: white;
            background-color: #4285f4;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .button:hover {
            background-color: #357ae8;
        }
        .post {
            background-color: white;
            margin-top: 20px;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        .post-header {
            display: flex;
            align-items: center;
        }
        .post-avatar {
            border-radius: 50%;
            margin-right: 15px;
            width: 50px;
            height: 50px;
        }
        .post-info {
            flex-grow: 1;
        }
        .post-body {
            margin-top: 10px;
        }
        .post-footer {
            margin-top: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .like-icon {
            color: #e74c3c;
        }
        .post-level {
            margin-left: 20px;
        }
    </style>
    <script type="text/javascript">
    	$(function(){
    		$('.tbtn').click(function(){
    			var path = '/mis/main.mis';
    			
    			var bid = $(this).attr('id');
    			switch(bid){
    				case 'home':
    					path = '/mis/main.mis';
    					break;
    				case 'logout':
    					path = '/mis/member/logout.mis';
    					break;
    				case 'login':
    					path = '/mis/member/login.mis';
    					break;
    				case 'join':
    					path = '/mis/member/join.mis';
    					break;
    			}
    			
    			$(location).attr('href', path);
    		});
    		
	    	$('#write').click(function(){
	    		var path = '/mis/reboard/reboardWrite.mis';
	    		$('#frm').attr('action', path);
	    		$('#frm').submit();
	    	});
	    	
	    	/* 페이징 처리 */
	    	$('.pageBtn').click(function(){
	    		var spno = $(this).attr('id');
	    		$('#nowPage').val(spno);
	    		$('#frm').attr('action', '/mis/reboard/reboard.mis');
	    		$('#frm').submit();
	    	});
	    	
	    	/* 글 삭제 이벤트 */
	    	$('.delete').click(function(){
	    		var sbno = $(this).attr('id').substring(1);
	    		$('#frm').append('<input type="hidden" name="bno" value="' + sbno + '">');
	    		$('#frm').attr('action', '/mis/reboard/delReboard.mis');
	    		$('#frm').submit();
	    		
	    	});

	    	/* 댓글 쓰기 이벤트 */
	    	$('.append').click(function(){
	    		var sbno = $(this).attr('id').substring(1);
	    		$('#frm').append('<input type="hidden" name="bno" value="' + sbno + '">');
	    		$('#frm').attr('action', '/mis/reboard/reboardRewrite.mis');
	    		$('#frm').submit();
	    	});
	    	
	    	/* 좋아요 클릭 이벤트 */
	    	$('i.goods').click(function(){
	    		// 해당 태그의 글 번호 꺼내온다
	    		var sbno = $(this).attr('id').substring(1);
	    		$('#frm').append('<input type="hidden" name="bno" value="' + sbno + '">');	    		
	    		$('#frm').attr('action', '/mis/reboard/addGood.mis');
	    		$('#frm').submit();
	    	});
    	});
    </script>
</head>
<body>
	<form method="POST" id="frm">
		<input type="hidden" name="nowPage" id="nowPage" value="${PAGE.nowPage}">
		<input type="hidden" name="id" value="${SID}">
	</form>
    <div class="header">
        <h1>댓글 게시판</h1>
    </div>
    <div class="container">
        <!-- 버튼 태그 -->
        <div style="text-align: center; margin-bottom: 20px;">
            <button class="button tbtn" id="home">Home</button>
<c:if test="${not empty SID}">
                <button class="button tbtn" id="logout">Logout</button>
                <button class="button tbtn" id="write">글 작성</button>
</c:if>
<c:if test="${empty SID}">
                <button class="button tbtn" id="join">Join</button>
                <button class="button tbtn" id="login">Login</button>
</c:if>
        </div>

        <!-- 게시글 태그 -->
<c:if test="${not empty LIST}">
<c:forEach var="DATA" items="${LIST}">
            <div class="post post-level" style="margin-left: ${(DATA.level - 1) * 50}px;">
                <div class="post-header">
                    <img src="/mis/avatar/${DATA.savename}" class="post-avatar">
                    <div class="post-info">
                        <h4>${DATA.id}</h4>
                        <p>작성일 : ${DATA.sdate}</p>
                    </div>
                </div>
                <div class="post-body">
                    <pre>${DATA.body}</pre>
                </div>
                <div class="post-footer">
<c:if test="${SID eq DATA.id}">
                    <button class="button delete" id="d${DATA.bno}">글삭제</button>
</c:if>
<c:if test="${not empty SID and DATA.level lt 3}">
                    <button class="button append" id="r${DATA.bno}">댓글쓰기</button>
</c:if>
                    <div class="w3-hide" id="${DATA.regroup}"></div>
                    <p>
                    	<i class="fa fa-heart like-icon goods" id="g${DATA.bno}"></i>
	                    <span>좋아요</span>
	                    <span>${DATA.goods}</span>
                    </p>
                </div>
            </div>
</c:forEach>
    </div>
    

    <!-- 페이징 처리 -->
    <div class="w3-col w3-center w3-margin-top">
			<div class="w3-bar w3-border w3-border w3-border-blue w3-round">
<c:if test="${PAGE.startPage eq 1}">
				<span class="w3-bar-item w3-pale-blue">&laquo;</span>
</c:if>
<c:if test="${PAGE.startPage ne 1}">
				<span class="w3-bar-item w3-btn w3-hover-blue pageBtn" 
													id="${PAGE.startPage - 1}">&laquo;</span>
</c:if>
<c:forEach var="pno" begin="${PAGE.startPage}" end="${PAGE.endPage}">
	<c:if test="${PAGE.nowPage eq pno}"><!-- 현재 보고있는 페이지인 경우 -->
				<span class="w3-bar-item w3-pink"
																id="${pno}">${pno}</span>
	</c:if>
	<c:if test="${PAGE.nowPage ne pno}">
				<span class="w3-bar-item w3-btn w3-hover-blue pageBtn" 
																id="${pno}">${pno}</span>
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
<!-- 리스트가 비어있지 않은 경우 방명록 리스트 조건처리 닫는 태그 -->
<c:if test="${empty LIST}">
			<div class="w3-col w3-border-bottom w3-margin-top">
				<h3 class="w3-center w3-text-gray">* 아직 작성된 글이 없습니다. *</h3>
			</div>
</c:if>

</body>
</html>
