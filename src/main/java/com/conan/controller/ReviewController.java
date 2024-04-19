package com.conan.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.conan.domain.Review;
import com.conan.service.ReviewService;
import com.conan.service.UserService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/movie")
@AllArgsConstructor
public class ReviewController {
	private ReviewService reviewservice;
	private UserService userservice;

	
	@PostMapping("/movieDetail")
	public String getMovieDetail(Model model, HttpServletRequest request) {
		/* 영화 상세페이지 db출력 */
		String movieCd = request.getParameter("movieCd");
		log.info("getMovieDetail : " + movieCd);
		model.addAttribute("movie", reviewservice.getMovieDetail(movieCd));
		
		/*상세페이지 평균 평점 출력*/
		model.addAttribute("avgRate", reviewservice.getAvgRate(movieCd));
		
		/* 영화 유저 닉네임 출력 */
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userID");
		model.addAttribute("user", userservice.getAccount(userId));
		
		/* 영화 관람평 작성 */
		
		
		/* 해당영화 관람평 출력 */
		model.addAttribute("reviews", reviewservice.getMovieReviews(movieCd));

		return "movie/movieDetail";
	}

}
