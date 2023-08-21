package com.sai.laps.ejb.appnotes;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface AppNotesRemote 
{
	public HashMap updateData(HashMap hshValues);
	public HashMap getData(HashMap hshRequestValues);
}
