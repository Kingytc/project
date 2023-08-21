package com.sai.laps.ejb.appraisal;
import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface appraisalRemote
{
	public HashMap getuserslist(HashMap hshValues);
	public void insertdates(HashMap hshValues);
	public void updateDataQuestParameters(HashMap hshValues);
	public HashMap updateDataQuest(HashMap hshValues);
	public HashMap getDataQuestParameters(HashMap hshValues);
	public HashMap getDataQuest(HashMap hshValues);
	public HashMap getloandetails(HashMap hshValues);
	public void updateAppraisalData(HashMap hshValues);
	public HashMap getAppraisalData(HashMap hshRequestValues);
	public HashMap getProductList(HashMap hshValues);	
	public HashMap getEMIData(HashMap hshValues);	
	public HashMap getEMIAGRIData(HashMap hshValues);
	public HashMap getfarmemiData(HashMap hshValues);
	public void updateEMIAGRIData(HashMap hshValues);
	public HashMap getPresanction(HashMap hshValues);
	public void updatePresanction(HashMap hshValues);
	public HashMap getUGCEligibility(HashMap hshValues);
	public void updateDepositROIData(String strAppno);
	public void updateDepositRepayPeriod(String strAppno, String strEmployment, String strAppstatus, String strDocRecvd);
	public void updateBIRData(HashMap hshValues);
	public HashMap getBIRData(HashMap hshValues);
	public void updateGSTDetails(HashMap hshValues);
	public HashMap getGSTDetails(HashMap hshValues);
	public void updateCreditSalesData(HashMap hshValues); 
	public HashMap getCreditSalesData(HashMap hshValues); 
	public void updateRestruceAssessment(HashMap hshValues); 
	public HashMap getRestruceAssessment(HashMap hshValues); 
	public HashMap getRestruceAnnexure(HashMap hshValues); 
}

