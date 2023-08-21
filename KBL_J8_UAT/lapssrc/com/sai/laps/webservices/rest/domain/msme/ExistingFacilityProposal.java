package com.sai.laps.webservices.rest.domain.msme;

import java.util.List;

import com.sai.laps.webservices.rest.domain.CoApplicant;
import com.sai.laps.webservices.rest.domain.DeviationDetails;
import com.sai.laps.webservices.rest.domain.DocumentsDetails;

public class ExistingFacilityProposal {

private String nameOfBank;
private String type;
private String facility;
private String purposeOfLaon;
private String typeOfFacility;
private String limit;
private String outstanding ;
private String outstandingDate;
private String bankingType; 
private String interestType; 
private String spreadValue; 
private String repaymentType; 
private String dueDate;  
private String securityDesc;
private String securityValue;
private String whetherLitigation;
private String natureOfLitigation;
private String dateOfLitigation;
private String claimAmount;
private String otherClaim;
private String presentPosition;

	
public  ExistingFacilityProposal() {
	super();
	// TODO Auto-generated constructor stub

}

public ExistingFacilityProposal(String nameOfBank,String type,String facility,String purposeOfLaon,String limit,String outstanding,String outstandingDate,String bankingType,
		String interestType,String spreadValue,String repaymentType,String dueDate,String securityDesc,String securityValue,String whetherLitigation,String natureOfLitigation,
		String dateOfLitigation,String claimAmount,String otherClaim,String presentPosition) {
	super();
		
}

public String getNameOfBank() {
	return nameOfBank;
}

public void setNameOfBank(String nameOfBank) {
	this.nameOfBank = nameOfBank;
}

public String getType() {
	return type;
}

public void setType(String type) {
	this.type = type;
}

public String getFacility() {
	return facility;
}

public void setFacility(String facility) {
	this.facility = facility;
}

public String getPurposeOfLaon() {
	return purposeOfLaon;
}

public void setPurposeOfLaon(String purposeOfLaon) {
	this.purposeOfLaon = purposeOfLaon;
}

public String getTypeOfFacility() {
	return typeOfFacility;
}

public void setTypeOfFacility(String typeOfFacility) {
	this.typeOfFacility = typeOfFacility;
}

public String getLimit() {
	return limit;
}

public void setLimit(String limit) {
	this.limit = limit;
}

public String getOutstanding() {
	return outstanding;
}

public void setOutstanding(String outstanding) {
	this.outstanding = outstanding;
}

public String getOutstandingDate() {
	return outstandingDate;
}

public void setOutstandingDate(String outstandingDate) {
	this.outstandingDate = outstandingDate;
}

public String getBankingType() {
	return bankingType;
}

public void setBankingType(String bankingType) {
	this.bankingType = bankingType;
}

public String getInterestType() {
	return interestType;
}

public void setInterestType(String interestType) {
	this.interestType = interestType;
}

public String getSpreadValue() {
	return spreadValue;
}

public void setSpreadValue(String spreadValue) {
	this.spreadValue = spreadValue;
}

public String getRepaymentType() {
	return repaymentType;
}

public void setRepaymentType(String repaymentType) {
	this.repaymentType = repaymentType;
}

public String getDueDate() {
	return dueDate;
}

public void setDueDate(String dueDate) {
	this.dueDate = dueDate;
}

public String getSecurityDesc() {
	return securityDesc;
}

public void setSecurityDesc(String securityDesc) {
	this.securityDesc = securityDesc;
}

public String getSecurityValue() {
	return securityValue;
}

public void setSecurityValue(String securityValue) {
	this.securityValue = securityValue;
}

public String getWhetherLitigation() {
	return whetherLitigation;
}

public void setWhetherLitigation(String whetherLitigation) {
	this.whetherLitigation = whetherLitigation;
}

public String getNatureOfLitigation() {
	return natureOfLitigation;
}

public void setNatureOfLitigation(String natureOfLitigation) {
	this.natureOfLitigation = natureOfLitigation;
}

public String getDateOfLitigation() {
	return dateOfLitigation;
}

public void setDateOfLitigation(String dateOfLitigation) {
	this.dateOfLitigation = dateOfLitigation;
}

public String getClaimAmount() {
	return claimAmount;
}

public void setClaimAmount(String claimAmount) {
	this.claimAmount = claimAmount;
}

public String getOtherClaim() {
	return otherClaim;
}

public void setOtherClaim(String otherClaim) {
	this.otherClaim = otherClaim;
}

public String getPresentPosition() {
	return presentPosition;
}

public void setPresentPosition(String presentPosition) {
	this.presentPosition = presentPosition;
}



}
