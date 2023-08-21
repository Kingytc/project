package com.sai.laps.ejb.repdata;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface RepDataRemote 
{
	public HashMap getData(HashMap hshRequestValues);
	public HashMap getParameter(HashMap hshRequestValues);
	public HashMap getParameter1(HashMap hshRequestValues);
	public HashMap updateData(HashMap hshRequestValues);
}