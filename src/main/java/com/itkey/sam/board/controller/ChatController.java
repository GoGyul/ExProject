package com.itkey.sam.board.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.itkey.sam.board.dto.WriterDTO;
import com.itkey.sam.board.model.service.FileService;

@Controller
public class ChatController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired FileService fileService;
	
	@RequestMapping(value = "/chat.do")
	public ModelAndView chat(@RequestParam Map<String, Object> param, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("loginId"); 
		
		if(session.getAttribute("login") == null) {
			ModelAndView mv = new ModelAndView("exception");
			mv.addObject("status","404");
			return mv;
		}
		
		WriterDTO wDTO = (WriterDTO)session.getAttribute("login");
		String name = wDTO.getBoardWriterName();
		int fileIdx = wDTO.getFileIDX();

		
		ModelAndView mv = new ModelAndView("chat");
		mv.addObject("boardWriterName", name);
		
		return mv;
		
	}
	
}
