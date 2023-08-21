package com.sai.laps.ejb.govtsponschklist;

import java.rmi.RemoteException;
import java.util.HashMap;

import javax.ejb.*;

@Remote
public interface GovtSponsChkListRemote 
{		
	public void updategovtsponsData(HashMap hshValues);
	public HashMap getgovtsponsData(HashMap hshValues);
	
	public HashMap getgovtQuestParameters(HashMap hshValues);
	public void updategovtQuestParameters(HashMap hshValues);
	
	public void updategovtsponsparameters(HashMap hshValues);
	public HashMap getgovtsponsparameters(HashMap hshValues);
	
	public HashMap checkeligibityforgovtsponsor(HashMap hshValues);
	
}