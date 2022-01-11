package com.itkey.sam.board.model.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.itkey.sam.board.dto.WriterDTO;
import com.itkey.sam.board.model.dao.WriterDAO;



@Service("writerService")
public class WriterServiceImpl implements WriterService {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Resource(name="writerDAO") WriterDAO dao;
	
	@Override
	public String logOn(Map<String, Object> param) {
		
		return null;
	}

	@Override
	public boolean isExistWriter(String writerId) {
		
		return dao.isExistWriter(writerId);
	}

	@Override
	public WriterDTO getWriterByWriterId(String writerId) {
		return dao.getWriterByWriterId(writerId);
	}

	@Override
	public int insertWriter(Map<String, Object> param) {
		return dao.insertWriter(param);
	}

	@Override
	public int getAllWriterCount() {
		return dao.getAllWriterCount();
	}

	@Override
	public int getTodayRegistCount(String now) {
		return dao.getTodayRegistCount(now);
	}

	@Override
	public HashMap<String, Object> getWriterAndFileInfoByWriterId(String boardWriter) {
		return dao.getWriterAndFileInfoByWriterId(boardWriter);
	}

	@Override
	public int updateWriter(Map<String, Object> param) {
		return dao.updateWriter(param);
	}

	@Override
	public int withdrawWriter(Map<String, Object> param) {
		return dao.withdrawWriter(param);
	}


	
	
	
}
