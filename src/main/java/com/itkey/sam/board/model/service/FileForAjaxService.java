package com.itkey.sam.board.model.service;

import java.util.List;
import java.util.Map;

import com.itkey.sam.board.dto.FileDTO;

public interface FileForAjaxService {

	int getNewFileIdx();

	int insertWriterProfileForAjax(Map<String, Object> param);

	FileDTO getWriterFileInfoForAjax(int fileIDX);

	int insertBoardFileForAjax(List<FileDTO> fileList);

	FileDTO getFileForDownForAjax(int fileIdx);

}
