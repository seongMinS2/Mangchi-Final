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
	private String kId;
	private String mDel;

	public Member(int mIdx, String mId, String mPw, String mNick, float mScore, Date mRegdate, String mAddr,
			double mLttd, double mLgtd, String mImg, String mChk, int mRadius, String kId, String mDel) {
		super();
		this.mIdx = mIdx;
		this.mId = mId;
		this.mPw = mPw;
		this.mNick = mNick;
		this.mScore = mScore;
		this.mRegdate = mRegdate;
		this.mAddr = mAddr;
		this.mLttd = mLttd;
		this.mLgtd = mLgtd;
		this.mImg = mImg;
		this.mChk = mChk;
		this.mRadius = mRadius;
		this.kId = kId;
		this.mDel = mDel;
	}

	public Member(String mId, String mPw, String mNick, String mAddr, double mLttd, double mLgtd, String mChk) {
		this(0, mId, mPw, mNick, 2.5f, null, mAddr, mLttd, mLgtd, null, mChk, 1, null, null);
	}
	
	public Member(String mId, String mNick, String mAddr, double mLttd, double mLgtd,  String kId) {
		this(0, mId, null, mNick, 2.5f, null, mAddr, mLttd, mLgtd, null, null,1 , kId, null);
	}

	public LoginInfo toLoginInfo() {
		return new LoginInfo(mIdx, mId, mNick, mScore, mRegdate, mAddr, mLttd, mLgtd, mImg, mChk, mRadius, kId, null);
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

	public String getkId() {
		return kId;
	}

	public void setkId(String kId) {
		this.kId = kId;
	}

	public String getmDel() {
		return mDel;
	}

	public void setmDel(String mDel) {
		this.mDel = mDel;
	}

	public java.util.Date getToDate() {
		return new java.util.Date(mRegdate.getTime());
	}

	@Override
	public String toString() {
		return "Member [mIdx=" + mIdx + ", mId=" + mId + ", mPw=" + mPw + ", mNick=" + mNick + ", mScore=" + mScore
				+ ", mRegdate=" + mRegdate + ", mAddr=" + mAddr + ", mLttd=" + mLttd + ", mLgtd=" + mLgtd + ", mImg="
				+ mImg + ", mChk=" + mChk + ", mRadius=" + mRadius + ", kId=" + kId + ", mDel=" + mDel + "]";
	}

}
