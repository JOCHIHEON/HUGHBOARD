package com.board.hugh.controller;

import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.WebUtils;

import com.board.hugh.config.PassEncryption;
import com.board.hugh.dto.LoginDTO;
import com.board.hugh.service.UserService;
import com.board.hugh.vo.UserVO;

@Controller
@RequestMapping("user")
public class UserController {
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private UserService userService;
	
	// 일반 로그인
	@RequestMapping(value="login", method=RequestMethod.GET)
	public String loginGET() {
		
		return "user/login";
	}
	
	@RequestMapping(value="loginPost", method=RequestMethod.POST)
	public void loginPOST(LoginDTO lDTO, Model model, HttpSession session) throws Exception {
		lDTO.setpw(PassEncryption.encPwd(lDTO.getpw()));
		UserVO uVO = userService.login(lDTO);
		
		if (uVO == null) {
			return;
		}
		
		model.addAttribute("uVO", uVO);
		
		if (lDTO.isUsecookie()) {
			int amount = 60 * 60 * 24 * 7;
			Date sessionlimit = new Date(System.currentTimeMillis() + (1000 * amount));
			
			userService.updateForCookie(uVO.getUid(), session.getId(), sessionlimit);
		}
	}
	
	// "네이버 아이디로 로그인하기" 로그인
	@RequestMapping(value="loginNaver", method=RequestMethod.GET)
	public String loginNaver() {
		
		return "/user/loginNaver";
	}
	
	@RequestMapping(value="loginPostNaver", method=RequestMethod.POST)
	public String loginPOSTNaver(@ModelAttribute("uVO") UserVO uVO) throws Exception {
		
		return "/user/loginPost";
	}
	
	// 로그아웃
	@RequestMapping(value="logout", method=RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		Object obj = session.getAttribute("login");
		
		if (obj != null) {
			UserVO uVo = (UserVO) obj;
			
			session.removeAttribute("login");
			session.invalidate();
			
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			if (loginCookie != null) {
				loginCookie.setPath("/");
				loginCookie.setMaxAge(0);
				response.addCookie(loginCookie);
				userService.updateForCookie(uVo.getUid(), session.getId(), new Date());
			}
		}
		
		return "redirect:/";
	}
	
	// 회원가입
	@RequestMapping(value="join", method=RequestMethod.GET)
	public String joinGET() {
		return "user/join";
	}
	
	@RequestMapping(value="joinPost", method=RequestMethod.POST)
	public String joinPost(@ModelAttribute("uVO") UserVO uVO) throws Exception {
		uVO.setPw(PassEncryption.encPwd(uVO.getPw()));
		logger.info("currnent join member: " + uVO.toString());
		userService.create(uVO);
		
		return "user/joinPost";
	}
	
	// email 인증 
	@RequestMapping(value="joinConfirm", method=RequestMethod.GET)
	public String emailConfirm(@ModelAttribute("uVO") UserVO uVO, Model model) throws Exception {
		logger.info(uVO.getEmail() + ": auth confirmed");
		uVO.setAuthstatus(1);
		userService.updateAuthstatus(uVO);
		
		model.addAttribute("auth_check", 1);
		
		return "user/joinPost";
	}
	
	// 사용자 정보
	@RequestMapping(value="info", method=RequestMethod.GET)
	public String info(HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession();
		String uid = ((UserVO) session.getAttribute("login")).getUid();
		
		UserVO uVO = userService.readByUid(uid);
				
		userService.update(uVO);
		
		logger.info("user info: " + uVO.toString());
		model.addAttribute("uVO", uVO);
		
		return "user/info";
	}
	
	// 사용자 정보 수정
	@RequestMapping(value="edit", method=RequestMethod.POST)
	public String edit(@ModelAttribute("uVO") UserVO uVO) throws Exception {
		userService.update(uVO);
		logger.info("update user info: " + uVO.toString());
		
		return "redirect:/user/info";
	}
	
	// 회원가입 관련 ajax 처리(중복 uid, email 체크) --------------------------------------------------------------------------------------------------
	// ajax uid 중복체크
	@ResponseBody
	@RequestMapping(value="joinUidCheck", method=RequestMethod.GET)
	public ResponseEntity<String> joinUidCheck(String uid) {
		ResponseEntity<String> entity = null;
		
		try {
			if (userService.readByUid(uid) != null) {
				entity = new ResponseEntity<>("UID_DUP", HttpStatus.OK);
			} else {
				entity = new ResponseEntity<>("SUCCESS", HttpStatus.OK);
			}
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	// ajax email 중복체크
	@ResponseBody
	@RequestMapping(value="joinEmailCheck", method=RequestMethod.GET)
	public ResponseEntity<String> joinEmailCheck(String email) {
		ResponseEntity<String> entity = null;
		
		try {
			if (userService.readByEmail(email) != null) {
				entity = new ResponseEntity<>("EMAIL_DUP", HttpStatus.OK);
			} else {
				entity = new ResponseEntity<>("SUCCESS", HttpStatus.OK);
			}
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}
