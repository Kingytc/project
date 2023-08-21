package com.sai.laps.webservices.rest.domain;

public class LandHolding {

	private String landHold;
	private String surveyNo;
	private String ownedOrLeased;
	private String farmerCategory;
	private String landLessLabourType;

	

	public LandHolding() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	public LandHolding(String landHold, String surveyNo, String ownedOrLeased, String farmerCategory, String landLessLabourType)
	{
		
		super();
		this.landHold=landHold;
		this.surveyNo=surveyNo;
		this.ownedOrLeased=ownedOrLeased;
		this.farmerCategory=farmerCategory;
		this.landLessLabourType=landLessLabourType;	
	}


	public String getLandHold() {
		return landHold;
	}


	public void setLandHold(String landHold) {
		this.landHold = landHold;
	}


	public String getSurveyNo() {
		return surveyNo;
	}


	public void setSurveyNo(String surveyNo) {
		this.surveyNo = surveyNo;
	}


	public String getOwnedOrLeased() {
		return ownedOrLeased;
	}


	public void setOwnedOrLeased(String ownedOrLeased) {
		this.ownedOrLeased = ownedOrLeased;
	}


	public String getFarmerCategory() {
		return farmerCategory;
	}


	public void setFarmerCategory(String farmerCategory) {
		this.farmerCategory = farmerCategory;
	}


	public String getLandLessLabourType() {
		return landLessLabourType;
	}


	public void setLandLessLabourType(String landLessLabourType) {
		this.landLessLabourType = landLessLabourType;
	}
	
	
	
	
	
}


