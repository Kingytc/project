package com.sai.laps.ejb.commdocument;

import javax.ejb.*;
import javax.ejb.Remote;

import com.sai.fw.business.entities.User;

import java.rmi.*;
import java.util.*;
@Remote
public interface CommDocumentRemote 
{
	public void updateDocument(HashMap hshValues);
	public HashMap getDocumentScan(HashMap hshValues);
	public HashMap getData(HashMap hshValues);
	public HashMap getDocumentRules(HashMap hshValues);

	public void updateDocumentScan(HashMap hshValues);
	public HashMap createFile(HashMap hshValues);
	public HashMap getComFacDocuments(HashMap hshRequestValues);
	public void updateComFacilityDocuments(HashMap hshRequestValues);
	public HashMap getDeletedDocument(HashMap hshRequestValues);	
	public boolean updateAttachedDocument(HashMap hshValues);
	public HashMap viewDocumentScanningImage(HashMap hshValues);
	public HashMap viewDocumentPdfImage(HashMap hashValue);
	public boolean updateAttachedPdfDocument(HashMap hashValue);

	public HashMap getAnnexureI(HashMap hshRequestValues);	
	public HashMap getAnnexureII(HashMap hshRequestValues);
	public HashMap getAnnexureIII(HashMap hshRequestValues);
	public HashMap getAnnexureIV(HashMap hshRequestValues);
	public HashMap getAnnexureV(HashMap hshRequestValues);
	public HashMap getAnnexureVI(HashMap hshRequestValues);
	public HashMap getAnnexureVII(HashMap hshRequestValues);
	public HashMap getFinancialDataPrint(HashMap hshRequestValues);

	public HashMap getAnnexureIX_Print(HashMap hshReqValues);
	public HashMap getAnnexure(HashMap hshReqValues);
	public HashMap getMCLRAnnexure(HashMap hshReqValues);
	
	public HashMap getDocTemplate(HashMap hshValues);
	public HashMap getDocumentDetails(HashMap hshValues);
	public HashMap getUploadedDocDetails(HashMap hshValues);
	public HashMap viewDocumentData(HashMap hshValues);
	public HashMap printDocumentDetails(HashMap hshValues);
	public void updateDocPrintDetails(HashMap hshValues);
	public HashMap getDocumentPrintHistory(HashMap hshValues);
	public HashMap getDocTemplateFacility(HashMap hshValues);
	
	public HashMap get_Corp_Annexure(HashMap hshRequestValues);
	public HashMap get_Corp_AnnexureData(HashMap hshValues);
	
	
	
	
	
}
