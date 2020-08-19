package com.aia.mangh.mm.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aia.mangh.mm.model.EditRequest;
import com.aia.mangh.mm.service.MemberEditService;

@Controller
@RequestMapping("/member/edit")
public class MemberEditController {
	
	@Autowired
	private MemberEditService editService;

	// 회원정보 수정(닉네임, 주소, 사진)
	@RequestMapping(value="/edit",method=RequestMethod.POST)
	@ResponseBody
	public int edit(EditRequest editRequest, HttpServletRequest request) {
		return editService.editMember(editRequest, request);
	}
}
