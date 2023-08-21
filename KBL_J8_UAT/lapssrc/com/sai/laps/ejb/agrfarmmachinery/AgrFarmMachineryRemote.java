package com.sai.laps.ejb.agrfarmmachinery;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface AgrFarmMachineryRemote 
{
	public void updateFarmMachineryDetails(HashMap hshValues);
	public HashMap getFarmMachineryDetails(HashMap hshValues);
	
	public void updateIncomeHireDetails(HashMap hshValues);
	public HashMap getIncomeHireDetails(HashMap hshValues);
	
	
	public  HashMap getSheepFinancialAnalysis(HashMap hshValues);
	//Added by Arsath on 27/02/2014 for farm forestry
	public void updateFarmForestrydet(HashMap hshValues);
	public HashMap getFarmForestrydet(HashMap hshValues);
	
}
