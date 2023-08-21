package com.sai.laps.ejb.comssiaboveten;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface SSIAboveTenRemote 
{
	public HashMap getData(HashMap hshRequestValues);
	//public HashMap getApplicanBackgroundHelpData(HashMap hshRequestValues);
	//public HashMap getGuarantorHelpData(HashMap hshRequestValues);
	//changed by mercy for employment page
	public void updateProjectData(HashMap hshValues);
	public HashMap getProjectDetails(HashMap hshValues);
	public HashMap updateGeneralData(HashMap hshValues);
	public HashMap updateCostofProjectData(HashMap hshValues);
	public HashMap updateExportProductsData(HashMap hshValues);
	public HashMap updateStaffData(HashMap hshValues);
	public HashMap updateAnnexure2StructureData(HashMap hshValues);
	public HashMap updateAnnexure2BuildingProposedData(HashMap hshValues);
	public void updateAnnexure2MachineryData(HashMap hshValues);
	//by Mercy
	public HashMap getAnnexure2MachineryDetails(HashMap hshRequestValues);
	//public HashMap updateApplicantBackgroundData(HashMap hshValues);
	//public HashMap updateGuarantorData(HashMap hshValues);
	public void removeUtillitiesData(HashMap hshValues);
	//Link added by priya  for ssi_otherdetails
	//public HashMap getApplicantBakgroundDetails(HashMap hshRequestValues);
	public HashMap getotherdetailsData(HashMap hshValues);
	public void updateotherdetailsData(HashMap hshValues);
	// End added priya for ssi_otherdetails
	
	//Link added by S.SATHYA MOORTHY FOR ssi_other details.
	public HashMap getotherdetailsData1(HashMap hshValues);
	public HashMap updateotherdetails1(HashMap hshValues);
	
	//by Gokulakrishnan.C
	public HashMap getAllVehicleDetails(HashMap hshValues);
	public void updateVehicleDetails(HashMap hshValues);
	
	//by prashanth for subsidy
	public void updataSubsidy(HashMap hsh);
	public HashMap getDataSubsidy(HashMap hsh);
	
	//by mercy for tertiary accountdetails
	public void updateAccountDetails(HashMap hsh);
	public HashMap getAccountDetails(HashMap hsh);
} 