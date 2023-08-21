package com.sai.laps.webservices.rest.domain.msme;

public class TurnOverMethod {

	private String year;
 	private String type;
 	private String projectSales;
 	private String acceptProjectSale;
 	private String acceptSalesPercent25;
 	private String minMarginReq;
 	private String eligibleFinance;
 	private String actualMarginAvailable;
 	private String eligibleBankFinance;
 	private String permissibleBankFinance;
 	private String limitsSoughts;
 	private String limitsproposed;
 	private String requiredMargin;
 	private String surplusRequiredMargin;
	
	
public TurnOverMethod()
	{super();}
	
public TurnOverMethod(String  year,
	String  type,
	String  projectSales,
	String  acceptProjectSale,
	String  acceptSalesPercent25,
	String  minMarginReq,
	String  eligibleFinance,
	String  actualMarginAvailable,
	String  eligibleBankFinance,
	String  permissibleBankFinance,
	String  limitsSoughts,
	String  limitsproposed,
	String  requiredMargin,
	String  surplusRequiredMargin)
{
	this.type=type;
	this.projectSales=projectSales;
	this.acceptProjectSale=acceptProjectSale;
	this.acceptSalesPercent25=acceptSalesPercent25;
	this.minMarginReq=minMarginReq;
	this.eligibleFinance=eligibleFinance;
	this.actualMarginAvailable=actualMarginAvailable;
	this.eligibleBankFinance=eligibleBankFinance;
	this.permissibleBankFinance=permissibleBankFinance;
	this.limitsSoughts=limitsSoughts;
	this.limitsproposed=limitsproposed;
	this.requiredMargin=requiredMargin;
	this.surplusRequiredMargin=surplusRequiredMargin;


}

public String getYear() {
	return year;
}

public void setYear(String year) {
	this.year = year;
}

public String getType() {
	return type;
}

public void setType(String type) {
	this.type = type;
}

public String getProjectSales() {
	return projectSales;
}

public void setProjectSales(String projectSales) {
	this.projectSales = projectSales;
}

public String getAcceptProjectSale() {
	return acceptProjectSale;
}

public void setAcceptProjectSale(String acceptProjectSale) {
	this.acceptProjectSale = acceptProjectSale;
}

public String getAcceptSalesPercent25() {
	return acceptSalesPercent25;
}

public void setAcceptSalesPercent25(String acceptSalesPercent25) {
	this.acceptSalesPercent25 = acceptSalesPercent25;
}

public String getMinMarginReq() {
	return minMarginReq;
}

public void setMinMarginReq(String minMarginReq) {
	this.minMarginReq = minMarginReq;
}

public String getEligibleFinance() {
	return eligibleFinance;
}

public void setEligibleFinance(String eligibleFinance) {
	this.eligibleFinance = eligibleFinance;
}

public String getActualMarginAvailable() {
	return actualMarginAvailable;
}

public void setActualMarginAvailable(String actualMarginAvailable) {
	this.actualMarginAvailable = actualMarginAvailable;
}

public String getEligibleBankFinance() {
	return eligibleBankFinance;
}

public void setEligibleBankFinance(String eligibleBankFinance) {
	this.eligibleBankFinance = eligibleBankFinance;
}

public String getPermissibleBankFinance() {
	return permissibleBankFinance;
}

public void setPermissibleBankFinance(String permissibleBankFinance) {
	this.permissibleBankFinance = permissibleBankFinance;
}

public String getLimitsSoughts() {
	return limitsSoughts;
}

public void setLimitsSoughts(String limitsSoughts) {
	this.limitsSoughts = limitsSoughts;
}

public String getLimitsproposed() {
	return limitsproposed;
}

public void setLimitsproposed(String limitsproposed) {
	this.limitsproposed = limitsproposed;
}

public String getRequiredMargin() {
	return requiredMargin;
}

public void setRequiredMargin(String requiredMargin) {
	this.requiredMargin = requiredMargin;
}

public String getSurplusRequiredMargin() {
	return surplusRequiredMargin;
}

public void setSurplusRequiredMargin(String surplusRequiredMargin) {
	this.surplusRequiredMargin = surplusRequiredMargin;
}


}
