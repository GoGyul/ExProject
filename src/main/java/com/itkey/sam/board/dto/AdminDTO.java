package com.itkey.sam.board.dto;

import lombok.Data;

@Data
public class AdminDTO {

	private int adminIdx;
	private String adminId;
	private String adminName;
	private String adminPw;
	private String fileIdx;
	private String adminJoinDate;
	private String salt;
	private String delYn;
	
	private String boardWriter;
	private String boardWriterName;
	
}
