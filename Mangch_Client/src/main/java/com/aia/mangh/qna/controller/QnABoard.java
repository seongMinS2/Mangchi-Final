package com.aia.mangh.qna.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/qna/*")
public class QnABoard {
	
	
	@GetMapping("qnaBoard")
	public String qnaBoard() {
		
		// qna화면 이동
		
		return "/qna/qnaBoard";
	}
	
	@GetMapping("writeBoard")
	public String qnaDetailBoard() {
		
		//글쓰기 이동
		
		return "/qna/writeBoard";
	}
	
	@GetMapping("contents/{idx}")
	public String qnaDetailView(@PathVariable int idx, Model model) {

		//상세보기페이지 이동
		
		model.addAttribute("idx", idx);
		return "/qna/contentsView";
	}
	
	@GetMapping("update-board/{idx}")
	public String qnaModifyBoard(@PathVariable int idx,Model model) {
		
		//수정폼 이동
		
		model.addAttribute("idx", idx);
		return "/qna/modifyBoard";
	}
	
	@GetMapping("reply-board/{idx}")
	public String qnaReplyWriteBoard(@PathVariable int idx,Model model) {
		
		//답글쓰기 페이지 이동
		
		model.addAttribute("idx", idx);
		return "/qna/replyWriteBoard";
	}
}
