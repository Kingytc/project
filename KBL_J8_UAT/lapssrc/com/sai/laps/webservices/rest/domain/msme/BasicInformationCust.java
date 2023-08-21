package com.sai.laps.webservices.rest.domain.msme;

public class BasicInformationCust {
	
	private String customerID;
	private String proposalID;
	private String facilityID;
	private String finYears;
	
	
	public BasicInformationCust() {
		super();
		// TODO Auto-generated constructor stub
	}

	public BasicInformationCust(String customerID, String proposalID,
			String facilityID, String finYears) {
		super();
		this.customerID = customerID;
		this.proposalID = proposalID;
		this.facilityID = facilityID;
		this.finYears = finYears;
		
	}

	public String getCustomerID() {
		return customerID;
	}

	public void setCustomerID(String customerID) {
		this.customerID = customerID;
	}

	public String getProposalID() {
		return proposalID;
	}

	public void setProposalID(String proposalID) {
		this.proposalID = proposalID;
	}

	public String getFacilityID() {
		return facilityID;
	}

	public void setFacilityID(String facilityID) {
		this.facilityID = facilityID;
	}

	public String getFinYears() {
		return finYears;
	}

	public void setFinYears(String finYears) {
		this.finYears = finYears;
	}
	
	

}
