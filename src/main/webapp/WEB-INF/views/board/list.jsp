<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>4/11 스프링 게시판</title>
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

<!-- <script>
$("#regBtn").on("click", function() {
	self.location = "/board/write";
}); // 버튼 클릭시 등록창으로 이동
</script> -->
<script type="text/javascript">
	window.onload = function() {
		$("#regBtn").on("click", function() {
			self.location = "/board/write";
		}); // 버튼 클릭시 등록창으로 이동
	};
</script>
</head>
<body>
	<jsp:include
		page="${pageContext.request.contextPath}/WEB-INF/views/include/header.jsp" />

	<!-- 메인 -->
	<main>
		<section class="notice">
			<!-- Begin Page Content -->
			<div class="container-fluid">

				<!-- Page Heading -->
				<!-- 	<h1 class="h3 mb-2 text-gray-800">Board List Page</h1> -->
				<div class="page-title">
					<h1>영화Talk 게시판</h1>
				</div>


				<!-- DataTales Example -->
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<!-- board seach area -->
						<div id="board-search">
							<div class="container">
								<div class="search-window">
									<form action="">
										<div class="search-wrap">
											<label for="search" class="blind">게시글 검색</label> 
											<select name="searchType">
												<option value = "title">제목</option>
												<option value= "content">내용</option>
												<option value= "title_content">제목+내용</option>
												<option value= "writer">작성자</option>
											</select>
											
											<input
												id="search" type="search" name="" placeholder="검색어를 입력해주세요."
												value="" />
											<button type="submit" class="btn btn-dark">검색</button>
										</div>
									</form>
									<div class="write">
										<button id='regBtn' type="button" class=" write__button" 
											onclick="location.href='/board/write';">
											글쓰기
										</button>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="card-body">
						<div class="table-responsive">
							<table class="table table-hover" width="100%" cellspacing="0">
								<div id="board-list">
									<div class="container">
										<table class="board-table">
											<thead>
												<tr>
													<th class="th-num">번호</th>
													<!-- <th class="th-cate">분류</th> -->
													<th class="th-title">제목</th>
													<th class="th-user">글쓴이</th>
													<th class="th-date">등록일</th>
													<th class="th-view">조회👁️‍🗨️</th>
													<th class="th-like">추천👍</th>
												</tr>
											</thead>
											<c:forEach var="board" items="${bList}">
												<tbody>
													<tr>
														<td class="th-b">${board.boardID}</td>
														<td class="th-b">
															<a href="read?boardID=${board.boardID}">
															${board.boardTitle}
															</a>
														</td>
														<td class="th-b">${board.userID}</td>
														<td class="th-b">
														${fn:substring(board.boardDate,0,11)}${fn:substring(board.boardDate,11,13)}:${fn:substring(board.boardDate,14,16)}
														</td>
														<td class="th-b">${board.boardView}</td>
														<td class="th-b">${board.boardLike}</td>
													</tr>
												</tbody>
											</c:forEach>
										</table>
									</div>
							</table>

							<!-- Modal -->
							<div class="modal" id="myModal" tabindex="-1" role="dialog">
								<div class="modal-dialog" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title">Modal title</h5>
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<div class="modal-body">
											<p>Modal body text goes here.</p>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-primary">Save
												changes</button>
											<button type="button" class="btn btn-secondary"
												data-dismiss="modal">Close</button>
										</div>
									</div>
								</div>
							</div>
							<!-- Modal -->

						</div>
					</div>
				</div>

			</div>
			<!-- /.container-fluid -->
		</section>
	</main>


	<jsp:include
		page="${pageContext.request.contextPath}/WEB-INF/views/include/footer.jsp" />

	<script>
		$(document).ready(
				function() {
					let result = '<c:out value = "${result}"/>';
					console.log('result : ', result);
					
					if(!(result==' ') && parseInt(result) > 0) {
						alert(parseInt(result) + "번 게시글이 등록되었습니다!");
					}
					else if(result=="modify"){
						alert("게시글이 수정되었습니다!");
					}
					else if(result=="remove"){
						alert("게시글이 삭제되었습니다!");
					}

		}); // document ready 끝
	</script>
</body>
</html>