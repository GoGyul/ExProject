package com.itkey.sam.board.model.service;

import java.util.List;

import com.itkey.sam.board.dto.FileDTO;

public interface FileService {

	int getMaxFileIdx();

	void insertFile(List<FileDTO> fileList);

	int updateWriterProfileFile(List<FileDTO> fileList);

	Object getProfileFileByFileIdx(int fileIdx);

	

}
