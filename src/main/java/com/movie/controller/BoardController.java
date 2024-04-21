package com.movie.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.movie.domain.Board;
import com.movie.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor // 
@RequestMapping("/board/*")

public class BoardController {
	private BoardService service;

	@GetMapping("/list")
	public void list(Model model) {
		log.info("list");
		model.addAttribute("bList", service.getList());
	}

	@PostMapping("/write") // 게시글 저장
	public String register(Board board, RedirectAttributes rttr) {
		log.info("write : " + board);
		service.write(board);
		rttr.addFlashAttribute("result", board.getBno());
		return "redirect:/board/list";
	}
	
	@GetMapping("/write") // 
	public void write() {

	}

	@GetMapping("/read")
	public void read(@RequestParam("bno") Integer bno, Model model) {
		log.info("/read");
		model.addAttribute("board", service.read(bno));
	}

	@PostMapping("/modify")
	public String modify(Board board, RedirectAttributes rttr) {
		log.info("modify : " + board);
		if (service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list";
	}

	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Integer bno, RedirectAttributes rttr) {
		log.info("remove....... : " + bno);
		if (service.remove(bno)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list";
	}
	

	
}
