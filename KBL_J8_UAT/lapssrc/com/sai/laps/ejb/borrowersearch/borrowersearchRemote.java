package com.sai.laps.ejb.borrowersearch;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface borrowersearchRemote 
{
	public HashMap getData(HashMap hshRequestValues);
	public HashMap getDataFinal(HashMap hshRequestValues);
	public HashMap getRenewalData(HashMap hshRequestValues);
	public HashMap getBorrowerDetails(HashMap hshRequestValues);
	public HashMap getDataHelp(HashMap hsh);
	//public HashMap getagrBorrowerDetails(HashMap hshRequestValues);
	//public HashMap getNPABorrowerDetails(HashMap hshRequestValues);
	public HashMap getNPABorrower(HashMap hshRequestValues);
	public HashMap getMonitoringBorrower(HashMap hshRequestValues);
	public HashMap getMonitoringData(HashMap hshRequestValues);
	public HashMap getNPADataFinal(HashMap hshValues);
	public HashMap getTermLoanReviewData(HashMap hshValues);
	public HashMap getNPAAccountSearchData(HashMap hshValues);
	public HashMap getNPAAccountDetails(HashMap hshValues);
	public void updateNPAAccountDetails(HashMap hshValues);
	public void updateNPAprovisioning(HashMap hshValues);
	public HashMap getNPAProvisioning(HashMap hshValues);
	public HashMap getNPAAccountVerifySearchData(HashMap hshValues);
	public void updateNPAVERFAccountDetails(HashMap hshValues);
	public HashMap getNPAverfAccountDetails(HashMap hshValues);
	public HashMap getExecMOCDetails(HashMap hshValues);
	
}
