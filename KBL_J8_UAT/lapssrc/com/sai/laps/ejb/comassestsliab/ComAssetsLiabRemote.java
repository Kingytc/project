package com.sai.laps.ejb.comassestsliab;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.sql.ResultSet;
import java.util.*;
@Remote
public interface ComAssetsLiabRemote  {
	public void updateInterFrim(HashMap hsh);
	public HashMap getInterfirmComp(HashMap hshValues)  ;
	
	public void updateFinangrpconcern(HashMap hsh);
	public HashMap getFinangrpconcern(HashMap hshValues)  ;

}
