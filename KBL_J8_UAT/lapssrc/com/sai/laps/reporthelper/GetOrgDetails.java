package com.sai.laps.reporthelper;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;

import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

public class GetOrgDetails{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4873919707002965053L;

	public HashMap getLevels(HashMap hshPar) 
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strQuery = null;
		ArrayList arrBnkCode = new ArrayList();
 		ArrayList arrBnkName = new ArrayList();		
		String strTemp =null;

		try
		{			
			String orgLevel = Helper.correctNull((String)hshPar.get("org_Level"));
			strQuery = SQLParser.getSqlQuery("setorgreplevel");
			rs = DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				if(orgLevel.equals("C"))
				{	
					strTemp = Helper.correctNull(rs.getString("glp_orgname1"));
					if (!strTemp.trim().equals(""))
					{
						strTemp = "C";
						arrBnkCode.add(strTemp);
					}
					strTemp = Helper.correctNull(rs.getString("glp_orgname1"));
					if (!strTemp.trim().equals(""))
					{
						arrBnkName.add(strTemp);
					}
				}	
				if(orgLevel.equals("C") || orgLevel.equals("R") )
				{	
					strTemp = Helper.correctNull(rs.getString("glp_orgname2"));
					if (!strTemp.trim().equals(""))
					{
						strTemp = "R";
						arrBnkCode.add(strTemp);
					}
					strTemp = Helper.correctNull(rs.getString("glp_orgname2"));
					if (!strTemp.trim().equals(""))
					{
						arrBnkName.add(strTemp);
					}
				}	
				if(orgLevel.equals("C") || orgLevel.equals("R") || orgLevel.equals("D"))
				{
					strTemp = Helper.correctNull(rs.getString("glp_orgname3"));
					if (!strTemp.trim().equals(""))
					{
						strTemp = "D";
						arrBnkCode.add(strTemp);
					}
					strTemp = Helper.correctNull(rs.getString("glp_orgname3"));
					if (!strTemp.trim().equals(""))
					{
						arrBnkName.add(strTemp);
					}
				}	
				if(!orgLevel.equals("B"))
				{	
					strTemp = Helper.correctNull(rs.getString("glp_orgname4"));
					if (!strTemp.trim().equals(""))
					{
						strTemp = "A";
						arrBnkCode.add(strTemp);
					}
					strTemp = Helper.correctNull(rs.getString("glp_orgname4"));
					if (!strTemp.trim().equals(""))
					{
						arrBnkName.add(strTemp);
					}
				}	
				
				strTemp = Helper.correctNull(rs.getString("glp_orgname5"));
				if (!strTemp.trim().equals(""))
				{
					strTemp = "B";
					arrBnkCode.add(strTemp);
				}
				strTemp = Helper.correctNull(rs.getString("glp_orgname5"));
				if (!strTemp.trim().equals(""))
				{
					arrBnkName.add(strTemp);
				}
			}
			hshRecord.put("arrCodes",arrBnkCode);
			hshRecord.put("arrValues",arrBnkName);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in GetOrgDetails -> getLevels :: "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs!=null)
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
	
	public HashMap getOrgNames(HashMap hshValues) 
	{
	
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arrBnkCode = new ArrayList();
		ArrayList arrBnkName = new ArrayList();
		String strBnkLevel  = null;
		String strTemp=null;
		boolean bState=false;

		try
		{
			strBnkLevel=(String)hshValues.get("bnklevel");
			
			String strOrglevel=Helper.correctNull((String)hshValues.get("strOrgLevel"));
			String strOrgcode= Helper.correctNull((String)hshValues.get("strOrgCode"));
			String strAppend=" ";
			if (strOrglevel.equals("C"))
			{
				strOrgcode=strOrgcode.substring(0,3)+"%%%%%%%%%%%";
			}
			else if(strOrglevel.equals("R"))
			{
				strOrgcode=strOrgcode.substring(0,6)+"%%%%%%%%";
			}
			else if(strOrglevel.equals("D"))
			{
				strOrgcode=strOrgcode.substring(0,9)+"%%%%%%";
			}
			else if(strOrglevel.equals("A"))
			{
				strOrgcode=strOrgcode.substring(0,12)+"%%%%%";
			}
			else if(strOrglevel.equals("B"))
			{
				strOrgcode=strOrgcode.substring(0,15);
			}
				
			
			if(strBnkLevel.equalsIgnoreCase("C"))
			{
				strAppend=" ";
			}
			else if(strBnkLevel.equalsIgnoreCase("R"))
			{
				strAppend="and org_code  in (select RPAD(SUBSTR(org_code,0,6),15,0) from organisations where org_level ='A')";
			}
			else if(strBnkLevel.equalsIgnoreCase("D"))
			{
				strAppend="and org_code  in (select RPAD(SUBSTR(org_code,0,9),15,0) from organisations where org_level ='A')";
			}
			else if(strBnkLevel.equalsIgnoreCase("A"))
			{
				strAppend=" ";
			}
			
			strQuery = SQLParser.getSqlQuery("selorgchildnames^"+strOrgcode+"^"+strBnkLevel+"^"+strAppend);
			
			if(rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			bState = rs.next();
			if (bState)
			{
				rs.beforeFirst();
				while(rs.next())
				{
					strTemp = rs.getString("org_level")+"-"+rs.getString("org_code");
					arrBnkCode.add(strTemp);
					arrBnkName.add(rs.getString("org_name"));
				}
			}
			else
			{
				arrBnkCode.add("nil");
				arrBnkName.add("nil");
			}
			
			hshRecord.put("arrCodes",arrBnkCode);
			hshRecord.put("arrValues",arrBnkName);
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in  GetOrgDetails-> getOrgNames "+ce.toString());
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
}