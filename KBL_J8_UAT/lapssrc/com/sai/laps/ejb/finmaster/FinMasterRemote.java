package com.sai.laps.ejb.finmaster;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface FinMasterRemote 
{
	public HashMap updateData(HashMap hsh);
	public HashMap getDataHelp(HashMap hsh);
	
	public HashMap updateBenchmarkRatio(HashMap hsh);
	public HashMap getBenchmarkRatio(HashMap hshValues); 
}