package com.sai.laps.ejb.adhoc;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface adhocRemote 
{	
	
	public HashMap getDataFinal(HashMap hshValues);
	
	public HashMap getFacilityData(HashMap hshValues);
	public HashMap updateFacilityData(HashMap hshValues);
	
	public void updateSecurityData(HashMap hshValues);
	public HashMap getSecurityData(HashMap hshValues);
	
	public void updateBankingDetails(HashMap hshValues);
	public HashMap getBankingDetails(HashMap hshValues);
	
	public void updateFinancial(HashMap hshValues);
	public HashMap getFinancial(HashMap hshValues);
	
	public void updateGuaranteeData(HashMap hshValues);
	public HashMap getGuaranteeData(HashMap hshValues);
	
	public void updateRecommendations(HashMap hshValues);
	public HashMap getRecommendations(HashMap hshValues);
	
	public void updatetermscond(HashMap hshValues);
	public HashMap gettermscond(HashMap hshValues);
	
	public void updateComments(HashMap hshValues);
	public HashMap getComments(HashMap hshValues);
	
	public void updateLimitSought(HashMap hshValues);
	public HashMap getLimitSought(HashMap hshValues);
	
	public HashMap getPrintAdhocProposal(HashMap hshValues);
	
	public HashMap getADCHistory(HashMap hshValues);
	public HashMap getADCAction(HashMap hshValues);
	public HashMap updateADCAction(HashMap hshValues);
	public HashMap getADCMailcomments(HashMap hshValues);
	public void updateADCMailcomments(HashMap hshValues);
	public HashMap getADCApprovalprint(HashMap hshValues);
	
}