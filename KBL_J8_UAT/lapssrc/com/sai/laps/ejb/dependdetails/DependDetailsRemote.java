package com.sai.laps.ejb.dependdetails;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;


@Remote
public interface DependDetailsRemote 
{
	public void updateData(HashMap hshValues);
	public HashMap getData(HashMap hshValues);
	public void updateCreditCardData(HashMap hshValues);	
	public HashMap getCreditCardData(HashMap hshValues);	
	
}