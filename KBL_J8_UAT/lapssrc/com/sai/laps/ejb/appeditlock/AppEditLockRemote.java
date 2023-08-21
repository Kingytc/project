package com.sai.laps.ejb.appeditlock;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface AppEditLockRemote
{
	public HashMap getProductList(HashMap hshValues);
	public String getAppno(HashMap hshValues);
	//public String lockApplication(HashMap hshValues);
	//public void unLockApplication(HashMap hshValues);
	public HashMap getAppData(HashMap hshRequestValues);
	public HashMap getOrgCode(HashMap hshOrgcode);
	public HashMap getParentName(HashMap hshValues);
	public HashMap getToolBarData(HashMap hshValues);
	public String getNPAAppno(HashMap hshValues);
	public HashMap getProductAppList(HashMap hshValues);
	public HashMap getActivityList(HashMap hshValues);
	public String getRatingAppno(HashMap hshValues);
	
	public String generateTokenVal(HashMap hshValues)throws RemoteException;
}
