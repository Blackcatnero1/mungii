<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title></title>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/mis/css/w3.css">
<link rel="stylesheet" type="text/css" href="/mis/css/user.css">
<script type="text/javascript" src="/mis/js/jquery-3.7.1.min.js"></script>
<style type="text/css">

</style>
<script type="text/javascript">
	$(document).ready(function(){
		$('#frm').submit();
	});
</script>
</head>
<body>
	<form method="POST" action="${PATH}" id="frm">
<c:if test="${not empty BNO}">
		<input type="hidden" name="bno" value="${BNO}">
</c:if>
<c:if test="${not empty nowPage}">
		<input type="hidden" name="nowPage" value="${nowPage}">
</c:if>
<c:if test="${not empty RESULT}">
		<input type="hidden" name="RESULT" value="${RESULT}">
</c:if>
<c:if test="${not empty TPNO}">
		<input type="hidden" name="tpno" value="${TPNO}">
</c:if>
	</form>
</body>
</html>