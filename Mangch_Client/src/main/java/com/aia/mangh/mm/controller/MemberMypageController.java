package com.aia.mangh.mm.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aia.mangh.mm.model.EditRequest;
import com.aia.mangh.mm.model.LoginRequest;
import com.aia.mangh.mm.service.ChkIdPwService;
import com.aia.mangh.mm.service.MemberDeleteService;
import com.aia.mangh.mm.service.MemberEditPwService;
import com.aia.mangh.mm.service.MemberEditService;
import com.aia.mangh.mm.service.MemberListService;

@Controller
@RequestMapping("/member/memberMypage")
public class MemberMypageController {

	@Autowired
	private MemberListService listService;
	
	@Autowired
	private MemberEditService editService;

	@Autowired
	private ChkIdPwService service;
	
	@Autowired
	private MemberEditPwService editPwService;
	
	@Autowired
	private MemberDeleteService deleteService;

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
	public String getMemberList(@PathVariable("mIdx") int mIdx, HttpServletRequest request, Model model) {
		System.out.println("list mIdx >> " + mIdx);
		model.addAttribute("result", listService.memberList(mIdx));
		return "/member/mypageForm";
	}

	// PW 체크
	@RequestMapping(value="/chkmPw", method=RequestMethod.POST)
	@ResponseBody
	public int chkmPw(LoginRequest loginRequest) {
		System.out.println(loginRequest);
		int result = service.checkIdPw(loginRequest);
		return result;
	}
	
	// 회원정보 수정(닉네임, 주소, 사진)
	@RequestMapping(value="/edit",method=RequestMethod.POST)
	public String edit(EditRequest editRequest, HttpServletRequest request) {
		System.out.println("controller : "+editRequest);
		int result = editService.editMember(editRequest, request);
		System.out.println("결 과 : "+result);
		return "/member/mypageForm";
	}
	
	@RequestMapping(value="/editPw", method=RequestMethod.POST)
	@ResponseBody
	public int editPw(String mId, String nPw) {
		System.out.println("nPw :"+nPw);

		int result = editPwService.editPw(mId, nPw);
		
		return result;
	}
	
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	@ResponseBody
	public int delete(String mId) {
		System.out.println("delete mId: "+mId);
		int result = deleteService.delete(mId);
		return result;
	}

}
