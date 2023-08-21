package com.sai.laps.ejb.fishersinvest;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface FishersInvestRemote 
{
	
	public HashMap getfishersinvest(HashMap hshValues);
	public HashMap updatefishersinvest(HashMap hshValues);
	public void updatemarketingfisheries(HashMap hshValues);
	public HashMap getmarketingfisheries(HashMap hshValues);
	
	

}