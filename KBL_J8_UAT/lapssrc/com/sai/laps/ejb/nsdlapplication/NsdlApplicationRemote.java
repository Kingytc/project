package com.sai.laps.ejb.nsdlapplication;

import java.rmi.RemoteException;
import java.util.HashMap;
import java.util.Map;

import javax.ejb.EJBObject;
import javax.ejb.Remote;

import javazoom.upload.MultipartFormDataRequest;
@Remote
public interface NsdlApplicationRemote  {
	
	public HashMap getNSDLApplications(HashMap hshValues);
	public HashMap updateNSDLApplicationReallocation(HashMap hshValues);
	public HashMap getNsdlRecvApplication(HashMap hshValues);
	public HashMap getNsdlShowApplicationDetails(HashMap hshValues);
	public void updateNSDLApplicationstatus(HashMap hshValues);
	public HashMap generateXMLResponseFiles(HashMap hshValues);
	public HashMap getDocumentList(HashMap hshValues);
	public HashMap viewAttachedDocument(HashMap hshValues);
	
	public HashMap downloadRequestFiles(HashMap hshValues);
	public HashMap downloadByFileID(HashMap hshValues);
	public String uploadNSDLResponse(MultipartFormDataRequest mrequest);

}
