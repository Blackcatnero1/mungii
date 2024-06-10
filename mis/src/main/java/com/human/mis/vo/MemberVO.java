package com.human.mis.vo;

import java.text.*;
import java.util.*;
public class MemberVO {
	private int mno, ano, cnt;
	private String name, id, pw, mail, tel, gen, savename, sdate;
	private Date jdate;
	public int getMno() {
		return mno;
	}
	public void setMno(int mno) {
		this.mno = mno;
	}
	public int getAno() {
		return ano;
	}
	public void setAno(int ano) {
		this.ano = ano;
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
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getGen() {
		return gen;
	}
	public void setGen(String gen) {
		this.gen = gen;
	}
	public String getSavename() {
		return savename;
	}
	public void setSavename(String savename) {
		this.savename = savename;
	}
	public String getSdate() {
		return sdate;
	}
	public void setSdate(String sdate) {
		this.sdate = sdate;
	}
	public Date getJdate() {
		return jdate;
	}
	public void setJdate(Date jdate) {
		this.jdate = jdate;
		SimpleDateFormat form = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		sdate = form.format(jdate);
	}
	@Override
	public String toString() {
		return "MemberVO [mno=" + mno + ", ano=" + ano + ", cnt=" + cnt + ", name=" + name + ", id=" + id + ", pw=" + pw
				+ ", mail=" + mail + ", tel=" + tel + ", gen=" + gen + ", savename=" + savename + ", sdate=" + sdate
				+ ", jdate=" + jdate + "]";
	}
}