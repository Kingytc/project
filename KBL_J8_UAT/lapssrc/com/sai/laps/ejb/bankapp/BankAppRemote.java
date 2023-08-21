package com.sai.laps.ejb.bankapp;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface BankAppRemote
{
	public void updateData(HashMap hshValues);
	public HashMap getData(HashMap hshValues);
	public void updateCostofData(HashMap hshValues);
	public  HashMap getCostofData(HashMap hshValues);
	public void updateTermLoanAssesment(HashMap hshValues);
	public  HashMap getTermLoanAssesment(HashMap hshValues);
	public void updateCopMofComments(HashMap hshValues);
	public  HashMap getCopMofComments(HashMap hshValues);
	public void updateSourceOfMargin(HashMap hshValues);
	public  HashMap getSourceOfMargin(HashMap hshValues);
	public void updateReleasePattern(HashMap hshValues);
	public  HashMap getReleasePattern(HashMap hshValues);
	public void updateOthers(HashMap hshValues);
	public  HashMap getOthers(HashMap hshValues);
	public void updateBankingdetailsData(HashMap hshValues);
	public HashMap getBankingdetailsData(HashMap hshValues);
	// Added by vinoth kumar for Brief Details of the Project page
	public void updateBreifDetailOfProject(HashMap hshValues);
	public HashMap getBreifDetailOfProject(HashMap hshValues);
	//added by Hemavathi for New Banking arrangement type
	public void UpdateBankingArrangement(HashMap hshValues);
	public HashMap getBankingArrangement(HashMap hshValues);
	
	public void UpdateMultipleBaking(HashMap hshValues);
	public HashMap getMultipleBanking(HashMap hshValues);
	
	public HashMap getConsortiumDetails(HashMap hshValues);
	public HashMap getPostSanctionParameters(HashMap hshValues);
	public void updatePostSanctionParameters(HashMap hshValues);
	public HashMap getLimitOfTLData(HashMap hshValues);
	public HashMap getLimitOfData(HashMap hshValues);
	
}