package com.itkey.sam.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.itkey.sam.board.dto.AdminDTO;
import com.itkey.sam.board.dto.WriterDTO;

public class MyInterceptor extends HandlerInterceptorAdapter  {

	@Override
	public boolean preHandle(
			HttpServletRequest request, HttpServletResponse response,
			Object obj) throws Exception {
		
		HttpSession session = request.getSession();
		WriterDTO wDTO = (WriterDTO)session.getAttribute("login");
		
		if(wDTO == null) {
			response.sendRedirect("/sam/login.do");
			return false;
		}
		return true;
		
	}
	
}
