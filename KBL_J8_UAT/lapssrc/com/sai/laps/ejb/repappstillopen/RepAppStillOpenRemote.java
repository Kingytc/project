package com.sai.laps.ejb.repappstillopen;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface RepAppStillOpenRemote 
{
	public HashMap getData(HashMap hshRequestValues);
}