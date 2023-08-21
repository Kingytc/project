package com.sai.laps.ejb.retailassessment;

import java.rmi.RemoteException;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.EJBObject;
import javax.ejb.Remote;

@Remote
public interface RetailAssessmentRemote {
	public  HashMap getRepaymentCapacity(HashMap hshValues);
	public  HashMap getCommonAssessment(HashMap hshValues);
}
