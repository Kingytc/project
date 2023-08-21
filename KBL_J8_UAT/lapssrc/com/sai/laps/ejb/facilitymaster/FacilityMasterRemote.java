package com.sai.laps.ejb.facilitymaster;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface FacilityMasterRemote 
{
	public HashMap updateData(HashMap hshValues);
	public HashMap getData(HashMap hshValues);
	public void updateexposureindustry(HashMap hshreqvalues);
	public HashMap getexposureindustry(HashMap hshvalues);
	//public HashMap getFacilityNames(HashMap hshValues);
}