package com.sai.laps.ejb.commworkflow;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface CommWorkflowRemote 
{
	public HashMap updateAction(HashMap hshValues);
	public HashMap getAction(HashMap hshValues) ;
	
	public void updateDrawDownSchedule(HashMap hshValues);
	public HashMap getDrawDownSchedule(HashMap hshValues);
	
	public HashMap getHistory(HashMap hshValues);
	public HashMap getWorkflowUsers(HashMap hshValues) ;
	public void getSave(HashMap hshSaveValues) ;
	public HashMap getWorkUsers(HashMap hshValues) ;
	
	public HashMap getNPAAction(HashMap hshValues) ;
	public HashMap getNPAHistory(HashMap hshValues);
	public HashMap updateNPAAction(HashMap hshValues);
	public HashMap getTermsConditions(HashMap hshValues);
	
	public HashMap getMONAction(HashMap hshValues) ;
	public HashMap getMONHistory(HashMap hshValues);
	public HashMap updateMONAction(HashMap hshValues);
	
	//Added by Mercy for Term Loan Review
	public HashMap updateTermLoanReview(HashMap hshValues) ;
	public HashMap getTermLoanReview(HashMap hshValues);
	public void updateTLRStatus(HashMap hshSaveValues) ;
	
	//Added by Prashanth for Credit Process Audit
	
	public void updateCreditProcessAudit(HashMap hshSaveValues) ;
	public HashMap getCreditProcessAudit(HashMap hshValues) ;
	public void updateCreditMoragageDetails(HashMap hshSaveValues) ;
	public HashMap getCreditMoragageDetails(HashMap hshValues) ;
	
	
	public HashMap getTermLoanReviewHistory(HashMap hshValues) ;
	//public HashMap getTATHistory(HashMap hshValues) ;
	public void updateWorkFlowComments(HashMap hshSaveValues) ;
	public HashMap getWorkFlowComments(HashMap hshValues) ;
	
	public HashMap getTermsofSanctionFacilityData(HashMap hshValues) ;
	public void updateTermsofSanctionFacilityData(HashMap hshValues) ;
	
	//added by jaleel for legal compliance letter
	public HashMap getlegalComplianceData(HashMap hshValues) ;
	public void updateLegalComplianceData(HashMap hshValues);
	/*
	 * Added by prakash for generating Sanction Reference Number
	 */
	public String getSanctionRefernceNumber(HashMap hshValues) ;
	
	public HashMap getLoanAccountData(HashMap hshValues) ;
	public void updateLoanAccountData(HashMap hshValues) ;

	public HashMap getRestrFacilityDetails(HashMap hshValues) ;
	public void updRestrFacilityDetails(HashMap hshValues) ;
	
	public HashMap getFacilityDetailsData(HashMap hshValues) ;
	public void updFacilityDetailsData(HashMap hshValues) ;
	
	public HashMap getPostSanctionFacDetails(HashMap hshValues) ;

	public double getBorrowerMSMETotalLimit(String strAppId,String strValuesIn) ;
	public double getExposureTotalLimit(String strAppId,String strValuesIn,String strSessionModuleType) ;
	public double getExposureTotalLimitagri(String strAppId,String strValuesIn,String misactcode) ;
	
	public String getDocumentID(HashMap hshValues) ;
	public HashMap updateDigiSanctionDetails(HashMap hshValues) ;
	public HashMap manualloanAccountCreationService(HashMap hshValues) ;
	public HashMap msmeInPrinciple(HashMap hshValues) ;
	public HashMap setDecHistory(HashMap hshValues) ;
	public HashMap getAuditTrail_dec(HashMap hshValues) ;
	public void updsmsTrigger(HashMap hshValues);
	
	public HashMap checkLoanInterestModify(HashMap hshValues);
	public HashMap checkLoanInterestModifyWithoutenc(HashMap hshValues);
	public HashMap checkLoanInterestModifyhttpheader(HashMap hshValues);
	
	public HashMap getReadyForSAnctionUsingDBFunction(HashMap hshValues);

	

	
	public void updsmsforsecurity(HashMap hshValues);
	public HashMap checkLoanInterestModifyWithoutCerti(HashMap hshValues);
	public HashMap updateCGTMSE_txndet(HashMap hshValues) ;
	public HashMap getCGTMSE_txndet(HashMap hshValues);
	public void updatequerystatus(HashMap hshValues);
	

}
