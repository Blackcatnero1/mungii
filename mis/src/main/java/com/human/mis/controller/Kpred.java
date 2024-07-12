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
		mv.addObject("CITYLIST", cityList);
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
}	
	
	
	
