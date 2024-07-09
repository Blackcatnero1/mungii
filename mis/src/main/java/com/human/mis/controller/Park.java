package com.human.mis.controller;

import org.springframework.web.bind.annotation.RequestMapping;

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

public class Park {
	@RequestMapping("/park.mis")
	public String getPark() {
		return "park";
	}
}
