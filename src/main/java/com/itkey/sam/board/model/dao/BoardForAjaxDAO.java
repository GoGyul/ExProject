package com.itkey.sam.board.model.dao;

import java.util.Map;

import com.itkey.sam.board.dto.BoardDTO;
import com.itkey.sam.board.dto.Criteria;

public interface BoardForAjaxDAO {

	Object countBoardForAjax(Map<String, Object> map);

	Object todayCountBoardForAjax(String today);

	int searchBoardCountForAjax(BoardDTO bDTO);

	Object getBoardListForAjax(BoardDTO bDTO, Criteria cri);

	BoardDTO getBoardForAjax(BoardDTO bDTO);

	int insetBoardForAjax(BoardDTO bDTO);

	int deleteBoardForAjax(BoardDTO bDTO);

	int updateBoardForAjax(BoardDTO bDTO);

	int increaseBoardCountForAjax(BoardDTO bDTO);

	Object getNextBoardForAjax(BoardDTO bDTO);

	Object getPrevBoardForAjax(BoardDTO bDTO);

}
