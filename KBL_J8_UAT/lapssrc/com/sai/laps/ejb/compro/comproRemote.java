package com.sai.laps.ejb.compro;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface comproRemote 
{
	public HashMap getValues(HashMap hsh);
	public HashMap updatePromoter(HashMap hsh);
	public HashMap getProData(HashMap hsh);
	
	public void updateActivity(HashMap hsh);
	public HashMap getActivity(HashMap hsh);
	
	public void updateGroup(HashMap hsh);
	public HashMap getGroup(HashMap hsh);
	
	public void updateLitigation(HashMap hsh);
	public HashMap getLitigation(HashMap hsh);
	
	public void updateEquity(HashMap hsh);
	public HashMap getEquity(HashMap hsh);
	
	public void updateComments(HashMap hsh);
	public HashMap getComments(HashMap hsh);
//	public void updateCharges(HashMap hsh);
	public HashMap getCharges(HashMap hsh);
//	public void updateFIData(HashMap hsh);
//	public HashMap getFILoanData(HashMap hsh);
	
	public HashMap getRawMajorData(HashMap hsh);
	public void updateRawMajor(HashMap hsh);
	
	public HashMap getSupplyIndiData(HashMap hsh);
	public void updateSupplyIndi(HashMap hsh);
	
	public HashMap getOtherSubstData(HashMap hsh);
	public void updateOtherDetailsSubst(HashMap hsh);
	
	public HashMap getSegmentEndData(HashMap hsh);
	public void updateSegmentEnd(HashMap hsh);
	
	public HashMap getDistLocalData(HashMap hsh);
	public void updateDistLocal(HashMap hsh);

	public HashMap getCapitalStructure(HashMap hshValues);
	public void updateCapitalStructure(HashMap hshValues);
//	public HashMap getAllPromoterValues(HashMap hsh);
	
	public HashMap getCompanyBackground(HashMap hshValues);
	public void updateCompanyBackground(HashMap hshValues);
//Added by rajesh on 29/11/2013	
	public void update_Others(HashMap hsh);
	public HashMap get_Others(HashMap hshRequestValues);
	

	public void update_swotanalysis(HashMap hshValues);
	public HashMap get_swotanalysis(HashMap hshRequestValues);
	

	public void update_Management(HashMap hsh);
	public HashMap get_Management(HashMap hshRequestValues);

	public void updatecom_externalratingdata(HashMap hshValues)  ;
	public HashMap getcom_externalratingdata(HashMap hshValues); 

	public void updateFinancialComments(HashMap hsh);
	public HashMap getFinancialComments(HashMap hsh);

	public void updatecom_Rbiloanpolicyguidedata(HashMap hshValues)  ;
	public HashMap getcom_Rbiloanpolicyguidedata(HashMap hshValues)  ;
	
	public void updatecom_Rbicommentsdata(HashMap hshValues)  ;
	public HashMap getcom_Rbicommentsdata(HashMap hshValues)  ;
	
	public void updatecom_nonfundloanlcdata(HashMap hshValues)  ;
	public HashMap getcom_nonfundloanlcdata(HashMap hshValues); 
	
	public HashMap getcom_Bankingdetacommentdata(HashMap hshValues)  ;
	
	public void updateSHGAssessment(HashMap hshValues)  ;
	public HashMap getSHGAssessment(HashMap hshValues); 
	
	public void updategroupcomments(HashMap hshValues)  ;
	public HashMap getgroupcomments(HashMap hshValues); 
	
	public HashMap getPromotorsList(HashMap hshValues); 
	
	
	public void updateOtherLimits(HashMap hshValues)  ;
	public HashMap getOtherLimits(HashMap hshValues);

	public HashMap getRenewalProcessNote(HashMap hshReqValues);
	public HashMap getmisprocessnotedetails(HashMap hshValues);

	public void updateSvanidhiAssess(HashMap hshValues);
	public HashMap getSvanidhiAssess(HashMap hshValues);
	public double getExposureTotalLimit(String strAppId,String strValuesIn,String strSessionModuleType) ;
	public double getExposureTotalLimitagri(String strAppId,String strValuesIn,String misactcode) ;
}