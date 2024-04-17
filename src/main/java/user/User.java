package user;

import java.util.Date;

public class User {
	private String userID;
	private String userPassword;
	private String userName;
	private String userNickname;
	private String userEmail;
	//private Date regDate;
	
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserNickname() {
		return userNickname;
	}
	public void setUserNickname(String userNickname) {
		this.userNickname = userNickname;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	/*
	 * public Date getRegDate() { return regDate; } public void setRegDate(Date
	 * regDate) { this.regDate = regDate; }
	 */
	

	/* 한 명의 회원 데이터를 다룰 수 있는 데이터베이스 및 자바빈즈(jsp에서 하나의 데이터를 관리하고 처리하는 기법) 완성 */	
}