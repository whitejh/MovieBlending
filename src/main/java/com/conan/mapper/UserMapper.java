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
	public User getAccount(String userID);
	public List<Review> getReviews(String userID);
	public List<Favorite> getFavorites(String userID);
	

}
