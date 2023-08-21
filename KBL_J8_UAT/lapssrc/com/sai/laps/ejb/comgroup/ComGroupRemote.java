package com.sai.laps.ejb.comgroup;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface ComGroupRemote 
{
	public HashMap updateData(HashMap hshValues);
	public HashMap getData(HashMap hshValues);
}