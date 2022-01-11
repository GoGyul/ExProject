package com.itkey.sam.board.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itkey.sam.board.dto.AdminDTO;
import com.itkey.sam.board.dto.BoardDTO;
import com.itkey.sam.board.dto.Criteria;
import com.itkey.sam.board.dto.PageDTO;
import com.itkey.sam.board.dto.WriterDTO;
import com.itkey.sam.board.model.service.AdminService;
import com.itkey.sam.board.model.service.BoardService;
import com.itkey.sam.board.model.service.WriterService;

@Controller
public class AdminController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired BoardService boardService;
	
	@Autowired WriterService writerService;
	
	@Autowired AdminService adminService;
	
	static String keyword = "";
	static String keywordType = "";
	
	@RequestMapping(value="/admin.do")
	public ModelAndView admin(@RequestParam Map<String, Object> requestParam, BoardDTO bDTO, Criteria cri, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		AdminDTO aDTO = (AdminDTO)session.getAttribute("login");
		logger.debug("aDTO==="+aDTO);
		if(aDTO == null || !aDTO.getAdminId().equals("admin")) {
			ModelAndView mv = new ModelAndView("exception");
			mv.addObject("status","404");
			return mv;
		}
		
		if(bDTO.getKeywordType() == null || bDTO.getKeywordType().isEmpty()) {
			bDTO.setKeywordType("writerAndTitle");
		}
		if(bDTO.getKeyword() == null) {
			bDTO.setKeyword("");
		}
		
		if(!keyword.equals(bDTO.getKeyword())) {
			cri.setPageNum(1);
		}
		if(!keywordType.equals(bDTO.getKeywordType())) {
			cri.setPageNum(1);
		}
		
		keyword = bDTO.getKeyword();
		keywordType = bDTO.getKeywordType();
		
		String now = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		
		int allBoardCount = adminService.getAllBoardCountForAdmin();
		int todayBoardCount = adminService.getTodayBoardCountForAdmin(now);
		int allWriterCount = adminService.getAllWriterCountForAdmin();
		int todayRegistCount = adminService.getTodayRegistCountForAdmin(now);
		logger.debug("allBoardCount"+ allBoardCount);
		logger.debug("todayBoardCount======================="+ todayBoardCount);
		
		int total = adminService.searchBoardCountForAdmin(bDTO);
		
		ModelAndView mv = new ModelAndView("admin_board_mgmt");
		
		mv.addObject("total",total);
		mv.addObject("allBoardCount", allBoardCount);
		mv.addObject("todayBoardCount", todayBoardCount);
		mv.addObject("allWriterCount", allWriterCount);
		mv.addObject("todayRegistCount", todayRegistCount);
		mv.addObject("pageMaker",  new PageDTO(cri, total));
		mv.addObject("keyword", bDTO.getKeyword());
		mv.addObject("keywordType", bDTO.getKeywordType());
		mv.addObject("boardList", adminService.getBoardListForAdmin(bDTO,cri));
		logger.debug("getBoardList================",adminService.getBoardListForAdmin(bDTO,cri));
		
		return mv;
		
	}
	
	@ResponseBody
	@RequestMapping(value="/choiceDelete.do")
	public int choiceDelete(@RequestParam(value="boardIdxList[]") List<String> boardIdxList,HttpServletRequest request) {
		
		logger.debug("choiceDelete==== boardIdxList"+boardIdxList);
		
		HttpSession session = request.getSession();
		
		AdminDTO aDTO = (AdminDTO)session.getAttribute("login");
		logger.debug("aDTO==="+aDTO);
		if(aDTO == null || !aDTO.getAdminId().equals("admin")) {
			return 0;
		}
		
		int result = adminService.choiceDelete(boardIdxList);
		
		return 1;
		
	}
	
	@ResponseBody
	@RequestMapping(value="/choiceDeleteWriter.do")
	public String choiceDeleteWriter(@RequestParam(value="boardWriterIdxList[]") List<String> boardWriterIdxList,HttpServletRequest request) throws JsonProcessingException {
		
		logger.debug("choiceDeleteWriter==== boardWriterIdxList"+boardWriterIdxList);
		
		HttpSession session = request.getSession();
		
		AdminDTO aDTO = (AdminDTO)session.getAttribute("login");
		logger.debug("aDTO==="+aDTO);
		if(aDTO == null || !aDTO.getAdminId().equals("admin")) {
			return "0";
		}
		
		int result = adminService.choiceDeleteWriter(boardWriterIdxList);
		
		// 삭제한 유저들의 정보를 다시 가져옴, ajax로 넘겨 처리하기 위함
		List<WriterDTO> writerList = new ArrayList<>();
		
		Iterator<String> ite = boardWriterIdxList.iterator();
		while(ite.hasNext()) {
			WriterDTO wDTO = adminService.getWriterOne(Integer.parseInt(ite.next()));
			writerList.add(wDTO);
		}
		logger.debug("writerList == "+ writerList);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		json = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(writerList);
		
		return json;
		
	}
	
	@ResponseBody
	@RequestMapping(value="/deleteSeperateBoard.do")
	public String deleteSeperateBoard(@RequestParam Map<String, Object> param, HttpServletRequest request) throws JsonProcessingException {

		HttpSession session = request.getSession();
		HashMap<String,Object> resultMap = new HashMap<>();
		
		AdminDTO aDTO = (AdminDTO)session.getAttribute("login");
		logger.debug("aDTO==="+aDTO);
		if(aDTO == null || !aDTO.getAdminId().equals("admin")) {
			return "0";
		}
		
		int boardIdx = Integer.parseInt((String) param.get("boardIdx"));
		logger.debug("deleteSeperateBoard boardIdx=="+boardIdx);
		
		int result = adminService.deleteSeperateBoard(boardIdx);
		HashMap<String, Object> recentlyDeleteBoardSeperateBoard = adminService.getRecentlyDeleteSeperateBoard(boardIdx);
		logger.debug("deleteSeperateBoard recentlyDeleteBoardSeperateBoard=="+recentlyDeleteBoardSeperateBoard);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		json = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(recentlyDeleteBoardSeperateBoard);
		
		return json;
		
	}
	
	@ResponseBody
	@RequestMapping(value="/deleteSeperateWriter.do")
	public String deleteSeperateWriter(@RequestParam Map<String, Object> param, HttpServletRequest request) throws JsonProcessingException {

		HttpSession session = request.getSession();
		HashMap<String,Object> resultMap = new HashMap<>();
		
		AdminDTO aDTO = (AdminDTO)session.getAttribute("login");
		logger.debug("aDTO==="+aDTO);
		if(aDTO == null || !aDTO.getAdminId().equals("admin")) {
			return "0";
		}
		
		int boardWriterIdx = Integer.parseInt((String) param.get("boardWriterIdx"));
		logger.debug("deleteSeperateWriter boardIdx=="+boardWriterIdx);
		
		int result = adminService.deleteSeperateWriter(boardWriterIdx);
		HashMap<String, Object> recentlyDeleteSeperateWriter = adminService.getRecentlyDeleteSeperateWriter(boardWriterIdx);
		logger.debug("deleteSeperateBoard recentlyDeleteBoardSeperateBoard=="+recentlyDeleteSeperateWriter);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		json = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(recentlyDeleteSeperateWriter);
		
		return json;
		
	}
	
	@RequestMapping(value="/adminMember.do")
	public ModelAndView adminMember(@RequestParam Map<String, Object> requestParam, WriterDTO wDTO, Criteria cri, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		AdminDTO aDTO = (AdminDTO)session.getAttribute("login");
		logger.debug("aDTO==="+aDTO);
		if(aDTO == null || !aDTO.getAdminId().equals("admin")) {
			ModelAndView mv = new ModelAndView("exception");
			mv.addObject("status","404");
			return mv;
		}
		
		if(wDTO.getKeywordType() == null || wDTO.getKeywordType().isEmpty()) {
			wDTO.setKeywordType("writerAndNameAndPhoneAndEmail");
		}
		if(wDTO.getKeyword() == null) {
			wDTO.setKeyword("");
		}
		
		if(!keyword.equals(wDTO.getKeyword())) {
			cri.setPageNum(1);
		}
		if(!keywordType.equals(wDTO.getKeywordType())) {
			cri.setPageNum(1);
		}
		
		keyword = wDTO.getKeyword();
		keywordType = wDTO.getKeywordType();
		
		String now = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		
		int allBoardCount = adminService.getAllBoardCountForAdmin();
		int todayBoardCount = adminService.getTodayBoardCountForAdmin(now);
		int allWriterCount = adminService.getAllWriterCountForAdmin();
		int todayRegistCount = adminService.getTodayRegistCountForAdmin(now);
		
		ModelAndView mv = new ModelAndView("admin_member_mgmt");
		
		int total = adminService.searchWriterCountForAdmin(wDTO);
		
		mv.addObject("total",total);
		mv.addObject("allBoardCount", allBoardCount);
		mv.addObject("todayBoardCount", todayBoardCount);
		mv.addObject("allWriterCount", allWriterCount);
		mv.addObject("todayRegistCount", todayRegistCount);
		mv.addObject("pageMaker",  new PageDTO(cri, total));
		mv.addObject("keyword", wDTO.getKeyword());
		mv.addObject("keywordType", wDTO.getKeywordType());
		mv.addObject("writerList", adminService.getWriterListForAdmin(wDTO,cri));
		
		return mv;
		
	}
	
	
	
}
