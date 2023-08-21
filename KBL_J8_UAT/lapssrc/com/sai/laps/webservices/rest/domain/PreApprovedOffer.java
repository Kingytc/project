package com.sai.laps.webservices.rest.domain;

public class PreApprovedOffer {
	private String accountNo;
	private String customerID;
	
		
	public PreApprovedOffer() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	public PreApprovedOffer(String accountNo, String customerID) {
		super();
		this.accountNo = accountNo;
		this.customerID = customerID;
	}


	public String getAccountNo() {
		return accountNo;
	}
	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}
	public String getCustomerID() {
		return customerID;
	}
	public void setCustomerID(String customerID) {
		this.customerID = customerID;
	}
	
	
}
