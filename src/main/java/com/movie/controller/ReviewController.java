package com.movie.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.movie.domain.Review;
import com.movie.domain.User;
import com.movie.service.ReviewService;
import com.movie.service.UserService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/movie")
@AllArgsConstructor
public class ReviewController {
	private ReviewService reviewservice;
	private UserService userservice;
	
	@GetMapping("/movieDetail")
	public String getMovie(Model model, HttpServletRequest request) {
		/* 영화 상세페이지 db출력 */
		String movieCd = request.getParameter("movieCd");
		log.info("getMovieDetail : " + movieCd);
		model.addAttribute("movie", reviewservice.getMovieDetail(movieCd));
		
		/*상세페이지 평균 평점 출력*/
		model.addAttribute("avgRate", reviewservice.getAvgRate(movieCd));
		log.info("getAvgRate : " + reviewservice.getAvgRate(movieCd));
		
		/* 영화 유저 닉네임 출력 */
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user"); // 수정
		model.addAttribute("user", userservice.getAccount(user)); // 수정
		
		/* 해당영화 관람평 출력 */
		model.addAttribute("reviews", reviewservice.getMovieReviews(movieCd));

		return "movie/movieDetail";
	}

	
	/* 영화 관람평 작성 */
	@PostMapping("/writeReview")
    public String writeReview(Model model, HttpServletRequest request, HttpSession session){
        // 세션에서 현재 사용자의 ID와 닉네임 가져오기
		User user = (User) session.getAttribute("user"); // 수정 성공
		
        // 요청 파라미터에서 필요한 값들을 가져옴
        String movieCd = request.getParameter("movieCd");
        Double rate = Double.parseDouble(request.getParameter("rate"));
        String content = request.getParameter("content");
        String movieNm = request.getParameter("movieNm");
        String imgUrl = request.getParameter("imgUrl");
        String userNickname = request.getParameter("userNickname");
        
		/*
		 * String regDate = request.getParameter("regDate"); SimpleDateFormat sdf = new
		 * SimpleDateFormat("yyyy-MM-dd"); Date reviewDate = sdf.parse(regDate);
		 */

        // Review 객체 생성
        Review review = new Review();
        review.setUserID(user.getUserID()); // 수정
        review.setUserNickname(userNickname);
        review.setMovieCd(movieCd);
        review.setMovieNm(movieNm);
        review.setRate(rate);
        review.setContent(content);
        review.setImgUrl(imgUrl);
        //review.setRegDate(reviewDate);

        // ReviewService를 통해 관람평 작성 메서드 호출
        reviewservice.write(review);

        return "redirect:/movie/movieDetail?movieCd="+movieCd;
    }
	
	
}
