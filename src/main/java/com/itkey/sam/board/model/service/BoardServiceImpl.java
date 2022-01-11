package com.itkey.sam.board.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.itkey.sam.board.dto.BoardDTO;
import com.itkey.sam.board.dto.Criteria;
import com.itkey.sam.board.model.dao.BoardDAO;

@Service("boardService")
public class BoardServiceImpl implements BoardService {
	
	// Logback logger (package : org.slf4j.Logger & org.slf4j.LoggerFactory)
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/* 
	 * Follow can be used for DI
	 * @Autowired BoardDAO dao;
	 */
	
	// Dependency Injection With BoardDAO
	@Resource(name="boardDAO") BoardDAO dao;

	@Override
	public int getAllBoardCount() {
		int result = dao.getAllBoardCount();
		return result;
	}

	@Override
	public int getTodayBoardCount(String now) {
		int result = dao.getTodayBoardCount(now);
		return result;
	}

	@Override
	public Object getBoardList(BoardDTO bDTO, Criteria cri) {
		return dao.getBoardList(bDTO,cri);
	}

	@Override
	public int searchBoardCount(BoardDTO bDTO) {
		return dao.searchBoardCount(bDTO);
	}

	@Override
	public int insertBoard(Map<String, Object> param) {
		return dao.insertBoard(param);
	}

	@Override
	public HashMap<String, Object> getDetailBoard(int boardIdx) {
		return dao.getDetailBoard(boardIdx);
	}

	@Override
	public void increaseCountBoard(int boardIdx) {
		dao.increaseCountBoard(boardIdx);
	}

	@Override
	public HashMap<String, Object> getNextBoard(Map<String, Object> param) {
		return dao.getNextBoard(param);
	}

	@Override
	public HashMap<String, Object> getPrevBoard(Map<String, Object> param) {
		return dao.getPrevBoard(param);
	}

	@Override
	public HashMap<String, Object> getSecretBoard(int boardIdx) {
		return dao.getSecretBoard(boardIdx);
	}

	@Override
	public int updateBoard(Map<String, Object> param) {
		return dao.updateBoard(param);
	}

	@Override
	public int deleteBoard(Map<String, Object> param) {
		return dao.deleteBoard(param);
	}

	@Override
	public HashMap<String, Object> getDetailSecretBoard(int boardIdx) {
		return dao.getDetailSecretBoard(boardIdx);
	}

	

	

	

	

}