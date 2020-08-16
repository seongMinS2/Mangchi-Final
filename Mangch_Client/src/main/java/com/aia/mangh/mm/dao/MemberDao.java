package com.aia.mangh.mm.dao;

import java.util.List;

import com.aia.mangh.mm.model.LoginRequest;
import com.aia.mangh.mm.model.Member;

public interface MemberDao {

	// 회원 가입
	public int insertMember(Member member);
	
	// 로그인
	public Member selectByIdPw(LoginRequest loginRequest);
	
	// ID, PW 확인
	public int checkIdPw(LoginRequest loginRequest);
	
	// 회원 ID 중복체크
	public int selectById(String mId);
	
	//회원 닉네임 중복체크
	public int selectByNick(String mNick);
	
	// 회원 정보 출력
	public List<Member> selectList(int mIdx);
	
	// 카카오 로그인
	public Member selectBykakao(String mId);
}
