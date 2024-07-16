package com.human.mis.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.EnableLoadTimeWeaving;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.human.mis.dao.RealTimeDao;
import com.human.mis.vo.MemberVO;
import com.human.mis.vo.RealTimeVO;

/**
 * 이 클래스는 실시간 미세먼지 정보를 보여주는 컨트롤러 클래스
 * @author 허광혁
 * @since 2024.07.04
 * @version v.1.0
 * 			
 * 			작업이력 ]
 * 					2024.07.04	: 	[ 담당자 ] 허광혁
 * 									미세먼지 실시간 폼 요청
 */

@Controller
@RequestMapping("/realTimeDust")
public class RealTime {
	@Autowired
	RealTimeDao rtDao;
	
	// 실시간화면 보기 요청
	@RequestMapping("view.mis")
	public ModelAndView goRealTimeDust(HttpSession session, ModelAndView mv, RedirectView rv, MemberVO mVO) {
		List<RealTimeVO> gooName_List = rtDao.getSeoulGooList();
		String sid = (String) session.getAttribute("SID");
		mv.addObject("SID", sid);
		mv.addObject("SLIST", gooName_List);
		mv.setViewName("realTimeView");
		return mv;
	}

	// 예측화면 요청
	@RequestMapping("goPred.mis")
	public ModelAndView goPred(HttpSession session, ModelAndView mv, RealTimeVO rtVO) {
		RealTimeVO realTimeVO = new RealTimeVO();
		List<RealTimeVO> attraction = rtDao.getAttraction(rtVO);
		List<String> cityNameList = rtDao.getCity();
		
		realTimeVO = rtDao.getWeather(rtVO);
		
		realTimeVO.setName(rtVO.getName());
		realTimeVO.setDate(rtVO.getDate());
		
		double discomfort = 0.81*realTimeVO.getTemp_avg()+0.01*realTimeVO.getHum_avg()*(0.99 * realTimeVO.getTemp_avg() - 14.3)+ 46.3;
		double disIndex = Math.round(discomfort * 100) / 100.0;
		
		String rainp_am = realTimeVO.getRainp_am();
		String rainp_pm = realTimeVO.getRainp_pm();
		String sid = (String) session.getAttribute("SID");
		
		mv.addObject("LCITY", cityNameList);
		mv.addObject("SID", sid);
		mv.addObject("ALIST", attraction);
		mv.addObject("RAINP_PM", rainp_pm);
		mv.addObject("RAINP_AM", rainp_am);
		mv.addObject("DISCOMFORT", disIndex);
		mv.addObject("PRED", realTimeVO);
		mv.setViewName("predView");
		return mv;
	}

	@RequestMapping("getCCTV.mis")
	@ResponseBody
	public HashMap<String, String> getCCTV(String name) {
		HashMap<String, String> map = new HashMap<String, String>();
		String gooCCTV = rtDao.getCCTV(name);
		map.put("result", gooCCTV);		
		return map;
	}
}
