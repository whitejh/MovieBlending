package com.conan.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.conan.domain.Board;
import com.conan.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BoardService {
	@Setter(onMethod_ = { @Autowired })
	private BoardMapper mapper;
	
	public List<Board> getList() {
		log.info("getList.............");
		return mapper.getList();
	}
	
	public void write(Board board) {
		log.info("write.... " + board.getBno());
		mapper.insertSelectKey(board);
	}
	
	public Board read(Integer bno) {
		log.info("get.... " + bno);
		return mapper.read(bno);
	}
	
	public boolean modify(Board board) {
		log.info("modify.... " + board);
		return mapper.update(board)==1; // 수정 성공
	}
	
	public boolean remove(Integer bno) {
		log.info("remove.... " + bno);
		return mapper.delete(bno)==1; // 삭제 성공
	}
	
	
}
