package com.sai.laps.webservices.rest.domain;

public class FetchProposals {

	private String panNumber;
	private String startDate;
	private String mobileNumber;
	private String cbscustid;

	
	 public FetchProposals(){
		 super();
	 }
	 
	 public FetchProposals(String panNumber,String startDate,String mobileNumber, String cbscustid){
		 
		 this.panNumber=panNumber;
		 this.startDate=startDate;
		 this.mobileNumber=mobileNumber;
		 this.cbscustid=cbscustid;
		 
	 }
	 
	public void setPanNumber(String panNumber) {
		this.panNumber = panNumber;
	}

	public String getPanNumber() {
		return panNumber;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setMobileNumber(String mobileNumber) {
		this.mobileNumber = mobileNumber;
	}

	public String getMobileNumber() {
		return mobileNumber;
	}

	public void setCbscustid(String cbscustid) {
		this.cbscustid = cbscustid;
	}

	public String getCbscustid() {
		return cbscustid;
	}
}
