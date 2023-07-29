package com.mystudy.vo;


import java.sql.Date;

public class GuestBookViewVO {
	
	private String content, name, sysFilename;
	private int rNum;
	private int guestCode, writerCode;
	private Date regdate;
	
	
	
	




	@Override
	public String toString() {
		return "GuestBookViewVO [content=" + content + ", name=" + name + ", sysFilename=" + sysFilename + ", rownum="
				+ rNum + ", guestCode=" + guestCode + ", writerCode=" + writerCode + ", regdate=" + regdate + "]";
	}


	
	
	public GuestBookViewVO() {
		super();
	}


	public GuestBookViewVO(String content, String name, String sysFilename, int rNum, int guestCode, int writerCode,
			Date regdate) {
		super();
		this.content = content;
		this.name = name;
		this.sysFilename = sysFilename;
		this.rNum = rNum;
		this.guestCode = guestCode;
		this.writerCode = writerCode;
		this.regdate = regdate;
	}





	public int getrNum() {
		return rNum;
	}




	public void setrNum(int rNum) {
		this.rNum = rNum;
	}




	public String getContent() {
		return content;
	}




	public void setContent(String content) {
		this.content = content;
	}




	public String getName() {
		return name;
	}




	public void setName(String name) {
		this.name = name;
	}




	public String getSysFilename() {
		return sysFilename;
	}




	public void setSysFilename(String sysFilename) {
		this.sysFilename = sysFilename;
	}




	public int getGuestCode() {
		return guestCode;
	}




	public void setGuestCode(int guestCode) {
		this.guestCode = guestCode;
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
