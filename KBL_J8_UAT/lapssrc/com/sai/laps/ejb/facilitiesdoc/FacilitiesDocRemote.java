package com.sai.laps.ejb.facilitiesdoc;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface FacilitiesDocRemote 
{	public HashMap getFacilityHead(HashMap hshRequestValues);
	public HashMap getFacility(HashMap hshRequestValues);
	public HashMap getDocData(HashMap hshRequestValues);
	public void updateDocData(HashMap hshRequestValues);	
}