<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/board.css" />
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
	<jsp:include
		page="${pageContext.request.contextPath}/WEB-INF/views/include/header.jsp" />
	<!-- 메인 -->
	<main>
		<section class="notice">
			<div class="page-title">
				<div class="container">
					<!-- <h1>영화Talk 상세페이지</h1> -->
				</div>
			</div>

			<div class="container">
				<div class=row>
					<table class="table table-striped" style="text-align: center;"
						border: 1px solid #dddddd>
						<thead>
							<tr>
								<th colspan="3"
									style="background-color: #eeeeee; text-align: center;">게시판
									글보기</th>
							<tr>
						</thead>
						<tbody>
							<tr>
								<td style="width: 20%;">글 제목</td>
								<td colspan="2">${board.getBoardTitle()}</td>
							</tr>
							<tr>
								<td>작성자</td>
								<td colspan="2">${board.getUserID()}</td>
							</tr>
							<tr>
								<td>작성일자</td>
								<td colspan="2">${fn:substring(board.boardDate,0,11)}${fn:substring(board.boardDate,11,13)}:${fn:substring(board.boardDate,14,16)}</td>
							</tr>
							<tr>
								<td>추천👍</td>
								<td colspan="2">${board.getBoardLike()}</td>
							</tr>
							<tr>
								<td>조회💬</td>
								<td colspan="2">${board.getBoardView()}</td>
							</tr>
							<tr>
								<td>내용</td>
								<td colspan="2"
									style="display: block; min-height: 200px; text-align: left;">
									${board.getBoardContent()}</td>
							</tr>
							<tr>
								<td colspan="2"><a href="/board/list"
									class="btn btn-primary">목록</a> <a
									onclick="return confirm('추천하시겠습니까?')"
									href="/board/like?boardID=${board.boardID}"
									class="btn btn-success pull-right">👍${board.getBoardLike()}</a>

									<c:if
										test="${user.userID != null && user.userID.equals(board.getUserID()) }">
										<a onclick="return confirm('글 수정하시겠습니까?')"
											href="/board/modify?boardID=${board.boardID}"
											class="btn btn-warning">수정</a>
										<a onclick="return confirm('정말로 삭제하시겠습니까?')"
											href="/board/delete?boardID=${board.boardID}"
											class="btn btn-danger">삭제</a>
									</c:if></td>
							</tr>
							<tr>
								<th colspan="3"
									style="background-color: #eeeeee; text-align: center;">댓글</th>
							</tr>
							
							<c:if
								test="${user.userID != null}">
								<tr>
									<form method="post" action="/reply/write">
										<td><input type="hidden" name="writer"
											value="${user.userID}"> <input type="hidden"
											name="boardID" value="${board.boardID}"></td>
										<td><textarea rows="5" cols="50" name="content"></textarea>
											<button type="submit" class="btn btn-primary">댓글 작성</button>
										</td>
									</form>
								</tr>
							</c:if>

							<tr>
								<td>작성자 / 작성날짜</td>
								<td colspan="2">댓글 내용</td>
							</tr>
							<c:forEach var="reply" items="${reply}">
								<tr>
									<td>
										<p>${reply.writer}</p>
										<p>
											<fmt:formatDate value="${reply.regDate}"
												pattern="yyyy-MM-dd HH:mm:ss" />
										</p>
									</td>
									<td colspan="2" style="text-align: left;">
										${reply.content} <c:if
											test="${user.userID != null && user.userID.equals(reply.getWriter()) }">
											<div class="replyDelete">
												<a onclick="return confirm('댓글 삭제하시겠습니까?'')"
													class="btn btn-danger"
													href="/reply/delete?replyID=${reply.replyID}&boardID=${reply.boardID}">삭제</a>
											</div>
										</c:if>
									</td>
								<tr>
							</c:forEach>
						</tbody>
					</table>

				</div>
			</div>
		</section>
	</main>
	<jsp:include
		page="${pageContext.request.contextPath}/WEB-INF/views/include/footer.jsp" />
</body>
<script>
	<script>
	$(document).ready(function() {
		let result = '<c:out value = "${result}"/>';
		console.log('result : ', result);

		if (result == "modify") {
			alert("게시글이 수정되었습니다!");
		}

	}); // document ready 끝
</script>

</script>
</html>