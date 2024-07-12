package com.human.mis.vo;

import java.text.*;
import java.util.*;

public class KpredVO {
	private int cnt;
	private String continent, country, cityname, kdate, pm25_beijing, pm10_beijing, no2_beijing, so2_beijing, o3_beijing,
    co_beijing, actual_pm25, actual_pm10, actual_no2, actual_so2,
    actual_o3, actual_co, predicted_pm25, predicted_pm10, predicted_no2,
    predicted_so2, predicted_o3, predicted_co, city;
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getContinent() {
		return continent;
	}
	public void setContinent(String continent) {
		this.continent = continent;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getCityname() {
		return cityname;
	}
	public void setCityname(String cityname) {
		this.cityname = cityname;
	}
	public String getKdate() {
		return kdate;
	}
	public void setKdate(String kdate) {
		this.kdate = kdate;
	}
	public String getPm25_beijing() {
		return pm25_beijing;
	}
	public void setPm25_beijing(String pm25_beijing) {
		this.pm25_beijing = pm25_beijing;
	}
	public String getPm10_beijing() {
		return pm10_beijing;
	}
	public void setPm10_beijing(String pm10_beijing) {
		this.pm10_beijing = pm10_beijing;
	}
	public String getNo2_beijing() {
		return no2_beijing;
	}
	public void setNo2_beijing(String no2_beijing) {
		this.no2_beijing = no2_beijing;
	}
	public String getSo2_beijing() {
		return so2_beijing;
	}
	public void setSo2_beijing(String so2_beijing) {
		this.so2_beijing = so2_beijing;
	}
	public String getO3_beijing() {
		return o3_beijing;
	}
	public void setO3_beijing(String o3_beijing) {
		this.o3_beijing = o3_beijing;
	}
	public String getCo_beijing() {
		return co_beijing;
	}
	public void setCo_beijing(String co_beijing) {
		this.co_beijing = co_beijing;
	}
	public String getActual_pm25() {
		return actual_pm25;
	}
	public void setActual_pm25(String actual_pm25) {
		this.actual_pm25 = actual_pm25;
	}
	public String getActual_pm10() {
		return actual_pm10;
	}
	public void setActual_pm10(String actual_pm10) {
		this.actual_pm10 = actual_pm10;
	}
	public String getActual_no2() {
		return actual_no2;
	}
	public void setActual_no2(String actual_no2) {
		this.actual_no2 = actual_no2;
	}
	public String getActual_so2() {
		return actual_so2;
	}
	public void setActual_so2(String actual_so2) {
		this.actual_so2 = actual_so2;
	}
	public String getActual_o3() {
		return actual_o3;
	}
	public void setActual_o3(String actual_o3) {
		this.actual_o3 = actual_o3;
	}
	public String getActual_co() {
		return actual_co;
	}
	public void setActual_co(String actual_co) {
		this.actual_co = actual_co;
	}
	public String getPredicted_pm25() {
		return predicted_pm25;
	}
	public void setPredicted_pm25(String predicted_pm25) {
		this.predicted_pm25 = predicted_pm25;
	}
	public String getPredicted_pm10() {
		return predicted_pm10;
	}
	public void setPredicted_pm10(String predicted_pm10) {
		this.predicted_pm10 = predicted_pm10;
	}
	public String getPredicted_no2() {
		return predicted_no2;
	}
	public void setPredicted_no2(String predicted_no2) {
		this.predicted_no2 = predicted_no2;
	}
	public String getPredicted_so2() {
		return predicted_so2;
	}
	public void setPredicted_so2(String predicted_so2) {
		this.predicted_so2 = predicted_so2;
	}
	public String getPredicted_o3() {
		return predicted_o3;
	}
	public void setPredicted_o3(String predicted_o3) {
		this.predicted_o3 = predicted_o3;
	}
	public String getPredicted_co() {
		return predicted_co;
	}
	public void setPredicted_co(String predicted_co) {
		this.predicted_co = predicted_co;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	@Override
	public String toString() {
		return "MapVO [cnt=" + cnt + ", continent=" + continent + ", country=" + country + ", cityname=" + cityname
				+ ", kdate=" + kdate + ", pm25_beijing=" + pm25_beijing + ", pm10_beijing=" + pm10_beijing
				+ ", no2_beijing=" + no2_beijing + ", so2_beijing=" + so2_beijing + ", o3_beijing=" + o3_beijing
				+ ", co_beijing=" + co_beijing + ", actual_pm25=" + actual_pm25 + ", actual_pm10=" + actual_pm10
				+ ", actual_no2=" + actual_no2 + ", actual_so2=" + actual_so2 + ", actual_o3=" + actual_o3
				+ ", actual_co=" + actual_co + ", predicted_pm25=" + predicted_pm25 + ", predicted_pm10="
				+ predicted_pm10 + ", predicted_no2=" + predicted_no2 + ", predicted_so2=" + predicted_so2
				+ ", predicted_o3=" + predicted_o3 + ", predicted_co=" + predicted_co + ", city=" + city + "]";
	}
}
