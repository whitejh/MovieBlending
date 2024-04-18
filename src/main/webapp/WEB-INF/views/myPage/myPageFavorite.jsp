<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/myPage.css" />
<script src="https://kit.fontawesome.com/87f959d9dc.js"></script>
</head>

<body>
	<jsp:include
		page="${pageContext.request.contextPath}/WEB-INF/views/include/header.jsp" />

	<main>
		<div class="left">
			<a class="myMenu" href="/myPage">사용자 정보</a><br> 
			<a class="myMenu" href="/myPage/Review">작성한 리뷰</a><br> 
			<a class="myMenu" href="/myPage/Favorite"
				style="text-decoration: underline;">즐겨찾기</a>
		</div>
		<c:forEach var="favorite" items="${favorites}">
			<div class="favoriteBox">
				<img class="favoritImg" src="${favorite.imgUrl}" width="200px"><br>
				<img class="heart" src="../images/heart.fill@2x.png">
				
				<div class="favoriteStarBox">
				</div>

				<span class="favoriteMovieName">${favorite.movieNm}</span><br>
			</div>
		</c:forEach>
	</main>
	
		
	<aside>
    	<a class="arrow-up" title="back to top" onclick="window.scrollTo(0,0);">
       	<i class="fa-solid fa-arrow-up"></i></a>
    </aside>
	
</body>
</html>