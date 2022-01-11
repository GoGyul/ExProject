package com.itkey.sam.board.model.dao;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itkey.sam.board.dto.AdminDTO;
import com.itkey.sam.board.dto.BoardDTO;
import com.itkey.sam.board.dto.Criteria;
import com.itkey.sam.board.dto.WriterDTO;

@Repository("adminDAO")
public class AdminDAOImpl implements AdminDAO {

	// Logback logger (package : org.slf4j.Logger & org.slf4j.LoggerFactory)
		private final Logger logger = LoggerFactory.getLogger(this.getClass());
		
		// Mybatis SqlSessionTemplate
		@Autowired private SqlSessionTemplate sqlSession;
	
	@Override
	public AdminDTO getAdmin(Map<String, Object> param) {
		return sqlSession.selectOne("getAdmin",param);
	}

	@Override
	public int getAllBoardCountForAdmin() {
		int result = sqlSession.selectOne("getAllBoardCountForAdmin");
		return result;
	}

	@Override
	public int searchBoardCountForAdmin(BoardDTO bDTO) {
		int result = sqlSession.selectOne("searchBoardCountForAdmin",bDTO);
		return result;
	}

	@Override
	public int getTodayBoardCountForAdmin(String now) {
		int result = sqlSession.selectOne("getTodayBoardCountForAdmin",now);
		logger.debug("AdminDAOImpl getBoardListForAdmin result===================="+result);
		logger.debug("AdminDAOImpl getBoardListForAdmin now===================="+now);
		return result;
	}

	@Override
	public Object getBoardListForAdmin(BoardDTO bDTO, Criteria cri) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("board", bDTO);
		cri.setStartNum((cri.getPageNum() -1 ) * cri.getAmount());
		paramMap.put("criteria", cri);
		logger.debug("getBoardListForAdmin paramMap===================="+paramMap);
		return sqlSession.selectList("getBoardListForAdmin",paramMap);
	}

	@Override
	public int choiceDelete(List<String> boardIdxList) {
		int result = 0;
		Iterator<String> ite = boardIdxList.iterator();
		while(ite.hasNext()) {
			int boardIdx = Integer.parseInt(ite.next());
			logger.debug("choiceDelete  boardIdx ==" + boardIdx);
			sqlSession.update("choiceDelete",boardIdx);
			result++;
		}
		logger.debug("choiceDelete  result ==" + result);
		return result;
	}

	@Override
	public HashMap<String, Object> getDetailBoardForAdmin(int boardIdx) {
		return sqlSession.selectOne("getDetailBoardForAdmin", boardIdx);
	}

	@Override
	public HashMap<String, Object> getNextBoardForAdmin(Map<String, Object> param) {
		return sqlSession.selectOne("getNextBoardForAdmin",param);
	}

	@Override
	public HashMap<String, Object> getPrevBoardForAdmin(Map<String, Object> param) {
		return sqlSession.selectOne("getPrevBoardForAdmin",param);
	}

	@Override
	public int deleteSeperateBoard(int boardIdx) {
		return sqlSession.update("deleteSeperateBoard",boardIdx);
	}

	@Override
	public HashMap<String, Object> getRecentlyDeleteSeperateBoard(int boardIdx) {
		return sqlSession.selectOne("getRecentlyDeleteSeperateBoard",boardIdx);
	}

	@Override
	public int getAllWriterCountForAdmin() {
		int result = sqlSession.selectOne("getAllWriterCountForAdmin");
		return result;
	}

	@Override
	public int getTodayRegistCountForAdmin(String now) {
		int result = sqlSession.selectOne("getTodayRegistCountForAdmin",now);
		return result;
	}

	@Override
	public int searchWriterCountForAdmin(WriterDTO wDTO) {
		int result = sqlSession.selectOne("searchWriterCountForAdmin",wDTO);
		return result;
	}

	@Override
	public Object getWriterListForAdmin(WriterDTO wDTO, Criteria cri) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("writer", wDTO);
		cri.setStartNum((cri.getPageNum() -1 ) * cri.getAmount());
		paramMap.put("criteria", cri);
		logger.debug("getWriterListForAdmin paramMap===================="+paramMap);
		return sqlSession.selectList("getWriterListForAdmin",paramMap);
	}

	@Override
	public WriterDTO getWriterOne(int parseInt) {
		int boardWriterIdx = parseInt;
		return sqlSession.selectOne("getWriterOne",boardWriterIdx);
	}

	@Override
	public int choiceDeleteWriter(List<String> boardWriterIdxList) {
		int result = 0;
		Iterator<String> ite = boardWriterIdxList.iterator();
		while(ite.hasNext()) {
			int boardWriterIdx = Integer.parseInt(ite.next());
			logger.debug("choiceDeleteWriter  boardIdx ==" + boardWriterIdx);
			sqlSession.update("choiceDeleteWriter",boardWriterIdx);
			result++;
		}
		logger.debug("choiceDeleteWriter  result ==" + result);
		return result;
	}

	@Override
	public int deleteSeperateWriter(int boardWriterIdx) {
		return sqlSession.update("deleteSeperateWriter",boardWriterIdx);
	}

	@Override
	public HashMap<String, Object> getRecentlyDeleteSeperateWriter(int boardWriterIdx) {
		return sqlSession.selectOne("getRecentlyDeleteSeperateWriter",boardWriterIdx);
	}

}
