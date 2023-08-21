package com.sai.laps.ejb.limitmaster;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface LimitmasterRemote 
{
	public HashMap getData(HashMap hshRequestValues);
	public HashMap getLimitList(HashMap hshRequestValues);
	public void updateData(HashMap hshValues);
	public HashMap getAgencyandSymbolList(HashMap hshRequestValues);
	public HashMap updateExternalCreditRating(HashMap hshRequestValues);
}