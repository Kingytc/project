package com.sai.laps.webservices.rest.domain;

import java.util.List;

import org.jboss.beans.metadata.plugins.SearchInfoValueAdapter;
import org.jboss.ejb3.interceptors.metadata.AdditiveBeanInterceptorMetaDataBridge;
import org.json.JSONArray;
import org.json.JSONObject;
import java.util.ArrayList;

import com.sai.laps.webservices.rest.domain.msme.DigiRating;

public class ProposalCreation {
	
	
	
	private String larNumber;
	private String customerID;
	private String lapsID;
	private String loanType;
	private String amountRequested;
	private String singlePremium;
	private String projectCost;
	private String loanTenor;
	private String holidayPeriod;
	private String loanPurpose;
	private String applicationBranch;
	private String interestRate;
	private String emiAmount;
	private String misActivityCode;
	private String mclrType;
	private String paymentMode;
	private String deviation;
	private String applicationScore;
	private String appScoreDeviation;
	private String processingFee;
	private String processsingFeeCollected;
	private List<DocumentsDetails> documentDetails;
	private List<CoApplicant> coApplicant;
	private List<DeviationDetails> deviationDetails;
	private String sanctionStatus;
	private String categoryLoanPurpose;
	private String premisesAge;
	//private String securityId;
	private String operativeAccountNo;
	private String termAndCondition;
	private String creditRiskPremium;
	private String businessStrategicPremium;
	private String insuranceAmntFundedBy;
	private String insuranceAmount;
	private String premiumTenor;
	private String loanAmountCovered;
	private String margin;
	private String vehiclePurchase;
	private String vehicleCost;
	private String tax;
	private String otherCharges;
	private String accessoriesPrice;
	private String insurance;
	private String discount;
	private String totalCost;
	private String verificationDoneBy;
	private String costAlreadyIncurred;
	private String ownSavingAndDisposalInvest;
	private String interestCollected;
	private String fuelUsed;
	private String customerBackgroundComments;
	
	private String govtSponserScheme;
	private String schemeType;
	private String sponsorAgency;
	private String agencyName;
	private String subsidyAmount;
	private String subsidyType;
	
	private String deviationROI;
	private String deviationFOIR;
	private String deviationLoanAmount;
	
	private String digiNMI;
	private String digiMaxEmi;
	
	private String digiFOIR;
	private String digiNMImultiplier;
	private String loanFromBank;
	private String reasonShiftBank;
	private String loanAmntTransferBank;
	private String dateOfAvailing;
	private String installmentTrnsBank;
	private String stallmentStipulated;
	private String installmentStartDate;
	private String installmentLastDate;
	private String holidayperiod;
	private String repaymentPeriod;
	private String interestRateTakeOver;
	private String totalLiability;
	private String asOnDateLiability;
	private String noOfInstallmentPaid;
	private String uptoDate;
	private String regularLoanAcc;
	private String overdueAmount;
	private String asOnDateOvrdue;
	private String amountPaidTransfer;
	private String opinionDetails;
	private String accountStatementFrom;
	private String accountStatementTo;
	private String comments;
	private String takeOver;
	private String digiAppNo;
	private String permissionRefNo;
	private String repaymentType;
	private List<RepaymentSchedule> repaymentSchedule;
	private String scheme;
	private String installmentPeriodicity;
	private String productDesc;
	private String residualValue;
	private String productIdentification;
	private List securityId;
	private String gstyear1;
	private String gstyear1amnt;
	private String gstyear2;
	private String gstyear2amnt;
	private String commercialBureauScore;
	private String consumerIndScore;
	private String consumerPartyScore;
	private String odAccountScore;
	private String currentAccountScore;
	private String fsaScore;
	private String bandRating;
	private String bandPath;
	private String kbRating;
	private String penalInterest;
	private String interestConcession;
	private String renewType;
	private String renewProposalsNo;
	private List<DigiRating> digiRating; 
	private String findigitype;
	private String findigiyear;
	private String ecsBankName;
	private String ecsAccountType;
	private String ecsOperAccountType;
	private String ecsAuthunenticateMode;
	private String ecsIFSCCODE;
	private String gstVerification;
	private String upfrontfee;
	private List<GoldOrnaments> goldOrnaments;
	private String docRecAgri;
	private String appraiserName;
	private String appraiseon;
	private String appraisercomments;
	private String appraisercbsid;
	private String strappraiserName;
	private String strappraiseon;
	private String strappraisercomments;
	private String strappraisercbsid;
	private String amrtOverrideLoanAmount;
	private ArrayList termsAndCondition;
	private String amrtOverride;
	private String bussinessId;
	private String upfrontFeeCollected;
	private String maxEligibleEMI;
	private String stpType;
	private List<DepositDetails> depositdetails;
	private String token;
	
//	shiva new fields added for Gold loan
	private String inttype;
	private String cfr_verified;
	private String CFR_borname;
	private String cersai_check;
	private String DRAWING_PWR_IND;
	private String GLSUBHEADCODE;
	private String GISTOFSECURITUES;
	private String loanSecure;
	private String SANCLEVEL;
	private String SANCAUTH;
	private String repaymentterms;
	private String schemecode;
	private String restime;
	private String sanctionedBy;
	private String appriasedBy;
	private String flowdata;
	private String appraisaldepartment;
	
	
	
	public ProposalCreation() {
		super();
		// TODO Auto-generated constructor stub
	}


	public ProposalCreation(String larNumber, String customerID, String lapsID,
			String loanType, String amountRequested, String singlePremium,
			String projectCost, String loanTenor, String holidayPeriod,
			String loanPurpose, String applicationBranch, String interestRate,
			String emiAmount, List<CoApplicant> coApplicant,String misActivityCode,String mclrType,String paymentMode,
			String deviation,String applicationScore,List<DeviationDetails> deviationDetails,String appScoreDeviation,String processingFee,
			String processsingFeeCollected,List<DocumentsDetails> documentDetails,String sanctionStatus,String categoryLoanPurpose,String premisesAge,List securityId,
			String operativeAccountNo,String termAndCondition,String creditRiskPremium,String businessStrategicPremium,String insuranceAmntFundedBy,String insuranceAmount,
			String premiumTenor, String loanAmountCovered,String margin, String vehiclePurchase,String vehicleCost,String tax,String otherCharges, String accessoriesPrice, String insurance,
			String discount, String totalCost, String verificationDoneBy, String costAlreadyIncurred, String ownSavingAndDisposalInvest,String interestCollected,String fuelUsed,String customerBackgroundComments,
			String govtSponserScheme, String schemeType,String sponsorAgency, String agencyName, String subsidyAmount,String subsidyType,
			String deviationROI, String deviationFOIR, String deviationLoanAmount,String digiNMI,String digiMaxEmi,String digiFOIR,String digiNMImultiplier,String loanFromBank,
			 String reasonShiftBank,
				String loanAmntTransferBank,
				String dateOfAvailing,
				String installmentTrnsBank,
				String installmentStartDate,
				String installmentLastDate,
				String holidayperiod,
				String repaymentPeriod,
				String interestRateTakeOver,
				String totalLiability,
				String asOnDateLiability,
				String noOfInstallmentPaid,
				String uptoDate,
				String regularLoanAcc,
				String overdueAmount,
				String asOnDateOvrdue,
				String amountPaidTransfer,
				String opinionDetails,
				String accountStatementFrom,
				String accountStatementTo,
				String comments,
				String takeOver,
				String stallmentStipulated,
				String digiAppNo,
				String permissionRefNo,
				String repaymentType,
				List<RepaymentSchedule> repaymentSchedule,
				String scheme,
				String installmentPeriodicity,
				String productDesc,
				String residualValue,
				String productIdentification,
				String gstyear1,
				String gstyear1amnt,
				String gstyear2,
				String gstyear2amnt,
				String commercialBureauScore,
				String consumerIndScore,
				String consumerPartyScore,
				String odAccountScore,
				String currentAccountScore,
				String fsaScore,
				String bandRating,
				String bandPath,
				String kbRating,
				String penalInterest,
				String interestConcession,
				String renewType,
				String renewProposalsNo, 
				List<DigiRating> digiRating,
				String findigitype,
				String findigiyear,
				String ecsBankName,
				String ecsAccountType,
				String ecsOperAccountType,
				String ecsAuthunenticateMode,
				String ecsIFSCCODE,String gstVerification,String upfrontfee,
				List<GoldOrnaments> goldOrnaments,String docRecAgri,String appraiserName,String appraiseon,String appraisercomments,String appraisercbsid,
				String amrtOverrideLoanAmount,ArrayList termsAndCondition,String amrtOverride,String bussinessId,String upfrontFeeCollected,String maxEligibleEMI,String stpType,List<DepositDetails> depositdetails,
				String token,String restime,String inttype,String cfr_verified,String CFR_borname,String cersai_check,String DRAWING_PWR_IND,String GLSUBHEADCODE,
				String GISTOFSECURITUES,String loanSecure,String SANCLEVEL,String SANCAUTH,String repaymentterms,String schemecode,String sanctionedBy,String appriasedBy,String flowdata,
				String appraisaldepartment) {
		super();
		this.larNumber = larNumber;
		this.customerID = customerID;
		this.lapsID = lapsID;
		this.loanType = loanType;
		this.amountRequested = amountRequested;
		this.singlePremium = singlePremium;
		this.projectCost = projectCost;
		this.loanTenor = loanTenor;
		this.holidayPeriod = holidayPeriod;
		this.loanPurpose = loanPurpose;
		this.applicationBranch = applicationBranch;
		this.interestRate = interestRate;
		this.emiAmount = emiAmount;
		this.misActivityCode = misActivityCode;
		this.processingFee = processingFee;
		this.processsingFeeCollected = processsingFeeCollected;
		this.documentDetails = documentDetails;
		this.coApplicant = coApplicant;
		this.mclrType=mclrType;
		this.paymentMode=paymentMode;
		this.deviation=deviation;
		this.applicationScore=applicationScore;
		this.deviationDetails=deviationDetails;
		this.appScoreDeviation=appScoreDeviation;
		this.sanctionStatus=sanctionStatus;
		this.categoryLoanPurpose=categoryLoanPurpose;
		this.premisesAge=premisesAge;
		this.securityId=securityId;
		this.operativeAccountNo=operativeAccountNo;
		this.termAndCondition=termAndCondition;
		this.creditRiskPremium=creditRiskPremium;
		this.businessStrategicPremium=businessStrategicPremium;
		this.insuranceAmntFundedBy=insuranceAmntFundedBy;
		this.insuranceAmount=insuranceAmount;
		this.premiumTenor=premiumTenor;
		this.loanAmountCovered=loanAmountCovered;
		this.margin=margin;
		this.vehiclePurchase=vehiclePurchase;
	    this.vehicleCost=vehicleCost;
    	 this.tax=tax;
		 this.otherCharges=otherCharges;
		 this.accessoriesPrice=accessoriesPrice;
		 this.insurance=insurance;
		 this.discount=discount;
		 this.totalCost=totalCost;
		 this. verificationDoneBy=verificationDoneBy;
		 this.costAlreadyIncurred=costAlreadyIncurred;
		 this.ownSavingAndDisposalInvest=ownSavingAndDisposalInvest;
		 this.interestCollected=interestCollected;
		 this.fuelUsed=fuelUsed;
		 this.customerBackgroundComments=customerBackgroundComments;
		this.govtSponserScheme = govtSponserScheme;
		this.schemeType = schemeType;
		this.sponsorAgency = sponsorAgency;
		this.agencyName = agencyName;
		this.subsidyAmount = subsidyAmount;
		this.subsidyType = subsidyType;
		
		this.deviationROI=deviationROI;
		this.deviationFOIR=deviationFOIR;
		this.deviationLoanAmount=deviationLoanAmount;
		this.digiNMI=digiNMI;
		this.digiMaxEmi=digiMaxEmi;
		this.digiFOIR=digiFOIR;
		this.digiNMImultiplier=digiNMImultiplier;
		
		 this.loanFromBank=loanFromBank;
		  this.reasonShiftBank=reasonShiftBank;
		  this.loanAmntTransferBank=loanAmntTransferBank;
		  this.dateOfAvailing=dateOfAvailing;
		  this.installmentTrnsBank=installmentTrnsBank;
		  this.installmentStartDate=installmentStartDate;
		  this.installmentLastDate=installmentLastDate;
		  this.holidayperiod=holidayperiod;
		  this.repaymentPeriod=repaymentPeriod;
		  this.interestRateTakeOver=interestRateTakeOver;
		  this.totalLiability=totalLiability;
		  this.asOnDateLiability=asOnDateLiability;
		  this.noOfInstallmentPaid=noOfInstallmentPaid;
		  this.uptoDate=uptoDate;
		  this.regularLoanAcc=regularLoanAcc;
		  this.overdueAmount=overdueAmount;
		  this.asOnDateOvrdue=asOnDateOvrdue;
		  this.amountPaidTransfer=amountPaidTransfer;
		  this.opinionDetails=opinionDetails;
		  this.accountStatementFrom=accountStatementFrom;
		  this.accountStatementTo=accountStatementTo;
		  this.comments=comments;
		  this.takeOver=takeOver;
		  this.stallmentStipulated=stallmentStipulated;
		  this.digiAppNo=digiAppNo;
		  this.permissionRefNo=permissionRefNo;
		  this.repaymentType=repaymentType;
		  this.repaymentSchedule=repaymentSchedule;
		  this.scheme=scheme;
		  this.installmentPeriodicity=installmentPeriodicity;
		  this.productDesc=productDesc;
		  this.residualValue=residualValue;
		  this.productIdentification= productIdentification;
		  this.setGstyear1(gstyear1);
		  this.setGstyear1amnt(gstyear1amnt);
		  this.setGstyear2(gstyear2);
		  this.setGstyear2amnt(gstyear2);
		  this.commercialBureauScore= commercialBureauScore;
		  this.consumerIndScore= consumerIndScore;
		  this.consumerPartyScore= consumerPartyScore;
		  this.odAccountScore= odAccountScore;
		  this.currentAccountScore= currentAccountScore;
		  this.fsaScore= fsaScore;
		  this.bandRating= bandRating;
		  this.bandPath= bandPath;
		  this.kbRating= kbRating;
		  this.penalInterest= penalInterest;
		  this.setInterestConcession(interestConcession);
		  this.renewType = renewType;
		  this.renewProposalsNo = renewProposalsNo;
		  this.digiRating= digiRating;
		  this.setFindigitype(findigitype);
		  this.setFindigiyear(findigiyear);
		  this.ecsBankName = ecsBankName;
		  this.ecsAccountType = ecsAccountType;
		  this.ecsOperAccountType = ecsOperAccountType;
		  this.ecsAuthunenticateMode = ecsAuthunenticateMode;
		  this.ecsIFSCCODE = ecsIFSCCODE;
		  this.gstVerification = gstVerification;
		  this.upfrontfee = upfrontfee;
		  this.setGoldOrnaments(goldOrnaments);
		  this.setDocRecAgri(docRecAgri);
		  this.appraiserName=appraiserName;
		  this.appraiseon=appraiseon;
		  this.appraisercomments=appraisercomments;
		  this.appraisercbsid=appraisercbsid;
		  this.setAmrtOverrideLoanAmount(amrtOverrideLoanAmount);
		  this.setTermsAndCondition(termsAndCondition);
		  this.amrtOverride=amrtOverride;
		  this.bussinessId=bussinessId;
		  this.upfrontFeeCollected=upfrontFeeCollected;
		  this.maxEligibleEMI=maxEligibleEMI;
		  this.stpType=stpType;
		  this.token=token;
		  this.restime=restime;
		  this.setDepositdetails(depositdetails);
		  
		  this.inttype=inttype;
		  this.cfr_verified=cfr_verified;
		  this.CFR_borname=CFR_borname;
		  this.cersai_check=cersai_check;
		  this.DRAWING_PWR_IND=DRAWING_PWR_IND;
		  this.GLSUBHEADCODE=GLSUBHEADCODE;
		  this.GISTOFSECURITUES=GISTOFSECURITUES;
		  this.loanSecure=loanSecure;
		  this.SANCLEVEL=SANCLEVEL;
		  this.SANCAUTH=SANCAUTH;
		  this.repaymentterms=repaymentterms;
		  this.schemecode=schemecode;
		  this.sanctionedBy=sanctionedBy;
		  this.appriasedBy=appriasedBy;
		  this.flowdata=flowdata;
		  this.appraisaldepartment=appraisaldepartment;
		  
		  
		  
		  
}


	public String getLarNumber() {
		return larNumber;
	}
 

	public void setLarNumber(String larNumber) {
		this.larNumber = larNumber;
	}


	public String getCustomerID() {
		return customerID;
	}


	public void setCustomerID(String customerID) {
		this.customerID = customerID;
	}


	public String getLapsID() {
		return lapsID;
	}


	public void setLapsID(String lapsID) {
		this.lapsID = lapsID;
	}


	public String getLoanType() {
		return loanType;
	}


	public void setLoanType(String loanType) {
		this.loanType = loanType;
	}


	public String getAmountRequested() {
		return amountRequested;
	}


	public void setAmountRequested(String amountRequested) {
		this.amountRequested = amountRequested;
	}


	public String getSinglePremium() {
		return singlePremium;
	}


	public void setSinglePremium(String singlePremium) {
		this.singlePremium = singlePremium;
	}


	public String getProjectCost() {
		return projectCost;
	}


	public void setProjectCost(String projectCost) {
		this.projectCost = projectCost;
	}


	public String getLoanTenor() {
		return loanTenor;
	}


	public void setLoanTenor(String loanTenor) {
		this.loanTenor = loanTenor;
	}


	public String getHolidayPeriod() {
		return holidayPeriod;
	}


	public void setHolidayPeriod(String holidayPeriod) {
		this.holidayPeriod = holidayPeriod;
	}


	public String getLoanPurpose() {
		return loanPurpose;
	}


	public void setLoanPurpose(String loanPurpose) {
		this.loanPurpose = loanPurpose;
	}


	public String getApplicationBranch() {
		return applicationBranch;
	}


	public void setApplicationBranch(String applicationBranch) {
		this.applicationBranch = applicationBranch;
	}


	public String getInterestRate() {
		return interestRate;
	}


	public void setInterestRate(String interestRate) {
		this.interestRate = interestRate;
	}


	public String getEmiAmount() {
		return emiAmount;
	}


	public void setEmiAmount(String emiAmount) {
		this.emiAmount = emiAmount;
	}


	public String getMisActivityCode() {
		return misActivityCode;
	}


	public void setMisActivityCode(String misActivityCode) {
		this.misActivityCode = misActivityCode;
	}


	public String getProcessingFee() {
		return processingFee;
	}


	public void setProcessingFee(String processingFee) {
		this.processingFee = processingFee;
	}


	public String getProcesssingFeeCollected() {
		return processsingFeeCollected;
	}


	public void setProcesssingFeeCollected(String processsingFeeCollected) {
		this.processsingFeeCollected = processsingFeeCollected;
	}


	public List<DocumentsDetails> getDocumentDetails() {
		return documentDetails;
	}


	public void setDocumentDetails(List<DocumentsDetails> documentDetails) {
		this.documentDetails = documentDetails;
	}


	public List<CoApplicant> getCoApplicant() {
		return coApplicant;
	}


	public void setCoApplicant(List<CoApplicant> coApplicant) {
		this.coApplicant = coApplicant;
	}


	


	public String getMclrType() {
		return mclrType;
	}


	public void setMclrType(String mclrType) {
		this.mclrType = mclrType;
	}


	public String getPaymentMode() {
		return paymentMode;
	}


	public void setPaymentMode(String paymentMode) {
		this.paymentMode = paymentMode;
	}


	public String getDeviation() {
		return deviation;
	}


	public void setDeviation(String deviation) {
		this.deviation = deviation;
	}


	public String getApplicationScore() {
		return applicationScore;
	}


	public void setApplicationScore(String applicationScore) {
		this.applicationScore = applicationScore;
	}


	public List<DeviationDetails> getDeviationDetails() {
		return deviationDetails;
	}


	public void setDeviationDetails(List<DeviationDetails> deviationDetails) {
		this.deviationDetails = deviationDetails;
	}


	public String getAppScoreDeviation() {
		return appScoreDeviation;
	}


	public void setAppScoreDeviation(String appScoreDeviation) {
		this.appScoreDeviation = appScoreDeviation;
	}


	public String getSanctionStatus() {
		return sanctionStatus;
	}


	public void setSanctionStatus(String sanctionStatus) {
		this.sanctionStatus = sanctionStatus;
	}


	public String getCategoryLoanPurpose() {
		return categoryLoanPurpose;
	}


	public void setCategoryLoanPurpose(String categoryLoanPurpose) {
		this.categoryLoanPurpose = categoryLoanPurpose;
	}


	public String getPremisesAge() {
		return premisesAge;
	}


	public void setPremisesAge(String premisesAge) {
		this.premisesAge = premisesAge;
	}


	public List getSecurityId() {
		return securityId;
	}


	public void setSecurityId(List securityId) {
		this.securityId = securityId;
	}


	public String getOperativeAccountNo() {
		return operativeAccountNo;
	}


	public void setOperativeAccountNo(String operativeAccountNo) {
		this.operativeAccountNo = operativeAccountNo;
	}


	public String getTermAndCondition() {
		return termAndCondition;
	}

	public void setTermAndCondition(String termAndCondition) {
		this.termAndCondition = termAndCondition;
	}

	public String getCreditRiskPremium() {
		return creditRiskPremium;
	}


	public void setCreditRiskPremium(String creditRiskPremium) {
		this.creditRiskPremium = creditRiskPremium;
	}


	public String getBusinessStrategicPremium() {
		return businessStrategicPremium;
	}


	public void setBusinessStrategicPremium(String businessStrategicPremium) {
		this.businessStrategicPremium = businessStrategicPremium;
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


	public String getMargin() {
		return margin;
	}


	public void setMargin(String margin) {
		this.margin = margin;
	}


	public String getVehiclePurchase() {
		return vehiclePurchase;
	}


	public void setVehiclePurchase(String vehiclePurchase) {
		this.vehiclePurchase = vehiclePurchase;
	}


	public String getVehicleCost() {
		return vehicleCost;
	}


	public void setVehicleCost(String vehicleCost) {
		this.vehicleCost = vehicleCost;
	}


	public String getTax() {
		return tax;
	}


	public void setTax(String tax) {
		this.tax = tax;
	}


	public String getOtherCharges() {
		return otherCharges;
	}


	public void setOtherCharges(String otherCharges) {
		this.otherCharges = otherCharges;
	}


	public String getAccessoriesPrice() {
		return accessoriesPrice;
	}


	public void setAccessoriesPrice(String accessoriesPrice) {
		this.accessoriesPrice = accessoriesPrice;
	}


	public String getInsurance() {
		return insurance;
	}


	public void setInsurance(String insurance) {
		this.insurance = insurance;
	}


	public String getDiscount() {
		return discount;
	}


	public void setDiscount(String discount) {
		this.discount = discount;
	}


	public String getTotalCost() {
		return totalCost;
	}


	public void setTotalCost(String totalCost) {
		this.totalCost = totalCost;
	}


	public String getVerificationDoneBy() {
		return verificationDoneBy;
	}


	public void setVerificationDoneBy(String verificationDoneBy) {
		this.verificationDoneBy = verificationDoneBy;
	}


	public String getCostAlreadyIncurred() {
		return costAlreadyIncurred;
	}


	public void setCostAlreadyIncurred(String costAlreadyIncurred) {
		this.costAlreadyIncurred = costAlreadyIncurred;
	}


	public String getOwnSavingAndDisposalInvest() {
		return ownSavingAndDisposalInvest;
	}


	public void setOwnSavingAndDisposalInvest(String ownSavingAndDisposalInvest) {
		this.ownSavingAndDisposalInvest = ownSavingAndDisposalInvest;
	}


	public String getInterestCollected() {
		return interestCollected;
	}


	public void setInterestCollected(String interestCollected) {
		this.interestCollected = interestCollected;
	}


	public String getFuelUsed() {
		return fuelUsed;
	}


	public void setFuelUsed(String fuelUsed) {
		this.fuelUsed = fuelUsed;
	}


	public String getCustomerBackgroundComments() {
		return customerBackgroundComments;
	}


	public void setCustomerBackgroundComments(String customerBackgroundComments) {
		this.customerBackgroundComments = customerBackgroundComments;
	}


	public String getGovtSponserScheme() {
		return govtSponserScheme;
	}


	public void setGovtSponserScheme(String govtSponserScheme) {
		this.govtSponserScheme = govtSponserScheme;
	}


	public String getSchemeType() {
		return schemeType;
	}


	public void setSchemeType(String schemeType) {
		this.schemeType = schemeType;
	}


	public String getSponsorAgency() {
		return sponsorAgency;
	}


	public void setSponsorAgency(String sponsorAgency) {
		this.sponsorAgency = sponsorAgency;
	}


	public String getAgencyName() {
		return agencyName;
	}


	public void setAgencyName(String agencyName) {
		this.agencyName = agencyName;
	}


	public String getSubsidyAmount() {
		return subsidyAmount;
	}


	public void setSubsidyAmount(String subsidyAmount) {
		this.subsidyAmount = subsidyAmount;
	}


	public String getSubsidyType() {
		return subsidyType;
	}


	public void setSubsidyType(String subsidyType) {
		this.subsidyType = subsidyType;
	}


	public String getDeviationROI() {
		return deviationROI;
	}


	public void setDeviationROI(String deviationROI) {
		this.deviationROI = deviationROI;
	}


	public String getDeviationFOIR() {
		return deviationFOIR;
	}


	public void setDeviationFOIR(String deviationFOIR) {
		this.deviationFOIR = deviationFOIR;
	}


	public String getDeviationLoanAmount() {
		return deviationLoanAmount;
	}


	public void setDeviationLoanAmount(String deviationLoanAmount) {
		this.deviationLoanAmount = deviationLoanAmount;
	}


	public String getDigiNMI() {
		return digiNMI;
	}


	public void setDigiNMI(String digiNMI) {
		this.digiNMI = digiNMI;
	}


	public String getDigiMaxEmi() {
		return digiMaxEmi;
	}


	public void setDigiMaxEmi(String digiMaxEmi) {
		this.digiMaxEmi = digiMaxEmi;
	}


	public String getDigiFOIR() {
		return digiFOIR;
	}


	public void setDigiFOIR(String digiFOIR) {
		this.digiFOIR = digiFOIR;
	}


	public String getDigiNMImultiplier() {
		return digiNMImultiplier;
	}


	public void setDigiNMImultiplier(String digiNMImultiplier) {
		this.digiNMImultiplier = digiNMImultiplier;
	}


	public String getLoanFromBank() {
		return loanFromBank;
	}


	public void setLoanFromBank(String loanFromBank) {
		this.loanFromBank = loanFromBank;
	}


	public String getReasonShiftBank() {
		return reasonShiftBank;
	}


	public void setReasonShiftBank(String reasonShiftBank) {
		this.reasonShiftBank = reasonShiftBank;
	}


	public String getLoanAmntTransferBank() {
		return loanAmntTransferBank;
	}


	public void setLoanAmntTransferBank(String loanAmntTransferBank) {
		this.loanAmntTransferBank = loanAmntTransferBank;
	}


	public String getDateOfAvailing() {
		return dateOfAvailing;
	}


	public void setDateOfAvailing(String dateOfAvailing) {
		this.dateOfAvailing = dateOfAvailing;
	}


	public String getInstallmentTrnsBank() {
		return installmentTrnsBank;
	}


	public void setInstallmentTrnsBank(String installmentTrnsBank) {
		this.installmentTrnsBank = installmentTrnsBank;
	}


	public String getInstallmentStartDate() {
		return installmentStartDate;
	}


	public void setInstallmentStartDate(String installmentStartDate) {
		this.installmentStartDate = installmentStartDate;
	}


	public String getInstallmentLastDate() {
		return installmentLastDate;
	}


	public void setInstallmentLastDate(String installmentLastDate) {
		this.installmentLastDate = installmentLastDate;
	}


	public String getHolidayperiod() {
		return holidayperiod;
	}


	public void setHolidayperiod(String holidayperiod) {
		this.holidayperiod = holidayperiod;
	}


	public String getRepaymentPeriod() {
		return repaymentPeriod;
	}


	public void setRepaymentPeriod(String repaymentPeriod) {
		this.repaymentPeriod = repaymentPeriod;
	}


	public String getInterestRateTakeOver() {
		return interestRateTakeOver;
	}


	public void setInterestRateTakeOver(String interestRateTakeOver) {
		this.interestRateTakeOver = interestRateTakeOver;
	}


	public String getTotalLiability() {
		return totalLiability;
	}


	public void setTotalLiability(String totalLiability) {
		this.totalLiability = totalLiability;
	}


	public String getAsOnDateLiability() {
		return asOnDateLiability;
	}


	public void setAsOnDateLiability(String asOnDateLiability) {
		this.asOnDateLiability = asOnDateLiability;
	}


	public String getNoOfInstallmentPaid() {
		return noOfInstallmentPaid;
	}


	public void setNoOfInstallmentPaid(String noOfInstallmentPaid) {
		this.noOfInstallmentPaid = noOfInstallmentPaid;
	}


	public String getUptoDate() {
		return uptoDate;
	}


	public void setUptoDate(String uptoDate) {
		this.uptoDate = uptoDate;
	}


	public String getRegularLoanAcc() {
		return regularLoanAcc;
	}


	public void setRegularLoanAcc(String regularLoanAcc) {
		this.regularLoanAcc = regularLoanAcc;
	}


	public String getOverdueAmount() {
		return overdueAmount;
	}


	public void setOverdueAmount(String overdueAmount) {
		this.overdueAmount = overdueAmount;
	}


	public String getAsOnDateOvrdue() {
		return asOnDateOvrdue;
	}


	public void setAsOnDateOvrdue(String asOnDateOvrdue) {
		this.asOnDateOvrdue = asOnDateOvrdue;
	}


	public String getAmountPaidTransfer() {
		return amountPaidTransfer;
	}


	public void setAmountPaidTransfer(String amountPaidTransfer) {
		this.amountPaidTransfer = amountPaidTransfer;
	}


	public String getOpinionDetails() {
		return opinionDetails;
	}


	public void setOpinionDetails(String opinionDetails) {
		this.opinionDetails = opinionDetails;
	}



	public String getComments() {
		return comments;
	}


	public void setComments(String comments) {
		this.comments = comments;
	}


	public String getTakeOver() {
		return takeOver;
	}

	
	

	public String getAccountStatementFrom() {
		return accountStatementFrom;
	}


	public void setAccountStatementFrom(String accountStatementFrom) {
		this.accountStatementFrom = accountStatementFrom;
	}


	public String getAccountStatementTo() {
		return accountStatementTo;
	}


	public void setAccountStatementTo(String accountStatementTo) {
		this.accountStatementTo = accountStatementTo;
	}


	public void setTakeOver(String takeOver) {
		this.takeOver = takeOver;
	}


	public String getStallmentStipulated() {
		return stallmentStipulated;
	}


	public void setStallmentStipulated(String stallmentStipulated) {
		this.stallmentStipulated = stallmentStipulated;
	}


	public String getDigiAppNo() {
		return digiAppNo;
	}


	public void setDigiAppNo(String digiAppNo) {
		this.digiAppNo = digiAppNo;
	}


	public String getPermissionRefNo() {
		return permissionRefNo;
	}


	public void setPermissionRefNo(String permissionRefNo) {
		this.permissionRefNo = permissionRefNo;
	}


	public String getRepaymentType() {
		return repaymentType;
	}


	public void setRepaymentType(String repaymentType) {
		this.repaymentType = repaymentType;
	}


	public List<RepaymentSchedule> getRepaymentSchedule() {
		return repaymentSchedule;
	}


	public void setRepaymentSchedule(List<RepaymentSchedule> repaymentSchedule) {
		this.repaymentSchedule = repaymentSchedule;
	}


	public String getScheme() {
		return scheme;
	}


	public void setScheme(String scheme) {
		this.scheme = scheme;
	}


	public String getInstallmentPeriodicity() {
		return installmentPeriodicity;
	}


	public void setInstallmentPeriodicity(String installmentPeriodicity) {
		this.installmentPeriodicity = installmentPeriodicity;
	}


	public String getProductDesc() {
		return productDesc;
	}


	public void setProductDesc(String productDesc) {
		this.productDesc = productDesc;
	}


	public String getResidualValue() {
		return residualValue;
	}


	public void setResidualValue(String residualValue) {
		this.residualValue = residualValue;
	}

	public String getProductIdentification() {
		return productIdentification;
	}


	public void setProductIdentification(String productIdentification) {
		this.productIdentification = productIdentification;
	}


	public void setGstyear1(String gstyear1) {
		this.gstyear1 = gstyear1;
	}


	public String getGstyear1() {
		return gstyear1;
	}


	public void setGstyear1amnt(String gstyear1amnt) {
		this.gstyear1amnt = gstyear1amnt;
	}


	public String getGstyear1amnt() {
		return gstyear1amnt;
	}


	public void setGstyear2(String gstyear2) {
		this.gstyear2 = gstyear2;
	}


	public String getGstyear2() {
		return gstyear2;
	}


	public void setGstyear2amnt(String gstyear2amnt) {
		this.gstyear2amnt = gstyear2amnt;
	}


	public String getGstyear2amnt() {
		return gstyear2amnt;
	}


	public void setCommercialBureauScore(String commercialBureauScore) {
		this.commercialBureauScore = commercialBureauScore;
	}


	public String getCommercialBureauScore() {
		return commercialBureauScore;
	}


	public void setConsumerIndScore(String consumerIndScore) {
		this.consumerIndScore = consumerIndScore;
	}


	public String getConsumerIndScore() {
		return consumerIndScore;
	}


	public void setConsumerPartyScore(String consumerPartyScore) {
		this.consumerPartyScore = consumerPartyScore;
	}


	public String getConsumerPartyScore() {
		return consumerPartyScore;
	}


	public void setOdAccountScore(String odAccountScore) {
		this.odAccountScore = odAccountScore;
	}


	public String getOdAccountScore() {
		return odAccountScore;
	}


	public void setCurrentAccountScore(String currentAccountScore) {
		this.currentAccountScore = currentAccountScore;
	}


	public String getCurrentAccountScore() {
		return currentAccountScore;
	}


	public void setFsaScore(String fsaScore) {
		this.fsaScore = fsaScore;
	}


	public String getFsaScore() {
		return fsaScore;
	}


	public void setBandRating(String bandRating) {
		this.bandRating = bandRating;
	}


	public String getBandRating() {
		return bandRating;
	}


	public void setBandPath(String bandPath) {
		this.bandPath = bandPath;
	}


	public String getBandPath() {
		return bandPath;
	}


	public void setKbRating(String kbRating) {
		this.kbRating = kbRating;
	}


	public String getKbRating() {
		return kbRating;
	}


	public void setPenalInterest(String penalInterest) {
		this.penalInterest = penalInterest;
	}


	public String getPenalInterest() {
		return penalInterest;
	}


	public void setInterestConcession(String interestConcession) {
		this.interestConcession = interestConcession;
	}


	public String getInterestConcession() {
		return interestConcession;
	}


	public void setRenewType(String renewType) {
		this.renewType = renewType;
	}

	public String getRenewType() {
		return renewType;
	}


	public void setRenewProposalsNo(String renewProposalsNo) {
		this.renewProposalsNo = renewProposalsNo;
	}


	public String getRenewProposalsNo() {
		return renewProposalsNo;
	}
	
	public List<DigiRating> getDigiRating() {
		return digiRating;
	}

	public void setDigiRating(List<DigiRating> digiRating) {
		this.digiRating = digiRating;
	}


	public void setFindigitype(String findigitype) {
		this.findigitype = findigitype;
	}


	public String getFindigitype() {
		return findigitype;
	}


	public void setFindigiyear(String findigiyear) {
		this.findigiyear = findigiyear;
	}


	public String getFindigiyear() {
		return findigiyear;
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


	public void setGstVerification(String gstVerification) {
		this.gstVerification = gstVerification;
	}


	public String getGstVerification() {
		return gstVerification;
	}


	public void setUpfrontfee(String upfrontfee) {
		this.upfrontfee = upfrontfee;
	}


	public String getUpfrontfee() {
		return upfrontfee;
	}


	public void setGoldOrnaments(List<GoldOrnaments> goldOrnaments) {
		this.goldOrnaments = goldOrnaments;
	}


	public List<GoldOrnaments> getGoldOrnaments() {
		return goldOrnaments;
	}


	public void setDocRecAgri(String docRecAgri) {
		this.docRecAgri = docRecAgri;
	}


	public String getDocRecAgri() {
		return docRecAgri;
	}


	public void setAppraiserName(String appraiserName) {
		this.appraiserName = appraiserName;
	}


	public String getAppraiserName() {
		return appraiserName;
	}


	public void setAppraiseon(String appraiseon) {
		this.appraiseon = appraiseon;
	}


	public String getAppraiseon() {
		return appraiseon;
	}


	public void setAppraisercomments(String appraisercomments) {
		this.appraisercomments = appraisercomments;
	}


	public String getAppraisercomments() {
		return appraisercomments;
	}


	public void setAppraisercbsid(String appraisercbsid) {
		this.appraisercbsid = appraisercbsid;
	}


	public String getAppraisercbsid() {
		return appraisercbsid;
	}
	public void setAmrtOverrideLoanAmount(String amrtOverrideLoanAmount) {
		this.amrtOverrideLoanAmount = amrtOverrideLoanAmount;
	}


	public String getAmrtOverrideLoanAmount() {
		return amrtOverrideLoanAmount;
	}


	public void setTermsAndCondition(ArrayList termsAndCondition) {
		this.termsAndCondition = termsAndCondition;
	}


	public ArrayList getTermsAndCondition() {
		return termsAndCondition;
	}


	public void setAmrtOverride(String amrtOverride) {
		this.amrtOverride = amrtOverride;
	}


	public String getAmrtOverride() {
		return amrtOverride;
	}


	public void setBussinessId(String bussinessId) {
		this.bussinessId = bussinessId;
	}


	public String getBussinessId() {
		return bussinessId;
	}


	public void setUpfrontFeeCollected(String upfrontFeeCollected) {
		this.upfrontFeeCollected = upfrontFeeCollected;
	}


	public String getUpfrontFeeCollected() {
		return upfrontFeeCollected;
	}


	public void setMaxEligibleEMI(String maxEligibleEMI) {
		this.maxEligibleEMI = maxEligibleEMI;
	}


	public String getMaxEligibleEMI() {
		return maxEligibleEMI;
	}


	public void setStpType(String stpType) {
		this.stpType = stpType;
	}


	public String getStpType() {
		return stpType;
	}

	public List<DepositDetails> getDepositdetails() {
		return depositdetails;
	}


	public void setDepositdetails(List<DepositDetails> depositdetails) {
		this.depositdetails = depositdetails;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public String getRestime() {
		return restime;
	}

	public void setRestime(String restime) {
		this.restime = restime;
	}

//		shiva newly Added data
	
	public String getInttype() {
		return inttype;
	}


	public void setInttype(String inttype) {
		this.inttype = inttype;
	}


	public String getCfr_verified() {
		return cfr_verified;
	}


	public void setCfr_verified(String cfr_verified) {
		this.cfr_verified = cfr_verified;
	}


	public String getCFR_borname() {
		return CFR_borname;
	}


	public void setCFR_borname(String cFR_borname) {
		CFR_borname = cFR_borname;
	}


	public String getCersai_check() {
		return cersai_check;
	}


	public void setCersai_check(String cersai_check) {
		this.cersai_check = cersai_check;
	}


	public String getDRAWING_PWR_IND() {
		return DRAWING_PWR_IND;
	}


	public void setDRAWING_PWR_IND(String dRAWING_PWR_IND) {
		DRAWING_PWR_IND = dRAWING_PWR_IND;
	}


	public String getGLSUBHEADCODE() {
		return GLSUBHEADCODE;
	}


	public void setGLSUBHEADCODE(String gLSUBHEADCODE) {
		GLSUBHEADCODE = gLSUBHEADCODE;
	}


	public String getGISTOFSECURITUES() {
		return GISTOFSECURITUES;
	}


	public void setGISTOFSECURITUES(String gISTOFSECURITUES) {
		GISTOFSECURITUES = gISTOFSECURITUES;
	}


	public String getLoanSecure() {
		return loanSecure;
	}


	public void setLoanSecure(String loanSecure) {
		this.loanSecure = loanSecure;
	}


	public String getSANCLEVEL() {
		return SANCLEVEL;
	}


	public void setSANCLEVEL(String sANCLEVEL) {
		SANCLEVEL = sANCLEVEL;
	}


	public String getSANCAUTH() {
		return SANCAUTH;
	}


	public void setSANCAUTH(String sANCAUTH) {
		SANCAUTH = sANCAUTH;
	}


	public String getRepaymentterms() {
		return repaymentterms;
	}


	public void setRepaymentterms(String repaymentterms) {
		this.repaymentterms = repaymentterms;
	}


	public String getSchemecode() {
		return schemecode;
	}


	public void setSchemecode(String schemecode) {
		this.schemecode = schemecode;
	}


	public String getSanctionedBy() {
		return sanctionedBy;
	}


	public void setSanctionedBy(String sanctionedBy) {
		this.sanctionedBy = sanctionedBy;
	}


	public String getAppriasedBy() {
		return appriasedBy;
	}


	public void setAppriasedBy(String appriasedBy) {
		this.appriasedBy = appriasedBy;
	}


	public String getFlowdata() {
		return flowdata;
	}


	public void setFlowdata(String flowdata) {
		this.flowdata = flowdata;
	}


	public String getAppraisaldepartment() {
		return appraisaldepartment;
	}


	public void setAppraisaldepartment(String appraisaldepartment) {
		this.appraisaldepartment = appraisaldepartment;
	}

	
		
}
