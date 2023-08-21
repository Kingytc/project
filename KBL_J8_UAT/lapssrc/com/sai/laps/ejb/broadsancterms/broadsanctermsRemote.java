package com.sai.laps.ejb.broadsancterms;

import java.rmi.RemoteException;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.EJBObject;
import javax.ejb.Remote;
@Remote
public interface broadsanctermsRemote 
{
	public HashMap getData(HashMap hshValues);
	public void updateBroadTermsProposalFinancial(HashMap hshValues);
	public HashMap getBroadTermsProposalFinancial(HashMap hshValues);
	
	public void updateBroadTermsProposalComments(HashMap hshValues);
	public HashMap getBroadTermsProposalComments(HashMap hshValues);
	
	public void updateBSTCustProfitData(HashMap hshValues);
	public HashMap getBSTCustProfitData(HashMap hshValues);
	
	public HashMap updateBSTCustomerDetailsData(HashMap hshValues);
	public HashMap getBSTCustomerDetailsData(HashMap hshValues);
	
	public HashMap getBSTCustomerList(HashMap hshValues);
	
	public HashMap updateBSTfacility(HashMap hshValues);
	public HashMap getBSTfacility(HashMap hshValues);
	
	public HashMap getBSTApprovalprint(HashMap hshValues);
	
	public HashMap getBSTHistory(HashMap hshValues);
	public HashMap getBSTAction(HashMap hshValues);
	public HashMap updateBSTAction(HashMap hshValues);
	
	public void updateBSTComments(HashMap hshValues);
	public HashMap getBSTComments(HashMap hshValues);
	
	public void updateBSTSecurity(HashMap hshValues);
	public HashMap getDataBSTSecurity(HashMap hshValues);
	
	public HashMap getBSTAppnoData(HashMap hshValues);
	
	public void updateOrgrecmds(HashMap hshValues);
	public HashMap getOrgrecmds(HashMap hshValues);
	public void updateBankingArrangementData(HashMap hshValues);
	public HashMap getBankingArrangementData(HashMap hshValues);
	public void updateCreditFacilitiesData(HashMap hshValues);
	public HashMap getCreditFacilitiesData(HashMap hshValues);
	public void updateDefaultersListData(HashMap hshValues);
	public HashMap getDefaultersListData(HashMap hshValues);
	
}