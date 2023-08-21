package com.sai.laps.ejb.ComProposal;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface ComProposalRemote 
{

	public HashMap getData(HashMap hshRequestValues);
	public void updateCompany(HashMap hsh);
	public void updateActivity(HashMap hsh);
	
	public HashMap getDataOper(HashMap hsh);
	public  void updateOper(HashMap hsh);
	
	public HashMap getDataComment(HashMap hsh);
	public void updateGeneralComment(HashMap hsh);
	
	public void updatetakeoverterm(HashMap hsh);
	public HashMap gettakeoverterm(HashMap hsh);
	
	public void updatetakeoverworking(HashMap hsh);
	public HashMap gettakeoverworking(HashMap hsh);
	
	public void updatetakeover(HashMap hsh);
	public HashMap gettakeover(HashMap hsh);
	
	public void updateCashBudget(HashMap hsh);
	public HashMap getCashBudget(HashMap hsh);
	
	public void updatempbf(HashMap hsh);
	public HashMap getmpbf(HashMap hsh);
	
	public HashMap getRiskAnalysis(HashMap hshValues);

	public void updateAssessmentType(HashMap hshValues);
	public  HashMap getAssessmentType(HashMap hshValues);
	
	public HashMap getAuditorComments(HashMap hsh);
	public void updateAuditorObser(HashMap hsh);
	
	public HashMap getBreakUpofNoncurrent(HashMap hsh);
	public void updateBreakUpofNoncurrent(HashMap hsh);
	
	public HashMap getBankingDetails(HashMap hsh);
	public void updateBankingDetails(HashMap hsh);
	
	public HashMap getourBankcreditDetails(HashMap hsh);
	public void updateourBankcreditDetails(HashMap hsh);
	
	public void updturnoverMethod(HashMap hshValues);
	public HashMap getturnoverMethod(HashMap hshValues);
	
	public void updexpenditureMethod(HashMap hshValues);
	public HashMap getexpenditureMethod(HashMap hshValues);
	
	public void updateCashFlow (HashMap hshValues);
	public HashMap getCashFlow(HashMap hshValues);
	public HashMap getFinYear(HashMap hshRequestValues);
	
	public HashMap getFarmBudget(HashMap hshRequestValues);
	
	public HashMap getCropLoan(HashMap hshRequestValues);
	
	public HashMap getDSS(HashMap hshRequestValues);
	public void updateDSS(HashMap hshValues);
	
	public HashMap getInlandAssessment(HashMap hshRequestValues);
	public void updInlandAssessment(HashMap hshValues);
	
	public HashMap getDataComments(HashMap hshRequestValues);
	public void updateDataComments(HashMap hshValues);
	
	public HashMap getExposureIndustry(HashMap hshRequestValues);
	public void updateExposureIndustry(HashMap hshValues);
	public HashMap updateCropLoan(HashMap hshValues);
	
	public void updateFinGroupComments(HashMap hshValues);
	public HashMap getFinGroupComments(HashMap hshValues);
	
	public void updateBGassessment(HashMap hshValues);
	public HashMap getBGassessment(HashMap hshValues);
	
	public HashMap getSancAuthority(HashMap hshValues);
	
	public void updateRBIGuidelines_restr(HashMap hsh);
	public HashMap getRBIGuidelines_restr(HashMap hsh);
	
	
	public void updateRestructuringAss(HashMap hsh);
	public HashMap getRestructuringAss(HashMap hsh);
	public HashMap getSancBranches(HashMap hsh);
	
	public void updateCgssdAssessment(HashMap hshValues);
	public HashMap getCgssdAssessment(HashMap hshValues);
	
}


//public void updateFacility(HashMap hsh);
//public void deleteFacility(HashMap hsh);
//public void updatePromoter(HashMap hsh);
//public HashMap getDataTerms(HashMap hsh);
//public void updateTerm(HashMap hsh);
//public void updateBusiness(HashMap hsh);
//public HashMap getDataBusiness(HashMap hsh);
//public  HashMap getSecurityCharges(HashMap hshValues);
//public HashMap PrintData(HashMap hshRequestValues);
//public void updateTermloan(HashMap hshValues);
//public  HashMap getTermloan(HashMap hshValues);
//public void updateTermloandpg(HashMap hshValues);
//public  HashMap getTermloandpg(HashMap hshValues);
//public HashMap getDataConfirm(HashMap hsh);
//public void updateConfirm(HashMap hsh);
//public HashMap getDataProcess(HashMap hsh);
//public void updateProcess(HashMap hsh);
//public HashMap getDataAuditorComment(HashMap hsh);
//public void updateAuditorComment(HashMap hsh);
//public HashMap getDataMarketing(HashMap hsh);
//public void updateMarketing(HashMap hsh);
//public HashMap getDataMarketUtil(HashMap hsh);
//public void updateMgmt(HashMap hsh);
//public HashMap getDataMgmt(HashMap hsh);
//public void updateYield(HashMap hsh);
//public HashMap getDataYield(HashMap hsh);
//public HashMap getDemandSupplyData(HashMap hshRequestValues);
//public HashMap UpdateDemandSupplyData(HashMap hshRequestValues);
//public  HashMap getSanctionData(HashMap hshValues);