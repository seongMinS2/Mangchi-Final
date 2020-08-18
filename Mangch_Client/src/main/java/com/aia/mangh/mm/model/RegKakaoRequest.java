package com.aia.mangh.mm.model;

import org.springframework.web.multipart.MultipartFile;

public class RegKakaoRequest {

	private String mId;
	//private String mPw;
	private String mNick;
	private String mAddr;
	private double mLttd;
	private double mLgtd;
	private MultipartFile mImg;
	private String kImg;
	private String kId;
	
	public RegKakaoRequest() {}
	
	public Member toMember() {
		return new Member(mId,mNick,mAddr,mLttd,mLgtd, kId);
	}

	public RegKakaoRequest(String mId, String mNick, String mAddr, double mLttd, double mLgtd, MultipartFile mImg,
			String kImg, String kId) {
		this.mId = mId;
		this.mNick = mNick;
		this.mAddr = mAddr;
		this.mLttd = mLttd;
		this.mLgtd = mLgtd;
		this.mImg = mImg;
		this.kImg = kImg;
		this.kId = kId;
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

	public String getkImg() {
		return kImg;
	}

	public void setkImg(String kImg) {
		this.kImg = kImg;
	}

	public String getkId() {
		return kId;
	}

	public void setkId(String kId) {
		this.kId = kId;
	}

	@Override
	public String toString() {
		return "RegKakaoRequest [mId=" + mId + ", mNick=" + mNick + ", mAddr=" + mAddr + ", mLttd=" + mLttd + ", mLgtd="
				+ mLgtd + ", mImg=" + mImg + ", kImg=" + kImg + ", kId=" + kId + "]";
	}
	
	
	

	
}
