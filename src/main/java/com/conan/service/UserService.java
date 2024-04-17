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
	
	public List<Review> getReviews(String userID) {
		log.info("getReviews...");
		return mapper.getReviews(userID);
	}
	
	
	public List<Favorite> getFavorites(String userID) {
		log.info("getFavorites...");
		return mapper.getFavorites(userID);
	}
}
