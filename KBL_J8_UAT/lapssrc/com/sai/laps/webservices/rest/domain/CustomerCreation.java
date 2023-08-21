package com.sai.laps.webservices.rest.domain;

import java.util.List;

import com.sai.laps.webservices.rest.domain.msme.ExistingFacilityProposal;

public class CustomerCreation {
	
	
	private String cbsid;
	private String customerTitle;
	private String customerFullName;
	private String customerShortName;
	private String customerConstitution;
	private String customerDOB;
	private String customerPANNO;
	private String gender;
	private String maritalStatus;
	private String customerStatus;
	private String taxSlab;
	private String borrowerStatus;
	private String employmentType;
	private String bankingwithus;
	private String borrowerSince;
	private String satisfactoryDealing;
	private String staffRelation;
	private String introducerStatus;
	private String residentStatus;
	private String religion;
	private String caste;
	private String childDependent;
	private String otherDependent;
	private String earningMember;
	private String familyIncome;
	private String physicallyChallenged;
	private String blind;
	private String branchCode;
	
	private String addressLine1;
	private String addressLine2;
	private String city;
	private String district;
	private String state;
	private String country;
	private String pincode;
	private String yearsPresentAddress;
	private String residentType;
	
	private String occupation;
	private String proofType;
	private String idReference;
	private String riskCategory;
	private String residentProof;
	private String residentIdProof;
	private String natureActivity;
	private String residentIdDate;
	private String idProofExpDate;
	
	private String cibilReferred;
	private String cibilScore;
	private String cibilDetails;

	private String primaryIncome;
	private String grossIncome;
	private String incomeTaxDetail;
	private String incomeITR;
	private String docCollected;
	
	private String companyName;
	private String compAddress;
	private String compCity;
	private String compState;
	private String compPincode;
	private String compPhoneno;
	private String employeeID;
	private String experinceYears;
	private String dateJoining;
	private String retirementDate;
	private String confirmedEmployee;
	private String listedCompany;
	private String salaryReceiptDate;
	private String commencementDate;
	private String yearsCurrentActivity;
	
	private String addressChangeFlag;
	private String panFlag;
	private String fiAddressFlag;
	private String fiEmploymentFlag;
	private String fiBankStatementFlag;
	private String emandateEmiFlag;
	
	private String emanBankAccountNo;
	private String emanBankName;
	private String permanentaddressChangeFlag;
	private String fatherName;
	private String staffFlag;
	private String educationQualification;
	private String itrflag;
	private String businessProofFlag;
	private String officeAddFlag;

	private String mobileNumber;
	private String customerEmail;
	private String networthBorrower;
	private String proformaInvoice;
	private String ownResidenceProof;
	private List<ExistingFacilityProposal> existingFacility;
	
	private String incomeYearEnded;
	private String itrFillingDate;
	private String udyogAadharNumber;
	private String gstin;
	private String mseRegNumber;
	private String crifScore;
	private String crifDetails;
	private String crifReportedDate;
	private String spouseName;
	private String motherName;
	private List<LandHolding> landHolding;
	private String comAddressLine2;
	private String comAddressLine3;
	private String incomeYearEndPreviousYear;
	private String itrFillDatePreviousYear;
	private String itrSalaryPreviousYear;
	private String udyamRegistrationNumber;
	private String salesTurnOverApplicant;
	private String salesTurnOverDate;
	private String criteriaforSalesTurnover;
	private String udyamRegistrationClassification;
	private String udyamDate;
	private String cibilDate;
	
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
	
	
	public CustomerCreation() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CustomerCreation(String cbsid, String customerTitle,
			String customerFullName, String customerShortName,
			String customerConstitution, String customerDOB,
			String customerPANNO, String gender, String maritalStatus,
			String customerStatus, String taxSlab, String borrowerStatus,
			String employmentType, String bankingwithus, String borrowerSince,
			String satisfactoryDealing, String staffRelation,
			String introducerStatus, String residentStatus, String religion,
			String caste, String childDependent, String otherDependent,
			String earningMember, String familyIncome,
			String physicallyChallenged, String blind,String branchCode,String addressLine1, String addressLine2,
			String city, String district, String state, String country,
			String pincode, String yearsPresentAddress,String residentType,
			String occupation, String proofType,
			String idReference, String riskCategory, String residentProof,
			String residentIdProof, String natureActivity, String residentIdDate,String cibilReferred, String cibilScore,
			String cibilDetails, String primaryIncome, String grossIncome,
			String incomeTaxDetail, String incomeITR, String docCollected,
			String companyName, String compAddress,
			String compCity, String compState, String compPincode,
			String compPhoneno, String employeeID, String experinceYears,
			String dateJoining, String retirementDate,
			String confirmedEmployee, String listedCompany,
			String salaryReceiptDate, String commencementDate,
			String yearsCurrentActivity,String addressChangeFlag, String panFlag,
			String fiAddressFlag, String fiEmploymentFlag,
			String fiBankStatementFlag,String emandateEmiFlag,String emanBankAccountNo,String emanBankName,String permanentaddressChangeFlag,
			String fatherName, String staffFlag, String educationQualification,
			String itrflag,String businessProofFlag,String officeAddFlag,String mobileNumber,String customerEmail,String idProofExpDate,String networthBorrower,
			String proformaInvoice,String ownResidenceProof,List<ExistingFacilityProposal> existingFacility,String incomeYearEnded, String itrFillingDate,
			String udyogAadharNumber, String gstin, String mseRegNumber, String crifScore, String crifDetails, String crifReportedDate, String motherName, String spouseName,
			List<LandHolding> landHolding,String comAddressLine2, String comAddressLine3,String incomeYearEndPreviousYear, String itrFillDatePreviousYear,
			String itrSalaryPreviousYear,String udyamRegistrationNumber,String salesTurnOverApplicant,String salesTurnOverDate,String criteriaforSalesTurnover,String udyamRegistrationClassification,String udyamDate,String cibilDate,
			String token,String restime) {
		super();
		this.cbsid = cbsid;
		this.customerTitle = customerTitle;
		this.customerFullName = customerFullName;
		this.customerShortName = customerShortName;
		this.customerConstitution = customerConstitution;
		this.customerDOB = customerDOB;
		this.customerPANNO = customerPANNO;
		this.gender = gender;
		this.maritalStatus = maritalStatus;
		this.customerStatus = customerStatus;
		this.taxSlab = taxSlab;
		this.borrowerStatus = borrowerStatus;
		this.employmentType = employmentType;
		this.bankingwithus = bankingwithus;
		this.borrowerSince = borrowerSince;
		this.satisfactoryDealing = satisfactoryDealing;
		this.staffRelation = staffRelation;
		this.introducerStatus = introducerStatus;
		this.residentStatus = residentStatus;
		this.religion = religion;
		this.caste = caste;
		this.childDependent = childDependent;
		this.otherDependent = otherDependent;
		this.earningMember = earningMember;
		this.familyIncome = familyIncome;
		this.physicallyChallenged = physicallyChallenged;
		this.blind = blind;
		this.branchCode=branchCode;
		this.addressLine1 = addressLine1;
		this.addressLine2 = addressLine2;
		this.city = city;
		this.district = district;
		this.state = state;
		this.country = country;
		this.pincode = pincode;
		this.yearsPresentAddress = yearsPresentAddress;
		this.residentType=residentType;
		this.occupation = occupation;
		this.proofType = proofType;
		this.idReference = idReference;
		this.riskCategory = riskCategory;
		this.residentProof = residentProof;
		this.residentIdProof = residentIdProof;
		this.natureActivity = natureActivity;
		this.residentIdDate = residentIdDate;
		this.cibilReferred = cibilReferred;
		this.cibilScore = cibilScore;
		this.cibilDetails = cibilDetails;
		this.primaryIncome = primaryIncome;
		this.grossIncome = grossIncome;
		this.incomeTaxDetail = incomeTaxDetail;
		this.incomeITR = incomeITR;
		this.docCollected = docCollected;
		this.companyName = companyName;
		this.compAddress = compAddress;
		this.compCity = compCity;
		this.compState = compState;
		this.compPincode = compPincode;
		this.compPhoneno = compPhoneno;
		this.employeeID = employeeID;
		this.experinceYears = experinceYears;
		this.dateJoining = dateJoining;
		this.retirementDate = retirementDate;
		this.confirmedEmployee = confirmedEmployee;
		this.listedCompany = listedCompany;
		this.salaryReceiptDate = salaryReceiptDate;
		this.commencementDate = commencementDate;
		this.yearsCurrentActivity = yearsCurrentActivity;
		this.addressChangeFlag = addressChangeFlag;
		this.panFlag = panFlag;
		this.fiAddressFlag = fiAddressFlag;
		this.fiEmploymentFlag = fiEmploymentFlag;
		this.fiBankStatementFlag = fiBankStatementFlag;
		this.emandateEmiFlag=emandateEmiFlag;
		this.emanBankAccountNo=emanBankAccountNo;
		this.emanBankName=emanBankName;
		this.permanentaddressChangeFlag=permanentaddressChangeFlag;
		this.fatherName=fatherName;
		this.staffFlag=staffFlag;
		this.educationQualification=educationQualification;
		this.itrflag=itrflag;
		this.businessProofFlag=businessProofFlag;
		this.officeAddFlag=officeAddFlag;
		this.mobileNumber=mobileNumber;
		this.customerEmail=customerEmail;
		this.idProofExpDate=idProofExpDate;
		this.networthBorrower=networthBorrower;
		this.ownResidenceProof=ownResidenceProof;
		this.proformaInvoice=proformaInvoice;
		this.existingFacility=existingFacility;
		this.incomeYearEnded = incomeYearEnded;
		this.itrFillingDate = itrFillingDate;
		this.udyogAadharNumber = udyogAadharNumber;
		this.gstin = gstin;
		this.mseRegNumber = mseRegNumber;
		this.crifScore=crifScore;
		this.crifReportedDate=crifReportedDate;
		this.crifDetails=crifDetails;
		this.spouseName=spouseName;
		this.motherName=motherName;	
		this.landHolding=landHolding;
		this.comAddressLine2=comAddressLine2;
		this.comAddressLine3=comAddressLine3;
		this.incomeYearEndPreviousYear=incomeYearEndPreviousYear;
		this.itrFillDatePreviousYear=itrFillDatePreviousYear;
		this.itrSalaryPreviousYear=itrSalaryPreviousYear;
		this.udyamRegistrationNumber=udyamRegistrationNumber;
		this.salesTurnOverApplicant=salesTurnOverApplicant;
		this.salesTurnOverDate=salesTurnOverDate;
		this.criteriaforSalesTurnover=criteriaforSalesTurnover;
		this.udyamRegistrationClassification=udyamRegistrationClassification;
		this.udyamDate=udyamDate;
		this.token=token;
		this.restime=restime;
		this.setCibilDate(cibilDate);
		
	}
 	
	
	

	
	public List<LandHolding> getLandHolding() {
		return landHolding;
	}

	public void setLandHolding(List<LandHolding> landHolding) {
		this.landHolding = landHolding;
	}

	public String getSpouseName() {
		return spouseName;
	}

	public void setSpouseName(String spouseName) {
		this.spouseName = spouseName;
	}

	public String getMotherName() {
		return motherName;
	}

	public void setMotherName(String motherName) {
		this.motherName = motherName;
	}

	public String getAddressChangeFlag() {
		return addressChangeFlag;
	}

	public void setAddressChangeFlag(String addressChangeFlag) {
		this.addressChangeFlag = addressChangeFlag;
	}

	public String getPanFlag() {
		return panFlag;
	}

	public void setPanFlag(String panFlag) {
		this.panFlag = panFlag;
	}

	public String getFiAddressFlag() {
		return fiAddressFlag;
	}

	public void setFiAddressFlag(String fiAddressFlag) {
		this.fiAddressFlag = fiAddressFlag;
	}

	public String getFiEmploymentFlag() {
		return fiEmploymentFlag;
	}

	public void setFiEmploymentFlag(String fiEmploymentFlag) {
		this.fiEmploymentFlag = fiEmploymentFlag;
	}

	public String getFiBankStatementFlag() {
		return fiBankStatementFlag;
	}

	public void setFiBankStatementFlag(String fiBankStatementFlag) {
		this.fiBankStatementFlag = fiBankStatementFlag;
	}

	public String getCbsid() {
		return cbsid;
	}

	public void setCbsid(String cbsid) {
		this.cbsid = cbsid;
	}

	public String getCustomerTitle() {
		return customerTitle;
	}

	public void setCustomerTitle(String customerTitle) {
		this.customerTitle = customerTitle;
	}

	public String getCustomerFullName() {
		return customerFullName;
	}

	public void setCustomerFullName(String customerFullName) {
		this.customerFullName = customerFullName;
	}

	public String getCustomerShortName() {
		return customerShortName;
	}

	public void setCustomerShortName(String customerShortName) {
		this.customerShortName = customerShortName;
	}

	public String getCustomerConstitution() {
		return customerConstitution;
	}

	public void setCustomerConstitution(String customerConstitution) {
		this.customerConstitution = customerConstitution;
	}

	public String getCustomerDOB() {
		return customerDOB;
	}

	public void setCustomerDOB(String customerDOB) {
		this.customerDOB = customerDOB;
	}

	public String getCustomerPANNO() {
		return customerPANNO;
	}

	public void setCustomerPANNO(String customerPANNO) {
		this.customerPANNO = customerPANNO;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getMaritalStatus() {
		return maritalStatus;
	}

	public void setMaritalStatus(String maritalStatus) {
		this.maritalStatus = maritalStatus;
	}

	public String getCustomerStatus() {
		return customerStatus;
	}

	public void setCustomerStatus(String customerStatus) {
		this.customerStatus = customerStatus;
	}

	public String getTaxSlab() {
		return taxSlab;
	}

	public void setTaxSlab(String taxSlab) {
		this.taxSlab = taxSlab;
	}

	public String getBorrowerStatus() {
		return borrowerStatus;
	}

	public void setBorrowerStatus(String borrowerStatus) {
		this.borrowerStatus = borrowerStatus;
	}

	public String getEmploymentType() {
		return employmentType;
	}

	public void setEmploymentType(String employmentType) {
		this.employmentType = employmentType;
	}

	public String getBankingwithus() {
		return bankingwithus;
	}

	public void setBankingwithus(String bankingwithus) {
		this.bankingwithus = bankingwithus;
	}

	public String getBorrowerSince() {
		return borrowerSince;
	}

	public void setBorrowerSince(String borrowerSince) {
		this.borrowerSince = borrowerSince;
	}

	public String getSatisfactoryDealing() {
		return satisfactoryDealing;
	}

	public void setSatisfactoryDealing(String satisfactoryDealing) {
		this.satisfactoryDealing = satisfactoryDealing;
	}

	public String getStaffRelation() {
		return staffRelation;
	}

	public void setStaffRelation(String staffRelation) {
		this.staffRelation = staffRelation;
	}

	public String getIntroducerStatus() {
		return introducerStatus;
	}

	public void setIntroducerStatus(String introducerStatus) {
		this.introducerStatus = introducerStatus;
	}

	public String getResidentStatus() {
		return residentStatus;
	}

	public void setResidentStatus(String residentStatus) {
		this.residentStatus = residentStatus;
	}

	public String getReligion() {
		return religion;
	}

	public void setReligion(String religion) {
		this.religion = religion;
	}

	public String getCaste() {
		return caste;
	}

	public void setCaste(String caste) {
		this.caste = caste;
	}

	public String getChildDependent() {
		return childDependent;
	}

	public void setChildDependent(String childDependent) {
		this.childDependent = childDependent;
	}

	public String getOtherDependent() {
		return otherDependent;
	}

	public void setOtherDependent(String otherDependent) {
		this.otherDependent = otherDependent;
	}

	public String getEarningMember() {
		return earningMember;
	}

	public void setEarningMember(String earningMember) {
		this.earningMember = earningMember;
	}

	public String getFamilyIncome() {
		return familyIncome;
	}

	public void setFamilyIncome(String familyIncome) {
		this.familyIncome = familyIncome;
	}

	public String getPhysicallyChallenged() {
		return physicallyChallenged;
	}

	public void setPhysicallyChallenged(String physicallyChallenged) {
		this.physicallyChallenged = physicallyChallenged;
	}

	public String getBlind() {
		return blind;
	}

	public void setBlind(String blind) {
		this.blind = blind;
	}

	public String getBranchCode() {
		return branchCode;
	}

	public void setBranchCode(String branchCode) {
		this.branchCode = branchCode;
	}

	public String getAddressLine1() {
		return addressLine1;
	}

	public void setAddressLine1(String addressLine1) {
		this.addressLine1 = addressLine1;
	}

	public String getAddressLine2() {
		return addressLine2;
	}

	public void setAddressLine2(String addressLine2) {
		this.addressLine2 = addressLine2;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getPincode() {
		return pincode;
	}

	public void setPincode(String pincode) {
		this.pincode = pincode;
	}

	public String getYearsPresentAddress() {
		return yearsPresentAddress;
	}

	public void setYearsPresentAddress(String yearsPresentAddress) {
		this.yearsPresentAddress = yearsPresentAddress;
	}

	public String getResidentType() {
		return residentType;
	}

	public void setResidentType(String residentType) {
		this.residentType = residentType;
	}

	public String getOccupation() {
		return occupation;
	}

	public void setOccupation(String occupation) {
		this.occupation = occupation;
	}

	public String getProofType() {
		return proofType;
	}

	public void setProofType(String proofType) {
		this.proofType = proofType;
	}

	public String getIdReference() {
		return idReference;
	}

	public void setIdReference(String idReference) {
		this.idReference = idReference;
	}

	public String getRiskCategory() {
		return riskCategory;
	}

	public void setRiskCategory(String riskCategory) {
		this.riskCategory = riskCategory;
	}

	public String getResidentProof() {
		return residentProof;
	}

	public void setResidentProof(String residentProof) {
		this.residentProof = residentProof;
	}

	public String getResidentIdProof() {
		return residentIdProof;
	}

	public void setResidentIdProof(String residentIdProof) {
		this.residentIdProof = residentIdProof;
	}

	public String getNatureActivity() {
		return natureActivity;
	}

	public void setNatureActivity(String natureActivity) {
		this.natureActivity = natureActivity;
	}

	public String getResidentIdDate() {
		return residentIdDate;
	}

	public void setResidentIdDate(String residentIdDate) {
		this.residentIdDate = residentIdDate;
	}

	public String getCibilReferred() {
		return cibilReferred;
	}

	public void setCibilReferred(String cibilReferred) {
		this.cibilReferred = cibilReferred;
	}

	public String getCibilScore() {
		return cibilScore;
	}

	public void setCibilScore(String cibilScore) {
		this.cibilScore = cibilScore;
	}

	public String getCibilDetails() {
		return cibilDetails;
	}

	public void setCibilDetails(String cibilDetails) {
		this.cibilDetails = cibilDetails;
	}

	public String getPrimaryIncome() {
		return primaryIncome;
	}

	public void setPrimaryIncome(String primaryIncome) {
		this.primaryIncome = primaryIncome;
	}

	public String getGrossIncome() {
		return grossIncome;
	}

	public void setGrossIncome(String grossIncome) {
		this.grossIncome = grossIncome;
	}

	public String getIncomeTaxDetail() {
		return incomeTaxDetail;
	}

	public void setIncomeTaxDetail(String incomeTaxDetail) {
		this.incomeTaxDetail = incomeTaxDetail;
	}

	public String getIncomeITR() {
		return incomeITR;
	}

	public void setIncomeITR(String incomeITR) {
		this.incomeITR = incomeITR;
	}

	public String getDocCollected() {
		return docCollected;
	}

	public void setDocCollected(String docCollected) {
		this.docCollected = docCollected;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getCompAddress() {
		return compAddress;
	}

	public void setCompAddress(String compAddress) {
		this.compAddress = compAddress;
	}

	public String getCompCity() {
		return compCity;
	}

	public void setCompCity(String compCity) {
		this.compCity = compCity;
	}

	public String getCompState() {
		return compState;
	}

	public void setCompState(String compState) {
		this.compState = compState;
	}

	public String getCompPincode() {
		return compPincode;
	}

	public void setCompPincode(String compPincode) {
		this.compPincode = compPincode;
	}

	public String getCompPhoneno() {
		return compPhoneno;
	}

	public void setCompPhoneno(String compPhoneno) {
		this.compPhoneno = compPhoneno;
	}

	public String getEmployeeID() {
		return employeeID;
	}

	public void setEmployeeID(String employeeID) {
		this.employeeID = employeeID;
	}

	public String getExperinceYears() {
		return experinceYears;
	}

	public void setExperinceYears(String experinceYears) {
		this.experinceYears = experinceYears;
	}

	public String getDateJoining() {
		return dateJoining;
	}

	public void setDateJoining(String dateJoining) {
		this.dateJoining = dateJoining;
	}

	public String getRetirementDate() {
		return retirementDate;
	}

	public void setRetirementDate(String retirementDate) {
		this.retirementDate = retirementDate;
	}

	public String getConfirmedEmployee() {
		return confirmedEmployee;
	}

	public void setConfirmedEmployee(String confirmedEmployee) {
		this.confirmedEmployee = confirmedEmployee;
	}

	public String getListedCompany() {
		return listedCompany;
	}

	public void setListedCompany(String listedCompany) {
		this.listedCompany = listedCompany;
	}

	public String getSalaryReceiptDate() {
		return salaryReceiptDate;
	}

	public void setSalaryReceiptDate(String salaryReceiptDate) {
		this.salaryReceiptDate = salaryReceiptDate;
	}

	public String getCommencementDate() {
		return commencementDate;
	}

	public void setCommencementDate(String commencementDate) {
		this.commencementDate = commencementDate;
	}

	public String getYearsCurrentActivity() {
		return yearsCurrentActivity;
	}

	public void setYearsCurrentActivity(String yearsCurrentActivity) {
		this.yearsCurrentActivity = yearsCurrentActivity;
	}

	public String getEmandateEmiFlag() {
		return emandateEmiFlag;
	}

	public void setEmandateEmiFlag(String emandateEmiFlag) {
		this.emandateEmiFlag = emandateEmiFlag;
	}

	public String getEmanBankAccountNo() {
		return emanBankAccountNo;
	}

	public void setEmanBankAccountNo(String emanBankAccountNo) {
		this.emanBankAccountNo = emanBankAccountNo;
	}

	public String getEmanBankName() {
		return emanBankName;
	}

	public void setEmanBankName(String emanBankName) {
		this.emanBankName = emanBankName;
	}

	public String getPermanentaddressChangeFlag() {
		return permanentaddressChangeFlag;
	}

	public void setPermanentaddressChangeFlag(String permanentaddressChangeFlag) {
		this.permanentaddressChangeFlag = permanentaddressChangeFlag;
	}

	public String getFatherName() {
		return fatherName;
	}

	public void setFatherName(String fatherName) {
		this.fatherName = fatherName;
	}

	public String getStaffFlag() {
		return staffFlag;
	}

	public void setStaffFlag(String staffFlag) {
		this.staffFlag = staffFlag;
	}

	public String getEducationQualification() {
		return educationQualification;
	}

	public void setEducationQualification(String educationQualification) {
		this.educationQualification = educationQualification;
	}

	public String getItrflag() {
		return itrflag;
	}

	public void setItrflag(String itrflag) {
		this.itrflag = itrflag;
	}

	public String getBusinessProofFlag() {
		return businessProofFlag;
	}

	public void setBusinessProofFlag(String businessProofFlag) {
		this.businessProofFlag = businessProofFlag;
	}

	public String getOfficeAddFlag() {
		return officeAddFlag;
	}

	public void setOfficeAddFlag(String officeAddFlag) {
		this.officeAddFlag = officeAddFlag;
	}
			
	public String getMobileNumber() {
		return mobileNumber;
	}
	
	public void setMobileNumber(String mobileNumber) {
		this.mobileNumber = mobileNumber;
	}
	
	public String getCustomerEmail() {
		return customerEmail;
	}
	
	public void setCustomerEmail(String customerEmail) {
		this.customerEmail = customerEmail;
	}

	public String getIdProofExpDate() {
		return idProofExpDate;
	}

	public void setIdProofExpDate(String idProofExpDate) {
		this.idProofExpDate = idProofExpDate;
	}

	public String getNetworthBorrower() {
		return networthBorrower;
	}

	public void setNetworthBorrower(String networthBorrower) {
		this.networthBorrower = networthBorrower;
	}

	public String getProformaInvoice() {
		return proformaInvoice;
	}

	public void setProformaInvoice(String proformaInvoice) {
		this.proformaInvoice = proformaInvoice;
	}

	public String getOwnResidenceProof() {
		return ownResidenceProof;
	}

	public void setOwnResidenceProof(String ownResidenceProof) {
		this.ownResidenceProof = ownResidenceProof;
	}

	public List<ExistingFacilityProposal> getExistingFacility() {
		return existingFacility;
	}

	public void setExistingFacility(List<ExistingFacilityProposal> existingFacility) {
		this.existingFacility = existingFacility;
	}

	public String getIncomeYearEnded() {
		return incomeYearEnded;
	}

	public void setIncomeYearEnded(String incomeYearEnded) {
		this.incomeYearEnded = incomeYearEnded;
	}

	public String getItrFillingDate() {
		return itrFillingDate;
	}

	public void setItrFillingDate(String itrFillingDate) {
		this.itrFillingDate = itrFillingDate;
	}

	public String getUdyogAadharNumber() {
		return udyogAadharNumber;
	}

	public void setUdyogAadharNumber(String udyogAadharNumber) {
		this.udyogAadharNumber = udyogAadharNumber;
	}

	public String getGstin() {
		return gstin;
	}

	public void setGstin(String gstin) {
		this.gstin = gstin;
	}

	public String getMseRegNumber() {
		return mseRegNumber;
	}

	public void setMseRegNumber(String mseRegNumber) {
		this.mseRegNumber = mseRegNumber;
	}

	public String getCrifScore() {
		return crifScore;
	}

	public void setCrifScore(String crifScore) {
		this.crifScore = crifScore;
	}

	public String getCrifDetails() {
		return crifDetails;
	}

	public void setCrifDetails(String crifDetails) {
		this.crifDetails = crifDetails;
	}

	public String getCrifReportedDate() {
		return crifReportedDate;
	}

	public void setCrifReportedDate(String crifReportedDate) {
		this.crifReportedDate = crifReportedDate;
	}

	public String getComAddressLine2() {
		return comAddressLine2;
	}

	public void setComAddressLine2(String comAddressLine2) {
		this.comAddressLine2 = comAddressLine2;
	}

	public String getComAddressLine3() {
		return comAddressLine3;
	}

	public void setComAddressLine3(String comAddressLine3) {
		this.comAddressLine3 = comAddressLine3;
	}

	public String getIncomeYearEndPreviousYear() {
		return incomeYearEndPreviousYear;
	}

	public void setIncomeYearEndPreviousYear(String incomeYearEndPreviousYear) {
		this.incomeYearEndPreviousYear = incomeYearEndPreviousYear;
	}

	public String getItrFillDatePreviousYear() {
		return itrFillDatePreviousYear;
	}

	public void setItrFillDatePreviousYear(String itrFillDatePreviousYear) {
		this.itrFillDatePreviousYear = itrFillDatePreviousYear;
	}
	
	public String getItrSalaryPreviousYear() {
		return itrSalaryPreviousYear;
	}

	public void setItrSalaryPreviousYear(String itrSalaryPreviousYear) {
		this.itrSalaryPreviousYear = itrSalaryPreviousYear;
	}

	public void setUdyamRegistrationNumber(String udyamRegistrationNumber) {
		this.udyamRegistrationNumber = udyamRegistrationNumber;
	}

	public String getUdyamRegistrationNumber() {
		return udyamRegistrationNumber;
	}

	public void setSalesTurnOverApplicant(String salesTurnOverApplicant) {
		this.salesTurnOverApplicant = salesTurnOverApplicant;
	}

	public String getSalesTurnOverApplicant() {
		return salesTurnOverApplicant;
	}

	public void setSalesTurnOverDate(String salesTurnOverDate) {
		this.salesTurnOverDate = salesTurnOverDate;
	}

	public String getSalesTurnOverDate() {
		return salesTurnOverDate;
	}

	public void setCriteriaforSalesTurnover(String criteriaforSalesTurnover) {
		this.criteriaforSalesTurnover = criteriaforSalesTurnover;
	}

	public String getCriteriaforSalesTurnover() {
		return criteriaforSalesTurnover;
	}

	public void setUdyamRegistrationClassification(
			String udyamRegistrationClassification) {
		this.udyamRegistrationClassification = udyamRegistrationClassification;
	}

	public String getUdyamRegistrationClassification() {
		return udyamRegistrationClassification;
	}

	public void setUdyamDate(String udyamDate) {
		this.udyamDate = udyamDate;
	}

	public String getUdyamDate() {
		return udyamDate;
	}

	public void setCibilDate(String cibilDate) {
		this.cibilDate = cibilDate;
	}

	public String getCibilDate() {
		return cibilDate;
	}
	
	

}
