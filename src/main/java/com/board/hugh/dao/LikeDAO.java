package com.board.hugh.dao;

import com.board.hugh.vo.LikeVO;

public interface LikeDAO {
	public void create(int bno, String uid) throws Exception;
	
	public LikeVO read(int bno, String uid) throws Exception;
	
	public void delete(int bno, String uid) throws Exception;
}
