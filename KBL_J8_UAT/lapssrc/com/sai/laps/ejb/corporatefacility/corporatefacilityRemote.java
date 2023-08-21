package com.sai.laps.ejb.corporatefacility;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface corporatefacilityRemote 
{

	public HashMap getData(HashMap hshValues);

	public HashMap getProcessingFee(HashMap hshValues);
	public HashMap getAmountRange(HashMap hshValues);
	public void  updateProcessChargesData (HashMap hshValues);
	public HashMap getDocFee(HashMap hshValues);
	public HashMap getAmountDocRange(HashMap hshValues);
	public HashMap  updateDocChargesData (HashMap hshValues);
	public HashMap getMarginFee(HashMap hshValues);
	public HashMap getAmountMarginRange(HashMap hshValues);
	public HashMap  updateMarginChargesData (HashMap hshValues);

	public HashMap updateData(HashMap hshValues);
	
	//Other details
	public void updateotherdet(HashMap hshValues);
	public HashMap getDataotherdet(HashMap hshValues);
	public void updateFacilitySaveStatus(HashMap hshValues);
	public String checkFacilitySaveStatus(HashMap hshValues);
	
	public HashMap checkPageStatus(HashMap hshValues);
	//security 
	
	public void update_securitytype(HashMap hshValues);
	public HashMap getdatasecuritytype(HashMap hshValues);
	public HashMap getassessment(HashMap hshValues);
	
	

	public HashMap getAssesAmountRange(HashMap hshValues);
	public HashMap getAssesmentData(HashMap hshValues);
	public HashMap  updateAssesmentData (HashMap hshValues);
	public void  updateAssesment (HashMap hshValues);
	
	public HashMap getListofPageData(HashMap hshValues);
	public HashMap  updateListofPageData (HashMap hshValues);
	

	public void  updateFormulaData (HashMap hshValues);
	public HashMap  getFormulaData (HashMap hshValues);
	

	public void  updatedatafacilitylevel (HashMap hshValues);
	public HashMap getdatafacilitylevel(HashMap hshValues);
	public HashMap getOtherDetailLend(HashMap hshValues);
	public void update_NFBLData (HashMap hshValues);
	public HashMap get_NFBLData(HashMap hshValues);
	public HashMap getDataOtherLendingPower(HashMap hshValues);
	public void  updateDataOtherLendingPower (HashMap hshValues);
	//commission
	public HashMap getcommissionFee(HashMap hshValues);
	public HashMap getAmountcommissionRange(HashMap hshValues);
	public void  updatecommissionData (HashMap hshValues);
	
	public HashMap getComFacilityDelegatedPowers(HashMap hshValues);
	public void  updateComFacilityDelegatedPowers (HashMap hshValues);
	
	public HashMap get_svanidhi(HashMap hshValues);
	public void  update_svanidhi (HashMap hshValues);

}