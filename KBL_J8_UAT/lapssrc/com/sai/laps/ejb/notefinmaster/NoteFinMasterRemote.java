package com.sai.laps.ejb.notefinmaster;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface NoteFinMasterRemote 
{
	public HashMap updateData(HashMap hsh);
	public HashMap getDataHelp(HashMap hsh);
}