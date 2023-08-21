package com.sai.laps.management;

import java.sql.ResultSet;

import javax.ejb.EJBException;

import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.SQLParser;

public class ApplicationManager {
	public static boolean checkSession(String strUserId,int hidlogincount)
	{
		ResultSet rs=null;
		String strQuery="";
		int intlogincount=0;
	
		try 
		{
			strQuery=SQLParser.getSqlQuery("authenticate2^"+strUserId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				intlogincount=rs.getInt("lnk_logincount");
				if(intlogincount==hidlogincount)
					return true;
				else
					return false;
			}
			else
			{
				return false;
			}
			
		}catch(Exception ex)
		{
			throw new EJBException("Error in checkSession :: "+ex.toString());
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
		
	}
}
