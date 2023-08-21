package com.sai.laps.ejb.repappdove;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface RepAppDoveRemote 
{
	public HashMap getData(HashMap hshRequestValues);
		
}