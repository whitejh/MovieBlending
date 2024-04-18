package com.conan.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.conan.service.ReviewService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/movie")
@AllArgsConstructor
public class ReviewController {
	private ReviewService service;

	/* 상세페이지 movie db 출력 */
	@PostMapping("/movieDetail")
	public String getMovieDetail(Model model, HttpServletRequest request) {
		String movieCd = request.getParameter("movieCd");
		log.info("getMovieDetail : " + movieCd);
		model.addAttribute("movie", service.getMovie(movieCd));
		return "movie/movieDetail";
	}

}
