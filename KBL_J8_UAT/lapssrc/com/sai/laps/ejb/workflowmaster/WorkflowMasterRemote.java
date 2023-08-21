package com.sai.laps.ejb.workflowmaster;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface WorkflowMasterRemote 
{
	public HashMap updateData(HashMap hshValues);
	public HashMap getData(HashMap hshValues);
}