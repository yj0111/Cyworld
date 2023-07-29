package com.mystudy.vo;

public class HomeStateVO {
	int userCode, today, total ;
	String homeName, regdate;
	
	
	
	
	
	public HomeStateVO() {
		super();
	}






	public int getUserCode() {
		return userCode;
	}






	public void setUserCode(int userCode) {
		this.userCode = userCode;
	}






	public int getToday() {
		return today;
	}






	public void setToday(int today) {
		this.today = today;
	}






	public int getTotal() {
		return total;
	}






	public void setTotal(int total) {
		this.total = total;
	}






	public String getHomeName() {
		return homeName;
	}






	public void setHomeName(String homeName) {
		this.homeName = homeName;
	}






	public String getRegdate() {
		return regdate;
	}






	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}






	@Override
	public String toString() {
		return "HomeStateVO [userCode=" + userCode + ", today=" + today + ", total=" + total + ", homeName=" + homeName
				+ ", regdate=" + regdate + "]";
	}
	
	
	
}
