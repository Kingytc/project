package com.sai.laps.webservices.rest.domain.agri;

import java.util.List;

import com.sai.laps.webservices.rest.domain.CoApplicant;
import com.sai.laps.webservices.rest.domain.ManagementInfo;
import com.sai.laps.webservices.rest.domain.msme.BussinessOperation;
import com.sai.laps.webservices.rest.domain.msme.DigiRating;
import com.sai.laps.webservices.rest.domain.msme.Dscr;
import com.sai.laps.webservices.rest.domain.msme.ExistingFacilityProposal;
import com.sai.laps.webservices.rest.domain.msme.ExpenditureMethod;
import com.sai.laps.webservices.rest.domain.msme.FacilityDetails;
import com.sai.laps.webservices.rest.domain.msme.FinancialLiabilitis;
import com.sai.laps.webservices.rest.domain.msme.MicroMitra;
import com.sai.laps.webservices.rest.domain.msme.OdccLimits;
import com.sai.laps.webservices.rest.domain.msme.TurnOverMethod;

public class AgriFacilityProposal {
	
	private String larNo;
	private String type;
	private String adhocType;
	private String facilityOfAdhoc;
	private String interestType;
	private  String tenor;
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
	private String cbsId;
	private String lapsCustomerId;
	private String applicationBranch;
	private String facilityDescription;
	private String operativeAccountNo;
	private String proposalFormat;
	private String processingCharges;
	private String cfrVerified;
	private String cersaiChecked;
	private String prioritysector;
	private List<CoApplicant> coApplicant;
	private String briefHistoryProcesnote;
	private String briefHistoryAnnexure;
	private String briefHistorySourcing;
	private List<ManagementInfo> managementInfo;
	private String birRequired;
	private String submissionDate;
	private String receiptDate;
	private String birCharges;
	private String birReportDate;
	private String insuranceAmntFundedBy;
	private String insuranceAmount;
	private String premiumTenor;
	private String loanAmountCovered;
	private String creditRiskPremium;
	private String fixedSpread;
	private String referenceType;
	private List<TurnOverMethod> turnOverMethod;
	private List<ExpenditureMethod> expenditureMethod;
	private String RenewProposalNumber;
	private String RenewProposalSno;
	private List<FacilityDetails> facilityDetails;
	private String financialFormat;
	private String valuesAreIn;
	private String facilities;
	private List<FinancialLiabilitis> liabilities;
	private List<FinancialLiabilitis> assets;
	private List<FinancialLiabilitis> profitLossAcc;
	private List<AgriVerification> verificationFlag;
	private List<ExistingFacilityProposal>  ExistingFacilityProposal;
	private String financialId;
	private List<Dscr> dscr;
	private List<Dscr> sensitivityAnalysis;
	private String assessmentComment;
	private List<DigiRating> digiRating;
	private  List<MicroMitra>  microMitraAssessment;
	private String amberExits;	
	private String otherAssessmentforWCDPNWCTL;
	private List<BussinessOperation> bussinessOperation;
	private List<OdccLimits> odccLimits;
	private String scheme;
	
	
	public AgriFacilityProposal() {
		super();
		// TODO Auto-generated constructor stub
	}


	public AgriFacilityProposal(String larNo, String type, String adhocType, String facilityOfAdhoc,
			String interestType, String tenor, String proposedBankArrngmnt, String paymentMode,
			String periodInstallment, String margin, String dueDate, String irregularities, String govtSponserScheme,
			String proopsedLimit, String singlePremium, String interestSubType, String initialHoliday,
			String repaymentType, String interestRate, String puropse, String borrowerFreshLimit,
			String processNoteDesc, String detailsAsOn, String cbsId, String lapsCustomerId, String applicationBranch,
			String facilityDescription, String operativeAccountNo, String proposalFormat, String processingCharges,
			String cfrVerified, String cersaiChecked, String prioritysector, List<CoApplicant> coApplicant,
			String briefHistoryProcesnote, String briefHistoryAnnexure, String briefHistorySourcing,
			List<ManagementInfo> managementInfo, String birRequired, String submissionDate, String receiptDate,
			String birCharges, String birReportDate, String insuranceAmntFundedBy, String insuranceAmount,
			String premiumTenor, String loanAmountCovered, String creditRiskPremium, String fixedSpread,
			String referenceType, List<TurnOverMethod> turnOverMethod, List<ExpenditureMethod> expenditureMethod,
			String renewProposalNumber, String renewProposalSno, List<FacilityDetails> facilityDetails,
			String financialFormat, String valuesAreIn, String facilities, List<FinancialLiabilitis> liabilities,
			List<FinancialLiabilitis> assets, List<FinancialLiabilitis> profitLossAcc,
			List<AgriVerification> verificationFlag,
			List<com.sai.laps.webservices.rest.domain.msme.ExistingFacilityProposal> existingFacilityProposal,
			String financialId, List<Dscr> dscr, List<Dscr> sensitivityAnalysis, String assessmentComment,
			List<DigiRating> digiRating, List<MicroMitra> microMitraAssessment, String amberExits,
			String otherAssessmentforWCDPNWCTL, List<BussinessOperation> bussinessOperation,
			List<OdccLimits> odccLimits, String scheme) {
		super();
		this.larNo = larNo;
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
		this.cbsId = cbsId;
		this.lapsCustomerId = lapsCustomerId;
		this.applicationBranch = applicationBranch;
		this.facilityDescription = facilityDescription;
		this.operativeAccountNo = operativeAccountNo;
		this.proposalFormat = proposalFormat;
		this.processingCharges = processingCharges;
		this.cfrVerified = cfrVerified;
		this.cersaiChecked = cersaiChecked;
		this.prioritysector = prioritysector;
		this.coApplicant = coApplicant;
		this.briefHistoryProcesnote = briefHistoryProcesnote;
		this.briefHistoryAnnexure = briefHistoryAnnexure;
		this.briefHistorySourcing = briefHistorySourcing;
		this.managementInfo = managementInfo;
		this.birRequired = birRequired;
		this.submissionDate = submissionDate;
		this.receiptDate = receiptDate;
		this.birCharges = birCharges;
		this.birReportDate = birReportDate;
		this.insuranceAmntFundedBy = insuranceAmntFundedBy;
		this.insuranceAmount = insuranceAmount;
		this.premiumTenor = premiumTenor;
		this.loanAmountCovered = loanAmountCovered;
		this.creditRiskPremium = creditRiskPremium;
		this.fixedSpread = fixedSpread;
		this.referenceType = referenceType;
		this.turnOverMethod = turnOverMethod;
		this.expenditureMethod = expenditureMethod;
		RenewProposalNumber = renewProposalNumber;
		RenewProposalSno = renewProposalSno;
		this.facilityDetails = facilityDetails;
		this.financialFormat = financialFormat;
		this.valuesAreIn = valuesAreIn;
		this.facilities = facilities;
		this.liabilities = liabilities;
		this.assets = assets;
		this.profitLossAcc = profitLossAcc;
		this.verificationFlag = verificationFlag;
		ExistingFacilityProposal = existingFacilityProposal;
		this.financialId = financialId;
		this.dscr = dscr;
		this.sensitivityAnalysis = sensitivityAnalysis;
		this.assessmentComment = assessmentComment;
		this.digiRating = digiRating;
		this.microMitraAssessment = microMitraAssessment;
		this.amberExits = amberExits;
		this.otherAssessmentforWCDPNWCTL = otherAssessmentforWCDPNWCTL;
		this.bussinessOperation = bussinessOperation;
		this.odccLimits = odccLimits;
		this.scheme = scheme;
	}


	public String getLarNo() {
		return larNo;
	}


	public void setLarNo(String larNo) {
		this.larNo = larNo;
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


	public String getCbsId() {
		return cbsId;
	}


	public void setCbsId(String cbsId) {
		this.cbsId = cbsId;
	}


	public String getLapsCustomerId() {
		return lapsCustomerId;
	}


	public void setLapsCustomerId(String lapsCustomerId) {
		this.lapsCustomerId = lapsCustomerId;
	}


	public String getApplicationBranch() {
		return applicationBranch;
	}


	public void setApplicationBranch(String applicationBranch) {
		this.applicationBranch = applicationBranch;
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


	public String getProposalFormat() {
		return proposalFormat;
	}


	public void setProposalFormat(String proposalFormat) {
		this.proposalFormat = proposalFormat;
	}


	public String getProcessingCharges() {
		return processingCharges;
	}


	public void setProcessingCharges(String processingCharges) {
		this.processingCharges = processingCharges;
	}


	public String getCfrVerified() {
		return cfrVerified;
	}


	public void setCfrVerified(String cfrVerified) {
		this.cfrVerified = cfrVerified;
	}


	public String getCersaiChecked() {
		return cersaiChecked;
	}


	public void setCersaiChecked(String cersaiChecked) {
		this.cersaiChecked = cersaiChecked;
	}


	public String getPrioritysector() {
		return prioritysector;
	}


	public void setPrioritysector(String prioritysector) {
		this.prioritysector = prioritysector;
	}


	public List<CoApplicant> getCoApplicant() {
		return coApplicant;
	}


	public void setCoApplicant(List<CoApplicant> coApplicant) {
		this.coApplicant = coApplicant;
	}


	public String getBriefHistoryProcesnote() {
		return briefHistoryProcesnote;
	}


	public void setBriefHistoryProcesnote(String briefHistoryProcesnote) {
		this.briefHistoryProcesnote = briefHistoryProcesnote;
	}


	public String getBriefHistoryAnnexure() {
		return briefHistoryAnnexure;
	}


	public void setBriefHistoryAnnexure(String briefHistoryAnnexure) {
		this.briefHistoryAnnexure = briefHistoryAnnexure;
	}


	public String getBriefHistorySourcing() {
		return briefHistorySourcing;
	}


	public void setBriefHistorySourcing(String briefHistorySourcing) {
		this.briefHistorySourcing = briefHistorySourcing;
	}


	public List<ManagementInfo> getManagementInfo() {
		return managementInfo;
	}


	public void setManagementInfo(List<ManagementInfo> managementInfo) {
		this.managementInfo = managementInfo;
	}


	public String getBirRequired() {
		return birRequired;
	}


	public void setBirRequired(String birRequired) {
		this.birRequired = birRequired;
	}


	public String getSubmissionDate() {
		return submissionDate;
	}


	public void setSubmissionDate(String submissionDate) {
		this.submissionDate = submissionDate;
	}


	public String getReceiptDate() {
		return receiptDate;
	}


	public void setReceiptDate(String receiptDate) {
		this.receiptDate = receiptDate;
	}


	public String getBirCharges() {
		return birCharges;
	}


	public void setBirCharges(String birCharges) {
		this.birCharges = birCharges;
	}


	public String getBirReportDate() {
		return birReportDate;
	}


	public void setBirReportDate(String birReportDate) {
		this.birReportDate = birReportDate;
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


	public List<TurnOverMethod> getTurnOverMethod() {
		return turnOverMethod;
	}


	public void setTurnOverMethod(List<TurnOverMethod> turnOverMethod) {
		this.turnOverMethod = turnOverMethod;
	}


	public List<ExpenditureMethod> getExpenditureMethod() {
		return expenditureMethod;
	}


	public void setExpenditureMethod(List<ExpenditureMethod> expenditureMethod) {
		this.expenditureMethod = expenditureMethod;
	}


	public String getRenewProposalNumber() {
		return RenewProposalNumber;
	}


	public void setRenewProposalNumber(String renewProposalNumber) {
		RenewProposalNumber = renewProposalNumber;
	}


	public String getRenewProposalSno() {
		return RenewProposalSno;
	}


	public void setRenewProposalSno(String renewProposalSno) {
		RenewProposalSno = renewProposalSno;
	}


	public List<FacilityDetails> getFacilityDetails() {
		return facilityDetails;
	}


	public void setFacilityDetails(List<FacilityDetails> facilityDetails) {
		this.facilityDetails = facilityDetails;
	}


	public String getFinancialFormat() {
		return financialFormat;
	}


	public void setFinancialFormat(String financialFormat) {
		this.financialFormat = financialFormat;
	}


	public String getValuesAreIn() {
		return valuesAreIn;
	}


	public void setValuesAreIn(String valuesAreIn) {
		this.valuesAreIn = valuesAreIn;
	}


	public String getFacilities() {
		return facilities;
	}


	public void setFacilities(String facilities) {
		this.facilities = facilities;
	}


	public List<FinancialLiabilitis> getLiabilities() {
		return liabilities;
	}


	public void setLiabilities(List<FinancialLiabilitis> liabilities) {
		this.liabilities = liabilities;
	}


	public List<FinancialLiabilitis> getAssets() {
		return assets;
	}


	public void setAssets(List<FinancialLiabilitis> assets) {
		this.assets = assets;
	}


	public List<FinancialLiabilitis> getProfitLossAcc() {
		return profitLossAcc;
	}


	public void setProfitLossAcc(List<FinancialLiabilitis> profitLossAcc) {
		this.profitLossAcc = profitLossAcc;
	}


	public List<AgriVerification> getVerificationFlag() {
		return verificationFlag;
	}


	public void setVerificationFlag(List<AgriVerification> verificationFlag) {
		this.verificationFlag = verificationFlag;
	}


	public List<ExistingFacilityProposal> getExistingFacilityProposal() {
		return ExistingFacilityProposal;
	}


	public void setExistingFacilityProposal(List<ExistingFacilityProposal> existingFacilityProposal) {
		ExistingFacilityProposal = existingFacilityProposal;
	}


	public String getFinancialId() {
		return financialId;
	}


	public void setFinancialId(String financialId) {
		this.financialId = financialId;
	}


	public List<Dscr> getDscr() {
		return dscr;
	}


	public void setDscr(List<Dscr> dscr) {
		this.dscr = dscr;
	}


	public List<Dscr> getSensitivityAnalysis() {
		return sensitivityAnalysis;
	}


	public void setSensitivityAnalysis(List<Dscr> sensitivityAnalysis) {
		this.sensitivityAnalysis = sensitivityAnalysis;
	}


	public String getAssessmentComment() {
		return assessmentComment;
	}


	public void setAssessmentComment(String assessmentComment) {
		this.assessmentComment = assessmentComment;
	}


	public List<DigiRating> getDigiRating() {
		return digiRating;
	}


	public void setDigiRating(List<DigiRating> digiRating) {
		this.digiRating = digiRating;
	}


	public List<MicroMitra> getMicroMitraAssessment() {
		return microMitraAssessment;
	}


	public void setMicroMitraAssessment(List<MicroMitra> microMitraAssessment) {
		this.microMitraAssessment = microMitraAssessment;
	}


	public String getAmberExits() {
		return amberExits;
	}


	public void setAmberExits(String amberExits) {
		this.amberExits = amberExits;
	}


	public String getOtherAssessmentforWCDPNWCTL() {
		return otherAssessmentforWCDPNWCTL;
	}


	public void setOtherAssessmentforWCDPNWCTL(String otherAssessmentforWCDPNWCTL) {
		this.otherAssessmentforWCDPNWCTL = otherAssessmentforWCDPNWCTL;
	}


	public List<BussinessOperation> getBussinessOperation() {
		return bussinessOperation;
	}


	public void setBussinessOperation(List<BussinessOperation> bussinessOperation) {
		this.bussinessOperation = bussinessOperation;
	}


	public List<OdccLimits> getOdccLimits() {
		return odccLimits;
	}


	public void setOdccLimits(List<OdccLimits> odccLimits) {
		this.odccLimits = odccLimits;
	}


	public String getScheme() {
		return scheme;
	}


	public void setScheme(String scheme) {
		this.scheme = scheme;
	}
	
	
}
