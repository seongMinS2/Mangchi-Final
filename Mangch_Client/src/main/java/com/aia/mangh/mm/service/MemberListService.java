package com.aia.mangh.mm.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aia.mangh.mm.dao.MemberDao;
import com.aia.mangh.mm.model.Member;

@Service
public class MemberListService {
	
	private MemberDao dao;
	
	@Autowired
	SqlSessionTemplate template;

	public List<Member> memberList(int mIdx){
			
		dao = template.getMapper(MemberDao.class);
	
		System.out.println(mIdx);
		
		List<Member> member = dao.selectList(mIdx);
		
		System.out.println(member);
		return member;
		
	}
	
}
