package com.sai.laps.ejb.agrotherassets;
import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface agrotherRemote{

	public void updateagrassets(HashMap hshValues);
	public HashMap getagrassets (HashMap hshRequestValues);
	
//	added by sathiya
	public void updategolddetails(HashMap hshValues);
	public HashMap getgolddetails(HashMap hshValues);
	public HashMap getgolddetailsprint(HashMap hshValues);
	public void updateSecurityValue(String strAppNo, double dblTotalRate);
	//Added by Arsath on 01/08/2013 for Appraiser Details
	public void updateGoldAppraiserdet(HashMap hshValues);
	public HashMap getGoldAppraiserdet(HashMap hshValues);
	public HashMap getGoldReAppraiserdet(HashMap hshValues);
	public void updateGoldReAppraiserdet(HashMap hshValues);
	public HashMap getgoldpenddingreapp(HashMap hshValues);
	public HashMap getgoldpenddingreappforreport(HashMap hshValues);
	public HashMap getcertificateforpa(HashMap hshValues);
}
