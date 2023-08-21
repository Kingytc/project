package com.sai.laps.ejb.perfinancial;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface PerFinancialRemote 
{
	/*for inserting in bank accounts tab*/
	//public HashMap getData(HashMap hshValues);
	//public HashMap insertData(HashMap hshValues);

	/*for inserting in investment tab*/
	public HashMap getInvestMent(HashMap hshValues);
	public void insertInvestMent(HashMap hshValues);
	public HashMap getFinancialInvesmentCheck(HashMap hshRequestValues);
	
	/*for inserting in policy tab*/
	public HashMap getPolicy(HashMap hshValues);
	public void insertPolicy(HashMap hshValues);
	public HashMap getFinancialInsuranceCheck(HashMap hshRequestValues);

	/*for inserting in property tab*/
	//public HashMap getProperty(HashMap hshValues);
	//public HashMap insertProperty(HashMap hshValues);

	/*for inserting in liability tab*/
	public HashMap getLiability(HashMap hshValues);
	public void insertLiability(HashMap hshValues);
	public HashMap getComments(HashMap hshValues);
	public void updateComments(HashMap hshValues);
	
	//Added by rajesh for other bank details 
	public HashMap getBankComments(HashMap hshValues);
	public void updateBankComments(HashMap hshValues);
	
	public HashMap invokeProcedureCIBIL(HashMap hshValues);
	public HashMap getCIBILView(HashMap hshValues);
	public HashMap cibilReportScore(HashMap hshValues);
	public HashMap cibilReportCheckProcCall(HashMap hshValues);
	
}
