package com.sai.laps.ejb.audittrial;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface AuditTrialRemote 
{
	public HashMap getDataHelp(HashMap hshValues);	
	public HashMap getData(HashMap hshValues);	
}