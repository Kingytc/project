package com.sai.laps.ejb.facilities;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface FacilitiesRemote 
{
	public HashMap updateData(HashMap hshValues);
	public HashMap updateOPSData(HashMap hshValues);
	public HashMap getFacilityData(HashMap hshValues);
	public HashMap getOPSFacilityData(HashMap hshValues);
	
	//DONE BY PAUL
	
	public void updateFreezeData(HashMap hshValues);	
	public HashMap getFreezeData(HashMap hshValues);	
	
	public HashMap getFinancialtype(HashMap hshValues);
	public HashMap updateFinancialtype(HashMap hshValues);
	
	public void updateCompanyData(HashMap hsh);
	
	public void updateComments(HashMap hshValues);	
	public HashMap getComments(HashMap hshValues);	

//	kamal Added
	//public void updateAppSecurityAttach(HashMap hsh);
	//public HashMap getAppSecurityAttach(HashMap hsh);
//	kamal Added 11/07/09
	
	public HashMap getFacilityInterest(HashMap hshValues);
	
	public HashMap getSetupFacility(HashMap hshValues);
	
	public HashMap getApplicationSearchDetails(HashMap hshValues);
	
	public void deleteAgricultureTabDetails(HashMap hsh);
	
	public HashMap getCommentsonInterestRate(HashMap hshValues);
	
	public void updateCommentsonInterestRate(HashMap hsh);
	public void UpdateRoiBasedOnrating(HashMap hshValues);
	
	public HashMap getApplicationRenew(HashMap hshValues);
	
	public HashMap getRenewedFacility(HashMap hshValues);
	public HashMap getPostSanctiondata(HashMap hshValues);
	public HashMap getPSOldSanctionedData(HashMap hshValues);
	
	public void updateMISCBSDetails(HashMap hsh);
	public HashMap updateUnusedAccounts(HashMap hsh);
	
	public HashMap getLoadAdhocFacilities(HashMap hshValues);
	
	public HashMap getClosureFacilities(HashMap hshValues);
	public void UpdateClosureFacilities(HashMap hshValues);
	
	public HashMap getFacilityMCLRDetails(HashMap hshValues);
	public void UpdateFacilityMCLRDetails(HashMap hshValues);
	
	public HashMap getSHGmembershare(HashMap hshValues);
	public void updateSHGmembershare(HashMap hshValues);
	
	public HashMap getMCLRSpreadValue(HashMap hshValues);
	
	public HashMap getCheckListValue(HashMap hshValues);
	 public void updateCheckListValue(HashMap hshValues);
	 
	 
	 public HashMap getStatMasterValues(HashMap hshValues);
	 
	 public HashMap getInterestType(HashMap hshValues);
	 public HashMap getFacilityArrangement(HashMap hshValues);
	 public void UpdateFacilityArrangement(HashMap hshValues);
	 public HashMap msmeRoiUpdateServices(HashMap hshValues);
	 public HashMap chkMCLRTable(HashMap hshValues);
	 public HashMap getagr_eNWR(HashMap hshRequestValues);
	 public void updateagreNWR(HashMap hshValues);
	 public HashMap getvalid_eNWRDOI(HashMap hshValues);

}