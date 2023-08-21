package com.sai.laps.ejb.setorg;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface SetOrgRemote 
{
	public void updateData(HashMap hshValues);
	public HashMap getData(HashMap hshRequestValues);
	public HashMap getDataHelp(HashMap hshParamter); 
	public HashMap getDuplicateCheck(HashMap hshParamter); 
	public String getRegionalOffice(HashMap hshParamter);
	public void updateMoveOrganisation(HashMap hshValues);
}
