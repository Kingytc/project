package com.sai.laps.webservices.rest.domain;

public class DedupeCheck {

	private static final long serialVersionUID = 1L;
	
	private String panno;
	private String cbsid;
	
	public DedupeCheck() {
		super();
		// TODO Auto-generated constructor stub
	}

	public DedupeCheck(String panno, String cbsid) {
		super();
		this.panno = panno;
		this.cbsid = cbsid;
	}

	public String getPanno() {
		return panno;
	}

	public void setPanno(String panno) {
		this.panno = panno;
	}

	public String getCbsid() {
		return cbsid;
	}

	public void setCbsid(String cbsid) {
		this.cbsid = cbsid;
	}
	
	
	
	
}
