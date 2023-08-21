package com.sai.laps.ejb.additionalParameter;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import com.sai.laps.helper.ApplicantParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "AdditionalParameterBean", mappedName = "AdditionalParameterHome")
@Remote (AdditionalParameterRemote.class)
public class AdditionalParameterBean extends BeanAdapter
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 863008085316958879L;
	/**
	 * 
	 */
	

	public  HashMap getadditionalParameter(HashMap hshValues) 
	{
		String strQuery="";
		String strAppStatus="";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strCustomerID=correctNull((String)hshValues.get("strApplicationNo"));	
		String appno1=correctNull((String)hshValues.get("appno1"));	
		String strCBSID=correctNull((String)hshValues.get("hidCBSId"));
		String hidapptype=correctNull((String)hshValues.get("hidAppType"));
		
		try
		{
			if(!strCustomerID.equalsIgnoreCase(""))
			{
				strQuery = SQLParser.getSqlQuery("addparameterselval^"+strCustomerID+"^"+hidapptype);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{	
					hshRecord.put("sel_minor",correctNull((String)rs.getString("minor")));
					hshRecord.put("txt_guardian",correctNull((String)rs.getString("guardian")));
					hshRecord.put("txt_relation",correctNull((String)rs.getString("relation_address")));
					hshRecord.put("sel_trade",correctNull((String)rs.getString("trade_finance")));
					hshRecord.put("sel_inland",correctNull((String)rs.getString("trade_inland")));
					hshRecord.put("txt_ititle",correctNull((String)rs.getString("intr_title")));
					hshRecord.put("txt_iname",correctNull((String)rs.getString("intr_name")));
					hshRecord.put("gua_name",correctNull((String)rs.getString("gua_name")));
					hshRecord.put("flag","true");									
				}
			}
			hshRecord.put("hidCBSId",strCBSID);
			hshRecord.put("hidAppType",hidapptype);
			
			if(rs!=null)
				rs.close();	
				
	     		rs=DBUtils.executeLAPSQuery("commworkflowsel2^"+appno1);
				if(rs.next())
				{
					strAppStatus=rs.getString(1);
				}
				hshRecord.put("appstatus",strAppStatus);
			
		
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
		return hshRecord;
	}	


	public HashMap updateadditionalParameter(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String strCustomerID=correctNull((String)hshValues.get("strApplicationNo"));
		String strCBSID=correctNull((String)hshValues.get("hidCBSId"));
		String hidapptype=correctNull((String)hshValues.get("hidAppType"));
		try
		{
		   if(strAction.equalsIgnoreCase("insert"))
			{
				
				hshQueryValues = new HashMap();							
				int intUpdateSize=0;				
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				intUpdateSize++;
				hshQuery.put("strQueryId","addparameterinsval");
				
				arrValues.add(strCBSID);
				arrValues.add(correctNull((String )hshValues.get("txt_guardian")));
				arrValues.add(correctNull((String )hshValues.get("sel_minor")));				
				arrValues.add(correctNull((String )hshValues.get("sel_trade")));
				arrValues.add(correctNull((String )hshValues.get("sel_inland")));
				arrValues.add(correctNull((String )hshValues.get("txt_ititle")));
				arrValues.add(correctNull((String )hshValues.get("txt_iname")));				
				arrValues.add(correctNull((String )hshValues.get("txt_relation")));				
				arrValues.add(hidapptype);
				arrValues.add(strCustomerID);
				arrValues.add(correctNull((String )hshValues.get("txt_guardianame")));	
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);	
				hshQueryValues.put("size",Integer.toString(intUpdateSize));
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","addparameterdelval");
				arrValues.add(strCustomerID);
				arrValues.add(hidapptype);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			else  if(strAction.equalsIgnoreCase("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","addparameterdelval");
				arrValues.add(strCustomerID);
				arrValues.add(hidapptype);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQueryValues = new HashMap();
				
				int intUpdateSize=0;
				
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				intUpdateSize++;
				hshQuery.put("strQueryId","addparameterinsval");
				
				arrValues.add(strCBSID);
				arrValues.add(correctNull((String )hshValues.get("txt_guardian")));
				arrValues.add(correctNull((String )hshValues.get("sel_minor")));				
				arrValues.add(correctNull((String )hshValues.get("sel_trade")));
				arrValues.add(correctNull((String )hshValues.get("sel_inland")));
				arrValues.add(correctNull((String )hshValues.get("txt_ititle")));
				arrValues.add(correctNull((String )hshValues.get("txt_iname")));				
				arrValues.add(correctNull((String )hshValues.get("txt_relation")));				
				arrValues.add(hidapptype);
				arrValues.add(strCustomerID);
				arrValues.add(correctNull((String )hshValues.get("txt_guardianame")));		
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);	
				hshQueryValues.put("size",Integer.toString(intUpdateSize));
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");				
				
			}
			HashMap hshRecord = getadditionalParameter(hshValues);
			return hshRecord;
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
	}

	
	/**
	 *  author : Muralidharan
	 * 
	 * @param hshValues
	 * @return
	 * @
	 */
	
	public  HashMap checkRating(HashMap hshValues) 
	{
 		String strAppStatus="";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String appno=correctNull((String)hshValues.get("com_appno"));
		
		if(appno.equalsIgnoreCase(""))
		{
			appno=correctNull((String)hshValues.get("strappno"));
		}
		
		try
		{	
			 if(rs!=null)
				rs.close();	
				
	     		rs=DBUtils.executeLAPSQuery("commworkflowsel2^"+appno);
				if(rs.next())
				{
					strAppStatus=rs.getString(1);
				}
				hshRecord.put("appstatus",strAppStatus);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getCorporateSanctionDetails"+ce.toString());
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
				throw new EJBException("Error closing the connection in checkRating"+cf.getMessage());
			}
		}
		hshRecord.put("com_appno",appno);
		return hshRecord;
	}
	
	/**
	 *  author : Muralidharan
	 * 
	 * @param hshValues
	 * @return
	 * @
	 */
	
	public  HashMap getCorporateSanctionDetails(HashMap hshValues) 
	{
 		String strQuery="";
 		String strAppStatus="";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String checkData="NO";
		String appno=correctNull((String)hshValues.get("com_appno"));
		
		if(appno.equalsIgnoreCase(""))
		{
			appno=correctNull((String)hshValues.get("appno"));
		}
		
		String facility_id = correctNull((String)hshValues.get("sel_ram_facility"));		
		
		
		try
		{			
			
			if(rs != null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_sanction_details^"+appno+"^"+facility_id);
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{
				hshRecord.put("facility_rating",correctNull((String)rs.getString("ram_rating")));
				hshRecord.put("facility_existing",correctNull((String)rs.getString("existing_limit")));
				hshRecord.put("facility_proposed",correctNull((String)rs.getString("proposed_limit")));
				hshRecord.put("requested_amt",correctNull((String)rs.getString("requested_amt")));				
				hshRecord.put("facility_sancamt",correctNull((String)rs.getString("sanctioned_amt")));		
				hshRecord.put("facility_interestrate",correctNull((String)rs.getString("ram_interest")));		
				hshRecord.put("facility_sancinterest",correctNull((String)rs.getString("sanctioned_interest")));				
				hshRecord.put("start_date",correctNull((String)rs.getString("start_date")));
				hshRecord.put("cbs_taxslab",correctNull((String)rs.getString("cbs_taxslab")));
				hshRecord.put("cbs_noofflows",correctNull((String)rs.getString("cbs_noofflows")));				
				hshRecord.put("cbs_loan_frequency",correctNull((String)rs.getString("cbs_loan_frequency")));		
				hshRecord.put("cbs_loan_period",correctNull((String)rs.getString("cbs_loan_period")));		
				hshRecord.put("cbs_sector_code",correctNull((String)rs.getString("cbs_sector_code")));				
				hshRecord.put("cbs_subsector_code",correctNull((String)rs.getString("cbs_subsector_code")));
				hshRecord.put("cbs_purposeof_advance",correctNull((String)rs.getString("cbs_purposeof_advance")));				
				hshRecord.put("cbs_operation_mode",correctNull((String)rs.getString("cbs_operation_mode")));		
				hshRecord.put("cbs_natureof_advance",correctNull((String)rs.getString("cbs_natureof_advance")));		
				hshRecord.put("cbs_sanction_level",correctNull((String)rs.getString("cbs_sanction_level")));				
				hshRecord.put("cbs_sanction_authority",correctNull((String)rs.getString("cbs_sanction_authority")));
				hshRecord.put("cbs_sanction_refno",correctNull((String)rs.getString("cbs_sanction_refno")));
				hshRecord.put("cbs_payment_method",correctNull((String)rs.getString("cbs_payment_method")));				
				hshRecord.put("cbs_operating_accno",correctNull((String)rs.getString("cbs_operating_accno")));
				hshRecord.put("FreeText7",correctNull((String)rs.getString("FreeText7")));
				hshRecord.put("scheme_code",correctNull((String)rs.getString("scheme_code")));
				
				hshRecord.put("borrowercat",correctNull((String)rs.getString("cbs_borrowercat")));
				hshRecord.put("advtype",correctNull((String)rs.getString("cbs_advtype")));
				hshRecord.put("advmode",correctNull((String)rs.getString("cbs_advmode")));
				hshRecord.put("indtype",correctNull((String)rs.getString("cbs_indtype")));
				hshRecord.put("app_check",correctNull((String)rs.getString("facility_stat_flag")));
				checkData="YES";
				hshRecord.put("customertype", Helper.correctNull((String) rs.getString("cbs_cust_type")));
				hshRecord.put("customertypedesc", Helper.correctNull((String) rs.getString("cbs_cust_typedesc")));
				hshRecord.put("healthcode", Helper.correctNull((String) rs.getString("cbs_health_code")));
				hshRecord.put("healthcodedesc", Helper.correctNull((String) rs.getString("cbs_health_codedesc")));
				hshRecord.put("freecode7", Helper.correctNull((String) rs.getString("cbs_freecode7")));
				hshRecord.put("freecode7desc", Helper.correctNull((String) rs.getString("cbs_freecode7desc")));
				
			}
			else
			{
				checkData="NO";
				
				if(rs != null)
				{
					rs.close();
				}
				
				strQuery = SQLParser.getSqlQuery("sel_facility_details^"+appno+"^"+facility_id);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("facility_existing",correctNull((String)rs.getString("facility_existing")));
					hshRecord.put("facility_proposed",correctNull((String)rs.getString("facility_proposed")));
					hshRecord.put("facility_sancamt",correctNull((String)rs.getString("facility_sancamt")));
					hshRecord.put("facility_sancinterest",correctNull((String)rs.getString("facility_sancinterest")));
					
					hshRecord.put("requested_amt",correctNull((String)rs.getString("requested_amt")));
					hshRecord.put("facility_interestrate",correctNull((String)rs.getString("facility_interest")));
				}
				
				hshRecord.put("cbs_taxslab","0");
				hshRecord.put("cbs_loan_frequency","0");	
				hshRecord.put("cbs_sector_code","0");				
				hshRecord.put("cbs_subsector_code","0");
				hshRecord.put("cbs_purposeof_advance","0");				
				hshRecord.put("cbs_operation_mode","0");		
				hshRecord.put("cbs_natureof_advance","0");		
				hshRecord.put("cbs_sanction_level","0");				
				hshRecord.put("cbs_sanction_authority","0");
				hshRecord.put("cbs_payment_method","0");	
				hshRecord.put("borrowercat","s");	
				hshRecord.put("advmode","s");	
				hshRecord.put("advtype","s");	
				hshRecord.put("indtype","s");	
				hshRecord.put("cbs_sanction_refno",appno);
			}
			
			hshRecord.put("Flag","1");
			hshRecord.put("facility_id",facility_id);
			hshRecord.put("com_appno",appno);
			hshRecord.put("SENT_FLAG","false");
			hshRecord.put("checkData",checkData);
			
			if(rs!=null)
				rs.close();	
				
	     	rs=DBUtils.executeLAPSQuery("commworkflowsel2^"+appno);
			if(rs.next())
			{
				strAppStatus=rs.getString(1);
			}
			hshRecord.put("appstatus",strAppStatus);
				
			if(rs!=null)
				rs.close();	
				
	     	rs=DBUtils.executeLAPSQuery("selprosalvaluesin^"+appno);
	     	if(rs.next())
			{
				strAppStatus=rs.getString("prop_valuesin");
			}
			hshRecord.put("proposalin",strAppStatus);
				
				
				
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getCorporateSanctionDetails"+ce.toString());
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
				throw new EJBException("Error closing the connection in getCorporateSanctionDetails "+cf.getMessage());
			}
		}
		return hshRecord;
	}	

	/**
	 *  author : Muralidharan
	 * 
	 * @param hshValues
	 * @return
	 * @
	 */
	
	public void updateCorporateSanctionDetails(HashMap hshValues) 
	{		
		String strQuery="";
		ResultSet rs = null;
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		
		String CompanyName="";
		String CompanyID="";
		String FacilityName="";
		String FacilityParent="";
		String Facility_SchemeCode="";
		String strAction="";
		String facility_id="";
		String cbsaccountno="";
		
		String appno=correctNull((String)hshValues.get("com_appno"));		
		
		if(appno.equalsIgnoreCase(""))
		{
			appno=correctNull((String)hshValues.get("appno"));
		}
	
		String facility_sno = correctNull((String)hshValues.get("sel_ram_facility"));			
		String strCheck=correctNull((String)hshValues.get("hidAction"));
		
		try
		{
			if(rs != null)
			{
				rs.close();
			}
			if(!strCheck.equalsIgnoreCase("reject"))
			{
				strQuery = SQLParser.getSqlQuery("sel_sanction_details^"+appno+"^"+facility_sno);
				rs=DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{
					strAction="update";
					facility_id=correctNull((String)rs.getString("facility_catid"));
				}
				else
				{
					strAction="insert";
				}
			}
			if(strCheck.equalsIgnoreCase("reject"))
			{
				strAction="reject";
			}
			
			if(strAction.equals("insert"))
			{  
				if(rs != null)
				{
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("comfunsel3^"+appno);
				rs=DBUtils.executeQuery(strQuery);				
				if(rs.next())
				{
					CompanyName=correctNull((String)rs.getString("app_name"));					
					CompanyID=correctNull((String)rs.getString("demo_appid"));								
				}
				
				if(rs != null)
				{
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("sel_facility_details^"+appno+"^"+facility_sno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					FacilityName=correctNull((String)rs.getString("facility_catdesc"));
					FacilityParent=correctNull((String)rs.getString("facility_headid"));
					Facility_SchemeCode=correctNull((String)rs.getString("facility_schemecode"));				
				}
											   
				if(rs != null)
				{
					rs.close();
				}
				
				HashMap hshrec=new HashMap();
				hshrec.put("appno",appno);
				hshrec.put("facsno",facility_sno);
				hshrec=getFacilitysno(hshrec);
				facility_id=correctNull((String)hshrec.get("strFacId"));
				cbsaccountno=correctNull((String)hshrec.get("strCbsaccno"));
				
				hshQueryValues = new HashMap();	
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				int intUpdateSize=0;				
				
				intUpdateSize++;
				hshQuery.put("strQueryId","ins_sanction_details");
				arrValues.add(appno);//1
				arrValues.add(CompanyID);//2
				arrValues.add(CompanyName);//3				
				arrValues.add(facility_sno);//4				
				arrValues.add(Facility_SchemeCode);//5
				arrValues.add(FacilityName);//6
				arrValues.add(facility_id);//7
				arrValues.add(FacilityParent);//8
				arrValues.add(correctNull((String)hshValues.get("txt_rating")));//9
				arrValues.add(correctNull((String)hshValues.get("txt_existing_limit")));//10
				arrValues.add(correctNull((String)hshValues.get("txt_proposed_limit")));//11
				arrValues.add(correctNull((String)hshValues.get("txt_sanctioned_amt")));//12
				arrValues.add(correctNull((String)hshValues.get("txt_interest_rate")));//13
				arrValues.add(correctNull((String)hshValues.get("txt_mod_interestrate")));//14
				arrValues.add(correctNull((String)hshValues.get("txt_loan_startdate")));//15
				arrValues.add(correctNull((String)hshValues.get("sel_taxslab")));//16
				arrValues.add(correctNull((String)hshValues.get("txt_flows")));//17
				arrValues.add(correctNull((String)hshValues.get("sel_loan_frequency")));//18				
				arrValues.add(correctNull((String)hshValues.get("txt_loanperiod")));//19
				arrValues.add(correctNull((String)hshValues.get("sel_sectorcode")));//20
				arrValues.add(correctNull((String)hshValues.get("sel_subsector")));//21
				arrValues.add(correctNull((String)hshValues.get("select_purposeadvance")));//22				
				arrValues.add(correctNull((String)hshValues.get("sel_oprationmode")));//23
				arrValues.add(correctNull((String)hshValues.get("sel_natureof_advance")));//24
				arrValues.add(correctNull((String)hshValues.get("sel_sanctionlevel")));//25			
				arrValues.add(correctNull((String)hshValues.get("sel_sanctionauthority")));//26
				arrValues.add(correctNull((String)hshValues.get("txt_sanction_refno")));//27
				arrValues.add(correctNull((String)hshValues.get("selmodepayment")));//28
				arrValues.add(correctNull((String)hshValues.get("txt_operativeaccno")));//29
				arrValues.add(correctNull((String)hshValues.get("txt_freetext7")));//30
				arrValues.add("Y");
				arrValues.add(cbsaccountno);
				arrValues.add(correctNull((String)hshValues.get("selborrowercat")));
				arrValues.add(correctNull((String)hshValues.get("seladvtype")));
				arrValues.add(correctNull((String)hshValues.get("seladvmode")));
				arrValues.add(correctNull((String)hshValues.get("selindtype")));
				arrValues.add(correctNull((String) hshValues.get("hidcusttype")));
				arrValues.add(correctNull((String) hshValues.get("hidhealthcode")));
				arrValues.add(correctNull((String) hshValues.get("hidfreecode7")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");				
			}
					
			else  if(strAction.equals("update"))
			{
				hshQueryValues = new HashMap();	
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				int intUpdateSize=0;				
				
				intUpdateSize++;
				hshQuery.put("strQueryId","upd_sanction_details");				
				arrValues.add(correctNull((String)hshValues.get("txt_rating")));//9
				arrValues.add(correctNull((String)hshValues.get("txt_existing_limit")));//10
				arrValues.add(correctNull((String)hshValues.get("txt_proposed_limit")));//11
				arrValues.add(correctNull((String)hshValues.get("txt_sanctioned_amt")));//12
				arrValues.add(correctNull((String)hshValues.get("txt_interest_rate")));//13
				arrValues.add(correctNull((String)hshValues.get("txt_mod_interestrate")));//14
				arrValues.add(correctNull((String)hshValues.get("txt_loan_startdate")));//15
				arrValues.add(correctNull((String)hshValues.get("sel_taxslab")));//16
				arrValues.add(correctNull((String)hshValues.get("txt_flows")));//17
				arrValues.add(correctNull((String)hshValues.get("sel_loan_frequency")));//18				
				arrValues.add(correctNull((String)hshValues.get("txt_loanperiod")));//19
				arrValues.add(correctNull((String)hshValues.get("sel_sectorcode")));//20
				arrValues.add(correctNull((String)hshValues.get("sel_subsector")));//21
				arrValues.add(correctNull((String)hshValues.get("select_purposeadvance")));//22				
				arrValues.add(correctNull((String)hshValues.get("sel_oprationmode")));//23
				arrValues.add(correctNull((String)hshValues.get("sel_natureof_advance")));//24
				arrValues.add(correctNull((String)hshValues.get("sel_sanctionlevel")));//25			
				arrValues.add(correctNull((String)hshValues.get("sel_sanctionauthority")));//26
				arrValues.add(correctNull((String)hshValues.get("txt_sanction_refno")));//27
				arrValues.add(correctNull((String)hshValues.get("selmodepayment")));//28
				arrValues.add(correctNull((String)hshValues.get("txt_operativeaccno")));//29
				arrValues.add(correctNull((String)hshValues.get("txt_freetext7")));//30
				arrValues.add("Y");
				arrValues.add(correctNull((String)hshValues.get("selborrowercat")));
				arrValues.add(correctNull((String)hshValues.get("seladvtype")));
				arrValues.add(correctNull((String)hshValues.get("seladvmode")));
				arrValues.add(correctNull((String)hshValues.get("selindtype")));
				arrValues.add(correctNull((String) hshValues.get("hidcusttype")));
				arrValues.add(correctNull((String) hshValues.get("hidhealthcode")));
				arrValues.add(correctNull((String) hshValues.get("hidfreecode7")));
				arrValues.add(appno);//1							
				arrValues.add(facility_sno);//4
				arrValues.add(facility_id);//7			
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			}
			else if(strAction.equals("reject"))
			{
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","upd_sanctiondetails");
				arrValues.add("N");
				arrValues.add(appno);
				arrValues.add(facility_sno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			
			StringBuilder sbAuditTrial=new StringBuilder();
			sbAuditTrial.append("Facility Name = ").append(correctNull((String )hshValues.get("sel_ram_facility1"))).append("~Sector Code = ").append(correctNull((String )hshValues.get("sel_sectorcode1")))
			.append("~Existing Limit = ").append(correctNull((String )hshValues.get("txt_existing_limit"))).append("~Sub Sector Code = ").append(correctNull((String )hshValues.get("sel_subsector1")))
			.append("~Proposed Limit = ").append(correctNull((String )hshValues.get("txt_proposed_limit"))).append("~Purpose Of Advance = ").append(correctNull((String )hshValues.get("select_purposeadvance1")))
			.append("~Rating =").append(correctNull((String )hshValues.get("txt_rating"))).append("~Operation Mode = ").append(correctNull((String )hshValues.get("sel_oprationmode1")))
			.append("~Nature Of Advance = ").append(correctNull((String )hshValues.get("sel_natureof_advance1"))).append("~Sanctioned Loan Amount = ").append(correctNull((String )hshValues.get("txt_sanctioned_amt")))
			.append("~Sanction Level = ").append(correctNull((String )hshValues.get("sel_sanctionlevel1"))).append("~Rate of Interest = ").append(correctNull((String )hshValues.get("txt_interest_rate")))
			.append("~Sanction Authority = ").append(correctNull((String )hshValues.get("sel_sanctionauthority1"))).append("~Modified Rate of Interest = ").append(correctNull((String )hshValues.get("txt_mod_interestrate")))
			.append("~Sanction Ref.No = ").append(correctNull((String )hshValues.get("txt_sanction_refno"))).append("~Tax Slab = ").append(correctNull((String )hshValues.get("sel_taxslab1")))
			.append("~Payment Method = ").append(correctNull((String )hshValues.get("selmodepayment1"))).append("~No Of Flows = ").append(correctNull((String )hshValues.get("txt_flows")));
			
			if(correctNull((String )hshValues.get("selmodepayment")).equals("E"))
			{	
				sbAuditTrial.append("~Operating A/C No = ").append(correctNull((String )hshValues.get("txt_operativeaccno")));
			}
			sbAuditTrial.append("~Loan Frequency = ").append(correctNull((String )hshValues.get("sel_loan_frequency1")))
			.append("~Loan period = ").append(correctNull((String )hshValues.get("txt_loanperiod")));
			
			AuditTrial.auditLog(hshValues,"166",appno,sbAuditTrial.toString());
			
			
		  
		}
		catch(Exception ce)
		{
			throw new EJBException("inside updateCorporateSanctionDetails"+ce.toString());
		}finally
		{
			try
			{
				if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection in updateCorporateSanctionDetails"+cf.getMessage());
			}
			
		}
	}
	public void updateTertiarySanctionDetails(HashMap hshValues) 
	{		
		String strQuery="";
		ResultSet rs = null;
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		
		String CompanyName="";
		String CompanyID="";
		String FacilityName="";
		String FacilityParent="";
		String Facility_SchemeCode="";
		String strAction="";
		String facility_id="";
		String cbsaccountno="";
		
		String appno=correctNull((String)hshValues.get("com_appno"));		
		
		if(appno.equalsIgnoreCase(""))
		{
			appno=correctNull((String)hshValues.get("appno"));
		}
	
		String Facility_sno = correctNull((String)hshValues.get("sel_ram_facility"));			
		String strCheck=correctNull((String)hshValues.get("hidAction"));
		
		try
		{
			if(rs != null)
			{
				rs.close();
			}
			if(!strCheck.equalsIgnoreCase("reject"))
			{
				strQuery = SQLParser.getSqlQuery("sel_sanction_details^"+appno+"^"+Facility_sno);
				rs=DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{
					strAction="update";
					facility_id=correctNull((String)rs.getString("facility_catid"));
				}
				else
				{
					strAction="insert";
				}
			}
			if(strCheck.equalsIgnoreCase("reject"))
			{
				strAction="reject";
			}
			
			if(strAction.equals("insert"))
			{  
				if(rs != null)
				{
					rs.close();
				}
				String strapptype="N";
				strQuery = SQLParser.getSqlQuery("comfunsel4^"+appno+"^"+strapptype);
				rs=DBUtils.executeQuery(strQuery);				
				if(rs.next())
				{
					CompanyName=correctNull((String)rs.getString("app_name"));					
					CompanyID=correctNull((String)rs.getString("demo_appid"));								
				}
				
				if(rs != null)
				{
					rs.close();
				}
				
				strQuery = SQLParser.getSqlQuery("sel_facility_details^"+appno+"^"+Facility_sno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					FacilityName=correctNull((String)rs.getString("facility_catdesc"));
					FacilityParent=correctNull((String)rs.getString("facility_headid"));
					Facility_SchemeCode=correctNull((String)rs.getString("facility_schemecode"));				
				}
							   
				if(rs != null)
				{
					rs.close();
				}
				
				HashMap hshrec=new HashMap();
				hshrec.put("appno",appno);
				hshrec.put("facsno",Facility_sno);
				hshrec=getFacilitysno(hshrec);
				facility_id=correctNull((String)hshrec.get("strFacId"));
				cbsaccountno=correctNull((String)hshrec.get("strCbsaccno"));
				
				hshQueryValues = new HashMap();	
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				int intUpdateSize=0;				
				
				intUpdateSize++;
				hshQuery.put("strQueryId","ins_sanction_details");
				arrValues.add(appno);//1
				arrValues.add(CompanyID);//2
				arrValues.add(CompanyName);//3				
				arrValues.add(Facility_sno);//4				
				arrValues.add(Facility_SchemeCode);//5
				arrValues.add(FacilityName);//6
				arrValues.add(facility_id);//7
				arrValues.add(FacilityParent);//8
				arrValues.add(correctNull((String)hshValues.get("txt_rating")));//9
				arrValues.add(correctNull((String)hshValues.get("txt_existing_limit")));//10
				arrValues.add(correctNull((String)hshValues.get("txt_proposed_limit")));//11
				arrValues.add(correctNull((String)hshValues.get("txt_sanctioned_amt")));//12
				arrValues.add(correctNull((String)hshValues.get("txt_interest_rate")));//13
				arrValues.add(correctNull((String)hshValues.get("txt_mod_interestrate")));//14
				arrValues.add(correctNull((String)hshValues.get("txt_loan_startdate")));//15
				arrValues.add(correctNull((String)hshValues.get("sel_taxslab")));//16
				arrValues.add(correctNull((String)hshValues.get("txt_flows")));//17
				arrValues.add(correctNull((String)hshValues.get("sel_loan_frequency")));//18				
				arrValues.add(correctNull((String)hshValues.get("txt_loanperiod")));//19
				arrValues.add(correctNull((String)hshValues.get("sel_sectorcode")));//20
				arrValues.add(correctNull((String)hshValues.get("sel_subsector")));//21
				arrValues.add(correctNull((String)hshValues.get("select_purposeadvance")));//22				
				arrValues.add(correctNull((String)hshValues.get("sel_oprationmode")));//23
				arrValues.add(correctNull((String)hshValues.get("sel_natureof_advance")));//24
				arrValues.add(correctNull((String)hshValues.get("sel_sanctionlevel")));//25			
				arrValues.add(correctNull((String)hshValues.get("sel_sanctionauthority")));//26
				arrValues.add(correctNull((String)hshValues.get("txt_sanction_refno")));//27
				arrValues.add(correctNull((String)hshValues.get("selmodepayment")));//28
				arrValues.add(correctNull((String)hshValues.get("txt_operativeaccno")));//29
				arrValues.add(correctNull((String)hshValues.get("txt_freetext7")));//30
				arrValues.add("Y");
				arrValues.add(cbsaccountno);
				arrValues.add(correctNull((String)hshValues.get("selborrowercat")));
				arrValues.add(correctNull((String)hshValues.get("seladvtype")));
				arrValues.add(correctNull((String)hshValues.get("seladvmode")));
				arrValues.add(correctNull((String)hshValues.get("selindtype")));
				arrValues.add(correctNull((String) hshValues.get("hidcusttype")));
				arrValues.add(correctNull((String) hshValues.get("hidhealthcode")));
				arrValues.add(correctNull((String) hshValues.get("hidfreecode7")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");				
			}
					
			else  if(strAction.equals("update"))
			{
				hshQueryValues = new HashMap();	
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				int intUpdateSize=0;				
				
				intUpdateSize++;
				hshQuery.put("strQueryId","upd_sanction_details");				
				arrValues.add(correctNull((String)hshValues.get("txt_rating")));//9
				arrValues.add(correctNull((String)hshValues.get("txt_existing_limit")));//10
				arrValues.add(correctNull((String)hshValues.get("txt_proposed_limit")));//11
				arrValues.add(correctNull((String)hshValues.get("txt_sanctioned_amt")));//12
				arrValues.add(correctNull((String)hshValues.get("txt_interest_rate")));//13
				arrValues.add(correctNull((String)hshValues.get("txt_mod_interestrate")));//14
				arrValues.add(correctNull((String)hshValues.get("txt_loan_startdate")));//15
				arrValues.add(correctNull((String)hshValues.get("sel_taxslab")));//16
				arrValues.add(correctNull((String)hshValues.get("txt_flows")));//17
				arrValues.add(correctNull((String)hshValues.get("sel_loan_frequency")));//18				
				arrValues.add(correctNull((String)hshValues.get("txt_loanperiod")));//19
				arrValues.add(correctNull((String)hshValues.get("sel_sectorcode")));//20
				arrValues.add(correctNull((String)hshValues.get("sel_subsector")));//21
				arrValues.add(correctNull((String)hshValues.get("select_purposeadvance")));//22				
				arrValues.add(correctNull((String)hshValues.get("sel_oprationmode")));//23
				arrValues.add(correctNull((String)hshValues.get("sel_natureof_advance")));//24
				arrValues.add(correctNull((String)hshValues.get("sel_sanctionlevel")));//25			
				arrValues.add(correctNull((String)hshValues.get("sel_sanctionauthority")));//26
				arrValues.add(correctNull((String)hshValues.get("txt_sanction_refno")));//27
				arrValues.add(correctNull((String)hshValues.get("selmodepayment")));//28
				arrValues.add(correctNull((String)hshValues.get("txt_operativeaccno")));//29
				arrValues.add(correctNull((String)hshValues.get("txt_freetext7")));//30
				arrValues.add("Y");
				arrValues.add(correctNull((String)hshValues.get("selborrowercat")));
				arrValues.add(correctNull((String)hshValues.get("seladvtype")));
				arrValues.add(correctNull((String)hshValues.get("seladvmode")));
				arrValues.add(correctNull((String)hshValues.get("selindtype")));
				arrValues.add(correctNull((String) hshValues.get("hidcusttype")));
				arrValues.add(correctNull((String) hshValues.get("hidhealthcode")));
				arrValues.add(correctNull((String) hshValues.get("hidfreecode7")));
				arrValues.add(appno);//1							
				arrValues.add(Facility_sno);//4
				arrValues.add(facility_id);//7			
				arrValues.size();
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			}
			else if(strAction.equals("reject"))
			{
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","upd_sanctiondetails");
				arrValues.add("N");
				arrValues.add(appno);
				arrValues.add(Facility_sno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		  
			StringBuilder sbAuditTrial=new StringBuilder();
			
				sbAuditTrial.append("~Facility Name = ").append(correctNull((String )hshValues.get("sel_ram_facility1")))
				.append("~Sector Code = ").append(correctNull((String )hshValues.get("txt_sectorcode")))
				.append("~Existing Limit = ").append(correctNull((String )hshValues.get("txt_existing_limit")))
				.append("~Sub Sector Code = ").append(correctNull((String )hshValues.get("txt_subsectorcode")))
				.append("~Proposed Limit = ").append(correctNull((String )hshValues.get("txt_proposed_limit")))
				.append("~Purpose Of Advance = ").append(correctNull((String )hshValues.get("txt_purposeofadvance")))
				.append("~Operation Mode = ").append(correctNull((String )hshValues.get("txt_operationmode")))
				.append("~Nature Of Advance = ").append(ApplicantParams.getApplicantParams("SanctionNatureOfAdvance",correctNull((String )hshValues.get("sel_natureof_advance"))))
				.append("~Sanctioned Loan Amount  = ").append(correctNull((String )hshValues.get("txt_sanctioned_amt")))
				.append("~Sanction Level = ").append(correctNull((String )hshValues.get("sel_sanctionlevel1")))
				.append("~Rate of Interest = ").append(correctNull((String )hshValues.get("txt_interest_rate")))
				.append("~Sanction Authority = ").append(correctNull((String )hshValues.get("sel_sanctionauthority1")))
				.append("~Modified Rate of Interest = ").append(correctNull((String )hshValues.get("txt_mod_interestrate")))
				.append("~Sanction Ref.No = ").append(correctNull((String )hshValues.get("txt_sanction_refno")))
				.append("~Tax Slab = ").append(correctNull((String )hshValues.get("txt_taxslab")))
				.append("~Payment Method = ").append(ApplicantParams.getApplicantParams("SanctionModOfPayment",correctNull((String )hshValues.get("selmodepayment"))))
				.append("~No Of Flows = ").append(correctNull((String )hshValues.get("txt_flows")))
				.append("~Operating A/C No = ").append(correctNull((String )hshValues.get("txt_operativeaccno")))
				.append("~Loan Frequency = ").append(ApplicantParams.getApplicantParams("RepaymentCorporate",correctNull((String )hshValues.get("sel_loan_frequency"))))
				.append("~Loan period Months = ").append(correctNull((String )hshValues.get("txt_loanperiod")))
				.append("~Free Text 7 = ").append(correctNull((String )hshValues.get("txt_freetext7")));
			
			if(!strCheck.equalsIgnoreCase("reject"))
			{
				hshValues.put("hidAction","Approve");
			}
			AuditTrial.auditLog(hshValues,"203",appno,sbAuditTrial.toString());
			
		}
		catch(Exception ce)
		{
			throw new EJBException("inside updateCorporateSanctionDetails"+ce.toString());
		}finally
		{
			try
			{
				if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection in updateCorporateSanctionDetails"+cf.getMessage());
			}
			
		}
	}
	public HashMap getSearch(HashMap hshValues) 
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strCustPannoCheck=null;
		ArrayList arrCol = new ArrayList();
		ArrayList arrValue = new ArrayList();
		String strsearch="",strtype="",strcode="";
		try
		{
			strcode=Helper.correctNull((String)hshValues.get("id"));
			strsearch=Helper.correctNull((String)hshValues.get("txt_codename"));
			strtype=Helper.correctNull((String)hshValues.get("cat"));
			strCustPannoCheck=Helper.correctNull((String)hshValues.get("pannocheck"));
			
			
			if(strtype.equalsIgnoreCase("1"))
			{
				rs = DBUtils.executeLAPSQuery("sel_searchbycode^"+strcode+"^"+strsearch);
			}
			else if(strtype.equalsIgnoreCase("2"))
			{
				rs = DBUtils.executeLAPSQuery("sel_searchbyname^"+strcode+"^"+strsearch);
			}
			else if(strCustPannoCheck.trim().equalsIgnoreCase("NOPAN") && strcode.equals("25"))//customer haven't panno
			{
				rs = DBUtils.executeLAPSQuery("selstaticdatanew_custpanno_check^"+strcode);
			}
			else 
			{
				rs = DBUtils.executeLAPSQuery("selstaticdatanew^"+strcode);
			}
				
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull((String)rs.getString("stat_data_sno")));
				arrCol.add(correctNull((String)rs.getString("stat_data_desc")));
				arrCol.add(correctNull((String)rs.getString("stat_data_desc1")));
				arrValue.add(arrCol);
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
	public  HashMap getTertiarySanctionDetails(HashMap hshValues) 
	{
 		String strQuery="";
 		String strAppStatus="";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String checkData="NO";
		String appno=correctNull((String)hshValues.get("com_appno"));
		
		if(appno.equalsIgnoreCase(""))
		{
			appno=correctNull((String)hshValues.get("appno"));
		}
		
		String facility_sno = correctNull((String)hshValues.get("sel_ram_facility"));		
		
		
		try
		{			
			
			if(rs != null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_tersanction_details^"+appno+"^"+facility_sno);
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{
				hshRecord.put("facility_rating",correctNull((String)rs.getString("ram_rating")));
				hshRecord.put("facility_existing",correctNull((String)rs.getString("existing_limit")));
				hshRecord.put("facility_proposed",correctNull((String)rs.getString("proposed_limit")));
				hshRecord.put("requested_amt",correctNull((String)rs.getString("requested_amt")));				
				hshRecord.put("facility_sancamt",correctNull((String)rs.getString("sanctioned_amt")));
				
				hshRecord.put("facility_interestrate",correctNull((String)rs.getString("ram_interest")));		
				hshRecord.put("facility_sancinterest",correctNull((String)rs.getString("sanctioned_interest")));				
				hshRecord.put("start_date",correctNull((String)rs.getString("start_date")));
				hshRecord.put("cbs_taxslab",correctNull((String)rs.getString("cbs_taxslab1")));
				hshRecord.put("sel_taxslab",correctNull((String)rs.getString("cbs_taxslab")));
				hshRecord.put("cbs_noofflows",correctNull((String)rs.getString("cbs_noofflows")));				
				hshRecord.put("cbs_loan_frequency",correctNull((String)rs.getString("cbs_loan_frequency")));		
				hshRecord.put("cbs_loan_period",correctNull((String)rs.getString("cbs_loan_period")));		
				hshRecord.put("cbs_sector_code",correctNull((String)rs.getString("cbs_sector_code1")));				
				hshRecord.put("sel_sector_code",correctNull((String)rs.getString("cbs_sector_code")));
				hshRecord.put("cbs_subsector_code",correctNull((String)rs.getString("cbs_subsector_code1")));
				hshRecord.put("sel_subsector_code",correctNull((String)rs.getString("cbs_subsector_code")));
				hshRecord.put("cbs_purposeof_advance",correctNull((String)rs.getString("cbs_purposeof_advance1")));				
				hshRecord.put("sel_purposeof_advance",correctNull((String)rs.getString("cbs_purposeof_advance")));
				hshRecord.put("cbs_operation_mode",correctNull((String)rs.getString("cbs_operation_mode1")));		
				hshRecord.put("sel_operation_mode",correctNull((String)rs.getString("cbs_operation_mode")));
				hshRecord.put("cbs_natureof_advance",correctNull((String)rs.getString("cbs_natureof_advance")));		
				hshRecord.put("cbs_sanction_level",correctNull((String)rs.getString("cbs_sanction_level")));				
				hshRecord.put("cbs_sanction_authority",correctNull((String)rs.getString("cbs_sanction_authority")));
				hshRecord.put("cbs_sanction_refno",correctNull((String)rs.getString("cbs_sanction_refno")));
				hshRecord.put("cbs_payment_method",correctNull((String)rs.getString("cbs_payment_method")));				
				hshRecord.put("cbs_operating_accno",correctNull((String)rs.getString("cbs_operating_accno")));
				hshRecord.put("FreeText7",correctNull((String)rs.getString("FreeText7")));
				hshRecord.put("scheme_code",correctNull((String)rs.getString("scheme_code")));
				hshRecord.put("borrowercat",correctNull((String)rs.getString("cbs_borrowercat")));
				hshRecord.put("advtype",correctNull((String)rs.getString("cbs_advtype")));
				hshRecord.put("advmode",correctNull((String)rs.getString("cbs_advmode")));
				hshRecord.put("indtype",correctNull((String)rs.getString("cbs_indtype")));
				hshRecord.put("app_check",correctNull((String)rs.getString("facility_stat_flag")));
				hshRecord.put("customertype", Helper.correctNull((String) rs.getString("cbs_cust_type")));
				hshRecord.put("customertypedesc", Helper.correctNull((String) rs.getString("cbs_cust_typedesc")));
				hshRecord.put("healthcode", Helper.correctNull((String) rs.getString("cbs_health_code")));
				hshRecord.put("healthcodedesc", Helper.correctNull((String) rs.getString("cbs_health_codedesc")));
				hshRecord.put("freecode7", Helper.correctNull((String) rs.getString("cbs_freecode7")));
				hshRecord.put("freecode7desc", Helper.correctNull((String) rs.getString("cbs_freecode7desc")));
				checkData="YES";
			}
			else
			{
				checkData="NO";
				
				if(rs != null)
				{
					rs.close();
				}
				
				strQuery = SQLParser.getSqlQuery("sel_facility_details^"+appno+"^"+facility_sno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("facility_existing",correctNull((String)rs.getString("facility_existing")));
					hshRecord.put("facility_proposed",correctNull((String)rs.getString("facility_proposed")));
					hshRecord.put("facility_sancamt",correctNull((String)rs.getString("facility_sancamt")));
					hshRecord.put("facility_sancinterest",correctNull((String)rs.getString("facility_sancinterest")));

					hshRecord.put("requested_amt",correctNull((String)rs.getString("requested_amt")));
					hshRecord.put("facility_interestrate",correctNull((String)rs.getString("facility_interest")));
					hshRecord.put("cbs_sanction_refno",appno);
				}
				
				hshRecord.put("cbs_loan_frequency","0");	
				hshRecord.put("cbs_natureof_advance","0");		
				hshRecord.put("cbs_sanction_level","0");				
				hshRecord.put("cbs_sanction_authority","0");
				hshRecord.put("cbs_payment_method","0");	
				hshRecord.put("borrowercat","s");	
				hshRecord.put("advmode","s");	
				hshRecord.put("advtype","s");	
				hshRecord.put("indtype","s");	
				
			}
			
			hshRecord.put("Flag","1");
			hshRecord.put("facility_id",facility_sno);
			hshRecord.put("com_appno",appno);
			hshRecord.put("SENT_FLAG","false");
			hshRecord.put("checkData",checkData);
			
			if(rs!=null)
				rs.close();	
				
	     		rs=DBUtils.executeLAPSQuery("commworkflowsel2^"+appno);
				if(rs.next())
				{
					strAppStatus=rs.getString(1);
				}
				hshRecord.put("appstatus",strAppStatus);
				
			if (rs != null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("comfunsel4^" + appno+"^"+"N");
			if (rs.next()) {
				String strPanno = Helper.correctNull((String)rs.getString("perapp_panno"));
				
				if(strPanno.trim().equalsIgnoreCase("NOPAN"))
					hshRecord.put("hidtaxslab",strPanno);
					
			}			
				
				
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getCorporateSanctionDetails"+ce.toString());
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
				throw new EJBException("Error closing the connection in getCorporateSanctionDetails "+cf.getMessage());
			}
		}
		return hshRecord;
	}	
	private HashMap getFacilitysno(HashMap hshMap)
	{
		
		String strAppno="";
		String strFacilitysno="";
		String strQuery="";
		ResultSet rs=null;
		HashMap hshRecord=new HashMap();
		try{
			strAppno=correctNull((String)hshMap.get("appno"));
			strFacilitysno=correctNull((String)hshMap.get("facsno"));
			strQuery=SQLParser.getSqlQuery("getfacdetforsanction^"+strAppno+"^"+strFacilitysno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("strFacId",correctNull(rs.getString("facility_id")));
				hshRecord.put("strCbsaccno",correctNull(rs.getString("cbs_accountno")));
			}
			
		}catch(Exception ex)
		{
			throw new EJBException(ex.toString());
		}
		return hshRecord;
	}
}