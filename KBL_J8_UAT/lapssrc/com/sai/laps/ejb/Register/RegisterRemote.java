package com.sai.laps.ejb.Register;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface RegisterRemote 
{
	//public void updateDisposal(HashMap hsh);      
	//public HashMap getDisposal(HashMap hsh);
	public HashMap getDocSearch(HashMap hshValues);
	public void updateDocumentRegister(HashMap hshValues);
	public HashMap getDocumentRegister(HashMap hshValues);
	public void updateLimitRegisster(HashMap hshValues);
	public HashMap getLimitRegister(HashMap hshValues);
	public void updateInsuranceDetails(HashMap hshValues);
	public HashMap getInsuranceDetails(HashMap hshValues);
	public void updateConsortium(HashMap hshValues);
	public HashMap getConstoritum(HashMap hshValues);

	
	//public void updateInterestRegister(HashMap hshValues);
	//public HashMap getInterestRegister(HashMap hshValues);

	public void updateDBC(HashMap hshValues);
	public HashMap getDBC(HashMap hshValues);

	//public void updateInstallmentRegister(HashMap hshValues);
	//public HashMap getInstallmentRegister(HashMap hshValues);
	
	//public void updatemonitorguarantor(HashMap hshValues);
	//public HashMap getmonitorguarantor(HashMap hshValues);
	
	//public void updateRenewalRegister(HashMap hshValues);
	//public HashMap getRenewalRegister(HashMap hshValues);
	public void updateSecurityMaster(HashMap hshValues);
	public HashMap getSecurityMaster(HashMap hshValues);
	public void updateDrawingpower(HashMap hshValues);
	public HashMap getDrawingpower(HashMap hshValues);

	
	public void updatebranchcomments(HashMap hshValues);
	public HashMap getbranchcomments(HashMap hshValues);

	public void updateAuditorsInspection(HashMap hshValues);
	public HashMap getAuditorsInspection(HashMap hshValues);

	public void updatemonitorchecklist(HashMap hshValues);
	public HashMap getmonitorchecklist(HashMap hshValues);
	
	public void updatemonSecurityregister(HashMap hshValues);
	public HashMap getmonSecurityregister(HashMap hshValues);

	public void updateStockStatement(HashMap hshValues);
	public HashMap getStockStatement(HashMap hshValues);	
	
	public HashMap getInsuranceno(HashMap hshValues);

	public void updateSecuInsuranceMapping(HashMap hshValues);
	public HashMap getSecuInsuranceMapping(HashMap hshValues);	
	public HashMap getSecurityInsuranceDetail(HashMap hshValues);	
	
}