package com.itkey.sam.board.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itkey.sam.board.dto.BoardDTO;
import com.itkey.sam.board.dto.Criteria;
import com.itkey.sam.board.dto.FileDTO;
import com.itkey.sam.board.dto.PageDTO;
import com.itkey.sam.board.model.service.BoardForAjaxService;
import com.itkey.sam.board.model.service.FileForAjaxService;
import com.itkey.sam.board.model.service.WriterForAjaxService;
import com.itkey.sam.util.FileUtils;

@Controller
public class BoardForAjaxController {

	static String keyword = "";
	static String keywordType = "";
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired WriterForAjaxService writerForAjaxService;
	
	@Autowired BoardForAjaxService boardForAjaxService;
	
	@Autowired FileForAjaxService fileForAjaxService;
	
	@RequestMapping(value = "/ajaxMain.do" )
	public ModelAndView ajaxMain() {
		
		ModelAndView mv = new ModelAndView("ajaxmain");
		
		return mv;
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/boardListForAjax.do")
	public String boardListForAjax(@RequestParam Map<String,Object> param, BoardDTO bDTO, Criteria cri,HttpServletRequest request) throws JsonProcessingException {
		
		Map<String, Object> map = new HashMap<String,Object>();
		
		logger.debug("boardListForAjax", param.get("keyword"));
		logger.debug("checkIdForAjax logOn user check");
		logger.debug("bDTO ================================ "+bDTO.getKeyword());
		logger.debug("bDTO ================================ "+bDTO.getKeywordType());
		Enumeration<?> paramKeys = request.getParameterNames();
		while (paramKeys.hasMoreElements()) {
		     String key = (String)paramKeys.nextElement();
		     logger.info(key+":"+request.getParameter(key));
		}
		
		if(bDTO.getKeywordType() == null || bDTO.getKeywordType().isEmpty()) {
			bDTO.setKeywordType("writerAndContent");
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
		logger.debug("boardListForAjax bDTO === "+ bDTO);
		int total = boardForAjaxService.searchBoardCountForAjax(bDTO);
		
		keyword = bDTO.getKeyword();
		keywordType = bDTO.getKeywordType();
		
		logger.debug("bDTO ================================ "+bDTO.getKeyword());
		logger.debug("bDTO ================================ "+bDTO.getKeywordType());
		
		String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		param.put("today", today);
		
		map.put("today",  today);
		map.put("pageMaker",  new PageDTO(cri, total));
		map.put("keyword", bDTO.getKeyword());
		map.put("keywordType", bDTO.getKeywordType());
		map.put("countBoard", boardForAjaxService.countBoardForAjax(map));
		map.put("countWriter", writerForAjaxService.countWriterForAjax(map));
		map.put("todayCountBoard", boardForAjaxService.todayCountBoardForAjax(today));
		map.put("todayCountWriter", writerForAjaxService.todayCountWriterForAjax(today));
		map.put("boardList", boardForAjaxService.getBoardListForAjax(bDTO,cri));
		
		logger.debug("map == " + map);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		json = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(map);
		
		return json;
		
	}
	
	@ResponseBody
	@RequestMapping(value ="/selectBoardForAjax.do")
	public String selectBoardForAjax (@RequestParam Map<String, Object> param) throws JsonProcessingException {
		
		//	파라미터로 들어오는 값들을 BoardDTO 객체에 담고 해당 게시글을 찾음
		Map<String, Object> map = new HashMap<String, Object>();
		BoardDTO bDTO = new BoardDTO();
		bDTO.setBoardIdx(param.get("boardIdx").toString());
		bDTO.setBoardWriter(param.get("boardWriter").toString());
		
		bDTO = boardForAjaxService.getBoardForAjax(bDTO);
		bDTO.setKeywordType(param.get("keywordType").toString());
		bDTO.setKeyword(param.get("keyword").toString());
	
		//	상세보기한 게시판 기준으로 전,후 게시글 가져오는 로직
		map.put("boardInfo",bDTO);
		map.put("nextBoard", boardForAjaxService.getNextBoardForAjax(bDTO));
		map.put("prevBoard", boardForAjaxService.getPrevBoardForAjax(bDTO));
		
		logger.debug("param DTO =================== "+ bDTO.toString());
		
		//	파일이 있는 게시글일시 FileDTO 에 값을 세팅해서 map에 담아 던져줌
		FileDTO fDTO = new FileDTO();
		if(bDTO.getFileIdx() == null || bDTO.getFileIdx().equals("")) {
			map.put("fileInfo", null);
		}else {
			fDTO.setFileIdx(Integer.parseInt(bDTO.getFileIdx()));
			fDTO = fileForAjaxService.getWriterFileInfoForAjax(fDTO.getFileIdx());
			map.put("fileInfo", fDTO);
		}
		
		//	조회수 로직 실행
		int result = boardForAjaxService.increaseBoardCountForAjax(bDTO);
		
//		map.put("nextBoard", boardForAjaxService.getNextBoardForAjax(bDTO));
		
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		json = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(map);
		
		return json;
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/boardWriteForAjax.do", method = RequestMethod.POST)
	public String boardWriteForAjax(MultipartHttpServletRequest request) throws IOException {
		
		System.out.println("들어옴===================");
		Map<String,Object> param = new HashMap<String,Object>();
		
		logger.debug("boardWriteForAjax controller input");
		Enumeration<?> paramKeys = request.getParameterNames();
		while (paramKeys.hasMoreElements()) {
		     String key = (String)paramKeys.nextElement();
		     logger.info(key+":"+request.getParameter(key));
		}
		
		//	파라미터로 받는 값들을 BoardDTO와 fileList 변수에 담아줌
		BoardDTO bDTO = new BoardDTO();
		
		FileUtils fileUtils = new FileUtils();
		List<FileDTO> fileList = fileUtils.parseFileInfo(request);
		logger.debug("boardWriteForAjax fileList"+fileList);
		
		bDTO.setBoardContents(request.getParameter("boardContents"));
		bDTO.setBoardTitle(request.getParameter("boardTitle"));
		bDTO.setBoardWriter(request.getParameter("boardWriter"));
		bDTO.setBoardPublicFl(request.getParameter("boardPublicFl"));
		//bDTO.setBoardIdx(request.getParameter("boardIdx"));
		
		//	파일이 없는 게시글일시 insertBoard 로직만 실행
		if(CollectionUtils.isEmpty(fileList) == true) {
			int result = boardForAjaxService.insetBoardForAjax(bDTO);
			if(result == 1) {
				return "1";
			}else {
				return "0";
			}
		//	파일이 있으면 insertFile과 insertBoard 로직 실행
		}else {
			int fileIdx = fileForAjaxService.getNewFileIdx();
			bDTO.setFileIdx(Integer.toString(fileIdx));
			int result = boardForAjaxService.insetBoardForAjax(bDTO);
			
			for(int i = 0; i<fileList.size(); i++) {
				fileList.get(i).setFileIdx(fileIdx);
				fileIdx++;
			}
			
			int fileResult = fileForAjaxService.insertBoardFileForAjax(fileList);
			logger.debug("boardWriteForAjax fileIdx"+fileIdx);
			
			if(result == 1 || fileResult > 0) {
				return "1";
			}else {
				return "0";
			}
			
		}
	}
	
	@ResponseBody
	@RequestMapping(value ="/deleteBoardForAjax.do")
	public String deleteBoardForAjax(@ModelAttribute BoardDTO bDTO) {
		logger.debug("deleteBoardForAjax controller input " ); 
		logger.debug("deleteBoardForAjax controller input BoardDTO = "+ bDTO.toString());
		
		int result = boardForAjaxService.deleteBoardForAjax(bDTO);
		
		if(result == 1) {
			return "succes";
		}else {
			return "fail";
		}
		
	}
	
	
	@RequestMapping(value = "/fileDownForAjax.do")
	public Object fileDownForAjax(@RequestParam Map<String, Object> param, HttpServletResponse response, HttpServletRequest request) throws IOException {
		
		int fileIdx = Integer.parseInt((String)param.get("fileIdx")); 
		logger.debug("fileDownForAjax fileIdx ====== "+ fileIdx);
		
		FileDTO fDTO = fileForAjaxService.getFileForDownForAjax(fileIdx);
		logger.debug("fileDownForAjax fDTO ====== "+ fDTO.toString());
			
		File file = new File(fDTO.getFilePath(), fDTO.getFileOriginalName());
		
		logger.debug("file  ========================="+file);
		
		if(file.exists()) {
			logger.debug("파일이 존재함 =========================");
			ModelAndView mv = new ModelAndView("downLoadView");
			mv.addObject("downLoadFile", file);
			mv.addObject("fileOriginalName", fDTO.getFileOriginalName());
			return mv;
		}else {
			logger.debug("파일이 존재하지 않음 =========================");
			return "fail";
		}
        
	}
	
	@ResponseBody
	@RequestMapping(value = "/updateView.do")
	public String updateView(@RequestParam Map<String,Object> param) throws JsonProcessingException {
		
		Map<String, Object> map = new HashMap<String, Object>();
		BoardDTO bDTO = new BoardDTO();
		bDTO.setBoardIdx(param.get("boardIdx").toString());
		bDTO.setBoardWriter(param.get("boardWriter").toString());
		
		bDTO = boardForAjaxService.getBoardForAjax(bDTO);
		map.put("boardInfo",bDTO);
		
		FileDTO fDTO = new FileDTO();
		if(bDTO.getFileIdx() == null || bDTO.getFileIdx().equals("")) {
			map.put("fileInfo", null);
		}else {
			fDTO.setFileIdx(Integer.parseInt(bDTO.getFileIdx()));
			fDTO = fileForAjaxService.getWriterFileInfoForAjax(fDTO.getFileIdx());
			map.put("fileInfo", fDTO);
		}
		
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		json = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(map);
		
		return json;
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/boardUpdateForAjax.do", method = RequestMethod.POST)
	public String boardUpdateForAjax(MultipartHttpServletRequest request) throws IOException {
		
		Map<String,Object> param = new HashMap<String,Object>();
		
		logger.debug("boardUpdateForAjax controller input");
		Enumeration<?> paramKeys = request.getParameterNames();
		while (paramKeys.hasMoreElements()) {
		     String key = (String)paramKeys.nextElement();
		     logger.info(key+":"+request.getParameter(key));
		}
		
		BoardDTO bDTO = new BoardDTO();
		
		FileUtils fileUtils = new FileUtils();
		List<FileDTO> fileList = fileUtils.parseFileInfo(request);
		logger.debug("boardWriteForAjax fileList"+fileList);
		
		bDTO.setBoardContents(request.getParameter("boardContents"));
		bDTO.setBoardTitle(request.getParameter("boardTitle"));
		bDTO.setBoardWriter(request.getParameter("boardUpdateWriter"));
		bDTO.setBoardPublicFl(request.getParameter("boardPublicFl"));
		bDTO.setBoardIdx(request.getParameter("boardIdx"));
		
		if(CollectionUtils.isEmpty(fileList) == true) {
			int result = boardForAjaxService.updateBoardForAjax(bDTO);
			if(result == 1) {
				return "1";
			}else {
				return "0";
			}
		}else {
			int fileIdx = fileForAjaxService.getNewFileIdx();
			bDTO.setFileIdx(Integer.toString(fileIdx));
			int result = boardForAjaxService.updateBoardForAjax(bDTO);
			
			for(int i = 0; i<fileList.size(); i++) {
				fileList.get(i).setFileIdx(fileIdx);
				fileIdx++;
			}
			
			int fileResult = fileForAjaxService.insertBoardFileForAjax(fileList);
			logger.debug("boardWriteForAjax fileIdx"+fileIdx);
			
			if(result == 1 || fileResult > 0) {
				return "1";
			}else {
				return "0";
			}
		}	
		
	}
	
	
	
}
