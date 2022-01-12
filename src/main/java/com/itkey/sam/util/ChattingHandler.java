package com.itkey.sam.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.itkey.sam.board.dto.WriterDTO;

import lombok.extern.log4j.Log4j;

public class ChattingHandler extends TextWebSocketHandler {

	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

		sessionList.add(session);
		
		Map<String,Object> map = session.getAttributes();
		WriterDTO wDTO = (WriterDTO)map.get("login");
		
		
		
		logger.debug("map==========================" + map);
		 
		logger.info(wDTO.getBoardWriterName() + "님이 입장하셨습니다.");
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		logger.info("#ChattingHandler, handleMessage");
		logger.info(session.getId() + ": " + message);
		
		Map<String,Object> map = session.getAttributes();
		WriterDTO wDTO = (WriterDTO)map.get("login");
		
		for(WebSocketSession s : sessionList) {
			s.sendMessage(new TextMessage(wDTO.getBoardWriterName() + ":" + message.getPayload() +":" + wDTO.getOriginalFileName()));
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
//		logger.info("#ChattingHandler, afterConnectionClosed");

		sessionList.remove(session);
		
		Map<String,Object> map = session.getAttributes();
		WriterDTO wDTO = (WriterDTO)map.get("login");
		  
		logger.info(wDTO.getBoardWriterName() + "님이 퇴장하셨습니다.");
	}
	
}
