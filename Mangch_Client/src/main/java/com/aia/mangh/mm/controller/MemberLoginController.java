package com.aia.mangh.mm.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aia.mangh.mm.model.LoginRequest;
import com.aia.mangh.mm.service.MemberLoginService;

@Controller
@RequestMapping("/member/memberLogin")
public class MemberLoginController {

	@Autowired
	MemberLoginService loginService;

	@RequestMapping(method = RequestMethod.GET)
	public String getLoginForm() {
		return "member/loginForm";
	}

	@RequestMapping(method = RequestMethod.POST)
	@ResponseBody
	public String login(LoginRequest loginRequest, HttpSession session, HttpServletResponse response, Model model) {

		//request.setAttribute("result", loginService.loginMember(loginRequest, session, response));

		//String result = (String) request.getAttribute("result");
		
		//String result = loginService.loginMember(loginRequest, session, response);
		
//		if (session.getAttribute("loginInfo") != null) {
//
//			return "member/mypageForm";
//		} else {
//			return "member/loginForm";
//		}
		
		//model.addAttribute("result", loginService.loginMember(loginRequest, session, response));

		//return "/member/mypageForm";

		return loginService.loginMember(loginRequest, session, response);
	}

//	@RequestMapping("/CheckIdPw")
//	public String CheckIdPw(LoginRequest loginRequest) {
//
//		System.out.println("check contro: " + loginRequest);
//		String result = null;
//		CheckIdPwService service = new CheckIdPwService();
//
//		result = service.checkIdPw(loginRequest);
//		System.out.println(result);
//		return result;
//	}

}
