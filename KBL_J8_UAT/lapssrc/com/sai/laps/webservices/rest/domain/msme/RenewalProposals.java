package com.sai.laps.webservices.rest.domain.msme;

public class RenewalProposals {
	

	private String renewalDate;
	private String custId;

	public RenewalProposals() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public RenewalProposals(String renewalDate,String custId) {
		super();
		this.renewalDate = renewalDate;
		this.custId = custId;
	}

	public String getRenewalDate() {
		return renewalDate;
	}

	public void setRenewalDate(String renewalDate) {
		this.renewalDate = renewalDate;
	}

	public void setCustId(String custId) {
		this.custId = custId;
	}

	public String getCustId() {
		return custId;
	}

}
