package com.sai.laps.ejb.lapstoram;

import java.rmi.RemoteException;
import java.util.HashMap;

import javax.ejb.EJBObject;
import javax.ejb.Remote;
@Remote
public interface LapsToRamRemote  
{
	
//FOR RETAIL CUSTOMER PROFILE UNION MILES...... 
	
	public HashMap createRCustomerFlatFile(HashMap map);
	public HashMap createELoanModelFlatFile(HashMap map);
	
	//FOR CORPORATE COMPANY MAST......

	public HashMap companyMaster(HashMap map);
	public HashMap retailCompanyMaster(HashMap map);
	public HashMap industryMaster(HashMap map);
	public HashMap groupMaster(HashMap map);
	
	//FOR FINANCIAL
	public HashMap ProjectFinancialInput(HashMap map);
	public HashMap LargeCorporateModel(HashMap map);
	public HashMap RealEstateModel(HashMap map);
	public HashMap NbfcModel(HashMap map);
	public HashMap BankModel(HashMap map);
	public HashMap InfraStructureModel(HashMap map);
	public HashMap OperationsPhase(HashMap map);
	public HashMap BrokerModel(HashMap map);
	public HashMap SimplifiedFinancial(HashMap map);
	public HashMap startInterface(HashMap map);
	public HashMap getRAMParameters(HashMap map);
	
	//added by Kamal 
	public HashMap createSecurityMaster(HashMap map);
	public HashMap createChargeMaster(HashMap map);
	public HashMap createFacilityMaster(HashMap map);
	
	public HashMap createFacilityDetails(HashMap map);
	public HashMap createSecurityDetails(HashMap map);
	public HashMap createChargeDetails(HashMap map);
	
	
}
