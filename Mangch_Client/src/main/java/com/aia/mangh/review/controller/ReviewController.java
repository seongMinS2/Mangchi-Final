package com.aia.mangh.review.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ReviewController {

	// 리뷰 작성
	@RequestMapping("/review/reviewForm")
	public String reviewForm(@RequestParam("reqIdx") int reqIdx, @RequestParam("reqWriter") String reqWriter,
			@RequestParam("reqHelper") String reqHelper, Model model) {

		model.addAttribute("reqIdx", reqIdx);
		model.addAttribute("reqWriter", reqWriter);
		model.addAttribute("reqHelper", reqHelper);
		return "review/reviewForm";
	}
}
