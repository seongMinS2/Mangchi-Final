package com.aia.mangh.mm.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aia.mangh.mm.service.MemberListService;

@Controller
@RequestMapping("/member/memberMypage")
public class MemberMypageController {
	
	@Autowired
	private MemberListService listService;
	
	// 요청리스트 페이지
	@RequestMapping("/requestListForm")
	public String getreqListForm() {
		return "member/requestListForm";
	}
	
	// 대여리스트 페이지
	@RequestMapping("/lendingListForm")
	public String getLendListForm() {
		return "member/lendingListForm";
	}
	
	// 나의 리뷰 페이지
	@RequestMapping("/reviewListForm")
	public String getrevListForm() {
		return "member/reviewListForm";
	}
	
	// 나의 댓글 페이지
	@RequestMapping("/commentListForm")
	public String getComListForm() {
		return "member/commentListForm";
	}
	
	// 나의 정보 페이지
	@RequestMapping("/mypageForm")
	public String getMypageForm() {
		return "member/mypageForm";
	}
	
	// 거리 설정 페이지
	@RequestMapping("/distSetForm")
	public String getdistSetForm() {
		return "member/distSetForm";
	}
	
	// 키워드 설정 페이지
	@RequestMapping("/keywordSetForm")
	public String getkeywordSetForm() {
		return "member/keywordSetForm";
	}
	
	// 회원 정보 출력
	@RequestMapping("/mypage/{mIdx}")		
	public String getMemberList(@PathVariable("mIdx") int mIdx, HttpServletRequest request, Model model){
		System.out.println("list mIdx >> "+mIdx);
		model.addAttribute("result", listService.memberList(mIdx));
		return "/member/mypageForm";
	}

	
}
