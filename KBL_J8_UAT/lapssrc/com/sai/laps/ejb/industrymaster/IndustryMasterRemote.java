package com.sai.laps.ejb.industrymaster;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface IndustryMasterRemote 
{
	public HashMap getIndustryData(HashMap hshRequestValues);
	public HashMap getData(HashMap hshRequestValues);
	public HashMap updateData(HashMap hshValues);
}