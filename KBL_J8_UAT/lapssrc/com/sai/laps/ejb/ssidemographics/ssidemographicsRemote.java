package com.sai.laps.ejb.ssidemographics;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface ssidemographicsRemote 
{
	public HashMap autoGen(HashMap hshRequestValues);
	public HashMap getNames(HashMap hshRequestValues);
	public HashMap getCorresRec(HashMap hshRequestValues);
	public HashMap getOpsdemograph(HashMap hshRequestValues);
	public HashMap updateOpsdemograph(HashMap hshRequestValues);
	
}