package com.board.hugh.service;

import java.util.Date;

import com.board.hugh.dto.LoginDTO;
import com.board.hugh.vo.UserVO;

public interface UserService {
	public void create(UserVO uVO) throws Exception;
	
	public UserVO login(LoginDTO lDTO) throws Exception;
	
	public UserVO readByUid(String uid) throws Exception;
	
	public UserVO readByEmail(String email) throws Exception;
	
	public UserVO readForCheckSession(String value) throws Exception;
	
	public void update(UserVO uVO) throws Exception;
	
	public void updateAuthstatus(UserVO uVO) throws Exception;
	
	public void updateForCookie(String uid, String sessionid, Date next) throws Exception;
}
