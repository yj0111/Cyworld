package com.mystudy.vo;

public class UserVO {
	private int userCode, guestAuthority; 




	private String id, password, email, phone, name, birth, gender, regdate;
	
	public UserVO(int userCode,String id, String password, String email, String phone, String name,  String birth, String gender,
			String regdate, int guestAuthority) {
		this.userCode = userCode;
		this.id = id;
		this.password = password;
		this.email = email;
		this.phone = phone;
		this.name = name;
		this.birth = birth;
		this.gender = gender;
		this.regdate = regdate;
		this.guestAuthority = guestAuthority;
	}
	
	
	

	public UserVO() {
		super();
	}



	public int getGuestAuthority() {
		return guestAuthority;
	}
	
	
	public void setGuestAuthority(int guestAuthority) {
		this.guestAuthority = guestAuthority;
	}

	public int getUserCode() {
		return userCode;
	}



	public void setUserCode(int userCode) {
		this.userCode = userCode;
	}



	public String getId() {
		return id;
	}



	public void setId(String id) {
		this.id = id;
	}



	public String getPassword() {
		return password;
	}



	public void setPassword(String password) {
		this.password = password;
	}



	public String getEmail() {
		return email;
	}



	public void setEmail(String email) {
		this.email = email;
	}



	public String getPhone() {
		return phone;
	}



	public void setPhone(String phone) {
		this.phone = phone;
	}



	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}



	public String getBirth() {
		return birth;
	}



	public void setBirth(String birth) {
		this.birth = birth;
	}



	public String getGender() {
		return gender;
	}




	public void setGender(String gender) {
		this.gender = gender;
	}




	public String getRegdate() {
		return regdate;
	}



	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}




	@Override
	public String toString() {
		return "UserVO [userCode=" + userCode + ", id=" + id + ", password=" + password + ", email=" + email
				+ ", phone=" + phone + ", name=" + name + ", birth=" + birth + ", gender=" + gender + ", regdate="
				+ regdate + ", guestAuthority=" + guestAuthority + "]";
	}



	
	
	
	
}
