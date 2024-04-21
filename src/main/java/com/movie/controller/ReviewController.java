package com.movie.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.movie.domain.Favorite;
import com.movie.domain.Review;
import com.movie.service.ReviewService;
import com.movie.service.UserService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/movie")
@AllArgsConstructor
public class ReviewController {
	private ReviewService reviewservice;
	private UserService userservice;
	
	@GetMapping("/movieDetail")
	public String getMovie(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userID");
		
		/* 영화 상세페이지 db출력 */
		String movieCd = request.getParameter("movieCd");
		log.info("getMovieDetail : " + movieCd);
		
		if(userId != null) {
			model.addAttribute("movie", reviewservice.getUserMovieDetail(movieCd));
		}else {
			model.addAttribute("movie", reviewservice.getMovieDetail(movieCd));
		}
		
		/*상세페이지 평균 평점 출력*/
		model.addAttribute("avgRate", reviewservice.getAvgRate(movieCd));
		log.info("getAvgRate : " + reviewservice.getAvgRate(movieCd));
		
		/* 영화 유저 닉네임 출력 */
		
		model.addAttribute("user", userservice.getAccount(userId));
		

		/* 해당영화 관람평 출력 */
		model.addAttribute("reviews", reviewservice.getMovieReviews(movieCd));

		return "movie/movieDetail";
	}

	
	/* 영화 관람평 작성 */
	@PostMapping("/writeReview")
    public String writeReview(Model model, HttpServletRequest request, HttpSession session) {
        // 세션에서 현재 사용자의 ID와 닉네임 가져오기
        String userID = (String) session.getAttribute("userID");

        // 요청 파라미터에서 필요한 값들을 가져옴
        String movieCd = request.getParameter("movieCd");
        Double rate = Double.parseDouble(request.getParameter("rate"));
        String content = request.getParameter("content");
        String movieNm = request.getParameter("movieNm");
        String imgUrl = request.getParameter("imgUrl");
        String userNickname = request.getParameter("userNickname");

        // Review 객체 생성
        Review review = new Review();
        review.setUserID(userID);
        review.setUserNickname(userNickname);
        review.setMovieCd(movieCd);
        review.setMovieNm(movieNm);
        review.setRate(rate);
        review.setContent(content);
        review.setImgUrl(imgUrl);

        // ReviewService를 통해 관람평 작성 메서드 호출
        reviewservice.write(review);

        return "redirect:/movie/movieDetail?movieCd="+movieCd;
    }
	
	/* 즐겨찾기 */
	@PostMapping("/favorite")
	public String favorite(Model model, HttpServletRequest request, HttpSession session) {
		String movieCd = request.getParameter("movieCd");
		String userID = (String) session.getAttribute("userID");
        String movieNm = request.getParameter("movieNm");
        Double rate = Double.parseDouble(request.getParameter("rate"));
        String imgUrl = request.getParameter("imgUrl");
		
		// favorite 객체 생성
		Favorite favorite = new Favorite();
		favorite.setMovieCd(movieCd);
		favorite.setUserID(userID);
		favorite.setMovieNm(movieNm);
		favorite.setRate(rate);
		favorite.setImgUrl(imgUrl);
		
		reviewservice.getFavorite(favorite);
		
		return "redirect:/movie/movieDetail?movieCd="+movieCd;
	}
}
