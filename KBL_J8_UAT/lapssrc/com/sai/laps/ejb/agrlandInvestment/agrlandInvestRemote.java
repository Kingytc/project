package com.sai.laps.ejb.agrlandInvestment;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface agrlandInvestRemote 
{
	public void updateData(HashMap hshValues);
	public HashMap getData(HashMap hshValues);
	 
}