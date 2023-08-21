package com.sai.laps.ejb.setproducts;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface SetProductsRemote 
{
	public HashMap updateData(HashMap hshValues);
	public HashMap getData(HashMap hshRequestValues);
	public HashMap getCatgList(HashMap hshRequestValues);
	public String checkProductSaveStatus(HashMap hshValues);
	public void updateProductSaveStatus(HashMap hshValues);
	public HashMap getAuthorityData(HashMap hshRequestValues);
	public void updateAuthorityData(HashMap hshValues);
	public HashMap getDocList(HashMap hshValues);
	public HashMap getDocData(HashMap hshRequestValues);
	public void updateDocData(HashMap hshRequestValues);
	public HashMap getWorkflowList(HashMap hshRequestValues);
	public HashMap getWorkflowData(HashMap hshRequestValues);
	public void updateWorkflowData(HashMap hshRequestValues);
	public HashMap getLimitCode(HashMap hshRequestValues);
	public HashMap interestTerm(HashMap hshRequestValues);
	public HashMap getDataHelp(HashMap hsh);
	public void renewProduct(HashMap hshRequestValues);
	public void deleteTerms(HashMap hshValues);
	public void updateStaffLoan(HashMap hshRequestValues);
	public HashMap getStaffloan(HashMap hshValues);
	public HashMap getWorkflowNPA(HashMap hshRequestValues); 
	public void updateNPAWorkflowData(HashMap hshRequestValues);
	public void updateNPADelegatePower(HashMap hshRequestValues);
	public HashMap getNPADelegatePower(HashMap hshRequestValues);
	public HashMap updateNPAAuthority(HashMap hshValues);
	public HashMap getNPAAuthority(HashMap hshValues);
	
	public HashMap getWorkflowmonitoring(HashMap hshRequestValues); 
	public void updateMONWorkflowData(HashMap hshRequestValues);
	
	public HashMap updateMONAuthority(HashMap hshValues);
	public HashMap getMONAuthority(HashMap hshValues);
	public HashMap getWorkflowBST(HashMap hshRequestValues); 
	public void updateWorkflowBST(HashMap hshRequestValues);
	public void copyProduct(HashMap hshValues);
	
	public void updateOnlineRepayCapacity(HashMap hshValues);
	public HashMap getSchemeCodeData(HashMap hshValues);
	
	/* Added By Karthikeyan.S for Activity Code in Products on 28/09/2013*/
	public HashMap getPrdAcitivityCodeData(HashMap hshValues);
	public void updatePrdAcitivityCodeData(HashMap hshValues);
	public HashMap corpinterestTerm(HashMap hsh);
	public void deletecorpTerms(HashMap hshValues);
	public HashMap getCorporateRatings(HashMap hsh);
	public HashMap getratingBasedROI(HashMap hshValues); 
	public void setratingBasedROI(HashMap hshValues);
	public HashMap getSchemesubheadCodeData(HashMap hshValues);
	public void updateSolKpowerData(HashMap hshRequestValues)
	; 
	public HashMap getSolKpowerData(HashMap hshValues); 
	public HashMap getRepaymentTypeData(HashMap hshValues);
	public HashMap getnewSancLimit(HashMap hshValues);
	public void updatenewSancLimit(HashMap hshValues);
	public HashMap getPerratingBasedROI(HashMap hshValues); 
	public void UpdatePerratingBasedROI(HashMap hshValues);
	public HashMap getOtherinterestTerm(HashMap hshValues);
	public HashMap getOtherinterestTypes(HashMap hshValues);
	public HashMap getCorpOtherinterestTerm(HashMap hshValues);
	
	public HashMap getSetTermsandConditions(HashMap hshValues);
	public void updateSetTermsandConditions(HashMap hshValues);
}
