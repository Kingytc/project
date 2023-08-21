package com.sai.laps.ejb.lapsReport;


import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface lapsReportRemote 
{
	public void updateDueDiligence1(HashMap hshValues);
	public void updateDueDiligence2(HashMap hshValues);
	public void updateDueDiligence3(HashMap hshValues);
	public HashMap getDueDiligenceRetail(HashMap hshValues);
	
	public void updateAgriDueDiligence(HashMap hshRequestValues);
	public HashMap getDueDiligence(HashMap hshValues);
	
	public void updateCreditreport1(HashMap hshValues);
	public HashMap getCreditreport1(HashMap hshValues);
	
	public void updateCreditreport2(HashMap hshValues);
	public HashMap getCreditreport2(HashMap hshValues);
	
	//public HashMap getCreditReportPrint(HashMap hshValues);
	public HashMap getCreditReportPrint1(HashMap hshValues);
	public HashMap getCreditReportPrint2(HashMap hshValues);
	public HashMap getCreditreportforRetail(HashMap hshValues);
	
	public void updateOPSInspectionReport(HashMap hshValues);
	public HashMap getOPSInspectionReport(HashMap hshValues);
	
	public void updateComInspectionReport(HashMap hshvalues);
	public HashMap getComInspectionReport(HashMap hshvalues);
	
	public HashMap getComInspectionReportPrint(HashMap hshvalues);
	
	public void AttachDetachCreditReport(HashMap hshvalues);
	public HashMap getCreditreportNames(HashMap hshValues);
	
	public void updateComDueDiligenceReport(HashMap hshRequestValues);
	public HashMap getComDueDiligenceReport(HashMap hshRequestValues);
	
	public void updateComCreditLimitSought(HashMap hshRequestValues);
	public HashMap getComCreditLimitSought(HashMap hshRequestValues);
	
	
	public void updateComDueDiligenceCertificate(HashMap hshRequestValues);
	public HashMap getComDueDiligenceCertificate(HashMap hshRequestValues);
	
	public HashMap getComDueDiligenceReportPrint(HashMap hshRequestValues);
	
	public HashMap getProcessNote(HashMap hshRequestValues);
	public HashMap getFacilityDetails(String strAppno);
	public HashMap getFinProgrammePrint(HashMap hshRequestValues);
	
	public HashMap getProposalLC (HashMap hshValues); 
	public HashMap getProposalMDSanction (HashMap hshValues); 
	public HashMap getPostSancShortnote (HashMap hshValues); 
	public HashMap getMCLRPermissionLetter (HashMap hshValues); 
	
	public HashMap getRenewalProcessNote (HashMap hshValues); 
	
//	public HashMap getCreditReportPrintforssi(HashMap hshValues);
	public HashMap getinwarddetails (HashMap hshReqValues); 
	public void updateinwarddetails (HashMap hshReqValues); 
	
	public void updateoutwarddetails(HashMap hshRequestValues);
	public HashMap getoutwarddetails(HashMap hshRequestValues);
	public HashMap getbrachlist(HashMap hshReqValues);
	
	public HashMap getinwardoutwardproposaldetails(HashMap hshReqValues);
	public void updateinwardoutwardproposaldetails(HashMap hshReqValues);
	
	public HashMap getinwardoutwardshortnotedetails(HashMap hshReqValues);
	public void updateinwardoutwardshortnotedetails(HashMap hshReqValues);
	public HashMap proposalsummery(HashMap hshReqValues) ;
	public HashMap proposalsummeryRet(HashMap hshReqValues) ;
	
}