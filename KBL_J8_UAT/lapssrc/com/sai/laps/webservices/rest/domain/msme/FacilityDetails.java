package com.sai.laps.webservices.rest.domain.msme;

import java.util.List;

public class FacilityDetails {
	
	private String type;
	private String adhocType;
	private String facilityOfAdhoc;
	private String interestType;
	private String tenor;
	private String proposedBankArrngmnt;
	private String paymentMode;
	private String periodInstallment;
	private String margin;
	private String dueDate;
	private String irregularities;
	private String govtSponserScheme;
	private String proopsedLimit;
	private String singlePremium;
	private String interestSubType;
	private String initialHoliday;
	private String repaymentType;
	private String interestRate;
	private String puropse;
	private String borrowerFreshLimit;
	private String processNoteDesc;
	private String detailsAsOn;
	private String facilityDescription;
	private String operativeAccountNo;
	private String insuranceAmntFundedBy;
	private String insuranceAmount;
	private String premiumTenor;
	private String loanAmountCovered;
	private String renewProposalNumber;
	private String renewProposalSno;
	private String facilitySno;
	private String facilityGroup;
	private String creditRiskPremium;
	private String fixedSpread;
	private String referenceType;
	private String cgtmse;
	private String interestCollected;
	private List<RepaymentScheduleMsme> repaymentSchedule;
	private String ecsBankName;
	private String ecsAccountType;
	private String ecsOperAccountType;
	private String ecsAuthunenticateMode;
	private String ecsIFSCCODE;

	public FacilityDetails() {
		super();
		// TODO Auto-generated constructor stub
	}
	public FacilityDetails(String type, String adhocType,
			String facilityOfAdhoc, String interestType, String tenor,
			String proposedBankArrngmnt, String paymentMode,
			String periodInstallment, String margin, String dueDate,
			String irregularities, String govtSponserScheme,
			String proopsedLimit, String singlePremium, String interestSubType,
			String initialHoliday, String repaymentType, String interestRate,
			String puropse, String borrowerFreshLimit, String processNoteDesc,
			String detailsAsOn, String facilityDescription,
			String operativeAccountNo, String insuranceAmntFundedBy,
			String insuranceAmount, String premiumTenor,
			String loanAmountCovered, String renewProposalNumber,
			String renewProposalSno,String facilitySno,String facilityGroup,String creditRiskPremium,String fixedSpread,String referenceType,List<RepaymentScheduleMsme> repaymentSchedule,String cgtmse,
			String interestCollected,String ecsBankName,String ecsAccountType,String ecsOperAccountType,String ecsAuthunenticateMode,String ecsIFSCCODE) {
		super();
		this.type = type;
		this.adhocType = adhocType;
		this.facilityOfAdhoc = facilityOfAdhoc;
		this.interestType = interestType;
		this.tenor = tenor;
		this.proposedBankArrngmnt = proposedBankArrngmnt;
		this.paymentMode = paymentMode;
		this.periodInstallment = periodInstallment;
		this.margin = margin;
		this.dueDate = dueDate;
		this.irregularities = irregularities;
		this.govtSponserScheme = govtSponserScheme;
		this.proopsedLimit = proopsedLimit;
		this.singlePremium = singlePremium;
		this.interestSubType = interestSubType;
		this.initialHoliday = initialHoliday;
		this.repaymentType = repaymentType;
		this.interestRate = interestRate;
		this.puropse = puropse;
		this.borrowerFreshLimit = borrowerFreshLimit;
		this.processNoteDesc = processNoteDesc;
		this.detailsAsOn = detailsAsOn;
		this.facilityDescription = facilityDescription;
		this.operativeAccountNo = operativeAccountNo;
		this.insuranceAmntFundedBy = insuranceAmntFundedBy;
		this.insuranceAmount = insuranceAmount;
		this.premiumTenor = premiumTenor;
		this.loanAmountCovered = loanAmountCovered;
		this.renewProposalNumber = renewProposalNumber;
		this.renewProposalNumber = renewProposalSno;
		this.facilitySno=facilitySno;
		this.facilityGroup=facilityGroup;
		this.creditRiskPremium=creditRiskPremium;
		this.fixedSpread=fixedSpread;
		this.referenceType=referenceType;
		this.cgtmse=cgtmse;
		this.repaymentSchedule=repaymentSchedule;
		this.interestCollected=interestCollected;
		this.setEcsBankName(ecsBankName);
	    this.setEcsAccountType(ecsAccountType);
	    this.setEcsOperAccountType(ecsOperAccountType);
	    this.setEcsAuthunenticateMode(ecsAuthunenticateMode);
	    this.setEcsIFSCCODE(ecsIFSCCODE);
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getAdhocType() {
		return adhocType;
	}
	public void setAdhocType(String adhocType) {
		this.adhocType = adhocType;
	}
	public String getFacilityOfAdhoc() {
		return facilityOfAdhoc;
	}
	public void setFacilityOfAdhoc(String facilityOfAdhoc) {
		this.facilityOfAdhoc = facilityOfAdhoc;
	}
	public String getInterestType() {
		return interestType;
	}
	public void setInterestType(String interestType) {
		this.interestType = interestType;
	}
	public String getTenor() {
		return tenor;
	}
	public void setTenor(String tenor) {
		this.tenor = tenor;
	}
	public String getProposedBankArrngmnt() {
		return proposedBankArrngmnt;
	}
	public void setProposedBankArrngmnt(String proposedBankArrngmnt) {
		this.proposedBankArrngmnt = proposedBankArrngmnt;
	}
	public String getPaymentMode() {
		return paymentMode;
	}
	public void setPaymentMode(String paymentMode) {
		this.paymentMode = paymentMode;
	}
	public String getPeriodInstallment() {
		return periodInstallment;
	}
	public void setPeriodInstallment(String periodInstallment) {
		this.periodInstallment = periodInstallment;
	}
	public String getMargin() {
		return margin;
	}
	public void setMargin(String margin) {
		this.margin = margin;
	}
	public String getDueDate() {
		return dueDate;
	}
	public void setDueDate(String dueDate) {
		this.dueDate = dueDate;
	}
	public String getIrregularities() {
		return irregularities;
	}
	public void setIrregularities(String irregularities) {
		this.irregularities = irregularities;
	}
	public String getGovtSponserScheme() {
		return govtSponserScheme;
	}
	public void setGovtSponserScheme(String govtSponserScheme) {
		this.govtSponserScheme = govtSponserScheme;
	}
	public String getProopsedLimit() {
		return proopsedLimit;
	}
	public void setProopsedLimit(String proopsedLimit) {
		this.proopsedLimit = proopsedLimit;
	}
	public String getSinglePremium() {
		return singlePremium;
	}
	public void setSinglePremium(String singlePremium) {
		this.singlePremium = singlePremium;
	}
	public String getInterestSubType() {
		return interestSubType;
	}
	public void setInterestSubType(String interestSubType) {
		this.interestSubType = interestSubType;
	}
	public String getInitialHoliday() {
		return initialHoliday;
	}
	public void setInitialHoliday(String initialHoliday) {
		this.initialHoliday = initialHoliday;
	}
	public String getRepaymentType() {
		return repaymentType;
	}
	public void setRepaymentType(String repaymentType) {
		this.repaymentType = repaymentType;
	}
	public String getInterestRate() {
		return interestRate;
	}
	public void setInterestRate(String interestRate) {
		this.interestRate = interestRate;
	}
	public String getPuropse() {
		return puropse;
	}
	public void setPuropse(String puropse) {
		this.puropse = puropse;
	}
	public String getBorrowerFreshLimit() {
		return borrowerFreshLimit;
	}
	public void setBorrowerFreshLimit(String borrowerFreshLimit) {
		this.borrowerFreshLimit = borrowerFreshLimit;
	}
	public String getProcessNoteDesc() {
		return processNoteDesc;
	}
	public void setProcessNoteDesc(String processNoteDesc) {
		this.processNoteDesc = processNoteDesc;
	}
	public String getDetailsAsOn() {
		return detailsAsOn;
	}
	public void setDetailsAsOn(String detailsAsOn) {
		this.detailsAsOn = detailsAsOn;
	}
	public String getFacilityDescription() {
		return facilityDescription;
	}
	public void setFacilityDescription(String facilityDescription) {
		this.facilityDescription = facilityDescription;
	}
	public String getOperativeAccountNo() {
		return operativeAccountNo;
	}
	public void setOperativeAccountNo(String operativeAccountNo) {
		this.operativeAccountNo = operativeAccountNo;
	}
	public String getInsuranceAmntFundedBy() {
		return insuranceAmntFundedBy;
	}
	public void setInsuranceAmntFundedBy(String insuranceAmntFundedBy) {
		this.insuranceAmntFundedBy = insuranceAmntFundedBy;
	}
	public String getInsuranceAmount() {
		return insuranceAmount;
	}
	public void setInsuranceAmount(String insuranceAmount) {
		this.insuranceAmount = insuranceAmount;
	}
	public String getPremiumTenor() {
		return premiumTenor;
	}
	public void setPremiumTenor(String premiumTenor) {
		this.premiumTenor = premiumTenor;
	}
	public String getLoanAmountCovered() {
		return loanAmountCovered;
	}
	public void setLoanAmountCovered(String loanAmountCovered) {
		this.loanAmountCovered = loanAmountCovered;
	}
	public String getRenewProposalNumber() {
		return renewProposalNumber;
	}
	public void setRenewProposalNumber(String renewProposalNumber) {
		this.renewProposalNumber = renewProposalNumber;
	}
	public String getRenewProposalSno() {
		return renewProposalSno;
	}
	public void setRenewProposalSno(String renewProposalSno) {
		this.renewProposalSno = renewProposalSno;
	}
	public String getFacilitySno() {
		return facilitySno;
	}
	public void setFacilitySno(String facilitySno) {
		this.facilitySno = facilitySno;
	}
	public String getFacilityGroup() {
		return facilityGroup;
	}
	public void setFacilityGroup(String facilityGroup) {
		this.facilityGroup = facilityGroup;
	}
	public String getCreditRiskPremium() {
		return creditRiskPremium;
	}
	public void setCreditRiskPremium(String creditRiskPremium) {
		this.creditRiskPremium = creditRiskPremium;
	}
	public String getFixedSpread() {
		return fixedSpread;
	}
	public void setFixedSpread(String fixedSpread) {
		this.fixedSpread = fixedSpread;
	}
	public String getReferenceType() {
		return referenceType;
	}
	public void setReferenceType(String referenceType) {
		this.referenceType = referenceType;
	}
	public String getCgtmse() {
		return cgtmse;
	}
	public void setCgtmse(String cgtmse) {
		this.cgtmse = cgtmse;
	}
	public List<RepaymentScheduleMsme> getRepaymentSchedule() {
		return repaymentSchedule;
	}
	public void setRepaymentSchedule(List<RepaymentScheduleMsme> repaymentSchedule) {
		this.repaymentSchedule = repaymentSchedule;
	}
	
	public String getInterestCollected() {
		return interestCollected;
	}
	
	public void setInterestCollected(String interestCollected) {
		this.interestCollected = interestCollected;
	}
	public void setEcsBankName(String ecsBankName) {
		this.ecsBankName = ecsBankName;
	}
	public String getEcsBankName() {
		return ecsBankName;
	}
	public void setEcsAccountType(String ecsAccountType) {
		this.ecsAccountType = ecsAccountType;
	}
	public String getEcsAccountType() {
		return ecsAccountType;
	}
	public void setEcsOperAccountType(String ecsOperAccountType) {
		this.ecsOperAccountType = ecsOperAccountType;
	}
	public String getEcsOperAccountType() {
		return ecsOperAccountType;
	}
	public void setEcsAuthunenticateMode(String ecsAuthunenticateMode) {
		this.ecsAuthunenticateMode = ecsAuthunenticateMode;
	}
	public String getEcsAuthunenticateMode() {
		return ecsAuthunenticateMode;
	}
	public void setEcsIFSCCODE(String ecsIFSCCODE) {
		this.ecsIFSCCODE = ecsIFSCCODE;
	}
	public String getEcsIFSCCODE() {
		return ecsIFSCCODE;
	}
	
	
}
