package com.mystudy.vo;

public class ImageFileVO {
	// 10.19수정함
	String imageCode, oriFilename, sysFilename, storagePath;
	int postCode, userCode;
	
	public String getImageCode() {
		return imageCode;
	}
	public void setImageCode(String imageCode) {
		this.imageCode = imageCode;
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
	public String getStoragePath() {
		return storagePath;
	}
	public void setStoragePath(String storagePath) {
		this.storagePath = storagePath;
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
	@Override
	public String toString() {
		return "ImageFileVO [imageCode=" + imageCode + ", oriFilename=" + oriFilename + ", sysFilename=" + sysFilename
				+ ", storagePath=" + storagePath + ", postCode=" + postCode + ", userCode=" + userCode + "]";
	}
	

	
}
