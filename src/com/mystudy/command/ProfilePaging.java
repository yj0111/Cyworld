package com.mystudy.command;

public class ProfilePaging {
	private int nowPage = 1;
	private int nowBlock = 1;
	
	private int numViewPage = 3;
	private int numViewBlock = 3;

	
	private int totalProfile = 0;
	private int totalPage = 0;
	private int totalBlock = 0;
	
	private int begin = 0;
	private int end = 0;
	
	private int beginPage = 0;
	private int endPage = 0;
	
	// 전체 페이지
	public void setTotalPage() {
		totalPage = totalProfile / numViewPage;
		if (totalProfile % numViewPage > 0 ) totalPage++;
	}
	
	
	
	public int getNowPage() {
		return nowPage;
	}
	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}
	public int getNowBlock() {
		return nowBlock;
	}
	public void setNowBlock(int nowBlock) {
		this.nowBlock = nowBlock;
	}
	public int getNumViewPage() {
		return numViewPage;
	}
	public void setNumViewPage(int numViewPage) {
		this.numViewPage = numViewPage;
	}
	public int getNumViewBlock() {
		return numViewBlock;
	}
	public void setNumViewBlock(int numViewBlock) {
		this.numViewBlock = numViewBlock;
	}
	public int getTotalProfile() {
		return totalProfile;
	}
	public void setTotalProfile(int totalProfile) {
		this.totalProfile = totalProfile;
	}
	public int getTotalPage() {
		return totalPage;
	}

	public int getTotalBlock() {
		return totalBlock;
	}
	public void setTotalBlock(int totalBlock) {
		this.totalBlock = totalBlock;
	}
	public int getBegin() {
		return begin;
	}
	public void setBegin(int begin) {
		this.begin = begin;
	}
	public int getEnd() {
		return end;
	}
	public void setEnd(int end) {
		this.end = end;
	}
	public int getBeginPage() {
		return beginPage;
	}
	public void setBeginPage(int beginPage) {
		this.beginPage = beginPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	
	

	
	
}
