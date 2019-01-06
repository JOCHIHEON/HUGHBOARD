package com.board.hugh.dao.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.board.hugh.dao.UserDAO;
import com.board.hugh.dto.LoginDTO;
import com.board.hugh.vo.UserVO;

@Repository
public class UserDAOImpl implements UserDAO {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void create(UserVO uVO) throws Exception {
		sqlSession.insert("user.create", uVO);
	}

	@Override
	public UserVO read(LoginDTO lDTO) throws Exception {
		return sqlSession.selectOne("user.read", lDTO);
	}

	@Override
	public UserVO readByUid(String uid) throws Exception {
		return sqlSession.selectOne("user.readByUid", uid);
	}

	@Override
	public UserVO readByEmail(String email) throws Exception {
		return sqlSession.selectOne("user.readByEmail", email);
	}
	
	@Override
	public UserVO readForCheckSession(String value) throws Exception {
		return sqlSession.selectOne("user.readForCheckSession", value);
	}

	@Override
	public void update(UserVO uVO) throws Exception {
		sqlSession.update("user.update", uVO);
	}
	
	@Override
	public void updateAuthkey(UserVO uVO) throws Exception {
		sqlSession.update("user.updateAuthkey", uVO);
	}
	
	@Override
	public void updateAuthstatus(UserVO uVO) throws Exception {
		sqlSession.update("user.updateAuthstatus", uVO);
	}
	
	@Override
	public void updateForCookie(String uid, String sessionid, Date next) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("uid", uid);
		map.put("sessionid", sessionid);
		map.put("next", next);
		
		sqlSession.update("user.updateForCookie", map);
	}

}
