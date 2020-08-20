package com.aia.mangh.mm.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aia.mangh.mm.model.RegKakaoRequest;
import com.aia.mangh.mm.model.kakaoRequest;
import com.aia.mangh.mm.service.ChkkIdService;
import com.aia.mangh.mm.service.KakaoAPIService;
import com.aia.mangh.mm.service.KakaoGetUserInfoService;
import com.aia.mangh.mm.service.MemberRegKakaoService;

@Controller
@RequestMapping("/member/kakao")
public class MemberKakaoController {

	@Autowired
	private ChkkIdService chkkIdService;

	@Autowired
	private KakaoAPIService kakao;

	@Autowired
	private KakaoGetUserInfoService kakaoGetUserService;

	@Autowired
	private MemberRegKakaoService kakaoService;

	// 카카오 추가회원가입 폼
	@RequestMapping("/regkakaoForm")
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
	@RequestMapping("/regkakao")
	public String regKakao(RegKakaoRequest kakaoRequest, HttpServletRequest request, Model model) {

		System.out.println("kakaoRequest Controller >> " + kakaoRequest);

		model.addAttribute("result", kakaoService.regKakaoMember(kakaoRequest, request));

		return "index";
	}

	// REST 카카오 정보가져오기
	@RequestMapping("/kakaoREST")
	public String loginRest(@RequestParam("code") String code, HttpSession session) {

		System.out.println("code : " + code);

		String access_Token = kakao.getAccessToken(code);
		System.out.println("controller access_token : " + access_Token);

//		HashMap<String, Object> userInfo = kakaoGetUserService.getUserInfo(access_Token);
//		System.out.println("User Info: " + userInfo);
//
//		String mId = (String) userInfo.get("email");
//		String kId = (String) userInfo.get("id");
//		String mNick = (String) userInfo.get("nickname");
//		String mImg = (String) userInfo.get("img");
//
//		if (userInfo.get("email") != null) {
//			
//			mImg = kakao.getUpdateProfile(access_Token);
//
//			int result = chkkIdService.ChkkId(mId, mImg, session);
//
//			if (result > 0) {
//				System.out.println("result: " + result);
//				// return "/member/mypageForm";
//				
//			} else {
//				kakaoRequest kakaoInfo = new kakaoRequest(mId, mNick, mImg, kId, access_Token);
//				session.setAttribute("kakaoInfo", kakaoInfo);
//				session.setAttribute("access_Token", access_Token);
//				return "/member/regFormKakao";
//			}
//
//		}
//
//		return "index";
		return login(access_Token, session);
	}
	
	// 로그인
	public String login(String access_Token, HttpSession session) {
		HashMap<String, Object> userInfo = kakaoGetUserService.getUserInfo(access_Token);
		System.out.println("User Info: " + userInfo);

		String mId = (String) userInfo.get("email");
		String kId = (String) userInfo.get("id");
		String mNick = (String) userInfo.get("nickname");
		String mImg = (String) userInfo.get("img");

		
			
			mImg = kakao.getUpdateProfile(access_Token);

			int result = chkkIdService.ChkkId(mId, mImg, session);

			if (result > 0) {
				System.out.println("result: " + result);
				 return "member/mypageForm";
				
			} else if(result == 0){
				kakaoRequest kakaoInfo = new kakaoRequest(mId, mNick, mImg, kId, access_Token);
				session.setAttribute("kakaoInfo", kakaoInfo);
				session.setAttribute("access_Token", access_Token);
				return "member/regFormKakao";
			}

		
		
		return "index";
	}
	

	// 카카오 로그아웃
	@RequestMapping(value = "/logout")
	public String logout(HttpSession session) {
		if ((String) session.getAttribute("access_Token") != null) {
			kakao.kakaoLogout((String) session.getAttribute("access_Token"));
		}
		session.removeAttribute("kakaoInfo");
		session.removeAttribute("loginInfo");
		return "index";
	}
}
