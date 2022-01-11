package com.itkey.sam.board.model.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itkey.sam.board.dto.BoardDTO;
import com.itkey.sam.board.dto.Criteria;

@Repository("boardForAjaxDAO")
public class BoardForAjaxDAOImpl implements BoardForAjaxDAO {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	// Mybatis SqlSessionTemplate
	@Autowired private SqlSessionTemplate sqlSession;

	@Override
	public Object countBoardForAjax(Map<String, Object> map) {
		int result = sqlSession.selectOne("countBoardForAjax", map);
		return result;
	}

	@Override
	public Object todayCountBoardForAjax(String today) {
		int result = sqlSession.selectOne("todayCountBoardForAjax", today);
		return result;
	}

	@Override
	public int searchBoardCountForAjax(BoardDTO bDTO) {
		int result = sqlSession.selectOne("searchBoardCountForAjax",bDTO);
		return result;
	}

	@Override
	public Object getBoardListForAjax(BoardDTO bDTO, Criteria cri) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("board", bDTO);
		cri.setStartNum((cri.getPageNum() -1 ) * cri.getAmount());
		paramMap.put("criteria", cri);
		return sqlSession.selectList("getBoardListForAjax",paramMap);
	}

	@Override
	public BoardDTO getBoardForAjax(BoardDTO bDTO) {
		return sqlSession.selectOne("getBoardForAjax",bDTO);
	}

	@Override
	public int insetBoardForAjax(BoardDTO bDTO) {
		return sqlSession.insert("insetBoardForAjax",bDTO);
	}

	@Override
	public int deleteBoardForAjax(BoardDTO bDTO) {
		return sqlSession.update("deleteBoardForAjax",bDTO);
	}

	@Override
	public int updateBoardForAjax(BoardDTO bDTO) {
		return sqlSession.update("updateBoardForAjax",bDTO);
	}

	@Override
	public int increaseBoardCountForAjax(BoardDTO bDTO) {
		return sqlSession.update("increaseBoardCountForAjax",bDTO);
	}

	@Override
	public Object getNextBoardForAjax(BoardDTO bDTO) {
		return sqlSession.selectOne("getNextBoardForAjax",bDTO);
	}

	@Override
	public Object getPrevBoardForAjax(BoardDTO bDTO) {
		return sqlSession.selectOne("getPrevBoardForAjax",bDTO);
	}
	
}
