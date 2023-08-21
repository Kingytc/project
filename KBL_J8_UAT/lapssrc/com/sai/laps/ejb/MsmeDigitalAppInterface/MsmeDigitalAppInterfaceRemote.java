package com.sai.laps.ejb.MsmeDigitalAppInterface;

import java.util.HashMap;
import javax.ejb.Remote;

@Remote
public interface MsmeDigitalAppInterfaceRemote {

	public HashMap updateMsmeLarService(HashMap hshValues);	
	public HashMap renewalProposal(HashMap hshValues);
	public HashMap basicInformationCustomer(HashMap hshValues);
	public HashMap msmeCustomerCreation(HashMap hshValues);
	public HashMap msmeDedupeCheckService(HashMap hshValues);

	public HashMap msmecollateralsecurity(HashMap hshValues);

	public HashMap msmeRenewalDedupeCheckService(HashMap hshValues);
	public HashMap msmeFinancialCMAService(HashMap hshValues); 
	public HashMap CorpProposalCreation(HashMap hshValues); 
	public HashMap msmeUpdateSanctionDetails(HashMap hshValues); 
	public HashMap msmeGetDigiDecisionDetail(HashMap hshValues); 

	public HashMap financialCreation(HashMap hshValues);  
	public HashMap CorpRenewalProposalCreation(HashMap hshValues); 
	public HashMap CAMService(HashMap hshValues);
	public HashMap scorecardDetails(HashMap hshValues);
	public HashMap setScorecardDetails(HashMap hshValues);
	public HashMap getScorecardDetails(HashMap hshValues);
	public HashMap cbsIDCreationServiceNonInd(HashMap hshValues);
	public HashMap financialdigiratingCreation(HashMap hshValues);
	public HashMap getRatingHistory(HashMap hshValues);
	
	
}
