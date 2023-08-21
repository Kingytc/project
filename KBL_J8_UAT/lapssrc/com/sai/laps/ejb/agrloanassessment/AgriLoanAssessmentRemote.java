package com.sai.laps.ejb.agrloanassessment;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface AgriLoanAssessmentRemote
{
	public HashMap updatepoultrytechdata(HashMap hshValues);
	public HashMap getpoultrytechdata(HashMap hshValues);
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
	public HashMap getpoultrybroiincomeflowData(HashMap hshValues);
	public void updatepoultrybroiincomeflowData(HashMap hshValues);
	public HashMap getAssessment(HashMap hshValues);
	public HashMap gethomesteadassesmentdata(HashMap hshValues);
	public HashMap getbroiagrflocknew(HashMap hshValues);
	
}
