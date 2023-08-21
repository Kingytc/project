package com.sai.laps.webservices.rest.domain;

public class GenDmsUpd {
	
	private String larNumber;
	private String dmsRferenceNumber;
	
	
	public GenDmsUpd(){
		super();
	}
	
	public GenDmsUpd(String larNumber,String dmsRferenceNumber){
		super();
		this.larNumber = larNumber;
		this.dmsRferenceNumber = dmsRferenceNumber;
	}

	public void setLarNumber(String larNumber) {
		this.larNumber = larNumber;
	}

	public String getLarNumber() {
		return larNumber;
	}

	public void setDmsRferenceNumber(String dmsRferenceNumber) {
		this.dmsRferenceNumber = dmsRferenceNumber;
	}

	public String getDmsRferenceNumber() {
		return dmsRferenceNumber;
	}

}
