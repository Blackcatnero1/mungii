package com.human.mis.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

public class ReboardVO {
	private int bno, rno, regroup, upBno, cnt, goods, level, nowPage, startRno, endRno;
	private String id, body, upno, savename, sdate;
	private Date wdate;
	public int getNowPage() {
		return nowPage;
	}
	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}
	public int getStartRno() {
		return startRno;
	}
	public void setStartRno(int startRno) {
		this.startRno = startRno;
	}
	public int getEndRno() {
		return endRno;
	}
	public void setEndRno(int endRno) {
		this.endRno = endRno;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public int getRegroup() {
		return regroup;
	}
	public void setRegroup(int regroup) {
		this.regroup = regroup;
	}
	public int getUpBno() {
		return upBno;
	}
	public void setUpBno(int upBno) {
		this.upBno = upBno;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public int getGoods() {
		return goods;
	}
	public void setGoods(int goods) {
		this.goods = goods;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getBody() {
		return body;
	}
	public void setBody(String body) {
		this.body = body;
	}
	public String getUpno() {
		return upno;
	}
	public void setUpno(String upno) {
		this.upno = upno;
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
	public void setSdate() {
		SimpleDateFormat form = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		sdate = form.format(wdate);
	}
	public Date getWdate() {
		return wdate;
	}
	public void setWdate(Date wdate) {
		this.wdate = wdate;
		setSdate();
	}
	@Override
	public String toString() {
		return "ReboardVO [bno=" + bno + ", rno=" + rno + ", regroup=" + regroup + ", cnt=" + cnt + ", goods=" + goods
				+ ", level=" + level + ", nowPage=" + nowPage + ", startRno=" + startRno + ", endRno=" + endRno
				+ ", id=" + id + ", body=" + body + ", upno=" + upno + ", savename=" + savename + ", sdate=" + sdate
				+ ", wdate=" + wdate + "]";
	}
	
}
