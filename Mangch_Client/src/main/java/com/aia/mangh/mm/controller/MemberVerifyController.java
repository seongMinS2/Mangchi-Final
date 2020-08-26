package com.aia.mangh.mm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aia.mangh.mm.service.MemberVerifyService;

@Controller
@RequestMapping("/member/verify")
public class MemberVerifyController {

	@Autowired
	private MemberVerifyService verifyService;

	// 메일 발송 요청
	@ResponseBody
	@RequestMapping("/MailSend")
	public String reMailSend(@RequestParam("email") String email) {

		String code = makeRandom();

		int rCnt = verifyService.reMailSend(email, code);
		System.out.println("인증번호 발송: " + rCnt);

		return code;
	}

	// 인증번호 난수 생성
	public String makeRandom() {
		String value = "";
		for (int i = 0; i < 8; i++) {

			int rndVal = (int) (Math.random() * 62);
			if (rndVal < 10) {
				value += rndVal;
			} else if (rndVal > 35) {
				value += (char) (rndVal + 61);
			} else {
				value += (char) (rndVal + 55);
			}
		}
		return value;
	}
}
