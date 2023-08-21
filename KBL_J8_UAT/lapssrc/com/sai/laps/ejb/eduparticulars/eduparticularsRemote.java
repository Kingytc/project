package com.sai.laps.ejb.eduparticulars;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface eduparticularsRemote 
{
	public void updateData(HashMap hsh);
	public HashMap getData(HashMap hshRequestValues);
	
}
