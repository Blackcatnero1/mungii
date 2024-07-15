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
            text-align: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            background-image: url('https://github.com/Blackcatnero1/mungii/blob/branch/yujin/Gmail/export202406271712491601.png?raw=true');
            width: 100%;
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
        .button.pink { background-color: #e91e63; }
        .button.blue-gray { background-color: #607d8b; }
        .button.orange { background-color: #ff9800; }
        .button.light-green { background-color: #8bc34a; }
        .button.blue { background-color: #2196f3; }
        .button.green { background-color: #4caf50; }
        		
		.fixed-size{
			height: 100px;
			text-size: 15px;
		}
		
		/* 이미지 고정 크기 및 자르기 설정 */
		.fixed-size img {
		    width: 135px;
			display: inline-block;
		    object-fit: cover;
		}
    </style>
    <script type="text/javascript">
        $(document).ready(function(){
            $('#join').click(function(){
                $(location).attr('href', '/mis/member/join.mis');
            });

            // 각 버튼에 대한 클릭 이벤트 처리
            $('#login').click(function(){
                var sid = $('#id').val();
                if(!sid){
                    $('#id').focus();
                    return;
                }
                
                var spw = $('#pw').val();
                if(!spw){
                    $('#pw').focus();
                    return;
                }
                
                $('#frm').attr('method', 'POST').attr('action', '/mis/member/loginProc.mis');
                $('#frm').submit();
            });

            // 엔터 키로 로그인 버튼 클릭 이벤트 추가
            $('#id, #pw').on('keypress', function(e) {
                if (e.which == 13) {
                    $('#login').click();
                }
            });
            
            $('#logout').click(function(){
                $(location).attr('href', '/mis/member/logout.mis');
            });
            $('#park').click(function(){
                $(location).attr('href', '/mis/park/park.mis');
            });
            $('#myPage').click(function(){
                $(location).attr('href', '/mis/member/mypage.mis');
            });
            $('#kpred').click(function(){
            	$(location).attr('href', '/mis/kpred/kpred.mis');
            });
            
         	// 모든 기사 링크에 클릭 이벤트 추가
            var articleList = document.getElementById('articleList');
	        var articles = [
	        	{ title: '석탄화력 가동을 중지하면 미세먼지 농도는 얼마나 줄어들까?', url: 'http://www.keaj.kr/news/articleView.html?idxno=3396' },
	            { title: '3.4%라는 숫자로 가려져 있던 석탄화력발전소 초미세먼지의 심각성', url: 'https://www.greenpeace.org/korea/update/5956/blog-ce-hidden-figure-severe-impact-of-fine-dust/' },
	            { title: '석탄화력에서 배출되는 미세먼지, 사망률 2배 높인다', url: 'https://m.dongascience.com/news.php?idx=62613' },
	            { title: '고농도 미세먼지 7가지 대응요령', url: 'https://www.cleanair.go.kr/dust/dust/dust-emergency02.do' },
	            { title: '미세먼지 줄이고 건강은 지키는 8가지 실천방법', url: 'https://www.korea.kr/news/healthView.do?newsId=148912595#health' },
	            { title: '미세먼지란?', url: 'https://www.ehtis.or.kr/cmn/sym/mnu/mpm/60001011/htmlMenuView.do' },
	            { title: '폐 망가뜨리는 미세 먼지 ‘이 음식’ 먹으면 배출', url: 'https://m.health.chosun.com/svc/news_view.html?contid=2023020701441' }
	        ];
	
	     // Fisher-Yates 알고리즘을 사용한 배열 섞기
	        function shuffleArray(array) {
	            for (let i = array.length - 1; i > 0; i--) {
	                const j = Math.floor(Math.random() * (i + 1));
	                [array[i], array[j]] = [array[j], array[i]];
	            }
	        }

	        shuffleArray(articles); // 페이지 로드시 한 번 섞어줌

	        // 섞인 기사 제목을 화면에 적용하는 함수
	        function displayArticles(articles) {
	            var articleList = document.getElementById('articleList');
	            articleList.innerHTML = ''; // 기존 리스트 초기화

	            articles.forEach(function(article, index) {
	            	var truncatedTitle = truncateText(article.title, 15); // 최대 길이를 15로 설정
	            	var articleLink = document.createElement('a');
	            	articleLink.style.textDecoration = 'none'; // style 속성 설정 방식 수정
	            	articleLink.href = article.url;
	            	articleLink.textContent = truncatedTitle;
	            	articleLink.title = article.title; // 원본 텍스트를 title 속성에 추가
	            	articleLink.classList.add('article-link', 'w3-margin-left'); // 클래스 리스트에 여러 클래스 추가
	            	articleLink.style.marginBottom = '-1px'; // 원하는 margin-bottom 값으로 설정
	            	articleList.appendChild(articleLink);

	                // 마지막 기사에는 구분선 추가하지 않음
	                if (index < articles.length - 1) {
	                    var hr = document.createElement('hr');
	                    hr.style.border = 'solid 1px #808080';
	                    hr.style.margin = '10px 0';
	                    articleList.appendChild(hr);
	                }
	            });
	        }

	        // 텍스트를 자르고 '...'을 추가하는 함수
	        function truncateText(text, maxLength) {
	            if (text.length > maxLength) {
	                return text.substring(0, maxLength) + '...';
	            } else {
	                return text;
	            }
	        }

	        displayArticles(articles); // 섞인 기사 제목을 화면에 표시
        });
    </script>
</head>
<body class="w3-light-grey">
<div class="w3-content" style="max-width:1000px;">
    <!-- 헤더1 -->
    <div class="w3-col">
   		<img src='https://github.com/Blackcatnero1/mungii/blob/branch/yujin/Gmail/export202406271712491601.png?raw=true' style="width:1000px; height:250px;">
    </div>
    <!-- 버튼헤더(필요시 갯수추가) -->
    <header class="w3-container w3-center w3-padding w3-white">
        <h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off">실시간 정보 보기</button></h6>
        <h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off" id="kpred">미세먼지 예측하기</button></h6>
        <h6><button class="w3-button w3-white w3-third w3-large w3-opacity w3-hover-opacity-off" id="park">테마파크</button></h6>
    </header>
    <!-- Grid -->
    <div class="w3-col l8">
        <!-- 좌분면 -->
	    <!-- 국내 순위 -->
	    <div class="w3-col l6 s6">
	        <div class="w3-white w3-margin-right w3-margin-left">
	            <div class="w3-center">
	                <h3>국내</h3>
	            </div>
	            <hr style="border: solid 1px black; margin: 0;">
	            <ol id="domestic-ranking">
                <!-- JSP forEach 루프 -->
                <!-- JSP forEach 루프 (첫 5개 요소만 반복) -->
                <c:forEach items="${linksList2}" var="link" varStatus="loop">
                    <c:if test="${loop.index < 5}">
                        <li class="w3-margin-bottom">
                            <a href="${link.href}" class="w3-text-gray w3-left-align" style="text-decoration:none;"><b>${link.text}</b></a>
                            <div><b>AQI : ${link.aqi}</b></div>
                        </li>
                    </c:if>
                </c:forEach>
            </ol>
        </div>
    </div>
    
	   <!-- 해외 순위 -->
	   <div class="w3-col l6 s6">
	       <div class="w3-white w3-margin-left w3-margin-right ">
	           <div class="w3-center">
	               <h3>해외</h3>
	           </div>
	           <hr style="border: solid 1px black; margin: 0;">
	           <ol id="international-ranking">
	            <!-- JSP forEach 루프 (첫 5개 요소만 반복) -->
	            <c:forEach items="${linksList}" var="link" varStatus="loop">
	                <c:if test="${loop.index < 5}">
	                    <li class="w3-margin-top">
	                        <a href="${link.href}" class="w3-text-gray w3-left-align" style="text-decoration:none;"><b>${link.text}</b></a>
	                        <div><b>AQI : ${link.aqi}</b></div>
	                    </li>
	                </c:if>
	            </c:forEach>
	         </ol>
	     </div>
	 </div>
	 <div class="w3-col w3-center">
       	<div>
	        <h3 class="w3-white w3-margin-left w3-margin-right w3-padding w3-center">대마파크</h3>
	        <div class="w3-col">
	        <c:forEach var="DATA" items="${LIST}">
				<div class="w3-quarter w3-margin-bottom l3" style="display: inline-block">
					<div class="fixed-size">
						<img src="${DATA.plink}" style="height:100%">
					</div>
					<h6 style="margin:0;"><small>${DATA.pname}</small></h6>
					<p style="margin:0;"><small>${DATA.pcity}</small></p>
					<p style="margin:0;"><small>${DATA.pmis} AQI</small></p>
				</div>
			</c:forEach>
			</div>
		</div>
	</div>
</div>
<div>
            <!-- 좌분면 닫기 -->
        <!-- 좌우 나누는 박스 -->
        <div class="w3-rest l3 s3">
            <!-- 우상단 -->
            <form method="POST" id="frm">
                <div class="w3-white w3-margin">
                    <c:if test="${empty SID}">
                        <div class="w3-container w3-padding w3-black">
                            <h4>로그인</h4>
                        </div>
                        <div class="w3-container w3-white" style="padding-bottom: 10px;">
                            <p><input class="w3-input w3-border" name="id" id="id" type="text" placeholder="아이디" style="padding-left: 10px"></p>
                            <p><input type="password" class="w3-input w3-border" name="pw" id="pw" placeholder="비밀번호"></p>
                            <div class="w3-half w3-button w3-green" id="login">로그인</div>
                            <div class="w3-half w3-button w3-blue" id="join">회원가입</div>
                        </div>
                    </c:if>
                    <c:if test="${not empty SID}">
                        <div class="w3-container w3-padding w3-black">
                            <h4>내 정보</h4>
                        </div>
                        <div class="w3-container w3-white" style="padding-bottom: 10px;">
                        	<h5 class="w3-center w3-padding"><b>${SID}</b> 님 환영합니다.</h5>
                            <div class="w3-col w3-button w3-pale-red" id="logout">로그아웃</div>
                            <div class="w3-col w3-button w3-gray w3-margin-top" id="myPage">마이페이지</div>
                        </div>
                    </c:if>
                </div>
            </form>
            <!-- 우하단 -->
            <div class="w3-white w3-margin">
			    <div class="w3-container w3-padding w3-black">
			        <h4>관련 기사</h4>
			    </div>
			    <div id="articleList" class="w3-container w3-white w3-padding" style="max-height: 400px; overflow-y: auto; display: flex; flex-direction: column;">
			        <div id="articleList" class="w3-container w3-white w3-padding" style="max-height: 400px; overflow-y: auto; display: flex; flex-direction: column;">

				    </div>
				</div>
			</div>
            <!-- 우하단 닫기 -->
        </div>
        <!-- 좌우 나누는 박스 닫기 -->
    </div>
    <!-- END GRID -->
<!-- END w3-content -->
<!-- Footer -->
<footer class="w3-container w3-dark-grey" style="padding:32px">
    <a href="#" class="w3-button w3-black w3-padding-large w3-margin-bottom"><i class="fa fa-arrow-up w3-margin-right"></i>위로가는버튼 필요한가요</a>
    <p>사용설명서 여기다가</p>
</footer>
</div>

</body>
</html>
