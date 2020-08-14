package com.aia.mangh.mm.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aia.mangh.mm.model.RegRequest;
import com.aia.mangh.mm.service.ChkmIdService;
import com.aia.mangh.mm.service.ChkmNickService;
import com.aia.mangh.mm.service.MemberRegService;

@Controller
@RequestMapping("/member/memberReg")
public class MemberRegController {
	
	@Autowired
	private MemberRegService regService;
	
	@Autowired
	private ChkmIdService chkmIdService;
	
	@Autowired
	private ChkmNickService chkmNickService;

	@RequestMapping("/regForm")
	public String getRegForm() {
		return "member/regForm";
	}
	
	// 회원가입
	@RequestMapping("/reg")
	public int reg(RegRequest regRequest, HttpServletRequest request) {

		System.out.println("regRequest Controller >> " + regRequest);

		return regService.regMember(regRequest, request);
	}
	
	// 회원 ID 중복체크
	@RequestMapping("/chkmId")
	public int chkmId(String mId, HttpServletRequest request) {
		
		System.out.println("chkmId >> " + mId);
		
		return chkmIdService.ChkmId(mId, request);
	}
	
	// 회원 닉네임 중복체크
	@RequestMapping("/chkmNick")
	public int chkmNick(String mNick, HttpServletRequest request) {
		
		System.out.println("chkmNick >> "+ mNick);
		
		return chkmNickService.ChkmNick(mNick, request);
	}
}
