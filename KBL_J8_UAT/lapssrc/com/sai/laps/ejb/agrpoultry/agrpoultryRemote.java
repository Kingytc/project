package com.sai.laps.ejb.agrpoultry;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface agrpoultryRemote
{
	public void updatenonrecurringData(HashMap hshValues);
	public HashMap getnonrecurringData(HashMap hshValues);
	public void updaterecurringData(HashMap hshValues);
	public HashMap getrecurringData(HashMap hshValues);
	public HashMap updateagrflock(HashMap hshValues);
	public HashMap getagrflock(HashMap hshValues);
	public HashMap updatepoultrytechdata(HashMap hshValues);
	public HashMap getpoultrytechdata(HashMap hshValues);
	public HashMap updatepoultryfindata(HashMap hshValues);
	public HashMap getpoultryfindata(HashMap hshValues);
	public HashMap getpoultryflowchartData(HashMap hshValues);
	public HashMap getpoultryincomeflowData(HashMap hshValues);
	public void updatepoultryflowchartData(HashMap hshValues);
	public void updatepoultryincomeflowData(HashMap hshValues);
	public void updatepoultrycashflow(HashMap hshValues);
	public HashMap getpoultrycashflow(HashMap hshValues);
	public void updatesheeptechdata(HashMap hshValues);
	public HashMap getsheeptechdata(HashMap hshValues);
	public HashMap updatesheepecodata(HashMap hshValues);
	public HashMap getsheepecodata(HashMap hshValues);
	public void updatesheepincome(HashMap hshValues);
	public HashMap getsheepincome(HashMap hshValues);
	public void updatesheepexpenses(HashMap hshValues);
	public HashMap getsheepexpenses(HashMap hshValues);
	public HashMap updateagrsheepflock(HashMap hshValues);
	public HashMap getagrsheepflock(HashMap hshValues);
	public void updatesheepcashflow(HashMap hshValues);
	public HashMap getsheepcashflow(HashMap hshValues);
	public HashMap updatesheeploanreq(HashMap hshValues);
	public HashMap getsheeploanreq(HashMap hshValues);
	public HashMap getsheepeligibility(HashMap hshValues);
	public HashMap updatepoultrybroilerfindata(HashMap hshValues);
	public HashMap getpoultrybroilerfindata(HashMap hshValues);
	public void updatebroinonrecurringData(HashMap hshValues);
	public HashMap getbroinonrecurringData(HashMap hshValues);
	public void updatebroirecurringData(HashMap hshValues);
	public HashMap getbroirecurringData(HashMap hshValues);
	public HashMap updatebroiagrflock(HashMap hshValues);
	public HashMap getbroiagrflock(HashMap hshValues);
	public HashMap getpoultrybroiflowchartData(HashMap hshValues);
	public void updatepoultrybroiflowchartData(HashMap hshValues);
	public HashMap getpoultryirr(HashMap hshValues);
	public HashMap updatepoultryirr(HashMap hshValues);
	public HashMap getpoultrybroiincomeflowData(HashMap hshValues);
	public void updatepoultrybroiincomeflowData(HashMap hshValues);
	
	
	
}