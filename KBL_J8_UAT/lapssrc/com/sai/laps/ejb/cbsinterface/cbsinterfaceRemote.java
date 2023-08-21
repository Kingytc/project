package com.sai.laps.ejb.cbsinterface;

import java.rmi.RemoteException;
import java.util.HashMap;

import javax.ejb.EJBObject;
import javax.ejb.Remote;
@Remote
public interface cbsinterfaceRemote 
{
	public HashMap getCbsApplicantData(HashMap hshValues);
	public HashMap checkMandatoryFieldsFromCBS(HashMap hshValues);
	public HashMap checkLoanInterestModifyhttpheader(HashMap hshValues);
	

}
