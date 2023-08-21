package com.sai.laps.ejb.apistatushandle;


import java.rmi.RemoteException;
import java.util.HashMap;

import javax.ejb.Remote;

import java.util.*;


@Remote
public interface ApistatushandleRemote {
	
	public HashMap updateApiStatus(HashMap hshValues) throws RemoteException;

}
