package com.human.mis.controller;

import org.springframework.context.annotation.*;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 이 클래스는 지정시간에 데이터 추가를 위해 Django서버에 요청을 하기 위한 Scheduler 클래스
 * @author	김광섭
 * @version v.2.9
 * 	클래스 제작 [ 담당자 : 김광섭 ]
 */

@Configuration
@EnableScheduling
public class SchedulerConfig {
	
    @Bean
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }

    @Scheduled(cron = "0 50 10 * * *")
    public void callSalesEndpoint() {
        LocalDateTime currentTime = LocalDateTime.now();
        String[] urls = {"crawling", "crawling2", "crawling3"};
        for(int i = 0 ; i < urls.length; i++) {
        	String url = "http://58.72.151.124:6012/" + urls[i];
        	RestTemplate restTemplate = restTemplate();
        	try {
        		String result = restTemplate.getForObject(url, String.class);
        		System.out.println("현재 시간: " + currentTime);
        		System.out.println(i + 1 + "번째 스케쥴링에 성공하였습니다.");
        	} catch (HttpServerErrorException e) {
        		System.out.println("현재 시간: " + currentTime);
        		System.out.println(i + 1 + "번째 스케쥴링에 성공하였습니다.");
        	} catch (Exception e) {
        		System.err.println("Unexpected error: " + e.getMessage().replaceAll("\n", " ").replaceAll("\r", " "));
        	}
        	
        }
    }
}