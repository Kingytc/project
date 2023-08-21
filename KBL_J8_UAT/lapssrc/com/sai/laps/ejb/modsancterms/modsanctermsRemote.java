package com.sai.laps.ejb.modsancterms;

import java.rmi.RemoteException;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.EJBObject;
import javax.ejb.Remote;

@Remote
public interface modsanctermsRemote 
{
	public HashMap getDataFinal(HashMap hshValues);
	
	public void updateSecuritesData(HashMap hshValues);
	public HashMap getSecuritesData(HashMap hshValues);
	
	public void updateModsoughtData(HashMap hshValues);
	public HashMap getModsoughtData(HashMap hshValues);
	
	public void updateValueofAccountData(HashMap hshValues);
	public HashMap getValueofAccountData(HashMap hshValues);
	
	public void updateRemarksData(HashMap hshValues);
	public HashMap getRemarksData(HashMap hshValues);
	
	public void updateRecommendationData(HashMap hshValues);
	public HashMap getRecommendationData(HashMap hshValues);
	
	public void updatefacilityData(HashMap hshValues);
	public HashMap getfacilityData(HashMap hshValues);
	
	//public void updateFacSecurityData(HashMap hshValues);
	//public HashMap getFacSecurityData(HashMap hshValues);
	
	public void updateMstLimitMasterData(HashMap hshValues);
	public HashMap getMstLimitMasterData(HashMap hshValues);
	
	public void updateMstWorkflowMasterData(HashMap hshValues);
	public HashMap getMstWorkflowMasterData(HashMap hshValues);
	
	public HashMap getMSTHistory(HashMap hshValues);
	public HashMap getMSTAction(HashMap hshValues);
	public HashMap updateMSTAction(HashMap hshValues);
	
	public void updateMSTMailcomments(HashMap hshValues);
	public HashMap getMSTMailcomments(HashMap hshValues);
	
	public HashMap getMSTApprovalprint(HashMap hshValues);
	
	public HashMap getFinancialData(HashMap hshRequestValues);
	public void updateFinancial(HashMap hshValues);
	
	//public HashMap getFacilityName(HashMap hshValues);
}