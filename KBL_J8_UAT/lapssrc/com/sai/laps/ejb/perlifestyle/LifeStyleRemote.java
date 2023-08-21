package com.sai.laps.ejb.perlifestyle;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface LifeStyleRemote 
{
	@SuppressWarnings("rawtypes")
	public HashMap getData(HashMap hshRequestValues);
	public void updateData(HashMap hshValues);
}