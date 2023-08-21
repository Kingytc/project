package com.sai.laps.ejb.mastapplicant;

import java.rmi.RemoteException;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.EJBObject;
import javax.ejb.Remote;

import com.sai.fw.business.entities.User;
@Remote
public interface MastApplicantRemote 
{
	public HashMap getCGTMSEConstitution(HashMap hshValues);
	public HashMap getMasterSearch(HashMap hshValues);
	public HashMap getDemographics(HashMap hshValues);
	public HashMap updateDemographics(HashMap hshValues);
	public void deleteDemographics(HashMap hshValues);
	public HashMap getIncome(HashMap hshValues);
	public HashMap updateIncome(HashMap hshValues);
	public HashMap getEmployer(HashMap hshValues);
	public HashMap updateEmployer(HashMap hshValues);
	public HashMap renewApplicantData(HashMap hshValues);
	public HashMap getOrgList(HashMap hshRequestValues);
	public HashMap getCodeList(HashMap hshRequestValues);
	public HashMap getAppList(HashMap hshRequestValues);
	//public HashMap getReports(HashMap hshValues);
	//public HashMap getEmployerMedic(HashMap hshValues);
	//public HashMap updateEmployerMedic(HashMap hshValues);
	//public HashMap getFinData(HashMap hshValues);
	//public HashMap getFinProfitData(HashMap hshValues);
	//public void updateFinData(HashMap hshRequestValues);
	//public void updateFinProfitData(HashMap hshRequestValues);
	public HashMap getOpeViability(HashMap hshValues);
	public void updateOpeViability(HashMap hshRequestValues);
	public HashMap getCitySearch(HashMap hshValues);
	public HashMap getCitySearchList(HashMap hshValues);
	public HashMap getCityDetails(HashMap hshValues);
	public HashMap  updateCityDetails(HashMap hshValues);
	public boolean updateDemographicsApplicantPhoto(HashMap hshValues);
	public HashMap getdemographicsphoto(HashMap hshValues);
	public HashMap getexapplicantcheck(HashMap hshValues);
	
	public HashMap getbpldetails(HashMap hshValues);
	public void updatebpldetails(HashMap hshValues);
	
	public HashMap getBranchSearchList(HashMap hshValues);
	
	public HashMap getKYCNormsdetails(HashMap hshValues);
	public void updateKYCNormsdetails(HashMap hshValues);
	
	public HashMap getCountrySearchList(HashMap hshValues);

	
	public HashMap updateAddressDetails(HashMap hshValues);
	public HashMap getAddressDetails(HashMap hshValues);
	
	public HashMap updateRating(HashMap hshValues);
	public HashMap getRating(HashMap hshValues);
	
	public HashMap updateDefaulter(HashMap hshValues);
	public HashMap getDefaulter(HashMap hshValues);
	
	public  HashMap getCustomerProfileStatus(HashMap hshValues);
	
	//Added by Arsath on 22/07/2013 for District Search
	public HashMap getDistrictSearch(HashMap hshValues);
	//End
	public String getCityDistrictStateDesc(String strType, String strCode);
	public String getMasterDesc(String strType, String strID, String strCode);
	
	//Added by Guhan.T for CBS ID validation
	public HashMap getValidCBSId(HashMap hshValues);
	
	public void updateLandbuild(HashMap hshRequestValues);
	public HashMap getLandbuild(HashMap hshValues);

	//Added for Other Bank details page by Rajesh on 06/02/2014
	public void updateBankdetail(HashMap hshRequestValues);
	public HashMap getBankdetail(HashMap hshValues);
	public HashMap getConsBankdetail(HashMap hshValues);
	public void updateConsBankdetail(HashMap hshRequestValues);
	
	//Added for Financial by Rajesh on 30/06/2014
	public HashMap getfinancialSearch(HashMap hshValues);
	
	//Added for Solvency by Ramprasad on 30/09/2014
	public HashMap getSolvencySearch(HashMap hshValues);
	
	
	public HashMap updateCusGroupMgmt(HashMap hshValues);
	public HashMap getCusGroupMgmt(HashMap hshValues);
	
	public void updateCusGroupMembersMgmt(HashMap hshValues);
	public HashMap getCusGroupMembersMgmt(HashMap hshValues);
	public HashMap updateCustomerProfileGroupMembers(HashMap hshValues);
	
	public HashMap getsecuritydet(HashMap hshValues);
	public HashMap getdepositdet(HashMap hshValues);
	public HashMap getExistingFacDet(HashMap hshValues);
	public HashMap getBankerSearch(HashMap hshValues);
	
	public void updSvanidhiDetails(HashMap hshValues);
	public HashMap getSvanidhiDetails(HashMap hshValues);
	// added for Banker's certificate module on 18/11/2020
	

}
