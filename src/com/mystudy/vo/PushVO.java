package com.mystudy.vo;

import java.sql.Date;

public class PushVO {
	
	private int pushCode, userCode1, userCode2, guestCode, comCode, check;
	private String content;
	private Date regdate;
	
	
	public PushVO() {
		super();
	}
	public PushVO(int pushCode, int userCode1, int userCode2, int guestCode, int comCode, int check, String content, Date regdate) {
		super();
		this.pushCode = pushCode;
		this.userCode1 = userCode1;
		this.userCode2 = userCode2;
		this.guestCode = guestCode;
		this.comCode = comCode;
		this.check = check;
		this.content = content;
		this.regdate = regdate;
	}
	@Override
	public String toString() {
		return "PushVO [pushCode=" + pushCode + ", userCode1=" + userCode1 + ", userCode2=" + userCode2 + ", guestCode="
				+ guestCode + ", comCode=" + comCode + ", check=" + check + ", content=" + content + ", regdate=" + regdate + "]";
	}
	
	
	
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getPushCode() {
		return pushCode;
	}
	public void setPushCode(int pushCode) {
		this.pushCode = pushCode;
	}
	public int getUserCode1() {
		return userCode1;
	}
	public void setUserCode1(int userCode1) {
		this.userCode1 = userCode1;
	}
	public int getUserCode2() {
		return userCode2;
	}
	public void setUserCode2(int userCode2) {
		this.userCode2 = userCode2;
	}
	public int getGuestCode() {
		return guestCode;
	}
	public void setGuestCode(int guestCode) {
		this.guestCode = guestCode;
	}
	public int getComCode() {
		return comCode;
	}
	public void setComCode(int comCode) {
		this.comCode = comCode;
	}
	public int getCheck() {
		return check;
	}
	public void setCheck(int check) {
		this.check = check;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	
	
	
}
