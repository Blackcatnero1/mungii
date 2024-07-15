package com.human.mis.vo;

public class RealTimeVO {
	private int code, apicode, temp_min, temp_max, temp_avg, rain_avg, wind_avg, wind_max, hum_avg,
					pred_pm10, pred_pm25;
	private double pred_oz, pred_no2, pred_co, pred_so;
	private String name, date, wind_deg, rainp_am, rainp_pm, attraction, stars;
	
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public int getApicode() {
		return apicode;
	}
	
	public int getTemp_min() {
		return temp_min;
	}
	public void setTemp_min(int temp_min) {
		this.temp_min = temp_min;
	}
	public int getTemp_max() {
		return temp_max;
	}
	public void setTemp_max(int temp_max) {
		this.temp_max = temp_max;
	}
	public int getTemp_avg() {
		return temp_avg;
	}
	public void setTemp_avg(int temp_avg) {
		this.temp_avg = temp_avg;
	}
	public int getRain_avg() {
		return rain_avg;
	}
	public void setRain_avg(int rain_avg) {
		this.rain_avg = rain_avg;
	}
	public int getWind_avg() {
		return wind_avg;
	}
	public void setWind_avg(int wind_avg) {
		this.wind_avg = wind_avg;
	}
	public String getWind_deg() {
		return wind_deg;
	}
	public void setWind_deg(String wind_deg) {
		this.wind_deg = wind_deg;
	}
	public int getWind_max() {
		return wind_max;
	}
	public void setWind_max(int wind_max) {
		this.wind_max = wind_max;
	}
	public int getHum_avg() {
		return hum_avg;
	}
	public void setHum_avg(int hum_avg) {
		this.hum_avg = hum_avg;
	}
	public double getPred_oz() {
		return pred_oz;
	}
	public void setPred_oz(double pred_oz) {
		this.pred_oz = pred_oz;
	}
	public double getPred_no2() {
		return pred_no2;
	}
	public void setPred_no2(double pred_no2) {
		this.pred_no2 = pred_no2;
	}
	public double getPred_co() {
		return pred_co;
	}
	public void setPred_co(double pred_co) {
		this.pred_co = pred_co;
	}
	public double getPred_so() {
		return pred_so;
	}
	public void setPred_so(double pred_so) {
		this.pred_so = pred_so;
	}
	public int getPred_pm10() {
		return pred_pm10;
	}
	public void setPred_pm10(int pred_pm10) {
		this.pred_pm10 = pred_pm10;
	}
	public int getPred_pm25() {
		return pred_pm25;
	}
	public void setPred_pm25(int pred_pm25) {
		this.pred_pm25 = pred_pm25;
	}
	public String getStars() {
		return stars;
	}
	public void setStars(String stars) {
		this.stars = stars;
	}
	public void setApicode(int apicode) {
		this.apicode = apicode;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getRainp_am() {
		return rainp_am;
	}
	public void setRainp_am(String rainp_am) {
		this.rainp_am = rainp_am;
	}
	public String getRainp_pm() {
		return rainp_pm;
	}
	public void setRainp_pm(String rainp_pm) {
		this.rainp_pm = rainp_pm;
	}
	public String getAttraction() {
		return attraction;
	}
	public void setAttraction(String attraction) {
		this.attraction = attraction;
	}
	public String getStar() {
		return stars;
	}
	public void setStar(String star) {
		this.stars = star;
	}
	
}
