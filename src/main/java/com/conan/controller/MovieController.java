package com.conan.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/movie/*")
public class MovieController {
	
	
	@GetMapping("/boxOffice")
	public String login() {	
		return "movie/boxOffice";
	}
	

}
