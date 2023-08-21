package com.sai.laps.ejb.corpexecutivesummarypdf;

import java.rmi.RemoteException;
import java.util.HashMap;

import javax.ejb.EJBObject;
import javax.ejb.Remote;
import javax.ejb.RemoteHome;
@Remote
public interface ExecutiveSummaryRemote  {
	public HashMap getExecutiveSummaryData(HashMap hshValues);
}
