package com.human.mis.service;

import java.lang.reflect.*;

import javax.servlet.http.*;

import org.aspectj.lang.*;
import org.aspectj.lang.annotation.*;
import org.aspectj.lang.reflect.*;
import org.slf4j.*;
import org.springframework.stereotype.*;

import com.human.mis.vo.MemberVO;

@Service // service 클래스를 been 처리해주는 어노테이션
@Aspect // 이 클래스가 AOP 처리를 위한 클래스임을 밝혀주는 어노테이션
public class MemberLogService {
	// logger 꺼내오고
	private static final Logger membLog = LoggerFactory.getLogger("membLog");
	
	// 회원 로그인/아웃 관련 로그 처리
	@After("execution(* com.human.mis.controller.Member.**Proc(..))")
	public void memberLog(JoinPoint join) {
		// 세가지 함수의 기능을 통합했으므로
		// 어떤 함수가 실행되었는지 알아낸다.
		MethodSignature methodSignature = (MethodSignature) join.getSignature();
		Method method = methodSignature.getMethod();
		String funcName = method.getName();
		
		// 세션 꺼내오고
		HttpSession session = (HttpSession) join.getArgs()[0];
		String sid  = (String) session.getAttribute("SID");
		
		String id = "";
		String act = "";
		
	// 실행함수에 따라 조건처리
	if(funcName.equals("loginProc")) {
		// MemberVO의 cnt 를 꺼내서
		MemberVO mVO = (MemberVO) join.getArgs()[3];
		int cnt = mVO.getCnt();
		id = mVO.getId();
		if(cnt == 1) {
			session.setAttribute("SID", id);
			act = "로그인";
		} else {
			act = "로그인에 실패";
		}
	
	} else if(funcName.equals("logoutProc")) {
		
	}
		
	}
}
