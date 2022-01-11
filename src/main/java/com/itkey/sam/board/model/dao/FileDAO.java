package com.itkey.sam.board.model.dao;

import java.util.List;

import com.itkey.sam.board.dto.FileDTO;

public interface FileDAO {

	int getMaxFileIdx();

	void insertFile(List<FileDTO> fileList);

	int updateWriterProfileFile(List<FileDTO> fileList);

	Object getProfileFileByFileIdx(int fileIdx);

}
