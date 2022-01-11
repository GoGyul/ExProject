package com.itkey.sam.board.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.itkey.sam.board.dto.AdminDTO;
import com.itkey.sam.board.dto.BoardDTO;
import com.itkey.sam.board.dto.Criteria;
import com.itkey.sam.board.dto.FileDTO;
import com.itkey.sam.board.dto.PageDTO;
import com.itkey.sam.board.model.service.AdminService;
import com.itkey.sam.board.model.service.BoardService;
import com.itkey.sam.board.model.service.FileService;
import com.itkey.sam.board.model.service.WriterService;
import com.itkey.sam.util.FileUtils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
public class BoardController {
	// Logback logger (package : org.slf4j.Logger & org.slf4j.LoggerFactory)
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	// Dependency Injection With BoardService
	@Autowired BoardService boardService;
	
	@Autowired WriterService writerService;
	
	@Autowired FileService fileService;
	
	@Autowired AdminService adminService;
	
	static String keyword = "";
	static String keywordType = "";

	/**
	 * @param  requestParam 
	 * @Method Post
	 * @return ModelAndView
	 * @url    [default] http://localhost:8080/sam/main.do 
	 * @throws Exception
	 */
	@RequestMapping(value = "/main.do")
	public ModelAndView sample(@RequestParam Map<String, Object> requestParam, BoardDTO bDTO, Criteria cri) throws Exception {
		// Logger
		logger.debug("Board List Page Response");
		
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
		
		int allBoardCount = boardService.getAllBoardCount();
		int todayBoardCount = boardService.getTodayBoardCount(now);
		int allWriterCount = writerService.getAllWriterCount();
		int todayRegistCount = writerService.getTodayRegistCount(now);
		
		int total = boardService.searchBoardCount(bDTO);
		
		logger.debug("Board List total =="+total);
		
		ModelAndView mv = new ModelAndView("main");
		
		mv.addObject("total",total);
		mv.addObject("allBoardCount", allBoardCount);
		mv.addObject("todayBoardCount", todayBoardCount);
		mv.addObject("allWriterCount", allWriterCount);
		mv.addObject("todayRegistCount", todayRegistCount);
		mv.addObject("pageMaker",  new PageDTO(cri, total));
		mv.addObject("keyword", bDTO.getKeyword());
		mv.addObject("keywordType", bDTO.getKeywordType());
		mv.addObject("boardList", boardService.getBoardList(bDTO,cri));
		logger.debug("getBoardList",boardService.getBoardList(bDTO,cri));

		return mv;
	}
	
	@RequestMapping(value = "/write.do")
	public String writeForm() {
		return "write";
	}
	
	@RequestMapping(value = "/writeBoard.do")
	public String writeBoard(@RequestParam Map<String, Object> param, MultipartHttpServletRequest mhsr) throws IOException {
		
		FileUtils fileUtils = new FileUtils();
		List<FileDTO> fileList = fileUtils.parseFileInfo(mhsr);
		
		if(CollectionUtils.isEmpty(fileList) == false) {
			int fileIdx = fileService.getMaxFileIdx();
			fileList.get(0).setFileIdx(fileIdx);
			param.put("fileIdx", fileIdx);
			fileService.insertFile(fileList);
			int result = boardService.insertBoard(param);
			
		}else {
			param.put("fileIdx", null);
			int result = boardService.insertBoard(param);
		}
		
		return "redirect:/main.do";
	}
	
	@RequestMapping(value = "/getBoard.do")
	public ModelAndView getBoard(@RequestParam int boardIdx, String keywordType, String keyword, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		logger.debug("getBoard 키워드 타입과 키워드"+keywordType+","+keyword);
		
		ModelAndView mv = new ModelAndView("detail");
		
		Map<String,Object> param = new HashMap<>();
		param.put("boardIdx", boardIdx);
		param.put("keywordType", keywordType);
		param.put("keyword", keyword);
		
		boardService.increaseCountBoard(boardIdx);
		
		//관리자
		String id = (String)session.getAttribute("loginId");
		logger.debug("id==="+id);
		if(id!=null) {
			if( id.equals("ADMIN")) {
				logger.debug("aDTO=========== 관리자");
				
				HashMap<String,Object> detailBoard = adminService.getDetailBoardForAdmin(boardIdx);
				HashMap<String,Object> nextBoard = adminService.getNextBoardForAdmin(param);
				HashMap<String,Object> prevBoard = adminService.getPrevBoardForAdmin(param);
				
				if(detailBoard.get("FILE_ORIGINAL_NAME") == null) {
					detailBoard.put("FILE_ORIGINAL_NAME", null);
				}
				
				mv.addObject("nextBoard",nextBoard);
				mv.addObject("prevBoard",prevBoard);
				mv.addObject("keywordType",param.get("keywordType"));
				mv.addObject("keyword",param.get("keyword"));
				mv.addObject("detailBoard",detailBoard);
				
				return mv;
			}
		}
		
		//일반 유저
		HashMap<String,Object> detailBoard = boardService.getDetailBoard(boardIdx);
		HashMap<String,Object> nextBoard = boardService.getNextBoard(param);
		HashMap<String,Object> prevBoard = boardService.getPrevBoard(param);
		
		if(detailBoard.get("FILE_ORIGINAL_NAME") == null) {
			detailBoard.put("FILE_ORIGINAL_NAME", null);
		}
		
		mv.addObject("nextBoard",nextBoard);
		mv.addObject("prevBoard",prevBoard);
		mv.addObject("keywordType",param.get("keywordType"));
		mv.addObject("keyword",param.get("keyword"));
		mv.addObject("detailBoard",detailBoard);
		
		return mv;
		
	}
	
	@RequestMapping(value ="/sercretBoard.do")
	public ModelAndView sercretBoard(@RequestParam Map<String, Object> param, HttpServletRequest request) {
		
		logger.debug("param" + param);
		
		HttpSession session = request.getSession();
		
		
		if( session.getAttribute("login") != null ){
	         String id = (String)session.getAttribute("loginId"); 
	         logger.debug("세션 id" + id);
	         
	         if(id.equals(param.get("boardWriter"))) {
	        	 
	        	 ModelAndView mv = new ModelAndView("detail");
	        	 int boardIdx = Integer.parseInt(param.get("boardIdx").toString());
	        	 HashMap<String,Object> secretBoard = boardService.getSecretBoard(boardIdx);
	        	 boardService.increaseCountBoard(boardIdx);
	        	 mv.addObject("detailBoard",secretBoard);
	        	 
		         return mv;
	         }else {
	        	 ModelAndView mv = new ModelAndView("exception");
	        	 mv.addObject("status","잘못된 접근 입니다.");
	 	    	 return mv;
	         }
	         
	    }else {
	    	ModelAndView mv = new ModelAndView("exception");
	    	mv.addObject("status","잘못된 접근 입니다.");
	    	return mv;
	    }
		
	}
	
	@RequestMapping(value ="/update.do")
	public ModelAndView update(int boardIdx, String boardPublicFl, String boardWriter, HttpServletRequest request) {
		
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("loginId"); 
		
		if(boardPublicFl.equals("N")) {
			
			if(session.getAttribute("login") == null || !id.equals(boardWriter) ) {
				ModelAndView mv = new ModelAndView("exception");
				System.out.println("들어옴");
				mv.addObject("status","잘못된 접근 입니다.");
				return mv;
			}
			
			HashMap<String,Object> detailBoard = boardService.getDetailSecretBoard(boardIdx);
			ModelAndView mv = new ModelAndView("update");
			mv.addObject("detailBoard",detailBoard);
			return mv;
			
		}
		ModelAndView mv = new ModelAndView("update");
		HashMap<String,Object> detailBoard = boardService.getDetailBoard(boardIdx);
		mv.addObject("detailBoard",detailBoard);
		
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="/doUpdate.do")
	public int doUpdate(@RequestParam Map<String, Object> param, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("login") != null) {
			
			String id = (String)session.getAttribute("loginId"); 
			
			if(id.equals(param.get("boardWriter"))) {
				
				logger.debug("param"+param);
				
				int result = boardService.updateBoard(param);
				logger.debug("result=="+result);
				return 1;
				
			}else {
				
				return 0;
				
			}
			
		}else {
			
			return 0;
			
		}
		
	}
	
	@ResponseBody
	@RequestMapping(value="/doDelete.do")
	public int doDelete(@RequestParam Map<String, Object> param, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("login") != null) {
			
			String id = (String)session.getAttribute("loginId"); 
			
			if(id.equals(param.get("boardWriter"))) {
				
				logger.debug("param"+param);
				
				int result = boardService.deleteBoard(param);
				logger.debug("result=="+result);
				return 1;
				
			}else {
				return 0;
			}
			
		}else {
			
			return 0;
			
		}
		
	}
	
}
