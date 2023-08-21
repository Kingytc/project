package com.sai.laps.ejb.undelete;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface UndeleteRemote 
{
	public HashMap getData(HashMap hshRequestValues);
	public HashMap updateData(HashMap hshRequestValues);
}
