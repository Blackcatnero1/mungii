package com.human.mis.dao;

import java.util.*;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;

import com.human.mis.vo.*;

public class KpredDao {
	@Autowired
	SqlSessionTemplate session;
	public List<KpredVO> getContinent() {
		return session.selectList("kSQL.getContinent");
	}
	public List<KpredVO> getCountry(String continent){
		return session.selectList("kSQL.getCountry", continent);
	}
	public List<KpredVO> getCity(KpredVO kVO){
		return session.selectList("kSQL.getCity", kVO);
	}
	public KpredVO getCityDate(){
		return session.selectOne("kSQL.cityDate");
	}
	public List<KpredVO> getCityname(){
		return session.selectList("kSQL.selCity");
	}
	public KpredVO selCityDate(KpredVO kVO) {
		return session.selectOne("kSQL.selCityDate", kVO);
	}
	
}