package com.itkey.sam.board.model.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itkey.sam.board.dto.WriterDTO;

@Repository("writerForAjaxDAO")
public class WriterForAjaxDAOImpl implements WriterForAjaxDAO {

private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired private SqlSessionTemplate sqlSession;
	
	@Override
	public int isExistWriterByWriterId(String boardWriter) {
		WriterDTO wDTO = sqlSession.selectOne("isExistWriterByWriterId",boardWriter);
		if(wDTO == null) {
			return 0; 
		}else {
			logger.debug("isExistWriterByWriterId wDTO===="+wDTO);
			return 1;
		}
	}

	@Override
	public WriterDTO getWriterByWriterIdForAjax(String boardWriter) {
		logger.debug("getWriterByWriterIdForAjax boardWriter===="+boardWriter);
		return sqlSession.selectOne("getWriterByWriterIdForAjax",boardWriter);
	}

	@Override
	public int insertWriterForAjax(Map<String, Object> param) {
		return sqlSession.insert("insertWriterForAjax",param);
	}

	@Override
	public Object countWriterForAjax(Map<String, Object> map) {
		int result = sqlSession.selectOne("countWriterForAjax",map);
		return result;
	}

	@Override
	public Object todayCountWriterForAjax(String today) {
		 int result = sqlSession.selectOne("todayCountWriterForAjax",today);
		return result;
	}

}
