package com.aia.mangh.mm.dao;

import com.aia.mangh.mm.model.LoginRequest;
import com.aia.mangh.mm.model.Member;

public interface MemberDao {

	// 로그인
	public Member selectByIdPw(LoginRequest loginRequest);
	
	// ID, PW 확인
	public int checkIdPw(LoginRequest loginRequest);
}
