package com.itkey.sam.board.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.itkey.sam.board.dto.AdminDTO;
import com.itkey.sam.board.dto.BoardDTO;
import com.itkey.sam.board.dto.Criteria;
import com.itkey.sam.board.dto.WriterDTO;
import com.itkey.sam.board.model.dao.AdminDAO;

@Service("adminService")
public class AdminServiceImpl implements AdminService {

	@Resource(name="adminDAO") AdminDAO dao; 
	
	@Override
	public AdminDTO getAdmin(Map<String, Object> param) {
		return dao.getAdmin(param);
	}

	@Override
	public int getAllBoardCountForAdmin() {
		return dao.getAllBoardCountForAdmin();
	}

	@Override
	public int searchBoardCountForAdmin(BoardDTO bDTO) {
		return dao.searchBoardCountForAdmin(bDTO);
	}

	@Override
	public int getTodayBoardCountForAdmin(String now) {
		return dao.getTodayBoardCountForAdmin(now);
	}

	@Override
	public Object getBoardListForAdmin(BoardDTO bDTO, Criteria cri) {
		return dao.getBoardListForAdmin(bDTO,cri);
	}

	@Override
	public int choiceDelete(List<String> boardIdxList) {
		return dao.choiceDelete(boardIdxList);
	}

	@Override
	public HashMap<String, Object> getDetailBoardForAdmin(int boardIdx) {
		return dao.getDetailBoardForAdmin(boardIdx);
	}

	@Override
	public HashMap<String, Object> getNextBoardForAdmin(Map<String, Object> param) {
		return dao.getNextBoardForAdmin(param);
	}

	@Override
	public HashMap<String, Object> getPrevBoardForAdmin(Map<String, Object> param) {
		return dao.getPrevBoardForAdmin(param);
	}

	@Override
	public int deleteSeperateBoard(int boardIdx) {
		return dao.deleteSeperateBoard(boardIdx);
	}

	@Override
	public HashMap<String, Object> getRecentlyDeleteSeperateBoard(int boardIdx) {
		return dao.getRecentlyDeleteSeperateBoard(boardIdx);
	}

	@Override
	public int getAllWriterCountForAdmin() {
		return dao.getAllWriterCountForAdmin();
	}

	@Override
	public int getTodayRegistCountForAdmin(String now) {
		return dao.getTodayRegistCountForAdmin(now);
	}

	@Override
	public int searchWriterCountForAdmin(WriterDTO wDTO) {
		return dao.searchWriterCountForAdmin(wDTO);
	}

	@Override
	public Object getWriterListForAdmin(WriterDTO wDTO, Criteria cri) {
		return dao.getWriterListForAdmin(wDTO,cri);
	}

	@Override
	public WriterDTO getWriterOne(int parseInt) {
		return dao.getWriterOne(parseInt);
	}

	@Override
	public int choiceDeleteWriter(List<String> boardWriterIdxList) {
		return dao.choiceDeleteWriter(boardWriterIdxList);
	}

	@Override
	public int deleteSeperateWriter(int boardWriterIdx) {
		return dao.deleteSeperateWriter(boardWriterIdx);
	}

	@Override
	public HashMap<String, Object> getRecentlyDeleteSeperateWriter(int boardWriterIdx) {
		return dao.getRecentlyDeleteSeperateWriter(boardWriterIdx);
	}

}
