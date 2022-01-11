package com.itkey.sam.board.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.itkey.sam.board.dto.AdminDTO;
import com.itkey.sam.board.dto.BoardDTO;
import com.itkey.sam.board.dto.Criteria;
import com.itkey.sam.board.dto.WriterDTO;

public interface AdminService {

	AdminDTO getAdmin(Map<String, Object> param);

	int getAllBoardCountForAdmin();

	int searchBoardCountForAdmin(BoardDTO bDTO);

	int getTodayBoardCountForAdmin(String now);

	Object getBoardListForAdmin(BoardDTO bDTO, Criteria cri);

	int choiceDelete(List<String> boardIdxList);

	HashMap<String, Object> getDetailBoardForAdmin(int boardIdx);

	HashMap<String, Object> getNextBoardForAdmin(Map<String, Object> param);

	HashMap<String, Object> getPrevBoardForAdmin(Map<String, Object> param);

	int deleteSeperateBoard(int boardIdx);

	HashMap<String, Object> getRecentlyDeleteSeperateBoard(int boardIdx);

	int getAllWriterCountForAdmin();

	int getTodayRegistCountForAdmin(String now);

	int searchWriterCountForAdmin(WriterDTO wDTO);

	Object getWriterListForAdmin(WriterDTO wDTO, Criteria cri);

	WriterDTO getWriterOne(int parseInt);

	int choiceDeleteWriter(List<String> boardWriterIdxList);

	int deleteSeperateWriter(int boardWriterIdx);

	HashMap<String, Object> getRecentlyDeleteSeperateWriter(int boardWriterIdx);

}
