package com.sai.laps.ejb.comrepappstatus;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface ComRepAppStatusRemote 
{
	public HashMap getData(HashMap hshRequestValues);
	
}