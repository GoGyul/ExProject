package com.itkey.sam.board.model.service;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.itkey.sam.board.dto.WriterDTO;
import com.itkey.sam.board.model.dao.WriterDAO;
import com.itkey.sam.board.model.dao.WriterForAjaxDAO;

@Service("WriterForAjaxService")
public class WriterForAjaxServiceImpl implements WriterForAjaxService {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Resource(name="writerForAjaxDAO") WriterForAjaxDAO dao;
	
	@Override
	public int isExistWriterByWriterId(String boardWriter) {
		return dao.isExistWriterByWriterId(boardWriter);
	}

	@Override
	public WriterDTO getWriterByWriterIdForAjax(String parameter) {
		return dao.getWriterByWriterIdForAjax(parameter);
	}

	@Override
	public int insertWriterForAjax(Map<String, Object> param) {
		return dao.insertWriterForAjax(param);
	}

	@Override
	public Object countWriterForAjax(Map<String, Object> map) {
		return dao.countWriterForAjax(map);
	}

	@Override
	public Object todayCountWriterForAjax(String today) {
		return dao.todayCountWriterForAjax(today);
	}

}
