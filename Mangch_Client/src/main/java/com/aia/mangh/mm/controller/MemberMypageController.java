package com.aia.mangh.mm.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aia.mangh.mm.model.Member;
import com.aia.mangh.mm.service.MemberListService;

@Controller
@RequestMapping("/member/memberMypage")
public class MemberMypageController {
	
	@Autowired
	private MemberListService listService;

	@RequestMapping("/mypageForm")
	public String getRegForm() {
		return "member/mypageForm";
	}
	
	// 회원 정보 출력
	@RequestMapping("/mypage/{mIdx}")		
	public String getMemberList(@PathVariable("mIdx") int mIdx, HttpServletRequest request, Model model){
		System.out.println("list mIdx >> "+mIdx);
		model.addAttribute("result", listService.memberList(mIdx));
		return "/member/mypageForm";
	}
	
}
