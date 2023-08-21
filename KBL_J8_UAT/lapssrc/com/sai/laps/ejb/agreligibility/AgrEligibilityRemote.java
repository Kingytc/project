package com.sai.laps.ejb.agreligibility;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface AgrEligibilityRemote 
{	
	public HashMap getUGCC_Eligibility(HashMap hshValues);
	public void updateUGCC_Eligibility(HashMap hshValues);
}