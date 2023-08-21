/******************************************************************************
 * Package:			com.sai.laps.ejb.comrepapptrack
 * File:			ComRepAppTrackBean.java
 * Description:		Bean Implementation Class for Commercial Application 						   Tracking Report
 * @author			R.Saraswathi 
 ******************************************************************************/
package com.sai.laps.ejb.comrepapptrack;

import java.sql.ResultSet;
import java.util.ArrayList;
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
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;


@Stateless(name = "ComRepAppTrackBean", mappedName = "ComRepAppTrackHome")
@Remote (ComRepAppTrackRemote.class)
public class ComRepAppTrackBean extends BeanAdapter
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	


	static Logger log=Logger.getLogger(ComRepAppTrackBean.class);	


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
			else if (strMethod.equalsIgnoreCase("getAppno"))
			{
				hshRecord =(HashMap)getAppno(hshValues);
			} 
			else if (strMethod.equalsIgnoreCase("getComUserDetails"))
			{
				hshRecord =(HashMap)getComUserDetails(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("getlayerlist"))
			{
				hshRecord =(HashMap)getlayerlist(hshValues);
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
		int intAppFlowPoint=0;
		String strStat=null;
		String strToDate="";
		String strFromDate="";
		String strorglevel="",strLoanType="";
		int count=0;
		String strOrg_Name = "",strDatetype="";	
		StringBuffer strbufOrgcode=new StringBuffer();
		try
		{
			
			strDate =(String)hshRequestValues.get("txtDate");
			strGen =(String)hshRequestValues.get("strUserId");
			strStat =(String)hshRequestValues.get("hidStatus");
			strOrgCode =(String)hshRequestValues.get("hidOrgCode");
			strAppno =(String)hshRequestValues.get("hidAppno");
			strSelFields =(String)hshRequestValues.get("hidSelFields");
			strOpFields =(String)hshRequestValues.get("hidOpFields");
			strOrg_Name=correctNull((String)hshRequestValues.get("hidOrgName"));
			strorglevel=correctNull((String)hshRequestValues.get("orglevel"));
			strLoanType=correctNull((String)hshRequestValues.get("hidLoanType")); 
			strOrgCode=strOrgCode.replaceAll("'","");
			if(strorglevel.equalsIgnoreCase("C"))
			{
				strbufOrgcode.append("org_code like '001%'");
			}
			else if(strorglevel.equalsIgnoreCase("R")||strorglevel.equalsIgnoreCase("CPC"))
			{
				strbufOrgcode.append("org_code like '").append(strOrgCode.substring(0,6)).append("%'");
			}
			else if(strorglevel.equalsIgnoreCase("D"))
			{
				strbufOrgcode.append("org_code like '").append(strOrgCode.substring(0,9)).append("%'");
			}
			else if(strorglevel.equalsIgnoreCase("A"))
			{
				strbufOrgcode.append("org_code like '").append(strOrgCode.substring(0,12)).append("%'");
			}
			
			if(strOpFields.equals("")&& strSelFields.equals(""))
			{	
				strSelFields="Proposal Number,Applicant Name,Applied Date";
				strOpFields="app_no ,comapp_companyname ,to_char(app_createdate,'dd/mm/yyyy') as app_date ";
			}
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
			if(strStat.equalsIgnoreCase("L")){
				strOpFields=strOpFields+",to_char(app_lodgeddate,'DD/MM/YYYY') as app_lodgeddate,app_renew_flag";
				strSelFields=strSelFields+",Lodged Date,Proposal Type";
			}
			
			strOpFields=strOpFields+",app_applnholder,(select usr_fname||' '||usr_mname||' '||usr_lname from users where usr_id=app_applnholder) as appholder,(select org_name from users,organisations where usr_id=app_applnholder and usr_orgcode=org_code) as holderorgname,app_renew_flag";
			
			if(strStat.equalsIgnoreCase("P")){
				strSelFields=strSelFields+",Application Pending With,User ID,User Organisation,Proposal Type";
			}	
			//rs = stmt.executeQuery(strQuery);
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
			//strbufOrgcode.append("app_orgcode in (").append(strOrgCode).append(")");
			
			if(strorglevel.equalsIgnoreCase("CPC"))
				strQuery = SQLParser.getSqlQuery("selcomapptrack_cpc^"+strOpFields+"^"+strLoanType+"^"+strbufOrgcode.toString()+"^"+strStat+"^"+strAppno);
			else
				strQuery = SQLParser.getSqlQuery("selcomapptrack^"+strOpFields+"^"+strLoanType+"^"+strbufOrgcode.toString()+"^"+strStat+"^"+strAppno);
			
//			if (strStat.equalsIgnoreCase("R"))
//			{
//				strQuery = strQuery + "and  upper(app_status) ='CR'" ;
//			}		
//			else if (strStat.equalsIgnoreCase("A"))
//			{
//				strQuery = strQuery + "and  upper(app_status) ='CA'" ;
//			}
//			else if (strStat.equalsIgnoreCase("P"))
//			{
//				strQuery = strQuery + "and  upper(app_status) ='OP'" ;
//			}					
			if(rs != null)
			{
				rs.close();
			}
			//rs = stmt.executeQuery(strQuery);
			rs= DBUtils.executeQuery(strQuery);
			hshRec = new HashMap();
			vecVal = new ArrayList();
			while (rs.next())
			{
				count=count+1;
				vecRecords = new ArrayList();
				//intAppFlowPoint = rs.getInt("nextflowpoint");
				strStat =correctNull(rs.getString("app_status"));
				if (vecT.contains("Proposal Number"))
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
					//}
					else if(correctNull(rs.getString("app_valuesin")).equalsIgnoreCase("C"))
					{
						dbltemp=dbltemp*100;
					}
					
					vecRecords.add(Helper.formatDoubleValue(dbltemp));
					//vecRecords.add(strTemp);
					vecRecords.add("center");
				}
				if ((vecT.contains("Approved Date"))||vecT.contains("Rejected Date")||vecT.contains("Date"))
				{
					strTemp =correctNull(rs.getString("app_processdate"));
					vecRecords.add(strTemp);
					vecRecords.add("center");
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
					else if (strTemp.equalsIgnoreCase("ol"))
					{
						strTemp ="Open Lodged";
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
				
//				if (vecT.contains("Current Flowpoint"))
//				{
//					strTemp =correctNull(rs.getString("curflowpoint"));
//					vecRecords.add(strTemp);
//					vecRecords.add("center");
//				 }
//				if (vecT.contains("Flowpoint Received Date"))
//				{
//					vecRecords.add(correctNull(
//												rs.getString("mail_date")));
//					vecRecords.add("center");
//				}
//				if (vecT.contains("Current Flowpoint Action"))
//				{
//					strTemp =correctNull(rs.getString("wrkaction"));
//					vecRecords.add(strTemp);
//					vecRecords.add("left");
//					
//				}
//				if (vecT.contains("Next Flowpoint"))
//				{
//					strTemp =correctNull(rs.getString("nextflowpoint"));
//					if (strStat.equalsIgnoreCase("op") && intAppFlowPoint > 8)
//					{
//						strTemp +="/17";// for Approved Appln
//					}
//					if (strStat.equalsIgnoreCase("pa") && intAppFlowPoint > 16)
//					{
//						strTemp ="&nbsp;";// for Approved Appln
//					}
//					if (strStat.equalsIgnoreCase("pr") && intAppFlowPoint > 8 && intAppFlowPoint <= 17)
//					{
//						strTemp ="&nbsp;";// for Rejected Appln
//					}
//					vecRecords.add(strTemp);
//					vecRecords.add("center");
//				}
//				if (vecT.contains("Next Flowpoint Action"))
//				{
//					strTemp =correctNull(rs.getString("nextaction"));
//					if (strStat.equalsIgnoreCase("op") && intAppFlowPoint > 8)
//					{
//						strTemp +="/Reject the Loan";// for Approved Appln
//					}
//					if (strStat.equalsIgnoreCase("pa") && intAppFlowPoint > 16)
//					{
//						strTemp ="&nbsp;";// for Approved Appln
//					}
//					if (strStat.equalsIgnoreCase("pr") && intAppFlowPoint > 8 && intAppFlowPoint <= 17)
//					{
//						strTemp ="&nbsp;";// for Rejected Appln
//					}
//					vecRecords.add(strTemp);
//					vecRecords.add("left");
//				}
				if(vecT.contains("Lodged Date"))
				{
					strTemp =correctNull(rs.getString("app_lodgeddate"));
					if(strTemp.equalsIgnoreCase(""))
						strTemp=" ";
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}
				if(vecT.contains("Application Pending With"))
				{
					strTemp =correctNull(rs.getString("appholder"));
					if(strTemp.equalsIgnoreCase(""))
						strTemp=" ";
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}
				if(vecT.contains("User ID"))
				{
					strTemp =correctNull(rs.getString("app_applnholder"));
					if(strTemp.equalsIgnoreCase(""))
						strTemp=" ";
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}
				if(vecT.contains("User Organisation"))
				{
					strTemp =correctNull(rs.getString("holderorgname"));
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
					vecRecords.add("left");
				}
				vecVal.add(vecRecords);
			}
			hshRec.put("vecValues",vecVal);
			hshRec.put("labels",strSelFields);
			hshRec.put("txtDate",strDate);
			hshRec.put("genby",strGen);
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
		String strOrgLevel = null;
		String strOrgCode= null;
		String hidOrgCode = null;
		String hidOpFields = null;
		String hidSelFields = null;
		String strProfileName = null;
		String strAppno=null;
		String strStat=null;

		try
		{
					
			hshTemp=(HashMap)EJBInvoker.executeStateLess("repData",hshPar,"getParameter");
			strParam = (String)hshTemp.get("param");
			strProfileName =(String)hshTemp.get("profilename");
			StringTokenizer st = new StringTokenizer(strParam,";");
			
			strOrgLevel = st.nextToken();
			hidOrgCode = st.nextToken();
			strAppno = st.nextToken();
			strAppno = strAppno.replace('\'',' ');
			hidOpFields =st.nextToken();
			hidSelFields = st.nextToken();
			strStat = st.nextToken();
			
			vecLabel.add("Profile Name");
			vecLabel.add("Organisation Level");
			vecLabel.add("Process Status");
			vecLabel.add("Organisation Names");
			vecLabel.add("Application Numbers");
			vecLabel.add("Output Fields");

			vecValue.add(strProfileName);						
			vecValue.add(strOrgLevel);
			vecValue.add("");
			if (strStat.equalsIgnoreCase("R"))
			{
				strStat ="Rejected";
			}
			else if (strStat.equalsIgnoreCase("A"))
			{
				strStat ="Approved";
			}
			else if (strStat.equalsIgnoreCase("P"))
			{
				strStat ="Pending";
			}

			strQuery = SQLParser.getSqlQuery("repbanknames^"+hidOrgCode);
			//rs = stmt.executeQuery(strQuery);
			rs= DBUtils.executeQuery(strQuery);
			hidOrgCode="";
			while(rs.next())
			{
				hidOrgCode += correctNull(rs.getString("org_name"))+",";		
			}
			hidOrgCode = hidOrgCode.substring(0,hidOrgCode.length()-1);
			vecValue.add(hidOrgCode);
			vecValue.add(strAppno);
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
		String strAppno = null;
		String strDate =null;
		String strGen =null;
		String strStat =null;

		try
		{
						
			hshTemp=(HashMap)EJBInvoker.executeStateLess("repData",hshPar,"getParameter");
			strGen =(String)hshTemp.get("genby");
			strDate =(String)hshTemp.get("txtDate");
			strParam =(String)hshTemp.get("param");
			StringTokenizer st = new StringTokenizer(strParam,";");
			
			strTemp= st.nextToken();
			strOrgCode = st.nextToken();
			strAppno = st.nextToken();
			hidOpFields = st.nextToken();
			hidSelFields =st.nextToken();
			strStat = st.nextToken();
			
			hshRecord.put("hidOrgCode",strOrgCode);
			hshRecord.put("hidAppno",strAppno);
			hshRecord.put("hidSelFields",hidSelFields);
			hshRecord.put("hidOpFields",hidOpFields);
			hshRecord.put("txtDate",strDate);
			hshRecord.put("strUserId",strGen);
			hshRecord.put("hidStatus",strStat);
			
			hshPar = new HashMap();
			hshPar =(HashMap)getRepDetails(hshRecord);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in help "+ce.toString());
		}
		
		return hshPar;
	}

	private HashMap getAppno(HashMap hshPar) 
	{
		HashMap hshRec = new HashMap();
		
		ResultSet rs = null;
		String strQuery = null;
		String strOrgCode = null;
		ArrayList vecAppno = new ArrayList();
		String strStat = null;
		String strorglevel = null,strLoanType="";
		StringBuffer strbufOrgcode=new StringBuffer();
		try
		{
			
			strOrgCode=correctNull((String)hshPar.get("hidOrgCode"));
			strStat =(String)hshPar.get("hidStatus");
			strorglevel=correctNull((String)hshPar.get("hidorglevel")); 
			strOrgCode=strOrgCode.replaceAll("'","");
			strLoanType=correctNull((String)hshPar.get("hidLoanType")); 
			if(strorglevel.equalsIgnoreCase("C"))
			{
				strbufOrgcode.append("app_orgcode like '001%'");
			}
			else if(strorglevel.equalsIgnoreCase("R"))
			{
				strbufOrgcode.append("app_orgcode like '").append(strOrgCode.substring(0,6)).append("%'");
			}
			else if(strorglevel.equalsIgnoreCase("CPC"))
			{
				strbufOrgcode.append("org_code like '").append(strOrgCode.substring(0,6)).append("%'");
			}
			else if(strorglevel.equalsIgnoreCase("D"))
			{
				strbufOrgcode.append("app_orgcode like '").append(strOrgCode.substring(0,9)).append("%'");
			}
			else if(strorglevel.equalsIgnoreCase("A"))
			{
				strbufOrgcode.append("app_orgcode like '").append(strOrgCode.substring(0,12)).append("%'");
			}
			
			if(strorglevel.equalsIgnoreCase("CPC"))
			strQuery = SQLParser.getSqlQuery("selcomrepappno_cpc^"+strLoanType+"^"+strbufOrgcode.toString());
			else
				strQuery = SQLParser.getSqlQuery("selcomrepappno^"+strLoanType+"^"+strbufOrgcode.toString());
			if(strorglevel.equalsIgnoreCase("CPC"))
			{
			if (strStat.equalsIgnoreCase("R"))
			{
				strQuery = strQuery + "and  upper(app_status) like '_R' and app_approvedby=usr_id" ;
			}		
			else if (strStat.equalsIgnoreCase("A"))
			{
				strQuery = strQuery + "and  upper(app_status) like '_A'  and app_approvedby=usr_id" ;
			}
			else if (strStat.equalsIgnoreCase("P"))
			{
				strQuery = strQuery + "and  upper(app_status) like '_P'  and app_applnholder=usr_id" ;
			}
			else if (strStat.equalsIgnoreCase("L"))
			{
				strQuery = strQuery + "and  upper(app_status) like '_L'  and app_applnholder=usr_id" ;
			}
			}else{
				if (strStat.equalsIgnoreCase("R"))
				{
					strQuery = strQuery + "and  upper(app_status) like '_R'" ;
				}		
				else if (strStat.equalsIgnoreCase("A"))
				{
					strQuery = strQuery + "and  upper(app_status) like '_A'" ;
				}
				else if (strStat.equalsIgnoreCase("P"))
				{
					strQuery = strQuery + "and  upper(app_status) like '_P'" ;
				}
				else if (strStat.equalsIgnoreCase("L"))
				{
					strQuery = strQuery + "and  upper(app_status) like '_L'" ;
				}
			}
			rs= DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				vecAppno.add(correctNull(rs.getString("app_no")));		
			}

			hshRec.put("vecValues",vecAppno);
						
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
		return hshRec;
	}
	private HashMap getComUserDetails(HashMap hshRequestValues) 
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
		String strToDate="";
		String strFromDate="";
		String strQ="";
		String strapprovedby="",strApp_Name="",strLoanType="";;
		
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
			strLoanType=correctNull((String)hshRequestValues.get("hidLoanType"));
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
			
			if ((strStat.equalsIgnoreCase("R"))||(strStat.equalsIgnoreCase("A")))
			{
				strbufOrgcode.append("and applications.app_approvedby =");
				strDatetype="app_processdate";
			}		
			/*else if (strStat.equalsIgnoreCase("A"))
			{
				strbufOrgcode.append("and applications.app_approvedby =");
			}*/
			else if (strStat.equalsIgnoreCase("P")||strStat.equalsIgnoreCase("L"))
			{
				strbufOrgcode.append("and applications.app_applnholder =");
				strDatetype="app_createdate";
				
			}
			strbufOrgcode.append(strAppno);
			
			if(strStat.equalsIgnoreCase("L")){
				strOpFields=strOpFields+",to_char(app_lodgeddate,'DD/MM/YYYY') as app_lodgeddate,app_renew_flag";
				strSelFields=strSelFields+",Lodged Date,Proposal Type";
			}	
			
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
			if(strOrglevel.equalsIgnoreCase("CPC"))
			strQuery = SQLParser.getSqlQuery("selcomuserstatus_cpc^"+strOpFields+"^"+strbufOrgcode.toString()+"^"+strStat+"^"+strLoanType);
			else
				strQuery = SQLParser.getSqlQuery("selcomuserstatus^"+strOpFields+"^"+strbufOrgcode.toString()+"^"+strStat+"^"+strLoanType);	
			
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
				if (vecT.contains("Proposal Number"))
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
				if (vecT.contains("Amount"))
				{
					//app_valuesin
					double dbltemp=0;
					dbltemp =Double.parseDouble(Helper.correctDouble((String)rs.getString("facility_proposed")));
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
					vecRecords.add("left");
				}
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
			else if((strStat.equalsIgnoreCase("L"))||(strStat.equalsIgnoreCase("ol")))
			{
				strStat="Lodged";
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
	 private HashMap getlayerlist(HashMap hshValues) 
		{
		
			String strQuery="";
	 		ResultSet rs = null;
	 		HashMap hshRecord = new HashMap();
			ArrayList arrRow=new ArrayList();
			ArrayList arrCol=new ArrayList();
			String strOrgCode ="";
			String strorglevel="";
			StringBuffer strbufOrgcode=new StringBuffer();
			try
			{
				strOrgCode = correctNull((String) hshValues.get("hidOrgCode"));
				strorglevel=correctNull((String) hshValues.get("orglevel"));
				strOrgCode=strOrgCode.replaceAll("'","");
				if(strorglevel.equalsIgnoreCase("C"))
				{
					strbufOrgcode.append("org_code like '001%'");
				}
				else if(strorglevel.equalsIgnoreCase("R"))
				{
					strbufOrgcode.append("org_code like '").append(strOrgCode.substring(0,6)).append("%'");
				}
				else if(strorglevel.equalsIgnoreCase("D"))
				{
					strbufOrgcode.append("org_code like '").append(strOrgCode.substring(0,9)).append("%'");
				}
				else if(strorglevel.equalsIgnoreCase("A"))
				{
					strbufOrgcode.append("org_code like '").append(strOrgCode.substring(0,9)).append("%'");
				}
				
				
				strQuery=SQLParser.getSqlQuery("sel_lawyer^"+strbufOrgcode.toString());		
				rs = DBUtils.executeQuery(strQuery);
				
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(correctNull(rs.getString("lawyer_seqno")));
					arrCol.add(correctNull(rs.getString("lawyer_name")));
					arrRow.add(arrCol);							
				}
				hshRecord.put("arrRow",arrRow);
			}
			catch(Exception ce)
			{
				throw new EJBException("Error in getLawyerList "+ce.toString());
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