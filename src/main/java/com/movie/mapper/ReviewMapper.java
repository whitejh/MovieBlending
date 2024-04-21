package com.movie.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.movie.domain.Favorite;
import com.movie.domain.Movie;
import com.movie.domain.Review;

public interface ReviewMapper {
	
	/* 관람평 db 저장 */
	public int write(Review review);

	/* 상세페이지 관람평 출력 */
	public List<Review> getMovieReviews(String movieCd);

	/* 비회원 상세페이지 movie db 출력 */
	public Movie getMovieDetail(String movieCd);
	
	/* 회원 상세페이지 movie db 출력 */
	public Movie getUserMovieDetail(String movieCd);
	
	/*상세페이지 평균 평점 출력*/
	public double getAvgRate(@Param("movieCd") String movieCd);
	
	/* 즐겨찾기 추가 */
	public int getFavorite(Favorite favorite);
	
	/*즐겨찾기 업뎃*/
	public int getFavoriteUpdate(String userID, String MovieCd);
}
