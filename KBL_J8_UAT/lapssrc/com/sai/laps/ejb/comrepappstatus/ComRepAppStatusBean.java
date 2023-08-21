package com.sai.laps.ejb.comrepappstatus;

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

@Stateless(name = "ComRepAppStatusBean", mappedName = "ComRepAppStatusHome")
@Remote (ComRepAppStatusRemote.class)
public class ComRepAppStatusBean extends BeanAdapter
{
	/**
	 * 
	 */
	//static Logger log=Logger.getLogger(ComRepAppStatusBean.class);
	private static final long serialVersionUID = 1L;
	


	static Logger log=Logger.getLogger(ComRepAppStatusBean.class);	


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
			else if (strMethod.equalsIgnoreCase("getComTurnaroundRepDetails"))
			{
				hshRecord =(HashMap)getComTurnaroundRepDetails(hshValues);
			}  
			
		
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getdata "+ce.toString());
		}
		
		return hshRecord;

	}

	private HashMap getRepDetails(HashMap hshRequestValues) 
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
		String strDate=null;
		String strFromDate=null;
		ArrayList vecT = new ArrayList();
		String strQ=" ";
		String strSaveDate=null;
		String strGen=null;
		String txtfromamt=null,strOrglevel=null;
		String txttoamt=null;
		String strDatetype="";
		String strOrg_Name = "",strLoanType="";
		StringBuffer strbufOrgcode=new StringBuffer();
		int count=0;
			
		try
		{
			
			strSaveDate =(String)hshRequestValues.get("txtSaveDate");
			strGen =(String)hshRequestValues.get("strUserId");
			strOrglevel=correctNull((String)hshRequestValues.get("orglevel"));
			strOrgCode =(String)hshRequestValues.get("hidOrgCode");
			strSelFields =(String)hshRequestValues.get("hidSelFields");
			strOpFields =(String)hshRequestValues.get("hidOpFields");
			strStatus =(String)hshRequestValues.get("hidStatus");
			strDate =(String)hshRequestValues.get("txtDate");
			txtfromamt=correctNull((String)hshRequestValues.get("txtfromamt"));
			txttoamt=(String)hshRequestValues.get("txttoamt");
			strOrg_Name=correctNull((String)hshRequestValues.get("hidOrgName"));
			strLoanType=correctNull((String)hshRequestValues.get("hidLoanType"));
			if(strOpFields.equals("")&& strSelFields.equals(""))
			{	
				strSelFields="Proposal Number,Applicant Name,Applied Date";
				strOpFields="app_no,comapp_companyname,to_char(app_createdate,'dd/mm/yyyy') as app_date,app_status,to_char(inward_docreceivedon,'dd/mm/yyyy') as inward_date";
			}
			if(!((strOrglevel.equalsIgnoreCase("State")) || (strOrglevel.equalsIgnoreCase("City")) ||(strOrglevel.equalsIgnoreCase("S/C"))))
			{
			strOrgCode=strOrgCode.replaceAll("'","");
			}
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
			// 
			else if(strOrglevel.equalsIgnoreCase("State"))
			{
				if(strOrgCode.indexOf(",")!=-1)
				{
					strbufOrgcode.append("ORG_STATE in (").append(strOrgCode).append(")");
						
				}
				else
				{
					strbufOrgcode.append("ORG_STATE =").append(strOrgCode);
				}
			}
			else if((strOrglevel.equalsIgnoreCase("City"))||(strOrglevel.equalsIgnoreCase("S/C")))
			{
				if(strOrgCode.indexOf(",")!=-1)
				{
					strbufOrgcode.append("ORG_CITY in (").append(strOrgCode).append(")");
				}
				else
				{
					strbufOrgcode.append("ORG_CITY =").append(strOrgCode);
				}
			}
			if((strStatus.equalsIgnoreCase("A"))||(strStatus.equalsIgnoreCase("R")))
			{
				strbufOrgcode.append("and applications.app_approvedby = users.usr_id");
				strDatetype="app_processdate";
			}
			else
			{
				strbufOrgcode.append("and applications.app_applnholder = users.usr_id");
				strDatetype="app_createdate";
			}
			if(!strDate.equalsIgnoreCase("All"))
			{
				strFromDate = strDate.substring(0,strDate.indexOf("-"));
				strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				strbufOrgcode.append(" and (TO_DATE(to_char(").append(strDatetype).append(",'DD/MM/YYYY'),'DD/MM/YYYY')between TO_DATE('")
				.append(strFromDate).append("','DD/MM/YYYY') and TO_DATE('").append(strToDate).append("','DD/MM/YYYY'))");
			}
			
			if(strStatus.equalsIgnoreCase("L")){
				strOpFields=strOpFields+",to_char(app_lodgeddate,'DD/MM/YYYY') as app_lodgeddate,app_renew_flag";
				strSelFields=strSelFields+",Lodged Date,Proposal Type";
			}	
			
			strQuery = SQLParser.getSqlQuery("selusername^"+strGen);		
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
			if(strOrglevel.equalsIgnoreCase("CPC"))
				strQuery = SQLParser.getSqlQuery("selcomappstatus_cpc^"+strOpFields+"^"+strbufOrgcode.toString()+"^"+strStatus+"^"+strLoanType+"^"+">"+"^"+txtfromamt+"^"+"<"+"^"+txttoamt);	
			else
			strQuery = SQLParser.getSqlQuery("selcomappstatus^"+strOpFields+"^"+strbufOrgcode.toString()+"^"+strStatus+"^"+strLoanType+"^"+">"+"^"+txtfromamt+"^"+"<"+"^"+txttoamt);
			
			if(rs != null)
			{
				rs.close();
			}
		
			rs= DBUtils.executeQuery(strQuery);
			hshRec = new HashMap();
			vecVal = new ArrayList();
			while (rs.next())
			{
				count=count+1;
				vecRecords = new ArrayList();
				
				if (vecT.contains("Proposal Number"))
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
				if(vecT.contains("Amount"))
				{
					double dbltemp=0;
					dbltemp =Double.parseDouble(Helper.correctDouble((String)rs.getString("proposedamt")));
					if(correctNull(rs.getString("app_valuesin")).equalsIgnoreCase("A"))
					{
						dbltemp=dbltemp/100000;
					}
					//else if(correctNull(rs.getString("app_valuesin")).equalsIgnoreCase("L"))
					//{
					//	dbltemp=dbltemp;
					//}
					else if(correctNull(rs.getString("app_valuesin")).equalsIgnoreCase("C"))
					{
						dbltemp=dbltemp*100;
					}
					vecRecords.add(Helper.formatDoubleValue(dbltemp));
					vecRecords.add("right");
				}
				if (vecT.contains("Application Status"))
				{
					strTemp =correctNull(rs.getString("app_status"));
					if (strTemp.equalsIgnoreCase("op"))
					{
						strTemp="Open Pending";
					}
					else if (strTemp.equalsIgnoreCase("pa"))
					{
						strTemp ="Processed Approved";
					}
					else if (strTemp.equalsIgnoreCase("pr"))
					{
						strTemp ="Processed Rejected";
					}
					else if (strTemp.equalsIgnoreCase("ca"))
					{
						strTemp ="Closed Approved";
					}
					else if (strTemp.equalsIgnoreCase("cr"))
					{
						strTemp ="Closed Rejected";
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
					{*/
					//	strappwith =correctNull(rs.getString("createdby"));
					/*}*/
					strTemp =correctNull(rs.getString("createdby"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if(vecT.contains("Lodged Date"))
				{
					strTemp =correctNull(rs.getString("app_lodgeddate"));
					if(strTemp.equalsIgnoreCase(""))
						strTemp=" ";
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}			
				if(vecT.contains("Proposal Type"))
				{
					strTemp =correctNull(rs.getString("app_renew_flag"));
					
					if (strTemp.equalsIgnoreCase("S"))
						strTemp = "Restructure";
					else if (strTemp.equalsIgnoreCase("R"))
						strTemp = "Renew";
					else if (strTemp.equalsIgnoreCase("P"))
						strTemp = "Postsanction";
					else
						strTemp = "Fresh";
					
					vecRecords.add(strTemp);
					vecRecords.add("center");
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
			hshRec.put("txtDate",strDate);
			hshRec.put("vecValues",vecVal);
			hshRec.put("labels",strSelFields);
			hshRec.put("genby",strGen);
			hshRec.put("txtSaveDate",strSaveDate);
			hshRec.put("count",Integer.toString(count));
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
			else  if (strStatus.equalsIgnoreCase("c"))
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
		ArrayList vecLabel = new ArrayList();
		ArrayList vecValue = new ArrayList();
		String strQuery = null;
		String strTemp=null;
		String strParam = null;
		String strOrgCode= null;
		String hidOpFields = null;
		String hidSelFields = null;
		String strPeriod=null;
		String strSubPeriod =null;
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
			
			hshRecord.put("hidOrgCode",strOrgCode);
			hshRecord.put("hidStatus",strStatus);
			hshRecord.put("txtDate",strPeriod);
			hshRecord.put("hidSelFields",hidSelFields);
			hshRecord.put("hidOpFields",hidOpFields);
			hshRecord.put("txtSaveDate",strSaveDate);
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
	
	private HashMap getComTurnaroundRepDetails(HashMap hshRequestValues) 
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
		String strSaveDate=null;
		String strGen=null;
		String strFromAmt=null;
		String strToAmt=null;
		String strOrgName=null,strDatetype=null,strLoanType="";
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
			
			strOrglevel=correctNull((String)hshRequestValues.get("orglevel"));
			strFromAmt=correctNull((String)hshRequestValues.get("fromamt"));
			strToAmt=correctNull((String)hshRequestValues.get("toamt"));
			strOrgName=correctNull((String)hshRequestValues.get("hidOrgName"));
			strLoanType=correctNull((String)hshRequestValues.get("hidLoanType"));
			strQuery = SQLParser.getSqlQuery("selusername^"+strGen);
			if(strOpFields.equals("")&& strSelFields.equals(""))
			{	
				strSelFields="Proposal Number,Applicant Name,Application Status,Applied Date,Approved or Rejected Date";
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
			else if(strOrglevel.equalsIgnoreCase("R")||strOrglevel.equalsIgnoreCase("CPC"))
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
				strbufOrgcode.append("and applications.app_applnholder = users.usr_id");
				strDatetype="app_createdate";
			}
			
			if(!strDate.equalsIgnoreCase("All"))
			{
				strFromDate = strDate.substring(0,strDate.indexOf("-"));
				strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				strbufOrgcode.append(" and (TO_DATE(to_char(").append(strDatetype).append(",'DD/MM/YYYY'),'DD/MM/YYYY')between TO_DATE('")
				.append(strFromDate).append("','DD/MM/YYYY') and TO_DATE('").append(strToDate).append("','DD/MM/YYYY'))");
			}
			if(strOrglevel.equalsIgnoreCase("CPC"))
			strQuery = SQLParser.getSqlQuery("selcomappturnaroundrep_cpc^"+strOpFields+"^"+strbufOrgcode.toString()+"^"+strStatus+"^"+strLoanType);
			else
				strQuery = SQLParser.getSqlQuery("selcomappturnaroundrep^"+strOpFields+"^"+strbufOrgcode.toString()+"^"+strStatus+"^"+strLoanType);	
			
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
				
				if (vecT.contains("Proposal Number"))
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
					else if (strTemp.equalsIgnoreCase("ol"))
					{
						strTemp ="Open/Lodged";
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
					double dbltemp=0;
					dbltemp =Double.parseDouble(Helper.correctDouble((String)rs.getString("facility_proposed")));
					if(correctNull(rs.getString("app_valuesin")).equalsIgnoreCase("A"))
					{
						dbltemp=dbltemp/100000;
					}
					//else if(correctNull(rs.getString("app_valuesin")).equalsIgnoreCase("L"))
					//{
					//	dbltemp=dbltemp;
				//	}
					else if(correctNull(rs.getString("app_valuesin")).equalsIgnoreCase("C"))
					{
						dbltemp=dbltemp*100;
					}
					vecRecords.add(Helper.formatDoubleValue(dbltemp));
					vecRecords.add("center");
				}
				if ((vecT.contains("Approved Date"))||vecT.contains("Rejected Date")||vecT.contains("Date")||vecT.contains("Lodged Date"))
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
					else if(strStatus.equalsIgnoreCase("L"))
					{
						strTemp =correctNull(rs.getString("app_lodgeddate"));
						if(strTemp.equalsIgnoreCase(""))
						{
							strTemp =" ";
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
					if(vecT.contains("Proposal Type"))
					{
						strTemp =correctNull(rs.getString("app_renew_flag"));
						
						if (strTemp.equalsIgnoreCase("S"))
							strTemp = "Restructure";
						else if (strTemp.equalsIgnoreCase("R"))
							strTemp = "Renew";
						else if (strTemp.equalsIgnoreCase("P"))
							strTemp = "Postsanction";
						else
							strTemp = "Fresh";
						
						vecRecords.add(strTemp);
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
			else if(strStatus.equalsIgnoreCase("L"))
			{
				strStatus="Lodged";
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
}