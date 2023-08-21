package com.sai.laps.ejb.comformula;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface ComformulaRemote 
{
	public HashMap getFormulaResult(HashMap hshValues);
	public HashMap ListFinData(HashMap hshValues);
	public HashMap GetFinValue(HashMap hshValues);
	public HashMap getYearsData(HashMap hshValues);
	public HashMap GetCashFlowData(HashMap hshValues);
	public HashMap GetFundFlowData(HashMap hshValues);
	
	 public void updateFincommentsData(HashMap hshValues);
	 public HashMap getDateFincommentsData(HashMap hshValues);
}
