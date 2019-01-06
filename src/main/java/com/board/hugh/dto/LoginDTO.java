package com.board.hugh.dto;

public class LoginDTO {
	private String uid;
	private String pw;
	private boolean usecookie;
	
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getpw() {
		return pw;
	}
	public void setpw(String pw) {
		this.pw = pw;
	}
	public boolean isUsecookie() {
		return usecookie;
	}
	public void setUsecookie(boolean usecookie) {
		this.usecookie = usecookie;
	}
	
	@Override
	public String toString() {
		return "LoginDTO [uid=" + uid + ", pw=" + pw + ", usecookie=" + usecookie + "]";
	}
	
}
