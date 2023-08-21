package com.sai.laps.ejb.dscr;

import java.rmi.RemoteException;
import java.util.HashMap;

import javax.ejb.EJBObject;
import javax.ejb.Remote;
@Remote
public interface DscrRemote {
	
	public HashMap getDataForDSCR(HashMap hshRequestValues);
	public void updateDSCRData(HashMap hshRequestValues);
	public HashMap updateDSCRFormula(HashMap hshRequestValues);
	public void deleteData(HashMap hsh);
	public HashMap getPrintValues(HashMap hshRequestValues);
	public HashMap getDataAssessment(HashMap hshRequestValues);
	public void updategetDataForDSCRSensitivitydata(HashMap hsh);
	public HashMap getDataForDSCRSensitivitydata(HashMap hshRequestValues);
	public HashMap updateDSCRSENSFormula(HashMap hshRequestValues);
	
	public HashMap getPrintSensitivityVal(HashMap hshRequestValues);
	public void updateDSCRSensitivityTableUpdate(HashMap hsh);
}
