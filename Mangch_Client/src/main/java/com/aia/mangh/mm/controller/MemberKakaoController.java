package com.aia.mangh.mm.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aia.mangh.mm.model.RegKakaoRequest;
import com.aia.mangh.mm.service.ChkkIdService;
import com.aia.mangh.mm.service.MemberRegKakaoService;

@Controller
@RequestMapping("/member/kakao")
public class MemberKakaoController {
	
	@Autowired
	private ChkkIdService chkkIdService;
	
	@Autowired
	private MemberRegKakaoService kakaoService;
	
	// 카카오 추가회원가입 폼
	@RequestMapping(method = RequestMethod.GET)
	public String getkakaoForm() {
		return "member/regFormKakao";
	}

	// 카카오 로그인 체크(0 or 1 반환) 
	// 카카오 회원의 프로필 사진 업데이트 체크 >> 프로필 사진 업데이트
	@RequestMapping("/kakaoId")
	@ResponseBody
	public int kakaoId(String mId, String mImg, HttpSession session) {
		
		int resultCnt = 0;
		System.out.println("kakaoId >> " + mId);
		System.out.println("kakaoImg >> " + mImg);
		resultCnt = chkkIdService.ChkkId(mId, mImg, session);

		return resultCnt;
	}
	
	// 카카오 회원가입 
	@RequestMapping(method = RequestMethod.POST)
	public String regKakao(RegKakaoRequest kakaoRequest, HttpServletRequest request, Model model) {

		System.out.println("kakaoRequest Controller >> " + kakaoRequest);
		
		model.addAttribute("result", kakaoService.regKakaoMember(kakaoRequest, request));
		
		return "index";
	}
	
}
