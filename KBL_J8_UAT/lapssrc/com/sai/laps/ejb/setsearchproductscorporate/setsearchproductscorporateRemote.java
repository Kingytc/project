package com.sai.laps.ejb.setsearchproductscorporate;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface setsearchproductscorporateRemote 
{
	public HashMap getData(HashMap hshRequestValues);
	
}
