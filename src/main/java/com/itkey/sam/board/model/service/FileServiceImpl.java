package com.itkey.sam.board.model.service;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.itkey.sam.board.dto.FileDTO;
import com.itkey.sam.board.model.dao.FileDAO;

@Service("fileService")
public class FileServiceImpl implements FileService {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Resource(name="fileDAO") FileDAO dao;
	
	@Override
	public int getMaxFileIdx() {
		return dao.getMaxFileIdx();
	}

	@Override
	public void insertFile(List<FileDTO> fileList) {
		dao.insertFile(fileList);
	}

	@Override
	public int updateWriterProfileFile(List<FileDTO> fileList) {
		return dao.updateWriterProfileFile(fileList);
	}

	@Override
	public Object getProfileFileByFileIdx(int fileIdx) {
		return dao.getProfileFileByFileIdx(fileIdx);
	}

}
