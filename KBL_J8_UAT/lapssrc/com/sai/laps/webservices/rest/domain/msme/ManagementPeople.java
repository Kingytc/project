package com.sai.laps.webservices.rest.domain.msme;

public class ManagementPeople {

	private String concernType;
	private String concernSubType;
	private String accOperatedBy;
	private String cutomerID;
	private String cbsCustomerId;
	private String concernName;
	private String address;

	private String city;
	private String state;
	private String phoneNo;
	private String district;

	private String pinCode;

	private String faxNo;
	

	private String chiefPromoter;

	private String documentExecutant;

	private String relationAmongThem;
	
	private String npaCategory;
	private String personalGuarantee;



	public ManagementPeople() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ManagementPeople(String concernType, String concernSubType, String accOperatedBy, String cutomerID,String cbsCustomerId,String concernName,String address,String city,String state,String phoneNo,String district,String pinCode,
			String faxNo,String chiefPromoter, String documentExecutant,String relationAmongThem,String npaCategory,String personalGuarantee) {
		
		this.accOperatedBy=accOperatedBy;
		this.address=address;
		this.concernType=concernType;
		this.concernSubType=concernSubType;
		this.cutomerID=cutomerID;
		this.cbsCustomerId=cbsCustomerId;
		this.concernName=concernName;
		this.address=address;
		this.city=city;
		this.state=state;
		this.phoneNo=phoneNo;
		this.district=district;
		this.pinCode=pinCode;
		this.faxNo=faxNo;
		this.chiefPromoter=chiefPromoter;
		this.documentExecutant=documentExecutant;
		this.relationAmongThem=relationAmongThem;
		this.npaCategory=npaCategory;
		this.personalGuarantee=personalGuarantee;
		
	}

	public String getConcernType() {
		return concernType;
	}

	public void setConcernType(String concernType) {
		this.concernType = concernType;
	}

	public String getConcernSubType() {
		return concernSubType;
	}

	public void setConcernSubType(String concernSubType) {
		this.concernSubType = concernSubType;
	}

	public String getAccOperatedBy() {
		return accOperatedBy;
	}

	public void setAccOperatedBy(String accOperatedBy) {
		this.accOperatedBy = accOperatedBy;
	}

	public String getCutomerID() {
		return cutomerID;
	}

	public void setCutomerID(String cutomerID) {
		this.cutomerID = cutomerID;
	}

	public String getCbsCustomerId() {
		return cbsCustomerId;
	}

	public void setCbsCustomerId(String cbsCustomerId) {
		this.cbsCustomerId = cbsCustomerId;
	}

	public String getConcernName() {
		return concernName;
	}

	public void setConcernName(String concernName) {
		this.concernName = concernName;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public String getPinCode() {
		return pinCode;
	}

	public void setPinCode(String pinCode) {
		this.pinCode = pinCode;
	}

	public String getFaxNo() {
		return faxNo;
	}

	public void setFaxNo(String faxNo) {
		this.faxNo = faxNo;
	}

	public String getChiefPromoter() {
		return chiefPromoter;
	}

	public void setChiefPromoter(String chiefPromoter) {
		this.chiefPromoter = chiefPromoter;
	}

	public String getDocumentExecutant() {
		return documentExecutant;
	}

	public void setDocumentExecutant(String documentExecutant) {
		this.documentExecutant = documentExecutant;
	}

	public String getRelationAmongThem() {
		return relationAmongThem;
	}

	public void setRelationAmongThem(String relationAmongThem) {
		this.relationAmongThem = relationAmongThem;
	}

	public void setNpaCategory(String npaCategory) {
		this.npaCategory = npaCategory;
	}

	public String getNpaCategory() {
		return npaCategory;
	}

	public void setPersonalGuarantee(String personalGuarantee) {
		this.personalGuarantee = personalGuarantee;
	}

	public String getPersonalGuarantee() {
		return personalGuarantee;
	}


	
	

}
