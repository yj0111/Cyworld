package com.mystudy.vo;


import java.sql.Date;

public class GuestBookVO {
	
	private String content;
	private int guestCode, userCode, writerCode;
	private Date regdate;
	
	
	
	public GuestBookVO() {
		super();
	}
	@Override
	public String toString() {
		return "GuestBookVO [content=" + content + ", guestCode=" + guestCode + ", userCode=" + userCode
				+ ", writerCode=" + writerCode + ", regdate=" + regdate + "]";
	}
	public GuestBookVO(String content, int guestCode, int userCode, int writerCode, Date regdate) {
		super();
		this.content = content;
		this.guestCode = guestCode;
		this.userCode = userCode;
		this.writerCode = writerCode;
		this.regdate = regdate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getGuestCode() {
		return guestCode;
	}
	public void setGuestCode(int guestCode) {
		this.guestCode = guestCode;
	}
	public int getUserCode() {
		return userCode;
	}
	public void setUserCode(int userCode) {
		this.userCode = userCode;
	}
	public int getWriterCode() {
		return writerCode;
	}
	public void setWriterCode(int writerCode) {
		this.writerCode = writerCode;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	
	
}
