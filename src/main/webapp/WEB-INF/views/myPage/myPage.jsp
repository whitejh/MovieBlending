<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/myPage.css" />
<script src="https://kit.fontawesome.com/87f959d9dc.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
	crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
	<!-- Header-->
	<jsp:include
		page="${pageContext.request.contextPath}/WEB-INF/views/include/header.jsp" />

	<div class="wrapper">
		<main>
			<div class="left">
			 <h1 class="myTitle">마이페이지</h1>
				<a class="myMenu" href="/myPage" style="text-decoration: underline;">사용자 정보<i class="fa-regular fa-greater-than"></i></a><br> 
				<a class="myMenu" href="/myPage/Review">작성한 리뷰<i class="fa-regular fa-greater-than"></i></a><br>
				<a class="myMenu" href="/myPage/Favorite">즐겨찾기<i class="fa-regular fa-greater-than"></i></a>
			</div>
			<span class = mTitle><h1 class="mText">사용자 정보</h1></span><hr>
			<div class="middle">
				<p class="user_info_name">아이디</p>
				<p class="user_info_name">비밀번호</p>
				<p class="user_info_name">이름</p>
				<p class="user_info_name">닉네임</p>
				<p class="user_info_name">이메일</p>
				<p class="user_info_name">가입날짜</p>
			</div>

			<div class="right">
				<p class="user_info">${user.userID}</p>
				<p class="user_info">${user.userPassword}</p>
				<p class="user_info">${user.userName}</p>
				<p class="user_info">${user.userNickname}</p>
				<p class="user_info">${user.userEmail}</p>
				<p class="user_info">${user.regDate}</p>
			</div>

			<div class="withdrawal">
				<button type="submit" class="btn btn-danger" onclick="location.href='myPage/withdrawal'">회원
					탈퇴</button>
			</div>
		</main>
	</div>

</html>