package com.sai.laps.ejb.perborrowersearch;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface perborrowersearchRemote 
{
	public HashMap getData(HashMap hshRequestValues);
	public HashMap getDataFinal(HashMap hshRequestValues);
	public HashMap getBorrowerDetails(HashMap hshRequestValues);
	public HashMap getDataHelp(HashMap hsh);
}
