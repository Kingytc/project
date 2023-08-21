package com.sai.laps.ejb.qisanalysismaster;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface QisAnalysisMasterRemote 
{
	public HashMap updateData(HashMap hsh);
	public HashMap getDataHelp(HashMap hsh);
	


}