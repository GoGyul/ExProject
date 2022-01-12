package com.itkey.sam.board.controller;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itkey.sam.board.dto.FileDTO;
import com.itkey.sam.board.dto.WriterDTO;
import com.itkey.sam.board.model.service.FileForAjaxService;
import com.itkey.sam.board.model.service.WriterForAjaxService;
import com.itkey.sam.util.AES256Util;
import com.itkey.sam.util.FileUtils;

@Controller
public class WriterForAjaxController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired WriterForAjaxService writerForAjaxService;
	
	@Autowired FileForAjaxService fileForAjaxService;
	
	@ResponseBody
	@RequestMapping(value = "/sessionForAjax.do")
	public Map<String,Object> sessionForAjax(@RequestParam Map<String,Object> param, HttpSession session){
		
		logger.debug("sessionForAjax");
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		WriterDTO wDTO = (WriterDTO)session.getAttribute("login");
		
		if(wDTO==null) {
			return map;
		}
		
		map.put("login", session.getAttribute("login"));
		map.put("loginId", session.getAttribute("loginId"));
		map.put("loginName", session.getAttribute("loginName"));
		map.put("loginFileInfo", session.getAttribute("loginFileInfo"));
		map.put("selPage", session.getAttribute("selPage"));
		map.put("keywordType", session.getAttribute("keywordType"));
		map.put("keyword", session.getAttribute("keyword"));
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/checkIdForAjax.do", method = RequestMethod.POST)
	public int checkIdForAjax(HttpServletRequest request ) {
		logger.debug("checkIdForAjax logOn user check");
		Enumeration<?> paramKeys = request.getParameterNames();
		while (paramKeys.hasMoreElements()) {
		     String key = (String)paramKeys.nextElement();
		     logger.info(key+":"+request.getParameter(key));
		}
		
		String boardWriter = (String)request.getParameter("boardWriter");
		
		int result = writerForAjaxService.isExistWriterByWriterId(boardWriter);
		
		logger.debug("checkIdForAjax request boardWriter == ", boardWriter);
		logger.debug("isExistWriterByWriterId result == ", result);
		
		return result;
		
	}
	 
	@ResponseBody
	@RequestMapping(value = "/registerForAjax.do",method = RequestMethod.POST)
	public String registerForAjax(MultipartHttpServletRequest request) throws IOException {
		
		Map<String,Object> param = new HashMap<String,Object>();
		
		logger.debug("registerForAjax");
		Enumeration<?> paramKeys = request.getParameterNames();
		while (paramKeys.hasMoreElements()) {
		     String key = (String)paramKeys.nextElement();
		     logger.info(key+":"+request.getParameter(key));
		}
		
		FileUtils fileUtils = new FileUtils();
		List<FileDTO> fileList = fileUtils.parseFileInfo(request);
		logger.debug("registerForAjax fileList"+fileList);
		
		int fileIdx = fileForAjaxService.getNewFileIdx();
		logger.debug("registerForAjax fileIdx"+fileIdx);
		
		fileList.get(0).setFileIdx(fileIdx);
		
		String requestPw = (String)request.getParameter("boardWriterPw");
		String salt = AES256Util.generateSalt();
		String inputPw = AES256Util.getEncrypt(requestPw, salt);
		
		param.put("boardWriter", request.getParameter("boardWriter"));
		param.put("boardWriterName", request.getParameter("boardWriterName"));
		param.put("boardWriterEmail", request.getParameter("boardWriterEmail"));
		param.put("boardWriterPhone", request.getParameter("boardWriterPhone"));
		param.put("boardWriterPw", inputPw);
		param.put("fileIdx", fileIdx);
		param.put("salt", salt);
		param.put("delYn", "N");
		param.put("fileOriginalName", fileList.get(0).getFileOriginalName());
		param.put("fileChangedName", fileList.get(0).getFileChangedName());
		param.put("filePath", fileList.get(0).getFilePath());
		
		int insertWriterResult = writerForAjaxService.insertWriterForAjax(param);
		int insertFileResult = fileForAjaxService.insertWriterProfileForAjax(param);
		
		logger.debug("registerForAjax param =="+param);
		
		if(insertWriterResult == 1 && insertFileResult==1) {
			return "1";
		}
		
		return "0";
	}
	
	@ResponseBody
	@RequestMapping(value ="/loginCheckForAjax.do")
	public String loginCheckForAjax(@RequestParam Map<String,Object> param, HttpServletRequest request) {
		
		logger.debug("loginCheckForAjax param === "+ param);
		
		WriterDTO wDTO = null;
		String boardWriter = (String)param.get("boardWriter");
		String boardWriterPw = (String)param.get("boardWriterPw");
		
		// 아이디 확인 
		int idCheck = writerForAjaxService.isExistWriterByWriterId(boardWriter);
		if(idCheck == 0) {
			return "0";
		}
		
		// 탈퇴회원 확인
		wDTO = writerForAjaxService.getWriterByWriterIdForAjax(boardWriter);
		logger.debug("loginCheckForAjax wDTO == "+wDTO);
		if(wDTO.getDelYN().equals("Y")) {
			return "0";
		}
		
		// 비밀번호 확인
		String salt = wDTO.getSalt();
		String chkPw = AES256Util.getEncrypt(boardWriterPw, salt);
		if(!chkPw.equals(wDTO.getBoardWriterPW())) {
		 return "2";	
		}
		
		return "1";
		
	}
	
	@ResponseBody
	@RequestMapping(value ="/loginForAjax.do")
	public String loginForAjax(@RequestParam Map<String, Object> param, HttpServletRequest request) throws JsonProcessingException {
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		HttpSession session = request.getSession();
		logger.debug("loginForAjax param==================="+param);
		
		WriterDTO wDTO = null;
		wDTO = writerForAjaxService.getWriterByWriterIdForAjax((String)param.get("boardWriter"));
		
		FileDTO fDTO = fileForAjaxService.getWriterFileInfoForAjax(wDTO.getFileIDX());
		wDTO.setOriginalFileName(fDTO.getFileOriginalName());
		
		if(session.getAttribute("login") != null ){
			logger.debug("loginId ===================== in session"+(String)session.getAttribute("loginId"));
	         session.removeAttribute("login"); 
	         session.invalidate();
	    }
		
		session.setAttribute("login", wDTO);
		session.setAttribute("loginId", wDTO.getBoardWriter());
		session.setAttribute("loginName", wDTO.getBoardWriterName());
		session.setAttribute("loginFileInfo", fDTO);
		logger.debug("loginForAjax END===================END");
		
		map.put("login", wDTO);
		map.put("loginId", wDTO.getBoardWriter());
		map.put("loginName", wDTO.getBoardWriterName());
		map.put("loginImg", fDTO.getFileOriginalName());
		
		ObjectMapper mapper = new ObjectMapper();
		String json = "";
		json = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(map);
		
		return json;
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/logoutForAjax.do")
	public String logoutForAjax(@RequestParam Map<String,Object> param, HttpServletRequest request ) {
		logger.debug("logoutForAjax");
		
		HttpSession session = request.getSession();
		
		Object obj = session.getAttribute("login");
		String admin = (String)session.getAttribute("loginId");
		
		
		session.removeAttribute("login");
		session.removeAttribute("loginId");
		session.removeAttribute("loginName");
		session.removeAttribute("loginImg");
		session.invalidate();
		
		return "0";
		
	}
	
	
	
}
