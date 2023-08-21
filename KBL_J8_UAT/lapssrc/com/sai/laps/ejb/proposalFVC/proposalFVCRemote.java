package com.sai.laps.ejb.proposalFVC;
import java.rmi.RemoteException;
import java.util.HashMap;

import javax.ejb.*;
@Remote
public interface proposalFVCRemote  
{
	public void updatedata(HashMap hshValues);
	public HashMap getdata(HashMap hshValues);
	
	public void updateFVCaccounts(HashMap hshValues);
	public HashMap getFVCaccounts(HashMap hshValues);
}
