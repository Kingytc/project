package com.sai.laps.ejb.qisanalysisresult;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface QisAnalysisResultRemote 
{

	public HashMap getDataList(HashMap hshRequestValues);
	
	
	
}
