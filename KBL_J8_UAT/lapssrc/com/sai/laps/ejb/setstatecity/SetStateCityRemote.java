package com.sai.laps.ejb.setstatecity;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface SetStateCityRemote 
{
	
	public HashMap updateStateDetails(HashMap hshValues);
	public HashMap getData(HashMap hsh);
	
	public HashMap getDataCibilDetails(HashMap hsh);
	public HashMap updateCibilDetails(HashMap hshValues);
	
	public HashMap updateCityOnlDetails(HashMap hshValues);
	public HashMap updateUserOnlDetails(HashMap hshValues);
	public HashMap updateStateOnlDetails(HashMap hshValues);
	public HashMap updateOrgOnlDetails(HashMap hshValues);
	
}
