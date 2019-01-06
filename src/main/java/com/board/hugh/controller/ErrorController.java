package com.board.hugh.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("error")
public class ErrorController {
	private static final Logger logger = LoggerFactory.getLogger(ErrorController.class);
	
	@RequestMapping("throwable")
	public String throwable(HttpServletRequest request, Model model) {
		logger.info("throwable");
		errorLog(request);
		model.addAttribute("msg", "예외가 발생하였습니다.");
		
		return "error";
	}
	
	@RequestMapping("exception")
	public String exception(HttpServletRequest request, Model model) {
		logger.info("exception");
		errorLog(request);
		model.addAttribute("msg", "예외가 발생하였습니다.");
		
		return "error";
	}
	
	@RequestMapping("400")
	public String error400(HttpServletRequest request, Model model) {
		logger.info("error_code 400");
		errorLog(request);
		model.addAttribute("msg", "잘못된 요청입니다.");
		
		return "error";
	}
	
	@RequestMapping("403")
	public String error403(HttpServletRequest request, Model model) {
		logger.info("error_code 403");
		errorLog(request);
		model.addAttribute("msg", "접근이 금지되었습니다.");
		
		return "error";
	}
	
	@RequestMapping("404")
	public String error404(HttpServletRequest request, Model model) {
		logger.info("error_code 404");
		errorLog(request);
		model.addAttribute("msg", "존재하지 않는 페이지입니다.");
		
		return "error";
	}
	
	@RequestMapping("405")
	public String error405(HttpServletRequest request, Model model) {
		logger.info("error_code 405");
		errorLog(request);
		model.addAttribute("msg", "허용되지 않는 요청 방식입니다.");
		
		return "error";
	}
	
	@RequestMapping("500")
	public String error500(HttpServletRequest request, Model model) {
		logger.info("error_code 500");
		errorLog(request);
		model.addAttribute("msg", "서버에 오류가 발생하였습니다.");
		
		return "error";
	}
	
	@RequestMapping("503")
	public String error503(HttpServletRequest request, Model model) {
		logger.info("error_code 503");
		errorLog(request);
		model.addAttribute("msg", "서비스를 사용하실 수 없습니다.");
		
		return "error";
	}
	
	private void errorLog(HttpServletRequest request) {
		logger.info("status_code: " + request.getAttribute("javax.servlet.error.status_code"));
		logger.info("exception_type: " + request.getAttribute("javax.servlet.error.exception_type"));
		logger.info("message: " + request.getAttribute("javax.servlet.error.message"));
		logger.info("request_uri: " + request.getAttribute("javax.servlet.error.request_uri"));
		logger.info("exception: " + request.getAttribute("javax.servlet.error.exception"));
		logger.info("servlet_name: " + request.getAttribute("javax.servlet.error.servlet_name"));
	}
}
