package com.human.mis.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

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
	@Bean
	public RestTemplate restTemplate() {
	    return new RestTemplate();
	}
	
	@RequestMapping("/main.mis")
	public ModelAndView getMain(ModelAndView mv) {
		mv.setViewName("main");
		String url = "https://www.iqair.com/ko/world-air-quality-ranking/cleanest-cities";
		String url2 = "https://www.iqair.com/ko/south-korea";
		try {
            // URL 호출하여 HTML 콘텐츠 가져오기
            RestTemplate restTemplate = new RestTemplate();
            String htmlContent = restTemplate.getForObject(url, String.class);
            String htmlContent2 = restTemplate.getForObject(url2,  String.class);
            
            // HTML 파싱
            Document doc = Jsoup.parse(htmlContent);
            Document doc2 = Jsoup.parse(htmlContent2);
            
            // a 태그와 aqi-number div 찾기
            Elements links = doc.select("a.city-label");
            Elements aqiNumbers = doc.select("div.aqi-number");
            Elements aqiNumber2 = doc2.select("p.iqair-aqi-pill");
            Elements links2 = doc2.select("img.flag");
            
            List<Map<String, String>> linksList = new ArrayList<>();
            List<Map<String, String>> linksList2 = new ArrayList<>();

            int count = 0;
            for (int i = 0; i < links.size() && i < 10; i++) {
                Element link = links.get(i);
                Element aqiNumber = aqiNumbers.get(i);
                Element innerCityy = links2.get(i).nextElementSibling();
                Element aqiNumber3 = aqiNumber2.get(10 + i);
                
                String linkText = link.text();
                String linkHref = "https://www.iqair.com" + link.attr("href");
                String aqilink = aqiNumber.text();
                
                String innerCity = innerCityy.text();
                String linkHref2 = "https://www.iqair.com" + innerCityy.attr("href");
                String aqilink2 = aqiNumber3.text();
                
                Map<String, String> linkMap = new HashMap<>();
                Map<String, String> linkMap2 = new HashMap<>();
                
                linkMap.put("text", linkText);
                linkMap.put("href", linkHref);
                linkMap.put("aqi", aqilink);
                
                linkMap2.put("text", innerCity);
                linkMap2.put("href", linkHref2);
                linkMap2.put("aqi", aqilink2);
                
                
                linksList.add(linkMap);
                linksList2.add(linkMap2);
                count++;
            }
            // 상위 10개의 a 태그와 aqi-number div를 포함한 List를 ModelAndView에 추가
            mv.addObject("linksList", linksList);
            mv.addObject("linksList2", linksList2);
        } catch (Exception e) {
            e.printStackTrace();
            mv.addObject("linksList", "Failed to fetch content");
        }
        return mv;
    }
	
	@RequestMapping("/temp.mis")
	public String getTemp() {
		return "temp";
	}
	
	@RequestMapping("/park.mis")
	public String getPark() {
		return "park";
	}
	
}
