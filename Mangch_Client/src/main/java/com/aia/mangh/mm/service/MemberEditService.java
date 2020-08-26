package com.aia.mangh.mm.service;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.aia.mangh.mm.dao.MemberDao;
import com.aia.mangh.mm.model.EditRequest;
import com.aia.mangh.mm.model.EditRequest2;
import com.aia.mangh.mm.model.LoginInfo;
import com.aia.mangh.mm.model.Member;

@Service
public class MemberEditService {

	private MemberDao dao;

	@Autowired
	SqlSessionTemplate template;

	Member member = null;

	// Member 객체 불러오기
	public Member getMember(String mId) {
		System.out.println(mId);
		dao = template.getMapper(MemberDao.class);

		member = dao.selectByMember(mId);
		System.out.println("getMember: " + member);
		return member;
	}

	// 회원정보 수정(주소, 사진, 거리)
	public int editMember(EditRequest editRequest, HttpServletRequest request) {
		
		LoginInfo loginInfo = null;
		int result = 0;
		
		EditRequest2 editRequest2 = editRequest.toEditMember();

		System.out.println("getmid: " + editRequest.getmId());

		member = getMember(editRequest.getmId());

		dao = template.getMapper(MemberDao.class);
		
		try {
			System.out.println("try membr: " + member);
			String oldfile = member.getmImg();
			MultipartFile file = editRequest.getmImg();

			System.out.println(editRequest);

			if (file != null && !file.isEmpty() && file.getSize() > 0) {
				// 서버 내부의 경로
				String uri = request.getSession().getServletContext().getInitParameter("memberUploadPath");
				System.out.println("uri: "+uri);

				// 시스템의 실제(절대) 경로
				String realPath = request.getSession().getServletContext().getRealPath(uri);

				System.out.println("realpath:"+realPath);
				// 저장할 이미지 파일의 새로운 이름 생성
				String newFileName = System.nanoTime() + "_" + file.getOriginalFilename();

				// 서버의 저장소에 실제 저장
				File saveFile = new File(realPath, newFileName);
				file.transferTo(saveFile);
			
				// 데이터베이스에 저장할 Member 객체의 데이터를 완성한다. : 사진 경로
				editRequest2.setmImg(newFileName);

				// 이전 페이지를 지운다.
				// 이전 파일의 File 객체
				File oldFile = new File(realPath, oldfile);

				// 파일이 존재하면
				if (oldFile.exists() && oldfile!="defalult.png") {
					// 파일을 삭제
					oldFile.delete();
				}

			} else {
				editRequest2.setmImg(oldfile);
			}

			result = dao.updateByMember(editRequest2);
			
			member = dao.selectByMember(editRequest2.getmId());
			loginInfo = member.toLoginInfo();

			System.out.println("loginInfo kakaoedit: "+loginInfo.onString());
			request.getSession().setAttribute("loginInfo", loginInfo);

		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return result;
	}
	
	// 회원 비밀번호 수정
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
