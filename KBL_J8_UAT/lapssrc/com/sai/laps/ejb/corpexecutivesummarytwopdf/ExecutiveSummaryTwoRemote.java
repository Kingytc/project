package com.sai.laps.ejb.corpexecutivesummarytwopdf;

import java.rmi.RemoteException;
import java.util.HashMap;

import javax.ejb.EJBObject;
import javax.ejb.Remote;
@Remote
public interface ExecutiveSummaryTwoRemote  
{
	public HashMap getFinancialData(HashMap hshRequestValues);
}
