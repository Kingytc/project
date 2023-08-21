package com.sai.laps.webservices.rest.domain.msme;

public class BussinessOperation {

	
	private String odInterest;
	private String forexIncome;
	private String tlInterestIncome;
	private String otherfacilitiesincome;
	private String interestEarned;
	private String otherIncome;
	private String fromDate;
	private String toDate;
	private String recoveryStatus;
	
	
	public  BussinessOperation() {
		super();
		// TODO Auto-generated constructor stub
	
	}
	
	public BussinessOperation(String odInterest,String forexIncome, String tlInterestIncome,String otherfacilitiesincome,
			String interestEarned,String otherIncome,String fromDate,String toDate,String recoveryStatus)
	{
		this.setOdInterest(odInterest);
		this.setForexIncome(forexIncome);
		this.setTlInterestIncome(tlInterestIncome);
		this.setOtherfacilitiesincome(otherfacilitiesincome);
		this.setInterestEarned(interestEarned);
		this.setOtherIncome(otherIncome);
		this.setFromDate(fromDate);
		this.setToDate(toDate);
		this.setRecoveryStatus(recoveryStatus);
		
	}

	public void setOdInterest(String odInterest) {
		this.odInterest = odInterest;
	}

	public String getOdInterest() {
		return odInterest;
	}

	public void setForexIncome(String forexIncome) {
		this.forexIncome = forexIncome;
	}

	public String getForexIncome() {
		return forexIncome;
	}

	public void setTlInterestIncome(String tlInterestIncome) {
		this.tlInterestIncome = tlInterestIncome;
	}

	public String getTlInterestIncome() {
		return tlInterestIncome;
	}

	public void setOtherfacilitiesincome(String otherfacilitiesincome) {
		this.otherfacilitiesincome = otherfacilitiesincome;
	}

	public String getOtherfacilitiesincome() {
		return otherfacilitiesincome;
	}

	public void setInterestEarned(String interestEarned) {
		this.interestEarned = interestEarned;
	}

	public String getInterestEarned() {
		return interestEarned;
	}

	public void setOtherIncome(String otherIncome) {
		this.otherIncome = otherIncome;
	}

	public String getOtherIncome() {
		return otherIncome;
	}

	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}

	public String getFromDate() {
		return fromDate;
	}

	public void setToDate(String toDate) {
		this.toDate = toDate;
	}

	public String getToDate() {
		return toDate;
	}

	public void setRecoveryStatus(String recoveryStatus) {
		this.recoveryStatus = recoveryStatus;
	}

	public String getRecoveryStatus() {
		return recoveryStatus;
	}
}

