package com.mystudy.vo;

public class BoardVO {
	
	private int rNum, postCode, userCode, hit;
	private String title, content ,regdate;
		
	public BoardVO() {
	}

	public BoardVO(int rNum, int postCode, int userCode, int hit, String title, String content, String regdate) {
		this.rNum = rNum;
		this.postCode = postCode;
		this.userCode = userCode;
		this.hit = hit;
		this.title = title;
		this.content = content;
		this.regdate = regdate;
	}



	
	public int getrNum() {
		return rNum;
	}

	public void setrNum(int rNum) {
		this.rNum = rNum;
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

	public int getHit() {
		return hit;
	}

	public void setHit(int hit) {
		this.hit = hit;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
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
		return "BoardVO [postCode=" + postCode + ", userCode=" + userCode + ", hit=" + hit + ", title=" + title
				+ ", content=" + content + ", regdate=" + regdate + "]";
	}
	

	
}
