package com.sai.laps.ejb.ascertain;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface AscertainRemote 
{
	public HashMap getData(HashMap hshRequestValues);
	public boolean CheckSession(HashMap hshRequestValues);
}
