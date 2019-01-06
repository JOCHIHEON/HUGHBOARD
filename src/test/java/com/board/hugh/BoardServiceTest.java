package com.board.hugh;

import static org.junit.Assert.assertNull;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.board.hugh.dao.BoardDAO;
import com.board.hugh.service.BoardService;
import com.board.hugh.vo.BoardVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath*:spring/root-context.xml"})
public class BoardServiceTest {
	
	private static Logger log = LoggerFactory.getLogger(BoardServiceTest.class);
	
	@Autowired
	private SqlSessionFactory sqlSessionFactory;
	
	@Autowired
	private BoardDAO bDAO;
	
	@Autowired
	private BoardService boardService;
	
	@Test @Ignore
	public void testSqlSession() throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
	}
	
	@Test
	public void testBoardCreate() throws Exception {
		BoardVO bVO = new BoardVO();
		bVO.setTitle("테스트");
		bVO.setContent("테스트 내용");
		bVO.setWriter("테스터");
		
		assertNull(bVO.getFiles());
		
		boardService.create(bVO);
		
		log.debug("testBoardCreate=>{}", bVO.toString());
	}
	
	@Test @Ignore
	public void testBoardRead() throws Exception {
		bDAO.read(25);
	}
	
	@Test @Ignore
	public void testBoardUpdate() throws Exception {
		BoardVO bVO = new BoardVO();
		bVO.setBno(33);
		bVO.setTitle("수정된 내용!!");
		bVO.setContent("수정된 내용!!");
		
		bDAO.update(bVO);
	}
	
	@Test @Ignore
	public void testBoardDelete() throws Exception {
		bDAO.delete(56);
	}

}
