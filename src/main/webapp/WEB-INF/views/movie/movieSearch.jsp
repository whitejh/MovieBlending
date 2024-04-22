<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 조회 페이지</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/movieSearch.css" />
<script src="https://kit.fontawesome.com/87f959d9dc.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<style type="text/css">
a, a:hover {
	color: white;
	text-decoration: none;
}
</style>

</head>
<body>
	<jsp:include
		page="${pageContext.request.contextPath}/WEB-INF/views/include/header.jsp" />

	<main>
		<div class="movieSearch_movie">
			<select id="searchType">
				<option value="movieNm">영화 제목</option>
				<option value="directorNm">감독명</option>
			</select> <input id="searchInput" name="search" type="text"
				placeholder="찾고 있는 영화가 있나요?" size="60" /> <input id="searchButton"
				class="header__search__button" type="submit" value="검색" />
			<ul>
				<li><h1>${searchText}</h1></li>
			</ul>
			<div class="movieSearch_list"></div>
		</div>
	</main>

	<!-- Footer -->
	<jsp:include
		page="${pageContext.request.contextPath}/WEB-INF/views/include/footer.jsp" />
		
	<script>
		$(document).ready(function() { //페이지 로드 후 실행될 함수     
			
			adjustCardHeight(); // 페이지 로드 시 카드 높이 조정
			
			// 윈도우 크기가 변경될 때마다 카드 높이 다시 조정
		    $(window).resize(function() {
		        adjustCardHeight();
		    });
		
			//movieButton 버튼 클릭 이벤트 함수(상세보기)
			$("#movieButton").on('click', function() {
				document.getElementById('movieForm').submit();
			});

			//검색 버튼 이벤트
			$("#searchButton").on('click', function() {
				$(".movieSearch_list").empty();
		        let inputText = $("#searchInput").val();
		        let type = $("#searchType").val(); // 선택된 검색 유형 가져오기
		        fetchSearchData(inputText, type); // 입력한 검색어와 선택된 검색 유형을 fetchData 함수에 전달
		    });
			
		});
		
		function fetchSearchData(inputText, type) {
			// AJAX 요청 보내기
			$.getJSON({
				url : '/movieSearch1',
				type : 'GET',
				data : {
					inputText : inputText,
					type : type // 선택된 검색 유형도 함께 전달
				},
				success : function(data) {
					console.log('AJAX 요청 성공 !!!');
					positionWithPoster(data);
				},
				error : function(xhr, status, error) {
					console.error('AJAX 요청 실패 ??? : ' + status + " " + error);
					console.error('전달하려는 inputText: ' + inputText);
					console.error('전달하려는 type: ' + type);
				}
			});
		}
		
		// 포스터가 있는 카드를 먼저 나열하게 배치
		function positionWithPoster(data) {
			// posterUrl이 있는 영화와 없는 영화를 구분하기 위한 배열 선언
		    let moviesWithPoster = [];
		    let moviesWithoutPoster = [];
		    
		 	// posterUrl 유무에 따라 분류
		    $.each(data, function(index, item) {  
		        if (item.posterUrl) {
		            moviesWithPoster.push(item);
		        } else {
		            moviesWithoutPoster.push(item);
		        }
		    });
		 	
		    // posterUrl이 있는 영화들 먼저 출력
		    $.each(moviesWithPoster, function(index, item) {    
		    	showSearchCard(item);
		    });
		    // 그 후 posterUrl이 없는 영화들 이어서 출력
		    $.each(moviesWithoutPoster, function(index, item) {  
		    	showSearchCard(item);
		    });
		}
		
		//데이터 출력 함수(카드에다 출력)
		function showSearchCard(item) {
			// item.openDt를 날짜 형식으로 변환
			let year = item.openDt.substring(0, 4);
			let month = item.openDt.substring(4, 6);
			let day = item.openDt.substring(6, 8);
			let formattedDate = year + '-' + month + '-' + day;

			let cardHtml = '<div class="card mb-3">'
					+ '<div class="card-header text-center">' + '<span>'
					+ item.movieNm
					+ '</span>'
					+ '<button class="bookmark-btn" data-bookmarked="false">&#9734;</button>'
					+ '</div>'
					+ '<div class="row g-0">'
					+ '<div class="col-md-12 text-center">'
					+ '<img src="' + item.posterUrl + '" class="card-img-top" alt="' + item.movieNm + ' : 포스터가 존재하지 않습니다.">'
					+ '</div>'
					+ '</div>'
					+ '<div class="card-body text-center">'
					+ '<p class="card-text">개봉일 : '
					+ formattedDate
					+ '</p>'
					+ '<ul class="list-group list-group-flush">'
					+ '<li class="list-group-item">장르 : '
					+ item.genre
					+ '</li>'
					+ '<li class="list-group-item">감독 : '
					+ item.directorNm
					+ '</li>'
					+ '</ul>'
					+ '<a href="movie/movieDetail?movieCd='
					+ item.movieCd
					+ '" class="btn btn-primary">상세 보기</a>'
					+ '</div>'
					+ '</div>';
			$(".movieSearch_list").append(cardHtml);
		}
		
		function adjustCardHeight() {
		    var maxHeight = 0;

		    // 모든 카드의 높이를 측정하여 최대 높이를 찾음
		    $('.card').each(function() {
		        var cardHeight = $(this).outerHeight();
		        if (cardHeight > maxHeight) {
		            maxHeight = cardHeight;
		        }
		    });

		    // 모든 카드에 최대 높이를 적용
		    $('.card').css('height', maxHeight + 'px');
		}
</script>