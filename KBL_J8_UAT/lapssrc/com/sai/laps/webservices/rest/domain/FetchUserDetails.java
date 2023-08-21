package com.sai.laps.webservices.rest.domain;

public class FetchUserDetails {

	private String orgCode;
	
	public FetchUserDetails() {
		super();
	}

	public FetchUserDetails(String orgCode) {
		super();
		
		this.orgCode=orgCode;
	}
	
	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}

	public String getOrgCode() {
		return orgCode;
	}
}
