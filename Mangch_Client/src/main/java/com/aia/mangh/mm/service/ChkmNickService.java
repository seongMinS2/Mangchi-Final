package com.aia.mangh.mm.service;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aia.mangh.mm.dao.MemberDao;

@Service
public class ChkmNickService {

	private MemberDao dao;
	
	@Autowired
	SqlSessionTemplate template;
	
	public int ChkmNick(String mNick, HttpServletRequest request) {
		
		dao = template.getMapper(MemberDao.class);
		
		int resultCnt = 0;

		resultCnt = dao.selectByNick(mNick);

		if (resultCnt > 0) {
			resultCnt = 1;
		}

		return resultCnt;
		
	}
}
