package com.aia.mangh.chat.model;

public class SendMsgInfo {
	
	private int reqIdx;
	private String uNick;
	
	
	public int getReqIdx() {
		return reqIdx;
	}
	public void setReqIdx(int reqIdx) {
		this.reqIdx = reqIdx;
	}
	public String getuNick() {
		return uNick;
	}
	public void setuNick(String uNick) {
		this.uNick = uNick;
	}
	@Override
	public String toString() {
		return "SendMsgInfo [reqIdx=" + reqIdx + ", uNick=" + uNick + "]";
	}
	
	
}
