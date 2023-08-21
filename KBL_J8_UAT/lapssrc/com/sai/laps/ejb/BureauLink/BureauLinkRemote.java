package com.sai.laps.ejb.BureauLink;
import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface BureauLinkRemote  {

	public HashMap getBureauData(HashMap hshValues);
	public HashMap updateBureauData(HashMap hshValues);
	public String getMaxInwardno(String strSolid);
	public HashMap getInwardSearch(HashMap hshValues);
	public HashMap getData(HashMap hshValues);
}
