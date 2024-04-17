package com.conan.mapper;
import java.util.List;

import com.conan.domain.Board;

public interface BoardMapper {
	// @Select("select * from board where bno > 0")
	public List<Board> getList();
	public int insert(Board board);
	public int insertSelectKey(Board board);
	public Board read(Integer bno);
	public void increaseHit(Integer bno); 
	public int delete(Integer bno);
	public int update(Board board);
}
