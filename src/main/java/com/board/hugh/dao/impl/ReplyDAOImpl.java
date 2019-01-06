package com.board.hugh.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.board.hugh.dao.ReplyDAO;
import com.board.hugh.vo.Criteria;
import com.board.hugh.vo.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void create(ReplyVO rVO) throws Exception {
		sqlSession.insert("reply.create", rVO);
	}

	@Override
	public List<ReplyVO> readAll(int bno, Criteria cri) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("bno", bno);
		map.put("cri", cri);
		
		return sqlSession.selectList("reply.readAll", map);
	}

	@Override
	public void update(ReplyVO rVO) throws Exception {
		sqlSession.update("reply.update", rVO);
	}

	@Override
	public void delete(int rno) throws Exception {
		sqlSession.delete("reply.delete", rno);
	}
	
	@Override
	public int readCount(int bno) throws Exception {
		return sqlSession.selectOne("reply.readCount", bno);
	}

}
