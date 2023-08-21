package com.sai.laps.ejb.orgdetails;

import java.sql.ResultSet;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "OrgDetailsBean", mappedName = "OrgDetailsHome")
@Remote (OrgDetailsRemote.class)
public class OrgDetailsBean extends BeanAdapter
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public HashMap getData(HashMap hshValues) 
	{
		HashMap hshRecord = new HashMap();
		String strMethod ="";

		try
		{
			strMethod=(String)hshValues.get("hidMethod");

			if (strMethod.equalsIgnoreCase("getLevels"))
			{
				hshRecord =(HashMap)getLevels(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("getSubLevels"))
			{
				hshRecord =(HashMap)getSubLevels(hshValues);
			} 
			else if (strMethod.equalsIgnoreCase("getListValues"))
			{
				hshRecord =(HashMap)getListValues(hshValues);
			} 
			else if (strMethod.equalsIgnoreCase("getParamList"))
			{
				hshRecord =(HashMap)getParamList(hshValues);
			} 
			else if (strMethod.equalsIgnoreCase("showProfile"))
			{
				hshRecord =(HashMap)showProfile(hshValues);
			} 
			else if (strMethod.equalsIgnoreCase("getAnnexureDLevels"))
			{
				hshRecord =(HashMap)getAnnexureDLevels(hshValues);
			} 
			else if (strMethod.equalsIgnoreCase("getOrgLevels"))
			{
				hshRecord =(HashMap)getOrgLevels(hshValues);
			}
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getdata "+ce.toString());
		}
		return hshRecord;
	}

	private HashMap getListValues(HashMap hshValues) 
	{
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecBnkCode = new ArrayList();
		ArrayList vecBnkName = new ArrayList();
		String strValue = null;
		String strTemp  = null;

		try
		{			
			strValue=(String)hshValues.get("bnklevel");
			if (strValue.equalsIgnoreCase("Corporate Center") || strValue.equalsIgnoreCase("C"))
			{
				strTemp = "C";
			}
			else if (strValue.equalsIgnoreCase("Zone") || strValue.equalsIgnoreCase("R"))
			{
				strTemp = "R";
			}
			else if (strValue.equalsIgnoreCase("Region") || strValue.equalsIgnoreCase("D"))
			{
				strTemp = "D";
			}
			else if (strValue.equalsIgnoreCase("Branch") || strValue.equalsIgnoreCase("A"))
			{
				strTemp = "A";
			}
			strQuery = SQLParser.getSqlQuery("setorgrepbanks^"+strTemp);
			rs = DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				strTemp = rs.getString("org_level")+"-"+rs.getString("org_code");
				vecBnkCode.add(strTemp);
				vecBnkName.add(rs.getString("org_name"));
			}
			hshRecord.put("vecCodes",vecBnkCode);
			hshRecord.put("vecValues",vecBnkName);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in help "+ce.toString());
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

	private HashMap getLevels(HashMap hshPar) 
	{

		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strQuery = null;
		ArrayList vecBnkCode = new ArrayList();
 		ArrayList vecBnkName = new ArrayList();		
		String strTemp =null;

		try
		{			
			String orgLevel = correctNull((String)hshPar.get("org_Level"));
			String strParam=correctNull((String)hshPar.get("param"));
			strQuery = SQLParser.getSqlQuery("setorgreplevel");
			rs = DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				
				if((orgLevel.equals("C")) && !strParam.equalsIgnoreCase("BRCLPU"))
				{	
					strTemp = correctNull(rs.getString("glp_orgname1"));
					if (!strTemp.trim().equals(""))
					{
						strTemp = "C";
						vecBnkCode.add(strTemp);
					}
					strTemp = correctNull(rs.getString("glp_orgname1"));
					if (!strTemp.trim().equals(""))
					{
						vecBnkName.add(strTemp);
					}
				}	
				if((orgLevel.equals("C") || orgLevel.equals("R"))&& !strParam.equalsIgnoreCase("BRCLPU") )
				{	
					strTemp = correctNull(rs.getString("glp_orgname2"));
					if (!strTemp.trim().equals(""))
					{
						strTemp = "R";
						vecBnkCode.add(strTemp);
					}
					
					strTemp = correctNull(rs.getString("glp_orgname2"));
					if (!strTemp.trim().equals(""))
					{
						vecBnkName.add(strTemp);
					}
				}	
				if((orgLevel.equals("C") || orgLevel.equals("R"))&& !strParam.equalsIgnoreCase("BRCLPU"))
				{
					if(!strParam.equalsIgnoreCase("secval"))
					{
						strTemp = "CPC";
						if (!strTemp.trim().equals(""))
						{
							vecBnkCode.add(strTemp);
							vecBnkName.add(strTemp);
						}
					}
				}
				if(orgLevel.equals("C") || orgLevel.equals("R") || orgLevel.equals("D"))
				{
					strTemp = correctNull(rs.getString("glp_orgname3"));
					if (!strTemp.trim().equals(""))
					{
						strTemp = "D";
						vecBnkCode.add(strTemp);
					}
					strTemp = correctNull(rs.getString("glp_orgname3"));
					if (!strTemp.trim().equals(""))
					{
						vecBnkName.add(strTemp);
					}
				}	
				if(!orgLevel.equals("B"))
				{	
					strTemp = correctNull(rs.getString("glp_orgname4"));
					if (!strTemp.trim().equals(""))
					{
						strTemp = "A";
						vecBnkCode.add(strTemp);
					}
					strTemp = correctNull(rs.getString("glp_orgname4"));
					if (!strTemp.trim().equals(""))
					{
						vecBnkName.add(strTemp);
					}
				}	
				
				strTemp = correctNull(rs.getString("glp_orgname5"));
				if (!strTemp.trim().equals(""))
				{
					strTemp = "B";
					vecBnkCode.add(strTemp);
				}
				strTemp = correctNull(rs.getString("glp_orgname5"));
				if (!strTemp.trim().equals(""))
				{
					vecBnkName.add(strTemp);
				}
				
				
				
				
			}
			hshRecord.put("vecCodes",vecBnkCode);
			hshRecord.put("vecValues",vecBnkName);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in help "+ce.toString());
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
	private HashMap getOrgLevels(HashMap hshPar) 
	{

		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strQuery = null;
		ArrayList vecBnkCode = new ArrayList();
 		ArrayList vecBnkName = new ArrayList();		
		String strTemp =null;

		try
		{			
			String orgLevel = correctNull((String)hshPar.get("org_Level"));
			strQuery = SQLParser.getSqlQuery("setorgreplevel");
			rs = DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				
				if(orgLevel.equals("C"))
				{	
					strTemp = correctNull(rs.getString("glp_orgname1"));
					if (!strTemp.trim().equals(""))
					{
						strTemp = "C";
						vecBnkCode.add(strTemp);
					}
					strTemp = correctNull(rs.getString("glp_orgname1"));
					if (!strTemp.trim().equals(""))
					{
						vecBnkName.add(strTemp);
					}
				}	
				if(orgLevel.equals("C") || orgLevel.equals("R") )
				{	
					strTemp = correctNull(rs.getString("glp_orgname2"));
					if (!strTemp.trim().equals(""))
					{
						strTemp = "R";
						vecBnkCode.add(strTemp);
					}
					
					strTemp = correctNull(rs.getString("glp_orgname2"));
					if (!strTemp.trim().equals(""))
					{
						vecBnkName.add(strTemp);
					}
				}	
				if(orgLevel.equals("C") || orgLevel.equals("R") || orgLevel.equals("D"))
				{
					strTemp = correctNull(rs.getString("glp_orgname3"));
					if (!strTemp.trim().equals(""))
					{
						strTemp = "D";
						vecBnkCode.add(strTemp);
					}
					//strTemp = correctNull(rs.getString("glp_orgname3"));
					strTemp = "CLPH";
					if (!strTemp.trim().equals(""))
					{
						vecBnkName.add(strTemp);
					}
				}	
				if(orgLevel.equals("C") || orgLevel.equals("R"))
				{
					strTemp = "CPC";
					if (!strTemp.trim().equals(""))
					{
						vecBnkCode.add(strTemp);
						vecBnkName.add(strTemp);
					}
				}
				if(!orgLevel.equals("B"))
				{	
					strTemp = correctNull(rs.getString("glp_orgname4"));
					if (!strTemp.trim().equals(""))
					{
						strTemp = "A";
						vecBnkCode.add(strTemp);
					}
					strTemp = correctNull(rs.getString("glp_orgname4"));
					if (!strTemp.trim().equals(""))
					{
						vecBnkName.add(strTemp);
					}
				}	
				
				strTemp = correctNull(rs.getString("glp_orgname5"));
				if (!strTemp.trim().equals(""))
				{
					strTemp = "B";
					vecBnkCode.add(strTemp);
				}
				strTemp = correctNull(rs.getString("glp_orgname5"));
				if (!strTemp.trim().equals(""))
				{
					vecBnkName.add(strTemp);
				}
				
				
				
				
			}
			hshRecord.put("vecCodes",vecBnkCode);
			hshRecord.put("vecValues",vecBnkName);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in help "+ce.toString());
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

	private HashMap getSubLevels(HashMap hshRequestValues) 
	{		
		ResultSet rs = null;
		ResultSet rs1 = null;
		ArrayList vecRecords=null;
		HashMap hshRec=null;
		ArrayList vecVal =null;
		String strQuery=null;
		String strBankCode = null;
		String strBankLevel  = null;
		String strOpFields = null;
		String strSelFields=null;
		ArrayList vecT = new ArrayList();
		String strDate=null;
		String strGen=null;
			
		try
		{			
			strDate =(String)hshRequestValues.get("txtDate");
			strGen =(String)hshRequestValues.get("strUserId");
			strSelFields =(String)hshRequestValues.get("hidSelFields");
			strOpFields =(String)hshRequestValues.get("hidOpFields");
			strQuery = SQLParser.getSqlQuery("selusername^"+strGen);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2));//+" "+correctNull(rs.getString(3));
			}
			rs.close();
			StringTokenizer st = new StringTokenizer(strOpFields,",");
			while (st.hasMoreTokens())
			{
				vecT.add(st.nextToken());
			}
			strBankLevel =(String)hshRequestValues.get("bnklevel");
			strBankCode = (String)hshRequestValues.get("hidOrgCode");
			if (strBankLevel.equalsIgnoreCase("C"))
			{
				strBankCode = strBankCode.substring(0,3);
			}
			else if (strBankLevel.equalsIgnoreCase("R"))
			{
				strBankCode = strBankCode.substring(0,6);
			}
			else if (strBankLevel.equalsIgnoreCase("D"))
			{
				strBankCode = strBankCode.substring(0,9);
			}
			else if (strBankLevel.equalsIgnoreCase("A"))
			{
				strBankCode = strBankCode.substring(0,12);
			}
			else if (strBankLevel.equalsIgnoreCase("B"))
			{
				strBankCode = strBankCode.substring(0,15);
			}
			strQuery = SQLParser.getSqlQuery("setorgrep^"+strOpFields+"^"+strBankCode);
			rs = DBUtils.executeQuery(strQuery);
			hshRec = new HashMap();
			vecVal = new ArrayList();
			while (rs.next())
			{
				vecRecords = new ArrayList();
				vecRecords.add(correctNull(rs.getString("org_level")));
				if (vecT.contains("org_name"))
				{
					vecRecords.add(correctNull(rs.getString("org_name")));
				}
				if (vecT.contains("org_add1"))
				{
					vecRecords.add(correctNull(rs.getString("org_add1")));
				}
				if (vecT.contains("org_add2"))
				{
					vecRecords.add(correctNull(rs.getString("org_add2")));
				}
				if (vecT.contains("org_city"))
				{
				
					rs1=DBUtils.executeLAPSQuery("selcitycode^"+correctNull((String)rs.getString("org_city")));
					if(rs1.next()){
						vecRecords.add(correctNull((String)rs1.getString("city_name")));
					}else{
						vecRecords.add("");
					}
					if(rs1 != null){
						rs1.close();
					}
				}
				
				if (vecT.contains("org_state"))
				{
					rs1=DBUtils.executeLAPSQuery("selstatename2^"+correctNull((String)rs.getString("org_state")));
					if(rs1.next()){
						vecRecords.add(correctNull((String)rs1.getString("state_name")));
					}else{
						vecRecords.add("");
					}
					if(rs1 != null){
						rs1.close();
					}
					
				}
				
				if (vecT.contains("org_zip"))
				{
					vecRecords.add(correctNull(rs.getString("org_zip")));
				}
				if (vecT.contains("org_phone"))
				{
					vecRecords.add(correctNull(rs.getString("org_phone")));
				}
				if (vecT.contains("org_fax"))
				{
				vecRecords.add(correctNull(rs.getString("org_fax")));
				}
				if (vecT.contains("org_url"))
				{
					vecRecords.add(correctNull(rs.getString("org_url")));
				}
				vecVal.add(vecRecords);
			}
			hshRec.put("vecValues",vecVal);
			hshRec.put("labels",strSelFields);
			hshRec.put("txtDate",strDate);
			hshRec.put("genby",strGen);
		}
		catch(Exception e)
		{
			throw new EJBException("inside getdata"+e.toString());
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
			catch(Exception e)
			{
				throw new EJBException("close"+e.toString()); 
			}
		}
		return hshRec;
	}

	private HashMap getParamList(HashMap hshPar) 
	{
		HashMap hshRecord = new HashMap();
		HashMap hshTemp = new HashMap();
		String strTemp=null;
		String strParam = null;
		String strBankCode = null;
		String strBankLevel  = null;
		String hidOpFields = null;
		String hidSelFields = null;
		String strDate =null;
		String strGen =null;

		try
		{
			hshTemp=(HashMap)EJBInvoker.executeStateLess("repData",hshPar,"getParameter");
			strGen =(String)hshTemp.get("genby");
			strDate =(String)hshTemp.get("txtDate");
			strParam =(String)hshTemp.get("param");
			StringTokenizer st = new StringTokenizer(strParam,";");
			strTemp = st.nextToken();
			strBankLevel =strTemp.substring(0,1);
			strBankCode = strTemp.substring(strTemp.indexOf("-")+1,strTemp.length());
			strTemp = st.nextToken();
			hidOpFields = strTemp;
			strTemp = st.nextToken();
			hidSelFields =strTemp;
			hshRecord.put("bnklevel",strBankLevel);
			hshRecord.put("hidOrgCode",strBankCode);
			hshRecord.put("hidSelFields",hidSelFields);
			hshRecord.put("hidOpFields",hidOpFields);
			hshRecord.put("txtDate",strDate);
			hshRecord.put("strUserId",strGen);
			hshPar = new HashMap();
			hshPar =(HashMap)getSubLevels(hshRecord);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in help "+ce.toString());
		}
		return hshPar;
	}

	private HashMap showProfile(HashMap hshPar) 
	{		
		ResultSet rs = null;
		String strQuery = null;
		HashMap hshRecord = new HashMap();
		HashMap hshTemp = new HashMap();
		ArrayList vecLabel = new ArrayList();
		ArrayList vecValue = new ArrayList();
		String strTemp=null;
		String strParam = null;
		String strBankCode = null;
		String strBankLevel  = null;
		String hidOpFields = null;
		String hidSelFields = null;
		String strProfileName = null;

		try
		{					
			hshTemp=(HashMap)EJBInvoker.executeStateLess("repData",hshPar,"getParameter");
			strParam = (String)hshTemp.get("param");
			strProfileName =(String)hshTemp.get("profilename");
			StringTokenizer st = new StringTokenizer(strParam,";");
			strTemp = st.nextToken();
			strBankLevel =strTemp.substring(0,1);
			strBankCode = strTemp.substring(strTemp.indexOf("-")+1,strTemp.length());
			strTemp = st.nextToken();
			hidOpFields = strTemp;
			strTemp = st.nextToken();
			hidSelFields =strTemp;
			vecLabel.add("Profile Name");
			vecLabel.add("Organisation Level");
			vecLabel.add("Organisation Name");
			vecLabel.add("Output Fields");

			if (strBankLevel.equalsIgnoreCase("C"))
			{
				strBankLevel = "Corporate";
			}
			else if (strBankLevel.equalsIgnoreCase("R"))
			{
				strBankLevel = "Region";
			}
			else if (strBankLevel.equalsIgnoreCase("D"))
			{
				strBankLevel = "District";
			}
			else if (strBankLevel.equalsIgnoreCase("A"))
			{
				strBankLevel = "Area";
			}
			else if (strBankLevel.equalsIgnoreCase("B"))
			{
				strBankLevel = "Branch";
			}
			strQuery = SQLParser.getSqlQuery("repbankname^"+strBankCode);
			rs = DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				strBankCode = correctNull(rs.getString("org_name"));			
			}
			vecValue.add(strProfileName);
			vecValue.add(strBankLevel);
			vecValue.add(strBankCode);
			vecValue.add(hidSelFields);
			hshRecord.put("vecLabel",vecLabel);
			hshRecord.put("vecValue",vecValue);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in help "+ce.toString());
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
	
	
	private HashMap getAnnexureDLevels(HashMap hshPar) 
	{

		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strQuery = null;
		ArrayList vecBnkCode = new ArrayList();
 		ArrayList vecBnkName = new ArrayList();		
		String strTemp =null;
		String strParam="";

		try
		{			
			String orgLevel = correctNull((String)hshPar.get("org_Level"));
			strParam= correctNull((String)hshPar.get("param"));
			strQuery = SQLParser.getSqlQuery("setorgreplevel");
			rs = DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				if(strParam.equalsIgnoreCase("D"))
				{
					if(orgLevel.equals("C"))
					{	
						strTemp = correctNull(rs.getString("glp_orgname1"));
						if (!strTemp.trim().equals(""))
						{
							strTemp = "C";
							vecBnkCode.add(strTemp);
						}
						strTemp = correctNull(rs.getString("glp_orgname1"));
						if (!strTemp.trim().equals(""))
						{
							vecBnkName.add(strTemp);
						}
					}	
					if(orgLevel.equals("C") || orgLevel.equals("R") )
					{	
						strTemp = correctNull(rs.getString("glp_orgname2"));
						if (!strTemp.trim().equals(""))
						{
							strTemp = "R";
							vecBnkCode.add(strTemp);
						}
						
						strTemp = correctNull(rs.getString("glp_orgname2"));
						if (!strTemp.trim().equals(""))
						{
							vecBnkName.add(strTemp);
						}
					}	
					if(orgLevel.equals("C") || orgLevel.equals("R") || orgLevel.equals("D"))
					{
						strTemp = correctNull(rs.getString("glp_orgname3"));
						if (!strTemp.trim().equals(""))
						{
							strTemp = "D";
							vecBnkCode.add(strTemp);
						}
						strTemp = correctNull(rs.getString("glp_orgname3"));
						if (!strTemp.trim().equals(""))
						{
							vecBnkName.add(strTemp);
						}
					}	
					if(orgLevel.equals("A"))
					{	
						strTemp = correctNull(rs.getString("glp_orgname4"));
						if (!strTemp.trim().equals(""))
						{
							strTemp = "A";
							vecBnkCode.add(strTemp);
						}
						strTemp = correctNull(rs.getString("glp_orgname4"));
						if (!strTemp.trim().equals(""))
						{
							vecBnkName.add(strTemp);
						}
					}	
				}
				else if(strParam.equalsIgnoreCase("MMR"))
				{
					if(orgLevel.equals("C") || orgLevel.equals("R") || orgLevel.equals("D"))
					{
						strTemp = correctNull(rs.getString("glp_orgname3"));
						if (!strTemp.trim().equals(""))
						{
							strTemp = "D";
							vecBnkCode.add(strTemp);
						}
						strTemp = correctNull(rs.getString("glp_orgname3"));
						if (!strTemp.trim().equals(""))
						{
							vecBnkName.add(strTemp);
						}
					}	
					if(orgLevel.equals("C") || orgLevel.equals("R") || orgLevel.equals("D") || orgLevel.equals("A"))
					{	
						strTemp = correctNull(rs.getString("glp_orgname4"));
						if (!strTemp.trim().equals(""))
						{
							strTemp = "A";
							vecBnkCode.add(strTemp);
						}
						strTemp = correctNull(rs.getString("glp_orgname4"));
						if (!strTemp.trim().equals(""))
						{
							vecBnkName.add(strTemp);
						}
					}
				}
					
			}
			hshRecord.put("vecCodes",vecBnkCode);
			hshRecord.put("vecValues",vecBnkName);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in help "+ce.toString());
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
	
	
	
}