package com.sai.laps.webservices.rest.domain;


public class GetGoldRate {
	private String date;
	public GetGoldRate() {
		super();
	}
     public GetGoldRate(String date)
     {
    	 super();
    	 this.date=date;
     }
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
}