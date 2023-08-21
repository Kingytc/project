package com.sai.laps.ejb.monitoringsetup;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface monitoringsetupRemote 
{
	public void updateMonitoringAlerts(HashMap hsh);
	public HashMap getMonitoringAlerts(HashMap hsh);
	
	
	
	public void updateMonReviewCorporatePersonal(HashMap hsh);
	public HashMap getMonReviewCorporatePersonal(HashMap hsh);
	//public void updateAdHocMonthlyMonitor(HashMap hsh);
	//public void updateSubMonthlyMonitor(HashMap hsh);
	//public void updateMonthlyMonitorBorrowerData(HashMap hsh);
	//public HashMap getMonthlyMonitorBorrowerData(HashMap hsh);
}
