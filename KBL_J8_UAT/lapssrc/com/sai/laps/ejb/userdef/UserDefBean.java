package com.sai.laps.ejb.userdef;

import java.sql.ResultSet;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.undelete.UndeleteBean;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "UserDefBean", mappedName = "UserDefHome")
@Remote (UserDefRemote.class)
public class UserDefBean extends BeanAdapter
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5522674113579518210L;
	static Logger log=Logger.getLogger(UserDefBean.class);
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

			if (strMethod.equalsIgnoreCase("getUserClass"))
			{
				hshRecord =(HashMap)getUserClass(hshValues);
			} 
			else if (strMethod.equalsIgnoreCase("getRepDetails"))
			{
				hshRecord =(HashMap)getRepDetails(hshValues);
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
			throw new EJBException("Error in getdata "+ce.toString());
		}
		
		return hshRecord;

	}

	
	
	private HashMap getUserClass(HashMap hshPar) 
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecUsrCode = new ArrayList();
 		ArrayList vecUsrClass = new ArrayList();		

		try
		{
			rs=DBUtils.executeLAPSQuery("selectusrclass");
			while(rs.next())
			{
				 vecUsrCode.add(correctNull(rs.getString("usr_class")));
				 vecUsrClass.add(correctNull(rs.getString("usr_class")));	
			}
						
			hshRecord.put("vecCodes",vecUsrCode);
			hshRecord.put("vecValues",vecUsrClass);
			if(rs != null)
			{
				rs.close();
			}
		}
		catch(Exception ce)
		{
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
	
	private HashMap getRepDetails(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		ResultSet rs1 = null;
		ArrayList vecRecords=null;
		HashMap hshRec=null;
		ArrayList vecVal =null;
		String strQuery=null;
		String strOrgCode = null;
		String strOpFields = null;
		String strSelFields=null;
		String strClass=null;
		String strAvail=null;
		String strTemp=null;
		ArrayList vecT = new ArrayList();
		String strOrgName = "";
		String strDate=null;
		String strGen=null;
			
		try
		{
			strDate =(String)hshRequestValues.get("txtDate");
			strGen =(String)hshRequestValues.get("strUserId");
			strAvail =(String)hshRequestValues.get("hidAvail");
			strOrgCode =(String)hshRequestValues.get("hidOrgCode");
			strClass =(String)hshRequestValues.get("hidClass");
			strSelFields =(String)hshRequestValues.get("hidSelFields");
			strOpFields =(String)hshRequestValues.get("hidOpFields");
			rs=DBUtils.executeLAPSQuery("selusername^"+strGen);
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
			strQuery = SQLParser.getSqlQuery("repuserdef^"+strOpFields+"^"+strAvail+"^"+strOrgCode+"^"+strClass);
					
			rs = DBUtils.executeQuery(strQuery);
			
			hshRec = new HashMap();
			vecVal = new ArrayList();
			while (rs.next())
			{
				vecRecords = new ArrayList();
				
				if (vecT.contains("org_name"))
				{
					strTemp =correctNull(rs.getString("org_name"));
					if (strTemp.equals(strOrgName))
					{
						vecRecords.add("&nbsp;");
					}
					else
					{
						vecRecords.add(strTemp);
					}
					strOrgName=strTemp;
					vecRecords.add("left");
										
				}
				if (vecT.contains("usr_class"))
				{
					vecRecords.add(correctNull(
												rs.getString("usr_class")));
					vecRecords.add("center");
				}
				if (vecT.contains("usr_id"))
				{
					vecRecords.add(correctNull(
												rs.getString("usr_id")));
					vecRecords.add("left");
				}
				if (vecT.contains("usr_fname"))
				{
					strTemp =correctNull(rs.getString("usr_fname"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if (vecT.contains("usr_lname"))
				{
					strTemp =correctNull(rs.getString("usr_lname"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if (vecT.contains("usr_avail"))
				{
					strTemp =correctNull(rs.getString("usr_avail"));
					if (strTemp.equalsIgnoreCase("a"))
					{
						strTemp ="Available";
					}
					else
					{
						strTemp="Un Available";
					}
					vecRecords.add(strTemp);
					vecRecords.add("left");
					
				}
				if (vecT.contains("grp_name"))
				{
					strTemp =correctNull(rs.getString("grp_name"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if (vecT.contains("user_designation"))
				{
					strTemp =correctNull(rs.getString("user_designation"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				/*if (vecT.contains("usr_supid"))
				{
					strTemp =correctNull(rs.getString("usr_supid"));
					rs1=DBUtils.executeLAPSQuery("selectusername^"+strTemp);
					strTemp="&nbsp;";
					while (rs1.next())
					{
						strTemp =correctNull(rs1.getString(1)).trim();
						if (strTemp.equals(""))
						{
							strTemp ="&nbsp;";
						}
					}
					rs1.close();
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}*/
				if (vecT.contains("usr_mname"))
				{
					strTemp =correctNull(rs.getString("usr_mname"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				
				vecVal.add(vecRecords);
			}
			hshRec.put("vecValues",vecVal);
			hshRec.put("labels",strSelFields);
			hshRec.put("txtDate",strDate);
			hshRec.put("genby",strGen);
			if(rs!= null)
			{
				rs.close();
			}
		}
		catch(Exception e)
		{
			throw new EJBException("inside getdata"+e.toString());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
				if(rs1 != null)
				{
					rs1.close();
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
		String strOrgLevel = null;
		String strAvail  = null;
		String strClass = null;
		String hidOrgCode = null;
		String hidOpFields = null;
		String hidSelFields = null;
		String strProfileName = null;

		try
		{
			hshTemp=(HashMap)EJBInvoker.executeStateLess("repData",hshPar,"getParameter");
			strParam = (String)hshTemp.get("param");
			strProfileName =(String)hshTemp.get("profilename");
			StringTokenizer st = new StringTokenizer(strParam,";");
			
			strOrgLevel = st.nextToken();
			strAvail =  st.nextToken();
			hidOrgCode = st.nextToken();
			strClass = st.nextToken();
			hidOpFields =st.nextToken();
	 		hidSelFields = st.nextToken();
			
			vecLabel.add("Profile Name");
			vecLabel.add("Organisation Level");
			vecLabel.add("Availability");
			vecLabel.add("Organisation Names");
			vecLabel.add("Class");
			vecLabel.add("Output Fields");

			if (strAvail.equalsIgnoreCase("a"))
			{
				strAvail = "Available";
			}
			else 
			{
				strAvail = "Un Available";
			}

			
			vecValue.add(strProfileName);						
			vecValue.add(strOrgLevel);
			vecValue.add(strAvail);
			rs=DBUtils.executeLAPSQuery("repbanknames^"+hidOrgCode);
			hidOrgCode="";
			while(rs.next())
			{
				hidOrgCode += correctNull(rs.getString("org_name"))+",";		
			}
			hidOrgCode = hidOrgCode.substring(0,hidOrgCode.length()-1);
			vecValue.add(hidOrgCode);
			vecValue.add(strClass);
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
		String strTemp=null;
		String strParam = null;
		String strAvail  = null;
		String strOrgCode= null;
		String strClass = null;
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
			strAvail= st.nextToken();
			strOrgCode = st.nextToken();
			strClass =st.nextToken();
			hidOpFields = st.nextToken();
			hidSelFields =st.nextToken();
			
			hshRecord.put("hidAvail",strAvail);
			hshRecord.put("hidOrgCode",strOrgCode);
			hshRecord.put("hidClass",strClass);
			hshRecord.put("hidSelFields",hidSelFields);
			hshRecord.put("hidOpFields",hidOpFields);
			hshRecord.put("txtDate",strDate);
			hshRecord.put("strUserId",strGen);
			hshPar = new HashMap();
			hshPar =(HashMap)getRepDetails(hshRecord);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in help "+ce.toString());
		}
		
		return hshPar;
	}
}