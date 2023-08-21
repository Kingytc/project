package com.sai.laps.ejb.comrepapptrack;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface ComRepAppTrackRemote 
{
	public HashMap getData(HashMap hshRequestValues);
}