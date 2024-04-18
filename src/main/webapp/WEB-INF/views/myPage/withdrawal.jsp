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
</head>
<body>
	<!-- Header-->
	<jsp:include
		page="${pageContext.request.contextPath}/WEB-INF/views/include/header.jsp" />

	<div class="wrapper">
		<main>
			<div class="left">
				<a class="myMenu" href="/myPage" style="text-decoration: underline;">사용자
					정보</a><br> <a class="myMenu" href="/myPage/Review">작성한 리뷰</a><br>
				<a class="myMenu" href="/myPage/Favorite">즐겨찾기</a>
			</div>

			<div class="login-wrap">
				<div class="login-html">
					<input id="tab-1" type="radio" name="tab" class="sign-in" checked>
					<label for="tab-1" class="tab" style="cursor: pointer">회원
						탈퇴</label>


					<!-- 회원탈퇴 -->
					<div class="login-form">
						<div class="sign-in-htm">
							<form method="post" role="form" autocomplete="off">
								<div class="group">
									<label for="user" class="label">ID</label> <input id="user"
										type="text" class="input" name="userID" value="${user.userID}">
								</div>
								<div class="group">
									<label for="pass" class="label">Password</label> <input
										id="pass" type="password" class="input" data-type="password"
										name="userPassword">
								</div>

								<div class="group">
									<input type="submit" class="button" value="회원탈퇴"
										style="cursor: pointer">
								</div>
								<div class="hr"></div>
								<div class="foot-lnk">
									<a href="/myPage">처음으로</a>
								</div>

							</form>
							<c:if test ="${msg == false }">
								<p>입력한 비밀번호가 잘못되었습니다</p>
							</c:if>
						</div>
					</div>
				</div>
			</div>

		</main>
	</div>


	<script>
	
	</script>

</body>
<script>
	
</script>

</html>