package com.sai.laps.ejb.duplicatequeries;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface DuplicateQueriesRemote 
{	
	public HashMap getData(HashMap hshRequestValues);
}