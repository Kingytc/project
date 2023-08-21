package com.sai.laps.ejb.combobassessment;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface ComBobAssessmentRemote 
{
	public HashMap getData(HashMap hshRequestValues);
	public HashMap getDataList(HashMap hshRequestValues);	
	public void UpdateAssessmentoflimit(HashMap hshValues);
	
	public HashMap UpdateAssessmentdatas(HashMap hshValues);
	public HashMap updateHoldingLevels(HashMap hshValues);
}
