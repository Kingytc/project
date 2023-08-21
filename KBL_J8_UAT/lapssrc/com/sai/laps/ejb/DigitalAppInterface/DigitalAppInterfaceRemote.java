package com.sai.laps.ejb.DigitalAppInterface;

import java.rmi.RemoteException;
import java.util.HashMap;
import javax.ejb.EJBObject;
import javax.ejb.Remote;

@Remote
public interface DigitalAppInterfaceRemote  {
	
	public HashMap updateInwardDetails(HashMap hshValues);	
	public HashMap dedupeCheck(HashMap hshValues);	
	public HashMap customerCreation(HashMap hshValues);	
	public HashMap ProposalCreation(HashMap hshValues);	
	public HashMap preApprovedOfferService(HashMap hshValues);
	public HashMap preApprovedOfferServiceApp(HashMap hshValues);
	public HashMap proposalCreationForHL(HashMap hshValues);
	public HashMap updateSecurityDetails (HashMap hshValues);
	public HashMap cbsIDCreationService(HashMap hshValues);
	public HashMap custIdVerification(HashMap hshValues);
	public HashMap cbsIdModificationService(HashMap hshValues);
	public HashMap custIdPanModification(HashMap hshValues);
	public String genrateURL(String docurl,String strDocType);
	public HashMap readTableFromServer(HashMap hshValues);
	public void pushDocumentService(HashMap hshVal);
	public HashMap uploadFileToServer(HashMap hshValues);
	public HashMap handleStatusDetails(HashMap hshValues);
	public HashMap getDigiDeviationDetail (HashMap hshValues);
	public HashMap updateDigiDeviationDetail(HashMap hshValues);	
	public HashMap getDigiDecisionDetail(HashMap hshValues);	
	public HashMap updateSubmitData(HashMap hshValues);	
	public HashMap updateSanctionDetails(HashMap hshValues);	
	public HashMap getDocumentURLs(HashMap hshValues);	
	public HashMap getDocumentDetailsdigi(HashMap hshValues);	
	public HashMap cbsBreService(HashMap hshValues);	
	public HashMap getdigi_FIKYCpending(HashMap hshValues);	
	public HashMap loanAccountCreationService(HashMap hshValues);	
	public HashMap autoLoanDedupeCheck(HashMap hshValues);	
	public HashMap autoLoanproposalCreation(HashMap hshValues);
	public HashMap userOrganisationDetail(HashMap hshValues);
	public HashMap hunterService(HashMap hshValues);
	public HashMap updateEligibility(HashMap hshValues);
	public HashMap cbsIdUnderVerification(HashMap hshValues);
	public HashMap breCallFourService(HashMap hshValues); 
	public HashMap applicationDedupe(HashMap hshValues); 
	public HashMap amberRule(HashMap hshValues);
	public HashMap proposalCreationForPB(HashMap hshValues);
	//public HashMap roiUpdateServices(HashMap hshValues);
	public HashMap valuerListService(HashMap hshValues);
	public HashMap larInwardreg(HashMap hshValues);
	public HashMap renewalProposalRetails(HashMap hshValues);
	public HashMap fetchProposalsService(HashMap hshValues);
	public HashMap proposalCreationForPM(HashMap hshValues);
	//public HashMap getDocURLs(HashMap hshValues);
	public HashMap fetchUserDetails(HashMap hshValues);
	public HashMap UCICExecuteService(HashMap hshValues);
	public HashMap fetchUserOrganisationsDetails(HashMap hshValues);
	public HashMap IFSCcodeCheck(HashMap hshValues);
	public HashMap IFSCcodeLapsCheck(HashMap hshValues);
	public HashMap FinalInPrinciple(HashMap hshValues);
	public HashMap GenDmsUpd(HashMap hshValues);
	public HashMap organisationDetails(HashMap hshValues);
	public HashMap updateDMSAppNo(HashMap hshValues);
	public HashMap proposalCreationForPJ(HashMap hshValues);
	public HashMap proposalCreationForPD(HashMap hshValues);	
	public HashMap Birdataapi(HashMap hshValues);
	public HashMap goldratedetails(HashMap hshValues) ;
	public HashMap fetchjewelappraiserlist(HashMap hshValues);
	public HashMap dogoldreappraiser(HashMap hshValues) ;
	public HashMap perappidcreation(HashMap hshValues) ;
	public HashMap usertransfer(HashMap hshValues) ;
	public HashMap useravailability(HashMap hshValues) ;
	public HashMap userDesignationupdate(HashMap hshValues) ;
	public HashMap Usercreation(HashMap hshValues) ;
	
}
