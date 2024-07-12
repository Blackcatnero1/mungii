package com.human.mis.vo;

import java.text.SimpleDateFormat;
import java.util.*;

public class MemberVO {
	private int mno, cnt;
	private String nickname, name, id, pw, home, gen, sdate;
	private Date jdate;
	public int getMno() {
		return mno;
	}
	public void setMno(int mno) {
		this.mno = mno;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getSdate() {
		return sdate;
	}
	public void setSdate(String sdate) {
		this.sdate = sdate;
	}
	public String getGen() {
		return gen;
	}
	public void setGen(String gen) {
		this.gen = gen;
	}
	public Date getJdate() {
		return jdate;
	}
	public void setJdate(Date jdate) {
		this.jdate = jdate;
		SimpleDateFormat form = new SimpleDateFormat("yyyy-MM-dd");
		sdate = form.format(jdate);
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getHome() {
		return home;
	}
	public void setHome(String home) {
		this.home = home;
	}
	@Override
	public String toString() {
		return "MemberVO [mno=" + mno + ", cnt=" + cnt + ", nickname=" + nickname + ", name=" + name + ", id=" + id
				+ ", pw=" + pw + ", home=" + home + ", gen=" + gen + ", jdate=" + jdate + "]";
	}

}