package com.sai.laps.ejb.Ssi_schdu;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface Ssi_schduRemote 
{
	
	public HashMap updateData(HashMap hshRequestValues);
    public HashMap getData(HashMap hshRequestValues);
}