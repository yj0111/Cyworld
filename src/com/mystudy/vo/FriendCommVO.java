package com.mystudy.vo;

public class FriendCommVO {
	int friendCommCode, userCode, guestCode;
	String content, regdate, guestName, friendName;
	
	
	public String getFriendName() {
		return friendName;
	}
	public void setFriendName(String friendName) {
		this.friendName = friendName;
	}
	public String getGuestName() {
		return guestName;
	}
	public void setGuestName(String guestName) {
		this.guestName = guestName;
	}
	public int getFriendCommCode() {
		return friendCommCode;
	}
	public void setFriendCommCode(int friendCommCode) {
		this.friendCommCode = friendCommCode;
	}
	public int getUserCode() {
		return userCode;
	}
	public void setUserCode(int userCode) {
		this.userCode = userCode;
	}
	public int getGuestCode() {
		return guestCode;
	}
	public void setGuestCode(int guestCode) {
		this.guestCode = guestCode;
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
		return "FriendCommVO [friendCommCode=" + friendCommCode + ", userCode=" + userCode + ", guestCode=" + guestCode
				+ ", content=" + content + ", regdate=" + regdate + ", guestName=" + guestName + "]";
	}
	
	
	
	
}
