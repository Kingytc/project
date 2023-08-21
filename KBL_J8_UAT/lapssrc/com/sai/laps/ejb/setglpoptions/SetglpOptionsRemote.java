package com.sai.laps.ejb.setglpoptions;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface SetglpOptionsRemote 
{
	public void updateData(HashMap hshValues);
	public HashMap getData(HashMap hshRequestValues);
	public HashMap getDataHelp(HashMap hshParamter);
	public HashMap getScreenData(HashMap hshParamter);
	public void updateScreenData(HashMap hshParamter);
}
