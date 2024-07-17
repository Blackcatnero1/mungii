package com.human.mis.service;

import javax.servlet.http.*;

import org.springframework.web.servlet.*;

public class LoginCheckInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// 세션 꺼내고
		HttpSession session = request.getSession();
		// 로그인 아이디
		Object sid = session.getAttribute("SID");
		if (sid == null) {
			// 이미 로그인 되어있는 경우
			response.sendRedirect("/mis/member/login.mis");
			return false; // 클라이언트의 요청 처리함수를 실행하면 안된다.
		}
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {}

}
