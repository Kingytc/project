package com.sai.laps.ejb.dataaccess;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;


@Remote
public interface DataAccessRemote 
{
	public void updateData(HashMap hshValues);
	//public void updateCBSData(HashMap hshValues);
	//public void updateInternetData(HashMap hshValues);
}
