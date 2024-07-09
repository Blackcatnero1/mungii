package com.human.mis.vo;


public class ParkVO {
	private int pno;
	private String pname, pmis, pcity, pkreview;
	public int getPno() {
		return pno;
	}
	public void setPno(int pno) {
		this.pno = pno;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getPmis() {
		return pmis;
	}
	public void setPmis(String pmis) {
		this.pmis = pmis;
	}
	public String getPcity() {
		return pcity;
	}
	public void setPcity(String pcity) {
		this.pcity = pcity;
	}
	public String getPkreview() {
		return pkreview;
	}
	public void setPkreview(String pkreview) {
		this.pkreview = pkreview;
	}
	@Override
	public String toString() {
		return "ParkVO [pno=" + pno + ", pname=" + pname + ", pmis=" + pmis + ", pcity=" + pcity + ", pkreview="
				+ pkreview + "]";
	}
}
