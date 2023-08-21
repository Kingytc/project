package com.sai.laps.ejb.ramratingreports;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface ramratingreportsRemote 
{
	public HashMap getram105rep(HashMap hshValues);
	//public HashMap getram106rep(HashMap hshValues);	
}