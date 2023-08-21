package com.sai.laps.ejb.repgroups;

import java.sql.ResultSet;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "RepGroupsBean", mappedName = "RepGroupsHome")
@Remote (RepGroupsRemote.class)
public class RepGroupsBean extends BeanAdapter
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1586413060293089271L;
	static Logger log=Logger.getLogger(RepGroupsBean.class);
	/**
	 * 
	 */
	

	public HashMap getData(HashMap hshValues) 
	{
		HashMap hshRecord = new HashMap();
		String strMethod ="";

		try
		{
			strMethod=(String)hshValues.get("hidMethod");

			if (strMethod.equalsIgnoreCase("getRepDetails"))
			{
				hshRecord =(HashMap)getRepDetails(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("getGroupNames"))
			{
				hshRecord =(HashMap)getGroupNames(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("showProfile"))
			{
				hshRecord =(HashMap)showProfile(hshValues);
			} 
			else if (strMethod.equalsIgnoreCase("getParamList"))
			{
				hshRecord =(HashMap)getParamList(hshValues);
			} 
		
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getdata "+ce.toString());
		}
		
		return hshRecord;

	}

	private HashMap getRepDetails(HashMap hshRequestValues) 
	{
		ResultSet rs = null;		
		ArrayList vecRecords=null;
		HashMap hshRec=null;
		ArrayList vecVal =null;
		String strQuery=null;
		String strGrpName = null;
		String strGrpRights=null;
		String strOpFields = null;
		String strSelFields=null;
		String strTemp=null;
		ArrayList vecT = new ArrayList();
		String strDate=null;
		String strGen=null;
			
		try
		{
			strDate =(String)hshRequestValues.get("txtDate");
			strGen =(String)hshRequestValues.get("strUserId");
			strGrpName =(String)hshRequestValues.get("hidGrpName");
			strSelFields =(String)hshRequestValues.get("hidSelFields");
			strOpFields =(String)hshRequestValues.get("hidOpFields");
			rs=DBUtils.executeLAPSQuery("selusername^"+strGen);
			while (rs.next())
			{
				strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2))+" "+correctNull(rs.getString(3));
			}
			rs.close();
			StringTokenizer st = new StringTokenizer(strOpFields,",");
			while (st.hasMoreTokens())
			{
				vecT.add(st.nextToken());
			}
			strQuery = SQLParser.getSqlQuery("repgroups^"+strGrpName);
		    rs=DBUtils.executeQuery(strQuery);
			hshRec = new HashMap();
			vecVal = new ArrayList();
			while (rs.next())
			{
				vecRecords = new ArrayList();
				if (vecT.contains("grp_name"))
				{
					vecRecords.add(correctNull(
												rs.getString("grp_name")));
				}
				if (vecT.contains("navigational"))
				{
					strGrpRights =correctNull(rs.getString("grp_rights"));
					strTemp=getRights(strGrpRights,"All");
					vecRecords.add(strTemp);
				}
				if (vecT.contains("data"))
				{
					strTemp =strGrpRights.substring(18,19);
					if (strTemp.equals("w"))
					{
						strTemp ="Write";
					}
					else
					{
						strTemp ="Read";
					}
					vecRecords.add(strTemp);
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
			log.error("error in getData method.."+e.toString());
			throw new EJBException("inside getdata"+e.toString());
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
			catch(Exception e)
			{
				throw new EJBException("close"+e.toString()); 
			}
		}
		return hshRec;
	}

	private HashMap showProfile(HashMap hshPar) 
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		HashMap hshTemp = new HashMap();
		ArrayList vecLabel = new ArrayList();
		ArrayList vecValue = new ArrayList();
		String strParam = null;
		String hidGrpName = null;
		String hidSelFields = null;
		String strProfileName = null;

		try
		{
			hshTemp=(HashMap)EJBInvoker.executeStateLess("repData",hshPar,"getParameter");
			strParam = (String)hshTemp.get("param");
			strProfileName =(String)hshTemp.get("profilename");
			StringTokenizer st = new StringTokenizer(strParam,";");
			
			hidGrpName = st.nextToken();
	 		hidSelFields = st.nextToken();
			
			vecLabel.add("Profile Name");
			vecLabel.add("Group Names");
			vecLabel.add("Output Fields");

			vecValue.add(strProfileName);						
			rs=DBUtils.executeLAPSQuery("repgroups^"+hidGrpName);
			hidGrpName="";
			while(rs.next())
			{
				hidGrpName += correctNull(rs.getString("grp_name"))+",";		
			}
			hidGrpName = hidGrpName.substring(0,hidGrpName.length()-1);
			vecValue.add(hidGrpName);
			vecValue.add(hidSelFields);
			
			hshRecord.put("vecLabel",vecLabel);
			hshRecord.put("vecValue",vecValue);
			
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in help "+ce.toString());
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

	private HashMap getParamList(HashMap hshPar) 
	{
		HashMap hshRecord = new HashMap();
		HashMap hshTemp = new HashMap();
		String strParam = null;
		String strGrpName= null;
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
			
			strGrpName = st.nextToken();
			hidOpFields = st.nextToken();
			hidSelFields =st.nextToken();
			
			hshRecord.put("hidGrpName",strGrpName);
			hshRecord.put("hidSelFields",hidSelFields);
			hshRecord.put("hidOpFields",hidOpFields);
			hshRecord.put("txtDate",strDate);
			hshRecord.put("strUserId",strGen);
			
			hshPar = new HashMap();
			hshPar =(HashMap)getRepDetails(hshRecord);
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in help "+ce.toString());
		}
		
		return hshPar;
	}

	private HashMap getGroupNames(HashMap hshPar) 
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecCode = new ArrayList();
 		ArrayList vecValues = new ArrayList();		

		try
		{
			rs=DBUtils.executeLAPSQuery("selectgrpnames");
			while(rs.next())
			{
				 vecCode.add(correctNull(rs.getString("grp_id")));
				 vecValues.add(correctNull(rs.getString("grp_name")));	
			}
						
			hshRecord.put("vecCodes",vecCode);
			hshRecord.put("vecValues",vecValues);
			
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in help "+ce.toString());
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

	private String getRights(String strRights,String opt) 
	{
		String strValue="";
		try
		{
			if (opt.equals("All"))
			{		
				if (strRights.substring(0,1).equals("1"))
				{
					strValue = "Setup - Vital<br>";
				}
				if (strRights.substring(1,2).equals("1"))
				{
					strValue += "Setup - Non Vital<br>";
				}
				if (strRights.substring(2,3).equals("1"))
				{
					strValue += "Masters<br>";
				}
				if (strRights.substring(3,4).equals("1"))
				{
					strValue += "Defaulters List<br>";
				}
				if(strRights.substring(4,7).contains("1"))
				{
					strValue += "<b>Retail &amp; Agriculture</b><br>";
					if (strRights.substring(4,5).equals("1"))
					{
						strValue += "&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;Customer Profile <br>";
					}
					if (strRights.substring(5,6).equals("1"))
					{
						strValue += "&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;Application<br>";
					}
					if (strRights.substring(6,7).equals("1"))
					{
						strValue += "&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;Appraisal<br>";
					}
				}
				if(strRights.substring(7,10).contains("1"))
				{
					strValue += "<b>Tertiary</b><br>";
					if (strRights.substring(7,8).equals("1"))
					{
						strValue += "&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;Customer Profile<br>";
					}
					if (strRights.substring(8,9).equals("1"))
					{
						strValue += "&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;Application<br>";
					}
					if (strRights.substring(9,10).equals("1"))
					{
						strValue += "&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;Proposal<br>";
					}
				}
				if(strRights.substring(10,14).contains("1"))
				{
					strValue += "<b>Corporate &amp; SME</b><br>";
					if (strRights.substring(10,11).equals("1"))
					{
						strValue += "&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;Customer Profile<br>";
					}
					if (strRights.substring(11,12).equals("1"))
					{
						strValue += "&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;Application<br>";
					}
					if (strRights.substring(12,13).equals("1"))
					{
						strValue += "&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;Proposal <br>";
					}
					if (strRights.substring(13,14).equals("1"))
					{
						strValue += "&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;Executive Summary<br>";
					}
				}
				if (strRights.substring(14,15).equals("1"))
				{
					strValue += "Monitoring Register <br>";
				}
				if (strRights.substring(15,16).equals("1"))
				{
					strValue += "Monitoring Report <br>";
				}
				if (strRights.substring(16,17).equals("1"))
				{
					strValue += "NPA <br>";
				}
				if (strRights.substring(17,18).equals("1"))
				{
					strValue += "Reports";
				}
			}
/*			else
			{
				if (strRights.equals("w"))
				{
					strValue = "Write";
				}
				else if (strRights.equals("r"))
				{
					strValue = "Read";
				}
				else if (strRights.equals("x"))
				{
					strValue ="None";
				}
			}*/
		}
		catch(Exception e)
		{
			throw new EJBException("Error in help "+e.toString());
		}
		return strValue;
	}
}