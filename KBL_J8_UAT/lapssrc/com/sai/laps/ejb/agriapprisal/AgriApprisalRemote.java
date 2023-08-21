package com.sai.laps.ejb.agriapprisal;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface AgriApprisalRemote 
{
	//public HashMap getApprisal(HashMap hshValues) throws  RemoteException;
	public HashMap getdairyfarmingData(HashMap hshValues) ;
	public void updatedairyfarmingData(HashMap hshRequestValues) ;
	public HashMap getDatadairyfindata(HashMap hshValues) ;
	//public HashMap getDairyAppraisalData(HashMap hshValues) ;
	//public HashMap getFarmmechAppraisaldata(HashMap hshValues);
	public HashMap getcapleligdata(HashMap hshValues);
	//public HashMap getcaplAppraisaldata(HashMap hshValues);
	//public HashMap getcsicropdata(HashMap hshValues);
	//public HashMap getcsidairydata(HashMap hshValues);
	//public HashMap getcsicapldata(HashMap hshValues);
	//public HashMap getbullockAppraisal(HashMap hshValues);
	public HashMap getagrigloddata(HashMap hshValues) ;
	public HashMap getagrifddata(HashMap hshValues) ;
	
	public HashMap checkagrieligibility(HashMap hshValues);
}