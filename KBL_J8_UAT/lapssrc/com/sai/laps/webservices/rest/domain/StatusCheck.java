package com.sai.laps.webservices.rest.domain;

import java.io.Serializable;

public class StatusCheck implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String lapsProposalNumber;
	private String appReferenceNumber;
	private String mclrtype	;
	private String userId;
	private String mobilebanking;
	
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
	
	public StatusCheck() {
		super();
	}
	public StatusCheck(String lapsProposalNumber, String appReferenceNumber, String mclrtype,String userId,String token,String restime,String mobilebanking) {
		super();
		this.lapsProposalNumber = lapsProposalNumber;
		this.appReferenceNumber = appReferenceNumber;
		this.mclrtype=mclrtype;
		this.userId=userId;
		this.token=token;
		this.restime=restime;
		this.mobilebanking=mobilebanking;
	}
	public String getLapsProposalNumber() {
		return lapsProposalNumber;
	}
	public void setLapsProposalNumber(String lapsProposalNumber) {
		this.lapsProposalNumber = lapsProposalNumber;
	}
	public String getAppReferenceNumber() {
		return appReferenceNumber;
	}
	public void setAppReferenceNumber(String appReferenceNumber) {
		this.appReferenceNumber = appReferenceNumber;
	}
	public String getMclrtype() {
		return mclrtype;
	}
	public void setMclrtype(String mclrtype) {
		this.mclrtype = mclrtype;
	}
	
	public String getMobilebanking() {
		return mobilebanking;
	}

	public void setMobilebanking(String mobilebanking) {
		this.mobilebanking = mobilebanking;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	

	
}
