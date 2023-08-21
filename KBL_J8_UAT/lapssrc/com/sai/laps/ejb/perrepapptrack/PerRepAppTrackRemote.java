package com.sai.laps.ejb.perrepapptrack;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface PerRepAppTrackRemote 
{
	public HashMap getData(HashMap hshRequestValues);
}