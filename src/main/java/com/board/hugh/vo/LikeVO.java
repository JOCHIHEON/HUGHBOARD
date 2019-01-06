package com.board.hugh.vo;

public class LikeVO {
	private int lno;
	private int bno;
	private String uid;
	
	public int getLno() {
		return lno;
	}
	public void setLno(int lno) {
		this.lno = lno;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	
	@Override
	public String toString() {
		return "LikeVO [lno=" + lno + ", bno=" + bno + ", uid=" + uid + "]";
	}
	
}
