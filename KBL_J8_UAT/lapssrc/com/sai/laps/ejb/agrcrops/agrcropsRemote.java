package com.sai.laps.ejb.agrcrops;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface agrcropsRemote 
{
	public void updatePreviousseasonData(HashMap hshValues);
	public HashMap getPreviousseasonData(HashMap hshValues);
	public void updatePlantationData(HashMap hshValues);
	public HashMap getPlantationData(HashMap hshValues);
	public HashMap updateCapitalData(HashMap hshValues);
	public HashMap getCapitalData(HashMap hshValues);
	public HashMap updateAssesmentData(HashMap hshValues);
	public HashMap getAssesmentData(HashMap hshValues);
	public HashMap updateConsumptionData(HashMap hshValues);
	public HashMap getConsumptionData(HashMap hshValues);
	public HashMap updateLivestockData(HashMap hshValues);
	public HashMap getLivestockData(HashMap hshValues);
	public HashMap updateMachineryData(HashMap hshValues);
	public HashMap getMachineryData(HashMap hshValues);
	public HashMap updateShagriData(HashMap hshValues);
	public HashMap getShagriData(HashMap hshValues);
	public HashMap getBoatNetData(HashMap hshValues);	
	public void updateBoatNetData(HashMap hshValues);
	public HashMap getDataLiveStock(HashMap hshValues);
	public void updateLiveStock(HashMap hshValues);
	public HashMap getEconomicsDetails(HashMap hshValues);	
	public void updateEconomicsDetails(HashMap hshValues);
	public HashMap getFinancemasterData(HashMap hshValues);
	public HashMap updateInspectedEstateData(HashMap hshValues);
	public HashMap getInspectedEstateData(HashMap hshValues);
	public HashMap updateYearCostData(HashMap hshValues);
	public HashMap getYearCostData(HashMap hshValues);
	public void updateEconomicAspects(HashMap hshValues);
	public HashMap getEconomicAspects(HashMap hshValues);
	public HashMap updateCroppingPatterns(HashMap hshValues);
	public HashMap getCroppingPatterns(HashMap hshValues);
	public void updateBoatEconomics(HashMap hshValues);
	public HashMap getBoatEconomics(HashMap hshValues);
	public void updatesheddetails(HashMap hshValues);
	public HashMap  getsheddetails(HashMap hshValues);
	public void updatetechdetails(HashMap hshValues);
	public HashMap  gettechdetails(HashMap hshValues);
	public void updatecoffeehypo(HashMap hshValues);
	public HashMap  getcoffeehypo(HashMap hshValues);
	public HashMap updatecropAssesmentData(HashMap hshValues);
	public HashMap getcropAssesmentData(HashMap hshValues);
	public void updateCropAssessmentDetails(HashMap hshValues);
	public HashMap getCropAssessmentDetails(HashMap hshValues);
	public HashMap insertPlantationExpenses(HashMap hshValues);
	public HashMap getplantationExpenses(HashMap hshValues);

	public void updatefarmMechMinorIrrig(HashMap hshValues);
	public HashMap getfarmMechMinorIrrig(HashMap hshValues);
	public HashMap getcattlechartdetails(HashMap hshValues);
	public void updateLandDevelopment(HashMap hshValues);
	public HashMap getLandDevelopment(HashMap hshValues); 
	public void updateSoilReclamation(HashMap hshValues);
	public HashMap getSoilReclamation(HashMap hshValues);
	public void updateDryingYard(HashMap hshValues);
	public HashMap getDryingYard(HashMap hshValues);
	//Added by Arsath for Fencing Details page
	public void updateFencingdet(HashMap hshValues);
	public HashMap getFencingdet(HashMap hshValues);
	
	public void updInterestSubventionDetails(HashMap hshValues);
	public HashMap getInterestSubventionDetails(HashMap hshValues);
}