package com.sai.laps.webservices.rest.domain.msme;

public class MicroMitra {

	private String stockValue;
	private String	bookDebtValue;
	private String	creditorsValue;
	private String	total;
 	private String	totalOfMPBF75Percent;
 	private String	loanAmountApplied;
 	private String leastOfLoanAmountOrMPBF;
	private String asOnDate;
 	public  MicroMitra(){
		super();
		// TODO Auto-generated constructor stub
	
		
 	}
	
 		public MicroMitra(String stockValue, String	bookDebtValue,String creditorsValue,String	total,String	totalOfMPBF75Percent,String	loanAmountApplied,
				String leastOfLoanAmountOrMPBF, String asOnDate)
		{
		this.bookDebtValue=bookDebtValue;
		this.stockValue=stockValue;
		this.creditorsValue=creditorsValue;
		this.total=total;
		this.totalOfMPBF75Percent=totalOfMPBF75Percent;
		this.loanAmountApplied=loanAmountApplied;
		this.leastOfLoanAmountOrMPBF=leastOfLoanAmountOrMPBF;	
		this.asOnDate=asOnDate;
		}
		public String getStockValue() {
			return stockValue;
		}
		public void setStockValue(String stockValue) {
			this.stockValue = stockValue;
		}
		public String getBookDebtValue() {
			return bookDebtValue;
		}
		public void setBookDebtValue(String bookDebtValue) {
			this.bookDebtValue = bookDebtValue;
		}
		public String getCreditorsValue() {
			return creditorsValue;
		}
		public void setCreditorsValue(String creditorsValue) {
			this.creditorsValue = creditorsValue;
		}
		public String getTotal() {
			return total;
		}
		public void setTotal(String total) {
			this.total = total;
		}
		public String getTotalOfMPBF75Percent() {
			return totalOfMPBF75Percent;
		}
		public void setTotalOfMPBF75Percent(String totalOfMPBF75Percent) {
			this.totalOfMPBF75Percent = totalOfMPBF75Percent;
		}
		public String getLoanAmountApplied() {
			return loanAmountApplied;
		}
		public void setLoanAmountApplied(String loanAmountApplied) {
			this.loanAmountApplied = loanAmountApplied;
		}
		public String getLeastOfLoanAmountOrMPBF() {
			return leastOfLoanAmountOrMPBF;
		}
		public void setLeastOfLoanAmountOrMPBF(String leastOfLoanAmountOrMPBF) {
			this.leastOfLoanAmountOrMPBF = leastOfLoanAmountOrMPBF;
		}

		public String getAsOnDate() {
			return asOnDate;
		}

		public void setAsOnDate(String asOnDate) {
			this.asOnDate = asOnDate;
		}
	
 
 	
}
