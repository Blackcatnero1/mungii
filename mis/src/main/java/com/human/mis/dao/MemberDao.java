package com.human.mis.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.human.mis.vo.MemberVO;

public class MemberDao {
	@Autowired
	SqlSessionTemplate session;
	
	public int getLogin(MemberVO mVO) {
		return session.selectOne("mSQL.login", mVO);
	}
	
	public int idCheck(String id) {
		return session.selectOne("mSQL.idCheck", id);
	}
	
	public int addMember(MemberVO mVO) {
		return session.insert("mSQL.addMember", mVO);
	}
	
	public MemberVO memberInfo(String id){
		return session.selectOne("mSQL.memberInfo", id);
	}
}
