package com.mystudy.vo;

public class FriendRequestVO {
	
	private int requestCode, checked;
	private String id, name, message, requesterCode;

	
	public FriendRequestVO() {
		super();
	}


	

	
	@Override
	public String toString() {
		return "FriendRequestVO [requestCode=" + requestCode + ", checked=" + checked + ", id=" + id + ", name=" + name
				+ ", message=" + message + ", requesterCode=" + requesterCode + "]";
	}





	public FriendRequestVO(int requestCode, int checked, String id, String name, String message, String requesterCode) {
		super();
		this.requestCode = requestCode;
		this.checked = checked;
		this.id = id;
		this.name = name;
		this.message = message;
		this.requesterCode = requesterCode;
	}





	public String getRequesterCode() {
		return requesterCode;
	}


	public void setRequesterCode(String requester) {
		this.requesterCode = requester;
	}


	public int getRequestCode() {
		return requestCode;
	}


	public void setRequestCode(int requestCode) {
		this.requestCode = requestCode;
	}


	public int getChecked() {
		return checked;
	}


	public void setChecked(int checked) {
		this.checked = checked;
	}


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getMessage() {
		return message;
	}


	public void setMessage(String message) {
		this.message = message;
	}
	

	
	
	
}
