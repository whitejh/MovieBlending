package com.conan.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.conan.domain.Favorite;
import com.conan.domain.Review;
import com.conan.domain.User;
import com.conan.mapper.UserMapper;

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
	
	public String login(String userID, String userPassword) {
		log.info("login...");
		User user = mapper.login(userID);
		if(user.getUserPassword().equals(userPassword)) {
			return user.getUserID();
		}
		return null;
	}
	
	public void join(User user) {
		log.info("join...");
		mapper.join(user);
	}
	
	public User getAccount(String userID) {
		log.info("getAccount");
		return mapper.getAccount(userID);
	}
	
	public List<Review> getMyReviews(String userID) {
		log.info("getMyReviews...");
		return mapper.getMyReviews(userID);
	}
	
	
	public List<Favorite> getMyFavorites(String userID) {
		log.info("getMyFavorites...");
		return mapper.getMyFavorites(userID);
	}
	
	public void deleteUser(String userID) {
		log.info("회원 탈퇴...");
		mapper.deleteUser(userID);
	}
}