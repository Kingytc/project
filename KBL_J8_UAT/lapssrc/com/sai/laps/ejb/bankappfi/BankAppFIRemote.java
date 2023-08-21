package com.sai.laps.ejb.bankappfi;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface BankAppFIRemote 
{
	public void updateData(HashMap hshValues);
	public HashMap getData(HashMap hshValues);
	public HashMap getSecurityRetailDetails(HashMap hshValues);
	public void updateSecurityRetailDetails (HashMap hshValues);
	public HashMap getAttachedRetailSecurityDetails(HashMap hshValues);
	public void updateAttachedRetailSecurityDetails(HashMap hshValues);
	public HashMap getattachRetailSecurity(HashMap hshValues);
	public HashMap getRetailSecuritiesbySecId(HashMap hshRequestValues);
	public HashMap getFreezeData(HashMap hshRequestValues);

	public void updateAgriProgramme(HashMap hshValues);
	public HashMap getFinProgramme (HashMap hshValues);
	public void getcollValueSecurityfreeze(HashMap hshValues) ;
	//Added by Arsath on 12/02/2014 for Existing Income other than crop page
	public void updateExsincotherthancrop (HashMap hshValues);
	public HashMap getExsincotherthancrop(HashMap hshRequestValues);
	//End of Arsath
	
	public HashMap getSecCollateralCoverageRetail(HashMap hshValues);
	public HashMap getCollateralSecurityRetailDisplay(HashMap hshValues);
	public void updateReleaseofSecurity (HashMap hshValues);
	
	public void updateBAConsData(HashMap hshValues);
	public HashMap getBAConsData (HashMap hshValues);
	
	public void updateBAConsDataTL(HashMap hshValues);
	public HashMap getBAConsDataTL (HashMap hshValues);
	public void updateFreezeData(HashMap hshRequestValues);
	public void  DetachSecurities(HashMap hshValues);
	public HashMap  getlegalopinionverification(HashMap hshValues);
	public void updatelegalopinionverification(HashMap hshValues);
	public double getExposureTotalLimit(String strAppId,String strValuesIn,String strSessionModuleType) ;
	public double getExposureTotalLimitagri(String strAppId,String strValuesIn,String misactcode) ;
}