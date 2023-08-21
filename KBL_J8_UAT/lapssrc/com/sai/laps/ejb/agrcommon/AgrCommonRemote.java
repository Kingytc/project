package com.sai.laps.ejb.agrcommon;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface AgrCommonRemote 
{
	public void updateLoanRequirements(HashMap hshValues);
	public HashMap getLoanRequirementsData(HashMap hshValues);
	public void deleteLoanRequirements(HashMap hshValues);
	public HashMap getIncome(HashMap hshValues) ;
	public HashMap getExpense(HashMap hshValues) ;
	public void deleteIncomeAndExpense(HashMap hshValues);
	public void updateIncomeandExpense(HashMap hshValues);
	public HashMap getIncomeExpenseTotal(HashMap hshValues);
	public HashMap getTechData(HashMap hashmap);
	public void updateTechData(HashMap hashmap);
	public HashMap checkMandatoryPages (HashMap hshValues);
	public void updateAgr_targetmastedate(HashMap hshValues);//added by ganesan on 30/05/2014
	public HashMap getAgr_targetmastedate(HashMap hshValues) ;
}