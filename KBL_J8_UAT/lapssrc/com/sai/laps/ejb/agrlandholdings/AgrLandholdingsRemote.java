package com.sai.laps.ejb.agrlandholdings;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface AgrLandholdingsRemote
{
	public void updateData(HashMap hshValues);
	public HashMap getData(HashMap hshValues);
	public void updateDatainvest(HashMap hshValues);
	public void updateRegData(HashMap hshValues);
	public HashMap getDatareject(HashMap hshValues);
	public HashMap getDatainvest(HashMap hshValues);
	public void updateConsumptionloan(HashMap hshValues);
	public HashMap getDataConsumptionloan(HashMap hshValues);
	public void updateFodderLiveStock(HashMap hshValues);
	public HashMap getFodderLiveStock(HashMap hshValues);
	//Added by Arsath for Plantation
	public void updateHortiData(HashMap hshValues);
	public HashMap getHortiData(HashMap hshValues);
	public void updateHortiCostOfDevelopmentDetails(HashMap hshValues);
	public HashMap getHortiCostOfDevelopmentDetails(HashMap hshValues);
	public void updateHortiProjectedIncome(HashMap hshValues);
	public HashMap getHortiProjectedIncome(HashMap hshValues);
	public void updateHortiFinancialProgramme(HashMap hshValues);
	public HashMap getHortiFinancialProgramme(HashMap hshValues);
	public void updatePlantationRepayment(HashMap hshValues);
	public HashMap getPlantationRepayment(HashMap hshValues);
	public void updateOnFarmDevelopment(HashMap hshValues);
	public HashMap getOnFarmDevelopment(HashMap hshValues);
	public void updateSandCasting(HashMap hshValues);
	public HashMap getSandCasting(HashMap hshValues);
	public HashMap getLandHoldingDataDisp(HashMap hshValues);
	
	public void updatePhysicalProgramme (HashMap hshvalues);
	
	//public void updateFarmBudgetNetIncomeDetails(HashMap hshvalues);
	
}
