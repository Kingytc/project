package com.sai.laps.ejb.setgroups;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface SetGroupsRemote 
{
	public void updateData(HashMap hshValues);
	public HashMap getData(HashMap hshRequestValues);
}
