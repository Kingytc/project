package com.sai.laps.ejb.DmsDocument;

import java.util.HashMap;
import javax.*;
import javax.ejb.Remote;

@Remote
public interface DmsDocumentRemote 
	{
	
	public HashMap getDocumentURLs(HashMap hshValues);
	public HashMap getDocumentDetails(HashMap hshValues);
	
	}
