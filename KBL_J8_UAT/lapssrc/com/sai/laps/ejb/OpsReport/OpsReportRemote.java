package com.sai.laps.ejb.OpsReport;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface OpsReportRemote 
{
	public HashMap getData(HashMap hshRequestValues);
	
}