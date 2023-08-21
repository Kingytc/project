package com.sai.laps.ejb.NationalPortal;

import java.rmi.RemoteException;
import java.util.HashMap;
import java.util.Map;

import javax.ejb.EJBException;
import javax.ejb.EJBObject;
import javax.ejb.Remote;
@Remote
public interface NationalPortalRemote 
{
	public HashMap getNpMailbox(HashMap hshValues);
	public HashMap getNPDedupeChk(HashMap hshValues);
	public HashMap updateNPDedupeChk(HashMap hshValues) ;
	public HashMap getNPSearchList(HashMap hshValues);
	public HashMap getNPStatusUpdate(HashMap hshValues);
	public HashMap getNPInwardCreation(HashMap hshValues);
	public HashMap getNPAgriInwardCreation(HashMap hshValues) ;
	public HashMap getNPALiveliwoodInwardCreation(HashMap hshValues) ;
	public HashMap getNPCustProfileCreation(HashMap hshValues);
	public HashMap getNPAgriCustProfileCreation(HashMap hshValues) ;
	public HashMap getNPLiveliwoodCustProfileCreation(HashMap hshValues) ;
	public HashMap getNPApplicationCreation(HashMap hshValues);
	public HashMap getEmplyomentdetails(HashMap hshValues);
	public HashMap getFinancialITRDetails(HashMap hshValues);
	public HashMap getBREmatch(HashMap hshValues);
	public HashMap getInprincipleDetails(HashMap hshValues);
	public HashMap getNP_ApplicantDeatis(HashMap hshValues) ;
	public HashMap getNP_Education(HashMap hshValues) ;
	public HashMap getNP_Document(HashMap hshValues) ;
	public HashMap getNP_CourseDetails(HashMap hshValues) ;
	public HashMap getNP_CoApplicantDeatils(HashMap hshValues) ;
	public HashMap getNP_EligibilityDeatils(HashMap hshValues); 
	public HashMap getData(HashMap hshValues) ;
	
	
	
	public HashMap getAgriProjLoanDetails(HashMap hshValues) ;
	public HashMap getAGRIPersonalDetails(HashMap hshValues) ;
	public HashMap getNULMPersonalDetails(HashMap hshValues) ;
	public HashMap getBusstandindiapersonaldet(HashMap hshValues) ;
	public HashMap getBusmudragstdetails(HashMap hshValues) ;
	public HashMap getAssoConcernDetails(HashMap hshValues) ;
	public HashMap getBusstandindialoandet(HashMap hshValues) ;
	public HashMap getBusMudraloandetails(HashMap hshValues) ;
	public HashMap getBusmudrapersdetails(HashMap hshValues) ;	
	public HashMap getBusSWMSpersonaldetails(HashMap hshValues) ;
	public HashMap getBusSWMSloandetails(HashMap hshValues) ;
	public HashMap getPSB59NULMAddressDetails(HashMap hshValues) ;
	public HashMap getPSB59AddressDetails(HashMap hshValues) ;
	public HashMap getNULMLoanDetails(HashMap hshValues) ;
	public HashMap getEligibilityDetails(HashMap hshValues) ;
	public HashMap getBasicEligibilityDetails(HashMap hshValues) ;
	public HashMap getScalingDetails(HashMap hshValues) ; 
	public HashMap getScoringDetails(HashMap hshValues) ;
	public HashMap getBankDetails(HashMap hshValues) ; 
	public HashMap getPropertyDetails(HashMap hshValues) ;
	public HashMap getPSB59AllApplicationDetails(HashMap hshValues) ;
	public HashMap getPSB59SanctionDetails(HashMap hshValues);
	public HashMap updatePSB59SanctionDetails(HashMap hshValues);
	public HashMap updateMapCBSidforNationalPortal(HashMap hshValues);
	public HashMap PSB59getcbsidrecord(HashMap hshValues) ;
	public HashMap updatePSB59HoldRejStatus(HashMap hshValues) ; 
	public HashMap PSB59getHoldRejStatus(HashMap hshValues) ;
	public HashMap PSB59updatenpinbox(HashMap hshValues);
	public HashMap getNPInboxDetails(HashMap hshValues);
	public HashMap PSB59getPrincipleDetailsList(HashMap hshValues) ; 
	public HashMap getPSB59applicaionSearch(HashMap hshValues);
	public HashMap NP_viewAttachedDocument(HashMap hshValues);
	public HashMap updateReallocationList(HashMap hshValues) ; 
	public HashMap getReallocationList(HashMap hshValues);
	public HashMap PSB59getApplicationDetailsList(HashMap hshValues);
	public HashMap getBREMATCHDETAILS(HashMap hshValues);
	public HashMap getDOCDETAILS(HashMap hshValues) ;
	public HashMap getITRDETAILS(HashMap hshValues);
	public HashMap getPSB59CourseDtls(HashMap hshValues) ;
	public HashMap getPSB59CoapplicanrDtls(HashMap hshValues) ;
	public HashMap getPSB59ApplicantListDtls(HashMap hshValues) ;
	public HashMap getNPReportList(HashMap hshValues);
	public HashMap invokeUpdateSanctionAPI(HashMap hshValues); 
	public HashMap getNP_Dsibursment(HashMap hshValues); 
	public HashMap invokeUpdateDsibursmentAPI(HashMap hshValues) ; 
	public HashMap updateNP_Dsibursment(HashMap hshValues) ; 
	public HashMap NPAppnoSearch(HashMap hshRequestValues) ;
	public HashMap invokeProposalStatusAPI(HashMap hshValues) ;
	public HashMap getNPHLApplicationCreation(HashMap hshValues) ;
	public HashMap getNP_AgriApplicationCreation(HashMap hshValues);
	public HashMap Nationalportaldocdownload(HashMap hshValues) ;
	public HashMap getNPCustProfileCreation_BS(HashMap hshValues) ;
	public HashMap getNPApplicationCreation_BS(HashMap hshValues) ;
	public HashMap getNPBSInwardCreation(HashMap hshValues) ;
	
	public void updateNPReallocation(HashMap hshValues);
	
}