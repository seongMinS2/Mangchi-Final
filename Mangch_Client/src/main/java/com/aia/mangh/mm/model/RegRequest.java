package com.aia.mangh.mm.model;

import org.springframework.web.multipart.MultipartFile;

public class RegRequest {

	private String mId;
	private String mPw;
	private String mNick;
	private String chkmPw;
	private String mChk;
	private String mAddr;
	private double mLttd;
	private double mLgtd;
	private MultipartFile mImg;
	
	public RegRequest() {}
	


	public Member toMember() {
		return new Member(mId,mPw,mNick,mAddr,mLttd,mLgtd,mChk);
	}

	public RegRequest(String mId, String mPw, String mNick, String chkmPw, String mChk, String mAddr, double mLttd,
			double mLgtd, MultipartFile mImg) {
		this.mId = mId;
		this.mPw = mPw;
		this.mNick = mNick;
		this.chkmPw = chkmPw;
		this.mChk = mChk;
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



	public String getChkmPw() {
		return chkmPw;
	}



	public void setChkmPw(String chkmPw) {
		this.chkmPw = chkmPw;
	}



	public String getmChk() {
		return mChk;
	}



	public void setmChk(String mChk) {
		this.mChk = mChk;
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
		return "RegRequest [mId=" + mId + ", mPw=" + mPw + ", mNick=" + mNick + ", chkmPw=" + chkmPw + ", mChk=" + mChk
				+ ", mAddr=" + mAddr + ", mLttd=" + mLttd + ", mLgtd=" + mLgtd + ", mImg=" + mImg + "]";
	}
	
	
}
