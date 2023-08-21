package com.sai.laps.ejb.exposure;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface ExposureRemote 
{
	public HashMap getExpData(HashMap hshRequestValues);
	public HashMap getApplicantList(HashMap hshRequestValues);
	public void updateExp(HashMap hshRequestValues);
	public HashMap showGroup(HashMap hashtable);
	public HashMap showIndustry(HashMap hashtable);
	public void updateConsExp(HashMap hshRequestValues);
	public HashMap getConsExp(HashMap hshRequestValues);
}
