package com.board.hugh.dao;

import java.util.Date;

import com.board.hugh.dto.LoginDTO;
import com.board.hugh.vo.UserVO;

public interface UserDAO {
	public void create(UserVO uVO) throws Exception;
	
	public UserVO read(LoginDTO lDTO) throws Exception;

	public UserVO readByUid(String uid) throws Exception;
	
	public UserVO readByEmail(String email) throws Exception;
	
	public UserVO readForCheckSession(String value) throws Exception;
	
	public void update(UserVO uVO) throws Exception;
	
	public void updateAuthkey(UserVO uVO) throws Exception;
	
	public void updateAuthstatus(UserVO uVO) throws Exception;

	public void updateForCookie(String uid, String sessionid, Date next) throws Exception;
}
