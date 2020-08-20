package com.aia.mangh.mm.model;

import org.springframework.web.multipart.MultipartFile;

public class EditRequest {

	private String mId;
	private String mNick;
	private String mAddr;
	private double mLttd;
	private double mLgtd;
	private MultipartFile mImg;
	private int mRadius;
	

	public EditRequest(String mId, String mNick, String mAddr, double mLttd, double mLgtd, MultipartFile mImg,
			int mRadius) {
		this.mId = mId;
		this.mNick = mNick;
		this.mAddr = mAddr;
		this.mLttd = mLttd;
		this.mLgtd = mLgtd;
		this.mImg = mImg;
		this.mRadius = mRadius;
	}

	public EditRequest() {
	}
	
	public EditRequest2 toEditMember() {
		return new EditRequest2(mId,mNick,mAddr,mLttd,mLgtd,null,mRadius);
	}
	public String getmId() {
		return mId;
	}
	public void setmId(String mId) {
		this.mId = mId;
	}
	public String getmNick() {
		return mNick;
	}
	public void setmNick(String mNick) {
		this.mNick = mNick;
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
	
	public int getmRadius() {
		return mRadius;
	}

	public void setmRadius(int mRadius) {
		this.mRadius = mRadius;
	}

	@Override
	public String toString() {
		return "EditRequest [mId=" + mId + ", mNick=" + mNick + ", mAddr=" + mAddr + ", mLttd=" + mLttd + ", mLgtd="
				+ mLgtd + ", mImg=" + mImg + ", mRadius=" + mRadius + "]";
	}

}
