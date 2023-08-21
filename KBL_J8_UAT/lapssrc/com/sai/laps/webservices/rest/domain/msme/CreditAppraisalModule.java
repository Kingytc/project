package com.sai.laps.webservices.rest.domain.msme;

import java.util.List;

public class CreditAppraisalModule {

	private String customerName;
	private String constitution;
	private String industry;
	private String etbOrNTB;
	private String etbYearOfRelationWithKBL;
	private String creditScore;
	private String proposedFacilityRequestType;
	private String overDraft;
	private String creditLetter;
	private String bankGuarantee;
	private String wcdpn;
	private String customerExposerWithKBL;
	private String proposedLimitRequested;
	private String proposedNPAStatus;
	private String proposedLimitUtilisation;	
	private String customerMSMEexposure;
	private String otherFacilityRequestType;
	private String otherNPAStatus;
	private String otherPreLimitUtilisation;
	private String otherLimitrequest;
	private String appRefNo;
	private String panNo;
	private String custId;
	private String appDate;
	private String transitionDate;
	private String incorporateBusinessDate;	
	private String cmrRank;
	private String wilfulDafaulter;
	private String suitFiledProgress;
	private String suitfiledLessThan3Years;
	private String last5MonthNPA;
	private String currentRatio;
	private String netWorkingCapital;
	private String tolOrTNW;
	private String daysReceivable;
	private String cashAccrual;
	private String netWorth;
	private String interestorEBIT;
	private String cashBankBalance;
	private String currentLiabilities;
	private String debitOrEquity;
	private String salesOrPAT;
	private String returnAssets;
	private String returnCapitalEmployeed;
	private String returnEquity;
	private String salesWorkCapitalLimit;
	private String businessCreditDeviationFresh;
	private String businessDebitDeviationFresh;
	private String chequeReturnLast9Month;
	private String variationcreditCount6Month;
	private String credtDebitRatio6Months;
	private String businessCreditDeviationRenewal;
	private String businessDebitDeviationRenewal;
	private String chequeReturnLast12Month;
	private String variationCreditMonthly;
	private String variationDebitMonthly;
	private String daysOverutilisation6Months;
	private String commercialScoreCardSummary;
	private String consumerScorecardSummary;
	private String bankOdScoreCardSummary;
	private String financialScoreSummary;
	private String demogScoreCardSummary;
	private String applicationNo;
	private List<BureauVariable> bureauRenewal;
	private List<BureauVariable> bureauFresh;
	private String utilisationODLimit;
	
	
	public CreditAppraisalModule(){
		super();
	}
	
	public CreditAppraisalModule(String customerName,
			String constitution,
			String industry,
			String etbOrNTB,
			String etbYearOfRelationWithKBL,
			String creditScore,
			String proposedFacilityRequestType,
			String overDraft,
			String creditLetter,
			String bankGuarantee,
			String wcdpn,
			String customerExposerWithKBL,
			String proposedLimitRequested,
			String proposedNPAStatus,
			String proposedLimitUtilisation,	
			String customerMSMEexposure,
			String otherFacilityRequestType,
			String otherNPAStatus,
			String otherPreLimitUtilisation,
			String otherLimitrequest,
			String appRefNo,
			String panNo,
			String custId,
			String appDate,
			String transitionDate,
			String incorporateBusinessDate,	
			String cmrRank,
			String wilfulDafaulter,
			String suitFiledProgress,
			String suitfiledLessThan3Years,
			String last5MonthNPA,
			String currentRatio,
			String netWorkingCapital,
			String tolOrTNW,
			String daysReceivable,
			String cashAccrual,
			String netWorth,
			String interestorEBIT,
			String cashBankBalance,
			String currentLiabilities,
			String debitOrEquity,
			String salesOrPAT,
			String returnAssets,
			String returnCapitalEmployeed,
			String returnEquity,
			String salesWorkCapitalLimit,
			String businessCreditDeviationFresh,
			String businessDebitDeviationFresh,
			String chequeReturnLast9Month,
			String variationcreditCountt6Month,
			String credtDebitRatio6Months,
			String businessCreditDeviationRenewal,
			String businessDebitDeviationRenewal,
			String chequeReturnLast12Month,
			String variationCreditMonthly,
			String variationDebitMonthly,
			String daysOverutilisation6Months,
			String commercialScoreCardSummary,
			String consumerScorecardSummary,
			String bankOdScoreCardSummary,
			String financialScoreSummary,
			String demogScoreCardSummary,
			String applicationNo,
			 List<BureauVariable> bureauRenewal,
			 List<BureauVariable> bureauFresh,
			 String utilisationODLimit
			
			)
	{

		this.customerName=customerName;
		this.constitution=constitution;
		this.industry =industry;
		this.etbOrNTB=etbOrNTB;
		this.etbYearOfRelationWithKBL=etbYearOfRelationWithKBL;
		this.creditScore=creditScore;
		this.proposedFacilityRequestType=proposedFacilityRequestType;
		this.overDraft=overDraft;
		this.creditLetter=creditLetter;
		this.bankGuarantee=bankGuarantee;
		this.wcdpn=wcdpn;
		this.customerExposerWithKBL=customerExposerWithKBL;
		this.proposedLimitRequested=proposedLimitRequested;
		this.proposedNPAStatus=proposedNPAStatus;
		this.proposedLimitUtilisation=proposedLimitUtilisation;	
		this.customerMSMEexposure=customerMSMEexposure;
		this.otherFacilityRequestType=otherFacilityRequestType;
		this.otherNPAStatus=otherNPAStatus;
		this.otherPreLimitUtilisation=otherPreLimitUtilisation;
		this.otherLimitrequest=otherLimitrequest;
		this.appRefNo=appRefNo;
		this.panNo=panNo;
		this.custId=custId;
		this.appDate=appDate;
		this.transitionDate=transitionDate;
		this.incorporateBusinessDate=incorporateBusinessDate;	
		this.cmrRank=cmrRank;
		this.wilfulDafaulter=wilfulDafaulter;
		this.suitFiledProgress=suitFiledProgress;
		this.suitfiledLessThan3Years=suitfiledLessThan3Years;
		this.last5MonthNPA=last5MonthNPA;
		this.currentRatio=currentRatio;
		this.netWorkingCapital=netWorkingCapital;
		this.tolOrTNW=tolOrTNW;
		this.daysReceivable=daysReceivable;
		this.cashAccrual=cashAccrual;
		this.netWorth=netWorth;
		this.interestorEBIT=interestorEBIT;
		this.cashBankBalance=cashBankBalance;
		this.currentLiabilities=currentLiabilities;
		this.debitOrEquity=debitOrEquity;
		this.salesOrPAT=salesOrPAT;
		this.returnAssets=returnAssets;
		this.returnCapitalEmployeed=returnCapitalEmployeed;
		this.returnEquity=returnEquity;
		this.salesWorkCapitalLimit=salesWorkCapitalLimit;
		this.businessCreditDeviationFresh=businessCreditDeviationFresh;
		this.businessDebitDeviationFresh=businessDebitDeviationFresh;
		this.chequeReturnLast9Month=chequeReturnLast9Month;
		this.variationcreditCount6Month=variationcreditCount6Month;
		this.credtDebitRatio6Months=credtDebitRatio6Months;
		this.businessCreditDeviationRenewal=businessCreditDeviationRenewal;
		this.businessDebitDeviationRenewal=businessDebitDeviationRenewal;
		this.chequeReturnLast12Month=chequeReturnLast12Month;
		this.variationCreditMonthly=variationCreditMonthly;
		this.variationDebitMonthly=variationDebitMonthly;
		this.daysOverutilisation6Months=daysOverutilisation6Months;
		this.commercialScoreCardSummary=commercialScoreCardSummary;
		this.consumerScorecardSummary=consumerScorecardSummary;
		this.bankOdScoreCardSummary=bankOdScoreCardSummary;
		this.financialScoreSummary=financialScoreSummary;
		this.demogScoreCardSummary=demogScoreCardSummary;
		this.bureauRenewal=bureauRenewal;
		this.bureauFresh=bureauFresh;
		this.applicationNo=applicationNo;
		this.utilisationODLimit=utilisationODLimit;
		
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getConstitution() {
		return constitution;
	}

	public void setConstitution(String constitution) {
		this.constitution = constitution;
	}

	public String getIndustry() {
		return industry;
	}

	public void setIndustry(String industry) {
		this.industry = industry;
	}


	public String getApplicationNo() {
		return applicationNo;
	}

	public void setApplicationNo(String applicationNo) {
		this.applicationNo = applicationNo;
	}

	public String getEtbOrNTB() {
		return etbOrNTB;
	}

	public void setEtbOrNTB(String etbOrNTB) {
		this.etbOrNTB = etbOrNTB;
	}

	

	public String getEtbYearOfRelationWithKBL() {
		return etbYearOfRelationWithKBL;
	}

	public void setEtbYearOfRelationWithKBL(String etbYearOfRelationWithKBL) {
		this.etbYearOfRelationWithKBL = etbYearOfRelationWithKBL;
	}

	public String getCreditScore() {
		return creditScore;
	}
	
	public void setCreditScore(String creditScore) {
		this.creditScore = creditScore;
	}

	public String getProposedFacilityRequestType() {
		return proposedFacilityRequestType;
	}

	public void setProposedFacilityRequestType(String proposedFacilityRequestType) {
		this.proposedFacilityRequestType = proposedFacilityRequestType;
	}

	public String getOverDraft() {
		return overDraft;
	}

	public void setOverDraft(String overDraft) {
		this.overDraft = overDraft;
	}

	public String getCreditLetter() {
		return creditLetter;
	}

	public void setCreditLetter(String creditLetter) {
		this.creditLetter = creditLetter;
	}

	public String getBankGuarantee() {
		return bankGuarantee;
	}

	public void setBankGuarantee(String bankGuarantee) {
		this.bankGuarantee = bankGuarantee;
	}

	public String getWcdpn() {
		return wcdpn;
	}

	public void setWcdpn(String wcdpn) {
		this.wcdpn = wcdpn;
	}

	public String getCustomerExposerWithKBL() {
		return customerExposerWithKBL;
	}

	public void setCustomerExposerWithKBL(String customerExposerWithKBL) {
		this.customerExposerWithKBL = customerExposerWithKBL;
	}

	public String getProposedLimitRequested() {
		return proposedLimitRequested;
	}

	public void setProposedLimitRequested(String proposedLimitRequested) {
		this.proposedLimitRequested = proposedLimitRequested;
	}

	public String getProposedNPAStatus() {
		return proposedNPAStatus;
	}

	public void setProposedNPAStatus(String proposedNPAStatus) {
		this.proposedNPAStatus = proposedNPAStatus;
	}

	public String getProposedLimitUtilisation() {
		return proposedLimitUtilisation;
	}

	public void setProposedLimitUtilisation(String proposedLimitUtilisation) {
		this.proposedLimitUtilisation = proposedLimitUtilisation;
	}

	public String getCustomerMSMEexposure() {
		return customerMSMEexposure;
	}

	public void setCustomerMSMEexposure(String customerMSMEexposure) {
		this.customerMSMEexposure = customerMSMEexposure;
	}

	public String getOtherFacilityRequestType() {
		return otherFacilityRequestType;
	}

	public void setOtherFacilityRequestType(String otherFacilityRequestType) {
		this.otherFacilityRequestType = otherFacilityRequestType;
	}

	public String getOtherNPAStatus() {
		return otherNPAStatus;
	}

	public void setOtherNPAStatus(String otherNPAStatus) {
		this.otherNPAStatus = otherNPAStatus;
	}

	public String getOtherPreLimitUtilisation() {
		return otherPreLimitUtilisation;
	}

	public void setOtherPreLimitUtilisation(String otherPreLimitUtilisation) {
		this.otherPreLimitUtilisation = otherPreLimitUtilisation;
	}

	public String getOtherLimitrequest() {
		return otherLimitrequest;
	}

	public void setOtherLimitrequest(String otherLimitrequest) {
		this.otherLimitrequest = otherLimitrequest;
	}

	public String getAppRefNo() {
		return appRefNo;
	}

	public void setAppRefNo(String appRefNo) {
		this.appRefNo = appRefNo;
	}

	public String getPanNo() {
		return panNo;
	}

	public void setPanNo(String panNo) {
		this.panNo = panNo;
	}

	public String getCustId() {
		return custId;
	}

	public void setCustId(String custId) {
		this.custId = custId;
	}

	public String getAppDate() {
		return appDate;
	}

	public void setAppDate(String appDate) {
		this.appDate = appDate;
	}

	public String getTransitionDate() {
		return transitionDate;
	}

	public void setTransitionDate(String transitionDate) {
		this.transitionDate = transitionDate;
	}

	public String getIncorporateBusinessDate() {
		return incorporateBusinessDate;
	}

	public void setIncorporateBusinessDate(String incorporateBusinessDate) {
		this.incorporateBusinessDate = incorporateBusinessDate;
	}

	public String getCmrRank() {
		return cmrRank;
	}

	public void setCmrRank(String cmrRank) {
		this.cmrRank = cmrRank;
	}

	public String getWilfulDafaulter() {
		return wilfulDafaulter;
	}

	public void setWilfulDafaulter(String wilfulDafaulter) {
		this.wilfulDafaulter = wilfulDafaulter;
	}

	public String getSuitFiledProgress() {
		return suitFiledProgress;
	}

	public void setSuitFiledProgress(String suitFiledProgress) {
		this.suitFiledProgress = suitFiledProgress;
	}

	public String getSuitfiledLessThan3Years() {
		return suitfiledLessThan3Years;
	}

	public void setSuitfiledLessThan3Years(String suitfiledLessThan3Years) {
		this.suitfiledLessThan3Years = suitfiledLessThan3Years;
	}

	public String getLast5MonthNPA() {
		return last5MonthNPA;
	}

	public void setLast5MonthNPA(String last5MonthNPA) {
		this.last5MonthNPA = last5MonthNPA;
	}

	public String getCurrentRatio() {
		return currentRatio;
	}

	public void setCurrentRatio(String currentRatio) {
		this.currentRatio = currentRatio;
	}

	public String getNetWorkingCapital() {
		return netWorkingCapital;
	}

	public void setNetWorkingCapital(String netWorkingCapital) {
		this.netWorkingCapital = netWorkingCapital;
	}



	public String getTolOrTNW() {
		return tolOrTNW;
	}

	public void setTolOrTNW(String tolOrTNW) {
		this.tolOrTNW = tolOrTNW;
	}

	public String getDaysReceivable() {
		return daysReceivable;
	}

	public void setDaysReceivable(String daysReceivable) {
		this.daysReceivable = daysReceivable;
	}

	public String getCashAccrual() {
		return cashAccrual;
	}

	public void setCashAccrual(String cashAccrual) {
		this.cashAccrual = cashAccrual;
	}

	public String getNetWorth() {
		return netWorth;
	}

	public void setNetWorth(String netWorth) {
		this.netWorth = netWorth;
	}

	public String getInterestorEBIT() {
		return interestorEBIT;
	}

	public void setInterestorEBIT(String interestorEBIT) {
		this.interestorEBIT = interestorEBIT;
	}

	public String getCashBankBalance() {
		return cashBankBalance;
	}

	public void setCashBankBalance(String cashBankBalance) {
		this.cashBankBalance = cashBankBalance;
	}

	public String getCurrentLiabilities() {
		return currentLiabilities;
	}

	public void setCurrentLiabilities(String currentLiabilities) {
		this.currentLiabilities = currentLiabilities;
	}

	public String getDebitOrEquity() {
		return debitOrEquity;
	}

	public void setDebitOrEquity(String debitOrEquity) {
		this.debitOrEquity = debitOrEquity;
	}

	public String getSalesOrPAT() {
		return salesOrPAT;
	}

	public void setSalesOrPAT(String salesOrPAT) {
		this.salesOrPAT = salesOrPAT;
	}

	public String getReturnAssets() {
		return returnAssets;
	}

	public void setReturnAssets(String returnAssets) {
		this.returnAssets = returnAssets;
	}

	public String getReturnCapitalEmployeed() {
		return returnCapitalEmployeed;
	}

	public void setReturnCapitalEmployeed(String returnCapitalEmployeed) {
		this.returnCapitalEmployeed = returnCapitalEmployeed;
	}

	public String getReturnEquity() {
		return returnEquity;
	}

	public void setReturnEquity(String returnEquity) {
		this.returnEquity = returnEquity;
	}

	public String getSalesWorkCapitalLimit() {
		return salesWorkCapitalLimit;
	}

	public void setSalesWorkCapitalLimit(String salesWorkCapitalLimit) {
		this.salesWorkCapitalLimit = salesWorkCapitalLimit;
	}

	public String getBusinessCreditDeviationFresh() {
		return businessCreditDeviationFresh;
	}

	public void setBusinessCreditDeviationFresh(String businessCreditDeviationFresh) {
		this.businessCreditDeviationFresh = businessCreditDeviationFresh;
	}

	public String getBusinessDebitDeviationFresh() {
		return businessDebitDeviationFresh;
	}

	public void setBusinessDebitDeviationFresh(String businessDebitDeviationFresh) {
		this.businessDebitDeviationFresh = businessDebitDeviationFresh;
	}

	public String getChequeReturnLast9Month() {
		return chequeReturnLast9Month;
	}

	public void setChequeReturnLast9Month(String chequeReturnLast9Month) {
		this.chequeReturnLast9Month = chequeReturnLast9Month;
	}

	
	public String getVariationcreditCount6Month() {
		return variationcreditCount6Month;
	}

	public void setVariationcreditCount6Month(String variationcreditCount6Month) {
		this.variationcreditCount6Month = variationcreditCount6Month;
	}

	public String getCredtDebitRatio6Months() {
		return credtDebitRatio6Months;
	}

	public void setCredtDebitRatio6Months(String credtDebitRatio6Months) {
		this.credtDebitRatio6Months = credtDebitRatio6Months;
	}

	public String getBusinessCreditDeviationRenewal() {
		return businessCreditDeviationRenewal;
	}

	public void setBusinessCreditDeviationRenewal(
			String businessCreditDeviationRenewal) {
		this.businessCreditDeviationRenewal = businessCreditDeviationRenewal;
	}

	public String getBusinessDebitDeviationRenewal() {
		return businessDebitDeviationRenewal;
	}

	public void setBusinessDebitDeviationRenewal(
			String businessDebitDeviationRenewal) {
		this.businessDebitDeviationRenewal = businessDebitDeviationRenewal;
	}

	public String getChequeReturnLast12Month() {
		return chequeReturnLast12Month;
	}

	public void setChequeReturnLast12Month(String chequeReturnLast12Month) {
		this.chequeReturnLast12Month = chequeReturnLast12Month;
	}

	public String getVariationCreditMonthly() {
		return variationCreditMonthly;
	}

	public void setVariationCreditMonthly(String variationCreditMonthly) {
		this.variationCreditMonthly = variationCreditMonthly;
	}

	public String getVariationDebitMonthly() {
		return variationDebitMonthly;
	}

	public void setVariationDebitMonthly(String variationDebitMonthly) {
		this.variationDebitMonthly = variationDebitMonthly;
	}

	public String getDaysOverutilisation6Months() {
		return daysOverutilisation6Months;
	}

	public void setDaysOverutilisation6Months(String daysOverutilisation6Months) {
		this.daysOverutilisation6Months = daysOverutilisation6Months;
	}

	public String getCommercialScoreCardSummary() {
		return commercialScoreCardSummary;
	}

	public void setCommercialScoreCardSummary(String commercialScoreCardSummary) {
		this.commercialScoreCardSummary = commercialScoreCardSummary;
	}

	public String getConsumerScorecardSummary() {
		return consumerScorecardSummary;
	}

	public void setConsumerScorecardSummary(String consumerScorecardSummary) {
		this.consumerScorecardSummary = consumerScorecardSummary;
	}

	public String getBankOdScoreCardSummary() {
		return bankOdScoreCardSummary;
	}

	public void setBankOdScoreCardSummary(String bankOdScoreCardSummary) {
		this.bankOdScoreCardSummary = bankOdScoreCardSummary;
	}

	public String getFinancialScoreSummary() {
		return financialScoreSummary;
	}

	public void setFinancialScoreSummary(String financialScoreSummary) {
		this.financialScoreSummary = financialScoreSummary;
	}

	public String getDemogScoreCardSummary() {
		return demogScoreCardSummary;
	}

	public void setDemogScoreCardSummary(String demogScoreCardSummary) {
		this.demogScoreCardSummary = demogScoreCardSummary;
	}

	public List<BureauVariable> getBureauRenewal() {
		return bureauRenewal;
	}

	public void setBureauRenewal(List<BureauVariable> bureauRenewal) {
		this.bureauRenewal = bureauRenewal;
	}

	public List<BureauVariable> getBureauFresh() {
		return bureauFresh;
	}

	public void setBureauFresh(List<BureauVariable> bureauFresh) {
		this.bureauFresh = bureauFresh;
	}

	public String getUtilisationODLimit() {
		return utilisationODLimit;
	}

	public void setUtilisationODLimit(String utilisationODLimit) {
		this.utilisationODLimit = utilisationODLimit;
	}

	
	
	}



