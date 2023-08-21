package com.sai.laps.ejb.adhoc;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.helper.SetupParams;
import com.sai.laps.tagdatahelper.TagDataHelperADC;
@Stateless(name = "adhocBean", mappedName = "adhocHome")
@Remote (adhocRemote.class)
public class adhocBean extends BeanAdapter
{

	static Logger log=Logger.getLogger(adhocBean.class);	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8023300715585591892L;
	
	
	public HashMap getDataFinal(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = null;
		String strid="",strQuery="";
		ArrayList vecval =  new ArrayList();
		ArrayList vecdata =  new ArrayList();
		
		try
		{
			hshRecord = new HashMap();
			strid = correctNull((String)hshRequestValues.get("id"));
			if(strid.equalsIgnoreCase(""))
			{
				strid=Helper.correctNull((String)hshRequestValues.get("comapp_id"));
			}
			  
			String strOrgSelect=correctNull((String)hshRequestValues.get("strOrgSelect"));

			strQuery = SQLParser.getSqlQuery("adc_applnlist^"+strOrgSelect+"%^"+strid);
			
			rs =DBUtils.executeQuery(strQuery);	
			while(rs.next())
			{
				vecval =  new ArrayList();
				vecval.add(rs.getString("adc_appno"));
				vecval.add(rs.getString("comapp_companyname"));
				vecval.add(rs.getString("adc_staus"));
				String strAppholderid=correctNull(rs.getString("adc_holdusrid"));
				if(correctNull((String)hshRequestValues.get("strUserId")).equals(strAppholderid))
				{
					vecval.add("Y");
					vecval.add(strAppholderid);
				}
				else
				{
					vecval.add("N");	
					vecval.add(strAppholderid);
				}
				vecdata.add(vecval);	
			}
			hshRecord.put("vecval",vecdata);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
		}
		finally
		{
			try
			{				
				if(rs != null)
				{
					rs.close();
				}	
				if(rs1!=null)
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
	
	
	public HashMap getFacilityData(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		
		ResultSet rs=null;
		ResultSet rs1=null;
		
		ArrayList arrCol = null;
		ArrayList arrRow = new ArrayList();
		
		String strQuery="";
		String strAppno="";
		String strcomappid="";
		try
		{
			strAppno= correctNull((String)hshValues.get("appno"));	
			strcomappid= correctNull((String)hshValues.get("hidapplicantid"));
			strQuery=SQLParser.getSqlQuery("sel_adcfacility^"+strAppno+"^0");

			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("adcfac_appno")));//0
				arrCol.add(correctNull(rs.getString("adcfac_headid")));//1
				arrCol.add(correctNull(rs.getString("adcfac_id")));//2
				arrCol.add(Helper.correctDouble(rs.getString("adcfac_amount")));//3
				arrCol.add(correctNull(rs.getString("adcfac_interest")));//4
				arrCol.add(correctNull(rs.getString("adcfac_margin")));//5
				arrCol.add(Helper.correctDouble(rs.getString("adcfac_os")));//6
				arrCol.add(correctNull(rs.getString("adcfac_osason")));//7
				arrCol.add(correctNull(rs.getString("adcfac_months")));//8
				arrCol.add(correctNull(rs.getString("adcfac_secvalue")));//9
				arrCol.add(correctNull(rs.getString("adcfac_remarks")));//10
				arrCol.add(correctNull(rs.getString("adcfac_cbsaccno")));//11
				arrCol.add(correctNull(rs.getString("adcfac_group")));//12
				String strFacgrp=correctNull(rs.getString("adcfac_sno"));
				arrCol.add(strFacgrp);//13
				arrCol.add(correctNull(rs.getString("facheaddesc")));//14
				arrCol.add(correctNull(rs.getString("facdesc")));//15
				arrCol.add(correctNull(rs.getString("adcfac_category")));//16
				arrRow.add(arrCol);
				
				strQuery=SQLParser.getSqlQuery("sel_adcfacility^"+strAppno+"^"+strFacgrp);
				
				if(rs1!=null)
					rs1.close();
				
				rs1=DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					arrCol = new ArrayList();
					arrCol.add(correctNull(rs1.getString("adcfac_appno")));//0
					arrCol.add(correctNull(rs1.getString("adcfac_headid")));//1
					arrCol.add(correctNull(rs1.getString("adcfac_id")));//2
					arrCol.add(Helper.correctDouble(rs1.getString("adcfac_amount")));//3
					arrCol.add(correctNull(rs1.getString("adcfac_interest")));//4
					arrCol.add(correctNull(rs1.getString("adcfac_margin")));//5
					arrCol.add(Helper.correctDouble(rs1.getString("adcfac_os")));//6
					arrCol.add(correctNull(rs1.getString("adcfac_osason")));//7
					arrCol.add(correctNull(rs1.getString("adcfac_months")));//8
					arrCol.add(correctNull(rs1.getString("adcfac_secvalue")));//9
					arrCol.add(correctNull(rs1.getString("adcfac_remarks")));//10
					arrCol.add(correctNull(rs1.getString("adcfac_cbsaccno")));//11
					arrCol.add(correctNull(rs1.getString("adcfac_group")));//12
					arrCol.add(correctNull(rs1.getString("adcfac_sno")));//13
					arrCol.add(correctNull(rs1.getString("facheaddesc")));//14
					arrCol.add(correctNull(rs1.getString("facdesc")));//15
					arrCol.add(correctNull(rs1.getString("adcfac_category")));//16
					arrRow.add(arrCol);
				}
			}			
			
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("appno",strAppno);
			
			
			if(strAppno.equalsIgnoreCase("NEW"))
			{
				strQuery=SQLParser.getSqlQuery("adc_checkapplnstatus^"+"'OP','PR','PA'"+"^"+strcomappid);
				
				rs=DBUtils.executeQuery(strQuery);
			
				if(rs.next())
				{
					hshRecord.put("checkappln","true");
				}
				else
				{
					hshRecord.put("checkappln","false");
				}
			}
			
			if(strAppno.equalsIgnoreCase("NEW"))
			{
				hshRecord.put("btnenable","Y");
				hshRecord.put("appholder","Y");
				hshRecord.put("appstatus","op");
			}
			else
			{
				TagDataHelperADC tagDataHelperadc=new TagDataHelperADC();
				hshRecord.putAll((HashMap)tagDataHelperadc.getADCAppData(hshValues));
				
				char readFlag=Helper.correctNull((String)hshValues.get("strGroupRights")).charAt(18);
				String strAppholder=hshValues.get("strUserId").equals(correctNull((String)hshRecord.get("applnholder")))?"Y":"N";
				hshRecord.put("btnenable",(""+readFlag).equals("r")?"N":(correctNull((String)hshRecord.get("appstatus")).equalsIgnoreCase("op") && strAppholder.equals("Y"))?"Y":"N");
			}
		}
		catch(Exception ex)
		{
			throw new EJBException("Error in getFacilityData of adhocBean :: "+ex.toString());
		}
		finally
		{
			try{
				if(rs!=null)
				{
					rs.close();
				}
			}
			catch(Exception ex)
			{
				throw new EJBException("Error in Closing the connection in getFacilityData of adhocBean"+ ex.toString());
			}
		}
		return hshRecord;
	}
	public HashMap updateFacilityData(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
				
		ArrayList arrValues=new ArrayList();
		
		ResultSet rs=null;
		
		String strAction=(String)hshValues.get("hidAction");
		String strAppno="";
		int intUpdateSize=0;
		StringTokenizer stk = null;
		
		String strSno="";
		String strFactype="";
		String strFacilityhead="";
		String strFacility="";
		String strAmount="";
		String strOutstanding="";
		String strInterest="";
		String strOutstandingason="";
		String strSecurity="";
		String strOverdue="";
		String strMargin="";
		String strPeriod="";
		String strCbsno="";
		String strFacilitygroup="0";
		String strCategory="";
		String strPrdcode="";
		
		String strSolid="";
		String strLimitAvil="";
		String strQuery="";
		
		String strmsg="";
		try
		{

			strSno=correctNull((String)hshValues.get("hidsno"));
			strFactype=correctNull((String)hshValues.get("hidfactype"));
			strAppno=correctNull((String)hshValues.get("appno"));
			strSolid=correctNull((String)hshValues.get("strSolid"));
			
			if(strFactype.equals("sublimit"))
			{
				strFacilityhead=correctNull((String) hshValues.get("subfacility_head"));
				stk = new StringTokenizer(strFacilityhead,"-");
				if(stk.hasMoreTokens())
				{
					strFacilityhead = (String)stk.nextToken();
				}
				
				strFacility =correctNull((String) hshValues.get("subfacility"));
				stk = new StringTokenizer(strFacility,"-");
				if(stk.hasMoreTokens())
				{
					strFacility = (String)stk.nextToken();
				}
				
				strAmount=Helper.correctDouble((String)hshValues.get("txt_subamt"));
				strOutstanding=Helper.correctDouble((String)hshValues.get("txt_suboutstanding"));
				strInterest=correctNull((String)hshValues.get("txt_subint"));
				strOutstandingason=correctNull((String)hshValues.get("txt_suboutstandingason"));
				strSecurity=correctNull((String)hshValues.get("txt_subsecurity"));
				strOverdue=correctNull((String)hshValues.get("txt_suboverdue"));
				strMargin=correctNull((String)hshValues.get("txt_submargin"));
				strPeriod=correctNull((String)hshValues.get("txt_subperiod"));
				strCbsno=correctNull((String)hshValues.get("txt_subcbsno"));
				strFacilitygroup=correctNull((String)hshValues.get("hidfacgrp"));
				strCategory=correctNull((String)hshValues.get("faccategory"));
			}
			else
			{
				strFacilityhead=correctNull((String) hshValues.get("facility_head"));
				stk = new StringTokenizer(strFacilityhead,"-");
				if(stk.hasMoreTokens())
				{
					strFacilityhead = (String)stk.nextToken();
				}
				
				strFacility =correctNull((String) hshValues.get("facility"));
				stk = new StringTokenizer(strFacility,"-");
				if(stk.hasMoreTokens())
				{
					strFacility = (String)stk.nextToken();
				}
				
				strAmount=Helper.correctDouble((String)hshValues.get("txt_amt"));
				strOutstanding=Helper.correctDouble((String)hshValues.get("txt_outstanding"));
				strInterest=correctNull((String)hshValues.get("txt_int"));
				strOutstandingason=correctNull((String)hshValues.get("txt_outstandingason"));
				strSecurity=correctNull((String)hshValues.get("txt_security"));
				strOverdue=correctNull((String)hshValues.get("txt_overdue"));
				strMargin=correctNull((String)hshValues.get("txt_margin"));
				strPeriod=correctNull((String)hshValues.get("txt_period"));
				strCbsno=correctNull((String)hshValues.get("txt_cbsno"));
				strCategory=correctNull((String)hshValues.get("faccategory"));
			}
			
			
			
			if(strAppno.equalsIgnoreCase("NEW"))
			{
				
				strQuery=SQLParser.getSqlQuery("selautolimitid^C^"+strAmount);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strPrdcode=correctNull(rs.getString("prd_code"));
				}
				
				
				if(strPrdcode.equalsIgnoreCase(""))
				{
					strLimitAvil="Limit Master Not defined in setup";
					
				}
				else
				{
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					intUpdateSize++;
					
					strAppno=getADCAppno(strSolid);
					
					hshQuery.put("strQueryId","ins_adcapplication");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String)hshValues.get("strUserId")));
					arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
					arrValues.add(correctNull((String)hshValues.get("valuesin")));
					arrValues.add(strPrdcode);
					arrValues.add(correctNull((String)hshValues.get("com_id")));
					arrValues.add(correctNull((String)hshValues.get("strUserId")));
					
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdateSize,hshQuery);	
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					intUpdateSize++;				
					hshQuery.put("strQueryId","ins_adcfacility");
					arrValues.add(strAppno);
					arrValues.add(getMaxADCfacilityId(strAppno));
					arrValues.add(strFacilityhead);
					arrValues.add(strFacility);
					arrValues.add(strFacilitygroup);
					arrValues.add(strCategory);
					arrValues.add(strAmount);
					arrValues.add(strInterest);
					arrValues.add(strMargin);
					arrValues.add(strOutstanding);
					arrValues.add(strOutstandingason);
					arrValues.add(strPeriod);
					arrValues.add(strSecurity);
					arrValues.add(strOverdue);
					arrValues.add(strCbsno);
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdateSize,hshQuery);	
				}
				
			}
			else
			{	
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdateSize++;
				if(strAction.equalsIgnoreCase("delete"))
				{
					strQuery=SQLParser.getSqlQuery("sel_adcfacility^"+strAppno+"^"+strSno);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						//strExp=strExp+"Sub Limit Exists, Cannot be deleted";
						//throw new EJBException(strExp);
						strmsg="Sub Limit Exists, Cannot be deleted";
					}
					
					if(strmsg.equalsIgnoreCase(""))
					{
						hshQuery.put("strQueryId","del_adcfacility");
						arrValues.add(strAppno);
						arrValues.add(strSno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdateSize,hshQuery);
					}
				}
				else if(strAction.equalsIgnoreCase("insert"))
				{
					hshQuery.put("strQueryId","ins_adcfacility");
					
					arrValues.add(strAppno);
					arrValues.add(getMaxADCfacilityId(strAppno));
					arrValues.add(strFacilityhead);
					arrValues.add(strFacility);
					arrValues.add(strFacilitygroup);
					arrValues.add(strCategory);
					arrValues.add(strAmount);
					arrValues.add(strInterest);
					arrValues.add(strMargin);
					arrValues.add(strOutstanding);
					arrValues.add(strOutstandingason);
					arrValues.add(strPeriod);
					arrValues.add(strSecurity);
					arrValues.add(strOverdue);
					arrValues.add(strCbsno);
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdateSize,hshQuery);	
					
					if(!(strOutstandingason.equalsIgnoreCase("")))
					{
					
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						intUpdateSize++;
						
						hshQuery.put("strQueryId","updadcfacility");
						
						arrValues.add(strOutstandingason);
						arrValues.add(strAppno);
						
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdateSize,hshQuery);
					}
					
				}
				else if(strAction.equalsIgnoreCase("update"))
				{
					hshQuery.put("strQueryId","upd_adcfacility");	
					
					arrValues.add(strFacilityhead);
					arrValues.add(strFacility);
					arrValues.add(strFacilitygroup);
					arrValues.add(strCategory);
					arrValues.add(strAmount);
					arrValues.add(strInterest);
					arrValues.add(strMargin);
					arrValues.add(strOutstanding);
					arrValues.add(strOutstandingason);
					arrValues.add(strPeriod);
					arrValues.add(strSecurity);
					arrValues.add(strOverdue);
					arrValues.add(strCbsno);
					arrValues.add(strAppno);
					arrValues.add(strSno);
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdateSize,hshQuery);	
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					intUpdateSize++;
					
					hshQuery.put("strQueryId","updadcfacility");
					
					arrValues.add(strOutstandingason);
					arrValues.add(strAppno);
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdateSize,hshQuery);
				}
			}
			if(strmsg.equalsIgnoreCase(""))
			{
				hshQueryValues.put("size",""+intUpdateSize);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			}
			
			
			hshValues.put("appno",strAppno);
			hshRecord = getFacilityData(hshValues);
			hshRecord.put("msg",strmsg);
			hshRecord.put("strLimitAvil",strLimitAvil);
		
		}catch(Exception ex)
		{
			throw new EJBException("Error in updateFacilityData of adhocBean :: "+ex.toString());
		}
		return hshRecord;
	}
	
	public void updateSecurityData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		
		String strAppno="";
		String strAction="";
		String strSecno="";
		
		int intUpdatesize=0;
		
		try
		{

			strAction=correctNull((String)hshValues.get("hidAction"));
			strAppno=correctNull((String)hshValues.get("appno"));
			strSecno=correctNull((String)hshValues.get("hidsno"));
			
			
			
			if(strAction.equals("Insert"))
			{
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize++;
				strSecno=getMaxsecno(strAppno);
				arrValues.add(strAppno);
				arrValues.add(strSecno);
				arrValues.add(correctNull((String)hshValues.get("hidsecid")));
				arrValues.add(correctNull((String)hshValues.get("txtsecdetails")));
				arrValues.add(correctNull((String)hshValues.get("txtsecvalue")));
				arrValues.add(correctNull((String)hshValues.get("txtsecvaldate")));
				arrValues.add(correctNull((String)hshValues.get("selsectype")));
				arrValues.add(correctNull((String)hshValues.get("txtsectenor")));
				arrValues.add(correctNull((String)hshValues.get("txtvaluername")));
				arrValues.add(correctNull((String)hshValues.get("txtinsuranceamt")));
				arrValues.add(correctNull((String)hshValues.get("txtinsexpdate")));
				arrValues.add(correctNull((String)hshValues.get("txtremarks")));
				arrValues.add(correctNull((String)hshValues.get("sellimit")));
				hshQuery.put("strQueryId","ins_adcsecdetails");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
			else if(strAction.equals("Update"))
			{
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize++;
			
				arrValues.add(correctNull((String)hshValues.get("hidsecid")));
				arrValues.add(correctNull((String)hshValues.get("txtsecdetails")));
				arrValues.add(correctNull((String)hshValues.get("txtsecvalue")));
				arrValues.add(correctNull((String)hshValues.get("txtsecvaldate")));
				arrValues.add(correctNull((String)hshValues.get("selsectype")));
				arrValues.add(correctNull((String)hshValues.get("txtsectenor")));
				arrValues.add(correctNull((String)hshValues.get("txtvaluername")));
				arrValues.add(correctNull((String)hshValues.get("txtinsuranceamt")));
				arrValues.add(correctNull((String)hshValues.get("txtinsexpdate")));
				arrValues.add(correctNull((String)hshValues.get("txtremarks")));
				arrValues.add(correctNull((String)hshValues.get("sellimit")));
				arrValues.add(strAppno);
				arrValues.add(strSecno);
				hshQuery.put("strQueryId","upd_adcsecdetails");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
			else if(strAction.equals("Delete"))
			{
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize++;
				
				arrValues.add(strAppno);
				arrValues.add(strSecno);
				hshQuery.put("strQueryId","del_adcsecdetails");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
			
			hshQueryValues.put("size",""+intUpdatesize);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		
		}catch(Exception ex)
		{
			throw new EJBException("Error in updateSecurityData of adhocBean :: "+ex.toString());
		}
	}
	
	public HashMap getSecurityData(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		
		String strAppno="";
		String strQuery="";
		
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		try
		{
			hshRecord=new HashMap();
			strAppno=correctNull((String)hshValues.get("appno"));
			
			strQuery=SQLParser.getSqlQuery("sel_adcsecdetails^"+strAppno);
			
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(correctNull(rs.getString("sec_srlno")));//0
				arrCol.add(correctNull(rs.getString("sec_id")));//1
				arrCol.add(correctNull(rs.getString("sec_name")));//2
				arrCol.add(correctNull(rs.getString("sec_desc")));//3
				arrCol.add(correctNull(rs.getString("sec_value")));//4
				arrCol.add(correctNull(rs.getString("sec_valuedate")));//5
				arrCol.add(correctNull(rs.getString("sec_tenor")));//6
				arrCol.add(correctNull(rs.getString("sec_type")));//7
				arrCol.add(correctNull(rs.getString("sec_valuedby")));//8
				arrCol.add(correctNull(rs.getString("sec_insamt")));//9
				arrCol.add(correctNull(rs.getString("sec_insexpdate")));//10
				arrCol.add(correctNull(rs.getString("sec_remarks")));//11
				arrCol.add(correctNull(rs.getString("sec_facsno")));//12
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow",arrRow);
		
			
		}catch(Exception ex)
		{
			throw new EJBException("Error in getSecurityData of adhocBean :: "+ex.toString());
		}
		finally
		{
			try{
				if(rs!=null)
				{
					rs.close();
				}
			}
			catch(Exception ex)
			{
				throw new EJBException("Error in Closing the connection in getSecurityData of adhocBean"+ ex.toString());
			}
		}
		return hshRecord;
	}
	
	public void updateBankingDetails(HashMap hshValues) 
	{
		try
		{
			HashMap hshQueryValues = new HashMap();
			HashMap hshQuery = new HashMap();
			ArrayList arrValues = new ArrayList();
			String strAppno="";
			String strAction="";
			int intUpdatesize=0;
			
				strAction=correctNull((String)hshValues.get("hidAction"));
				strAppno=correctNull((String)hshValues.get("appno"));
				
				if(strAction.equals("Update"))
				{
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					intUpdatesize++;
					arrValues.add(strAppno);
					hshQuery.put("strQueryId","del_adcbankdetails");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					intUpdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String)hshValues.get("selmulbank")));
					arrValues.add(correctNull((String)hshValues.get("txtleadbank")));
					//arrValues.add(correctNull((String)hshValues.get("txtourbank")));
					arrValues.add(correctNull((String)hshValues.get("selassest")));
					arrValues.add(correctNull((String)hshValues.get("txtinrating")));
					arrValues.add(correctNull((String)hshValues.get("txtrev_duedate")));
					arrValues.add(correctNull((String)hshValues.get("txtextratingst")));
					arrValues.add(correctNull((String)hshValues.get("txtextratinglt")));
					arrValues.add(correctNull((String)hshValues.get("selstatus")));
					arrValues.add(correctNull((String)hshValues.get("wc_existfb")));
					arrValues.add(correctNull((String)hshValues.get("wc_propfb")));
					arrValues.add(correctNull((String)hshValues.get("wc_existnfb")));
					arrValues.add(correctNull((String)hshValues.get("wc_propnfb")));
					hshQuery.put("strQueryId","ins_adcbankdetails");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
				}
				else if(strAction.equals("Delete"))
				{
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					intUpdatesize++;
					arrValues.add(strAppno);
					hshQuery.put("strQueryId","del_adcbankdetails");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
				}
				
				hshQueryValues.put("size",""+intUpdatesize);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				/** Audit Trial Starts Here**/
				StringBuilder sbAt = new StringBuilder();
				if(!(strAction.equals("Delete")))
				{
					sbAt.append("~Sole/Consortium/Multiple Banking =").append(SetupParams.getSetupParams("BankType",correctNull((String)hshValues.get("selmulbank"))));
					sbAt.append(" ~Lead Bank  = ").append(correctNull((String)hshValues.get("txtleadbank")));
					sbAt.append(" ~Fund	Based (WC + TL) = ").append(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("wc_existfb")))));
					sbAt.append(" ~Proposed = ").append(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("wc_propfb")))));
					sbAt.append(" ~Non Fund Based = ").append(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("wc_existnfb")))));
					sbAt.append(" ~Proposed = ").append(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("wc_propnfb")))));
					sbAt.append(" ~Asset Classification = ").append(SetupParams.getSetupParams("AssetClassification",correctNull((String)hshValues.get("selassest"))));
					sbAt.append(" ~Internal Credit Rating = ").append(correctNull((String)hshValues.get("txtinrating")));
					sbAt.append(" ~Due date of Review = ").append(correctNull((String)hshValues.get("txtrev_duedate")));
					sbAt.append(" ~External Credit Rating (Short Term) = ").append(correctNull((String)hshValues.get("txtextratingst")));
					sbAt.append(" ~External Credit Rating (Long Term) = ").append(correctNull((String)hshValues.get("txtextratinglt"))); 
					sbAt.append(" ~Status of Account = ").append(SetupParams.getSetupParams("AccountStatus", correctNull((String)hshValues.get("selstatus"))));
				}
				AuditTrial.auditLog(hshValues,"289",strAppno,sbAt.toString());
				
			
		}catch(Exception ex)
		{
			throw new EJBException("Error in updateBankingDetails of adhocBean :: "+ex.toString());
		}
	}
	
	public HashMap getBankingDetails(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		boolean recordflag=false;
		try
		{
			String strAppno="";
			String strQuery="";
			hshRecord=new HashMap();
			strAppno=correctNull((String)hshValues.get("appno"));
				
			strQuery=SQLParser.getSqlQuery("sel_adcbankdetails^"+strAppno);
				
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("bankingtype",rs.getString("adcbank_type"));
				hshRecord.put("leadbank",rs.getString("adcbank_leadbank"));
				//hshRecord.put("ourbank",rs.getString("adcbank_share"));
				hshRecord.put("asset",rs.getString("adcbank_asset"));
				hshRecord.put("int_rating",rs.getString("adcbank_internalrating"));
				hshRecord.put("rev_duedate",rs.getString("adcbank_reviewduedate"));
				hshRecord.put("ext_rating_short",rs.getString("adcbank_externalrating_st"));
				hshRecord.put("ext_rating_long",rs.getString("adcbank_externalrating_lt"));
				hshRecord.put("accstatus",rs.getString("adcbank_accountstatus"));
				
				hshRecord.put("WC_SHARE_FE",rs.getString("adcbank_propexistfb"));
				hshRecord.put("WC_SHARE_FP",rs.getString("adcbank_propproposedfb"));
				hshRecord.put("WC_SHARE_NFE",rs.getString("adcbank_propexistnfb"));
				hshRecord.put("WC_SHARE_NFP",rs.getString("adcbank_propproposednfb"));
				recordflag=true;
			}
			  if(recordflag)
				hshRecord.put("recordflag","Y");
			  else
				hshRecord.put("recordflag","N");
			
		}catch(Exception ex)
		{
			throw new EJBException("Error in getBankingDetails of adhocBean :: "+ex.toString());
		}
		finally
		{
			try{
				if(rs!=null)
				{
					rs.close();
				}
			}
			catch(Exception ex)
			{
				throw new EJBException("Error in Closing the connection in getBankingDetails of adhocBean"+ ex.toString());
			}
		}
		return hshRecord;
	}
	
	public void updateFinancial(HashMap hshValues) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshQuery ;
		ArrayList arr = new ArrayList();
		String val="";
		String appno="";
		try
		{
			val=(String)hshValues.get("hidAction");
			appno=(String)hshValues.get("appno");

			String []first_year=null;	
			String []second_year=null;
			String []third_year=null;
			String []next_year=null;
			String []description=null;
			int intUpdatesize=0;
			
			if (val.equals("update"))
			{
				
				first_year= (String [])hshValues.get("txt_firstyear");
				second_year= (String [])hshValues.get("txt_secondyear");
				third_year= (String [])hshValues.get("txt_thirdyear");
				next_year= (String [])hshValues.get("txt_nextyear");
				description= (String [])hshValues.get("txt_desc");
				hshQuery = new HashMap();
				int len=first_year.length;
			
				hshQuery = new HashMap();
				hshqueryval = new HashMap();
				arr=new ArrayList();
				intUpdatesize=intUpdatesize+1;
				hshQuery.put("strQueryId","del_adhocfin");
				arr.add(appno);
				hshQuery.put("arrValues",arr);
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery = new HashMap();
				arr=new ArrayList();
				intUpdatesize=intUpdatesize+1;
				hshQuery.put("strQueryId","del_adhocfincomments");
				arr.add(appno);
				hshQuery.put("arrValues",arr);
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);
				
				for(int k=0,j=0;k<len;k++)
				{	
					
					hshQuery = new HashMap();
					arr=new ArrayList();
					intUpdatesize=intUpdatesize+1;
					hshQuery.put("strQueryId","ins_adhocfin");
					
					arr.add(appno);
					arr.add(Integer.toString(k));
					arr.add(correctNull((String)first_year[k]));
					arr.add(correctNull((String)second_year[k]));
					arr.add(correctNull((String)third_year[k]));
					arr.add(correctNull((String)next_year[k]));
					if(k==0 || k==1)
						arr.add("");
					else
					{
						arr.add(correctNull((String)description[j]));
						j++;
					}
					hshQuery.put("arrValues",arr);						
					hshqueryval.put("size",Integer.toString(intUpdatesize));
					hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
				}	
				
				
				hshQuery = new HashMap();
				arr=new ArrayList();
				intUpdatesize=intUpdatesize+1;
				hshQuery.put("strQueryId","ins_adhocfincomments");
				arr.add(appno);
				arr.add(Helper.correctNull((String)hshValues.get("comments")));
				hshQuery.put("arrValues",arr);
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);
			}
			else if(val.equals("delete"))
			{
				hshQuery = new HashMap();
				hshqueryval = new HashMap();
				arr=new ArrayList();
				intUpdatesize=intUpdatesize+1;
				hshQuery.put("strQueryId","del_adhocfin");
				arr.add(appno);
				hshQuery.put("arrValues",arr);
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery = new HashMap();
				arr=new ArrayList();
				intUpdatesize=intUpdatesize+1;
				hshQuery.put("strQueryId","del_adhocfincomments");
				arr.add(appno);
				hshQuery.put("arrValues",arr);
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);
				
			}
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
						
		}catch(Exception ex)
		{
			throw new EJBException("Error in updateFinancial of adhocBean :: "+ex.toString());
		}
	}
	
	public HashMap getFinancial(HashMap hshValues) 
	{
		ResultSet rs=null;		
		HashMap hshRecord=new HashMap();
		ArrayList arrVal = new ArrayList();
		ArrayList arrRec= new ArrayList();
		String appno="";
		String strQuery="";
		try
		{
			appno=(String)hshValues.get("appno");
			rs=DBUtils.executeLAPSQuery("sel_adhocfin^"+appno);
			
			while(rs.next())
			{
				arrRec = new ArrayList();						
				arrRec.add(correctNull(rs.getString("adcfin_pretyear")));
				arrRec.add(correctNull(rs.getString("adcfin_lastyear")));
				arrRec.add(correctNull(rs.getString("adcfin_currentyear")));
				arrRec.add(correctNull(rs.getString("adcfin_nextyear")));
				arrVal.add(arrRec);	
			}
			

			strQuery = SQLParser.getSqlQuery("sel_adhocfincomments^"+appno);
			rs = DBUtils.executeQuery(strQuery);	
			if(rs.next())
			{
				hshRecord.put("comments",correctNull(Helper.CLOBToString((rs.getClob("adcfincom_comments")))));
			}
			
			hshRecord.put("arrVal",arrVal);
		}catch(Exception ex)
		{
			throw new EJBException("Error in getFinancial of adhocBean :: "+ex.toString());
		}
		finally
		{
			try{
				if(rs!=null)
				{
					rs.close();
				}
			}
			catch(Exception ex)
			{
				throw new EJBException("Error in Closing the connection in getFinancial of adhocBean"+ ex.toString());
			}
		}
		return hshRecord;
	}
	
	public void updateGuaranteeData(HashMap hshValues) 
	{
		try
		{
			HashMap hshQueryValues = new HashMap();
			HashMap hshQuery = new HashMap();
			ArrayList arrValues = new ArrayList();
			String strAppno="";
			String strAction="";
			int intUpdatesize=0;
			
				strAction=correctNull((String)hshValues.get("hidAction"));
				strAppno=correctNull((String)hshValues.get("appno"));
				
				if(strAction.equals("Update"))
				{
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					intUpdatesize++;
					arrValues.add(strAppno);
					hshQuery.put("strQueryId","del_adcgaurantee");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					if(!correctNull((String)hshValues.get("txtarea_guarantee")).equals(""))
					{
						arrValues=new ArrayList();
						hshQuery=new HashMap();
						intUpdatesize++;
						arrValues.add(strAppno);
						arrValues.add(correctNull((String)hshValues.get("txtarea_guarantee")));
						hshQuery.put("strQueryId","ins_adcgaurantee");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdatesize,hshQuery);
					}
				}
				else if(strAction.equals("Delete"))
				{
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					intUpdatesize++;
					arrValues.add(strAppno);
					hshQuery.put("strQueryId","del_adcgaurantee");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
				}
				
				hshQueryValues.put("size",""+intUpdatesize);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}catch(Exception ex)
		{
			throw new EJBException("Error in updateGuaranteeData of adhocBean :: "+ex.toString());
		}
	}
	
	public HashMap getGuaranteeData(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		try
		{
			String strAppno="";
			String strQuery="";
			hshRecord=new HashMap();
			strAppno=correctNull((String)hshValues.get("appno"));
				
			strQuery=SQLParser.getSqlQuery("sel_adcgaurantee^"+strAppno);
				
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				
				hshRecord.put("guarantee_comment",correctNull(Helper.CLOBToString(rs.getClob("guarntee_comments"))));
				
			}
			
		}catch(Exception ex)
		{
			throw new EJBException("Error in getGuaranteeData of adhocBean :: "+ex.toString());
		}
		finally
		{
			try{
				if(rs!=null)
				{
					rs.close();
				}
			}
			catch(Exception ex)
			{
				throw new EJBException("Error in Closing the connection in getGuaranteeData of adhocBean"+ ex.toString());
			}
		}
		return hshRecord;
	}
	
	public void updateRecommendations(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		
		String strAppno="";
		String strAction="";
		int intUpdatesize=0;
		try
		{
			strAction=correctNull((String)hshValues.get("hidAction"));
			strAppno=correctNull((String)hshValues.get("appno"));
			
			if(strAction.equals("update"))
			{
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize++;
				
				arrValues.add(strAppno);
				arrValues.add(correctNull((String)hshValues.get("sel_level")));
				
				hshQuery.put("strQueryId","del_adcrecommendation");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize++;
			
				arrValues.add(strAppno);
				arrValues.add(correctNull((String)hshValues.get("sel_level")));
				arrValues.add(correctNull((String)hshValues.get("txt_recommendation")));
				arrValues.add(correctNull((String)hshValues.get("txt_signatures")));
				hshQuery.put("strQueryId","ins_adcrecommendation");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				
				hshQuery = new HashMap();	
				intUpdatesize++;
				arrValues=new ArrayList();
				arrValues.add(correctNull((String)hshValues.get("txt_refno")));
				arrValues.add(correctNull((String)hshValues.get("txt_date")));
				arrValues.add(strAppno);
				hshQuery.put("strQueryId","upd_adcrecommendation");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
			else if(strAction.equals("delete"))
			{
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize++;
				
				arrValues.add(strAppno);
				arrValues.add(correctNull((String)hshValues.get("sel_level")));
				
				hshQuery.put("strQueryId","del_adcrecommendation");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
			hshQueryValues.put("size",""+intUpdatesize);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}catch(Exception ex)
		{
			throw new EJBException("Error in updateRecommendations of adhocBean :: "+ex.toString());
		}
	}
	
	public HashMap getRecommendations(HashMap hshValues) 
	{
		HashMap hshRecord;
		ResultSet rs=null;
		String strAppno="";
		String strQuery="";
		String strLevel="";
		
		try
		{
			hshRecord=new HashMap();
			strAppno=correctNull((String)hshValues.get("appno"));
			strLevel=correctNull((String)hshValues.get("sel_level"));
			
				strQuery=SQLParser.getSqlQuery("sel_adcrecommendation^"+strAppno+"^"+"'"+strLevel+"'");
				
				rs=DBUtils.executeQuery(strQuery);
			
				if(rs.next())
				{
					hshRecord.put("recommappno",correctNull(rs.getString("adcrecom_appno")));
					hshRecord.put("recommcomments",Helper.CLOBToString(rs.getClob("adcrecom_comments")));
					hshRecord.put("recommsignatures",Helper.CLOBToString(rs.getClob("adcrecom_signatures")));
					hshRecord.put("recommrefno",Helper.correctNull(rs.getString("adcrecom_refno")));
					hshRecord.put("recommdate",Helper.correctNull(rs.getString("adcrecom_date")));
					
				}
				hshRecord.put("remarksorglevel",strLevel);
		}catch(Exception ex)
		{
			throw new EJBException("Error in getRecommendations of adhocBean :: "+ex.toString());
		}
		finally
		{
			try{
				if(rs!=null)
				{
					rs.close();
				}
			}
			catch(Exception ex)
			{
				throw new EJBException("Error in Closing the connection in getRecommendations of adhocBean"+ ex.toString());
			}
		}
		return hshRecord;
	}
	
	public void updatetermscond(HashMap hshValues) 
	{
		try
		{
			
		}catch(Exception ex)
		{
			throw new EJBException("Error in updatetermscond of adhocBean :: "+ex.toString());
		}
	}
	
	public HashMap gettermscond(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		try
		{
			
		}catch(Exception ex)
		{
			throw new EJBException("Error in gettermscond of adhocBean :: "+ex.toString());
		}
		finally
		{
			try{
				if(rs!=null)
				{
					rs.close();
				}
			}
			catch(Exception ex)
			{
				throw new EJBException("Error in Closing the connection in gettermscond of adhocBean"+ ex.toString());
			}
		}
		return hshRecord;
	}
	
	public void updateComments(HashMap hshValues) 
	{
		try
		{
			HashMap hshQueryValues = new HashMap();
			HashMap hshQuery = new HashMap();
			ArrayList arrValues = new ArrayList();
			
			String strAppno="";
			String strAction="";
			
			int intUpdatesize=0;
			
				strAction=correctNull((String)hshValues.get("hidAction"));
				strAppno=correctNull((String)hshValues.get("appno"));
				
				if(strAction.equals("insert"))
				{
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					intUpdatesize++;
					arrValues.add(strAppno);
					hshQuery.put("strQueryId","del_adccomment");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					intUpdatesize++;
					
					arrValues.add(strAppno);
					arrValues.add(correctNull((String)hshValues.get("selsancauth")));
					arrValues.add(correctNull((String)hshValues.get("txt_valueacc")));
					arrValues.add(correctNull((String)hshValues.get("txt_request")));
					arrValues.add(correctNull((String)hshValues.get("txt_authority")));
					
					hshQuery.put("strQueryId","ins_adccomment");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
				}
				else if(strAction.equals("delete"))
				{
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					intUpdatesize++;
					arrValues.add(strAppno);
					hshQuery.put("strQueryId","del_adccomment");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
				}
				
				hshQueryValues.put("size",""+intUpdatesize);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}catch(Exception ex)
		{
			throw new EJBException("Error in updateComments of adhocBean :: "+ex.toString());
		}
	}
	
	public HashMap getComments(HashMap hshValues) 
	{
		HashMap hshRecord=null;
		ResultSet rs=null;
		String strAppno="";
		String strQuery="";
		/*ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();*/
		try
		{
			hshRecord=new HashMap();
			strAppno=correctNull((String)hshValues.get("appno"));
			strQuery=SQLParser.getSqlQuery("sel_adccomment^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				//arrCol=new ArrayList();
				hshRecord.put("adccom_sanctauth",(correctNull(rs.getString("adccom_sanctauth"))));//0
				//arrCol.add(correctNull(rs.getString("adccom_srlno")));//1
				hshRecord.put("adccom_valueaccount",(correctNull(Helper.CLOBToString(rs.getClob("adccom_valueaccount")))));//2
				hshRecord.put("adccom_presentreq",(correctNull(rs.getString("adccom_presentreq"))));//3
				hshRecord.put("adccom_delegatedauth",(correctNull(rs.getString("adccom_delegatedauth"))));//4
				//arrRow.add(arrCol);
			}
			//hshRecord.put("arrRow",arrRow);
			
		}catch(Exception ex)
		{
			throw new EJBException("Error in getComments of adhocBean :: "+ex.toString());
		}
		finally
		{
			try{
				if(rs!=null)
				{
					rs.close();
				}
			}
			catch(Exception ex)
			{
				throw new EJBException("Error in Closing the connection in getComments of adhocBean"+ ex.toString());
			}
		}
		return hshRecord;
	}
	
	public void updateLimitSought(HashMap hshValues) 
	{
		try
		{
			HashMap hshQueryValues = new HashMap();
			HashMap hshQuery = new HashMap();
			ArrayList arrValues = new ArrayList();
			String strAppno="";
			String strAction="";
			int intUpdatesize=0;
			
				strAction=correctNull((String)hshValues.get("hidAction"));
				strAppno=correctNull((String)hshValues.get("appno"));
				
				if(strAction.equals("Update"))
				{
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					intUpdatesize++;
					arrValues.add(strAppno);
					hshQuery.put("strQueryId","del_adclimitcomment");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					if(!correctNull((String)hshValues.get("txtarea_limitcomment")).equals(""))
					{
						arrValues=new ArrayList();
						hshQuery=new HashMap();
						intUpdatesize++;
						arrValues.add(strAppno);
						arrValues.add(correctNull((String)hshValues.get("txtarea_limitcomment")));
						hshQuery.put("strQueryId","ins_adclimitcomment");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdatesize,hshQuery);
					}
				}
				else if(strAction.equals("Delete"))
				{
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					intUpdatesize++;
					arrValues.add(strAppno);
					hshQuery.put("strQueryId","del_adclimitcomment");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
				}
				
				hshQueryValues.put("size",""+intUpdatesize);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}catch(Exception ex)
		{
			throw new EJBException("Error in updateLimitSought of adhocBean :: "+ex.toString());
		}
	}
	
	public HashMap getLimitSought(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		try
		{
			String strAppno="";
			String strQuery="";
			hshRecord=new HashMap();
			strAppno=correctNull((String)hshValues.get("appno"));
				
			strQuery=SQLParser.getSqlQuery("sel_adclimitcomment^"+strAppno);
				
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				
				hshRecord.put("limit_comment",correctNull(Helper.CLOBToString(rs.getClob("limitcomments"))));
				
			}
			
		}catch(Exception ex)
		{
			throw new EJBException("Error in getLimitSought of adhocBean :: "+ex.toString());
		}
		finally
		{
			try{
				if(rs!=null)
				{
					rs.close();
				}
			}
			catch(Exception ex)
			{
				throw new EJBException("Error in Closing the connection in getLimitSought of adhocBean"+ ex.toString());
			}
		}
		return hshRecord;
	}
	
	public HashMap getPrintAdhocProposal(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		try
		{
			
		}catch(Exception ex)
		{
			throw new EJBException("Error in getPrintAdhocProposal of adhocBean :: "+ex.toString());
		}
		finally
		{
			try{
				if(rs!=null)
				{
					rs.close();
				}
			}
			catch(Exception ex)
			{
				throw new EJBException("Error in Closing the connection in getPrintAdhocProposal of adhocBean"+ ex.toString());
			}
		}
		return hshRecord;
	}
	
	
	private String getMaxADCfacilityId(String appno)
	{
		String strSno="";
		ResultSet rs=null;
		try
		{
				rs=DBUtils.executeLAPSQuery("sel_adcfacilityMaxid^"+appno);
				if(rs.next())
				{
					strSno = correctNull(rs.getString("facilityid"));
				}
		}
		catch(Exception Ex)
		{
			throw new EJBException(Ex.getMessage());
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
		return strSno;
	}
	
	private String getADCAppno(String strSolid)
	{
		String strappno="";
		int appno=0;
		String strQuery="";
		java.text.NumberFormat nf=java.text.NumberFormat.getNumberInstance();
		nf.setMinimumIntegerDigits(7);
		nf.setGroupingUsed(false);
		
		ResultSet rs=null;
		try
		{
				strQuery=SQLParser.getSqlQuery("sel_adcmaxappno^"+strSolid);

				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					appno = (rs.getInt("appno"));
				}
				appno++;
				strappno=strSolid+3+nf.format(appno);
		}
		catch(Exception Ex)
		{
			throw new EJBException(Ex.getMessage());
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
		return strappno;
	}
	
	private String getMaxsecno(String strAppno) 
	{
		String strSecno="";
		ResultSet rs=null;
		String strQuery="";
		try
		{
			strQuery=SQLParser.getSqlQuery("selmax_adcsecdetails^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strSecno=rs.getString("snomax");
			}
			
		}catch(Exception ex)
		{
			throw new EJBException("Error in getMaxsecno :: "+ex.toString());
		}
		finally
		{
			try{
				if(rs!=null)
					rs.close();
			}catch(Exception ex)
			{
				throw new EJBException("Error in Closing Connection"+ex.toString());
			}
		}
		return strSecno;
	}
	
	public HashMap getADCHistory(HashMap hshValues)
	{
		String strAppno="";
		ResultSet rs=null;
		ResultSet rs1=null;
		HashMap hshRecord=new HashMap();
		ArrayList arrFromflow=new ArrayList();
		ArrayList arrToflow=new ArrayList();
		ArrayList arrFromUsr=new ArrayList();
		ArrayList arrToUsr=new ArrayList();
		ArrayList arrDate=new ArrayList();
		ArrayList arrMailType=new ArrayList();
		
		try
		{
			
			strAppno=correctNull((String)hshValues.get("appno"));
			if(rs!=null)
			rs.close();	
			
			rs=DBUtils.executeLAPSQuery("adc_workflowhistory^"+strAppno);
			while(rs.next())
			{
				arrFromUsr.add(correctNull(rs.getString("fromuser")));
				arrToUsr.add(correctNull(rs.getString("touser")));
				arrFromflow.add(correctNull(rs.getString("adcmail_fromflowpoint")));
				arrToflow.add(correctNull(rs.getString("adcmail_toflowpoint")));
				arrDate.add(correctNull(rs.getString("maildate")));
			}
			hshRecord.put("arrFromUsr",arrFromUsr);
			hshRecord.put("arrToUsr",arrToUsr);
			hshRecord.put("arrFromflow",arrFromflow);
			hshRecord.put("arrToflow",arrToflow);
			hshRecord.put("arrDate",arrDate);
			hshRecord.put("arrMailType",arrMailType);
			
			return hshRecord;
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
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
			catch(Exception e1)
			{
				throw new EJBException("Error closing connection.."+e1);
			}
		}
	}
	
	public HashMap getADCAction(HashMap hshValues) 
	{
		
		String strAppno="";
		String strQuery="";
		String strAppStatus="";
		String strAction="";
		
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		
		
		HashMap hshRecord=new HashMap();
		ArrayList arrFlowpoint=new ArrayList();
		ArrayList arrDone=new ArrayList();
		ArrayList arrClassDesc=new ArrayList();
		ArrayList arrMaxclass=new ArrayList();
		ArrayList arrAction=new ArrayList();
		try
		{
			strAppno=correctNull((String)hshValues.get("appno"));
			strAction=correctNull((String)hshValues.get("hidAction"));
			
			if(rs!=null)
			rs.close();	
			
			strQuery=SQLParser.getSqlQuery("sel_adcapplication^"+strAppno);
     		rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strAppStatus=correctNull((String)rs.getString("adc_staus"));
				hshRecord.put("ApproveRejectedby",correctNull(rs.getString("adc_processusrid")));
				hshRecord.put("Sanction_Comments",correctNull(rs.getString("adc_sanccomments")));
				hshRecord.put("appstatus",strAppStatus);
			}
			
			if(rs!=null)
				rs.close();	
			
			strQuery=SQLParser.getSqlQuery("sel_adcworkflowsel^"+strAppno+"^<^9^>^0");
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				strQuery=SQLParser.getSqlQuery("adc_workflowcnt^"+strAppno+"^"+rs.getString(1));
				if(rs1!=null)
				rs1.close();
				
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					arrDone.add(rs1.getString(1));
				}
				arrFlowpoint.add((correctNull((String)rs.getString(1))));
				arrAction.add((correctNull((String)rs.getString(2))));
				arrMaxclass.add((correctNull((String)rs.getString(3))));
				arrClassDesc.add((correctNull((String)rs.getString(5))));
			}
			
			if(strAppStatus.equalsIgnoreCase("op"))
			{
				arrDone.add("0");
			}
			else
			{
				arrDone.add("1");
			}
			
			if(!strAppStatus.equalsIgnoreCase("op"))
			{
				if((strAppStatus.equalsIgnoreCase("pa")) || (strAppStatus.equalsIgnoreCase("ca"))) 
				{
					strQuery=SQLParser.getSqlQuery("sel_adcworkflowsel^"+strAppno+"^<^17^>^8");
				}
				else if(strAppStatus.equalsIgnoreCase("pr") || strAppStatus.equalsIgnoreCase("cr"))
				{
					strQuery=SQLParser.getSqlQuery("sel_adcworkflowsel^"+strAppno+"^<^25^>^16");
				}
				if(rs!=null)
				rs.close();	
				
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					strQuery=SQLParser.getSqlQuery("adc_workflowcnt^"+strAppno+"^"+rs.getString(1));
					if(rs1!=null)
					rs1.close();
					
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						arrDone.add((correctNull((String)rs1.getString(1))));
					}
					arrFlowpoint.add((correctNull((String)rs.getString(1))));
					arrAction.add((correctNull((String)rs.getString(2))));
					arrMaxclass.add((correctNull((String)rs.getString(3))));
					arrClassDesc.add((correctNull((String)rs.getString(5))));
				}
			}

			strQuery=SQLParser.getSqlQuery("sel_adcworkflow^"+strAppno+"^"+strAppno);
			if(rs!=null)
			rs.close();	
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("strCurrFlowPoint",(correctNull((String)rs.getString("adcmail_toflowpoint"))));
				hshRecord.put("strDate",(correctNull((String)rs.getString("adcmail_date"))));
				hshRecord.put("strDueDate",(correctNull((String)rs.getString("duedate"))));
			}
			else
			{
					strQuery=SQLParser.getSqlQuery("sel_adcappworkflow^"+strAppno);
					if(rs!=null)
					rs.close();	
					
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshRecord.put("strCurrFlowPoint","1");
						hshRecord.put("strDate",(correctNull((String)rs.getString("createdate"))));
						hshRecord.put("strDueDate",(correctNull((String)rs.getString("duedate"))));
					}
			}
			
			strQuery=SQLParser.getSqlQuery("sel_adcworkflowpoint^"+strAppno);
			if(rs!=null)
			rs.close();	
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("prd_skip",(correctNull((String)rs.getString("prd_skip"))));
				hshRecord.put("prd_approval",(correctNull((String)rs.getString("prd_approval"))));
			}
			
			hshRecord.put("arrFlowpoint",arrFlowpoint);
			hshRecord.put("arrAction",arrAction);
			hshRecord.put("arrMaxclass",arrMaxclass);
			hshRecord.put("arrClassDesc",arrClassDesc);
			hshRecord.put("arrDone",arrDone);
			
			if(strAction.trim().equalsIgnoreCase("send"))
			{
				hshRecord.put("status","success");
				
			}
			return hshRecord;
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
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
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}
	}
	
	
	public HashMap updateADCAction(HashMap hshValues)
	{
		String strAppno="";
		String strAction="";
		String strFromflowpoint="";
		String strToflowpoint="";
		String strFromuserid="";
		String strTouserid="";
		String strQuery="";
		
		HashMap hshResult=new HashMap();
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		
		ResultSet rs=null;
		try
		{
			strAction=correctNull((String)hshValues.get("hidAction"));
			strAppno=correctNull((String)hshValues.get("appno"));
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=(String)hshValues.get("appno");
			}
			strFromflowpoint=correctNull((String)hshValues.get("mail_fromflowpoint"));
			strToflowpoint=correctNull((String)hshValues.get("mail_toflowpoint"));
			strFromuserid=correctNull((String)hshValues.get("strUserId"));
			strTouserid=correctNull((String)hshValues.get("hidmail_tousrid"));
			
			if(strAction.equalsIgnoreCase("send"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","adc_insmailbox");//insert into adcmail table 
				arrValues.add(strAppno);
				arrValues.add(strFromuserid);
				arrValues.add(strTouserid);
				arrValues.add(strFromflowpoint);
				arrValues.add(strToflowpoint);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","upd_adcappholder");//update adc application table
				arrValues.add(strTouserid);
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","2");
				hshQueryValues.put("2",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			if(strAction.equalsIgnoreCase("approve")||strAction.equalsIgnoreCase("reject"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","upd_adcappstatus");//update application table - status
				
				if(strAction.equalsIgnoreCase("approve"))
				arrValues.add("pa");
				else
				arrValues.add("pr");
				arrValues.add(correctNull((String)hshValues.get("strUserId")));
				arrValues.add(Helper.getCurrentDateTime());
				arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
				arrValues.add(correctNull((String)hshValues.get("txt_sanctioncomments")));
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","adc_insmailbox");//insert into adcmail table 
				arrValues.add(strAppno);
				arrValues.add(strFromuserid);
				arrValues.add(strFromuserid);
				arrValues.add(strFromflowpoint);
				
				if(strAction.equalsIgnoreCase("approve"))
				{
					arrValues.add("9");
				}
				else
				{
					arrValues.add("17");
				}
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				
				hshQueryValues.put("size","2");
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			if(strAction.equalsIgnoreCase("undo"))
			{
				strQuery=SQLParser.getSqlQuery("getmaxadcflowpoint^"+strAppno);
	     		rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strToflowpoint=correctNull((String)rs.getString("maxflowpoint"));
				}
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","upd_adcappstatus");//update application table - status
				arrValues.add("op");
				arrValues.add(correctNull((String)hshValues.get("strUserId")));
				arrValues.add(Helper.getCurrentDateTime());
				arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
				arrValues.add(null);
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","adc_insmailbox");//insert into adcmail table 
				arrValues.add(strAppno);
				arrValues.add(strFromuserid);
				arrValues.add(strFromuserid);
				arrValues.add(strFromflowpoint);
				arrValues.add(strToflowpoint);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				
				hshQueryValues.put("size","2");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			if(strAction.equalsIgnoreCase("freeze"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","upd_adcworkflowcloseappln");
				
				arrValues.add(strAppno);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch(Exception e)
		{
			throw new EJBException(e.toString());
		}
		return hshResult;
	}
	
	public void updateADCMailcomments(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAppno="";
		String strMailComments="";
		String strUserId="";
		String strtoUser="";
		
		try
		{	
				strAppno = correctNull((String )hshValues.get("appno"));
				strMailComments = correctNull((String )hshValues.get("comments"));
				strUserId = correctNull((String )hshValues.get("hiduserid"));
				strtoUser = correctNull((String )hshValues.get("hidtoUser"));
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ins_adcmailcomments");
				arrValues.add(strAppno);
				arrValues.add(strMailComments);
				arrValues.add(strUserId);
				arrValues.add(strtoUser);
				arrValues.add(correctNull((String )hshValues.get("txt_pano")));
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
		}
		catch(Exception ce)
		{
			throw new EJBException("inside updateADCMailcomments"+ce.toString());
		}
	}
	
	
	public HashMap getADCMailcomments(HashMap hshValues) 
	{	
		ResultSet rs = null;
		HashMap hshRecord = null;
		HashMap hshRow=null;

		String strAppno = "";

		int no=1;

		try
		{

			strAppno = correctNull((String)hshValues.get("appno"));

			hshRecord = new HashMap();
			
			rs=DBUtils.executeLAPSQuery("sel_adcmailcomments^"+strAppno);
			while(rs.next())
			{		hshRow=new HashMap();
					hshRow.put("mail_appno",correctNull(rs.getString(1)));
					hshRow.put("mail_comments",correctNull(Helper.CLOBToString(rs.getClob("adcmcom_comments"))));
					hshRow.put("mail_userid",correctNull(rs.getString(3)));
					hshRow.put("mail_date",correctNull(rs.getString(4)));
					hshRow.put("mail_touser",correctNull(rs.getString(5)));
					hshRow.put("mail_usrname",correctNull(rs.getString(7)));
					hshRow.put("mail_usrdesign",correctNull(rs.getString(6)));
					hshRow.put("mail_pano",correctNull(rs.getString(8)));

					hshRecord.put(Integer.toString(no),hshRow);
					no++;				
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getADCMailcomments login  "+ce.toString());
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
	public HashMap getADCApprovalprint(HashMap hshValues) 
	{	
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = null;
		String strAppno = "";
		String strQuery	= "";
		String strComappid = "";
		String strOwnership ="";
		String strTemp="";
		String strCitycode="";
		String Strproposalvaluesin="L";
		
		
		try
		{
			hshRecord = new HashMap();
			hshRecord.put("strOrgName",correctNull((String)hshValues.get("strOrgName")));
			strAppno = correctNull((String)hshValues.get("appno"));
			
			
			strQuery = SQLParser.getSqlQuery("comfunsel3^" + strAppno);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				strComappid = correctNull(rs.getString("demo_appid"));
				Strproposalvaluesin=correctNull(rs.getString("app_valuesin"));
 				hshRecord.put("proposalvaluesin",Strproposalvaluesin);
				
			}
			
/***************************************************************************************************************************
 * 
 *									 Signatures,Resolution,DELEGATED AUTHORITY
 * 
 * 
 ***************************************************************************************************************************/
			
			//Ad hoc Comment Details
			strQuery=SQLParser.getSqlQuery("sel_adccomment^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("valueaccount",correctNull(Helper.CLOBToString(rs.getClob("adccom_valueaccount"))));
			}
			if (rs != null)
			{
				rs.close();
			}

			
			strQuery = SQLParser.getSqlQuery("sel_exec_signatures^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			StringBuffer sbfsignatories=null;
			StringBuffer sbfgridcomments=null;
			if(rs.next())
			{
				sbfsignatories = new StringBuffer(correctNull(rs.getString("exec_signatures")));
				sbfgridcomments= new StringBuffer(correctNull(rs.getString("exec_gridcomments")));
				hshRecord.put("exec_mcmresolution",correctNull(rs.getString("exec_mcmresolution")));
				hshRecord.put("exec_delegated",correctNull(rs.getString("exec_delegated")));
			}
			if(sbfsignatories!=null)
			{
				for (int i = 0;i < sbfsignatories.length(); i++) {
					if (sbfsignatories.charAt(i) == '\n') {
						sbfsignatories.replace(i, i + 1, "<br>");
					}
					if (sbfsignatories.charAt(i) == ' ') {
						sbfsignatories.replace(i, i + 1, "&nbsp;");
					}
				}
				hshRecord.put("exec_signatures",sbfsignatories.toString());
			}
			if(sbfgridcomments!=null)
			{
				for (int i = 0,j=0;i < sbfgridcomments.length(); i++) 
				{
					if (sbfgridcomments.charAt(i) == '\n') {
						sbfgridcomments.replace(i, i + 1, "<br>");
						j++;
					}
					if (j>1 && sbfgridcomments.charAt(i) == ' ') {
						sbfgridcomments.replace(i, i + 1, "&nbsp;");
					}
				}
				hshRecord.put("exec_gridcomments",sbfgridcomments.toString());
			}
			
/***************************************************************************************************************************
 * 
 * 										Reference No,Date,PRESENT REQUEST,SANCTION AUTHORITY
 * 
 * 
 ***************************************************************************************************************************/			
			
			strQuery = SQLParser.getSqlQuery("execsel_port^" + strAppno);
			
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				//hshRecord.put("cmd_searchreport", correctNull(rs.getString("cmd_searchreport")));
				//hshRecord.put("audit_notes", correctNull(Helper.CLOBToString(rs.getClob("audit_notes"))));
				hshRecord.put("exec_date", correctNull(rs.getString("exec_date")));
				hshRecord.put("sel_guaranteoffered", correctNull(rs.getString("exec_offercorpguarantee")));
				hshRecord.put("sel_applicantguarantee", correctNull(rs.getString("exec_whetherapplco")));
				hshRecord.put("exec_comments", correctNull(rs.getString("exec_comments_sisterconcern")).equals("")?"Nil":correctNull(rs.getString("exec_comments_sisterconcern")));
				//hshRecord.put("exec_borrowertype",strBorrowerType);
				hshRecord.put("exec_sancauth", correctNull(rs.getString("exec_sancauth")));
				hshRecord.put("exec_refno", correctNull(rs.getString("exec_refno")));
				hshRecord.put("exec_mcm", correctNull(rs.getString("exec_mcm")));
				hshRecord.put("exec_agendano", correctNull(rs.getString("exec_agendano")));
				hshRecord.put("exec_presentreq", correctNull(rs.getString("exec_presentreq")));
			}
			
			strQuery = SQLParser.getSqlQuery("applicant_create_code^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("appCreationBranch",correctNull((String)rs.getString("org_name")));
			}
			
			if (rs != null) 
			{
				rs.close();
			}
			
/***************************************************************************************************************************
 * 
 * 														COMPANY DETAILS
 * 
 * 
 ***************************************************************************************************************************/			
			
			//Customer Details
			strQuery = SQLParser.getSqlQuery("comappmastersel^"+strComappid);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshRecord.put("comapp_companyname", correctNull(rs.getString("comapp_companyname")));
				hshRecord.put("comapp_companyid", correctNull(rs.getString("comapp_companyid")));
				hshRecord.put("comapp_yrsinbusiness", correctNull(rs.getString("comapp_yrsinbusiness")));
				hshRecord.put("comapp_businessnature", correctNull(rs.getString("comapp_businessnature")).equalsIgnoreCase("")?"Nil":correctNull(rs.getString("comapp_businessnature")));
				hshRecord.put("comapp_regadd1", correctNull(rs.getString("comapp_regadd1")));
				hshRecord.put("comapp_regadd2", correctNull(rs.getString("comapp_regadd2")));
				//hshRecord.put("comapp_regcity", correctNull(rs.getString("comapp_regcity")));
				//hshRecord.put("comapp_regstate", correctNull(rs.getString("comapp_regstate")));
				hshRecord.put("comapp_regphone", correctNull(rs.getString("comapp_regphone")));
				hshRecord.put("comapp_regfax", correctNull(rs.getString("comapp_regfax")));
				hshRecord.put("comapp_regpin", correctNull(rs.getString("comapp_regpin")));
				hshRecord.put("groupdesc", correctNull(rs.getString("groupdesc")));
				hshRecord.put("comapp_ownership", correctNull(rs.getString("comapp_ownership")));
				strOwnership=correctNull(rs.getString("comapp_ownership"));
				strCitycode=correctNull(rs.getString("comapp_regcity"));
			}
			if (rs != null) 
			{
				rs.close();
			}
			
			/*-added by abdul jaleel for adding  city and state in address */
			
			strQuery = SQLParser.getSqlQuery("selcitycode^"+strCitycode.trim());
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshRecord.put("Regcity_name", correctNull((String)rs.getString("city_name")));
			
				strQuery = SQLParser.getSqlQuery("selstatecode^"+correctNull((String)rs.getString("state_id")));
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					hshRecord.put("Regstate_name", correctNull((String)rs1.getString("state_name")));	
				}
			}
			
			if (rs1 != null) 
			{
				rs.close();
			}
			
			
			
			
/***************************************************************************************************************************
 * 
 * 
 * 										CONSTITUTION
 * 
 * 
 ***************************************************************************************************************************/
			
			if(strOwnership.equalsIgnoreCase("IN"))//Individual
			{
				
				hshRecord.put("strownership","Individual");
			}
			else if(strOwnership.equalsIgnoreCase("OLP"))//PVT LTD COMPANY
			{
				
				hshRecord.put("strownership","Private Limited Company");
			}
			else if(strOwnership.equalsIgnoreCase("OCC"))//PUBLIC LTD COMPANY
			{
				
				hshRecord.put("strownership","Public Limited Company");
			}
			else if(strOwnership.equalsIgnoreCase("OP"))//PARTNER SHIP
			{
				
				hshRecord.put("strownership","Partnership");
			}
			else if(strOwnership.equalsIgnoreCase("OLC"))//Joint Borrowers
			{
				
				hshRecord.put("strownership","Joint Borrowers");
			}
			else if(strOwnership.equalsIgnoreCase("OS"))//Sole Proprietor
			{
				
				hshRecord.put("strownership","Sole Proprietor");
			}
			else if(strOwnership.equalsIgnoreCase("Jo"))//Joint Venture
			{
				
				hshRecord.put("strownership","Joint Venture");
			}
			else if(strOwnership.equalsIgnoreCase("sub"))//Wholly owned subsidiary
			{
				
				hshRecord.put("strownership","Wholly owned subsidiary");
			}
			else if(strOwnership.equalsIgnoreCase("TR"))//Trusts
			{
				
				hshRecord.put("strownership","Trusts");
			}
			else if(strOwnership.equalsIgnoreCase("AC"))//Association
			{
				
				hshRecord.put("strownership","Association");
			}
			else if(strOwnership.equalsIgnoreCase("nbfc"))//NBFC
			{
				
				hshRecord.put("strownership","NBFC");
			}
			else if(strOwnership.equalsIgnoreCase("HUF"))//HUF
			{
				
				hshRecord.put("strownership","H.U.F");
			}
			else if(strOwnership.equalsIgnoreCase("OO"))//Others
			{
				
				hshRecord.put("strownership","Others");
			}
/***************************************************************************************************************************
 * 
 * BANKING ARRANGEMENT,MONTH OF REVIEW,ASSET CLASSIFICATION,INTERNAL CREDIT RATING,LEAD BANK
 * OUR SHARE,EXTERNAL CREDIT RATING,STATUS OF ACCOUNT
 * 
 * 
 ***************************************************************************************************************************/
			if (rs != null) 
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("sel_adcbankdetails^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strTemp=correctNull(rs.getString("adcbank_type"));
				hshRecord.put("bankingtype",strTemp.equals("1")?"Sole":strTemp.equals("2")?"Consortium":strTemp.equals("3")?"Multiple":strTemp.equals("4")?"Sole/Consortium":strTemp.equals("5")?"Sole/Multiple":strTemp.equals("6")?"Consortium/Multiple":strTemp.equals("7")?"Sole/Consortium/Multiple":"");
				hshRecord.put("leadbank",rs.getString("adcbank_leadbank"));
				//hshRecord.put("ourbank",rs.getString("adcbank_share"));
				strTemp=correctNull(rs.getString("adcbank_asset"));
				hshRecord.put("asset",strTemp.equals("0")?"":strTemp.equals("1")?"Standard":strTemp.equals("2")?"Sub Standard":strTemp.equals("3")?"Loss":"Doubtful");
				hshRecord.put("int_rating",rs.getString("adcbank_internalrating"));
				hshRecord.put("rev_duedate",rs.getString("adcbank_reviewduedate"));
				hshRecord.put("ext_rating_short",rs.getString("adcbank_externalrating_st"));
				hshRecord.put("ext_rating_long",rs.getString("adcbank_externalrating_lt"));
				strTemp=correctNull(rs.getString("adcbank_accountstatus"));
				hshRecord.put("accstatus",strTemp.equals("0")?"":strTemp.equals("1")?"Regular":strTemp.equals("2")?"EAS I":strTemp.equals("3")?"EAS II":"SMA");
				
				hshRecord.put("WC_SHARE_FE",rs.getString("adcbank_propexistfb"));
				hshRecord.put("WC_SHARE_FP",rs.getString("adcbank_propproposedfb"));
				hshRecord.put("WC_SHARE_NFE",rs.getString("adcbank_propexistnfb"));
				hshRecord.put("WC_SHARE_NFP",rs.getString("adcbank_propproposednfb"));
			}
			
/***************************************************************************************************************************
 * 
 * FOR WC FUND , WC NON FUND AND TERM LOAN FACILITY TOTAL AMT
 * 
 ***************************************************************************************************************************/	
			
			ArrayList OurBank_WC_Funded = new ArrayList();
			ArrayList OurBank_WC_NonFunded = new ArrayList();
			ArrayList WC_NonFunded = new ArrayList();
			ArrayList OurBank_TL = new ArrayList();
			ArrayList arrSubFac = new ArrayList();
			ArrayList WC_Funded = new ArrayList();
			ArrayList arrCol = new ArrayList();
			ArrayList TL_Funded_NonFunded = new ArrayList();
			
			
			double wc_funded_existing = 0.00, wc_funded_proposed = 0.00;
			double wc_nonfunded_existing = 0.00, wc_nonfunded_proposed = 0.00;
			double tl_funded_existing = 0.00, tl_funded_proposed = 0.00;
			double tl_total_existing = 0.00, tl_total_proposed = 0.00;
			double total_existing = 0.00, total_proposed = 0.00;

			if (rs != null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("WC_FUNDED_TOTAL_adc^" + strAppno);
			if (rs.next())
			{
				wc_funded_existing = Double.parseDouble(Helper.correctDouble(correctNull((String) rs.getString("WC_FUNDED_EXISTING"))));
				wc_funded_proposed = Double.parseDouble(Helper.correctDouble(correctNull((String) rs.getString("WC_FUNDED_PROPOSED"))));
			}
			if (rs != null) 
			{
				rs.close();
			}

			rs = DBUtils.executeLAPSQuery("WC_NONFUNDED_TOTAL_adc^" + strAppno);
			if (rs.next()) 
			{
				wc_nonfunded_existing = Double.parseDouble(Helper.correctDouble(correctNull((String) rs.getString("WC_NONFUNDED_EXISTING"))));
				wc_nonfunded_proposed = Double.parseDouble(Helper.correctDouble(correctNull((String) rs.getString("WC_NONFUNDED_PROPOSED"))));
			}
			if (rs != null) 
			{
				rs.close();
			}
			
			rs = DBUtils.executeLAPSQuery("TL_FUNDED_TOTAL_adc^" + strAppno);
			if (rs.next()) 
			{
				tl_funded_existing = Double.parseDouble(Helper.correctDouble(correctNull((String) rs.getString("TL_FUNDED_EXISTING"))));
				tl_funded_proposed = Double.parseDouble(Helper.correctDouble(correctNull((String) rs.getString("TL_FUNDED_PROPOSED"))));
			}
			if (rs != null)
			{
				rs.close();
			}
			
			tl_total_existing = tl_funded_existing ;//+ tl_nonfunded_existing;
			tl_total_proposed = tl_funded_proposed ;//+ tl_nonfunded_proposed;

			total_existing = wc_funded_existing + wc_nonfunded_existing + tl_total_existing;
			total_proposed = wc_funded_proposed + wc_nonfunded_proposed	+ tl_total_proposed;

			hshRecord.put("wc_funded_existing", jtn.format(wc_funded_existing));
			hshRecord.put("wc_funded_proposed", jtn.format(wc_funded_proposed));
			
			hshRecord.put("wc_nonfunded_existing", jtn.format(wc_nonfunded_existing));
			hshRecord.put("wc_nonfunded_proposed", jtn.format(wc_nonfunded_proposed));
			
			hshRecord.put("tl_total_existing", jtn.format(tl_total_existing));
			hshRecord.put("tl_total_proposed", jtn.format(tl_total_proposed));
			
			hshRecord.put("total_existing", Helper.formatDoubleValue(total_existing));
			hshRecord.put("total_proposed", Helper.formatDoubleValue(total_proposed));

						
/***************************************************************************************************************************
 * 
 * WC NON FUNDED FACILITY DETAILS WITH SECURITY
 * 
 ***************************************************************************************************************************/
						
						OurBank_WC_Funded = new ArrayList();
						OurBank_WC_NonFunded = new ArrayList();
						OurBank_TL = new ArrayList();
						ArrayList arrSecRemarkscol=new ArrayList();
						ArrayList arrSecRemarksrow=new ArrayList();
						
						if (rs != null) 
						{
							rs.close();
						}

						strQuery = SQLParser.getSqlQuery("com_wc_nonfunded_adc^" + strAppno);
						rs = DBUtils.executeQuery(strQuery);
						while (rs.next())
						{
							WC_NonFunded = new ArrayList();
							String strFacSno = correctNull((String)rs.getString("facility_sno"));
								WC_NonFunded.add(correctNull(rs.getString("facility_catdesc"))); 		//0
								WC_NonFunded.add(correctNull(rs.getString("facility_existing"))); 		//1
								WC_NonFunded.add(correctNull(rs.getString("facility_proposed"))); 		//2
								WC_NonFunded.add(correctNull(rs.getString("facility_margin"))); 		//3
								WC_NonFunded.add(correctNull(rs.getString("facility_intremarks")));		//4
								WC_NonFunded.add(correctNull(rs.getString("facility_dp")));				//5
								WC_NonFunded.add(correctNull(rs.getString("facility_outstanding")));	//6
								WC_NonFunded.add(correctNull(rs.getString("security_value")));			//7
								WC_NonFunded.add(correctNull(rs.getString("facility_desc")));			//8

								String strfacheadid = correctNull(rs.getString("facility_headid"));
							
								arrSubFac = new ArrayList();
								arrSubFac = getSubFacilitiesData(strAppno,strFacSno,"NFD");				//9
								WC_NonFunded.add(arrSubFac);
								//end for sub-facilities
								WC_NonFunded.add(correctNull(rs.getString("bplr")));					//10
								WC_NonFunded.add(correctNull(rs.getString("facility_intadjustment")));	//11
								WC_NonFunded.add(correctNull(rs.getString("facility_category")));		//12
								WC_NonFunded.add(correctNull(rs.getString("facility_months")));			//13
								WC_NonFunded.add(strfacheadid);											//14
								
							
									strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^" + strFacSno + "^" + strAppno);
									rs1 = DBUtils.executeQuery(strQuery);
									ArrayList arrSecurities=new ArrayList();
									int j=0;
									while (rs1.next()) 
									{
										arrCol=new ArrayList();
										arrSecRemarkscol=new ArrayList();
										arrCol.add(correctNull(rs1.getString("sec_desc_details"))); 
										arrCol.add(correctNull(rs1.getString("sec_margin"))); 
										arrSecRemarkscol.add(correctNull(rs1.getString("sec_remarks")));
										arrSecRemarksrow.add(arrSecRemarkscol);
										arrSecurities.add(arrCol);
										j++;
									}
									WC_NonFunded.add(arrSecurities);
									WC_NonFunded.add(""+j);
							
							OurBank_WC_NonFunded.add(WC_NonFunded);
							hshRecord.put("detailsasondate", correctNull(rs.getString("facility_osason")));
						}

						hshRecord.put("OurBank_WC_NonFunded", OurBank_WC_NonFunded);

						
						
/***************************************************************************************************************************
 * 
 * WC FUNDED FACILITY DETAILS WITH SECURITY
 * 
 **************************************************************************************************************************/
						
						if (rs != null) 
						{
							rs.close();
						}
						
						strQuery = SQLParser.getSqlQuery("com_wc_funded_adc^" + strAppno);
						rs = DBUtils.executeQuery(strQuery);
						while (rs.next()) 
						{
							WC_Funded = new ArrayList();
							WC_Funded.add(correctNull(rs.getString("facility_catdesc")));
							WC_Funded.add(correctNull(rs.getString("facility_existing")));
							WC_Funded.add(correctNull(rs.getString("facility_proposed")));
							WC_Funded.add(correctNull(rs.getString("facility_margin")));
							WC_Funded.add(correctNull(rs.getString("facility_intremarks")));
							WC_Funded.add(correctNull(rs.getString("facility_dp")));
							WC_Funded.add(correctNull(rs.getString("facility_outstanding")));
							WC_Funded.add(correctNull(rs.getString("security_value")));
							WC_Funded.add(correctNull(rs.getString("facility_desc")));

							//
							String strFacSno = correctNull((String)rs.getString("facility_sno"));
							arrSubFac = new ArrayList();
							arrSubFac = getSubFacilitiesData(strAppno,strFacSno,"FD");
							WC_Funded.add(arrSubFac);
							WC_Funded.add(correctNull(rs.getString("bplr")));
							WC_Funded.add(correctNull(rs.getString("facility_intadjustment")));
							WC_Funded.add(correctNull(rs.getString("facility_category")));
							WC_Funded.add(correctNull(rs.getString("facility_months")));
							WC_Funded.add(correctNull(rs.getString("facility_headid")));
							

							strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^" +  strFacSno + "^" + strAppno);
							rs1 = DBUtils.executeQuery(strQuery);
							ArrayList arrSecurities=new ArrayList();
							int j=0;
							while (rs1.next()) 
							{
								arrCol=new ArrayList();
								arrSecRemarkscol=new ArrayList();
								arrCol.add(correctNull(rs1.getString("sec_desc_details"))); 
								arrCol.add(correctNull(rs1.getString("sec_margin")));
								arrSecRemarkscol.add(correctNull(rs1.getString("sec_remarks")));
								arrSecRemarksrow.add(arrSecRemarkscol);
								arrSecurities.add(arrCol);
								j++;
							}
							WC_Funded.add(arrSecurities);
							WC_Funded.add(""+j);

							OurBank_WC_Funded.add(WC_Funded);
							hshRecord.put("detailsasondate", correctNull(rs.getString("facility_osason")));
						}

						hshRecord.put("OurBank_WC_Funded", OurBank_WC_Funded);

						
/***************************************************************************************************************************
 * 
 * TL FUNDED & NON FUNDED FACILITY DETAILS WITH SECURITY
 * 
 **************************************************************************************************************************/

						if (rs != null)
						{
							rs.close();
						}

						strQuery = SQLParser.getSqlQuery("com_tl_funded_nonfunded_adc^" + strAppno);
						rs = DBUtils.executeQuery(strQuery);
						while (rs.next()) 
						{
							TL_Funded_NonFunded = new ArrayList();
							TL_Funded_NonFunded.add(correctNull(rs.getString("facility_catdesc")));
							TL_Funded_NonFunded.add(correctNull(rs.getString("facility_existing")));
							TL_Funded_NonFunded.add(correctNull(rs.getString("facility_proposed")));
							TL_Funded_NonFunded.add(correctNull(rs.getString("facility_margin")));
							TL_Funded_NonFunded.add(correctNull(rs.getString("facility_intremarks")));
							TL_Funded_NonFunded.add(correctNull(rs.getString("facility_dp")));
							TL_Funded_NonFunded.add(correctNull(rs.getString("facility_outstanding")));
							TL_Funded_NonFunded.add(correctNull(rs.getString("security_value")));
							TL_Funded_NonFunded.add(correctNull(rs.getString("facility_desc")));

							String strFacSno = correctNull((String)rs.getString("facility_sno"));
							
							arrSubFac = new ArrayList();
							arrSubFac = getSubFacilitiesData(strAppno,strFacSno,"TL");
							TL_Funded_NonFunded.add(arrSubFac);
							TL_Funded_NonFunded.add(correctNull(rs.getString("bplr")));
							TL_Funded_NonFunded.add(correctNull(rs.getString("facility_intadjustment")));
							TL_Funded_NonFunded.add(correctNull(rs.getString("facility_category")));
							TL_Funded_NonFunded.add(correctNull(rs.getString("facility_months")));
							TL_Funded_NonFunded.add(correctNull(rs.getString("facility_headid")));

							strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^" + strFacSno + "^" +  strAppno);
							rs1 = DBUtils.executeQuery(strQuery);
							ArrayList arrSecurities=new ArrayList();
							int j=0;
							while (rs1.next()) 
							{
								arrCol=new ArrayList();
								arrSecRemarkscol=new ArrayList();
								arrCol.add(correctNull(rs1.getString("sec_desc_details"))); 
								arrCol.add(correctNull(rs1.getString("sec_margin"))); 
								arrSecRemarkscol.add(correctNull(rs1.getString("sec_remarks")));
								arrSecRemarksrow.add(arrSecRemarkscol);
								arrSecurities.add(arrCol);
								j++;
							}
							TL_Funded_NonFunded.add(arrSecurities);
							TL_Funded_NonFunded.add(""+j);
							OurBank_TL.add(TL_Funded_NonFunded);
							hshRecord.put("detailsasondate", correctNull(rs.getString("facility_osason")));
						}

						hshRecord.put("OurBank_TL", OurBank_TL);
						hshRecord.put("arrSecRemarks",arrSecRemarksrow);
/********************************************************************************************************************************************
 * 
 *   								Collateral DETAILS  
 * 
 **********************************************************************************************************************************/
						
			
						if (rs != null)
							rs.close();
						strQuery=SQLParser.getSqlQuery("selsecuritybytype^" + strAppno+"^Collateral");
						rs=DBUtils.executeQuery(strQuery);
						ArrayList arrColldetails=new ArrayList();
						while (rs.next())
						{
							arrCol = new ArrayList();
							arrCol.add(rs.getString("sec_desc_details"));
							arrCol.add(rs.getString("sec_desc_value"));
							arrCol.add(rs.getString("as_on_date"));
							arrCol.add(rs.getString("sec_valuersname"));
							arrCol.add(rs.getString("sec_insuranceamt"));
							arrCol.add(rs.getString("sec_insexpirydate"));
							arrCol.add(rs.getString("sec_remarks"));
							arrColldetails.add(arrCol);

						}
						hshRecord.put("arrColldetails", arrColldetails);

						if (rs != null) 
						{
							rs.close();
						}

/********************************************************************************************************************************************
 * 
 *   								Financials  
 * 
 **********************************************************************************************************************************/					
										
										
			strQuery=SQLParser.getSqlQuery("sel_execfin^"+strAppno+"^"+"0^FI");
			ArrayList arrFin=new ArrayList();
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();			
				arrCol.add(correctNull(rs.getString("fin_year1")));
				arrCol.add(correctNull(rs.getString("fin_year2")));
				arrCol.add(correctNull(rs.getString("fin_year3")));
				arrCol.add(correctNull(rs.getString("fin_year4")));
				arrCol.add(correctNull(rs.getString("fin_rowdesc")));
				arrFin.add(arrCol);	
			}
			hshRecord.put("arrValFin",arrFin);
			
			if(rs!=null)
				rs.close();
			
			strQuery = SQLParser.getSqlQuery("executive_finnotes_sel^"+strAppno+"^"+"FI"+"^"+"0");
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{
				hshRecord.put("comments",correctNull(Helper.CLOBToString(rs.getClob("notes"))));
			}
/********************************************************************************************************************************************
 * 
 *   								GUARANTEE - Details
 * 
 **********************************************************************************************************************************/	
			/*if(rs != null)
				rs.close();	
			strQuery=SQLParser.getSqlQuery("sel_adcgaurantee^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				
				hshRecord.put("guarantee_comment",correctNull(Helper.CLOBToString(rs.getClob("guarntee_comments"))));
				
			}*/
/********************************************************************************************************************************************
 * 
 *   								LIMIT SOUGHT - Details
 * 
 **********************************************************************************************************************************/				
			
			if(rs != null)
				rs.close();	
			strQuery=SQLParser.getSqlQuery("sel_adclimitcomment^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				
				hshRecord.put("limit_comment",correctNull(Helper.CLOBToString(rs.getClob("limitcomments"))));
				
			}
/********************************************************************************************************************************************
 * 
 *   								Terms and Conditions
 * 
 **********************************************************************************************************************************/			
			
			ArrayList  arrtermcond = new ArrayList(); 
			strQuery = SQLParser.getSqlQuery("seltermsandconditionval^"+strAppno);
			
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("terms_termdesc")));
				arrtermcond.add(arrCol);
		
			}
			hshRecord.put("arrtermcond",arrtermcond);
			
			
/***********************************************************************************************************************************************
 * 
 * 				For Promotes and Guarantors
 * 
 * **********************************************************************************************************************************************/

						//Personal Promotes
						
						strQuery = SQLParser.getSqlQuery("compromoterselectionpromoters^"+ strAppno);
						ArrayList arrGuarantors=new ArrayList();
						ArrayList arrCorpguarantee=new ArrayList();
						if (rs != null)
							rs.close();
						rs = DBUtils.executeQuery(strQuery);
						while (rs.next()) 
						{
							arrCol = new ArrayList();
							arrCol.add(correctNull(rs.getString("com_compdtfname")));
							arrCol.add(correctNull(rs.getString("com_compdtlname")));
							arrCol.add(correctNull(rs.getString("com_compdtmname")));
							arrCol.add(correctNull(rs.getString("com_compdaca")));
							String company_id = correctNull((String) rs.getString("com_compdtid"));
							if (rs1 != null)
							{
								rs1.close();
							}
							strQuery = SQLParser.getSqlQuery("selcreditreport2^" + strAppno + "^" + company_id);
							rs1 = DBUtils.executeQuery(strQuery);
							if (rs1.next()) 
							{
								arrCol.add(correctNull(rs1.getString("CR_Total_MEANS")));
								arrCol.add(correctNull(rs1.getString("cr_meansason")));
							} 
							else
							{
								arrCol.add("0.00");
							}
							arrCol.add(correctNull(rs.getString("com_compdexp")));

							String strpromgua[] = correctNull(rs.getString("com_compdttype")).split("@");

							for (int  i = 0; i < strpromgua.length; i++) 
							{
								
								if (strpromgua[i].equals("G")) 
								{
									String strGuaType=correctNull(rs.getString("COM_COMPDSEX"));
									if(strGuaType.trim().equals("Male") || strGuaType.trim().equals("Female"))
										arrGuarantors.add(arrCol);
									else
										arrCorpguarantee.add(arrCol);
									
									
								} 
							}
							
							
						}
						hshRecord.put("arrGuarantors", arrGuarantors);
						hshRecord.put("arrCorpguarantee", arrCorpguarantee);

						//CORPORATE GUARANTEE
									
//						if(rs!=null)
//							rs.close();
//						ArrayList arrCorpguarantee=new ArrayList();
//						strQuery=SQLParser.getSqlQuery("exec_guadetailsel^" + strAppno);
//						rs = DBUtils.executeQuery(strQuery);
//						while (rs.next()) 
//						{
//							arrCol = new ArrayList();
//							arrCol.add(rs.getString("exec_guaname"));
//							arrCol.add(rs.getString("exec_tnw"));
//							arrCorpguarantee.add(arrCol);
//
//						}
//						hshRecord.put("arrCorpguarantee", arrCorpguarantee);
						
/***********************************************************************************************************************************************
 * 
 * 				PRESENT REQUEST:Ad hoc Limit
 * 
 * **********************************************************************************************************************************************/						
						strQuery = SQLParser.getSqlQuery("selonlyADHOC^"+strAppno);
						ArrayList presentrequest=new ArrayList();
						if (rs != null)
							rs.close();
						rs = DBUtils.executeQuery(strQuery);
						while (rs.next()) 
						{
							arrCol = new ArrayList();
							arrCol.add(correctNull(rs.getString("facility_catdesc")));
							arrCol.add(correctNull(rs.getString("facility_proposed")));
							arrCol.add(correctNull(rs.getString("facility_months")));
							arrCol.add(correctNull(rs.getString("facility_intremarks")));
							presentrequest.add(arrCol);
						}
						hshRecord.put("presentrequest",presentrequest);
						if (rs != null)
							rs.close();
/***********************************************************************************************************************************************
 * 
 * 				12.  RECOMMENDATIONS 
 * 	
 * **********************************************************************************************************************************************/ 
						ArrayList OurBank_WC_Funded_sec = new ArrayList();
						ArrayList OurBank_WC_NonFunded_sec = new ArrayList();
						ArrayList WC_NonFunded_sec = new ArrayList();
						ArrayList OurBank_TL_sec = new ArrayList();
						ArrayList WC_Funded_sec = new ArrayList();
						ArrayList TL_Funded_NonFunded_sec = new ArrayList();
						ArrayList arrSecRemarkscol_sec=new ArrayList();
						ArrayList arrSecRemarksrow_sec=new ArrayList();
						
						if (rs != null) 
						{
							rs.close();
						}

						strQuery = SQLParser.getSqlQuery("com_wc_nonfunded^" + strAppno);
						rs = DBUtils.executeQuery(strQuery);
						while (rs.next())
						{
							WC_NonFunded_sec = new ArrayList();
							String strFacSno = correctNull((String)rs.getString("facility_sno"));
								WC_NonFunded_sec.add(correctNull(rs.getString("facility_catdesc"))); 		//0
								WC_NonFunded_sec.add(correctNull(rs.getString("facility_existing"))); 		//1
								WC_NonFunded_sec.add(correctNull(rs.getString("facility_proposed"))); 		//2
								WC_NonFunded_sec.add(correctNull(rs.getString("facility_margin"))); 		//3
								WC_NonFunded_sec.add(correctNull(rs.getString("facility_intremarks")));		//4
								WC_NonFunded_sec.add(correctNull(rs.getString("facility_dp")));				//5
								WC_NonFunded_sec.add(correctNull(rs.getString("facility_outstanding")));	//6
								WC_NonFunded_sec.add(correctNull(rs.getString("security_value")));			//7
								WC_NonFunded_sec.add(correctNull(rs.getString("facility_desc")));			//8

								String strfacheadid = correctNull(rs.getString("facility_headid"));
							
								arrSubFac = new ArrayList();
								arrSubFac = getSubFacilitiesData(strAppno,strFacSno,"adc_NFD");				//9
								WC_NonFunded_sec.add(arrSubFac);
								//end for sub-facilities
								WC_NonFunded_sec.add(correctNull(rs.getString("bplr")));					//10
								WC_NonFunded_sec.add(correctNull(rs.getString("facility_intadjustment")));	//11
								WC_NonFunded_sec.add(correctNull(rs.getString("facility_category")));		//12
								WC_NonFunded_sec.add(correctNull(rs.getString("facility_months")));			//13
								WC_NonFunded_sec.add(strfacheadid);											//14
								
							
									strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^" + strFacSno + "^" + strAppno);
									rs1 = DBUtils.executeQuery(strQuery);
									ArrayList arrSecurities=new ArrayList();
									
									int j=0;
									while (rs1.next()) 
									{
										arrCol=new ArrayList();
										arrSecRemarkscol_sec=new ArrayList();
										arrCol.add(correctNull(rs1.getString("sec_desc_details"))); 
										arrCol.add(correctNull(rs1.getString("sec_margin"))); 
										arrSecRemarkscol_sec.add(correctNull(rs1.getString("sec_remarks")));
										arrSecRemarksrow_sec.add(arrSecRemarkscol_sec);
										arrSecurities.add(arrCol);
										j++;
									}
									WC_NonFunded_sec.add(arrSecurities);
									WC_NonFunded_sec.add(""+j);
									WC_NonFunded_sec.add(arrSecRemarksrow_sec);
							OurBank_WC_NonFunded_sec.add(WC_NonFunded_sec);
							hshRecord.put("detailsasondate_sec", correctNull(rs.getString("facility_osason")));
						}

						hshRecord.put("OurBank_WC_NonFunded_sec", OurBank_WC_NonFunded_sec);

						
						
/***************************************************************************************************************************
 * 
 * WC FUNDED FACILITY DETAILS WITH SECURITY
 * 
 **************************************************************************************************************************/
						
						if (rs != null) 
						{
							rs.close();
						}
						
						strQuery = SQLParser.getSqlQuery("com_wc_funded^" + strAppno);
						rs = DBUtils.executeQuery(strQuery);
						while (rs.next()) 
						{
							WC_Funded_sec = new ArrayList();
							WC_Funded_sec.add(correctNull(rs.getString("facility_catdesc")));
							WC_Funded_sec.add(correctNull(rs.getString("facility_existing")));
							WC_Funded_sec.add(correctNull(rs.getString("facility_proposed")));
							WC_Funded_sec.add(correctNull(rs.getString("facility_margin")));
							WC_Funded_sec.add(correctNull(rs.getString("facility_intremarks")));
							WC_Funded_sec.add(correctNull(rs.getString("facility_dp")));
							WC_Funded_sec.add(correctNull(rs.getString("facility_outstanding")));
							WC_Funded_sec.add(correctNull(rs.getString("security_value")));
							WC_Funded_sec.add(correctNull(rs.getString("facility_desc")));

							//
							String strFacSno = correctNull((String)rs.getString("facility_sno"));
							arrSubFac = new ArrayList();
							arrSubFac = getSubFacilitiesData(strAppno,strFacSno,"adc_FD");
							WC_Funded_sec.add(arrSubFac);
							WC_Funded_sec.add(correctNull(rs.getString("bplr")));
							WC_Funded_sec.add(correctNull(rs.getString("facility_intadjustment")));
							WC_Funded_sec.add(correctNull(rs.getString("facility_category")));
							WC_Funded_sec.add(correctNull(rs.getString("facility_months")));
							WC_Funded_sec.add(correctNull(rs.getString("facility_headid")));
							

							strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^" +  strFacSno + "^" + strAppno);
							rs1 = DBUtils.executeQuery(strQuery);
							ArrayList arrSecurities=new ArrayList();
							arrSecRemarksrow_sec=new ArrayList();
							int j=0;
							while (rs1.next()) 
							{
								arrCol=new ArrayList();
								arrSecRemarkscol_sec=new ArrayList();
								arrCol.add(correctNull(rs1.getString("sec_desc_details"))); 
								arrCol.add(correctNull(rs1.getString("sec_margin")));
								arrSecRemarkscol_sec.add(correctNull(rs1.getString("sec_remarks")));
								arrSecRemarksrow_sec.add(arrSecRemarkscol_sec);
								arrSecurities.add(arrCol);
								j++;
							}
							WC_Funded_sec.add(arrSecurities);
							WC_Funded_sec.add(""+j);
							WC_Funded_sec.add(arrSecRemarksrow_sec);
							OurBank_WC_Funded_sec.add(WC_Funded_sec);
							hshRecord.put("detailsasondate_sec", correctNull(rs.getString("facility_osason")));
						}

						hshRecord.put("OurBank_WC_Funded_sec", OurBank_WC_Funded_sec);

						
/***************************************************************************************************************************
 * 
 * TL FUNDED & NON FUNDED FACILITY DETAILS WITH SECURITY
 * 
 **************************************************************************************************************************/

						if (rs != null)
						{
							rs.close();
						}

						strQuery = SQLParser.getSqlQuery("com_tl_funded_nonfunded^" + strAppno);
						rs = DBUtils.executeQuery(strQuery);
						while (rs.next()) 
						{
							TL_Funded_NonFunded_sec = new ArrayList();
							TL_Funded_NonFunded_sec.add(correctNull(rs.getString("facility_catdesc")));
							TL_Funded_NonFunded_sec.add(correctNull(rs.getString("facility_existing")));
							TL_Funded_NonFunded_sec.add(correctNull(rs.getString("facility_proposed")));
							TL_Funded_NonFunded_sec.add(correctNull(rs.getString("facility_margin")));
							TL_Funded_NonFunded_sec.add(correctNull(rs.getString("facility_intremarks")));
							TL_Funded_NonFunded_sec.add(correctNull(rs.getString("facility_dp")));
							TL_Funded_NonFunded_sec.add(correctNull(rs.getString("facility_outstanding")));
							TL_Funded_NonFunded_sec.add(correctNull(rs.getString("security_value")));
							TL_Funded_NonFunded_sec.add(correctNull(rs.getString("facility_desc")));

							String strFacSno = correctNull((String)rs.getString("facility_sno"));
							
							arrSubFac = new ArrayList();
							arrSubFac = getSubFacilitiesData(strAppno,strFacSno,"adc_TL");
							TL_Funded_NonFunded_sec.add(arrSubFac);
							TL_Funded_NonFunded_sec.add(correctNull(rs.getString("bplr")));
							TL_Funded_NonFunded_sec.add(correctNull(rs.getString("facility_intadjustment")));
							TL_Funded_NonFunded_sec.add(correctNull(rs.getString("facility_category")));
							TL_Funded_NonFunded_sec.add(correctNull(rs.getString("facility_months")));
							TL_Funded_NonFunded_sec.add(correctNull(rs.getString("facility_headid")));

							strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^" + strFacSno + "^" +  strAppno);
							rs1 = DBUtils.executeQuery(strQuery);
							ArrayList arrSecurities=new ArrayList();
							arrSecRemarksrow_sec=new ArrayList();
							int j=0;
							while (rs1.next()) 
							{
								arrCol=new ArrayList();
								arrSecRemarkscol_sec=new ArrayList();
								arrCol.add(correctNull(rs1.getString("sec_desc_details"))); 
								arrCol.add(correctNull(rs1.getString("sec_margin"))); 
								arrSecRemarkscol_sec.add(correctNull(rs1.getString("sec_remarks")));
								arrSecRemarksrow_sec.add(arrSecRemarkscol_sec);
								arrSecurities.add(arrCol);
								j++;
							}
							TL_Funded_NonFunded_sec.add(arrSecurities);
							TL_Funded_NonFunded_sec.add(""+j);
							TL_Funded_NonFunded_sec.add(arrSecRemarksrow_sec);
							OurBank_TL_sec.add(TL_Funded_NonFunded_sec);
							hshRecord.put("detailsasondate_sec", correctNull(rs.getString("facility_osason")));
						}

						hshRecord.put("OurBank_TL_sec", OurBank_TL_sec);
						//hshRecord.put("arrSecRemarks_sec",arrSecRemarksrow_sec);
/***********************************************************************************************************************************************
 * 
 * 				6.2 PERSONAL/CORPORATE GUARANTEE : MEANS
 * 
 * **********************************************************************************************************************************************/
			if (rs != null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("selcreditreport2^"+strAppno+"^"+"1");
			if (rs.next())
			{
				hshRecord.put("means",correctNull(rs.getString("CR_Total_MEANS")));
				hshRecord.put("meansason",correctNull(rs.getString("cr_meansason")));
			}
			else 
			{
				hshValues.put("means","0.00");
			}				
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getADCApprovalprint "+ce.toString());
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
	
	/*private ArrayList getSubFacilitiesData(String strAppno, String strFacSno, String strType) throws Exception{
		ArrayList arrSubFac = new ArrayList();
		ArrayList arrSubFacRecords = new ArrayList();
		String strQuery="";
		ResultSet rs =null;
		ResultSet rs1 =null;
		
		try{
			if(strType.trim().equalsIgnoreCase("TL"))
				strQuery = SQLParser.getSqlQuery("adc_subfac^"+strAppno+"^"+strFacSno);
			else if(strType.trim().equalsIgnoreCase("FD"))
				strQuery = SQLParser.getSqlQuery("adc_subfac^"+strAppno+"^"+strFacSno);
			else if(strType.trim().equalsIgnoreCase("NFD"))
				strQuery = SQLParser.getSqlQuery("adc_subfac^"+strAppno+"^"+strFacSno);
			
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next()){
				arrSubFacRecords = new ArrayList();
				arrSubFacRecords.add(correctNull(rs.getString("facility_catdesc")));
				arrSubFacRecords.add(correctNull(rs.getString("ADCFAC_AMOUNT")));
				arrSubFacRecords.add(correctNull(rs.getString("ADCFAC_OS")));
				arrSubFacRecords.add(correctNull(rs.getString("ADCFAC_SECVALUE")));
				arrSubFacRecords.add(correctNull(rs.getString("ADCFAC_REMARKS")));
				arrSubFacRecords.add(correctNull(rs.getString("adcfac_category")));
				arrSubFacRecords.add(correctNull(rs.getString("ADCFAC_MONTHS")));
				arrSubFacRecords.add(correctNull(rs.getString("ADCFAC_HEADID")));
				arrSubFacRecords.add(correctNull(rs.getString("ADCFAC_MARGIN")));
				arrSubFacRecords.add(correctNull(rs.getString("ADCFAC_INTEREST")));
				//Attach Primary Security to facility
				if(rs1 != null)
					rs1.close();	
				strQuery=SQLParser.getSqlQuery("sel_adcsec_primarydetails^"+strAppno+"^"+"Primary"+"^"+strFacSno);
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					arrSubFacRecords.add(correctNull(rs1.getString("sec_desc")));//10
				}
				else
				{
					arrSubFacRecords.add("");//10
				}
				if(rs1 != null)
					rs1.close();
				arrSubFac.add(arrSubFacRecords);
			}
			
			
		}catch(Exception e)
		{
			log.error("Exception in getSubFacilitiesData of Adhoc Bean"+e.getMessage());
		}finally{
			try{
				if(rs!=null)
					rs.close();
				if(rs1!=null)
					rs1.close();
			}catch(Exception ce)
			{
				log.error("Exception in closing connection in getSubFacilitiesData of Adhoc Bean"+ce.getMessage());
			}
		}
		return arrSubFac;
	}*/
	
	private ArrayList getSubFacilitiesData(String strAppno, String strFacSno, String strType) throws Exception{
		ArrayList arrSubFac = new ArrayList();
		ArrayList arrSubFacRecords = new ArrayList();
		String strQuery="";
		ResultSet rs =null;
		ResultSet rs1=null;
		String strsubfacsno="";
		try{
			if(strType.trim().equalsIgnoreCase("TL"))
				strQuery = SQLParser.getSqlQuery("com_subfac_existing_adc^"+strAppno+"^"+strFacSno);
			else if(strType.trim().equalsIgnoreCase("FD"))
				strQuery = SQLParser.getSqlQuery("com_subfac_existing_adc^"+strAppno+"^"+strFacSno);
			else if(strType.trim().equalsIgnoreCase("NFD"))
				strQuery = SQLParser.getSqlQuery("com_subfac_existing_adc^"+strAppno+"^"+strFacSno);
			else if(strType.trim().equalsIgnoreCase("adc_TL"))
				strQuery = SQLParser.getSqlQuery("com_subfac_adc^"+strAppno+"^"+strFacSno);
			else if(strType.trim().equalsIgnoreCase("adc_FD"))
				strQuery = SQLParser.getSqlQuery("com_subfac_adc^"+strAppno+"^"+strFacSno);
			else if(strType.trim().equalsIgnoreCase("adc_NFD"))
				strQuery = SQLParser.getSqlQuery("com_subfac_adc^"+strAppno+"^"+strFacSno);
			
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next()){
				//int d2b = 0;
				arrSubFacRecords = new ArrayList();
				arrSubFacRecords.add(correctNull(rs.getString("facility_catdesc")));//0
				arrSubFacRecords.add(correctNull(rs.getString("facility_existing")));//1
				arrSubFacRecords.add(correctNull(rs.getString("facility_proposed")));//2
				arrSubFacRecords.add(correctNull(rs.getString("facility_margin")));//3
				arrSubFacRecords.add(correctNull(rs.getString("facility_intremarks")));//4
				arrSubFacRecords.add(correctNull(rs.getString("facility_dp")));//5
				arrSubFacRecords.add(correctNull(rs.getString("facility_outstanding")));//6
				arrSubFacRecords.add(correctNull(rs.getString("security_value")));//7
				arrSubFacRecords.add(correctNull(rs.getString("facility_desc")));//8
				arrSubFacRecords.add(correctNull(rs.getString("bplr")));//9
				arrSubFacRecords.add(correctNull(rs.getString("facility_intadjustment")));//10
				arrSubFacRecords.add(correctNull(rs.getString("facility_category")));//11
				arrSubFacRecords.add(correctNull(rs.getString("facility_months")));//12
				arrSubFacRecords.add(correctNull(rs.getString("facility_headid")));//13
				strsubfacsno=correctNull(rs.getString("facility_sno"));
				
				strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^" +  strsubfacsno
						+ "^" + strAppno);
				rs1 = DBUtils.executeQuery(strQuery);
				ArrayList arrSecurities=new ArrayList();
				int j=0;
				while (rs1.next()) {
					ArrayList arrCol=new ArrayList();
					arrCol.add(correctNull(rs1.getString("sec_desc_details"))); 
					arrCol.add(correctNull(rs1.getString("sec_margin")));
					arrSecurities.add(arrCol);
					j++;
				}
				arrSubFacRecords.add(arrSecurities);
				arrSubFacRecords.add(""+j);
				arrSubFac.add(arrSubFacRecords);
			}
		}catch(Exception e)
		{
			log.error("Exception in getSubFacilitiesData of Adhoc Bean "+e.getMessage());
		}finally{
			try{
				if(rs!=null)
					rs.close();
			}catch(Exception ce)
			{
				log.error("Exception in closing connection in getSubFacilitiesData of Bean"+ce.getMessage());
			}
		}
		return arrSubFac;
	}
	
}
