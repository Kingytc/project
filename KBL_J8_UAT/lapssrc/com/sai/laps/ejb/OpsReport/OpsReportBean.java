/******************************************************************************
 * Package:			com.sai.laps.ejb.perrepappstatus
 * File:			PerRepAppStatusBean.java
 * Description:		Bean Implementation Class for Application Status  Report
 * @author			R.Saraswathi 
 ******************************************************************************/
package com.sai.laps.ejb.OpsReport;


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
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "OpsReportBean", mappedName = "OpsReportHome")
@Remote (OpsReportRemote.class)
public class OpsReportBean extends BeanAdapter
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String tempOffset = "50";
	static Logger log=Logger.getLogger(OpsReportBean.class);
	
	public HashMap getData(HashMap hshValues) 
	{
		HashMap hshRecord = new HashMap();
		String strMethod ="";

		try
		{
			strMethod=(String)hshValues.get("hidMethod");

			if (strMethod.equalsIgnoreCase("getOpsRepDetails"))
			{
				hshRecord =(HashMap)getOpsRepDetails(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("getRepDetails1"))
			{
				hshRecord =(HashMap)getRepDetails1(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("getOpsUserDetails"))
			{
				hshRecord =(HashMap)getOpsUserDetails(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("getOpsAppTracking"))
			{
				hshRecord =(HashMap)getOpsAppTracking(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("getOpsAppno"))
			{
				hshRecord =(HashMap)getOpsAppno(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("getOpsTurnaroundRepDetails"))
			{
				hshRecord =(HashMap)getOpsTurnaroundRepDetails(hshValues);
			}
			
			
		
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getdata "+ce.toString());
		}
		
		return hshRecord;

	}

	private HashMap getOpsRepDetails(HashMap hshValues) 
	{
		
 		ResultSet rs = null;
 		ResultSet rs1=null;
		ArrayList vecRecords=null;
		HashMap hshRec=null;
		ArrayList vecVal =null;
		String strQuery=null,strQuery1=null;
		String strOrgCode = null;
		String strOpFields = null;
		String strSelFields=null;
		String strStatus=null;
		String strTemp=null;
		String strToDate=null;
		String txtfromamt=null;
		String txttoamt=null;
		String strDate=null;
		String strFromDate=null;
		ArrayList vecT = new ArrayList();
		String strSaveDate=null;
		String strGen=null;
		String strOrglevel=null;
		String strOrg_Name = "";
		String strDatetype="";
		StringBuffer strbufOrgcode=new StringBuffer();
			
		try
		{
			
			
			strSaveDate =(String)hshValues.get("txtSaveDate");
			strGen =(String)hshValues.get("strUserId");
			
			strOrgCode =(String)hshValues.get("hidOrgCode");
			
		
			
			strSelFields =(String)hshValues.get("hidSelFields");
			strOpFields =(String)hshValues.get("hidOpFields");
			strStatus =(String)hshValues.get("hidStatus");
			strDate =(String)hshValues.get("txtDate");
			txtfromamt=correctNull((String)hshValues.get("txtfromamt"));
			txttoamt=(String)hshValues.get("txttoamt");
			strOrglevel=correctNull((String)hshValues.get("orglevel"));
			strOrg_Name=correctNull((String)hshValues.get("hidOrgName"));
			if(strOpFields.equals("")&& strSelFields.equals(""))  
			{	
				strSelFields="Application Number,Applicant Name,Amount,Applied Date";
				strOpFields="app_no,perapp_fname,perapp_lname,loan_recmdamt as  loan_recmdamt,to_char(app_createdate,'DD/MM/YYYY') as app_date";
			}
			if(!((strOrglevel.equalsIgnoreCase("State")) || (strOrglevel.equalsIgnoreCase("City")) ||(strOrglevel.equalsIgnoreCase("S/C"))))
			{
			strOrgCode=strOrgCode.replaceAll("'","");
			}
			if(strOrglevel.equalsIgnoreCase("C"))
			{
				strbufOrgcode.append(" org_code like '001%'");
			}
			else if(strOrglevel.equalsIgnoreCase("R"))
			{
				strbufOrgcode.append(" org_code like '").append(strOrgCode.substring(0,6)).append("%'");
			}
			else if(strOrglevel.equalsIgnoreCase("D"))
			{
				strbufOrgcode.append(" org_code like '").append(strOrgCode.substring(0,9)).append("%'");
			}
			else if(strOrglevel.equalsIgnoreCase("A"))
			{
				strbufOrgcode.append(" org_code like '").append(strOrgCode.substring(0,12)).append("%'");
			}
			else if(strOrglevel.equalsIgnoreCase("B"))
			{
				strbufOrgcode.append(" org_code = '").append(strOrgCode).append("'");
			}
			
			else if(strOrglevel.equalsIgnoreCase("State"))
			{
				if(strOrgCode.indexOf(",")!=-1)
				{
					strbufOrgcode.append(" ORG_STATE in (").append(strOrgCode).append(")");
						
				}
				else
				{
					strbufOrgcode.append(" ORG_STATE =").append(strOrgCode);
				}
			}
			else if((strOrglevel.equalsIgnoreCase("City"))||(strOrglevel.equalsIgnoreCase("S/C")))
			{
				if(strOrgCode.indexOf(",")!=-1)
				{
					strbufOrgcode.append(" ORG_CITY in (").append(strOrgCode).append(")");
				}
				else
				{
					strbufOrgcode.append(" ORG_CITY =").append(strOrgCode);
				}
			}
			if((strStatus.equalsIgnoreCase("A"))||(strStatus.equalsIgnoreCase("R")))
			{
				strbufOrgcode.append(" and applications.app_approvedby = users.usr_id");
				strDatetype="app_processdate";
			}
			else
			{
				strbufOrgcode.append(" and applications.app_applnholder = users.usr_id");
				strDatetype="app_createdate";
			}
			if(!strDate.equalsIgnoreCase("All"))
			{
				strFromDate = strDate.substring(0,strDate.indexOf("-"));
				strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				strbufOrgcode.append(" and (TO_DATE(to_char(").append(strDatetype).append(",'DD/MM/YYYY'),'DD/MM/YYYY')between TO_DATE('")
				.append(strFromDate).append("','DD/MM/YYYY') and TO_DATE('").append(strToDate).append("','DD/MM/YYYY'))");
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			rs=DBUtils.executeLAPSQuery("selusername^"+strGen);
			while (rs.next())
			{
				strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2));
			}
			StringTokenizer st = new StringTokenizer(strSelFields,",");
			while (st.hasMoreTokens())
			{
				vecT.add(st.nextToken());
			}
			
//			if(!strDate.equals("All"))
//			{
//				strFromDate = strDate.substring(0,strDate.indexOf("-"));
//				strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
//				strQuery =SQLParser.getSqlQuery("selappstatusdatewise^"+strOpFields+"^"+strbufOrgcode.toString()+"^"+strStatus+"^"+strDatetype+"^"+strFromDate+"^"+strToDate+"^"+txtfromamt+"^"+txttoamt);
//			}	
			
			/*else
			{
				strQuery = SQLParser.getSqlQuery("selappstatusamtwise^"+strOpFields+"^"+strbufOrgcode.toString()+"^"+strStatus+"^"+txtfromamt+"^"+txttoamt);
			}
*/
			strQuery = SQLParser.getSqlQuery("selopsappstatus^"+strOpFields+"^"+strbufOrgcode.toString()+"^"+strStatus+"^"+">"+"^"+txtfromamt+"^"+"<"+"^"+txttoamt);
			if(rs != null)
				rs.close();
			rs=DBUtils.executeQuery(strQuery);
			hshRec = new HashMap();
			vecVal = new ArrayList();
			while (rs.next())
			{
				vecRecords = new ArrayList();
				
				if (vecT.contains("Application Number"))
				{
					strTemp =correctNull(rs.getString("app_no"));
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}
				if (vecT.contains("Applicant Name"))
				{
					strTemp =correctNull(rs.getString("perapp_fname")); 
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if (vecT.contains("Amount"))
				{
					strTemp =Helper.correctDouble(rs.getString("facility_proposed"));
					vecRecords.add(Helper.formatDoubleValue(Double.parseDouble(strTemp)));
					vecRecords.add("right");
				}
						
				if (vecT.contains("Applied Date"))
				{
					strTemp =correctNull(rs.getString("inward_date"));
					if(strTemp.equalsIgnoreCase(""))
					{
						strTemp =correctNull(rs.getString("app_date"));
					}
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}
				
				if (vecT.contains("Application Status"))
				{
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
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if (vecT.contains("Product Name"))
				{
					String a = correctNull(rs.getString("facheaddesc"));
					String b = correctNull(rs.getString("facdesc"));
					//String c = correctNull(rs.getString("prd_desc"));
				//	strTemp = a+"-"+b+"-"+c;
					strTemp = a+"-"+b;
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if ((vecT.contains("Approved Date"))||(vecT.contains("Rejected Date"))||(vecT.contains("Date")))
				{
					strTemp =correctNull(rs.getString("app_processdate"));
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}
				if (vecT.contains("Branch"))
				{
					strTemp =correctNull(rs.getString("org_name"));
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}
				if (vecT.contains("Current Flowpoint"))
				{
					strTemp =correctNull(rs.getString("mail_toflowpoint"));
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}
				if (vecT.contains("Flowpoint Received Date"))
				{
					vecRecords.add(correctNull(rs.getString("mail_date")));
					vecRecords.add("center");
				}
				if (vecT.contains("Current Flowpoint Action"))
				{
					strTemp =correctNull(rs.getString("wrk_flowname"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if(vecT.contains("Approved By"))
				{
					strTemp =correctNull(rs.getString("usr_fname"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if(vecT.contains("Rejected By"))
				{
					strTemp =correctNull(rs.getString("usr_fname"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if(vecT.contains("Pending with"))
				{
					//String strappwith="";
					/*strQuery1 = SQLParser.getSqlQuery("selapplicationwith^"+Helper.correctNull((String)rs.getString("app_no")));
					if(rs1 != null)
						rs1.close();
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						strappwith =correctNull(rs1.getString("createdby"));
					}
					if(strappwith.equalsIgnoreCase(""))
					{*/
					strTemp =correctNull(rs.getString("createdby"));
				/*	}*/
					
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				vecVal.add(vecRecords);
			}
			if(strStatus.equalsIgnoreCase("A"))
			{
				strStatus="Approved";
			}
			else if(strStatus.equalsIgnoreCase("R"))
			{
				strStatus="Rejected";
			}
			else
			{
				strStatus="Pending";
			}
			hshRec.put("strStatus",strStatus);
			hshRec.put("vecValues",vecVal);
			hshRec.put("txtDate",strDate);
			hshRec.put("labels",strSelFields);
			hshRec.put("genby",strGen);
			hshRec.put("txtSaveDate",strSaveDate);
			hshRec.put("Org_Name",strOrg_Name);
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
	
	
	private HashMap getOpsUserDetails(HashMap hshRequestValues) 
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
		String strAppno = null;
		String strTemp=null;
		ArrayList vecT = new ArrayList();
		String strOrgName = "";
		String strDate=null;
		String strGen=null;
		String strStat="";
		String strToDate=null;
		String strFromDate=null;
		String strQ="";
		String strapprovedby="",strApp_Name="";
		
		String strOrglevel=null;
		StringBuffer strbufOrgcode=new StringBuffer();
		String strOrg_Name = "",strDatetype="";
		try
		{
			strDate =(String)hshRequestValues.get("txtDate");
			if(strDate.equalsIgnoreCase(""))
			{
				strDate="All";
			}
			strStat =(String)hshRequestValues.get("hidStatus");
            strGen =(String)hshRequestValues.get("strUserId");
			strOrgCode =(String)hshRequestValues.get("hidOrgCode");
			strAppno =(String)hshRequestValues.get("hidAppno");
			strSelFields =(String)hshRequestValues.get("hidSelFields");
			strOpFields =(String)hshRequestValues.get("hidOpFields");
			strOrglevel=correctNull((String)hshRequestValues.get("orglevel"));
			strOrg_Name=correctNull((String)hshRequestValues.get("hidOrgName"));
			strApp_Name=correctNull((String)hshRequestValues.get("hidappname"));
			strOrgCode=strOrgCode.replaceAll("'","");
			if(strOrglevel.equalsIgnoreCase("C"))
			{
				strbufOrgcode.append("ORG_CODE like '001%'");
			}
			else if(strOrglevel.equalsIgnoreCase("R"))
			{
				strbufOrgcode.append("ORG_CODE like '").append(strOrgCode.substring(0,6)).append("%'");
			}
			else if(strOrglevel.equalsIgnoreCase("D"))
			{
				strbufOrgcode.append("ORG_CODE like '").append(strOrgCode.substring(0,9)).append("%'");
			}
			else if(strOrglevel.equalsIgnoreCase("A"))
			{
				strbufOrgcode.append("ORG_CODE like '").append(strOrgCode.substring(0,12)).append("%'");
			}
			else if(strOrglevel.equalsIgnoreCase("B"))
			{
				strbufOrgcode.append("ORG_CODE = '").append(strOrgCode).append("'");
			}
			
			if ((strStat.equalsIgnoreCase("R"))||(strStat.equalsIgnoreCase("A")))
			{
				strbufOrgcode.append("and applications.app_approvedby =");
				strDatetype="app_processdate";
			}		
			else if (strStat.equalsIgnoreCase("P"))
			{
				strbufOrgcode.append("and applications.app_applnholder =");
				strDatetype="app_createdate";
				
			}
			strbufOrgcode.append(strAppno);
			
			
			if(!strDate.equalsIgnoreCase("All"))
			{
				strFromDate = strDate.substring(0,strDate.indexOf("-"));
				strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				strbufOrgcode.append(" and (TO_DATE(to_char(").append(strDatetype).append(",'DD/MM/YYYY'),'DD/MM/YYYY')between TO_DATE('")
				.append(strFromDate).append("','DD/MM/YYYY') and TO_DATE('").append(strToDate).append("','DD/MM/YYYY'))");
			}
			rs=DBUtils.executeLAPSQuery("selusername^"+strGen);
			while (rs.next())
			{
				strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2));
			}
			StringTokenizer st = new StringTokenizer(strSelFields,",");
			while (st.hasMoreTokens())
			{
				vecT.add(st.nextToken());
			}
			
			
			strQuery = SQLParser.getSqlQuery("selopsuserstatus^"+strOpFields+"^"+strbufOrgcode.toString()+"^"+strStat);
			
			/*if(!strDate.equals("All"))
			{
				strFromDate = strDate.substring(0,strDate.indexOf("-"));
				strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				if(strStat.equalsIgnoreCase("P"))
				{
					strQ =SQLParser.getSqlQuery("seldatewise^"+strFromDate+"^"+strToDate);
				}
				else
				{
					strQ =SQLParser.getSqlQuery("seldatewise1^"+strFromDate+"^"+strToDate);	
				}
				strQuery = strQuery + strQ;
			}	*/		
			
			
			if(rs != null)
				rs.close();

			
			rs=DBUtils.executeQuery(strQuery);
			hshRec = new HashMap();
			vecVal = new ArrayList();
			while (rs.next())
			{
				vecRecords = new ArrayList();
			//	strStat =correctNull(rs.getString("app_status"));
				if (vecT.contains("Application Number"))
				{
					strTemp =correctNull(rs.getString("app_no"));
					if (strTemp.equals(strOrgName))
					{
						vecRecords.add("&nbsp;");
					}
					else
					{
						vecRecords.add(strTemp);
					}
					vecRecords.add("left");
					strOrgName=strTemp;
										
				}
				if (vecT.contains("Applicant Name"))
				{
					strTemp =correctNull(rs.getString("perapp_fname")) + " "+ 
						correctNull(rs.getString("perapp_lname"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if (vecT.contains("Applied Date"))
				{
					strTemp =correctNull(rs.getString("inward_date"));
					if(strTemp.equalsIgnoreCase(""))
					{
						strTemp =correctNull(rs.getString("app_date"));
					}
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}
				if (vecT.contains("Amount"))
				{
					strTemp =Helper.correctDouble(rs.getString("facility_proposed"));
					vecRecords.add(Helper.formatDoubleValue(Double.parseDouble(strTemp)));
					vecRecords.add("right");
				}
				if (vecT.contains("Branch"))
				{
					strTemp =correctNull(rs.getString("org_name"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if (vecT.contains("Application Status"))
				{
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
					
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if (vecT.contains("Product Name"))
				{
					
					String a = correctNull(rs.getString("facheaddesc"));
					String b = correctNull(rs.getString("facdesc"));
				//	String c = correctNull(rs.getString("prd_desc"));
				//	strTemp = a+"-"+b+"-"+c;
					strTemp = a+"-"+b;
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if ((vecT.contains("Approved Date"))||(vecT.contains("Rejected Date"))||(vecT.contains("Date")))
					
				{
					strTemp =correctNull(rs.getString("app_processdate"));
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}
				/*if ((vecT.contains("Approved By"))||(vecT.contains("Rejected By")))
				{
					strTemp =correctNull(rs.getString("app_approvedby"));
					 
					
					
					if(rs1 != null)
						rs1.close();

					if(!strTemp.equalsIgnoreCase(""))
					{
						rs1=DBUtils.executeLAPSQuery("seluserstatusapp^"+strTemp);
						if(rs1.next())
						{
							strTemp =correctNull(rs1.getString("usr_name"));
						}
					}
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}*/
				vecVal.add(vecRecords);
			}
			if((strStat.equalsIgnoreCase("A"))||(strStat.equalsIgnoreCase("pa")))
			{
				strStat="Approved";
			}
			else if((strStat.equalsIgnoreCase("R"))||(strStat.equalsIgnoreCase("pr")))
			{
				strStat="Rejected";
			}
			else
			{
				strStat="Pending";
			}
			hshRec.put("strStatus",strStat);
			hshRec.put("vecValues",vecVal);
			hshRec.put("labels",strSelFields);
			hshRec.put("txtDate1",strFromDate);
			hshRec.put("txtDate",strToDate);
			hshRec.put("genby",strGen);
			hshRec.put("Org_Name",strOrg_Name);
			hshRec.put("App_Name",strApp_Name);
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
				if(rs1!=null)
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
	
	private HashMap getOpsAppTracking(HashMap hshRequestValues) 
	{
		
		ResultSet rs = null;
		ArrayList vecRecords=null;
		HashMap hshRec=null;
		ArrayList vecVal =null;
		String strQuery=null;
		String strOrgCode = null;
		String strOpFields = null;
		String strSelFields=null;
		String strAppno = null;
		String strTemp=null;
		ArrayList vecT = new ArrayList();
		String strOrgName = "";
		String strDate=null;
		String strGen=null;
		String strStat=null;	
		
		String strToDate="";
		String strFromDate="";
		String strQ="",strDatetype="";
		StringBuffer strbufOrgcode=new StringBuffer();
		String strOrg_Name = "";
		try
		{
			
			
			strDate =(String)hshRequestValues.get("txtDate");
			strStat =(String)hshRequestValues.get("hidStatus");
			strGen =(String)hshRequestValues.get("strUserId");
			strOrgCode =(String)hshRequestValues.get("hidOrgCode");
			strAppno =(String)hshRequestValues.get("hidAppno");
			strSelFields =(String)hshRequestValues.get("hidSelFields");
			strOpFields =(String)hshRequestValues.get("hidOpFields");
			strOrg_Name=correctNull((String)hshRequestValues.get("hidOrgName"));
			
			strDate =(String)hshRequestValues.get("txtDate");
			if ((strStat.equalsIgnoreCase("R"))||(strStat.equalsIgnoreCase("A")))
			{
				strDatetype="app_processdate";
			}		
			else if (strStat.equalsIgnoreCase("P"))
			{
				strDatetype="app_createdate";
			}
			if(strDate.equalsIgnoreCase(""))
			{
				strDate="All";
			}
				
			rs=DBUtils.executeLAPSQuery("selusername^"+strGen);
			
			while (rs.next())
			{
				strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2));
			}
			StringTokenizer st = new StringTokenizer(strSelFields,",");
			while (st.hasMoreTokens())
			{
				vecT.add(st.nextToken());
			}
			strbufOrgcode.append("org_code in (").append(strOrgCode).append(")");
			if(!strDate.equalsIgnoreCase("All"))
			{
				strFromDate = strDate.substring(0,strDate.indexOf("-"));
				strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				strbufOrgcode.append(" and (TO_DATE(to_char(").append(strDatetype).append(",'DD/MM/YYYY'),'DD/MM/YYYY')between TO_DATE('")
				.append(strFromDate).append("','DD/MM/YYYY') and TO_DATE('").append(strToDate).append("','DD/MM/YYYY'))");
			}
			strQuery = SQLParser.getSqlQuery("selopsapptracking^"+strOpFields+"^"+strStat+"^"+strAppno+"^"+strbufOrgcode);
			
			/*if(!strDate.equals("All"))
			{
				strFromDate = strDate.substring(0,strDate.indexOf("-"));
				strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				//strQ =SQLParser.getSqlQuery("seldatewise^"+strFromDate+"^"+strToDate);
				
				if(strStat.equalsIgnoreCase("P"))
				{
					strQ =SQLParser.getSqlQuery("seldatewise^"+strFromDate+"^"+strToDate);
				}
				else
				{
					strQ =SQLParser.getSqlQuery("seldatewise1^"+strFromDate+"^"+strToDate);	
				}
				
				strQuery = strQuery + strQ;
			}	*/	
			
			/*if (strStat.equalsIgnoreCase("R"))
			{
				strQuery = strQuery + "and  upper(app_status) = 'PR' " ;
			}		
			else if (strStat.equalsIgnoreCase("A"))
			{
				strQuery = strQuery + "and  upper(app_status) ='PA'" ;
			}
			else if (strStat.equalsIgnoreCase("P"))
			{
				strQuery = strQuery + "and  upper(app_status) ='OP'" ;
			}*/
			
			if(rs != null)
				rs.close();
			
			rs=DBUtils.executeQuery(strQuery);
			hshRec = new HashMap();
			vecVal = new ArrayList();
			while (rs.next())
			{
				vecRecords = new ArrayList();
				//strStat =correctNull(rs.getString("app_status"));
				if (vecT.contains("Application Number"))
				{
					strTemp =correctNull(rs.getString("app_no"));
					if (strTemp.equals(strOrgName))
					{
						vecRecords.add("&nbsp;");
					}
					else
					{
						vecRecords.add(strTemp);
					}
					vecRecords.add("left");
					strOrgName=strTemp;
										
				}
				if (vecT.contains("Applicant Name"))
				{
					strTemp =correctNull(rs.getString("perapp_fname")) + " "+ correctNull(rs.getString("perapp_lname"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if (vecT.contains("Applied Date"))
				{
					strTemp =correctNull(rs.getString("inward_date"));
					if(strTemp.equalsIgnoreCase(""))
					{
						strTemp =correctNull(rs.getString("app_date"));
					}
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}
				if (vecT.contains("Amount"))
				{
					strTemp =correctNull(rs.getString("facility_proposed"));
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}
				if (vecT.contains("Organisation"))
				{
					strTemp =correctNull(rs.getString("org_name"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if (vecT.contains("Application Status"))
				{
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
					
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if (vecT.contains("Product Name"))
				{
					String a = correctNull(rs.getString("facheaddesc"));
					String b = correctNull(rs.getString("facdesc"));
					//String c = correctNull(rs.getString("prd_desc"));
					//strTemp = a+"-"+b+"-"+c;
					strTemp=a+"-"+b;
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if ((vecT.contains("Approved Date"))||vecT.contains("Rejected Date")||vecT.contains("Date"))
				{
					strTemp =correctNull(rs.getString("app_processdate"));
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}
		
				
				vecVal.add(vecRecords);
			}
			hshRec.put("vecValues",vecVal);
			hshRec.put("labels",strSelFields);
			hshRec.put("txtDate1",strDate);
			//hshRec.put("txtDate",strToDate);
			hshRec.put("genby",strGen);
			hshRec.put("Org_Name",strOrg_Name);
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
	
	private HashMap getOpsTurnaroundRepDetails(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		ResultSet rs1 = null;
		ArrayList vecRecords=null;
		HashMap hshRec=null;
		ArrayList vecVal =null;
		String strQuery=null,strQuery1=null;
		String strOrgCode = null;
		String strOpFields = null;
		String strSelFields=null;
		String strStatus=null;
		String strTemp=null;
		String strDate=null;
		String strToDate=null;
		String strFromDate=null;
		ArrayList vecT = new ArrayList();
		String strLoanType=null;
		String strSaveDate=null;
		String strGen=null;
		String strFromAmt=null;
		String strToAmt=null;
		String strOrgName=null,strDatetype=null,strorgname=null;
		int count=0;
		
		String strOrglevel=null;
		
		StringBuffer strbufOrgcode=new StringBuffer();
			
		try
		{
			strSaveDate =(String)hshRequestValues.get("txtSaveDate");
			strGen =(String)hshRequestValues.get("strUserId");
			strOrgCode =(String)hshRequestValues.get("hidOrgCode");
			strSelFields =(String)hshRequestValues.get("hidSelFields");
			strOpFields =(String)hshRequestValues.get("hidOpFields");
			
			strStatus =(String)hshRequestValues.get("hidStatus");
			strDate =(String)hshRequestValues.get("txtDate");
			strLoanType=(String)hshRequestValues.get("hidLoanType");
			
			strOrglevel=correctNull((String)hshRequestValues.get("orglevel"));
			strFromAmt=correctNull((String)hshRequestValues.get("fromamt"));
			strToAmt=correctNull((String)hshRequestValues.get("toamt"));
			strOrgName=correctNull((String)hshRequestValues.get("hidOrgName"));
			
			strQuery = SQLParser.getSqlQuery("selusername^"+strGen);
			if(strOpFields.equals("")&& strSelFields.equals(""))
			{	
				strSelFields="Application Number,Applicant Name,Application Status,Applied Date,Approved or Rejected Date";
				strOpFields="app_no,perapp_fname,perapp_lname,app_status,to_char(loan_receivedate,'dd/mm/yyyy') as app_createdate,to_char(app_processdate,'dd/mm/yyyy') as app_processdate,to_char(app_deldate,'dd/mm/yyyy') as app_deldate";
			}
			rs= DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2));
			}
			StringTokenizer st = new StringTokenizer(strSelFields,",");
			while (st.hasMoreTokens())
			{
				vecT.add(st.nextToken());
			}
			
			
			strOrgCode=strOrgCode.replaceAll("'","");
			if(strOrglevel.equalsIgnoreCase("C"))
			{
				strbufOrgcode.append("orgs.org_code like '001%'");
			}
			else if(strOrglevel.equalsIgnoreCase("R"))
			{
				strbufOrgcode.append("orgs.org_code like '").append(strOrgCode.substring(0,6)).append("%'");
			}
			else if(strOrglevel.equalsIgnoreCase("D"))
			{
				strbufOrgcode.append("orgs.org_code like '").append(strOrgCode.substring(0,9)).append("%'");
			}
			else if(strOrglevel.equalsIgnoreCase("A"))
			{
				strbufOrgcode.append("orgs.org_code like '").append(strOrgCode.substring(0,12)).append("%'");
			}
			else if(strOrglevel.equalsIgnoreCase("B"))
			{
				strbufOrgcode.append("orgs.org_code = '").append(strOrgCode).append("'");
			}
			if((strStatus.equalsIgnoreCase("A"))||(strStatus.equalsIgnoreCase("R")))
			{
				strbufOrgcode.append("and applications.app_approvedby = users.usr_id");
				strDatetype="app_processdate";
			}
			else
			{
				strbufOrgcode.append("and applications.APP_APPLNHOLDER = users.usr_id");
				strDatetype="APP_CREATEDATE";
			}
			
			if(!strDate.equalsIgnoreCase("All"))
			{
				strFromDate = strDate.substring(0,strDate.indexOf("-"));
				strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				strbufOrgcode.append(" and (TO_DATE(to_char(").append(strDatetype).append(",'DD/MM/YYYY'),'DD/MM/YYYY')between TO_DATE('")
				.append(strFromDate).append("','DD/MM/YYYY') and TO_DATE('").append(strToDate).append("','DD/MM/YYYY'))");
			}
			
			strQuery = SQLParser.getSqlQuery("selopsappturnaroundrep^"+strOpFields+"^"+strbufOrgcode.toString()+"^"+strStatus);
			
			if(rs != null)
				rs.close();
			if(rs != null)
			{
				rs.close();
			}
			rs= DBUtils.executeQuery(strQuery);
			hshRec = new HashMap();
			vecVal = new ArrayList();

			while (rs.next())
			{
				count = count+1;
				vecRecords = new ArrayList();
				
				if (vecT.contains("Application Number"))
				{
					strTemp =correctNull(rs.getString("app_no"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
															
				}
				if (vecT.contains("Applicant Name"))
				{
					strTemp =correctNull(rs.getString("perapp_fname")); 
					vecRecords.add(strTemp);
					vecRecords.add("center");
															
				}
				if (vecT.contains("Application Status"))
				{
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
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if (vecT.contains("Applied Date"))
				{
					strTemp =correctNull(rs.getString("inward_date"));
					if(strTemp.equalsIgnoreCase(""))
					{
						strTemp =correctNull(rs.getString("app_createdate"));
					}
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}
				if (vecT.contains("Amount"))
				{
					strTemp =correctNull(rs.getString("facility_proposed"));
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}
				if ((vecT.contains("Approved Date"))||vecT.contains("Rejected Date")||vecT.contains("Date"))
				{
					strTemp =correctNull(rs.getString("app_processdate"));
					//if (!strTemp.equals("") && !strTemp.equals("01/01/1900"))
				//	{
						vecRecords.add(strTemp);
						vecRecords.add("center");	
				//	}
					/*else
					{
						//added by balaji to avoid the the duplication date such as 01/01/1900
						strTemp =correctNull(rs.getString("app_deldate"));
						if(!strTemp.equals("01/01/1900"))
						{
							vecRecords.add(strTemp);
							vecRecords.add("center");
						}
						else
						{
							vecRecords.add("");
							vecRecords.add("center");
						}
					}*/
				}
				if (vecT.contains("Assured Turnaround Time(Days)"))
				{
					strTemp =correctNull(rs.getString("prd_duration"));
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}
				if ((vecT.contains("Actual Time taken(Days)"))||vecT.contains("No of Days Pending"))
				{
					if(strStatus.equalsIgnoreCase("P"))
					{
						strTemp =correctNull(rs.getString("inwardpending_hours"));
						if(strTemp.equalsIgnoreCase(""))
						{
							strTemp =correctNull(rs.getString("pending_hours"));
						}
					}
					else
					{
						strTemp =correctNull(rs.getString("inwardexception_hours"));	
						if(strTemp.equalsIgnoreCase(""))
						{
							strTemp =correctNull(rs.getString("exception_hours"));		
						}
					}
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}
				if (vecT.contains("Branch"))
				{
					strTemp =correctNull(rs.getString("rorg_name"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if(vecT.contains("Application Approved By"))
				{
					strTemp =correctNull(rs.getString("usr_fname"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if(vecT.contains("Application Rejected By"))
				{
					strTemp =correctNull(rs.getString("usr_fname"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if(vecT.contains("Application Pending with"))
				{
					/*String strappwith="";
					strQuery1 = SQLParser.getSqlQuery("selapplicationwith^"+Helper.correctNull((String)rs.getString("app_no")));
					if(rs1 != null)
						rs1.close();
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						strappwith =correctNull(rs1.getString("createdby"));
					}
					if(strappwith.equalsIgnoreCase(""))
					{
						strappwith =correctNull(rs.getString("usr_fname"));
					}*/
					strTemp =correctNull(rs.getString("usr_fname"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}

				/*if (vecT.contains("Current Flowpoint"))
				{
					strTemp =correctNull(rs.getString("mail_toflowpoint"));
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}*/
					if (vecT.contains("Office"))
					{
						if(correctNull(rs.getString("rorg_name")).equalsIgnoreCase(correctNull(rs.getString("org_name1"))))
						{
							vecRecords.add("");
						}
						else
						{
							vecRecords.add(Helper.correctNull((String)rs.getString("org_name1")));
						}
						vecRecords.add("left");
					}
				
				vecVal.add(vecRecords);
			}
			if(strStatus.equalsIgnoreCase("P"))
			{
				strStatus="Pending";
			}
			else if(strStatus.equalsIgnoreCase("A"))
			{
				strStatus="Approved";
			}
			else 
			{
				strStatus="Rejected";
			}
			
			hshRec.put("txtDate",strDate);
			hshRec.put("vecValues",vecVal);
			hshRec.put("labels",strSelFields);
			hshRec.put("genby",strGen);
			hshRec.put("txtSaveDate",strSaveDate);
			hshRec.put("count",Integer.toString(count));
			hshRec.put("Org_Name",strOrgName);
			hshRec.put("strStatus",strStatus);
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
	
	private HashMap getRepDetails1(HashMap hshValues) 
	{
		
		ResultSet rs = null;
		ArrayList vecRecords=null;
		HashMap hshRec=null;
		ArrayList vecVal =null;
		String strQuery=null;
		String strOrgCode = null;
		String strOpFields = null;
		String strSelFields=null;
		String strStatus=null;
		String strTemp=null;
		String strToDate=null;
		String txtfromamt=null;
		String txttoamt=null;
		String strDate=null;
		String strFromDate=null;
		ArrayList vecT = new ArrayList();
		String strSaveDate=null;
		String strGen=null;
			
		try
		{
			
			
			strSaveDate =(String)hshValues.get("txtSaveDate");
			strGen =(String)hshValues.get("strUserId");
			
			strOrgCode =(String)hshValues.get("hidOrgCode");
			
		
			
			strSelFields =(String)hshValues.get("hidSelFields");
			strOpFields =(String)hshValues.get("hidOpFields");
			strStatus =(String)hshValues.get("hidStatus");
			strDate =(String)hshValues.get("txtDate");
			txtfromamt=correctNull((String)hshValues.get("txtfromamt"));
			txttoamt=(String)hshValues.get("txttoamt");
			
			if(strOpFields.equals("")&& strSelFields.equals(""))
				
			{	strSelFields="Application Number,Applicant Name,Amount,Applied Date,Application Status";
				strOpFields="app_no,perapp_fname,perapp_lname,loan_recmdamt as  loan_recmdamt,convert(varchar,app_createdate,103) as app_date,app_status";
			}
			
			if(rs!=null)
			{
				rs.close();
			}
			
			rs=DBUtils.executeLAPSQuery("selusername^"+strGen);
			while (rs.next())
			{
				strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2));
			}
			StringTokenizer st = new StringTokenizer(strSelFields,",");
			while (st.hasMoreTokens())
			{
				vecT.add(st.nextToken());
			}
			
			if(!strDate.equals("All"))
			{
				strFromDate = strDate.substring(0,strDate.indexOf("-"));
				strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				strQuery =SQLParser.getSqlQuery("selappstatusdatewise^"+strOpFields+"^"+strOrgCode+"^"+strStatus+"^"+strFromDate+"^"+strToDate+"^"+txtfromamt+"^"+txttoamt);
			}	
			
			else
			{
				strQuery = SQLParser.getSqlQuery("selappstatusamtwise^"+strOpFields+"^"+strOrgCode+"^"+strStatus+"^"+txtfromamt+"^"+txttoamt);
			}
			
			
			if(rs != null)
				rs.close();
			rs=DBUtils.executeQuery(strQuery);
			hshRec = new HashMap();
			vecVal = new ArrayList();
			while (rs.next())
			{
				vecRecords = new ArrayList();
				
				if (vecT.contains("Application Number"))
				{
					strTemp =correctNull(rs.getString("app_no"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if (vecT.contains("Applicant Name"))
				{
					strTemp =correctNull(rs.getString("perapp_fname")); 
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if (vecT.contains("Amount"))
				{
					strTemp =correctNull(rs.getString("loan_recmdamt"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
						
				if (vecT.contains("Applied Date"))
				{
					strTemp =correctNull(rs.getString("app_date"));
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}
				
				if (vecT.contains("Application Status"))
				{
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
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if (vecT.contains("Product Name"))
				{
					String a = correctNull(rs.getString("cat_name"));
					String b = correctNull(rs.getString("scatname"));
					String c = correctNull(rs.getString("prd_desc"));
					strTemp = a+"-"+b+"-"+c;
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if (vecT.contains("Approval/Rejection Date"))
				{
					strTemp =correctNull(rs.getString("app_processdate"));
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}
				if (vecT.contains("Current Flowpoint"))
				{
					strTemp =correctNull(rs.getString("mail_toflowpoint"));
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}
				if (vecT.contains("Flowpoint Received Date"))
				{
					vecRecords.add(correctNull(
												rs.getString("mail_date")));
					vecRecords.add("center");
				}
				if (vecT.contains("Current Flowpoint Action"))
				{
					strTemp =correctNull(rs.getString("wrk_flowname"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
					
				}
					
				vecVal.add(vecRecords);
			}
			hshRec.put("vecValues",vecVal);
			hshRec.put("txtDate",strDate);
			hshRec.put("labels",strSelFields);
			hshRec.put("genby",strGen);
			hshRec.put("txtSaveDate",strSaveDate);
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
	private HashMap getOpsAppno(HashMap hshPar) 
	{
		HashMap hshRec = new HashMap();
		
		ResultSet rs = null;
		String strQuery = null;
		String strOrgCode = null;
		ArrayList vecAppno = new ArrayList();
		String strStat = null;
		String strProdtype=null;
		
		try
		{
			
			
			strOrgCode=correctNull((String)hshPar.get("hidOrgCode"));
			strStat =(String)hshPar.get("hidStatus");
			strProdtype=correctNull((String)hshPar.get("prodtype"));
			
			
			strQuery = SQLParser.getSqlQuery("selopsrepappno^"+strOrgCode+"^"+strStat);
			
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				vecAppno.add(correctNull(rs.getString("app_no")));		
			}
			hshRec.put("vecValues",vecAppno);
						
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getOpsAppno "+ce.toString());
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
		return hshRec;
	}

	
	
	
	
	
}