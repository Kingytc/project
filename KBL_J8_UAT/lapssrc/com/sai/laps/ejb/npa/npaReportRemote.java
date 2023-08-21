package com.sai.laps.ejb.npa;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface npaReportRemote 
{
	public HashMap getcompromisecomments(HashMap hsh);
	public void updatecompromisecomments(HashMap hsh);
	public HashMap getcompromisepage3Data(HashMap hsh);
	public void updatecompromisepage3Data(HashMap hsh);
	public void updateCompromiseModulardues(HashMap hsh);
	public HashMap getCompromiseModulardues(HashMap hshValues);
	public HashMap getEvaluationscores(HashMap hshValues);
	public void updateCompromiseReliefSought(HashMap hsh);
	public HashMap getCompromiseReliefSought(HashMap hsh);
	
	public void updatecompromisetermscond(HashMap hsh);
	public HashMap getcompromisetermscond(HashMap hsh);
	
	public HashMap getsarfaeripage2Data(HashMap hsh);
	public void updatesarfaeripage2Data(HashMap hsh);
	public HashMap getsarfaeripage3Data(HashMap hsh);
	public void updatesarfaeripage3Data(HashMap hsh);
	public void updateSarfaesiDocument(HashMap hsh);
	public HashMap getSarfaesiDocument(HashMap hsh);
	
	//public HashMap get34pointspage2Data(HashMap hsh);
	//public void update34pointspage2Data(HashMap hsh);
	public HashMap get34pointspage4Data(HashMap hsh);
	public void update34pointspage4Data(HashMap hsh);
	//public HashMap get34pointspage5Data(HashMap hsh);
	//public void update34pointspage5Data(HashMap hsh);
	public HashMap get34pointspage6Data(HashMap hsh);
	public void update34pointspage6Data(HashMap hsh);
	//public HashMap get34pointspage3Data(HashMap hsh);
	//public void update34pointspage3Data(HashMap hsh);
	public HashMap getFilingtermloan(HashMap hsh);
	public void updateFilingtermloan(HashMap hsh);
	public HashMap getFilingPresentrate(HashMap hsh);
	public void updateFilingPresentrate(HashMap hsh);
	public HashMap getFilingLimitSanctioned(HashMap hsh);
	public void updateFilingLimitSanctioned(HashMap hsh);
	public HashMap getFilingColletralSecurity(HashMap hsh);
	public void updateFilingColletralSecurity(HashMap hsh);
	public HashMap getFilingDeposit(HashMap hsh);
	public void updateFilingDeposit(HashMap hsh);
	public HashMap getFilingregistered(HashMap hsh);
	public void updateFilingregistered(HashMap hsh);

	public void updateprudentialpage2Data(HashMap hsh);
	public HashMap getprudentialpage2Data(HashMap hsh);
	
	public HashMap getstatusnotepage2Data(HashMap hsh);
	public void updatestatusnotepage2Data(HashMap hsh);
	
	public HashMap printgetCompromise(HashMap hsh);
	public HashMap printgetSarfaeri(HashMap hsh);
	public HashMap getprudentialprint(HashMap hsh); 
	public 	HashMap getNPAStatuspagePrint(HashMap hshValues);
	public HashMap printget34pointspageData(HashMap hsh);
	
	public HashMap checkOLDApplication(HashMap hsh);
	
	public HashMap getstatusSuitfield(HashMap hsh);
	public void updatestatusSuitfield(HashMap hsh);
	
	public HashMap getNpaProposalReport(HashMap hshValues);
	public HashMap getNpaReport(HashMap hshValues);
	
	public HashMap getDCBRegisterData(HashMap hshValues);
	public void updateDCBRegisterData(HashMap hshValues);
	
	 public HashMap getDCBRegisterPrintData(HashMap hshValues);
	 public HashMap getNPAapplicationno(HashMap hshValues);
	
	 public void updateNPAMailComments(HashMap hsh);
	 public HashMap getNPAMailComments(HashMap hshValues);
	 
//	public void updatecounterpage1Data(HashMap hsh);
//	public HashMap getcounterpage1Data(HashMap hsh);
//	public void updatecounterpage2Data(HashMap hsh);
//	public HashMap getcounterpage2Data(HashMap hsh);
//	public void updatecounterpage3Data(HashMap hsh);
//	public HashMap getcounterpage3Data(HashMap hsh);
//	public void updatecounterpage4Data(HashMap hsh);
//	public HashMap getcounterpage4Data(HashMap hsh);
//	public HashMap getBorrowerInfo(HashMap hsh);
//	public HashMap printgetCouteroff(HashMap hsh); 
//	public HashMap updatestatusnotepage1Data(HashMap hsh);
//	public HashMap getstatusnotepage1Data(HashMap hsh);
//	public HashMap getnpatype(HashMap hshValues);
//	public void updateSetlementdatapage5(HashMap hsh);
//	public HashMap getcreditrecoverypage5Data(HashMap hsh);	
//	public HashMap updateprudentialpage1Data(HashMap hsh);
//	public HashMap getprudentialpage1Data(HashMap hsh);
//	public void updateSetlementdatapage1(HashMap hsh);
//	public HashMap getcreditrecoverypage1Data(HashMap hsh);
//	public HashMap getsarfaeripage1Data(HashMap hsh);
//	public HashMap updatesarfaeripage1Data(HashMap hsh);
//	public void updateSetlementdatapage2(HashMap hsh);
//	public HashMap getcreditrecoverypage2Data(HashMap hsh);
//	public HashMap getsarfaeripage4Data(HashMap hsh);
//	public void updatesarfaeripage4Data(HashMap hsh);
//	public HashMap update34pointspage1Data(HashMap hsh);
//	public void updateSetlementdatapage3(HashMap hsh);
//	public HashMap getcreditrecoverypage3Data(HashMap hsh);
//	public void updateSetlementdatapage4(HashMap hsh);
//	public HashMap getcreditrecoverypage4Data(HashMap hsh);
//	public void updateprudentialpage4Data(HashMap hsh);
//	public HashMap getprudentialpage4Data(HashMap hsh);
//	public HashMap get34pointspage1Data(HashMap hsh);
//	public HashMap printgetCreditRecovery(HashMap hsh);	 
//	public HashMap getcompromisepage1Data(HashMap hsh);
//	public HashMap updatecompromisepage1Data(HashMap hsh);
//	public void updateprudentialpage3Data(HashMap hsh);
//	public HashMap getcompromisepage2Data(HashMap hsh);
//	public void updatecompromisepage2Data(HashMap hsh);
//	public void updatestatusnotepage3Data(HashMap hsh);
//	public HashMap getstatusnotepage3Data(HashMap hsh);
} 