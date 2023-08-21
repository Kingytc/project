package com.sai.laps.ejb.repappstatuswise;


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
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "RepAppStatuswiseBean", mappedName = "RepAppStatuswiseHome")
@Remote (RepAppStatuswiseRemote.class)
public class RepAppStatuswiseBean extends BeanAdapter
{
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(RepAppStatuswiseBean.class);
	private static final long serialVersionUID = -2632462106112582679L;

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
		String strOrgCode = null;//new StringBuffer();
		String strOpFields = null;
		String strSelFields=null;
		String strStatus=null;
		String strTemp=null;
		String strToDate=null;
		String strDate=null;
		String strFromDate=null;
		String strLoanType=null;
		String strGen=null;
		String strSaveDate = null;
		int count=0;
		
		String strOrglevel=null;
		String strOrgName="";
		StringBuffer strbufOrgcode=new StringBuffer();
		String strdatefeild="";
			
		try
		{

			
			
			strSaveDate =(String)hshRequestValues.get("txtSaveDate");
			strGen =(String)hshRequestValues.get("strUserId");
			
			strOrgCode = (String)hshRequestValues.get("hidOrgCode");
			strOrglevel=correctNull((String)hshRequestValues.get("orglevel"));
			/*strOrgCode = strOrgCode.reverse();
			char chrOrgCode[]= (strOrgCode.toString()).toCharArray();
			for(int i=0;i<chrOrgCode.length;i=i+3)
			{
				orgcount= orgcount+1;
				String num = (" "+chrOrgCode[i]+chrOrgCode[i+1]+chrOrgCode[i+2]).trim();
				if(Integer.parseInt(num) > 0 && orgcount==1)
				{
					strOrgCode = strOrgCode.reverse();
					break;
				}
				else if(Integer.parseInt(num)>0 && orgcount==2)
				{
					strOrgCode = new StringBuffer((strOrgCode.reverse()).substring(0,12));
					break;
				}
				else if(Integer.parseInt(num)>0 && orgcount==3)
				{
					strOrgCode = new StringBuffer((strOrgCode.reverse()).substring(0,9));
					break;
				}
				else if(Integer.parseInt(num)>0 && orgcount==4)
				{
					strOrgCode = new StringBuffer((strOrgCode.reverse()).substring(0,6));
					break;
				}
				else if(Integer.parseInt(num)>0 && orgcount==5)
				{
					strOrgCode = new StringBuffer((strOrgCode.reverse()).substring(0,3));
					break;
				}			 
			}*/
			String strUser="";
			strSelFields =(String)hshRequestValues.get("hidSelFields");
			strOpFields =(String)hshRequestValues.get("hidOpFields");
			strStatus =(String)hshRequestValues.get("hidStatus");
			strDate =(String)hshRequestValues.get("txtDate");
			strLoanType =(String)hshRequestValues.get("hidLoanType");
		    strOrgName=correctNull((String)hshRequestValues.get("hidOrgName"));
			strOrgCode=strOrgCode.replaceAll("'","");
			if(strOrglevel.equalsIgnoreCase("C"))
			{
				strbufOrgcode.append("org_code like '001%'");
			}
			else if(strOrglevel.equalsIgnoreCase("R")||strOrglevel.equalsIgnoreCase("CPC"))
			{
				strbufOrgcode.append("org_code like '").append(strOrgCode.substring(0,6)).append("%'");
			}
			else if(strOrglevel.equalsIgnoreCase("D"))
			{
				strbufOrgcode.append("org_code like '").append(strOrgCode.substring(0,9)).append("%'");
			}
			else if(strOrglevel.equalsIgnoreCase("A"))
			{
				strbufOrgcode.append("org_code like '").append(strOrgCode.substring(0,12)).append("%'");
			}
			else if(strOrglevel.equalsIgnoreCase("B"))
			{
				strbufOrgcode.append("org_code = '").append(strOrgCode).append("'");
			}
			if(strStatus.equalsIgnoreCase("P")||strStatus.equalsIgnoreCase("L"))
			{
				strdatefeild="loan_receivedate";
				strUser="app_applnholder";
			}
			else
			{
				strdatefeild="app_processdate";
				strUser="app_approvedby";
			}
			strQuery = SQLParser.getSqlQuery("selusername^"+strGen);
			rs= DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2));
			}
			if(strDate.equals("All"))
			{
			strQuery = SQLParser.getSqlQuery("selstatuswise^"+strOpFields+"^"+strbufOrgcode.toString()+"^"+strStatus+"^"+strLoanType);
			}
			else
			{
				strFromDate = strDate.substring(0,strDate.indexOf("-"));
				strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				if(strOrglevel.equalsIgnoreCase("CPC"))
					strQuery = SQLParser.getSqlQuery("selstatuswise1_cpc^"+strOpFields+"^"+strUser+"^"+strOrgCode+"^"+strStatus+"^"+strdatefeild+"^"+strFromDate+"^"+strToDate+"^"+strLoanType);
				else
				strQuery = SQLParser.getSqlQuery("selstatuswise1^"+strOpFields+"^"+strOrgCode+"^"+strStatus+"^"+strdatefeild+"^"+strFromDate+"^"+strToDate+"^"+strLoanType);
			}
					
			if(rs != null)
			{
				rs.close();
			}

			rs=DBUtils.executeQuery(strQuery);
			hshRec = new HashMap();
			vecVal = new ArrayList();
			while (rs.next())
			{
				count = count+1;
				vecRecords = new ArrayList();		
				//vecRecords.add(correctNull(rs.getString(6)));
				vecRecords.add("");
				vecRecords.add("left");
					strTemp =correctNull(rs.getString("org_name"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
					strTemp =correctNull(rs.getString("app_status"));
					if (strTemp.equalsIgnoreCase("op"))
					{
						strTemp="Open/Pending";
					}
					else if (strTemp.equalsIgnoreCase("pa"))
					{
						strTemp ="Processed/Approved";
					}
					else if (strTemp.equalsIgnoreCase("pr"))
					{
						strTemp ="Processed/Rejected";
					}
					else if (strTemp.equalsIgnoreCase("ca"))
					{
						strTemp ="Closed/Approved";
					}
					else if (strTemp.equalsIgnoreCase("cr"))
					{
						strTemp ="Closed/Rejected";
					}
					else if (strTemp.equalsIgnoreCase("ol"))
					{
						strTemp ="Open/Lodged";
					}
					vecRecords.add(strTemp);
					vecRecords.add("left");
					
					strTemp =correctNull(rs.getString(3));
					vecRecords.add(strTemp);
					vecRecords.add("center");
				
					if(strTemp.equalsIgnoreCase("op"))
					{
					strTemp =correctNull(rs.getString(4));
					}
					else 
					{
					strTemp =correctNull(rs.getString(5));
					}	
					vecRecords.add(Helper.formatDoubleValue(Double.parseDouble(strTemp)));
					vecRecords.add("right");
					
								
				vecVal.add(vecRecords);
			}
			hshRec.put("txtDate",strDate);
			hshRec.put("vecValues",vecVal);
			hshRec.put("labels",strSelFields);
			hshRec.put("genby",strGen);
			hshRec.put("txtSaveDate",strSaveDate);
			hshRec.put("count",Integer.toString(count));
			hshRec.put("OrgName",strOrgName);
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
		String strLoanType =null;
		String strStatus =null;
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