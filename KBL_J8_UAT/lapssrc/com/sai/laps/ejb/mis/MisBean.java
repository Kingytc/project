package com.sai.laps.ejb.mis;

import java.sql.ResultSet;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.commworkflow.CommWorkflowBean;
import com.sai.laps.ejb.mastapplicant.MastApplicantBean;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.MISLogger;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "MisBean", mappedName = "MisHome")
@Remote (MisRemote.class)
public class MisBean extends BeanAdapter {
	
	static Logger log=Logger.getLogger(MisBean.class);
	public void MisBean(){
		
	}
	
	//Created by Venkata Prasad Chowdary Mullamuri For MIS Static Data Master on 23-07-2013
	public void updateMISstaticdata(HashMap hshValues)
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshQry = new HashMap();
		ArrayList arrVal = new ArrayList();
		ResultSet rs=null;
		String getMISDataMaxId = "",strStatId="";		
		String hidslno="";
		String action = correctNull((String)hshValues.get("hidAction"));
		strStatId = correctNull((String)hshValues.get("seldataheadtype"));
		hidslno = correctNull((String)hshValues.get("hidsno"));
		String strKeyId = "";
		StringBuilder sbolddata=new StringBuilder();  
		String strhidsno = Helper.correctNull((String)hshValues.get("txt_hidsno"));
		try
		{
			if(action.equalsIgnoreCase("insert"))
			{
				getMISDataMaxId = Integer.toString(getMISDataMaxid(strStatId));				
				hshqueryval.put("size","1");
				hshQry.put("strQueryId","ins_misstaticdatamaster");
				arrVal.add(Helper.correctInt((String)hshValues.get("seldataheadtype")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_datacode")));	
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_datavalues")));				
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_visibility")));
				arrVal.add(getMISDataMaxId);
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_weathersche")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_whtrmclr")));
				hshQry.put("arrValues",arrVal);							
				hshqueryval.put("1",hshQry);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			else if(action.equalsIgnoreCase("update"))
			{
				hshqueryval.put("size","1");
				hshQry.put("strQueryId","upd_misstaticdatamaster");			
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_datacode")));	
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_datavalues")));				
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_visibility")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_weathersche")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_whtrmclr")));
				arrVal.add(Helper.correctInt((String)hshValues.get("seldataheadtype")));				
				arrVal.add(strhidsno);
				hshQry.put("arrValues",arrVal);							
				hshqueryval.put("1",hshQry);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			else if(action.equalsIgnoreCase("delete"))
			{
				hshqueryval.put("size","1");
				hshQry.put("strQueryId","del_misstaticdatamaster");
				arrVal.add(Helper.correctInt((String)hshValues.get("seldataheadtype")));
				arrVal.add(strhidsno);
				hshQry.put("arrValues",arrVal);							
				hshqueryval.put("1",hshQry);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}			
			hshQry.put("strSelDataHeads",Helper.correctInt((String)hshValues.get("seldataheadtype")));	
			
		}
		catch (Exception e)
		{
			throw new EJBException("Error in bean "+e.toString());
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
	
	//Created by Venkata Prasad Chowdary Mullamuri For MIS Static Data Master on 23-07-2013
	private int getMISDataMaxid(String strStatId)
	{		
		String strQuery="";
		ResultSet rs = null;
		int termId = 0;
		try
		{	
			strQuery = SQLParser.getSqlQuery("MISStaticDataMaxid^"+strStatId);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(rs.getString(1) != null)
				{
					termId = Integer.parseInt(rs.getString(1)) + 1;
				}
				else
				{
					termId = 1;
				}
			}
			rs.close();			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getMISDataMaxid "+ce.toString());
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
		return termId;
	}
	
	
	//Created by Venkata Prasad Chowdary Mullamuri For MIS Static Data Master on 23-07-2013
	public HashMap getMISstaticdata(HashMap hshValues) 
	{	
		
		String strQuery="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord =new HashMap();
		ArrayList arrCol= new ArrayList();
		ArrayList arrRow= new ArrayList();	
		String hidslno = "";		
		try
		{
			String strStatId = "";
			hidslno = correctNull((String)hshValues.get("hidsno"));
			if(hidslno=="")
			{
				hidslno="0";
			}
			String strSelDataHeads = Helper.correctNull((String)hshValues.get("DataHeads"));	
			if(strSelDataHeads.equalsIgnoreCase(""))
			{
				strSelDataHeads = Helper.correctNull((String)hshValues.get("seldataheadtype"));	
			}
				
				
				
			strQuery=SQLParser.getSqlQuery("sel_misstaticdatamaster^"+strSelDataHeads);		
			rs = DBUtils.executeQuery(strQuery);		
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("mis_static_data_code")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_static_data_desc")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_static_data_show")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_slno")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_static_data_id")));
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_SCHEMATIC")));				
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_MCLR_SCHEME")));				
				arrRow.add(arrCol);							
			}	
			
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("strStatId",strStatId);
			hshRecord.put("strSelDataHeads", strSelDataHeads);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getMISstaticdata "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}				
				
				if(rs1 != null)
				{
					rs1.close();
				}				
								
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());					
			}
		}
		return hshRecord;
	}
	public HashMap getMISMainSubActivity(HashMap hshRequestValues) 
	{		
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strQuery="";
		String strDesc="0";
		boolean recordflag=false;
		try
		{				
			hshRecord = new HashMap();
			strDesc=correctNull((String)hshRequestValues.get("hidMainActivityDesc"));
			if(strDesc.equals(""))
			{
				strDesc ="0";
			}
			hshRecord.put("newmode",(String)hshRequestValues.get("newmode"));
			strQuery = SQLParser.getSqlQuery("sel_MISDetails^"+strDesc);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{   
				recordflag=true;
				hshRecord.put("hidMainActivityDesc",rs.getString("mis_sno"));
				hshRecord.put("mis_mainact",rs.getString("mis_mainact"));
				hshRecord.put("mis_subactcode",rs.getString("mis_subactcode"));
				hshRecord.put("mis_subactdesc",rs.getString("mis_subactdesc"));
				hshRecord.put("mainactdesc",rs.getString("mainactdesc"));
				hshRecord.put("mis_show",rs.getString("mis_show"));
			}
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}
	public HashMap updateMISMainSubActivity(HashMap hshValues) 
	{	
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String strID="";
		String strExp ="$";
		ResultSet rs =null;
		StringBuilder sbAuditTrial=new StringBuilder();
		StringBuilder sbolddata = new StringBuilder();
		//String strKeyId = "";
		try
		{
			//strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			/*if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				rs = DBUtils.executeLAPSQuery("sel_MISDetails^"+Helper.correctNull(((String)hshValues.get("hidMainActivityDesc"))));
				if(rs.next())
				{
					sbolddata.append("~ Industry Group = "+Helper.correctNull((String)rs.getString("ind_grp")));
					sbolddata.append("~ Industry Name = "+Helper.correctNull((String)rs.getString("ind_name")));
					sbolddata.append("~ BSR Code = "+Helper.correctNull((String)rs.getString("ind_bsr_code")));
					if(Helper.correctNull((String)rs.getString("ind_active")).equalsIgnoreCase("Y"))
					{
						sbolddata.append("~ Active = Yes");
					}
					else
					{
						sbolddata.append("~ Active = No");
					}
				}
				if(rs!=null)
				rs.close();
			}*/
			if(strAction.equals("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");				
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","upd_MISDetails");
				arrValues.add(correctNull((String )hshValues.get("txt_MainActivityCode")));
				arrValues.add(correctNull((String )hshValues.get("txt_SubActCode")));
				arrValues.add(correctNull((String )hshValues.get("txt_SubActDesc")));
				arrValues.add(correctNull((String )hshValues.get("sel_Visibility")));
				arrValues.add(correctNull((String )hshValues.get("hidMainActivityDesc")));				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				hshValues.put("hidMainActivityDesc",((String)hshValues.get("hidMainActivityDesc")));
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equals("insert"))
			{
				strID =  Integer.toString(getTermCode());
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");				
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ins_MISDetails");
				arrValues.add(strID);
				arrValues.add(correctNull((String )hshValues.get("txt_MainActivityCode")));
				arrValues.add(correctNull((String )hshValues.get("txt_SubActCode")));
				arrValues.add(correctNull((String )hshValues.get("txt_SubActDesc")));
				arrValues.add(correctNull((String )hshValues.get("sel_Visibility")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				hshValues.put("hidMainActivityDesc",strID);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equals("delete"))
			{
			    /*strExp = strExp+"Cannot delete the Industry,the Industry is attached to a CMA.";
			    String  strQuery = SQLParser.getSqlQuery("selcmano^"+correctNull((String )hshValues.get("hidMainActivityDesc")));
			    if (rs != null) {
					rs.close();
				}
			    rs = DBUtils.executeQuery(strQuery);
			    if (rs.next()) {
			    	throw new Exception(strExp);
			    }*/
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");				
				hshQuery.put("strQueryId","del_MISDetails");
				arrValues.add(correctNull((String )hshValues.get("hidMainActivityDesc")));				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				/*try
				{
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				catch(Exception se)
				{
					throw new Exception(strExp);
				}*/
			}
			/*if(!strAction.equalsIgnoreCase("delete")){
			sbAuditTrial.append("~Industry Group = ").append(correctNull((String)hshValues.get("txt_indgrp")))
			.append("~Industry Name = "+correctNull((String )hshValues.get("txt_industryname")))
			.append("~BSR Code = ").append(correctNull((String )hshValues.get("txt_bsrcode")))
			.append("~Active = ");
			if(Helper.correctNull((String)hshValues.get("selactive")).equalsIgnoreCase("Y"))
			{
				sbAuditTrial.append("Yes");
			}
			else
			{
				sbAuditTrial.append("No");
			}
			}
			AuditTrial.auditNewLog(hshValues,"92",strKeyId,sbAuditTrial.toString(),sbolddata.toString());*/
			
			//if(strAction.equalsIgnoreCase("insert"))
				//hshValues = (HashMap)getData(hshValues);
			
		}
		catch(Exception ce)
		{
			throw new EJBException(ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshValues;
	}
	private int getTermCode()
	{		
		String strQuery="";
		ResultSet rs = null;
		int termId = 0;
		try
		{			
			strQuery = SQLParser.getSqlQuery("sel_MaxMISDetailsID");
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				termId = Integer.parseInt(rs.getString(1));
			}
			rs.close();
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData "+ce.toString());
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
		return termId;
	}
	public HashMap getMISActivity(HashMap hshValues) 
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		ArrayList arrCol = new ArrayList();
		ArrayList arrValue = new ArrayList();
		String strindustry="",strtype="";
		try
		{
			strindustry=Helper.correctNull((String)hshValues.get("txt_SubActCode"));
			strtype=Helper.correctNull((String)hshValues.get("cat"));
			if(strtype.equalsIgnoreCase("1"))
			{
				rs = DBUtils.executeLAPSQuery("sel_MISActivity_searchbycode^"+strindustry);
			}
			else if(strtype.equalsIgnoreCase("2"))
			{
				rs = DBUtils.executeLAPSQuery("sel_MISActivity_searchbyname^"+strindustry);
			}
				
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull((String)rs.getString("mis_subactcode")));
				arrCol.add(correctNull((String)rs.getString("mis_subactdesc")));
				arrCol.add(correctNull((String)rs.getString("mis_sno")));
				arrCol.add(correctNull((String)rs.getString("mis_mainact")));
				arrCol.add(correctNull((String)rs.getString("mainactdesc")));
				arrCol.add(correctNull((String)rs.getString("mis_show")));
				arrValue.add(arrCol);
			}
			hshResult.put("arrBSRCode",arrValue);
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
		}finally
		{
			try
			{
				if(rs!=null)
				{
					rs.close();
				}
			}catch(Exception ex)
			{
				throw new EJBException("Error in closing connection in getBSRCode");
			}
		}
		
		return hshResult;
	}
	public HashMap getMainActivitySearch(HashMap hshValues) 
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		ArrayList arrCol = new ArrayList();
		ArrayList arrValue = new ArrayList();
		String strcode="", strQuery="";
		try
		{
			strcode=Helper.correctNull((String)hshValues.get("id"));
			if(!strcode.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("sel_MISMainActivity^"+strcode);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol = new ArrayList();
					arrCol.add(correctNull((String)rs.getString("mis_slno")));
					arrCol.add(correctNull((String)rs.getString("mis_static_data_code")));
					arrCol.add(correctNull((String)rs.getString("mis_static_data_desc")));
					arrValue.add(arrCol);
				}
			}
			hshResult.put("arrCode",arrValue);
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
		}finally
		{
			try
			{
				if(rs!=null)
				{
					rs.close();
				}
			}catch(Exception ex)
			{
				throw new EJBException("Error in closing connection in getBSRCode");
			}
		}
		
		return hshResult;
	}
	public HashMap getMISActivityCodeDetails(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		String strQuery="", strActivityCode="", strCategory="", strActivity="";
		String strPageFrom = "";
		String strPrdCode = "",strActCode="",strPrdPurpose="";
		String strMainActivityCode = "",strSubActivityCode="";
		String strLoanType="",strCorpProductCode="";
		String strAppno="" , strModuleType="c";
		String FacilitySno="";
		HashMap hshMisActivityCode=new HashMap();
		HashMap hshMisActivityDesc=new HashMap();
		
		
		try
		{
			strPageFrom = Helper.correctNull((String)hshValues.get("master"));
			strActivityCode=Helper.correctNull((String)hshValues.get("txt_Activity"));
			strCategory=Helper.correctNull((String)hshValues.get("hidCategory"));
			strPrdCode = Helper.correctNull((String)hshValues.get("prdcode"));
			
			strLoanType= Helper.correctNull((String)hshValues.get("strLoanType"));
			strCorpProductCode= Helper.correctNull((String)hshValues.get("strCorpProductCode"));
			FacilitySno= Helper.correctNull((String)hshValues.get("facilitySno"));
			
			log.info(" =================product activity code =================="+strCorpProductCode);
			log.info(" =================strLoanType=================="+strLoanType);
			
			if(strLoanType.equalsIgnoreCase("C") || strLoanType.equalsIgnoreCase("A"))
			{
				strPrdCode=strCorpProductCode;
			}
			strAppno=Helper.correctNull((String)hshValues.get("strappno"));
 
			if(strPageFrom.equalsIgnoreCase("master")||strPageFrom.equalsIgnoreCase("mis") )
			{
				if(strCategory.equalsIgnoreCase("1"))
				{
					strActivity="and act_activitycode='"+strActivityCode+"'";
				}
				else
				{
					strActivity="and upper(msd.mis_static_data_desc) like upper('%"+strActivityCode+"%')";
				}
				strQuery=SQLParser.getSqlQuery("sel_Activity^"+strActivity);
			}
			else if(strPageFrom.equalsIgnoreCase("mis") && (!strAppno.equalsIgnoreCase("")))
			{
				if(rs !=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("sel_appstatus^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strModuleType=Helper.correctNull((String)rs.getString("app_loantype"));
					strModuleType=strModuleType.toLowerCase();
				}
				if(strModuleType.equalsIgnoreCase("c") || strModuleType.equalsIgnoreCase("a"))
				{
					strPrdCode=strCorpProductCode;
				}
				
				log.info(" =================Module Type=================="+strModuleType);
				String strActivityCodes="";
				
				if((strModuleType.equalsIgnoreCase("c") || strModuleType.equalsIgnoreCase("a")))
				{
					if(!strAppno.equalsIgnoreCase("") && !FacilitySno.equalsIgnoreCase(""))
					{
						strQuery=SQLParser.getSqlQuery("sel_FacilityIdLimit^"+strAppno+"^"+FacilitySno);
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strPrdCode=Helper.correctNull((String)rs.getString("facility_code"));
							log.info(" =================product code Taken from Facilities=================="+strPrdCode);
						}
					}
				}
				
				strQuery=SQLParser.getSqlQuery("sel_PrdActivityCodes^"+strPrdCode+"^"+strModuleType);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
					
				{
					strActivityCodes=correctNull(Helper.CLOBToString(rs.getClob("prdact_activitycode")));
				}
				if( strActivityCodes != null || strActivityCodes.equalsIgnoreCase(""))
				{
					StringTokenizer st = new StringTokenizer(strActivityCodes,"~");
					while(st.hasMoreTokens())
					{
						String strCode = (String)st.nextToken();
						if(strCode != null && strCode !="")
						{
							String[] strDesc=strCode.split("&");
							int size=strDesc.length;
							if(strDesc!=null && size>1)
							{
								strActCode=strActCode+"'"+strDesc[0]+"',";
								hshMisActivityCode.put(strDesc[0], strDesc[0]);
								hshMisActivityDesc.put(strDesc[0], strDesc[1]);
								//strPrdPurpose = strPrdPurpose+"'"+strDesc[1]+"',";
							}
						}
					}
				}
				strActivity = " and act_activitycode in( ";
				if(strActCode.equalsIgnoreCase(""))
				{
					strActCode = "''";
				}
				else
				{
					strActCode=strActCode.substring(0,(strActCode.length() -1));
				}
				if(strCategory.equalsIgnoreCase("1"))
				{
					strQuery=SQLParser.getSqlQuery("sel_Activity^"+"and act_activitycode='"+strActivityCode+"'");
				}
				else
				{
					strQuery=SQLParser.getSqlQuery("sel_Activity^"+"and upper(mis_static_data_desc) like upper('%"+strActivityCode+"%')");
				}
			}
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					String strProdcuActcode="";
					if(strPageFrom.equalsIgnoreCase("master") ||strPageFrom.equalsIgnoreCase("mis"))
					{
						strProdcuActcode=strActivityCode;
					}
					else
					{
						 	if(strCategory.equalsIgnoreCase("1"))
							{
								 strProdcuActcode=Helper.correctNull((String)hshMisActivityCode.get(strActivityCode));
							}
							else
							{
								 strProdcuActcode=Helper.correctNull((String)rs.getString("act_activitycode"));	
									
								 strProdcuActcode=Helper.correctNull((String)hshMisActivityDesc.get(strProdcuActcode));
								
							}
					}
					if(strProdcuActcode.length()>0)
					{
						arrCol=new ArrayList();
						arrCol.add(Helper.correctNull((String)rs.getString("act_sno")));//0
						arrCol.add(Helper.correctNull((String)rs.getString("act_mainactcode")));//1
						arrCol.add(Helper.correctNull((String)rs.getString("act_subactcode")));//2
						arrCol.add(Helper.correctNull((String)rs.getString("act_purposecode")));//3
						arrCol.add(Helper.correctNull((String)rs.getString("act_activitycode")));//4
						arrCol.add(Helper.correctNull((String)rs.getString("act_bsrcode")));//5
						arrCol.add(Helper.correctNull((String)rs.getString("act_bsr1code")));//6
						arrCol.add(Helper.correctNull((String)rs.getString("act_displayscreen")));//7
						arrCol.add(Helper.correctNull((String)rs.getString("act_industrytype")));//8
						arrCol.add(Helper.correctNull((String)rs.getString("act_show")));//9
						arrCol.add(Helper.correctNull((String)rs.getString("act_createdate")));//10
						arrCol.add(Helper.correctNull((String)rs.getString("act_modifieddate")));//11
						arrCol.add(Helper.correctNull((String)rs.getString("act_purposesno")));//12
						arrCol.add(Helper.correctNull((String)rs.getString("mis_static_data_desc")));//13
						arrCol.add(Helper.correctNull((String)rs.getString("act_lbrcode")));//14
						
						
						strMainActivityCode = Helper.correctNull((String)rs.getString("act_mainactcode"));
						strQuery = SQLParser.getSqlQuery("sel_misstaticdatadesc^"+"2"+"^"+strMainActivityCode);
						rs1= DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							arrCol.add(Helper.correctNull((String)rs1.getString("mis_static_data_desc")));//15
						}
						else
						{
							arrCol.add("");//15
						}
						strSubActivityCode = Helper.correctNull((String)rs.getString("act_subactcode"));
						strQuery = SQLParser.getSqlQuery("sel_MISSubActivityDesc^"+strMainActivityCode+"^"+strSubActivityCode);
						rs2= DBUtils.executeQuery(strQuery);
						if(rs2.next())
						{
							arrCol.add(Helper.correctNull((String)rs2.getString("mis_subactdesc")));//16
						}
						else
						{
							arrCol.add("");//16
						}
						arrCol.add(Helper.correctNull((String)rs.getString("act_busruleid")));//17
						arrCol.add(Helper.correctNull((String)rs.getString("act_schematicflag")));//18	
						arrCol.add(Helper.correctNull(rs.getString("act_freecode6")));//19
						arrCol.add(Helper.correctNull(rs.getString("act_freecode7")));//20
						arrCol.add(Helper.correctNull(rs.getString("act_freecode8")));//21
						arrCol.add(Helper.correctNull(rs.getString("ACT_CGTMSE")));//22
						arrCol.add(Helper.correctNull(rs.getString("ACT_ALLIED")));//23
						arrRow.add(arrCol);
					}
					
				}
				hshRecord.put("arrRow", arrRow);
				hshRecord.put("strLoanType",strLoanType);
				hshRecord.put("strCorpProductCode",strCorpProductCode);
				hshRecord.put("appno",strAppno);
				hshRecord.put("FacilitySno", FacilitySno);
				
				
				
		}
		catch(Exception e)
		{
			throw new EJBException("Exception occured in getMISActivityCodeDetails "+e.getMessage());
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
			catch(Exception ex)
			{
				throw new EJBException("Error in closing connection in getBSRCode");
			}
		}
		return hshRecord;
	}
	public HashMap updateMISActivityCodeDetails(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues=new ArrayList();
		ResultSet rs=null;
		String strAction="", strMainActivity="", strSubActivity="", strPurpose="", strActivityCode="";
		String strBSRCode="", strBSR1Code="", strDisplayScreen="", strIndustryType="", strVisibility="";
		String strUserId="", strSNo="", strQuery="",strLBRcode="",strAlliedcode="";
		String strBusinessRuleId="",strWeatherSche="",strFreecode6="",strFreecode7="",strFreecode8="";
		String strFreeCode7FinCode="",strFreeCode8FinCode="",strFreeCode7FinVal="",strFreeCode8FinVal="",strFreeCode7Desc="",strFreeCode8Desc="",strCGTMSE="";
		try
		{
			strAction=Helper.correctNull((String)hshValues.get("hidAction"));
			strSNo=Helper.correctNull((String)hshValues.get("hidSlNo"));
			strMainActivity=Helper.correctNull((String)hshValues.get("sel_MainActivity"));
			strSubActivity=Helper.correctNull((String)hshValues.get("sel_SubActivity"));
			strPurpose=Helper.correctNull((String)hshValues.get("sel_Purpose"));
			strActivityCode=Helper.correctNull((String)hshValues.get("txt_ActivityCode"));
			strBSRCode=Helper.correctNull((String)hshValues.get("sel_BSRCode"));
			strBSR1Code=Helper.correctNull((String)hshValues.get("sel_BSR1Code"));
			strDisplayScreen=Helper.correctNull((String)hshValues.get("sel_DisplayScreen"));
			strIndustryType=Helper.correctNull((String)hshValues.get("sel_IndustryType"));
			strVisibility=Helper.correctNull((String)hshValues.get("sel_Visibility"));
			strUserId=Helper.correctNull((String)hshValues.get("strUserId"));
			strLBRcode=Helper.correctNull((String)hshValues.get("sel_LBRCode"));
			strBusinessRuleId=Helper.correctNull((String)hshValues.get("sel_busruleid"));
			strWeatherSche=Helper.correctNull((String)hshValues.get("sel_ratbasedon"));
			strFreecode6=Helper.correctNull((String)hshValues.get("sel_freecode6"));
			strFreecode7=Helper.correctNull((String)hshValues.get("sel_freecode7"));
			strFreecode8=Helper.correctNull((String)hshValues.get("sel_freecode8"));
			strFreeCode7FinCode=Helper.correctNull((String)hshValues.get("hidFreeCode7"));
			strFreeCode8FinCode=Helper.correctNull((String)hshValues.get("hidFreeCode8"));
			strFreeCode7FinVal=Helper.correctNull((String)hshValues.get("hidFreeCode7FinVal"));
			strFreeCode8FinVal=Helper.correctNull((String)hshValues.get("hidFreeCode8FinVal"));
			strCGTMSE=Helper.correctNull((String)hshValues.get("sel_cg"));
			strAlliedcode=Helper.correctNull((String)hshValues.get("allied_act_code"));
			String[] strPurposeTot=strPurpose.split("_");
			String strPurposeCode=strPurposeTot[0];
			String strPurposeSlNo=strPurposeTot[1];
			
			if(strAction.equalsIgnoreCase("insert")||strAction.equalsIgnoreCase("update"))
			{
			if(strFreeCode7FinCode.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("sel_FreeCodeFinData^"+strFreecode7+"^"+strFreeCode7FinVal);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strFreeCode7FinCode=Helper.correctNull((String)rs.getString("fc_code"));
				}
			}
			if(rs!=null)
			{
				rs.close();
			}
			if(strFreeCode8FinCode.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("sel_FreeCodeFinData^"+strFreecode8+"^"+strFreeCode8FinVal);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strFreeCode8FinCode=Helper.correctNull((String)rs.getString("fc_code"));
				}
			}
			}
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","ins_ActivityCode");
				strSNo=getActCodeID();
				arrValues.add(strSNo);
				arrValues.add(strMainActivity);
				arrValues.add(strSubActivity);
				arrValues.add(strPurposeCode);
				arrValues.add(strActivityCode);
				arrValues.add(strBSRCode);
				arrValues.add(strBSR1Code);
				arrValues.add(strDisplayScreen);
				arrValues.add(strIndustryType);
				arrValues.add(strVisibility);
				arrValues.add(strPurposeSlNo);
				arrValues.add(strUserId);
				arrValues.add(strLBRcode);
				arrValues.add(strBusinessRuleId);	
				arrValues.add(strWeatherSche);	
				arrValues.add(strFreecode6);
				arrValues.add(strFreecode7);
				arrValues.add(strFreecode8);
				arrValues.add(strFreeCode7FinCode);
				arrValues.add(strFreeCode8FinCode);
				arrValues.add(strCGTMSE);
				arrValues.add(strAlliedcode);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","upd_ActivityCode");
				arrValues.add(strMainActivity);
				arrValues.add(strSubActivity);
				arrValues.add(strPurposeCode);
				arrValues.add(strActivityCode);
				arrValues.add(strBSRCode);
				arrValues.add(strBSR1Code);
				arrValues.add(strDisplayScreen);
				arrValues.add(strIndustryType);
				arrValues.add(strVisibility);
				arrValues.add(strPurposeSlNo);
				arrValues.add(strUserId);
				arrValues.add(strLBRcode);
				arrValues.add(strBusinessRuleId);
				arrValues.add(strWeatherSche);
				arrValues.add(strFreecode6);
				arrValues.add(strFreecode7);
				arrValues.add(strFreecode8);
				arrValues.add(strFreeCode7FinCode);
				arrValues.add(strFreeCode8FinCode);
				arrValues.add(strCGTMSE);
				arrValues.add(strAlliedcode);
				arrValues.add(strSNo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if (strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_ActivityCode");
				arrValues.add(strSNo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Exception occured in updateMISActivityCodeDetails "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshValues;
	}
	private String getActCodeID()
	{
		String strQuery="";
		ResultSet rs = null;
		String strActCodeID = "";
		try
		{			
			strQuery = SQLParser.getSqlQuery("sel_MaxActivityCodeID");
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				strActCodeID = Helper.correctNull((String)rs.getString(1));
			}
			rs.close();
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData "+ce.toString());
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
		return strActCodeID;
	}
	public HashMap getMainActCode(HashMap hshValues) 
	{
		ResultSet rs=null;
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		String strQuery="";
		String strMainActCode="";
		String strSubActCode="";
		try
		{
			strMainActCode=Helper.correctNull((String)hshValues.get("strMainActCode"));
			strSubActCode=Helper.correctNull((String)hshValues.get("subactcode"));
			if(!strMainActCode.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("sel_MISSubActivity^"+strMainActCode);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(Helper.correctNull((String)rs.getString("mis_subactcode")));
					arrCol.add(Helper.correctNull((String)rs.getString("mis_subactdesc")));
					arrRow.add(arrCol);
				}
			}
			hshValues.put("arrRow", arrRow);
			hshValues.put("strSubActCode",strSubActCode);
		}
		catch(Exception cf)
		{
			throw new EJBException("Error in getMainActCode"+cf.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshValues;
	}
	
	//Created by Venkata Prasad Chowdary Mullamuri For MIS Classification Master on 05-08-2013
	public void updateMisClassification(HashMap hshValues)
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshQry = new HashMap();
		ArrayList arrVal = new ArrayList();
		ResultSet rs=null,rs1=null,rs2=null;
		String hidSlNo="",strKeyId = "";
		StringBuilder sbolddata=new StringBuilder();  
		String strQuery="",strMaxMisSno="",action="",strActivityCode="",strMaxMisActivityCode="",strMaxMisActivitySno="";
		int termId=0,actCode=0;
		String strMisClassType="",strConstitution="",strConsMultiple="";
		String strhid_run_sno="",strhid_actual_sno="",strhid_activity_sno="";
		String strUserId="";
		try
		{
			action = correctNull((String)hshValues.get("hidAction"));
			hidSlNo = correctNull((String)hshValues.get("hidSlNo"));
			strUserId=Helper.correctNull((String)hshValues.get("strUserId"));
			String strhidsno = Helper.correctNull((String)hshValues.get("txt_hidsno"));
			strActivityCode = Helper.correctNull((String)hshValues.get("txt_ActivityCode"));
			if(strActivityCode.equalsIgnoreCase(""))
			{
				strActivityCode="000000";
				hidSlNo="00";
			}
			strMisClassType = Helper.correctNull((String)hshValues.get("sel_classtype"));
			strConsMultiple=Helper.correctNull((String)hshValues.get("hid_sel_constitution"));
			
			strhid_run_sno = correctNull((String)hshValues.get("hid_run_sno"));
			strhid_actual_sno = correctNull((String)hshValues.get("hid_actual_sno"));
			strhid_activity_sno = correctNull((String)hshValues.get("hid_activity_sno"));
			if(action.equalsIgnoreCase("insert"))
			{
				if(rs !=null){
					rs.close();
			}
				strQuery = SQLParser.getSqlQuery("sel_misclassmastermaxid");
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					if(rs.getString(1) != null)
					{
						termId = Integer.parseInt(rs.getString(1)) + 1;
					}
					else
					{
						termId = 1;
					}
				}
				if(rs2 !=null){
					rs2.close();
				}
				strQuery = SQLParser.getSqlQuery("sel_maxactivitycode^"+strActivityCode);
				rs2 = DBUtils.executeQuery(strQuery);
				if(rs2.next())
				{
					if(rs2.getString(1) != null)
					{
						actCode = Integer.parseInt(rs2.getString(1)) + 1;
					}
					else
					{
						actCode = 1;
					}
				}
				strMaxMisSno = Integer.toString(termId);
				strMaxMisActivityCode = Integer.toString(actCode);
				hshqueryval.put("size","1");
				hshQry.put("strQueryId","ins_mismaster");
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_classtype")));
				arrVal.add(hidSlNo); //Activity Sno
				arrVal.add(strMaxMisSno);//Running Sno
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_loanamt")));
				arrVal.add(Helper.correctDouble((String)hshValues.get("txt_loanamt_value")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_loantenor")));
				arrVal.add(Helper.correctDouble((String)hshValues.get("txt_loantenor_value")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_plantmech")));
				arrVal.add(Helper.correctDouble((String)hshValues.get("txt_plantmech_value")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_constitution")));				
				arrVal.add(Helper.correctNull((String)hshValues.get("hid_sel_constitution")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_fxdval")));
				arrVal.add(Helper.correctDouble((String)hshValues.get("txt_fxdval")));				
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_hlval")));
				arrVal.add(Helper.correctDouble((String)hshValues.get("txt_hlval")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_brancharea")));
				arrVal.add(Helper.correctNull((String)hshValues.get("hid_sel_branch_area")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_farmer_cate")));
				arrVal.add(Helper.correctNull((String)hshValues.get("hid_sel_farmer_cate")));			
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_sanction_val")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_sanctiondate")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_govt_spnr")));
				arrVal.add(Helper.correctNull((String)hshValues.get("hid_sel_govt_spnr")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_shg_val")));
				arrVal.add(Helper.correctDouble((String)hshValues.get("txt_shg_val")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_bankschematic_code")));
				arrVal.add(Helper.correctNull((String)hshValues.get("hid_sel_bankschematic_code")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_utlz_credit")));
				arrVal.add(Helper.correctNull((String)hshValues.get("hid_sel_utlz_credit")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_familyincome")));
				arrVal.add(Helper.correctDouble((String)hshValues.get("txt_familyincome")));				
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_borrower_totlimit")));
				arrVal.add(Helper.correctDouble((String)hshValues.get("txt_borrower_totlimit")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_borrower_totlimit_srvcat")));
				arrVal.add(Helper.correctDouble((String)hshValues.get("txt_borrower_totlimit_srvcat")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_borrower_agrtotlimit")));
				arrVal.add(Helper.correctDouble((String)hshValues.get("txt_borrower_agrtotlimit")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_psdateval")));//38
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_new_psdate")));//39
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_caste")));
				arrVal.add(Helper.correctNull((String)hshValues.get("hid_sel_caste")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_irrigate")));
				arrVal.add(Helper.correctInt((String)hshValues.get("txt_irrigate_val")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_dispscreen")));
				arrVal.add(Helper.correctNull((String)hshValues.get("hid_sel_dispscreen")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_gender")));
				arrVal.add(Helper.correctNull((String)hshValues.get("hid_sel_gender")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_mgmnt_gender")));
				arrVal.add(Helper.correctNull((String)hshValues.get("hid_sel_mgmnt_gender")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_sectype")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_sectype1")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_secval")));
				arrVal.add(Helper.correctNull((String)hshValues.get("hid_sel_secval")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_sharebrk")));
				arrVal.add(Helper.correctDouble((String)hshValues.get("txt_sharebrkval")));
				arrVal.add(strActivityCode);
				arrVal.add(strMaxMisActivityCode);//Based on Activity Code Sno
				arrVal.add(Helper.correctInt((String)hshValues.get("sel_priority")));
				arrVal.add(Helper.correctInt((String)hshValues.get("sel_subsector")));//Sub Sector
				arrVal.add(strUserId);
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_Visibility")));
				arrVal.add(Helper.correctNull((String)hshValues.get("rad_classificationbased")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_modeadv")));
				//Added by Arsath on 22/08/2013 for New Fields Sector, Staff
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_sector")));
				arrVal.add(Helper.correctNull((String)hshValues.get("hid_sector_value")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_staffscheme")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_staffschemevalue")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_cretype")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_cre_value")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_social_Infra")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_social_Infra")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_agri_anci")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_agri_anci")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_renew_energy")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_renew_energy")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_renew_energy_indv")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_renew_energy_indv")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_physically_challenged")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_physically_challenged_val")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_agri_infra")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_agri_infra")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_cons_cost")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_cons_cost")));
				
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_dte_from")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_dte_to")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_dte_effect")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_loan_prd")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_holiday_prd")));
				arrVal.add(Helper.correctNull((String)hshValues.get("hid_standUp")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_classfi")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_fromsalesturnover")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_tosalesturnover")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_minority")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_minority_val")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_nonindminority")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_nonindminority_val")));
				
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_start_up_minority_val")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_carpet")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_carpet_value")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_floorarea")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_floorarea_value")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_maxarea_indhouse")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_max_shg_proploan")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_max_shg_proploan_value")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_alliedactivity")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_dwelling_code")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_dwelling_value")));
				//End
				hshQry.put("arrValues",arrVal);							
				hshqueryval.put("1",hshQry);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			else if(action.equalsIgnoreCase("update"))
			{
						
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_classtype")));
				arrVal.add(strhid_actual_sno); //Actual Sno
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_loanamt")));
				arrVal.add(Helper.correctDouble((String)hshValues.get("txt_loanamt_value")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_loantenor")));
				arrVal.add(Helper.correctDouble((String)hshValues.get("txt_loantenor_value")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_plantmech")));
				arrVal.add(Helper.correctDouble((String)hshValues.get("txt_plantmech_value")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_constitution")));				
				arrVal.add(Helper.correctNull((String)hshValues.get("hid_sel_constitution")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_fxdval")));
				arrVal.add(Helper.correctDouble((String)hshValues.get("txt_fxdval")));				
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_hlval")));
				arrVal.add(Helper.correctDouble((String)hshValues.get("txt_hlval")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_brancharea")));
				arrVal.add(Helper.correctNull((String)hshValues.get("hid_sel_branch_area")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_farmer_cate")));
				arrVal.add(Helper.correctNull((String)hshValues.get("hid_sel_farmer_cate")));			
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_sanction_val")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_sanctiondate")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_govt_spnr")));
				arrVal.add(Helper.correctNull((String)hshValues.get("hid_sel_govt_spnr")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_shg_val")));
				arrVal.add(Helper.correctDouble((String)hshValues.get("txt_shg_val")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_bankschematic_code")));
				arrVal.add(Helper.correctNull((String)hshValues.get("hid_sel_bankschematic_code")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_utlz_credit")));
				arrVal.add(Helper.correctNull((String)hshValues.get("hid_sel_utlz_credit")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_familyincome")));
				arrVal.add(Helper.correctDouble((String)hshValues.get("txt_familyincome")));				
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_borrower_totlimit")));
				arrVal.add(Helper.correctDouble((String)hshValues.get("txt_borrower_totlimit")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_borrower_totlimit_srvcat")));
				arrVal.add(Helper.correctDouble((String)hshValues.get("txt_borrower_totlimit_srvcat")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_borrower_agrtotlimit")));
				arrVal.add(Helper.correctDouble((String)hshValues.get("txt_borrower_agrtotlimit")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_psdateval")));//38
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_new_psdate")));//39
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_caste")));
				arrVal.add(Helper.correctNull((String)hshValues.get("hid_sel_caste")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_irrigate")));
				arrVal.add(Helper.correctInt((String)hshValues.get("txt_irrigate_val")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_dispscreen")));
				arrVal.add(Helper.correctNull((String)hshValues.get("hid_sel_dispscreen")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_gender")));
				arrVal.add(Helper.correctNull((String)hshValues.get("hid_sel_gender")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_mgmnt_gender")));
				arrVal.add(Helper.correctNull((String)hshValues.get("hid_sel_mgmnt_gender")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_sectype")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_sectype1")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_secval")));
				arrVal.add(Helper.correctNull((String)hshValues.get("hid_sel_secval")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_sharebrk")));
				arrVal.add(Helper.correctDouble((String)hshValues.get("txt_sharebrkval")));
				arrVal.add(Helper.correctInt((String)hshValues.get("sel_priority")));
				arrVal.add(Helper.correctInt((String)hshValues.get("sel_subsector")));//Sub Sector
				arrVal.add(strUserId);
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_Visibility")));
				if(strMisClassType.equalsIgnoreCase("09"))
					arrVal.add(Helper.correctNull((String)hshValues.get("rad_classificationbased")));
				else
					arrVal.add(Helper.correctNull((String)hshValues.get("hid_rad_classificationbased")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_modeadv")));
				//Added by Arsath on 22/08/2013 for New Fields Sector, Staff
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_sector")));
				arrVal.add(Helper.correctNull((String)hshValues.get("hid_sector_value")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_staffscheme")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_staffschemevalue")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_cretype")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_cre_value")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_social_Infra")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_social_Infra")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_agri_anci")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_agri_anci")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_renew_energy")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_renew_energy")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_renew_energy_indv")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_renew_energy_indv")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_physically_challenged")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_physically_challenged_val")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_agri_infra")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_agri_infra")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_cons_cost")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_cons_cost")));
				
				
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_dte_from")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_dte_to")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_dte_effect")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_loan_prd")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_holiday_prd")));
				arrVal.add(Helper.correctNull((String)hshValues.get("hid_standUp")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_classfi")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_fromsalesturnover")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_tosalesturnover")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_minority")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_minority_val")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_nonindminority")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_nonindminority_val")));
				
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_start_up_minority_val")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_carpet")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_carpet_value")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_floorarea")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_floorarea_value")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_maxarea_indhouse")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_max_shg_proploan")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_max_shg_proploan_value")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_alliedactivity")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_dwelling_code")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_dwelling_value")));
				//End
				arrVal.add(strActivityCode);
				arrVal.add(strhid_activity_sno);//Based on Activity Code Sno
				arrVal.add(strhid_run_sno);//Running Sno
				hshQry.put("arrValues",arrVal);
				hshQry.put("strQueryId","upd_mismaster");	
				hshqueryval.put("size","1");				
				hshqueryval.put("1",hshQry);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			else if(action.equalsIgnoreCase("delete"))
			{
				hshqueryval.put("size","1");
				hshQry.put("strQueryId","del_mismaster");
				arrVal.add(strActivityCode);//Sub Sector
				arrVal.add(strhid_activity_sno);//Based on Activity Code Sno
				arrVal.add(strhid_run_sno);//Running Sno
				hshQry.put("arrValues",arrVal);							
				hshqueryval.put("1",hshQry);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}			
			
		}
		catch (Exception e)
		{
			throw new EJBException("Error in bean "+e.toString());
		}
		finally
		{
			try
			{				
				if(rs != null)
				{
					rs.close();
				}
				if(rs1 != null)
				{
					rs1.close();
				}
				if(rs2 != null)
				{
					rs2.close();
				}
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}	
	}
	
	//Created by Venkata Prasad Chowdary Mullamuri For MIS Static Data Master on 23-07-2013
	public HashMap getMisClassification(HashMap hshValues) 
	{	
		
		String strQuery="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord =new HashMap();
		ArrayList arrCol= new ArrayList();
		ArrayList arrRow= new ArrayList();	
		ArrayList arrRow1= new ArrayList();	
		ArrayList arrRow2=new ArrayList();
		String hidslno = "",strhid_run_sno="",strhid_actual_sno="",strhid_activity_sno="",strActivityCode="";
		String strClassifType="";
		NumberFormat nft=NumberFormat.getInstance();
		nft.setMinimumFractionDigits(2);
		nft.setMaximumFractionDigits(2);
		nft.setGroupingUsed(false);
		try
		{
			
			strhid_run_sno = correctNull((String)hshValues.get("hid_run_sno"));
			strhid_actual_sno = correctNull((String)hshValues.get("hid_actual_sno"));
			strhid_activity_sno = correctNull((String)hshValues.get("hidSlNo"));
			strActivityCode= correctNull((String)hshValues.get("txt_ActivityCode"));
			strClassifType= correctNull((String)hshValues.get("sel_classtype"));
			String strAppend = "";
			if(strClassifType.equalsIgnoreCase("08") ||strClassifType.equalsIgnoreCase("09"))
			{
				strAppend = " ";
			}
			else
			{
				strAppend = "mis_activitycode='"+strActivityCode+"' and";
			}
			strQuery=SQLParser.getSqlQuery("sel_mismaster^"+strAppend+"^"+strClassifType);
			rs = DBUtils.executeQuery(strQuery);		
			while(rs.next())
			{				
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("mis_type")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_activitysno")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_sno")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_loanamtcode")));
				arrCol.add(nft.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("mis_loanamtvalue")))));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_loantenorcode")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_loantenorvalue")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_plantmaccode")));
				arrCol.add(nft.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("mis_plantmacvalue")))));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_constitutioncode")));//10
				arrCol.add(Helper.correctNull((String)rs.getString("mis_constitutionvalue")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_fixedassetcode")));
				arrCol.add(nft.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("mis_fixedassetvalue")))));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_hlcode")));
				arrCol.add(nft.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("mis_hlvalue")))));//15
				arrCol.add(Helper.correctNull((String)rs.getString("mis_branchlocationcode")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_branchlocationvalue")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_farmercode")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_farmervalue")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_sanctiondatecode")));//20
				arrCol.add(Helper.correctNull((String)rs.getString("mis_sanctiondatevalue")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_govtsposchcode")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_govtsposchvalue")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_shgcode")));
				arrCol.add(nft.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("mis_shgvalue")))));//25
				arrCol.add(Helper.correctNull((String)rs.getString("mis_bankschemecode")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_bankschemevalue")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_utilizationcode")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_utilizationvalue")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_faminccode")));//30
				arrCol.add(nft.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("mis_famincvalue")))));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_totallimitcode")));
				arrCol.add(nft.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("mis_totallimitvalue")))));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_totalservicelimitcode")));
				arrCol.add(nft.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("mis_totalservicelimitvalue")))));//35
				arrCol.add(Helper.correctNull((String)rs.getString("mis_totalagrilimitcode")));
				arrCol.add(nft.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("mis_totalagrilimitvalue")))));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_psdatecode")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_psdatevalue")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_castecode")));//40
				arrCol.add(Helper.correctNull((String)rs.getString("mis_castevalue")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_irrigatedcode")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_irrigatedvalue")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_displayscreencode")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_displayscreenvalue")));//45
				arrCol.add(Helper.correctNull((String)rs.getString("mis_gendercode")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_gendervalue")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_managementgendercode")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_managementgendervalue")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_securitytypecode")));//50
				arrCol.add(Helper.correctNull((String)rs.getString("mis_securitytypevalue")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_securitynamecode")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_securitynamevalue")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_sharebrokercode")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_sharebrokercode")));//55
				arrCol.add(Helper.correctNull((String)rs.getString("mis_subsector")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_activityspecifsno")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_priority")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_activitycode")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_show")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_classifytype")));
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_MODEADV")));	
				//Added by Arsath on 22/08/2013 for New Fields like Sector, Staff
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_SECTORCODE")));//63
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_SECTORVAL")));//64
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_STAFFCODE")));//65
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_STAFFVAL")));//66
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_CRECODE")));//67
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_CREVALUE")));//68
				//Added by Guhan on 06/08/2015 for New Priority conditions
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_SOCIAL_INFRA_CODE")));//69
				arrCol.add(nft.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("MIS_SOCIAL_INFRA_VALUE")))));//70
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_AGRI_ANCI_CODE")));//71
				arrCol.add(nft.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("MIS_AGRI_ANCI_VALUE")))));//72
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_RENEW_ENERGY_CODE")));//73
				arrCol.add(nft.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("MIS_RENEW_ENERGY_VALUE")))));//74
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_RENEW_ENERGY_INDV_CODE")));//75
				arrCol.add(nft.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("MIS_RENEW_ENERGY_INDV_VALUE")))));//76
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_PHYS_CHALL_CODE")));//77
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_PHYS_CHALL_VALUE")));//78
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_AGRI_INFRA_CODE")));//79
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_AGRI_INFRA_VALUE")));//80
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_CONST_COST_CODE")));//81
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_CONST_COST_VALUE")));//82
				
				
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_EXPO_DT_FROM")));
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_EXPO_DT_TO")));
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_EFFECT_DT")));
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_LOAN_PRD")));
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_HOLIDAY_PRD")));//87
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_AGRI_SERVICE_CTG")));//88
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_CLASSIFICATION")));//89
				arrCol.add(nft.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("MIS_SALESFROMVALUE")))));//90
				arrCol.add(nft.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("MIS_SALESTOVALUE")))));//91
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_MINORITY_CODE")));//92
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_MINORITY_VALUE")));//93
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_NONIND_MINORITY_CODE")));//94
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_NONIND_MINORITY_VALUE")));//95
				
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_START_UP_CODE")));//96
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_CARPET_AREA_CODE")));//97
				arrCol.add(nft.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("MIS_CARPET_AREA_VALUE")))));//98
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_FLOOR_AREA_CODE")));//99
				arrCol.add(nft.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("MIS_FLOOR_AREA_VALUE")))));//100
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_INDIVIDUAL_HOUSE")));//101
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_SHG_PROPOSED_LOAN_CODE")));//102
				arrCol.add(nft.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("MIS_SHG_PROPOSED_LOAN_VALUE")))));//103
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_ALLIEDACTIVITY")));//104
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_DWELLING_CODE")));//105
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_DWELLING_VALUE")));//106
				//End
				arrRow.add(arrCol);							
			}
			
			strQuery = SQLParser.getSqlQuery("selSecurityType_MIS^0");
			rs = DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("sec_id")));
				arrCol.add(Helper.correctNull((String)rs.getString("sec_name")));
				arrRow1.add(arrCol);
			}
			
			
			strQuery = SQLParser.getSqlQuery("sel_mis_staticdata");
			rs = DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_STATIC_DATA_CODE")));
				arrCol.add(Helper.correctNull((String)rs.getString("MIS_STATIC_DATA_DESC")));
				arrRow2.add(arrCol);
			}
			
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("arrRow1",arrRow1);
			hshRecord.put("arrRow2", arrRow2);
			hshRecord.put("strClassifType",strClassifType );
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getMisClassification "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}				
				
				if(rs1 != null)
				{
					rs1.close();
				}				
								
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());					
			}
		}
		return hshRecord;
	}
	/**
	 * @author:Karthikeyan.S
	 * @date:August 07, 2013-02:04:12 PM
	 * @category MIS Details get method
	 * @return hshRecord
	 */
	public HashMap getClassificationActivityMaster(HashMap hshValues) 
	{
		HashMap hshRecord = new HashMap();
		String strQuery = "";
		ResultSet rs = null;
		
		try
		{
			strQuery = SQLParser.getSqlQuery("sel_master_classi_activity");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("social_infra", Helper.correctNull((String)rs.getString("MIS_SOCIAL_INFRA")));
				hshRecord.put("renew_energy", Helper.correctNull((String)rs.getString("MIS_RENEW_ENERGY")));
				hshRecord.put("renew_energy_indv", Helper.correctNull((String)rs.getString("MIS_RENEW_ENERGY_INDV")));
				hshRecord.put("agri_anci_activity", Helper.correctNull((String)rs.getString("MIS_AGRI_ANCI_ACTIVITY")));
				hshRecord.put("agri_infra", Helper.correctNull((String)rs.getString("MIS_AGRI_INFRA")));
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getClassificationActivityMaster "+e.toString());
		}
		return hshRecord;
	}
	
	public void updateClassificationActivityMaster(HashMap hshValues) 
	{
		HashMap hshquery = new HashMap();
		HashMap hshqueryValues = new HashMap();
		ArrayList arrValues = new ArrayList();
		
		try
		{
			hshqueryValues.put("size", "1");
			hshquery.put("strQueryId", "ins_classi_activity_master");
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_social_infra_val")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_renew_energy_val")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_renew_energy_indv_val")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_agri_anci_acti_val")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_agri_infra_val")));
			hshquery.put("arrValues", arrValues);
			hshqueryValues.put("1", hshquery);
			EJBInvoker.executeStateLess("dataaccess", hshqueryValues, "updateData");
		}
		catch(Exception e)
		{
			throw new EJBException("Error in updateClassificationActivityMaster "+e.toString());
		}		
	}
	
	public HashMap getMISDetails(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		HashMap hshPriority=new HashMap();
		HashMap hshMOA=new HashMap();
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		ResultSet rs3=null;
		ResultSet rs4=null;
		String strAppNo="";
		String strAppId="";
		String strQuery="";
		String strQuery1="";
		String strQuery2="";
		String strCityCode="";
		String strStateCode="";
		String strDistCode="";
		String strDistrict="";
		String strCity="";
		String strState="";
		String strDataFlag="";
		String alliedquerycode="";
		String alliedquerycode1="";
		
		String strUserId="";
		String strMasterUserId="";
		String strAuthuser="",strReclassification="";
		
		double dblTotLim=0.00;
		double dblTotLimAgr=0.00;
		double dblTotLimSer=0.00;
		double dblTotSocialInfra=0.00;
		double dblTotAgriAnci=0.00;
		double dblTotRenewEnergy=0.00;
		double dblTotRenewEnergyIndv=0.00;
		double dblAgriInfra=0.00;
		String strAppStatus="";
		String strPriorityType="";
		String strPrioritySubsector="";
		String strWeakerSectionSubSector="";
		String strAgriIndConfig="";
		String strTwentyPointPgm="";
		String strSensitiveSector="";
		String strInfracode="";
		String strGovtAnnounceScheme="";
		String strClassiMaster_Sno="";
		String strActivityCode="";
		String strActivitySno="";
		HashMap hshQueryValues=new HashMap();
	 	HashMap hshQuery = new HashMap();
	 	ArrayList arrValues=new ArrayList();
	 	StringBuilder sbActionData=new StringBuilder();
	 	String strAppLoanType="";
		String strFacilitySno="";
		String strAppValuesin="";
		java.text.NumberFormat nf= java.text.NumberFormat.getNumberInstance();
		nf.setMaximumFractionDigits(2);
		nf.setGroupingUsed(false);
		String strValuesIn="";
		String strStandUpIndia="",appraisalsanc="";
        String alliedactivity_code="";
		try
		{
			
			strReclassification=Helper.correctNull((String)hshValues.get("strReclassify"));
			strFacilitySno=Helper.correctInt((String)hshValues.get("sel_facilitysno"));
			/*String striframe="";
			striframe=Helper.correctNull((String)hshValues.get("iframe"));
			if(striframe.equalsIgnoreCase("Y"))
			{
				updateMISDetails(hshValues);
			}*/
//			CommWorkflowBean comworkflow= new CommWorkflowBean();	
//			//comworkflow.getAction(hshValues);
//			hshQueryValues=comworkflow.getAction(hshValues);
			String strAction=null;
			strAction=Helper.correctNull((String)hshValues.get("strAction"));
			if(strAction.equals(""))strAction=Helper.correctNull((String)hshValues.get("hidAction"));
			hshRecord.put("strAction",strAction);
			MISLogger.UpdateLogger("getMISDetails Executing for ==========="+Helper.correctNull((String)hshValues.get("appno")));
			strUserId=Helper.correctNull((String)hshValues.get("strUserId"));
			//appraisalsanc=Helper.correctNull((String)hshValues.get("appraisalsanc"));
			if(rs !=null){rs.close();}
			strQuery=SQLParser.getSqlQuery("sel_masteruserid_mis");
			MISLogger.UpdateLogger(strQuery);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				strMasterUserId=Helper.correctNull((String)rs.getString("USER_ID"));
				if(strUserId.equalsIgnoreCase(strMasterUserId))
				{
					strAuthuser="Y";
				}
			}
			String strBankncgtcScheme="";
			strAppNo=Helper.correctNull((String)hshValues.get("appno"));
			strAppId=Helper.correctNull((String)hshValues.get("hidapplicantid"));
			String strAppNewId=Helper.correctInt((String)hshValues.get("hidapplicantnewid"));
			rs= DBUtils.executeQuery(SQLParser.getSqlQuery("sel_SvanidhiType^"+strAppNo+"^"+strFacilitySno));
			if(rs.next())
			{
				strBankncgtcScheme=Helper.correctNull(rs.getString("COM_BANKSCHEME"));
				hshRecord.put("strBankncgtcScheme",strBankncgtcScheme);
			} 
			
			if(strAppNewId.equalsIgnoreCase("0"))
			{
				strAppNewId = strAppId;
//				if(rs !=null){rs.close();}
//				strQuery=SQLParser.getSqlQuery("selrenewappid^"+strAppId);
//				rs=DBUtils.executeQuery(strQuery);
//				if(rs.next())
//				{
//					strAppNewId=Helper.correctInt((String)rs.getString("perapp_id"));
//				}
			}
			
			strAppLoanType=Helper.correctNull((String)hshValues.get("apploantype"));
			
			if(strAppNo.equalsIgnoreCase(""))
			{
				strAppNo=Helper.correctNull((String)hshValues.get("strappno"));
			}
			
			if(strAppLoanType.equalsIgnoreCase("P"))
			{
				strFacilitySno="1";
			}
			if(rs !=null){rs.close();}
			strQuery=SQLParser.getSqlQuery("getagrvaluesin^"+strAppNo);
			MISLogger.UpdateLogger(strQuery);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strAppValuesin=Helper.correctNull((String)rs.getString("app_valuesin"));
				strAppStatus=Helper.correctNull((String)rs.getString("app_status"));
			}
				
			//For Retail BankScheme
			if(strAppLoanType.equalsIgnoreCase("P"))
			{
				strQuery=SQLParser.getSqlQuery("sel_prdbankscheme^"+strAppNo);
				rs=DBUtils.executeQuery(strQuery);
				MISLogger.UpdateLogger(strQuery);
				if(rs.next())
				{
					hshRecord.put("strPrdType",Helper.correctNull((String)rs.getString("prd_type")));
					hshRecord.put("strLoanType",Helper.correctNull((String)rs.getString("prd_loantype")));
					hshRecord.put("strBankScheme",Helper.correctNull((String)rs.getString("prd_bankscheme")));
					hshRecord.put("strAgriSchemeFlag",Helper.correctNull(rs.getString("prd_whetheragri")));
				}
				if(rs!=null)
				{
					rs.close();
				}
				
			 
			
				strQuery=SQLParser.getSqlQuery("selLoanAmt^"+strAppNo);
				MISLogger.UpdateLogger(strQuery);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("strLoanAmt",Helper.correctDouble((String)rs.getString("loanamt")));
					hshRecord.put("strReqTerms",Helper.correctInt((String)rs.getString("LOAN_REQTERMS")));
					hshRecord.put("PRD_CGTMSE",Helper.correctInt((String)rs.getString("LOAN_CGTMSE_APPLICABLE")));
				}
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("securesel^"+strAppNo);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("strHOLIDAYPERIOD",Helper.correctInt((String)rs.getString("LOAN_NOOFINSTALLMENT")));
				}			
			}
			else
			{	//For Corporate BankScheme
				
				strQuery=SQLParser.getSqlQuery("sel_facility_bankscheme^"+strAppNo+"^"+strFacilitySno);
				MISLogger.UpdateLogger(strQuery);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("strBankScheme",Helper.correctNull((String)rs.getString("com_bankscheme")));
					hshRecord.put("CorpProductCode",Helper.correctNull((String)rs.getString("facility_code")));
					hshRecord.put("facilitytype",Helper.correctNull((String)rs.getString("com_factype")));	
					rs1= DBUtils.executeQuery(SQLParser.getSqlQuery("sel_SvanidhiType^"+strAppNo+"^"+strFacilitySno));
					if(rs1.next())
					{
						hshRecord.put("strSvanidhiType",Helper.correctNull(rs1.getString("SVANIDHITYPE")));	
					} 
					if(rs1!=null)
					{
						rs1.close();
					}
				}
				if(rs!=null)
				{
					rs.close();
				}
				
				strQuery=SQLParser.getSqlQuery("sel_proposedLimit^"+strAppNo+"^"+strFacilitySno);
				MISLogger.UpdateLogger(strQuery);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("strLoanAmt",Helper.correctDouble((String)rs.getString("facility_proposed")));
					hshRecord.put("strReqTerms",Helper.correctInt((String)rs.getString("facility_months")));
					hshRecord.put("PRD_CGTMSE",Helper.correctNull((String)rs.getString("FACILITY_WHT_CGTMSEAPPLY")));
					hshRecord.put("strHOLIDAYPERIOD",Helper.correctNull((String)rs.getString("FACILITY_HOLIDAYPERIOD")));
				}
				if(rs!=null)
				{
					rs.close();
				}
			}
			
			if(rs!=null)rs.close();
			rs = DBUtils.executeLAPSQuery("sel_facilitycodedesc_code^"+strAppNo);
			if(rs.next()){
				hshRecord.put("COM_HEADFAC",Helper.correctNull((String)rs.getString("COM_HEADFAC")));
				hshRecord.put("COM_SUBFAC",Helper.correctNull((String)rs.getString("COM_SUBFAC")));
				hshRecord.put("COM_BANKSCHEME",Helper.correctNull((String)rs.getString("COM_BANKSCHEME")));
			}
			
			strQuery=SQLParser.getSqlQuery("sel_misappdetails^"+strAppNo+"^"+strFacilitySno);
			MISLogger.UpdateLogger(strQuery);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("app_totlim",Helper.correctDouble((String)rs.getString("app_totlim")));
				hshRecord.put("app_totlimser",Helper.correctDouble((String)rs.getString("app_totlimser")));
				hshRecord.put("app_totlimagri",Helper.correctDouble((String)rs.getString("app_totlimagri")));
				hshRecord.put("app_whetherrestructure",Helper.correctNull((String)rs.getString("app_whetherrestructure")));
				hshRecord.put("app_whetherservice",Helper.correctNull((String)rs.getString("app_whetherservice")));
				hshRecord.put("app_resunder",Helper.correctNull((String)rs.getString("app_resunder")));
				hshRecord.put("app_settlementno",Helper.correctNull((String)rs.getString("app_settlementno")));
				hshRecord.put("app_settlementdate",Helper.correctNull((String)rs.getString("app_settlementdate")));
				hshRecord.put("app_oldfacid",Helper.correctNull((String)rs.getString("app_oldfacid")));
				hshRecord.put("app_resreason",Helper.correctNull((String)rs.getString("app_resreason")));
				strCityCode=Helper.correctNull((String)rs.getString("app_city"));
				strDistCode=Helper.correctNull((String)rs.getString("app_district"));
				strStateCode=Helper.correctNull((String)rs.getString("app_state"));
				hshRecord.put("app_city",strCityCode);
				hshRecord.put("app_district",strDistCode);
				hshRecord.put("app_state",strStateCode);
				hshRecord.put("app_place",Helper.correctNull((String)rs.getString("app_place")));
				hshRecord.put("app_repayment",Helper.correctNull((String)rs.getString("app_repayment")));
				hshRecord.put("app_sourceofrepay",Helper.correctNull((String)rs.getString("app_sourceofrepay")));
				hshRecord.put("app_guarantee",Helper.correctNull((String)rs.getString("app_guarantee")));
				hshRecord.put("app_guaranteeamt",Helper.correctDouble((String)rs.getString("app_guaranteeamt")));
				hshRecord.put("app_whethernewfac",Helper.correctNull((String)rs.getString("app_whethernewfac")));
				hshRecord.put("app_commencementdate",Helper.correctNull((String)rs.getString("app_commencementdate")));
				strActivityCode=Helper.correctNull((String)rs.getString("app_activitycode"));
				strActivitySno=Helper.correctNull((String)rs.getString("app_activitysno"));
				hshRecord.put("app_activitycode",strActivityCode);
				hshRecord.put("app_activitysno",strActivitySno);
				hshRecord.put("app_mainactivity",Helper.correctNull((String)rs.getString("app_mainactivity")));
				hshRecord.put("app_subactivity",Helper.correctNull((String)rs.getString("app_subactivity")));
				hshRecord.put("app_purpose",Helper.correctNull((String)rs.getString("app_purpose")));
				hshRecord.put("app_bsrcode",Helper.correctNull((String)rs.getString("app_bsrcode")));
				hshRecord.put("app_bsr1code",Helper.correctNull((String)rs.getString("app_bsr1code")));
				hshRecord.put("app_industrytype",Helper.correctNull((String)rs.getString("app_industrytype")));
				hshRecord.put("app_assetclassifcation",Helper.correctNull((String)rs.getString("app_assetclassifcation")));
				hshRecord.put("app_dispscreen",Helper.correctNull((String)rs.getString("app_dispscreen")));
				hshRecord.put("app_facility_sno",Helper.correctNull((String)rs.getString("app_facility_sno")));
				hshRecord.put("app_sharebroker",Helper.correctNull((String)rs.getString("app_sharebroker")));
				hshRecord.put("app_MISdataflag",Helper.correctNull((String)rs.getString("mis_appdata_flag")));
				hshRecord.put("alliedactivitycode",Helper.correctNull((String)rs.getString("APP_ALLIED_ACTIVITYCODE")));
				alliedactivity_code=Helper.correctNull((String)rs.getString("APP_ALLIED_ACTIVITYCODE"));
				if(!alliedactivity_code.equalsIgnoreCase(""))
				{
					if(rs1!=null)
					{
						rs1.close();
					}
					alliedquerycode=SQLParser.getSqlQuery("get_main_allied_sel_Activity^"+alliedactivity_code);	
					//MISLogger.UpdateLogger(alliedquerycode);
					rs1=DBUtils.executeQuery(alliedquerycode);
					if(rs1.next())
					{
					
						String alliedpurpose=Helper.correctNull((String)rs1.getString("act_purposecode"))+" - " + Helper.correctNull((String)rs1.getString("MIS_STATIC_DATA_DESC"));
						hshRecord.put("alliedpurpose",alliedpurpose);
						
						if(rs4!=null)
						{
							rs4.close();
						}
						String strMainActivityCode = Helper.correctNull((String)rs1.getString("act_mainactcode"));
						alliedquerycode1 = SQLParser.getSqlQuery("sel_misstaticdatadesc^"+"2"+"^"+strMainActivityCode);
						rs4= DBUtils.executeQuery(alliedquerycode1);
						if(rs4.next())
						{
							String alliedmaincode=strMainActivityCode+" - "+ Helper.correctNull((String)rs4.getString("mis_static_data_desc"));//15
							hshRecord.put("alliedmaincode",alliedmaincode);
						}
						if(rs4!=null)
						{
							rs4.close();
						}
						String strSubActivityCode = Helper.correctNull((String)rs1.getString("act_subactcode"));
						alliedquerycode1 = SQLParser.getSqlQuery("sel_MISSubActivityDesc^"+strMainActivityCode+"^"+strSubActivityCode);
						rs4= DBUtils.executeQuery(alliedquerycode1);
						if(rs4.next())
						{
							String alliedstrSubActivityCode=strSubActivityCode+" - "+ Helper.correctNull((String)rs4.getString("mis_subactdesc"));//16
							hshRecord.put("alliedstrSubActivityCode",alliedstrSubActivityCode);
						}
			
					}
					
				}
				
				
				if(!strCityCode.equalsIgnoreCase(""))
				{
					if(rs1!=null)
					{
						rs1.close();
					}
					strQuery1=SQLParser.getSqlQuery("selcitycode^"+strCityCode);
					MISLogger.UpdateLogger(strQuery1);
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						strCity=Helper.correctNull((String)rs1.getString("city_name"));
					}
				}
				if(!strDistCode.equalsIgnoreCase(""))
				{
					if(rs1!=null)
					{
						rs1.close();
					}
					strQuery1=SQLParser.getSqlQuery("sel_districtmaster^"+strDistCode);
					MISLogger.UpdateLogger(strQuery1);
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						strDistrict=Helper.correctNull((String)rs1.getString("district_desc"));
					}
				}
				if(!strStateCode.equalsIgnoreCase(""))
				{
					if(rs1!=null)
					{
						rs1.close();
					}
					strQuery1=SQLParser.getSqlQuery("sel_statenamebycode^"+strStateCode);
					MISLogger.UpdateLogger(strQuery1);
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						strState=Helper.correctNull((String)rs1.getString("state_name"));
					}
				}
				hshRecord.put("strCity", strCity);
				hshRecord.put("strState", strState);
				hshRecord.put("strDistrict", strDistrict);
				strDataFlag="Y";
			}
			else
			{
				
				if(Helper.correctNull((String)hshValues.get("strProductType")).equalsIgnoreCase("pG"))
				{
					strQuery=SQLParser.getSqlQuery("sel_customerdetail^"+strAppNewId);
					MISLogger.UpdateLogger(strQuery);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						if(Helper.correctNull(rs.getString("INDINFO_RESIDENT_STATUS")).equalsIgnoreCase("N"))
						{
							strCityCode=Helper.correctNull(rs.getString("CON_COMCITY"));
							strDistCode=Helper.correctNull(rs.getString("CON_COMDIST"));
							strStateCode=Helper.correctNull(rs.getString("CON_COMSTATE"));
						}
						else
						{
							strCityCode=Helper.correctNull(rs.getString("CON_PERMCITY"));
							strDistCode=Helper.correctNull(rs.getString("CON_PERMDIST"));
							strStateCode=Helper.correctNull(rs.getString("CON_PERMSTATE"));
						}
						hshRecord.put("app_city",strCityCode);
						hshRecord.put("app_district",strDistCode);
						hshRecord.put("app_state",strStateCode);
						
						if(!strCityCode.equalsIgnoreCase(""))
						{
							if(rs1!=null)
							{
								rs1.close();
							}
							strQuery1=SQLParser.getSqlQuery("selcitycode^"+strCityCode);
							MISLogger.UpdateLogger(strQuery1);
							rs1=DBUtils.executeQuery(strQuery1);
							if(rs1.next())
							{
								strCity=Helper.correctNull(rs1.getString("city_name"));
							}
						}
						if(!strDistCode.equalsIgnoreCase(""))
						{
							if(rs1!=null)
							{
								rs1.close();
							}
							strQuery1=SQLParser.getSqlQuery("sel_districtmaster^"+strDistCode);
							MISLogger.UpdateLogger(strQuery1);
							rs1=DBUtils.executeQuery(strQuery1);
							if(rs1.next())
							{
								strDistrict=Helper.correctNull(rs1.getString("district_desc"));
							}
						}
						if(!strStateCode.equalsIgnoreCase(""))
						{
							if(rs1!=null)
							{
								rs1.close();
							}
							strQuery1=SQLParser.getSqlQuery("sel_statenamebycode^"+strStateCode);
							MISLogger.UpdateLogger(strQuery1);
							rs1=DBUtils.executeQuery(strQuery1);
							if(rs1.next())
							{
								strState=Helper.correctNull(rs1.getString("state_name"));
							}
						}
						hshRecord.put("strCity", strCity);
						hshRecord.put("strState", strState);
						hshRecord.put("strDistrict", strDistrict);
					}
					
					hshRecord.put("app_repayment", "N");
					hshRecord.put("app_guarantee", "00");
				}
			}
			
			if(rs!=null)
			{
				rs.close();
			}
			
			
			strQuery=SQLParser.getSqlQuery("sel_misappdisplayscreen^"+strAppNo+"^"+strFacilitySno);
			MISLogger.UpdateLogger(strQuery);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("app_totland",Helper.correctNull((String)rs.getString("app_totland")));
				hshRecord.put("app_totirrigatedland",Helper.correctDouble((String)rs.getString("app_totirrigatedland")));
				hshRecord.put("app_totnonirrigatedland",Helper.correctDouble((String)rs.getString("app_totnonirrigatedland")));
				hshRecord.put("app_totcultivatedland",Helper.correctDouble((String)rs.getString("app_totcultivatedland")));
				hshRecord.put("app_totnoncultivatedland",Helper.correctDouble((String)rs.getString("app_totnoncultivatedland")));
				hshRecord.put("app_farmercategory",Helper.correctNull((String)rs.getString("app_farmercategory")));
				hshRecord.put("app_whethercropins",Helper.correctNull((String)rs.getString("app_whethercropins")));
				hshRecord.put("app_whetherkrishicard",Helper.correctNull((String)rs.getString("app_whetherkrishicard")));
				hshRecord.put("app_krishicardno",Helper.correctNull((String)rs.getString("app_krishicardno")));
				hshRecord.put("app_whetherpais",Helper.correctNull((String)rs.getString("app_whetherpais")));
				hshRecord.put("app_premiumamt",Helper.correctDouble((String)rs.getString("app_premiumamt")));
				hshRecord.put("app_nomineename",Helper.correctNull((String)rs.getString("app_nomineename")));
				hshRecord.put("app_nomineeage",Helper.correctInt((String)rs.getString("app_nomineeage")));
				hshRecord.put("app_nomineerelation",Helper.correctNull((String)rs.getString("app_nomineerelation")));
				hshRecord.put("app_claimdet",Helper.correctDouble((String)rs.getString("app_claimdet")));
				hshRecord.put("app_totfinancialoutlays",Helper.correctDouble((String)rs.getString("app_totfinancialoutlays")));
				hshRecord.put("app_individualgrp",Helper.correctNull((String)rs.getString("app_individualgrp")));
				hshRecord.put("app_margin",Helper.correctDouble((String)rs.getString("app_margin")));
				hshRecord.put("app_plantval",Helper.correctNull((String)rs.getString("app_plantval")));
				hshRecord.put("app_indname",Helper.correctNull((String)rs.getString("app_indname")));
				hshRecord.put("app_whetheraccdep",Helper.correctNull((String)rs.getString("app_whetheraccdep")));
				hshRecord.put("app_noofunits",Helper.correctInt((String)rs.getString("app_noofunits")));
				hshRecord.put("app_equipval",Helper.correctNull((String)rs.getString("app_equipval")));
				hshRecord.put("app_borrowerlending",Helper.correctDouble((String)rs.getString("app_borrowerlending")));
				hshRecord.put("APP_CRE_PERCNT",Helper.correctDouble((String)rs.getString("APP_CRE_PERCNT")));
				hshRecord.put("app_meritorious_status",Helper.correctNull((String)rs.getString("app_meritorious_status")));
				hshRecord.put("app_socialinfra",Helper.correctNull((String)rs.getString("APP_SOCIALINFRA")));
				hshRecord.put("app_agri_anci",Helper.correctNull((String)rs.getString("APP_AGRIANCIACTIVITY")));
				hshRecord.put("app_renewenergy",Helper.correctNull((String)rs.getString("APP_RENEWENERGY")));
				hshRecord.put("app_renewenergy_indv",Helper.correctNull((String)rs.getString("APP_RENEWENERGY_INDV")));
				hshRecord.put("app_agri_infra",Helper.correctNull((String)rs.getString("APP_AGRIINFRA")));
				hshRecord.put("msme_reclassif_verifiedon",Helper.correctNull((String)rs.getString("msme_reclassif_verifiedon")));
				hshRecord.put("msme_reclassif_date",Helper.correctNull((String)rs.getString("msme_reclassif_date")));
				hshRecord.put("APP_INVESTMENT_DATE",Helper.correctNull((String)rs.getString("APP_INVESTMENT_DATE")));
				hshRecord.put("APP_CRITERIA_INVESTMENT",Helper.correctNull((String)rs.getString("APP_CRITERIA_INVESTMENT")));
				
				hshRecord.put("APP_MINISTRY_INDUSTRY",Helper.correctNull((String)rs.getString("APP_MINISTRY_INDUSTRY")));
				hshRecord.put("APP_CARPET_AREA",Helper.correctNull((String)rs.getString("APP_CARPET_AREA")));
				hshRecord.put("APP_FLOOR_AREA",Helper.correctNull((String)rs.getString("APP_FLOOR_AREA")));
				hshRecord.put("APP_AREA_INDV_HOUSE",Helper.correctNull((String)rs.getString("APP_AREA_INDV_HOUSE")));
				hshRecord.put("APP_PROPOSED_LOAN_SHG",Helper.correctNull((String)rs.getString("APP_PROPOSED_LOAN_SHG")));
				hshRecord.put("APP_DWELLING_UNIT",Helper.correctNull((String)rs.getString("APP_DWELLING_UNIT")));
				
				strDataFlag="Y";
			}
			/*if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("sel_misappclassification^"+strAppNo);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("strAgriIndConfig",Helper.correctNull((String)rs.getString("app_agriculture")));
				hshRecord.put("strPriorityType",Helper.correctNull((String)rs.getString("app_sector")));
				hshRecord.put("strPrioritySubsector",Helper.correctNull((String)rs.getString("app_subsector")));
				hshRecord.put("strSensitiveSector",Helper.correctNull((String)rs.getString("app_sensitivesector")));
				hshRecord.put("strWeakerSectionSubSector",Helper.correctNull((String)rs.getString("app_weakersec")));
				hshRecord.put("strTwentyPointPgm",Helper.correctNull((String)rs.getString("app_twentypointpgm")));
				hshRecord.put("app_infrastrcode",Helper.correctNull((String)rs.getString("app_infrastrcode")));
				strDataFlag="Y";
			}*/
			hshRecord.put("strDataFlag",strDataFlag);
			hshRecord.put("strAppNo",strAppNo);
			
			if((strAppStatus.equalsIgnoreCase("op")||strAuthuser.equalsIgnoreCase("Y")||strReclassification.equalsIgnoreCase("Y")) && (Integer.parseInt(strFacilitySno)> 0))
			{
				hshQueryValues=new HashMap();
				hshQueryValues.put("size","1");
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_misappclassification");
				arrValues.add(strAppNo);
				arrValues.add(strFacilitySno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				MISLogger.UpdateLogger("Updated Data Values ==="+hshQueryValues);
				
				
				hshValues.put("strFacilitySno",strFacilitySno);
				hshValues.put("strLoanAmt",Helper.correctNull((String)hshRecord.get("strLoanAmt")));
				hshValues.put("strHOLIDAYPERIOD",Helper.correctNull((String)hshRecord.get("strHOLIDAYPERIOD")));
				hshValues.put("strReqTerms",Helper.correctNull((String)hshRecord.get("strReqTerms")));
				hshValues.put("strReclassification",strReclassification);
				hshValues.put("strReclassifDate",Helper.correctNull((String)hshValues.get("strClassifyBasedOn")));
				
				hshPriority=(HashMap)getMISAppClassification(hshValues);
				 strPriorityType=Helper.correctNull((String)hshPriority.get("prioritytype"));
				 strPrioritySubsector=Helper.correctNull((String)hshPriority.get("subsector"));
				 strWeakerSectionSubSector=Helper.correctNull((String)hshPriority.get("strWeakerSectionSubSector"));
				 strAgriIndConfig=Helper.correctNull((String)hshPriority.get("strAgriIndConfig"));
				 strTwentyPointPgm=Helper.correctNull((String)hshPriority.get("strTwentyPointPgm"));
				 strSensitiveSector=Helper.correctNull((String)hshPriority.get("strSensitiveSector"));
				 strInfracode=Helper.correctNull((String)hshPriority.get("strInfracode"));
				 strGovtAnnounceScheme=Helper.correctNull((String)hshPriority.get("strGovtAnnounceScheme"));
				 strClassiMaster_Sno=Helper.correctNull((String)hshPriority.get("strClassiMaster_Sno"));
				 strStandUpIndia=Helper.correctNull((String)hshPriority.get("strStandUpIndia"));
				 
				 	hshQueryValues=new HashMap();
					hshQueryValues.put("size","1");
					arrValues=new ArrayList();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId","ins_misappclassification");
					arrValues.add(strAppNo);
					arrValues.add(strAgriIndConfig);
					arrValues.add(strPriorityType);
					arrValues.add(strPrioritySubsector);
					arrValues.add(strSensitiveSector);
					arrValues.add(strWeakerSectionSubSector);
					arrValues.add(strTwentyPointPgm);
					arrValues.add(strInfracode);
					arrValues.add(strGovtAnnounceScheme);
					arrValues.add(strClassiMaster_Sno);
					arrValues.add(strFacilitySno);
					arrValues.add(strStandUpIndia);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					MISLogger.UpdateLogger("Updated Data Values ==="+hshQueryValues);
				
			}
			else
			{
				if(rs2!=null)
				{
					rs2.close();
				}
				strQuery=SQLParser.getSqlQuery("sel_mispagedetailscorp^"+strAppNo+"^"+strFacilitySno);
				MISLogger.UpdateLogger(strQuery);
				rs2=DBUtils.executeQuery(strQuery);
				if(rs2.next())
				{
					strPriorityType=Helper.correctNull((String)rs2.getString("app_sector"));
					strPrioritySubsector=Helper.correctNull((String)rs2.getString("app_subsector"));
					strWeakerSectionSubSector=Helper.correctNull((String)rs2.getString("app_weakersec"));
					strAgriIndConfig=Helper.correctNull((String)rs2.getString("app_agriculture"));
					strTwentyPointPgm=Helper.correctNull((String)rs2.getString("app_twentypointpgm"));
					strSensitiveSector=Helper.correctNull((String)rs2.getString("app_sensitivesector"));
					strInfracode=Helper.correctNull((String)rs2.getString("app_infrastrcode"));
					strGovtAnnounceScheme=Helper.correctNull((String)rs2.getString("APP_GOVTANNOUNCESCHEME"));
					strClassiMaster_Sno=Helper.correctNull((String)rs2.getString("APP_MISMASTER_SNO"));
					strStandUpIndia=Helper.correctNull((String)rs2.getString("APP_STANDUP_INDIA"));
				}
			}
			hshRecord.put("strEditFlag","N");
			//To select the post sanction parameters
//			String strTemp = "and PS_APP_SNO='"+strFacilitySno+"'";
			if(strAppLoanType.equalsIgnoreCase("P"))
			{
				hshRecord.put("strPostSancParam", Helper.correctNull((String)hshValues.get("strModifyterms")));
			}
			else
			{
				String strQueryPS = SQLParser.getSqlQuery("sel_postsanctiondet^"+strFacilitySno+"^"+strAppNo);
				MISLogger.UpdateLogger(strQueryPS);
				ResultSet rsPS = DBUtils.executeQuery(strQueryPS);
				if(rsPS.next())
				{
					hshRecord.put("strPostSancParam", Helper.correctNull(rsPS.getString("PS_MODIFY_TERMS")));
					hshRecord.put("strEditFlag","Y");
				}
			}
			
			hshRecord.put("strPriorityType", strPriorityType);
			hshRecord.put("strPrioritySubsector", strPrioritySubsector);
			hshRecord.put("strWeakerSectionSubSector", strWeakerSectionSubSector);
			hshRecord.put("strAgriIndConfig", strAgriIndConfig);
			hshRecord.put("strTwentyPointPgm", strTwentyPointPgm);
			hshRecord.put("strSensitiveSector", strSensitiveSector);
			hshRecord.put("strInfracode", strInfracode);
			hshRecord.put("strGovtAnnounceScheme", strGovtAnnounceScheme);
			hshRecord.put("strClassiMaster_Sno", strClassiMaster_Sno);
			hshRecord.put("strStandUpIndia", strStandUpIndia);
			hshMOA=new HashMap();
			hshMOA.put("strAppNo", strAppNo);
			hshMOA.put("strActivityCode", strActivityCode);
			hshMOA.put("strActivitySno", strActivitySno);
			hshMOA.put("strFacilitySno", strFacilitySno);
			hshMOA.put("strClassiMaster_Sno", strClassiMaster_Sno);
			
			hshRecord.put("strFacilitySno", strFacilitySno);
			
			
			if(strAppStatus.equalsIgnoreCase("op")||strAuthuser.equalsIgnoreCase("Y")||strReclassification.equalsIgnoreCase("Y"))
			{
				dblTotLim=getBorrowerTotalLimit(strAppNewId,strAppValuesin);
				dblTotLimAgr=getBorrowerTotalAgriLimit(strAppNewId,strAppValuesin,strAppNo);
				dblTotLimSer=getBorrowerTotalServiceLimit(strAppNewId,strAppValuesin,strAppNo);
				
				//Added by Guhan on 07/08/2015 for New priority sector parameters 
				dblTotSocialInfra = getClassiActivityMasterSum(strAppNewId,"MIS_SOCIAL_INFRA","");
				dblTotAgriAnci = getClassiActivityMasterSum(strAppNewId,"MIS_AGRI_ANCI_ACTIVITY","1");
				dblTotRenewEnergy = getClassiActivityMasterSum(strAppNewId,"MIS_RENEW_ENERGY","");
				dblTotRenewEnergyIndv = getClassiActivityMasterSum(strAppNewId,"MIS_RENEW_ENERGY_INDV","");
				dblAgriInfra = getClassiActivityMasterSum(strAppNewId,"MIS_AGRI_INFRA","2");
								
				hshRecord.put("app_socialinfra",nf.format(dblTotSocialInfra));
				hshRecord.put("app_agri_anci",nf.format(dblTotAgriAnci));
				hshRecord.put("app_renewenergy",nf.format(dblTotRenewEnergy));
				hshRecord.put("app_renewenergy_indv",nf.format(dblTotRenewEnergyIndv));
				hshRecord.put("app_agri_infra",nf.format(dblAgriInfra));

				hshRecord.put("app_totlim",nf.format(dblTotLim));
				hshRecord.put("app_totlimagri",nf.format(dblTotLimAgr));
				hshRecord.put("app_totlimser",nf.format(dblTotLimSer));
			
				hshQueryValues=new HashMap();
				hshQueryValues.put("size","1");
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","upd_agrservlimit");
				arrValues.add(String.valueOf(dblTotLimAgr));
				arrValues.add(String.valueOf(dblTotLimSer));
				arrValues.add(strAppNo);
				arrValues.add(strFacilitySno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				MISLogger.UpdateLogger("Updated Values===="+hshQueryValues);

				hshQueryValues=new HashMap();
				hshQueryValues.put("size","1");
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","upd_classiActivityList");
				arrValues.add(String.valueOf(dblTotSocialInfra));
				arrValues.add(String.valueOf(dblTotAgriAnci));
				arrValues.add(String.valueOf(dblTotRenewEnergy));
				arrValues.add(String.valueOf(dblTotRenewEnergyIndv));
				arrValues.add(String.valueOf(dblAgriInfra));
				arrValues.add(strAppNo);
				arrValues.add(strFacilitySno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				MISLogger.UpdateLogger("Updated Values===="+hshQueryValues);
			
				if(rs2!=null)
				{
					rs2.close();
				}
				String strQueryAgr="";
				strQueryAgr=SQLParser.getSqlQuery("sel_landholdingMIS^"+strAppNewId);
				MISLogger.UpdateLogger(strQueryAgr);
				rs2=DBUtils.executeQuery(strQueryAgr);
				if(rs2.next())
				{
					hshRecord.put("land_acreage",Helper.correctNull((String)rs2.getString("land_acreage")));
					hshRecord.put("app_totirrigatedland",Helper.correctDouble((String)rs2.getString("land_irrigsize")));
					hshRecord.put("app_totnonirrigatedland",Helper.correctDouble((String)rs2.getString("land_nonirriga")));
					hshRecord.put("app_totcultivatedland",Helper.correctDouble((String)rs2.getString("land_cultivatable")));
					hshRecord.put("app_totnoncultivatedland",Helper.correctDouble((String)rs2.getString("land_noncultivatable")));
					hshRecord.put("land_farmercategory",Helper.correctNull((String)rs2.getString("land_farmercategory")));
				}
			}
			
			hshRecord.put("AuthUser", strAuthuser);
			updateLBRAndModeOfAdvData(hshMOA);
			
			if(rs!=null)
			{
				rs.close();
			}
			if(!strAppNewId.equalsIgnoreCase(""))
			{
				rs=DBUtils.executeLAPSQuery("sel_common_customer^"+strAppNewId);				 
				if(rs.next())
				{
					hshRecord.put("majority_member",Helper.correctNull(rs.getString("COMINFO_MAJORITYMEMBER")));
					hshRecord.put("stake_held",Helper.correctNull(rs.getString("perapp_stakeheld_women")));
					hshRecord.put("constitutionnew",Helper.correctNull((String)rs.getString("perapp_constitutionnew")));
					hshRecord.put("indinfo_caste",Helper.correctNull((String)rs.getString("indinfo_caste")));
					hshRecord.put("perapp_sex",Helper.correctNull((String)rs.getString("perapp_sex")));
					hshRecord.put("strempasondate",Helper.correctNull((String)rs.getString("cominfo_employees_asondate")));
					hshRecord.put("strtotalemp",Helper.correctNull((String)rs.getString("cominfo_total_employees")));
					hshRecord.put("COMINFO_GSTINREG",Helper.correctNull((String)rs.getString("COMINFO_GSTINREG")));
					hshRecord.put("COMINFO_GST_EXEMPTED",Helper.correctNull((String)rs.getString("COMINFO_GST_EXEMPTED")));
					hshRecord.put("indinfo_minority",Helper.correctNull((String)rs.getString("indinfo_minority")));
					hshRecord.put("PERAPP_UDYAM_REGNO",Helper.correctNull((String)rs.getString("PERAPP_UDYAM_REGNO")));
					hshRecord.put("PERAPP_SALES_TURNOVER",Helper.correctNull((String)rs.getString("PERAPP_SALES_TURNOVER")));
					hshRecord.put("PERAPP_SALES_TURNOVER_DATE",Helper.correctNull((String)rs.getString("PERAPP_SALES_TURNOVER_DATE")));
					hshRecord.put("PERAPP_CRITERIA_SALES_TURNOVER",Helper.correctNull((String)rs.getString("PERAPP_CRITERIA_SALES_TURNOVER")));
					hshRecord.put("cominfo_minority_community",Helper.correctNull((String)rs.getString("cominfo_minority_community")));
					hshRecord.put("indinfo_religion",Helper.correctNull((String)rs.getString("indinfo_religion")));
					hshRecord.put("perapp_religion",Helper.correctNull((String)rs.getString("perapp_religion")));


					
				}
			}

			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("sel_customerdetail^"+strAppNewId);
			MISLogger.UpdateLogger(strQuery);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				if(Helper.correctNull(rs.getString("INDINFO_RESIDENT_STATUS")).equalsIgnoreCase("N"))
				{
					strCityCode=Helper.correctNull(rs.getString("CON_COMCITY"));
					strDistCode=Helper.correctNull(rs.getString("CON_COMDIST"));
					strStateCode=Helper.correctNull(rs.getString("CON_COMSTATE"));
				}
				else
				{
					strCityCode=Helper.correctNull(rs.getString("CON_PERMCITY"));
					strDistCode=Helper.correctNull(rs.getString("CON_PERMDIST"));
					strStateCode=Helper.correctNull(rs.getString("CON_PERMSTATE"));
				}
				hshRecord.put("app_city",strCityCode);
				hshRecord.put("app_district",strDistCode);
				hshRecord.put("app_stateminority",strStateCode);
			}
			
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("sel_minorityconstitutionchk^"+strAppNewId);
			MISLogger.UpdateLogger(strQuery);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("StartupConstitution","Y");

			}
			/***
			 * For Audit Trial New Data MIS Classification - By Karthikeyan.S on 23/09/2013
			 */
			MastApplicantBean MAB=new MastApplicantBean();
			String strCatTypeDesc=MAB.getMasterDesc("MISMast", "12", strAgriIndConfig);
			String strSectorDesc="";
			if(strPriorityType.equalsIgnoreCase("01"))
			{
				strSectorDesc="Priority Sector";
			}
			else if(strPriorityType.equalsIgnoreCase("02"))
			{
				strSectorDesc="Non Priority Sector";
			}
			String strSubSectorDesc=MAB.getMasterDesc("MISMast","7",strPrioritySubsector);
			if(strSubSectorDesc.equalsIgnoreCase(""))
			{
				strSubSectorDesc=MAB.getMasterDesc("MISMast","8",strPrioritySubsector);
			}
			String strSensitiveSectorDesc=MAB.getMasterDesc("MISMast","11",strSensitiveSector);
			String strWeakerSectionDesc=MAB.getMasterDesc("MISMast","09",strWeakerSectionSubSector);
			String strTwentyPointPgmDesc=MAB.getMasterDesc("MISMast","10",strTwentyPointPgm);
			String strInfracodeDesc=MAB.getMasterDesc("MISMast","22",strInfracode);
			String strGovtAnnounceSchemeDesc=MAB.getMasterDesc("MISMast","23",strGovtAnnounceScheme);
			strQuery2=SQLParser.getSqlQuery("sel_MISClassAuditNew^232^"+strAppNo+"^232^"+strAppNo);
			MISLogger.UpdateLogger(strQuery2);
			rs3=DBUtils.executeQuery(strQuery2);
			if(rs3.next())
			{
				sbActionData.append(Helper.CLOBToString(rs3.getClob("action_newdata")));
				if(!(sbActionData.toString()).contains("Agriculture/Industry/Service Category type"))
				{
					if(strStandUpIndia.equalsIgnoreCase("Y"))
						strStandUpIndia="Yes";
					else if(strStandUpIndia.equalsIgnoreCase("N"))
						strStandUpIndia="No";
					else
						strStandUpIndia="Select";
					sbActionData.append("~Agriculture/Industry/Service Category type = ").append(strCatTypeDesc)
					.append("~Sector = ").append(strSectorDesc)
					.append("~Sub Sector = ").append(strSubSectorDesc)
					.append("~Sensitive sector = ").append(strSensitiveSectorDesc)
					.append("~Weaker Section = ").append(strWeakerSectionDesc)
					.append("~Twenty Point Program = ").append(strTwentyPointPgmDesc)
					.append("~Infrastructure Credit Type = ").append(strInfracodeDesc)
					.append("~Government announced scheme = ").append(strGovtAnnounceSchemeDesc)
					.append("~Standup India = ").append(strStandUpIndia)
					.append("~Total Limit of the Borrower=").append(nf.format(dblTotLim))
					.append("~Total Limit of the Borrower(Under Service Category)=").append(nf.format(dblTotLimSer))
					.append("~Total Limit of the Borrower(Under Agriculture Category)=").append(nf.format(dblTotLimAgr))
					.append("~Loan/s value for Agriculture Infrastructure)=").append(nf.format(dblAgriInfra));
					hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "upd_MISClassAuditNew");
					if(strAction.equalsIgnoreCase("delete")){
						arrValues.add("");
					}else{
					arrValues.add(sbActionData.toString());
					}
					arrValues.add("232");
					arrValues.add(strAppNo);
					arrValues.add("232");
					arrValues.add(strAppNo);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					MISLogger.UpdateLogger("Audit Table Values==="+hshQueryValues);
				}
			}
			rs3	= DBUtils.executeLAPSQuery("selorgno^"+strAppNo);
			if(rs3.next())
			{
				strValuesIn	= correctNull(rs3.getString("app_valuesin"));
			}
			
			if(strValuesIn.equals("C")){strValuesIn			= "Crore";}
			else if(strValuesIn.equals("L")){strValuesIn	= "Lacs";}
			else if(strValuesIn.equals("R")){strValuesIn	= "Rupees";}
			else if(strValuesIn.equals("A")){strValuesIn	= "";}
			hshRecord.put("strValuesIn", strValuesIn);
			if(rs3!=null){rs3.close();}
			rs3	= DBUtils.executeLAPSQuery("selAppSectorCount^"+strAppNo);
			if(rs3.next())
			{
				hshRecord.put("strAppSectorCount", correctNull(rs3.getString("sectorcount")));
			}
			if(rs3!=null){rs3.close();}
			if(rs2!=null){rs2.close();}
			strQuery=SQLParser.getSqlQuery("sel_minority_validation^"+strAppNewId);
			rs2=DBUtils.executeQuery(strQuery);
			if(rs2.next()){
				hshRecord.put("CON_COMSTATE",Helper.correctNull(rs2.getString("CON_COMSTATE")));
				hshRecord.put("PERAPP_RELIGION",Helper.correctNull(rs2.getString("PERAPP_RELIGION")));
				hshRecord.put("INDINFO_MINORITY",Helper.correctNull(rs2.getString("INDINFO_MINORITY")));

			}
			if(rs2!=null){rs2.close();}
			/***
			 * End - Audit Trial New Data MIS Classification
			 */
			
			
			
			//for checking freeze count
		   	int strFreezecount=0;
		   	String stractcodecgtmse="";
		   	String strFreezeflag="N";
		   	strQuery = SQLParser.getSqlQuery("sel_freezecount^" + strAppNo);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{	
				strFreezecount=Integer.parseInt(Helper.correctInt(rs.getString("freezecount")));
				if(strFreezecount!=0 )
				{
					strFreezeflag="Y";
				}
			}
			strQuery = SQLParser.getSqlQuery("sel_activity_CGTMSE^" +Helper.correctNull((String)hshValues.get("txt_ActivityCode")));
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{	
				stractcodecgtmse=Helper.correctNull((rs.getString("ACT_CGTMSE")));
				
			}
			if(rs!=null)
				rs.close();
			hshRecord.put("strFreezeflag",strFreezeflag);
			hshRecord.put("stractcodecgtmse",stractcodecgtmse);
			hshRecord.put("hshQueryValues11",hshQueryValues);
			
			rs=DBUtils.executeLAPSQuery("sel_date^"+strAppNo);
			if(rs.next())
			{
				hshRecord.put("strMisFlag","Y");
			}else{
				hshRecord.put("strMisFlag","N");
			}
			if(rs!=null)
				rs.close();
			
			rs=DBUtils.executeLAPSQuery("commworkflowsel2^"+strAppNo);
			if(rs.next())
			{
				hshRecord.put("APP_LOANSUBTYPE_DIGI",Helper.correctNull(rs.getString("APP_LOANSUBTYPE_DIGI")));
			}
			if(rs!=null)
				rs.close();
			if(strAppLoanType.equalsIgnoreCase("P"))
			{
				rs=DBUtils.executeLAPSQuery("sel_misshgdetcorp^"+strAppNo+"^"+"1");
				if(rs.next())
				{
					hshRecord.put("purposeofloan",Helper.correctNull(rs.getString("purposeofloan")));
	
				}
			}else{
				rs=DBUtils.executeLAPSQuery("sel_misshgdetcorp^"+strAppNo+"^"+strFacilitySno);
				if(rs.next())
				{
					hshRecord.put("purposeofloan",Helper.correctNull(rs.getString("purposeofloan")));

				}
			}
			if(rs!=null)
				rs.close();
			if(rs1!=null)
				rs1.close();
			double extBuild=0.00,dbltotalextbuild=0.00,extBuild1=0.00;
			String strbuildmeas="";
			if(strAppLoanType.equalsIgnoreCase("P"))
			{

				strQuery = SQLParser.getSqlQuery("sel_carpet_ret^" + strAppNo);
				rs1 = DBUtils.executeQuery(strQuery);
				while (rs1.next()) {

					rs = DBUtils.executeLAPSQuery("sel_carpet_retdetails^"
							+ strAppNo
							+ "^"
							+ Helper.correctNull((String) rs1
									.getString("APP_SEC_SECID")));
					if (rs.next()) {
						extBuild = Double.parseDouble(Helper
								.correctDouble((String) rs
										.getString("SEC_EXTENTOFBUILDING")));
						strbuildmeas = Helper.correctNull((String) rs
								.getString("sec_extofbuildmeas"));
						if (extBuild != 0) {
							if (strbuildmeas.equalsIgnoreCase("1"))
								extBuild1 = (extBuild * 4046.86);
							else if (strbuildmeas.equalsIgnoreCase("2"))
								extBuild1 = (extBuild * 10000);
							else if (strbuildmeas.equalsIgnoreCase("3"))
								extBuild1 = (extBuild * 0.092903);
							else if (strbuildmeas.equalsIgnoreCase("4"))
								extBuild1 = extBuild;
							else if (strbuildmeas.equalsIgnoreCase("05"))
								extBuild1 = extBuild * 0.836127;
							else if (strbuildmeas.equalsIgnoreCase("06"))
								extBuild1 = extBuild * 101.1714105;
							else if (strbuildmeas.equalsIgnoreCase("7"))
								extBuild1 = extBuild * 40.468564224;
							else if (strbuildmeas.equalsIgnoreCase("8"))
								extBuild1 = extBuild * 25.2929;
						}
						dbltotalextbuild += extBuild1;
					}

				}
			} else {
				strQuery = SQLParser.getSqlQuery("sel_carpet_corp^" + strAppNo);
				rs1 = DBUtils.executeQuery(strQuery);
				while (rs1.next()) {

					rs = DBUtils.executeLAPSQuery("sel_carpet_corpdetails^"
							+ strAppNo
							+ "^"
							+ Helper.correctNull((String) rs1
									.getString("APP_SEC_SECID")));
					if (rs.next()) {
						extBuild = Double.parseDouble(Helper
								.correctDouble((String) rs
										.getString("SEC_EXTENTOFBUILDING")));
						strbuildmeas = Helper.correctNull((String) rs
								.getString("sec_extofbuildmeas"));
						if (extBuild != 0) {
							if (strbuildmeas.equalsIgnoreCase("1"))
								extBuild1 = (extBuild * 4046.86);
							else if (strbuildmeas.equalsIgnoreCase("2"))
								extBuild1 = (extBuild * 10000);
							else if (strbuildmeas.equalsIgnoreCase("3"))
								extBuild1 = (extBuild * 0.092903);
							else if (strbuildmeas.equalsIgnoreCase("4"))
								extBuild1 = extBuild;
							else if (strbuildmeas.equalsIgnoreCase("05"))
								extBuild1 = extBuild * 0.836127;
							else if (strbuildmeas.equalsIgnoreCase("06"))
								extBuild1 = extBuild * 101.1714105;
							else if (strbuildmeas.equalsIgnoreCase("7"))
								extBuild1 = extBuild * 40.468564224;
							else if (strbuildmeas.equalsIgnoreCase("8"))
								extBuild1 = extBuild * 25.2929;
						}
						dbltotalextbuild += extBuild1;
					}

				}
			}
		
			hshRecord.put("dbltotalextbuild",String.valueOf(dbltotalextbuild));
			/*String strBankScheme="";
			String strSvanidhiType="";
			String strProposedAmt="";
			rs= DBUtils.executeQuery(SQLParser.getSqlQuery("sel_SvanidhiType^"+strAppNo+"^"+strFacilitySno));
			if(rs.next())
			{
				strBankScheme=Helper.correctNull(rs.getString("COM_BANKSCHEME"));
				strSvanidhiType=Helper.correctNull(rs.getString("SVANIDHITYPE"));
			} 
			hshRecord.put("strBankScheme",strBankScheme);
			
			hshRecord.put("strSvanidhiType",strSvanidhiType);*/
			if(rs!=null)
				rs.close();
			String ind_religion="",ind_minority="",nonind_religion="",nonind_minority="";
			rs=DBUtils.executeLAPSQuery("sel_weakersection_det^"+strAppNo+"^"+strFacilitySno);
			if(rs.next())
			{
				nonind_minority=Helper.correctNull((String)rs.getString("MIS_NONIND_MINORITY_COMMUNITY"));
				ind_religion=Helper.correctNull((String)rs.getString("MIS_IND_RELIGION"));
				nonind_religion=Helper.correctNull((String)rs.getString("MIS_NONIND_RELIGION"));
				ind_minority=Helper.correctNull((String)rs.getString("MIS_IND_MINORITY"));	
			}
			if(rs!=null)
				rs.close();
			
			rs=DBUtils.executeLAPSQuery("sel_salesdet^"+strAppNo+"^"+strFacilitySno);
			if(rs.next())
			{
				if(!("").equalsIgnoreCase(Helper.correctNull(rs.getString("MSME_RECLASSIF_DATE"))) &&
						!("").equalsIgnoreCase(Helper.correctNull(rs.getString("MSME_RECLASSIF_VERIFIEDON"))) )
				{
				hshRecord.put("PERAPP_SALES_TURNOVER",Helper.correctNull(rs.getString("APP_SALETURNOVER")));
				hshRecord.put("PERAPP_SALES_TURNOVER_DATE",Helper.correctNull(rs.getString("APP_SALESTURNOVER_DATE")));
				hshRecord.put("PERAPP_CRITERIA_SALES_TURNOVER",Helper.correctNull(rs.getString("APP_CRITERIA_SALESTURNOVER")));
				hshRecord.put("cominfo_minority_community",nonind_minority);
				hshRecord.put("indinfo_religion",ind_religion);
				hshRecord.put("perapp_religion",nonind_religion);
				hshRecord.put("indinfo_minority",ind_minority);
				}	 
			}
			if(rs!=null)
				rs.close();
			
			rs=DBUtils.executeLAPSQuery("sel_misappdis_plantval^"+strAppNo);
			if(rs.next())
			{
				hshRecord.put("strPlant_val",Helper.correctNull(rs.getString("app_plantval")));	
			}
			hshRecord.put("strFacilitySno", strFacilitySno);
			
			String chklad=Helper.correctNull((String)hshValues.get("sessionModuleType"));
			String prdcode=Helper.correctNull((String)hshValues.get("prdcode"));
			
			
			if(chklad.equals("LAD"))
			{
			if(rs!=null)
				rs.close();
			
			rs=DBUtils.executeLAPSQuery("chkagrigoldproduct^"+prdcode);
			if(rs.next())
			{
				hshRecord.put("agrigoldproduct","Y");	
			}
			}

		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getMISDetails "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
				if(rs1 != null)
				{
					rs1.close();
				}
				if(rs2 != null)
				{
					rs2.close();
				}
				if(rs3 != null)
				{
					rs3.close();
				}
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}
	/**
	 * @author:Karthikeyan.S
	 * @date:August 07, 2013-02:04:45 PM
	 * @category MIS Details update method
	 * @return
	 */
	public void updateMISDetails(HashMap hshValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAppNo="";
		String strAction="";
		String strActivityCode="";
		String strActivitySno="";
		StringBuilder sbActionData=new StringBuilder();
		StringBuilder sbOldAudit=new StringBuilder();
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs4=null;
		String strQuery="";
		String strQuery1="";
		String strApploantype="";
		String strFacilitySno="",strLoanCostofprojectOldAudit="",strCostoftheProject="";
		try
		{
			String strAuthuser="",strUserId=Helper.correctNull((String)hshValues.get("strUserId"));
			strAppNo=Helper.correctNull((String)hshValues.get("strappno"));
			String strconstitution=Helper.correctNull((String)hshValues.get("hidconstitution"));

			if(strAppNo.equalsIgnoreCase(""))
			{
				strAppNo=Helper.correctNull((String)hshValues.get("hidapplno"));
			}
			
			strAction=Helper.correctNull((String)hshValues.get("hidAction"));
			strActivityCode=Helper.correctNull((String)hshValues.get("txt_ActivityCode"));
			strActivitySno=Helper.correctNull((String)hshValues.get("hidSlNo"));
			
			strApploantype=Helper.correctNull((String)hshValues.get("apploantype"));
			strFacilitySno=Helper.correctInt((String)hshValues.get("sel_facilitysno"));
			
			if(strFacilitySno.equalsIgnoreCase(""))
				strFacilitySno=Helper.correctInt((String)hshValues.get("hidFacSno"));
			String strtotserviceborrwer=Helper.correctNull((String)hshValues.get(" app_totlimser"));
			String strtotagriborrower=Helper.correctNull((String)hshValues.get("app_totlimagri"));
			MastApplicantBean MAB=new MastApplicantBean();
			/***
			 * For Audit Trial Old Data - By Karthikeyan.S on 19/09/2013
			 */
			String strDisplayScreenOldAudit="";
			String strLoanTenureOldAudit="";
			strQuery1=SQLParser.getSqlQuery("sel_misappdetails^"+strAppNo+"^"+strFacilitySno);
			MISLogger.UpdateLogger(strQuery1);
			rs1=DBUtils.executeQuery(strQuery1);
			if(rs1.next())
			{
				String strBankSchemeOldAudit="";
				String strLoanTypeOldAudit="",strLoanAmtOldAudit="";
				
				if(strApploantype.equalsIgnoreCase("P"))
				{
					strQuery=SQLParser.getSqlQuery("sel_prdbankscheme^"+strAppNo);
					MISLogger.UpdateLogger(strQuery);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strLoanTypeOldAudit=Helper.correctNull((String)rs.getString("prd_loantype"));
						strBankSchemeOldAudit=Helper.correctNull((String)rs.getString("prd_bankscheme"));
					}
					if(rs!=null)
						rs.close();
					strQuery=SQLParser.getSqlQuery("selLoanAmt^"+strAppNo);
					MISLogger.UpdateLogger(strQuery);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strLoanAmtOldAudit=Helper.correctDouble((String)rs.getString("loanamt")); // Loan Amount
						strLoanTenureOldAudit=Helper.correctInt((String)rs.getString("loan_terms")); // Loan Tenure
						strLoanCostofprojectOldAudit=Helper.correctDouble((String)rs.getString("cloanprd"));
					}
				}
				else
				{
					strQuery=SQLParser.getSqlQuery("sel_chck_lst_doc^"+strAppNo+"^"+strFacilitySno);
					MISLogger.UpdateLogger(strQuery);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strLoanTypeOldAudit=Helper.correctNull((String)rs.getString("com_facility_loantype"));
						strBankSchemeOldAudit=Helper.correctNull((String)rs.getString("COM_BANKSCHEME"));
						strLoanAmtOldAudit=Helper.correctNull((String)rs.getString("FACILITY_SANCAMT"));
						strLoanTenureOldAudit=Helper.correctNull((String)rs.getString("FACILITY_TENOR"));
					}
				}
				String strBankSchemeDescOldAudit=MAB.getMasterDesc("MISMast", "1", strBankSchemeOldAudit); // Bank's Scheme
				if(rs!=null)
				{
					rs.close();
				}
				String strPurposeDescOldAudit="";
				String strBSRDescOldAudit="";
				
				if(rs!=null)
				{
					rs.close();
				}
				String[] strPurposeCodeSlNoOldAudit=null;
				String strPurposeCodeOldAudit="";
				String strSlNoOldAudit="";
				String strPurposeOldAudit=Helper.correctNull((String)rs1.getString("app_purpose"));
				if(!strPurposeOldAudit.equalsIgnoreCase(""))
				{
					strPurposeCodeSlNoOldAudit=strPurposeOldAudit.split("_");
					strPurposeCodeOldAudit=strPurposeCodeSlNoOldAudit[0];
					strSlNoOldAudit=strPurposeCodeSlNoOldAudit[1];
				}
				
				strQuery=SQLParser.getSqlQuery("sel_PurposeDesc^3^"+strPurposeCodeOldAudit+"^"+strSlNoOldAudit);
				MISLogger.UpdateLogger(strQuery);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strPurposeDescOldAudit=Helper.correctInt((String)rs.getString("mis_static_data_desc")); // Purpose
				}
				if(rs!=null)
				{
					rs.close();
				}
				String strBSRCodeOldAudit=Helper.correctNull((String)rs1.getString("app_bsrcode"));
				
				strQuery=SQLParser.getSqlQuery("sel_BSRDesc^"+strBSRCodeOldAudit);
				MISLogger.UpdateLogger(strQuery);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strBSRDescOldAudit=Helper.correctNull((String)rs.getString("ind_name")); // BSR Code
				}
				if(rs!=null)
				{
					rs.close();
				}
					
				
				String strRestructuredUnderOldAudit=Helper.correctNull((String)rs1.getString("app_resunder"));
				String strPlaceOldAudit=Helper.correctNull((String)rs1.getString("app_place"));
				String strSourceOfRepayOldAudit=Helper.correctNull((String)rs1.getString("app_sourceofrepay"));
				String strGuarCoveredOldAudit=Helper.correctNull((String)rs1.getString("app_guarantee"));
				String strMainActOldAudit=Helper.correctNull((String)rs1.getString("app_mainactivity"));
				String strBSR1CodeOldAudit=Helper.correctNull((String)rs1.getString("app_bsr1code"));
				String strIndTypeOldAudit=Helper.correctNull((String)rs1.getString("app_industrytype"));
				String strAssetClassificationOldAudit=Helper.correctNull((String)rs1.getString("app_assetclassifcation"));
				
	
				String strRestructuredUnderDescOldAudit=MAB.getMasterDesc("MISMast", "14", strRestructuredUnderOldAudit);
				String strPlaceDescOldAudit=MAB.getMasterDesc("StatMast", "128", strPlaceOldAudit);
				String strSourceOfRepayDescOldAudit=MAB.getMasterDesc("MISMast", "15", strSourceOfRepayOldAudit);
				String strGuarCoveredDescOldAudit=MAB.getMasterDesc("MISMast", "17", strGuarCoveredOldAudit);
				String strMainActDescOldAudit=MAB.getMasterDesc("MISMast", "2", strMainActOldAudit);
				String strBSR1DescOldAudit=MAB.getMasterDesc("MISMast", "6", strBSR1CodeOldAudit);
				String strIndTypeDescOldAudit=MAB.getMasterDesc("MISMast", "5", strIndTypeOldAudit);
				String strAssetClassificationDescOldAudit=MAB.getMasterDesc("MISMast", "16", strAssetClassificationOldAudit);
				
				/* Sub Sector */
				String strSubActivityCodeOldAudit=Helper.correctNull((String)rs1.getString("app_subactivity"));
				String strSubActivityDescOldAudit="";
				strQuery=SQLParser.getSqlQuery("sel_MISSubActivityDesc^"+strMainActOldAudit+"^"+strSubActivityCodeOldAudit);
				MISLogger.UpdateLogger(strQuery);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strSubActivityDescOldAudit=Helper.correctNull((String)rs.getString("mis_subactdesc"));
				}
				if(rs!=null)
				{
					rs.close();
				}
				
				/* Restructured Under */
				String strRestructureOldAudit=Helper.correctNull((String)rs1.getString("app_whetherrestructure"));
				String strRestructureDescOldAudit="";
				if(strRestructureOldAudit.equalsIgnoreCase("Y"))
				{
					strRestructureDescOldAudit="Yes";
				}
				else if(strRestructureOldAudit.equalsIgnoreCase("N"))
				{
					strRestructureDescOldAudit="No";
				}
	
				/* Whether under Service Area Approach */
				String strServiceAreaOldAudit=Helper.correctNull((String)rs1.getString("app_whetherservice"));
				String strServiceAreaDescOldAudit="";
				if(strServiceAreaOldAudit.equalsIgnoreCase("Y"))
				{
					strServiceAreaDescOldAudit="Yes";
				}
				else if(strServiceAreaOldAudit.equalsIgnoreCase("N"))
				{
					strServiceAreaDescOldAudit="No";
				}
	
				/* Does repayment depend purely on the asset financed */
				String strAssetFinancedOldAudit=Helper.correctNull((String)rs1.getString("app_repayment"));
				String strAssetFinancedDescOldAudit="";
				if(strAssetFinancedOldAudit.equalsIgnoreCase("Y"))
				{
					strAssetFinancedDescOldAudit="Yes";
				}
				else if(strAssetFinancedOldAudit.equalsIgnoreCase("N"))
				{
					strAssetFinancedDescOldAudit="No";
				}
	
				/* Whether the proposed facility is for New Project */
				String strNewProjectFacOldAudit=Helper.correctNull((String)rs1.getString("app_whethernewfac"));
				String strNewProjectFacDescOldAudit="";
				if(strNewProjectFacOldAudit.equalsIgnoreCase("Y"))
				{
					strNewProjectFacDescOldAudit="Yes";
				}
				else if(strNewProjectFacOldAudit.equalsIgnoreCase("N"))
				{
					strNewProjectFacDescOldAudit="No";
				}
				String strCity=Helper.correctNull((String)rs1.getString("app_city"));
				String strDistrict=Helper.correctNull((String)rs1.getString("app_district"));
				String strState=Helper.correctNull((String)rs1.getString("app_state"));
				String strCityDesc=MAB.getCityDistrictStateDesc("city", strCity);
				String strDistrictDesc=MAB.getCityDistrictStateDesc("district", strDistrict);
				String strStateDesc=MAB.getCityDistrictStateDesc("state", strState);
				strDisplayScreenOldAudit=Helper.correctNull((String)rs1.getString("app_dispscreen"));
				
				sbOldAudit.append("~Bank's Scheme=").append(strBankSchemeDescOldAudit)
					.append("~Loan Amount=").append(strLoanAmtOldAudit)
					.append("~Total Limit of the Borrower=").append(Helper.correctDouble((String)rs1.getString("app_totlim")))
					.append("~Total Limit of the Borrower(Under Service Category)=").append(Helper.correctDouble((String)rs1.getString("app_totlimser")))
					.append("~Total Limit of the Borrower(Under Agriculture Category)=").append(Helper.correctDouble((String)rs1.getString("app_totlimagri")))
					.append("~Whether this facility is by restructuring of any existing accounts=").append(strRestructureDescOldAudit)
					.append("~Whether under Service Area Approach=").append(strServiceAreaDescOldAudit);
				if(strRestructureOldAudit.equalsIgnoreCase("Y"))
				{
					sbOldAudit.append("~Restructured Under=").append(strRestructuredUnderDescOldAudit)
					.append("~Settlement Ref. No=").append(Helper.correctNull((String)rs1.getString("app_settlementno")))
					.append("~Settlement Date=").append(Helper.correctNull((String)rs1.getString("app_settlementdate")))
					.append("~Old Facility ID/Account Number of account to be restructured=").append(Helper.correctNull((String)rs1.getString("app_oldfacid")));
				}
				sbOldAudit.append("~City=").append(strCityDesc)
					.append("~District=").append(strDistrictDesc)
					.append("~State=").append(strStateDesc)
					.append("~Place=").append(strPlaceDescOldAudit)
					.append("~Does repayment depend purely on the asset financed=").append(strAssetFinancedDescOldAudit);
				if(strAssetFinancedOldAudit.equalsIgnoreCase("Y"))
				{
					sbOldAudit.append("~Source of repayment=").append(strSourceOfRepayDescOldAudit);
				}
				sbOldAudit.append("~Guarantee Covered by ECGCI / Govt. Agency=").append(strGuarCoveredDescOldAudit);
				if(!strGuarCoveredOldAudit.equalsIgnoreCase("00")&&!strGuarCoveredOldAudit.equalsIgnoreCase(""))
				{
					sbOldAudit.append("~Govt. Agency Guaranteed Amount=").append(Helper.correctDouble((String)rs1.getString("app_guaranteeamt")));
				}
				if(strLoanTypeOldAudit.equalsIgnoreCase("TL")||strLoanTypeOldAudit.equalsIgnoreCase("DL"))
				{
					sbOldAudit.append("~Whether the proposed facility is for New Project=").append(strNewProjectFacDescOldAudit);
					if(strNewProjectFacOldAudit.equalsIgnoreCase("Y"))
					{
						sbOldAudit.append("~Proposed date of Commencement of Commercial Operation (DCCO)=").append(Helper.correctNull((String)rs1.getString("app_commencementdate")));
					}
				}
				sbOldAudit.append("~Activity Code=").append(Helper.correctNull((String)rs1.getString("app_activitycode")))
					.append("~Main Activity=").append(strMainActDescOldAudit)
					.append("~Sub Activity=").append(strSubActivityDescOldAudit)
					.append("~Purpose=").append(strPurposeDescOldAudit)
					.append("~BSR Code=").append(strBSRDescOldAudit)
					.append("~BSR1 Code=").append(strBSR1DescOldAudit);
				if(!strIndTypeOldAudit.equalsIgnoreCase(""))
				{
					sbOldAudit.append("~Industry Type=").append(strIndTypeDescOldAudit);
				}
				sbOldAudit.append("~Asset Classification=").append(strAssetClassificationDescOldAudit);
				sbOldAudit.append("~Facility Sno=").append(strFacilitySno);
				String strnonreligion="";
		        if(rs!=null){
		        	rs.close();
		        }
					rs= DBUtils.executeLAPSQuery("selcbsstatdatabyiddesc^11^"+ Helper.correctNull((String)rs1.getString("MIS_NONIND_RELIGION")));
					if (rs.next()) {
						strnonreligion=Helper.correctNull(rs.getString("CBS_STATIC_DATA_DESC"));
					}
					String strnonindminority=Helper.correctNull((String)rs1.getString("MIS_NONIND_MINORITY_COMMUNITY"));
					if(strnonindminority.equalsIgnoreCase("Y"))
					{
						strnonindminority="Yes";
					}
					else if(strnonindminority.equalsIgnoreCase("N"))
					{
						strnonindminority="No";
					}
					
					String strreligion="";
			        if(rs!=null){
			        	rs.close();
			        }
						rs= DBUtils.executeLAPSQuery("selcbsstatdatabyiddesc^11^"+ Helper.correctNull((String)rs1.getString("MIS_IND_RELIGION")));
						if (rs.next()) {
							strreligion=Helper.correctNull(rs.getString("CBS_STATIC_DATA_DESC"));
						}
						String strindminority=Helper.correctNull((String)rs1.getString("MIS_IND_MINORITY"));
						if(strindminority.equalsIgnoreCase("Y"))
						{
							strindminority="Yes";
						}
						else if(strindminority.equalsIgnoreCase("N"))
						{
							strindminority="No";
						}
						String strmajorityscst=Helper.correctNull((String)hshValues.get("hidmajority_member"));
						if(strmajorityscst.equalsIgnoreCase("Y"))
						{
							strmajorityscst="Yes";
						}
						else if(strmajorityscst.equalsIgnoreCase("N"))
						{
							strmajorityscst="No";
						}
						String strheldwomen=Helper.correctNull((String)hshValues.get("hidstake_held"));
						if(strheldwomen.equalsIgnoreCase("Y"))
						{
							strheldwomen="Yes";
						}
						else if(strheldwomen.equalsIgnoreCase("N"))
						{
							strheldwomen="No";
						}
						String strgender=Helper.correctNull((String)hshValues.get("hidgender"));
						if(strgender.equalsIgnoreCase("M"))
						{
							strgender="Male";
						}
						else if(strgender.equalsIgnoreCase("F"))
						{
							strgender="Female";
						}
						else if(strgender.equalsIgnoreCase("O"))
						{
							strgender="Others";
						}
						String strcaste="";
				        if(rs!=null){
				        	rs.close();
				        }
							rs= DBUtils.executeLAPSQuery("selcbsstatdatabyiddesc^7^"+ Helper.correctNull((String)hshValues.get("hidcaste")));
							if (rs.next()) {
								strcaste=Helper.correctNull(rs.getString("CBS_STATIC_DATA_DESC"));
							}
						if(strconstitution.equalsIgnoreCase("01")){
							sbOldAudit.append("~Minority=").append(strindminority);
							sbOldAudit.append("~ Individual Religion=").append(strreligion);
							sbOldAudit.append("~Gender = ").append(strgender);
							sbOldAudit.append("~Caste = ").append(strcaste);
						}else{
							sbOldAudit.append("~Whether majority of members/owners belong to minority community=").append(strnonindminority);
							sbOldAudit.append("~Non Individual Religion=").append(strnonreligion);
							sbOldAudit.append("~Whether majority of members belongs to SC/ST = ").append(strmajorityscst);
							sbOldAudit.append("~Whether majority of shareholding & controlling stake held by women = ").append(strheldwomen);
						}
				

				
			}
			if(rs1!=null)
			{
				rs1.close();
			}
			strQuery1=SQLParser.getSqlQuery("sel_misappdisplayscreen^"+strAppNo+"^"+strFacilitySno);
			MISLogger.UpdateLogger(strQuery1);
			rs1=DBUtils.executeQuery(strQuery1);
			if(rs1.next())
			{
				String strFarmCatOldAudit=Helper.correctNull((String)rs1.getString("app_farmercategory"));
				String strFarmCatDescOldAudit=MAB.getMasterDesc("MISMast", "13", strFarmCatOldAudit);
				/* Whether covered under Crop Insurance */
				String strCropInsuOldAudit=Helper.correctNull((String)rs1.getString("app_whethercropins"));
				String strCropInsuDescOldAudit="";
				if(strCropInsuOldAudit.equalsIgnoreCase("Y"))
				{
					strCropInsuDescOldAudit="Yes";
				}
				else if(strCropInsuOldAudit.equalsIgnoreCase("N"))
				{
					strCropInsuDescOldAudit="No";
				}

				/* Whether covered under Krishi Card Scheme */
				String strKrishiCardOldAudit=Helper.correctNull((String)rs1.getString("app_whetherkrishicard"));
				String strKrishiCardDescOldAudit="";
				if(strKrishiCardOldAudit.equalsIgnoreCase("Y"))
				{
					strKrishiCardDescOldAudit="Yes";
				}
				else if(strKrishiCardOldAudit.equalsIgnoreCase("N"))
				{
					strKrishiCardDescOldAudit="No";
				}

				/* Whether Card converted under PAIS */
				String strPAISOldAudit=Helper.correctNull((String)rs1.getString("app_whetherpais"));
				String strPAISDescOldAudit="";
				if(strPAISOldAudit.equalsIgnoreCase("Y"))
				{
					strPAISDescOldAudit="Yes";
				}
				else if(strPAISOldAudit.equalsIgnoreCase("N"))
				{
					strPAISDescOldAudit="No";
				}

				/* Whether Accepts Deposits From Public */
				String strPublicDepositOldAudit=Helper.correctNull((String)rs1.getString("app_whetheraccdep"));
				String strPublicDepositDescOldAudit="";
				if(strPublicDepositOldAudit.equalsIgnoreCase("Y"))
				{
					strPublicDepositDescOldAudit="Yes";
				}
				else if(strPublicDepositOldAudit.equalsIgnoreCase("N"))
				{
					strPublicDepositDescOldAudit="No";
				}
				if(strDisplayScreenOldAudit.contains("agri"))
				{
					sbOldAudit.append("~Total Land Holding (in Acres)=").append(Helper.correctDouble((String)rs1.getString("app_totland")));
					if(!Helper.correctDouble((String)rs1.getString("app_totland")).equalsIgnoreCase("0")&&!Helper.correctDouble((String)rs1.getString("app_totland")).equalsIgnoreCase("0.00"))
					{
						sbOldAudit.append("~Irrigated=").append(Helper.correctDouble((String)rs1.getString("app_totirrigatedland")))
						.append("~Non Irrigated=").append(Helper.correctDouble((String)rs1.getString("app_totnonirrigatedland")))
						.append("~Cultivated=").append(Helper.correctDouble((String)rs1.getString("app_totcultivatedland")))
						.append("~Non Cultivated=").append(Helper.correctDouble((String)rs1.getString("app_totnoncultivatedland")));
					}
				sbOldAudit.append("~Farmer's Category=").append(strFarmCatDescOldAudit);
				}
				if(strDisplayScreenOldAudit.contains("agricropinsukrishimain"))
				{
					sbOldAudit.append("~Whether covered under Crop Insurance=").append(strCropInsuDescOldAudit)
					.append("~Whether covered under Krishi Card Scheme=").append(strKrishiCardDescOldAudit)
					.append("~Krishi Card No=").append(Helper.correctNull((String)rs1.getString("app_krishicardno")))
					.append("~Whether Card converted under PAIS=").append(strPAISDescOldAudit)
					.append("~Premium Paid Amount in Rs.=").append(Helper.correctDouble((String)rs1.getString("app_premiumamt")))
					.append("~Nominee Name=").append(Helper.correctNull((String)rs1.getString("app_nomineename")))
					.append("~Nominee Age=").append(Helper.correctInt((String)rs1.getString("app_nomineeage")))
					.append("~Nominee Relationship=").append(Helper.correctNull((String)rs1.getString("app_nomineerelation")))
					.append("~Claim Details under PAIS=").append(Helper.correctDouble((String)rs1.getString("app_claimdet")));
				}
				else if(strDisplayScreenOldAudit.contains("agritenure"))
				{
					sbOldAudit.append("~Loan Tenure (in months)=").append(strLoanTenureOldAudit);
				}
				else if(strDisplayScreenOldAudit.contains("agriAgribus"))
				{
					sbOldAudit.append("~Total financial outlays=").append(Helper.correctDouble((String)rs1.getString("app_totfinancialoutlays")))
					.append("~Individual Groups=").append(Helper.correctNull((String)rs1.getString("app_individualgrp")))
					.append("~Margin Money assistance amount=").append(Helper.correctDouble((String)rs1.getString("app_margin")));
				}
				else if(strDisplayScreenOldAudit.contains("industry"))
				{
					sbOldAudit.append("~ Investment in Plant & Machineries/Equipments=").append(Helper.correctDouble((String)rs1.getString("app_plantval")))
					.append("~Industry Name=").append(Helper.correctNull((String)rs1.getString("app_indname")));
				}
				else if(strDisplayScreenOldAudit.contains("nbfc"))
				{
					sbOldAudit.append("~Whether Accepts Deposits From Public=").append(strPublicDepositDescOldAudit);
				}
				else if(strDisplayScreenOldAudit.contains("housunit"))
				{
					sbOldAudit.append("~Number of housing units in building=").append(Helper.correctInt((String)rs1.getString("app_noofunits")));
				}
				else if(strDisplayScreenOldAudit.contains("fixedinvestment"))
				{
					sbOldAudit.append("~Investment in Equipments / Cost of Vehicles Used in Business=").append(Helper.correctDouble((String)rs1.getString("app_equipval")));
				}
				else if(strDisplayScreenOldAudit.contains("education"))
				{
					sbOldAudit.append("~Is the student meritorious?=").append("");
				}
				else if(strDisplayScreenOldAudit.contains("nbfc"))//added
				{
					sbOldAudit.append("~Whether Accepts Deposits From Public=").append(strPublicDepositDescOldAudit);
				}
				
					String strministry=Helper.correctNull((String)rs1.getString("APP_MINISTRY_INDUSTRY"));
					if(strministry.equalsIgnoreCase("Y"))
					{
						strministry="Yes";
					}
					else if(strministry.equalsIgnoreCase("N"))
					{
						strministry="No";
					}
					if(strDisplayScreenOldAudit.contains("ministry"))//added
					{
					sbOldAudit.append("~Whether Start up  Ministry of Commerce and Industry=").append(strministry);
					}if(strDisplayScreenOldAudit.contains("Carpet"))//added
					{
					sbOldAudit.append("~Carpet Area (in Sq mt)=").append(Helper.correctNull((String)rs1.getString("APP_CARPET_AREA")));
					}
					if(strDisplayScreenOldAudit.contains("floorarea"))//added
					{
				sbOldAudit.append("~Floor Area Ratio/Floor Space Index=").append(Helper.correctNull((String)rs1.getString("APP_FLOOR_AREA")));
					}
					String striindividualhouse="";
					rs4 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^253^"+ Helper.correctNull((String)rs1.getString("APP_AREA_INDV_HOUSE")));
					if (rs4.next()) {
						striindividualhouse=Helper.correctNull(rs4.getString("STAT_DATA_DESC1"));
					}
					if(strDisplayScreenOldAudit.contains("individualhouse"))//added
					{
					sbOldAudit.append("~Maximum Area of Individual House=").append(striindividualhouse);
					}
					if(strDisplayScreenOldAudit.contains("proposedloanSHG"))//added
					{
					sbOldAudit.append("~Maximum Share in the proposed loan by each SHG member=").append(Helper.correctNull((String)rs1.getString("APP_PROPOSED_LOAN_SHG")));
					}
					
				sbOldAudit.append("~Sales Turnover of the Applicant=").append(Helper.correctDouble((String)rs1.getString("APP_SALETURNOVER")));
				
				sbOldAudit.append("~Sales Turnover As on Date=").append(Helper.correctNull(rs1.getString("APP_SALESTURNOVER_DATE")));
				
					String strcriteriasales="";
					if(rs4!=null){
						rs4.close();
					}
					rs4 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^243^"+ Helper.correctNull((String)rs1.getString("APP_CRITERIA_SALESTURNOVER")));
					if (rs4.next()) {
						strcriteriasales=Helper.correctNull(rs4.getString("STAT_DATA_DESC1"));
					}
				sbOldAudit.append("~Criteria for Sales Turnover=").append(strcriteriasales);
				
				sbOldAudit.append("~investment Date=").append(Helper.correctNull(rs1.getString("APP_INVESTMENT_DATE")));
			
					String strcriteriainvest="";
					if(rs4!=null){
						rs4.close();
					}
					rs4 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^248^"+ Helper.correctNull((String)rs1.getString("APP_CRITERIA_INVESTMENT")));
					if (rs4.next()) {
						strcriteriainvest=Helper.correctNull(rs4.getString("STAT_DATA_DESC1"));
					}
				sbOldAudit.append("~Criteria for Investment value=").append(strcriteriainvest);
				if(strDisplayScreenOldAudit.contains("agriinfra"))//added
				{
				sbOldAudit.append("~Loan/s value for Agriculture Infrastructure=").append(Helper.correctDouble((String)rs1.getString("APP_AGRIINFRA")));

				}
				if(strDisplayScreenOldAudit.contains("renewenrgy"))//added
				{
				sbOldAudit.append("~Total value of the advances under Renewable Energy=").append(Helper.correctDouble((String)rs1.getString("APP_RENEWENERGY")));

				}
				if(strDisplayScreenOldAudit.contains("socinfra"))//added
				{
				sbOldAudit.append("~Total value of the advances under Social Infrastructure=").append(Helper.correctDouble((String)rs1.getString("APP_SOCIALINFRA")));

				}
				if(strDisplayScreenOldAudit.contains("dwellingunit"))//added
				{
				sbOldAudit.append("~overall cost of the dwelling unit=").append(Helper.correctDouble((String)rs1.getString("APP_DWELLING_UNIT")));

				}
				if(strApploantype.equalsIgnoreCase("P"))
				{
					sbOldAudit.append("~Cost of the Project=").append(strLoanCostofprojectOldAudit);
				}
			}
			if(!sbOldAudit.toString().equalsIgnoreCase(""))
			{
				String strCatType=Helper.correctNull((String)hshValues.get("sel_CategoryType"));
				String strSector=Helper.correctNull((String)hshValues.get("sel_Sector"));
				String strSubSector=Helper.correctNull((String)hshValues.get("sel_SubSector"));
				String strSensitiveSector=Helper.correctNull((String)hshValues.get("sel_SensitiveSector"));
				String strWeakerSection=Helper.correctNull((String)hshValues.get("sel_WeakerSection"));
				String strTwentyPointPgm=Helper.correctNull((String)hshValues.get("sel_TwentyPointPgm"));
				String strInfraCreditType=Helper.correctNull((String)hshValues.get("sel_InfraCreditType"));
				String strGovernmentScheme=Helper.correctNull((String)hshValues.get("sel_GovtAnnounceScheme"));
				String strStandupIndia=Helper.correctNull((String)hshValues.get("sel_StandupIndia"));
				String strGovernmentDesc=MAB.getMasterDesc("MISMast", "23", strGovernmentScheme);
				String strStandupIndiaDesc="";
				if(strStandupIndia.equalsIgnoreCase("Y"))
					strStandupIndiaDesc="Yes";
				else if(strStandupIndia.equalsIgnoreCase("N"))
					strStandupIndiaDesc="No";
				else
					strStandupIndiaDesc="Select";
				
				String strCatTypeDesc=MAB.getMasterDesc("MISMast", "12", strCatType);
				String strSectorDesc="";
				if(strSector.equalsIgnoreCase("01"))
				{
					strSectorDesc="Priority Sector";
				}
				else if(strSector.equalsIgnoreCase("02"))
				{
					strSectorDesc="Non Priority Sector";
				}
				String strSubSectorDesc=MAB.getMasterDesc("MISMast","7",strSubSector);
				if(strSubSectorDesc.equalsIgnoreCase(""))
				{
					strSubSectorDesc=MAB.getMasterDesc("MISMast","8",strSubSector);
				}
				String strSensitiveSectorDesc=MAB.getMasterDesc("MISMast","11",strSensitiveSector);
				String strWeakerSectionDesc=MAB.getMasterDesc("MISMast","09",strWeakerSection);
				String strTwentyPointPgmDesc=MAB.getMasterDesc("MISMast","10",strTwentyPointPgm);
				sbOldAudit.append("~Agriculture/Industry/Service Category type = ").append(strCatTypeDesc)
				.append("~Sector = ").append(strSectorDesc)
				.append("~Sub Sector = ").append(strSubSectorDesc)
				.append("~Sensitive sector = ").append(strSensitiveSectorDesc)
				.append("~Weaker Section = ").append(strWeakerSectionDesc)
				.append("~Twenty Point Program = ").append(strTwentyPointPgmDesc)
				.append("~Infrastructure Credit Type = ").append(strInfraCreditType)
				.append("~Government announced scheme = ").append(strGovernmentDesc)// New
				.append("~StandUp India = ").append(strStandupIndiaDesc);
			}
			
			if(rs !=null){rs.close();}
			strQuery=SQLParser.getSqlQuery("sel_masteruserid_mis");
			MISLogger.UpdateLogger(strQuery);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(strUserId.equalsIgnoreCase(Helper.correctNull((String)rs.getString("USER_ID"))))
				{
					strAuthuser="Y";
				}
			}
			
			if(rs !=null){rs.close();}
			strQuery=SQLParser.getSqlQuery("getagrvaluesin^"+strAppNo);
			MISLogger.UpdateLogger(strQuery);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				if(!Helper.correctNull((String)rs.getString("app_status")).equalsIgnoreCase("op") && !strAuthuser.equalsIgnoreCase("Y"))
				{
					return;
				}
			}
			/***
			 * End - Audit Trial Old Data
			 */
			if(strAction.equalsIgnoreCase("insert"))
			{
				if(rs != null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("sel_misappdetails^"+strAppNo+"^"+strFacilitySno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					if(!Helper.correctNull((rs.getString("app_guarantee"))).equalsIgnoreCase(Helper.correctNull((String)hshValues.get("sel_GuarCovered"))))
					{
						hshQueryValues = new HashMap();
						hshQuery = new HashMap();
						hshQuery.put("strQueryId", "upd_loan_digi_roi_fac");
						arrValues = new ArrayList();
						arrValues.add("");
						arrValues.add("");
						arrValues.add(strAppNo);
						arrValues.add(strFacilitySno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("1", hshQuery);
						hshQueryValues.put("size", "1");
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
					}
				}
				
				if(!strFacilitySno.equalsIgnoreCase("")&& !strFacilitySno.equalsIgnoreCase("0"))
				{
				hshQueryValues = new HashMap();
				hshQueryValues.put("size","4");
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_misappdetails");
				arrValues.add(strAppNo);
				arrValues.add(strFacilitySno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_misappdisplayscreen");
				arrValues.add(strAppNo);
				arrValues.add(strFacilitySno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
//				hshQuery = new HashMap();
//				arrValues=new ArrayList();
//				hshQuery.put("strQueryId","del_misappclassification");
//				arrValues.add(strAppNo);
//				arrValues.add(strFacilitySno);
//				hshQuery.put("arrValues",arrValues);
//				hshQueryValues.put("3",hshQuery);
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ins_misappdetails_laps");
				arrValues.add(strAppNo);
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_TotLimit")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_TotLimitService")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_TotLimitAgri")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_RestructFac")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_ServiceArea")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_RestructUnder")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_SettlementRefNo")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_SettlementDate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_OldFacID")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtarea_Reason")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_City")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_District")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_State")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_Place")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_AssetFinanced")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_RepaySource")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_GuarCovered")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_GuarAmount")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_NewProjectFac")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_DCCO")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_ActivityCode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hidSlNo")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_MainActivity")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_SubActivity")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_Purpose")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_BSRCode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_BSR1Code")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_IndustryType")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_AssetClassification")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_DisplayScreen")));
				arrValues.add(strFacilitySno);
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_sharebroker")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hidmisdataflag")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_minority")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_religion")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_firm_minority")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_corp_religion")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_allied_ActivityCode")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("3",hshQuery);
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ins_misappdisplayscreen_laps");
				arrValues.add(strAppNo);
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_TotLandHold")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_Irrigated")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_NonIrrigated")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_Cultivated")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_NonCultivated")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_FarmerCategory")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_CropInsu")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_KrishiCard")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_KrishiCard")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_PAIS")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_Premium")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_NomineeName")));
				arrValues.add(Helper.correctInt((String)hshValues.get("txt_NomineeAge")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_NomineeRel")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_PAISClaim")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_FinOutlays")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_IndGroups")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_MarginMoney")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_OrigInvest")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_IndName")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_PublicDeposit")));
				arrValues.add(Helper.correctInt((String)hshValues.get("txt_NoOfHousing")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_OriginalInvest")));
				arrValues.add(strFacilitySno);
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_onwardlending")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("sel_Meritorious")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_cre_percnt")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_social_infra")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_agri_anci")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_renew_energy")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_renew_energy_indv")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_agri_infra")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_sales_turnover")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_turnover_asondate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_sales_turnover")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_investDate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_criteria_invest")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_min_industry")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_carpetarea")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_floorarea")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_maxind_house")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_shgnumber")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_dwellingunit")));
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("4",hshQuery);
				/*hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ins_misappclassification");
				arrValues.add(Helper.correctNull((String)hshValues.get("strappno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_CategoryType")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_Sector")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_SubSector")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_SensitiveSector")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_WeakerSection")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_TwentyPointPgm")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_InfraCreditType")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("6",hshQuery);*/
				
				if(rs1!=null)
					rs1.close();
				strQuery=SQLParser.getSqlQuery("sel_corpcbsdetails^"+strAppNo+"^"+strFacilitySno);
				MISLogger.UpdateLogger(strQuery);
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					if(!Helper.correctNull((String)hshValues.get("txt_ActivityCode")).equalsIgnoreCase(""))
					{
						if(rs!=null)
							rs.close();
						strQuery =SQLParser.getSqlQuery("sel_activitylbrcode^" +Helper.correctNull((String)hshValues.get("txt_ActivityCode")));
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							hshQueryValues.put("size","5");
							hshQuery = new HashMap();
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","upd_cbsdetails");
							arrValues.add(Helper.correctNull(rs.getString("act_freecode6")));
							arrValues.add(Helper.correctNull(rs.getString("act_freecode7")));
							arrValues.add(Helper.correctNull(rs.getString("act_freecode8")));
							arrValues.add(Helper.correctNull(rs.getString("act_freecode7fincode")));
							arrValues.add(Helper.correctNull(rs.getString("act_freecode8fincode")));
							arrValues.add(Helper.correctNull(rs.getString("act_lbrcode")));
							arrValues.add(strAppNo);
							arrValues.add(strFacilitySno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("5",hshQuery);
						}
					}
				}
				
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				MISLogger.UpdateLogger("Updated Data Values==="+hshQueryValues);
				}
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQueryValues.put("size","3");
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_misappdetails");
				arrValues.add(strAppNo);
				arrValues.add(strFacilitySno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_misappdisplayscreen");
				arrValues.add(strAppNo);
				arrValues.add(strFacilitySno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_misappclassification");
				arrValues.add(strAppNo);
				arrValues.add(strFacilitySno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("3",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				MISLogger.UpdateLogger("Deleted Data Values==="+hshQueryValues);
			}
			/***
			 * For Audit Trial New Data - By Karthikeyan.S on 19/09/2013
			 */
			String strBankScheme="";
			String strLoanType="";
			String strLoanAmt="";
			String strLoanTenure="";
			String strBankSchemeDesc="";
			if(strApploantype.equalsIgnoreCase("P"))
			{
				strQuery=SQLParser.getSqlQuery("sel_prdbankscheme^"+strAppNo);
				MISLogger.UpdateLogger(strQuery);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strLoanType=Helper.correctNull((String)rs.getString("prd_loantype"));
					strBankScheme=Helper.correctNull((String)rs.getString("prd_bankscheme"));
				}
				strBankSchemeDesc=MAB.getMasterDesc("MISMast", "1", strBankScheme); // Bank's Scheme
				if(rs!=null)
				{
					rs.close();
				}
				
				strQuery=SQLParser.getSqlQuery("selLoanAmt^"+strAppNo);
				MISLogger.UpdateLogger(strQuery);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strLoanAmt=Helper.correctDouble((String)rs.getString("loanamt")); // Loan Amount
					strLoanTenure=Helper.correctInt((String)rs.getString("loan_terms")); // Loan Tenure
					strCostoftheProject=Helper.correctDouble((String)rs.getString("cloanprd")); // Loan Tenure
				}
			}
			else
			{
				strQuery=SQLParser.getSqlQuery("sel_chck_lst_doc^"+strAppNo+"^"+strFacilitySno);
				MISLogger.UpdateLogger(strQuery);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strLoanType=Helper.correctNull((String)rs.getString("com_facility_loantype"));
					strBankScheme=Helper.correctNull((String)rs.getString("COM_BANKSCHEME"));
					strLoanAmt=Helper.correctNull((String)rs.getString("FACILITY_SANCAMT"));
					strLoanTenure=Helper.correctNull((String)rs.getString("FACILITY_TENOR"));
				}
				
				strBankSchemeDesc=MAB.getMasterDesc("MISMast", "1", strBankScheme); 
			}
			if(rs!=null)
			{
				rs.close();
			}
			String strPurpose=Helper.correctNull((String)hshValues.get("sel_Purpose"));
			String strPurposeDesc="";
			if(!strPurpose.equalsIgnoreCase(""))
			{
				String[] strPurposeCodeSlNo=strPurpose.split("_");
				String strPurposeCode=strPurposeCodeSlNo[0];
				String strSlNo=strPurposeCodeSlNo[1];
				strQuery=SQLParser.getSqlQuery("sel_PurposeDesc^3^"+strPurposeCode+"^"+strSlNo);
				MISLogger.UpdateLogger(strQuery);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strPurposeDesc=Helper.correctInt((String)rs.getString("mis_static_data_desc")); // Purpose
				}
			}
			if(rs!=null)
			{
				rs.close();
			}
			String strBSRCode=Helper.correctNull((String)hshValues.get("sel_BSRCode"));
			String strBSRDesc="";
			strQuery=SQLParser.getSqlQuery("sel_BSRDesc^"+strBSRCode);
			MISLogger.UpdateLogger(strQuery);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strBSRDesc=Helper.correctNull((String)rs.getString("ind_name")); // BSR Code
			}
			String strRestructuredUnder=Helper.correctNull((String)hshValues.get("sel_RestructUnder"));
			String strPlace=Helper.correctNull((String)hshValues.get("sel_Place"));
			String strSourceOfRepay=Helper.correctNull((String)hshValues.get("sel_RepaySource"));
			String strGuarCovered=Helper.correctNull((String)hshValues.get("sel_GuarCovered"));
			String strMainAct=Helper.correctNull((String)hshValues.get("sel_MainActivity"));
			String strBSR1Code=Helper.correctNull((String)hshValues.get("sel_BSR1Code"));
			String strIndType=Helper.correctNull((String)hshValues.get("sel_IndustryType"));
			String strAssetClassification=Helper.correctNull((String)hshValues.get("sel_AssetClassification"));
			String strFarmCat=Helper.correctNull((String)hshValues.get("sel_FarmerCategory"));
			
			String strRestructuredUnderDesc=MAB.getMasterDesc("MISMast", "14", strRestructuredUnder);
			String strPlaceDesc=MAB.getMasterDesc("StatMast", "128", strPlace);
			String strSourceOfRepayDesc=MAB.getMasterDesc("MISMast", "15", strSourceOfRepay);
			String strGuarCoveredDesc=MAB.getMasterDesc("MISMast", "17", strGuarCovered);
			String strMainActDesc=MAB.getMasterDesc("MISMast", "2", strMainAct);
			String strBSR1Desc=MAB.getMasterDesc("MISMast", "6", strBSR1Code);
			String strIndTypeDesc=MAB.getMasterDesc("MISMast", "5", strIndType);
			String strAssetClassificationDesc=MAB.getMasterDesc("MISMast", "16", strAssetClassification);
			String strFarmCatDesc=MAB.getMasterDesc("MISMast", "13", strFarmCat);
			
			/* Sub Activity*/
			String strSubActivityCode=Helper.correctNull((String)hshValues.get("sel_SubActivity"));
			String strSubActivityDesc="";
			strQuery=SQLParser.getSqlQuery("sel_MISSubActivityDesc^"+strMainAct+"^"+strSubActivityCode);
			MISLogger.UpdateLogger(strQuery);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strSubActivityDesc=Helper.correctNull((String)rs.getString("mis_subactdesc"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			/* Restructured Under */
			String strRestructure=Helper.correctNull((String)hshValues.get("sel_RestructFac"));
			String strRestructureDesc="";
			if(strRestructure.equalsIgnoreCase("Y"))
			{
				strRestructureDesc="Yes";
			}
			else if(strRestructure.equalsIgnoreCase("N"))
			{
				strRestructureDesc="No";
			}
			
			/* Whether under Service Area Approach */
			String strServiceArea=Helper.correctNull((String)hshValues.get("sel_ServiceArea"));
			String strServiceAreaDesc="";
			if(strServiceArea.equalsIgnoreCase("Y"))
			{
				strServiceAreaDesc="Yes";
			}
			else if(strServiceArea.equalsIgnoreCase("N"))
			{
				strServiceAreaDesc="No";
			}
			
			/* Does repayment depend purely on the asset financed */
			String strAssetFinanced=Helper.correctNull((String)hshValues.get("sel_AssetFinanced"));
			String strAssetFinancedDesc="";
			if(strAssetFinanced.equalsIgnoreCase("Y"))
			{
				strAssetFinancedDesc="Yes";
			}
			else if(strAssetFinanced.equalsIgnoreCase("N"))
			{
				strAssetFinancedDesc="No";
			}
			
			/* Whether the proposed facility is for New Project */
			String strNewProjectFac=Helper.correctNull((String)hshValues.get("sel_NewProjectFac"));
			String strNewProjectFacDesc="";
			if(strNewProjectFac.equalsIgnoreCase("Y"))
			{
				strNewProjectFacDesc="Yes";
			}
			else if(strNewProjectFac.equalsIgnoreCase("N"))
			{
				strNewProjectFacDesc="No";
			}
			
			/* Whether covered under Crop Insurance */
			String strCropInsu=Helper.correctNull((String)hshValues.get("sel_CropInsu"));
			String strCropInsuDesc="";
			if(strCropInsu.equalsIgnoreCase("Y"))
			{
				strCropInsuDesc="Yes";
			}
			else if(strCropInsu.equalsIgnoreCase("N"))
			{
				strCropInsuDesc="No";
			}
			
			/* Whether covered under Krishi Card Scheme */
			String strKrishiCard=Helper.correctNull((String)hshValues.get("sel_KrishiCard"));
			String strKrishiCardDesc="";
			if(strKrishiCard.equalsIgnoreCase("Y"))
			{
				strKrishiCardDesc="Yes";
			}
			else if(strKrishiCard.equalsIgnoreCase("N"))
			{
				strKrishiCardDesc="No";
			}
			
			/* Whether Card converted under PAIS */
			String strPAIS=Helper.correctNull((String)hshValues.get("sel_PAIS"));
			String strPAISDesc="";
			if(strPAIS.equalsIgnoreCase("Y"))
			{
				strPAISDesc="Yes";
			}
			else if(strPAIS.equalsIgnoreCase("N"))
			{
				strPAISDesc="No";
			}
			
			/* Whether Accepts Deposits From Public */
			String strPublicDeposit=Helper.correctNull((String)hshValues.get("sel_PublicDeposit"));
			String strPublicDepositDesc="";
			if(strPublicDeposit.equalsIgnoreCase("Y"))
			{
				strPublicDepositDesc="Yes";
			}
			else if(strPublicDeposit.equalsIgnoreCase("N"))
			{
				strPublicDepositDesc="No";
			}
			
			String strDisplayScreen=Helper.correctNull((String)hshValues.get("sel_DisplayScreen"));
			sbActionData.append("~Bank's Scheme=").append(strBankSchemeDesc)
				.append("~Loan Amount=").append(strLoanAmt)
			//	.append("~Total Limit of the Borrower=").append(Helper.correctDouble((String)hshValues.get("txt_TotLimit")))
			//	.append("~Total Limit of the Borrower(Under Service Category)=").append(Helper.correctDouble((String)hshValues.get("app_totlimser")))
			//	.append("~Total Limit of the Borrower(Under Agriculture Category)=").append(Helper.correctDouble((String)hshValues.get("app_totlimagri")))
				.append("~Whether this facility is by restructuring of any existing accounts=").append(strRestructureDesc)
				.append("~Whether under Service Area Approach=").append(strServiceAreaDesc);
			if(strRestructure.equalsIgnoreCase("Y"))
			{
				sbActionData.append("~Restructured Under=").append(strRestructuredUnderDesc)
				.append("~Settlement Ref. No=").append(Helper.correctNull((String)hshValues.get("txt_SettlementRefNo")))
				.append("~Settlement Date=").append(Helper.correctNull((String)hshValues.get("txt_SettlementDate")))
				.append("~Old Facility ID/Account Number of account to be restructured=").append(Helper.correctNull((String)hshValues.get("txt_OldFacID")));
			}
			sbActionData.append("~City=").append(Helper.correctNull((String)hshValues.get("txt_City")))
				.append("~District=").append(Helper.correctNull((String)hshValues.get("txt_District")))
				.append("~State=").append(Helper.correctNull((String)hshValues.get("txt_State")))
				.append("~Place=").append(strPlaceDesc)
				.append("~Does repayment depend purely on the asset financed=").append(strAssetFinancedDesc);
			if(strAssetFinanced.equalsIgnoreCase("Y"))
			{
				sbActionData.append("~Source of repayment=").append(strSourceOfRepayDesc);
			}
			sbActionData.append("~Guarantee Covered by ECGCI / Govt. Agency=").append(strGuarCoveredDesc);
			if(!strGuarCovered.equalsIgnoreCase("00")&&!strGuarCovered.equalsIgnoreCase(""))
			{
				sbActionData.append("~Govt. Agency Guaranteed Amount=").append(Helper.correctDouble((String)hshValues.get("txt_GuarAmount")));
			}
			if(strLoanType.equalsIgnoreCase("TL")||strLoanType.equalsIgnoreCase("DL"))
			{
				sbActionData.append("~Whether the proposed facility is for New Project=").append(strNewProjectFacDesc);
				if(strNewProjectFac.equalsIgnoreCase("Y"))
				{
					sbActionData.append("~Proposed date of Commencement of Commercial Operation (DCCO)=").append(Helper.correctNull((String)hshValues.get("txt_DCCO")));
				}
			}
			sbActionData.append("~Activity Code=").append(Helper.correctNull((String)hshValues.get("txt_ActivityCode")))
				.append("~Main Activity=").append(strMainActDesc)
				.append("~Sub Activity=").append(strSubActivityDesc)
				.append("~Purpose=").append(strPurposeDesc)
				.append("~BSR Code=").append(strBSRDesc)
				.append("~BSR1 Code=").append(strBSR1Desc);
			if(!strIndType.equalsIgnoreCase(""))
			{
				sbActionData.append("~Industry Type=").append(strIndTypeDesc);
			}
			sbActionData.append("~Asset Classification=").append(strAssetClassificationDesc);
			if(strDisplayScreen.contains("agri"))
			{
				sbActionData.append("~Total Land Holding (in Acres)=").append(Helper.correctDouble((String)hshValues.get("txt_TotLandHold")));
				if(!Helper.correctDouble((String)hshValues.get("txt_TotLandHold")).equalsIgnoreCase("0")&&!Helper.correctDouble((String)hshValues.get("txt_TotLandHold")).equalsIgnoreCase("0.00"))
				{
					sbActionData.append("~Irrigated=").append(Helper.correctDouble((String)hshValues.get("txt_Irrigated")))
					.append("~Non Irrigated=").append(Helper.correctDouble((String)hshValues.get("txt_NonIrrigated")))
					.append("~Cultivated=").append(Helper.correctDouble((String)hshValues.get("txt_Cultivated")))
					.append("~Non Cultivated=").append(Helper.correctDouble((String)hshValues.get("txt_NonCultivated")));
				}
			sbActionData.append("~Farmer's Category=").append(strFarmCatDesc);
			}
			if(strDisplayScreen.contains("agricropinsukrishimain"))
			{
				sbActionData.append("~Whether covered under Crop Insurance=").append(strCropInsuDesc)
				.append("~Whether covered under Krishi Card Scheme=").append(strKrishiCardDesc)
				.append("~Krishi Card No=").append(Helper.correctNull((String)hshValues.get("txt_KrishiCard")))
				.append("~Whether Card converted under PAIS=").append(strPAISDesc)
				.append("~Premium Paid Amount in Rs.=").append(Helper.correctDouble((String)hshValues.get("txt_Premium")))
				.append("~Nominee Name=").append(Helper.correctNull((String)hshValues.get("txt_NomineeName")))
				.append("~Nominee Age=").append(Helper.correctInt((String)hshValues.get("txt_NomineeAge")))
				.append("~Nominee Relationship=").append(Helper.correctNull((String)hshValues.get("txt_NomineeRel")))
				.append("~Claim Details under PAIS=").append(Helper.correctDouble((String)hshValues.get("txt_PAISClaim")));
			}
			else if(strDisplayScreen.contains("agritenure"))
			{
				sbActionData.append("~Loan Tenure (in months)=").append(strLoanTenure);
			}
			else if(strDisplayScreen.contains("agriAgribus"))
			{
				sbActionData.append("~Total financial outlays=").append(Helper.correctDouble((String)hshValues.get("txt_FinOutlays")))
				.append("~Individual Groups=").append(Helper.correctNull((String)hshValues.get("txt_IndGroups")))
				.append("~Margin Money assistance amount=").append(Helper.correctDouble((String)hshValues.get("txt_MarginMoney")));
			}
			else if(strDisplayScreen.contains("industry"))
			{
				sbActionData.append("~ Investment in Plant & Machineries/Equipments=").append(Helper.correctDouble((String)hshValues.get("txt_OrigInvest")))
				.append("~Industry Name=").append(Helper.correctNull((String)hshValues.get("txt_IndName")));
			}
			else if(strDisplayScreen.contains("nbfc"))
			{
				sbActionData.append("~Whether Accepts Deposits From Public=").append(strPublicDepositDesc);
			}
			else if(strDisplayScreen.contains("housunit"))
			{
				sbActionData.append("~Number of housing units in building=").append(Helper.correctInt((String)hshValues.get("txt_NoOfHousing")));
			}
			else if(strDisplayScreen.contains("fixedinvestment"))
			{
				sbActionData.append("~ Investment in Equipments / Cost of Vehicles Used in Business=").append(Helper.correctDouble((String)hshValues.get("txt_OriginalInvest")));
			}
			else if(strDisplayScreen.contains("education"))
			{
				sbActionData.append("~Is the student meritorious?=").append("");
			}
			
				String strministry=Helper.correctNull((String)hshValues.get("sel_min_industry"));
				if(strministry.equalsIgnoreCase("Y"))
				{
					strministry="Yes";
				}
				else if(strministry.equalsIgnoreCase("N"))
				{
					strministry="No";
				}
				 if(strDisplayScreen.contains("ministry"))
				{
			sbActionData.append("~Whether Start up  Ministry of Commerce and Industry=").append(strministry);
				} if(strDisplayScreen.contains("Carpet"))
				{
			sbActionData.append("~Carpet Area (in Sq mt)=").append(Helper.correctNull((String)hshValues.get("txt_carpetarea")));
				}
				if(strDisplayScreen.contains("floorarea"))
				{
			sbActionData.append("~Floor Area Ratio/Floor Space Index=").append(Helper.correctNull((String)hshValues.get("txt_floorarea")));
				}
				String striindividualhouse="";
				rs4 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^253^"+ Helper.correctNull((String)hshValues.get("sel_maxind_house")));
				if (rs4.next()) {
					striindividualhouse=Helper.correctNull(rs4.getString("STAT_DATA_DESC1"));
				}
				if(strDisplayScreen.contains("individualhouse"))
				{
			sbActionData.append("~Maximum Area of Individual House=").append(striindividualhouse);
				}
				if(strDisplayScreen.contains("proposedloanSHG"))
				{
			sbActionData.append("~Maximum Share in the proposed loan by each SHG member=").append(Helper.correctNull((String)hshValues.get("txt_shgnumber")));
				}
			sbActionData.append("~Sales Turnover of the Applicant=").append(Helper.correctDouble((String)hshValues.get("txt_sales_turnover")));
			
			sbActionData.append("~Sales Turnover As on Date=").append(Helper.correctNull((String)hshValues.get("txt_turnover_asondate")));
			
				String strsalescriteria="";
		        if(rs!=null){
		        	rs.close();
		        }
					rs= DBUtils.executeLAPSQuery("selstatdatabyiddesc^243^"+ Helper.correctNull((String)hshValues.get("sel_sales_turnover")));
					if (rs.next()) {
						strsalescriteria=Helper.correctNull(rs.getString("STAT_DATA_DESC1"));
					}
			sbActionData.append("~Criteria for Sales Turnover=").append(strsalescriteria);
			
			sbActionData.append("~investment Date=").append(Helper.correctNull((String)hshValues.get("txt_investDate")));
			
				String strscriteriainvest="";
		        if(rs!=null){
		        	rs.close();
		        }
					rs= DBUtils.executeLAPSQuery("selstatdatabyiddesc^248^"+ Helper.correctNull((String)hshValues.get("sel_criteria_invest")));
					if (rs.next()) {
						strscriteriainvest=Helper.correctNull(rs.getString("STAT_DATA_DESC1"));
					}
			sbActionData.append("~Criteria for Investment value=").append(strscriteriainvest);
			if(strDisplayScreen.contains("agriinfra"))
			{
			sbActionData.append("~Loan/s value for Agriculture Infrastructure=").append(Helper.correctNull((String)hshValues.get("txt_agri_infra")));
			
			}
			if(strDisplayScreen.contains("renewenrgy"))//added
			{
				sbActionData.append("~Total value of the advances under Renewable Energy=").append(Helper.correctNull((String)hshValues.get("txt_renew_energy")));

			}
			if(strDisplayScreen.contains("socinfra"))//added
			{
				sbActionData.append("~Total value of the advances under Social Infrastructure=").append(Helper.correctNull((String)hshValues.get("txt_social_infra")));

			}
			if(strDisplayScreen.contains("dwellingunit"))//added
			{
				sbActionData.append("~overall cost of the dwelling unit=").append(Helper.correctNull((String)hshValues.get("txt_dwellingunit")));

			}
			if(strLoanType.contains("P"))//added
			{
				sbActionData.append("~Cost of the project=").append(strCostoftheProject);

			
			}
			String strnonreligion="";
	        if(rs!=null){
	        	rs.close();
	        }
				rs= DBUtils.executeLAPSQuery("selcbsstatdatabyiddesc^11^"+ Helper.correctNull((String)hshValues.get("sel_corp_religion")));
				if (rs.next()) {
					strnonreligion=Helper.correctNull(rs.getString("CBS_STATIC_DATA_DESC"));
				}
				String strnonindminority=Helper.correctNull((String)hshValues.get("sel_firm_minority"));
				if(strnonindminority.equalsIgnoreCase("Y"))
				{
					strnonindminority="Yes";
				}
				else if(strnonindminority.equalsIgnoreCase("N"))
				{
					strnonindminority="No";
				}
				
				String strreligion="";
		        if(rs!=null){
		        	rs.close();
		        }
					rs= DBUtils.executeLAPSQuery("selcbsstatdatabyiddesc^11^"+ Helper.correctNull((String)hshValues.get("sel_religion")));
					if (rs.next()) {
						strreligion=Helper.correctNull(rs.getString("CBS_STATIC_DATA_DESC"));
					}
					String strindminority=Helper.correctNull((String)hshValues.get("sel_minority"));
					if(strindminority.equalsIgnoreCase("Y"))
					{
						strindminority="Yes";
					}
					else if(strindminority.equalsIgnoreCase("N"))
					{
						strindminority="No";
					}
					String strmajorityscst=Helper.correctNull((String)hshValues.get("hidmajority_member"));
					if(strmajorityscst.equalsIgnoreCase("Y"))
					{
						strmajorityscst="Yes";
					}
					else if(strmajorityscst.equalsIgnoreCase("N"))
					{
						strmajorityscst="No";
					}
					String strheldwomen=Helper.correctNull((String)hshValues.get("hidstake_held"));
					if(strheldwomen.equalsIgnoreCase("Y"))
					{
						strheldwomen="Yes";
					}
					else if(strheldwomen.equalsIgnoreCase("N"))
					{
						strheldwomen="No";
					}
					String strgender=Helper.correctNull((String)hshValues.get("hidgender"));
					if(strgender.equalsIgnoreCase("M"))
					{
						strgender="Male";
					}
					else if(strgender.equalsIgnoreCase("F"))
					{
						strgender="Female";
					}
					else if(strgender.equalsIgnoreCase("O"))
					{
						strgender="Others";
					}
					String strcaste="";
			        if(rs!=null){
			        	rs.close();
			        }
						rs= DBUtils.executeLAPSQuery("selcbsstatdatabyiddesc^7^"+ Helper.correctNull((String)hshValues.get("hidcaste")));
						if (rs.next()) {
							strcaste=Helper.correctNull(rs.getString("CBS_STATIC_DATA_DESC"));
						}
			if(strconstitution.equalsIgnoreCase("01")){
			sbActionData.append("~Minority=").append(strindminority);
			sbActionData.append("~Individual Religion=").append(strreligion);
			sbActionData.append("~Gender = ").append(strgender);
		    sbActionData.append("~Caste = ").append(strcaste);
		  
			}else{
				sbActionData.append("~Whether majority of members/owners belong to minority community=").append(strnonindminority);
				sbActionData.append("~Non Individual Religion=").append(strnonreligion);
				sbActionData	.append("~Whether majority of members belongs to SC/ST = ").append(strmajorityscst);
				sbActionData.append("~Whether majority of shareholding & controlling stake held by women = ").append(strheldwomen);
			}
			sbActionData.append("~Facility Sno=").append(strFacilitySno);
			//AuditTrial.auditNewLog(hshValues, "232", strAppNo, sbActionData.toString(), sbOldAudit.toString());
			AuditTrial.auditNewLog1(hshValues,"232",strAppNo,sbActionData.toString(),sbOldAudit.toString(),strFacilitySno);	

			MISLogger.UpdateLogger("Audit Table:::::::::::::::::::::::PAGE ID=232:::::::::::: Application No:"+strAppNo+" Action ="+Helper.correctNull((String)hshValues.get("hidAction"))+" Old Values==="+sbOldAudit.toString()+"===New Values ===="+sbActionData.toString());
			/***
			 * End - Audit Trial New Data
			 */
		}
		catch(Exception cf)
		{
			throw new EJBException("Error in updateMISDetails"+cf.getMessage());
		}
	}
	/**
	 * @author:Karthikeyan.S
	 * @date:August 08, 2013-04:04:27 PM
	 * @category Farmer Category Master get method
	 * @return hshRecord
	 */
	public HashMap getFarmerCategoryData(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		String strQuery="";
		try
		{
			strQuery=SQLParser.getSqlQuery("sel_misfarmercategory");
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol=new ArrayList();
				String strIrrCode=Helper.correctNull((String)rs.getString("far_irrigcode"));
				String strCultCode=Helper.correctNull((String)rs.getString("far_cultivcode"));
				arrCol.add(Helper.correctNull((String)rs.getString("far_sno")));//0
				arrCol.add(strIrrCode);//1
				arrCol.add(Helper.correctDouble((String)rs.getString("far_irrigval")));//2
				arrCol.add(strCultCode);//3
				arrCol.add(Helper.correctDouble((String)rs.getString("far_cultiveval")));//4
				arrCol.add(Helper.correctNull((String)rs.getString("far_policydate")));//5
				String strIrrDesc=getMISStaticDataDesc("19",strIrrCode);
				arrCol.add(strIrrDesc);//6
				String strCultDesc=getMISStaticDataDesc("19",strCultCode);
				arrCol.add(strCultDesc);//7
				String strFarmCatCode=Helper.correctNull((String)rs.getString("far_farmcat"));
				arrCol.add(strFarmCatCode);//8
				String strFarmCatDesc=getMISStaticDataDesc("13",strFarmCatCode);
				arrCol.add(strFarmCatDesc);//9
				arrCol.add(Helper.correctNull((String)rs.getString("far_show")));//10
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow",arrRow);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getFarmerCategoryData "+ce.toString());
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
	/**
	 * @author:Karthikeyan.S
	 * @date:August 08, 2013-04:06:00 PM
	 * @category Farmer Category Master update method
	 * @return hshRecord
	 */
	public void updateFarmerCategoryData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAction="";
		try
		{
			String strSNo=Helper.correctNull((String)hshValues.get("hidSNo"));
			String strIrrCode=Helper.correctNull((String)hshValues.get("sel_Irrigated"));
			String strIrrVal=Helper.correctDouble((String)hshValues.get("txt_IrrigatedVal"));
			String strCultCode=Helper.correctNull((String)hshValues.get("sel_Cultivated"));
			String strCultVal=Helper.correctDouble((String)hshValues.get("txt_CultivatedVal"));
			String strNewFarVal=Helper.correctNull((String)hshValues.get("txt_NewFarmerDate"));
			String strFarmCat=Helper.correctNull((String)hshValues.get("sel_FarmCat"));
			String strUserId=Helper.correctNull((String)hshValues.get("strUserId"));
			String strVisibility=Helper.correctNull((String)hshValues.get("sel_Visibility"));
			strAction=Helper.correctNull((String)hshValues.get("hidAction"));
			if(strAction.equalsIgnoreCase("insert"))
			{
				strSNo=getMaxFarmerCatID();
				hshQueryValues = new HashMap();
				hshQueryValues.put("size","1");
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ins_misfarmercategory");
				arrValues.add(strSNo);
				arrValues.add(strIrrCode);
				arrValues.add(strIrrVal);
				arrValues.add(strCultCode);
				arrValues.add(strCultVal);
				arrValues.add(strNewFarVal);
				arrValues.add(strFarmCat);
				arrValues.add(strUserId);
				arrValues.add(strVisibility);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQueryValues = new HashMap();
				hshQueryValues.put("size","1");
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","upd_misfarmercategory");
				arrValues.add(strIrrCode);
				arrValues.add(strIrrVal);
				arrValues.add(strCultCode);
				arrValues.add(strCultVal);
				arrValues.add(strNewFarVal);
				arrValues.add(strFarmCat);
				arrValues.add(strUserId);
				arrValues.add(strVisibility);
				arrValues.add(strSNo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQueryValues.put("size","1");
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_misfarmercategory");
				arrValues.add(strSNo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch(Exception cf)
		{
			throw new EJBException("Error in updateFarmerCategoryData"+cf.getMessage());
		}
	}
	private String getMaxFarmerCatID() 
	{
		ResultSet rs1=null;
		String strQuery1="";
		String strSNo="";
		try
		{
			strQuery1=SQLParser.getSqlQuery("sel_maxmisfarmercategorysno");
			rs1=DBUtils.executeQuery(strQuery1);
			if(rs1.next())
			{
				strSNo=Helper.correctNull((String)rs1.getString("maxid"));
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getMaxFarmerCatID "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs1 != null)
				{
					rs1.close();
				}
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return strSNo;
	}
	public String getMISStaticDataDesc(String strID,String strCode) 
	{
		ResultSet rs1=null;
		String strQuery1="";
		String strDesc="";
		try
		{
			strQuery1=SQLParser.getSqlQuery("sel_misstaticdatadesc^"+strID+"^"+strCode);
			rs1=DBUtils.executeQuery(strQuery1);
			if(rs1.next())
			{
				strDesc=Helper.correctNull((String)rs1.getString("mis_static_data_desc"));
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getMaxFarmerCatID "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs1 != null)
				{
					rs1.close();
				}
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return strDesc;
	}
	public double getBorrowerTotalLimit(String strAppID, String strValuesin) 
	{
		ResultSet rs=null;
		String strQuery="";
		String strTotalLimit="";
		String strAppOldID="";
		double dblTotAmount=0.00;
		try
		{
			strQuery=SQLParser.getSqlQuery("select_perappoldid^"+strAppID);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strAppOldID=Helper.correctNull((String)rs.getString("perapp_oldid"));
			}
			if(!strAppOldID.equalsIgnoreCase(""))
			{
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("sel_borrowertotallimit^"+strAppOldID);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					dblTotAmount=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
				}
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("seltotliability^"+strAppOldID);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					dblTotAmount=dblTotAmount+Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
				}
			}
				strTotalLimit=Helper.convertSetupToApplicationValues(strValuesin,dblTotAmount);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getBorrowerTotalLimit "+ce.toString());
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
		return Double.parseDouble(strTotalLimit);
	}
	/*
	 * Added by prakash for MIS Classification
	 */
	public HashMap getMISAppClassification(HashMap hshValues)
	{
		String strActivityCode="";
		String strActivitySno="";
		String strAppno="";
		String strPriorityType="";
		String strPrioritySubSector="";
		String strSensitiveType="";
		String strSensitiveSubSector="";
		String strWeakerSectionSubSector="";
		String strSensitiveSector="";
		String strAgriIndConfig="";
		String strTwentyPointPgm="";
		String strGovtAnnounceScheme="";
		HashMap hshMIS=new HashMap();
		HashMap hshActivity=new HashMap();
		ResultSet rs=null;
		String strQuery="";
		String strPriority="";
		String strClassificationType="";
		String strValuesin="",strLoanType="";
		String strFacilitySno="";
		String strCheck="";
		String strClassiMaster_Sno = "";
		String strProductType="",strAppStatus="";

		try
		{
			
			//strActivityCode=Helper.correctNull((String)hshValues.get("txt_ActivityCode"));
			//strActivitySno=Helper.correctNull((String)hshValues.get("hidSlNo"));
			strAppno=Helper.correctNull((String)hshValues.get("strappno"));
			strFacilitySno=Helper.correctInt((String)hshValues.get("strFacilitySno"));
			
			strProductType=Helper.correctInt((String)hshValues.get("strProductType"));
			
			strCheck = " and app_facility_sno = "+strFacilitySno;
			
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=Helper.correctNull((String)hshValues.get("appno"));
			}
			
			if(!strAppno.equalsIgnoreCase(""))
			{
				if(strActivityCode.equalsIgnoreCase("") || strActivitySno.equalsIgnoreCase(""))
				{
					if(rs!=null)
					{
						rs.close();
					}
					strQuery = SQLParser.getSqlQuery("selmisappdetails^"+strAppno+"^"+strFacilitySno+"^"+strCheck);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strActivityCode=Helper.correctNull((String)rs.getString("app_activitycode"));
						strActivitySno=Helper.correctNull((String)rs.getString("app_activitysno"));
					}
				}
			}
			if(!strAppno.equalsIgnoreCase(""))
			{
				if(rs!=null)
				{
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("sel_appstatus^"+strAppno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strLoanType=Helper.correctNull((String)rs.getString("app_loantype"));
					strAppStatus=Helper.correctNull(rs.getString("app_status"));
					if(strLoanType.equalsIgnoreCase("A") || strLoanType.equalsIgnoreCase("R"))
					{
						strValuesin="R";
					}
					else
					{
						strValuesin=Helper.correctNull((String)rs.getString("app_valuesin"));
					}
				}
			}
			
			if(Helper.correctNull((String)hshValues.get("strAppType")).equalsIgnoreCase("P"))
			{
				if(rs!=null)
				{
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("selapplicationprocessdate^"+strAppno+"^"+strFacilitySno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshActivity.put("strProcessDate", Helper.correctNull(rs.getString("processdate")));
				}
				
				hshActivity.put("strPostSancFlag",Helper.correctNull((String)hshValues.get("strAppType")));
			}
			else if(Helper.correctNull((String)hshValues.get("strReclassification")).equalsIgnoreCase("Y"))
			{
				hshActivity.put("strProcessDate", Helper.correctNull((String)hshValues.get("strReclassifDate")));
				hshActivity.put("strReclassification","Y");
			}
			else if(strAppStatus.equalsIgnoreCase("PA"))
			{
				if(rs!=null)
				{
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("compropform6^"+strAppno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshActivity.put("strProcessDate", Helper.correctNull(rs.getString("app_processdate")));
				}
				hshActivity.put("strAppStatus",strAppStatus);
			}
			
			if( !(strActivityCode.equalsIgnoreCase("") || strActivitySno.equalsIgnoreCase("")))
			{
				hshActivity.put("strActivityCode", strActivityCode);
				hshActivity.put("strActivitySno", strActivitySno);
				hshActivity.put("strAppno", strAppno);
				
				hshActivity.put("strFacilitySno",Helper.correctInt((String)hshValues.get("strFacilitySno")));
				hshActivity.put("strLoanType",strLoanType);

				
				hshMIS=getPriorityNonPriorityClassification(hshActivity,strValuesin);
				strPriorityType=Helper.correctNull((String)hshMIS.get("prioritytype"));
				strPrioritySubSector=Helper.correctNull((String)hshMIS.get("subsector"));
				strClassiMaster_Sno=Helper.correctNull((String)hshMIS.get("Master_Sno"));
				
				hshMIS=new HashMap();
				hshActivity.put("strPrioritySubSector", strPrioritySubSector);
				hshActivity.put("strClassiMaster_Sno", strClassiMaster_Sno);

				hshMIS= getAgriIndConfig(hshActivity,strValuesin);		
				strPriority=Helper.correctNull((String)hshMIS.get("boolpriority"));
				if(strPriority.equalsIgnoreCase("false"))
				{
					strClassificationType="G";
					hshActivity.put("strAgrIndClassificationType",strClassificationType);
					hshMIS=new HashMap();
					hshMIS= getAgriIndConfig(hshActivity,strValuesin);
				}
				strAgriIndConfig=Helper.correctNull((String)hshMIS.get("subsector"));
				String strCodes="";
				if(rs!=null)
				{
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("selagriindcodes");
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strCodes=Helper.correctNull(rs.getString("codes"));
				}
				
				String strArr[]=strCodes.split("@");
				if(strArr!=null && strArr.length>=1)
				{
					for(int i=0;i<strArr.length;i++)
					{
						if(strAgriIndConfig.equalsIgnoreCase(strArr[i]))
						{
							hshActivity.put("applicantid", Helper.correctNull((String)hshValues.get("hidapplicantnewid")));
							hshActivity.put("AgriIndcode", strAgriIndConfig);
							hshMIS=new HashMap();
							hshMIS= getGovtAnnounceScheme(hshActivity,strValuesin);
							strGovtAnnounceScheme=Helper.correctNull((String)hshMIS.get("subsector"));
						}
					}
				}

				boolean bflag=true;
				if(strProductType.equalsIgnoreCase("pL"))
				{
					if(rs!=null)
					{
						rs.close();
					}
					strQuery = SQLParser.getSqlQuery("checkcostloanprd^"+strAppno);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						if(Integer.parseInt(Helper.correctInt(rs.getString("loan_lockperiod")))<Integer.parseInt(Helper.correctInt(rs.getString("loan_reqterms"))))
						{
							bflag=false;
							strSensitiveSector="011";
						}
						else if(Helper.correctNull(rs.getString("loan_dnw_revisions")).equalsIgnoreCase("Y"))
						{
							bflag=false;
							strSensitiveSector="011";
						}
					}
				}
				
				if(bflag)
				{
					hshMIS=new HashMap();
					hshMIS= getSensitiveSector(hshActivity,strValuesin);
					strPriority=Helper.correctNull((String)hshMIS.get("boolpriority"));
					if(strPriority.equalsIgnoreCase("false"))
					{
						strClassificationType="G";
						hshActivity.put("strSensitiveClassificationType",strClassificationType);
						hshMIS=new HashMap();
						hshMIS= getSensitiveSector(hshActivity,strValuesin);
					}
					strSensitiveSector=Helper.correctNull((String)hshMIS.get("subsector"));
					if(strSensitiveSector.equalsIgnoreCase(""))
					{
						strSensitiveSector="100";
					}
				}
				
				hshMIS=new HashMap();
				hshActivity.put("applicantid", Helper.correctNull((String)hshValues.get("hidapplicantnewid")));
				hshMIS= getWeakerSection(hshActivity,strValuesin);
				strPriority=Helper.correctNull((String)hshMIS.get("boolpriority"));
				if(strPriority.equalsIgnoreCase("false"))
				{
					strClassificationType="G";
					hshActivity.put("applicantid", Helper.correctNull((String)hshValues.get("hidapplicantnewid")));
					hshActivity.put("strWeakerClassificationType",strClassificationType);
					hshMIS=new HashMap();
					hshMIS= getWeakerSection(hshActivity,strValuesin);
				}
				strWeakerSectionSubSector=Helper.correctNull((String)hshMIS.get("subsector"));
				
				
				
				hshMIS=new HashMap();
				hshMIS= getTwentyPointPgm(hshActivity,strValuesin);
				strPriority=Helper.correctNull((String)hshMIS.get("boolpriority"));
				if(strPriority.equalsIgnoreCase("false"))
				{
					strClassificationType="G";
					hshActivity.put("strTwentyClassificationType",strClassificationType);
					hshMIS=new HashMap();
					hshMIS= getTwentyPointPgm(hshActivity,strValuesin);
				}
				strTwentyPointPgm=Helper.correctNull((String)hshMIS.get("subsector"));
				
				//Added by Guhan for Infrastructure credit type on 16-Nov-2014
				String strInfracode="";
				String strQueryInfra= SQLParser.getSqlQuery("sel_infracredittype_subsector^07^"+strActivityCode+"^"+strActivitySno);
				ResultSet rsInfra= DBUtils.executeQuery(strQueryInfra);
				if(rsInfra.next())
				{
					strInfracode = Helper.correctNull((String) rsInfra.getString("MIS_SUBSECTOR"));
				}			
				
				//Stand-up india changes added by harish on 10-OCT-2018
				hshMIS=new HashMap();
				String strStandUpIndia="";
				hshActivity.put("hidapplicantnewid", Helper.correctInt((String)hshValues.get("hidapplicantnewid")));
				hshActivity.put("hidapplicantid", Helper.correctInt((String)hshValues.get("hidapplicantid")));
				hshActivity.put("strAgriIndConfig", strAgriIndConfig);
				hshActivity.put("strPriorityType", strPriorityType);
				hshActivity.put("strHOLIDAYPERIOD", Helper.correctInt((String)hshValues.get("strHOLIDAYPERIOD")));
				hshActivity.put("strLoanAmt", Helper.correctInt((String)hshValues.get("strLoanAmt")));
				hshActivity.put("strReqTerms", Helper.correctInt((String)hshValues.get("strReqTerms")));
				hshActivity.put("strAppType", Helper.correctNull((String)hshValues.get("strAppType")));
				hshMIS= getStandupIndia(hshActivity,strValuesin);
				strStandUpIndia=Helper.correctNull((String)hshMIS.get("boolStandupIndia"));

				
				hshMIS=new HashMap();
				hshMIS.put("prioritytype",strPriorityType);
				hshMIS.put("subsector",strPrioritySubSector);
				hshMIS.put("strWeakerSectionSubSector",strWeakerSectionSubSector);
				hshMIS.put("strSensitiveSector",strSensitiveSector);
				hshMIS.put("strAgriIndConfig",strAgriIndConfig);
				hshMIS.put("strTwentyPointPgm",strTwentyPointPgm);
				hshMIS.put("strInfracode", strInfracode);
				hshMIS.put("strGovtAnnounceScheme", strGovtAnnounceScheme);
				hshMIS.put("strClassiMaster_Sno", strClassiMaster_Sno);
				hshMIS.put("strStandUpIndia", strStandUpIndia);

			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in MIS Classification "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshMIS;
		
	}
	public HashMap getPriorityNonPriorityClassification(HashMap hshActivity,String strValuesin)
	{
		boolean boolpriority=false;
		HashMap hshPriority=new HashMap();
		String strPriority="";
		String strClassificationType="";
		
		try
		{
			
			//hshActivity.put("strFacilitySno",Helper.correctInt((String)hshActivity.get("strFacilitySno")));
			hshPriority=getPriorityClassification(hshActivity,strValuesin);
			strPriority=(String)hshPriority.get("boolpriority");
			
			if(strPriority.equalsIgnoreCase("false"))
			{
				strClassificationType="G";
				hshActivity.put("strClassificationType",strClassificationType);
				hshPriority=getPriorityClassification(hshActivity,strValuesin);
				strPriority=(String)hshPriority.get("boolpriority");
			}
			
			if(strPriority.equalsIgnoreCase("false"))
			{
				hshPriority=getNonPriorityClassification(hshActivity,strValuesin);
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getting Priority/NonPriority Classification "+e.getMessage());
		}
		hshPriority.put("strFacilitySno",Helper.correctInt((String)hshActivity.get("strFacilitySno")));
		return hshPriority;
	}
	public HashMap getAgriIndConfig(HashMap hshActivity , String strValuesin)
	{
		HashMap hshValues=new HashMap();
		ResultSet rs=null,rs1=null;

		try
		{

			String strActivityCode="";
			String strActivitySno="";
			String strMisType="03";
			String strSubsector="";
			String strAppno="";
			String strQuery="";
			String strExcep="$";
			boolean boolStatus=false;
			String strConstCode="",strConstValue="";
			String strPlantandMacCode="",strPlantandMacValue="";
			String strGovtSchemeCode="",strGovtSchemeValue="";
			String strDisplayScreenCode="",strDisplayScreenValue="";
			String strFixedValCode="",strFixedValValue="";
			String strSectorCode="",strSectorValue="";
			String strPrioritySubSector="";
			String strClassificationType="";
			String strLoanType="";
			String strFacilitySno="",strPostSancFlag="",strProcessDate="",strAppStatus="";
			String strSalesTurnOverFrom="",strSalesTurnOverTo="";


			strActivityCode=Helper.correctNull((String)hshActivity.get("strActivityCode"));
			strActivitySno=Helper.correctNull((String)hshActivity.get("strActivitySno"));
			strAppno=Helper.correctNull((String)hshActivity.get("strAppno"));
			strPrioritySubSector=Helper.correctNull((String)hshActivity.get("strPrioritySubSector"));
			

			strLoanType=Helper.correctNull((String)hshActivity.get("strLoanType"));
			strFacilitySno=Helper.correctNull((String)hshActivity.get("strFacilitySno"));
			strPostSancFlag=Helper.correctNull((String)hshActivity.get("strPostSancFlag"));
			strProcessDate=Helper.correctNull((String)hshActivity.get("strProcessDate"));
			strAppStatus=Helper.correctNull((String)hshActivity.get("strAppStatus"));
			String strReClassifyFlag=Helper.correctNull((String)hshActivity.get("strReclassification"));
			
			/*strQuery = SQLParser.getSqlQuery("getmismasterdata^"+strMisType+"^"+strActivityCode+"^"+strActivitySno+"^"+strMisType+"^"+strActivitySno+"^"+strActivityCode);
			rs1=DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				strActivityCode=strActivityCode;
				strActivitySno=strActivitySno;
			}
			else
			{
				strActivityCode="000000";
				strActivitySno="0";
			}*/
			strClassificationType=Helper.correctNull((String)hshActivity.get("strAgrIndClassificationType"));
			if(strClassificationType.equalsIgnoreCase("G"))
			{
				strActivityCode="000000";
				strActivitySno="0";
			}

			if((strPostSancFlag.equals("P")||strAppStatus.equalsIgnoreCase("PA")||strReClassifyFlag.equalsIgnoreCase("Y")) && !strProcessDate.equals(""))
			strQuery = SQLParser.getSqlQuery("getmismasterdata_ps^"+strMisType+"^"+strActivityCode+"^"+strActivitySno+"^"+strMisType+"^"+strActivitySno+"^"+strActivityCode+"^"+strProcessDate);
			else
			strQuery = SQLParser.getSqlQuery("getmismasterdata^"+strMisType+"^"+strActivityCode+"^"+strActivitySno+"^"+strMisType+"^"+strActivitySno+"^"+strActivityCode);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				strConstCode=Helper.correctNull((String)rs.getString("mis_constitutioncode"));
				strConstValue=Helper.correctNull((String)rs.getString("mis_constitutionvalue"));
				strPlantandMacCode=Helper.correctNull((String)rs.getString("mis_plantmaccode"));
				strPlantandMacValue=Helper.correctNull((String)rs.getString("mis_plantmacvalue"));
				strGovtSchemeCode=Helper.correctNull((String)rs.getString("mis_govtsposchcode"));
				strGovtSchemeValue=Helper.correctNull((String)rs.getString("mis_govtsposchvalue"));
				strDisplayScreenCode=Helper.correctNull((String)rs.getString("mis_displayscreencode"));
				strDisplayScreenValue=Helper.correctNull((String)rs.getString("mis_displayscreenvalue"));
				strSectorCode=Helper.correctNull((String)rs.getString("mis_sectorcode"));
				strSectorValue=Helper.correctNull((String)rs.getString("mis_sectorval"));
				strFixedValCode=Helper.correctNull((String)rs.getString("mis_fixedassetcode"));
				strFixedValValue=Helper.correctNull((String)rs.getString("mis_fixedassetvalue"));
				strSalesTurnOverFrom=Helper.correctNull((String)rs.getString("MIS_SALESFROMVALUE"));
				strSalesTurnOverTo=Helper.correctNull((String)rs.getString("MIS_SALESTOVALUE"));
				
				boolean boolConstitution=false,boolConstitution1=true;
				boolean boolPlantandMachinery=false,boolPlantandMachinery1=true;
				boolean boolGovtScheme=false,boolGovtScheme1=true;
				boolean boolDisplay=false,boolDisplay1=true;
				boolean boolFixedValue=false,boolFixedValue1=true;
				boolean boolSectorValue=false,boolSectorValue1=true;
				boolean boolSalesTurnOver1=true,boolSalesTurnOver=false;



				strSubsector=Helper.correctNull((String)rs.getString("mis_subsector"));

				
				if(! (strConstCode.equalsIgnoreCase("") || strConstValue.equalsIgnoreCase("") || strConstCode.equalsIgnoreCase("0") || strConstValue.length()==1))
				{
					boolConstitution=true;
				}
				
				if(! (strPlantandMacCode.equalsIgnoreCase("") || strPlantandMacValue.equalsIgnoreCase("") || strPlantandMacValue.equalsIgnoreCase("0")))
				{
					boolPlantandMachinery=true;
				}
				
				if(! (strGovtSchemeCode.equalsIgnoreCase("") || strGovtSchemeValue.equalsIgnoreCase("") || strGovtSchemeCode.equalsIgnoreCase("0") || strGovtSchemeValue.length()==1))
				{
					boolGovtScheme=true;
				}
				
				if(! (strDisplayScreenCode.equalsIgnoreCase("") || strDisplayScreenValue.equalsIgnoreCase("") || strDisplayScreenCode.equalsIgnoreCase("0") || strDisplayScreenValue.length()==1))
				{
					boolDisplay=true;
				}
				if(! (strFixedValCode.equalsIgnoreCase("") || strFixedValValue.equalsIgnoreCase("") || strFixedValValue.equalsIgnoreCase("0")))
				{
					boolFixedValue=true;
				}
				if(! (strSectorCode.equalsIgnoreCase("") || strSectorValue.equalsIgnoreCase("") || strSectorCode.equalsIgnoreCase("0") || strSectorValue.length()==1))
				{
					boolSectorValue=true;
				}
				if(! (strSalesTurnOverFrom.equalsIgnoreCase("") || strSalesTurnOverFrom.equalsIgnoreCase("0") || strSalesTurnOverTo.equalsIgnoreCase("")|| strSalesTurnOverTo.equalsIgnoreCase("0")))
				{
					boolSalesTurnOver=true;
				}
				
				if(boolConstitution==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strConstCode);
					hshValues.put("strConstValue",strConstValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strFacilitySno", strFacilitySno);
					
					boolConstitution1=false;
					boolConstitution1=getConstitution(hshValues);
					if(boolConstitution1==false)
					{
						continue;
					}
				}
				
				if(boolPlantandMachinery==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strPlantandMacCode);
					hshValues.put("strConstValue",strPlantandMacValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strValuesin", strValuesin);

					boolPlantandMachinery1=false;
					boolPlantandMachinery1=getPlantandMachinery(hshValues);
					if(boolPlantandMachinery1==false)
					{
						continue;
					}
				}
				
				if(boolGovtScheme==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strGovtSchemeCode);
					hshValues.put("strConstValue",strGovtSchemeValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strFacilitySno", strFacilitySno);
					
					boolGovtScheme1=false;
					boolGovtScheme1=getGovernmentSponsersScheme(hshValues);
					if(boolGovtScheme1==false)
					{
						continue;
					}
				}
				if(boolDisplay==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strDisplayScreenCode);
					hshValues.put("strConstValue",strDisplayScreenValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strFacilitySno", strFacilitySno);

					boolDisplay1=false;
					boolDisplay1=getDisplayScreen(hshValues);
					if(boolDisplay1==false)
					{
						continue;
					}
				}
				if(boolFixedValue==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strFixedValCode);
					hshValues.put("strConstValue",strFixedValValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strValuesin", strValuesin);

					boolFixedValue1=false;
					boolFixedValue1=getFixedValue(hshValues);
					if(boolFixedValue1==false)
					{
						continue;
					}
				}
				if(boolSectorValue==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strSectorCode);
					hshValues.put("strConstValue",strSectorValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strPrioritySubSector", strPrioritySubSector);
					boolSectorValue1=false;
					boolSectorValue1=getSector(hshValues);
					if(boolSectorValue1==false)
					{
						continue;
					}
				}
				
				if(boolSalesTurnOver==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strSalesTurnOverFrom);
					hshValues.put("strConstValue",strSalesTurnOverTo);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strValuesin", strValuesin);

					boolSalesTurnOver1=false;
					boolSalesTurnOver1=getSalesTurnOver(hshValues);
					if(boolSalesTurnOver1==false)
					{
						continue;
					}
				}
				if(boolConstitution1==true && (boolPlantandMachinery1==true || boolFixedValue1==true) && 
					boolGovtScheme1==true && boolDisplay1==true && boolSalesTurnOver1==true && boolSectorValue1==true)
				{
					boolStatus=true;
				}
				else
				{
					boolStatus=false;
				}
				if(boolStatus==true)
				{
					hshValues.put("boolpriority",Boolean.toString(boolStatus));
					hshValues.put("subsector",strSubsector);//Sub Sector
					return hshValues;
				}

			}
			if(boolStatus==false)
			{
				hshValues.put("boolpriority",Boolean.toString(boolStatus));
			}	
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getting Agri Industry config "+e.getMessage());			
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				if(rs1 != null)
				   rs1.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshValues;
	}
	public HashMap getTwentyPointPgm(HashMap hshActivity, String strValuesin)
	{
		HashMap hshValues=new HashMap();
		ResultSet rs=null,rs1=null;
		try
		{

			String strActivityCode="";
			String strActivitySno="";
			String strMisType="06";
			String strSubsector="";
			String strAppno="";
			String strQuery="";
			String strExcep="$";
			boolean boolStatus=false;
			String strConstCode="",strConstValue="";
			String strFaremerCategoryCode="",strFaremerCategoryValue="";
			String strGovtSchemeCode="",strGovtSchemeValue="";
			String strCasteCode="",strCasteValue="";
			String strGenderCode="",strGenderValue="";
			String strMngmntGenderCode="",strMngmntGenderValue="";
			String strBranchAreaCode="",strBranchAreaValue="";
			String strClassificationType="";
			String strLoanType="",strFacilitySno="",strPostSancFlag="",strProcessDate="",strAppStatus="";


			strActivityCode=Helper.correctNull((String)hshActivity.get("strActivityCode"));
			strActivitySno=Helper.correctNull((String)hshActivity.get("strActivitySno"));
			strAppno=Helper.correctNull((String)hshActivity.get("strAppno"));

			strLoanType=Helper.correctNull((String)hshActivity.get("strLoanType"));
			strFacilitySno=Helper.correctNull((String)hshActivity.get("strFacilitySno"));
			
			strPostSancFlag=Helper.correctNull((String)hshActivity.get("strPostSancFlag"));
			strProcessDate=Helper.correctNull((String)hshActivity.get("strProcessDate"));
			strAppStatus=Helper.correctNull((String)hshActivity.get("strAppStatus"));
			String strReClassifyFlag=Helper.correctNull((String)hshActivity.get("strReclassification"));
			
			/*strQuery = SQLParser.getSqlQuery("getmismasterdata^"+strMisType+"^"+strActivityCode+"^"+strActivitySno+"^"+strMisType+"^"+strActivitySno+"^"+strActivityCode);
			rs1=DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				strActivityCode=strActivityCode;
				strActivitySno=strActivitySno;
			}
			else
			{
				strActivityCode="000000";
				strActivitySno="0";
			}*/
			strClassificationType=Helper.correctNull((String)hshActivity.get("strTwentyClassificationType"));
			if(strClassificationType.equalsIgnoreCase("G"))
			{
				strActivityCode="000000";
				strActivitySno="0";
			}
			if((strPostSancFlag.equals("P")||strAppStatus.equalsIgnoreCase("PA")||strReClassifyFlag.equalsIgnoreCase("Y")) && !strProcessDate.equals(""))
			strQuery = SQLParser.getSqlQuery("getmismasterdata_ps^"+strMisType+"^"+strActivityCode+"^"+strActivitySno+"^"+strMisType+"^"+strActivitySno+"^"+strActivityCode+"^"+strProcessDate);
			else 
			strQuery = SQLParser.getSqlQuery("getmismasterdata^"+strMisType+"^"+strActivityCode+"^"+strActivitySno+"^"+strMisType+"^"+strActivitySno+"^"+strActivityCode);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				strConstCode=Helper.correctNull((String)rs.getString("mis_constitutioncode"));
				strConstValue=Helper.correctNull((String)rs.getString("mis_constitutionvalue"));

				strFaremerCategoryCode=Helper.correctNull((String)rs.getString("mis_farmercode"));
				strFaremerCategoryValue=Helper.correctNull((String)rs.getString("mis_farmervalue"));
				strGovtSchemeCode=Helper.correctNull((String)rs.getString("mis_govtsposchcode"));
				strGovtSchemeValue=Helper.correctNull((String)rs.getString("mis_govtsposchvalue"));
				strBranchAreaCode=Helper.correctNull((String)rs.getString("mis_branchlocationcode"));
				strBranchAreaValue=Helper.correctNull((String)rs.getString("mis_branchlocationvalue"));
				strCasteCode=Helper.correctNull((String)rs.getString("mis_castecode"));
				strCasteValue=Helper.correctNull((String)rs.getString("mis_castevalue"));
				strGenderCode=Helper.correctNull((String)rs.getString("mis_gendercode"));
				strGenderValue=Helper.correctNull((String)rs.getString("mis_gendervalue"));
				
				strMngmntGenderCode=Helper.correctNull((String)rs.getString("MIS_MANAGEMENTGENDERCODE"));
				strMngmntGenderValue=Helper.correctNull((String)rs.getString("MIS_MANAGEMENTGENDERVALUE"));
				
				boolean boolConstitution=false,boolConstitution1=true;
				boolean boolFarmerCategory=false,boolFarmerCategory1=true;
				boolean boolGovtScheme=false,boolGovtScheme1=true;
				boolean boolBranchArea=false,boolBranchArea1=true;
				boolean boolCaste=false,boolCaste1=true;
				boolean boolGender=false,boolGender1=true;
				boolean boolMngmntGender=false,boolMngmntGender1=true;


				strSubsector=Helper.correctNull((String)rs.getString("mis_subsector"));

				
				if(! (strConstCode.equalsIgnoreCase("") || strConstValue.equalsIgnoreCase("") || strConstCode.equalsIgnoreCase("0") || strConstValue.length()==1))
				{
					boolConstitution=true;
				}
				if(! (strFaremerCategoryCode.equalsIgnoreCase("") || strFaremerCategoryValue.equalsIgnoreCase("") || strFaremerCategoryCode.equalsIgnoreCase("0") || strFaremerCategoryValue.length()==1))
				{
					boolFarmerCategory=true;
				}
				if(! (strGovtSchemeCode.equalsIgnoreCase("") || strGovtSchemeValue.equalsIgnoreCase("") || strGovtSchemeCode.equalsIgnoreCase("0") || strGovtSchemeValue.length()==1))
				{
					boolGovtScheme=true;
				}
				if(! (strCasteCode.equalsIgnoreCase("") || strCasteValue.equalsIgnoreCase("") || strCasteCode.equalsIgnoreCase("0") || strCasteValue.length()==1))
				{
					boolCaste=true;
				}
				
				if(! (strGenderCode.equalsIgnoreCase("") || strGenderValue.equalsIgnoreCase("") || strGenderCode.equalsIgnoreCase("0") || strGenderValue.length()==1))
				{
					boolGender=true;
				}
				
				if(! (strMngmntGenderCode.equalsIgnoreCase("") || strMngmntGenderValue.equalsIgnoreCase("") || strMngmntGenderCode.equalsIgnoreCase("0") || strMngmntGenderValue.length()==1))
				{
					boolMngmntGender=true;
				}
				
				if(! (strBranchAreaCode.equalsIgnoreCase("") || strBranchAreaValue.equalsIgnoreCase("") || strBranchAreaCode.equalsIgnoreCase("0") || strBranchAreaValue.length()==1))
				{
					boolBranchArea=true;
				}
				if(boolConstitution==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strConstCode);
					hshValues.put("strConstValue",strConstValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strFacilitySno", strFacilitySno);
					
					boolConstitution1=false;
					boolConstitution1=getConstitution(hshValues);
					if(boolConstitution1==false)
					{
						continue;
					}
				}
				if(boolFarmerCategory==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strFaremerCategoryCode);
					hshValues.put("strConstValue",strFaremerCategoryValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strFacilitySno", strFacilitySno);
					boolFarmerCategory1=false;
					boolFarmerCategory1=getFarmerCategory(hshValues);
					if(boolFarmerCategory1==false)
					{
						continue;
					}
				}
				if(boolGovtScheme==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strGovtSchemeCode);
					hshValues.put("strConstValue",strGovtSchemeValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strFacilitySno", strFacilitySno);
					
					boolGovtScheme1=false;
					boolGovtScheme1=getGovernmentSponsersScheme(hshValues);
					if(boolGovtScheme1==false)
					{
						continue;
					}
				}
				if(boolCaste==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strCasteCode);
					hshValues.put("strConstValue",strCasteValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);

					boolCaste1=false;
					boolCaste1=getCaste(hshValues);
					if(boolCaste1==false)
					{
						continue;
					}
				}
				
				if(boolGender==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strGenderCode);
					hshValues.put("strConstValue",strGenderValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strFacilitySno", strFacilitySno);

					boolGender1=false;
					boolGender1=getGender(hshValues);
					if(boolGender1==false)
					{
						continue;
					}
				}

				if(boolMngmntGender==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strMngmntGenderCode);
					hshValues.put("strConstValue",strMngmntGenderValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strFacilitySno", strFacilitySno);

					boolMngmntGender1=false;
					boolMngmntGender1=getManagementGender(hshValues);
					if(boolMngmntGender1==false)
					{
						continue;
					}
				}

				if(boolBranchArea==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strBranchAreaCode);
					hshValues.put("strConstValue",strBranchAreaValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strFacilitySno", strFacilitySno);

					boolBranchArea1=false;
					boolBranchArea1=getBranchLocation(hshValues);
					if(boolBranchArea1==false)
					{
						continue;
					}
				}
				if(boolConstitution1==true && boolFarmerCategory1==true && boolGovtScheme1==true &&
					boolCaste1==true && boolGender1==true && boolMngmntGender1==true && boolBranchArea1==true)
				{
					boolStatus=true;
				}
				else
				{
					boolStatus=false;
				}
				if(boolStatus==true)
				{
					hshValues.put("boolpriority",Boolean.toString(boolStatus));
					hshValues.put("subsector",strSubsector);//Sub Sector
					return hshValues;
				}

			}
			if(boolStatus==false)
			{
				hshValues.put("boolpriority",Boolean.toString(boolStatus));
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getting Twenty Point Program "+e.getMessage());					
		}
		finally
		{
			try
			{	if(rs != null)
				{
					rs.close();
				}
				if(rs1 != null)
				{
					rs1.close();
				}	
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshValues;
	}
	public HashMap getWeakerSection(HashMap hshActivity , String strValuesin)
	{
		HashMap hshValues=new HashMap();
		ResultSet rs=null,rs1=null;
		try
		{
			String strActivityCode="";
			String strActivitySno="";
			String strMisType="05";
			String strSubsector="";
			String strAppno="";
			String strQuery="";
			String strExcep="$";
			boolean boolStatus=false;
			String strConstCode="",strConstValue="";
			String strLoanAmtCode="",strLoanAmtValue="";
			String strLoanTenorCode="",strLoanTenorValue="";
			String strPlantandMacCode="",strPlantandMacValue="";
			String strFaremerCategoryCode="",strFaremerCategoryValue="";
			String strGovtSchemeCode="",strGovtSchemeValue="";
			String strTotalLimitCode="",strTotalLimitValue="";
			String strCasteCode="",strCasteValue="";
			String strGenderCode="",strGenderValue="";
			String strPhyChallCode="",strPhyChallValue="";
			String strIrrigatedLandCode="",strIrrigatedLandValue="";
			String strDisplayScreenCode="",strDisplayScreenValue="";
			String strClassificationType="";
			String strLoanType="",strFacilitySno="",strPostSancFlag="",strProcessDate="",strAppStatus="",strMinorityCode="",strMinorityValue="",strAlliedActivity="",
			strMinorityCommunityCode="",strMinorityCommunityValue="",strdwellingcode="",strdwellingvalue="";
			
			String strSalesTurnOverFrom="",strSalesTurnOverTo="";

			strActivityCode=Helper.correctNull((String)hshActivity.get("strActivityCode"));
			strActivitySno=Helper.correctNull((String)hshActivity.get("strActivitySno"));
			strAppno=Helper.correctNull((String)hshActivity.get("strAppno"));
			

			strLoanType=Helper.correctNull((String)hshActivity.get("strLoanType"));
			strFacilitySno=Helper.correctNull((String)hshActivity.get("strFacilitySno"));
			
			strPostSancFlag=Helper.correctNull((String)hshActivity.get("strPostSancFlag"));
			strProcessDate=Helper.correctNull((String)hshActivity.get("strProcessDate"));
			strAppStatus=Helper.correctNull((String)hshActivity.get("strAppStatus"));
			String strReClassifyFlag=Helper.correctNull((String)hshActivity.get("strReclassification"));
			
			/*
			strQuery = SQLParser.getSqlQuery("getmismasterdata^"+strMisType+"^"+strActivityCode+"^"+strActivitySno+"^"+strMisType+"^"+strActivitySno+"^"+strActivityCode);
			rs1=DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				strActivityCode=strActivityCode;
				strActivitySno=strActivitySno;
			}
			else
			{
				strActivityCode="000000";
				strActivitySno="0";
			}*/
			strClassificationType=Helper.correctNull((String)hshActivity.get("strWeakerClassificationType"));
			if(strClassificationType.equalsIgnoreCase("G"))
			{
				strActivityCode="000000";
				strActivitySno="0";
			}
			if((strPostSancFlag.equals("P")||strAppStatus.equalsIgnoreCase("PA")||strReClassifyFlag.equalsIgnoreCase("Y")) && !strProcessDate.equals(""))
			strQuery = SQLParser.getSqlQuery("getmismasterdata_ps^"+strMisType+"^"+strActivityCode+"^"+strActivitySno+"^"+strMisType+"^"+strActivitySno+"^"+strActivityCode+"^"+strProcessDate);
			else
			strQuery = SQLParser.getSqlQuery("getmismasterdata^"+strMisType+"^"+strActivityCode+"^"+strActivitySno+"^"+strMisType+"^"+strActivitySno+"^"+strActivityCode);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				strConstCode=Helper.correctNull((String)rs.getString("mis_constitutioncode"));
				strConstValue=Helper.correctNull((String)rs.getString("mis_constitutionvalue"));
				strLoanAmtCode=Helper.correctNull((String)rs.getString("mis_loanamtcode"));
				strLoanAmtValue=Helper.correctNull((String)rs.getString("mis_loanamtvalue"));
				strPlantandMacCode=Helper.correctNull((String)rs.getString("mis_plantmaccode"));
				strPlantandMacValue=Helper.correctNull((String)rs.getString("mis_plantmacvalue"));
				strFaremerCategoryCode=Helper.correctNull((String)rs.getString("mis_farmercode"));
				strFaremerCategoryValue=Helper.correctNull((String)rs.getString("mis_farmervalue"));
				strGovtSchemeCode=Helper.correctNull((String)rs.getString("mis_govtsposchcode"));
				strGovtSchemeValue=Helper.correctNull((String)rs.getString("mis_govtsposchvalue"));
				strTotalLimitCode=Helper.correctNull((String)rs.getString("mis_totallimitcode"));
				strTotalLimitValue=Helper.correctNull((String)rs.getString("mis_totallimitvalue"));
				
				strCasteCode=Helper.correctNull((String)rs.getString("mis_castecode"));
				strCasteValue=Helper.correctNull((String)rs.getString("mis_castevalue"));
				strGenderCode=Helper.correctNull((String)rs.getString("mis_gendercode"));
				strGenderValue=Helper.correctNull((String)rs.getString("mis_gendervalue"));
				strIrrigatedLandCode=Helper.correctNull((String)rs.getString("mis_irrigatedcode"));
				strIrrigatedLandValue=Helper.correctNull((String)rs.getString("mis_irrigatedvalue"));
				strDisplayScreenCode=Helper.correctNull((String)rs.getString("mis_displayscreencode"));
				strDisplayScreenValue=Helper.correctNull((String)rs.getString("mis_displayscreenvalue"));
				strPhyChallCode=Helper.correctNull((String)rs.getString("MIS_PHYS_CHALL_CODE"));
				strPhyChallValue=Helper.correctNull((String)rs.getString("MIS_PHYS_CHALL_VALUE"));
				
				strSalesTurnOverFrom=Helper.correctNull((String)rs.getString("MIS_SALESFROMVALUE"));
				strSalesTurnOverTo=Helper.correctNull((String)rs.getString("MIS_SALESTOVALUE"));
				strMinorityCode=Helper.correctNull((String)rs.getString("MIS_MINORITY_CODE"));
				strMinorityValue=Helper.correctNull((String)rs.getString("MIS_MINORITY_VALUE"));
				strMinorityCommunityCode=Helper.correctNull((String)rs.getString("MIS_NONIND_MINORITY_CODE"));
				strMinorityCommunityValue=Helper.correctNull((String)rs.getString("MIS_NONIND_MINORITY_VALUE"));
				strAlliedActivity = Helper.correctNull((String) rs.getString("MIS_ALLIEDACTIVITY"));
				strdwellingcode=Helper.correctNull((String)rs.getString("MIS_DWELLING_CODE"));
				strdwellingvalue=Helper.correctNull((String)rs.getString("MIS_DWELLING_VALUE"));
				boolean boolConstitution=false,boolConstitution1=true;
				boolean boolLoanAmount=false,boolLoanAmount1=true;
				boolean boolPlantandMachinery=false,boolPlantandMachinery1=true;
				boolean boolFarmerCategory=false,boolFarmerCategory1=true;
				boolean boolGovtScheme=false,boolGovtScheme1=true;
				boolean boolTotalLimit=false,boolTotalLimit1=true;
				
				boolean boolCaste=false,boolCaste1=true;
				boolean boolGender=false,boolGender1=true;
				boolean boolIrrigated=false,boolIrrigated1=true;
				boolean boolDisplay=false,boolDisplay1=true;
				boolean boolphychall=false,boolphychall1=true;
				boolean boolSalesTurnOver1=true,boolSalesTurnOver=false;
				boolean boolMinority=false,boolMinority1=true;
				boolean boolMinorityCommunity=false,boolMinorityCommunity1=true;
	            boolean boolAlliedActivity = false, boolAlliedActivity1 = true;
				strSubsector=Helper.correctNull((String)rs.getString("mis_subsector"));

				
				if(! (strConstCode.equalsIgnoreCase("") || strConstValue.equalsIgnoreCase("") || strConstCode.equalsIgnoreCase("0") || strConstValue.length()==1))
				{
					boolConstitution=true;
				}
				if(! (strLoanAmtCode.equalsIgnoreCase("") || strLoanAmtValue.equalsIgnoreCase("") || strLoanAmtCode.equalsIgnoreCase("0") || strLoanAmtValue.equalsIgnoreCase("0")))
				{
					boolLoanAmount=true;
				}
				if(! (strPlantandMacCode.equalsIgnoreCase("") || strPlantandMacValue.equalsIgnoreCase("") || strPlantandMacValue.equalsIgnoreCase("0")))
				{
					boolPlantandMachinery=true;
				}
				if(! (strFaremerCategoryCode.equalsIgnoreCase("") || strFaremerCategoryValue.equalsIgnoreCase("") || strFaremerCategoryCode.equalsIgnoreCase("0") || strFaremerCategoryValue.length()==1))
				{
					boolFarmerCategory=true;
				}
				if(! (strGovtSchemeCode.equalsIgnoreCase("") || strGovtSchemeValue.equalsIgnoreCase("") || strGovtSchemeCode.equalsIgnoreCase("0") || strGovtSchemeValue.length()==1))
				{
					boolGovtScheme=true;
				}
				if(! (strTotalLimitCode.equalsIgnoreCase("") || strTotalLimitValue.equalsIgnoreCase("") || strTotalLimitCode.equalsIgnoreCase("0") || strTotalLimitValue.equalsIgnoreCase("0")))
				{
					boolTotalLimit=true;
				}
				
				
				if(! (strCasteCode.equalsIgnoreCase("") || strCasteValue.equalsIgnoreCase("") || strCasteCode.equalsIgnoreCase("0") || strCasteValue.length()==1))
				{
					boolCaste=true;
				}
				
				if(! (strGenderCode.equalsIgnoreCase("") || strGenderValue.equalsIgnoreCase("") || strGenderCode.equalsIgnoreCase("0") || strGenderValue.length()==1))
				{
					boolGender=true;
				}
				
				if(! (strDisplayScreenCode.equalsIgnoreCase("") || strDisplayScreenValue.equalsIgnoreCase("") || strDisplayScreenCode.equalsIgnoreCase("0") || strDisplayScreenValue.length()==1))
				{
					boolDisplay=true;
				}
				if(! (strIrrigatedLandCode.equalsIgnoreCase("") || strIrrigatedLandValue.equalsIgnoreCase("") || strIrrigatedLandCode.equalsIgnoreCase("0") || strIrrigatedLandValue.equalsIgnoreCase("0")))
				{
					boolIrrigated=true;
				}
				if(! (strPhyChallCode.equalsIgnoreCase("") || strPhyChallValue.equalsIgnoreCase("") || strPhyChallCode.equalsIgnoreCase("0") || strPhyChallValue.equalsIgnoreCase("0")))
				{
					boolphychall=true;
				}
				if(! (strSalesTurnOverFrom.equalsIgnoreCase("") || strSalesTurnOverFrom.equalsIgnoreCase("0") || strSalesTurnOverTo.equalsIgnoreCase("")|| strSalesTurnOverTo.equalsIgnoreCase("0")))
				{
					boolSalesTurnOver=true;
				}
				if(! (strMinorityCode.equalsIgnoreCase("") || strMinorityValue.equalsIgnoreCase("") || strMinorityCode.equalsIgnoreCase("0") || strMinorityValue.equalsIgnoreCase("0")))
				{
					boolMinority=true;
				}
				if(! (strMinorityCommunityCode.equalsIgnoreCase("") || strMinorityCommunityValue.equalsIgnoreCase("") || strMinorityCommunityCode.equalsIgnoreCase("0") || strMinorityCommunityValue.equalsIgnoreCase("0")))
				{
					boolMinorityCommunity=true;
				}
				if (!(strAlliedActivity.equalsIgnoreCase("") || strAlliedActivity.equalsIgnoreCase(""))) {
					boolAlliedActivity = true;
				}
				
				
				if(boolConstitution==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strConstCode);
					hshValues.put("strConstValue",strConstValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strFacilitySno", strFacilitySno);
					boolConstitution1=false;
					boolConstitution1=getConstitution(hshValues);
					if(boolConstitution1==false)
					{
						continue;
					}
				}
				if(boolLoanAmount==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strLoanAmtCode);
					hshValues.put("strConstValue",strLoanAmtValue);
					hshValues.put("strAppno", strAppno);

					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strValuesin", strValuesin);
					
					boolLoanAmount1=false;
					boolLoanAmount1=getLoanAmount(hshValues);
					if(boolLoanAmount1==false)
					{
						continue;
					}
				}
				if (boolAlliedActivity == true) {
					hshValues = new HashMap();
					hshValues.put("strLoanAmtCode", strLoanAmtCode);
					hshValues.put("strLoanAmtValue", strLoanAmtValue);
					hshValues.put("strConstCode", strConstCode);
					hshValues.put("strConstValue", strConstValue);
					hshValues.put("strAlliedActivity", strAlliedActivity);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strValuesin", strValuesin);
					hshValues.put("applicantid", Helper.correctNull((String) hshActivity.get("applicantid")));

					boolAlliedActivity1 = false;
					boolAlliedActivity1 = getAliedAcivityDetails(hshValues);
					if (boolAlliedActivity1 == false) {
						continue;
					}
				}
				if(boolPlantandMachinery==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strPlantandMacCode);
					hshValues.put("strConstValue",strPlantandMacValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strValuesin", strValuesin);

					boolPlantandMachinery1=false;
					boolPlantandMachinery1=getPlantandMachinery(hshValues);
					if(boolPlantandMachinery1==false)
					{
						continue;
					}
				}
				if(boolFarmerCategory==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strFaremerCategoryCode);
					hshValues.put("strConstValue",strFaremerCategoryValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strFacilitySno", strFacilitySno);

					boolFarmerCategory1=false;
					boolFarmerCategory1=getFarmerCategory(hshValues);
					if(boolFarmerCategory1==false)
					{
						continue;
					}
				}
				if(boolGovtScheme==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strGovtSchemeCode);
					hshValues.put("strConstValue",strGovtSchemeValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strFacilitySno", strFacilitySno);
					boolGovtScheme1=false;
					boolGovtScheme1=getGovernmentSponsersScheme(hshValues);
					if(boolGovtScheme1==false)
					{
						continue;
					}
				}
				if(boolTotalLimit==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strTotalLimitCode);
					hshValues.put("strConstValue",strTotalLimitValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strValuesin", strValuesin);

					boolTotalLimit1=false;
					boolTotalLimit1=getTotalLimit(hshValues);
					if(boolTotalLimit1==false)
					{
						continue;
					}
				}
				
				if(boolCaste==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strCasteCode);
					hshValues.put("strConstValue",strCasteValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);

					boolCaste1=false;
					boolCaste1=getCaste(hshValues);
					if(boolCaste1==false)
					{
						continue;
					}
				}
				
				if(boolGender==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strGenderCode);
					hshValues.put("strConstValue",strGenderValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strFacilitySno", strFacilitySno);
					
					boolGender1=false;
					boolGender1=getGender(hshValues);
					if(boolGender1==false)
					{
						continue;
					}
				}
				
				if(boolIrrigated==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strIrrigatedLandCode);
					hshValues.put("strConstValue",strIrrigatedLandValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strFacilitySno", strFacilitySno);

					boolIrrigated1=false;
					boolIrrigated1=getIrrigatedValue(hshValues);
					if(boolIrrigated1==false)
					{
						continue;
					}
				}
				
				if(boolDisplay==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strDisplayScreenCode);
					hshValues.put("strConstValue",strDisplayScreenValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strFacilitySno", strFacilitySno);

					boolDisplay1=false;
					boolDisplay1=getDisplayScreen(hshValues);
					if(boolDisplay1==false)
					{
						continue;
					}
				}
				
				if(boolphychall==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strPhyChallCode);
					hshValues.put("strConstValue",strPhyChallValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strFacilitySno", strFacilitySno);
					
					boolphychall1=false;
					boolphychall1=getPhysicalChallenged(hshValues);
					if(boolphychall1==false)
					{
						continue;
					}
				}
				if(boolSalesTurnOver==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strSalesTurnOverFrom);
					hshValues.put("strConstValue",strSalesTurnOverTo);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strValuesin", strValuesin);

					boolSalesTurnOver1=false;
					boolSalesTurnOver1=getSalesTurnOver(hshValues);
					if(boolSalesTurnOver1==false)
					{
						continue;
					}
				}
				if(boolMinority==true)
				{
					hshValues=new HashMap();
					hshValues.put("strMinorityCode",strMinorityCode);
					hshValues.put("strMinorityValue",strMinorityValue);
					hshValues.put("strConstValue",strConstValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strLoanType", strLoanType);

					boolMinority1=false;
				    boolMinority1=getMinority(hshValues);
					if(boolMinority1==false)
					{
						continue;
					}
				}
				if(boolMinorityCommunity==true)
				{
					hshValues=new HashMap();
					hshValues.put("strMinorityCommunityCode",strMinorityCommunityCode);
					hshValues.put("strMinorityCommunityValue",strMinorityCommunityValue);
					hshValues.put("strConstValue",strConstValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strLoanType", strLoanType);

					boolMinorityCommunity1=false;
					boolMinorityCommunity1=getMinorityCommunity(hshValues);
					if(boolMinorityCommunity1==false)
					{
						continue;
					}
				}
				
				if(boolConstitution1==true && boolLoanAmount1==true && boolPlantandMachinery1==true && 
					boolFarmerCategory1==true && boolGovtScheme1==true && boolTotalLimit1==true &&
					boolCaste1==true && boolGender1==true && boolIrrigated1==true && boolDisplay1==true && boolphychall1 == true && boolSalesTurnOver1==true
					&& boolMinority1 == true &&boolMinorityCommunity1==true&& boolAlliedActivity1 == true )
				{
					boolStatus=true;
				}
				else
				{
					boolStatus=false;
				}
				if(boolStatus==true)
				{
					hshValues.put("boolpriority",Boolean.toString(boolStatus));
					hshValues.put("subsector",strSubsector);//Sub Sector
					return hshValues;
				}

			}
			if(boolStatus==false)
			{
				hshValues.put("boolpriority",Boolean.toString(boolStatus));
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getting Weaker Section Classification "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				if(rs1 != null)
					rs1.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshValues;
	}
	
	public boolean getPhysicalChallenged(HashMap hshValues) 
	{
		String strCode="";
		String strValue="";
		String strAppno="";
		strCode=Helper.correctNull((String)hshValues.get("strConstCode"));
		strValue=Helper.correctNull((String)hshValues.get("strConstValue"));
		strAppno=Helper.correctNull((String)hshValues.get("strAppno"));
		ResultSet rs=null;
		String strChkValue="";
		String strCheck="";
		String strQuery="";
		boolean boolValue=false;
		String strLoanType="";
		try
		{
			strLoanType=Helper.correctNull((String)hshValues.get("strLoanType"));
			
			strQuery = SQLParser.getSqlQuery("selmisstaticdata^20"+"^E"+"^"+strCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			strCheck= " and INDINFO_PHYSICALLY_CHALLANGED"+" "+ strCode +" "+"('" +strValue+"')";
			strQuery = SQLParser.getSqlQuery("selcustomerdata^"+strAppno+"^"+strCheck);	
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getting MIS Weaker section Classification -- Physically challenged "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return boolValue;	
	
	}
	public HashMap getPriorityClassification(HashMap hshActivity, String strValuesin)
	{
		HashMap hshValues=new HashMap();
		String strActivityCode="";
		String strActivitySno="";
		String strMisType="";
		String strSubsector="";
		String strClassiMaster_Sno="";
		String strConstCode="",strConstValue="";
		String strLoanAmtCode="",strLoanAmtValue="";
		String strLoanTenorCode="",strLoanTenorValue="";
		
		String strPlantandMacCode="",strPlantandMacValue="";
		String strFixedValCode="",strFixedValValue="";
		String strHLCode="",strHLValue="";
		
		String strBranchAreaCode="",strBranchAreaValue="";
		String strFaremerCategoryCode="",strFaremerCategoryValue="";
		String strGovtSchemeCode="",strGovtSchemeValue="";
		
		String strSHGCode="",strSHGValue="";
		String strBankSchemeCode="",strBankSchemeValue="";
		String strUtilizationCreditCode="",strUtilizationCreditValue="";
		
		String strFamilyIncomeCode="",strFamilyIncomeValue="";
		String strTotalLimitCode="",strTotalLimitValue="";
		String strTotalLimitServiceCode="",strTotalLimitServiceValue="";
		String strTotalLimitAgriCode="",strTotalLimitAgriValue="";

		String strSocialInfraCode="",strSocialInfraValue="";
		String strAgriAnciCode="",strAgriAnciValue="";
		String strRenewEnergyCode="",strRenewEnergyValue="";
		String strRenewEnergyIndvCode="",strRenewEnergyIndvValue="";
		String strAgriInfraCode="",strAgriInfraValue="";
		String strConstCostCode="",strConstCostValue="";
		String strSalesTurnOverFrom="",strSalesTurnOverTo="";
		
		String strstartup="",strcarpetcode="";
		String strcarpetvalue="",strfloorcode="";
		String strfloorvalue="",strindividualhouse="";
		String strSHGProposedloancode="",strSHGProposedloanvalue="",strdwellingcode="",strdwellingvalue="";
		String strAppno="";
		boolean boolpriority=false;
		String strClassificationType="";

		boolean boolStatus=false;
		ResultSet rs=null,rs1=null,rs2=null;
		strMisType="01";
		String subsector="";
		String strQuery="";
		String strLoanType="";
		String strFacilitySno="";
		String strExcep="$",strPostSancFlag="",strProcessDate="",strAppStatus="";
		try
		{
			strActivityCode=Helper.correctNull((String)hshActivity.get("strActivityCode"));
			strActivitySno=Helper.correctNull((String)hshActivity.get("strActivitySno"));
			strAppno=Helper.correctNull((String)hshActivity.get("strAppno"));
			strClassificationType=Helper.correctNull((String)hshActivity.get("strClassificationType"));
			strLoanType=Helper.correctNull((String)hshActivity.get("strLoanType"));
			strFacilitySno=Helper.correctNull((String)hshActivity.get("strFacilitySno"));
			
			strPostSancFlag=Helper.correctNull((String)hshActivity.get("strPostSancFlag"));
			strProcessDate=Helper.correctNull((String)hshActivity.get("strProcessDate"));
			strAppStatus=Helper.correctNull((String)hshActivity.get("strAppStatus"));
			String strReClassifyFlag=Helper.correctNull((String)hshActivity.get("strReclassification"));
			
			if(strClassificationType.equalsIgnoreCase("G"))
			{
				strActivityCode="000000";
				strActivitySno="0";
			}
			if(!strActivityCode.equalsIgnoreCase(""))
			{
			if((strPostSancFlag.equals("P")||strAppStatus.equalsIgnoreCase("PA")||strReClassifyFlag.equalsIgnoreCase("Y")) && !strProcessDate.equals(""))
			strQuery = SQLParser.getSqlQuery("getmismasterdata_ps^"+strMisType+"^"+strActivityCode+"^"+strActivitySno+"^"+strMisType+"^"+strActivitySno+"^"+strActivityCode+"^"+strProcessDate);
			else
			strQuery = SQLParser.getSqlQuery("getmismasterdata^"+strMisType+"^"+strActivityCode+"^"+strActivitySno+"^"+strMisType+"^"+strActivitySno+"^"+strActivityCode);
			rs=DBUtils.executeQuery(strQuery);
			/*rs2=DBUtils.executeQuery(strQuery);

			boolean bool=rs2.next();
			if(bool==false)
			{
				strExcep=strExcep+"The Activity Code is not linked with Priority classification";
				throw new Exception(strExcep);
			}*/
			while(rs.next())
			{
				strClassiMaster_Sno=Helper.correctNull((String)rs.getString("mis_sno"));
				strConstCode=Helper.correctNull((String)rs.getString("mis_constitutioncode"));
				strConstValue=Helper.correctNull((String)rs.getString("mis_constitutionvalue"));
				strLoanAmtCode=Helper.correctNull((String)rs.getString("mis_loanamtcode"));
				strLoanAmtValue=Helper.correctNull((String)rs.getString("mis_loanamtvalue"));
				strLoanTenorCode=Helper.correctNull((String)rs.getString("mis_loantenorcode"));
				strLoanTenorValue=Helper.correctNull((String)rs.getString("mis_loantenorvalue"));
				
				strPlantandMacCode=Helper.correctNull((String)rs.getString("mis_plantmaccode"));
				strPlantandMacValue=Helper.correctNull((String)rs.getString("mis_plantmacvalue"));
				strFixedValCode=Helper.correctNull((String)rs.getString("mis_fixedassetcode"));
				strFixedValValue=Helper.correctNull((String)rs.getString("mis_fixedassetvalue"));
				strHLCode=Helper.correctNull((String)rs.getString("mis_hlcode"));
				strHLValue=Helper.correctNull((String)rs.getString("mis_hlvalue"));
				
				strBranchAreaCode=Helper.correctNull((String)rs.getString("mis_branchlocationcode"));
				strBranchAreaValue=Helper.correctNull((String)rs.getString("mis_branchlocationvalue"));
				strFaremerCategoryCode=Helper.correctNull((String)rs.getString("mis_farmercode"));
				strFaremerCategoryValue=Helper.correctNull((String)rs.getString("mis_farmervalue"));
				strGovtSchemeCode=Helper.correctNull((String)rs.getString("mis_govtsposchcode"));
				strGovtSchemeValue=Helper.correctNull((String)rs.getString("mis_govtsposchvalue"));
				
				strSHGCode=Helper.correctNull((String)rs.getString("mis_shgcode"));
				strSHGValue=Helper.correctNull((String)rs.getString("mis_shgvalue"));
				strBankSchemeCode=Helper.correctNull((String)rs.getString("mis_bankschemecode"));
				strBankSchemeValue=Helper.correctNull((String)rs.getString("mis_bankschemevalue"));
				strUtilizationCreditCode=Helper.correctNull((String)rs.getString("mis_utilizationcode"));
				strUtilizationCreditValue=Helper.correctNull((String)rs.getString("mis_utilizationvalue"));
				
				strFamilyIncomeCode=Helper.correctNull((String)rs.getString("mis_faminccode"));
				strFamilyIncomeValue=Helper.correctNull((String)rs.getString("mis_famincvalue"));
				strTotalLimitCode=Helper.correctNull((String)rs.getString("mis_totallimitcode"));
				strTotalLimitValue=Helper.correctNull((String)rs.getString("mis_totallimitvalue"));
				strTotalLimitServiceCode=Helper.correctNull((String)rs.getString("mis_totalservicelimitcode"));
				strTotalLimitServiceValue=Helper.correctNull((String)rs.getString("mis_totalservicelimitvalue"));
				strTotalLimitAgriCode=Helper.correctNull((String)rs.getString("mis_totalagrilimitcode"));
				strTotalLimitAgriValue=Helper.correctNull((String)rs.getString("mis_totalagrilimitvalue"));

				strSocialInfraCode=Helper.correctNull((String)rs.getString("MIS_SOCIAL_INFRA_CODE"));
				strSocialInfraValue=Helper.correctNull((String)rs.getString("MIS_SOCIAL_INFRA_VALUE"));
				strAgriAnciCode=Helper.correctNull((String)rs.getString("MIS_AGRI_ANCI_CODE"));
				strAgriAnciValue=Helper.correctNull((String)rs.getString("MIS_AGRI_ANCI_VALUE"));
				strRenewEnergyCode=Helper.correctNull((String)rs.getString("MIS_RENEW_ENERGY_CODE"));
				strRenewEnergyValue=Helper.correctNull((String)rs.getString("MIS_RENEW_ENERGY_VALUE"));
				strRenewEnergyIndvCode=Helper.correctNull((String)rs.getString("MIS_RENEW_ENERGY_INDV_CODE"));
				strRenewEnergyIndvValue=Helper.correctNull((String)rs.getString("MIS_RENEW_ENERGY_INDV_VALUE"));
				strAgriInfraCode=Helper.correctNull((String)rs.getString("MIS_AGRI_INFRA_CODE"));
				strAgriInfraValue=Helper.correctNull((String)rs.getString("MIS_AGRI_INFRA_VALUE"));
				strConstCostCode=Helper.correctNull((String)rs.getString("MIS_CONST_COST_CODE"));
				strConstCostValue=Helper.correctNull((String)rs.getString("MIS_CONST_COST_VALUE"));
				

				strSubsector=Helper.correctNull((String)rs.getString("mis_subsector"));
				
				strSalesTurnOverFrom=Helper.correctNull((String)rs.getString("MIS_SALESFROMVALUE"));
				strSalesTurnOverTo=Helper.correctNull((String)rs.getString("MIS_SALESTOVALUE"));
				
				
				strstartup=Helper.correctNull((String)rs.getString("MIS_START_UP_CODE"));
				strcarpetcode=Helper.correctNull((String)rs.getString("MIS_CARPET_AREA_CODE"));
				strcarpetvalue=Helper.correctNull((String)rs.getString("MIS_CARPET_AREA_VALUE"));
				strfloorcode=Helper.correctNull((String)rs.getString("MIS_FLOOR_AREA_CODE"));
				strfloorvalue=Helper.correctNull((String)rs.getString("MIS_FLOOR_AREA_VALUE"));
				strindividualhouse=Helper.correctNull((String)rs.getString("MIS_INDIVIDUAL_HOUSE"));
				strSHGProposedloancode=Helper.correctNull((String)rs.getString("MIS_SHG_PROPOSED_LOAN_CODE"));
				strSHGProposedloanvalue=Helper.correctNull((String)rs.getString("MIS_SHG_PROPOSED_LOAN_VALUE"));
				strdwellingcode=Helper.correctNull((String)rs.getString("MIS_DWELLING_CODE"));
				strdwellingvalue=Helper.correctNull((String)rs.getString("MIS_DWELLING_VALUE"));
				boolean boolConstitution=false,boolConstitution1=true;
				boolean boolLoanAmount=false,boolLoanAmount1=true;
				boolean boolLoanTenor=false,boolLoanTenor1=true;
				boolean boolPlantandMachinery=false,boolPlantandMachinery1=true;
				boolean boolFixedValue=false,boolFixedValue1=true;
				boolean boolHLValue=false,boolHLValue1=true;
				boolean boolBranchArea=false,boolBranchArea1=true;
				boolean boolFarmerCategory=false,boolFarmerCategory1=true;
				boolean boolGovtScheme=false,boolGovtScheme1=true;
				boolean boolSHG=false,boolSHG1=true;
				boolean boolBankScheme=false,boolBankScheme1=true;
				boolean boolUtiliztionCredit=false,boolUtiliztionCredit1=true;
				boolean boolFamilyIncome=false,boolFamilyIncome1=true;
				boolean boolTotalLimit=false,boolTotalLimit1=true;
				boolean boolTotalServiceLimit=false,boolTotalServiceLimit1=true;
				boolean boolTotalAgriLimit=false,boolTotalAgriLimit1=true;

				boolean boolSocialInfra=false,boolSocialInfra1=true;
				boolean boolAgriAnci=false,boolAgriAnci1=true;
				boolean boolRenewEnergy=false,boolRenewEnergy1=true;
				boolean boolRenewEnergyIndv=false,boolRenewEnergyIndv1=true;
				boolean boolAgriInfra=false,boolAgriInfra1=true;
				boolean boolConstCost=false,boolConstCost1=true;
				
				boolean boolSalesTurnOver1=true,boolSalesTurnOver=false;

				boolean boolStartup1=true,boolStartup=false;
				boolean boolcarpet1=true,boolcarpet=false;
				boolean boolfloorarea1=true,boolfloorarea=false;
				boolean boolindividualhouse1=true,boolindividualhouse=false;
				boolean boolproposedSHG1=true,boolproposedSHG=false;
				boolean booldwellingunit1=true,booldwellingunit=false;
				
				if(! (strConstCode.equalsIgnoreCase("") || strConstValue.equalsIgnoreCase("") || strConstCode.equalsIgnoreCase("0") || strConstValue.length()==1))
				{
					boolConstitution=true;
				}
				if(! (strLoanAmtCode.equalsIgnoreCase("") || strLoanAmtValue.equalsIgnoreCase("") || strLoanAmtCode.equalsIgnoreCase("0") || strLoanAmtValue.equalsIgnoreCase("0")))
				{
					boolLoanAmount=true;
				}
				if(! (strLoanTenorCode.equalsIgnoreCase("") || strLoanTenorValue.equalsIgnoreCase("") || strLoanTenorCode.equalsIgnoreCase("0") || strLoanTenorValue.equalsIgnoreCase("0")))
				{
					boolLoanTenor=true;
				}
				if(! (strPlantandMacCode.equalsIgnoreCase("") || strPlantandMacValue.equalsIgnoreCase("") || strPlantandMacValue.equalsIgnoreCase("0")))
				{
					boolPlantandMachinery=true;
				}
				if(! (strFixedValCode.equalsIgnoreCase("") || strFixedValValue.equalsIgnoreCase("") || strFixedValValue.equalsIgnoreCase("0")))
				{
					boolFixedValue=true;
				}
				if(! (strHLCode.equalsIgnoreCase("") || strHLValue.equalsIgnoreCase("") || strHLCode.equalsIgnoreCase("0") || strHLValue.equalsIgnoreCase("0")))
				{
					boolHLValue=true;
				}
				if(! (strBranchAreaCode.equalsIgnoreCase("") || strBranchAreaValue.equalsIgnoreCase("") || strBranchAreaCode.equalsIgnoreCase("0") || strBranchAreaValue.length()==1))
				{
					boolBranchArea=true;
				}
				if(! (strFaremerCategoryCode.equalsIgnoreCase("") || strFaremerCategoryValue.equalsIgnoreCase("") || strFaremerCategoryCode.equalsIgnoreCase("0") || strFaremerCategoryValue.length()==1))
				{
					boolFarmerCategory=true;
				}
				if(! (strGovtSchemeCode.equalsIgnoreCase("") || strGovtSchemeValue.equalsIgnoreCase("") || strGovtSchemeCode.equalsIgnoreCase("0") || strGovtSchemeValue.length()==1))
				{
					boolGovtScheme=true;
				}
				if(! (strSHGCode.equalsIgnoreCase("") || strSHGValue.equalsIgnoreCase("") || strSHGCode.equalsIgnoreCase("0") || strSHGValue.equalsIgnoreCase("0")))
				{
					boolSHG=true;
				}
				if(! (strBankSchemeCode.equalsIgnoreCase("") || strBankSchemeValue.equalsIgnoreCase("") || strBankSchemeCode.equalsIgnoreCase("0") || strBankSchemeValue.length()==1))
				{
					boolBankScheme=true;
				}
				if(! (strUtilizationCreditCode.equalsIgnoreCase("") || strUtilizationCreditValue.equalsIgnoreCase("") || strUtilizationCreditCode.equalsIgnoreCase("0") || strUtilizationCreditValue.length()==1))
				{
					boolUtiliztionCredit=true;
				}
				if(! (strFamilyIncomeCode.equalsIgnoreCase("") || strFamilyIncomeValue.equalsIgnoreCase("") || strFamilyIncomeCode.equalsIgnoreCase("0") || strFamilyIncomeValue.equalsIgnoreCase("0")))
				{
					boolFamilyIncome=true;
				}
				if(! (strTotalLimitCode.equalsIgnoreCase("") || strTotalLimitValue.equalsIgnoreCase("") || strTotalLimitCode.equalsIgnoreCase("0") || strTotalLimitValue.equalsIgnoreCase("0")))
				{
					boolTotalLimit=true;
				}
				if(! (strTotalLimitServiceCode.equalsIgnoreCase("") || strTotalLimitServiceValue.equalsIgnoreCase("") ||  strTotalLimitServiceValue.equalsIgnoreCase("0")))
				{
					boolTotalServiceLimit=true;
				}
				if(! (strTotalLimitAgriCode.equalsIgnoreCase("") || strTotalLimitAgriValue.equalsIgnoreCase("") || strTotalLimitAgriCode.equalsIgnoreCase("0") || strTotalLimitAgriValue.equalsIgnoreCase("0")))
				{
					boolTotalAgriLimit=true;
				}
				if(! (strSocialInfraCode.equalsIgnoreCase("") || strSocialInfraValue.equalsIgnoreCase("") || strSocialInfraCode.equalsIgnoreCase("0") || strSocialInfraValue.equalsIgnoreCase("0")))
				{
					boolSocialInfra=true;
				}
				if(! (strAgriAnciCode.equalsIgnoreCase("") || strAgriAnciValue.equalsIgnoreCase("") || strAgriAnciCode.equalsIgnoreCase("0") || strAgriAnciValue.equalsIgnoreCase("0")))
				{
					boolAgriAnci=true;
				}
				if(! (strRenewEnergyCode.equalsIgnoreCase("") || strRenewEnergyValue.equalsIgnoreCase("") || strRenewEnergyCode.equalsIgnoreCase("0") || strRenewEnergyValue.equalsIgnoreCase("0")))
				{
					boolRenewEnergy=true;
				}
				if(! (strRenewEnergyIndvCode.equalsIgnoreCase("") || strRenewEnergyIndvValue.equalsIgnoreCase("") || strRenewEnergyIndvCode.equalsIgnoreCase("0") || strRenewEnergyIndvValue.equalsIgnoreCase("0")))
				{
					boolRenewEnergyIndv=true;
				}
				if(! (strAgriInfraCode.equalsIgnoreCase("") || strAgriInfraValue.equalsIgnoreCase("") || strAgriInfraCode.equalsIgnoreCase("0") || strAgriInfraValue.equalsIgnoreCase("0")))
				{
					boolAgriInfra=true;
				}
				if(! (strConstCostCode.equalsIgnoreCase("") || strConstCostValue.equalsIgnoreCase("") || strConstCostCode.equalsIgnoreCase("0") || strConstCostValue.equalsIgnoreCase("0")))
				{
					boolConstCost=true;
				}
				if(! (strSalesTurnOverFrom.equalsIgnoreCase("") || strSalesTurnOverFrom.equalsIgnoreCase("0") || strSalesTurnOverTo.equalsIgnoreCase("")|| strSalesTurnOverTo.equalsIgnoreCase("0")))
				{
					boolSalesTurnOver=true;
				}
				if(! (strcarpetcode.equalsIgnoreCase("") || strcarpetvalue.equalsIgnoreCase("") || strcarpetcode.equalsIgnoreCase("0") || strcarpetvalue.equalsIgnoreCase("0")))
				{
					boolcarpet=true;
				}
				if(! (strfloorcode.equalsIgnoreCase("") || strfloorvalue.equalsIgnoreCase("") || strfloorcode.equalsIgnoreCase("0") || strfloorvalue.equalsIgnoreCase("0")))
				{
					boolfloorarea=true;
				}
				if(! (strSHGProposedloancode.equalsIgnoreCase("") || strSHGProposedloanvalue.equalsIgnoreCase("") || strSHGProposedloancode.equalsIgnoreCase("0") || strSHGProposedloanvalue.equalsIgnoreCase("0")))
				{
					boolproposedSHG=true;
				}
				
				if(! (strstartup.equalsIgnoreCase("") || strstartup.equalsIgnoreCase("0")))
				{
					boolStartup=true;
				}
				if(! (strindividualhouse.equalsIgnoreCase("") || strindividualhouse.equalsIgnoreCase("0")))
				{
					boolindividualhouse=true;
				}
				if(! (strdwellingcode.equalsIgnoreCase("") || strdwellingvalue.equalsIgnoreCase("") || strdwellingcode.equalsIgnoreCase("0") || strdwellingvalue.equalsIgnoreCase("0")))
				{
					booldwellingunit=true;
				}
				
				if(boolConstitution==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strConstCode);
					hshValues.put("strConstValue",strConstValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strFacilitySno", strFacilitySno);
					boolConstitution1=false;
					boolConstitution1=getConstitution(hshValues);
					if(boolConstitution1==false)
					{
						continue;
					}
				}
				if(boolLoanAmount==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strLoanAmtCode);
					hshValues.put("strConstValue",strLoanAmtValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strValuesin", strValuesin);
					boolLoanAmount1=false;
					boolLoanAmount1=getLoanAmount(hshValues);
					if(boolLoanAmount1==false)
					{
						continue;
					}
				}
				if(boolFamilyIncome==true)
				{
					hshValues=new HashMap();
					hshValues.put("strSHGProposedloancode",strSHGProposedloancode);
					hshValues.put("strSHGProposedloanvalue",strSHGProposedloanvalue);
					hshValues.put("strFamilyIncomeCode",strFamilyIncomeCode);
					hshValues.put("strFamilyIncomeValue",strFamilyIncomeValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strValuesin", strValuesin);
					
					boolFamilyIncome1=false;
					boolFamilyIncome1=getFamilyIncomeofeachshgmember(hshValues);
					if(boolFamilyIncome1==false)
					{
						continue;
					}
				}
				if(boolLoanTenor==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strLoanTenorCode);
					hshValues.put("strConstValue",strLoanTenorValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strFacilitySno", strFacilitySno);					
					boolLoanTenor1=false;
					boolLoanTenor1=getLoanTenor(hshValues);
					if(boolLoanTenor1==false)
					{
						continue;
					}
				}
				if(boolPlantandMachinery==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strPlantandMacCode);
					hshValues.put("strConstValue",strPlantandMacValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strValuesin", strValuesin);
					boolPlantandMachinery1=false;
					boolPlantandMachinery1=getPlantandMachinery(hshValues);
					if(boolPlantandMachinery1==false)
					{
						continue;
					}
				}
				if(boolFixedValue==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strFixedValCode);
					hshValues.put("strConstValue",strFixedValValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strValuesin", strValuesin);
					boolFixedValue1=false;
					boolFixedValue1=getFixedValue(hshValues);
					if(boolFixedValue1==false)
					{
						continue;
					}
				}
				if(boolHLValue==true)
				{
					hshValues.put("strConstCode",strHLCode);
					hshValues.put("strConstValue",strHLValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strFacilitySno", strFacilitySno);
					//hshValues.put("strLoanType", strLoanType);
					//hshValues.put("strValuesin", strValuesin);
					boolHLValue1=false;
					boolHLValue1=getHLValue(hshValues); 
					if(boolHLValue1==false)
					{
						continue;
					}
				}
				if(boolBranchArea==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strBranchAreaCode);
					hshValues.put("strConstValue",strBranchAreaValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strFacilitySno", strFacilitySno);

					boolBranchArea1=false;
					boolBranchArea1=getBranchLocation(hshValues);
					if(boolBranchArea1==false)
					{
						continue;
					}
				}
				if(boolFarmerCategory==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strFaremerCategoryCode);
					hshValues.put("strConstValue",strFaremerCategoryValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strFacilitySno", strFacilitySno);
					boolFarmerCategory1=false;
					boolFarmerCategory1=getFarmerCategory(hshValues);
					if(boolFarmerCategory1==false)
					{
						continue;
					}
				}
				if(boolGovtScheme==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strGovtSchemeCode);
					hshValues.put("strConstValue",strGovtSchemeValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strLoanType", strLoanType);
					
					boolGovtScheme1=false;
					boolGovtScheme1=getGovernmentSponsersScheme(hshValues);
					if(boolGovtScheme1==false)
					{
						continue;
					}
				}
				if(boolSHG==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strSHGCode);
					hshValues.put("strConstValue",strSHGValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strValuesin", strValuesin);
					hshValues.put("strFacilitySno", strFacilitySno);
					boolSHG1=false;
					boolSHG1=getSHGValue(hshValues);
					if(boolSHG1==false)
					{
						continue;
					}
				}
				if(boolBankScheme==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strBankSchemeCode);
					hshValues.put("strConstValue",strBankSchemeValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strFacilitySno", strFacilitySno);
					
					boolBankScheme1=false;
					boolBankScheme1=getBankSchematicCode(hshValues);
					if(boolBankScheme1==false)
					{
						continue;
					}
				}
				if(boolUtiliztionCredit==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strUtilizationCreditCode);
					hshValues.put("strConstValue",strUtilizationCreditValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strFacilitySno", strFacilitySno);
					boolUtiliztionCredit1=false;
					boolUtiliztionCredit1=getUtilizationCredit(hshValues);
					if(boolUtiliztionCredit1==false)
					{
						continue;
					}
				}
				if(boolFamilyIncome==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strFamilyIncomeCode);
					hshValues.put("strConstValue",strFamilyIncomeValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strValuesin", strValuesin);
					
					boolFamilyIncome1=false;
					boolFamilyIncome1=getFamilyIncome(hshValues);
					if(boolFamilyIncome1==false)
					{
						continue;
					}
				}
				if(boolTotalLimit==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strTotalLimitCode);
					hshValues.put("strConstValue",strTotalLimitValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strValuesin", strValuesin);

					boolTotalLimit1=false;
					boolTotalLimit1=getTotalLimit(hshValues);
					if(boolTotalLimit1==false)
					{
						continue;
					}
				}
				if(boolTotalServiceLimit==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strTotalLimitServiceCode);
					hshValues.put("strConstValue",strTotalLimitServiceValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strValuesin", strValuesin);

					boolTotalServiceLimit1=false;
					hshValues.put("strFacilitySno",Helper.correctInt((String)hshActivity.get("strFacilitySno")));
					boolTotalServiceLimit1=getServiceTotalLimit(hshValues);
					if(boolTotalServiceLimit1==false)
					{
						continue;
					}
				}
				if(boolTotalAgriLimit==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strTotalLimitAgriCode);
					hshValues.put("strConstValue",strTotalLimitAgriValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strValuesin", strValuesin);

					boolTotalAgriLimit1=false;
					boolTotalAgriLimit1=getAgriTotalLimit(hshValues);
					if(boolTotalAgriLimit1==false)
					{
						continue;
					}
				}
				
				if(boolSocialInfra==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strSocialInfraCode);
					hshValues.put("strConstValue",strSocialInfraValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strValuesin", strValuesin);
					hshValues.put("strType", "APP_SOCIALINFRA");
					
					boolSocialInfra1=false;
					boolSocialInfra1=getClassiActivityLimit(hshValues);
					if(boolSocialInfra1==false)
					{
						continue;
					}
				}
				if(boolAgriAnci==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strAgriAnciCode);
					hshValues.put("strConstValue",strAgriAnciValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strValuesin", strValuesin);
					hshValues.put("strType", "APP_AGRIANCIACTIVITY");
					
					boolAgriAnci1=false;
					boolAgriAnci1=getClassiActivityLimit(hshValues);
					if(boolAgriAnci1==false)
					{
						continue;
					}
				}
				if(boolRenewEnergy==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strRenewEnergyCode);
					hshValues.put("strConstValue",strRenewEnergyValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strValuesin", strValuesin);
					hshValues.put("strType", "APP_RENEWENERGY");
					
					boolRenewEnergy1=false;
					boolRenewEnergy1=getClassiActivityLimit(hshValues);
					if(boolRenewEnergy1==false)
					{
						continue;
					}
				}
				if(boolRenewEnergyIndv==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strRenewEnergyIndvCode);
					hshValues.put("strConstValue",strRenewEnergyIndvValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strValuesin", strValuesin);
					hshValues.put("strType", "APP_RENEWENERGY_INDV");
					
					boolRenewEnergyIndv1=false;
					boolRenewEnergyIndv1=getClassiActivityLimit(hshValues);
					if(boolRenewEnergyIndv1==false)
					{
						continue;
					}
				}
				if(boolAgriInfra==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strAgriInfraCode);
					hshValues.put("strConstValue",strAgriInfraValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strValuesin", strValuesin);
					hshValues.put("strType", "APP_AGRIINFRA");
					
					boolAgriInfra1=false;
					boolAgriInfra1=getClassiActivityLimit(hshValues);
					if(boolAgriInfra1==false)
					{
						continue;
					}
				}
				if(boolConstCost==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strConstCostCode);
					hshValues.put("strConstValue",strConstCostValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strValuesin", strValuesin);
					
					boolConstCost1=false;
					boolConstCost1=getCostofConstruction(hshValues);
					if(boolConstCost1==false)
					{
						continue;
					}
				}
				
				if(boolSalesTurnOver==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strSalesTurnOverFrom);
					hshValues.put("strConstValue",strSalesTurnOverTo);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strValuesin", strValuesin);

					boolSalesTurnOver1=false;
					boolSalesTurnOver1=getSalesTurnOver(hshValues);
					if(boolSalesTurnOver1==false)
					{
						continue;
					}
				}
				//=========================added for priority sector guidlineses==================//
				if(boolStartup==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strstartup);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strValuesin", strValuesin);

					boolStartup1=false;
					boolStartup1=getStartUp(hshValues);
					if(boolStartup1==false)
					{
						continue;
					}
				}
				if(boolcarpet==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strcarpetcode);
					hshValues.put("strConstValue",strcarpetvalue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strValuesin", strValuesin);

					boolcarpet1=false;
					boolcarpet1=getCarpetArea(hshValues);
					if(boolcarpet1==false)
					{
						continue;
					}
				}
				if(boolfloorarea==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strfloorcode);
					hshValues.put("strConstValue",strfloorvalue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strValuesin", strValuesin);

					boolfloorarea1=false;
					boolfloorarea1=getFloorArea(hshValues);
					if(boolfloorarea1==false)
					{
						continue;
					}
				}
				if(boolindividualhouse==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strindividualhouse);
					//hshValues.put("strConstValue",strindividualhouse);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strValuesin", strValuesin);

					boolindividualhouse1=false;
					boolindividualhouse1=getIndividualHouse(hshValues);
					if(boolindividualhouse1==false)
					{
						continue;
					}
				}
				if(boolproposedSHG==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strSHGProposedloancode);
					hshValues.put("strConstValue",strSHGProposedloanvalue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strValuesin", strValuesin);

					boolproposedSHG1=false;
					boolproposedSHG1=getSHGProposedLoan(hshValues);
					if(boolproposedSHG1==false)
					{
						continue;
					}
				}
				
				if(booldwellingunit==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strdwellingcode);
					hshValues.put("strConstValue",strdwellingvalue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strValuesin", strValuesin);

					booldwellingunit1=false;
					booldwellingunit1=getDwellingunit(hshValues);
					if(booldwellingunit1==false)
					{
						continue;
					}
				}
				
				if(boolConstitution1==true && boolLoanAmount1==true && boolLoanTenor1==true && (boolPlantandMachinery1==true || boolFixedValue1==true) && 
						boolHLValue1==true && boolBranchArea1==true && boolFarmerCategory1==true && boolGovtScheme1==true && boolSHG1==true && boolBankScheme1==true &&
						boolUtiliztionCredit1==true && boolFamilyIncome1==true && boolTotalLimit1==true && boolTotalServiceLimit1==true && boolTotalAgriLimit1==true &&
						boolSocialInfra1==true && boolAgriAnci1==true && boolRenewEnergy1==true && boolRenewEnergyIndv1==true && boolAgriInfra1==true 
						&& boolSalesTurnOver1==true && boolStartup1==true && boolcarpet1==true && boolfloorarea1==true && boolindividualhouse1==true 
						&& boolproposedSHG1==true&& booldwellingunit1==true)
				{
					boolStatus=true;
				}
				else
				{
					boolStatus=false;
				}
				if(boolStatus==true)
				{
					
					hshValues.put("boolpriority",Boolean.toString(boolStatus));
					hshValues.put("prioritytype","01");//Priority Sector
					hshValues.put("subsector",strSubsector);//Sub Sector
					hshValues.put("Master_Sno",strClassiMaster_Sno);//S.no
					

					return hshValues;
				}

			}
			if(boolStatus==false)
			{
				hshValues.put("boolpriority",Boolean.toString(boolStatus));
			}
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getting Priority Classification "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				if(rs1 != null)
					rs1.close();
				if(rs2 != null)
					rs2.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshValues;
	}
	public HashMap getGovtAnnounceScheme(HashMap hshActivity, String strValuesin)
	{
		HashMap hshValues=new HashMap();
		String strActivityCode="";
		String strActivitySno="";
		String strMisType="";
		String strSubsector="";
		String strLoanAmtCode="",strLoanAmtValue="";
		String strPlantandMacCode="",strPlantandMacValue="";
		String strFixedValCode="",strFixedValValue="";
		
		String strQueryAvail = "",strSancAmt="0";
		ResultSet rsAvail = null;
		
		String strAppno="";
		boolean boolpriority=false;
		String strClassificationType="";
		
		boolean boolStatus=false;
		ResultSet rs=null,rs1=null,rs2=null;
		strMisType="08";
		String subsector="";
		String strQuery="";
		String strLoanType="";
		String strFacilitySno="";
		String strExcep="$",strPostSancFlag="",strProcessDate="",strAppStatus="";
		String strSalesTurnOverFrom="",strSalesTurnOverTo="";
		try
		{
			strAppno=Helper.correctNull((String)hshActivity.get("strAppno"));
			strClassificationType=Helper.correctNull((String)hshActivity.get("strClassificationType"));
			strLoanType=Helper.correctNull((String)hshActivity.get("strLoanType"));
			strFacilitySno=Helper.correctNull((String)hshActivity.get("strFacilitySno"));
			
			strPostSancFlag=Helper.correctNull((String)hshActivity.get("strPostSancFlag"));
			strProcessDate=Helper.correctNull((String)hshActivity.get("strProcessDate"));
			strAppStatus=Helper.correctNull((String)hshActivity.get("strAppStatus"));
			String strReClassifyFlag=Helper.correctNull((String)hshActivity.get("strReclassification"));
			
			strActivityCode="000000";
			strActivitySno="0";
			if(!strActivityCode.equalsIgnoreCase(""))
			{
				if((strPostSancFlag.equals("P")||strAppStatus.equalsIgnoreCase("PA")||strReClassifyFlag.equalsIgnoreCase("Y")) && !strProcessDate.equals(""))
				strQuery = SQLParser.getSqlQuery("getmismasterdata_ps^"+strMisType+"^"+strActivityCode+"^"+strActivitySno+"^"+strMisType+"^"+strActivitySno+"^"+strActivityCode+"^"+strProcessDate);
				else
				strQuery = SQLParser.getSqlQuery("getmismasterdata^"+strMisType+"^"+strActivityCode+"^"+strActivitySno+"^"+strMisType+"^"+strActivitySno+"^"+strActivityCode);
				rs=DBUtils.executeQuery(strQuery);

				while(rs.next())
				{
					strLoanAmtCode=Helper.correctNull((String)rs.getString("mis_loanamtcode"));
					strLoanAmtValue=Helper.correctNull((String)rs.getString("mis_loanamtvalue"));
					strPlantandMacCode=Helper.correctNull((String)rs.getString("mis_plantmaccode"));
					strPlantandMacValue=Helper.correctNull((String)rs.getString("mis_plantmacvalue"));
					strFixedValCode=Helper.correctNull((String)rs.getString("mis_fixedassetcode"));
					strFixedValValue=Helper.correctNull((String)rs.getString("mis_fixedassetvalue"));

					strSubsector=Helper.correctNull((String)rs.getString("mis_subsector"));
					
					strSalesTurnOverFrom=Helper.correctNull((String)rs.getString("MIS_SALESFROMVALUE"));
					strSalesTurnOverTo=Helper.correctNull((String)rs.getString("MIS_SALESTOVALUE"));
					
					boolean boolLoanAmount=false,boolLoanAmount1=true;
					boolean boolPlantandMachinery=false,boolPlantandMachinery1=true;
					boolean boolFixedValue=false,boolFixedValue1=true;
					boolean boolSalesTurnOver1=true,boolSalesTurnOver=false;
					
					if(! (strLoanAmtCode.equalsIgnoreCase("") || strLoanAmtValue.equalsIgnoreCase("") || strLoanAmtCode.equalsIgnoreCase("0") || strLoanAmtValue.equalsIgnoreCase("0")))
					{
						boolLoanAmount=true;
					}
					if(! (strPlantandMacCode.equalsIgnoreCase("") || strPlantandMacValue.equalsIgnoreCase("") || strPlantandMacValue.equalsIgnoreCase("0")))
					{
						boolPlantandMachinery=true;
					}
					if(! (strFixedValCode.equalsIgnoreCase("") || strFixedValValue.equalsIgnoreCase("") || strFixedValValue.equalsIgnoreCase("0")))
					{
						boolFixedValue=true;
					}
					if(! (strSalesTurnOverFrom.equalsIgnoreCase("") || strSalesTurnOverFrom.equalsIgnoreCase("0") || strSalesTurnOverTo.equalsIgnoreCase("")|| strSalesTurnOverTo.equalsIgnoreCase("0")))
					{
						boolSalesTurnOver=true;
					}
					
					if(boolLoanAmount==true)
					{
						hshValues=new HashMap();
						hshValues.put("strConstCode",strLoanAmtCode);
						hshValues.put("strConstValue",strLoanAmtValue);
						hshValues.put("strAppno", strAppno);
						hshValues.put("strLoanType", strLoanType);
						hshValues.put("strFacilitySno", strFacilitySno);
						hshValues.put("strValuesin", strValuesin);
						hshValues.put("applicantid", Helper.correctNull((String)hshActivity.get("applicantid")));
						
						String strCodes="";
						if(rsAvail!=null)
						{
							rsAvail.close();
						}
						strQuery = SQLParser.getSqlQuery("selagriindcodes");
						rsAvail = DBUtils.executeQuery(strQuery);
						if(rsAvail.next())
						{
							strCodes=Helper.correctNull(rsAvail.getString("codes"));
						}
						
						String strArr[]=strCodes.split("@");
						if(strArr!=null && strArr.length>=1)
						{
							for(int i=0;i<strArr.length;i++)
							{
								if(Helper.correctNull((String)hshActivity.get("AgriIndcode")).equalsIgnoreCase(strArr[i]))
								{
									if(rsAvail!=null)
									{
										rsAvail.close();
									}
									if(strLoanType.equalsIgnoreCase("P"))
										strQueryAvail = SQLParser.getSqlQuery("sel_sancamtretail_avail^"+strAppno);
									else
										strQueryAvail = SQLParser.getSqlQuery("sel_sancamt_avail^"+strAppno+"^"+strFacilitySno);
									rsAvail = DBUtils.executeQuery(strQueryAvail);
									if(rsAvail.next())
									{
										strSancAmt = Helper.correctNull((String)rsAvail.getString("sancamt"));
									}
									else
									{								
										strSancAmt = "0";
									}
								}
							}
						}
						
						
						hshValues.put("strSancAmt", strSancAmt);
						boolLoanAmount1=false;
						boolLoanAmount1=getLoanAmountMicroLimit(hshValues);
						if(boolLoanAmount1==false)
						{
							continue;
						}
					}
					
					if(boolPlantandMachinery==true)
					{
						hshValues=new HashMap();
						hshValues.put("strConstCode",strPlantandMacCode);
						hshValues.put("strConstValue",strPlantandMacValue);
						hshValues.put("strAppno", strAppno);
						hshValues.put("strFacilitySno", strFacilitySno);
						hshValues.put("strLoanType", strLoanType);
						hshValues.put("strValuesin", strValuesin);
						boolPlantandMachinery1=false;
						boolPlantandMachinery1=getPlantandMachinery(hshValues);
						if(boolPlantandMachinery1==false)
						{
							continue;
						}
					}
					
					if(boolFixedValue==true)
					{
						hshValues=new HashMap();
						hshValues.put("strConstCode",strFixedValCode);
						hshValues.put("strConstValue",strFixedValValue);
						hshValues.put("strAppno", strAppno);
						hshValues.put("strFacilitySno", strFacilitySno);
						hshValues.put("strLoanType", strLoanType);
						hshValues.put("strValuesin", strValuesin);
						boolFixedValue1=false;
						boolFixedValue1=getFixedValue(hshValues);
						if(boolFixedValue1==false)
						{
							continue;
						}
					}
					if(boolSalesTurnOver==true)
					{
						hshValues=new HashMap();
						hshValues.put("strConstCode",strSalesTurnOverFrom);
						hshValues.put("strConstValue",strSalesTurnOverTo);
						hshValues.put("strAppno", strAppno);
						hshValues.put("strFacilitySno", strFacilitySno);
						hshValues.put("strLoanType", strLoanType);
						hshValues.put("strValuesin", strValuesin);

						boolSalesTurnOver1=false;
						boolSalesTurnOver1=getSalesTurnOver(hshValues);
						if(boolSalesTurnOver1==false)
						{
							continue;
						}
					}
					
					if(boolLoanAmount1==true && (boolPlantandMachinery1==true || boolFixedValue1==true) && boolSalesTurnOver1==true)
					{
						boolStatus=true;
					}
					else
					{
						boolStatus=false;
					}
					if(boolStatus==true)
					{						
						hshValues.put("boolpriority",Boolean.toString(boolStatus));
						hshValues.put("prioritytype","01");//Priority Sector
						hshValues.put("subsector",strSubsector);//Sub Sector
						return hshValues;
					}
					
				}
				if(boolStatus==false)
				{
					hshValues.put("boolpriority",Boolean.toString(boolStatus));
				}
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getting Priority Classification "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
				rs.close();
			if(rs1 != null)
				rs1.close();
			if(rs2 != null)
				rs2.close();
			
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshValues;
	}
	
	public boolean getCostofConstruction(HashMap hshValues) 
	{
		String strCode="";
		String strValue="";
		String strAppno="";
		strCode=Helper.correctNull((String)hshValues.get("strConstCode"));
		strValue=Helper.correctNull((String)hshValues.get("strConstValue"));
		strAppno=Helper.correctNull((String)hshValues.get("strAppno"));
		ResultSet rs=null;
		String strChkValue="";
		String strCheck="";
		String strQuery="";
		String strLoanType="";
		String strValuesin="";
		boolean boolValue=false;
		try
		{
			
			strLoanType=Helper.correctNull((String) hshValues.get("strLoanType"));
			strValuesin=Helper.correctNull((String) hshValues.get("strValuesin"));
			
			if(!strLoanType.equalsIgnoreCase("P"))
			{
				if(!strValuesin.equalsIgnoreCase("R"))
				{
					strValue=Helper.convertSetupToApplicationValues(strValuesin, Double.parseDouble((String)Helper.correctNull(strValue)));
				}
			}

			strQuery = SQLParser.getSqlQuery("selmisstaticdata^19"+"^E"+"^"+strCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
			}
			if(rs!=null)
			{
				rs.close();
			}
					
			strCheck= " and LOAN_COSTLOANPRD "+strCode+" "+strValue;
			
			if(rs!=null)rs.close();
			if(strLoanType.equalsIgnoreCase("P"))
			{
				strQuery = SQLParser.getSqlQuery("sel_costofconstruction^"+strAppno+"^"+strCheck);	
			}
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getting Family Income "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return boolValue;		
	
	}
	public HashMap getNonPriorityClassification(HashMap hshActivity, String strValuesin)
	{
		HashMap hshValues=new HashMap();
		String strActivityCode="";
		String strActivitySno="";
		String strAppno="";
		String strMisType="";
		String strQuery="";
		String strClassiMaster_Sno="";
		String strPlantandMacCode="",strPlantandMacValue="";
		boolean boolpriority=false;
		ResultSet rs=null,rs1=null;
		String strExcep="$";
		strMisType="02";
		boolean boolStatus=false;
		String strSubsector="";
		String strLoanType="";
		String strFacilitySno="",strPostSancFlag="",strProcessDate="",strAppStatus="";
		String strSalesTurnOverFrom="",strSalesTurnOverTo="";

		String strstartup="",strcarpetcode="";
		String strcarpetvalue="",strfloorcode="";
		String strfloorvalue="",strindividualhouse="";
		String strSHGProposedloancode="",strSHGProposedloanvalue="";
		try
		{
			strActivityCode=Helper.correctNull((String)hshActivity.get("strActivityCode"));
			strActivitySno=Helper.correctNull((String)hshActivity.get("strActivitySno"));
			strLoanType=Helper.correctNull((String)hshActivity.get("strLoanType"));
			strFacilitySno=Helper.correctNull((String)hshActivity.get("strFacilitySno"));
			strAppno=Helper.correctNull((String)hshActivity.get("strAppno"));
			
			strPostSancFlag=Helper.correctNull((String)hshActivity.get("strPostSancFlag"));
			strProcessDate=Helper.correctNull((String)hshActivity.get("strProcessDate"));
			strAppStatus=Helper.correctNull((String)hshActivity.get("strAppStatus"));
			String strReClassifyFlag=Helper.correctNull((String)hshActivity.get("strReclassification"));
			
			
			
			if((strPostSancFlag.equals("P")||strAppStatus.equalsIgnoreCase("PA")||strReClassifyFlag.equalsIgnoreCase("Y")) && !strProcessDate.equals(""))
			strQuery = SQLParser.getSqlQuery("getmismasterdata_ps^"+strMisType+"^"+strActivityCode+"^"+strActivitySno+"^"+strMisType+"^"+strActivitySno+"^"+strActivityCode+"^"+strProcessDate);
			else
			strQuery = SQLParser.getSqlQuery("getmismasterdata^"+strMisType+"^"+strActivityCode+"^"+strActivitySno+"^"+strMisType+"^"+strActivitySno+"^"+strActivityCode);
			rs=DBUtils.executeQuery(strQuery);
			rs1=DBUtils.executeQuery(strQuery);

			boolean bool=rs1.next();
			if(bool==false)
			{
				strExcep=strExcep+"The Activity Code is not linked with Non Priority classification";
				throw new Exception(strExcep);
			}
			while(rs.next())
			{
				strClassiMaster_Sno=Helper.correctNull((String)rs.getString("mis_sno"));
				strPlantandMacCode=Helper.correctNull((String)rs.getString("mis_plantmaccode"));
				strPlantandMacValue=Helper.correctNull((String)rs.getString("mis_plantmacvalue"));
				
				strSubsector=Helper.correctNull((String)rs.getString("mis_subsector"));
				
				strSalesTurnOverFrom=Helper.correctNull((String)rs.getString("MIS_SALESFROMVALUE"));
				strSalesTurnOverTo=Helper.correctNull((String)rs.getString("MIS_SALESTOVALUE"));


				strstartup=Helper.correctNull((String)rs.getString("MIS_START_UP_CODE"));
				strcarpetcode=Helper.correctNull((String)rs.getString("MIS_CARPET_AREA_CODE"));
				strcarpetvalue=Helper.correctNull((String)rs.getString("MIS_CARPET_AREA_VALUE"));
				strfloorcode=Helper.correctNull((String)rs.getString("MIS_FLOOR_AREA_CODE"));
				strfloorvalue=Helper.correctNull((String)rs.getString("MIS_FLOOR_AREA_VALUE"));
				strindividualhouse=Helper.correctNull((String)rs.getString("MIS_INDIVIDUAL_HOUSE"));
				strSHGProposedloancode=Helper.correctNull((String)rs.getString("MIS_SHG_PROPOSED_LOAN_CODE"));
				strSHGProposedloanvalue=Helper.correctNull((String)rs.getString("MIS_SHG_PROPOSED_LOAN_VALUE"));
				
				
				boolean boolPlantandMachinery=false,boolPlantandMachinery1=true;
				boolean boolSalesTurnOver1=true,boolSalesTurnOver=false;
				boolean boolStartup1=true,boolStartup=false;
				boolean boolcarpet1=true,boolcarpet=false;
				boolean boolfloorarea1=true,boolfloorarea=false;
				boolean boolindividualhouse1=true,boolindividualhouse=false;
				boolean boolproposedSHG1=true,boolproposedSHG=false;
				
				if(! (strPlantandMacCode.equalsIgnoreCase("") || strPlantandMacValue.equalsIgnoreCase("") || strPlantandMacValue.equalsIgnoreCase("0")))
				{
					boolPlantandMachinery=true;
				}
				if(! (strSalesTurnOverFrom.equalsIgnoreCase("") || strSalesTurnOverFrom.equalsIgnoreCase("0") || strSalesTurnOverTo.equalsIgnoreCase("")|| strSalesTurnOverTo.equalsIgnoreCase("0")))
				{
					boolSalesTurnOver=true;
				}
				if(! (strcarpetcode.equalsIgnoreCase("") || strcarpetvalue.equalsIgnoreCase("") || strcarpetcode.equalsIgnoreCase("0") || strcarpetvalue.equalsIgnoreCase("0")))
				{
					boolcarpet=true;
				}
				if(! (strfloorcode.equalsIgnoreCase("") || strfloorvalue.equalsIgnoreCase("") || strfloorcode.equalsIgnoreCase("0") || strfloorvalue.equalsIgnoreCase("0")))
				{
					boolfloorarea=true;
				}
				if(! (strSHGProposedloancode.equalsIgnoreCase("") || strSHGProposedloanvalue.equalsIgnoreCase("") || strSHGProposedloancode.equalsIgnoreCase("0") || strSHGProposedloanvalue.equalsIgnoreCase("0")))
				{
					boolproposedSHG=true;
				}
				
				if(! (strstartup.equalsIgnoreCase("") || strstartup.equalsIgnoreCase("0")))
				{
					boolStartup=true;
				}
				if(! (strindividualhouse.equalsIgnoreCase("") || strindividualhouse.equalsIgnoreCase("0")))
				{
					boolindividualhouse=true;
				}
				if(boolPlantandMachinery==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strPlantandMacCode);
					hshValues.put("strConstValue",strPlantandMacValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strValuesin", strValuesin);
					
					boolPlantandMachinery1=false;
					boolPlantandMachinery1=getPlantandMachinery(hshValues);
				}
				if(boolSalesTurnOver==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strSalesTurnOverFrom);
					hshValues.put("strConstValue",strSalesTurnOverTo);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strValuesin", strValuesin);

					boolSalesTurnOver1=false;
					boolSalesTurnOver1=getSalesTurnOver(hshValues);
					if(boolSalesTurnOver1==false)
					{
						continue;
					}
				}
				//=========================added for priority sector guidlineses==================//
				if(boolStartup==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strstartup);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strValuesin", strValuesin);

					boolStartup1=false;
					boolStartup1=getStartUp(hshValues);
					if(boolStartup1==false)
					{
						continue;
					}
				}
				if(boolcarpet==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strcarpetcode);
					hshValues.put("strConstValue",strcarpetvalue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strValuesin", strValuesin);

					boolcarpet1=false;
					boolcarpet1=getCarpetArea(hshValues);
					if(boolcarpet1==false)
					{
						continue;
					}
				}
				if(boolfloorarea==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strfloorcode);
					hshValues.put("strConstValue",strfloorvalue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strValuesin", strValuesin);

					boolfloorarea1=false;
					boolfloorarea1=getFloorArea(hshValues);
					if(boolfloorarea1==false)
					{
						continue;
					}
				}
				if(boolindividualhouse==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strindividualhouse);
					//hshValues.put("strConstValue",strindividualhouse);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strValuesin", strValuesin);

					boolindividualhouse1=false;
					boolindividualhouse1=getIndividualHouse(hshValues);
					if(boolindividualhouse1==false)
					{
						continue;
					}
				}
				if(boolproposedSHG==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strSHGProposedloancode);
					hshValues.put("strConstValue",strSHGProposedloanvalue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strFacilitySno", strFacilitySno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strValuesin", strValuesin);

					boolproposedSHG1=false;
					boolproposedSHG1=getSHGProposedLoan(hshValues);
					if(boolproposedSHG1==false)
					{
						continue;
					}
				}
				if(boolPlantandMachinery1==true && boolSalesTurnOver1==true && boolStartup1==true && boolcarpet1==true && boolfloorarea1==true && boolindividualhouse1==true 
						&& boolproposedSHG1==true)
				{
					boolStatus=true;
				}
				else
				{
					boolStatus=false;
				}
				if(boolStatus==true)
				{
					hshValues.put("boolpriority",Boolean.toString(boolStatus));
					hshValues.put("prioritytype","02");//Non Priority Sector
					hshValues.put("subsector",strSubsector);//Sub Sector
					hshValues.put("Master_Sno",strClassiMaster_Sno);//S.No
					return hshValues;
				}
			}
			if(boolStatus==false)
			{
				hshValues.put("boolpriority",Boolean.toString(boolStatus));
				hshValues.put("prioritytype","02");//Non Priority Sector
			}	
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getting Non Priority Classification "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				if(rs1 != null)
					rs1.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshValues;
	}
	public HashMap getSensitiveSector(HashMap hshActivity , String strValuesin)
	{

		HashMap hshValues=new HashMap();
		ResultSet rs=null,rs1=null;
		try
		{
			String strActivityCode="";
			String strActivitySno="";
			String strMisType="04";
			String strSubsector="100";
			String strAppno="";
			String strQuery="";
			String strExcep="$";
			boolean boolStatus=false;
			String strConstCode="",strConstValue="";
			String strBankSchemeCode="",strBankSchemeValue="";
			String strStaffSchemeCode="",strStaffSchemeValue="";
			String strSecurityTypeCode="",strSecurityTypeValue="";
			String strSecurityNameCode="",strSecurityNameValue="";
			String strShareBrokerCode="",strShareBrokerValue="";
			String strCRECode="",strCREValue="";

			strActivityCode=Helper.correctNull((String)hshActivity.get("strActivityCode"));
			strActivitySno=Helper.correctNull((String)hshActivity.get("strActivitySno"));
			strAppno=Helper.correctNull((String)hshActivity.get("strAppno"));
			String strClassificationType="";
			String strLoanType="",strFacilitySno="",strPostSancFlag="",strProcessDate="",strAppStatus="";
			
			/*strQuery = SQLParser.getSqlQuery("getmismasterdata^"+strMisType+"^"+strActivityCode+"^"+strActivitySno+"^"+strMisType+"^"+strActivitySno+"^"+strActivityCode);
			rs1=DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				strActivityCode=strActivityCode;
				strActivitySno=strActivitySno;
			}
			else
			{
				strActivityCode="000000";
				strActivitySno="0";
			}*/

			strLoanType=Helper.correctNull((String)hshActivity.get("strLoanType"));
			strFacilitySno=Helper.correctNull((String)hshActivity.get("strFacilitySno"));
			strClassificationType=Helper.correctNull((String)hshActivity.get("strSensitiveClassificationType"));
			
			strPostSancFlag=Helper.correctNull((String)hshActivity.get("strPostSancFlag"));
			strProcessDate=Helper.correctNull((String)hshActivity.get("strProcessDate"));
			strAppStatus=Helper.correctNull((String)hshActivity.get("strAppStatus"));
			String strReClassifyFlag=Helper.correctNull((String)hshActivity.get("strReclassification"));
			
			if(strClassificationType.equalsIgnoreCase("G"))
			{
				strActivityCode="000000";
				strActivitySno="0";
			}
			if((strPostSancFlag.equals("P")||strAppStatus.equalsIgnoreCase("PA")||strReClassifyFlag.equalsIgnoreCase("Y")) && !strProcessDate.equals(""))
			strQuery = SQLParser.getSqlQuery("getmismasterdata_ps^"+strMisType+"^"+strActivityCode+"^"+strActivitySno+"^"+strMisType+"^"+strActivitySno+"^"+strActivityCode+"^"+strProcessDate);
			else
			strQuery = SQLParser.getSqlQuery("getmismasterdata^"+strMisType+"^"+strActivityCode+"^"+strActivitySno+"^"+strMisType+"^"+strActivitySno+"^"+strActivityCode);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				strConstCode=Helper.correctNull((String)rs.getString("mis_constitutioncode"));
				strConstValue=Helper.correctNull((String)rs.getString("mis_constitutionvalue"));
				
				strBankSchemeCode=Helper.correctNull((String)rs.getString("mis_bankschemecode"));
				strBankSchemeValue=Helper.correctNull((String)rs.getString("mis_bankschemevalue"));
				
				strStaffSchemeCode=Helper.correctNull((String)rs.getString("mis_staffcode"));
				strStaffSchemeValue=Helper.correctNull((String)rs.getString("mis_staffval"));
				
				strSecurityTypeCode=Helper.correctNull((String)rs.getString("mis_securitytypecode"));
				strSecurityTypeValue=Helper.correctNull((String)rs.getString("mis_securitytypevalue"));
				strSecurityNameCode=Helper.correctNull((String)rs.getString("mis_securitynamecode"));
				strSecurityNameValue=Helper.correctNull((String)rs.getString("mis_securitynamevalue"));
				
				strShareBrokerCode=Helper.correctNull((String)rs.getString("mis_sharebrokercode"));
				strShareBrokerValue=Helper.correctNull((String)rs.getString("mis_sharebrokervalue"));
				
				strCRECode=Helper.correctNull((String)rs.getString("MIS_CRECODE"));
				strCREValue=Helper.correctNull((String)rs.getString("MIS_CREVALUE"));
				
				
				strSubsector=Helper.correctNull((String)rs.getString("mis_subsector"));
				
				boolean boolConstitution=false,boolConstitution1=true;
				boolean boolBankScheme=false,boolBankScheme1=true;
				boolean boolStaffScheme=false,boolStaffScheme1=true;
				boolean boolSecurity=false,boolSecurity1=true;
				boolean boolShareBroker=false,boolShareBroker1=true;
				boolean boolCRE=false,boolCRE1=true;


				
				
				if(! (strConstCode.equalsIgnoreCase("") || strConstValue.equalsIgnoreCase("") || strConstCode.equalsIgnoreCase("0") || strConstValue.length()==1))
				{
					boolConstitution=true;
				}
				
				if(! (strBankSchemeCode.equalsIgnoreCase("") || strBankSchemeValue.equalsIgnoreCase("") || strBankSchemeCode.equalsIgnoreCase("0") || strBankSchemeValue.length()==1))
				{
					boolBankScheme=true;
				}
				if(! (strStaffSchemeCode.equalsIgnoreCase("") || strStaffSchemeValue.equalsIgnoreCase("") || strStaffSchemeCode.equalsIgnoreCase("0") || strStaffSchemeValue.equalsIgnoreCase("0")))
				{
					boolStaffScheme=true;
				}
				if(! ((strSecurityNameCode.equalsIgnoreCase("") || strSecurityNameValue.equalsIgnoreCase("") || strSecurityNameCode.equalsIgnoreCase("0") || strSecurityNameValue.equalsIgnoreCase("0"))
						&& (strSecurityTypeCode.equalsIgnoreCase("") || strSecurityTypeValue.equalsIgnoreCase("") || strSecurityTypeCode.equalsIgnoreCase("0") || strSecurityTypeValue.equalsIgnoreCase("0"))))
				{
					boolSecurity=true;
				}
				if(! (strShareBrokerCode.equalsIgnoreCase("") || strShareBrokerValue.equalsIgnoreCase("") || strShareBrokerCode.equalsIgnoreCase("0") || strShareBrokerValue.equalsIgnoreCase("0")))
				{
					boolShareBroker=true;
				}
				if(! (strCRECode.equalsIgnoreCase("") || strCREValue.equalsIgnoreCase("") || strCRECode.equalsIgnoreCase("0") || strCREValue.equalsIgnoreCase("0")))
				{
					boolCRE=true;
				}
				
				if(boolConstitution==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strConstCode);
					hshValues.put("strConstValue",strConstValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strFacilitySno", strFacilitySno);
					
					boolConstitution1=false;
					boolConstitution1=getConstitution(hshValues);
					if(boolConstitution1==false)
					{
						continue;
					}
				}
				if(boolBankScheme==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strBankSchemeCode);
					hshValues.put("strConstValue",strBankSchemeValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strFacilitySno", strFacilitySno);
					
					boolBankScheme1=false;
					boolBankScheme1=getBankSchematicCode(hshValues);
					if(boolBankScheme1==false)
					{
						continue;
					}
				}
				
				
				if(boolSecurity==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strSecurityTypeCode);
					hshValues.put("strConstValue",strSecurityTypeValue);

					hshValues.put("strConstCode1",strSecurityNameCode);
					hshValues.put("strConstValue1",strSecurityNameValue);
					
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strFacilitySno", strFacilitySno);
					
					boolSecurity1=false;
					boolSecurity1=getSecurityCode(hshValues);
					if(boolSecurity1==false)
					{
						continue;
					}
				}
				
				if(boolStaffScheme==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strStaffSchemeCode);
					hshValues.put("strConstValue",strStaffSchemeValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);

					boolStaffScheme1=false;
					boolStaffScheme1=getStaffscheme(hshValues);
					if(boolStaffScheme1==false)
					{
						continue;
					}
				}
				if(boolShareBroker==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strShareBrokerCode);
					hshValues.put("strConstValue",strShareBrokerValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strFacilitySno", strFacilitySno);
					
					boolShareBroker1=false;
					boolShareBroker1=getShareBroker(hshValues);
					if(boolShareBroker1==false)
					{
						continue;
					}
				}
				if(boolCRE==true)
				{
					hshValues=new HashMap();
					hshValues.put("strConstCode",strCRECode);
					hshValues.put("strConstValue",strCREValue);
					hshValues.put("strAppno", strAppno);
					hshValues.put("strLoanType", strLoanType);
					hshValues.put("strFacilitySno", strFacilitySno);
					
					boolCRE1=false;
					boolCRE1=getCRE(hshValues);
					if(boolCRE1==false)
					{
						continue;
					}
				}
				
				if(boolConstitution1==true && boolBankScheme1==true && boolStaffScheme1==true && boolSecurity1==true && boolShareBroker1==true && boolCRE1==true)
				{
					boolStatus=true;
				}
				else
				{
					boolStatus=false;
				}
				if(boolStatus==true)
				{
					hshValues.put("boolpriority",Boolean.toString(boolStatus));
					hshValues.put("subsector",strSubsector);//Sub Sector
					return hshValues;
				}

			}
			if(boolStatus==false)
			{
				hshValues.put("boolpriority",Boolean.toString(boolStatus));
			}
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getting Sensitive Sector "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				if(rs1 != null)
					rs1.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshValues;
	}
	public boolean getConstitution(HashMap hshRecord)
	{
		String strCode="";
		String strValue="";
		String strAppno="";
		strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
		strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
		strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
		ResultSet rs=null;
		String strChkValue="";
		String strCheck="";
		String strQuery="";
		String strLoanType="";
		String strFacilitySno="";
		boolean boolValue=false;
		try
		{
			
			strLoanType=Helper.correctNull((String)hshRecord.get("strLoanType"));
			strFacilitySno=Helper.correctNull((String)hshRecord.get("strFacilitySno"));
			
			strQuery = SQLParser.getSqlQuery("selmisstaticdata^20"+"^E"+"^"+strCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			StringTokenizer st=new StringTokenizer(strValue,"@");
			while(st.hasMoreElements()){
				strChkValue+="'";
				strChkValue+=(String)st.nextElement();
				strChkValue+="',";
			}
			int intLength=strChkValue.length();
			intLength=--intLength;
			strValue=strChkValue.substring(0,intLength);
			
			strCheck= " and perapp_constitution"+" "+ strCode +" "+"(" +strValue+")";
			if(strLoanType.equalsIgnoreCase("P"))
			{
				strQuery = SQLParser.getSqlQuery("selconstitution^"+strAppno+"^"+strCheck);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("selconstitutioncorp^"+strAppno+"^"+strFacilitySno+"^"+strCheck);
			}
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getting MIS Priority Classification "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return boolValue;
	}
	public boolean getUtilizationCredit(HashMap hshRecord)
	{

		String strCode="";
		String strValue="";
		String strAppno="";
		strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
		strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
		strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
		ResultSet rs=null;
		String strChkValue="";
		String strCheck="";
		String strQuery="";
		boolean boolValue=false;
		String strFacilitySno="",strCheck1="";
		
		
		try
		{
			strFacilitySno=Helper.correctNull((String)hshRecord.get("strFacilitySno"));
			strQuery = SQLParser.getSqlQuery("selmisstaticdata^20"+"^E"+"^"+strCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			StringTokenizer st=new StringTokenizer(strValue,"@");
			while(st.hasMoreElements()){
				strChkValue+="'";
				strChkValue+=(String)st.nextElement();
				strChkValue+="',";
			}
			int intLength=strChkValue.length();
			intLength=--intLength;
			strValue=strChkValue.substring(0,intLength);
			
			
			strCheck= " and app_place"+" "+ strCode +" "+"(" +strValue+")"+" "+strCheck;
			
			strQuery = SQLParser.getSqlQuery("selmisappdetails^"+strAppno+"^"+strFacilitySno+"^"+strCheck);
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getting MIS Priority Classification "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();	
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return boolValue;
	
	}
	public boolean getCaste(HashMap hshRecord)
	{

		String strCode="";
		String strValue="";
		String strAppno="";
		strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
		strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
		strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
		ResultSet rs=null;
		String strChkValue="";
		String strCheck="";
		String strQuery="";
		boolean boolValue=false;
		String  strLoanType="";
		try
		{
			strLoanType=Helper.correctNull((String)hshRecord.get("strLoanType"));
			strQuery = SQLParser.getSqlQuery("selmisstaticdata^20"+"^E"+"^"+strCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			StringTokenizer st=new StringTokenizer(strValue,"@");
			while(st.hasMoreElements()){
				strChkValue+="'";
				strChkValue+=(String)st.nextElement();
				strChkValue+="',";
			}
			int intLength=strChkValue.length();
			intLength=--intLength;
			strValue=strChkValue.substring(0,intLength);
			
			strCheck= " and indinfo_caste"+" "+ strCode +" "+"(" +strValue+")";
			if(strLoanType.equalsIgnoreCase("P"))
			{
				strQuery = SQLParser.getSqlQuery("selcustomerdata^"+strAppno+"^"+strCheck);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("selcustomerdatacorp^"+strAppno+"^"+strCheck);
			}
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getting MIS Priority Classification "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();	
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return boolValue;
	}
	public boolean getFarmerCategory(HashMap hshRecord)
	{
		String strCode="";
		String strValue="";
		String strAppno="";
		strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
		strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
		strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
		ResultSet rs=null;
		String strChkValue="";
		String strCheck="";
		String strQuery="";
		String strFacilitySno="";
		boolean boolValue=false;
		try
		{
			
			strFacilitySno=Helper.correctNull((String)hshRecord.get("strFacilitySno"));
			strQuery = SQLParser.getSqlQuery("selmisstaticdata^20"+"^E"+"^"+strCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			StringTokenizer st=new StringTokenizer(strValue,"@");
			while(st.hasMoreElements()){
				strChkValue+="'";
				strChkValue+=(String)st.nextElement();
				strChkValue+="',";
			}
			int intLength=strChkValue.length();
			intLength=--intLength;
			strValue=strChkValue.substring(0,intLength);
			
			strCheck= " and app_farmercategory"+" "+ strCode +" "+"(" +strValue+")";
			strQuery = SQLParser.getSqlQuery("selmisappdisplayscreendetails^"+strAppno+"^"+strFacilitySno+"^"+strCheck);
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getting MIS Priority Classification "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return boolValue;
	}
	public boolean getDisplayScreen(HashMap hshRecord)
	{
		String strCode="";
		String strValue="";
		String strAppno="";
		strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
		strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
		strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
		ResultSet rs=null;
		String strChkValue="";
		String strCheck="";
		String strQuery="";
		boolean boolValue=false;
		String strFacilitySno="";
		try
		{
			
			strFacilitySno=Helper.correctNull((String)hshRecord.get("strFacilitySno"));
//			strQuery = SQLParser.getSqlQuery("selmisstaticdata^20"+"^E"+"^"+strCode);
//			rs=DBUtils.executeQuery(strQuery);
//			if(rs.next())
//			{
//				strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
//			}
			
			if(strCode.equalsIgnoreCase("1"))
				strCode = "like";
			else if(strCode.equalsIgnoreCase("2"))
				strCode = "not like";
			
			if(rs!=null)
			{
				rs.close();
			}
			StringTokenizer st=new StringTokenizer(strValue,"@");
			while(st.hasMoreElements()){
//				strChkValue+="'";
//				strChkValue+=(String)st.nextElement();
//				strChkValue+="',";
				if(strChkValue.equalsIgnoreCase(""))
					strChkValue = "app_dispscreen " +strCode+ "('%"+(String)st.nextElement()+"%')";
				else
					strChkValue = strChkValue + " or app_dispscreen " +strCode+ "('%"+(String)st.nextElement()+"%')";
			}
//			int intLength=strChkValue.length();
//			intLength=--intLength;
//			strValue=strChkValue.substring(0,intLength);
			
			strCheck= " and ("+strChkValue+")";
			strQuery = SQLParser.getSqlQuery("selmisappdetails^"+strAppno+"^"+strFacilitySno+"^"+strCheck);
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getting MIS Priority Classification "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return boolValue;
	}
	public boolean getGender(HashMap hshRecord)
	{
		String strCode="";
		String strValue="";
		String strAppno="";
		strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
		strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
		strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
		ResultSet rs=null;
		String strChkValue="";
		String strCheck="";
		String strQuery="";
		boolean boolValue=false;
		String strLoanType="";
		String strFacilitySno="";

		try
		{

			strLoanType=Helper.correctNull((String)hshRecord.get("strLoanType"));
			strFacilitySno=Helper.correctNull((String)hshRecord.get("strFacilitySno"));

			strQuery = SQLParser.getSqlQuery("selmisstaticdata^20"+"^E"+"^"+strCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			StringTokenizer st=new StringTokenizer(strValue,"@");
			while(st.hasMoreElements()){
				strChkValue+="'";
				strChkValue+=(String)st.nextElement();
				strChkValue+="',";
			}
			int intLength=strChkValue.length();
			intLength=--intLength;
			strValue=strChkValue.substring(0,intLength);
			
			strCheck= " and perapp_sex"+" "+ strCode +" "+"(" +strValue+")";
			
			if(strLoanType.equalsIgnoreCase("P"))
			{
				strQuery = SQLParser.getSqlQuery("selconstitution^"+strAppno+"^"+strCheck);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("selconstitutioncorp^"+strAppno+"^"+strFacilitySno+"^"+strCheck);	
			}	
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getting MIS Priority Classification "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return boolValue;
	}
	public boolean getManagementGender(HashMap hshRecord)
	{
		String strCode="";
		String strValue="";
		String strAppno="";
		String strLoanType="";
		strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
		strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
		strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
		strLoanType=Helper.correctNull((String)hshRecord.get("strLoanType"));
		ResultSet rs=null;
		String strChkValue="";
		String strCheck="";
		String strQuery="";
		boolean boolValue=false;
		try
		{
			strQuery = SQLParser.getSqlQuery("selmisstaticdata^20"+"^E"+"^"+strCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			StringTokenizer st=new StringTokenizer(strValue,"@");
			while(st.hasMoreElements()){
				strChkValue+="'";
				strChkValue+=(String)st.nextElement();
				strChkValue+="',";
			}
			int intLength=strChkValue.length();
			intLength=--intLength;
			strValue=strChkValue.substring(0,intLength);
			
			strCheck= " and perapp_title"+" "+ strCode +" "+"(" +strValue+")";
			if(strLoanType.equals("P"))
				strQuery = SQLParser.getSqlQuery("sel_mngmntgendervalue_retail^"+strAppno+"^"+strCheck);
			else
				strQuery = SQLParser.getSqlQuery("sel_mngmntgendervalue^"+strAppno+"^"+strCheck);
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getting MIS Priority Classification "+e.getMessage());
		}


		finally
		{
			try
			{	
				if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return boolValue;
	}
	public boolean getGovernmentSponsersScheme(HashMap hshRecord)
	{
		String strCode="";
		String strValue="";
		String strAppno="";
		strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
		strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
		strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
		ResultSet rs=null;
		String strChkValue="";
		String strCheck="";
		String strQuery="";
		String strLoanType="";
		String strFacilitySno="";
		boolean boolValue=false;
		strLoanType=Helper.correctNull((String)hshRecord.get("strLoanType"));

		try
		{
			
			strFacilitySno=Helper.correctNull((String)hshRecord.get("strFacilitySno"));
			strQuery = SQLParser.getSqlQuery("selmisstaticdata^20"+"^E"+"^"+strCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			StringTokenizer st=new StringTokenizer(strValue,"@");
			while(st.hasMoreElements()){
				strChkValue+="'";
				strChkValue+=(String)st.nextElement();
				strChkValue+="',";
			}
			int intLength=strChkValue.length();
			intLength=--intLength;
			strValue=strChkValue.substring(0,intLength);
			
			if(strLoanType.equalsIgnoreCase("P"))
			{
				strCheck= " and govt_scheme"+" "+ strCode +" "+"(" +strValue+")";
				strQuery = SQLParser.getSqlQuery("selconstitution^"+strAppno+"^"+strCheck);	
			}
			else
			{
				strCheck= " and facility_schemetype"+" "+ strCode +" "+"(" +strValue+")";
				strQuery = SQLParser.getSqlQuery("selconstitutioncorp^"+strAppno+"^"+strFacilitySno+"^"+strCheck);
			}
			
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getting MIS Priority Classification "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return boolValue;
	}
	public boolean getSecurityValue(HashMap hshRecord)
	{
		String strCode="";
		String strValue="";
		String strAppno="";
		strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
		strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
		strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
		ResultSet rs=null;
		String strChkValue="";
		String strCheck="";
		String strQuery="";
		boolean boolValue=false;
		try
		{
			
			StringTokenizer st=new StringTokenizer(strValue,"@");
			while(st.hasMoreElements()){
				strChkValue+="'";
				strChkValue+=(String)st.nextElement();
				strChkValue+="',";
			}
			int intLength=strChkValue.length();
			intLength=--intLength;
			strValue=strChkValue.substring(0,intLength);
			
			strCheck= " and perapp_constitution"+" "+ strCode +" "+"(" +strValue+")";
			strQuery = SQLParser.getSqlQuery("selconstitution^"+strAppno+"^"+strCheck);
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getting MIS Priority Classification "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return boolValue;	
	}
	public boolean getBankSchematicCode(HashMap hshRecord)
	{
		String strCode="";
		String strValue="";
		String strAppno="";
		strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
		strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
		strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
		ResultSet rs=null;
		String strChkValue="";
		String strCheck="";
		String strQuery="";
		String strLoanType="";
		String strFacilitySno="";
		boolean boolValue=false;
		try
		{
			strLoanType=Helper.correctNull((String)hshRecord.get("strLoanType"));
			strFacilitySno=Helper.correctNull((String)hshRecord.get("strFacilitySno"));

			strQuery = SQLParser.getSqlQuery("selmisstaticdata^20"+"^E"+"^"+strCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			StringTokenizer st=new StringTokenizer(strValue,"@");
			while(st.hasMoreElements()){
				strChkValue+="'";
				strChkValue+=(String)st.nextElement();
				strChkValue+="',";
			}
			int intLength=strChkValue.length();
			intLength=--intLength;
			strValue=strChkValue.substring(0,intLength);
			
			if(strLoanType.equalsIgnoreCase("P"))
			{
				strCheck= " and prd_bankscheme"+" "+ strCode +" "+"(" +strValue+")";
				strQuery = SQLParser.getSqlQuery("selBankschematiccode^"+strAppno+"^"+strCheck);	
			}
			else
			{
				strCheck= " and com_bankscheme"+" "+ strCode +" "+"(" +strValue+")";
				strQuery = SQLParser.getSqlQuery("selBankschematiccodecorp^"+strAppno+"^"+strFacilitySno+"^"+strCheck);
			}
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getting Bank Schematic Code "+e.getMessage());
		}

		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return boolValue;	
	}
	public boolean getSector(HashMap hshRecord) 
	{

		String strCode="";
		String strValue="";
		String strAppno="";
		strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
		strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
		strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
		ResultSet rs=null;
		String strChkValue="";
		String strCheck="";
		String strQuery="";
		boolean boolValue=false;
		String strPrioritySubSector=Helper.correctNull((String)hshRecord.get("strPrioritySubSector"));
		try
		{
			strQuery = SQLParser.getSqlQuery("selmisstaticdata^20"+"^E"+"^"+strCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			StringTokenizer st=new StringTokenizer(strValue,"@");
			while(st.hasMoreElements()){
				//strChkValue+="'";
				strChkValue=(String)st.nextElement();
				//strChkValue+="',";
				if(strChkValue.equalsIgnoreCase(strPrioritySubSector))
				{
					boolValue=true;
					break;
				}
			}
		/*	int intLength=strChkValue.length();
			intLength=--intLength;
			strValue=strChkValue.substring(0,intLength);
			
			strCheck= " and app_subsector"+" "+ strCode +" "+"(" +strValue+")";
			strQuery = SQLParser.getSqlQuery("selmisappclassification^"+strAppno+"^"+strCheck);
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}*/
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getting MIS Priority Classification "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return boolValue;	
	
	}
	public boolean getStaffscheme(HashMap hshRecord) 
	{
		String strCode="";
		String strValue="";
		String strAppno="";
		strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
		strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
		strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
		ResultSet rs=null;
		String strChkValue="";
		String strCheck="";
		String strQuery="";
		boolean boolValue=false;
		String strLoanType="";
		try
		{
			strLoanType=Helper.correctNull((String)hshRecord.get("strLoanType"));
			
			strQuery = SQLParser.getSqlQuery("selmisstaticdata^20"+"^E"+"^"+strCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			StringTokenizer st=new StringTokenizer(strValue,"@");
			while(st.hasMoreElements()){
				strChkValue+="'";
				strChkValue+=(String)st.nextElement();
				strChkValue+="',";
			}
			int intLength=strChkValue.length();
			intLength=--intLength;
			strValue=strChkValue.substring(0,intLength);
			//where app_no=demo_appno and app_no='05130000064' and demo_type='a' 
			//and demo_appid=perapp_id and perapp_id=indinfo_appid  and indinfo_is_staff in (800)
			if(strLoanType.equalsIgnoreCase("P"))
			{
				strCheck= " and indinfo_is_staff"+" "+ strCode +" "+"(" +strValue+")";
				strQuery = SQLParser.getSqlQuery("selcustomerdata^"+strAppno+"^"+strCheck);	
			}
			else
			{
				strCheck= " and indinfo_is_staff"+" "+ strCode +" "+"(" +strValue+")";
				strQuery = SQLParser.getSqlQuery("selcustomerdatacorp^"+strAppno+"^"+strCheck);				
			}
			
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getting MIS Priority Classification "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return boolValue;	
	}
	public boolean getBranchLocation(HashMap hshRecord)
	{

		String strCode="";
		String strValue="";
		String strAppno="";
		strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
		strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
		strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
		ResultSet rs=null;
		String strChkValue="";
		String strCheck="";
		String strQuery="";
		String strLoanType="";
		String strFacilitySno="";
		boolean boolValue=false;
		try
		{
			
			strLoanType=Helper.correctNull((String)hshRecord.get("strLoanType"));
			strFacilitySno=Helper.correctNull((String)hshRecord.get("strFacilitySno"));

			strQuery = SQLParser.getSqlQuery("selmisstaticdata^20"+"^E"+"^"+strCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			StringTokenizer st=new StringTokenizer(strValue,"@");
			while(st.hasMoreElements()){
				strChkValue+="'";
				strChkValue+=(String)st.nextElement();
				strChkValue+="',";
			}
			int intLength=strChkValue.length();
			intLength=--intLength;
			strValue=strChkValue.substring(0,intLength);
			
			strCheck= " and org_branchin"+" "+ strCode +" "+"(" +strValue+")";
			
			if(strLoanType.equalsIgnoreCase("P"))
			{
				strQuery = SQLParser.getSqlQuery("selconstitution^"+strAppno+"^"+strCheck);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("selconstitutioncorp^"+strAppno+"^"+strFacilitySno+"^"+strCheck);
			}
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getting MIS Priority Classification "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return boolValue;	
	}
	public boolean getLoanAmount(HashMap hshRecord) 
	{
		String strCode="";
		String strValue="";
		String strAppno="";
		strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
		strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
		strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
		ResultSet rs=null;
		String strChkValue="";
		String strCheck="";
		String strQuery="";
		String strLoanType="";
		String strFacilitySno="";
		String strValuesin="";
		boolean boolValue=false;
		try
		{
			
			strLoanType=Helper.correctNull((String) hshRecord.get("strLoanType"));
			strFacilitySno=Helper.correctNull((String) hshRecord.get("strFacilitySno"));
			strValuesin=Helper.correctNull((String) hshRecord.get("strValuesin"));
			
			if(!strLoanType.equalsIgnoreCase("P"))
			{
				if(!strValuesin.equalsIgnoreCase("R"))
				{
					strValue=Helper.convertSetupToApplicationValues(strValuesin, Double.parseDouble((String)Helper.correctNull(strValue)));
				}
			}

			
			strQuery = SQLParser.getSqlQuery("selmisstaticdata^19"+"^E"+"^"+strCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			
			if(strLoanType.equalsIgnoreCase("P"))
			{
				strCheck= " and loan_recmdamt"+" "+ strCode +" "+strValue;
				strQuery = SQLParser.getSqlQuery("selconstitution^"+strAppno+"^"+strCheck);
			}
			else
			{
				strCheck= " and facility_sancamt"+" "+ strCode +" "+strValue;
				strQuery = SQLParser.getSqlQuery("selconstitutioncorp^"+strAppno+"^"+strFacilitySno+"^"+strCheck);				
			}
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getting MIS Priority Classification "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return boolValue;	
	}
	public boolean getLoanAmountMicroLimit(HashMap hshRecord) 
	{
		String strCode="";
		String strValue="";
		String strAppno="";
		String strTotalLimit="";
		String strAppOldID="";
		String strAgriCode="'7','11','22','26'";
		double dblTotAmount=0.00;
		strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
		strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
		strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
		ResultSet rs=null;
		String strChkValue="";
		String strCheck="";
		String strQuery="";
		String strLoanType="";
		String strFacilitySno="";
		String strValuesin="";
		boolean boolValue=false;
		String appprocessDate="",appstatus="";
		String desc="";
		try
		{
			
			strLoanType=Helper.correctNull((String) hshRecord.get("strLoanType"));
			strFacilitySno=Helper.correctNull((String) hshRecord.get("strFacilitySno"));
			strValuesin=Helper.correctNull((String) hshRecord.get("strValuesin"));
			
			strQuery = SQLParser.getSqlQuery("selmisstaticdata^19"+"^E"+"^"+strCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			strQuery=SQLParser.getSqlQuery("select_perappoldid^"+Helper.correctNull((String)hshRecord.get("applicantid")));
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strAppOldID=Helper.correctNull((String)rs.getString("perapp_oldid"));
			}
			
			strQuery=SQLParser.getSqlQuery("sel_productcode^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				appstatus=Helper.correctNull((String)rs.getString("app_status"));
				if(Helper.correctNull((String)rs.getString("app_status")).equals("op")||Helper.correctNull((String)rs.getString("app_status")).equals("ol"))
				{
					appprocessDate=Helper.correctNull((String)rs.getString("app_createdate"));
				}
				else
				{
					appprocessDate=Helper.correctNull((String)rs.getString("app_processdate"));	
				}
			}
			desc="and APP_CREATEDATE <=(to_date('"+appprocessDate+"','dd/mm/yyyy')+1)";

			if(!strAppOldID.equalsIgnoreCase(""))
			{
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("sel_borrowertotallimitagr_serv_newprop^"+strAppOldID+"^"+strAgriCode+"^"+desc);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					dblTotAmount=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
				}
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("seltotagriliability_serv_newprop^"+strAppOldID+"^"+strAgriCode+"^"+desc);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					dblTotAmount=dblTotAmount+Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
				}
			}
			dblTotAmount=dblTotAmount+Double.parseDouble(Helper.correctDouble((String)hshRecord.get("strSancAmt")));

			strTotalLimit=Helper.convertSetupToApplicationValues(strValuesin,dblTotAmount);
			
			strQuery = SQLParser.getSqlQuery("selGovtschemeDual^"+strTotalLimit+"^"+strCode+"^"+strValue);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getting MIS Priority Classification "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
				rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return boolValue;	
	}
	public boolean getLoanTenor(HashMap hshRecord) 
	{
		String strCode="";
		String strValue="";
		String strAppno="";
		strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
		strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
		strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
		ResultSet rs=null;
		String strChkValue="";
		String strCheck="";
		String strQuery="";
		String strLoanType="";
		String strFacilitySno="";
		boolean boolValue=false;
		try
		{
			strLoanType=Helper.correctNull((String)hshRecord.get("strLoanType"));
			strFacilitySno=Helper.correctNull((String)hshRecord.get("strFacilitySno"));

			strQuery = SQLParser.getSqlQuery("selmisstaticdata^19"+"^E"+"^"+strCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			if(strLoanType.equalsIgnoreCase("P"))
			{

				strCheck= " and loan_reqterms"+" "+ strCode +" "+strValue;
				strQuery = SQLParser.getSqlQuery("selconstitution^"+strAppno+"^"+strCheck);	
			}
			else
			{
				strCheck= " and facility_months"+" "+ strCode +" "+strValue;
				strQuery = SQLParser.getSqlQuery("selconstitutioncorp^"+strAppno+"^"+strFacilitySno+"^"+strCheck);
			}
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getting MIS Priority Classification "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return boolValue;	
	}
	public boolean getPlantandMachinery(HashMap hshRecord) 
	{
		String strCode="";
		String strValue="";
		String strAppno="";
		strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
		strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
		strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
		ResultSet rs=null;
		String strChkValue="";
		String strCheck="";
		String strQuery="";
		String strFacilitySno="";
		boolean boolValue=false;
		String strValuesin="";
		String strLoanType="";
		try
		{
			strValuesin=Helper.correctNull((String) hshRecord.get("strValuesin"));
			
			if(!strLoanType.equalsIgnoreCase("P"))
			{
				if(!strValuesin.equalsIgnoreCase("R"))
				{
					strValue=Helper.convertSetupToApplicationValues(strValuesin, Double.parseDouble((String)Helper.correctNull(strValue)));
				}
			}

			strFacilitySno=Helper.correctNull((String)hshRecord.get("strFacilitySno"));
//			strQuery = SQLParser.getSqlQuery("selmisstaticdata^19"+"^E"+"^"+strCode);
//			rs=DBUtils.executeQuery(strQuery);
//			if(rs.next())
//			{
//				strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
//			}
//			if(rs!=null)
//			{
//				rs.close();
//			}
			
			strCheck= " and app_plantval between"+" "+ strCode +" and "+strValue;
			strQuery = SQLParser.getSqlQuery("selmisappdisplayscreendetails^"+strAppno+"^"+strFacilitySno+"^"+strCheck);
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getting MIS Priority Classification "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return boolValue;		
	}
	
	public boolean getCRE(HashMap hshRecord) 
	{
		String strCode="";
		String strValue="";
		String strAppno="";
		strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
		strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
		strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
		ResultSet rs=null;
		String strChkValue="";
		String strCheck="";
		String strQuery="";
		String strFacilitySno="";
		boolean boolValue=false;
		String strValuesin="";
		String strLoanType="";
		try
		{
			strFacilitySno=Helper.correctNull((String)hshRecord.get("strFacilitySno"));
			strQuery = SQLParser.getSqlQuery("selmisstaticdata^19"+"^E"+"^"+strCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			strCheck= " and APP_CRE_PERCNT"+" "+ strCode +" "+strValue;
			strQuery = SQLParser.getSqlQuery("selmisappdisplayscreendetails^"+strAppno+"^"+strFacilitySno+"^"+strCheck);
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getting MIS Priority Classification "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return boolValue;		
	}

	public boolean getFamilyIncome(HashMap hshRecord) 
	{

		String strCode="";
		String strValue="";
		String strAppno="";
		strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
		strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
		strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
		ResultSet rs=null;
		String strChkValue="";
		String strCheck="";
		String strQuery="";
		String strLoanType="";
		String strValuesin="";
		boolean boolValue=false;
		try
		{
			
			strLoanType=Helper.correctNull((String) hshRecord.get("strLoanType"));
			strValuesin=Helper.correctNull((String) hshRecord.get("strValuesin"));
			
			if(!strLoanType.equalsIgnoreCase("P"))
			{
				if(!strValuesin.equalsIgnoreCase("R"))
				{
					strValue=Helper.convertSetupToApplicationValues(strValuesin, Double.parseDouble((String)Helper.correctNull(strValue)));
				}
			}

			strQuery = SQLParser.getSqlQuery("selmisstaticdata^19"+"^E"+"^"+strCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			double dblIncome=0.00;
			String strEmployment="";
			String strNetSal="";
			String strITRSal="";
			if(strLoanType.equalsIgnoreCase("P"))
			{
				strQuery = SQLParser.getSqlQuery("sel_incomeret^"+strAppno);	
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("sel_Incomecorp^"+strAppno);	
			}
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strEmployment=Helper.correctNull((String)rs.getString("perapp_employment"));
				strNetSal=Helper.correctNull((String)rs.getString("perinc_takehome"));
				strITRSal=Helper.correctNull((String)rs.getString("perinc_year1_income"));
			}
			if(strEmployment.equalsIgnoreCase("1") || strEmployment.equalsIgnoreCase("1"))
			{
				dblIncome=dblIncome+Double.parseDouble((String)Helper.correctDouble((String)strNetSal));
			}
			else
			{
				dblIncome=dblIncome+Double.parseDouble((String)Helper.correctDouble((String)strITRSal));
			}
			
			String strPlus="+";
			strValue=strValue +" "+"group by app_no";
			
		//	strCheck= " and indinfo_family_income"+" "+ strCode +" "+strValue;
			
			strCheck= " having sum (indinfo_family_income"+ " "+ strPlus + " " +dblIncome+")"+" "+ strCode +" "+strValue;


			if(strLoanType.equalsIgnoreCase("P"))
			{
				strQuery = SQLParser.getSqlQuery("selcustomerdata^"+strAppno+"^"+strCheck);	
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("selcustomerdatacorp^"+strAppno+"^"+strCheck);
			}
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getting Family Income "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return boolValue;		
	}
	public boolean getFixedValue(HashMap hshRecord) 
	{

		String strCode="";
		String strValue="";
		String strAppno="";
		strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
		strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
		strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
		ResultSet rs=null;
		String strChkValue="";
		String strCheck="";
		String strQuery="";
		boolean boolValue=false;
		String strFacilitySno="";
		String strValuesin="";
		String strLoanType="";
		try
		{
			strValuesin=Helper.correctNull((String) hshRecord.get("strValuesin"));
			
			if(!strLoanType.equalsIgnoreCase("P"))
			{
				if(!strValuesin.equalsIgnoreCase("R"))
				{
					strValue=Helper.convertSetupToApplicationValues(strValuesin, Double.parseDouble((String)Helper.correctNull(strValue)));
				}
			}
			strFacilitySno=Helper.correctNull((String)hshRecord.get("strFacilitySno"));
//			strQuery = SQLParser.getSqlQuery("selmisstaticdata^19"+"^E"+"^"+strCode);
//			rs=DBUtils.executeQuery(strQuery);
//			if(rs.next())
//			{
//				strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
//			}
//			if(rs!=null)
//			{
//				rs.close();
//			}
			
			strCheck= " and app_equipval between"+" "+ strCode +" and "+strValue;
			strQuery = SQLParser.getSqlQuery("selmisappdisplayscreendetails^"+strAppno+"^"+strFacilitySno+"^"+strCheck);
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getting MIS Priority Classification "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return boolValue;		
	}
	public boolean getHLValue(HashMap hshRecord) 
	{

		String strCode="";
		String strValue="";
		String strAppno="";
		String strFacilitySno="";
		strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
		strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
		strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
		strFacilitySno=Helper.correctNull((String)hshRecord.get("strFacilitySno"));
		ResultSet rs=null;
		String strChkValue="";
		String strCheck="";
		String strQuery="";
		boolean boolValue=false;
		try
		{
			boolValue=true;
			strQuery = SQLParser.getSqlQuery("selmisstaticdata^19"+"^E"+"^"+strCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			strCheck= " and APP_BORROWERLENDING"+" "+ strCode +" "+strValue;
			strQuery = SQLParser.getSqlQuery("selmisclassiactmaster^"+strAppno+"^"+strFacilitySno+"^"+strCheck);
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getting MIS Priority Classification "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return boolValue;			
	}
	public boolean getSHGValue(HashMap hshRecord) 
	{

		String strCode="";
		String strValue="";
		String strAppno="";
		strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
		strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
		strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
		ResultSet rs=null;
		String strChkValue="";
		String strCheck="";
		String strQuery="";
		boolean boolValue=false;
		String strLoanType="",strFacilitySno="",strValuesin="";
		double dblSancAmount=0.00;
		String strLoanAmt="";
		String strSHGmember="";
		try
		{

			strLoanType=Helper.correctNull((String) hshRecord.get("strLoanType"));
			strFacilitySno=Helper.correctNull((String) hshRecord.get("strFacilitySno"));
			strValuesin=Helper.correctNull((String) hshRecord.get("strValuesin"));
			
			if(!strLoanType.equalsIgnoreCase("P"))
			{
				if(!strValuesin.equalsIgnoreCase("R"))
				{
					strValue=Helper.convertSetupToApplicationValues(strValuesin, Double.parseDouble((String)Helper.correctNull(strValue)));
				}
			}

			
			strQuery = SQLParser.getSqlQuery("selmisstaticdata^19"+"^E"+"^"+strCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			strQuery = SQLParser.getSqlQuery("selSHGbeneficiaries^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strSHGmember=Helper.correctNull((String)rs.getString("members"));
			}
			if(rs!=null)
			{
				rs.close();
			}			
			
			if(strSHGmember.equalsIgnoreCase(""))
			{
				strSHGmember = "1";
			}
			
			
			
			if(strLoanType.equalsIgnoreCase("P"))
			{
				strCheck= " and loan_recmdamt"+" "+ strCode +" "+strValue;
				strQuery = SQLParser.getSqlQuery("selconstitution^"+strAppno+"^"+strCheck);
			}
			else
			{
				strCheck= " having  (facility_sancamt /"+" "+ strSHGmember + " "+" )"+ strCode +" "+strValue +" "+"group by app_no ,facility_sancamt ";
				strQuery = SQLParser.getSqlQuery("selconstitutioncorp^"+strAppno+"^"+strFacilitySno+"^"+strCheck);				
			}
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}
		
			/*
			strQuery = SQLParser.getSqlQuery("selmisstaticdata^19"+"^E"+"^"+strCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			strCheck= " and loan_recmdamt"+" "+ strCode +" "+strValue;
			strQuery = SQLParser.getSqlQuery("selconstitution^"+strAppno+"^"+strCheck);
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}*/
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getting SHG Value "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return boolValue;			
	}
	public boolean getIrrigatedValue(HashMap hshRecord) 
	{

		String strCode="";
		String strValue="";
		String strAppno="";
		strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
		strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
		strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
		ResultSet rs=null;
		String strChkValue="";
		String strCheck="";
		String strQuery="";
		boolean boolValue=false;
		String strFacilitySno="";
		try
		{
			strFacilitySno=Helper.correctNull((String)hshRecord.get("strFacilitySno"));
			strQuery = SQLParser.getSqlQuery("selmisstaticdata^19"+"^E"+"^"+strCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			strCheck= " and app_totirrigatedland"+" "+ strCode +" "+strValue;
			strQuery = SQLParser.getSqlQuery("selmisappdisplayscreendetails^"+strAppno+"^"+strFacilitySno+"^"+strCheck);
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getting MIS Priority Classification "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return boolValue;			
	}
	public boolean getTotalLimit(HashMap hshRecord) 
	{

		String strCode="";
		String strValue="";
		String strAppno="";
		strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
		strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
		strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
		ResultSet rs=null;
		String strChkValue="";
		String strCheck="";
		String strQuery="";
		String strLoanType="";
		String strValuesin="";
		boolean boolValue=false;
		String strFacilitySno="";
		try
		{
			strLoanType=Helper.correctNull((String)hshRecord.get("strLoanType"));
			strFacilitySno=Helper.correctNull((String)hshRecord.get("strFacilitySno"));
			strValuesin=Helper.correctNull((String)hshRecord.get("strValuesin"));
			
			if(!strLoanType.equalsIgnoreCase("P"))
			{
				if(!strValuesin.equalsIgnoreCase("R"))
				{
					strValue=Helper.convertSetupToApplicationValues(strValuesin, Double.parseDouble((String)Helper.correctNull(strValue)));
				}
			}
			
			strQuery = SQLParser.getSqlQuery("selmisstaticdata^19"+"^E"+"^"+strCode);
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			strCheck= " and app_totlim"+" "+ strCode +" "+strValue;
			strQuery = SQLParser.getSqlQuery("selmisappdetails^"+strAppno+"^"+strFacilitySno+"^"+strCheck);
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getting MIS Priority Classification "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return boolValue;		
	}
	public boolean getClassiActivityLimit(HashMap hshRecord) 
	{
		String strCode="";
		String strValue="";
		String strAppno="";
		String strType="";
		strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
		strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
		strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
		strType=Helper.correctNull((String)hshRecord.get("strType"));
		ResultSet rs=null;
		String strChkValue="";
		String strCheck="";
		String strQuery="";
		boolean boolValue=false;
		String strFacilitySno="";
		String strLoanType="";
		String strValuesin="";
		try
		{			
			strLoanType=Helper.correctNull((String)hshRecord.get("strLoanType"));
			strValuesin=Helper.correctNull((String)hshRecord.get("strValuesin"));
			strFacilitySno=Helper.correctNull((String)hshRecord.get("strFacilitySno"));
			
			if(!strLoanType.equalsIgnoreCase("P"))
			{
				if(!strValuesin.equalsIgnoreCase("R"))
				{
					strValue=Helper.convertSetupToApplicationValues(strValuesin, Double.parseDouble((String)Helper.correctNull(strValue)));
				}
			}
			
			strQuery = SQLParser.getSqlQuery("selmisstaticdata^19"+"^E"+"^"+strCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			strCheck= " and "+strType+" "+ strCode +" "+strValue;
			strQuery = SQLParser.getSqlQuery("selmisclassiactmaster^"+strAppno+"^"+strFacilitySno+"^"+strCheck);
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getting MIS Priority Classification "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return boolValue;		
	}
	
	public boolean getAgriTotalLimit(HashMap hshRecord) 
	{
		String strCode="";
		String strValue="";
		String strAppno="";
		strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
		strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
		strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
		ResultSet rs=null;
		String strChkValue="";
		String strCheck="";
		String strQuery="";
		boolean boolValue=false;
		String strFacilitySno="";
		String strLoanType="";
		String strValuesin="";
		try
		{
			
			strLoanType=Helper.correctNull((String)hshRecord.get("strLoanType"));
			strValuesin=Helper.correctNull((String)hshRecord.get("strValuesin"));
			strFacilitySno=Helper.correctNull((String)hshRecord.get("strFacilitySno"));
			
			if(!strLoanType.equalsIgnoreCase("P"))
			{
				if(!strValuesin.equalsIgnoreCase("R"))
				{
					strValue=Helper.convertSetupToApplicationValues(strValuesin, Double.parseDouble((String)Helper.correctNull(strValue)));
				}
			}
			
			strQuery = SQLParser.getSqlQuery("selmisstaticdata^19"+"^E"+"^"+strCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			strCheck= " and app_totlimagri"+" "+ strCode +" "+strValue;
			strQuery = SQLParser.getSqlQuery("selmisappdetails^"+strAppno+"^"+strFacilitySno+"^"+strCheck);
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getting MIS Priority Classification "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return boolValue;		
	}
	public boolean getServiceTotalLimit(HashMap hshRecord) 
	{
		String strCode="";
		String strValue="";
		String strAppno="";
		strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
		strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
		strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
		ResultSet rs=null;
		String strChkValue="";
		String strCheck="";
		String strQuery="";
		boolean boolValue=false;
		String strFacilitySno="";
		String strLoanType="";
		String strValuesin="";

		try
		{
			strLoanType=Helper.correctNull((String)hshRecord.get("strLoanType"));
			strValuesin=Helper.correctNull((String)hshRecord.get("strValuesin"));
			strFacilitySno=Helper.correctNull((String)hshRecord.get("strFacilitySno"));
			
			if(!strLoanType.equalsIgnoreCase("P"))
			{
				if(!strValuesin.equalsIgnoreCase("R"))
				{
					strValue=Helper.convertSetupToApplicationValues(strValuesin, Double.parseDouble((String)Helper.correctNull(strValue)));
				}
			}
			
//			strQuery = SQLParser.getSqlQuery("selmisstaticdata^19"+"^E"+"^"+strCode);
//			rs=DBUtils.executeQuery(strQuery);
//			if(rs.next())
//			{
//				strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
//			}
//			if(rs!=null)
//			{
//				rs.close();
//			}
			
			strCheck= " and app_totlimser between"+" "+ strCode +" and "+strValue;
			
			strQuery = SQLParser.getSqlQuery("selmisappdetails^"+strAppno+"^"+strFacilitySno+"^"+strCheck);
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getting MIS Priority Classification "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return boolValue;			
	}

	public HashMap getAppFarmersCategory(HashMap hshValues) 
	{
		HashMap hshResult=new HashMap();
		String strLandValue="";
		String strLandCode="";
		ResultSet rs=null;
		ResultSet rs1=null;
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		String strFarmer="";
		//String strIrrigatedLandValue="";
		//String strIrrigatedLandCode="";
		String strQuery="";
		String strQuery1="";
		String strAppNo="";
		boolean boolFlag=false;
		try
		{
			strQuery=SQLParser.getSqlQuery("sel_MISFarmerCategoryRecent");
			rs=DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				if(boolFlag!=true)
				{
					strLandCode=Helper.correctNull((String)rs.getString("far_cultivcode"));
					strLandValue=Helper.correctNull((String)rs.getString("far_cultiveval"));
					if(!strLandCode.equalsIgnoreCase(""))
					{
						double dblLandAppValue=Double.parseDouble(Helper.correctDouble((String)hshValues.get("strTotLandVal")));
						double dblLandValue=Double.parseDouble(Helper.correctDouble(strLandValue));
						if(strLandCode.equalsIgnoreCase("1"))
						{
							if(dblLandAppValue < dblLandValue)
							{
								//strFarmer=Helper.correctNull((String)rs.getString("far_farmcat"));

								arrCol=new ArrayList();
								String strFarmerDesc="";
								strFarmer=Helper.correctNull((String)rs.getString("far_farmcat"));
								strQuery1=SQLParser.getSqlQuery("sel_misstaticdatadesc^13^"+strFarmer);
								rs1=DBUtils.executeQuery(strQuery1);
								if(rs1.next())
								{
									strFarmerDesc=Helper.correctNull((String)rs1.getString("mis_static_data_desc"));
								}
								arrCol.add(strFarmer);
								arrCol.add(strFarmerDesc);
								arrRow.add(arrCol);
							
								boolFlag=true;
							}
						}
						else if(strLandCode.equalsIgnoreCase("2"))
						{
							if(dblLandAppValue <= dblLandValue)
							{
								//strFarmer=Helper.correctNull((String)rs.getString("far_farmcat"));

								arrCol=new ArrayList();
								String strFarmerDesc="";
								strFarmer=Helper.correctNull((String)rs.getString("far_farmcat"));
								strQuery1=SQLParser.getSqlQuery("sel_misstaticdatadesc^13^"+strFarmer);
								rs1=DBUtils.executeQuery(strQuery1);
								if(rs1.next())
								{
									strFarmerDesc=Helper.correctNull((String)rs1.getString("mis_static_data_desc"));
								}
								arrCol.add(strFarmer);
								arrCol.add(strFarmerDesc);
								arrRow.add(arrCol);
							
								boolFlag=true;
							}
						}
						else if(strLandCode.equalsIgnoreCase("3"))
						{
							if(dblLandAppValue > dblLandValue)
							{
								//strFarmer=Helper.correctNull((String)rs.getString("far_farmcat"));

								arrCol=new ArrayList();
								String strFarmerDesc="";
								strFarmer=Helper.correctNull((String)rs.getString("far_farmcat"));
								strQuery1=SQLParser.getSqlQuery("sel_misstaticdatadesc^13^"+strFarmer);
								rs1=DBUtils.executeQuery(strQuery1);
								if(rs1.next())
								{
									strFarmerDesc=Helper.correctNull((String)rs1.getString("mis_static_data_desc"));
								}
								arrCol.add(strFarmer);
								arrCol.add(strFarmerDesc);
								arrRow.add(arrCol);
							
								boolFlag=true;
							}
						}
						else if(strLandCode.equalsIgnoreCase("4"))
						{
							if(dblLandAppValue >= dblLandValue)
							{
								//strFarmer=Helper.correctNull((String)rs.getString("far_farmcat"));

								arrCol=new ArrayList();
								String strFarmerDesc="";
								strFarmer=Helper.correctNull((String)rs.getString("far_farmcat"));
								strQuery1=SQLParser.getSqlQuery("sel_misstaticdatadesc^13^"+strFarmer);
								rs1=DBUtils.executeQuery(strQuery1);
								if(rs1.next())
								{
									strFarmerDesc=Helper.correctNull((String)rs1.getString("mis_static_data_desc"));
								}
								arrCol.add(strFarmer);
								arrCol.add(strFarmerDesc);
								arrRow.add(arrCol);
							
								boolFlag=true;
							}
						}
						else if(strLandCode.equalsIgnoreCase("5"))
						{
							if(dblLandAppValue == dblLandValue)
							{
								arrCol=new ArrayList();
								String strFarmerDesc="";
								strFarmer=Helper.correctNull((String)rs.getString("far_farmcat"));
								strQuery1=SQLParser.getSqlQuery("sel_misstaticdatadesc^13^"+strFarmer);
								rs1=DBUtils.executeQuery(strQuery1);
								if(rs1.next())
								{
									strFarmerDesc=Helper.correctNull((String)rs1.getString("mis_static_data_desc"));
								}
								arrCol.add(strFarmer);
								arrCol.add(strFarmerDesc);
								arrRow.add(arrCol);
							}
						}
					}
				}
			}
			hshResult.put("strFarmer",strFarmer);
			hshResult.put("arrRow",arrRow);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getAppFarmersCategory "+e.toString());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
				if(rs1 != null)
				{
					rs1.close();
				}
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshResult;
	}
	public HashMap getSubsector(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		String strQuery="";
		String strClassType="";
		String strCode="";
		String strSubSectorVal="";
		try
		{
			strClassType=Helper.correctNull((String)hshValues.get("strClassType"));
			strSubSectorVal=Helper.correctNull((String)hshValues.get("strSubSectorVal"));
			if(strClassType.equalsIgnoreCase("01"))
			{
				strCode="7";
			}
			else if(strClassType.equalsIgnoreCase("02"))
			{
				strCode="8";
			}
			else if(strClassType.equalsIgnoreCase("03"))
			{
				strCode="12";
			}
			else if(strClassType.equalsIgnoreCase("04"))
			{
				strCode="11";
			}
			else if(strClassType.equalsIgnoreCase("05"))
			{
				strCode="9";
			}
			else if(strClassType.equalsIgnoreCase("06"))
			{
				strCode="10";
			}
			else if(strClassType.equalsIgnoreCase("07"))
			{
				strCode="22";
			}
			else if(strClassType.equalsIgnoreCase("08"))
			{
				strCode="23";
			}
			if(!strClassType.equalsIgnoreCase("09")){
			strQuery=SQLParser.getSqlQuery("sel_misstaticdata_common^"+strCode+"^E");
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("mis_static_data_code")));
				arrCol.add(Helper.correctNull((String)rs.getString("mis_static_data_desc")));
				arrRow.add(arrCol);
			}
			}
			hshRecord.put("arrRow", arrRow);
			hshRecord.put("strSubSectorVal",strSubSectorVal);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getSubsector "+e.toString());
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
	private void updateLBRAndModeOfAdvData(HashMap hshValues)
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		ResultSet rs=null;
		String strQuery="";
		String stractivitycode="";
		String stractivitysno="";
		String strlbrcode="";
		String strsector="";
		String strmodeofadv="";
		String strApplicationNumber="";
		String strFacilitySno="";
		String strMasterSno="";
		String strAppend="";
		try
		{
			strApplicationNumber=Helper.correctNull((String)hshValues.get("strAppNo"));
			strFacilitySno=Helper.correctInt((String)hshValues.get("strFacilitySno"));
			stractivitycode=Helper.correctNull((String)hshValues.get("strActivityCode"));
			stractivitysno=Helper.correctNull((String)hshValues.get("strActivitySno"));
			strMasterSno=Helper.correctNull((String)hshValues.get("strClassiMaster_Sno"));
			
			if(strFacilitySno.equalsIgnoreCase(""))
			{
				strFacilitySno = "1";
			}
			
//			strQuery = SQLParser.getSqlQuery("selmisappdetails^"+strApplicationNumber+"^"+strFacilitySno+"^ ");
//			rs = DBUtils.executeQuery(strQuery);
//			if(rs.next())
//			{
//				stractivitycode=Helper.correctNull((String)rs.getString("strActivityCode"));
//				stractivitysno=Helper.correctNull((String)rs.getString("strActivitySno"));
//			}
			
			if(!strApplicationNumber.equalsIgnoreCase(""))
			{
				strQuery =SQLParser.getSqlQuery("sel_activitylbrcode^" +stractivitycode);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strlbrcode=Helper.correctNull((String)rs.getString("ACT_LBRCODE"));
				}
				if(rs != null)
				{
					rs.close();
				}
				
				strQuery =SQLParser.getSqlQuery("sel_ModeOfAdv^" +strApplicationNumber+"^"+strFacilitySno);
				
				//strAppend = "where MIS_ACTIVITYCODE='"+stractivitycode+"' and MIS_ACTIVITYSNO='"+stractivitysno+"'and MIS_SNO='"+strMasterSno+"'";
				//strQuery =SQLParser.getSqlQuery("sel_ModeOfAdv_mastersno^"+strAppend);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strmodeofadv=Helper.correctNull((String)rs.getString("mis_modadv"));
				}
				if(rs != null)
				{
					rs.close();
				}
				hshQuery.put("strQueryId","upd_LBRCodeAndModeOfAdv");
				arrValues.add(strlbrcode);
				arrValues.add(strmodeofadv);
				arrValues.add(strApplicationNumber);
				arrValues.add(strFacilitySno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in updateLBRAndModeOfAdvData "+e.toString());
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

	public HashMap getActivityCodebyApplication(HashMap hshValues)
	{
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		String strQuery="";
		String strAppno = "";
		String strPrdCode = "";
		String strPageFrom = "";
		String strActCode = "",strActivity="";
		String strMainActivityCode="",strSubActivityCode="";
		String strLoanType="",strCorpProductCode="",strMainSubActivitycode = "";
		HashMap hshMISstatic = new HashMap();
		HashMap hshMISSubActivity = new HashMap();
		try
		{
			strPageFrom = Helper.correctNull((String)hshValues.get("master"));
			strAppno = Helper.correctNull((String)hshValues.get("strAppNo"));
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=Helper.correctNull((String)hshValues.get("strappno"));
			}
			strPrdCode = Helper.correctNull((String)hshValues.get("prdcode"));
			strLoanType= Helper.correctNull((String)hshValues.get("LoanType"));
			strCorpProductCode= Helper.correctNull((String)hshValues.get("CorpProdCode"));
			if(strLoanType.equalsIgnoreCase("C") || strLoanType.equalsIgnoreCase("A"))
			{
				strPrdCode=strCorpProductCode;
			}
			String strAppId=Helper.correctNull((String)hshValues.get("hidapplicantid"));
			String strAppNewId=Helper.correctInt((String)hshValues.get("hidapplicantnewid"));
			if(strAppNewId.equalsIgnoreCase("0"))
			{
				strAppNewId = strAppId;
			}
			strActivity = " and mac.ACT_ACTIVITYCODE in (";
			if(strPageFrom.equalsIgnoreCase("MIS") && (!strAppno.equalsIgnoreCase("")))
			{
				if(rs !=null)
				{
					rs.close();
				}
				/*Commented by Arsath for Performance Tuning
				 * Below field value retrieved from session itself instead of using this query
				strQuery=SQLParser.getSqlQuery("sel_appstatus^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strModuleType=Helper.correctNull((String)rs.getString("app_loantype"));
					strModuleType=strModuleType.toLowerCase();
				}
				*/
				String strActivityCodes="";
				//strQuery=SQLParser.getSqlQuery("sel_PrdActivityCodes^"+strPrdCode+"^"+strModuleType);
				strLoanType = strLoanType.toLowerCase();
				strQuery=SQLParser.getSqlQuery("sel_PrdActivityCodes^"+strPrdCode+"^"+strLoanType);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strActivityCodes=correctNull(Helper.CLOBToString(rs.getClob("prdact_activitycode")));
				}
				if( strActivityCodes != null )
				{
					StringTokenizer st = new StringTokenizer(strActivityCodes,"~");
					while(st.hasMoreTokens())
					{
						String strCode = (String)st.nextToken();
						if(strCode != null)
						{
							String[] strDesc=strCode.split("&");
							if(strDesc!=null)
							{
								strActCode=strActCode+"'"+strDesc[0]+"',";
							}
						}
					}
				}
				
				/* Added by Arsath for Performance Tuning
				 * Execution of query in loop has been reduced*/
				if(rs1!=null)
				{
					rs1.close();
				}
				strQuery = SQLParser.getSqlQuery("sel_misstaticdatadesc_new^"+"2");
				rs1= DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					String strSlcode = Helper.correctNull((String)rs1.getString("mis_static_data_code"));
					String strPrdDesc = Helper.correctNull((String)rs1.getString("mis_static_data_desc"));
					hshMISstatic.put(strSlcode,strPrdDesc);
				}
				
				if(rs1!=null)
				{
					rs1.close();
				}
				strQuery = SQLParser.getSqlQuery("sel_MISSubActivityDesc_new");
				rs1= DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					String strSubcode = Helper.correctNull((String)rs1.getString("mis_code"));
					String strSubPrdDesc = Helper.correctNull((String)rs1.getString("mis_subactdesc"));
					hshMISSubActivity.put(strSubcode,strSubPrdDesc);
				}
				
				
				if(rs!=null)
				{
					rs.close();
				}
				if(strActCode.endsWith(","))
				{
					strActCode=strActCode.substring(0,strActCode.length()-1);
				}
				if(strActCode.equalsIgnoreCase(""))
				{
					strActCode = "''";
				}
				strQuery=SQLParser.getSqlQuery("sel_Activity^"+strActivity+""+strActCode+")");
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(Helper.correctNull((String)rs.getString("act_sno")));//0
					arrCol.add(Helper.correctNull((String)rs.getString("act_mainactcode")));//1
					arrCol.add(Helper.correctNull((String)rs.getString("act_subactcode")));//2
					arrCol.add(Helper.correctNull((String)rs.getString("act_purposecode")));//3
					arrCol.add(Helper.correctNull((String)rs.getString("act_activitycode")));//4
					arrCol.add(Helper.correctNull((String)rs.getString("act_bsrcode")));//5
					arrCol.add(Helper.correctNull((String)rs.getString("act_bsr1code")));//6
					arrCol.add(Helper.correctNull((String)rs.getString("act_displayscreen")));//7
					arrCol.add(Helper.correctNull((String)rs.getString("act_industrytype")));//8
					arrCol.add(Helper.correctNull((String)rs.getString("act_show")));//9
					arrCol.add(Helper.correctNull((String)rs.getString("act_createdate")));//10
					arrCol.add(Helper.correctNull((String)rs.getString("act_modifieddate")));//11
					arrCol.add(Helper.correctNull((String)rs.getString("act_purposesno")));//12
					arrCol.add(Helper.correctNull((String)rs.getString("mis_static_data_desc")));//13
					arrCol.add(Helper.correctNull((String)rs.getString("act_lbrcode")));//14
					strMainActivityCode = Helper.correctNull((String)rs.getString("act_mainactcode"));
					strSubActivityCode = Helper.correctNull((String)rs.getString("act_subactcode"));
					if(strMainActivityCode.length()>0)
					{
						arrCol.add(Helper.correctNull((String)hshMISstatic.get(strMainActivityCode)));//15
					}
					else
					{
						arrCol.add("");//15
					}
					
					if(strMainActivityCode.length()>0 && strSubActivityCode.length()>0)
					{
						strMainSubActivitycode = strMainActivityCode+"-"+strSubActivityCode;
						arrCol.add(Helper.correctNull((String)hshMISSubActivity.get(strMainSubActivitycode)));//16  
					}
					else
					{
						arrCol.add("");//16
					}
				    //Commented by Arsath for performance tuning
				    //For Avoiding unwanted loop queries 
//					strQuery = SQLParser.getSqlQuery("sel_misstaticdatadesc^"+"2"+"^"+strMainActivityCode);
//					rs1= DBUtils.executeQuery(strQuery);
//					if(rs1.next())
//					{
//						arrCol.add(Helper.correctNull((String)rs1.getString("mis_static_data_desc")));//16
//					}
//					else
//					{
//						arrCol.add("");//16
//					}
//					strQuery = SQLParser.getSqlQuery("sel_MISSubActivityDesc^"+strMainActivityCode+"^"+strSubActivityCode);
//					rs2= DBUtils.executeQuery(strQuery);
//					if(rs2.next())
//					{
//						arrCol.add(Helper.correctNull((String)rs2.getString("mis_subactdesc")));//16
//					}
//					else
//					{
//						arrCol.add("");//16
//					}
					arrCol.add(Helper.correctNull((String)rs.getString("act_busruleid")));//17
					arrCol.add(Helper.correctNull((String)rs.getString("act_schematicflag")));//18
					
					arrCol.add(Helper.correctNull(rs.getString("act_freecode6")));//19
					arrCol.add(Helper.correctNull(rs.getString("act_freecode7")));//20
					arrCol.add(Helper.correctNull(rs.getString("act_freecode8")));//21
					arrCol.add(Helper.correctNull(rs.getString("ACT_CGTMSE")));//22
					arrCol.add(Helper.correctNull(rs.getString("ACT_ALLIED")));//22
					arrRow.add(arrCol);
				}
				hshValues.put("arrRow", arrRow);
				
				hshValues.put("strLoanType", strLoanType);
				hshValues.put("strCorpProductCode", strCorpProductCode);
				hshValues.put("appno",strAppno);
			}
		}
		catch(Exception e)
		{
			log.error("error in getActivityCodebyApplication.. " + e);
			throw new EJBException(e.getMessage());
		}
		finally 
		{
			try 
			{
				if (rs != null) 
				{
					rs.close();
				}
				if (rs1 != null) 
				{
					rs1.close();
				}
			} 
			catch (Exception e1) 
			{
				log.error("Error closing connection.." + e1);
			}
		}
		return hshValues;
	}
	
	public boolean getSecurityCode(HashMap hshRecord)
	{
		String strCode="";
		String strValue="";
		String strCode1="";
		String strValue1="";
		String strAppno="";
		strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
		strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
		
		strCode1=Helper.correctNull((String)hshRecord.get("strConstCode1"));
		strValue1=Helper.correctNull((String)hshRecord.get("strConstValue1"));

		strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
		
		ResultSet rs=null;
		String strChkValue="";
		String strCheck=" ",strCheck1=" ";
		String strQuery="";
		String strLoanType="";
		String strFacilitySno="";
		boolean boolValue=false;
		try
		{
			strLoanType=Helper.correctNull((String)hshRecord.get("strLoanType"));
			strFacilitySno=Helper.correctNull((String)hshRecord.get("strFacilitySno"));

			strQuery = SQLParser.getSqlQuery("selmisstaticdata^20"+"^E"+"^"+strCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			StringTokenizer st=new StringTokenizer(strValue,"@");
			while(st.hasMoreElements()){
				strChkValue+="'";
				strChkValue+=(String)st.nextElement();
				strChkValue+="',";
			}
			int intLength=strChkValue.length();
			intLength=--intLength;
			if(intLength>1)
			strValue=strChkValue.substring(0,intLength);
			
			/*
			 * In Master 'P' is the code for Primary Security. But in page level it is '1'
			 */
			if(strValue.equalsIgnoreCase("'P'"))
			{
				strValue = "'1'";
			}
			else
			{
				strValue = "'2'";
			}
			
			strChkValue="";
			strQuery = SQLParser.getSqlQuery("selmisstaticdata^20"+"^E"+"^"+strCode1);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strCode1=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			StringTokenizer st1=new StringTokenizer(strValue1,"@");
			while(st1.hasMoreElements()){
				strChkValue+="'";
				strChkValue+=(String)st1.nextElement();
				strChkValue+="',";
			}
			intLength=strChkValue.length();
			intLength=--intLength;
			if(intLength>1)
			strValue1=strChkValue.substring(0,intLength);
			
			if(strLoanType.equalsIgnoreCase("P"))
			{
//				if(rs!=null)
//				{
//					rs.close();
//				}
//				strQuery=SQLParser.getSqlQuery("sel_productcode^"+strAppno);
//				rs=DBUtils.executeQuery(strQuery);
//				if(rs.next())
//				{
//					strFacilitySno=Helper.correctNull((String)rs.getString("app_prdcode"));
//				}
				strFacilitySno = "1";
			}
			else
			{
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("sel_facbasedonsnogrp^"+strAppno+"^"+strFacilitySno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					if(!Helper.correctNull(rs.getString("facility_group")).equalsIgnoreCase("0"))
					strFacilitySno=Helper.correctNull(rs.getString("facility_group"));
				}
			}
			
			if(!(strCode.equalsIgnoreCase("")||strCode.equalsIgnoreCase("0")))
			strCheck1= "and app_sec_securitytype"+" "+ strCode +" "+"(" +strValue+")";
			if(!(strCode1.equalsIgnoreCase("")||strCode1.equalsIgnoreCase("0")))
			strCheck =strCheck + " CUS_SEC_CLASSIFICATION"+" "+ strCode1 +" "+"(" +strValue1+")";
			strQuery = SQLParser.getSqlQuery("sel_securities^"+strAppno+"^"+"^"+strFacilitySno+"^"+strCheck1+"^"+strCheck);	
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getting Security "+e.getMessage());
		}

		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return boolValue;	
	}
	public double getBorrowerTotalAgriLimit(String strAppID, String strValuesin,String strAppno) 
	{
		ResultSet rs=null;
		String strQuery="";
		String strTotalLimit="";
		String strAppOldID="";
		String strAgriCode="'1','2','26','27','28','31'";
		double dblTotAmount=0.00;
		String appprocessDate="",appstatus="";
		String desc="";
		try
		{
			strQuery=SQLParser.getSqlQuery("select_perappoldid^"+strAppID);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strAppOldID=Helper.correctNull((String)rs.getString("perapp_oldid"));
			}
			if(!strAppOldID.equalsIgnoreCase(""))
			{
				if(rs!=null)
				{
					rs.close();
				}
   			strQuery=SQLParser.getSqlQuery("sel_productcode^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				appstatus=Helper.correctNull((String)rs.getString("app_status"));
				if(Helper.correctNull((String)rs.getString("app_status")).equals("op")||Helper.correctNull((String)rs.getString("app_status")).equals("ol"))
				{
					appprocessDate=Helper.correctNull((String)rs.getString("app_createdate"));
				}
				else
				{
					appprocessDate=Helper.correctNull((String)rs.getString("app_processdate"));	
				}
			}
			 desc="and APP_CREATEDATE   <=(to_date('"+appprocessDate+"','dd/mm/yyyy')+1)";
   				if(rs!=null)
   				{
   					rs.close();
   				}
				strQuery=SQLParser.getSqlQuery("sel_borrowertotallimitagr_agri_newprop^"+strAppOldID+"^"+strAgriCode);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					dblTotAmount=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
				}
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("seltotagriliability_agri_newprop^"+strAppOldID+"^"+strAgriCode);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					dblTotAmount=dblTotAmount+Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
				}
			}
			strTotalLimit=Helper.convertSetupToApplicationValues(strValuesin,dblTotAmount);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getBorrowerTotalLimit "+ce.toString());
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
		return Double.parseDouble(strTotalLimit);
	}
	public boolean getShareBroker(HashMap hshRecord) 
	{
		String strCode="";
		String strValue="";
		String strAppno="";
		strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
		strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
		strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
		ResultSet rs=null;
		String strChkValue="";
		String strCheck="";
		String strQuery="";
		boolean boolValue=false;
		String strLoanType="";
		String strFacilitySno="";
		try
		{
			strLoanType=Helper.correctNull((String)hshRecord.get("strLoanType"));
			strFacilitySno=Helper.correctNull((String)hshRecord.get("strFacilitySno"));
			
			strQuery = SQLParser.getSqlQuery("selmisstaticdata^20"+"^E"+"^"+strCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			strCheck= " and app_sharebroker"+" "+ strCode +" "+"(" +strValue+")";
			strQuery = SQLParser.getSqlQuery("selmisappdetails^"+strAppno+"^"+strFacilitySno+"^"+strCheck);				
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getting Share Broker "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return boolValue;	
	}
	public double getClassiActivityMasterSum(String strAppID, String strType, String strPurpose) 
	{
		String strQuery = "";
		ResultSet rs = null;
		String strAppOldID="";
		String strActivityList="";
		 
		double dblTotalAmount = 0.00;
		try
		{
			strQuery = SQLParser.getSqlQuery("sel_classi_activity_master^"+strType);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				StringTokenizer st = new StringTokenizer(Helper.correctNull((String)rs.getString(1)),"@");
				while(st.hasMoreElements())
				{
					if(strActivityList.equalsIgnoreCase(""))
						strActivityList = "'"+(String)st.nextElement()+"'";
					else
						strActivityList = strActivityList+",'"+(String)st.nextElement()+"'";
				}
			}
			
			if(rs!=null) rs.close();
			
			strQuery=SQLParser.getSqlQuery("select_perappoldid^"+strAppID);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strAppOldID=Helper.correctNull((String)rs.getString("perapp_oldid"));
			}
			
			if(!strAppOldID.equalsIgnoreCase("") && !strActivityList.equalsIgnoreCase(""))
			{
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("sel_ClassiActivityLimit^"+strAppOldID+"^"+strActivityList);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					dblTotalAmount=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
				}
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("sel_ClassiActivityLimit_CorpAgri^"+strAppOldID+"^"+strActivityList);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					dblTotalAmount=dblTotalAmount+Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
				}
				
				if(!strPurpose.equalsIgnoreCase(""))
				{
					if(rs!=null)rs.close();
					strQuery = SQLParser.getSqlQuery("sel_otherbankliab_MIS^"+strAppID+"^"+strPurpose);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						dblTotalAmount=dblTotalAmount+Double.parseDouble((String)Helper.correctDouble(rs.getString("PERBANK_LIMIT")));
					}
				}
			}
			//dblTotalAmount=Helper.convertSetupToApplicationValues(strAppOldID,dblTotalAmount);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getClassiActivityMasterSum "+String.valueOf(ce));
		}
		return dblTotalAmount;
	}
	
	public double getBorrowerTotalServiceLimit(String strAppID, String strValuesin,String strAppno) 
	{
		ResultSet rs=null;
		String strQuery="";
		String strTotalLimit="";
		String strAppOldID="";
		String strAgriCode="'11','12','14','15','19','20','21','26','27','28','29'";
		double dblTotAmount=0.00;
		String appprocessDate="",appstatus="";
		String desc="";
		try
		{
			strQuery=SQLParser.getSqlQuery("select_perappoldid^"+strAppID);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strAppOldID=Helper.correctNull((String)rs.getString("perapp_oldid"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("sel_productcode^"+strAppno);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			appstatus=Helper.correctNull((String)rs.getString("app_status"));
			if(Helper.correctNull((String)rs.getString("app_status")).equals("op")||Helper.correctNull((String)rs.getString("app_status")).equals("ol"))
			{
				appprocessDate=Helper.correctNull((String)rs.getString("app_createdate"));
			}
			else
			{
				appprocessDate=Helper.correctNull((String)rs.getString("app_processdate"));	
			}
		}
		desc="and APP_CREATEDATE   <=(to_date('"+appprocessDate+"','dd/mm/yyyy')+1)";
			if(!strAppOldID.equalsIgnoreCase(""))
			{
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("sel_borrowertotallimitagr_serv_newprop^"+strAppOldID+"^"+strAgriCode);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					dblTotAmount=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
				}
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("seltotagriliability_serv_newprop^"+strAppOldID+"^"+strAgriCode);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					dblTotAmount=dblTotAmount+Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
				}
			}
			strTotalLimit=Helper.convertSetupToApplicationValues(strValuesin,dblTotAmount);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getBorrowerTotalLimit "+ce.toString());
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
		return Double.parseDouble(strTotalLimit);
	}

	public HashMap getStandupIndia(HashMap hshActivity, String strValuesin)
	{
		HashMap hshValues=new HashMap();
		ResultSet rs=null,rs1=null;
		try
		{

			String strAppno="";
			String strQuery="";
			String strExcep="$";
			boolean boolStatus=true;
			String strLoanType="",strFacilitySno="",strProcessDate="",strAppStatus="";


			strAppno=Helper.correctNull((String)hshActivity.get("strAppno"));

			strLoanType=Helper.correctNull((String)hshActivity.get("strLoanType"));
			strFacilitySno=Helper.correctNull((String)hshActivity.get("strFacilitySno"));
			
			strProcessDate=Helper.correctNull((String)hshActivity.get("strProcessDate"));
			strAppStatus=Helper.correctNull((String)hshActivity.get("strAppStatus"));
			String strAppNewId=Helper.correctNull((String)hshActivity.get("hidapplicantnewid"));
			String strAppId=Helper.correctNull((String)hshActivity.get("hidapplicantid"));
			String strReClassifyFlag=Helper.correctNull((String)hshActivity.get("strReclassification"));
			
			if(rs!=null)
			{
				rs.close();
			}
			String COMINFO_MAJORITYMEMBER="",perapp_stakeheld_women="",perapp_constitutionnew="",indinfo_caste="",perapp_sex="",perapp_oldid="";
			if(!strAppId.equalsIgnoreCase(""))
			{
				rs=DBUtils.executeLAPSQuery("sel_common_customer^"+strAppNewId);				 
				if(rs.next())
				{
					  COMINFO_MAJORITYMEMBER=Helper.correctNull(rs.getString("COMINFO_MAJORITYMEMBER"));
					  perapp_stakeheld_women=Helper.correctNull(rs.getString("perapp_stakeheld_women"));
					  perapp_constitutionnew=Helper.correctNull((String)rs.getString("perapp_constitutionnew"));
					  indinfo_caste=Helper.correctNull((String)rs.getString("indinfo_caste"));
					  perapp_sex=Helper.correctNull((String)rs.getString("perapp_sex"));
					  perapp_oldid=Helper.correctNull((String)rs.getString("perapp_oldid"));
				}
			}
			if(perapp_constitutionnew.equals("01"))
			{
				if(perapp_sex.equals("F") || (indinfo_caste.equals("001") || indinfo_caste.equals("002")) )
				{
					boolStatus=true;
				}
				else
				{
					boolStatus=false;
				}
			}
			else
			{
				if(COMINFO_MAJORITYMEMBER.equals("Y") || perapp_stakeheld_women.equals("Y") )
				{
					boolStatus=true;
				}
				else
				{
					boolStatus=false;
				}
			}

			
			log.info("Customer Profile Data ======================"+boolStatus);
			
			if(rs != null)
			{  rs.close();	}
			String appprocessDate="",appstatus="";
			strQuery=SQLParser.getSqlQuery("sel_productcode^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				appstatus=Helper.correctNull((String)rs.getString("app_status"));
				if(Helper.correctNull((String)rs.getString("app_status")).equals("op")||Helper.correctNull((String)rs.getString("app_status")).equals("ol"))
				{
					appprocessDate=Helper.correctNull((String)rs.getString("app_createdate"));
				}
				else
				{
					appprocessDate=Helper.correctNull((String)rs.getString("app_processdate"));	
				}
			}
			
			// borrower exposure under MSME
			double dblMSMEEXP=0.00,dblTOTEXP=0.00;
			String desc="";
			
//			if(appstatus.equals("op") || appstatus.equals("ol"))
//			{
//				desc="and APP_CREATEDATE <=(to_date('"+appprocessDate+"','dd/mm/yyyy'))";
//			}
//			else
			{
				desc="and APP_CREATEDATE  <=(to_date('"+appprocessDate+"','dd/mm/yyyy')+1)";
			}
			
			strQuery=SQLParser.getSqlQuery("sel_borrowertotallimit_msme_clsdappl^"+perapp_oldid+"^"+strAppno+"^"+desc);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				dblMSMEEXP=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
			}
			if(rs != null)
			{  rs.close();	}
			strQuery=SQLParser.getSqlQuery("seltotliability_msme_clsdappl^"+perapp_oldid+"^"+strAppno+"^"+strFacilitySno+"^"+desc);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				dblMSMEEXP=dblMSMEEXP+Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
			}
			if(dblMSMEEXP!=0.00)
			{
				boolStatus=false;
			}
			
			
			log.info("Borrower Expsoure ======================"+dblMSMEEXP);
			
			if(rs != null)
			{  rs.close();	}
			strQuery=SQLParser.getSqlQuery("sel_renewapp_standup^"+perapp_oldid+"^"+perapp_oldid);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(!Helper.correctNull(rs.getString("app_no")).equalsIgnoreCase(strAppno))
				{
					boolStatus=false;
				}
			}
			//end
			
			log.info("Renewal application ======================"+boolStatus);
			
			
			//Facilities with other Bank- Purpose of Loan- �Stand Up India�
			if(rs != null)
			{  rs.close();	}
			int purposeCount=0;
			strQuery=SQLParser.getSqlQuery("perbankingselectNewOldId^"+strAppId);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(Helper.correctNull((String)rs.getString("PERBANK_LOANPURPOSE")).equals("6"))
				{
					purposeCount++;
				}
			}
			if(purposeCount>0)
			{
				boolStatus=false;
			}
			log.info("Other bank facilities ======================"+boolStatus);
			
			//Exposure Range check
			
			double dblExposurerangeFrom=0,dblExposurerangeTo=0;
			if(rs != null)
			{  rs.close();	}
			String strLesser = ">=";
			String strGreater = "<=";
			strQuery=SQLParser.getSqlQuery("sel_mis_standupElig^"+appprocessDate);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				//period of loan
				Integer strHOLIDAYPERIOD=Integer.parseInt(Helper.correctInt((String)hshActivity.get("strHOLIDAYPERIOD")));
				Integer strReqTerms=Integer.parseInt(Helper.correctInt((String)hshActivity.get("strReqTerms")));

				Integer strHOLIDAY_PRD=Integer.parseInt(Helper.correctInt((String)rs.getString("MIS_HOLIDAY_PRD")));
				Integer strLOAN_PRD=Integer.parseInt(Helper.correctInt((String)rs.getString("MIS_LOAN_PRD")));
				String strAGRI_SERVICE_CTG=Helper.correctNull((String)rs.getString("MIS_AGRI_SERVICE_CTG"));
				String strPrioritySector=Helper.correctNull((String)rs.getString("MIS_CLASSIFICATION"));
				dblExposurerangeFrom=Double.parseDouble(Helper.correctDouble(rs.getString("MIS_EXPO_DT_FROM")));
				dblExposurerangeTo=Double.parseDouble(Helper.correctDouble(rs.getString("MIS_EXPO_DT_TO")));
				
				dblMSMEEXP+=Double.parseDouble(Helper.correctDouble((String)hshActivity.get("strLoanAmt")));
				
				//Exposure check
				if(dblExposurerangeFrom>dblMSMEEXP)
					boolStatus=false;
				if(dblExposurerangeTo<dblMSMEEXP)
					boolStatus=false;
				if(dblExposurerangeFrom>dblMSMEEXP && dblExposurerangeTo<dblMSMEEXP)
					boolStatus=false;
				
				
				log.info("Other bank facilities ======================"+dblMSMEEXP);
				
				//Period of Loan
				if(strReqTerms>strLOAN_PRD)   
				{
					boolStatus=false;
				}
				if(strHOLIDAYPERIOD>strHOLIDAY_PRD)
				{
					boolStatus=false;
				}
				
				if(!strPrioritySector.equalsIgnoreCase(Helper.correctNull((String)hshActivity.get("strPriorityType"))))
				{
					boolStatus=false;
				}
				
				//Agriculture Industry Service Category
				String[] strarrAGRI_SERVICE_CTG=strAGRI_SERVICE_CTG.split("@");
				int agrserviceFlag=0;
				String mis_strAgriIndConfig=Helper.correctNull((String)hshActivity.get("strAgriIndConfig"));
				for(int i=0;i<strarrAGRI_SERVICE_CTG.length;i++)
				{
					String strAgriIndConfig=strarrAGRI_SERVICE_CTG[i];
					if(strAgriIndConfig.equals(mis_strAgriIndConfig))
					{
						agrserviceFlag++;
					}
				}
				if(boolStatus)
				{
					if(agrserviceFlag>0)
					{
						boolStatus=true;
					}
					else
					{
						boolStatus=false;
					}	
				}
			}
			else
			{
				boolStatus=false;
			}
			
			if(boolStatus)
			{
				if(rs != null)
				{  rs.close();	}
				strQuery=SQLParser.getSqlQuery("select_facilityCode^"+strAppno+"^"+strFacilitySno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					if(Helper.correctNull(rs.getString("facility_status")).equalsIgnoreCase("R"))
					{
						boolStatus=false;
					}
				}
				if(rs != null)
				{  rs.close();	}
				strQuery=SQLParser.getSqlQuery("sel_misappclassification_appwise^"+strAppno+"^"+strFacilitySno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					if(Double.parseDouble(Helper.correctDouble(rs.getString("sanction_amt")))>dblExposurerangeFrom && Double.parseDouble(Helper.correctDouble(rs.getString("sanction_amt")))<dblExposurerangeTo)
					{
						boolStatus=false;
					}
				}
			}
			
			
			String boolStandupIndia="";
			if(boolStatus==false)
			{
				boolStandupIndia="N";
			}
			else
			{
				boolStandupIndia="Y";
			}
			
			
			
			hshValues.put("boolStandupIndia",boolStandupIndia);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getting Standup India "+e.getMessage());					
		}
		finally
		{
			try
			{	if(rs != null)
				{
					rs.close();
				}
				if(rs1 != null)
				{
					rs1.close();
				}	
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshValues;
	}
	public boolean getSalesTurnOver(HashMap hshRecord) 
	{
		String strCode="";
		String strValue="";
		String strAppno="";
		strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
		strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
		strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
		ResultSet rs=null;
		String strChkValue="";
		String strCheck="";
		String strQuery="";
		String strFacilitySno="";
		boolean boolValue=false;
		String strValuesin="";
		String strLoanType="";
		try
		{
			strValuesin=Helper.correctNull((String) hshRecord.get("strValuesin"));
			
			if(!strLoanType.equalsIgnoreCase("P"))
			{
				if(!strValuesin.equalsIgnoreCase("R"))
				{
					strValue=Helper.convertSetupToApplicationValues(strValuesin, Double.parseDouble((String)Helper.correctNull(strValue)));
				}
			}

			strFacilitySno=Helper.correctNull((String)hshRecord.get("strFacilitySno"));
			strCheck= " and app_saleturnover between"+" "+ strCode +" and "+strValue;
			strQuery = SQLParser.getSqlQuery("selmisappdisplayscreendetails^"+strAppno+"^"+strFacilitySno+"^"+strCheck);
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getting MIS Priority Classification "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return boolValue;		
	}
	
	// ==============================added for minority community ======================//
	public boolean getMinority(HashMap hshValues) 
	{
		String strCode="";
		String strValue="";
		String strAppno="",strConstitution="";
		strCode=Helper.correctNull((String)hshValues.get("strMinorityCode"));
		strValue=Helper.correctNull((String)hshValues.get("strMinorityValue"));
		strConstitution=Helper.correctNull((String)hshValues.get("strConstValue"));
		strAppno=Helper.correctNull((String)hshValues.get("strAppno"));
		ResultSet rs=null;
		String strChkValue="";
		String strCheck="";
		String strQuery="";
		boolean boolValue=false;
		String strLoanType="";
		try
		{
			strLoanType=Helper.correctNull((String)hshValues.get("strLoanType"));
			
			strQuery = SQLParser.getSqlQuery("selmisstaticdata^20"+"^E"+"^"+strCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			strCheck= " and INDINFO_MINORITY"+" "+ strCode +" "+"('" +strValue+"')";
			if(strLoanType.equalsIgnoreCase("P"))
			{
				strQuery = SQLParser.getSqlQuery("selcustomerdata^"+strAppno+"^"+strCheck);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("selcustomerdatacorp^"+strAppno+"^"+strCheck);
			}
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolValue=true;
			}
			else
			{
				boolValue=false;
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getting MIS Weaker section Classification -- Minority Section "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return boolValue;	
	
	}
	
public boolean getMinorityCommunity(HashMap hshValues) 
{
	String strCode="";
	String strValue="";
	String strAppno="",strConstitution="";
	strCode=Helper.correctNull((String)hshValues.get("strMinorityCommunityCode"));
	strValue=Helper.correctNull((String)hshValues.get("strMinorityCommunityValue"));
	strConstitution=Helper.correctNull((String)hshValues.get("strConstValue"));
	strAppno=Helper.correctNull((String)hshValues.get("strAppno"));
	ResultSet rs=null;
	String strChkValue="";
	String strCheck="";
	String strQuery="";
	boolean boolValue=false;
	String strLoanType="";
	try
	{
		strLoanType=Helper.correctNull((String)hshValues.get("strLoanType"));
		
		strQuery = SQLParser.getSqlQuery("selmisstaticdata^20"+"^E"+"^"+strCode);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
		}
		if(rs!=null)
		{
			rs.close();
		}
		
		strCheck= " and COMINFO_MINORITY_COMMUNITY"+" "+ strCode +" "+"('" +strValue+"')";
		if(strLoanType.equalsIgnoreCase("P"))
		{
			strQuery = SQLParser.getSqlQuery("selcommunitydata^"+strAppno+"^"+strCheck);
		}
		else
		{
			strQuery = SQLParser.getSqlQuery("selcommunitydatacorp^"+strAppno+"^"+strCheck);
		}
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			boolValue=true;
		}
		else
		{
			boolValue=false;
		}
	}
	catch (Exception e)
	{
		throw new EJBException("Error in getting MIS Weaker section Classification -- Minority community Section "+e.getMessage());
	}
	finally
	{
		try
		{	if(rs != null)
				rs.close();
		}
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}
	return boolValue;	

	}

public boolean getCarpetArea(HashMap hshRecord) 
{
	String strCode="";
	String strValue="";
	String strAppno="";
	strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
	strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
	strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
	ResultSet rs=null;
	String strChkValue="";
	String strCheck="";
	String strQuery="";
	String strLoanType="";
	String strFacilitySno="";
	String strValuesin="";
	boolean boolValue=false;
	try
	{
		
		strLoanType=Helper.correctNull((String) hshRecord.get("strLoanType"));
		strFacilitySno=Helper.correctNull((String) hshRecord.get("strFacilitySno"));
		strValuesin=Helper.correctNull((String) hshRecord.get("strValuesin"));
		
		if(!strLoanType.equalsIgnoreCase("P"))
		{
			if(!strValuesin.equalsIgnoreCase("R"))
			{
				strValue=Helper.convertSetupToApplicationValues(strValuesin, Double.parseDouble((String)Helper.correctNull(strValue)));
			}
		}

		
		strQuery = SQLParser.getSqlQuery("selmisstaticdata^19"+"^E"+"^"+strCode);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
		}
		if(rs!=null)
		{
			rs.close();
		}
		
		strCheck= " and APP_CARPET_AREA "+" "+ strCode +"  "+strValue;
		strQuery = SQLParser.getSqlQuery("selmisappdisplayscreendetails^"+strAppno+"^"+strFacilitySno+"^"+strCheck);
		
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			boolValue=true;
		}
		else
		{
			boolValue=false;
		}
	}
	catch (Exception e)
	{
		throw new EJBException("Error in getting MIS Priority Classification "+e.getMessage());
	}
	finally
	{
		try
		{	if(rs != null)
				rs.close();
		}
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}
	return boolValue;	
}
public boolean getFloorArea(HashMap hshRecord) 
{
	String strCode="";
	String strValue="";
	String strAppno="";
	strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
	strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
	strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
	ResultSet rs=null;
	String strChkValue="";
	String strCheck="";
	String strQuery="";
	String strLoanType="";
	String strFacilitySno="";
	String strValuesin="";
	boolean boolValue=false;
	try
	{
		
		strLoanType=Helper.correctNull((String) hshRecord.get("strLoanType"));
		strFacilitySno=Helper.correctNull((String) hshRecord.get("strFacilitySno"));
		strValuesin=Helper.correctNull((String) hshRecord.get("strValuesin"));
		
		if(!strLoanType.equalsIgnoreCase("P"))
		{
			if(!strValuesin.equalsIgnoreCase("R"))
			{
				strValue=Helper.convertSetupToApplicationValues(strValuesin, Double.parseDouble((String)Helper.correctNull(strValue)));
			}
		}

		
		strQuery = SQLParser.getSqlQuery("selmisstaticdata^19"+"^E"+"^"+strCode);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
		}
		if(rs!=null)
		{
			rs.close();
		}
		
		strCheck= " and APP_FLOOR_AREA "+" "+ strCode +"  "+strValue;
		strQuery = SQLParser.getSqlQuery("selmisappdisplayscreendetails^"+strAppno+"^"+strFacilitySno+"^"+strCheck);
		
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			boolValue=true;
		}
		else
		{
			boolValue=false;
		}
	}
	catch (Exception e)
	{
		throw new EJBException("Error in getting MIS Priority Classification "+e.getMessage());
	}
	finally
	{
		try
		{	if(rs != null)
				rs.close();
		}
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}
	return boolValue;	
}
public boolean getSHGProposedLoan(HashMap hshRecord) 
{
	String strCode="";
	String strValue="";
	String strAppno="";
	strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
	strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
	strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
	ResultSet rs=null;
	String strChkValue="";
	String strCheck="";
	String strQuery="";
	String strLoanType="";
	String strFacilitySno="";
	String strValuesin="";
	boolean boolValue=false;
	try
	{
		
		strLoanType=Helper.correctNull((String) hshRecord.get("strLoanType"));
		strFacilitySno=Helper.correctNull((String) hshRecord.get("strFacilitySno"));
		strValuesin=Helper.correctNull((String) hshRecord.get("strValuesin"));
		
		if(!strLoanType.equalsIgnoreCase("P"))
		{
			if(!strValuesin.equalsIgnoreCase("R"))
			{
				strValue=Helper.convertSetupToApplicationValues(strValuesin, Double.parseDouble((String)Helper.correctNull(strValue)));
			}
		}

		
		strQuery = SQLParser.getSqlQuery("selmisstaticdata^19"+"^E"+"^"+strCode);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
		}
		if(rs!=null)
		{
			rs.close();
		}
		
		strCheck= " and APP_PROPOSED_LOAN_SHG "+" "+ strCode +"  "+strValue;
		strQuery = SQLParser.getSqlQuery("selmisappdisplayscreendetails^"+strAppno+"^"+strFacilitySno+"^"+strCheck);
		
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			boolValue=true;
		}
		else
		{
			boolValue=false;
		}
	}
	catch (Exception e)
	{
		throw new EJBException("Error in getting MIS Priority Classification "+e.getMessage());
	}
	finally
	{
		try
		{	if(rs != null)
				rs.close();
		}
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}
	return boolValue;	
}

public boolean getStartUp(HashMap hshRecord) 
{
	String strCode="";
	String strValue="";
	String strAppno="";
	strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
	//strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
	strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
	ResultSet rs=null;
	String strChkValue="";
	String strCheck="";
	String strQuery="";
	String strLoanType="";
	String strFacilitySno="";
	String strValuesin="";
	boolean boolValue=false;
	try
	{
		
		strLoanType=Helper.correctNull((String) hshRecord.get("strLoanType"));
		strFacilitySno=Helper.correctNull((String) hshRecord.get("strFacilitySno"));
		strValuesin=Helper.correctNull((String) hshRecord.get("strValuesin"));
		
		
		strCheck= " and APP_MINISTRY_INDUSTRY ="+" "+ "'" +strCode+"'";
		strQuery = SQLParser.getSqlQuery("selmisappdisplayscreendetails^"+strAppno+"^"+strFacilitySno+"^"+strCheck);
		
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			boolValue=true;
		}
		else
		{
			boolValue=false;
		}
	}
	catch (Exception e)
	{
		throw new EJBException("Error in getting MIS Priority Classification "+e.getMessage());
	}
	finally
	{
		try
		{	if(rs != null)
				rs.close();
		}
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}
	return boolValue;	
}
public boolean getIndividualHouse(HashMap hshRecord) 
{
	String strCode="";
	String strValue="";
	String strAppno="";
	strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
	//strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
	strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
	ResultSet rs=null;
	String strChkValue="";
	String strCheck="";
	String strQuery="";
	String strLoanType="";
	String strFacilitySno="";
	String strValuesin="";
	boolean boolValue=false;
	try
	{
		
		strLoanType=Helper.correctNull((String) hshRecord.get("strLoanType"));
		strFacilitySno=Helper.correctNull((String) hshRecord.get("strFacilitySno"));
		strValuesin=Helper.correctNull((String) hshRecord.get("strValuesin"));
		
		
		strCheck= " and APP_AREA_INDV_HOUSE ="+" "+ "'" +strCode+"'";
		strQuery = SQLParser.getSqlQuery("selmisappdisplayscreendetails^"+strAppno+"^"+strFacilitySno+"^"+strCheck);
		
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			boolValue=true;
		}
		else
		{
			boolValue=false;
		}
	}
	catch (Exception e)
	{
		throw new EJBException("Error in getting MIS Priority Classification "+e.getMessage());
	}
	finally
	{
		try
		{	if(rs != null)
				rs.close();
		}
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}
	return boolValue;	
}

public boolean getAliedAcivityDetails(HashMap hshRecord) {
String strCode = "";
String strValue = "";
String strAppno = "";
strCode = Helper.correctNull((String) hshRecord.get("strConstCode"));
strValue = Helper.correctNull((String) hshRecord.get("strConstValue"));
strAppno = Helper.correctNull((String) hshRecord.get("strAppno"));
ResultSet rs = null,rs1=null,rs2=null,rs3=null,rs4=null;
String strChkValue = "";
String strCheck = "";
String strQuery = "",strQuery1="";
String strLoanType = "";
String strFacilitySno = "";
String strValuesin = "";
String strloanamountcode = "";
String strloanamountvalue = "",stractivitycode="";
String strAlliedActivity = "", strAppOldID = "";
boolean boolValue = false;
try {

strLoanType = Helper.correctNull((String) hshRecord.get("strLoanType"));
strFacilitySno = Helper.correctNull((String) hshRecord.get("strFacilitySno"));
strValuesin = Helper.correctNull((String) hshRecord.get("strValuesin"));
strloanamountcode = Helper.correctNull((String) hshRecord.get("strLoanAmtCode"));
strloanamountvalue = Helper.correctNull((String) hshRecord.get("strLoanAmtValue"));
strAlliedActivity = Helper.correctNull((String) hshRecord.get("strAlliedActivity"));
String strproposedallied="N";
int existingborrowercount=0;
double totallimit=0.00;
if (!strLoanType.equalsIgnoreCase("P")) {
	if (!strValuesin.equalsIgnoreCase("R")) {
		strloanamountvalue = Helper.convertSetupToApplicationValues(strValuesin,Double.parseDouble((String) Helper.correctNull(strloanamountvalue)));
	}
}

strQuery = SQLParser.getSqlQuery("selmisstaticdata^19" + "^E" + "^"+ strloanamountcode);
rs = DBUtils.executeQuery(strQuery);
if (rs.next()) {
	strCode = Helper.correctNull((String) rs.getString("mis_static_data_desc"));
}
if (rs != null) {
	rs.close();
}

strQuery = SQLParser.getSqlQuery("select_perappoldid^"+ Helper.correctNull((String) hshRecord.get("applicantid")));
rs = DBUtils.executeQuery(strQuery);
if (rs.next()) {
	strAppOldID = Helper.correctNull((String) rs.getString("perapp_oldid"));
}
if (strLoanType.equalsIgnoreCase("P")) {
	strQuery = SQLParser.getSqlQuery("sel__misretactivitycode^"+ strAppno);
} else {
	strQuery = SQLParser.getSqlQuery("sel__miscorpactivitycode^"+  strAppno+"^"+ strFacilitySno);
}
rs2 = DBUtils.executeQuery(strQuery);
if(rs2.next()){
	stractivitycode = Helper.correctNull((String) rs2.getString("APP_ACTIVITYCODE"));
	log.info("<<<<<<<<<===============stractivitycode================>>>>>>>>>>>>>>>"+stractivitycode);
}
if (strLoanType.equalsIgnoreCase("P")) {
	strQuery = SQLParser.getSqlQuery("sel__misretalliedactivity^"+ stractivitycode+"^"+ strAppno);
} else {
	strQuery = SQLParser.getSqlQuery("sel__miscorpalliedactivity^"+ stractivitycode+"^"+ strAppno+"^"+ strFacilitySno);
}
rs3 = DBUtils.executeQuery(strQuery);
if(rs3.next()){
	strproposedallied = "Y";
	log.info("<<<<<<<<<===============strproposedallied================>>>>>>>>>>>>>>>"+strproposedallied);
}
if (rs != null) {
	rs.close();
}
			if (!strLoanType.equalsIgnoreCase("P")) {
				strQuery = SQLParser.getSqlQuery("sel_existing_alliedchk_corp^"+ strAppOldID);
				rs4 = DBUtils.executeQuery(strQuery);
				while (rs4.next()) {
					String strmainact = Helper.correctNull((String) rs4.getString("MIS_MAINACT"));
					if (strmainact.equalsIgnoreCase("02")) {
						existingborrowercount++;
					}
					log.info("<<<<<<<<<===============strmainact================>>>>>>>>>>>>>>>"+strmainact);
					log.info("<<<<<<<<<===============existingborrowercount================>>>>>>>>>>>>>>>"+existingborrowercount);

				}
			}
if (strLoanType.equalsIgnoreCase("P")) {
	strQuery = SQLParser.getSqlQuery("sel_retail_alliedactivity_borrower^"+ strAppOldID );
} else {
	strQuery = SQLParser.getSqlQuery("sel_corp_alliedactivity_borrower^"+ strAppOldID + "^" + strFacilitySno);
}
rs = DBUtils.executeQuery(strQuery);
if(rs.next()){
	totallimit=Double.parseDouble(Helper.correctDouble(rs.getString("totallimit")));
	log.info("<<<<<<<<<===============totallimit================>>>>>>>>>>>>>>>"+totallimit);
}
if(rs!=null){
	rs.close();
}
if (strAlliedActivity.equalsIgnoreCase("Y")&&strproposedallied.equalsIgnoreCase("Y")) {
	if (strLoanType.equalsIgnoreCase("P")) {
		strCheck = " and  "+totallimit+ " " + strCode + " "+ strloanamountvalue;
		strQuery1 = SQLParser.getSqlQuery("sel_retail_alliedactivity^"+ strAppOldID + "^" + strCheck);
		rs1= DBUtils.executeQuery(strQuery1);
		if (rs1.next()) {
			boolValue = true;
			log.info("<<<<<<<<<===============allied activity condition sattisfied================>>>>>>>>>>>>>>>");

		} else {
			boolValue = false;
		}
	} else {
		if(existingborrowercount<=0){
		strCheck = " and  "+ totallimit + " " + strCode + " "+ strloanamountvalue;
		strQuery1 = SQLParser.getSqlQuery("sel_corp_alliedactivity^"+ strAppOldID + "^" + strFacilitySno + "^"+ strCheck);
		rs1= DBUtils.executeQuery(strQuery1);
			if (rs1.next()) {
				boolValue = true;
				log.info("<<<<<<<<<===============allied activity condition sattisfied================>>>>>>>>>>>>>>>");
	
			} else {
				boolValue = false;
			}
		}
		log.info("<<<<<<<<===================strQuery1================>>>>>>>>>>>>"+strQuery1);
	}
	
}

} catch (Exception e) {
throw new EJBException("Error in getting getAlliedActivityDetails "+ e.getMessage());
} finally {
try {
	if (rs != null)
		rs.close();
} catch (Exception cf) {
	throw new EJBException("Error closing the connection "
			+ cf.getMessage());
}
}
return boolValue;
}

public boolean getFamilyIncomeofeachshgmember(HashMap hshRecord) 
{

	String strCode="",strshgcode="";
	String strValue="",strshgvalue="";
	String strAppno="";
	strCode=Helper.correctNull((String)hshRecord.get("strFamilyIncomeCode"));
	strValue=Helper.correctNull((String)hshRecord.get("strFamilyIncomeValue"));
	strshgcode=Helper.correctNull((String)hshRecord.get("strSHGProposedloancode"));
	strshgvalue=Helper.correctNull((String)hshRecord.get("strSHGProposedloanvalue"));
	
	strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
	ResultSet rs=null,rs1=null,rs2=null;
	String strChkValue="";
	String strCheck="";
	String strQuery="";
	String strLoanType="";
	String strValuesin="";
	boolean boolValue=false;
	try
	{
		
		strLoanType=Helper.correctNull((String) hshRecord.get("strLoanType"));
		strValuesin=Helper.correctNull((String) hshRecord.get("strValuesin"));
		
		if(!strLoanType.equalsIgnoreCase("P"))
		{
			if(!strValuesin.equalsIgnoreCase("R"))
			{
				strValue=Helper.convertSetupToApplicationValues(strValuesin, Double.parseDouble((String)Helper.correctNull(strValue)));
			}
		}

		strQuery = SQLParser.getSqlQuery("selmisstaticdata^19"+"^E"+"^"+strCode);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
		}
		if(rs!=null)
		{
			rs.close();
		}
		double dblIncome=0.00;
		String strEmployment="";
		String strNetSal="";
		String strITRSal="";
		int shgcount=0;
		int propshgcount=0;
		strQuery = SQLParser.getSqlQuery("sel_shgcount^"+strAppno);	
		
		rs1=DBUtils.executeQuery(strQuery);
		if(rs1.next())
		{
			shgcount=Integer.parseInt(Helper.correctInt((String)rs1.getString("shgcount")));
		 log.info("<<<<<<<<<<<<<<===================shgcount=================>>>>>>>>>>>>"+shgcount);
		}
		if(rs1!=null){
			rs1.close();
		}
		String strPlus="+";
		strValue=strValue +" "+"group by app_no";
		if(! (strshgcode.equalsIgnoreCase("") || strshgvalue.equalsIgnoreCase("") || strshgcode.equalsIgnoreCase("0") || strshgvalue.equalsIgnoreCase("0")))
		{
		strQuery = SQLParser.getSqlQuery("sel_loanshare_shg1^"+strAppno);	
		rs2=DBUtils.executeQuery(strQuery);
		while(rs2.next()){
		if(!strLoanType.equalsIgnoreCase("P"))
		{
		
			strQuery = SQLParser.getSqlQuery("sel_shgIncomecorp^"+strAppno+"^"+Helper.correctNull((String)rs2.getString("appid")));	
			 log.info("<<<<<<<<<<<<<<===================appid=================>>>>>>>>>>>>"+Helper.correctNull((String)rs2.getString("appid")));

		}
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strEmployment=Helper.correctNull((String)rs.getString("perapp_employment"));
			strNetSal=Helper.correctNull((String)rs.getString("perinc_takehome"));
			strITRSal=Helper.correctNull((String)rs.getString("perinc_year1_income"));
		}
		if(strEmployment.equalsIgnoreCase("1") || strEmployment.equalsIgnoreCase("1"))
		{
			dblIncome=dblIncome+Double.parseDouble((String)Helper.correctDouble((String)strNetSal));
		}
		else
		{
			dblIncome=dblIncome+Double.parseDouble((String)Helper.correctDouble((String)strITRSal));
		}
	
		
		
	//	strCheck= " and indinfo_family_income"+" "+ strCode +" "+strValue;
		
		strCheck= " having sum (indinfo_family_income"+ " "+ strPlus + " " +dblIncome+")"+" "+ strCode +" "+strValue;


		if(!strLoanType.equalsIgnoreCase("P"))
		{
		
			strQuery = SQLParser.getSqlQuery("selcustomerdatacorp^"+strAppno+"^"+strCheck);
		}
		propshgcount++;
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{ 
			if(shgcount==propshgcount){
			boolValue=true;
			}
		}
		else
		{
			boolValue=false;
		}
	}
	log.info("<<<<<<<<<======propshgcount==============>>>>>>>>>>>"+propshgcount);
		
	}
	}
	catch (Exception e)
	{
		throw new EJBException("Error in getting Family Income of each shg member"+e.getMessage());
	}
	finally
	{
		try
		{	if(rs != null)
				rs.close();
		}
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}
	return boolValue;		
}

public boolean getDwellingunit(HashMap hshRecord) 
{
	String strCode="";
	String strValue="";
	String strAppno="";
	strCode=Helper.correctNull((String)hshRecord.get("strConstCode"));
	strValue=Helper.correctNull((String)hshRecord.get("strConstValue"));
	strAppno=Helper.correctNull((String)hshRecord.get("strAppno"));
	ResultSet rs=null;
	String strChkValue="";
	String strCheck="";
	String strQuery="";
	String strLoanType="";
	String strFacilitySno="";
	String strValuesin="";
	boolean boolValue=false;
	try
	{
		
		strLoanType=Helper.correctNull((String) hshRecord.get("strLoanType"));
		strFacilitySno=Helper.correctNull((String) hshRecord.get("strFacilitySno"));
		strValuesin=Helper.correctNull((String) hshRecord.get("strValuesin"));
		
		if(!strLoanType.equalsIgnoreCase("P"))
		{
			if(!strValuesin.equalsIgnoreCase("R"))
			{
				strValue=Helper.convertSetupToApplicationValues(strValuesin, Double.parseDouble((String)Helper.correctNull(strValue)));
			}
		}

		
		strQuery = SQLParser.getSqlQuery("selmisstaticdata^19"+"^E"+"^"+strCode);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strCode=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
		}
		if(rs!=null)
		{
			rs.close();
		}
		
		strCheck= " and APP_DWELLING_UNIT  "+" "+ strCode +"  "+strValue;
		strQuery = SQLParser.getSqlQuery("selmisappdisplayscreendetails^"+strAppno+"^"+strFacilitySno+"^"+strCheck);
		
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			boolValue=true;
		}
		else
		{
			boolValue=false;
		}
	}
	catch (Exception e)
	{
		throw new EJBException("Error in getting getDwellingunit "+e.getMessage());
	}
	finally
	{
		try
		{	if(rs != null)
				rs.close();
		}
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}
	return boolValue;	
}
public HashMap alliedgetMISActivityCodeDetails(HashMap hshValues) 
{
	HashMap hshRecord=new HashMap();
	ArrayList arrRow=new ArrayList();
	ArrayList arrCol=new ArrayList();
	ResultSet rs=null;
	ResultSet rs1=null;
	ResultSet rs2=null;
	String strQuery="", strActivityCode="", strCategory="", strActivity="";
	String strPageFrom = "";
	String strPrdCode = "",strActCode="",strPrdPurpose="";
	String strMainActivityCode = "",strSubActivityCode="";
	String strLoanType="",strCorpProductCode="";
	String strAppno="" , strModuleType="c";
	String FacilitySno="";
	String alliedcodesel="";
	HashMap hshMisActivityCode=new HashMap();
	HashMap hshMisActivityDesc=new HashMap();
	
	
	try
	{
		strPageFrom = Helper.correctNull((String)hshValues.get("master"));
		strActivityCode=Helper.correctNull((String)hshValues.get("txt_Activity"));
		strCategory=Helper.correctNull((String)hshValues.get("hidCategory"));
		strPrdCode = Helper.correctNull((String)hshValues.get("prdcode"));
		
		strLoanType= Helper.correctNull((String)hshValues.get("strLoanType"));
		strCorpProductCode= Helper.correctNull((String)hshValues.get("strCorpProductCode"));
		FacilitySno= Helper.correctNull((String)hshValues.get("facilitySno"));
		alliedcodesel=Helper.correctNull((String)hshValues.get("selectall"));
		log.info(" =================product activity code =================="+strCorpProductCode);
		log.info(" =================strLoanType=================="+strLoanType);
		
		if(strLoanType.equalsIgnoreCase("C") || strLoanType.equalsIgnoreCase("A"))
		{
			strPrdCode=strCorpProductCode;
		}
		strAppno=Helper.correctNull((String)hshValues.get("strappno"));

		if(strPageFrom.equalsIgnoreCase("mis") )
		{
			if(alliedcodesel.equalsIgnoreCase("alliedcode"))
			{
				strQuery=SQLParser.getSqlQuery("allied_sel_Activityallcode");
			}
			else
			{
			if(strCategory.equalsIgnoreCase("1"))
			{
				strActivity="and act_activitycode='"+strActivityCode+"'";
			}
			else
			{
				strActivity="and upper(msd.mis_static_data_desc) like upper('%"+strActivityCode+"%')";
			}
			
			strQuery=SQLParser.getSqlQuery("allied_sel_Activity^"+strActivity);
			}
		}
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
					arrCol=new ArrayList();
					arrCol.add(Helper.correctNull((String)rs.getString("act_sno")));//0
					arrCol.add(Helper.correctNull((String)rs.getString("act_mainactcode")));//1
					arrCol.add(Helper.correctNull((String)rs.getString("act_subactcode")));//2
					arrCol.add(Helper.correctNull((String)rs.getString("act_purposecode")));//3
					arrCol.add(Helper.correctNull((String)rs.getString("act_activitycode")));//4
					arrCol.add(Helper.correctNull((String)rs.getString("act_bsrcode")));//5
					arrCol.add(Helper.correctNull((String)rs.getString("act_bsr1code")));//6
					arrCol.add(Helper.correctNull((String)rs.getString("act_displayscreen")));//7
					arrCol.add(Helper.correctNull((String)rs.getString("act_industrytype")));//8
					arrCol.add(Helper.correctNull((String)rs.getString("act_show")));//9
					arrCol.add(Helper.correctNull((String)rs.getString("act_createdate")));//10
					arrCol.add(Helper.correctNull((String)rs.getString("act_modifieddate")));//11
					arrCol.add(Helper.correctNull((String)rs.getString("act_purposesno")));//12
					arrCol.add(Helper.correctNull((String)rs.getString("mis_static_data_desc")));//13
					arrCol.add(Helper.correctNull((String)rs.getString("act_lbrcode")));//14
					
					
					strMainActivityCode = Helper.correctNull((String)rs.getString("act_mainactcode"));
					strQuery = SQLParser.getSqlQuery("sel_misstaticdatadesc^"+"2"+"^"+strMainActivityCode);
					rs1= DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						arrCol.add(Helper.correctNull((String)rs1.getString("mis_static_data_desc")));//15
					}
					else
					{
						arrCol.add("");//15
					}
					strSubActivityCode = Helper.correctNull((String)rs.getString("act_subactcode"));
					strQuery = SQLParser.getSqlQuery("sel_MISSubActivityDesc^"+strMainActivityCode+"^"+strSubActivityCode);
					rs2= DBUtils.executeQuery(strQuery);
					if(rs2.next())
					{
						arrCol.add(Helper.correctNull((String)rs2.getString("mis_subactdesc")));//16
					}
					else
					{
						arrCol.add("");//16
					}
					arrCol.add(Helper.correctNull((String)rs.getString("act_busruleid")));//17
					arrCol.add(Helper.correctNull((String)rs.getString("act_schematicflag")));//18	
					arrCol.add(Helper.correctNull(rs.getString("act_freecode6")));//19
					arrCol.add(Helper.correctNull(rs.getString("act_freecode7")));//20
					arrCol.add(Helper.correctNull(rs.getString("act_freecode8")));//21
					arrCol.add(Helper.correctNull(rs.getString("ACT_CGTMSE")));//22
					arrCol.add(Helper.correctNull(rs.getString("ACT_ALLIED")));//23
					arrRow.add(arrCol);
				
				
			}
			hshRecord.put("arrRow", arrRow);
			hshRecord.put("strLoanType",strLoanType);
			hshRecord.put("strCorpProductCode",strCorpProductCode);
			hshRecord.put("appno",strAppno);
			hshRecord.put("FacilitySno", FacilitySno);
			
			
			
	}
	catch(Exception e)
	{
		throw new EJBException("Exception occured in alliedgetMISActivityCodeDetails "+e.getMessage());
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
		catch(Exception ex)
		{
			throw new EJBException("Error in closing connection in getBSRCode");
		}
	}
	return hshRecord;
}

}
