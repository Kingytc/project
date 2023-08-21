package com.sai.laps.ejb.setmodtermscond;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface SetModTermsCondRemote 
{
	public HashMap getData(HashMap hshRequestValues);
	public HashMap getTermData(HashMap hshRequestValues);
	public void updateData(HashMap hshValues);
//	kamal added
	public HashMap getSchemeDocData(HashMap hshRequestValues);
	public void updateshemedocData(HashMap hshValues);
	public HashMap getSchemeData(HashMap hshRequestValues);
	
//	kamal added 11/07/09
	public HashMap getSectorSchemeDoc(HashMap hshRequestValues);
	//kamal End  11/07/09

	public HashMap getTakeOverNorms(HashMap hshValues);
	public void updateTakeOverNorms(HashMap hshValues);
	
	public HashMap getRBIGuidelines(HashMap hshValues);
	public void updateRBIGuidelines(HashMap hshValues);
}