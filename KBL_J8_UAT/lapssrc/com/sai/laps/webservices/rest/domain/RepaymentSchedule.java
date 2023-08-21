package com.sai.laps.webservices.rest.domain;

public class RepaymentSchedule {

	private String frequency;
	private String installmentAmount;
	private String noInstallment;
	private String totalAmount;
	
	
	public RepaymentSchedule() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public RepaymentSchedule(String frequency,String installmentAmount,String noInstallment, String totalAmount) {
	
		this.frequency=frequency;
		this.installmentAmount=installmentAmount;
		this.noInstallment=noInstallment;
		this.totalAmount=totalAmount;
	}

	public String getFrequency() {
		return frequency;
	}

	public void setFrequency(String frequency) {
		this.frequency = frequency;
	}

	public String getInstallmentAmount() {
		return installmentAmount;
	}

	public void setInstallmentAmount(String installmentAmount) {
		this.installmentAmount = installmentAmount;
	}



	public String getNoInstallment() {
		return noInstallment;
	}

	public void setNoInstallment(String noInstallment) {
		this.noInstallment = noInstallment;
	}

	public String getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(String totalAmount) {
		this.totalAmount = totalAmount;
	}
	
	
	
}
