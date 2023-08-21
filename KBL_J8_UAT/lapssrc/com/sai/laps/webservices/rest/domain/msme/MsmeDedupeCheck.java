package com.sai.laps.webservices.rest.domain.msme;

public class MsmeDedupeCheck {

	private String panno;
	private String cbsid;
	
	public MsmeDedupeCheck() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MsmeDedupeCheck(String panno, String cbsid) {
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
