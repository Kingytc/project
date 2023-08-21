package com.sai.laps.ejb.prdsanclimit;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface PrdSanclimitRemote 
{
	public void updateData(HashMap hshValues);
	public HashMap getData(HashMap hshValues);
	
	//Added by Rajesh for Delegated Power on 17/02/2014
	public void updateDelegate(HashMap hshValues);
	public HashMap getDelegate(HashMap hshValues);
}