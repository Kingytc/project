package com.sai.laps.ejb.solvency;

import java.rmi.RemoteException;
import java.util.HashMap;


import javax.ejb.EJBException;
import javax.ejb.EJBObject;
import javax.ejb.Remote;

import org.apache.poi.hpsf.ReadingNotSupportedException;

@Remote
public interface ComSolvencyRemote  {
	public HashMap updateSolvencyData(HashMap hsh)  ;
	public HashMap getSolvencyData(HashMap hshRequestValues);
	public HashMap UpdateKpowerdetailsData(HashMap  hshValues);
	public HashMap getKpowerdetailsData(HashMap hshRequestValues);
	public HashMap getsolworkflow(HashMap hshRequestValues);
    public void updateAction(HashMap hshValues);
	public HashMap getAction(HashMap hshRequestValues);
	public HashMap getKpowerHistroy(HashMap hshRequestValues);
	public HashMap getKpowAction(HashMap hshRequestValues);
    public HashMap getSolDetails(HashMap hshRequestValues);
    public void updateKpowAction(HashMap hshValues);
    public HashMap getkpowDetails(HashMap hshRequestValues);
    public void getSaveSolvency(HashMap hshSaveValues);
    public void getSaveKpower(HashMap hshSaveValues);
    public String getSanctionRefernceNumber(HashMap hshValues);
    public String getSanctionRefernceNumberKpow(HashMap hshValues);
    public HashMap getBankerDetails(HashMap hshRequestValues);
	public HashMap updateBankersData(HashMap hsh)  ;
	public HashMap getBankersData(HashMap hsh)  ;
	public HashMap getBankerAction(HashMap hshRequestValues);
	public HashMap getbankerworkflow(HashMap hshRequestValues);
	public  HashMap getDelegateData(HashMap hshValues);
	public  void updateDelegate(HashMap hshValues);
	public  HashMap getProcessData(HashMap hshValues);
	public  HashMap updateProcessChargesData(HashMap hshValues);
	public void updateBankerAction(HashMap hshValues);
	public  HashMap getbankdata(HashMap hshRequestValues);
}
