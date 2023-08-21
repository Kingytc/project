package com.sai.laps.ejb.comrbidefaulter;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface RBIDefaulterRemote 
{
	public HashMap getData(HashMap hshRequestValues);
	public HashMap getSearchData(HashMap hshRequestValues);

}