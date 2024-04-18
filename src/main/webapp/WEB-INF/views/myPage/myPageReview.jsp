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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myPage.css" />
<script src="https://kit.fontawesome.com/87f959d9dc.js"></script>
<script>
	var newWindow = null;
	function openNewWindow() {
		if (newWindow && !newWindow.closed) {
			newWindow.focus(); // 이미 열린 새 창을 포커스합니다.
		} else {
			newWindow = window.open("myPageReviewSub.jsp", "",
					"width=600,height=800");
		}
	}
</script>
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/include/header.jsp" />
		
	<main>
		<div class="left">
			<a class="myMenu" href="/myPage">사용자 정보</a><br> <a
				class="myMenu" href="/myPage/Review"
				style="text-decoration: underline;">작성한 리뷰</a><br> <a
				class="myMenu" href="/myPage/Favorite">즐겨찾기</a>
		</div>
		<c:forEach var="review" items="${reviews}">
			<div class="reviewBox">
				<img class="posterImg" src="${review.imgUrl}" width="200px"> <img
					class="xmark" src="${pageContext.request.contextPath}/resources/images/xmark@2x.png"> <input
					class="reviewUpdate" type="submit" onclick="openNewWindow()"
					value="내용 수정"> <span class="movieName">${review.movieNm}</span><br>
				<div class="starBox">
					<img class="star" src="${pageContext.request.contextPath}/resources/images/star.fill@2x.png"> 
					<img class="star" src="${pageContext.request.contextPath}/resources/images/star.fill@2x.png"> 
					<img class="star" src="${pageContext.request.contextPath}/resources/images/star.fill@2x.png"> 
					<img class="star" src="${pageContext.request.contextPath}/resources/images/star.fill@2x.png"> 
					<img class="star" src="${pageContext.request.contextPath}/resources/images/star.fill@2x.png"> 
 					<span class="movieRate">&nbsp;${review.rate} / 10.0</span><br>
				</div>
				<span class="reviewDes">${review.content}</span>
			</div>
		</c:forEach>
	</main>
	
	<aside>
    	<a class="arrow-up" title="back to top" onclick="window.scrollTo(0,0);">
       	<i class="fa-solid fa-arrow-up"></i></a>
    </aside>


</body>
</html>