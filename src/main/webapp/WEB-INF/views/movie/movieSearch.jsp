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
<title>박스오피스</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/boxOffice.css" />
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
		<div class="boxoffice">
			<div class="boxoffice_name">
				<input id="searchInput" name="search" type="text"
					placeholder="찾고 있는 영화가 있나요?" size="60" /> <input id="searchButton"
					class="header__search__button" type="submit" value="검색" />
				<ul>
					<li><h1>${searchText}</h1></li>
				</ul>
			</div>
			<div class="boxoffice_movie">
				<c:forEach items="${mList}" var="item">
					<div class="card mb-3">
						<div class="card-header">
							<button class="bookmark-btn" data-bookmarked="false">&#9734;</button>
						</div>
						<div class="row g-0">
							<div class="col-md-12 text-center">
								<h5 class="card-title">${item.movieNm}</h5>
								<img src="${item.posterUrl}" class="card-img-top"
									alt="${item.movieNm} 이미지">
							</div>
						</div>
						<div class="card-body text-center">
							<p class="card-text">개봉일 : ${item.openDt}</p>
							<form id="movieForm" action="/movie/movieDetail" method="get">
								<input type="hidden" id="movieCd" name="movieCd"
									value="${item.movieCd}" />
								<button type="submit" id="movieButton" class="btn btn-primary">상세
									보기</button>
							</form>

						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</main>

	<!-- Footer -->
	<footer id="contact" class="section">
		<div class="max-container">
			<h2 class="title">세미 프로젝트 3팀</h2>
			<!-- <p class="description">세미 프로젝트 3팀</p> -->
			<ul class="contact__links">
				<li><a class="contact__link"
					href="https://www.instagram.com/netflixkr/" title="netflixkr link"
					target="_blank"> <i class="fa-brands fa-instagram"></i>
				</a></li>
				<li><a class="contact__link"
					href="https://www.instagram.com/disneypluskr/"
					title="disneypluskr link" target="_blank"> <i
						class="fa-brands fa-instagram"></i>
				</a></li>
			</ul>
			<p>©BlackLight - All rights reserved</p>
		</div>
	</footer>
	<script>
		$(document).ready(function() { //페이지 로드 후 실행될 함수     	
		
			//movieButton 버튼 클릭 이벤트 함수(상세보기)
			$("#movieButton").on('click', function() {
				document.getElementById('movieForm').submit();
			});

			//별 아이콘 클릭 시 색 채우기
			$('.bookmark-btn').click(function() {
				$(this).toggleClass('bookmarked'); //색상 클래스 토글
				let isBookmarked = $(this).hasClass('bookmarked'); //북마크 여부 확인
				$(this).attr('data-bookmarked', isBookmarked); //북마크 상태를 데이터 속성에 반영
			});

 			$("#searchButton").on('click', function() {
				var inputText = $("#searchInput").val();
				fetchData(inputText); //입력한 검색어를 fetchData 함수에 전달
			}); 
			
		});

		
		function fetchData(inputText) {
			// AJAX 요청 보내기
			$.ajax({
				url : '/genre',
				type : 'GET',
				data : {
					searchText : inputText,
				},
				success : function(data) {
					console.log('AJAX 요청 성공 !!!');
				},
				error : function(xhr, status, error) {
					console.error('AJAX 요청 실패 ??? : ' + status + " " + error);
				}
			});
		}
	</script>