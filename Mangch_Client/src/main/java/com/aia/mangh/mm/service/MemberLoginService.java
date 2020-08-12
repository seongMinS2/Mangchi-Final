package com.aia.mangh.mm.service;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aia.mangh.mm.dao.MemberDao;
import com.aia.mangh.mm.model.LoginInfo;
import com.aia.mangh.mm.model.LoginRequest;
import com.aia.mangh.mm.model.Member;

@Service
public class MemberLoginService {
	
	private MemberDao dao;

	@Autowired
	SqlSessionTemplate template;

	public String loginMember(LoginRequest loginRequest, HttpSession session, HttpServletResponse response) {

		dao = template.getMapper(MemberDao.class);

		Member member = null;
		
		LoginInfo loginInfo = null;
		
		String result = "N";
		System.out.println("loginRequest: "+loginRequest);
	
		member = dao.selectByIdPw(loginRequest);

		System.out.println("LoginService member: " +member);
	
		if (member != null) {
			
			loginInfo =  member.toLoginInfo();

			session.setAttribute("loginInfo", loginInfo);

			System.out.println("loginInfo >>> " + loginInfo + "로그인 되셨습니다 !!");
			
			result = "Y";
		}
		System.out.println("rrrr"+result);
		return result;

	}
}
