package com.sai.laps.ejb.comrepayschedule;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface ComRepayScheduleRemote 
{

	public  HashMap getTermFinanceFac(HashMap hshRequestValues);
	public  HashMap getFacRepayment(HashMap hshRequestValues);
	public void updFacRepayment(HashMap hshRequestValues);

	//Added nby Guhan T for Repayment Schedule of Non EMI
	public  HashMap getFacNonEMIRepayment(HashMap hshValues);
	public void updateFacNonEMIRepayment(HashMap hshValues);
	public HashMap calculateAmortizationCorporate(HashMap hshValues);

}
