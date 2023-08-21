package com.sai.laps.webservices.rest.services.msme;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.sai.laps.webservices.rest.domain.msme.CreditAppraisalModule;
import com.sai.laps.webservices.rest.domain.msme.FacilityProposal;
import com.sai.laps.webservices.rest.domain.msme.FinancialDigiRating;
import com.sai.laps.webservices.rest.domain.msme.MsmeCustomerCreation;
import com.sai.laps.webservices.rest.domain.msme.MsmeDedupeCheck;
import com.sai.laps.webservices.rest.domain.msme.BasicInformationCust;

import com.sai.laps.webservices.rest.domain.msme.MsmeLarService;
import com.sai.laps.webservices.rest.domain.msme.RenewalProposals;


public interface MsmeService {

	public String msmeLarCreation(MsmeLarService msmeLarService) throws JsonProcessingException;
	public String msmeRenewalProposals(RenewalProposals RenewalProposals) throws JsonProcessingException;
	public String msmeCustomerCreationService(MsmeCustomerCreation msmeCustomerCreation) throws JsonProcessingException;
	public String msmeDedupeCheckService(MsmeDedupeCheck msmeDedupeCheck) throws JsonProcessingException;
	public String basicInformationCust(BasicInformationCust BasicInformationCust) throws JsonProcessingException;

	public String collateralService(BasicInformationCust basicInformationCust) throws JsonProcessingException;

	
	public String msmeRenewalDedupeService(BasicInformationCust BasicInformationCust) throws JsonProcessingException;
	public String msmeFinancialCMAService(BasicInformationCust basicInformationCust) throws JsonProcessingException;
	public String msmeFacilityProposal(FacilityProposal facilityProposal) throws JsonProcessingException;
	public String msmeFinacialCreation(FacilityProposal facilityProposal) throws JsonProcessingException;
	public String msmeRenewalFacilityProposal(FacilityProposal facilityProposal) throws JsonProcessingException;
	public String camService(CreditAppraisalModule creditAppraisalModule) throws JsonProcessingException;
	public String msmeFinacialDigiRatingCreation(FinancialDigiRating financialDigiRating) throws JsonProcessingException;
	public String basicInfoffromLaps(BasicInformationCust basicInformationCust) throws JsonProcessingException;
	
}
