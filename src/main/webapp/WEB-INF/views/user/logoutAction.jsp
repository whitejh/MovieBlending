<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Movie Blending 웹사이트</title>
</head>
<body>
	<%
	session.invalidate(); /* 로그아웃 */
	%>
	<script>
		location.href = 'login.jsp';
	</script>
</body>
</html>