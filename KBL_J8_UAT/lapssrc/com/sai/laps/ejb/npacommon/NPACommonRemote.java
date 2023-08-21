package com.sai.laps.ejb.npacommon;
import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface NPACommonRemote 
{
	public HashMap getGeneralinfoData(HashMap hshValues);
	public HashMap updateGeneralinfoData(HashMap hshValues);
	
	public void updateotherbankdues(HashMap hshValues);
	public HashMap getotherbankdues(HashMap hshValues);
	
	public void updatesisterconcernsdata(HashMap hshValues);
	public HashMap getsisterconcerndata(HashMap hshValues);
	
	public void updatedepaccountdata(HashMap hshValues);
	public HashMap getdepaccountdata(HashMap hshValues);
	
	public void updatePresentPosition(HashMap hshValues); 
	public HashMap getPresentPosition(HashMap hshValues); 
	
	public void updateSecurities(HashMap hshValues); 
	public HashMap getSecurities(HashMap hshValues);
	
	public void updateBorrwerDetails(HashMap hshValues); 
	public HashMap getBorrowerDetails(HashMap hshValues);
	
	public void updateAuditorsObservation(HashMap hshValues); 
	public HashMap getAuditorsObservation(HashMap hshValues);
	
	public HashMap getGeneralHistoryData(HashMap hshValues);
	public void updateGeneralHistoryData(HashMap hshValues);
	
	public void updatesignatories(HashMap hsh);
	public HashMap getsignatories(HashMap hsh);
	
	public HashMap getorganisationrecmmendations(HashMap hsh);
	public void updateorganisationrecommendations(HashMap hsh);
	
	public HashMap getdelegatedwork(HashMap hshValues); 
	
//	public void loadcbsnpadata(HashMap hshValues); 
	
	public HashMap getStatusnoteOTS(HashMap hshValues); 
	public void updateStatusnoteOTS(HashMap hshValues);
	
	public HashMap getStatusNoteSarfaesia(HashMap hshValues); 
	public void updateStatusNoteSarfaesia(HashMap hshValues);
	
	
}