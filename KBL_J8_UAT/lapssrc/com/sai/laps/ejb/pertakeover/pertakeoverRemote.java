package com.sai.laps.ejb.pertakeover;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface pertakeoverRemote 
{
	public HashMap getData(HashMap hshValues);
	public void updateData(HashMap hshValues);
}