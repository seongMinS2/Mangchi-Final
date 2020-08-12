package com.aia.mangh.request.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

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

}
