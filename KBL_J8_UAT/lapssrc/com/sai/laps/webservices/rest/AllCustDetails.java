package com.sai.laps.webservices.rest;

public class AllCustDetails {
	
	private String CustomerId;
	
	

	public AllCustDetails() {
		super();
		// TODO Auto-generated constructor stub
	}

	public AllCustDetails(String CustomerId)
	{
		this.CustomerId=CustomerId;
	}

	public void setCustomerId(String customerId) {
		CustomerId = customerId;
	}

	public String getCustomerId() {
		return CustomerId;
	}

}
