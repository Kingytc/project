package com.sai.laps.ejb.monitoringletters;

import java.rmi.RemoteException;
import java.util.HashMap;

import javax.ejb.EJBObject;
import javax.ejb.Remote;


@Remote
public interface MonitoringLetterRemote 
{
	public HashMap getborrowerdetails(HashMap hshValues);
	public HashMap getLCDetails(HashMap hshValues);
	public HashMap getloandefaulter(HashMap hshValues);
	public HashMap getGuarantee(HashMap hshValues);
	public HashMap getBillDetails(HashMap hshValues);
	public HashMap getLimitRenewalDetails(HashMap hshValues);
	public HashMap getInsuranceRecovered(HashMap hshValues);
	public HashMap getNonsubmission(HashMap hshValues);
	public HashMap getDrawingPower(HashMap hshValues);
	
	//public HashMap getFollowupMonitoring(HashMap hshValues);
	//public void updateFollowupMonitoring(HashMap hshValues);
	public HashMap getStandingCrops(HashMap hshValues);
	public void updateStandingCrops(HashMap hshValues);
	public HashMap getStandingCropsPrint(HashMap hshValues);
	//public HashMap getFollowupInspectionCorporate(HashMap hshValues);
}