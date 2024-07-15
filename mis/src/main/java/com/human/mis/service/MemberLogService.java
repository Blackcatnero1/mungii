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
	
	// 회원 로그인/아웃 관련 로그 처리를 담당하는 메서드
	@After("execution(* com.human.mis.controller.Member.**Proc(..))")
	public void memberLog(JoinPoint join) {
	    // JoinPoint에서 실행된 메서드의 서명 정보를 추출한다.
	    MethodSignature methodSignature = (MethodSignature) join.getSignature();
	    Method method = methodSignature.getMethod();
	    // 실행된 메서드의 이름을 가져온다.
	    String funcName = method.getName();
	    
	    // 세션을 추출한다. 세션은 메서드의 첫 번째 인자로 전달된다.
	    HttpSession session = (HttpSession) join.getArgs()[0];
	    // 세션에서 "SID" 속성을 추출한다.
	    String sid = (String) session.getAttribute("SID");
	    
	    String id = ""; // 로그 대상 회원의 ID
	    String act = ""; // 수행된 동작(로그인, 로그아웃, 회원가입 성공/실패)
	    
	    // 실행된 메서드의 이름에 따라 로그 메시지를 설정한다.
	    if(funcName.equals("loginProc")) {
	        // loginProc 메서드가 실행된 경우
	        // MemberVO 객체를 추출하여 로그인 결과를 확인한다.
	        MemberVO mVO = (MemberVO) join.getArgs()[3];
	        int cnt = mVO.getCnt(); // 로그인 결과 상태 코드
	        id = mVO.getId(); // 로그인 시도한 회원의 ID
	        
	        if(cnt == 1) {
	            // 로그인 성공 시
	            session.setAttribute("SID", id); // 세션에 로그인한 회원의 ID를 저장한다.
	            act = "로그인"; // 로그 메시지 설정
	        } else {
	            // 로그인 실패 시
	            act = "로그인에 실패"; // 로그 메시지 설정
	        }
	        
	    } else if(funcName.equals("logoutProc")) {
	        // logoutProc 메서드가 실행된 경우
	        id = sid; // 세션에서 추출한 ID를 로그 대상 ID로 설정한다.
	        act = "로그아웃"; // 로그 메시지 설정
	        session.removeAttribute("SID"); // 세션에서 "SID" 속성을 제거한다.
	        
	    } else if(funcName.equals("joinProc")) {
	        // joinProc 메서드가 실행된 경우
	        // MemberVO 객체를 추출하여 회원가입 결과를 확인한다.
	        MemberVO mVO = (MemberVO) join.getArgs()[3];
	        int cnt = mVO.getCnt(); // 회원가입 결과 상태 코드
	        id = mVO.getId(); // 회원가입 시도한 회원의 ID
	        
	        if(cnt == 1) {
	            // 회원가입 성공 시
	            act = "회원가입에 성공"; // 로그 메시지 설정
	        } else {
	            // 회원가입 실패 시
	            act = "회원가입에 실패"; // 로그 메시지 설정
	        }
	    }
	    
	    // 로그 대상 회원의 ID와 수행된 동작을 로그로 기록한다.
	    membLog.info(id + " 회원이 " + act + "했습니다.");
	}
}
