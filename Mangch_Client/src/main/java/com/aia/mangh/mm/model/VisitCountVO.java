package com.aia.mangh.mm.model;

import java.sql.Date;

public class VisitCountVO {

	private int visit_id;
	private String visit_ip;
	private Date visit_time;
	private String visit_agent;
	
	public VisitCountVO(int visit_id, String visit_ip, Date visit_time, String visit_agent) {
		this.visit_id = visit_id;
		this.visit_ip = visit_ip;
		this.visit_time = visit_time;
		this.visit_agent = visit_agent;
	}
	public VisitCountVO() {
	}
	public int getVisit_id() {
		return visit_id;
	}
	public void setVisit_id(int visit_id) {
		this.visit_id = visit_id;
	}
	public String getVisit_ip() {
		return visit_ip;
	}
	public void setVisit_ip(String visit_ip) {
		this.visit_ip = visit_ip;
	}
	public Date getVisit_time() {
		return visit_time;
	}
	public void setVisit_time(Date visit_time) {
		this.visit_time = visit_time;
	}

	public String getVisit_agent() {
		return visit_agent;
	}
	public void setVisit_agent(String visit_agent) {
		this.visit_agent = visit_agent;
	}
	
	@Override
	public String toString() {
		return "VisitCountVO [visit_id=" + visit_id + ", visit_ip=" + visit_ip + ", visit_time=" + visit_time
				+ ", visit_agent=" + visit_agent + "]";
	}
	
}
