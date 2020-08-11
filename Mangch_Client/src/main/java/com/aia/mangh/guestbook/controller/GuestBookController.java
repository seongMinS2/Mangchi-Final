package com.aia.mangh.guestbook.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GuestBookController {
	
	@RequestMapping("/guest_book/gbBoard")
	public String donateBoard() {
		return "/guest_book/gbBoard";
	}
	//테스트

}
