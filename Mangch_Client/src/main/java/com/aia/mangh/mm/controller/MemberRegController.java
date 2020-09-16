package com.aia.mangh.mm.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aia.mangh.mm.model.RegRequest;
import com.aia.mangh.mm.service.MemberCheckService;
import com.aia.mangh.mm.service.MemberRegService;

@Controller
@RequestMapping("/member/memberReg")
public class MemberRegController {

	@Autowired
	private MemberRegService regService;

	@Autowired
	private MemberCheckService checkService;

	// 회원가입 폼
	@RequestMapping(method = RequestMethod.GET)
	public String getRegForm() {
		return "member/regForm";
	}

	// 회원가입
	@RequestMapping(method = RequestMethod.POST)
	public ModelAndView reg(RegRequest regRequest, HttpServletRequest request, Model model) {
		
		System.out.println("regRequest Controller >> " + regRequest);
		regService.regMember(regRequest, request);
		
		ModelAndView modelAndView = new ModelAndView("index");
		
		modelAndView.addObject("regMSG", "회원가입이 완료되었습니다! 로그인후 이용해주세요.");

		return modelAndView;
	}

	// 회원 ID 중복체크
	@ResponseBody
	@RequestMapping("/chkmId")
	public int chkmId(String mId) {
		System.out.println("chkmId >> " + mId);
		return checkService.ChkId(mId);
	}

	// 회원 닉네임 중복체크
	@ResponseBody
	@RequestMapping("/chkmNick")
	public int chkmNick(String mNick) {
		System.out.println("chkmNick >> " + mNick);
		return checkService.ChkNick(mNick);
	}

}
