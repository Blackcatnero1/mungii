package com.human.mis.dao;

import java.util.*;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.human.mis.vo.RealTimeVO;


public class RealTimeDao {
	@Autowired
	SqlSessionTemplate session;
	/**
	 * 게시글등록 데이터베이스작업 전담 처리함수
	 */
	public List<RealTimeVO> getSeoulGooList() {
		return session.selectList("rtSQL.GooName");
	}

	/**
	 * CCTV URL 매핑
	 */
	public String getCCTV(String name) {
		return session.selectOne("rtSQL.getCCTV", name);
	}

	/**
	 * 일기예보 전담 처리 함수
	 */
	public RealTimeVO getWeather(RealTimeVO rtVO) {
		return session.selectOne("rtSQL.getWeather", rtVO);
	}

	/**
	 * 관광명소 가져오기
	 */
	public List<RealTimeVO> getAttraction(RealTimeVO rtVO) {
		return session.selectList("rtSQL.getAttraction", rtVO);
	}

	/**
	 * 도시 가져오기
	 */
	public List<String> getCity() {
		return session.selectList("rtSQL.getCityName");
	}

	/**
	 * 질병 여부 가져오기
	 */
	public String getAche(String id) {
		return session.selectOne("rtSQL.getAche", id);
	}
}
