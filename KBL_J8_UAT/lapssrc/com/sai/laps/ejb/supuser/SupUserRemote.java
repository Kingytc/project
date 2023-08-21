package com.sai.laps.ejb.supuser;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface SupUserRemote 
{
	public HashMap getData(HashMap hshRequestValues);
	public HashMap getRetailAnnexure(HashMap hshValues);
	public void updateCropCgtmse(HashMap hshValues);
	public HashMap getCropCgtmse(HashMap hshValues);
	public HashMap getCropCgtmseAnnexure(HashMap hshValues);
	public void updateCorpNcgtc(HashMap hshValues);
	public HashMap getCorpNcgtc(HashMap hshValues);
}