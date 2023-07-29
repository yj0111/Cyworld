package com.mystudy.vo;

import java.sql.Date;

public class FriendVO {

	private int friendCode, userCode1, userCode2;
	private Date regdate;
	private String friendName, name;
	
	public FriendVO() {}
	
	public FriendVO(int friendCode, int userCode1, int userCode2, Date regdate, String friendName, String name) {
		super();
		this.friendCode = friendCode;
		this.userCode1 = userCode1;
		this.userCode2 = userCode2;
		this.regdate = regdate;
		this.friendName = friendName;
		this.name = name;
	}
	@Override
	public String toString() {
		return "FriendVO [friendCode=" + friendCode + ", userCode1=" + userCode1 + ", userCode2=" + userCode2
				+ ", regdate=" + regdate + ", friendName=" + friendName + ", name=" + name + "]";
	}
	public int getFriendCode() {
		return friendCode;
	}
	public void setFriendCode(int friendCode) {
		this.friendCode = friendCode;
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
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public String getFriendName() {
		return friendName;
	}
	public void setFriendName(String friendName) {
		this.friendName = friendName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
}
