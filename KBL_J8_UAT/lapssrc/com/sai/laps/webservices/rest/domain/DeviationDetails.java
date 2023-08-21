package com.sai.laps.webservices.rest.domain;

import java.util.ArrayList;

public class DeviationDetails {
	
	
	private String applicantType;
	private String applicantLapsid;
	private String applicantcbsid;
	private String applicantCibil;
	private String applicantCibilComments;
	private String applicantIncome;
	private String applicantIncomeComments;
	private ArrayList amberRules;
	private String hunterScore;
	private String hunterRuleMatch;
	private String jocatamatch;
	private String thickScore;
	private String thinScore;
	private String cfrMatch;
	private String digiMaxEMI;

	public DeviationDetails() {
		super();
		// TODO Auto-generated constructor stub
	}

	public DeviationDetails(String applicantType, String applicantLapsid,
			String applicantcbsid, String applicantCibil,
			String applicantCibilComments, String applicantIncome,
			String applicantIncomeComments,ArrayList amberRules,String hunterScore,String hunterRuleMatch, String jocatamatch, String thickScore,String thinScore,String cfrMatch,String digiMaxEMI) {
		super();
		this.applicantType = applicantType;
		this.applicantLapsid = applicantLapsid;
		this.applicantcbsid = applicantcbsid;
		this.applicantCibil = applicantCibil;
		this.applicantCibilComments = applicantCibilComments;
		this.applicantIncome = applicantIncome;
		this.applicantIncomeComments = applicantIncomeComments;
		this.amberRules=amberRules;
		this.hunterScore = hunterScore;
		this.hunterRuleMatch=hunterRuleMatch;
		this.jocatamatch=jocatamatch;
		this.thickScore=thickScore;
		this.thinScore=thinScore;
		this.cfrMatch=cfrMatch;
		this.digiMaxEMI=digiMaxEMI;
		
	}
	

	public String getApplicantType() {
		return applicantType;
	}

	public void setApplicantType(String applicantType) {
		this.applicantType = applicantType;
	}

	public String getApplicantLapsid() {
		return applicantLapsid;
	}

	public void setApplicantLapsid(String applicantLapsid) {
		this.applicantLapsid = applicantLapsid;
	}

	public String getApplicantcbsid() {
		return applicantcbsid;
	}

	public void setApplicantcbsid(String applicantcbsid) {
		this.applicantcbsid = applicantcbsid;
	}

	public String getApplicantCibil() {
		return applicantCibil;
	}

	public void setApplicantCibil(String applicantCibil) {
		this.applicantCibil = applicantCibil;
	}

	public String getApplicantCibilComments() {
		return applicantCibilComments;
	}

	public void setApplicantCibilComments(String applicantCibilComments) {
		this.applicantCibilComments = applicantCibilComments;
	}

	public String getApplicantIncome() {
		return applicantIncome;
	}

	public void setApplicantIncome(String applicantIncome) {
		this.applicantIncome = applicantIncome;
	}

	public String getApplicantIncomeComments() {
		return applicantIncomeComments;
	}

	public void setApplicantIncomeComments(String applicantIncomeComments) {
		this.applicantIncomeComments = applicantIncomeComments;
	}

	public ArrayList getAmberRules() {
		return amberRules;
	}

	public void setAmberRules(ArrayList amberRules) {
		this.amberRules = amberRules;
	}

	public String getHunterScore() {
		return hunterScore;
	}

	public void setHunterScore(String hunterScore) {
		this.hunterScore = hunterScore;
	}

	public String getHunterRuleMatch() {
		return hunterRuleMatch;
	}

	public void setHunterRuleMatch(String hunterRuleMatch) {
		this.hunterRuleMatch = hunterRuleMatch;
	}

	public String getJocatamatch() {
		return jocatamatch;
	}

	public void setJocatamatch(String jocatamatch) {
		this.jocatamatch = jocatamatch;
	}

	public String getThickScore() {
		return thickScore;
	}

	public void setThickScore(String thickScore) {
		this.thickScore = thickScore;
	}

	public String getThinScore() {
		return thinScore;
	}

	public void setThinScore(String thinScore) {
		this.thinScore = thinScore;
	}

	public String getCfrMatch() {
		return cfrMatch;
	}

	public void setCfrMatch(String cfrMatch) {
		this.cfrMatch = cfrMatch;
	}
	
	public String getdigiMaxEMI() {
		return digiMaxEMI;
	}

	public void setdigiMaxEMI(String digiMaxEMI) {
		digiMaxEMI = digiMaxEMI;
	}
	
	
}
