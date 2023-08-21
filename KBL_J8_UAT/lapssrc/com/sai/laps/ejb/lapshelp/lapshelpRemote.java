package com.sai.laps.ejb.lapshelp;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface lapshelpRemote 
{
	public void updateData(HashMap hshValues);
	public HashMap getData(HashMap hshRequestValues);
	public HashMap getdataHelpList(HashMap hshRequestValues);
	public HashMap getdataHelpLeftMenu(HashMap hshRequestValues);
}
