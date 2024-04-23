package com.movie.mapper;
import java.util.List;

import com.movie.domain.Board;

// DAO
public interface BoardMapper {
	
	public List<Board> getList();						// 게시판 목록
	public List<Board> getListPage(int displayPost, int postNum); // 페이징 처리
	public void insert(Board board);				// 게시글 작성
	public Board read(Integer boardID);			// 게시글 보기
	public void increaseView(Integer boardID); 	// 게시글 조회수 1 증가
	public void increaseLike(Integer boardID); 	// 게시글 조회수 1 증가
	public void delete(Integer boardID);			// 게시글 삭제
	public void update(Board board);				// 게시글 수정
	
	public int count(); // 게시물 총 개수
}