package com.itkey.sam.board.dto;

import lombok.Data;

@Data
public class FileDTO {

	private int fileIdx;
	private String fileOriginalName;
	private String fileChangedName;
	private String filePath;
	
}
