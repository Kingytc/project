package com.sai.laps.webservices.rest.domain;

public class InwardDetails {
	
	
	private static final long serialVersionUID = 1L;
	private String firstName;
	private String dob;
	private String applicationdate;
	private String customerType;
	private String cbsid;
	private String custAddress1;
	private String custAddress2;
	private String custCity;
	private String custState;
	private String custDistrict;
	private String custZip;
	private String custPhone;
	private String custMobile;
	private String custEmail;
	private String panno;
	private String loanPurpose;
	private String loanAmount;
	private String documentReceived;
	private String addlDocumentRecDate;
	private String inwardStatus;
	private String rejectionReason;
	private String leadNumber;
	private String branchSOLID;
	private String inwardAction;
	private String addressChangeFlag;
	private String larNumber;
	private String bankScheme;
	private String applProcessLoc;
	private String schemeDesc;
	private String digiAppNo;
	private String leadGeneratedId;
	private String leadStaffId;
	private String leadConvertedBy;
	
	private String govtSponserScheme;
	private String schemeType;
	private String sponsorAgency;
	private String agencyName;
	private String subsidyAmount;
	private String subsidyType;
	private String loanType;
	
	private String token;
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

	private String restime;
	public InwardDetails() {
		super();
		// TODO Auto-generated constructor stub
	}

	public InwardDetails(String firstName, String dob, String applicationdate,
			String customerType, String cbsid, String custAddress1,
			String custAddress2, String custCity, String custState,
			String custDistrict, String custZip, String custPhone,
			String custMobile, String custEmail, String panno,
			String loanPurpose, String loanAmount, String documentReceived,
			String addlDocumentRecDate, String inwardStatus,
			String rejectionReason, String leadNumber, String branchSOLID,
			String inwardAction, String addressChangeFlag,String larNumber,String bankScheme,String applProcessLoc,String schemeDesc,String digiAppNo,String leadGeneratedId,String leadStaffId,String leadConvertedBy,
			String govtSponserScheme, String schemeType,String sponsorAgency, String agencyName, String subsidyAmount,String subsidyType,String loanType,String token,String restime) 
	{
		super();
		this.firstName = firstName;
		this.dob = dob;
		this.applicationdate = applicationdate;
		this.customerType = customerType;
		this.cbsid = cbsid;
		this.custAddress1 = custAddress1;
		this.custAddress2 = custAddress2;
		this.custCity = custCity;
		this.custState = custState;
		this.custDistrict = custDistrict;
		this.custZip = custZip;
		this.custPhone = custPhone;
		this.custMobile = custMobile;
		this.custEmail = custEmail;
		this.panno = panno;
		this.loanPurpose = loanPurpose;
		this.loanAmount = loanAmount;
		this.documentReceived = documentReceived;
		this.addlDocumentRecDate = addlDocumentRecDate;
		this.inwardStatus = inwardStatus;
		this.rejectionReason = rejectionReason;
		this.leadNumber = leadNumber;
		this.branchSOLID = branchSOLID;
		this.inwardAction = inwardAction;
		this.addressChangeFlag = addressChangeFlag;
		this.bankScheme=bankScheme;
		this.applProcessLoc=applProcessLoc;
		this.schemeDesc=schemeDesc;
		this.digiAppNo=digiAppNo;
		this.leadGeneratedId=leadGeneratedId;
		this.leadStaffId=leadStaffId;
		this.leadConvertedBy=leadConvertedBy;
		this.govtSponserScheme = govtSponserScheme;
		this.schemeType = schemeType;
		this.sponsorAgency = sponsorAgency;
		this.agencyName = agencyName;
		this.subsidyAmount = subsidyAmount;
		this.subsidyType = subsidyType;
		this.loanType = loanType;
		this.token=token;
		this.restime=restime;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getDob() {
		return dob;
	}

	public void setDob(String dob) {
		this.dob = dob;
	}

	public String getApplicationdate() {
		return applicationdate;
	}

	public void setApplicationdate(String applicationdate) {
		this.applicationdate = applicationdate;
	}

	public String getCustomerType() {
		return customerType;
	}

	public void setCustomerType(String customerType) {
		this.customerType = customerType;
	}

	public String getCbsid() {
		return cbsid;
	}

	public void setCbsid(String cbsid) {
		this.cbsid = cbsid;
	}

	public String getCustAddress1() {
		return custAddress1;
	}

	public void setCustAddress1(String custAddress1) {
		this.custAddress1 = custAddress1;
	}

	public String getCustAddress2() {
		return custAddress2;
	}

	public void setCustAddress2(String custAddress2) {
		this.custAddress2 = custAddress2;
	}

	public String getCustCity() {
		return custCity;
	}

	public void setCustCity(String custCity) {
		this.custCity = custCity;
	}

	public String getCustState() {
		return custState;
	}

	public void setCustState(String custState) {
		this.custState = custState;
	}

	public String getCustDistrict() {
		return custDistrict;
	}

	public void setCustDistrict(String custDistrict) {
		this.custDistrict = custDistrict;
	}

	public String getCustZip() {
		return custZip;
	}

	public void setCustZip(String custZip) {
		this.custZip = custZip;
	}

	public String getCustPhone() {
		return custPhone;
	}

	public void setCustPhone(String custPhone) {
		this.custPhone = custPhone;
	}

	public String getCustMobile() {
		return custMobile;
	}

	public void setCustMobile(String custMobile) {
		this.custMobile = custMobile;
	}

	public String getCustEmail() {
		return custEmail;
	}

	public void setCustEmail(String custEmail) {
		this.custEmail = custEmail;
	}

	public String getPanno() {
		return panno;
	}

	public void setPanno(String panno) {
		this.panno = panno;
	}

	public String getLoanPurpose() {
		return loanPurpose;
	}

	public void setLoanPurpose(String loanPurpose) {
		this.loanPurpose = loanPurpose;
	}

	public String getLoanAmount() {
		return loanAmount;
	}

	public void setLoanAmount(String loanAmount) {
		this.loanAmount = loanAmount;
	}

	public String getDocumentReceived() {
		return documentReceived;
	}

	public void setDocumentReceived(String documentReceived) {
		this.documentReceived = documentReceived;
	}

	public String getAddlDocumentRecDate() {
		return addlDocumentRecDate;
	}

	public void setAddlDocumentRecDate(String addlDocumentRecDate) {
		this.addlDocumentRecDate = addlDocumentRecDate;
	}

	public String getInwardStatus() {
		return inwardStatus;
	}

	public void setInwardStatus(String inwardStatus) {
		this.inwardStatus = inwardStatus;
	}

	public String getRejectionReason() {
		return rejectionReason;
	}

	public void setRejectionReason(String rejectionReason) {
		this.rejectionReason = rejectionReason;
	}

	public String getLeadNumber() {
		return leadNumber;
	}

	public void setLeadNumber(String leadNumber) {
		this.leadNumber = leadNumber;
	}

	public String getBranchSOLID() {
		return branchSOLID;
	}

	public void setBranchSOLID(String branchSOLID) {
		this.branchSOLID = branchSOLID;
	}

	public String getInwardAction() {
		return inwardAction;
	}

	public void setInwardAction(String inwardAction) {
		this.inwardAction = inwardAction;
	}

	public String getAddressChangeFlag() {
		return addressChangeFlag;
	}

	public void setAddressChangeFlag(String addressChangeFlag) {
		this.addressChangeFlag = addressChangeFlag;
	}

	public String getLarNumber() {
		return larNumber;
	}

	public void setLarNumber(String larNumber) {
		this.larNumber = larNumber;
	}

	public String getBankScheme() {
		return bankScheme;
	}

	public void setBankScheme(String bankScheme) {
		this.bankScheme = bankScheme;
	}

	public String getApplProcessLoc() {
		return applProcessLoc;
	}

	public void setApplProcessLoc(String applProcessLoc) {
		this.applProcessLoc = applProcessLoc;
	}

	public String getSchemeDesc() {
		return schemeDesc;
	}

	public void setSchemeDesc(String schemeDesc) {
		this.schemeDesc = schemeDesc;
	}

	public String getDigiAppNo() {
		return digiAppNo;
	}

	public void setDigiAppNo(String digiAppNo) {
		this.digiAppNo = digiAppNo;
	}

	public String getLeadGeneratedId() {
		return leadGeneratedId;
	}

	public void setLeadGeneratedId(String leadGeneratedId) {
		this.leadGeneratedId = leadGeneratedId;
	}

	public String getLeadStaffId() {
		return leadStaffId;
	}

	public void setLeadStaffId(String leadStaffId) {
		this.leadStaffId = leadStaffId;
	}

	public String getLeadConvertedBy() {
		return leadConvertedBy;
	}

	public void setLeadConvertedBy(String leadConvertedBy) {
		this.leadConvertedBy = leadConvertedBy;
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

	public void setLoanType(String loanType) {
		this.loanType = loanType;
	}

	public String getLoanType() {
		return loanType;
	}

	
	
	
	
	
	
	
	
	
	
	
}
