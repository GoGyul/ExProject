package com.itkey.sam.board.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
public class WriterDTO {

	private int boardWriterIDX;
	private String boardWriter;
	private String boardWriterName;
	private String boardWriterPW;
	private String boardWriterPhone;
	private String boardWriterEmail;
	private int fileIDX;
	private String boardWriterJoinDate;
	private String salt;
	private String delYN;
	
	private String keywordType;
	private String keyword;
	private String originalFileName;
	
	
	
}
