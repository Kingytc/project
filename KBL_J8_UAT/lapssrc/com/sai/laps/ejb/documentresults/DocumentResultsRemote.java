package com.sai.laps.ejb.documentresults;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface DocumentResultsRemote 
{
	public HashMap getData(HashMap hshRequestValues);
	public HashMap getRetailProcessNote(HashMap hshValues);
	public HashMap getSanctionLetterData (HashMap hshValues);
	public HashMap getKeyFactStatementData (HashMap hshValues);

	//Added by Guhan For Key fact statement Fee structure page
	public void updateKeyFactFeesdata (HashMap hshValues);
	public HashMap getKeyFactFeesdata (HashMap hshValues);
} 