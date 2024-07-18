package com.human.mis.dao;

import java.util.*;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;

import com.human.mis.vo.*;

public class KpredDao {
	@Autowired
	SqlSessionTemplate session;
	
	// 도시 리스트 조회 전담 처리함수
	public List<KpredVO> getCityname(){
		return session.selectList("kSQL.selCity");
	}
	
	// 도시, 날짜 선택 후 예측 데이터 조회 전담 처리함수
	public KpredVO selCityDate(KpredVO kVO) {
		return session.selectOne("kSQL.selCityDate", kVO);
	}
	
	// 도시 입력 후 해당 도시의 예측률 조회 전담 처리함수
	public KpredVO accCity(String city) {
		return session.selectOne("kSQL.accCity", city);
	}
	
	// 도시들의 예측률 순위 조회 전담 처리함수
	public List<KpredVO> accRank() {
		return session.selectList("kSQL.accRank");
	}
	
	// 선택한 날짜 미세먼지 순위 조회 전담 처리함수
	public List<KpredVO> dateRank(String kdate){
		return session.selectList("kSQL.dateRank", kdate);
	}
	
}
