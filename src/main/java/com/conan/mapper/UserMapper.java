package com.conan.mapper;
import java.util.List;

import com.conan.domain.Favorite;
import com.conan.domain.Review;
import com.conan.domain.User;

// DAO
public interface UserMapper {
	public String getDate();
	
	public User login(String userID); // 로그인 
	public void join(User user);  // 회원가입
	public User getAccount(String userID);	// 회원 정보
	public List<Review> getMyReviews(String userID);	// 회원 영화 리뷰
	public List<Favorite> getMyFavorites(String userID);	// 회원 영화 즐겨찾기
	public void deleteUser(String userID); // 회원 탈퇴
	/* 리뷰 삭제 */
	public int deleteReview(int reviewID);
}