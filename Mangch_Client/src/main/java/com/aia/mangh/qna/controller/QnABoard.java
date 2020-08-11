package com.aia.mangh.qna.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class QnABoard {
	
	
	@RequestMapping("/qna/qnaBoard")
	public String qnaBoard() {
		
		// qna화면 이동
		
		return "/qna/qnaBoard";
	}
}
