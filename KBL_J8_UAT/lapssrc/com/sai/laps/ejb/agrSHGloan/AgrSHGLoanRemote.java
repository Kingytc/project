package com.sai.laps.ejb.agrSHGloan;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface AgrSHGLoanRemote 
{
	public void updateSHGFinancePositionDetails(HashMap hshValues);
 	public HashMap getSHGFinancePositionDetails(HashMap hshValues);
 	
 	public void updateSHGCorpusDetails(HashMap hshValues);
 	public HashMap getSHGCorpusDetails(HashMap hshValues);
}
