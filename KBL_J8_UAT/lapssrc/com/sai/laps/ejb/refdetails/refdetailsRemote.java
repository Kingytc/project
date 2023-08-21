package com.sai.laps.ejb.refdetails;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface refdetailsRemote 
{
	public void updrefData(HashMap hshValues);
	public HashMap getrefData(HashMap hshRequestValues);
	public void updatenriData(HashMap hshValues);
	public HashMap getnriData(HashMap hshRequestValues);
	public void UpdatePartnerDetailsData(HashMap hshValues);
	public HashMap getPartnerDetailsData(HashMap hshRequestValues);
}