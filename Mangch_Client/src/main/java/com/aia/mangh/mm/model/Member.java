package com.aia.mangh.mm.model;

import java.sql.Date;

public class Member {

	private int mIdx;
	private String mId;
	private String mPw;
	private String mNick;
	private float mScore;
	private Date mRegdate;
	private String mAddr;
	private double mLttd;
	private double mLgtd;
	private String mImg;
	private String mChk;
	private int mRadius;

	public Member(int mIdx, String mId, String mPw, String mNick, float mScore, Date mRegdate, String mAddr,
			double mLttd, double mLgtd, String mImg, String mChk, int mRadius) {
		this.mIdx = mIdx;
		this.mId = mId;
		this.mPw = mPw;
		this.mNick = mNick;
		this.mScore = mScore;
		this.mRegdate = mRegdate;
		this.mLttd = mLttd;
		this.mLgtd = mLgtd;
		this.mAddr = mAddr;
		this.mImg = mImg;
		this.mChk = mChk;
		this.mRadius = mRadius;
	}

	public Member(String mId, String mPw, String mNick, String mAddr, double mLttd, double mLgtd, String mChk) {
		this(0, mId, mPw, mNick, 2.5f, null, mAddr, mLttd, mLgtd, null, mChk, 0);
	}

	public LoginInfo toLoginInfo() {
		return new LoginInfo(mIdx, mId, mNick, mScore, mRegdate, mAddr, mLttd, mLgtd, mImg, mChk, mRadius);
	}

	public Member() {
	}

	public int getmIdx() {
		return mIdx;
	}

	public void setmIdx(int mIdx) {
		this.mIdx = mIdx;
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

	public float getmScore() {
		return mScore;
	}

	public void setmScore(float mScore) {
		this.mScore = mScore;
	}

	public Date getmRegdate() {
		return mRegdate;
	}

	public void setmRegdate(Date mRegdate) {
		this.mRegdate = mRegdate;
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

	public String getmAddr() {
		return mAddr;
	}

	public void setmAddr(String mAddr) {
		this.mAddr = mAddr;
	}

	public String getmImg() {
		return mImg;
	}

	public void setmImg(String mImg) {
		this.mImg = mImg;
	}

	public String getmChk() {
		return mChk;
	}

	public void setmChk(String mChk) {
		this.mChk = mChk;
	}

	public int getmRadius() {
		return mRadius;
	}

	public void setmRadius(int mRadius) {
		this.mRadius = mRadius;
	}

	public java.util.Date getToDate() {
		return new java.util.Date(mRegdate.getTime());
	}

	@Override
	public String toString() {
		return "Member [mIdx=" + mIdx + ", mId=" + mId + ", mPw=" + mPw + ", mNick=" + mNick + ", mScore=" + mScore
				+ ", mRegdate=" + mRegdate + ", mLttd=" + mLttd + ", mLgtd=" + mLgtd + ", mAddr=" + mAddr + ", mImg="
				+ mImg + ", mChk=" + mChk + ", mRadius=" + mRadius + "]";
	}
}
