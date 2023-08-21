package com.sai.laps.ejb.prodflowpoint;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface ProdFlowpointRemote 
{
	public HashMap getData(HashMap hshRequestValues);
}