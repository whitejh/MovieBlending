<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>박스오피스</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boxOffice.css" />
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
	<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/include/header.jsp" />

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
					<li><a href="#" class="boxoffice-btn" data-type="daily">일별
							박스오피스</a></li>
					<li><a href="#" class="boxoffice-btn" data-type="weekly">주간
							박스오피스</a></li>
					<li><a href="#" class="boxoffice-btn" data-type="weekend">주말
							박스오피스</a></li>
				</ul>
			</div>
			<div class="date_range"></div>
			<div class="boxoffice_movie">
				<c:forEach items="${mList}" var="item">
					<div class="card mb-3">
						<div class="card-header">
							<span>${item.rankOldAndNew}</span>
							<div class="numberCircle">${item.rank}</div>
							<button class="bookmark-btn" data-bookmarked="false">&#9734;</button>
						</div>
						<div class="row g-0">
							<div class="col-md-12 text-center">
								<h5 class="card-title">${item.movieNm}</h5>
								<img src="${item.posterUrl}" class="card-img-top"
									alt="${item.movieNm} 이미지">
							</div>
						</div>
						<div class="card-body text-center">
							<p class="card-text">개봉일 : ${item.openDt}</p>
							<ul class="list-group list-group-flush">
								<li class="list-group-item">당일 관객수: ${item.audiCnt}명</li>
								<li class="list-group-item">누적관객수: ${item.audiAcc}명</li>
							</ul>
							<a href="movie/movieDetail?movieCd=${item.movieCd}"
								class="btn btn-primary">상세 보기</a>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</main>
	
	<!-- Footer -->
	<footer id="contact" class="section">
		<div class="max-container">
			<h2 class="title">세미 프로젝트 3팀</h2>
			<!-- <p class="description">세미 프로젝트 3팀</p> -->
			<ul class="contact__links">
				<li><a class="contact__link"
					href="https://www.instagram.com/netflixkr/" title="netflixkr link"
					target="_blank"> <i class="fa-brands fa-instagram"></i>
				</a></li>
				<li><a class="contact__link"
					href="https://www.instagram.com/disneypluskr/"
					title="disneypluskr link" target="_blank"> <i
						class="fa-brands fa-instagram"></i>
				</a></li>
			</ul>
			<p>©BlackLight - All rights reserved</p>
		</div>
	</footer>

	<script>
    $(document).ready(function () {	//페이지 로드 후 실행될 함수     	
    	let result = $(".boxoffice_movie");
        let dateRange = $(".date_range");
        let yesterdayDate;
      
        //어제의 날짜를 계산
        let d = new Date();
		d.setDate(d.getDate() -1);	//-1이면 하루전, +1이면 내일
		let year = d.getFullYear();
		let month = ('0' + (d.getMonth() + 1)).slice(-2);
		let day = ('0' + d.getDate()).slice(-2);
		yesterdayDate = year + "-" + month + "-" + day;
        
        //어제의 날짜를 datepicker에 표시
        $('#datepicker').val(yesterdayDate);
        
        //Datepicker 설정
        $('#datepicker').datepicker({
            format: 'yyyy-mm-dd',
            autoclose: true,
            todayHighlight: true,
        });
        
        let type = "daily";
        fetchFirstData(yesterdayDate, type);	//초기 화면 설정(버튼 클릭 없이 나오게)

        //박스오피스 버튼 클릭 시 해당 타입의 데이터 조회
        $('.boxoffice_name ul li a').on('click', function () {
        	result.empty();
        	dateRange.empty();
        	$('.boxoffice_name ul li a').removeClass('active');
            $(this).addClass('active');
            let type = $(this).data('type');
            let selectedDate = $('#datepicker').val(); //선택한 날짜 가져오기
            updateNewData(selectedDate, type); //선택한 날짜와 타입을 fetchData 함수에 전달
        });    
        
        //페이지 로드 시 자동으로 일별 박스오피스 버튼 클릭
        $('.boxoffice-btn[data-type="daily"]').click();
        
        //btn-primary 버튼 클릭 이벤트 함수(상세보기)
        $(document).on('click', '.btn-primary', function() {
            let cardElement = $(this).closest('.card');
            let posterUrl = cardElement.find('img').attr('src');	//카드 안에 있는 이미지 src 속성값
            sessionStorage.removeItem("posterUrl");					//이전 포스터 세션 초기화
            sessionStorage.setItem("posterUrl", posterUrl);			//포스터 이미지 세션 저장
        });
        
     	//별 아이콘 클릭 시 색 채우기
        $('.bookmark-btn').click(function () {
            $(this).toggleClass('bookmarked'); //색상 클래스 토글
            let isBookmarked = $(this).hasClass('bookmarked'); //북마크 여부 확인
            $(this).attr('data-bookmarked', isBookmarked);	//북마크 상태를 데이터 속성에 반영
        });
    });
    
    //페이지 로드 시 초기 데이터 화면에 출력
    function fetchFirstData(selectedDate, type) {
        // AJAX 요청 보내기
        $.ajax({
            url: 'http://localhost:9090/boxOffice',
            type: 'GET',
            data: {
                selectedDate: selectedDate,
                type: type
            },
            success: function(data) {
                console.log('AJAX 요청 성공 !!!');
            },
            error: function (xhr, status, error) {
                console.error('AJAX 요청 실패 ??? : ' + status + " " + error);
            }
        }); 
    }
    
    //버튼 클릭 후 새로운 데이터 화면에 출력
    function updateNewData(selectedDate, type) {
        // AJAX 요청 보내기
        $.getJSON({
            url: 'http://localhost:8080/boxOffice1.json',
            type: 'GET',
            data: {
                selectedDate: selectedDate,
                type: type
            },
            success: function(data) {
            	updateCardData(data, type);
                console.log('AJAX 요청 성공 !!! ', data);
            },
            error: function (xhr, status, error) {
                console.error('AJAX 요청 실패 ??? : ' + status + " " + error);
            }
        }); 
    }
     
	//데이터 출력 함수(카드에다 출력)
	function updateCardData(data, type) {
         console.log('업데이트된 data : ' + data);
         $.each(data, function (index, item) {       	
         	let cardHtml =
    	        '<div class="card mb-3">' +
    	        '<div class="card-header">' +
    	        '<span>' + item.rankOldAndNew + '</span>' +
    	        '<div class="numberCircle">' + item.rank + '</div>' +
    	        '<button class="bookmark-btn" data-bookmarked="false"><i class="fa-solid fa-star"></i></button>' +
    	        '</div>' +
    	        '<div class="row g-0">' +
    	        '<div class="col-md-12 text-center">' +
    	        '<h5 class="card-title">' + item.movieNm + '</h5>' +
    	        '<img src="' + item.posterUrl + '" class="card-img-top" alt="' + item.movieNm + ' 이미지">' +
    	        '</div>' +
    	        '</div>' +
    	        '<div class="card-body text-center">' +
    	        '<p class="card-text">개봉일 : ' + item.openDt + '</p>' +
    	        '<ul class="list-group list-group-flush">' +
    	        '<li class="list-group-item">당일 관객수: ' + item.audiCnt + '명</li>' +
    	        '<li class="list-group-item">누적관객수: ' + item.audiAcc + '명</li>' +
    	        '</ul>' +
    	        '<a href="movie/movieDetail?movieCd=' + item.movieCd + '" class="btn btn-primary">상세 보기</a>' +
    	        '</div>' +
    	        '</div>';
    	        $(".boxoffice_movie").append(cardHtml);
         });
	}

    </script>

</body>
</html>