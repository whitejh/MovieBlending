package com.conan.controller;


import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.conan.domain.User;
import com.conan.service.UserService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor // 
//@RequestMapping("/user/*") // 공통주소
public class UserController {
	private UserService service;

	@GetMapping("/join")
	public String Join() {
		return "user/joinForm";
	}

	@PostMapping("/join")
	public String join(User user) { // body 값을 받을 DTO 필요
		log.info("join :aaaaaa ");
//		log.info("join : " + user);
		service.join(user);
	return "redirect:/loginForm";
	}

	@GetMapping("/login") // 로그인 페이지
	public String Login(HttpSession session) {
		String userID = (String) session.getAttribute("userID");
		if (userID != null) {
			return "redirect:/"; // 박스오피스 메인페이지로 이동
		}
		return "/user/loginForm"; // 로그인 되지 않은 상태
	}

	@PostMapping("/login")
	public String login(String userID, String userPassword, HttpSession session) {
		String id = service.login(userID, userPassword);
		if (id == null) { // 로그인실패
			return "redirect:/loginForm";
		}
		session.setAttribute("userID", id);
		return "redirect:/";
	}


	@GetMapping("/myPage")
	public String myPage() {
		return "myPage/myPage";
	}

}
