package com.aia.mangh.chat.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.aia.mangh.chat.model.SendMsgInfo;
import com.aia.mangh.mm.model.LoginInfo;

@Controller
@RequestMapping("/chat")
public class ChatController {
	@RequestMapping(method = RequestMethod.GET)
	public String chatPage(SendMsgInfo smi,HttpServletRequest req,Model model) {
//		LoginInfo loginInfo = new LoginInfo();
//		loginInfo.setmNick(uid);
////		LoginInfo loginInfo = (LoginInfo)req.getSession().getAttribute("loginInfo");
//		req.getSession().setAttribute("loginInfo", "");
//		model.addAttribute("loginUserNick",loginInfo.getmNick());
		if(smi.getuNick() != null) {
			model.addAttribute("msgInfo",smi);
		}
		System.out.println("채팅요청자 정보 : "+model.containsAttribute("msgInfo"));
		return "chatting/chatting2";
	}
}
