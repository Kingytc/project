package com.sai.laps.webservices.rest.services;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.sai.laps.webservices.rest.domain.CustomerCreation;
import com.sai.laps.webservices.rest.domain.DedupeCheck;
import com.sai.laps.webservices.rest.domain.FetchProposals;
import com.sai.laps.webservices.rest.domain.FetchUserDetails;
import com.sai.laps.webservices.rest.domain.FinalInPrinciple;
import com.sai.laps.webservices.rest.domain.GenDmsUpd;
import com.sai.laps.webservices.rest.domain.GetGoldRate;
import com.sai.laps.webservices.rest.domain.GoldReappraiser;
import com.sai.laps.webservices.rest.domain.InwardDetails;
import com.sai.laps.webservices.rest.domain.OrganisationDetails;
import com.sai.laps.webservices.rest.domain.PreApprovedOffer;
import com.sai.laps.webservices.rest.domain.ProposalCreation;
import com.sai.laps.webservices.rest.domain.SecurityCreation;
import com.sai.laps.webservices.rest.domain.ServerStatus;
import com.sai.laps.webservices.rest.domain.StatusCheck;
import com.sai.laps.webservices.rest.domain.UserClosure;
import com.sai.laps.webservices.rest.domain.UserCreation;
import com.sai.laps.webservices.rest.domain.UserUpdation;
import com.sai.laps.webservices.rest.domain.Userdesignation;
import com.sai.laps.webservices.rest.domain.ValuerList;
import com.sai.laps.webservices.rest.domain.msme.RenewalProposals;
import com.sai.laps.webservices.rest.domain.Birdata;

public interface InwardDetailService {
	
	public String saveInwardDetails(InwardDetails inwarddetails) throws JsonProcessingException;
	public String dedupeCheck(DedupeCheck DedupeCheck) throws JsonProcessingException;
	public String customerCreation(CustomerCreation CustomerCreation) throws JsonProcessingException;
	public String proposalCreation(ProposalCreation ProposalCreation) throws JsonProcessingException;
	public String preApprovedOfferService(PreApprovedOffer preApprovedOffer) throws JsonProcessingException;
	public String preApprovedOfferServiceApp(PreApprovedOffer preApprovedOffer) throws JsonProcessingException;
	public String handleSecurityDetails(SecurityCreation securityCreation) throws JsonProcessingException;
	public String handleStatusDetails(StatusCheck StatusCheck)throws JsonProcessingException;
	public String accountOpeningTriggerService(StatusCheck StatusCheck)throws JsonProcessingException;
	public String mclrService(StatusCheck StatusCheck)throws JsonProcessingException;
	public String dosanction(StatusCheck StatusCheck)throws JsonProcessingException;
	public String cbsBreService(PreApprovedOffer preApprovedOffer)throws JsonProcessingException;
	public String autoloanDedupeCheck(DedupeCheck DedupeCheck)throws JsonProcessingException;
	public String autoLoanproposalCreation(ProposalCreation proposalCreation)throws JsonProcessingException;
	public String userOrganisationDetail(StatusCheck statusCheck) throws JsonProcessingException;
	public String hunterService() throws JsonProcessingException;
	public String valuerListService(ValuerList valuerList) throws JsonProcessingException;
	public String larInwardreg(ProposalCreation ProposalCreation) throws JsonProcessingException;
	public String renewalProposalsRetails(RenewalProposals RenewalProposals) throws JsonProcessingException;
	public String FetchProposalsService(FetchProposals fetchProposals) throws JsonProcessingException;
	public String FetchUserDetailsService(FetchUserDetails fetchUserDetails) throws JsonProcessingException;
	public String FetchUserOrganisationsDetailsService(StatusCheck statusCheck) throws JsonProcessingException;
	public String CronServerStatus(ServerStatus serverStatus) throws JsonProcessingException;
	public String FinalinPrinciple(FinalInPrinciple finalinprinciple) throws JsonProcessingException;
	public String GenDmsupd(GenDmsUpd gendmsupd) throws JsonProcessingException;
	public String organisationDetails(OrganisationDetails organisationDetails) throws JsonProcessingException;
	public String BsaDsaMaster(ArrBsadsaMaster arrBsadsaMaster) throws JsonProcessingException;

	public String Birdata(Birdata Birdata) throws JsonProcessingException;

	public String getgoldrate(GetGoldRate goldrate) throws JsonProcessingException;
	public String getjewelappraiserslist(OrganisationDetails orgcode) throws JsonProcessingException;
	public String dogoldreappraiser(GoldReappraiser golddetails) throws JsonProcessingException;
	public String perappid(CustomerCreation CustomerCreation) throws JsonProcessingException;
	public String usertransfer(UserUpdation usertransferdetails) throws JsonProcessingException;
	public String useravailability(UserClosure useravailabilitydetails) throws JsonProcessingException;
	public String userDesignationupdate(Userdesignation Designationdetails) throws JsonProcessingException;
	public String usercreation(UserCreation userdetails) throws JsonProcessingException;
}
