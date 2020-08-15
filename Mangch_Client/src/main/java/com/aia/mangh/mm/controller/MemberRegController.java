package com.aia.mangh.mm.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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

	@RequestMapping(method = RequestMethod.GET)
	public String getRegForm() {
		return "member/regForm";
	}
	
	// 회원가입
	@RequestMapping(method = RequestMethod.POST)
	public String reg(RegRequest regRequest, HttpServletRequest request, Model model) {

		System.out.println("regRequest Controller >> " + regRequest);
		
		model.addAttribute("result", regService.regMember(regRequest, request));
		
		return "index";
	}
	
	
	  // 회원 ID 중복체크
	  
	  @RequestMapping("/chkmId")
	  @ResponseBody 
	  public int chkmId(String mId) {
	  
	  System.out.println("chkmId >> " + mId);
	  
	  return chkmIdService.ChkmId(mId); }
	  
	  
	  // 회원 닉네임 중복체크
	  
	  @RequestMapping("/chkmNick")
	  @ResponseBody 
	  public int chkmNick(String mNick) {
	  
	  System.out.println("chkmNick >> "+ mNick);
	  
	  return chkmNickService.ChkmNick(mNick); }
	 
}
