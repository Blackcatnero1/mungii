<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head></head>
<script defer src="https://maps.googleapis.com/maps/api/js?key=&callback=initMap&region=KR"></script>
<script type="text/javascript" src="/js/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="/css/w3.css">
<link rel="stylesheet" type="text/css" href="/css/user.css">
<link rel="stylesheet" type="text/css" href="/css/miseProj.css">
<script src='/js/miseProj.js'></script>
<script type="text/javascript">
	$(document).ready(function(){
		$('#continent').on('change', function(){
			var scontinent = $('#continent').val();
			var data = {
					continent: scontinent
			};
			$.ajax({
				type: "get",
				url: "/countryList.son",
				data: data,
				success: function(obj){
					for(var i = 0 ; i < obj.length; i++){
						$('#country').append("<option value='" + obj[i].country + "'>"+ obj[i].country +"</option>");
					}
				},
				error: function(xhr, status, error) {
	                alert("요청이 실패하였습니다.");
	            }
			});
		});
		$('#country').on('change', function(){
			var scontinent = $('#continent').val();
			var scountry = $('#country').val();
			var data = {
					continent: scontinent,
					country: scountry
			}
			$.ajax({
				type: "get",
				url: "/cityList.son",
				data: data,
				success: function(obj){
					for(var i = 0 ; i < obj.length; i++){
						$('#city').append('<option value=' + obj[i].cityname + '>'+ obj[i].cityname +'</option>');
					}
				},
				error: function(xhr, status, error) {
	                alert("요청이 실패하였습니다.");
	            }
			});
		});
		
		$('#continent').click(function(){
			$('#country').html('').append('<option selected>나라를 선택하세요.</option>');
			$('#city').html('').append('<option selected>도시를 선택하세요.</option>');
		});
	});
</script>
<body>
	<form method="post"></form>
    <div class="w3-content w3-center">
        <div class="w3-row w3-margin-top w3-center">
            <div class="w3-col l6 w3-border w3-padding">
                <label for="continent">도/특별시/광역시</label>
                <select id="continent" class="w3-select w3-center" name="continent">
                    <option selected>도/특별시/광역시를 선택하세요.</option>
                    <c:forEach var="DATA" items="${CONLIST}" varStatus="st">
                    	<option value="${DATA.continent }">${DATA.continent}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="w3-col l5 w3-border-top w3-border-bottom w3-padding">
                <label for="country">시/군/구</label>
                <select id="country" class="w3-select w3-center" name="country">
                    <option selected>시/군/구를 선택하세요.</option>
                </select>
            </div>
            <div class="w3-col l1 w3-border w3-padding" style="height: 79.5px; display: flex; align-items: center; justify-content: center;" >
                ★
            </div>
        </div>
        <div id="map" style="width:100%; height: 700px;"></div>
        <!-- 모달 HTML 구조 -->
		<div id="myModal" class="modal">
		  <div class="modal-content">
		    <span class="close">&times;</span>
		    <div id="modalContent"></div>
		  </div>
		</div>
    </div>
</body>
</html>
