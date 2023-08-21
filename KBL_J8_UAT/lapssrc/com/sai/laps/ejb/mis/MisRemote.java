package com.sai.laps.ejb.mis;

import java.rmi.RemoteException;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.EJBObject;
import javax.ejb.Remote;
@Remote
public interface MisRemote {
	
	//For MIS Static Data Master created by Venkat Prasad Chowdary on 23-07-2013
	public void updateMISstaticdata(HashMap hshValues);
	public HashMap getMISstaticdata(HashMap hshValues);
	public HashMap getMISMainSubActivity(HashMap hshValues);//Added for MIS Main & Sub Activity by Karthikeyan.S on 24/07/2013
	public HashMap updateMISMainSubActivity(HashMap hshValues);//Added for MIS Main & Sub Activity by Karthikeyan.S on 24/07/2013
	public HashMap getMISActivity(HashMap hshValues);
	public HashMap getMainActivitySearch(HashMap hshValues);
	public HashMap getMISActivityCodeDetails(HashMap hshValues);
	public HashMap updateMISActivityCodeDetails(HashMap hshValues);
	public HashMap getMainActCode(HashMap hshValues);
	public HashMap getMISDetails(HashMap hshValues);// Added for MIS Details By Karthikeyan.S on 07/08/2013
	public void updateMISDetails(HashMap hshValues);// Added for MIS Details By Karthikeyan.S on 07/08/2013
	public void updateMisClassification(HashMap hshValues);
	public HashMap getMisClassification(HashMap hshValues);
	public HashMap getFarmerCategoryData(HashMap hshValues);//Added for Farmer's Category By Karthikeyan.S on 08/08/2013
	public void updateFarmerCategoryData(HashMap hshValues);//Added for Farmer's Category By Karthikeyan.S on 08/08/2013
	public String getMISStaticDataDesc(String strID,String strCode);			//Added for MIS Static Data Description for Code By Karthikeyan.S on 09/08/2013
	public double getBorrowerTotalLimit(String strAppID, String strStatus);	//Added for calculating borrower total limit By Karthikeyan.S on 09/08/2013
	public double getClassiActivityMasterSum(String strAppID, String strType, String strPurpose);	//Added for calculating New priority type limits By Guhan.T on 07/08/2015
	public HashMap getAppFarmersCategory(HashMap hshValues);
	public HashMap getSubsector(HashMap hshValues);
	public HashMap getClassificationActivityMaster(HashMap hshValues);
	public void updateClassificationActivityMaster(HashMap hshValues);
	/*
	 * Added by prakash for MIS Classification
	 */
	public HashMap getMISAppClassification(HashMap hshValues);
	public HashMap getPriorityNonPriorityClassification(HashMap hshValues,String strValuesin);
	public HashMap getPriorityClassification(HashMap hshValues,String strValuesin);
	public HashMap getGovtAnnounceScheme(HashMap hshValues,String strValuesin);
	public boolean getConstitution(HashMap hshRecord);
	public boolean getLoanAmount(HashMap hshRecord);
	public boolean getLoanTenor(HashMap hshRecord);
	public boolean getPlantandMachinery(HashMap hshRecord);
	public boolean getFixedValue(HashMap hshRecord);
	public boolean getHLValue(HashMap hshRecord);
	public boolean getBranchLocation(HashMap hshRecord);
	public boolean getFarmerCategory(HashMap hshRecord);
	public boolean getGovernmentSponsersScheme(HashMap hshRecord);
	public boolean getSHGValue(HashMap hshRecord);
	public boolean getBankSchematicCode(HashMap hshRecord);
	public boolean getUtilizationCredit(HashMap hshRecord);
	public boolean getFamilyIncome(HashMap hshRecord);
	public boolean getTotalLimit(HashMap hshRecord);
	public boolean getAgriTotalLimit(HashMap hshRecord);
	public boolean getServiceTotalLimit(HashMap hshRecord);

	public boolean getCaste(HashMap hshRecord);
	public boolean getSecurityValue(HashMap hshRecord);
	public boolean getManagementGender(HashMap hshRecord);
	public boolean getGender(HashMap hshRecord);
	public boolean getDisplayScreen(HashMap hshRecord);
	//Added by BhanuPrasath for Displaying Activity Code while onload in application
	public HashMap getActivityCodebyApplication(HashMap hshValues);
	public boolean getSecurityCode(HashMap hshRecord);
	
	//Added by Guhan for CRE logic
	public boolean getCRE(HashMap hshRecord);
	//For Cost of the project
	public boolean getCostofConstruction(HashMap hshRecord);

	public HashMap getStandupIndia(HashMap hshValues,String strValuesin);
	public boolean getSalesTurnOver(HashMap hshValues);

	public boolean getStartUp(HashMap hshValues);
	public boolean getCarpetArea(HashMap hshValues);

	public boolean getFloorArea(HashMap hshValues);
	public boolean getSHGProposedLoan(HashMap hshValues);

	public boolean getIndividualHouse(HashMap hshValues);
	public boolean getMinority(HashMap hshValues);

	public boolean getMinorityCommunity(HashMap hshValues);
	public boolean getAliedAcivityDetails(HashMap hshRecord);
	
	public boolean getDwellingunit(HashMap hshRecord);
	public HashMap alliedgetMISActivityCodeDetails(HashMap hshValues);
	
}
