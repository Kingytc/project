package com.sai.laps.ejb.combanking;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface combankingRemote 
{
	public HashMap updateData(HashMap hsh);
	public HashMap getLoanData(HashMap hsh);
	public HashMap getRepayData(HashMap hsh);
	public void updateinsData(HashMap hsh);
	public HashMap getProductData(HashMap hsh);
	public void updateProduct(HashMap hsh);
	public HashMap getRawData(HashMap hsh);
	public void updateRaw(HashMap hsh);
	public HashMap getSupplyData(HashMap hsh);
	public void updateSupply(HashMap hsh);
	public HashMap getOtherData(HashMap hsh);
	public void updateOtherDetails(HashMap hsh);
	public HashMap getProcessData(HashMap hsh);
	public void updateProcess(HashMap hsh);
	public HashMap getDescData(HashMap hsh);
	public void updateDesc(HashMap hsh);
	public HashMap getStdData(HashMap hsh);
	public void updateStd(HashMap hsh);
	public HashMap getGovtData(HashMap hsh);
	public void updateGovt(HashMap hsh);
	public HashMap getTransData(HashMap hsh);
	public void updateTrans(HashMap hsh);
	public HashMap getMarketData(HashMap hsh);
	public void updateMarket(HashMap hsh);
	public HashMap getDistData(HashMap hsh);
	public void updateDist(HashMap hsh);
	public HashMap getCompData(HashMap hsh);
	public void updateComp(HashMap hsh);
	public HashMap getOrgData(HashMap hsh);
	public void updateOrg(HashMap hsh);
	public HashMap getEmpData(HashMap hsh);
	public void updateEmp(HashMap hsh);
	public HashMap getInfoData(HashMap hsh);
	public void updateInfo(HashMap hsh);
	public HashMap getSegmentData(HashMap hsh);
	public void updateSegment(HashMap hsh);
	public HashMap getMisData(HashMap hsh);
	public void updateMis(HashMap hsh);
	public HashMap getTotalLoan(HashMap hsh);
	public void updateLoan(HashMap hsh);	
	public HashMap getrangedeviation(HashMap hshValues);
	public void updaterangedeviation(HashMap hshValues);
	public HashMap getWCFacilitiesData(HashMap hshValues);
	
}