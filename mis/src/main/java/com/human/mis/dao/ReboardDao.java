package com.human.mis.dao;

import java.util.*;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.human.mis.util.PageUtil;
import com.human.mis.vo.*;

public class ReboardDao {
	@Autowired
	SqlSessionTemplate session;
	
	/**
	 * 게시글등록 데이터베이스작업 전담 처리함수
	 */
	public int addBoard(ReboardVO rVO) {
		return session.insert("rSQL.addBoard", rVO);
	}
	
	/**
	 * 상위 글 정보 조회 전담 처리함수
	 */
	public ReboardVO getUpContent(int bno) {
		return session.selectOne("rSQL.upContent", bno);
	}
	
	/**
	 * 총 게시글 수 조회 전담 처리함수
	 */
	public int getTotal() {
		return session.selectOne("rSQL.getTotal");
	}
	
	/**
	 * 게시글 리스트 조회 전담 처리함수
	 */
	public List getList(PageUtil page) {
		return session.selectList("rSQL.getList", page);
	}
	
	/**
	 * 게시글 삭제 전담 처리함수
	 */
	public int delReboard(ReboardVO rVO) {
		return session.update("rSQL.delReboard", rVO);
	}
	
	/**
	 * 좋아요 수 증가 전담 처리함수
	 */
	public int addGood(int bno) {
		return session.update("rSQL.addGood", bno);
	}
}
