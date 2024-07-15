package com.human.mis.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.human.mis.util.PageUtil;
import com.human.mis.vo.*;

public class ParkDao {
	
	@Autowired
	SqlSessionTemplate session;
	
	public List<ParkVO> getParkList(PageUtil page) {
		return session.selectList("pSQL.getParkList", page);
	}
	
	public int getParkTotal() {
		return session.selectOne("pSQL.getParkTotal");
	}
	
	public List<ParkVO> misSort(PageUtil page){
		return session.selectList("pSQL.misSort", page);
	}
	
	public List<ParkVO> reviewSort(PageUtil page){
		return session.selectList("pSQL.reviewSort", page);
	}
	
	public List<ParkVO> recSort(PageUtil page){
		return session.selectList("pSQL.recSort", page);
	}
	
	public List<ParkVO> mainParkList(){
		return session.selectList("pSQL.mainParkList");
	}
	
	public KpredVO parkCityDate(String city) {
		return session.selectOne("kSQL.parkCityDate", city);
	}
}
