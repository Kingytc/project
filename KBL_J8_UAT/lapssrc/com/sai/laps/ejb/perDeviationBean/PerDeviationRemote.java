package com.sai.laps.ejb.perDeviationBean;

import java.rmi.RemoteException;
import java.util.HashMap;

import javax.ejb.EJBObject;
import javax.ejb.Remote;
@Remote
public interface PerDeviationRemote  {
	public HashMap getPermissionMaster (HashMap hshValues);
	public HashMap updatePermissionMaster(HashMap hshValues);
	public HashMap getPermissiontypeData(HashMap hshValues);
	public HashMap updatePermissionData(HashMap hshValues);
	public HashMap getPermissionData(HashMap hshValues);
	public HashMap getPermissionLetterData(HashMap hshValues);
	public HashMap updatePermissionParamData(HashMap hshValues);
	public void updatepermissionGistData(HashMap hshValues);
	public HashMap getPermissionGistData(HashMap hshValues);
	public HashMap getPermissionClassification(HashMap hshValues);
	public void updateAssessmentMaster(HashMap hshValues);
	public HashMap getAssessmentMaster(HashMap hshValues);
	public void updateAssessment(HashMap hshValues);
	public HashMap getAssessment(HashMap hshValues);
	public HashMap get_PermApplBackgroundData(HashMap hshValues);
	public HashMap update_PermApplBackgroundData(HashMap hshValues);
	public void updatePermDocument(HashMap hshValues);
	public HashMap getpermDocumentDetails(HashMap hshValues);
	public HashMap getpermBorrowerDetails(HashMap hshValues);
	public HashMap getPermDataFinal(HashMap hshValues);
	public void updateFinancial (HashMap hshValues);
	public HashMap getdataFinancial (HashMap hshValues);
	public void UpdateTerms(HashMap hshValues);
	public HashMap getTerms(HashMap hshValues);
	public HashMap getDeletedTerms(HashMap hshRequestValues);
	public void UndeleteTermsData(HashMap hshValues);
	public HashMap getAction(HashMap hshValues);
	public HashMap getHistory(HashMap hshValues);
	
	public HashMap getSancAuthority(HashMap hshValues);
	public void updateBasicInformation(HashMap hshValues);
	public HashMap getBasicInformation (HashMap hshValues);
	public void updateProposalflow(HashMap hshValues);
	public HashMap getProposalflow (HashMap hshValues);
	public HashMap getAnnexure (HashMap hshValues);
	public HashMap getExecutive (HashMap hshValues);
	public HashMap updatePayMaster(HashMap hshValues);
	public HashMap getPayMasterData(HashMap hshValues);
	public HashMap updateAction (HashMap hshValues);
	public HashMap getPmayClassification(HashMap hshValues);
	public HashMap updateRecommendations (HashMap hshValues);
	public HashMap getRecommendations (HashMap hshValues);
	public HashMap getPrintDetails (HashMap hshValues);

	public HashMap getPermissionGistMoreDet (HashMap hshValues);
	public HashMap getpermQueryDetails (HashMap hshValues);	
	public void updatePermissionGistMoreDet (HashMap hshValues);
}
