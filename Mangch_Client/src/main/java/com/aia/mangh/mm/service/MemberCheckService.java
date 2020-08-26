package com.aia.mangh.mm.service;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aia.mangh.mm.dao.MemberDao;
import com.aia.mangh.mm.model.LoginInfo;
import com.aia.mangh.mm.model.LoginRequest;
import com.aia.mangh.mm.model.Member;

@Service
public class MemberCheckService {

	private MemberDao dao;
	
	@Autowired
	private SqlSessionTemplate template;
	
	
	// 로그인 체크(LoginRequest(아이디, 패스워드))
	public int ChkIdPw(LoginRequest loginRequest) {

		dao = template.getMapper(MemberDao.class);
		int resultCnt = dao.checkIdPw(loginRequest);

		return resultCnt;
	}
	
	// 아이디 중복체크
	public int ChkId(String mId) {

		dao = template.getMapper(MemberDao.class);

		int resultCnt = 0;

		resultCnt = dao.selectById(mId);

		if (resultCnt > 0) {
			resultCnt = 1;
		}

		return resultCnt;
	}
	
	// 패스워드 체크
	public int ChkPw(String mPw) {

		dao = template.getMapper(MemberDao.class);

		int resultCnt = 0;

		resultCnt = dao.selectById(mPw);

		if (resultCnt > 0) {
			resultCnt = 1;
		}

		return resultCnt;
	}
	
	// 닉네임 중복체크
	public int ChkNick(String mNick) {
		
		dao = template.getMapper(MemberDao.class);
		
		int resultCnt = 0;

		resultCnt = dao.selectByNick(mNick);

		if (resultCnt > 0) {
			resultCnt = 1;
		}

		return resultCnt;
		
	}
	
	// 카카오 회원번호 체크
	public int ChkkId(String mId, String mImg, HttpSession session) {

		dao = template.getMapper(MemberDao.class);

		int resultCnt = 0;
		Member member = null;
		LoginInfo loginInfo = null;

		resultCnt = dao.selectById(mId);
		
		if (resultCnt > 0) {
			resultCnt = 1;
			
			// 카카오 회원의 프로필사진 업데이트 유무
			String curImg = dao.selectByImg(mId);
			String hpmImg = null;
			
			System.out.println("(현재 사진)curImg: "+curImg);

			System.out.println("(바뀐 사진)mImg:"+mImg);
			
			hpmImg = mImg.substring(0,4);
			hpmImg = hpmImg.trim();
			
			// 기존의 회원사진이 카카오 프로필사진 or 사용자 지정 사진인지 확인
			if(hpmImg.equals("http")) {
				if(!(mImg.equals(curImg))) {
					System.out.println("카카오 프로필 사진이 변경되었습니다.");
					dao.updateByImg(mId, mImg);
					member = dao.selectBykakao(mId);
				}else {
					System.out.println("카카오 프로필 사진이 기존과 동일합니다.");
					member = dao.selectBykakao(mId);
				}
			} else {
				System.out.println("사용자 지정 사진이 기존과 동일합니다.");
				member = dao.selectBykakao(mId);
			}
			
			loginInfo =  member.toLoginInfo();
			loginInfo.setmPic("K");
			session.setAttribute("loginInfo", loginInfo);
			System.out.println("loginInfo >>> " + loginInfo + "로그인 되셨습니다 !!");
		}

		return resultCnt;
	}
	
	
}
