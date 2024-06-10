package com.human.mis.controller;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

/**
 * 이 클래스는 cafe 프로젝트의 컨트롤러 클래스로
 * "/main.cafe" 로 요청되는 경우 응답 문서를 선택해서 응답해주는 컨트롤러
 * @author 김한민
 * @since 2024.05.31
 * @version v.1.0
 * 			
 * 			작업이력 ]
 * 					2024.05.31	: 	[ 담당자 ] 김한민
 * 									컨트롤러 제작
 * 									"/main.cafe" URL 멥핑
 *
 */
@Controller
public class MainController {
	
	@RequestMapping("/main.mis")
	public String getMain() {
		return "main";
	}
	
}
