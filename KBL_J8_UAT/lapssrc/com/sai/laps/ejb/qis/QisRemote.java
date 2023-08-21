package com.sai.laps.ejb.qis;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface QisRemote 
{
	public void updateData(HashMap hshValues);
	public HashMap getData(HashMap hshValues);
	public HashMap getQisAna(HashMap hshValues);
}