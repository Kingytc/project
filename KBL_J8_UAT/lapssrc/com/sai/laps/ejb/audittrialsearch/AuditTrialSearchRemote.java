package com.sai.laps.ejb.audittrialsearch;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface AuditTrialSearchRemote
{
	public HashMap getData(HashMap hshRequestValues);
	public HashMap getDataFinal(HashMap hshRequestValues);
	public HashMap getBorrowerDetails(HashMap hshRequestValues);
}
