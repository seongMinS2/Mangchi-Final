package com.aia.mangh.mm.service;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.aia.mangh.mm.dao.MemberDao;
import com.aia.mangh.mm.model.Member;
import com.aia.mangh.mm.model.RegKakaoRequest;

@Service
public class MemberRegKakaoService {

	private MemberDao dao;
	
	@Autowired
	SqlSessionTemplate template;
	
	// 카카오 회원가입
	public int regKakaoMember(RegKakaoRequest kakaoRequest, HttpServletRequest request) {
		System.out.println("kakaoRequest to kakaoRequest >> " + kakaoRequest);
		
		Member member = kakaoRequest.toMember();
		
		System.out.println("kakaoRequest to Member >> " + member);
		
		dao = template.getMapper(MemberDao.class);
		
		int result = 0;

		try {

			MultipartFile file = kakaoRequest.getmImg();

			System.out.println(kakaoRequest);

			if (file != null && !file.isEmpty() && file.getSize() > 0) {
				String uri = request.getSession().getServletContext().getInitParameter("memberUploadPath");

				String realPath = request.getSession().getServletContext().getRealPath(uri);

				String newFileName = System.nanoTime() + "_" + file.getOriginalFilename();

				File saveFile = new File(realPath, newFileName);
				file.transferTo(saveFile);
				
				System.out.println("저장 완료 : " + newFileName);

				member.setmImg(newFileName);

			} else {
				if(kakaoRequest.getkImg() != null) {
					member.setmImg(kakaoRequest.getkImg());
				}else {
					member.setmImg("defalult.png");
				}
			}

			result = dao.insertMember(member);

		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} 
				
		return result ;
	}
}
