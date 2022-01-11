package com.itkey.sam.board.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.itkey.sam.board.dto.BoardDTO;
import com.itkey.sam.board.dto.Criteria;

/**
 * Service for SAMPLE_BOARD_TB table : 게시판 정보
**/
public interface BoardService {

	public int getAllBoardCount();

	public int getTodayBoardCount(String now);

	public Object getBoardList(BoardDTO bDTO, Criteria cri);

	public int searchBoardCount(BoardDTO bDTO);

	public int insertBoard(Map<String, Object> param);

	public HashMap<String, Object> getDetailBoard(int boardIdx);

	public void increaseCountBoard(int boardIdx);

	public HashMap<String, Object> getNextBoard(Map<String, Object> param);

	public HashMap<String, Object> getPrevBoard(Map<String, Object> param);

	public HashMap<String, Object> getSecretBoard(int boardIdx);

	public int updateBoard(Map<String, Object> param);

	public int deleteBoard(Map<String, Object> param);

	public HashMap<String, Object> getDetailSecretBoard(int boardIdx);




	


	


	

}
