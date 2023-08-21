package com.sai.laps.ejb.bobinterest;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface bobinterestRemote 
{
	public HashMap updateData(HashMap hshValues);
	public HashMap getDataHelp(HashMap hshRequestValues);	
}
