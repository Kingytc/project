/******************************************************************************
 * Package:			com.sai.laps.ejb.repappexception
 * File:			RepAppExceptionBean.java
 * Description:		Bean Implementation Class for Application Exception Report
 * @author			R.Saraswathi 
 ******************************************************************************/

package com.sai.laps.ejb.repappexception;

import java.sql.ResultSet;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "RepAppExceptionBean", mappedName = "RepAppExceptionHome")
@Remote (RepAppExceptionRemote.class)
public class RepAppExceptionBean extends BeanAdapter
{
	/**
	 * 
	 */

	private static final long serialVersionUID = -6568561193580897098L;
	static Logger log=Logger.getLogger(RepAppExceptionBean.class);

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
		String strOrgCode = null;
		String strSelFields=null;
		String strStatus=null;
		String strTemp=null;
		String strToDate=null;
		String strDate=null;
		String strFromDate=null;
		String strLoanType = null;
		String strBetween ="";
		String strGen=null;
		String strSaveDate = null;
			
		try
		{
			strSaveDate =(String)hshRequestValues.get("txtSaveDate");
			strGen =(String)hshRequestValues.get("strUserId");
			
			strOrgCode =(String)hshRequestValues.get("hidOrgCode");
			strSelFields =(String)hshRequestValues.get("hidSelFields");
			strStatus =(String)hshRequestValues.get("hidStatus");
			strLoanType =(String)hshRequestValues.get("hidLoanType");
			strDate =(String)hshRequestValues.get("txtDate");
			strQuery = SQLParser.getSqlQuery("selusername^"+strGen);
			rs= DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2))+" "+correctNull(rs.getString(3));
			}
			if (strStatus.equalsIgnoreCase("a"))
			{
				strBetween = " between 1 and 16 ";
			}
			else if (strStatus.equalsIgnoreCase("r"))
			{
				strBetween = " not between 9 and 16 ";
			}
			else if (strStatus.equalsIgnoreCase("p"))
			{
				strBetween = " between 1 and 8 ";
			}
			if(strDate.equals("All"))
			{
				strQuery = SQLParser.getSqlQuery("selappexcep^"+strOrgCode+"^"+strStatus+"^"+strLoanType+"^"+strBetween);
			}
			else
			{
				strFromDate = strDate.substring(0,strDate.indexOf("-"));
				strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				strQuery = SQLParser.getSqlQuery("selappexcepdt^"+strOrgCode+"^"+strStatus+"^"+strLoanType+"^"+strBetween+"^"+strFromDate+"^"+strToDate);
			}
			rs= DBUtils.executeQuery(strQuery);
			hshRec = new HashMap();
			vecVal = new ArrayList();
			while (rs.next())
			{
				vecRecords = new ArrayList();
				
				strTemp =correctNull(rs.getString("app_no"));
				vecRecords.add(strTemp);
				vecRecords.add("left");
				
				strTemp =correctNull(rs.getString("createdate"));
				vecRecords.add(strTemp);
				vecRecords.add("center");

				strTemp =correctNull(rs.getString("prd_desc"));
				vecRecords.add(strTemp);
				vecRecords.add("left");

				strTemp =correctNull(rs.getString("org_name"));
				vecRecords.add(strTemp);
				vecRecords.add("left");
				
				strTemp =correctNull(rs.getString("permittedhrs"));
				vecRecords.add(strTemp);
				vecRecords.add("center");

				strTemp =correctNull(rs.getString("actualhrs"));
				if (strTemp.trim().equals(""))
				{
					strTemp="Not Processed";
				}
				vecRecords.add(strTemp);
				vecRecords.add("center");
				
				int t =rs.getInt("exceededhrs");
				if (t < 0)
				{
					strTemp="0";
				}
				else
				{
					strTemp =correctNull(rs.getString("exceededhrs"));
				}
				if (strTemp.trim().equals(""))
				{
					strTemp="Not Processed";
				}
				vecRecords.add(strTemp);
				vecRecords.add("center");
			
				vecVal.add(vecRecords);
			}
			hshRec.put("txtDate",strDate);
			hshRec.put("vecValues",vecVal);
			hshRec.put("labels",strSelFields);
			hshRec.put("genby",strGen);
			hshRec.put("txtSaveDate",strSaveDate);
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

	private HashMap showProfile(HashMap hshPar) 
	{
		ResultSet rs = null;
		String strQuery = null;
		HashMap hshRecord = new HashMap();
		HashMap hshTemp = new HashMap();
		ArrayList vecLabel = new ArrayList();
		ArrayList vecValue = new ArrayList();
		String strParam = null;
		String strPeriod=null;
		String strStatus =null;
		String strOrgLevel = null;
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
			hidOrgCode = st.nextToken();
			strStatus = st.nextToken();
			strPeriod = st.nextToken();
			hidOpFields =st.nextToken();
	 		hidSelFields = st.nextToken();
			
			vecLabel.add("Profile Name");
			vecLabel.add("Organisation Level");
			vecLabel.add("Organisation Names");
			vecLabel.add("Process Status");
			vecLabel.add("Peroid");
			vecLabel.add("Output Fields");

			vecValue.add(strProfileName);						
			vecValue.add(strOrgLevel);
			strQuery = SQLParser.getSqlQuery("repbanknames^"+hidOrgCode);
			rs= DBUtils.executeQuery(strQuery);
			hidOrgCode="";
			while(rs.next())
			{
				hidOrgCode += correctNull(rs.getString("org_name"))+",";		
			}
			hidOrgCode = hidOrgCode.substring(0,hidOrgCode.length()-1);
			vecValue.add(hidOrgCode);
			if (strStatus.equalsIgnoreCase("p"))
			{
				strStatus="Pending";
			}
			else  if (strStatus.equalsIgnoreCase("a"))
			{
				strStatus="Approved";
			}
			else if (strStatus.equalsIgnoreCase("r"))
			{
				strStatus="Rejected";
			}
			vecValue.add(strStatus);
			vecValue.add(strPeriod);
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

	private HashMap getParamList(HashMap hshPar) 
	{
		HashMap hshRecord = new HashMap();
		HashMap hshTemp = new HashMap();
		String strTemp=null;
		String strParam = null;
		String strOrgCode= null;
		String hidOpFields = null;
		String hidSelFields = null;
		String strPeriod=null;
		String strStatus =null;
		String strLoanType=null;
		String strSaveDate =null;
		String strGen =null;

		try
		{
						
			hshTemp=(HashMap)EJBInvoker.executeStateLess("repData",hshPar,"getParameter");
			strGen =(String)hshTemp.get("genby");
			strSaveDate =(String)hshTemp.get("txtDate");
			strParam =(String)hshTemp.get("param");
			StringTokenizer st = new StringTokenizer(strParam,";");
			
			strTemp= st.nextToken();
			strOrgCode = st.nextToken();
			strStatus =  st.nextToken();
			strPeriod =  st.nextToken();
			hidOpFields = st.nextToken();
			hidSelFields =st.nextToken();
			strLoanType =st.nextToken();

			hshRecord.put("hidOrgCode",strOrgCode);
			hshRecord.put("hidStatus",strStatus);
			hshRecord.put("txtDate",strPeriod);
			hshRecord.put("hidSelFields",hidSelFields);
			hshRecord.put("hidOpFields",hidOpFields);
			hshRecord.put("hidLoanType",strLoanType);
			hshRecord.put("txtSaveDate",strSaveDate);
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
}