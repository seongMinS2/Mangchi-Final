package com.aia.mangh.mm.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aia.mangh.mm.dao.MemberDao;

@Service
public class MemberVerifyService {

	@Autowired
	private MailSenderService mailService;

	@Autowired
	private SqlSessionTemplate template;
	
	private MemberDao dao;
	
//	public String verify(String id, String code) {
//		
//		dao = template.getMapper(MemberDao.class);
//		
//		int rCnt = dao.verify(id, code);
//		
//		return rCnt>0?"Success":"Fail";
//	}

	public int reMailSend(String email, String code) {
				
		dao = template.getMapper(MemberDao.class);
		
		mailService.send(email, code);
		
		return 1;
	}
}
