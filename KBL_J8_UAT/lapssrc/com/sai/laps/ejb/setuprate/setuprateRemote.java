package com.sai.laps.ejb.setuprate;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface setuprateRemote 
{

	public HashMap getData(HashMap hshRequestValues);
	public void updateData(HashMap hshValues);
	//public HashMap getRate(HashMap hshRequestValues);
}
