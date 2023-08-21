package com.sai.laps.ejb.setsearchproducts;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface SetSearchProductsRemote 
{
	public HashMap getData(HashMap hshRequestValues);
	
}
