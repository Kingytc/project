package com.sai.laps.tagdatahelper;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;

import org.apache.log4j.Logger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

public class TagDataHelperADC extends BeanAdapter {

	static Logger log=Logger.getLogger(TagDataHelperADC.class);	
	/**
	 * 
	 */
	private static final long serialVersionUID = 98393303696804655L;
	
	public HashMap getADCAppData(HashMap hshRequestValues) 
	{
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strappno = correctNull((String) hshRequestValues.get("appno"));
		
		try
		{
			strQuery=SQLParser.getSqlQuery("seladcappdetails^"+strappno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshRecord.put("applicantid",correctNull(rs.getString("adc_comappid")));
				hshRecord.put("appname",correctNull(rs.getString("comapp_companyname")));
				hshRecord.put("applnholder",correctNull(rs.getString("adc_holdusrid")));
				hshRecord.put("appstatus",correctNull(rs.getString("adc_staus")));
				hshRecord.put("valuesin",correctNull(rs.getString("adc_valuesin")));
			}
		}
		catch (Exception ce)
		{
			throw new EJBException("Error in getData of getADCAppData ::  " + ce.toString());
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