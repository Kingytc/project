package com.sai.laps.ejb.monitoringalert;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface MonitoringAlertRemote 
{
	public HashMap getLoanDefaultData(HashMap hshValues);
	public HashMap nonRenewal(HashMap hshValues);
	public HashMap getDocumentationdeficiency(HashMap hshValues);
	public HashMap noninspectionofsecurities(HashMap hshValues);
	public HashMap otherdefaults(HashMap hshValues);
	//public HashMap getGeneral(HashMap hshValues);
	public HashMap getData(HashMap hshRequestValues);
	public HashMap getAlertData(HashMap hshRequestValues);
}