package com.sai.laps.ejb.authenticate;

import javax.ejb.Remote;

import java.util.*;
@Remote
public interface AuthenticateRemote 
{
	public HashMap getData(HashMap hshRequestValues);	
	public boolean CheckSession(HashMap hshRequestValues);
	public HashMap RedirectMonitoring(HashMap hshRequestValues);
}
