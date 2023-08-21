package com.sai.laps.webservices.rest.domain;

import java.io.Serializable;

public class SecurityCreation implements Serializable {
	
	
	private static final long serialVersionUID = 1L;
	private String securityType;
	private String securityClassification;
	private String alChrgdToOtherBanks;
	private String natureOfCharge;
	private String valuerName;
	private String dateOfSubmissionForValuation;
	private String dateOfReceiptOfValuation;
	private String dateOfValuation;
	private String securityDescription;
	private String collateralStartDate;
	private String collateralEndDate ;
	private String totalSecurityValue ;
	private String lapsId;
	
	private String cbsId;
	private String propertyType;
	private String plotNo;
	private String streetNo;
	private String wardNo;
	private String address;
	private String city;
	private String district;
	private String state;
	private String pinCode;
	private String totalArea;
	private String extentOfBuilding;
	private String valueAsPerValuation;
	private String forcedSaleValue;
	private String titleDeedsBranch;
	private String surveyNo;
	private String propertyAcquisition;
	private String legalAdviserName;
	private String dateOfSubmissionForLegalOpinion;
	private String dateOfReceiptOfLegalOpinion;
	private String dateOfLegalOpinion;
	private String flowOfTitle;
	private String ecObtained;
	private String latestTaxPaidYear;
	private String flowOfTitleSearchFromProp;
	private String periodOfEC;
	
	private String vehicleType;
	private String company;
	private String vehicleCatogery;
	private String model;
	private String vehicleAge;
	private String bookValue;
	private String purchasePrice;
	private String engineNo;
	private String regState;
	private String dealerName;
	private String contactNo;
	private String dealerAddress;
	private String dealerCity;
	private String dealerState;
	private String dealerDistrict;
	private String dealerCountry;
	private String dealerpinCode;
	private String dealerMailId;
	private String dealerCode;
	private String dealerGstNo;
	private String ownerName;
	private String doorNo;
	private String ownerAddress;
	private String ownerCity;
	private String ownerState;
	private String ownerDistrict;
	private String ownerCountry;
	private String ownergPinCode;
	private String make;
	private String ownerSalutation;
	private String owneraddress2;
	private String dealeraddress2;
	private String solID;
	
	
	
	
	public SecurityCreation() {
		super();
	}

	public SecurityCreation(String securityType, String securityClassification,
			String alChrgdToOtherBanks, String natureOfCharge,
			String valuerName, String dateOfSubmissionForValuation,
			String dateOfReceiptOfValuation, String dateOfValuation,
			String securityDescription, String collateralStartDate,
			String collateralEndDate, String totalSecurityValue, String lapsId,
			String cbsId, String propertyType, String plotNo, String streetNo,
			String wardNo, String address, String city, String district,
			String state, String pinCode, String totalArea,
			String extentOfBuilding, String valueAsPerValuation,
			String forcedSaleValue, String titleDeedsBranch, String surveyNo,
			String propertyAcquisition, String legalAdviserName,
			String dateOfSubmissionForLegalOpinion,
			String dateOfReceiptOfLegalOpinion, String dateOfLegalOpinion,
			String flowOfTitle, String ecObtained, String latestTaxPaidYear,
			String flowOfTitleSearchFromProp, String periodOfEC,String vehicleType,String company,String vehicleCatogery,String model,String vehicleAge,String bookValue,String purchasePrice,String engineNo,String regState,
			String dealerName,String  dealerAddress,String contactNo,String dealerCity,String dealerState,String dealerCountry,String dealerpinCode ,String dealerMailId,
			String dealerCode, String dealerGstNo,String ownerName,String doorNo,String ownerAddress,String ownerCity,String ownerDistrict,String ownerCountry, String ownergPinCode,String ownerState,
			String ownerSalutation, String make, String owneraddress2, String dealeraddress2,String solID) {
		
		super();
		
		this.securityType = securityType;
		this.securityClassification = securityClassification;
		this.alChrgdToOtherBanks = alChrgdToOtherBanks;
		this.natureOfCharge = natureOfCharge;
		this.valuerName = valuerName;
		this.dateOfSubmissionForValuation = dateOfSubmissionForValuation;
		this.dateOfReceiptOfValuation = dateOfReceiptOfValuation;
		this.dateOfValuation = dateOfValuation;
		this.securityDescription = securityDescription;
		this.collateralStartDate = collateralStartDate;
		this.collateralEndDate = collateralEndDate;
		this.totalSecurityValue = totalSecurityValue;
		this.lapsId = lapsId;
		this.cbsId = cbsId;
		this.propertyType = propertyType;
		this.plotNo = plotNo;
		this.streetNo = streetNo;
		this.wardNo = wardNo;
		this.address = address;
		this.city = city;
		this.district = district;
		this.state = state;
		this.pinCode = pinCode;
		this.totalArea = totalArea;
		this.extentOfBuilding = extentOfBuilding;
		this.valueAsPerValuation = valueAsPerValuation;
		this.forcedSaleValue = forcedSaleValue;
		this.titleDeedsBranch = titleDeedsBranch;
		this.surveyNo = surveyNo;
		this.propertyAcquisition = propertyAcquisition;
		this.legalAdviserName = legalAdviserName;
		this.dateOfSubmissionForLegalOpinion = dateOfSubmissionForLegalOpinion;
		this.dateOfReceiptOfLegalOpinion = dateOfReceiptOfLegalOpinion;
		this.dateOfLegalOpinion = dateOfLegalOpinion;
		this.flowOfTitle = flowOfTitle;
		this.ecObtained = ecObtained;
		this.latestTaxPaidYear = latestTaxPaidYear;
		this.flowOfTitleSearchFromProp = flowOfTitleSearchFromProp;
		this.periodOfEC = periodOfEC;
		this.vehicleType=vehicleType;
		this.company=company;
		this.vehicleCatogery=vehicleCatogery;
		this.model=model;
		this.vehicleAge=vehicleAge;
		this.bookValue=bookValue;
		this.purchasePrice=purchasePrice;
		this.engineNo=engineNo;
		this.regState=regState;
		this.dealerName=dealerName;
		this.dealerAddress=dealerAddress;
		this.contactNo=contactNo;
		this.dealerCity=dealerCity;
		this.dealerState=dealerState;
		this.dealerCountry=dealerCountry;
		this.dealerpinCode=dealerpinCode;
		this.dealerMailId=dealerMailId;
		this.dealerCode=dealerCode;
		this.dealerGstNo=dealerGstNo;
		this.ownerName=ownerName;
		this.doorNo=doorNo;
		this.ownerAddress=ownerAddress;
		this.ownerCity=ownerCity;
		this.ownerDistrict=ownerDistrict;
		this.ownerCountry=ownerCountry;
		this.ownergPinCode=ownergPinCode;
		this.ownerState=ownerState;
		this.make=make;
		this.ownerSalutation=ownerSalutation;
		this.owneraddress2=owneraddress2;
		this.dealeraddress2=dealeraddress2;
		this.solID=solID;
		
	}

	public String getSecurityType() {
		return securityType;
	}

	public void setSecurityType(String securityType) {
		this.securityType = securityType;
	}

	public String getSecurityClassification() {
		return securityClassification;
	}

	public void setSecurityClassification(String securityClassification) {
		this.securityClassification = securityClassification;
	}

	public String getAlChrgdToOtherBanks() {
		return alChrgdToOtherBanks;
	}

	public void setAlChrgdToOtherBanks(String alChrgdToOtherBanks) {
		this.alChrgdToOtherBanks = alChrgdToOtherBanks;
	}

	public String getNatureOfCharge() {
		return natureOfCharge;
	}

	public void setNatureOfCharge(String natureOfCharge) {
		this.natureOfCharge = natureOfCharge;
	}

	public String getValuerName() {
		return valuerName;
	}

	public void setValuerName(String valuerName) {
		this.valuerName = valuerName;
	}

	public String getDateOfSubmissionForValuation() {
		return dateOfSubmissionForValuation;
	}

	public void setDateOfSubmissionForValuation(String dateOfSubmissionForValuation) {
		this.dateOfSubmissionForValuation = dateOfSubmissionForValuation;
	}

	public String getDateOfReceiptOfValuation() {
		return dateOfReceiptOfValuation;
	}

	public void setDateOfReceiptOfValuation(String dateOfReceiptOfValuation) {
		this.dateOfReceiptOfValuation = dateOfReceiptOfValuation;
	}

	public String getDateOfValuation() {
		return dateOfValuation;
	}

	public void setDateOfValuation(String dateOfValuation) {
		this.dateOfValuation = dateOfValuation;
	}

	public String getSecurityDescription() {
		return securityDescription;
	}

	public void setSecurityDescription(String securityDescription) {
		this.securityDescription = securityDescription;
	}

	public String getCollateralStartDate() {
		return collateralStartDate;
	}

	public void setCollateralStartDate(String collateralStartDate) {
		this.collateralStartDate = collateralStartDate;
	}

	public String getCollateralEndDate() {
		return collateralEndDate;
	}

	public void setCollateralEndDate(String collateralEndDate) {
		this.collateralEndDate = collateralEndDate;
	}

	public String getTotalSecurityValue() {
		return totalSecurityValue;
	}

	public void setTotalSecurityValue(String totalSecurityValue) {
		this.totalSecurityValue = totalSecurityValue;
	}

	public String getLapsId() {
		return lapsId;
	}

	public void setLapsId(String lapsId) {
		this.lapsId = lapsId;
	}

	public String getCbsId() {
		return cbsId;
	}

	public void setCbsId(String cbsId) {
		this.cbsId = cbsId;
	}

	public String getPropertyType() {
		return propertyType;
	}

	public void setPropertyType(String propertyType) {
		this.propertyType = propertyType;
	}

	public String getPlotNo() {
		return plotNo;
	}

	public void setPlotNo(String plotNo) {
		this.plotNo = plotNo;
	}

	public String getStreetNo() {
		return streetNo;
	}

	public void setStreetNo(String streetNo) {
		this.streetNo = streetNo;
	}

	public String getWardNo() {
		return wardNo;
	}

	public void setWardNo(String wardNo) {
		this.wardNo = wardNo;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getPinCode() {
		return pinCode;
	}

	public void setPinCode(String pinCode) {
		this.pinCode = pinCode;
	}

	public String getTotalArea() {
		return totalArea;
	}

	public void setTotalArea(String totalArea) {
		this.totalArea = totalArea;
	}

	public String getExtentOfBuilding() {
		return extentOfBuilding;
	}

	public void setExtentOfBuilding(String extentOfBuilding) {
		this.extentOfBuilding = extentOfBuilding;
	}

	public String getValueAsPerValuation() {
		return valueAsPerValuation;
	}

	public void setValueAsPerValuation(String valueAsPerValuation) {
		this.valueAsPerValuation = valueAsPerValuation;
	}

	public String getForcedSaleValue() {
		return forcedSaleValue;
	}

	public void setForcedSaleValue(String forcedSaleValue) {
		this.forcedSaleValue = forcedSaleValue;
	}

	public String getTitleDeedsBranch() {
		return titleDeedsBranch;
	}

	public void setTitleDeedsBranch(String titleDeedsBranch) {
		this.titleDeedsBranch = titleDeedsBranch;
	}

	public String getSurveyNo() {
		return surveyNo;
	}

	public void setSurveyNo(String surveyNo) {
		this.surveyNo = surveyNo;
	}

	public String getPropertyAcquisition() {
		return propertyAcquisition;
	}

	public void setPropertyAcquisition(String propertyAcquisition) {
		this.propertyAcquisition = propertyAcquisition;
	}

	public String getLegalAdviserName() {
		return legalAdviserName;
	}

	public void setLegalAdviserName(String legalAdviserName) {
		this.legalAdviserName = legalAdviserName;
	}

	public String getDateOfSubmissionForLegalOpinion() {
		return dateOfSubmissionForLegalOpinion;
	}

	public void setDateOfSubmissionForLegalOpinion(
			String dateOfSubmissionForLegalOpinion) {
		this.dateOfSubmissionForLegalOpinion = dateOfSubmissionForLegalOpinion;
	}

	public String getDateOfReceiptOfLegalOpinion() {
		return dateOfReceiptOfLegalOpinion;
	}

	public void setDateOfReceiptOfLegalOpinion(String dateOfReceiptOfLegalOpinion) {
		this.dateOfReceiptOfLegalOpinion = dateOfReceiptOfLegalOpinion;
	}

	public String getDateOfLegalOpinion() {
		return dateOfLegalOpinion;
	}

	public void setDateOfLegalOpinion(String dateOfLegalOpinion) {
		this.dateOfLegalOpinion = dateOfLegalOpinion;
	}

	public String getFlowOfTitle() {
		return flowOfTitle;
	}

	public void setFlowOfTitle(String flowOfTitle) {
		this.flowOfTitle = flowOfTitle;
	}

	public String getEcObtained() {
		return ecObtained;
	}

	public void setEcObtained(String ecObtained) {
		this.ecObtained = ecObtained;
	}

	public String getLatestTaxPaidYear() {
		return latestTaxPaidYear;
	}

	public void setLatestTaxPaidYear(String latestTaxPaidYear) {
		this.latestTaxPaidYear = latestTaxPaidYear;
	}

	public String getFlowOfTitleSearchFromProp() {
		return flowOfTitleSearchFromProp;
	}

	public void setFlowOfTitleSearchFromProp(String flowOfTitleSearchFromProp) {
		this.flowOfTitleSearchFromProp = flowOfTitleSearchFromProp;
	}

	public String getPeriodOfEC() {
		return periodOfEC;
	}

	public void setPeriodOfEC(String periodOfEC) {
		this.periodOfEC = periodOfEC;
	}

	public String getVehicleType() {
		return vehicleType;
	}

	public void setVehicleType(String vehicleType) {
		this.vehicleType = vehicleType;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getVehicleCatogery() {
		return vehicleCatogery;
	}

	public void setVehicleCatogery(String vehicleCatogery) {
		this.vehicleCatogery = vehicleCatogery;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public String getVehicleAge() {
		return vehicleAge;
	}

	public void setVehicleAge(String vehicleAge) {
		this.vehicleAge = vehicleAge;
	}

	public String getBookValue() {
		return bookValue;
	}

	public void setBookValue(String bookValue) {
		this.bookValue = bookValue;
	}

	public String getPurchasePrice() {
		return purchasePrice;
	}

	public void setPurchasePrice(String purchasePrice) {
		this.purchasePrice = purchasePrice;
	}

	public String getEngineNo() {
		return engineNo;
	}

	public void setEngineNo(String engineNo) {
		this.engineNo = engineNo;
	}

	public String getRegState() {
		return regState;
	}

	public void setRegState(String regState) {
		this.regState = regState;
	}

	public String getDealerName() {
		return dealerName;
	}

	public void setDealerName(String dealerName) {
		this.dealerName = dealerName;
	}

	public String getContactNo() {
		return contactNo;
	}

	public void setContactNo(String contactNo) {
		this.contactNo = contactNo;
	}

	public String getDealerAddress() {
		return dealerAddress;
	}

	public void setDealerAddress(String dealerAddress) {
		this.dealerAddress = dealerAddress;
	}

	public String getDealerCity() {
		return dealerCity;
	}

	public void setDealerCity(String dealerCity) {
		this.dealerCity = dealerCity;
	}

	public String getDealerState() {
		return dealerState;
	}

	public void setDealerState(String dealerState) {
		this.dealerState = dealerState;
	}

	public String getDealerDistrict() {
		return dealerDistrict;
	}

	public void setDealerDistrict(String dealerDistrict) {
		this.dealerDistrict = dealerDistrict;
	}

	public String getDealerCountry() {
		return dealerCountry;
	}

	public void setDealerCountry(String dealerCountry) {
		this.dealerCountry = dealerCountry;
	}

	public String getDealerpinCode() {
		return dealerpinCode;
	}

	public void setDealerpinCode(String dealerpinCode) {
		this.dealerpinCode = dealerpinCode;
	}

	public String getDealerMailId() {
		return dealerMailId;
	}

	public void setDealerMailId(String dealerMailId) {
		this.dealerMailId = dealerMailId;
	}

	public String getDealerCode() {
		return dealerCode;
	}

	public void setDealerCode(String dealerCode) {
		this.dealerCode = dealerCode;
	}

	public String getDealerGstNo() {
		return dealerGstNo;
	}

	public void setDealerGstNo(String dealerGstNo) {
		this.dealerGstNo = dealerGstNo;
	}

	

	public String getDoorNo() {
		return doorNo;
	}

	public void setDoorNo(String doorNo) {
		this.doorNo = doorNo;
	}

	public String getOwnerName() {
		return ownerName;
	}

	public void setOwnerName(String ownerName) {
		this.ownerName = ownerName;
	}

	public String getOwnerAddress() {
		return ownerAddress;
	}

	public void setOwnerAddress(String ownerAddress) {
		this.ownerAddress = ownerAddress;
	}

	public String getOwnerCity() {
		return ownerCity;
	}

	public void setOwnerCity(String ownerCity) {
		this.ownerCity = ownerCity;
	}

	public String getOwnerState() {
		return ownerState;
	}

	public void setOwnerState(String ownerState) {
		this.ownerState = ownerState;
	}

	public String getOwnerDistrict() {
		return ownerDistrict;
	}

	public void setOwnerDistrict(String ownerDistrict) {
		this.ownerDistrict = ownerDistrict;
	}

	public String getOwnerCountry() {
		return ownerCountry;
	}

	public void setOwnerCountry(String ownerCountry) {
		this.ownerCountry = ownerCountry;
	}

	public String getOwnergPinCode() {
		return ownergPinCode;
	}

	public void setOwnergPinCode(String ownergPinCode) {
		this.ownergPinCode = ownergPinCode;
	}

	public String getMake() {
		return make;
	}

	public void setMake(String make) {
		this.make = make;
	}

	public String getOwnerSalutation() {
		return ownerSalutation;
	}

	public void setOwnerSalutation(String ownerSalutation) {
		this.ownerSalutation = ownerSalutation;
	}

	public String getOwneraddress2() {
		return owneraddress2;
	}

	public void setOwneraddress2(String owneraddress2) {
		this.owneraddress2 = owneraddress2;
	}

	public String getDealeraddress2() {
		return dealeraddress2;
	}

	public void setDealeraddress2(String dealeraddress2) {
		this.dealeraddress2 = dealeraddress2;
	}

	public String getSolID() {
		return solID;
	}

	public void setSolID(String solID) {
		this.solID = solID;
	}

	
		
	
	
	
}
