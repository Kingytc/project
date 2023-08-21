package com.sai.laps.ejb.excelfunction;
import java.rmi.RemoteException;
import java.util.HashMap;

import javax.ejb.EJBObject;
import javax.ejb.Remote;

@Remote
public interface ExcelFunctionRemote {
	
	public HashMap doExportOnlineReport(HashMap hshValues)throws  RemoteException;
	public HashMap doExcelExportFinancialFormat(HashMap hshRequestValues)throws  RemoteException;
	public HashMap getExcelValues(HashMap hshRequestValues);
	public HashMap getFreezedExcelValues(HashMap hshRequestValues);
	public HashMap getExcelData(HashMap hshRequestValues);
	public HashMap doFVCExportFormat(HashMap hshRequestValues);
	public HashMap doExportNPAProvOutput(HashMap hshRequestValues);
	public HashMap getZIPFileData(HashMap hshRequestValues);
	public HashMap doExportNPAProvReport(HashMap hshRequestValues);
	public HashMap doExportProductSpread(HashMap hshRequestValues);
	public HashMap updateProductSpread(HashMap hshRequestValues);
	public HashMap getNpaProvisioningReport(HashMap hshValues);
	public HashMap doExportNPAProvOutput_OLD(HashMap hshValues);
	public HashMap doExportNPAProvReport1(HashMap hshRequestValues);
	public HashMap doExportNPAProv_Accountwise(HashMap hshRequestValues);
	public HashMap dodownloadxslforfbill(HashMap hshRequestValues);
	public HashMap updateSpreadvalueforfbil(HashMap hshRequestValues);

}
