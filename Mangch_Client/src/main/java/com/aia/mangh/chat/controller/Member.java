package com.aia.mangh.chat.controller;

public class Member {
	private int idx;
	private String id;
	private String pw;
	private String nick;
	private float score;
	private String regdate;
	private double latitude;
	private double longitude;
	private String addr;
	private String img;
	private int check;
	private int radius;
	
	
	public Member(
			int idx, 
			String id, 
			String pw, 
			String nick,
			float score, 
			String regdate,
			double latitude,
			double longitude,
			String addr, 
			String img, 
			int check, 
			int radius) {
		this.idx = idx;
		this.id = id;
		this.pw = pw;
		this.nick = nick;
		this.score = score;
		this.regdate = regdate;
		this.latitude = latitude;
		this.longitude = longitude;
		this.addr = addr;
		this.img = img;
		this.check = check;
		this.radius = radius;
	}
	
	public Member() {}

	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	public float getScore() {
		return score;
	}
	public void setScore(float score) {
		this.score = score;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public double getLatitude() {
		return latitude;
	}
	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}
	public double getLongitude() {
		return longitude;
	}
	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public int getCheck() {
		return check;
	}
	public void setCheck(int check) {
		this.check = check;
	}
	public int getRadius() {
		return radius;
	}
	public void setRadius(int radius) {
		this.radius = radius;
	}
	
	
}
