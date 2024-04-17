<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>4/11 스프링 게시판</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
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
	<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/include/header.jsp" />
	<!-- Begin Page Content -->
	<div class="container-fluid">

		<!-- Page Heading -->
		<h1 class="h3 mb-2 text-gray-800">Board List Page</h1>
		<p class="mb-4"></p>

		<!-- DataTales Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">게시글</h6>
				<button id='regBtn' type="button" class="btn btn-sm btn-info">글쓰기</button>
			</div>
			<div class="card-body">
				<div class="table-responsive">
					<table class="table table-hover" width="100%" cellspacing="0">

						<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
							</tr>
						</thead>
						<c:forEach items="${bList}" var="board">
							<tbody>
								<tr>
									<td>${board.bno}</td>
									<td><a href="read?bno=${board.bno}">${board.title}</a></td>
									<td>${board.writer}</td>
									<td>${board.regDate}</td>
								</tr>
							</tbody>
						</c:forEach>
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

				</div>
			</div>
		</div>

	</div>
	<!-- /.container-fluid -->

	<jsp:include page="${pageContext.request.contextPath}//WEB-INF/views/include/footer.jsp" />

	<script>
		$(document).ready(
				function() {
					let result = '<c:out value = "${result}"/>';
					console.log('result : ', result);
					checkModal(result);

					function checkModal(result) {
						if (result === '') {
							return;
						}
						if (parseInt(result) > 0) {
							$('.modal-body  > p').text(
									"게시글" + parseInt(result) + "이 등록됨");
						}
						if (result === "modify") {
							$('.modal-body > p').text('수정이 완료됨');
						}
						if (result === "remove") {
							$('.modal-body > p').text('삭제가 완료됨');
						}
						$("#myModal").modal("show");
					} // checkModal()의 끝
				}); // document ready 끝
	</script>

</body>
</html>