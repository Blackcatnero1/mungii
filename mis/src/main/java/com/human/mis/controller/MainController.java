package com.human.mis.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.http.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.human.mis.dao.*;
import com.human.mis.vo.*;

@Controller
public class MainController {
    @Autowired
    ParkDao pDao;

    @Bean
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }
    @Autowired
    RestTemplate restTemplate;
    @RequestMapping("/main.mis")
    public ModelAndView getMain(ModelAndView mv, ParkVO pVO) {
        // 이하 코드는 기존과 동일
        String url = "https://www.iqair.com/ko/world-air-quality-ranking/cleanest-cities";
        String url2 = "https://www.iqair.com/ko/south-korea";
        try {
            // HttpHeaders 객체를 생성하여 헤더 설정
            HttpHeaders headers = new HttpHeaders();
            headers.set("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101 Firefox/91.0");

            // HttpEntity를 사용하여 헤더를 포함하는 요청 생성
            HttpEntity<String> entity = new HttpEntity<>(headers);

            // RestTemplate을 사용하여 HTTP 요청
            ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
            ResponseEntity<String> response2 = restTemplate.exchange(url2, HttpMethod.GET, entity, String.class);
            String htmlContent = response.getBody();
            String htmlContent2 = response2.getBody();

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
            List mpList = pDao.mainParkList();
            mv.addObject("LIST", mpList);
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
}
