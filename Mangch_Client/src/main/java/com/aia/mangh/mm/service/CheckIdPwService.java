package com.aia.mangh.mm.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aia.mangh.mm.dao.MemberDao;
import com.aia.mangh.mm.model.LoginRequest;

@Service
public class CheckIdPwService {
	
	private MemberDao dao;
	
	@Autowired
	private SqlSessionTemplate template;

	public String checkIdPw(LoginRequest loginRequest) {
		
		String result = "N";
		
		dao = template.getMapper(MemberDao.class);
		System.out.println("hi");
		int resultCnt = dao.checkIdPw(loginRequest);
		System.out.println("bye");
		if(resultCnt > 0) {
			result = "Y";
		}
		
		return result;
	}
}
