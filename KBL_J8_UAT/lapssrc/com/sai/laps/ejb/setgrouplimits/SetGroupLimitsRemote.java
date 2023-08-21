package com.sai.laps.ejb.setgrouplimits;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface SetGroupLimitsRemote 
{
	public HashMap getGroupLimitListData(HashMap hshRequestValues);
	public HashMap getData(HashMap hshRequestValues);
	public void updateData(HashMap hshValues);
	
}
