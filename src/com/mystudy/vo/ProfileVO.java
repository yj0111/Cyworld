package com.mystudy.vo;

public class ProfileVO {
	int profileCode, userCode;
	String oriFilename, sysFilename, content, regdate;
	
	public int getProfileCode() {
		return profileCode;
	}
	public void setProfileCode(int profileCode) {
		this.profileCode = profileCode;
	}
	public int getUserCode() {
		return userCode;
	}
	public void setUserCode(int userCode) {
		this.userCode = userCode;
	}
	public String getOriFilename() {
		return oriFilename;
	}
	public void setOriFilename(String oriFilename) {
		this.oriFilename = oriFilename;
	}
	public String getSysFilename() {
		return sysFilename;
	}
	public void setSysFilename(String sysFilename) {
		this.sysFilename = sysFilename;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	@Override
	public String toString() {
		return "ProfileVO [profileCode=" + profileCode + ", userCode=" + userCode + ", oriFilename=" + oriFilename
				+ ", sysFilename=" + sysFilename + ", content=" + content + ", regdate=" + regdate + "]";
	}
	
	
	
	
	
}
