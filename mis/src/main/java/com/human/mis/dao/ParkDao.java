package com.human.mis.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.human.mis.vo.ParkVO;

public class ParkDao {
	
	@Autowired
	SqlSessionTemplate session;
	
	public List<ParkVO> getPark(ParkVO pVO) {
		return session.selectList("pSQL.getPark", pVO);
	}
	
	public int getParkTotal(ParkVO pVO) {
		return session.selectOne("pSQL.getParkTotal", pVO);
	}
	
	public List<ParkVO> getParkList(ParkVO pVO) {
		return session.selectList("pSQL.getParkList", pVO);
	}
}
