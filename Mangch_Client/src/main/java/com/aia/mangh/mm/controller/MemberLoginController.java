package com.aia.mangh.mm.controller;

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

	// 로그인 폼
	@RequestMapping(method = RequestMethod.GET)
	public String getLoginForm() {
		return "member/loginForm";
	}

	// 로그인
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST)
	public String login(LoginRequest loginRequest, HttpSession session, HttpServletResponse response, Model model) {
		return loginService.loginMember(loginRequest, session, response);
	}

}
