package com.aia.mangh.mm.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aia.mangh.mm.dao.MemberDao;

@Service
public class MemberDeleteService {

	private MemberDao dao;

	@Autowired
	SqlSessionTemplate template;

	public int delete(String mId) {

		dao = template.getMapper(MemberDao.class);

		int resultCnt = 0;
		
		String mDel = "Y";

		resultCnt = dao.deleteMember(mId, mDel);

		if (resultCnt > 0) {
			resultCnt = 1;
		}

		return resultCnt;
	}
}
