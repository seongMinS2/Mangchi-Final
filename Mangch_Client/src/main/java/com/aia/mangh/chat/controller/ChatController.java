package com.aia.mangh.chat.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.aia.mangh.chat.model.SendMsgInfo;

@Controller
@RequestMapping("/chat")
public class ChatController {
	@RequestMapping(method = RequestMethod.GET)
	public String chatPage(SendMsgInfo smi,HttpServletRequest req,Model model,@RequestParam("nick") String nick) {
		Member member = new Member();
		member.setNick(nick);
		req.getSession().setAttribute("loginInfo", member);
		
		if(smi.getuNick() != null) {
			model.addAttribute("msgInfo",smi);
		}
		return "chatting/chatting";
	}
}
