package com.aia.mangh.mm.service;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aia.mangh.mm.dao.MemberDao;
import com.aia.mangh.mm.model.LoginInfo;
import com.aia.mangh.mm.model.Member;

@Service
public class ChkkIdService {

	private MemberDao dao;

	@Autowired
	SqlSessionTemplate template;

	public int ChkkId(String mId, HttpSession session) {

		dao = template.getMapper(MemberDao.class);

		int resultCnt = 0;
		Member member = null;
		LoginInfo loginInfo = null;

		resultCnt = dao.selectById(mId);
		
		member = dao.selectBykakao(mId);

		if (resultCnt > 0) {
			resultCnt = 1;
			
			loginInfo =  member.toLoginInfo();

			session.setAttribute("loginInfo", loginInfo);

			System.out.println("loginInfo >>> " + loginInfo + "로그인 되셨습니다 !!");
		}

		return resultCnt;
	}
}
