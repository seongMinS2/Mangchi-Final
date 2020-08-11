package com.aia.mangh.mm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MemberMypageController {

	@RequestMapping("/member/mypageForm")
	public String getRegForm() {
		return "member/mypageForm";
	}
}
