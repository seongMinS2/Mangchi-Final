package com.aia.mangh.mm.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.aia.mangh.mm.dao.MemberDao;
import com.aia.mangh.mm.model.VisitCountVO;

public class VisitCounter implements HttpSessionListener {

	private MemberDao dao;

	@Autowired
	SqlSessionTemplate template;

	public static int count;

	public static int getCount() {
		return count;
	}

	public void sessionCreated(HttpSessionEvent event) {

		// dao = template.getMapper(MemberDao.class);

		dao = getSessionService(event).getMapper(MemberDao.class);

		// 세션이 만들어질 때 호출
		HttpSession session = event.getSession(); // request에서 얻는 session과 동일한 객체
		session.setMaxInactiveInterval(60 * 20);

		count++;

		session.getServletContext().log(session.getId() + " 세션생성 " + ", 접속자수 : " + count);

		HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
				.getRequest();

		VisitCountVO vo = new VisitCountVO();
		System.out.println("ip : " + req.getRemoteAddr());
		System.out.println("agent" + req.getHeader("User-Agent"));
		
		vo.setVisit_ip(req.getRemoteAddr());
		vo.setVisit_agent(req.getHeader("User-Agent"));// 브라우저 정보
		
		// 방문자 수 증가
		dao.insertVisitor(vo);
		
		// 전체 방문자 수 
		int allVisitor = dao.selectAllVisitor();
		session.setAttribute("allVisitor", allVisitor);
		System.out.println("allVisitor session: "+allVisitor);
		
		// 오늘 방문자 수
		int todayVisitor = dao.selectTodayVisitor();
		session.setAttribute("todayVisitor", todayVisitor);
		System.out.println("todayVisitor session: "+todayVisitor);
		
		// 전체 요청게시물 수
		int allRequest = dao.selectAllRequest();
		session.setAttribute("allRequest", allRequest);
		System.out.println("allRequest session: "+allRequest);
		
		// 전체 나눔게시물 수
		int allDonate = dao.selectAllDonate();
		session.setAttribute("allDonate", allDonate);
		System.out.println("allDonate session: "+allDonate);
	}

	public void sessionDestroyed(HttpSessionEvent event) {
		// 세션이 소멸될 때 호출
		count--;
		if (count < 0)
			count = 0;

		HttpSession session = event.getSession();
		session.getServletContext().log(session.getId() + " 세션소멸 " + ", 접속자수 : " + count);
	}

	private SqlSessionTemplate getSessionService(HttpSessionEvent se) {
		WebApplicationContext context = WebApplicationContextUtils
				.getWebApplicationContext(se.getSession().getServletContext());
		return (SqlSessionTemplate) context.getBean("sqlSession");
	}

}
