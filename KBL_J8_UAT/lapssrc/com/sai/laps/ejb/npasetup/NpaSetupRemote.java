package com.sai.laps.ejb.npasetup;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface NpaSetupRemote 
{
	public void updateaggregatemeansData(HashMap hsh);
	public HashMap getaggregatemeansData(HashMap hsh);
	
	public void updateAgeofNpa(HashMap hsh);
	public HashMap getAgeofNpa(HashMap hsh);
	public void updateMethodology(HashMap hsh);
	public HashMap getMethodology(HashMap hsh);
	public void updateNpainterest(HashMap hsh);
	public HashMap getNpainterest(HashMap hsh);
	public void updateRealisible(HashMap hsh);
	public HashMap getRealisible(HashMap hsh);
	public void updateLegalPosition(HashMap hsh);
	public HashMap getLegalPosition(HashMap hsh);
}
