package com.sai.laps.securitymaster;

import java.rmi.RemoteException;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.EJBObject;
import javax.ejb.Remote;
@Remote
public interface SecurityMasterRemote  {
	
	public HashMap getSecurityMaster (HashMap hshValues);
	public HashMap updateSecurityMaster(HashMap hshValues);

    
    public void updateFurnitures(HashMap hshValues);
    public HashMap getFurnitures(HashMap hshValues);
    
    public void updateJewelDetail(HashMap hshValues);
    public HashMap getJewelDetail(HashMap hshValues);
    
    public HashMap updateTitleGoods(HashMap hshValues);
    public HashMap getTitleGoods(HashMap hshValues);
    
    public void updatePlantMachinery(HashMap hshValues);
    public HashMap getPlantMachinery(HashMap hshValues);

    public void updatePropertyDetData(HashMap hshRequestValues);
    public HashMap getPropertyDetData(HashMap hshRequestValues);
    public HashMap getSecurityClassification(HashMap hshRequestValues);
    public void updateSecurities(HashMap hshRequestValues);
    public HashMap getSecurities(HashMap hshRequestValues);
    public HashMap getJointSecurity(HashMap hshRequestValues);

    public void updateFinDocNonTradeable(HashMap hshValues);
    public HashMap getFinDocNonTradeable(HashMap hshValues);
    public void updateFinDocTradeable(HashMap hshValues);
    public HashMap getFinDocTradeable(HashMap hshValues);
    public void updateSecurityVehicle(HashMap hshValues);
    public HashMap getSecurityVehicle(HashMap hshValues);
    public void updateSecurityBankDeposit(HashMap hshValues);
    public HashMap getSecurityBankDeposit(HashMap hshValues);
    public void updateNetSecurityValue(String strSecID,String strSecValue);
    
    public HashMap getScoringParameters (HashMap hshValues); 
    public HashMap updateScoringParameters (HashMap hshValues);
    
    public HashMap getSecurityValuesDetails (HashMap hshValues); 
    public HashMap getSecuritiesbySecId (HashMap hshValues); 
    
    public void updateSecurityValuesDetails (HashMap hshValues);
    
    public HashMap getattachSecurity(HashMap hshValues);
    public HashMap getAttachedSecurityDetails(HashMap hshValues);
    public void updateAttachedSecurityDetails(HashMap hshValues);
    public HashMap getSecCollateralCoverage(HashMap hshValues);
    public HashMap getCollateralSecurityDisplay(HashMap hshValues);
    public HashMap getCollateralSecurityDisplayretail(HashMap hshValues);
    public HashMap getCollateralSecurityDisplaynew(HashMap hshValues);
    
    public void updateLegalOpinion(HashMap hshRequestValues);
    public HashMap getLegalOpinion(HashMap hshRequestValues);
    public void updateReleaseofSecurity(HashMap hshRequestValues);
    public HashMap getReleaseofSecurity(HashMap hshValues);
    public HashMap getRatingExposurecorp(HashMap hshValues);
    public HashMap getRatingExposureretail(HashMap hshValues);

    public HashMap updateSecurityOwnerChange(HashMap hshRequestValues);
    public HashMap getSecurityOwnerChange(HashMap hshRequestValues);
    public HashMap getData(HashMap hshRequestValues);
    public HashMap updateDocumentMaster(HashMap hshValues);
    public HashMap getDocumentMaster(HashMap hshValues);
    public HashMap getSecAttachedData(HashMap hshValues); 
    public HashMap getSecModifiedHisData(HashMap hshValues); 
    public HashMap getSecurityApproval(HashMap hshValues); 
    public HashMap updateSecurityApproval(HashMap hshValues); 
    public HashMap getMDTDattachedSec(HashMap hshValues); 
    public void  updateMDTDAttachedsec(HashMap hshValues); 
    public void  DetachSecurities(HashMap hshValues);
    public HashMap updateSecurityCrop(HashMap hshValues); 
    public HashMap getSecurityCrop(HashMap hshValues); 
    
    public HashMap getLiveStock(HashMap hshValues);
    public void updateLiveStock(HashMap hshValues);
    public HashMap getLiveStockDet(HashMap hshValues);
    public void updateLiveStock_det(HashMap hshValues);
    public void updateSecurityStock(HashMap hshValues);
    public HashMap getSecurityStock(HashMap hshValues);
    public HashMap getcersaiIDCheckDuplicate(HashMap hshValues);
    
    public void updateSecurityMovement(HashMap hshValues);
    public HashMap getSecurityMovement(HashMap hshValues);
    
    public HashMap getcropType(HashMap hshValues);
    public HashMap updateAgriunitcostMaster(HashMap hshValues);
    public HashMap getAgriunitcostMaster(HashMap hshValues) ;
}

