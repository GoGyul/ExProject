package com.itkey.sam.board.model.dao;

import java.util.Map;

import com.itkey.sam.board.dto.WriterDTO;

public interface WriterForAjaxDAO {

	int isExistWriterByWriterId(String boardWriter);

	WriterDTO getWriterByWriterIdForAjax(String parameter);

	int insertWriterForAjax(Map<String, Object> param);

	Object countWriterForAjax(Map<String, Object> map);

	Object todayCountWriterForAjax(String today);

}
