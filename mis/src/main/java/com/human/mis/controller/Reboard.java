package com.human.mis.controller;

import java.util.*;

import javax.servlet.http.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;
import org.springframework.web.servlet.view.*;

import com.human.mis.dao.*;
import com.human.mis.util.*;
import com.human.mis.vo.*;

/**
 * 이 클래스는 댓글 게시판 관련 요청을 처리해주는 컨트롤러 클래스
 * @author 김한민
 * @since 2024.06.03
 * @version v.1.0
 * 			
 * 			작업이력 ]
 * 					2024.06.03	: 	[ 담당자 ] 김한민
 * 									리스트 폼보기 요청
 *									글쓰기 폼보기 요청
 *					
 *					2024.06.04	: 	[ 담당자 ] 김한민
 *									리스트 폼보기 요청 수정 페이지 객체 추가 수정
 *									글 등록 요청 추가
 */


@Controller
@RequestMapping("/reboard")
public class Reboard {
	@Autowired
	ReboardDao rDao;
	
	@RequestMapping("/reboard.mis")
	public ModelAndView reboardList(HttpSession session, ModelAndView mv, 
											RedirectView rv, PageUtil page) {
		int total = rDao.getTotal();
		page.setTotalCount(total);
		page.setPage();
		
		List list = rDao.getList(page);
		mv.addObject("LIST", list);
		mv.addObject("PAGE", page);
		mv.setViewName("reboard/reboard");
		return mv;
	}
	
	/**
	 * 게시글 작성 폼보기 요청
	 */
	@RequestMapping("/reboardWrite.mis")
	public ModelAndView reboardWrite(HttpSession session, ModelAndView mv, 
											RedirectView rv, ReboardVO rVO) {
		mv.addObject("DATA", rVO);
		mv.setViewName("reboard/reboardWrite");
		return mv;
	}
	
	/**
	 * 댓글 쓰기 폼보기 요청 처리함수
	 */
	@RequestMapping("/reboardRewrite.mis")
	public ModelAndView reboardRewrite(HttpSession session, ModelAndView mv, 
			RedirectView rv, ReboardVO rVO, PageUtil page) {
		rVO = rDao.getUpContent(rVO.getBno());
		rVO.setNowPage(page.getNowPage());
		mv.addObject("DATA", rVO);
		mv.setViewName("reboard/reboardWrite");
		return mv;
	}
	
	/**
	 * 게시글 등록 요청 처리 함수
	 */
	@RequestMapping("/reboardWriteProc.mis")
	public ModelAndView reboardWriteProc(HttpSession session, ModelAndView mv, RedirectView rv, ReboardVO rVO) {
		// 작업 순서
		// 0. 세션검사는 인터셉터에서 처리
		// 1. 데이터 입력하고 결과 받고
		int cnt = rDao.addBoard(rVO);
		// 2. 결과 처리
		String path = "";
		if(cnt == 1) {
			// 성공한 경우
			path = "/mis/reboard/reboard.mis";
		} else {
			// 실패한 경우
			if(rVO.getLevel() == 0) {
				path = "/mis/reboard/reboardWrite.mis";				
			} else {
				path = "/mis/reboard/reboardRewrite.mis";				
				mv.addObject("BNO", rVO.getBno());
			}
		}
		// 데이터 전달 하고
		mv.addObject("nowPage", rVO.getNowPage());
		mv.addObject("PATH", path);
		mv.setViewName("redirect");
		return mv;
	}
	
	/**
	 * 게시글 삭제 요청 처리 함수
	 */
	@RequestMapping("/delReboard.mis")
	public ModelAndView delReboard(HttpSession session, ModelAndView mv, 
											RedirectView rv, ReboardVO rVO) {
		int cnt = rDao.delReboard(rVO);
		String path = "/mis/reboard/reboard.mis";
		
		mv.addObject("PATH", path);
		mv.addObject("nowPage", rVO.getNowPage());
		mv.setViewName("redirect");
		return mv;
	}
	
	/**
	 * 좋아요 수 증가 요청 처리 함수
	 */
	@RequestMapping("/addGood.mis")
	public ModelAndView addGood(HttpSession session, ModelAndView mv, 
											RedirectView rv, ReboardVO rVO) {
		rDao.addGood(rVO.getBno());
		mv.addObject("nowPage", rVO.getNowPage());
		mv.addObject("PATH", "/mis/reboard/reboard.mis");
		mv.setViewName("redirect");
		return mv;
	}
}
