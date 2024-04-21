package com.movie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movie.domain.Favorite;
import com.movie.domain.Review;
import com.movie.domain.User;
import com.movie.mapper.UserMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class UserService {
	@Setter(onMethod_ = { @Autowired })
	private UserMapper mapper;
	
	public String getDate() {
		log.info("getDate...");
		return mapper.getDate();
	}
	
	public User login(User user) {
		log.info("login...");
		return mapper.login(user);
	}
	
	public void join(User user) {
		log.info("join...");
		mapper.join(user);
	}
	
	public User getAccount(String userID) {
		log.info("getAccount");
		return mapper.getAccount(userID);
	}
	
	public void withdrawal(User user) {
		log.info("회원 탈퇴..." + user);
		mapper.withdrawal(user);
	}
	
	public List<Review> getMyReviews(String userID) {
		log.info("getMyReviews...");
		return mapper.getMyReviews(userID);
	}
	
	
	public List<Favorite> getMyFavorites(String userID) {
		log.info("getMyFavorites...");
		return mapper.getMyFavorites(userID);
	}
	
	/* 리뷰 삭제 */
	public int deleteReview(int reviewID) {
		log.info("delete...." + reviewID);
		return mapper.deleteReview(reviewID);
	}
}