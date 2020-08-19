package com.aia.mangh.mm.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aia.mangh.mm.dao.MemberDao;

@Service
public class MemberEditPwService {

	private MemberDao dao;

	@Autowired
	SqlSessionTemplate template;

	public int editPw(String mId, String nPw) {

		dao = template.getMapper(MemberDao.class);

		int resultCnt = 0;

		resultCnt = dao.updateByPw(mId, nPw);

		if (resultCnt > 0) {
			resultCnt = 1;
		}

		return resultCnt;
	}
}
