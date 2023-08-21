package com.sai.laps.webservices.rest.domain.msme;

public class Dscr {
	
	private String year ; 
	private String  type  ;
	private String totalSale  ;
	private String increasePercent ; 
	private String netProfit ; 
	private String interestTlExist  ;
	private String interestTlpropose  ;
	private String depreciation  ;
	private String interestTlExistAdd  ;
	private String interestTlProposedAdd  ;
	private String totalAccruals  ;
	private String installmentTlExist  ;
	private String installmentTlProposed  ;
	private String totalRepayment;
	private String dscr;
	private String interestTlExistProposed;
	public Dscr(){
		super();
	}
	
	public Dscr( String year  ,
			String type  ,
			String totalSale , 
			String increasePercent , 
			String netProfit  ,
		 	String  interestTlExist  ,
		 	String interestTlpropose  ,
		 	String depreciation  ,
		 	String interestTlExistAdd  ,
		 	String interestTlProposedAdd  ,
		 	String totalAccruals  ,
		 	String installmentTlExist  ,
		 	String installmentTlProposed,
		 	String totalRepayment,
		 	String dscr,
		 	String interestTlExistProposed){
		
		this.year=year;
		this.type=type;
		this.totalSale=totalSale;
		this.depreciation=depreciation;
		this.increasePercent=increasePercent;
		this.netProfit=netProfit;
		this.interestTlExist=interestTlExist;
		this.interestTlpropose=interestTlpropose;
		this.interestTlExistAdd=interestTlExistAdd;
		this.interestTlProposedAdd=interestTlProposedAdd;
		this.totalAccruals=totalAccruals;
		this.installmentTlExist=installmentTlExist;
		this.installmentTlProposed=installmentTlProposed;
		this.totalRepayment=totalRepayment;
		this.dscr=dscr;
		this.interestTlExistProposed=interestTlExistProposed;
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

	public String getTotalSale() {
		return totalSale;
	}

	public void setTotalSale(String totalSale) {
		this.totalSale = totalSale;
	}

	public String getIncreasePercent() {
		return increasePercent;
	}

	public void setIncreasePercent(String increasePercent) {
		this.increasePercent = increasePercent;
	}

	public String getNetProfit() {
		return netProfit;
	}

	public void setNetProfit(String netProfit) {
		this.netProfit = netProfit;
	}

	public String getInterestTlExist() {
		return interestTlExist;
	}

	public void setInterestTlExist(String interestTlExist) {
		this.interestTlExist = interestTlExist;
	}

	public String getInterestTlpropose() {
		return interestTlpropose;
	}

	public void setInterestTlpropose(String interestTlpropose) {
		this.interestTlpropose = interestTlpropose;
	}

	public String getDepreciation() {
		return depreciation;
	}

	public void setDepreciation(String depreciation) {
		this.depreciation = depreciation;
	}

	

	public String getTotalAccruals() {
		return totalAccruals;
	}

	public void setTotalAccruals(String totalAccruals) {
		this.totalAccruals = totalAccruals;
	}

	public String getInstallmentTlExist() {
		return installmentTlExist;
	}

	public void setInstallmentTlExist(String installmentTlExist) {
		this.installmentTlExist = installmentTlExist;
	}

	public String getInstallmentTlProposed() {
		return installmentTlProposed;
	}

	public void setInstallmentTlProposed(String installmentTlProposed) {
		this.installmentTlProposed = installmentTlProposed;
	}

	public String getTotalRepayment() {
		return totalRepayment;
	}

	public void setTotalRepayment(String totalRepayment) {
		this.totalRepayment = totalRepayment;
	}

	public String getDscr() {
		return dscr;
	}

	public void setDscr(String dscr) {
		this.dscr = dscr;
	}

	public String getInterestTlExistProposed() {
		return interestTlExistProposed;
	}

	public void setInterestTlExistProposed(String interestTlExistProposed) {
		this.interestTlExistProposed = interestTlExistProposed;
	}

	public String getInterestTlExistAdd() {
		return interestTlExistAdd;
	}

	public void setInterestTlExistAdd(String interestTlExistAdd) {
		this.interestTlExistAdd = interestTlExistAdd;
	}

	public String getInterestTlProposedAdd() {
		return interestTlProposedAdd;
	}

	public void setInterestTlProposedAdd(String interestTlProposedAdd) {
		this.interestTlProposedAdd = interestTlProposedAdd;
	}


	
	
	
}
