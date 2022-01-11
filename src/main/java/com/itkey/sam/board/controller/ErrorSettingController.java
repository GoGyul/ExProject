package com.itkey.sam.board.controller;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ErrorSettingController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@GetMapping("/error400")
	public String error400(HttpServletResponse res, Model model) {
		
		model.addAttribute("status", "400");

		logger.debug("error400 == "+model);
		
		return "exception";
	}
	
	@GetMapping("/error404")
	public String error404(HttpServletResponse res, Model model) {
		
		model.addAttribute("status", "404");

		logger.debug("error404 == "+model);
		
		return "exception";
	}
	
	@GetMapping("/error405")
	public String error405(HttpServletResponse res, Model model) {
		
		model.addAttribute("status", "405");

		logger.debug("error405 == "+model);
		
		return "exception";
	}
	
	@GetMapping("/error500")
	public String error500(HttpServletResponse res, Model model) {
		
		model.addAttribute("status", "500");

		logger.debug("error500 == "+model);
		
		return "exception";
	}
	
	@GetMapping("/error503")
	public String error503(HttpServletResponse res, Model model) {
		
		model.addAttribute("status", "503");

		logger.debug("error503 == "+model);
		
		return "exception";
	}
	
}
