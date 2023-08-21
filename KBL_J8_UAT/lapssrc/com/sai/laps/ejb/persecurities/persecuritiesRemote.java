package com.sai.laps.ejb.persecurities;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface persecuritiesRemote 
{
	public void updsecData(HashMap hshValues);
	public HashMap selsecData(HashMap hshRequestValues);
}