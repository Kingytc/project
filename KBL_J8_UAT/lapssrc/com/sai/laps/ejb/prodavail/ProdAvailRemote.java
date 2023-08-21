package com.sai.laps.ejb.prodavail;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface ProdAvailRemote 
{
	public HashMap getData(HashMap hshRequestValues);
}