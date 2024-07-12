package com.human.mis.vo;


public class ParkVO {
	private int pno, rno;
	private String pname, pmis, pcity, pkreview, plink, city, standard;
	
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public String getStandard() {
		return standard;
	}
	public void setStandard(String standard) {
		this.standard = standard;
	}
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
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getPkreview() {
		return pkreview;
	}
	public void setPkreview(String pkreview) {
		this.pkreview = pkreview;
	}
	public String getPlink() {
		return plink;
	}
	public void setPlink(String plink) {
		this.plink = plink;
	}
	@Override
	public String toString() {
		return "ParkVO [pno=" + pno + ", rno=" + rno + ", pname=" + pname + ", pmis=" + pmis + ", pcity=" + pcity
				+ ", pkreview=" + pkreview + ", plink=" + plink + ", city=" + city + ", standard=" + standard + "]";
	}
	
}
