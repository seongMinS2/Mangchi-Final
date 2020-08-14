package com.aia.mangh.mm.model;

import org.springframework.web.multipart.MultipartFile;

public class RegRequest {

	private String mId;
	private String mPw;
	private String mNick;
	private int mChk;
	private String chkEmail;
	private String mAddr;
	private double mLttd;
	private double mLgtd;
	private MultipartFile mImg;
	
	public RegRequest() {}
	
	public RegRequest(String mId, String mPw, String mNick, int mChk, String chkEmail, String mAddr, double mLttd,
			double mLgtd, MultipartFile mImg) {
		this.mId = mId;
		this.mPw = mPw;
		this.mNick = mNick;
		this.mChk = mChk;
		this.chkEmail = chkEmail;
		this.mAddr = mAddr;
		this.mLttd = mLttd;
		this.mLgtd = mLgtd;
		this.mImg = mImg;
	}

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

	public String getmNick() {
		return mNick;
	}

	public void setmNick(String mNick) {
		this.mNick = mNick;
	}

	public int getmChk() {
		return mChk;
	}

	public void setmChk(int mChk) {
		this.mChk = mChk;
	}

	public String getChkEmail() {
		return chkEmail;
	}

	public void setChkEmail(String chkEmail) {
		this.chkEmail = chkEmail;
	}

	public String getmAddr() {
		return mAddr;
	}

	public void setmAddr(String mAddr) {
		this.mAddr = mAddr;
	}

	public double getmLttd() {
		return mLttd;
	}

	public void setmLttd(double mLttd) {
		this.mLttd = mLttd;
	}

	public double getmLgtd() {
		return mLgtd;
	}

	public void setmLgtd(double mLgtd) {
		this.mLgtd = mLgtd;
	}

	public MultipartFile getmImg() {
		return mImg;
	}

	public void setmImg(MultipartFile mImg) {
		this.mImg = mImg;
	}
	
	@Override
	public String toString() {
		return "RegRequest [mId=" + mId + ", mPw=" + mPw + ", mNick=" + mNick + ", mChk=" + mChk + ", chkEmail="
				+ chkEmail + ", mAddr=" + mAddr + ", mLttd=" + mLttd + ", mLgtd=" + mLgtd + ", mImg=" + mImg + "]";
	}

	public Member toMember() {
		return new Member(mId,mPw,mNick,mAddr,mLttd,mLgtd,mChk);
	}
	
	
}
