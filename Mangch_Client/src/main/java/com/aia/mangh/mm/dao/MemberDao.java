package com.aia.mangh.mm.dao;

import java.util.List;

import com.aia.mangh.mm.model.EditRequest2;
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
	
	// 사진 확인
	public String selectByImg(String mId);
	
	// 사진 업데이트
	public int updateByImg(String mId, String mImg);
	
	// 아이디로 Member 객체 가져오기
	public Member selectByMember(String mId);
	
	// 회원수정
	public int updateByMember(EditRequest2 editRequest2);
	
	// 회원 비밀번호 수정
	public int updateByPw(String mId, String nPw);
	
	// 회원탈퇴
	public int deleteMember(String mId, String mDel);
	
	// 회원탈퇴 체크
	public int deleteChk(String mId);

}
