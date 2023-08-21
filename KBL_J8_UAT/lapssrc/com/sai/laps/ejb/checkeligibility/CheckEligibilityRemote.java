package com.sai.laps.ejb.checkeligibility;

import java.rmi.RemoteException;
import java.util.HashMap;

import javax.ejb.EJBObject;
import javax.ejb.Remote;
@Remote
public interface CheckEligibilityRemote 
{
	public HashMap getEligibility(HashMap hshValues);
}