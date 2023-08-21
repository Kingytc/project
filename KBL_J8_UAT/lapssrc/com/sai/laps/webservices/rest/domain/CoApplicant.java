package com.sai.laps.webservices.rest.domain;

public class CoApplicant {
	
	private String coapplicantName;
	private String coapplicantType;
	private String coapplicantLAPSID;
	private String coapplicantCBSID;
	private String coapplicantRelation;
	private String coaplicantIncome;
	private String coapplicantCBStype;
	private String coapplicantFacsno;
	
	
	public CoApplicant() {
		super();
		// TODO Auto-generated constructor stub
	}


	public CoApplicant(String coapplicantName, String coapplicantType,
			String coapplicantLAPSID, String coapplicantCBSID,
			String coapplicantRelation, String coaplicantIncome,String coapplicantCBStype,String coapplicantFacsno) {
		super();
		this.coapplicantName = coapplicantName;
		this.coapplicantType = coapplicantType;
		this.coapplicantLAPSID = coapplicantLAPSID;
		this.coapplicantCBSID = coapplicantCBSID;
		this.coapplicantRelation = coapplicantRelation;
		this.coaplicantIncome = coaplicantIncome;
		this.coapplicantCBStype=coapplicantCBStype;
		this.coapplicantFacsno=coapplicantFacsno;
	}


	public String getCoapplicantName() {
		return coapplicantName;
	}


	public void setCoapplicantName(String coapplicantName) {
		this.coapplicantName = coapplicantName;
	}


	public String getCoapplicantType() {
		return coapplicantType;
	}


	public void setCoapplicantType(String coapplicantType) {
		this.coapplicantType = coapplicantType;
	}


	public String getCoapplicantLAPSID() {
		return coapplicantLAPSID;
	}


	public void setCoapplicantLAPSID(String coapplicantLAPSID) {
		this.coapplicantLAPSID = coapplicantLAPSID;
	}


	public String getCoapplicantCBSID() {
		return coapplicantCBSID;
	}


	public void setCoapplicantCBSID(String coapplicantCBSID) {
		this.coapplicantCBSID = coapplicantCBSID;
	}


	public String getCoapplicantRelation() {
		return coapplicantRelation;
	}


	public void setCoapplicantRelation(String coapplicantRelation) {
		this.coapplicantRelation = coapplicantRelation;
	}


	public String getCoaplicantIncome() {
		return coaplicantIncome;
	}


	public void setCoaplicantIncome(String coaplicantIncome) {
		this.coaplicantIncome = coaplicantIncome;
	}


	public String getCoapplicantCBStype() {
		return coapplicantCBStype;
	}


	public void setCoapplicantCBStype(String coapplicantCBStype) {
		this.coapplicantCBStype = coapplicantCBStype;
	}


	public String getCoapplicantFacsno() {
		return coapplicantFacsno;
	}


	public void setCoapplicantFacsno(String coapplicantFacsno) {
		this.coapplicantFacsno = coapplicantFacsno;
	}
 
	
}
