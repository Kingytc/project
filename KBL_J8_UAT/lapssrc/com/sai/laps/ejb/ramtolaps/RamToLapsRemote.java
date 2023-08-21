package com.sai.laps.ejb.ramtolaps;

import java.rmi.RemoteException;
import java.util.HashMap;

import javax.ejb.EJBObject;
import javax.ejb.Remote;
@Remote
public interface RamToLapsRemote  
{		
	public HashMap RAMtoLAPS_REPORT(HashMap hshValues);	
	public HashMap RAMtoLAPS_REPORT_IRBID(HashMap hshValues);
	public HashMap ramtolaps_sectormaster(HashMap hshValues);
	public HashMap ramtolaps_marketsegmentmaster(HashMap hshValues);
	public HashMap ramtolaps_assetclassmaster(HashMap hshValues);
	public HashMap ramtolaps_countrymaster(HashMap hshValues);
	public HashMap ramtolaps_RBIindustrymaster(HashMap hshValues);
	public HashMap ramtolaps_retailscoring(HashMap hshValues);
	public HashMap ramtolaps_IRBRating(HashMap hshValues);
	public HashMap ramtolaps_IRBRating_IRBID(HashMap hshValues);
	//public HashMap startInterface(HashMap hashmap);
	
}
