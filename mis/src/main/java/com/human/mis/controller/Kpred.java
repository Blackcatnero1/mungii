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
import java.util.*;

import com.human.mis.vo.*;
import com.human.mis.dao.*;

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
	@RequestMapping("/kpred.mis")
	public ModelAndView goTests(ModelAndView mv, HttpSession session) {
		String sid = (String) session.getAttribute("SID");
		KpredVO kpredVO = kDao.getCityDate();
		List cityList = kDao.getCityname();
		KpredVO kVO = kDao.selAccu();
		List rankList = kDao.accRank();
		List dateRank = kDao.dateRank(kpredVO.getKdate().substring(0,10));
		mv.addObject("RANKLIST", rankList);
		mv.addObject("ACCU", kVO);
		mv.addObject("CITYLIST", cityList);
		mv.addObject("DATERANK", dateRank);
		mv.addObject("MISLIST", kpredVO);
		mv.addObject("SID", sid);
		mv.setViewName("pred/kpred");
		return mv;
	}
	
	@RequestMapping("/selCityDate.mis")
	@ResponseBody
	public KpredVO selCityDate(String city, String kdate, KpredVO kVO) {
		kVO.setCity(city);
		kVO.setKdate(kdate);
		KpredVO vo = kDao.selCityDate(kVO);
		return vo;
	}
	@RequestMapping("/selDateRank.mis")
	@ResponseBody
	public List<KpredVO> selDateRank(String kdate, KpredVO kVO) {
		kVO.setKdate(kdate);
		List dateRank = kDao.dateRank(kVO.getKdate().substring(0,10));
		return dateRank;
	}
	// 로그아웃 처리 요청
	@RequestMapping("/klogout.mis")
	public ModelAndView klogout(HttpSession session, ModelAndView mv, RedirectView rv) {
		// 세션 빼기
		session.removeAttribute("SID");
		rv.setUrl("/mis/kpred/kpred.mis");
		mv.setView(rv);
		return mv;
	}
	// 로그인 폼 보기
	@RequestMapping("/klogin.mis")
	public ModelAndView login(ModelAndView mv) {
		mv.setViewName("member/login");
		return mv;
	}
	// 로그인 처리요청
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
	
	
	
