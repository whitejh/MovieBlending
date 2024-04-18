package com.conan.mapper;

import java.util.List;

import com.conan.domain.Movie;
import com.conan.domain.Review;

public interface ReviewMapper {
	
	/* 관람평 db 저장 */
	public int write(Review review);

	/* 상세페이지 관람평 출력 */
	public List<Review> getMovieReviews(String movieCd);

	/* 상세페이지 movie db 출력 */
	public Movie getMovie(String movieCd);
}