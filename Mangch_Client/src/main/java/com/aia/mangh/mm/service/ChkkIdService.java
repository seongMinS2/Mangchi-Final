package com.aia.mangh.mm.service;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aia.mangh.mm.dao.MemberDao;
import com.aia.mangh.mm.model.LoginInfo;
import com.aia.mangh.mm.model.Member;

@Service
public class ChkkIdService {

	private MemberDao dao;

	@Autowired
	SqlSessionTemplate template;

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
			System.out.println("4자리 자른 curImg:"+hpmImg);
			
			hpmImg = hpmImg.trim();
			System.out.println("공백을 제거한 curImg:"+hpmImg);
			
			// 기존의 회원사진이 카카오 프로필사진 or 사용자 지정 사진인지 확인
			if(hpmImg.equals("http")) {
				if(!(mImg.equals(curImg))) {
					System.out.println("카카오 프로필 사진이 변경되었습니다.");
					
					dao.updateByImg(mId, mImg);
					
					member = dao.selectBykakao(mId);
					
					loginInfo =  member.toLoginInfo();

					session.setAttribute("loginInfo", loginInfo);

					System.out.println("loginInfo >>> " + loginInfo + "로그인 되셨습니다 !!");
				}else {
					System.out.println("카카오 프로필 사진이 기존과 동일합니다.");
					
					member = dao.selectBykakao(mId);
					
					loginInfo =  member.toLoginInfo();

					session.setAttribute("loginInfo", loginInfo);

					System.out.println("loginInfo >>> " + loginInfo + "로그인 되셨습니다 !!");
				}
			} else {
				System.out.println("사용자 지정 사진이 기존과 동일합니다.");
				
				member = dao.selectBykakao(mId);
				
				loginInfo =  member.toLoginInfo();

				session.setAttribute("loginInfo", loginInfo);

				System.out.println("loginInfo >>> " + loginInfo + "로그인 되셨습니다 !!");
			}
		}

		return resultCnt;
	}
}
