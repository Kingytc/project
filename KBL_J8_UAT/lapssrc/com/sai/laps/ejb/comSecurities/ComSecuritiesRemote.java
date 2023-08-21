package com.sai.laps.ejb.comSecurities;

import java.rmi.RemoteException;
import java.util.HashMap;

import javax.ejb.*;
@Remote
public interface ComSecuritiesRemote 
{
	public void updateData(HashMap hshValues);
	public HashMap getData(HashMap hshValues);

	public void updateChargeData(HashMap hshValues);
	public HashMap getChargeData(HashMap hshValues);
	
	//public HashMap getSeuritiesData(HashMap hshValues);
}
