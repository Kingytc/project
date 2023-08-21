package com.sai.laps.ejb.networth;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface networthRemote 
{
	public HashMap getData(HashMap hshRequestValues);
}