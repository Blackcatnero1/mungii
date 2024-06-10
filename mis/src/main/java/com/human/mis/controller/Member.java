package com.human.mis.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.human.mis.dao.MemberDao;
import com.human.mis.vo.MemberVO;

/**
 * 이 클래스는 로그인 처리를 해주는 컨트롤러 클래스
 * @author 김한민
 * @since 2024.06.03
 * @version v.1.0
 * 			
 * 			작업이력 ]
 * 					2024.06.03	: 	[ 담당자 ] 김한민
 * 									로그인 폼보기 요청
 *									로그인 처리 요청
 */

@Controller
@RequestMapping("/member")
public class Member {
	@Autowired
	MemberDao mDao;
	// 로그인 폼 보기
	@RequestMapping("/login.mis")
	public ModelAndView login(ModelAndView mv) {
		mv.setViewName("member/login");
		return mv;
	}
	// 로그인 처리요청
	@RequestMapping("/loginProc.mis")
	public ModelAndView loginProc(HttpSession session, ModelAndView mv, RedirectView rv, MemberVO mVO) {
		
		String view = "/mis/main.mis";
		
		// getLogin() 에 login이 되면 있으면 1이 넘어 온다.
		int cnt = mDao.getLogin(mVO);
		// memberVO에 있는 setCnt() 를 사용해서 cnt를 넣어준다.
		mVO.setCnt(cnt);
		if(cnt != 1) {
			// 로그인에 실패한 상태
			view = "/mis/member/login.mis";
		} else {
			// 로그인에 성공한 상태
			session.setAttribute("SID", mVO.getId());
		}
		
		rv.setUrl(view);
		mv.setView(rv);
		return mv;
	}
	// 로그아웃 처리 요청
	@RequestMapping("/logout.mis")
	public ModelAndView logout(HttpSession session, ModelAndView mv, RedirectView rv) {
		// 세션 빼기
		session.removeAttribute("SID");
		rv.setUrl("/mis/main.mis");
		mv.setView(rv);
		return mv;
	}
	// 회원가입 처리 요청
	@RequestMapping("join.mis")
	public ModelAndView join(HttpSession session, ModelAndView mv) {
		mv.setViewName("member/join");
		return mv;
	}
	// 아이디 체크 처리 요청
	@RequestMapping("idCheck.mis")
	@ResponseBody
	public HashMap idCheck(String id) {
		HashMap map = new HashMap();
		// 데이터베이스 조회
		int cnt = mDao.idCheck(id);
		// 기본 값을 NO로 설정
		String result = "NO";
		if(cnt == 0) {
			// 아이디가 겹치지 않는 경우
			result="YES";
		} 
		
		map.put("result", result);
		return map;
	}
	// 회원가입 처리 요청
	@RequestMapping("joinProc.mis")
	public ModelAndView joinProc(HttpSession session, ModelAndView mv, RedirectView rv, MemberVO mVO) {
		
		// 데이터 베이스 작업
		int cnt = mDao.addMember(mVO);
		mVO.setCnt(cnt);
		
		// 뷰 셋팅하고
		if(cnt == 1) {
			// 회원가입에 성공한 경우
			session.setAttribute("SID", mVO.getId());
			rv.setUrl("/mis/main.mis");
		} else {
			rv.setUrl("/mis/member/join.mis");
		}
		mv.setView(rv);
		return mv;
	}
}
