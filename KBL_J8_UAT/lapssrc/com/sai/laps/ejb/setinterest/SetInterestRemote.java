package com.sai.laps.ejb.setinterest;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface SetInterestRemote 
{
	public void updateData(HashMap hashtable);
	public HashMap getData(HashMap hashtable);
	public HashMap getInterests(HashMap hashtable);
	
	public HashMap getProcessChargesID(HashMap hshRequestValues);	
	public HashMap getProcessData(HashMap hshRequestValues);
	public HashMap updateProcessChargesData(HashMap hashtable);

	public HashMap getDocumentChargesID(HashMap hshRequestValues);
	public HashMap getDocumentData(HashMap hshRequestValues);
	public HashMap updateDocumentChargesData(HashMap hashtable);
	
	public HashMap getMarginData(HashMap hashtable);
	public HashMap updateMarginData(HashMap hashtable);
	
	public HashMap getInterestData(HashMap hashtable);
	public void updateInterestData(HashMap hashtable);
	
	public HashMap getIncomeData(HashMap hashtable);
	public HashMap updateIncomeData(HashMap hashtable);
	public HashMap getRentInsureData(HashMap hshRequestValues);
	public HashMap updateRentInsureData(HashMap hshValues);
	public HashMap getJewelAppraisalData(HashMap hshRequestValues);
	public HashMap updateJewelAppraisalData(HashMap hshValues);
	
	public HashMap getSpecificEligiblity(HashMap hshValues);
	public void updateSpecificEligiblity(HashMap hshValues);
	public HashMap getDataFacility(HashMap HashMap);
	
	public HashMap updateAgrimarginData(HashMap hshValues);
	public HashMap getAgrimarginData(HashMap hshValues) ;
	
	public void updateAgriPropertiesData(HashMap hshValues);
	public HashMap getAgriPropertiesData(HashMap hshValues);
	
	public HashMap updateCollateralSecurity(HashMap hshValues);
	public HashMap getCollateralSecurity(HashMap hshValues);
	
    public HashMap updateSetcorpcollateralSecurity(HashMap hshValues);
	public HashMap getSet_corpcollateralSecurity(HashMap hshValues) ;
	
	public void updateMCLRMaster(HashMap hshValues);
	public HashMap getMCLRMaster(HashMap hshValues) ;
	
	public void updateMCLRSpreadMaster(HashMap hshValues);
	public HashMap getMCLRSpreadMaster(HashMap hshValues) ;
	
}
