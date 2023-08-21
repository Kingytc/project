package com.sai.laps.ejb.document;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface DocumentRemote 
{
	public HashMap updateData(HashMap hshValues);
	public HashMap getData(HashMap hshRequestValues);
	public HashMap getUsedFor(HashMap hashValue);
	public HashMap insertData(HashMap hashValue);
	public HashMap deleteData(HashMap hashValue);

}
