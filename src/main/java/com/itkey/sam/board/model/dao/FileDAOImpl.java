package com.itkey.sam.board.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itkey.sam.board.dto.FileDTO;

@Repository("fileDAO")
public class FileDAOImpl implements FileDAO {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired private SqlSessionTemplate sqlSession;
	
	@Override
	public int getMaxFileIdx() {
		int result = sqlSession.selectOne("getMaxFileIdx");
		return result;
	}

	@Override
	public void insertFile(List<FileDTO> fileList) {
		for(FileDTO fDTO : fileList) {
			sqlSession.update("insertFile",fDTO);
		}
		
	}

	@Override
	public int updateWriterProfileFile(List<FileDTO> fileList) {
		int result = 0;
		for(FileDTO fDTO : fileList) {
			sqlSession.update("updateWriterProfileFile",fDTO);
			result++;
		}
		return result;
	}

	@Override
	public Object getProfileFileByFileIdx(int fileIdx) {
		return sqlSession.selectOne("getProfileFileByFileIdx",fileIdx);
	}

}
