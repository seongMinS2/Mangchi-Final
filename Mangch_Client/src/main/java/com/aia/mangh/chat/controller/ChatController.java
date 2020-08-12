package com.aia.mangh.chat.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ChatController {

	@RequestMapping("/chat")
	public String chatPage(HttpServletRequest req) {
		Member member = new Member();
		member.setId("test1@naver.com");
		member.setNick("테스터1");

		req.getSession().setAttribute("loginInfo", member);
		return "chatting/chatting";
	}
}
