package com.sai.laps.ejb.documentsupport;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface DocumentSupportRemote 
{	
	public HashMap getData(HashMap hshValues);
	public HashMap getdueReport(HashMap hshValues);
	public void updatedueReport(HashMap hshValues);
	public HashMap getdueReportprint(HashMap hshValues);
	public void updatedueReportGeneralInfo(HashMap hshRequestValues);
	public HashMap getdueReportGeneralInfo(HashMap hshRequestValues);
	public void updateQueryData(HashMap hshRequestValues);
	public HashMap getQueryData(HashMap hshRequestValues);
	public HashMap getQueryDetails(HashMap hshRequestValues);
	public HashMap UpdateQueryDetails(HashMap hshRequestValues);

	
}