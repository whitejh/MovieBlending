<!-- 로그인 시도 처리하는 페이지  -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<!-- 현재 페이지 안에서만 회원정보 클래스 User를 자바빈즈로 사용-->
<jsp:setProperty name="user" property="userID" />
<!-- 로그인 페이지에서 넘어온 정보 -->
<jsp:setProperty name="user" property="userPassword" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Movie Blending 웹사이트</title>
</head>
<body>
	<%
	// 접속한 회원 세션 관리
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인이 되어있습니다.')");
		script.println("location.href = '${pageContext.request.contextPath}/WEB-INF/views/movie/boxOffice.jsp'");
		script.println("</script>");
	}

	// 로그인 시도
	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(user.getUserID(), user.getUserPassword());

	if (result == 1) { // 로그인 성공
		session.setAttribute("userID", user.getUserID()); // 사용자 아이디를 세션에 저장
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = '${pageContext.request.contextPath}/WEB-INF/views/movie/boxOffice.jsp'"); // 로그인 성공, 메인페이지(박스오피스)로 이동
		script.println("</script>");
	} else if (result == 0) { // 로그인 실패 (비밀번호 불일치)
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다!')");
		script.println("history.back()"); // 이전(로그인) 페이지로 돌아감
		script.println("</script>");
	} else if (result == -1) { // 로그인 실패 (아이디 없음)
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디입니다!')");
		script.println("history.back()");
		script.println("</script>");
	} else if (result == -2) { // DB 오류
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류가 발생했습니다!')");
		script.println("history.back()");
		script.println("</script>");
	}
	%>
</body>
</html>