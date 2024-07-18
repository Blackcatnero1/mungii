package com.human.mis.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.*;

import com.human.mis.vo.*;
import com.human.mis.dao.*;

/**
 * 이 클래스는 중(장)기 예측 관련 처리를 해주는 컨트롤러 클래스
 * @author 김광섭
 * @since 2024.07.09
 * @version v.1.0
 * 			
 * 			작업이력 ]
 * 					2024.07.09	: 	[ 담당자 ] 김광섭
 * 									중(장)기 예측 뷰 구성
 */

@Controller
@RequestMapping("/kpred")
public class Kpred {
	@Autowired
	KpredDao kDao;
	
	@Autowired
	MemberDao mDao;
	@Autowired
	HttpServletResponse response;
	
	@Bean
	public RestTemplate restTemplate() {
	    return new RestTemplate();
	}
	
	// 중(장)기 예측 기본 페이지 전담 처리함수
	@RequestMapping("/kpred.mis")
	public ModelAndView goTests(ModelAndView mv, HttpSession session) {
		String sid = (String) session.getAttribute("SID");
		String dcity = "서울";
		LocalDateTime currentTime = LocalDateTime.now();
		// LocalDateTime 객체를 문자열로 변환합니다.
        String todayString = currentTime.toString().substring(0, 10);
        KpredVO todayCityDateVO = new KpredVO();
        todayCityDateVO.setKdate(todayString);
        todayCityDateVO.setCity(dcity);
		KpredVO kpredVO = kDao.selCityDate(todayCityDateVO);
		List cityList = kDao.getCityname();
		KpredVO kVO = kDao.accCity(dcity);
		
		List rankList = kDao.accRank();
		List dateRank = kDao.dateRank(kpredVO.getKdate().substring(0,10));
		mv.addObject("DATERANK", dateRank);
		mv.addObject("RANKLIST", rankList);
		
		mv.addObject("ACCU", kVO);
		mv.addObject("CITYLIST", cityList);
		mv.addObject("MISLIST", kpredVO);
		mv.addObject("SID", sid);
		mv.setViewName("pred/kpred");
		return mv;
	}
	
	// 도시, 날짜 선택 후 비동기 데이터 전송 전담 처리함수
	@RequestMapping("/selCityDate.mis")
	@ResponseBody
	public KpredVO selCityDate(String city, String kdate, KpredVO kVO) {
		kVO.setCity(city);
		kVO.setKdate(kdate);
		KpredVO vo = kDao.selCityDate(kVO);
		return vo;
	}
	
	// 날짜 선택 후 해당 날짜의 미세먼지 순위 데이터 전담 처리함수
	@RequestMapping("/selDateRank.mis")
	@ResponseBody
	public List<KpredVO> selDateRank(String kdate, KpredVO kVO) {
		kVO.setKdate(kdate);
		List dateRank = kDao.dateRank(kVO.getKdate().substring(0,10));
		return dateRank;
	}
	
	// 중(장)기 예측 전담 로그아웃 처리 요청
	@RequestMapping("/klogout.mis")
	public ModelAndView klogout(HttpSession session, ModelAndView mv, RedirectView rv) {
		// 세션 빼기
		session.removeAttribute("SID");
		rv.setUrl("/mis/kpred/kpred.mis");
		mv.setView(rv);
		return mv;
	}
	// 중(장)기 예측 전담 로그인 폼 보기
	@RequestMapping("/klogin.mis")
	public ModelAndView login(ModelAndView mv) {
		mv.setViewName("member/login");
		return mv;
	}
	
	// 중(장)기 예측 전담 로그인 처리요청
	@RequestMapping("/kloginProc.mis")
	public ModelAndView loginProc(HttpSession session, ModelAndView mv, RedirectView rv, MemberVO mVO) {
		String view = "/mis/kpred/kpred.mis";
		// getLogin() 에 login이 되면 있으면 1이 넘어 온다.
		int cnt = mDao.getLogin(mVO);
		// memberVO에 있는 setCnt() 를 사용해서 cnt를 넣어준다.
		mVO.setCnt(cnt);
		if(cnt != 1) {
			// 로그인에 실패한 상태
			view = "/mis/member/klogin.mis";
		} else {
			// 로그인에 성공한 상태
			session.setAttribute("SID", mVO.getId());
		}
		rv.setUrl(view);
		mv.setView(rv);
		return mv;
	}
	
}	
	
	
	
