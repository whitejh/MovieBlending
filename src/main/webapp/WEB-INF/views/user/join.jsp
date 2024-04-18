<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Movie Blending 웹사이트</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/login.css" />
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css?after" /> --%>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>

<script>
	
</script>
</head>
<body>
	<jsp:include
		page="${pageContext.request.contextPath}/WEB-INF/views/include/header.jsp" />

	<div class="login-wrap">
		<div class="login-html">
			<input id="tab-2" type="radio" name="tab" class="sign-up" checked>
			<label for="tab-2" class="tab" style="cursor: pointer">회원가입</label>

			<!-- 로그인 -->
			<div class="login-form">
				<div class="sign-in-htm">
					<form method="post" action="/login">
						<div class="group">
							<label for="user" class="label">ID</label> <input id="user"
								type="text" class="input" name="userID">
						</div>
						<div class="group">
							<label for="pass" class="label">Password</label> <input id="pass"
								type="password" class="input" data-type="password"
								name="userPassword">
						</div>
						<div class="group">
							<input id="check" type="checkbox" class="check" checked>
							<label for="check"><span class="icon"></span> 아이디 저장하기</label>
						</div>
						<div class="group">
							<input type="submit" class="button" value="Sign In"
								style="cursor: pointer">
						</div>
					</form>
					<div class="hr"></div>
					<div class="foot-lnk">
						<a href="#forgot">Forgot Password?</a>
					</div>
				</div>

				<!-- 회원가입 -->
				<div class="sign-up-htm">
					<form method="post" action="/join">
						<div class="group">
							<label for="id" class="label">UserID</label> <input id="id"
								type="text" class="input" name="userID">
						</div>
						<div class="group">
							<label for="pass" class="label">Password</label> <input id="pass"
								type="password" class="input" data-type="password"
								name="userPassword">
						</div>
						<div class="group">
							<label for="username" class="label">Username</label> <input
								id="username" type="text" class="input" name="userName">
						</div>
						<div class="group">
							<label for="nickname" class="label">Nickname</label> <input
								id="nickname" type="text" class="input" name="userNickname">
						</div>
						<div class="group">
							<label for="email" class="label">Email</label> <input id="email"
								type="email" class="input" name="userEmail">
						</div>
						<div class="hr"></div>
						<div class="group">
							<input type="submit" class="button" value="Sign Up"
								style="cursor: pointer">
						</div>
					</form>

					<!-- 					<div class="foot-lnk">
						<label for="tab-1" style="cursor: pointer">Already Member?</label>
					</div> -->

				</div>
			</div>
		</div>
	</div>
	
		<jsp:include
		page="${pageContext.request.contextPath}/WEB-INF/views/include/footer.jsp" />
</body>
</html>