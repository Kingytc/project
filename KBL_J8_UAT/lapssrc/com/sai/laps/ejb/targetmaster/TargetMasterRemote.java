package com.sai.laps.ejb.targetmaster;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface TargetMasterRemote {
	public void updateTargetMasterData(HashMap hshValues);
	public HashMap getTargetMasterData(HashMap hshValues);
	
	
	public HashMap getTargetBranchMasterData(HashMap hshValues);
	public HashMap getBranchTarget(HashMap hshValues);
	
	public HashMap getTargetDataPrint(HashMap hshValues);
}
