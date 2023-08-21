package com.sai.laps.ejb.perpropertydetails;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface PropertyDetailsRemote 
{
	public HashMap getData(HashMap hshValues);
	public void updateData(HashMap hshValues);
	public HashMap getdisbursementdetails(HashMap hshRequestValues);
	public HashMap getotherinfodetails(HashMap hshRequestValues);	
	public void updateDataDisbursement(HashMap hshValues);
	public void updateotherinfoData(HashMap hshValues);
	public HashMap getOtherAssetData(HashMap hshRequestValues);
	public void updateOtherAssetData(HashMap hshValues);
	public HashMap updateGeneralInfo(HashMap hshValues);
	public HashMap getGeneralInfo(HashMap hshValues);
	public HashMap getDatalegal(HashMap hshRequestValues);
	public HashMap legalupdateData(HashMap hshValues);
	public void updateValuerEntryData(HashMap hshValues);
	public HashMap getValuerEntryData(HashMap hshValues);
	public void updateLoanAgainstDep(HashMap hshValues);
	public HashMap getLoanAgainstDep(HashMap hshValues);
	public HashMap getRenewalDetails(HashMap hshValues);
	public void updateRenewalDetails(HashMap hshValues);
	public void updateHousingLoanData(HashMap hshValues);
	public HashMap getHousingLoanData(HashMap hshValues);
	public void PullCustDepDetails(HashMap hshValues);
	public void UndoPulledDetails(HashMap hshValues);
	public HashMap getOtherDepDetails(HashMap hshValues);
	public void PullOtherDepDetails(HashMap hshValues);
	public void updateLoanRecmdAmtData(String strAppNo, double dblCostLoanPrd);
	public void updateSecurityDesc(HashMap hshValues);
	public HashMap getSecurityDesc(HashMap hshValues);
	public void updatePMAYdata(HashMap hshValues);
	public HashMap getPMAYdata(HashMap hshValues);
	public void updateAHPdata(HashMap hshValues);
	public HashMap getAHPdata(HashMap hshValues);


}