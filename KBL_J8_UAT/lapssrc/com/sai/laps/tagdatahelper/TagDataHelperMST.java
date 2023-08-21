package com.sai.laps.tagdatahelper;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

public class TagDataHelperMST extends BeanAdapter {

	/**
	 * 
	 */
	private static final long serialVersionUID = 98393303696804655L;
	static Logger log=Logger.getLogger(TagDataHelperMST.class);

	public HashMap getFacilityName(HashMap hshValues) 
	{		
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList arrCol= new ArrayList();
		ArrayList arrRow= new ArrayList();	
		
		try
		{	
			String appno= correctNull((String)hshValues.get("appno"));
				rs = DBUtils.executeLAPSQuery("sel_facilityformodification^"+appno);
				
				hshRecord = new HashMap();
				while(rs.next())
				{
					arrCol = new ArrayList();
					arrCol.add(correctNull(rs.getString("mstfacilities_sno")));
					arrCol.add(correctNull(rs.getString("facility_catdesc")));
					arrCol.add(Helper.formatDoubleValue(rs.getDouble("mstfacilities_sanclimit")));
					arrRow.add(arrCol);	
				}
			hshRecord.put("arrRow",arrRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in TagDataHelperMST "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}				
			
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap getSecurityName(HashMap hshValues) 
	{	
		
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList arrCol= new ArrayList();
		ArrayList arrRow= new ArrayList();	
		
		String strAppno="";
		try
		{
			strAppno=correctNull((String)hshValues.get("appno"));			
			rs = DBUtils.executeLAPSQuery("sel_mstsecurity^"+strAppno);
			
			hshRecord = new HashMap();
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("mstsec_id")));
				arrCol.add(correctNull(rs.getString("sec_name")));
				arrRow.add(arrCol);	
			}
			hshRecord.put("arrRow",arrRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getSecurityName "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}	
			
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}
	
	public HashMap getMSTAppData(HashMap hshRequestValues) 
	{
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strappno = correctNull((String) hshRequestValues.get("appno"));
		
		try
		{
			strQuery=SQLParser.getSqlQuery("selmstappdetails^"+strappno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				//hshRecord.put("appno",correctNull(rs.getString("mst_appno")));
				hshRecord.put("applicantid",correctNull(rs.getString("mst_appid")));
				hshRecord.put("appname",correctNull(rs.getString("comapp_companyname")));
				hshRecord.put("applnholder",correctNull(rs.getString("mst_holdusrid")));
				hshRecord.put("appstatus",correctNull(rs.getString("mst_status")));
				hshRecord.put("propappno",correctNull(rs.getString("mst_applicationno")));
				hshRecord.put("valuesin",correctNull(rs.getString("mst_valuesin")));
				hshRecord.put("org_name",correctNull(rs.getString("org_name")));
			}
		}
		catch (Exception ce)
		{
			throw new EJBException("Error in getData of getMSTAppData ::  " + ce.toString());
		}
		finally
		{
			try
			{
				if (rs != null) 
				{
					rs.close();
				}
			}
			catch (Exception cf) 
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}
		return hshRecord;
	}
}