package com.aia.mangh.mm.model;

public class kakaoRequest {

	private String mId;
	private String mNick;
	private String mImg;
	private String kId;
	private String access_Token;

	public kakaoRequest(String mId, String mNick, String mImg, String kId, String access_Token) {

		this.mId = mId;
		this.mNick = mNick;
		this.mImg = mImg;
		this.kId = kId;
		this.access_Token = access_Token;
	}

	public kakaoRequest() {
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

	public String getmImg() {
		return mImg;
	}

	public void setmImg(String mImg) {
		this.mImg = mImg;
	}

	public String getkId() {
		return kId;
	}

	public void setkId(String kId) {
		this.kId = kId;
	}

	public String getAccess_Token() {
		return access_Token;
	}

	public void setAccess_Token(String access_Token) {
		this.access_Token = access_Token;
	}

	@Override
	public String toString() {
		return "kakaoRequest [mId=" + mId + ", mNick=" + mNick + ", mImg=" + mImg + ", kId=" + kId + ", access_Token="
				+ access_Token + "]";
	}

}
