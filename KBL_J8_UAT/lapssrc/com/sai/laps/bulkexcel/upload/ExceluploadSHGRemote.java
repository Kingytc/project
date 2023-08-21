package com.sai.laps.bulkexcel.upload;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;

@Remote
public interface ExceluploadSHGRemote {
	public HashMap doUploadBulkData(HashMap hshValues)throws RemoteException;
	public ArrayList updateLapsDatabase(HashMap hshValues, String action) throws RemoteException; 
	
}
