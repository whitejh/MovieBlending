package com.conan.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.conan.domain.Movie;
import com.conan.service.MovieService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor 
/* @RequestMapping("/movie/*") */
public class MovieController {
	@Autowired
	private MovieService service;
	
	@GetMapping("/boxOffice")	//박스오피스 페이지
    public String viewBoxOffice(@RequestParam(required = false) String selectedDate,
            @RequestParam(required = false) String type, Model model) {
		//맨 처음 페이지 로드할 때 파라미터 값이 둘다 null일 때 기본값 설정
        if (selectedDate == null && type == null) {
            selectedDate = getYesterdayDate();
            type = "daily";
        }
        log.info("전달받은 두 값: " + selectedDate + " 그리고 " + type);
        try {
            List<Movie> mList = service.fetchBoxOfficeData(selectedDate, type);
            model.addAttribute("mList", mList);	//프론트에 쓸 mList 세팅
        } catch (IOException e) {
            e.printStackTrace();	// 예외 처리
        }
        return "movie/boxOffice";
    }	
	
	//어제 날짜 가져오는 함수
	private String getYesterdayDate() {
		Calendar calendar = new GregorianCalendar();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		calendar.add(Calendar.DATE, -1);		
		String yesterDayDate = sdf.format(calendar.getTime());
		
		return yesterDayDate;
	}

}
