package com.itkey.sam.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.itkey.sam.board.dto.AdminDTO;
import com.itkey.sam.board.dto.FileDTO;
import com.itkey.sam.board.dto.WriterDTO;
import com.itkey.sam.board.model.service.AdminService;
import com.itkey.sam.board.model.service.FileService;
import com.itkey.sam.board.model.service.WriterService;
import com.itkey.sam.util.AES256Util;
import com.itkey.sam.util.FileUtils;

@Controller
public class WriterController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private WriterService writerService;
	
	@Autowired
	private FileService fileService;
	
	@Autowired
	private AdminService adminService;
	
	@RequestMapping(value = "/login.do")
	public String loginView() {
		logger.debug("login page");
		return "login";
	}
	
	@ResponseBody
	@RequestMapping(value ="/checkId.do", method = RequestMethod.POST)
	public int checkId(@RequestParam Map<String, Object> param) {
		logger.debug("logOn user check");
		Map<String, Object> map = new HashMap<String, Object>();
		
		String writerId = (String)param.get("username");
		
		boolean isExist = writerService.isExistWriter(writerId);
		
		if(isExist) {
			
			return 1;
			
		}else {
			logger.debug("일치하는 아이디가 없음");
			map.put("f-1", 0);
			return 0;
		}
		
	}
	
	@ResponseBody
	@RequestMapping(value ="/logOn.do", method = RequestMethod.POST)
	public int logOn(@RequestParam Map<String, Object> param, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		logger.debug("logOn user check");
		
		WriterDTO wDTO = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		String writerId = (String)param.get("username");
		String writerPass = (String)param.get("password");
		
		// 관리자 로그인 
		if(writerId.equals("ADMIN") && writerPass.equals("1234")) {
			logger.debug("관리자 로그인"+writerId+","+writerPass);
			
			AdminDTO aDTO = new AdminDTO();
			aDTO = adminService.getAdmin(param);
			aDTO.setBoardWriter("ADMIN");
			
			session.setAttribute("login", aDTO);
			session.setAttribute("loginId", aDTO.getBoardWriter());
			
			return 11;
		}
		
		boolean isExist = writerService.isExistWriter(writerId);
		
		// 일반회원 로그인
		if(isExist) {
			
			logger.debug("일치하는 아이디가 있음");
			wDTO = writerService.getWriterByWriterId(writerId);
			
			if(wDTO.getDelYN().equals("Y")) {
				return 0;
			}
			
			String salt = wDTO.getSalt();
			String pass = AES256Util.getEncrypt(writerPass, salt);
			
			if(wDTO.getBoardWriterPW().equals(pass)) {
				
				if(session.getAttribute("login") != null ){
			         // 기존에 login이란 세션 값이 존재한다면
			         session.removeAttribute("login"); // 기존값을 제거해 준다.
			    }
				
				FileDTO fDTO = (FileDTO)fileService.getProfileFileByFileIdx(wDTO.getFileIDX());
				wDTO.setOriginalFileName(fDTO.getFileOriginalName());
				
				session.setAttribute("login", wDTO); // 세션에 login이란 이름으로 wDTO 객체를 저장해 놈.
		        session.setAttribute("loginId", wDTO.getBoardWriter());
				
				logger.debug("아이디, 비밀번호 일치, 로그인 성공"+wDTO);
				
				return 10;
				
			}else {
				logger.debug("비밀번호 불일치, 로그인 실패"+wDTO);
				return 1;
			}
			
		}else {
			logger.debug("일치하는 아이디가 없음");
			map.put("f-1", 0);
			return 0;
		}
		
	}
		
	@RequestMapping(value = "/register.do")
	public String register()  {
		return "register";
		
	}
	
	@RequestMapping(value = "/doRegister.do")
	public String doRegister(@RequestParam Map<String,Object> param
            , MultipartHttpServletRequest mhsr) throws IOException  {
		
		String salt = AES256Util.generateSalt();
		param.put("salt", salt);
		
		String password = (String)param.get("boardWriterPw");
		password = AES256Util.getEncrypt(password, salt);
		param.put("boardWriterPw", password);
		
		FileUtils fileUtils = new FileUtils();
		List<FileDTO> fileList = fileUtils.parseFileInfo(mhsr);
		
		if(CollectionUtils.isEmpty(fileList) == false) {
			int fileIdx = fileService.getMaxFileIdx();
			fileList.get(0).setFileIdx(fileIdx);
			fileService.insertFile(fileList);
			param.put("fileIdx", fileIdx);
			
			int result = writerService.insertWriter(param);
		}

		return "login";
	}
	
	@RequestMapping(value = "/logout.do")
	public String logout(HttpSession session,HttpServletRequest request, HttpServletResponse response) {
		
		Object obj = session.getAttribute("login");
		String admin = (String)session.getAttribute("loginId");
		
		if(admin.equals("ADMIN")) {
			session.removeAttribute("login");
			session.invalidate();
			return "redirect:/login.do";
		}
		
		if(obj != null) {
			WriterDTO wDTO = (WriterDTO)obj;
			session.removeAttribute("login");
			session.invalidate();
		}
		
		return "redirect:/login.do";
		
	}
	
	@ResponseBody
	@RequestMapping(value="/modifyWriter.do")
	public int modifyWriter(@RequestParam String boardWriter, HttpSession session) {
		logger.debug("modifyWriter.do boardWriter ===="+boardWriter);
		
		Object obj = session.getAttribute("login");
		logger.debug("modifyWriter.do obj ===="+obj);
		String sessionId = (String) session.getAttribute("loginId");
		logger.debug("modifyWriter.do sessionId ===="+sessionId);
		if(obj == null || !sessionId.equals(boardWriter)) {
			return 0;
		}
		
		return 1;
		
	}
	
	@RequestMapping(value = "/modifyWriterView.do")
	public ModelAndView modifyWriterView(@RequestParam String boardWriter, HttpSession session) {
		
		ModelAndView mv = new ModelAndView("modify");
		
		mv.addObject("writer", writerService.getWriterAndFileInfoByWriterId(boardWriter));
				
		return mv;		
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/modifyWriterProcess.do")
	public int modifyWriterProcess( @RequestParam Map<String,Object> param
            ,HttpSession session){
		
		logger.debug("modifyWriterProcess param =="+param);
		
		WriterDTO wDTO = (WriterDTO)session.getAttribute("login");
		
		if(wDTO == null || !param.get("boardWriter").equals(wDTO.getBoardWriter()) ) {
			return 0;
		}
		
		String salt = AES256Util.generateSalt();
		param.put("salt", salt);
		
		String password = (String)param.get("boardWriterPw");
		password = AES256Util.getEncrypt(password, salt);
		param.put("boardWriterPw", password);
		
		logger.debug("modifyWriterProcess param =="+param);
		
		int result = writerService.updateWriter(param);
		logger.debug("modifyWriterProcess result =="+result);
		
		// 수정된  DTO 세션에 다시 넣어줌
		wDTO = writerService.getWriterByWriterId(wDTO.getBoardWriter());
		
		if ( session.getAttribute("login") != null ){
	         session.removeAttribute("login");
	         session.removeAttribute("loginId");
	      }
		
		session.setAttribute("login", wDTO); 
        session.setAttribute("loginId", wDTO.getBoardWriter());
		
		return 1;
		
	}
	
	@RequestMapping(value= "/uploadFileAjax.do")
    @ResponseBody
    public int uploadUtil(MultipartHttpServletRequest mhsr,String fileIdx, String boardWriter ,HttpSession session) throws IOException {
        		
		WriterDTO wDTO = (WriterDTO)session.getAttribute("login");
		
		if(wDTO == null || !boardWriter.equals(wDTO.getBoardWriter()) ) {
			return 0;
		}
		
        FileUtils fileUtils = new FileUtils();
		List<FileDTO> fileList = fileUtils.parseFileInfo(mhsr);
		
		logger.debug("uploadUtil=="+fileList);
		
		if(CollectionUtils.isEmpty(fileList) == false) {
			
			int parseIdx = Integer.parseInt(fileIdx);
			fileList.get(0).setFileIdx(parseIdx);
			int result = fileService.updateWriterProfileFile(fileList);
			
			return 1;
			
		}
		
        return 0;
            
    }
	
	@ResponseBody
	@RequestMapping(value ="/doWithdraw.do")
	public int doWithdraw( @RequestParam Map<String,Object> param
            ,HttpSession session) {
		
		logger.debug("doWithdraw param == "+param);
		
		WriterDTO wDTO = (WriterDTO)session.getAttribute("login");
		if(wDTO == null || !param.get("boardWriter").equals(wDTO.getBoardWriter()) ) {
			return 0;
		}
		
		int result = writerService.withdrawWriter(param);
		logger.debug("doWithdraw result"+result);
		session.removeAttribute("login");
		session.removeAttribute("loginID");
		session.invalidate();
		
		return 1;
		
	}
	
	
	
	
}
