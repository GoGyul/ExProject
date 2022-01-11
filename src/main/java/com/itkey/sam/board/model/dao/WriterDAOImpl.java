package com.itkey.sam.board.model.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itkey.sam.board.dto.WriterDTO;

@Repository("writerDAO")
public class WriterDAOImpl implements WriterDAO {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired private SqlSessionTemplate sqlSession;

	@Override
	public boolean isExistWriter(String writerId) {
		
		WriterDTO dto = sqlSession.selectOne("findUserById", writerId);
		if(dto == null) {
			return false;
		}
		return true;
	}

	@Override
	public WriterDTO getWriterByWriterId(String writerId) {
		WriterDTO dto = sqlSession.selectOne("findUserById", writerId);
		return dto;
	}

	@Override
	public int insertWriter(Map<String, Object> param) {
		int result = sqlSession.update("insertWriter", param);
		return result;
	}

	@Override
	public int getAllWriterCount() {
		int result = sqlSession.selectOne("getAllWriterCount");
		return result;
	}

	@Override
	public int getTodayRegistCount(String now) {
		int result = sqlSession.selectOne("getTodayRegistCount",now);
		return result;
	}

	@Override
	public HashMap<String, Object> getWriterAndFileInfoByWriterId(String boardWriter) {
		return sqlSession.selectOne("getWriterAndFileInfoByWriterId",boardWriter);
	}

	@Override
	public int updateWriter(Map<String, Object> param) {
		int result = sqlSession.update("updateWriter",param);
		return result;
	}

	@Override
	public int withdrawWriter(Map<String, Object> param) {
		int result = sqlSession.update("withdrawWriter",param);
		return result;
	}
	
	
	
}
