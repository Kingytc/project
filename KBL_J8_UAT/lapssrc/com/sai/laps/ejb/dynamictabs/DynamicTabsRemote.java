package com.sai.laps.ejb.dynamictabs;

import java.rmi.RemoteException;
import java.util.HashMap;

import javax.ejb.EJBObject;
import javax.ejb.Remote;

@Remote
public interface DynamicTabsRemote  
{
	public HashMap getData(HashMap hshRequestValues);
	public HashMap getChildTabs(HashMap hshRequestValues);
	public HashMap getAppraisalTabData(HashMap hshRequestValues);
}
