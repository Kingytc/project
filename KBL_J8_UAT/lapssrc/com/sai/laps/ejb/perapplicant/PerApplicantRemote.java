package com.sai.laps.ejb.perapplicant;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface PerApplicantRemote 
{
	public HashMap getLoanProducts(HashMap hshValues);
	public HashMap calculateAmortization(HashMap hshValues);
	public HashMap calcRepayment(HashMap hshValues);
	public HashMap calcRepayment1(HashMap hshValues);
	public HashMap updateAmortization(HashMap hshValues);
	public HashMap updateLoanProducts(HashMap hshValues);
	 
	public HashMap getPersonalSearch(HashMap hshValues);
	public HashMap getInterestTerms(HashMap hshValues);
	public HashMap getInterestRate(HashMap hshValues);
	public HashMap getStepupRate(HashMap hshValues);
	//public void updateOverDraft(HashMap hshValues);
	//public HashMap getOverDraft(HashMap hshValues);
	public void updateCoAppGuarantor(HashMap hshRequestValues);
	public HashMap getCoAppGuarantor(HashMap hshRequestValues);
	public HashMap getMargin(HashMap hshRequestValues);
	public void getFreezeData(HashMap hshValues);
	//public HashMap getPersonalLoandetails(HashMap hshRequestValues);
	//public void updatePersonalLoanData(HashMap hshValues);
	//public HashMap renewRetail(HashMap hshValues);
	//public void renewTranction(HashMap hshValues);
	//public HashMap getRenewData(HashMap hshValues);	
	//public HashMap getStepupData(HashMap hshRequestValues);
	//public void updateStepupData(HashMap hshValues);
	//public HashMap calculateStepUpAmortization(HashMap hshValues);
	//public void updateBranchQueriesData(HashMap hshRequestValues);
	//public HashMap getBranchQueriesList(HashMap hshValues);
	public HashMap getCoAppGuarantorCheck(HashMap hshRequestValues);
	//public HashMap getReviewDate(HashMap hsh);
	public HashMap getCoAppGuarantorType(HashMap hsh);
	public HashMap interfaceSanctionDetails(HashMap hsh);
	public HashMap checkEligibility(HashMap hshRequestValues);
	public HashMap getEqualInstallments(HashMap hshValues);

	public HashMap getSlabRateChart(HashMap hshValues);
	public HashMap getComboRateChart(HashMap hshValues);

	public HashMap getStaffservice(HashMap hshValues);
	public HashMap getGuarantorEligible(HashMap hshValues);
	public HashMap getNSCloancheck(HashMap hshValues);
	public HashMap updateSourceOfMargin(HashMap hshValues);
	public HashMap getSourceOfMargin(HashMap hshValues);
	public HashMap getApplicantIDHelp(HashMap hshValues);
	public void updateRepaymentCapacityValue(HashMap hshValues);
	public HashMap getApplicationSearchDetails(HashMap hshValues);
	public HashMap updateRetailApplicationRenew(HashMap hshValues);
	public void updatePerincomedetaildate(HashMap hshValues);
	public HashMap getdataPerincomedetaildate(HashMap hshValues);
	public String getCollateralpercent(String prdcode,String RecmdValue);	
	//Added by rajesh for SHG details on 26/02/2014
	public void updateShgdetails(HashMap hshValues);
	public HashMap getShgdetails(HashMap hshValues);

	//Added by Archunan for Lease details on 18/03/2014
	public void updateLeaseperiod(HashMap hshValues);
	public HashMap getLeaseperiod(HashMap hshValues);


	//added by bhaskar
	public HashMap getRetailrating(HashMap hshValues);
	
	public void updateRetailRating(HashMap hshValues);
	//added by punitha
	public  HashMap getinstacash(HashMap hshValues);
	public void updateinstacash(HashMap hshValues);
	public  HashMap getotherratingParameters(HashMap hshValues);
	public void updateotherratingParameters(HashMap hshValues);
	
	public  void updateAgricultureGold(HashMap hshValues);
	public HashMap getAgricultureGold(HashMap hshValues);
	
	public HashMap getCusGroupApplicantIDHelp(HashMap hshValues);
	public HashMap getCIBILReport(HashMap hshRequestValues);
	public HashMap getCIBILRegenerate(HashMap hshRequestValues);
	public HashMap updateDigiLoanProducts(HashMap hshRequestValues);
	//added by Nagappan
	public HashMap roiUpdateServices(HashMap hshValues);
	public HashMap enachcheckService(HashMap hshValues);
	public double getExposureTotalLimit(String strAppId,String strValuesIn,String strSessionModuleType) ;
	}
