<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>

<%-- <%@ page import="movie.Movie_kmdbDAO"%>
<%@ page import="movie.Movie_kobisDAO"%> --%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>박스오피스</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/boxOffice.css" />
<script src="https://kit.fontawesome.com/87f959d9dc.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<style type="text/css">
a, a:hover {
	color: white;
	text-decoration: none;
}
</style>

</head>
<body>
	<jsp:include
		page="${pageContext.request.contextPath}/WEB-INF/views/include/header.jsp" />

	<main>
		<div class="datepicker-container">
			<div class="datepicker-btn-group">
				<input type="text" id="datepicker" class="form-control"
					placeholder="날짜 선택">
			</div>
		</div>
		<div class="boxoffice">
			<div class="boxoffice_name">
				<ul>
					<li><a href="#" class="boxoffice-btn active" data-type="daily">일별
							박스오피스</a></li>
					<li><a href="#" class="boxoffice-btn" data-type="weekly">주간
							박스오피스</a></li>
					<li><a href="#" class="boxoffice-btn" data-type="weekend">주말
							박스오피스</a></li>
				</ul>
			</div>
			<div class="date_range"></div>
			<div class="boxoffice_movie"></div>
		</div>
	</main>

	<jsp:include
		page="${pageContext.request.contextPath}/WEB-INF/views/include/footer.jsp" />



	<script>
		$(document)
				.ready(
						function() { //페이지 로드 후 실행될 함수
							let result = $(".boxoffice_movie");
							let dateRange = $(".date_range");

							//어제의 날짜를 계산
							let d = new Date();
							d.setDate(d.getDate() - 1); //-1이면 하루전, +1이면 내일
							let year = d.getFullYear();
							let month = ('0' + (d.getMonth() + 1)).slice(-2);
							let day = ('0' + d.getDate()).slice(-2);
							yesterdayDate = year + "-" + month + "-" + day;

							//어제의 날짜를 datepicker에 표시
							$('#datepicker').val(yesterdayDate);

							//Datepicker 설정
							$('#datepicker').datepicker({
								format : 'yyyy-mm-dd',
								autoclose : true,
								todayHighlight : true,
							});

							//박스오피스 버튼 클릭 시 해당 타입의 데이터 조회
							$('.boxoffice_name ul li a').on(
									'click',
									function() {
										$('.boxoffice_name ul li a')
												.removeClass('active');
										$(this).addClass('active');
										let type = $(this).data('type');
										let selectedDate = $('#datepicker')
												.val(); // 선택한 날짜 가져오기
										fetchData(selectedDate, type); // 선택한 날짜와 타입을 fetchData 함수에 전달
									});

							//페이지 로드 시 자동으로 일별 박스오피스 버튼 클릭
							//이 함수 위치 바뀌면 절대 실행 X
							$('.boxoffice-btn[data-type="daily"]').click();

							//데이터 조회 함수
							function fetchData(selectedDate, type) {
								result.empty(); // 초기화 1.
								dateRange.empty(); // 초기화 2.
								let apiUrl;

								// type(박스오피스 버튼의 data-type)에 따라 url 링크 구분
								switch (type) {
								case 'daily': //일별
									apiUrl = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888";
									break;
								case 'weekly': //주간(weekGb=0)
									apiUrl = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&weekGb=0";
									break;
								case 'weekend': //주말(weekGb=1)
									apiUrl = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&weekGb=1";
									break;
								}

								let targetDt = selectedDate.split('-').join(''); //'2024-03-01'을 '20240301'로 변형
								apiUrl += "&targetDt=" + targetDt; // 변형한 날짜값을 url 파라미터에 추가

								$
										.ajax({
											url : apiUrl,
											method : "GET",
											success : function(data) { //데이터 존재 시,
												//조회한 데이터의 날짜 범위 출력(showRange)
												if (data.boxOfficeResult
														&& data.boxOfficeResult.showRange) {
													dateRange
															.text(data.boxOfficeResult.showRange);
													processData(data, type); //데이터 카드 출력 함수
												} else {
													result
															.text('해당 날짜의 박스오피스 데이터가 아직 없습니다.');
													dateRange.empty();
												}
											},
										});
							}

							//kmdb API에서 영화 포스터 가져오기
							function fetchMoviePoster(movieNm, openDt, movieCd,
									cardElement) {
								//다시 JSON 방식으로(xml로 하면 일부 영화 포스터 안나옴)
								let kmdbApiUrl = "http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&_type=json"
										+ "&ServiceKey=6CO85UB1I0DP2Y32897W"
										+ "&title="
										+ encodeURIComponent(movieNm)
										+ "&releaseDts="
										+ openDt.split('-').join('');

								$
										.ajax({
											url : kmdbApiUrl,
											method : "GET",
											dataType : "json", //응답 데이터 형식을 json으로 지정
											success : function(data) {
												//0번째 => 무조건 첫번째 <posters>의 url만 가져오기
												//만약 기존처럼 모든 posters를 가져온다고 선언하면, 공백 데이터까지 먹어버려 변수가 깨짐
												let posters = data.Data[0].Result[0].posters; //포스터 URL 추출

												//포스터 URL이 존재할 시,
												if (posters) {
													//<posters>안에 url이 여러개 존재하면, "|"로 쪼개서 첫번째 url만 추출
													let posterUrl = posters
															.split("|")[0];
													displayImage(posterUrl,
															movieNm,
															cardElement);

													//서블릿(서버)에 데이터 전송
													//db 테이블에 저장하기 위한 용도
													$
															.ajax({
																type : "POST", //전송 방식
																url : "${pageContext.request.contextPath}/boxOffice/boxOffice.mov", // 서버 URL
																data : { // 왼쪽이 그릇(저장할 파라미터 주소), 오른쪽이 내용물(저장할 실제 값)
																	movieCd : movieCd,
																	movieNm : movieNm,
																	openDt : openDt,
																	posterUrl : posterUrl
																},
																success : function(
																		response) {
																	console
																			.log("데이터 전송 성공");
																},
																error : function(
																		xhr,
																		status,
																		error) {
																	console
																			.error("데이터 전송 실패: "
																					+ error);
																}
															});
												} else {
													console
															.error('영화 포스터 이미지 데이터가 존재하지 않습니다.');
												}
											},
											error : function(jqXHR, textStatus,
													errorThrown) {
												console
														.error('영화 이미지를 가져오는 중 오류가 발생했습니다. 오류: '
																+ textStatus);
											}
										});
							}

							//포스터(스틸컷) 화면 출력
							//imageUrl: 카드에 표시할 이미지의 url
							//altText: 이미지가 안나올 때 나오는 대체 텍스트
							//cardElement: 이미지가 추가될 카드 요소
							function displayImage(imageUrl, altText,
									cardElement) {
								//부트스트랩 카드 코드를 따와서 여기에다 포스터 화면 출력(class="card-img-top")
								let imageHtml = '<img src="' + imageUrl + '" class="card-img-top" alt="' + altText + ' 이미지">';
								$(cardElement).find('.card-title').after(
										imageHtml);
							}

							//데이터 출력 함수(카드에다 출력)
							function processData(data, type) {
								let boxOfficeList;

								//출력할 데이터(boxOfficeList)의 유형을 식별
								if (type === 'daily') {
									boxOfficeList = data.boxOfficeResult.dailyBoxOfficeList; //일별(daily)
								} else if (type === 'weekly'
										|| type === 'weekend') {
									if (data.boxOfficeResult
											&& data.boxOfficeResult.weeklyBoxOfficeList) {
										boxOfficeList = data.boxOfficeResult.weeklyBoxOfficeList; //주간(weekly)
									} else if (data.boxOfficeResult
											&& data.boxOfficeResult.weekendBoxOfficeList) {
										boxOfficeList = data.boxOfficeResult.weekendBoxOfficeList; //주말(weekend)
									} else {
										console
												.error('주간 또는 주말 박스오피스 데이터를 찾을 수 없습니다.'); //데이터 존재 X시,
										return;
									}
								}

								//-------------부트스트랩 카드 나열 함수----------------
								let cardCount = 0;
								$
										.each(
												boxOfficeList,
												function(index, item) {
													let rank = item.rank
													let movieCd = item.movieCd; //특정 영화 상세페이지로 이동할 때 필요한 파라미터
													let movieNm = item.movieNm;
													let openDt = item.openDt;

													if (cardCount < 20) {
														let cardHtml = '<div class="card mb-3">'
																+ '<div class="card-header">'
																+ '<span>'
																+ rank
																+ '</span>'
																+ '<button class="bookmark-btn" data-bookmarked="false"><i class="fa-solid fa-star"></i></button>'
																+ '</div>'
																+ '<div class="row g-0">'
																+ '<div class="col-md-12">'
																+ '<div class="card-body text-center">'
																+ '<h5 class="card-title">'
																+ movieNm
																+ '</h5>'
																+ '<p class="card-text">개봉일 : '
																+ openDt
																+ '</p>'
																+
																//url에 movieCd 파라미터 전달(포스터 이미지는 세션으로 대체)
																'<a href="movieDetail.jsp?movieCd='
																+ movieCd
																+ '" class="btn btn-primary">상세 보기</a>'
																+ '</div>'
																+ '</div>'
																+ '</div>'
																+ '</div>';
														result.append(cardHtml);
														cardCount++;

														//포스터가 들어갈 카드 순서 값 가져오기
														let cardElement = result
																.find('.card')
																.last();
														//순서 맞춰서 카드에 데이터 출력
														fetchMoviePoster(
																movieNm,
																openDt,
																movieCd,
																cardElement);
													}
												});
							}

							//btn-primary 버튼 클릭 이벤트 함수(상세보기)
							$(document).on(
									'click',
									'.btn-primary',
									function() {
										let cardElement = $(this).closest(
												'.card');
										let posterUrl = cardElement.find('img')
												.attr('src'); //카드 안에 있는 이미지 src 속성값
										sessionStorage.removeItem("posterUrl"); //이전 포스터 세션 초기화
										sessionStorage.setItem("posterUrl",
												posterUrl); //포스터 이미지 세션 저장
									});

							//별 아이콘 클릭 시 색 채우기
							$('.bookmark-btn').click(
									function() {
										$(this).toggleClass('bookmarked'); // 색상 클래스 토글
										let isBookmarked = $(this).hasClass(
												'bookmarked'); // 북마크 여부 확인
										$(this).attr('data-bookmarked',
												isBookmarked); // 북마크 상태를 데이터 속성에 반영
									});
						});
	</script>

</body>
</html>