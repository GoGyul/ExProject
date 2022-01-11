package com.itkey.sam.board.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itkey.sam.board.dto.BoardDTO;
import com.itkey.sam.board.dto.Criteria;

@Repository("boardDAO")
public class BoardDAOImpl implements BoardDAO {
	
	// Logback logger (package : org.slf4j.Logger & org.slf4j.LoggerFactory)
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	// Mybatis SqlSessionTemplate
	@Autowired private SqlSessionTemplate sqlSession;

	@Override
	public int getAllBoardCount() {
		logger.debug("* [DAO] Input  ◀ (getAllBoardCount) : ");
		int result = sqlSession.selectOne("getAllBoardCount");
		logger.debug("* [DAO] Output ◀ (Mybatis) : " + result);
		return result;
	}

	@Override
	public int getTodayBoardCount(String now) {
		int result = sqlSession.selectOne("getTodayBoardCount", now);
		return result;
	}

	@Override
	public Object getBoardList(BoardDTO bDTO, Criteria cri) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("board", bDTO);
		cri.setStartNum((cri.getPageNum() -1 ) * cri.getAmount());
		paramMap.put("criteria", cri);
		return sqlSession.selectList("getBoardList",paramMap);
	}

	@Override
	public int searchBoardCount(BoardDTO bDTO) {
		int result = sqlSession.selectOne("searchBoardCount",bDTO);
		return result;
	}

	@Override
	public int insertBoard(Map<String, Object> param) {
		int result = sqlSession.update("insertBoard",param);
		return result;
	}

	@Override
	public HashMap<String, Object> getDetailBoard(int boardIdx) {
		return sqlSession.selectOne("getDetailBoard", boardIdx);
	}

	@Override
	public void increaseCountBoard(int boardIdx) {
		sqlSession.update("increaseCountBoard",boardIdx);
	}

	@Override
	public HashMap<String, Object> getNextBoard(Map<String, Object> param) {
		return sqlSession.selectOne("getNextBoard",param);
	}

	@Override
	public HashMap<String, Object> getPrevBoard(Map<String, Object> param) {
		return sqlSession.selectOne("getPrevBoard",param);
	}

	@Override
	public HashMap<String, Object> getSecretBoard(int boardIdx) {
		return sqlSession.selectOne("getSecretBoard", boardIdx);
	}

	@Override
	public int updateBoard(Map<String, Object> param) {
		int result = sqlSession.update("updateBoard",param);
		return result;
	}

	@Override
	public int deleteBoard(Map<String, Object> param) {
		int result = sqlSession.delete("deleteBoard",param);
		return result;
	}

	@Override
	public HashMap<String, Object> getDetailSecretBoard(int boardIdx) {
		return sqlSession.selectOne("getDetailSecretBoard",boardIdx);
	};

}