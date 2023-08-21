package com.sai.laps.ejb.FinacleBean;

import java.rmi.RemoteException;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.EJBObject;
import javax.ejb.Remote;
@Remote
public interface FinacleRemote  
{
	//public HashMap OneTime_CC_TL_OD_Details(HashMap map);
	//public HashMap OneTime_Bills(HashMap hshValues);
	//public HashMap OneTime_Guarantee(HashMap map);
	//public HashMap OneTime_LC(HashMap hshValues);
	//public HashMap daily_OD_CC_TL_Details(HashMap hashmap);
	//public HashMap daily_Guarantee(HashMap map);
	//public HashMap daily_CCPC_Details(HashMap map);
	//public HashMap daily_bills_Details(HashMap map);
	//public HashMap daily_letterofcredit_Details(HashMap map);
	//public HashMap Finacle_CBSCUSTID_CBSAccountNo(HashMap hshValues);
	//public HashMap NPAPromoter(HashMap hshValues);
	//public HashMap NPASecurities(HashMap hshValues);
	//public HashMap NPABasic(HashMap hshValues);
	//public HashMap NPADocument(HashMap hshValues);
	//public HashMap NPAPresentPosition(HashMap hshValues);
	//public HashMap mondbcreader(HashMap hshValues);
	//public HashMap moninterestreader(HashMap hshValues);
	//public HashMap monpackingcreditreader(HashMap hshValues);
	//public HashMap moninstallmentsreader(HashMap hshValues);
	//public HashMap monletterofcreditreader(HashMap hshValues);
	//public HashMap mondocumentregister(HashMap hshValues);
	//public HashMap MONBills(HashMap hshValues);
	//public HashMap MonLimitRegister(HashMap hshValues);
	//public HashMap MonPersonalProfile(HashMap hshValues);   
	//public HashMap MONGuarantee(HashMap hshValues);
	//public HashMap MONInsurance(HashMap hshValues);
	//public HashMap MonFundBased(HashMap hshValues);
	//public HashMap MonConsortium(HashMap hshValues);
	//public HashMap Finacledailyupload(HashMap hshValues);
	
	//public HashMap CustomerProfile(HashMap map);
	
	public HashMap SanctionDetails(HashMap map);
	public HashMap corporateSanctionDetails(HashMap map);
	public HashMap CoporateCustomerProfile(HashMap map);	
	public HashMap getadditionalParameter1(HashMap map);
	public HashMap updateadditionalParameter1(HashMap map);
	public HashMap  AppStatusFileGeneration(HashMap hashmap);
	public HashMap  monBankTypeFlatFile (HashMap hashmap);
	public HashMap  getPreDisbursementflatfileData(HashMap hshValues);
	public HashMap SuitFileGeneration (HashMap hashmap);
	public HashMap advanceAccountGeneration (HashMap hashmap);
	
	public HashMap getCBSDetails(HashMap hshValues);
	public void updateCBSDetails(HashMap hshValues);
	public HashMap getFreeCodeData(HashMap hshValues);

	public HashMap getAccountFlatFileReport(HashMap hshValues);
	public HashMap getOtherFlatFileReport(HashMap hshValues);
	public HashMap getOtherFlatFileReportCorpAgri(HashMap hshValues,String strFacilitySno);
	public HashMap getODFlatFileReport(HashMap hshValues);
	public HashMap getODFlatFileReportCorpAgri(HashMap hshValues,String strFacilitySno);
	public HashMap getAccountFlatFileReportCorpAgri(HashMap hshValues);
}
