package com.conan.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.conan.domain.User;
import com.conan.service.UserService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
//@RequestMapping("/user/*") // 공통주소
public class UserController {
	private UserService service;

	@GetMapping("/join")
	public String Join() {
		return "user/join";
	}

	@PostMapping("/join")
	public String join(User user) { // body 값을 받을 DTO 필요
		log.info("join :aaa");
//		log.info("join : " + user);
		service.join(user);
		return "redirect:/login";
	}

	@GetMapping("/login") // 로그인 페이지
	public String Login(HttpSession session) {
		String userID = (String) session.getAttribute("userID"); // 세션처리
		if (userID != null) {
			return "redirect:/"; // 로그인 성공, 박스오피스 메인페이지로 이동
		}
		return "/user/login"; // 로그인 되지 않은 상태
	}

	@PostMapping("/login")
	public String login(String userID, String userPassword, HttpSession session) {
		String id = service.login(userID, userPassword);
		if (id == null) { // 로그인실패
			return "redirect:/login";
		}
		session.setAttribute("userID", id);
		return "redirect:/";
	}

	@GetMapping("/logout") // 로그아웃
	public String logout(HttpSession session) {
		session.invalidate(); // 세션에 저장되어있는 값과 세션을 삭제
		return "redirect:/login"; // 로그인 페이지로 이동
	}

	@GetMapping("/myPage")
	public String myPage(HttpSession session, Model model) {
		log.info("Enter myPage: try");
		String userID = (String) session.getAttribute("userID");
		model.addAttribute("user", service.getAccount(userID));
		log.info("Enter myPage: success");
		return "myPage/myPage";
	}

	@GetMapping("/myPage/Review")
	public String Review(HttpSession session, Model model) {
		log.info("Review: try");
		String userID = (String) session.getAttribute("userID");
		model.addAttribute("reviews", service.getMyReviews(userID));
		log.info("Review: success");
		return "myPage/myPageReview";
	}

	@GetMapping("/myPage/Favorite")
	public String Favorite(HttpSession session, Model model) {
		log.info("Favorite: try");
		String userID = (String) session.getAttribute("userID");
		model.addAttribute("favorites", service.getMyFavorites(userID));
		log.info("Favorite: success");
		return "myPage/myPageFavorite";
	}

	// 회원 탈퇴 Get
	@GetMapping("/withdraw")
	public String withdraw(HttpSession session) {
		String userID = (String) session.getAttribute("userID");
		if (userID != null) {
			service.deleteUser(userID);
		}
		session.invalidate();
		return "redirect:/";
	}

	@PostMapping("/withdraw")
	public String withdraw(User user, HttpSession session, RedirectAttributes rttr) {
		log.info("PostMapping /withdraw");
		User member = (User) session.getAttribute("user");

		String userID = member.getUserID();
		String oldPass = member.getUserPassword();
		String newPass = member.getUserPassword();

		if (!(oldPass.equals(newPass))) {
			rttr.addFlashAttribute("msg", false);
			return "redirect:/myPage/withdrawl";
		}

		service.deleteUser(userID);
		session.invalidate();
		rttr.addFlashAttribute("msg", "이용해주셔서 감사합니다.");
		return "redirect:/";
	}

	/*
	 * @GetMapping("/deleteView") public String deleteView() { return
	 * "/myPage/deleteView"; }
	 */

	@PostMapping("/delete")
	public String delete(String userID, RedirectAttributes rttr, HttpSession session) {
		service.deleteUser(userID);
		session.invalidate();
		rttr.addFlashAttribute("msg", "이용해주셔서 감사합니다");
		return "redirect:/login";
	}

	/*
	 * @RequestMapping("/delete") public String deleteUser(String userPassword,
	 * Model model, HttpSession session) { User user = (User)
	 * session.getAttribute("user");
	 * 
	 * if(service.deleteUser(userPassword)) }
	 */
	

	@GetMapping("/deleteReview")
	public String deleteReview(Model model, Integer reviewID) {
		service.deleteReview(reviewID);
		return "redirect:/myPage/Review";
	}
	
	@GetMapping("/myPage/ReviewSub")
	public String ReviewSub(Model model, Integer reviewID) {
		log.info("Review: try");
		model.addAttribute("review", service.getMyReview(reviewID));
		log.info("Review: success" + reviewID);
		return "myPage/myPageReviewSub";
	}

	@GetMapping("/modifyReview")
	public void modifyReview(Model model, Integer reviewID, String content, Double rate) {
		Map<String,Object> map = new HashMap<String,Object>();
		log.info("modifyReview: try" + rate + content);
		map.put("reviewID", reviewID);
		map.put("content", content);
		map.put("rate", rate);
		service.modifyReview(map);
	}
}