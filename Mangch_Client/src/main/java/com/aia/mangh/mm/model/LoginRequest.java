package com.aia.mangh.mm.model;

public class LoginRequest {
	
	private String mId;
	private String mPw;
	
	public LoginRequest(String mId, String mPw) {
		this.mId = mId;
		this.mPw = mPw;
	}

	public LoginRequest() {}
	
	

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	public String getmPw() {
		return mPw;
	}

	public void setmPw(String mPw) {
		this.mPw = mPw;
	}

	@Override
	public String toString() {
		return "LoginRequest [mId=" + mId + ", mPw=" + mPw + "]";
	}
}
