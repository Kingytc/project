package com.sai.laps.ejb.qisrange;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface QisRangeRemote 
{
	public HashMap getData(HashMap hshRequestValues);
	public void updateData(HashMap hshRequestValues);
	public HashMap getDataHelp(HashMap hshRequestValues);
}
