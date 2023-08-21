package com.sai.laps.ejb.agrstandardreport;

import java.rmi.RemoteException;
import java.util.HashMap;

import javax.ejb.EJBObject;
import javax.ejb.Remote;
@Remote
public interface AgrStandardReportRemote
{
	
	public HashMap getDetails(HashMap hashmap);
	
	

}
