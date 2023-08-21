package com.sai.laps.ejb.agrnursery;

import java.rmi.RemoteException;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.EJBObject;
import javax.ejb.Remote;
@Remote
public interface AgrNurseryLoanRemote
{
	public HashMap getHorticultureIncomeExp(HashMap hshValues);
	public HashMap getHorticultureFinancialAnalysis(HashMap hshValues);
	public void updateDairyCostofInvestment(HashMap hshValues);
	public HashMap getDairyCostofInvestment(HashMap hshValues);
	public void updateDairyFinancialData(HashMap hshValues);
	public HashMap getDairyFinancialData(HashMap hshValues);
	public void updateDairyHerdProductionChart(HashMap hshValues);
	public HashMap getDairyHerdProductionChart(HashMap hshValues);
	public void updateDairyIncomeStatement(HashMap hshValues);
	public HashMap getDairyIncomeStatement(HashMap hshValues);
	public HashMap getDairyRecurringExpenditure(HashMap hshValues);
	public HashMap getDairyFinancialAnalysis(HashMap hshValues);
	public HashMap getHorticultureScaleOfFinance(HashMap hshValues);
	public HashMap getSheepRearingCostOfProject(HashMap hshValues);
	public void updateSheepRearingCostOfProject(HashMap hshValues);
	 public void updateSheepHerdProjectionChart(HashMap hshValues);
	 public HashMap getSheepHerdProjectionChart(HashMap hshValues);
	 public HashMap getSheepIncome(HashMap hshValues);
		public void updateSheepIncome(HashMap hshValues);
	///	public HashMap getHorticultureFinancialAnalysis(HashMap hshValues);
		public  HashMap getAgriFinancialYear(HashMap hshValues);
		public  void updateAgriFinancialYear(HashMap hshValues);
		
}
