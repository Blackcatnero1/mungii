package com.human.mis.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.human.mis.dao.ParkDao;
import com.human.mis.util.PageUtil;
import com.human.mis.vo.ParkVO;

/**
 * 이 클래스는 태마파크 정보를 처리를 해주는 컨트롤러 클래스
 * @author 김한민
 * @since 2024.07.09
 * @version v.1.0
 * 			
 * 			작업이력 ]
 * 					2024.07.09	: 	[ 담당자 ] 김한민
 * 									테마파크 리스트 뷰 작업
 */
@Controller
@RequestMapping("/park")
public class Park {
	@Autowired
	ParkDao pDao;
	
	@RequestMapping("/park.mis")
	public ModelAndView getPark(HttpSession session, ModelAndView mv, 
											RedirectView rv, PageUtil page) {
		// 페이지 기본값 설정
		int nowPage = page.getNowPage();
		if(nowPage == 0) {
			nowPage = 1;
		}
		
		int total = pDao.getParkTotal();
		page.setTotalCount(total);
		page.setPage(nowPage, total);
		
		// 데이터 베이스에서 조회
		List<ParkVO> list = pDao.getParkList(page);
		
		
		// 데이터 전달하고
		mv.addObject("LIST", list);
		mv.addObject("PAGE", page);
		
		// 뷰 셋팅하고
		mv.setViewName("park");
		return mv;
	}
}
