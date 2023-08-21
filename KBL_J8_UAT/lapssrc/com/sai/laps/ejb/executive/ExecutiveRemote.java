package com.sai.laps.ejb.executive;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface ExecutiveRemote 
{
	public HashMap getData(HashMap hshValues);
	public void updateData(HashMap hshValues);
	public HashMap getData2(HashMap hshValues);
	public void updateData2(HashMap hshValues);
	public HashMap getData3(HashMap hshValues);
	public void updateData3(HashMap hshValues);
	public HashMap getData4(HashMap hshValues);
	public void updateData4(HashMap hshValues);
	public HashMap getData5(HashMap hshValues);
	public void updateData5(HashMap hshValues);
	public HashMap getData6(HashMap hshValues);
	public void updateData6(HashMap hshValues);
	public HashMap getData7(HashMap hshValues);
	public void updateData7(HashMap hshValues);
	public HashMap getExecutivePrint(HashMap hshValues);
	public HashMap getData8(HashMap hshValues);
	public HashMap insertData(HashMap hshValues);
	public HashMap getDataList(HashMap hshValues);
	///public HashMap getCollateralSecurity(HashMap hshValues);
	///public void updateCollateralSecurity(HashMap hshValues);
	public HashMap getData9(HashMap hshValues);
	public void updateData9(HashMap hshValues);
	public HashMap getData10(HashMap hshValues);
	public void updateData10(HashMap hshValues);
	
	public HashMap getData11(HashMap hshValues);
	public void updateData11(HashMap hshValues);
	
	public HashMap getDataFinancial(HashMap hshValues);
	public void updateFinancial(HashMap hshValues);
	
	public HashMap getDataSRERatingDetails(HashMap hshValues);
	public void upDataSRERatingDetails(HashMap hshValues);
	public HashMap getShortReveiwPrint(HashMap hshValues);
	public HashMap getShortTermLoanPrint(HashMap hshValues);
	public HashMap getFinIndicatorComment(HashMap hshValues);
	public void updateFinIndicatorComment(HashMap hshValues); 
	public HashMap updateLoad(HashMap hshValues);
	public void updateGridObservationData(HashMap hshValues);
	public HashMap getGridObservationData(HashMap hshValues);
	public void updateImplnScheduleData(HashMap hshValues);
	public HashMap getImplnScheduleData(HashMap hshValues);
	public void updateRecommendationData(HashMap hshValues);
	public HashMap getRecommendationData(HashMap hshValues);
	public void updateDelegationData(HashMap hshValues);
	public HashMap getDelegationData(HashMap hshValues);
	public void updateAssessmentSelection(HashMap hshValues);
	public HashMap getAssessmentSelection(HashMap hshValues);
	public HashMap getTLWCFacilitiesData(HashMap hshValues); 
	public void updateRatificationComments(HashMap hshValues);
	public HashMap getRatificationComments(HashMap hshValues);	
	public HashMap getDataShareHoldPattern(HashMap hshValues);
	public void updateShareHoldPattern(HashMap hshValues);
	public HashMap getDataNatureOfShares(HashMap hshValues);
	public void updateNatureOfShares(HashMap hshValues);
	public HashMap getMDSanctiontoEC(HashMap hshValues);
	public void updateMDSanctiontoEC(HashMap hshValues);
	public HashMap getECBoardAnnexureVIII(HashMap hshValues);
	public void updCaptialMarketInfo(HashMap hshValues);
	public HashMap getCaptialMarketInfo(HashMap hshValues);
	public HashMap geteNWRassessment(HashMap hshValues);
	public void updateeNWRassessment(HashMap hshValues);

}