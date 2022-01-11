package com.itkey.sam.board.model.service;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.itkey.sam.board.dto.BoardDTO;
import com.itkey.sam.board.dto.Criteria;
import com.itkey.sam.board.model.dao.AdminDAO;
import com.itkey.sam.board.model.dao.BoardForAjaxDAO;

@Service("boardForAjaxService")
public class BoardForAjaxServiceImpl implements BoardForAjaxService {

	@Resource(name="boardForAjaxDAO") BoardForAjaxDAO dao;

	@Override
	public Object countBoardForAjax(Map<String, Object> map) {
		return dao.countBoardForAjax(map);
	}

	@Override
	public Object todayCountBoardForAjax(String today) {
		return dao.todayCountBoardForAjax(today);
	}

	@Override
	public int searchBoardCountForAjax(BoardDTO bDTO) {
		return dao.searchBoardCountForAjax(bDTO);
	}

	@Override
	public Object getBoardListForAjax(BoardDTO bDTO, Criteria cri) {
		return dao.getBoardListForAjax(bDTO,cri);
	}

	@Override
	public BoardDTO getBoardForAjax(BoardDTO bDTO) {
		return dao.getBoardForAjax(bDTO);
	}

	@Override
	public int insetBoardForAjax(BoardDTO bDTO) {
		return dao.insetBoardForAjax(bDTO);
	}

	@Override
	public int deleteBoardForAjax(BoardDTO bDTO) {
		return dao.deleteBoardForAjax(bDTO);
	}

	@Override
	public int updateBoardForAjax(BoardDTO bDTO) {
		return dao.updateBoardForAjax(bDTO);
	}

	@Override
	public int increaseBoardCountForAjax(BoardDTO bDTO) {
		return dao.increaseBoardCountForAjax(bDTO);
	}

	@Override
	public Object getNextBoardForAjax(BoardDTO bDTO) {
		return dao.getNextBoardForAjax(bDTO);
	}

	@Override
	public Object getPrevBoardForAjax(BoardDTO bDTO) {
		return dao.getPrevBoardForAjax(bDTO);
	}
	
}
