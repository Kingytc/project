package com.sai.laps.ejb.edustudent;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface edustudentRemote 
{
	public void updateData(HashMap hsh);
	public HashMap getData(HashMap hshRequestValues);
	//public HashMap getPrintData(HashMap hshRequestValues);
	public HashMap getStudentDetails(HashMap hshRequestValues);
	
}
