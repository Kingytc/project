package com.sai.laps.ejb.reviewtermloantwo;

import java.rmi.RemoteException;
import java.util.HashMap;
import javax.ejb.EJBObject;
import javax.ejb.Remote;
@Remote
public interface ReviewTermLoanTwoRemote  
{
	public HashMap updateTypeReviewTermLoan(HashMap hshRequestValues);
	public HashMap getTypeReviewTermLoan(HashMap hshRequestValues);
	public void updateReviewTermLoanYear(HashMap hshRequestValues);
	public HashMap getTermLoanReviewFacilities(HashMap hshRequestValues);
	public void updateTermLoanReviewFacilities(HashMap hshRequestValues);
	public HashMap getBirefBackgroundData(HashMap hshRequestValues);
	public void updateBriefBackgroundData(HashMap hshRequestValues);	
	public HashMap getPresentStatusData(HashMap hshRequestValues);
	public void updatePresentStatusData(HashMap hshRequestValues);	
	public HashMap getOthersData(HashMap hshRequestValues);
	public void updateOthersData(HashMap hshRequestValues);	
	
	public HashMap getTLAccountData(HashMap hshRequestValues);
	public void updateTLAccountData(HashMap hshRequestValues);	
	public HashMap getCDAccountData(HashMap hshRequestValues);
	public void updateCDAccountData(HashMap hshRequestValues);	
	public HashMap getProposalData(HashMap hshRequestValues);
	public void updateProposalData(HashMap hshRequestValues);	
	public HashMap getComplianceData(HashMap hshRequestValues);
	public void updateComplianceData(HashMap hshRequestValues);	
	public HashMap getTermAndConditionsData(HashMap hshRequestValues);
	public void updateTermAndConditionsData(HashMap hshRequestValues);	
	public HashMap getBankingArrangementData(HashMap hshRequestValues);
	public void updateBankingArrangementData(HashMap hshRequestValues);	
	
	public HashMap getInternalRatingData(HashMap hshRequestValues);
	public void updateInternalRatingData(HashMap hshRequestValues);	
}

