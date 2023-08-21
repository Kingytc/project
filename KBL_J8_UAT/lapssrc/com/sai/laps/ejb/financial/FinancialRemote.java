package com.sai.laps.ejb.financial;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface FinancialRemote 
{

	public HashMap getData(HashMap hshRequestValues);
	public HashMap getDataRatio(HashMap hshRequestValues);
	public HashMap getRatioList(HashMap hshRequestValues);
	public void updateData(HashMap hsh);
	public HashMap getDataList(HashMap hshRequestValues);
	public void deleteData(HashMap hsh);
	public void uploadtoRAM(HashMap hashMap);
	public boolean CheckBalanceSheet(HashMap hashMap,String cma);
	public HashMap updateFinancialData(HashMap hshRequestValues);
	public void updateFinData(HashMap hshRequestValues);
	
	public HashMap getSensitiveData(HashMap hshRequestValues);
	public void updateSensitiveData(HashMap hsh);
	public HashMap updateSensitiveFinancialData(HashMap hsh);
	
	public void updateBenchMarkParam(HashMap hshValues);
	public HashMap getBenchMarkParam(HashMap hshValues);
	
	public HashMap getDataAssessment(HashMap hshRequestValues);
	public HashMap getAnnexureIX(HashMap hshValues);
	public void updateFreezeData(HashMap hshValues);
	public HashMap getCMAType(HashMap hshValues);
	public HashMap updateAttachData(HashMap hshValues);
	public HashMap updateFinRating(HashMap hshValues);
	public HashMap getFinRating(HashMap hshValues);
	public void updateDataRatio(HashMap hshRequestValues);
	public HashMap getHistroy(HashMap hshRequestValues); 
	public HashMap getAction(HashMap hshRequestValues);
	public void updateAction(HashMap hshValues);
	public void updateOnlyforRating(HashMap hshValues);//getAnnexCorpData//getCorpDataRatio//getCorpAnnexureII
	public HashMap getAnnexCorpData(HashMap hshValues);
	public HashMap getCorpDataRatio(HashMap hshValues);
	public HashMap getCorpAnnexureII(HashMap hshRequestValues);
	public HashMap getCgtmseFinancialData(HashMap hshRequestValues);
	
	//done for cgmtse
	public void updateRetailData(HashMap hsh);
	public HashMap getRetailData(HashMap hshRequestValues);
	
	public HashMap getDigiRating(HashMap hshRequestValues);

}
