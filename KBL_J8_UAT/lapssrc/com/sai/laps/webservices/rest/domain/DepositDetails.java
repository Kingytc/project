package com.sai.laps.webservices.rest.domain;

public class DepositDetails {
	
	private String issuebranch;
	private String standname;
	private String accno;
	private String dateofissue;
	private String faceval;
	private String rateofint;
	private String presentos;
	private String presentason;
	private String maturityval;
	private String tenure;
	private String matdate;
	private String rateincharges;
	private String margin;
	private String banktype;
	private String secid;
	private String loan_updflag;
	private String loan_entryflag;

	public DepositDetails() {
		   super();
		// TODO Auto-generated constructor stub
	}
	public DepositDetails(String issuebranch,String standname,String accno,String dateofissue,String faceval,String rateofint,String presentos,
			String presentason,String maturityval,String tenure,String matdate,String rateincharges,String margin,String banktype,String secid
			,String loan_updflag,String loan_entryflag) {
		super();
		this.issuebranch = issuebranch;
		this.standname = standname;
		this.accno = accno;
		this.dateofissue = dateofissue;
		this.faceval = faceval;
		this.rateofint = rateofint;
		this.presentos = presentos;
		this.presentason = presentason;
		this.maturityval = maturityval;
		this.tenure = tenure;
		this.matdate = matdate;
		this.rateincharges = rateincharges;
		this.margin = margin;
		this.banktype = banktype;
		this.secid = secid;
		this.loan_updflag = loan_updflag;
		this.loan_entryflag = loan_entryflag;
		  
	}
	public String getIssuebranch() {
		return issuebranch;
	}
	public void setIssuebranch(String issuebranch) {
		this.issuebranch = issuebranch;
	}
	public String getStandname() {
		return standname;
	}
	public void setStandname(String standname) {
		this.standname = standname;
	}
	public String getAccno() {
		return accno;
	}
	public void setAccno(String accno) {
		this.accno = accno;
	}
	public String getDateofissue() {
		return dateofissue;
	}
	public void setDateofissue(String dateofissue) {
		this.dateofissue = dateofissue;
	}
	public String getFaceval() {
		return faceval;
	}
	public void setFaceval(String faceval) {
		this.faceval = faceval;
	}
	public String getRateofint() {
		return rateofint;
	}
	public void setRateofint(String rateofint) {
		this.rateofint = rateofint;
	}
	public String getPresentos() {
		return presentos;
	}
	public void setPresentos(String presentos) {
		this.presentos = presentos;
	}
	public String getPresentason() {
		return presentason;
	}
	public void setPresentason(String presentason) {
		this.presentason = presentason;
	}
	public String getMaturityval() {
		return maturityval;
	}
	public void setMaturityval(String maturityval) {
		this.maturityval = maturityval;
	}
	public String getTenure() {
		return tenure;
	}
	public void setTenure(String tenure) {
		this.tenure = tenure;
	}
	public String getMatdate() {
		return matdate;
	}
	public void setMatdate(String matdate) {
		this.matdate = matdate;
	}
	public String getRateincharges() {
		return rateincharges;
	}
	public void setRateincharges(String rateincharges) {
		this.rateincharges = rateincharges;
	}
	public String getMargin() {
		return margin;
	}
	public void setMargin(String margin) {
		this.margin = margin;
	}
	public String getBanktype() {
		return banktype;
	}
	public void setBanktype(String banktype) {
		this.banktype = banktype;
	}
	public String getSecid() {
		return secid;
	}
	public void setSecid(String secid) {
		this.secid = secid;
	}
	public String getLoan_updflag() {
		return loan_updflag;
	}
	public void setLoan_updflag(String loan_updflag) {
		this.loan_updflag = loan_updflag;
	}
	public String getLoan_entryflag() {
		return loan_entryflag;
	}
	public void setLoan_entryflag(String loan_entryflag) {
		this.loan_entryflag = loan_entryflag;
	}
	

}
