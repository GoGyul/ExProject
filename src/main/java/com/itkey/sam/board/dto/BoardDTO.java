package com.itkey.sam.board.dto;


public class BoardDTO {
	
	private String boardIdx          = null;
	private String boardWriter       = null;
	private String boardTitle        = null;
	private String boardContents     = null;
	private String boardViewCount    = null;
	private String fileIdx           = null;
	private String boardWriteDate;
	private String boardPublicFl;
	private String keywordType;
	private String keyword;
	
	public String getBoardWriteDate() {
		return boardWriteDate;
	}
	public void setBoardWriteDate(String boardWriteDate) {
		this.boardWriteDate = boardWriteDate;
	}
	@Override
	public String toString() {
		return "BoardDTO [boardIdx=" + boardIdx + ", boardWriter=" + boardWriter + ", boardTitle=" + boardTitle
				+ ", boardContents=" + boardContents + ", boardViewCount=" + boardViewCount + ", fileIdx=" + fileIdx
				+ ", boardPublicFl=" + boardPublicFl + ", keywordType=" + keywordType + ", keyword=" + keyword + "]";
	}
	public String getBoardPublicFl() {
		return boardPublicFl;
	}
	public void setBoardPublicFl(String boardPublicFl) {
		this.boardPublicFl = boardPublicFl;
	}
	public String getKeywordType() {
		return keywordType;
	}
	public void setKeywordType(String keywordType) {
		this.keywordType = keywordType;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getBoardIdx() {
		return boardIdx;
	}
	public void setBoardIdx(String boardIdx) {
		this.boardIdx = boardIdx;
	}
	public String getBoardWriter() {
		return boardWriter;
	}
	public void setBoardWriter(String boardWriter) {
		this.boardWriter = boardWriter;
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public String getBoardContents() {
		return boardContents;
	}
	public void setBoardContents(String boardContents) {
		this.boardContents = boardContents;
	}
	public String getBoardViewCount() {
		return boardViewCount;
	}
	public void setBoardViewCount(String boardViewCount) {
		this.boardViewCount = boardViewCount;
	}
	public String getFileIdx() {
		return fileIdx;
	}
	public void setFileIdx(String fileIdx) {
		this.fileIdx = fileIdx;
	}
	
}