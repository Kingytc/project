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
public class TagDataHelperBST extends BeanAdapter {
/**
	 * 
	 */
	private static final long serialVersionUID = 6564650981860974841L;
	static Logger log=Logger.getLogger(TagDataHelperBST.class);

	public HashMap getBSTTermFinanceFac(HashMap hshValues) 
	{	
		
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList arrCol= new ArrayList();
		ArrayList arrRow= new ArrayList();	
		
		try
		{
			
			String strAppno= correctNull((String)hshValues.get("appno"));
			
			rs = DBUtils.executeLAPSQuery("sel_bsttermfinancefac^"+strAppno);
			
			hshRecord = new HashMap();
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("bstfacilities_sno")));
				arrCol.add(correctNull(rs.getString("facility_catdesc"))+" - "+rs.getDouble("bstfacilities_proposed"));
				arrRow.add(arrCol);	
			}
			hshRecord.put("vecRow",arrRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getBSTTermFinanceFac "+ce.toString());
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
	
	public HashMap getBSTAppData(HashMap hshRequestValues) 
	{
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strappno = correctNull((String) hshRequestValues.get("appno"));
		
		try
		{
			strQuery=SQLParser.getSqlQuery("sel_bstappdetails^"+strappno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshRecord.put("appstatus",correctNull(rs.getString("bstapp_status")));
				hshRecord.put("companyname",correctNull(rs.getString("bst_companyname")));
				hshRecord.put("applnholder",correctNull(rs.getString("bstapp_applnholder")));
				hshRecord.put("valuesin",correctNull(rs.getString("bstapp_valuesin")));
				hshRecord.put("org_name",correctNull(rs.getString("org_name")));
			}
		}
		catch (Exception ce)
		{
			throw new EJBException("Error in getData " + ce.toString());
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