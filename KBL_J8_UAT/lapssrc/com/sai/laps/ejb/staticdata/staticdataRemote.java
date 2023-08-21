package com.sai.laps.ejb.staticdata;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface staticdataRemote 
{
	public void updateData(HashMap hshValues);
	public HashMap getData(HashMap hshValues);
	public HashMap getDataonselect(HashMap hshValues);
		
	public void updateLawyerMasterData(HashMap hshValues);
	public HashMap getLawyerMasterList(HashMap hshValues);

	public void updatenpaprovcoverpercnt(HashMap hshValues);
	public HashMap getnpaprovcoverpercnt(HashMap hshValues);
	
	public void updateMCLRMSMEmasterdata(HashMap hshValues);
	public HashMap getMCLRMSMEmasterdata(HashMap hshValues);
	
	public void updateValuerMasterData(HashMap hshValues);
	public HashMap getValuerMasterList(HashMap hshValues);
	
	public void updateBuilderMasterData(HashMap hshValues);
	public HashMap getBuilderMasterList(HashMap hshValues);
	
	public void updateCompanyMasterData(HashMap hshValues);
	public HashMap getCompanyMasterList(HashMap hshValues);
	
	public void updateCoopSocietyMasterData(HashMap hshValues);
	public HashMap getCoopSocietyMasterList(HashMap hshValues);
	
	public void updateCorpMasterList(HashMap hshValues);
	public HashMap getCorpMasterList(HashMap hshValues);
	
	//public void updateOccupationMasterData(HashMap hshValues);
	//public HashMap getOccupationMasterList(HashMap hshValues);
	
	//public void updateDesignationMasterData(HashMap hshValues);
	//public HashMap getDesignationMasterList(HashMap hshValues);
	
	public void updateRejectReasonMasterData(HashMap hshValues);
	public HashMap getRejectReasonMasterList(HashMap hshValues);
	
	public HashMap updateDataHouseParameters(HashMap hshValues);
	public HashMap getDataHouseParameters(HashMap hshValues);
	
	public void updateInstructions(HashMap hshValues);
	public HashMap getInstructionsData(HashMap hshRequestValues);
	
	public void updategeneralinfoData(HashMap hshValues);
	public HashMap getgeneralinfoData(HashMap hshValues);
	
	public void updateReject(HashMap hshValues);
	
//	public HashMap getBankReferenceList(HashMap hshValues);
	public HashMap getState(HashMap hshValues);
	
	public void updateDistrictMasterData(HashMap hshValues);
	public HashMap getDistrictMasterList(HashMap hshValues);
	public HashMap getDistrictMasterList1(HashMap hshValues);
	
	public void updateFinanceData(HashMap hshValues);
	public HashMap getFinanceData(HashMap hshValues);
	
	public HashMap  getaccountheld1(HashMap hshValues);
	
	public void updateCoffeeData(HashMap hshValues);
	public HashMap getCoffeeData(HashMap hshValues);
	public HashMap getflexState(HashMap hshValues);
	
	public HashMap getState1(HashMap hshValues);
	public void updateUGCData(HashMap hshValues);
	public HashMap getUGCData(HashMap hshValues);
	public HashMap getSancrefno(HashMap hshValues);
	public HashMap getGoldRateData(HashMap hshValues);
	public void updateGoldRateData(HashMap hshValues);
	public HashMap getSchemeCodeRangeCheck(HashMap hshValues);
	public void updateInterfaceSchemeData(HashMap hshValues);
	public HashMap getInterfaceSchemeData(HashMap hshValues);
	public void updateFreeCode(HashMap hshValues);
	public HashMap getFreeCode(HashMap hshValues);	
	public void updateCBSstaticdata(HashMap hshValues);
	public HashMap getCBSstaticdata(HashMap hshValues);
	
	//Added by Arsath for Plantation
	public void updateHorticultureFinanceMasterData(HashMap hshValues);
	public  HashMap getHorticultureFinanceMasterData(HashMap hshValues);
	
	//Added by Guhan T for Activity data
	public void updateActivityMasterData(HashMap hshValues);
	public  HashMap getActivityMasterData(HashMap hshValues);
	public void updateTypepoultrymastersdata(HashMap hshValues );
	public HashMap getTypepoultrymastersdata(HashMap hshValues);
	
	public HashMap getRatingCode(HashMap hshValues);
	public void updateRatingCode(HashMap hshValues);
	public HashMap getLawyerMaster_legal(HashMap hshValues);
	
	public HashMap getFVCMaster(HashMap hshValues);
	public HashMap getUserApplicationCount(HashMap hshValues);
	public HashMap getUserApplicationList(HashMap hshValues);
	public void updateFVCMaster(HashMap hshValues);
	public HashMap updateUserApplicationTransfer(HashMap hshValues);
	
	public void updateAFOSetBranchMaster(HashMap hshValues);
	public HashMap getAFOSetBranchMaster(HashMap hshValues);
	
	public HashMap updateAFOClusterBranchSelection(HashMap hshValues);
	public HashMap getAFOClusterBranchSelection(HashMap hshValues);
	
	public HashMap updateShareValueMasterData(HashMap hshValues);
	public HashMap getShareValueMasterData(HashMap hshValues);

	public void updateUserPageControl(HashMap hshValues);
	public HashMap getUserPageControl(HashMap hshValues);
	
	public HashMap getShareMasterHistory(HashMap hshValues);
	
	public void updateSMSMaster(HashMap hshValues);
	public HashMap getSMSMaster(HashMap hshValues);

	public void updateBSADSAmasterData(HashMap hshValues);
	public HashMap getBSADSAList(HashMap hshValues);
		
	public HashMap updatePostSancParameters(HashMap hshValues);
	public HashMap getPostSancParameters(HashMap hshValues);
	
	public HashMap getTownMasterList(HashMap hshValues);

	public void updateTownMasterData(HashMap hshValues);
	public HashMap getgeclidentification(HashMap hshValues);
	
	
	//==================added for BIR Master============================================//
	public void updateBIRmasterData(HashMap hshValues);
	public HashMap getBIRList(HashMap hshValues);
	public HashMap getBIRListprop(HashMap hshValues);
	public HashMap getNameofsectorgeclident(HashMap hshValues);
	public HashMap getValuerMasterListList(HashMap hshValues);
	public HashMap updateBSADmasterapi(HashMap hshValues);

	

	
	
	public HashMap getActivityDetails(HashMap hshValues) throws RemoteException;
	public HashMap getActivitySpecificationbtdetails(HashMap hshValues) throws RemoteException;
	
	public HashMap getDetailsActivitySpecifications(HashMap hshValues) throws RemoteException;
	
	public HashMap getmiborbranchlist(HashMap hshValues);
	public void updatemiborbranchlist(HashMap hshValues);



	
}
