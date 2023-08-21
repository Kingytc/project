package com.sai.laps.ejb.reviewtermloan;

import java.rmi.RemoteException;
import java.util.HashMap;

import javax.ejb.EJBObject;
import javax.ejb.Remote;

@Remote
public interface ReviewTermLoanRemote  
{
	
	public HashMap updateTypeReviewTermLoan(HashMap hshRequestValues);
	
	public void updateReviewFinancial(HashMap hshRequestValues);
	public HashMap getReviewFinancial(HashMap hshRequestValues);
	
	public void updateReviewCorpCompany(HashMap hshRequestValues);
	public HashMap getReviewCorpCompany(HashMap hshRequestValues);
	public void updateReviewTermLoanYear(HashMap hshRequestValues);
	public HashMap getTypeReviewTermLoan(HashMap hshRequestValues);
	public HashMap getTLReviewCorporatePrint(HashMap hshValues);
	public HashMap getTLReviewSMEPrint(HashMap hshRequestValues);
	public HashMap getTLReviewRetailPrint(HashMap hshRequestValues);

	public HashMap getReviewYear(HashMap hshRequestValues);
	public HashMap getReviewYearAndStatus(HashMap hshRequestValues);
	
	public void updateAuditorObservationData(HashMap hshRequestValues);
	public HashMap getAuditorObservationData(HashMap hshRequestValues);
	public void updateSecuritiesData(HashMap hshRequestValues);
	public HashMap getSecuritiesData(HashMap hshRequestValues);
	public void updatePromotersData(HashMap hshRequestValues);
	public HashMap getPromotersData(HashMap hshRequestValues);
	public void updateGroupConcernData(HashMap hshRequestValues);
	public HashMap getGroupConcernData(HashMap hshRequestValues);
	
	
	
}
