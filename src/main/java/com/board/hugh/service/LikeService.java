package com.board.hugh.service;

import com.board.hugh.vo.LikeVO;

public interface LikeService {
	public void Like(int bno, String uid) throws Exception;
	
	public LikeVO read(int bno, String uid) throws Exception;
	
	public void delete(int bno, String uid) throws Exception;
}
