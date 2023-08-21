package com.sai.laps.ejb.productmaster;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface ProdMasterRemote 
{
	public HashMap updateData(HashMap hshValues);
	public HashMap getData(HashMap hshValues);
}