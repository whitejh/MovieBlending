package com.conan.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.conan.domain.Movie;
import com.conan.domain.Review;
import com.conan.mapper.ReviewMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ReviewService {
	@Setter(onMethod_ = @Autowired)
	private ReviewMapper mapper;

	/* 관람평 db 저장 */
	public int write(Review review) {
		log.info("register...." + review);
		return mapper.write(review);
	}

	/* 상세페이지 관람평 출력 */
	public List<Review> getMovieReviews(String movieCD) {
		log.info("get.. ..." + movieCD);
		return mapper.getMovieReviews(movieCD);
	}

	/* 상세페이지 movie db 출력 */
	public Movie getMovie(String movieCd) {
		log.info("get.. ..." + movieCd);
		return mapper.getMovie(movieCd);
	}

}
