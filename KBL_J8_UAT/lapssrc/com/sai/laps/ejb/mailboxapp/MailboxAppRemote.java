package com.sai.laps.ejb.mailboxapp;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface MailboxAppRemote 
{
	public HashMap getData(HashMap hshRequestValues);
 	//public HashMap getOutBox(HashMap hshRequestValues);
	public HashMap getMonData(HashMap hshRequestValues);
	public HashMap getBranchMailBox(HashMap hshRequestValues);
}
