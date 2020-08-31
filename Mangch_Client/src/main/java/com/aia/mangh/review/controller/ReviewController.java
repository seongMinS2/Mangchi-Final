package com.aia.mangh.review.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ReviewController {

	// 리뷰 작성
	@RequestMapping("/review/reviewForm")
	public String reviewForm(@RequestParam("reviewIdx") int reviewIdx,
			@RequestParam("rstatus") int rstatus,
			@RequestParam("receiver") String receiver,
			Model model) {

		
		model.addAttribute("reviewIdx", reviewIdx);
		model.addAttribute("rstatus", rstatus);
		model.addAttribute("receiver", receiver);
		return "review/reviewForm";
	}
}