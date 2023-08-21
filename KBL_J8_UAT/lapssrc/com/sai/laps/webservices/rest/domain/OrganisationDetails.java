package com.sai.laps.webservices.rest.domain;

public class OrganisationDetails {
	
	private String organisationCode;
	
	public OrganisationDetails(){
		super();
	}
	
	public OrganisationDetails(String organisationCode){
		super();
		this.setOrganisationCode(organisationCode);
		}

	public void setOrganisationCode(String organisationCode) {
		this.organisationCode = organisationCode;
	}

	public String getOrganisationCode() {
		return organisationCode;
	}

}
