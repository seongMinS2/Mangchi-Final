package com.aia.mangh.request.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class RequestController {

	// 요청 게시물 리스트
	@RequestMapping("/request/requestList")
	public String requestReg() {
		return "request/requestBoard";
	}

	// 요청 게시물 등록
	@RequestMapping("/request/requestWrite")
	public String requestRegForm() {
		return "request/requestForm";
	}

	// 게시물 상세 정보 출력
	@RequestMapping("/request/requestDetail")
	public String requestDetail(@RequestParam("idx") int idx, @RequestParam("status") int status,Model model) {
		model.addAttribute("idx", idx);
		model.addAttribute("status",status);
		return "request/requestDetail";
	}

	// 게시물 수정
	@RequestMapping("/request/edit")
	public String requestEdit(@RequestParam("reqIdx") int reqIdx, Model model) {
		model.addAttribute("reqIdx", reqIdx);
		return "request/requestForm";
	}


}
