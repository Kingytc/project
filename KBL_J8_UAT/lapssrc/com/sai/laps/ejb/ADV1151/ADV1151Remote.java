package com.sai.laps.ejb.ADV1151;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface ADV1151Remote 
{
	//public void updateCollateralSecurity(HashMap hshValues); 
	//public HashMap getCollateralSecurity(HashMap hshValues); 
	public void updateadvBorrowingPower(HashMap hsh);      
	public HashMap getadvBorrowingPower(HashMap hsh);
	public void updateLegalheirs(HashMap hsh);      
	public HashMap getLegalheirs(HashMap hsh);
	public void updateComments(HashMap hshValues); 
	public HashMap getComments(HashMap hshValues); 
	public void updateconnectedaccts(HashMap hshValues); 
	public HashMap getconnectedaccts(HashMap hshValues); 
	public void updateMeansCapital(HashMap hsh);      
	public HashMap getMeansCapital(HashMap hsh);
	public void updateTermdepoits(HashMap hsh);
	public HashMap getTermdepoits(HashMap hsh);
	public HashMap getTurnover(HashMap hsh);
	public void updateTurnover(HashMap hsh);
	public void updateADVLiabilities(HashMap hshValues);
	public HashMap getADVLiabilities(HashMap hshValues);
	//public void updateADVMarketBorrowing(HashMap hshValues);
	//public HashMap getADVMarketBorrowing(HashMap hshValues);
	public void updateADVDocument(HashMap hshValues);
	public HashMap getADVDocument(HashMap hshValues) ;
	public void updateADVBorrowerExp(HashMap hshValues);
	public HashMap getADVBorrowerExp(HashMap hshValues);
	//public void updateAuditObservations(HashMap hshValues);
	//public HashMap getAuditObservations(HashMap hshValues);
	public HashMap getGuranteedetails(HashMap hsh);
	public void updateGuranteedetails(HashMap hsh);
	public void updateworkingcapital(HashMap hshRequestValues);
	public HashMap getworkingcapital(HashMap hshValues);
	public void updatedishonours(HashMap hshRequestValues);
	public HashMap getdishonours(HashMap hshValues);
	public void updatecommentsonstatus(HashMap hshRequestValues);
	public HashMap getcommentsonstatus(HashMap hshValues);
	public void updatetermloancomments(HashMap hshRequestValues);
	public HashMap gettermloancomments(HashMap hshValues);
	public void updateotherbank(HashMap hshRequestValues);
	public HashMap getotherbank(HashMap hshValues);
	public void updateworkingcapitalcomments(HashMap hshValues);
	public HashMap getworkingcapitalcomments(HashMap hshValues);
	public void updateDepositAccounts(HashMap hshValues);
	public HashMap getDepositAccounts(HashMap hsh);
	
	public void updatePurchaseDetails(HashMap hshValues);
	public HashMap getPurchaseDetails(HashMap hsh);
	
	public void updateGeneralComments(HashMap hshValues);
	public HashMap getGeneralComments(HashMap hshValues);

	public HashMap getDataFinancials(HashMap hshValues);
	public HashMap insertData(HashMap hshValues);
	
	public HashMap getADVPrint(HashMap hshValues);


}