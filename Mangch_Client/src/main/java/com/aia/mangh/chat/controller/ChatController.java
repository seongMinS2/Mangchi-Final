package com.aia.mangh.chat.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aia.mangh.chat.model.SendMsgInfo;

@Controller
public class ChatController {

	@RequestMapping("/chat")
	public String chatPage(SendMsgInfo smi,HttpSession session,Model model) {
		Member member = new Member();
		member.setId("test1@naver.com");
		member.setNick("테스트용");
		
		session.setAttribute("loginInfo", member);
		model.addAttribute("msgInfo",smi);
		return "chatting/chatting";
	}
}
