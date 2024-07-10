package com.human.mis.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.human.mis.util.PageUtil;
import com.human.mis.vo.ParkVO;

public class ParkDao {
	
	@Autowired
	SqlSessionTemplate session;
	
	public List<ParkVO> getParkList(PageUtil page) {
		return session.selectList("pSQL.getParkList", page);
	}
	
	public int getParkTotal() {
		return session.selectOne("pSQL.getParkTotal");
	}
	
}
