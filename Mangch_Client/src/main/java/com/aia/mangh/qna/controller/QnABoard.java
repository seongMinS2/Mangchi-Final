package com.aia.mangh.qna.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/qna/*")
public class QnABoard {
	
	
	@RequestMapping("qnaBoard")
	public String qnaBoard() {
		
		// qna화면 이동
		
		return "/qna/qnaBoard";
	}
	
	@RequestMapping("writeBoard")
	public String qnaDetailBoard() {
		
		//글쓰기 이동
		
		return "/qna/writeBoard";
	}
	
//	@RequestMapping("contents")
//	public String qnaContentsView() {
//		
//		// 글 상세보기 이동
//		
//		return "/qna/contentsView";
//	}
	
	@RequestMapping("/contents/{idx}")
	public String qnaDetailView(@PathVariable int idx, Model model) {
		
		model.addAttribute("idx", idx);
		return "/qna/contentsView";
	}
}
