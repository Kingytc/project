package com.sai.laps.ejb.setusedby;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface SetUsedbyRemote 
{
	public void updateData(HashMap hshValues);
	public HashMap getData(HashMap hshRequestValues);
	public HashMap getFacUsedby(HashMap hshRequestValues);
	public void updateFacUsedby(HashMap hshValues);
}
