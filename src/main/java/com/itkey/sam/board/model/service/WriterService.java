package com.itkey.sam.board.model.service;

import java.util.HashMap;
import java.util.Map;

import com.itkey.sam.board.dto.WriterDTO;

public interface WriterService {

	public String logOn(Map<String, Object> param);

	public boolean isExistWriter(String writerId);

	public WriterDTO getWriterByWriterId(String writerId);

	public int insertWriter(Map<String, Object> param);

	public int getAllWriterCount();

	public int getTodayRegistCount(String now);

	public HashMap<String, Object> getWriterAndFileInfoByWriterId(String boardWriter);

	public int updateWriter(Map<String, Object> param);

	public int withdrawWriter(Map<String, Object> param);


	

}
