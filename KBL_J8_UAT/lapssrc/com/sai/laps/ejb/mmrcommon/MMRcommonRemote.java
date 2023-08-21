package com.sai.laps.ejb.mmrcommon;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface MMRcommonRemote 
{
	public void updateBookdebitsvalue(HashMap hshValues);
	public HashMap getBookdebitsvalue(HashMap hshValues);
	
	public void updatemsodestimate(HashMap hshValues);
	public HashMap getmsodestimate(HashMap hshValues);
	
	public void updateBookdebitseligible(HashMap hshValues);
	public HashMap getBookdebitseligible(HashMap hshValues);

	public void updateConsortium(HashMap hshValues);
	public HashMap getConsortium(HashMap hshValues);
	
	public void updateInspectionReport(HashMap hshValues);
	public HashMap getInspectionReport(HashMap hshValues);

	public void updateStockeligible(HashMap hshValues);
	public HashMap getstockeligible(HashMap hshValues);
	
	public void updatehedgeddetails(HashMap hshValues);
    public HashMap gethedgeddetails(HashMap hshValues);
	
	public void updateMonitoringInfo(HashMap hshValues);
	public HashMap getMonitoringInfo(HashMap hshValues);
	
	public void updateMonitoringInformation(HashMap hshValues);
	public HashMap getMonitoringInformation(HashMap hshValues);
	
	
	public void updatemonmsodBorrowing(HashMap hshValues);
	public HashMap getmonmsodBorrowing(HashMap hshValues);
	
	public void updatemonConsortiumMeeting(HashMap hshValues);
	public HashMap getmonConsortiumMeeting(HashMap hshValues);
	
	public void updateDataInsurancecovered(HashMap hshValues);
	public HashMap getDataInsurancecovered(HashMap hshValues);
	
	public void updateRecoveredStatement(HashMap hshValues);
	public HashMap getRecoveredStatement(HashMap hshValues);
	
	public void updateCurrentAssetfinanced(HashMap hshValues);
	public HashMap getCurrentAssetfinanced(HashMap hshValues);
	
	public void updateQprPerformance(HashMap hshValues);
	public HashMap getQprPerformance(HashMap hshValues);
	
	public void updateworkingcapitalfunds(HashMap hshValues);
	public HashMap getworkingcapitalfunds(HashMap hshValues);
	
	public void updateMMRFacility(HashMap hshValues);
	public HashMap getMMRFacility(HashMap hshValues);
	
	public void updateinventory(HashMap hshValues);
	public HashMap getinventory(HashMap hshValues);
	
	public HashMap getBorrowerinfo(HashMap hshValues);
	public void updateBorrowerinfo(HashMap hshValues);
	
	public HashMap updateAccountwise(HashMap hshValues);
	public HashMap getAccountwise(HashMap hshValues);
	
	public void updateGeneralInfo(HashMap hshValues);
	public HashMap getGeneralInfo(HashMap hshValues);
	
	public HashMap getstockReport(HashMap hshValues);

	public HashMap getBookprint(HashMap hshValues);
	
	public HashMap getDPexcludingPC(HashMap hshValues);
	
	public HashMap getMonfacility(HashMap hshValues);
	
	public HashMap getMMRSearch(HashMap hshValues);
	
	
	public HashMap getMMRReportPrint(HashMap hshValues);
	
	
	public void updateReasonsExcessData(HashMap hshValues);
	public HashMap getReasonsExcessData(HashMap hshValues);
	
	public void updateAnnexureFacility(HashMap hshValues);
	public HashMap getAnnexureFacility  (HashMap hshValues);
	
	public HashMap getMMRReportApril2012Print(HashMap hshValues);
	

}