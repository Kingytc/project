package com.sai.laps.ejb.repgroups;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface RepGroupsRemote 
{
	public HashMap getData(HashMap hshRequestValues);
}