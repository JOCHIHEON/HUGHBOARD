package com.board.hugh.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.board.hugh.dao.BoardDAO;
import com.board.hugh.vo.BoardVO;
import com.board.hugh.vo.SearchCriteria;

@Repository
public class BoardDAOImpl implements BoardDAO {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void create(BoardVO bVO) throws Exception {
		sqlSession.insert("board.create", bVO);
	}
	
	@Override
	public BoardVO read(int bno) throws Exception {
		return sqlSession.selectOne("board.read", bno);
	}
	
	@Override
	public List<String> readAllAttaches(int bno) throws Exception {
		return sqlSession.selectList("board.readAllAttaches", bno);
	}

	@Override
	public void update(BoardVO bVO) throws Exception {
		sqlSession.update("board.update", bVO);
	}

	@Override
	public void updateViewcnt(int bno, int cnt) throws Exception {
		Map<String, Integer> map = new HashMap<>();
		map.put("bno", bno);
		map.put("cnt", cnt);
		
		sqlSession.update("board.updateViewcnt", map);
	}
	
	@Override
	public void updateReplycnt(int bno, int cnt) throws Exception {
		Map<String, Integer> map = new HashMap<>();
		map.put("bno", bno);
		map.put("cnt", cnt);
		
		sqlSession.update("board.updateReplycnt", map);
	}
	
	@Override
	public void updateLikecnt(int bno, int cnt) throws Exception {
		Map<String, Integer> map = new HashMap<>();
		map.put("bno", bno);
		map.put("cnt", cnt);
		
		sqlSession.update("board.updateLikecnt", map);
	}
	
	@Override
	public void delete(int bno) throws Exception {
		sqlSession.delete("board.delete", bno);
	}

	@Override
	public List<BoardVO> readAll(SearchCriteria cri) throws Exception {
		return sqlSession.selectList("board.readAll", cri);
	}

	@Override
	public int readCount(SearchCriteria cri) throws Exception {
		return sqlSession.selectOne("board.countAll", cri);
	}

	// Attach 관련
	@Override
	public void createAttach(String fullName) throws Exception {
		sqlSession.insert("board.createAttach", fullName);
	}
	
	@Override
	public int readCountAttaches(int bno) throws Exception {
		return sqlSession.selectOne("board.countAllAttaches", bno);
	}
	
	@Override
	public void updateAttach(String fullName, int bno) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("fullName", fullName);
		map.put("bno", bno);
		
		sqlSession.update("board.updateAttach", map);
	}
	
	@Override
	public void deleteAttach(String fullName, int bno) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("fullName", fullName);
		map.put("bno", bno);
		
		sqlSession.delete("board.deleteAttach", map);
	}

	@Override
	public void deleteAllAttaches(int bno) throws Exception {
		sqlSession.delete("board.deleteAllAttaches", bno);
	}

}
