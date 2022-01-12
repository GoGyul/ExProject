package com.itkey.sam.board.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itkey.sam.board.dto.FileDTO;

@Repository("fileForAjaxDAO")
public class FileForAjaxDAOImpl implements FileForAjaxDAO {

private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired private SqlSessionTemplate sqlSession;
	
	@Override
	public int getNewFileIdx() {
		return sqlSession.selectOne("getNewFileIdx");
	}

	@Override
	public int insertWriterProfileForAjax(Map<String, Object> param) {
		return sqlSession.insert("insertWriterProfileForAjax",param);
	}

	@Override
	public FileDTO getWriterFileInfoForAjax(int fileIDX) {
		return sqlSession.selectOne("getWriterFileInfoForAjax",fileIDX);
	}

	@Override
	public int insertBoardFileForAjax(List<FileDTO> fileList) {
		int result = 0;
		for(FileDTO fDTO : fileList) {
			logger.debug("insertBoardFileForAjax DAO INPUT FileDAO === "+fDTO.toString());
			sqlSession.insert("insertBoardFileForAjax",fDTO);
			result++;
		}
		return result;
	}

	@Override
	public FileDTO getFileForDownForAjax(int fileIdx) {
		return sqlSession.selectOne("getFileForDownForAjax",fileIdx);
	}

	@Override
	public int updateFileForAjax(List<FileDTO> fileList) {
		int result = 0;
		for(FileDTO fDTO : fileList) {
			logger.debug("insertBoardFileForAjax DAO INPUT FileDAO === "+fDTO.toString());
			sqlSession.insert("updateFileForAjax",fDTO);
			result++;
		}
		return result;
	}

}
