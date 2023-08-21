package com.sai.laps.webservices.rest.domain;

public class Birdata {
	
	private String regioncode;

	public Birdata() {
		super();
		// TODO Auto-generated constructor stub
	}

	public String getRegioncode() {
		return regioncode;
	}

	public void setRegioncode(String regioncode) {
		this.regioncode = regioncode;
	}

	// COnstructor using Fields
	public Birdata(String regioncode) {
		super();
		this.regioncode = regioncode;
	}

}
