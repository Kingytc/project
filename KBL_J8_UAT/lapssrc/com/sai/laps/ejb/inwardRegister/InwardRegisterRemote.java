package com.sai.laps.ejb.inwardRegister;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface InwardRegisterRemote 
{
	public HashMap getdata(HashMap hshValues);
	public HashMap updatedata(HashMap hshValues);
	public HashMap  getInwardnoSearchList(HashMap hshValues);
	public HashMap getInwardnoList(HashMap hshValues);
	
	public HashMap checkBranchworks(HashMap hshValues);
	public HashMap ActionInward(HashMap hshValues);
	
	public void updatebrrecmdfacility(HashMap hshValues);
	public void updatebrrecmdsecurity(HashMap hshValues);
	public void updatebrrecmd(HashMap hshValues);
	public HashMap getbrrecmd(HashMap hshValues);
	public HashMap getbrrecmdfacility(HashMap hshValues);
	public HashMap getbrrecmdsecurity(HashMap hshValues);
	
	public HashMap getInwardremarks(HashMap hshValues);
	public void updateInwardremarks(HashMap hshValues);
	
	public HashMap getRecommendationPrint(HashMap hshValues);
	
	public void updateAccountOperationalDetails(HashMap hshValues);
	public HashMap getAccountOperationalDetails(HashMap hshValues);
	
	public void updateBusinessOperationsDetails(HashMap hshValues);
	public HashMap getBusinessOperationsDetails(HashMap hshValues);
	
	public void updateRecdComments(HashMap hshValues);
	public HashMap getRecdComments(HashMap hshValues);
	
	public HashMap getRenewalLimitsRecommendationPrint(HashMap hshValues);
	
	public HashMap getHistorydata(HashMap hshValues);
	public HashMap getInwardnoSearch (HashMap hshValues);
	
	public void updateCibilaccountInfo(HashMap hshValues);
	public HashMap getDateCibilaccountInfo (HashMap hshValues);
	
	public HashMap getCibilReportData(HashMap hshValues);
	public  HashMap getCBSIDHelp(HashMap hshValues);

	//Added by rajesh for OD/CC Limits on 02/12/2013
	public  HashMap getOdCcLimits(HashMap hshValues);
	public void updateOdCcLimits(HashMap hshValues);
	
	public void updateOtherDetails(HashMap hshValues);
	public HashMap getOthersDetails(HashMap hshValues);
	
	public HashMap getPackingCredit(HashMap hshValues);
	public void updatePackingCredit(HashMap hshValues);
	
	//Added by Guhan.T for Bills purchased details on 05/12/2013
	public  HashMap getBillsPurchasedDetails(HashMap hshValues);
	public void updateBillsPurchasedDetails(HashMap hshValues);
	
	public  HashMap getCBSapplHelp(HashMap hshValues);
	public  HashMap getCBSValidateData(HashMap hshValues);
	public HashMap updateUCICcustid(HashMap hshValues);
	public  HashMap getUCICcustid(HashMap hshValues);
	public  HashMap getInwardLeadnoCheck(HashMap hshValues);
	public  HashMap getmsmeproposal(HashMap hshValues);
	public HashMap getmsmeproposalSearch(HashMap hshValues)  ;
	public HashMap getmsmeproposalresult(HashMap hshValues)  ;
	public HashMap updatemsmeproposal(HashMap hshRequestValues);
    public HashMap getMsmeApproval(HashMap hshRequestValues);
	 public HashMap updateMsmeApproval(HashMap hshRequestValues);

	
}
