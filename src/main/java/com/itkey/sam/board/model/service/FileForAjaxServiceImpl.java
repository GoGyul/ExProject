package com.itkey.sam.board.model.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.itkey.sam.board.dto.FileDTO;
import com.itkey.sam.board.model.dao.FileDAO;
import com.itkey.sam.board.model.dao.FileForAjaxDAO;

@Service("fileForAjaxService")
public class FileForAjaxServiceImpl implements FileForAjaxService {

	@Resource(name="fileForAjaxDAO") FileForAjaxDAO dao;

	@Override
	public int getNewFileIdx() {
		return dao.getNewFileIdx();
	}

	@Override
	public int insertWriterProfileForAjax(Map<String, Object> param) {
		return dao.insertWriterProfileForAjax(param);
	}

	@Override
	public FileDTO getWriterFileInfoForAjax(int fileIDX) {
		return dao.getWriterFileInfoForAjax(fileIDX);
	}

	@Override
	public int insertBoardFileForAjax(List<FileDTO> fileList) {
		return dao.insertBoardFileForAjax(fileList);
	}

	@Override
	public FileDTO getFileForDownForAjax(int fileIdx) {
		return dao.getFileForDownForAjax(fileIdx);
	}
	
}
