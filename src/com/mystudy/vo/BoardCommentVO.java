package com.mystudy.vo;

public class BoardCommentVO {

	private int comCode, postCode, userCode;
	private String name, content ,regdate;
		
	public BoardCommentVO() {}
	public BoardCommentVO(int comCode, int postCode, int userCode, String name, String content, String regdate) {
		this.comCode = comCode;
		this.postCode = postCode;
		this.userCode = userCode;
		this.name = name;
		this.content = content;
		this.regdate = regdate;
	}
	
	public int getComCode() {
		return comCode;
	}
	public void setComCode(int comCode) {
		this.comCode = comCode;
	}
	public int getPostCode() {
		return postCode;
	}
	public void setPostCode(int postCode) {
		this.postCode = postCode;
	}
	public int getUserCode() {
		return userCode;
	}
	public void setUserCode(int userCode) {
		this.userCode = userCode;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
		return "BoardCommentVO [comCode=" + comCode + ", postCode=" + postCode + ", userCode=" + userCode + ", name="
				+ name + ", content=" + content + ", regdate=" + regdate + "]";
	}
		
	
	
}
