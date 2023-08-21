package com.sai.laps.ejb.cibilinterface;

import java.rmi.RemoteException;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.EJBObject;
import javax.ejb.Remote;
@Remote
public interface cibilinterfaceRemote {
	public HashMap getCibilResponse(HashMap hshValues);
	public HashMap getResponseFile(HashMap hshValues);
	public HashMap getCibilRequest(HashMap hshValues);
}
