package com.sai.laps.webservices.rest.domain.msme;

public class OdccLimits {
	
	private String sanctionedLimit;
	private String maxDrBalance;
	private String minDrBalance;
	private String maxCrBalance;
	private String minCrBalance;
	private String crSummation;
	private String drSummation;
	private String salesTurnover;
	private String excessPermitted;
	private String chequeReturn;
	private String chequeReturnAmount;
	private String remarks;
	private String comments;
	
	
	public  OdccLimits() {
		super();
		// TODO Auto-generated constructor stub
	
	}
	
	
	public OdccLimits(String sanctionedLimit,String maxDrBalance,String minDrBalance,String maxCrBalance,String minCrBalance,String crSummation,String drSummation
			,String salesTurnover,String excessPermitted,String chequeReturn,String chequeReturnAmount,String remarks,String comments)
	{
		this.setSanctionedLimit(sanctionedLimit);
		this.setMaxDrBalance(maxDrBalance);
		this.setMinDrBalance(minDrBalance);
		this.setMaxCrBalance(maxCrBalance);
		this.setMinCrBalance(minCrBalance);
		this.setCrSummation(crSummation);
		this.setDrSummation(drSummation);
		this.setSalesTurnover(salesTurnover);
		this.setExcessPermitted(excessPermitted);
		this.setChequeReturn(chequeReturn);
		this.setChequeReturnAmount(chequeReturnAmount);
		this.setRemarks(remarks);
		this.setComments(comments);
	}


	public void setSanctionedLimit(String sanctionedLimit) {
		this.sanctionedLimit = sanctionedLimit;
	}


	public String getSanctionedLimit() {
		return sanctionedLimit;
	}


	public void setMaxDrBalance(String maxDrBalance) {
		this.maxDrBalance = maxDrBalance;
	}


	public String getMaxDrBalance() {
		return maxDrBalance;
	}


	public void setMinDrBalance(String minDrBalance) {
		this.minDrBalance = minDrBalance;
	}


	public String getMinDrBalance() {
		return minDrBalance;
	}


	public void setMaxCrBalance(String maxCrBalance) {
		this.maxCrBalance = maxCrBalance;
	}


	public String getMaxCrBalance() {
		return maxCrBalance;
	}


	public void setMinCrBalance(String minCrBalance) {
		this.minCrBalance = minCrBalance;
	}


	public String getMinCrBalance() {
		return minCrBalance;
	}


	public void setCrSummation(String crSummation) {
		this.crSummation = crSummation;
	}


	public String getCrSummation() {
		return crSummation;
	}


	public void setDrSummation(String drSummation) {
		this.drSummation = drSummation;
	}


	public String getDrSummation() {
		return drSummation;
	}


	public void setSalesTurnover(String salesTurnover) {
		this.salesTurnover = salesTurnover;
	}


	public String getSalesTurnover() {
		return salesTurnover;
	}


	public void setExcessPermitted(String excessPermitted) {
		this.excessPermitted = excessPermitted;
	}


	public String getExcessPermitted() {
		return excessPermitted;
	}


	public void setChequeReturn(String chequeReturn) {
		this.chequeReturn = chequeReturn;
	}


	public String getChequeReturn() {
		return chequeReturn;
	}


	public void setChequeReturnAmount(String chequeReturnAmount) {
		this.chequeReturnAmount = chequeReturnAmount;
	}


	public String getChequeReturnAmount() {
		return chequeReturnAmount;
	}


	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}


	public String getRemarks() {
		return remarks;
	}


	public void setComments(String comments) {
		this.comments = comments;
	}


	public String getComments() {
		return comments;
	}
}
