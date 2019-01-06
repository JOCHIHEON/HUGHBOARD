package com.board.hugh.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.board.hugh.dao.BoardDAO;
import com.board.hugh.dao.ReplyDAO;
import com.board.hugh.service.ReplyService;
import com.board.hugh.vo.Criteria;
import com.board.hugh.vo.ReplyVO;

@Service
public class ReplyServiceImpl implements ReplyService {
	@Autowired
	private ReplyDAO rDAO;
	
	@Autowired
	private BoardDAO bDAO;
	
	@Override
	@Transactional
	public void create(ReplyVO rVO) throws Exception {
		rDAO.create(rVO);
		bDAO.updateReplycnt(rVO.getBno(), 1);
	}

	@Override
	public List<ReplyVO> readAll(int bno, Criteria cri) throws Exception {
		return rDAO.readAll(bno, cri);
	}

	@Override
	public void update(ReplyVO rVO) throws Exception {
		rDAO.update(rVO);
	}
	
	@Override
	@Transactional
	public void delete(int rno, int bno) throws Exception {
		rDAO.delete(rno);
		bDAO.updateReplycnt(bno, -1);
	}

	@Override
	public int readCount(int bno) throws Exception {
		return rDAO.readCount(bno);
	}

}
