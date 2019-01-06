package com.board.hugh.dao;

import java.util.List;

import com.board.hugh.vo.BoardVO;
import com.board.hugh.vo.SearchCriteria;

public interface BoardDAO {
	// Board 관련
	public void create(BoardVO bVO) throws Exception;
	
	public BoardVO read(int bno) throws Exception;
	
	public List<BoardVO> readAll(SearchCriteria cri) throws Exception;
	
	public int readCount(SearchCriteria cri) throws Exception;
	
	public void update(BoardVO bVO) throws Exception;
	
	public void updateViewcnt(int bno, int cnt) throws Exception;
	
	public void updateReplycnt(int bno, int cnt) throws Exception;
	
	public void updateLikecnt(int bno, int cnt) throws Exception;
	
	public void delete(int bno) throws Exception;
	
	// Attach 관련
	public void createAttach(String fullName) throws Exception;
	
	public List<String> readAllAttaches(int bno) throws Exception;
	
	public void updateAttach(String fullName, int bno) throws Exception;
	
	public void deleteAttach(String fullName, int bno) throws Exception;
	
	public void deleteAllAttaches(int bno) throws Exception;
	
	public int readCountAttaches(int bno) throws Exception;
}
