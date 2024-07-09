package com.human.mis.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.human.mis.vo.ParkVO;

public class ParkDao {
	
	@Autowired
	SqlSessionTemplate session;
	
	public int getPark(ParkVO pVO) {
		return session.selectOne("pSQL.getPark", pVO);
	}
}
