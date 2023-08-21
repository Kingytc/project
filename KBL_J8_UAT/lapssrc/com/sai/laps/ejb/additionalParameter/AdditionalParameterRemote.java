package com.sai.laps.ejb.additionalParameter;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface AdditionalParameterRemote 
{	
	public HashMap getadditionalParameter(HashMap hshValues);
	public HashMap updateadditionalParameter(HashMap hshValues);		
	public  HashMap getCorporateSanctionDetails(HashMap hshValues);
	public void updateCorporateSanctionDetails(HashMap hshValues);
	public  HashMap checkRating(HashMap hshValues);
	//added by Mercy 
	public HashMap getSearch(HashMap hshValues);
	public void updateTertiarySanctionDetails(HashMap hshValues);	
	public HashMap getTertiarySanctionDetails(HashMap hshValues);	
}