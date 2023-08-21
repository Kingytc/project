package com.sai.laps.ejb.perpropertydetails;

import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.ArrayList;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.jms.Session;

import com.sai.laps.helper.SAILogger;

import org.apache.log4j.Logger;
import org.omg.PortableServer.ServantLocatorPOA;

import com.sai.laps.ejb.agrotherassets.agrotherBean;
import com.sai.laps.ejb.perapplicant.PerApplicantBean;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.helper.SetupParams;
import com.sai.laps.securitymaster.SecurityMasterBean;

@Stateless(name = "PropertyDetailsBean", mappedName = "PropertyDetailsHome")
@Remote (PropertyDetailsRemote.class)
public class PropertyDetailsBean extends BeanAdapter
{	
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(PropertyDetailsBean.class);

	public HashMap getData(HashMap hshValues) 
	{
		String strQuery1 = "";		 
		ResultSet rs = null;
		ResultSet rs1 = null;		 
		HashMap hshResult = new HashMap();
		String strApplicationNo = correctNull((String)hshValues.get("appno"));
		String strOrgcode = correctNull((String)hshValues.get("strOrgCode"));
		String codeno = correctNull((String)hshValues.get("txt_coopcode"));
		String recordflag="N";
		if(codeno.equalsIgnoreCase(""))
		{
			codeno="0";
		}
		try 
		{ 
			rs=DBUtils.executeLAPSQuery("propdetailsel^"+ strApplicationNo);			 
			while (rs.next()) 
			{
				hshResult.put("prop_appid",correctNull(rs.getString("prop_appid")));
				hshResult.put("prop_houseno",correctNull(rs.getString("prop_houseno")));
				hshResult.put("prop_area",correctNull(rs.getString("prop_area")));
				hshResult.put("hidcity",correctNull(rs.getString("prop_city")));
				hshResult.put("hidstate",correctNull(rs.getString("prop_state")));
				hshResult.put("prop_city",correctNull(rs.getString("city_name")));
				hshResult.put("prop_state",correctNull(rs.getString("state_name")));
				hshResult.put("prop_pin",correctNull(rs.getString("prop_pin")));
				hshResult.put("prop_builtup",correctNull(rs.getString("prop_builtup")));
				hshResult.put("prop_housingaddress",correctNull(rs.getString("prop_housingaddress")));
				String  Buildercode=correctNull(rs.getString("prop_housingaddress"));
				
				if(!Buildercode.equalsIgnoreCase(""))
				{																																																																			
					strQuery1 = SQLParser.getSqlQuery("sel_perpropertybuildername^"+strOrgcode+"^"+Buildercode+"^"+Buildercode+"^"+strApplicationNo);
					rs1=DBUtils.executeQuery(strQuery1);
					
					if(rs1.next())
					{
						hshResult.put("builder_name",correctNull(rs1.getString("builder_name")));
					}
					else
					{
						hshResult.put("builder_name","");
					}						
					if(rs1!=null)
					{
						rs1.close();
					}
				}
				else
				{
					hshResult.put("builder_name","");
				}		
				hshResult.put("prop_allotted",correctNull(rs.getString("prop_allotted")));
				hshResult.put("prop_unexpiredlease",correctNull(rs.getString("prop_unexpiredlease")));
				hshResult.put("prop_purpose",correctNull(rs.getString("prop_purpose")));
				hshResult.put("prop_costofland",correctNull(rs.getString("prop_costofland")));
				hshResult.put("prop_amountinvested",correctNull(rs.getString("prop_amountinvested")));
				hshResult.put("prop_costofconstruct",correctNull(rs.getString("prop_costofconstruct")));
				hshResult.put("prop_savingbank",correctNull(rs.getString("prop_savingbank")));
				hshResult.put("prop_costofamenties",correctNull(rs.getString("prop_costofamenties")));
				hshResult.put("prop_disposal",correctNull(rs.getString("prop_disposal")));
				hshResult.put("prop_costrepair",correctNull(rs.getString("prop_costrepair")));
				hshResult.put("prop_pfrefundable",correctNull(rs.getString("prop_pfrefundable")));
				hshResult.put("prop_pfnonrefundable",correctNull(rs.getString("prop_pfnonrefundable")));
				hshResult.put("prop_costofflat",correctNull(rs.getString("prop_costofflat")));
				hshResult.put("prop_otherspy",correctNull(rs.getString("prop_otherspy")));
				hshResult.put("prop_otheramt",correctNull(rs.getString("prop_otheramt")));
				hshResult.put("prop_otherspy1",correctNull(rs.getString("prop_otherspy1")));
				hshResult.put("prop_otheramt1",correctNull(rs.getString("prop_otheramt1")));
				hshResult.put("prop_otherspy2",correctNull(rs.getString("prop_otherspy2")));
				hshResult.put("prop_otheramt2",correctNull(rs.getString("prop_otheramt2")));
				hshResult.put("prop_stampduty",correctNull(rs.getString("prop_stampduty")));
				hshResult.put("prop_loanappliedfor",correctNull(rs.getString("prop_loanappliedfor")));
				hshResult.put("prop_totalcost",correctNull(rs.getString("prop_totalcost")));
				hshResult.put("prop_totalfund",correctNull(rs.getString("prop_totalfund")));
				hshResult.put("prop_loanrepayment",correctNull(rs.getString("prop_loanrepayment")));
				hshResult.put("prop_areaofplot",correctNull(rs.getString("prop_areaofplot")));
				hshResult.put("prop_proposedbuildup",correctNull(rs.getString("prop_proposedbuildup")));
				hshResult.put("prop_purchaseprice",correctNull(rs.getString("prop_purchaseprice")));
				hshResult.put("prop_Architectfee",correctNull(rs.getString("prop_Architectfee")));
				hshResult.put("prop_costofconstloan",correctNull(rs.getString("prop_costofconstloan")));
				hshResult.put("prop_areaundivided",correctNull(rs.getString("prop_areaundivided")));
				hshResult.put("prop_costundivided",correctNull(rs.getString("prop_costundivided")));
				hshResult.put("prop_semifinished",correctNull(rs.getString("prop_semifinished")));
				hshResult.put("prop_costofcomplete",correctNull(rs.getString("prop_costofcomplete")));
				hshResult.put("prop_registration",correctNull(rs.getString("prop_registration")));
				hshResult.put("prop_totalcostloan",correctNull(rs.getString("prop_totalcostloan")));
				hshResult.put("prop_marketval",correctNull(rs.getString("prop_marketval")));
				hshResult.put("prop_type",correctNull(rs.getString("prop_type")));
				hshResult.put("prop_age",correctNull(rs.getString("prop_age")));
				hshResult.put("prop_structureval",correctNull(rs.getString("prop_structureval")));
				hshResult.put("prop_mortgage",correctNull(rs.getString("prop_mortgage")));
				hshResult.put("prop_institutename",correctNull(rs.getString("prop_institutename")));
				String institutename=correctNull(rs.getString("prop_institutename"));
				if(!institutename.equalsIgnoreCase(""))
				{		
					strQuery1="";
					strQuery1 = SQLParser.getSqlQuery("sel_perpropertycoopHousingname^"+strOrgcode+"^"+institutename+"^"+institutename+"^"+strApplicationNo);
					rs1=DBUtils.executeQuery(strQuery1);
					
					if(rs1.next())
					{
						hshResult.put("coopsoc_name",correctNull(rs1.getString("coopsoc_name")));
					}
					else
					{
						hshResult.put("coopsoc_name","");
					}						
					if(rs1!=null)
					{
						rs1.close();
					}
				}
				else
				{
					hshResult.put("coopsoc_name","");
				}
				hshResult.put("prop_outstandingloan",correctNull(rs.getString("prop_outstandingloan")));
				hshResult.put("prop_repairdetails",correctNull(rs.getString("prop_repairdetails")));
				hshResult.put("prop_housetype",correctNull(rs.getString("prop_housetype")));
				hshResult.put("prop_mar_land",correctNull(rs.getString("prop_mar_land")));
				hshResult.put("prop_mar_build",correctNull(rs.getString("prop_mar_build")));
				String prop_lease_expdate=correctNull(rs.getString("prop_lease_expdate"));
				if(prop_lease_expdate.equalsIgnoreCase("01/01/1900"))
				{
					prop_lease_expdate ="";
				}
				else
				{
					hshResult.put("prop_lease_expdate",correctNull(rs.getString("prop_lease_expdate")));
				}				
				String agree_Date=correctNull(rs.getString("prop_agree_date"));
				if(agree_Date.equalsIgnoreCase("01/01/1900"))
				{
					agree_Date ="";
				}
				else
				{
					hshResult.put("prop_agree_date",correctNull(rs.getString("prop_agree_date")));
				}				
				hshResult.put("prop_agree_no",correctNull(rs.getString("prop_agree_no")));
				hshResult.put("prop_own_status",correctNull(rs.getString("prop_own_status")));
				hshResult.put("prop_dwelling_unit",correctNull(rs.getString("prop_dwelling_unit")));
				hshResult.put("prop_house_rent",correctNull(rs.getString("prop_house_rent")));
				hshResult.put("prop_exp_rent",correctNull(rs.getString("prop_exp_rent")));
				hshResult.put("prop_proj_details",correctNull(rs.getString("prop_proj_details")));
				hshResult.put("prop_spy2",correctNull(rs.getString("prop_spy2")));
				hshResult.put("prop_sellername",correctNull(rs.getString("prop_sellername")));
				hshResult.put("prop_sell_add",correctNull(rs.getString("prop_sell_add")));
				hshResult.put("prop_completion",correctNull(rs.getString("prop_completion")));
				String issu_Date=correctNull(rs.getString("prop_occucerti_issue"));
				if(issu_Date.equalsIgnoreCase("01/01/1900"))
				{
					issu_Date ="";
				}
				else
				{
					hshResult.put("prop_occucerti_issue",correctNull(rs.getString("prop_occucerti_issue")));
				}
				hshResult.put("propertytype2",correctNull(rs.getString("prop_type1")));
				hshResult.put("qualityconst",correctNull(rs.getString("prop_quality")));
				hshResult.put("presenceamenities",correctNull(rs.getString("prop_amenity")));
				hshResult.put("marketability",correctNull(rs.getString("prop_market")));
				hshResult.put("prop_cost",correctNull(rs.getString("prop_cost")));
				hshResult.put("prop_constr",correctNull(rs.getString("prop_constr")));
				hshResult.put("prop_floorno",correctNull(rs.getString("prop_floorno")));				
				hshResult.put("prop_location1",correctNull(rs.getString("prop_location1")));
				hshResult.put("prop_location2",correctNull(rs.getString("prop_location2")));
				hshResult.put("prop_location3",correctNull(rs.getString("prop_location3")));
				hshResult.put("prop_location4",correctNull(rs.getString("prop_location4")));
				hshResult.put("prop_amenities1",correctNull(rs.getString("prop_amenities1")));
				hshResult.put("prop_amenities2",correctNull(rs.getString("prop_amenities2")));
				hshResult.put("prop_amenities3",correctNull(rs.getString("prop_amenities3")));
				hshResult.put("prop_amenities4",correctNull(rs.getString("prop_amenities4")));
				// added by Naresh
				hshResult.put("prop_charges",correctNull(rs.getString("prop_charges")));
				hshResult.put("prop_nature",correctNull(rs.getString("prop_nature")));
				hshResult.put("prop_first_mortgage",correctNull(rs.getString("prop_first_mortgage")));
				hshResult.put("prop_intermsecurity",correctNull(rs.getString("prop_intermsecurity")));
				// end
				
				hshResult.put("prop_estimatecost",correctNull(rs.getString("prop_estimatecost")));
				hshResult.put("prop_chargesany",correctNull(rs.getString("prop_chargesany")));
				hshResult.put("prop_municipalupto",correctNull(rs.getString("prop_municipalupto")));
				hshResult.put("prop_waterdate",correctNull(rs.getString("prop_waterdate")));
				hshResult.put("prop_societypermission",correctNull(rs.getString("prop_societypermission")));
				hshResult.put("prop_liensociety",correctNull(rs.getString("prop_liensociety")));
				hshResult.put("prop_outstandingsociety",correctNull(rs.getString("prop_outstandingsociety")));
				hshResult.put("prop_costofconstruction",correctNull(rs.getString("prop_costofconstruction")));
				recordflag="Y";
				
				hshResult.put("prop_plotprice",correctNull(rs.getString("prop_plotprice")));
			}
			hshResult.put("recordflag",recordflag);
		} 
		catch (Exception ce) 
		{
			throw new EJBException("Error in closing getData" + ce.getMessage());
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
			catch (Exception e) 
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshResult;
	}

	public  HashMap getdisbursementdetails(HashMap hshValues) 
	{ 
		ResultSet rs = null;
		ResultSet rs1=null;
		HashMap hshRecord = new HashMap();
		String appno   = "";
		appno = correctNull((String) hshValues.get("appno"));
		boolean recordflag=false;
		try
		{	
			rs1=DBUtils.executeLAPSQuery("get_Sancamount^"+appno);
			if(rs1.next())
			{
				hshRecord.put("sanction_amount",correctNull(rs1.getString("sanction_amount")));
			}
			if(rs1!=null)rs1.close();
			
			rs1=DBUtils.executeLAPSQuery("get_Appstatus^"+appno);
			if(rs1.next())
			{
				hshRecord.put("app_status",correctNull(rs1.getString("app_status")));
				hshRecord.put("sanction_date",correctNull(rs1.getString("app_processdate")));
			}
			
			/*Commented by Arsath for Performance Tuning
			 * sanction date included in previous query & query also removed from sql.xml
			 */
			//if(rs1!=null)rs1.close();

			//rs1=DBUtils.executeLAPSQuery("get_SanctionDate^"+appno);
			//while(rs1.next())
			//{
			//	hshRecord.put("sanction_date",correctNull(rs1.getString("app_processdate")));
			//}//
			if(rs1!=null)rs1.close();
			
			rs=DBUtils.executeLAPSQuery("selectdisbursemnet^"+appno);			 
			

			while(rs.next())
			{	
				hshRecord.put("stage1amt",correctNull(rs.getString("stage1amt")));
				hshRecord.put("stage1dt",correctNull(rs.getString("stage1dt")));
				hshRecord.put("stage2amt",correctNull(rs.getString("stage2amt")));
				hshRecord.put("stage2dt",correctNull(rs.getString("stage2dt")));
				hshRecord.put("stage3amt",correctNull(rs.getString("stage3amt")));
				hshRecord.put("stage3dt",correctNull(rs.getString("stage3dt")));
				hshRecord.put("totalamt",correctNull(rs.getString("totalamt")));
				hshRecord.put("totaldt",correctNull(rs.getString("totaldt")));				
				hshRecord.put("stage4amt",correctNull(rs.getString("stage4amt")));
				hshRecord.put("stage4dt",correctNull(rs.getString("stage4dt")));					
				hshRecord.put("stage5amt",correctNull(rs.getString("stage5amt")));
				hshRecord.put("stage5dt",correctNull(rs.getString("stage5dt")));
				recordflag=true;
			}
			if(recordflag) //for audit trail
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error  in getdisbursementdetails "+ce.toString());
		}
		finally
		{
			try
			{				
				if(rs != null)
				{
					rs.close();
				} 
				if (rs1 != null) 
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
	
	public  HashMap getotherinfodetails(HashMap hshValues) 
	{ 
		ResultSet rs = null;
		HashMap hshRecord = null;
		HashMap hshRecords = null;
		String appno   = "";
		appno = correctNull((String) hshValues.get("appno"));
	
		try
		{ 
			rs=DBUtils.executeLAPSQuery("selpropotherinfo^"+appno);			 
			hshRecord = new HashMap();
			hshRecords = new HashMap();
			while(rs.next())
			{	
				hshRecord.put("other1",correctNull(rs.getString("other1")));
				hshRecord.put("other2",correctNull(rs.getString("other2")));
				hshRecord.put("other3",correctNull(rs.getString("other3")));
				hshRecord.put("other4",correctNull(rs.getString("other4")));
				hshRecord.put("other5",correctNull(rs.getString("other5")));
				hshRecord.put("other6",correctNull(rs.getString("other6")));
				hshRecord.put("other7",correctNull(rs.getString("other7")));
				hshRecord.put("other8",correctNull(rs.getString("other8")));
				hshRecord.put("other9",correctNull(rs.getString("other9")));					
			}		
			rs=DBUtils.executeLAPSQuery("selpurpose^"+appno);
			while(rs.next())
			{	
				hshRecord.put("status",correctNull(rs.getString(1)));
			}
			hshRecords.put("hshRecord",hshRecord);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error  in getdisbursementdetails "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs!= null)
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

	public void updateDataDisbursement(HashMap hshValues) 
	{ 
		ResultSet rs=null;		
		HashMap hshQueryValues=new HashMap();		
		HashMap hshQuery=null;
		ArrayList arrValues=null;
		String strAction=(String)hshValues.get("hidAction");
		String appno	  = "";
		appno = correctNull((String) hshValues.get("appno"));
		String strAppno="";
		StringBuilder sbAuditTrial=new StringBuilder();
		StringBuilder sboldAudit = new StringBuilder();
		
		try
		{				
			if(!appno.equalsIgnoreCase(""))
			{
				String strQuery = SQLParser.getSqlQuery("selectdisbursemnet^" + appno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
				String strstage1amtoldaudit=Helper.correctNull(rs.getString("stage1amt"));
				String strstage1dtoldaudit=Helper.correctNull(rs.getString("stage1dt"));
				String strstage2amtoldaudit=Helper.correctNull(rs.getString("stage2amt"));
				String strstage2dtoldaudit=Helper.correctNull(rs.getString("stage2dt"));
				String strstage3amtoldaudit=Helper.correctNull(rs.getString("stage3amt"));
				String strstage3dtoldaudit=Helper.correctNull(rs.getString("stage3dt"));				
				String strstage4amtoldaudit=Helper.correctNull(rs.getString("stage4amt"));
				String strstage4dtoldaudit=Helper.correctNull(rs.getString("stage4dt"));					
				String strstage5amtoldaudit=Helper.correctNull(rs.getString("stage5amt"));
				String strstage5dtoldaudit=Helper.correctNull(rs.getString("stage5dt"));
				String stroldaudit=Helper.correctNull(rs.getString("totalamt"));

				sboldAudit.append("~First Stage Disbursed Amount= =").append(strstage1amtoldaudit)
				.append("~Disbursed On =").append(strstage1dtoldaudit)
				.append("~Second stage Disbursed Amount =").append(strstage2amtoldaudit)
				.append("~Disbursed On =").append(strstage2dtoldaudit)
				.append("~Third stage Disbursed Amount =").append(strstage3amtoldaudit)
				.append("~Disbursed On =").append(strstage3dtoldaudit)
				.append("~Fourth stage Disbursed Amount =").append(strstage4amtoldaudit)
				.append("~Disbursed On =").append(strstage4dtoldaudit)
				.append("~Fifth stage Disbursed Amount =").append(strstage5amtoldaudit)
				.append("~Disbursed On =").append(strstage5dtoldaudit)
				.append("~Total =").append(stroldaudit);
				}
				if(rs!=null)
				{
					rs.close();
				}
			}
			if(strAction.equalsIgnoreCase("update"))
			{
				String stage1amt= correctNull((String)hshValues.get("stage1amt"));
				if( stage1amt.equals(""))
				{
					stage1amt="0.00";
				}
				String stage2amt=correctNull((String)hshValues.get("stage2amt"));
				if(stage2amt.equals(""))
				{
					stage2amt="0.00";
				}
				String stage3amt=correctNull((String)hshValues.get("stage3amt"));
				if(stage3amt.equals(""))
				{
					stage3amt="0.00";
				}
				String stage4amt=correctNull((String)hshValues.get("stage4amt"));
				if(stage4amt.equals(""))
				{
					stage4amt="0.00";
				}
				String stage5amt=correctNull((String)hshValues.get("stage5amt"));
				if(stage5amt.equals(""))
				{
					stage5amt="0.00";
				}				
				String stage6amt=correctNull((String)hshValues.get("stage6amt"));
				if(stage6amt.equals(""))
				{
					stage6amt="0.00";
				} 
				rs=DBUtils.executeLAPSQuery("countdisbursemnet^"+ appno);
				 
				while(rs.next())
				{
					strAppno= rs.getString(1);										
				}	

				hshQueryValues.put("size","1");
				if(strAppno.equals(""))
				{
					hshQuery=new HashMap();
					hshQuery.put("strQueryId","disbursemnetinsert");
					arrValues=new ArrayList();
					arrValues.add(appno);
					arrValues.add(stage1amt);
					arrValues.add(correctNull((String)hshValues.get("stage1dt")));
					arrValues.add(stage2amt);
					arrValues.add(correctNull((String)hshValues.get("stage2dt")));
					arrValues.add(stage3amt);
					arrValues.add(correctNull((String)hshValues.get("stage3dt")));
					arrValues.add(stage5amt);
					arrValues.add(correctNull((String)hshValues.get("stage5dt")));
					arrValues.add(stage6amt);
					arrValues.add(correctNull((String)hshValues.get("stage6dt")));
					arrValues.add(stage4amt);
					arrValues.add(correctNull((String)hshValues.get("stage4dt")));				
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);													
				}
				else
				{
					hshQuery=new HashMap();
					hshQuery.put("strQueryId","disbursemnetupdate");
					arrValues=new ArrayList();
					arrValues.add(stage1amt);
					arrValues.add(correctNull((String)hshValues.get("stage1dt")));
					arrValues.add(stage2amt);
					arrValues.add(correctNull((String)hshValues.get("stage2dt")));
					arrValues.add(stage3amt);
					arrValues.add(correctNull((String)hshValues.get("stage3dt")));					
					arrValues.add(stage5amt);
					arrValues.add(correctNull((String)hshValues.get("stage5dt")));
					arrValues.add(stage6amt);
					arrValues.add(correctNull((String)hshValues.get("stage6dt")));
					arrValues.add(stage4amt);
					arrValues.add(correctNull((String)hshValues.get("stage4dt")));				
					arrValues.add(appno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
				}				
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{ 
				hshQueryValues.put("size","1");
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","disbursemnetdelete");
				arrValues=new ArrayList();
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);				
			}
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			/** For the purpose of 'Audit Trial' */
			
				sbAuditTrial.append("~First Stage Disbursed Amount=");
				sbAuditTrial.append(correctNull((String)hshValues.get("stage1amt")));
				sbAuditTrial.append("~Disbursed On=");
				sbAuditTrial.append(correctNull((String)hshValues.get("stage1dt")));
				sbAuditTrial.append("~Second Stage Disbursed Amount=");
				sbAuditTrial.append(correctNull((String)hshValues.get("stage2amt")));
				sbAuditTrial.append("~Disbursed On=");
				sbAuditTrial.append(correctNull((String)hshValues.get("stage2dt")));
				sbAuditTrial.append("~Third Stage Disbursed Amount=");
				sbAuditTrial.append(correctNull((String)hshValues.get("stage3amt")));
				sbAuditTrial.append("~Disbursed On=");
				sbAuditTrial.append(correctNull((String)hshValues.get("stage3dt")));
				sbAuditTrial.append("~Fourth Stage Disbursed Amount=");
				sbAuditTrial.append(correctNull((String)hshValues.get("stage5amt")));
				sbAuditTrial.append("~Disbursed On=");
				sbAuditTrial.append(correctNull((String)hshValues.get("stage5dt")));
				sbAuditTrial.append("~Fifth Stage Disbursed Amount=");
				sbAuditTrial.append(correctNull((String)hshValues.get("stage6amt")));
				sbAuditTrial.append("~Disbursed On=");
				sbAuditTrial.append(correctNull((String)hshValues.get("stage6dt")));
				sbAuditTrial.append("~Total=");
				sbAuditTrial.append(correctNull((String)hshValues.get("stage4amt")));
				if(correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("N"))
				{
					hshValues.put("hidAction", "insert");
				}
				AuditTrial.auditNewLog(hshValues,"244",appno,sbAuditTrial.toString(),sboldAudit.toString());
			
			/** End */
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateData "+ce.toString());
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
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
	}
	
	public void updateData(HashMap hshValues) 
	{	
		ArrayList arrValues = new ArrayList();
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		String strAppno=correctNull((String)hshValues.get("appno"));
		String strAction="";
		try
		{	
			strAction  = correctNull((String)hshValues.get("hidAction"));
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","propdetaildel");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
	
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(correctNull((String) hshValues.get("prop_houseno")));
				arrValues.add(correctNull((String) hshValues.get("prop_area")));
				arrValues.add(correctNull((String) hshValues.get("hidcity")));
				arrValues.add(correctNull((String) hshValues.get("hidstate")));
				arrValues.add(correctNull((String) hshValues.get("prop_pin")));
				arrValues.add(correctNull((String) hshValues.get("prop_builtup")));
				arrValues.add(correctNull((String) hshValues.get("txt_buildercode")));
				arrValues.add(correctNull((String) hshValues.get("prop_allotted")));
				arrValues.add(correctNull((String) hshValues.get("prop_unexpiredlease")));
				arrValues.add(correctNull((String) hshValues.get("prop_purpose")));
				arrValues.add(correctNull((String) hshValues.get("txtcostofland")));
				arrValues.add(correctNull((String) hshValues.get("prop_amountinvested")));
				arrValues.add(correctNull((String) hshValues.get("prop_costofconstruct")));
				arrValues.add(correctNull((String) hshValues.get("prop_savingbank")));
				arrValues.add(correctNull((String) hshValues.get("prop_costofamenties")));
				arrValues.add(correctNull((String) hshValues.get("prop_disposal")));
				arrValues.add(correctNull((String) hshValues.get("prop_costrepair")));
				arrValues.add(correctNull((String) hshValues.get("prop_pfrefundable")));
				arrValues.add(correctNull((String) hshValues.get("prop_pfnonrefundable")));
				arrValues.add(correctNull((String) hshValues.get("prop_costofflat")));
				arrValues.add(correctNull((String) hshValues.get("prop_otherspy")));
				arrValues.add(correctNull((String) hshValues.get("prop_otheramt")));
				arrValues.add(correctNull((String) hshValues.get("prop_stampduty")));
				arrValues.add(correctNull((String) hshValues.get("prop_loanappliedfor")));
			
				String totalcost = correctNull((String) hshValues.get("prop_totalcost"));
				if(totalcost.equalsIgnoreCase(""))
				{
					totalcost = "0";
				}
				arrValues.add(totalcost);
				String totalfund = correctNull((String) hshValues.get("prop_totalfund"));
				if(totalcost.equalsIgnoreCase(""))
				{
					totalfund = "0";
				}
				arrValues.add(totalfund);
				arrValues.add(correctNull((String) hshValues.get("prop_loanrepayment")));
				arrValues.add(correctNull((String) hshValues.get("prop_areaofplot")));
				arrValues.add(correctNull((String) hshValues.get("prop_proposedbuildup")));
				arrValues.add(correctNull((String) hshValues.get("prop_purchaseprice")));
				arrValues.add(correctNull((String) hshValues.get("prop_Architectfee")));
				arrValues.add(correctNull((String) hshValues.get("prop_costofconstloan")));
				arrValues.add(correctNull((String) hshValues.get("prop_areaundivided")));
				arrValues.add(correctNull((String) hshValues.get("prop_costundivided")));
				arrValues.add(correctNull((String) hshValues.get("prop_semifinished")));
				arrValues.add(correctNull((String) hshValues.get("prop_costofcomplete")));
				arrValues.add(correctNull((String) hshValues.get("prop_registration")));
				arrValues.add(correctNull((String) hshValues.get("prop_totalcostloan")));
				arrValues.add(correctNull((String) hshValues.get("prop_marketval")));
				arrValues.add(correctNull((String) hshValues.get("prop_type")));
				arrValues.add(correctNull((String) hshValues.get("prop_age")));
				arrValues.add(correctNull((String) hshValues.get("prop_structureval")));
				arrValues.add(correctNull((String) hshValues.get("prop_mortgage")));
				arrValues.add(correctNull((String) hshValues.get("txt_coopcode")));
				arrValues.add(correctNull((String) hshValues.get("prop_outstandingloan")));
				arrValues.add(correctNull((String) hshValues.get("prop_repairdetails")));
				arrValues.add(correctNull((String) hshValues.get("propertytype1")));
				arrValues.add(correctNull((String) hshValues.get("prop_otherspy1")));
				arrValues.add(correctNull((String) hshValues.get("prop_otheramt1")));
				arrValues.add(correctNull((String) hshValues.get("prop_otherspy2")));
				arrValues.add(correctNull((String) hshValues.get("prop_otheramt2")));
				 
				String prop_mar_land=correctNull((String) hshValues.get("prop_mar_land"));
				if(prop_mar_land.equalsIgnoreCase(""))
				{
					prop_mar_land="0";
				}
				arrValues.add(prop_mar_land);
				String prop_mar_build=correctNull((String) hshValues.get("prop_mar_build"));
				if(prop_mar_build.equalsIgnoreCase(""))
				{
					prop_mar_build="0";
				}
				arrValues.add(prop_mar_build);
				String prop_lease_expdate=correctNull((String) hshValues.get("prop_lease_expdate"));
				if(prop_lease_expdate.equalsIgnoreCase(""))
				{
					prop_lease_expdate="01/01/1900";
				}
				arrValues.add(prop_lease_expdate);
				String prop_agree_date=correctNull((String) hshValues.get("prop_agree_date"));
				if(prop_agree_date.equalsIgnoreCase(""))
				{
					prop_agree_date="01/01/1900";
				}
				arrValues.add(prop_agree_date);			
				arrValues.add(correctNull((String) hshValues.get("prop_agree_no")));
				arrValues.add(correctNull((String) hshValues.get("sel_own")));
				arrValues.add(correctNull((String) hshValues.get("sel_dwell")));
				String prop_house_rent=correctNull((String) hshValues.get("sel_house"));
				if(prop_house_rent.equalsIgnoreCase(""))
				{
					prop_house_rent="0";
				}
				arrValues.add(prop_house_rent);
				String prop_exp_rent=correctNull((String) hshValues.get("prop_exp_rent"));
				if(prop_exp_rent.equalsIgnoreCase(""))
				{
					prop_exp_rent="0";
				}
				arrValues.add(prop_exp_rent);
				arrValues.add(correctNull((String) hshValues.get("prop_proj_details")));
				arrValues.add(correctNull((String) hshValues.get("prop_spy2")));
				arrValues.add(correctNull((String) hshValues.get("prop_sellername")));
				arrValues.add(correctNull((String) hshValues.get("txt_selleraddress")));
				arrValues.add(correctNull((String) hshValues.get("txt_completion")));
				arrValues.add(correctNull((String) hshValues.get("txt_certificateissu")));
				arrValues.add(correctNull((String) hshValues.get("propertytype2")));
				arrValues.add(correctNull((String) hshValues.get("qualityconst")));
				arrValues.add(correctNull((String) hshValues.get("presenceamenities")));
				arrValues.add(correctNull((String) hshValues.get("marketability")));
				String prop_cost=correctNull((String) hshValues.get("prop_cost"));
				
				if(prop_cost.equalsIgnoreCase(""))
				{
					prop_cost="0";
				}
				arrValues.add(prop_cost);
				arrValues.add(correctNull((String) hshValues.get("prop_construction")));
				arrValues.add(correctNull((String)hshValues.get("prop_floorno")));				
				arrValues.add(correctNull((String)hshValues.get("chk_mainroad")));
				arrValues.add(correctNull((String)hshValues.get("chk_public")));
				arrValues.add(correctNull((String)hshValues.get("chk_eduinstitution")));
				arrValues.add(correctNull((String)hshValues.get("chk_prime")));
				arrValues.add(correctNull((String)hshValues.get("chk_accessible")));
				arrValues.add(correctNull((String)hshValues.get("chk_assured")));
				arrValues.add(correctNull((String)hshValues.get("chk_drainages")));
				arrValues.add(correctNull((String)hshValues.get("chk_currentconnection")));
				arrValues.add(correctNull((String) hshValues.get("txt_prop_charges")));
				arrValues.add(correctNull((String) hshValues.get("sel_nature")));
				arrValues.add(correctNull((String) hshValues.get("firstmortgage")));
				arrValues.add(correctNull((String) hshValues.get("prop_intermsecurity")));
				arrValues.add(correctNull((String)hshValues.get("prop_estimatedprice")));
				arrValues.add(correctNull((String)hshValues.get("txt_prop_charges")));
				arrValues.add(correctNull((String)hshValues.get("txt_municipaldate")));
				arrValues.add(correctNull((String)hshValues.get("txt_waterdate")));
				arrValues.add(correctNull((String)hshValues.get("prop_societypermission")));
				arrValues.add(correctNull((String)hshValues.get("prop_liensociety")));
				arrValues.add(correctNull((String)hshValues.get("prop_outstandingsociety")));
				arrValues.add(correctNull((String)hshValues.get("prop_costofconstruction")));
				arrValues.add(correctNull((String)hshValues.get("prop_plotprice")));				
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "propdetailins");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","propdetaildel");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");  
			}
			/** For the purpose of 'Audit Trial' */
			propAssetAuditTrial(hshValues,strAppno,strAction);
			/** End */
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateData "+ce.toString());
		}
		finally
		{	
			try
			{
				//EJBInvoker.executeStateLess("appeditlock",hshValues,"unLockApplication");
			}
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}
	}

/**
 * Method to accomodate the 'Audit Trial' aspects with respect to 'Proposed Asset - House' page.
 * @author C.Gokulakrishnan 
 * @param hshValues
 * @param strAppno
 * @param strAction
 */
	private void propAssetAuditTrial(HashMap hshValues, String strAppno, String strAction)  {
		StringBuilder sbAuditTrial=new StringBuilder();
		
		try{
			if (strAction.equalsIgnoreCase("insert"))
			{
				sbAuditTrial.append("~Purpose of Loan=");
			if(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("1"))
			{
				sbAuditTrial.append("Purchase of Land & Construction of House");
			}else if(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("2")){
				sbAuditTrial.append("Purchase of Flat");
			}else if(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("3")){
				sbAuditTrial.append("Purchase of ready built House");
			}else if(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("4")){
				sbAuditTrial.append("Foreclosure/takeover from other Bank/Fls");
			}else if(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("5")){
				sbAuditTrial.append("Improvement/Renovation of House/Flat");
			}else if(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("6")){
				sbAuditTrial.append("Construction of House/Flat");
			}else{
				sbAuditTrial.append("Personal needs against mortgage of property");
			}
			//Type of property
			sbAuditTrial.append("~Type of the Property=");
			if(correctNull((String)hshValues.get("propertytype1")).trim().equalsIgnoreCase("Land"))
				sbAuditTrial.append("Land");
			else if(correctNull((String)hshValues.get("propertytype1")).trim().equalsIgnoreCase("Flat"))
				sbAuditTrial.append("Flat / Apartment");
			else if(correctNull((String)hshValues.get("propertytype1")).trim().equalsIgnoreCase("House"))
				sbAuditTrial.append("House / Building");
			else
				sbAuditTrial.append("");
			//Location			
			sbAuditTrial.append("~Location of the Property=");
			if(correctNull((String)hshValues.get("prop_type")).trim().equalsIgnoreCase("1"))
				sbAuditTrial.append("Metro");
			else if(correctNull((String)hshValues.get("prop_type")).trim().equalsIgnoreCase("2"))
				sbAuditTrial.append("Urban");
			else if(correctNull((String)hshValues.get("prop_type")).trim().equalsIgnoreCase("3"))
				sbAuditTrial.append("Semi Urban");
			else if(correctNull((String)hshValues.get("prop_type")).trim().equalsIgnoreCase("4"))
				sbAuditTrial.append("Rural");
			else
				sbAuditTrial.append("");
			if(!(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("2")))
			{
				sbAuditTrial.append("~Area of Plot=");
				sbAuditTrial.append(correctNull((String)hshValues.get("prop_areaofplot")));
			}
			sbAuditTrial.append("~Survey No=");
			sbAuditTrial.append(correctNull((String)hshValues.get("prop_builtup")));
			if(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("1"))
			{
				sbAuditTrial.append("~Proposed Built up area=");
				sbAuditTrial.append(correctNull((String)hshValues.get("prop_proposedbuildup")));
			}
			else
			{
				sbAuditTrial.append("~Built up area=");
				sbAuditTrial.append(correctNull((String)hshValues.get("prop_proposedbuildup")));
			}
			sbAuditTrial.append("~Khata No=");
			sbAuditTrial.append(correctNull((String)hshValues.get("prop_totalcostloan")));
			sbAuditTrial.append("~Ownership Status=");
			if(correctNull((String)hshValues.get("sel_own")).trim().equalsIgnoreCase("1"))
				sbAuditTrial.append("Sole");
			else if(correctNull((String)hshValues.get("sel_own")).trim().equalsIgnoreCase("2"))
				sbAuditTrial.append("Joint");
			else
				sbAuditTrial.append("");

			//Quality of Construction
			if(!(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("1"))||(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("6")))
			{
				sbAuditTrial.append("~Quality of Construction / Condition=");
				if(correctNull((String)hshValues.get("qualityconst")).trim().equalsIgnoreCase("1"))
					sbAuditTrial.append("Excellent");
				else if(correctNull((String)hshValues.get("qualityconst")).trim().equalsIgnoreCase("2"))
					sbAuditTrial.append("Good");
				else if(correctNull((String)hshValues.get("qualityconst")).trim().equalsIgnoreCase("3"))
					sbAuditTrial.append("Fair");
				else if(correctNull((String)hshValues.get("qualityconst")).trim().equalsIgnoreCase("4"))
					sbAuditTrial.append("Poor");
				else
					sbAuditTrial.append("");
			}
			//Marketability			
			sbAuditTrial.append("~Marketability=");
			if(correctNull((String)hshValues.get("marketability")).trim().equalsIgnoreCase("1"))
				sbAuditTrial.append("Very Good");
			else if(correctNull((String)hshValues.get("marketability")).trim().equalsIgnoreCase("2"))
				sbAuditTrial.append("Good");
			else if(correctNull((String)hshValues.get("marketability")).trim().equalsIgnoreCase("3"))
				sbAuditTrial.append("Fair");
			else if(correctNull((String)hshValues.get("marketability")).trim().equalsIgnoreCase("4"))
				sbAuditTrial.append("Poor");
			else
				sbAuditTrial.append("");
			//Amenities	
			if((correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("5"))||(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("6"))||(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("7")))
			{
				sbAuditTrial.append("~Presence of Amenities=");
				if(correctNull((String)hshValues.get("presenceamenities")).trim().equalsIgnoreCase("1"))
					sbAuditTrial.append("Very Good");
				else if(correctNull((String)hshValues.get("presenceamenities")).trim().equalsIgnoreCase("2"))
					sbAuditTrial.append("Good");
				else if(correctNull((String)hshValues.get("presenceamenities")).trim().equalsIgnoreCase("3"))
					sbAuditTrial.append("Fair");
				else if(correctNull((String)hshValues.get("presenceamenities")).trim().equalsIgnoreCase("4"))
					sbAuditTrial.append("Poor");
				else
					sbAuditTrial.append("");
			}
			//Purchase Price
			if(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("1")||
				correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("4")||
				correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("6"))
			{
				sbAuditTrial.append("~Purchase price of plot=");
			}
			else if (correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("3")||
					correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("5"))
			{
				sbAuditTrial.append("~Purchase price of House/Flat=");
			}
			sbAuditTrial.append(correctNull((String)hshValues.get("prop_purchaseprice")));
			//Estimated Cost of Construction	
			if(!(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("2"))||(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("7")))
			{
				sbAuditTrial.append("~Estimated Cost of Construction=");
				sbAuditTrial.append(correctNull((String)hshValues.get("prop_estimatedprice")));
			}
			//Dwelling Unit
			if(!(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("3")) && !(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("1")))
			{
				sbAuditTrial.append("~Is the dwelling Unit=");
				if(correctNull((String)hshValues.get("prop_allotted")).trim().equalsIgnoreCase("1"))
					sbAuditTrial.append("Final Stage/ Ready built House");
				else if(correctNull((String)hshValues.get("prop_allotted")).trim().equalsIgnoreCase("2"))
					sbAuditTrial.append("Intermediate Stage");
				else if(correctNull((String)hshValues.get("prop_allotted")).trim().equalsIgnoreCase("3"))
					sbAuditTrial.append("Foundation Stage");
				else if(correctNull((String)hshValues.get("prop_allotted")).trim().equalsIgnoreCase("4"))
					sbAuditTrial.append("Planning Stage");
				else
					sbAuditTrial.append("");
			}
			//Legal Title			
			sbAuditTrial.append("~Is the legal title to the dwelling unit clear=");
			if(correctNull((String)hshValues.get("sel_dwell")).trim().equalsIgnoreCase("1"))
				sbAuditTrial.append("Yes");
			else if(correctNull((String)hshValues.get("sel_dwell")).trim().equalsIgnoreCase("2"))
				sbAuditTrial.append("No");
			else
				sbAuditTrial.append("");
			//Property Type			
			if((correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("2"))||(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("4"))||(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("6")))
			{
				sbAuditTrial.append("~Property Type=");
				if(correctNull((String)hshValues.get("propertytype2")).trim().equalsIgnoreCase("1"))
					sbAuditTrial.append("New");
				else if(correctNull((String)hshValues.get("propertytype2")).trim().equalsIgnoreCase("2"))
					sbAuditTrial.append("Existing").append("~Age of the Premises =").append(correctNull((String)hshValues.get("prop_age")));
				else
					sbAuditTrial.append("");
			}
			//Period required			
			if(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("4"))
			{
				sbAuditTrial.append("~Purchase price of House/Flat=");
			}
			else if(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("1")||
				correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("2")||
				correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("6"))
			{
				sbAuditTrial.append("~Period required for Construction=");
			}
			else if(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("5"))
			{
				sbAuditTrial.append("~Period required for Renovation=");
			}
			sbAuditTrial.append(correctNull((String)hshValues.get("prop_repairdetails")));
			//Age 		
			if((correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("3"))||(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("5"))||(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("7")))
			{
				sbAuditTrial.append("~Age of the Premises=");
				sbAuditTrial.append(correctNull((String)hshValues.get("prop_age")));
			}

			//Undivided Shares of Land		
			if(!(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("2")))
			{
				sbAuditTrial.append("~Undivided Shares of Land=");
				sbAuditTrial.append(correctNull((String)hshValues.get("prop_costofcomplete")));
			}
			//house no	
			
			sbAuditTrial.append("~House No/Plot No=");
			sbAuditTrial.append(correctNull((String)hshValues.get("prop_houseno")));
			//Floor no
			if(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("1"))
			{
				sbAuditTrial.append("~No.of Floors =");
			}
			else 
			{
				sbAuditTrial.append("~Floor No.=");
			}
			sbAuditTrial.append(correctNull((String)hshValues.get("prop_floorno")));
			//Nature of the property
			if(!(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("3")))
			{
				sbAuditTrial.append("~Nature of the property=");
				if(correctNull((String)hshValues.get("sel_nature")).trim().equalsIgnoreCase("R"))
					sbAuditTrial.append("Residential");
				else if(correctNull((String)hshValues.get("sel_nature")).trim().equalsIgnoreCase("C"))
					sbAuditTrial.append("Commerical");
			}
			//location			
			sbAuditTrial.append("~Location Address=");
			sbAuditTrial.append(correctNull((String)hshValues.get("prop_area")));
			//city
			sbAuditTrial.append("~City=");
			sbAuditTrial.append(correctNull((String)hshValues.get("prop_city")));
			//state	
			sbAuditTrial.append("~State=");
			sbAuditTrial.append(correctNull((String)hshValues.get("prop_state")));
			//pincode		
			sbAuditTrial.append("~Pin Code=");
			sbAuditTrial.append(correctNull((String)hshValues.get("prop_pin")));
			//Market Value of the Land
			if(!(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("2")))
			{
				sbAuditTrial.append("~Market Value of the Land=");
				sbAuditTrial.append(correctNull((String)hshValues.get("prop_mar_land")));
			}
			//Market value of house /flat			
			if(!(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("6")))
			{
				if(!(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("2")))
				{	
					sbAuditTrial.append("~Market Value of Building/House=");
				}
				else
				{
					sbAuditTrial.append("~Market Value of Flat=");
				}
				sbAuditTrial.append(correctNull((String)hshValues.get("prop_mar_build")));
			}

			if(!((correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("5"))
					||(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("6"))
					||(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("7"))))
			{
				sbAuditTrial.append("~Date of Agreement=");
				sbAuditTrial.append(correctNull((String)hshValues.get("prop_agree_date")));
				
				sbAuditTrial.append("~Agreement No=");
				sbAuditTrial.append(correctNull((String)hshValues.get("prop_agree_no")));
			}
			//Property Used for			
			sbAuditTrial.append("~Property Used For=");
			if(correctNull((String)hshValues.get("sel_house")).trim().equalsIgnoreCase("1"))
			{
				sbAuditTrial.append("Renting Out");
			}
			else if(correctNull((String)hshValues.get("sel_house")).trim().equalsIgnoreCase("2"))
				sbAuditTrial.append("Self Occupation");
			else if(correctNull((String)hshValues.get("sel_house")).trim().equalsIgnoreCase("3"))
				sbAuditTrial.append("Leasing Out");
			else if(correctNull((String)hshValues.get("sel_house")).trim().equalsIgnoreCase("4"))
				sbAuditTrial.append("Commercial");
			else
				sbAuditTrial.append("");
			//Expected Rent
			if(correctNull((String)hshValues.get("sel_house")).trim().equalsIgnoreCase("1"))
			{	
				sbAuditTrial.append("~Expected Rent Per Month=");
				sbAuditTrial.append(correctNull((String)hshValues.get("prop_exp_rent")));
			}
			if(!((correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("5"))||(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("6"))
					||(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("7"))))
			{
				sbAuditTrial.append("~Seller/ Owner Name=");
				sbAuditTrial.append(correctNull((String)hshValues.get("prop_sellername")));
			}
			/*if(!(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("5"))||(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("6")))
			{
				sbAuditTrial.append("~Seller/ Owner Address=");
				sbAuditTrial.append(correctNull((String)hshValues.get("txt_selleraddress")));
			}*/
			
			if((correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("3")))
			{
				sbAuditTrial.append("~Interim security=");
				sbAuditTrial.append(correctNull((String)hshValues.get("prop_intermsecurity")));
			}
			//commented by lakshmi priya.S (since these fields are textarea)
		/*	if((correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("2")))
			{
				sbAuditTrial.append("~Project Name & Details=");
				sbAuditTrial.append(correctNull((String)hshValues.get("prop_proj_details")));
			}*/
			
			/*if(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("2") || correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("1")
					|| correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("4") || correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("7"))
			{
				//sbAuditTrial.append("~Particulars of Completion=");
				//sbAuditTrial.append(correctNull((String)hshValues.get("txt_completion")));
				
				//sbAuditTrial.append("~Charges if Any=");
				//sbAuditTrial.append(correctNull((String)hshValues.get("txt_prop_charges")));
			}*/
			
			/*if((correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("3")))
			{
				//sbAuditTrial.append("~Charges if Any=");
				//sbAuditTrial.append(correctNull((String)hshValues.get("txt_prop_charges")));
			}*/
			
			if((correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("4")))
			{
				sbAuditTrial.append("~Cost per sq. ft=");
				sbAuditTrial.append(correctNull((String)hshValues.get("prop_cost")));
			}
			
			/*if(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("2") || correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("4")|| correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("7"))
			{
				sbAuditTrial.append("~Particulars of permission=");
				sbAuditTrial.append(correctNull((String)hshValues.get("txt_prop_charges")));
			}
			
			if((correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("1")))
			{
				sbAuditTrial.append("~Particulars of permission from relevant Authority =");
				sbAuditTrial.append(correctNull((String)hshValues.get("txt_prop_charges")));
			}*/
			 
			if(!(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("6")))
			{
				sbAuditTrial.append("~Cost per sq. ft=");
				sbAuditTrial.append(correctNull((String)hshValues.get("prop_cost")));
			}
			if((correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("1"))||(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("3"))||(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("6")))
			{
				sbAuditTrial.append("~Cost per sq. ft(construction)=");
				sbAuditTrial.append(correctNull((String)hshValues.get("prop_costofconstruction")));
			}
			if(!(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("1"))||(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("6")))
			{
				sbAuditTrial.append("~Occupancy Certificate Issued Date=");
				sbAuditTrial.append(correctNull((String)hshValues.get("txt_certificateissu")));
			}
			//Location - Here the '~' is added at the end of field name itself, as it values are separated by a comma			
			sbAuditTrial.append("~Location(Indicators)=~");
			if(correctNull((String)hshValues.get("chk_mainroad")).trim().equalsIgnoreCase("Y"))
				sbAuditTrial.append("Near by Main Road. ");
			if(correctNull((String)hshValues.get("chk_eduinstitution")).trim().equalsIgnoreCase("Y"))
				sbAuditTrial.append("Near by Market/ Educational Institution. ");
			if(correctNull((String)hshValues.get("chk_public")).trim().equalsIgnoreCase("Y"))
				sbAuditTrial.append("Near by Other Public Utilities viz., Hospital/Post Office/Railway Station etc. ");
			if(correctNull((String)hshValues.get("chk_prime")).trim().equalsIgnoreCase("Y"))
				sbAuditTrial.append("Neighbourhood - Prime/ Suburb etc. ");
			//Amenities - Here the '~' is added at the end of field name itself, as it values are separated by a comma
			sbAuditTrial.append("~Amenities(Indicators)=~");
			if(correctNull((String)hshValues.get("chk_accessible")).trim().equalsIgnoreCase("Y"))
				sbAuditTrial.append("Accessible to Road. ");
			if(correctNull((String)hshValues.get("chk_assured")).trim().equalsIgnoreCase("Y"))
				sbAuditTrial.append("Assured water supply. ");
			if(correctNull((String)hshValues.get("chk_drainages")).trim().equalsIgnoreCase("Y"))
				sbAuditTrial.append("Proper Drainage System/ Not pruned to water logging. ");
			if(correctNull((String)hshValues.get("chk_currentconnection")).trim().equalsIgnoreCase("Y"))
				sbAuditTrial.append("Current Connection available. ");
			//Name of the Builder
			if(!(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("5"))||(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("7")))
			{
				sbAuditTrial.append("~Name of the Builder and his reputation & track record in completion of earlier Project=");
				sbAuditTrial.append(correctNull((String)hshValues.get("prop_housingaddress")));
			}
			sbAuditTrial.append("~Municipal Tax Paid Upto=");
			sbAuditTrial.append(correctNull((String)hshValues.get("txt_municipaldate")));
			sbAuditTrial.append("~Water Tax Paid Upto=");
			sbAuditTrial.append(correctNull((String)hshValues.get("txt_waterdate")));
			if(!((correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("3"))||(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("6"))||(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("7"))))
			{
				sbAuditTrial.append("~Name of the Society incase the site is allotted by Co-op.Housing Society and whether " +
						"it is approved by competent authority in the State Government=");
				sbAuditTrial.append(correctNull((String)hshValues.get("prop_institutename")));
			}
			//Scoiety's Permission / NOC
			if(correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("5") ||
					correctNull((String)hshValues.get("prop_purpose")).trim().equalsIgnoreCase("7"))
			{
				sbAuditTrial.append("~Whether Society's Permission/NOC for renovation is obtained=");
			}else{
				sbAuditTrial.append("~Whether Society's Permission/NOC for sale is obtained=");
			}
			if(correctNull((String)hshValues.get("prop_societypermission")).trim().equalsIgnoreCase("1"))
				sbAuditTrial.append("Yes");
			else
				sbAuditTrial.append("No");
			//Any lien			
			sbAuditTrial.append("~Any lien has been marked in Society's record for the flat=");
			if(correctNull((String)hshValues.get("prop_liensociety")).trim().equalsIgnoreCase("1"))
				sbAuditTrial.append("Yes");
			else if(correctNull((String)hshValues.get("prop_liensociety")).trim().equalsIgnoreCase("2"))
				sbAuditTrial.append("No");
			else
				sbAuditTrial.append("");
			//Whether any amount to be paid			
			sbAuditTrial.append("~Whether any amount to be paid to society is outstanding=");
			if(correctNull((String)hshValues.get("prop_outstandingsociety")).trim().equalsIgnoreCase("1"))
				sbAuditTrial.append("Yes");
			else if(correctNull((String)hshValues.get("prop_outstandingsociety")).trim().equalsIgnoreCase("2"))
				sbAuditTrial.append("No");
			else
				sbAuditTrial.append("~");
			//Esitimate of Cost			
			sbAuditTrial.append("~Esitimate of Cost(Purchase price)=");
			sbAuditTrial.append(correctNull((String)hshValues.get("prop_costofamenties")));
			if(correctNull((String)hshValues.get("prd")).trim().equalsIgnoreCase("pH"))
			{
				sbAuditTrial.append("~Esitimate of Cost(Cost of Construction/Improvement)=");
			}else{
				sbAuditTrial.append("~Esitimate of Cost(Furnishing Cost)=");
			}
			sbAuditTrial.append(correctNull((String)hshValues.get("prop_costofconstruct")));
			sbAuditTrial.append("~Esitimate of Cost(Document/Registration Fees)=");
			sbAuditTrial.append(correctNull((String)hshValues.get("prop_registration")));
			sbAuditTrial.append("~Esitimate of Cost("+correctNull((String)hshValues.get("prop_costrepair"))+")=");
			sbAuditTrial.append(correctNull((String)hshValues.get("txtcostofland")));
			sbAuditTrial.append("~Esitimate of Cost("+correctNull((String)hshValues.get("prop_spy2"))+")=");
			sbAuditTrial.append(correctNull((String)hshValues.get("prop_outstandingloan")));
			sbAuditTrial.append("~Esitimate of Cost("+correctNull((String)hshValues.get("prop_otherspy"))+")=");
			sbAuditTrial.append(correctNull((String)hshValues.get("prop_otheramt")));
			sbAuditTrial.append("~Esitimate of Cost(Total Cost)=");
			sbAuditTrial.append(correctNull((String)hshValues.get("prop_totalcost")));
			sbAuditTrial.append("~Estimate of Sources(Loans requested from the Bank)=");
			sbAuditTrial.append(correctNull((String)hshValues.get("prop_amountinvested")));
			sbAuditTrial.append("~Estimate of Sources(Cost already incurred)=");
			sbAuditTrial.append(correctNull((String)hshValues.get("prop_savingbank")));
			sbAuditTrial.append("~Estimate of Sources(Own Savings and Disposal of " +
					"Investments(FD's,Shares,NSC,LICP,Provident Fund))=");
			sbAuditTrial.append(correctNull((String)hshValues.get("prop_disposal")));
			sbAuditTrial.append("~Estimate of Sources("+correctNull((String)hshValues.get("prop_otherspy2"))+")=");
			sbAuditTrial.append(correctNull((String)hshValues.get("prop_otheramt2")));
			sbAuditTrial.append("~Estimate of Sources("+correctNull((String)hshValues.get("prop_otherspy1"))+")=");
			sbAuditTrial.append(correctNull((String)hshValues.get("prop_otheramt1")));
			sbAuditTrial.append("~Estimate of Sources(Total Fund)=");
			sbAuditTrial.append(correctNull((String)hshValues.get("prop_totalfund")));
			
			if(correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("Y"))
			{
				hshValues.put("hidAction", "update");
			}	
		}
			AuditTrial.auditLog(hshValues,"34",strAppno,sbAuditTrial.toString());
		}catch(Exception e)
		{
			throw new EJBException("Exception in propAssetAuditTrial method of PropertyDetailsBean "+e.getMessage());
		}
	}


	public void updateotherinfoData(HashMap hshValues) 
	{	
		ArrayList arrValues = new ArrayList();
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		String strAppno=correctNull((String)hshValues.get("appno"));
		try
		{	
			hshQueryValues.put("size","2");
			hshQuery.put("strQueryId","delpropotherinfo");
			arrValues.add(strAppno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);	
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			arrValues.add(strAppno);
			arrValues.add(correctNull((String) hshValues.get("other1")));
			arrValues.add(correctNull((String) hshValues.get("other2")));
			arrValues.add(correctNull((String) hshValues.get("other3")));
			arrValues.add(correctNull((String) hshValues.get("other4")));
			arrValues.add(correctNull((String) hshValues.get("other5")));
			arrValues.add(correctNull((String) hshValues.get("other6")));
			arrValues.add(correctNull((String) hshValues.get("other7")));
			arrValues.add(correctNull((String) hshValues.get("other8")));
			arrValues.add(correctNull((String) hshValues.get("other9")));						
			
			hshQueryValues.put("size", "2");
			hshQuery.put("arrValues", arrValues);	
			hshQuery.put("strQueryId", "inspropotherinfo");
			hshQueryValues.put("2", hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateData "+ce.toString());
		}
		finally
		{	
			try
			{
				//EJBInvoker.executeStateLess("appeditlock",hshValues,"unLockApplication");
			}
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}
	}

	public HashMap updateGeneralInfo(HashMap hshValues) 
	{
		HashMap hshRec=new HashMap();		
		ArrayList arrValues = new ArrayList();
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		String strAppno=correctNull((String)hshValues.get("appno"));
		String strhidAction=correctNull((String)hshValues.get("hidAction"));
		String varPurposeOfLoan =correctNull((String)hshValues.get("phpa_loan_purpose"));
		StringBuilder sbAuditTrial=new StringBuilder();
		StringBuilder sboldAudit = new StringBuilder();
		ResultSet rs=null;
		String strQuery="";
		
		try
		{	
			if(!strAppno.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("propgendetailsel^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					String strstatus1=Helper.correctNull(rs.getString("selfocc_status"));
					String strstatus2=Helper.correctNull(rs.getString("spouse_status"));
					String strstatus3=Helper.correctNull(rs.getString("legal_status"));
					String strstatus4=Helper.correctNull(rs.getString("collateral_status"));
					String strstatus5=Helper.correctNull(rs.getString("emploan_status"));
					String strstatus6=Helper.correctNull(rs.getString("escalation_status"));
										
					sboldAudit.append("~Whether the house/flat be self occupied after construction =");
					if(strstatus1.equalsIgnoreCase("1"))
						sboldAudit.append("Yes");
					else if (strstatus1.equalsIgnoreCase("2"))
						sboldAudit.append("No");
					else sboldAudit.append("--select--");
					sboldAudit.append("~Do you / your spouse / children own any house/flat =");
					if(strstatus2.equalsIgnoreCase("1"))
						sboldAudit.append("Yes");
					else if (strstatus2.equalsIgnoreCase("2"))
						sboldAudit.append("No");
					else sboldAudit.append("--select--");
					sboldAudit.append("~Is the legal title clear =");
					if(strstatus3.equalsIgnoreCase("1"))
						sboldAudit.append("Yes");
					else if (strstatus3.equalsIgnoreCase("2"))
						sboldAudit.append("No");
					else sboldAudit.append("--select--");
					sboldAudit.append("~Whether the applicant is bonafide owner of the residential / commercial =");
					if(strstatus4.equalsIgnoreCase("1"))
						sboldAudit.append("Yes");
					else if (strstatus4.equalsIgnoreCase("2"))
						sboldAudit.append("No");
					else sboldAudit.append("--select--");
					sboldAudit.append("~Whether your employer has any housing loan schemes =");
					if(strstatus5.equalsIgnoreCase("1"))
						sboldAudit.append("Yes");
					else if (strstatus5.equalsIgnoreCase("2"))
						sboldAudit.append("No");
					else sboldAudit.append("--select--");
					if(varPurposeOfLoan=="H" || varPurposeOfLoan=="G")
					{
					sboldAudit.append("~Whether the loan is taken for reimbursement =");
					if(strstatus6.equalsIgnoreCase("1"))
						sboldAudit.append("Yes");
					else if (strstatus6.equalsIgnoreCase("2"))
						sboldAudit.append("No");
					else sboldAudit.append("--select--");
					}
				}
				if(rs!=null)
				{
					rs.close();
				}
			}
			
			if(strhidAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId", "propgendetaildel");
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else
			{
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId", "propgendetaildel");
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(strAppno);
				arrValues.add(correctNull((String) hshValues.get("sel1")));
				arrValues.add(correctNull((String) hshValues.get("txtArea1")));
				arrValues.add(correctNull((String) hshValues.get("sel2")));
				arrValues.add(correctNull((String) hshValues.get("txtArea2")));
				arrValues.add(correctNull((String) hshValues.get("sel3")));
				arrValues.add(correctNull((String) hshValues.get("txtArea3")));
				arrValues.add(correctNull((String) hshValues.get("sel4")));
				arrValues.add(correctNull((String) hshValues.get("txtArea4")));
				arrValues.add(correctNull((String) hshValues.get("sel5")));
				arrValues.add(correctNull((String) hshValues.get("txtArea5")));
				arrValues.add(correctNull((String) hshValues.get("sel6")));
				arrValues.add(correctNull((String) hshValues.get("txtArea6")));
				arrValues.add(correctNull((String) hshValues.get("sel7")));
				arrValues.add(correctNull((String) hshValues.get("txtArea7")));
				arrValues.add(correctNull((String) hshValues.get("txt_registration")));
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId", "propgendetailins");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			/** For the purpose of 'Audit Trial' */
			if(!strAppno.equalsIgnoreCase(""))
			{
			sbAuditTrial.append("~Whether the house/flat be self occupied after construction =");
			if(correctNull((String)hshValues.get("sel1")).trim().equalsIgnoreCase("1"))
				sbAuditTrial.append("Yes");
			else if(correctNull((String)hshValues.get("sel1")).trim().equalsIgnoreCase("2"))
				sbAuditTrial.append("No");
			
			sbAuditTrial.append("~Do you / your spouse / children own any house/flat =");
			if(correctNull((String)hshValues.get("sel2")).trim().equalsIgnoreCase("1"))
				sbAuditTrial.append("Yes");
			else if(correctNull((String)hshValues.get("sel2")).trim().equalsIgnoreCase("2"))
				sbAuditTrial.append("No");
			
			sbAuditTrial.append("~Is the legal title clear=");
			if(correctNull((String)hshValues.get("sel3")).trim().equalsIgnoreCase("1"))
				sbAuditTrial.append("Yes");
			else if(correctNull((String)hshValues.get("sel3")).trim().equalsIgnoreCase("2"))
				sbAuditTrial.append("No");
			
			sbAuditTrial.append("~Whether the applicant is bonafide owner of the residential / commercial =");
			if(correctNull((String)hshValues.get("sel4")).trim().equalsIgnoreCase("1"))
				sbAuditTrial.append("Yes");
			else if(correctNull((String)hshValues.get("sel4")).trim().equalsIgnoreCase("2"))
				sbAuditTrial.append("No");
			
			sbAuditTrial.append("~Whether your employer has any housing loan schemes =");
			if(correctNull((String)hshValues.get("sel5")).trim().equalsIgnoreCase("1"))
				sbAuditTrial.append("Yes");
			else if(correctNull((String)hshValues.get("sel5")).trim().equalsIgnoreCase("2"))
				sbAuditTrial.append("No");
			if(varPurposeOfLoan=="H" || varPurposeOfLoan=="G")
			{
			sbAuditTrial.append("~Whether the loan is taken for reimbursement =");
			if(correctNull((String)hshValues.get("sel6")).trim().equalsIgnoreCase("1"))
				sbAuditTrial.append("Yes");
			else if(correctNull((String)hshValues.get("sel6")).trim().equalsIgnoreCase("2"))
				sbAuditTrial.append("No");
			}
				if(correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("N"))
				{
					hshValues.put("hidAction", "insert");
				}	
			}
			AuditTrial.auditNewLog(hshValues, "245", strAppno,sbAuditTrial.toString(),sboldAudit.toString());
			/** End */
		}				
		catch(Exception e)
		{
			log.error("Exception"+ e);
		}
		return hshRec;	
	}

	public HashMap getGeneralInfo(HashMap hshValues) 
	{
		HashMap hshRec=new HashMap();			 
		ResultSet rs = null;
		ResultSet rs1 = null;
		String appno   = "", strappname="";
		appno = correctNull((String) hshValues.get("appno"));
		strappname = correctNull((String) hshValues.get("appname"));
		if(strappname.equals(""))
		{
			strappname=correctNull((String)hshValues.get("app_name"));
		}
		boolean recordflag=false;  
	
		try
		{ 
			rs=DBUtils.executeLAPSQuery("propgendetailsel^"+appno);	
			while(rs.next())
			{
				hshRec.put("appno",appno);
				hshRec.put("selfocc_status",correctNull(rs.getString("selfocc_status")));
				hshRec.put("selfocc_desc",correctNull(rs.getString("selfocc_desc")));
				hshRec.put("spouse_status",correctNull(rs.getString("spouse_status")));
				hshRec.put("spouse_desc",correctNull(rs.getString("spouse_desc")));
				hshRec.put("legal_status",correctNull(rs.getString("legal_status")));
				hshRec.put("legal_desc",correctNull(rs.getString("legal_desc")));
				hshRec.put("collateral_status",correctNull(rs.getString("collateral_status")));
				hshRec.put("collateral_desc",correctNull(rs.getString("collateral_desc")));
				hshRec.put("emploan_status",correctNull(rs.getString("emploan_status")));
				hshRec.put("emploan_desc",correctNull(rs.getString("emploan_desc")));
				hshRec.put("escalation_status",correctNull(rs.getString("escalation_status")));
				hshRec.put("escalation_desc",correctNull(rs.getString("escalation_desc")));
				hshRec.put("guarantor_status",correctNull(rs.getString("guarantor_status")));
				hshRec.put("guarantor_desc",correctNull(rs.getString("guarantor_desc")));
				hshRec.put("registration_date",correctNull(rs.getString("registration_date")));
				recordflag=true;
			}
			if(rs1 !=null)
				rs1.close();
			rs1=DBUtils.executeLAPSQuery("sel_per_house_proposed_asset^"+ appno);			 
			if (rs1.next()) 
			{
				hshRec.put("phpa_loan_purpose",correctNull(rs1.getString("phpa_loan_purpose")));
			}
			/** For the purpose of 'Audit Trial' */
			if(recordflag)
				hshRec.put("recordflag","Y");
			else
				hshRec.put("recordflag","N");
			
			hshRec.put("app_name",strappname);
		}
		catch(Exception e)
		{
			log.error("Exception"+ e);
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				} 
			}
			catch (Exception e1)
			{
				log.error("error occured"+e1.toString());
			}
		}
		return hshRec;		
	}

	/*public HashMap getOtherAssetData(HashMap hshRequestValues)
	{
		String strEditlockflag = null;
		String strLock="";
		ResultSet rs=null;		
		HashMap hshValues = new HashMap();
		ArrayList arrVal = new ArrayList();
		ArrayList arrRec= new ArrayList();
		String appno="";

		try
		{
			strEditlockflag = (String)hshRequestValues.get("hideditflag");
			appno=(String)hshRequestValues.get("appno");
			rs=DBUtils.executeLAPSQuery("perotherassetselect^"+appno);
			while(rs.next())
			{
				arrRec = new ArrayList();
				arrRec.add(correctNull(rs.getString(1)));
				arrRec.add(correctNull(rs.getString(2)));
				arrRec.add(correctNull(rs.getString(3)));
				arrRec.add(correctNull(rs.getString(4)));
				arrRec.add(correctNull(rs.getString(5)));
				arrRec.add(correctNull(rs.getString(6)));
				arrVal.add(arrRec);
			}
			hshValues.put("arrVal",arrVal);
			if(strEditlockflag!=null && strEditlockflag.equalsIgnoreCase("yes"))			
			{
				strLock = (String)EJBInvoker.executeStateLess("appeditlock",hshRequestValues,"lockApplication");
			}
			if(strEditlockflag!=null && strEditlockflag.equalsIgnoreCase("no"))
			{
				EJBInvoker.executeStateLess("appeditlock",hshRequestValues,"unLockApplication");
			}	
		}		
		catch (Exception e)
		{
			Logger.log("error occured"+e.toString());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				} 
			}
			catch (Exception e1)
			{
				Logger.log("error occured"+e1.toString());
			}
		}
		hshValues.put("editlock",strLock);
		return hshValues;
	}
	
	public void updateOtherAssetData(HashMap hshValues)
	{
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		ArrayList arrValues ;
		int intValue = 0;
		String strAppno="";
		
		try
		{ 
			strAppno=(String)hshValues.get("appno");			
			String []strAssetDetail=null;
			String []strSupplier = null;
			String []strPurchasePrice = null;
			String []strinvoicevalue =null;
			String []strMarketValue = null;		
			String strincincome="";
			strAssetDetail= (String [])hshValues.get("txtAssetDetail");
			strSupplier= (String [])hshValues.get("txtSupplier");
			strPurchasePrice = (String [])hshValues.get("txtPurchasePrice");
			strinvoicevalue = (String[])hshValues.get("txtinvoice");
			strMarketValue = (String [])hshValues.get("txtMarketValue");	
			strincincome=(String)hshValues.get("txt_incincome");
			if(strincincome.equalsIgnoreCase(""))
			{
				strincincome="0.00";
			}
			int intUpdatesize=0;
			intUpdatesize=1;
			hshQuery=new HashMap();
			hshQuery.put("strQueryId","perassetdelete");
			arrValues=new ArrayList();
			arrValues.add(strAppno);
			hshQueryValues.put("size",Integer.toString(intUpdatesize));
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			int len=strAssetDetail.length;
			for(int k=0;k<len;k++)
			{				
				if(!strAssetDetail[k].equals(""))
				{								
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					intUpdatesize=intUpdatesize+1;
					hshQuery.put("strQueryId","perotherassetinsert");
					arrValues.add(strAppno);
					intValue=intValue+1;
					String i=Integer.toString(intValue);
					arrValues.add(i);
					arrValues.add(correctNull(strAssetDetail[k]));
					arrValues.add(correctNull(strSupplier[k]));
					arrValues.add(Helper.correctDouble((String)strPurchasePrice[k]));
					arrValues.add(Helper.correctDouble((String)strinvoicevalue[k]));
					arrValues.add(Helper.correctDouble((String)strMarketValue[k]));
					arrValues.add(strincincome);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);	
				}
			}
			
			hshQueryValues.put("size",Integer.toString(intUpdatesize));		
			//Start of Audit Trial			
			len=strAssetDetail.length;
			for(int k=0;k<len;k++)
			{				
				if(!strAssetDetail[k].equals(""))
				{
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					intUpdatesize=intUpdatesize+1;
					String strActionData = "Details of Asset = "+correctNull(strAssetDetail[k])+
					"~Name of Supplier / Dealer = "+correctNull(strSupplier[k])+
					"~Purchase Price / Amount = "+Helper.correctDouble((String)strPurchasePrice[k])+
					"~Market Value = "+Helper.correctDouble((String)strMarketValue[k]);
		
					hshQuery.put("strQueryId","audittrial");
					arrValues.add("36");
					arrValues.add(correctNull((String)hshValues.get("strUserId")));
					arrValues.add(correctNull((String)hshValues.get("strClientIP")));
					arrValues.add(strAppno);
					arrValues.add(strActionData);
					arrValues.add("Insert");			
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);	
				}
			}
			hshQueryValues.put("size",Integer.toString(intUpdatesize));	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");			
		}
		catch (Exception e)
		{
			Logger.log("in bean"+e);
		}
		finally
		{	
			try
			{
				EJBInvoker.executeStateLess("appeditlock",hshValues,"unLockApplication");
			}
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}
	}
	*/
	public HashMap getOtherAssetData(HashMap hshRequestValues)
	{
		//String strEditlockflag = null;
		String strLock="";
		ResultSet rs=null;		
		HashMap hshValues = new HashMap();
		ArrayList arrVal = new ArrayList();
		ArrayList arrRec= new ArrayList();
		String appno="";
		String recordflag="N";
		String strModuleType="",strQuery="";

		try
		{
			//strEditlockflag = (String)hshRequestValues.get("hideditflag");
			appno=(String)hshRequestValues.get("appno");
			String schemetype = correctNull((String)hshRequestValues.get("schemetype"));
			strModuleType=(String)hshRequestValues.get("sessionModuleType");
			String strfacsno="";
			
			HashMap hshScheme = new HashMap();
			hshScheme = Helper.splitScheme(schemetype);
			
			if(hshScheme!=null && strModuleType.equalsIgnoreCase("AGR"))
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				schemetype =Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			else
			{
				strfacsno="1";
			}
			
			rs=DBUtils.executeLAPSQuery("perotherassetselect^"+appno+"^"+strfacsno);
			while(rs.next())
			{
				arrRec = new ArrayList();
				arrRec.add(correctNull(rs.getString(1)));
				arrRec.add(correctNull(rs.getString(2)));
				arrRec.add(Helper.checkDecimal(Helper.correctDouble(rs.getString(3))));
				arrRec.add(Helper.correctNull(rs.getString(4))); //changes made by Dinesh
				arrRec.add(Helper.correctNull((String)rs.getString(5)));
				arrRec.add(Helper.checkDecimal(Helper.correctDouble(rs.getString(6))));
				arrRec.add(correctNull(rs.getString(7)));//changes made by Madhura
				arrVal.add(arrRec);
				recordflag="Y";
			}
			hshValues.put("arrVal",arrVal);
			hshValues.put("recordflag",recordflag);
			/*if(strEditlockflag!=null && strEditlockflag.equalsIgnoreCase("yes"))			
			{
				strLock = (String)EJBInvoker.executeStateLess("appeditlock",hshRequestValues,"lockApplication");
			}
			if(strEditlockflag!=null && strEditlockflag.equalsIgnoreCase("no"))
			{
				EJBInvoker.executeStateLess("appeditlock",hshRequestValues,"unLockApplication");
			}*/	
			
			rs=DBUtils.executeLAPSQuery("sel_prdDesc^"+appno);
			if(rs.next())
			{
				hshValues.put("prd_applicablefor", Helper.correctNull((String)rs.getString("PRD_APPLICABLEFOR")));
			}
			
				//for checking freeze count
			int strFreezecount=0;
			String strFreezeflag="N",strPrioityflag="N";
			strQuery = SQLParser.getSqlQuery("sel_freezecount^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{	
				strFreezecount=Integer.parseInt(Helper.correctInt((String)rs.getString("freezecount")));
				if(strFreezecount!=0 )
				{
					strFreezeflag="Y";
				}
			}
			if( Helper.correctNull((String)hshValues.get("hidAction")).equalsIgnoreCase("undo"))
			{
				strFreezeflag="N";
			}
			hshValues.put("strFreezeflag",strFreezeflag);
			
			
		}		
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				} 
			}
			catch (Exception e1)
			{
				log.error("error occured"+e1.toString());
			}
		}
		hshValues.put("editlock",strLock);
		return hshValues;
	}
	
	public void updateOtherAssetData(HashMap hshValues)
	{
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		ArrayList arrValues ;
		int intValue = 0,len=0;
		String strAppno="";
		String strAction="";
		StringBuilder sbAuditTrial=new StringBuilder();
		String strModuleType="";
		
		try
		{ 
			strAppno=(String)hshValues.get("appno");			
			String []strAssetDetail=null;
			String []strSupplier = null;
			String []strPurchasePrice = null;
			String []strinvoicevalue =null;
			String []strinvoiceDate = null;	
			String []strtxtNeed=null;
			String strincincome="";
			strModuleType=(String)hshValues.get("sessionModuleType");
			strAction=correctNull((String)hshValues.get("hidAction"));
			strAssetDetail= (String [])hshValues.get("txtAssetDetail");
			strSupplier= (String [])hshValues.get("txtSupplier");
			strPurchasePrice = (String [])hshValues.get("txtPurchasePrice");
			strinvoicevalue = (String[])hshValues.get("txtinvoice");
			strinvoiceDate = (String [])hshValues.get("txt_invoiceDate");	
			strincincome=(String)hshValues.get("txt_incincome");
			String schemetype = correctNull((String)hshValues.get("schemetype"));	
			String strfacsno="";
			
			HashMap hshScheme = new HashMap();
			hshScheme = Helper.splitScheme(schemetype);
			
			if(hshScheme!=null && strModuleType.equalsIgnoreCase("AGR"))
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				schemetype =Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			else
			{
				strfacsno="1";
			}
			
			if(strincincome.equalsIgnoreCase(""))
			{
				strincincome="0.00";
			}
			strtxtNeed=(String [])hshValues.get("txtNeed");
			int intUpdatesize=1;
			
			if(strAction.equalsIgnoreCase("insert"))
				{
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","perassetdelete");
				arrValues=new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(strfacsno);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				len=strAssetDetail.length;
				for(int k=0;k<len;k++)
					{				
					if(!strAssetDetail[k].equals(""))
						{								
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize=intUpdatesize+1;
						hshQuery.put("strQueryId","perotherassetinsert");
						arrValues.add(strAppno);
						intValue=intValue+1;
						String i=Integer.toString(intValue);
						arrValues.add(i);
						arrValues.add(correctNull(strAssetDetail[k]));
						arrValues.add(correctNull(strSupplier[k]));
						arrValues.add(Helper.correctDouble((String)strPurchasePrice[k]));
						arrValues.add(strinvoicevalue[k]);
						arrValues.add(Helper.correctDouble((String)strinvoiceDate[k]));
						arrValues.add(strincincome);
						arrValues.add(correctNull(strtxtNeed[k]));
						arrValues.add(strfacsno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));	
						
						}
					}

				hshQueryValues.put("size",Integer.toString(intUpdatesize));	
				}
			else if(strAction.equalsIgnoreCase("delete"))
				{
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","perassetdelete");
				arrValues=new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(strfacsno);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				}
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			/** For the purpose of 'Audit Trial' */
			if((strAction.equalsIgnoreCase("insert"))||(strAction.equalsIgnoreCase("update")))
			{
				int strArrlen=strAssetDetail.length;
				for(int k=0;k<strArrlen;k++)
				{		
					if(!strAssetDetail[k].equals(""))
					{
						sbAuditTrial.append("Details of Asset= "+correctNull(strAssetDetail[k]));
						sbAuditTrial.append("~Equipment needed for="+correctNull(strtxtNeed[k]));
						sbAuditTrial.append("~Name and address of Supplier / Dealer= "+correctNull(strSupplier[k]));
						sbAuditTrial.append("~Purchase Price / Amount= "+Helper.correctDouble((String)strPurchasePrice[k]));
						sbAuditTrial.append("~Invoice="+correctNull((String)strinvoicevalue[k]));
						sbAuditTrial.append("~Invoice Date= "+Helper.correctDouble((String)strinvoiceDate[k])+"~");
					}
				}
				sbAuditTrial.append("~Expected Monthly income after acquiring the equipments="+correctNull((String)hshValues.get("txt_incincome")));
				if(correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("Y"))
				{
					hshValues.put("hidAction", "update");
				}
			}
			AuditTrial.auditLog(hshValues,"39",strAppno,sbAuditTrial.toString());
			/** End */
		}
		catch (Exception e)
		{
			log.error("in bean"+e);
		}
		finally
		{	
			try
			{
				//EJBInvoker.executeStateLess("appeditlock",hshValues,"unLockApplication");
			}
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}
	}
	
	
	/*public HashMap getDatalegal(HashMap hshRequestValues)
	{ 
		ResultSet rs=null;
		ResultSet rs1 = null;
		HashMap hshRecord=new HashMap();
		String strOrgCode=correctNull((String)hshRequestValues.get("strOrgCode"));
		String strAppno=correctNull((String)hshRequestValues.get("appno"));
		String strQuery1 = "";				
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = new ArrayList();	
		String senddate ="";
		String legalsno ="";
		String recddate= "", entrydate="", refdate="";
		String lawyerdesig="";
		try
		{		
			rs=DBUtils.executeLAPSQuery("legalopinionSel^"+strAppno);
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("APP_NO")));
				legalsno=correctNull(rs.getString("LEGOP_SNO"));
				arrCol.add(correctNull(rs.getString("LEGOP_SNO")));
				entrydate=correctNull((String)rs.getString("ENTRY_DATE"));
				if(entrydate.equalsIgnoreCase("01/01/1900"))
				{
					entrydate="";
				}
				arrCol.add(entrydate);
				arrCol.add(correctNull(rs.getString("REF_NO")));
				refdate=correctNull((String)rs.getString("REF_DATE"));
				if(refdate.equalsIgnoreCase("01/01/1900"))
				{
					refdate="";
				}
				arrCol.add(refdate);			
				arrCol.add(correctNull(rs.getString("LEGOP_FLAG")));
				arrCol.add(correctNull(rs.getString("MORTAGE_FLAG")));
				arrCol.add(correctNull(rs.getString("CONDITIONS")));
				arrCol.add(correctNull(rs.getString("REMARKS")));
				arrCol.add(correctNull(rs.getString("LAWYER_CODE")));
				senddate=correctNull((String)rs.getString("SEND_DATE"));
				if(senddate.equalsIgnoreCase("01/01/1900"))
				{
					senddate="";
				}
				arrCol.add(senddate);
				recddate=correctNull((String)rs.getString("RECD_DATE"));
				if(recddate.equalsIgnoreCase("01/01/1900"))
				{
					recddate="";
				}
				arrCol.add(recddate);
				arrCol.add(correctNull(rs.getString("branch_panel")));
				String appno=correctNull(rs.getString("APP_NO"));
				String legalslno = correctNull(rs.getString("LEGOP_SNO"));
				String designation= correctNull(rs.getString("LAWYER_CODE"));
				
				if(!appno.equalsIgnoreCase("") && !legalslno.equalsIgnoreCase("") && !designation.equalsIgnoreCase(""))
				{																																																																			
					strQuery1 = SQLParser.getSqlQuery("sel_lawyerdesig^"+designation+"^"+designation+"^"+strOrgCode+"^"+strOrgCode+"^"+legalslno+"^"+strAppno);
					 rs1=DBUtils.executeQuery(strQuery1);
					
					if(rs1.next())
					{
						arrCol.add(correctNull(rs1.getString("lawyer_name")));	
						lawyerdesig =correctNull(rs1.getString("lawyer_design"));
					}
					else
					{
						arrCol.add("");
					}						
					if(rs1!=null)
					{
						rs1.close();
					}
				}
				else
				{
					arrCol.add("");
				}				
				if(!appno.equalsIgnoreCase("") && !legalslno.equalsIgnoreCase("") && !lawyerdesig.equalsIgnoreCase(""))
				{																																																																			
					strQuery1 = SQLParser.getSqlQuery("selectdesignation^"+designation+"^"+strOrgCode+"^"+lawyerdesig+"^"+lawyerdesig);
					rs1=DBUtils.executeQuery(strQuery1);
						
					if(rs1.next())
					{
						arrCol.add(correctNull(rs1.getString("DESIGN_NAME")));
					}
					else
					{
						arrCol.add("");
					}						
					if(rs1!=null)
					{
						rs1.close();
					}
				}
				else
				{
					arrCol.add("");
				}						
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow",arrRow);
		}		
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
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
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}
		return hshRecord;
	}
	
	public HashMap legalupdateData(HashMap hshValues) 
	{
		HashMap hshRecord = null;
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		ArrayList arrValues1=new ArrayList();
		String strAppid=correctNull((String)hshValues.get("appno"));
		String strAction=(String)hshValues.get("hidAction");
		String strOrgCode=correctNull((String)hshValues.get("strOrgCode"));
		ResultSet rs = null;
		String intValue = "";
		try
		{	 
			hshValues.put("size","2");
			if(strAction.equalsIgnoreCase("insert"))
			{							
			  rs=DBUtils.executeLAPSQuery("legalMax^"+strAppid);	
				 			
				while(rs.next())
				{			
					intValue = correctNull((String)rs.getString("MaxSlno"));				
				}
				if(rs!=null)
				{
					rs.close();
				}
				arrValues.add(strAppid);
				arrValues.add(strOrgCode);
				arrValues.add(intValue);
				arrValues.add(hshValues.get("TxtEntryDt"));
				arrValues.add(hshValues.get("TxtRefNo"));
				arrValues.add(hshValues.get("TxtRefDt"));
				arrValues.add(hshValues.get("hid_sno"));
				arrValues.add(hshValues.get("LegOpFl"));
				arrValues.add(hshValues.get("MortFl"));
				arrValues.add(hshValues.get("TxtCond"));
				arrValues.add(hshValues.get("TxtRemark"));
				arrValues.add(hshValues.get("TxtsentDt"));
				arrValues.add(hshValues.get("TxtRecdDt"));
				arrValues.add(hshValues.get("sel_branchpanel"));
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","legalopinionIns");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction1.equalsIgnoreCase("insert1"))
			{	
				arrValues1.add(hshValues.get("TxtsentDt"));
				arrValues1.add(hshValues.get("TxtRecdDt"));				
				arrValues1.add(strAppid);
				hshQuery.put("arrValues",arrValues1);
				hshQuery.put("strQueryId","apphistoryUpd");                		
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}		
			if(strAction.equalsIgnoreCase("update"))
			{			
				arrValues.add(strOrgCode);
				arrValues.add(hshValues.get("TxtEntryDt"));
				arrValues.add(hshValues.get("TxtRefNo"));
				arrValues.add(hshValues.get("TxtRefDt"));
				arrValues.add(hshValues.get("hid_sno"));
				arrValues.add(hshValues.get("LegOpFl"));
				arrValues.add(hshValues.get("MortFl"));
				arrValues.add(hshValues.get("TxtCond"));
				arrValues.add(hshValues.get("TxtRemark"));				
				arrValues.add(hshValues.get("TxtsentDt"));
				arrValues.add(hshValues.get("TxtRecdDt"));
				arrValues.add(hshValues.get("sel_branchpanel"));
				arrValues.add(strAppid);
				arrValues.add(hshValues.get("hidEditLock"));
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","legalopinionUpd");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");		
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				arrValues.add(strAppid);
				arrValues.add(hshValues.get("hidEditLock"));
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","legalopinionDel");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			}				
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateData "+ce.toString());
		}		
		return hshRecord;
	}
	*/
	public HashMap getDatalegal(HashMap hshRequestValues)
	{ 
		ResultSet rs=null;
		HashMap hshRecord=new HashMap();
		String strAppno=correctNull((String)hshRequestValues.get("appno"));
		if(strAppno.equalsIgnoreCase(""))
		{
			strAppno=correctNull((String)hshRequestValues.get("strappno"));
		}
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = new ArrayList();	
		String senddate ="";
		String recddate= "", entrydate="", refdate="";
		String strsearchdate="",strQuery="";
		try
		{	
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" +strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshRecord.put("appname", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}
			
			if(rs!=null)
			{
				rs.close();
			}
			
			strQuery = SQLParser.getSqlQuery("getloanterms^" +strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshRecord.put("application_receivedate", correctNull(rs.getString("receivedate")));				
			}
			
			if(rs!=null)
			{
				rs.close();
			}
			
			rs=DBUtils.executeLAPSQuery("legalopinionSel^"+strAppno);
			while(rs.next())
			{
				arrCol = new ArrayList();
				
				arrCol.add(correctNull(rs.getString("APP_NO")));
				arrCol.add(correctNull(rs.getString("LEGOP_SNO")));
				
				entrydate=correctNull((String)rs.getString("ENTRY_DATE"));
				if(entrydate.equalsIgnoreCase("01/01/1900"))
				{
					entrydate="";
				}
				arrCol.add(entrydate);
				arrCol.add(correctNull(rs.getString("REF_NO")));
				refdate=correctNull((String)rs.getString("REF_DATE"));
				if(refdate.equalsIgnoreCase("01/01/1900"))
				{
					refdate="";
				}
				arrCol.add(refdate);			
				arrCol.add(correctNull(rs.getString("LEGOP_FLAG")));
				arrCol.add(correctNull(rs.getString("MORTAGE_FLAG")));
				arrCol.add(correctNull(rs.getString("CONDITIONS")));
				arrCol.add(correctNull(rs.getString("REMARKS")));
				arrCol.add(correctNull(rs.getString("LAWYER_CODE")));
			
				senddate=correctNull((String)rs.getString("SEND_DATE"));
				if(senddate.equalsIgnoreCase("01/01/1900"))
				{
					senddate="";
				}
				arrCol.add(senddate);
				recddate=correctNull((String)rs.getString("RECD_DATE"));
				if(recddate.equalsIgnoreCase("01/01/1900"))
				{
					recddate="";
				}
				
				arrCol.add(recddate);
				arrCol.add(correctNull(rs.getString("branch_panel")));
				strsearchdate=correctNull((String)rs.getString("search_date"));
			
				if(strsearchdate.equalsIgnoreCase("01/01/1900"))
				{
					strsearchdate="";
				}
				arrCol.add(strsearchdate);
				arrCol.add(correctNull(rs.getString("past_details")));
				arrCol.add(correctNull(rs.getString("lawyer_name")));
				arrCol.add(correctNull(rs.getString("lawyer_designation")));
							
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow",arrRow);
		}		
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
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
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}
		return hshRecord;
	}
	
	public HashMap legalupdateData(HashMap hshValues) 
	{
		HashMap hshRecord = null;
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		StringBuilder sbolddata=new StringBuilder();
		String strQuery="";
		String strAppid=correctNull((String)hshValues.get("appno"));
		if(strAppid.equalsIgnoreCase(""))
		{
			strAppid=correctNull((String)hshValues.get("strappno"));
		}
		String strAction=(String)hshValues.get("hidAction");
		String strOrgCode=correctNull((String)hshValues.get("strOrgCode"));
		ResultSet rs = null;
		String intValue = "";
		try
		{	
			hshValues.put("size","2");
			if(!strAppid.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("legalopinionSelbysno^"+correctNull((String)hshValues.get("hidsno"))+"^"+strAppid);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					sbolddata.append("Date of Entry=").append(correctNull(rs.getString("entry_date")))
					.append(" ~Date Sent =").append(correctNull(rs.getString("send_date")))
					.append(" ~Date received =").append(correctNull(rs.getString("recd_date")))
					.append(" ~Search Report Date =").append(correctNull(rs.getString("search_date")))
					.append(" ~Ref.No. =").append(correctNull(rs.getString("ref_no")))
					.append(" ~Dated =").append(correctNull(rs.getString("ref_date")))
					.append(" ~Lawyer Name=").append(correctNull(rs.getString("lawyer_name")))
					.append(" ~Designation =").append(correctNull(rs.getString("lawyer_designation")))
					.append(" ~Whether on the branch panel? =").append(SetupParams.getSetupParams("SacrificeLimit",correctNull(rs.getString("branch_panel"))))
					.append(" ~Whether legal opinion Indicated clear/marketable title =").append(SetupParams.getSetupParams("SacrificeLimit",correctNull(rs.getString("legop_flag"))))
					.append(" ~Whether Valid mortgage can be created in favour of our bank =").append(SetupParams.getSetupParams("SacrificeLimit",correctNull(rs.getString("mortage_flag"))))
					.append(" ~Conditions =").append(correctNull(rs.getString("conditions")))
					.append(" ~Remarks =").append(correctNull(rs.getString("remarks")))
					.append(" ~Past 30 Years Search Report =").append(correctNull(rs.getString("past_details")));
				}
			}
			if(strAction.equalsIgnoreCase("insert"))
			{							
			  rs=DBUtils.executeLAPSQuery("legalMax^"+strAppid);	
				 			
				while(rs.next())
				{			
					intValue = correctNull((String)rs.getString("MaxSlno"));				
				}
				if(rs!=null)
				{
					rs.close();
				}
				arrValues.add(strAppid);
				arrValues.add(strOrgCode);
				arrValues.add(intValue);
				arrValues.add(correctNull((String)hshValues.get("TxtEntryDt")));
				arrValues.add(correctNull((String)hshValues.get("TxtRefNo")));
				arrValues.add(correctNull((String)hshValues.get("TxtRefDt")));
				arrValues.add(correctNull((String)hshValues.get("hid_sno")));
				arrValues.add(correctNull((String)hshValues.get("LegOpFl")));
				arrValues.add(correctNull((String)hshValues.get("MortFl")));
				arrValues.add(correctNull((String)hshValues.get("TxtCond")));
				arrValues.add(correctNull((String)hshValues.get("TxtRemark")));
				arrValues.add(correctNull((String)hshValues.get("TxtsentDt")));
				arrValues.add(correctNull((String)hshValues.get("TxtRecdDt")));
				arrValues.add(correctNull((String)hshValues.get("sel_branchpanel")));
				arrValues.add(correctNull((String)hshValues.get("TxtSearchDt")));
				arrValues.add(correctNull((String)hshValues.get("TxtPast")));
				arrValues.add(correctNull((String)hshValues.get("TxtLawDet")));
				arrValues.add(correctNull((String)hshValues.get("TxtDesign")));
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","legalopinionIns");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("update"))
			{			
				arrValues.add(strOrgCode);
				arrValues.add(correctNull((String)hshValues.get("TxtEntryDt")));
				arrValues.add(correctNull((String)hshValues.get("TxtRefNo")));
				arrValues.add(correctNull((String)hshValues.get("TxtRefDt")));
				arrValues.add(correctNull((String)hshValues.get("hid_sno")));
				arrValues.add(correctNull((String)hshValues.get("LegOpFl")));
				arrValues.add(correctNull((String)hshValues.get("MortFl")));
				arrValues.add(correctNull((String)hshValues.get("TxtCond")));
				arrValues.add(correctNull((String)hshValues.get("TxtRemark")));				
				arrValues.add(correctNull((String)hshValues.get("TxtsentDt")));
				arrValues.add(correctNull((String)hshValues.get("TxtRecdDt")));
				arrValues.add(correctNull((String)hshValues.get("sel_branchpanel")));
				arrValues.add(correctNull((String)hshValues.get("TxtSearchDt")));
				arrValues.add(correctNull((String)hshValues.get("TxtPast")));
				arrValues.add(correctNull((String)hshValues.get("TxtLawDet")));
				arrValues.add(correctNull((String)hshValues.get("TxtDesign")));
				arrValues.add(strAppid);
				arrValues.add(correctNull((String)hshValues.get("hidsno")));
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","legalopinionUpd");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");		
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				arrValues.add(strAppid);
				arrValues.add(correctNull((String)hshValues.get("hidsno")));
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","legalopinionDel");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			}				
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(!strAppid.equalsIgnoreCase(""))
			{
				sbAuditTrial.append("Date of Entry=").append(correctNull((String )hshValues.get("TxtEntryDt")))
				.append("~Date Sent =").append(correctNull((String )hshValues.get("TxtsentDt")))
				.append("~Date received =").append(correctNull((String )hshValues.get("TxtRecdDt")))
				.append("~Search Report Date =").append(correctNull((String )hshValues.get("TxtSearchDt")))
				.append("~Ref.No. =").append(correctNull((String )hshValues.get("TxtRefNo")))
				.append("~Dated =").append(correctNull((String )hshValues.get("TxtRefDt")))
				.append("~Lawyer Name=").append(correctNull((String )hshValues.get("TxtLawDet")))
				.append("~Designation =").append(correctNull((String )hshValues.get("TxtDesign")))
				.append("~Whether on the branch panel? =").append(SetupParams.getSetupParams("SacrificeLimit",correctNull((String )hshValues.get("sel_branchpanel"))))
				.append("~Whether legal opinion Indicated clear/marketable title =").append(SetupParams.getSetupParams("SacrificeLimit",correctNull((String )hshValues.get("LegOpFl"))))
				.append("~Whether Valid mortgage can be created in favour of our bank =").append(SetupParams.getSetupParams("SacrificeLimit",correctNull((String )hshValues.get("MortFl"))))
				.append("~Conditions =").append(correctNull((String)hshValues.get("TxtCond")))
				.append("~Remarks =").append(correctNull((String)hshValues.get("TxtRemark")))
				.append("~Past 30 Years Search Report =").append(correctNull((String)hshValues.get("TxtPast")));

				if(correctNull((String )hshValues.get("hidFlagAgr")).equals(""))
					{	
						AuditTrial.auditNewLog(hshValues,"241",strAppid,sbAuditTrial.toString(),sbolddata.toString());
					}
				else
					{
						AuditTrial.auditNewLog(hshValues,"218",strAppid,sbAuditTrial.toString(),sbolddata.toString());
					}
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateData "+ce.toString());
		}		
		return hshRecord;
	}
	
	public void updateValuerEntryData(HashMap hshValues)
	{		 
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();	 
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		ResultSet rs1 = null;
		String strappno ="";
		String prd_type="";
	 	String strAction = null;
		String strdateofentry = "";
		String strvaluercode = "";
		String strCertificationno = "";
		String strCertDate = "";
		String strlandvalue = "";
		String strbuildervalue = "";
		String strestimatedvalue = "";		
		String strcomments = "";
		String reference_rt = "";
		String guidance_rt = "";
		String valuation_dt = "";
		String strsno="";
		String send_date = "";
		String branchpanel= "";
		String strvaluersname="";
		String strQuery="",strcbsId="";
		StringBuilder sbolddata=new StringBuilder();
		try
		{
			java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
			nf.setGroupingUsed(false);
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);
			prd_type=correctNull((String)hshValues.get("strProductType"));
			strappno =correctNull((String)hshValues.get("appno"));		
			strAction  = correctNull((String)hshValues.get("hidAction"));
			strsno	= correctNull((String )hshValues.get("hidslno"));
			strdateofentry= correctNull((String)hshValues.get("txt_dateofentry"));			
			strvaluercode= correctNull((String)hshValues.get("hidsno"));			
			strCertificationno= correctNull((String)hshValues.get("txt_Certificationno"));			
			strCertDate= correctNull((String)hshValues.get("txt_CertDate"));			
			strlandvalue= correctNull((String)hshValues.get("txt_landvalue"));
			strcbsId= correctNull((String)hshValues.get("hidsecID"));
			if(strlandvalue.equalsIgnoreCase(""))
			{
				strlandvalue = "0.00";
			}
			strbuildervalue= correctNull((String)hshValues.get("txt_buildervalue"));
			if(strbuildervalue.equalsIgnoreCase(""))
			{
				strbuildervalue = "0.00";
			}
			strestimatedvalue= correctNull((String)hshValues.get("txt_estimatedvalue"));
			if(strestimatedvalue.equalsIgnoreCase(""))
			{
				strestimatedvalue = "0.00";
			}
			strcomments= correctNull((String)hshValues.get("txt_comments"));			
		    valuation_dt= correctNull((String)hshValues.get("txt_dateofvaluation"));
		    
			reference_rt= correctNull((String)hshValues.get("txt_refrate"));	
			if(reference_rt.equalsIgnoreCase(""))
			{
				reference_rt="0.00";
			}
			guidance_rt= correctNull((String)hshValues.get("txt_guirate"));
			if(guidance_rt.equalsIgnoreCase(""))
			{
				guidance_rt="0.00";
			}
			send_date = correctNull((String)hshValues.get("txt_dateofsent"));
			branchpanel = correctNull((String)hshValues.get("sel_branchpanel"));
			strvaluersname = correctNull((String)hshValues.get("txt_name"));
			
			/** For Audit trial old data ***//*
			if((!strappno.equalsIgnoreCase(""))&&(!branchpanel.equalsIgnoreCase("N")))
			{
				strQuery=SQLParser.getSqlQuery("Sel_valuationentry1bysno^"+strsno+"^"+strappno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					String strmarket="";
					if (prd_type.equalsIgnoreCase("pH")) 
					{
						strmarket="Market Value for the Land.";
					}
					else if (prd_type.equalsIgnoreCase("pP")) 
					{
						strmarket="Market Value for the Asset.";
					}
					else if (prd_type.equalsIgnoreCase("pA")) 
					{
						strmarket="Market Value for the Vehicle.";
					}
					else
					{
						strmarket="Market Value for the Asset.";
					}
					
					if(correctNull((String)rs.getString("branchpanel")).equalsIgnoreCase("N"))
					{
						branchpanel="No";
					}
					else if(correctNull((String)rs.getString("branchpanel")).equalsIgnoreCase("Y"))
					{
						branchpanel="Yes";
					}
					else
					{
						branchpanel="";
					}
					sbolddata.append("Date Sent =").append(correctNull(rs.getString("send_date")))
					.append(" ~Date Received =").append(correctNull(rs.getString("valuation_dt")))
					.append(" ~Date of Entry =").append(correctNull(rs.getString("entry_date")))
					.append(" ~Reference Rate (in Rs.)  =").append(ApplicationParams.getCurrency()+ " "+nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("reference_rt")))))
					.append(" ~Guidance Rate (in Rs.)  =").append(ApplicationParams.getCurrency()+ " "+nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("guidance_rt")))))
					.append(" ~Whether on the branch panel? =").append(branchpanel)
					.append(" ~Valuer Name =").append(correctNull(rs.getString("valuername")))
					.append(" ~Letter /Certification Number =").append(correctNull(rs.getString("let_cer_no"))).append(" "+correctNull(rs.getString("let_cer_date")))
					.append(" ~"+strmarket+"=").append(ApplicationParams.getCurrency()+ " "+nf.format(Double.parseDouble(Helper.correctDouble((String )rs.getString("mark_val_land")))));
					if (prd_type.equalsIgnoreCase("pH")) 
					{
						sbolddata.append(" ~Market Value for the Building=").append(ApplicationParams.getCurrency()+ " "+nf.format(Double.parseDouble(Helper.correctDouble((String )rs.getString("mark_val_build")))));
					}
					sbolddata.append(" ~Estimated value on Forced Sale =").append(ApplicationParams.getCurrency()+ " "+nf.format(Double.parseDouble(Helper.correctDouble((String )rs.getString("esti_val_force")))));
						//sbolddata.append(" ~Market Value for the Asset.  =").append(ApplicationParams.getCurrency()+ " "+correctNull((String )rs.getString("mark_val_build")));
				}
				if(rs!=null)
				{
					rs.close();
				}
			}*/
			/*** End of audit trial old data ***/
			
			if (strAction.equalsIgnoreCase("New"))
			{
				rs1=DBUtils.executeLAPSQuery("Sel_MaxId_evaluate^"+strappno);				 
				if(rs1.next())
				{	
					strsno= rs1.getString("maxid");
				}
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strappno);
				arrValues.add(strsno);
				arrValues.add(strdateofentry);
				arrValues.add(strvaluercode);
				arrValues.add(strCertificationno);
				arrValues.add(strCertDate);
				arrValues.add(strlandvalue);
				arrValues.add(strbuildervalue);
				arrValues.add(strestimatedvalue);
				arrValues.add(strcomments);
				arrValues.add(valuation_dt);
				arrValues.add(reference_rt);
				arrValues.add(guidance_rt);
				arrValues.add(send_date);
				arrValues.add(branchpanel);
				arrValues.add(strvaluersname);
				arrValues.add("Y");
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","ins_valuationentry");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			else if(strAction.equalsIgnoreCase("Edit"))
			{
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strvaluercode);
				arrValues.add(strdateofentry);
				arrValues.add(strCertificationno);
				arrValues.add(strCertDate);
				arrValues.add(strlandvalue);
				arrValues.add(strbuildervalue);
				arrValues.add(strestimatedvalue);
				arrValues.add(strcomments);
				arrValues.add( valuation_dt);
				arrValues.add(reference_rt);
				arrValues.add(guidance_rt);
				arrValues.add(send_date);
				arrValues.add(branchpanel);
				arrValues.add(strvaluersname);
				arrValues.add("Y");
				arrValues.add(strappno);
				arrValues.add(strsno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","upd_valuationentry");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				if(strcbsId.equalsIgnoreCase("")){
					arrValues.add(strappno);
					arrValues.add(strsno);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","valuerentryDel");
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
				}else{
					
					if(prd_type.equalsIgnoreCase("pH")){
						 if(rs!=null)
							  rs.close();
							rs = DBUtils.executeLAPSQuery("sel_proposedasset_sec^"+strappno+"^"+strcbsId);
							if(rs.next())
							{
								hshQueryValues=new HashMap();
		    					hshQuery=new HashMap();
		    					arrValues=new ArrayList();   
		    					arrValues.add(strappno);
		    					arrValues.add(strsno);
		    					hshQuery.put("arrValues",arrValues);
		    					hshQuery.put("strQueryId","valuerentryDel");
		    					hshQueryValues.put("size","1");
		    					hshQueryValues.put("1",hshQuery);
		    					
		    					hshQuery=new HashMap();
		    					arrValues=new ArrayList();   
		    					arrValues.add(strappno);
		    					arrValues.add(strcbsId);	    					
		    					//arrValues.add(String.valueOf(srlno));	
		    					arrValues.add(strsno);	
		    					arrValues.add(Helper.correctNull((String)rs.getString("CUS_VALSUBMITTEDDATE")));	    					
		    					arrValues.add(Helper.correctNull((String)rs.getString("CUS_VALRECVDATE")));	    					
								arrValues.add(Helper.correctNull((String)rs.getString("CUS_SEC_VALUATION_DATE")));	    					
								arrValues.add(Helper.correctNull((String)rs.getString("CUS_SEC_VALUER_NAME")));
								arrValues.add(Helper.correctNull((String)rs.getString("SEC_SALEVALUE")));	
		    					arrValues.add("N");	
								arrValues.add(Helper.correctNull((String)rs.getString("CUS_SEC_VALUERCODE")));
								hshQuery.put("arrValues",arrValues);
		    					hshQuery.put("strQueryId","ins_proposedasset_valuationEntry");
		    					hshQueryValues.put("size","2");
		    					hshQueryValues.put("2",hshQuery);
		    					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
					}
				}else if(prd_type.equalsIgnoreCase("pA")){
					 if(rs!=null)
						  rs.close();
						rs = DBUtils.executeLAPSQuery("sel_proposedasset_sec_veh^"+strappno+"^"+strcbsId);
						if(rs.next())
						{
							hshQueryValues=new HashMap();
	    					hshQuery=new HashMap();
	    					arrValues=new ArrayList();   
	    					arrValues.add(strappno);
	    					arrValues.add(strsno);
	    					hshQuery.put("arrValues",arrValues);
	    					hshQuery.put("strQueryId","valuerentryDel");
	    					hshQueryValues.put("size","1");
	    					hshQueryValues.put("1",hshQuery);
	    					
	    					hshQuery=new HashMap();
	    					arrValues=new ArrayList();   
	    					arrValues.add(strappno);
	    					arrValues.add(strcbsId);	    					
	    					arrValues.add(String.valueOf(strsno));	
	    					//arrValues.add(snmbr++);	
	    					arrValues.add(Helper.correctNull((String)rs.getString("CUS_VALSUBMITTEDDATE")));	    					
							arrValues.add(Helper.correctNull((String)rs.getString("CUS_VALRECVDATE")));	    					
							arrValues.add(Helper.correctNull((String)rs.getString("CUS_SEC_VALUATION_DATE")));	    					
							arrValues.add(Helper.correctNull((String)rs.getString("CUS_SEC_VALUER_NAME")));
							arrValues.add(Helper.correctNull((String)rs.getString("cus_sec_totalsecvalue")));
							arrValues.add("Y");
	    					arrValues.add("N");	
							arrValues.add(Helper.correctNull((String)rs.getString("CUS_SEC_VALUERCODE")));
							hshQuery.put("arrValues",arrValues);
	    					hshQuery.put("strQueryId","ins_proposedasset_valuationEntry_veh");
	    					hshQueryValues.put("size","2");
	    					hshQueryValues.put("2",hshQuery);
	    					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
						}
				}
					
				}
				
			}
			
	/** For Audit trial new data ***/
			
			StringBuilder sbAuditTrial=new StringBuilder();
			String strBranchpanel="";
			if(!strappno.equalsIgnoreCase(""))
			{
				if(Helper.correctNull((String)hshValues.get("sel_branchpanel")).equalsIgnoreCase("Y"))
					strBranchpanel="Yes";
				else strBranchpanel="No";
				
				String strmarket="";
				if (prd_type.equalsIgnoreCase("pH")) 
				{
					strmarket="Market Value for the Land.";
				}
				else if (prd_type.equalsIgnoreCase("pP")) 
				{
					strmarket="Market Value for the Asset.";
				}
				else if (prd_type.equalsIgnoreCase("pA")) 
				{
					strmarket="Market Value for the Vehicle.";
				}
				else
				{
					strmarket="Market Value for the Asset.";
				}
				sbAuditTrial.append("Date Sent =").append(correctNull((String )hshValues.get("txt_dateofsent")))
				.append("~Date Received =").append(correctNull((String )hshValues.get("txt_dateofvaluation")))
				.append("~Date of Entry =").append(correctNull((String )hshValues.get("txt_dateofentry")))
				.append("~Reference Rate (in Rs.)  =").append(ApplicationParams.getCurrency()+ " "+correctNull((String )hshValues.get("txt_refrate")))
				.append("~Guidance Rate (in Rs.)  =").append(ApplicationParams.getCurrency()+ " "+correctNull((String )hshValues.get("txt_guirate")))
				.append(" ~Whether on the branch panel? =").append(strBranchpanel)
				.append("~Valuer Name =").append(correctNull((String )hshValues.get("txt_name")))
				.append("~Letter /Certification Number =").append(correctNull((String )hshValues.get("txt_Certificationno"))).append(" "+correctNull((String )hshValues.get("txt_CertDate")));
				sbAuditTrial.append(" ~"+strmarket+" =").append(ApplicationParams.getCurrency()+ " "+correctNull((String )hshValues.get("txt_landvalue")));
				//sbAuditTrial.append(ApplicationParams.getCurrency()+ " "+correctNull((String )hshValues.get("txt_landvalue")));
				
				if(("pH").equals(correctNull((String )hshValues.get("strProductType"))))
				{
					sbAuditTrial.append("~Market Value for the Building =").append(ApplicationParams.getCurrency()+ " "+correctNull((String )hshValues.get("txt_buildervalue")));
				}
				sbAuditTrial.append("~Estimated value on Forced Sale =").append(ApplicationParams.getCurrency()+ " "+correctNull((String )hshValues.get("txt_estimatedvalue")));
				//sbAuditTrial.append("~Remarks =").append(correctNull((String )hshValues.get("txt_comments")));
				if (strAction.equalsIgnoreCase("New"))
				{
					hshValues.remove("hidAction");
					hshValues.put("hidAction","insert");
				}
				else if(strAction.equalsIgnoreCase("Edit"))
				{
					hshValues.remove("hidAction");
					hshValues.put("hidAction","update");
				}
			/*if(correctNull((String )hshValues.get("hidCategoryType")).equals("OPS"))
			{	
				AuditTrial.auditNewLog(hshValues,"214",strappno,sbAuditTrial.toString(),sbolddata.toString());
			}
			else
			{
				AuditTrial.auditNewLog(hshValues,"242",strappno,sbAuditTrial.toString(),sbolddata.toString());
			}*/
			}
			
	/** End og audit trial new data ***/
			
		}
		catch (Exception ce)
		{
			throw new EJBException("Error on found in u'r bean <-- "+ce.toString());
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
	}
	
	
	public HashMap getValuerEntryData(HashMap hshValues) 
	{ 
		String strQuery = "";
 		ResultSet rs = null;
 		ResultSet rs1 = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();
		String strappno="";
		boolean recordflag=false;
		try
		{ 
			strappno = correctNull((String)hshValues.get("appno"));
			if((strappno==null)||(strappno.equalsIgnoreCase("")))
			{
				strappno = correctNull((String)hshValues.get("strappno"));
			}	
			rs=DBUtils.executeLAPSQuery("Sel_valuationentry1^"+strappno);						
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString("app_no")));//0
				vecCol.add(correctNull(rs.getString("valu_sno")));//1
				String entry_date = correctNull(rs.getString("entry_date"));
				if(entry_date.equalsIgnoreCase("01/01/1900"))
				{
					entry_date ="";
				}
				vecCol.add(entry_date);//2
				vecCol.add(correctNull(rs.getString("valuers_code")));//3
				vecCol.add(correctNull(rs.getString("let_cer_no")));//4
				String let_cer_date = correctNull(rs.getString("let_cer_date"));
				if(let_cer_date.equalsIgnoreCase("01/01/1900"))
				{
					let_cer_date ="";
				}
				vecCol.add(let_cer_date);//5
				vecCol.add(correctNull(rs.getString("mark_val_land")));//6
				vecCol.add(correctNull(rs.getString("mark_val_build")));//7
				vecCol.add(correctNull(rs.getString("esti_val_force")));//8
				vecCol.add(correctNull(rs.getString("remark_note")));//9
				String valuation_dt = correctNull(rs.getString("valuation_dt"));
				if(valuation_dt.equalsIgnoreCase("01/01/1900"))
				{
					valuation_dt ="";
				}
			    vecCol.add(valuation_dt);//10
				vecCol.add(correctNull(rs.getString("reference_rt")));//11
				vecCol.add(correctNull(rs.getString("guidance_rt")));//12	
				vecCol.add(correctNull(rs.getString("send_date")));//13	
				vecCol.add(correctNull(rs.getString("valuers_code")));//14
				vecCol.add(correctNull(rs.getString("valuername")));//15
				vecCol.add(correctNull(rs.getString("branchpanel")));//16
				vecCol.add(correctNull(rs.getString("SEC_SECURITYID")));//17
				vecCol.add(correctNull(rs.getString("RECD_DATE")));//18
				vecRow.add(vecCol);
				recordflag=true;
			}
				
			hshRecord.put("vecRow",vecRow);	
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" +strappno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshRecord.put("appname", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}
			
			if(rs != null)
			{
				rs.close();
			} 
			rs=DBUtils.executeLAPSQuery("sel_prdDesc^"+strappno);
			if(rs.next())
			{
				hshRecord.put("prd_applicablefor", Helper.correctNull((String)rs.getString("PRD_APPLICABLEFOR")));
			}
			
			//for checking freeze count
			if(rs != null)
			{
				rs.close();
			} 
			int strFreezecount=0;
			String strFreezeflag="N",strPrioityflag="N";
			strQuery = SQLParser.getSqlQuery("sel_freezecount^" + strappno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{	
				strFreezecount=Integer.parseInt(Helper.correctInt((String)rs.getString("freezecount")));
				if(strFreezecount!=0 )
				{
					strFreezeflag="Y";
				}
			}
			if( Helper.correctNull((String)hshValues.get("hidAction")).equalsIgnoreCase("undo"))
			{
				strFreezeflag="N";
			}
			hshRecord.put("strFreezeflag",strFreezeflag);
			
			//for proposed assets check 
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_editApply_valuation^"+ strappno);
    		rs = DBUtils.executeQuery(strQuery);
			while(rs.next()) 
			{
				if(Helper.correctNull((String)rs.getString("EDIT_APPLY_FLAG")).equalsIgnoreCase("N")){
					hshRecord.put("valuationFlag","N");
				}
			}
    			
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_editApply_house^"+ strappno);
    		rs = DBUtils.executeQuery(strQuery);
			while(rs.next()) 
			{
				if(Helper.correctNull((String)rs.getString("PHPA_EDIT_APPLYFLAG")).equalsIgnoreCase("N")){
					hshRecord.put("HouseEdit_Flag","N");
				}
			}
			
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_editApply_vehicle^"+ strappno);
    		rs = DBUtils.executeQuery(strQuery);
			while(rs.next()) 
			{
				if(Helper.correctNull((String)rs.getString("AUTO_EDIT_APPLYFLAG")).equalsIgnoreCase("N")){
					hshRecord.put("VehicleEdit_Flag","N");
				}
			}
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getevaluationList "+ce.toString());
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
	public HashMap getLoanAgainstDep(HashMap hshRequestValues) 
	{
		String strQuery="", strQuery1="";
		String strQueryDep="";
 		ResultSet rs = null;
 		ResultSet rsDep = null;
 		ResultSet rs1= null;
 		ResultSet rs2= null;
		HashMap hshRecord = new HashMap();
		ArrayList vecRow =new ArrayList();
		ArrayList vecData =new ArrayList();
		String strTemp = "";
		String strAppNo="";
		String strStatus="";
		String strAlert[]= new String[500];
		int i=0;
		String strappid="",date1="",date2="",date3="", strEmployment="", strSecId="", strCBSId="";
		String strDocRecvdFrom="";
		double dblTotalRate=0.00;
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String strDepType="";
		try
		{ 
			String strAppno=correctNull((String)hshRequestValues.get("appno"));
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=Helper.correctNull((String)hshRequestValues.get("strappno"));
			}
			String strAction=Helper.correctNull((String)hshRequestValues.get("hidAction"));
			if(strAction.equalsIgnoreCase("pull"))
			{
				PullCustDepDetails(hshRequestValues);
			}
			else if(strAction.equalsIgnoreCase("pulling"))
			{
				PullOtherDepDetails(hshRequestValues);
			}
			else if(strAction.equalsIgnoreCase("undo")||strAction.equalsIgnoreCase("delete"))
			{
				UndoPulledDetails(hshRequestValues);
			}
			strappid=Helper.correctNull((String)hshRequestValues.get("hidapplicantid"));
			if(strappid.equalsIgnoreCase(""))
			{
				strappid=Helper.correctNull((String)hshRequestValues.get("hidDemoId"));
			}
			strQuery=SQLParser.getSqlQuery("sel_loanagainstdeposit^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);		
			 		
			while(rs.next())
			{
				vecRow = new ArrayList();
				String strOrgName="";
				vecRow.add(Helper.correctNull((String)rs.getString(1)));
				String strOrgCode=Helper.correctNull((String)rs.getString(2));
				if(!strOrgCode.equalsIgnoreCase(""))
				{
					strQuery1=SQLParser.getSqlQuery("selectorgname^"+strOrgCode);
					rs2=DBUtils.executeQuery(strQuery1);
					if(rs2.next())
					{
						strOrgName=Helper.correctNull((String)rs2.getString("org_name"));
					}
				}
				vecRow.add(strOrgName);
				vecRow.add(Helper.correctNull((String)rs.getString(3)));
				vecRow.add(Helper.correctNull((String)rs.getString(4)));
				
				strQueryDep=SQLParser.getSqlQuery("sel_depositaccno^"+Helper.correctNull((String)rs.getString(4)));
				rsDep=DBUtils.executeQuery(strQueryDep);
				while(rsDep.next())
				{
					strTemp = "";
					strAppNo=Helper.correctNull((String)rsDep.getString("loan_appno"));
					strStatus=Helper.correctNull((String)rsDep.getString("app_status"));
					
					if(strStatus.equalsIgnoreCase("pa"))
					{
						if(strTemp.equalsIgnoreCase(""))
							strTemp = Helper.correctNull((String)rsDep.getString("loan_appno"));
						else
							strTemp = strTemp+", "+strAppNo;
					}
				}
				if(!strTemp.equalsIgnoreCase(""))
				strAlert[i] = "Deposit "+Helper.correctNull((String)rs.getString(4))+" has already been attached with Approved Applications ("+strTemp+")";
				
				date1=Helper.correctNull((String)rs.getString(5));
				if(date1.equalsIgnoreCase("01/01/1900"))
				{
					date1="";
				}
				vecRow.add(date1);
				vecRow.add(Helper.correctNull((String)rs.getString(6)));
				vecRow.add(Helper.correctNull((String)rs.getString(7)));
				vecRow.add(Helper.correctNull((String)rs.getString(8)));
				date3=Helper.correctNull((String)rs.getString(9));
				if(date3.equalsIgnoreCase("01/01/1900"))
				{
					date3="";
				}
				vecRow.add(date3);
				vecRow.add(Helper.correctNull((String)rs.getString(10)));
				vecRow.add(Helper.correctNull((String)rs.getString(11)));
				date2=Helper.correctNull((String)rs.getString(12));
				if(date2.equalsIgnoreCase("01/01/1900"))
				{
					date2="";
				}
				vecRow.add(date2);
				vecRow.add(Helper.correctNull((String)rs.getString(13)));
				vecRow.add(Helper.correctNull((String)rs.getString(14)));
				vecRow.add(Helper.correctNull((String)rs.getString(15)));
				vecRow.add(Helper.correctNull((String)rs.getString(16)));
				vecRow.add(Helper.correctNull((String)rs.getString(17)));
				vecData.add(vecRow);
				if(Helper.correctNull((String)rs.getString("loan_banktype")).equalsIgnoreCase("1"))
				{
					hshRecord.put("strCustPullStatus","YES");
				}
				else if(Helper.correctNull((String)rs.getString("loan_banktype")).equalsIgnoreCase("2"))
				{
					hshRecord.put("strOtherPullStatus","YES");
				}
				dblTotalRate=dblTotalRate+Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_presentos")));
				i++;
			}
			
			int strlen = strAlert.length;
			strTemp = "";
			for(int j=0;j<strlen;j++)
			{
				if(!Helper.correctNull((String)strAlert[j]).equalsIgnoreCase(""))
				{
					if(strTemp.equalsIgnoreCase(""))
						strTemp = strAlert[j];
					else
						strTemp = strTemp+", "+strAlert[j];
				}
			}
			
			agrotherBean.updateSecurityValue(strAppno, dblTotalRate);
			updateLoanRecmdAmtData(strAppno, dblTotalRate);
			if(!strappid.equalsIgnoreCase(""))
			{
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("selcustomerdetails^"+strappid);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strEmployment=Helper.correctNull((String)rs.getString("perapp_employment"));
					strCBSId=Helper.correctNull((String)rs.getString("perapp_cbsid"));
				}
			}
			if(rs !=null)
			{
				rs.close();
			}
			if(!strappid.equalsIgnoreCase(""))
			{
				rs = DBUtils.executeLAPSQuery("select_perappoldid^" + strappid);
				if(rs.next())
				{
					strappid=Helper.correctNull((String)rs.getString("perapp_oldid"));
				}
				if(rs!=null)
				{
					rs.close();
				}
			}
//			if(!strappid.equalsIgnoreCase(""))
//			{
//				strQuery = SQLParser.getSqlQuery("lapsid_sel^" + strappid);
//				rs = DBUtils.executeQuery(strQuery);
//				while(rs.next()) 
//				{
//					strSecId=Helper.correctNull((String)rs.getString("cus_owner_security_id"));
//				}
//			}
			if(strAction.equalsIgnoreCase("pulling"))
			{
				 hshRecord.put("strLoadFlag","Y");
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("getlreq^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()) 
			{
				strDocRecvdFrom=Helper.correctNull((String)rs.getString("loan_docrecvd"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("findapptype^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()) 
			{
				hshRecord.put("prd_deposittype",Helper.correctNull(rs.getString("prd_deposittype")));
				hshRecord.put("prd_depositloanfor",Helper.correctNull(rs.getString("prd_depositloanfor")));
				strDepType=Helper.correctNull(rs.getString("prd_deposittype"));
			}
			hshRecord.put("strSecId",strSecId);
			hshRecord.put("strEmployment",strEmployment);
			hshRecord.put("vecData",vecData);	
			hshRecord.put("id1",strappid);				
			hshRecord.put("strCBSId",strCBSId);					
			hshRecord.put("strAlert", strTemp);
					
			hshRecord.put("strDocRecvdFrom",strDocRecvdFrom);	
			
			
			if(strDepType.equalsIgnoreCase("G"))
			{
				if(Helper.correctNull((String)hshRecord.get("strOtherPullStatus")).equalsIgnoreCase("YES"))
				{
					if(rs!=null)
					{
						rs.close();
					}
					strQuery = SQLParser.getSqlQuery("getappamt^" + strAppno);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next()) 
					{
						if(Helper.correctNull(rs.getString("loan_mclrtype")).equalsIgnoreCase(""))
						{
							hshQueryValues=new HashMap();
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","updateloandetails_deposit");
							arrValues.add("0.00");
							arrValues.add("0.00");
							arrValues.add("0");
							arrValues.add("");
							arrValues.add("");
							arrValues.add(strAppno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size","1");
							hshQueryValues.put("1",hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
							
							hshRecord.put("strOtherDepFlag","Y");	
							
							
						}
					}
				}
				else
				{
					
					double dblROI=0.0,dblFinalROI=0.0;
					if(rs!=null)
						rs.close();
					
					strQuery=SQLParser.getSqlQuery("sel_loanagainstdeposit^"+strAppno);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
							dblROI=rs.getDouble("loan_rateincharges");
							dblFinalROI=Math.max(dblFinalROI,dblROI);
					}
					
					hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","updateloandetails_deposit");
					arrValues.add(String.valueOf(dblFinalROI));
					arrValues.add(String.valueOf(dblFinalROI));
					arrValues.add("Fixed");
					arrValues.add("");
					arrValues.add("");
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}
			
			if(strAction.equalsIgnoreCase("pull")||strAction.equalsIgnoreCase("pulling")||strAction.equalsIgnoreCase("undo")||strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_date");
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getsecurityList "+ce.toString());
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
	public void updateLoanAgainstDep(HashMap hshValues) 
	{
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		HashMap hshRecord=new HashMap();
		ArrayList arrValues ;		 
		ResultSet rs=null;
		String strAction=null,strQuery="";
		String strRecptno ="";			
		String strIssuseoffice="";
		String strStandname="";			
		String strAccountno ="";
		String  strFacevalue ="",strIssuedate="",str_txtrateofint="",str_txtprsntos="",str_txtmargin="",txtpresentdate="";
		String  str_txtmatval="",str_txttenure="",str_txtmatdate="",str_txtdeppercent;
		String strAppno="";
		String strid="";
		String strBankType="";
		String strSecId="";
		String noOfCustomers="1";
		StringBuilder sbolddata=new StringBuilder();
		HashMap hshResult=new HashMap();
		try
		{
			String strAppid=Helper.correctNull((String)hshValues.get("hidapplicantid"));
			SecurityMasterBean SM=new SecurityMasterBean();
			rs = DBUtils.executeLAPSQuery("select_perappoldid^" + strAppid);
			if(rs.next())
			{
				strAppid=Helper.correctNull((String)rs.getString("perapp_oldid"));
			}
			hshValues.put("strAppid", strAppid);
			strAction =correctNull((String)hshValues.get("hidAction"));
			strid=correctNull((String)hshValues.get("hid_sno"));
			strAppno=correctNull((String)hshValues.get("appno"));
			strRecptno = correctNull((String)hshValues.get("txtreceiptno"));		
			strIssuseoffice = correctNull((String)hshValues.get("txtissuseoffice"));			
			strStandname = correctNull((String)hshValues.get("txtstandname"));
			strAccountno = correctNull((String)hshValues.get("txtaccountno"));
			strIssuedate= correctNull((String)hshValues.get("txt_issuedate"));
			if(strIssuedate.equalsIgnoreCase(""))
			{
				strIssuedate="01/01/1900";
			}
			
			strFacevalue= correctNull((String)hshValues.get("txtfacevalue"));
			str_txtrateofint= correctNull((String)hshValues.get("txt_rateofint"));
			str_txtprsntos= correctNull((String)hshValues.get("txt_prsntos"));
			txtpresentdate= correctNull((String)hshValues.get("txtpresentdate"));
			str_txtmatval= correctNull((String)hshValues.get("txt_matval"));
			str_txttenure= correctNull((String)hshValues.get("txttenure"));
			str_txtmatdate= correctNull((String)hshValues.get("txtmatdate"));
			if(str_txtmatdate.equalsIgnoreCase(""))
			{
				str_txtmatdate="01/01/1900";
			}
			str_txtmargin= correctNull((String)hshValues.get("txtmargin"));
			str_txtdeppercent= correctNull((String)hshValues.get("txtdeppercent"));
		  
			
			if (strFacevalue.equals(""))
			{
				strFacevalue = "0";
			}			
			if (str_txtrateofint.equals(""))
			{
				str_txtrateofint = "0";
			}			
			if (str_txtprsntos.equals(""))
			{
				str_txtprsntos = "0";
			}
			if (txtpresentdate.equals(""))
			{
				txtpresentdate ="01/01/1900";
			}
			
			if (str_txtmatval.equals(""))
			{
				str_txtmatval = "0";
			}
			if (str_txtdeppercent.equals(""))
			{
				str_txtdeppercent = "0";
			}
			if (str_txtmargin.equals(""))
			{
				str_txtmargin = "0";
			}
			strBankType=Helper.correctNull((String)hshValues.get("sel_banktype"));
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				strQuery=SQLParser.getSqlQuery("sel_loanagainstdepositbysno^"+strid+"^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					sbolddata.append(" ~Issuing branch/ post office ="+correctNull(rs.getString("loan_issuebranch"))).append(" ~Standing in the name of =").append(correctNull(rs.getString("loan_STANDNAME")))
					.append(" ~Account no. =").append(correctNull(rs.getString("loan_accno"))).append(" ~Date of issue =").append(correctNull(rs.getString("laon_dateofissue")))
					.append(" ~Face value (Rs)  =").append(correctNull(rs.getString("loan_faceval"))).append(" ~Rate of interest % =").append(correctNull(rs.getString("loan_rateofint")))
					.append(" ~Present value (Rs) =").append(correctNull(rs.getString("loan_presentos")))
					.append(" ~Maturity value (Rs) =").append(correctNull(rs.getString("loan_maturityval")))
					.append(" ~Maturity date =").append(correctNull(rs.getString("loan_matdate"))).append(" ~Rate of interest charged on loan/overdraft against deposit % =").append(correctNull(rs.getString("loan_rateincharges")))
					.append(" ~Margin % =").append(correctNull(rs.getString("loan_margin")));
				}
			}
			String strSecUpdFlag="N";
			hshRecord.put("hidAction",strAction);
			hshRecord.put("sel_bank",strBankType);
			hshRecord.put("strFldName",strIssuseoffice);
			hshRecord.put("strFldCode","");
			hshRecord.put("txt_accountno",strAccountno);
			hshRecord.put("txt_rateintrest",str_txtrateofint);
			hshRecord.put("txt_Issue_Date",strIssuedate);
			hshRecord.put("txt_Face_PrinciValue",strFacevalue);
			hshRecord.put("txt_Maturity_Value",str_txtmatval);
			hshRecord.put("txt_Present_BookValue",str_txtprsntos);
			hshRecord.put("txt_Due_Date",str_txtmatdate);
			if(strAction.equals("insert"))
			{
				/* Changes by Karthikeyan.S
				 * For updating Bank Deposit details in Securities if Data is available in Securities page for given A/c no.
				 */
				hshResult=updateSecurities(hshValues);
				strSecUpdFlag=Helper.correctNull((String)hshResult.get("strSecUpdFlag"));
				strSecId=Helper.correctNull((String)hshResult.get("hidSecurityId"));
				hshRecord.put("hidSecurityId",strSecId);
				SM.updateSecurityBankDeposit(hshRecord);
				/* End */
				if(rs!=null)
				{
					rs.close();
				}
				str_txtdeppercent=getROIData(hshValues);
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","Ins_loanagainstdep");
				arrValues=new ArrayList();
				rs=DBUtils.executeLAPSQuery("Sel_MaxId_loanagainstdep^"+strAppno);
				 
				if(rs.next())
				{
					strid = correctNull((String)rs.getString("maxid"));
				}
				arrValues.add(strid);				
				arrValues.add(strAppno);
				arrValues.add(strIssuseoffice);
				arrValues.add(strStandname);
				arrValues.add(strAccountno);				
				arrValues.add(strIssuedate);
				arrValues.add(strFacevalue);
				arrValues.add(str_txtrateofint);	
				arrValues.add(str_txtprsntos);
				arrValues.add(txtpresentdate);
				arrValues.add(str_txtmatval);	
				arrValues.add(str_txttenure);	
				arrValues.add(str_txtmatdate);	
				arrValues.add(str_txtdeppercent);	
				arrValues.add(str_txtmargin);	
				arrValues.add(strBankType);	
				arrValues.add(strSecId);
				arrValues.add(strSecUpdFlag);
				arrValues.add("L");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equals("update"))
			{
				hshResult=updateSecurities(hshValues);
				strSecUpdFlag=Helper.correctNull((String)hshResult.get("strSecUpdFlag"));
				strSecId=Helper.correctNull((String)hshResult.get("hidSecurityId"));
				hshRecord.put("hidSecurityId",strSecId);
				SM.updateSecurityBankDeposit(hshRecord);
				
				
				str_txtdeppercent=getROIData(hshValues);
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","Upd_loanagainstdep");
				arrValues=new ArrayList();
				arrValues.add(strIssuseoffice);
				arrValues.add(strStandname);
				arrValues.add(strAccountno);				
				arrValues.add(strIssuedate);
				arrValues.add(strFacevalue);
				arrValues.add(str_txtrateofint);	
				arrValues.add(str_txtprsntos);	
				arrValues.add(txtpresentdate);
				arrValues.add(str_txtmatval);	
				arrValues.add(str_txttenure);	
				arrValues.add(str_txtmatdate);	
				arrValues.add(str_txtdeppercent);	
				arrValues.add(str_txtmargin);	
				arrValues.add(strBankType);	
				strSecId=correctNull((String)hshValues.get("hidSecurityId"));
				arrValues.add(strSecId);
				//arrValues.add(strSecUpdFlag);
				arrValues.add(strAppno);
				arrValues.add(strid);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");				
			}			
			else if(strAction.equals("delete"))
			{
				/* Changes by Karthikeyan.S
				 * For deleting Bank Deposit details in Securities
				 */
				String strUpdFlag="";
				strSecId=correctNull((String) hshValues.get("hidSecurityId"));
				if(!strSecId.equalsIgnoreCase(""))
				{
					if(rs!=null)
					{
						rs.close();
					}
					strQuery=SQLParser.getSqlQuery("sel_depositupdflag^"+strSecId);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strUpdFlag=Helper.correctNull((String)rs.getString("loan_updflag"));
					}
					if(!strUpdFlag.equalsIgnoreCase("Y"))
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "del_securities");
						arrValues.add(strSecId);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("1", hshQuery);
		
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "del_ownership_securities");
						arrValues.add(strSecId);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("2", hshQuery);
						hshQueryValues.put("size", "2");
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						hshRecord.put("hidSecurityId",strSecId);
						SM.updateSecurityBankDeposit(hshRecord);
					}
				}
				/* End */
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","Del_loanagnstdep");
				arrValues=new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(strid);				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}	
			
//			    String ratecharge="";
//				strQuery=SQLParser.getSqlQuery("sel_maxrateincharges^"+strAppno);
//				rs=DBUtils.executeQuery(strQuery);	
//				if(rs.next())
//				{
//					ratecharge=correctNull((String)rs.getString("loan_rateincharges"));	
//				}
//				if(ratecharge.equals(""))
//				{
//					strQuery=SQLParser.getSqlQuery("selperprdmargin^"+strAppno);
//					rs=DBUtils.executeQuery(strQuery);	
//					if(rs.next())
//					{
//						ratecharge=correctNull((String)rs.getString("loan_intrate"));	
//					}
//				}
//				hshQueryValues = new HashMap();
//				hshQuery=new HashMap();
//				hshQuery.put("strQueryId","upd_interest_loandetails");
//				arrValues=new ArrayList();
//				arrValues.add(ratecharge);
//				arrValues.add(strAppno);
//				hshQuery.put("arrValues",arrValues);
//				hshQueryValues.put("1",hshQuery);
//				hshQueryValues.put("size","1");
//				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				StringBuilder sbAuditTrial=new StringBuilder();
				sbAuditTrial.append("Deposit/NSC receipt no  =").append(correctNull((String )hshValues.get("txtreceiptno"))).append("~Issuing branch/ post office ="+correctNull((String )hshValues.get("txtissuseoffice"))).append("~Standing in the name of =").append(correctNull((String )hshValues.get("txtstandname")))
				.append("~Account no. =").append(correctNull((String )hshValues.get("txtaccountno"))).append("~Date of issue =").append(correctNull((String )hshValues.get("txt_issuedate")))
				.append("~Face value (Rs)  =").append(correctNull((String )hshValues.get("txtfacevalue"))).append("~Rate of interest % =").append(correctNull((String )hshValues.get("txt_rateofint")))
				.append("~Present value (Rs) =").append(correctNull((String )hshValues.get("txt_prsntos")))
				.append("~Maturity value (Rs) =").append(correctNull((String )hshValues.get("txt_matval")))
				.append("~Maturity date =").append(correctNull((String )hshValues.get("txtmatdate"))).append("~Rate of interest charged on loan/overdraft against deposit % =").append(correctNull((String )hshValues.get("txtdeppercent")))
				.append("~Margin % =").append(correctNull((String )hshValues.get("txtmargin")));
				
			//	AuditTrial.auditLog(hshValues,"141",strAppno,sbAuditTrial.toString());
				AuditTrial.auditNewLog(hshValues,"141",strAppno,sbAuditTrial.toString(),sbolddata.toString());
			
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
			}
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}	
	}
	private HashMap updateSecurities(HashMap hshValues) 
	{
		ResultSet rs=null;
		String strAccountno="" , strQuery="" ,strSecUpdFlag="",strSecId="N",strAppid="";
		String str_txtprsntos="";
		String noOfCustomers="1";
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		HashMap hshRecord=new HashMap();
		String strExp="$";
		String strCBSID="";
		String strName="";
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		try
		{
			strAppid=Helper.correctNull((String)hshValues.get("strAppid"));
			strAccountno=Helper.correctNull((String)hshValues.get("txtaccountno"));
			str_txtprsntos=Helper.correctNull((String)hshValues.get("txt_prsntos"));
			SecurityMasterBean SM=new SecurityMasterBean();
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("sel_bnkdepdetails^"+strAccountno+"^7"+"^45");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				String strCustomerID=Helper.correctNull((String)rs.getString("perapp_oldid"));
	
				if(strAppid.equalsIgnoreCase(strCustomerID))
				{
					strSecUpdFlag="Y";
					strSecId=Helper.correctNull((String)rs.getString("sec_id"));
				}
				else
				{
					/*
					 * Account number of some other customer id should not be attached
					 */
					strCBSID=Helper.correctNull((String)rs.getString("perapp_cbsid"));
					strName=Helper.correctNull((String)rs.getString("perapp_fname"));
					strExp=strExp+"The Account No. "+strAccountno+" is related to the customer "+strName+" with CBSID " +strCBSID;
					throw new Exception(strExp);
				}
			}
			if(!strSecUpdFlag.equalsIgnoreCase("Y"))
			{		
				strSecId=SM.getOldAppidWithSno(strAppid);
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_securitiesgolddep");
				arrValues.add(strSecId);
				arrValues.add("7");
				arrValues.add("45");
				arrValues.add("N");
				arrValues.add(str_txtprsntos);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_ownership_securities");
				arrValues.add(strSecId);
				arrValues.add(strAppid);
				arrValues.add(noOfCustomers);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				hshQueryValues.put("size", "2");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			hshRecord.put("hidSecurityId",strSecId);
			hshRecord.put("strSecUpdFlag",strSecUpdFlag);
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
			}
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}
		return hshRecord;
	}
	
	/**
	 * @author : S.SATHYA MOORTHY
	 * @since  :17/12/2008
	 * @param hashmap
	 * @pupose : For Renewal Details.(UPDATE DATA)
	 */
	public void updateRenewalDetails(HashMap hashmap)
	{
		HashMap hshQueryValues=null;
		HashMap hshQuery=null;
		ArrayList arrValues=null;
		int intupdatesize=0;
		
		try
		{
			
			String strAppno=correctNull((String)hashmap.get("appno"));
			String strhidAction=correctNull((String)hashmap.get("hidAction"));
			hshQueryValues = new HashMap();
			
			if("update".equals(strhidAction))
			{
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","Del_renewaldetails");
				arrValues=new ArrayList();
				intupdatesize++;
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intupdatesize,hshQuery);
				
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","ins_renewaldetails");
				arrValues=new ArrayList();
				intupdatesize++;
				arrValues.add(strAppno);
				arrValues.add(correctNull((String)hashmap.get("txtarea_compliance")));
				arrValues.add(correctNull((String)hashmap.get("txtarea_documents")));
				arrValues.add(correctNull((String)hashmap.get("txtarea_fdr")));
				arrValues.add(correctNull((String)hashmap.get("txtarea_audit")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intupdatesize,hshQuery);
							
			}
			else if("delete".equals(strhidAction))
			{
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","Del_renewaldetails");
				arrValues=new ArrayList();
				intupdatesize++;
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intupdatesize,hshQuery);
			}
			hshQueryValues.put("size",""+intupdatesize);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			
		}catch(Exception e){
			throw new EJBException(e.getMessage());
		}
		finally{
			
		}
 	}
	
	
	
	/**
	 * @author : S.SATHYA MOORTHY
	 * @since  :17/12/2008
	 * @param hashmap
	 * @pupose : For Renewal Details.(UPDATE DATA)
	 */
	public HashMap getRenewalDetails(HashMap hashmap)
	{
		ResultSet rs=null;
		HashMap hshRecord=new HashMap();
		try
		{
			String strAppno=correctNull((String)hashmap.get("appno"));
			rs=DBUtils.executeQuery(SQLParser.getSqlQuery("get_renewalDetails^"+strAppno));
			if(rs.next())
			{	
				hshRecord.put("per_appno",correctNull(rs.getString("per_appno")));	
				hshRecord.put("txtarea_compliance",correctNull(rs.getString("per_compliance")));	
				hshRecord.put("txtarea_documents",correctNull(rs.getString("per_documents")));	
				hshRecord.put("txtarea_fdr",correctNull(rs.getString("per_fdc")));	
				hshRecord.put("txtarea_audit",correctNull(rs.getString("per_audit")));	
			}	
						
		}catch(Exception e){
			throw new EJBException(e.getMessage());
		}
		finally{
			try{if(rs!=null)rs.close();}catch(Exception e){throw new EJBException(e.getMessage());}
		}
		
		
		return hshRecord;
	}
	public void updateHousingLoanData(HashMap hshValues) 
	{	
		ArrayList arrValues = new ArrayList();
		HashMap hshQuery = new HashMap();
		ResultSet rs=null,rs1=null;
		String strQuery="",currentdate="";
		HashMap hshQueryValues = new HashMap();
		String strAppno=correctNull((String)hshValues.get("appno"));
		String strAction="",strSecId="";
		StringBuilder sbOldAudit = new StringBuilder();
		StringBuilder sbAuditTrial=new StringBuilder();
		String noOfCustomers="1",strOwnerCount="",strloanpurpose="",strpropertytype="";
		int intOwnerCount=0,intAtuoCount=0;
		double strsec_val = 0.00;
		int intDeleteOwn=0;
		String strDeleteOwn="",maxno="0";		
		try
		{	
			strAction  = correctNull((String)hshValues.get("hidAction"));
			SecurityMasterBean SM=new SecurityMasterBean();
			String strAppid=Helper.correctNull((String)hshValues.get("hidapplicantid"));
			
			rs = DBUtils.executeLAPSQuery("select_perappoldid^" + strAppid);
			if(rs.next())
			{
				strAppid=Helper.correctNull((String)rs.getString("perapp_oldid"));
			}
			
			strloanpurpose=correctNull((String) hshValues.get("sel_purpose_of_loan"));
			strpropertytype=correctNull((String) hshValues.get("sel_property_type"));
			
			strOwnerCount=Helper.correctInt((String)hshValues.get("hidOwners"));
			strDeleteOwn=Helper.correctInt((String)hshValues.get("hidDeleteOwn"));	
			String strhidapplicantid = Helper.correctNull((String) hshValues.get("hidapplicantid"));
			if(strhidapplicantid.equals(""))
			{
				strhidapplicantid = Helper.correctNull((String) hshValues.get("appid"));
			}
			intOwnerCount=Integer.parseInt(strOwnerCount);
			intDeleteOwn=Integer.parseInt(strDeleteOwn);
	/*** For Audit Trial Old Data - By Guhan.T on 11/10/2013 ***/
			
			if(!strAppno.equalsIgnoreCase(""))
			{				
				strQuery=SQLParser.getSqlQuery("sel_per_house_proposed_asset^" + strAppno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
					{
					String strloanpurposeoldaudit=Helper.correctNull(rs.getString("phpa_loan_purpose"));
					String strtakeoveroldaudit=Helper.correctNull(rs.getString("phpa_take_over"));
					String strpropertytypeoldaudit=Helper.correctNull(rs.getString("phpa_prop_type"));
					String strpropertynatureoldaudit=Helper.correctNull(rs.getString("phpa_prop_nature"));
					String strpropusedforoldaudit=Helper.correctNull(rs.getString("phpa_prop_usedfor"));
					String strpremisesageoldaudit=Helper.correctNull(rs.getString("phpa_premises_age"));
					String strresiduallifeoldaudit=Helper.correctNull(rs.getString("phpa_residual_life"));
					String strbranchdistoldaudit=Helper.correctNull(rs.getString("phpa_branch_distance"));
					String strproplocationoldaudit=Helper.correctNull(rs.getString("phpa_prop_location"));
					String strpropsurveynooldaudit=Helper.correctNull(rs.getString("phpa_prop_surveyno"));
					String strpropplotnooldaudit=Helper.correctNull(rs.getString("phpa_prop_plotno"));
					String strpropstreetoldaudit=Helper.correctNull(rs.getString("phpa_prop_street"));
					String strproptalukoldaudit=Helper.correctNull(rs.getString("phpa_prop_taluk"));
					String strpropcityoldaudit=Helper.correctNull(rs.getString("phpa_prop_city"));
					String strpropdistrictoldaudit=Helper.correctNull(rs.getString("phpa_prop_district"));
					String strpropstateoldaudit=Helper.correctNull(rs.getString("phpa_prop_state"));
					String strproppinoldaudit=Helper.correctNull(rs.getString("phpa_prop_pincode"));
					String strpropareaoldaudit=Helper.correctNull(rs.getString("phpa_site_area"));
					String strfloorspaceareaoldaudit=Helper.correctNull(rs.getString("phpa_floorspace_area"));
					String strmarketvalueoldaudit=Helper.correctNull(rs.getString("phpa_site_market_value"));
					String strpurchasevalueoldaudit=Helper.correctNull(rs.getString("phpa_site_purchase_price"));
					String strvaluationcostoldaudit=Helper.correctNull(rs.getString("phpa_site_valuation_cost"));
					String strbldgmarketvalueoldaudit=Helper.correctNull(rs.getString("phpa_bldg_market_value"));
					String strbldgpurchaseoldaudit=Helper.correctNull(rs.getString("phpa_bldg_purchase_price"));
					String strbldgvaluationoldaudit=Helper.correctNull(rs.getString("phpa_bldg_valuation_cost"));
					String strbldgestimatecostoldaudit=Helper.correctNull(rs.getString("phpa_bldg_estimate_cost"));
					String strbldgrenovationcostoldaudit=Helper.correctNull(rs.getString("phpa_constucion_cost"));
					String strprojnameoldaudit=Helper.correctNull(rs.getString("phpa_project_name"));
					String strprojdetailsoldaudit=Helper.correctNull(rs.getString("phpa_project_details"));
					String strbuildernameoldaudit=Helper.correctNull(rs.getString("phpa_builder_name"));
					String strbuilderbackgrndoldaudit=Helper.correctNull(rs.getString("phpa_builder_background"));
					String strprojfinanceoldaudit=Helper.correctNull(rs.getString("phpa_project_finance"));
					String strlocroadoldaudit=Helper.correctNull(rs.getString("phpa_loc_road"));
					String strlocmarketoldaudit=Helper.correctNull(rs.getString("phpa_loc_market"));
					String strlocpublicoldaudit=Helper.correctNull(rs.getString("phpa_loc_public"));
					String strlocneighbouroldaudit=Helper.correctNull(rs.getString("phpa_loc_neighbourhood"));
					String strameroadoldaudit=Helper.correctNull(rs.getString("phpa_ame_road"));
					String stramewateroldaudit=Helper.correctNull(rs.getString("phpa_ame_water"));
					String strdrainageoldaudit=Helper.correctNull(rs.getString("phpa_ame_drainage"));
					String strelectricityoldaudit=Helper.correctNull(rs.getString("phpa_ame_electricity"));
					String stralrdymortageoldaudit=Helper.correctNull(rs.getString("phpa_already_mortgage"));
					String strnatureofcharge=Helper.correctNull(rs.getString("phpa_natureofcharge"));
					String strloanpurposeoption="";
					String strtakeoveroption="";
					String strpropertytypeoption="";
					String strpropertynatureoption="";
					String strpropusedforoption="";
					String strmortageoptionoption="";
					String strproplocationoption="";
					String strprojfinanceoption="";
					String strlocroadoption="";
					String strlocmarketoption="";
					String strlocpublicoption="";
					String strlocneighbouroption="";
					String strameroadoption="";
					String stramewateroption="";
					String strdrainageoption="";
					String strelectricityoption="";
					String strmetlifesuraksha=Helper.correctNull(rs.getString("phpa_metlifepremiumamt"));
					
					if(strlocroadoldaudit.equalsIgnoreCase("Y"))
						strlocroadoption = "Yes";
					else strlocroadoption = "No";
					if(strlocmarketoldaudit.equalsIgnoreCase("Y"))
						strlocmarketoption = "Yes";
					else strlocmarketoption = "No";
					if(strlocpublicoldaudit.equalsIgnoreCase("Y"))
						strlocpublicoption = "Yes";
					else strlocpublicoption = "No";
					if(strlocneighbouroldaudit.equalsIgnoreCase("Y"))
						strlocneighbouroption = "Yes";
					else strlocneighbouroption = "No";
					if(strameroadoldaudit.equalsIgnoreCase("Y"))
						strameroadoption = "Yes";
					else strameroadoption = "No";
					if(stramewateroldaudit.equalsIgnoreCase("Y"))
						stramewateroption = "Yes";
					else stramewateroption = "No";
					if(strdrainageoldaudit.equalsIgnoreCase("Y"))
						strdrainageoption = "Yes";
					else strdrainageoption = "No";
					if(strelectricityoldaudit.equalsIgnoreCase("Y"))
						strelectricityoption = "Yes";
					else strelectricityoption = "No";					
					
					if(strloanpurposeoldaudit.equalsIgnoreCase("0"))
						strloanpurposeoption = "Select";
					else if(strloanpurposeoldaudit.equalsIgnoreCase("G"))
						strloanpurposeoption = "Purchase of Site";
					else if(strloanpurposeoldaudit.equalsIgnoreCase("C"))
						strloanpurposeoption = "Construction of House";
					else if(strloanpurposeoldaudit.equalsIgnoreCase("S"))
						strloanpurposeoption = "Purchase of Site & Construction of House";
					else if(strloanpurposeoldaudit.equalsIgnoreCase("H"))
						strloanpurposeoption = "Purchase of Ready Built House/Flat";
					else if(strloanpurposeoldaudit.equalsIgnoreCase("R"))
						strloanpurposeoption = "Renovation";
					else if(strloanpurposeoldaudit.equalsIgnoreCase("M"))
						strloanpurposeoption = "Mortgage";
						
					if(strtakeoveroldaudit.equalsIgnoreCase("0"))
						strtakeoveroption = "Select";
					else if(strtakeoveroldaudit.equalsIgnoreCase("Y"))
						strtakeoveroption = "Yes";
					else if(strtakeoveroldaudit.equalsIgnoreCase("N"))
						strtakeoveroption = "No";
					
					if(strpropertytypeoldaudit.equalsIgnoreCase("0"))
						strpropertytypeoption = "Select";
					else if(strpropertytypeoldaudit.equalsIgnoreCase("L"))
						strpropertytypeoption = "Land";
					else if(strpropertytypeoldaudit.equalsIgnoreCase("F"))
						strpropertytypeoption = "Flat / Apartment";
					else if(strpropertytypeoldaudit.equalsIgnoreCase("H"))
						strpropertytypeoption = "House / Building";
					
					if(strpropertynatureoldaudit.equalsIgnoreCase("0"))
						strpropertynatureoption = "Select";
					else if(strpropertynatureoldaudit.equalsIgnoreCase("R"))
						strpropertynatureoption = "Residential";
					else if(strpropertynatureoldaudit.equalsIgnoreCase("C"))
						strpropertynatureoption = "Commercial";
					
					if(strpropusedforoldaudit.equalsIgnoreCase("0"))
						strpropusedforoption = "Select";
					else if(strpropusedforoldaudit.equalsIgnoreCase("R"))
						strpropusedforoption = "Renting Out";
					else if(strpropusedforoldaudit.equalsIgnoreCase("O"))
						strpropusedforoption = "Self Occupation";
					else if(strpropusedforoldaudit.equalsIgnoreCase("L"))
						strpropusedforoption = "Leasing Out";
					else if(strpropusedforoldaudit.equalsIgnoreCase("C"))
						strpropusedforoption = "Commercial";
					
					if(stralrdymortageoldaudit.equalsIgnoreCase("0"))
						strmortageoptionoption = "Select";
					else if(stralrdymortageoldaudit.equalsIgnoreCase("Y"))
						strmortageoptionoption = "Yes";
					else if(stralrdymortageoldaudit.equalsIgnoreCase("N"))
						strmortageoptionoption = "No";
					
					if(strproplocationoldaudit.equalsIgnoreCase("0"))
						strproplocationoption = "Select";
					else if(strproplocationoldaudit.equalsIgnoreCase("M"))
						strproplocationoption = "Metro";
					else if(strproplocationoldaudit.equalsIgnoreCase("U"))
						strproplocationoption = "Urban";
					else if(strproplocationoldaudit.equalsIgnoreCase("S"))
						strproplocationoption = "Semi-Urban";
					else if(strproplocationoldaudit.equalsIgnoreCase("R"))
						strproplocationoption = "Rural";
					
					if(strprojfinanceoldaudit.equalsIgnoreCase("0"))
						strprojfinanceoption = "Select";
					else if(strprojfinanceoldaudit.equalsIgnoreCase("Y"))
						strprojfinanceoption = "Yes";
					else if(strprojfinanceoldaudit.equalsIgnoreCase("N"))
						strprojfinanceoption = "No";
					
					sbOldAudit.append("~Purpose of Loan= ").append(strloanpurposeoption)
					.append("~Whether Take-Over= ").append(strtakeoveroption)
					.append("~Type of Property= ").append(strpropertytypeoption)
					.append("~Nature of Property= ").append(strpropertynatureoption)
					.append("~Property used for= ").append(strpropusedforoption)
					.append("~Age of the Premises= ").append(strpremisesageoldaudit)
					.append("~Residual Life of Premises= ").append(strresiduallifeoldaudit)
					.append("~Distance from Branch = ").append(strbranchdistoldaudit)
					.append("~Whether Property Already Mortgaged= ").append(strmortageoptionoption)
					.append("~Location of Property = ").append(strproplocationoption)
					.append("~Survey No.= ").append(strpropsurveynooldaudit)
					.append("~House/Plot No.= ").append(strpropplotnooldaudit)
					.append("~Street= ").append(strpropstreetoldaudit)
					.append("~Taluk= ").append(strproptalukoldaudit)
					.append("~City/Town= ").append(strpropcityoldaudit)
					.append("~District= ").append(strpropdistrictoldaudit)
					.append("~State= ").append(strpropstateoldaudit)
					.append("~Pincode= ").append(strproppinoldaudit)
					.append("~Area of Site= ").append(strpropareaoldaudit)
					.append("~Floor Space/Builtup Area= ").append(strfloorspaceareaoldaudit)
					.append("~Market Value of Site= ").append(strmarketvalueoldaudit)
					.append("~Purchase Value of Site= ").append(strpurchasevalueoldaudit)
					.append("~Market Value of Building/Flat= ").append(strbldgmarketvalueoldaudit)
					.append("~Purchase Value of Building/Flat= ").append(strbldgpurchaseoldaudit)
					.append("~Estimated Cost of Construction= ").append(strbldgestimatecostoldaudit)
					.append("~Cost of Renovation= ").append(strbldgrenovationcostoldaudit)
					.append("~Valuation Price of Site= ").append(strvaluationcostoldaudit)
					.append("~Valuation Price of Building/Flat= ").append(strbldgvaluationoldaudit)
					.append("~Project Name= ").append(strprojnameoldaudit)
					.append("~Builder Name= ").append(strbuildernameoldaudit)
					.append("~Project Details= ").append(strprojdetailsoldaudit)
					.append("~Background of Builder= ").append(strbuilderbackgrndoldaudit)
					.append("~Whether the project finance is sanctioned in our bank= ").append(strprojfinanceoption)
					.append("~Location [Indicators]")
					.append("~Near by Main Road= ").append(strlocroadoption)
					.append("~Near by Market/ Educational Institution= ").append(strlocmarketoption)
					.append("~Near by Other Public Utilities viz., Hospital/Post Office/Railway Station etc= ").append(strlocpublicoption)
					.append("~Neighbourhood - Prime/ Suburb etc.= ").append(strlocneighbouroption)
					.append("~Amenities [Indicators]")
					.append("~Accessible to Road= ").append(strameroadoption)
					.append("~Assured water supply= ").append(stramewateroption)
					.append("~Proper Drainage System/ Not pruned to water logging= ").append(strdrainageoption)
					.append("~Current Connection available= ").append(strelectricityoption)
					.append("~Met Loan & Life Suraksha Premium= ").append(strelectricityoption);
					}
				if(rs!=null)
				{
					rs.close();
				}
			}
			/*** End of audit trial old data ***/
		
			if(strAction.equalsIgnoreCase("insert"))
			{
				/*hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","del_per_house_proposed_asset");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);*/
				rs1=DBUtils.executeLAPSQuery("Sel_MaxId_house^"+strAppno);				 
				if(rs1.next())
				{	
					maxno= Helper.correctInt((String)rs1.getString("maxid"));
				}
	
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strAppno);//1
				arrValues.add(correctNull((String) hshValues.get("sel_purpose_of_loan")));//2
				arrValues.add(correctNull((String) hshValues.get("sel_take_over")));//3
				arrValues.add(correctNull((String) hshValues.get("sel_property_type")));//4
				arrValues.add(correctNull((String) hshValues.get("sel_property_nature")));//5
				arrValues.add(correctNull((String) hshValues.get("txt_property_for")));//6
				arrValues.add(Helper.correctInt((String) hshValues.get("txt_premises_age")));//7
				arrValues.add(Helper.correctInt((String) hshValues.get("txt_residual_life")));//8
				arrValues.add(Helper.correctInt((String) hshValues.get("txt_branch_distance")));//9
				arrValues.add(correctNull((String) hshValues.get("sel_already_mortgaged")));//10
				arrValues.add(correctNull((String) hshValues.get("sel_property_location")));//11
				arrValues.add(correctNull((String) hshValues.get("txt_survey_no")));//12
				arrValues.add(correctNull((String) hshValues.get("txt_plot_no")));//13
				arrValues.add(correctNull((String) hshValues.get("txt_addr_street")));//14
				arrValues.add(correctNull((String) hshValues.get("txt_addr_taluk")));//15
				arrValues.add(correctNull((String) hshValues.get("hidcity")));//16
				arrValues.add(correctNull((String) hshValues.get("hid_dist")));//17
				arrValues.add(correctNull((String) hshValues.get("hidstate")));//18
				arrValues.add(correctNull((String) hshValues.get("txt_addr_pincode")));//19
				arrValues.add(Helper.correctDouble((String) hshValues.get("txt_area_site")));//20
				arrValues.add(Helper.correctDouble((String) hshValues.get("txt_area_floorspace")));//21
				arrValues.add(Helper.correctDouble((String) hshValues.get("txt_marketvalue_site")));//22
				arrValues.add(Helper.correctDouble((String) hshValues.get("txt_purchasevalue_site")));//23
				arrValues.add(Helper.correctDouble((String) hshValues.get("txt_valuation_site")));//24
				if(strloanpurpose.equalsIgnoreCase("R")|| strloanpurpose.equalsIgnoreCase("C"))
				{
				    arrValues.add(Helper.correctDouble((String) hshValues.get("txt_marketVal")));//25
				}
				else
				{
					arrValues.add(Helper.correctDouble((String) hshValues.get("txt_marketvalue_flat")));//25	
				}
				arrValues.add(Helper.correctDouble((String) hshValues.get("txt_purchasevalue_flat")));//26
				arrValues.add(Helper.correctDouble((String) hshValues.get("txt_valuation_flat")));//27
				arrValues.add(Helper.correctDouble((String) hshValues.get("txt_construction_estimate")));//28
				arrValues.add(Helper.correctDouble((String) hshValues.get("txt_rennovation_bldg")));//29
				arrValues.add(correctNull((String) hshValues.get("txt_project_name")));//30
				arrValues.add(correctNull((String) hshValues.get("txtar_project_details")));//31
				arrValues.add(correctNull((String) hshValues.get("txt_builder_name")));//32
				arrValues.add(correctNull((String) hshValues.get("txtar_builder_background")));//33
				arrValues.add(correctNull((String) hshValues.get("sel_projfin_sanc")));//34
				arrValues.add(correctNull((String) hshValues.get("chk_mainroad")));//35
				arrValues.add(correctNull((String) hshValues.get("chk_eduinstitution")));//36
				arrValues.add(correctNull((String) hshValues.get("chk_public")));//37
				arrValues.add(correctNull((String) hshValues.get("chk_prime")));//38
				arrValues.add(correctNull((String) hshValues.get("chk_accessible")));//39
				arrValues.add(correctNull((String) hshValues.get("chk_assured")));//40
				arrValues.add(correctNull((String) hshValues.get("chk_drainages")));//41
				arrValues.add(correctNull((String) hshValues.get("chk_currentconnection")));//42
				arrValues.add(correctNull((String) hshValues.get("sel_securitytype")));//43
				arrValues.add(correctNull((String) hshValues.get("sel_securityclassifcation")));//44
				
				/** For Nature of Charge in Loan Particulars by DINESH on 06/02/2014 **/
				arrValues.add(correctNull((String) hshValues.get("sel_natureCharge")));//45
				
				// For per_house_proposed_asset Count
				rs = DBUtils.executeLAPSQuery("sel_perHouse_count^" + strAppno);
				if(rs.next())
				{
					intAtuoCount=rs.getInt("perhouse_count");
				}
				
				if(intAtuoCount==0)
				{
					//strSecId=SM.getOldAppidWithSno(strAppid);
				}
				else
				{
					strSecId = correctNull((String) hshValues.get("hidSecurityId"));
				}
				arrValues.add(strSecId);
				arrValues.add(correctNull((String) hshValues.get("txt_metloanpremium")));
				
				arrValues.add(correctNull((String) hshValues.get("hidtown")));
				arrValues.add(correctNull((String) hshValues.get("sel_house_type")));
				arrValues.add(maxno);
				arrValues.add("Y");
				arrValues.add(correctNull((String) hshValues.get("txt_cost_renovation")));
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","ins_per_house_proposed_asset");
				hshQueryValues.put("size","1");					
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				
				/** For inserting House details in Securities by DINESH on 07/20/2014 **//*
				
				if(intAtuoCount==0)
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "ins_secVechicleDetails");
					
					arrValues.add(strSecId);
					arrValues.add(Helper.correctNull((String) hshValues.get("sel_securitytype")));
					arrValues.add(Helper.correctNull((String) hshValues.get("sel_securityclassifcation")));
					arrValues.add("N");
					if(strloanpurpose.equalsIgnoreCase("G"))
					{
						arrValues.add(Helper.correctNull((String) hshValues.get("txt_marketvalue_site")));
					}
					if(strloanpurpose.equalsIgnoreCase("C"))
					{
						arrValues.add(Helper.correctNull((String) hshValues.get("txt_rennovation_bldg")));
					}
					if(strloanpurpose.equalsIgnoreCase("S"))
					{
						strsec_val = Double.parseDouble(Helper.correctDouble((String) hshValues.get("txt_construction_estimate")))
							+Double.parseDouble(Helper.correctDouble((String) hshValues.get("txt_marketvalue_site")));
						arrValues.add(String.valueOf(strsec_val));
					}
					if(strloanpurpose.equalsIgnoreCase("H"))
					{
						arrValues.add(Helper.correctNull((String) hshValues.get("txt_valuation_flat")));
					}
					if(strloanpurpose.equalsIgnoreCase("R"))
					{
						arrValues.add(Helper.correctNull((String) hshValues.get("txt_rennovation_bldg")));
					}
					if(strloanpurpose.equalsIgnoreCase("M"))
					{
						if(strpropertytype.equalsIgnoreCase("L"))
						{
							arrValues.add(Helper.correctNull((String) hshValues.get("txt_valuation_site")));
						}
						else
						{
							arrValues.add(Helper.correctNull((String) hshValues.get("txt_valuation_flat")));
						}
					}
					
					arrValues.add(correctNull((String) hshValues.get("sel_natureCharge")));
					
					currentdate=Helper.getCurrentDateTime();
					
					arrValues.add(currentdate);
					arrValues.add(currentdate);
					arrValues.add(Helper.correctNull((String) hshValues.get("sel_jointholder")));
					
					if(strloanpurpose.equalsIgnoreCase("G"))
					{
						arrValues.add(Helper.correctNull((String) hshValues.get("txt_marketvalue_site")));
					}
					if(strloanpurpose.equalsIgnoreCase("C"))
					{
						arrValues.add(Helper.correctNull((String) hshValues.get("txt_rennovation_bldg")));
					}
					if(strloanpurpose.equalsIgnoreCase("S"))
					{
						strsec_val = Double.parseDouble(Helper.correctDouble((String) hshValues.get("txt_construction_estimate")))
							+Double.parseDouble(Helper.correctDouble((String) hshValues.get("txt_marketvalue_site")));
						arrValues.add(String.valueOf(strsec_val));
					}
					if(strloanpurpose.equalsIgnoreCase("H"))
					{
						arrValues.add(Helper.correctNull((String) hshValues.get("txt_valuation_flat")));
					}
					if(strloanpurpose.equalsIgnoreCase("R"))
					{
						arrValues.add(Helper.correctNull((String) hshValues.get("txt_rennovation_bldg")));
					}
					if(strloanpurpose.equalsIgnoreCase("M"))
					{
						if(strpropertytype.equalsIgnoreCase("L"))
						{
							arrValues.add(Helper.correctNull((String) hshValues.get("txt_valuation_site")));
						}
						else
						{
							arrValues.add(Helper.correctNull((String) hshValues.get("txt_valuation_flat")));
						}
					}
					
					
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
			
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "ins_ownership_securities");
					arrValues.add(strSecId);
					arrValues.add(strAppid);
					arrValues.add(noOfCustomers);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("2", hshQuery);
			
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				}	
				else
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "upd_secVechicleDetails");
					
					*//** For Net Sec Value **//*
					if(strloanpurpose.equalsIgnoreCase("G"))
					{
						arrValues.add(Helper.correctNull((String) hshValues.get("txt_marketvalue_site")));
					}
					else if(strloanpurpose.equalsIgnoreCase("C"))
					{
						arrValues.add(Helper.correctNull((String) hshValues.get("txt_rennovation_bldg")));
					}
					else if(strloanpurpose.equalsIgnoreCase("S"))
					{
						strsec_val = Double.parseDouble(Helper.correctDouble((String) hshValues.get("txt_construction_estimate")))
								+Double.parseDouble(Helper.correctDouble((String) hshValues.get("txt_marketvalue_site")));
						arrValues.add(String.valueOf(strsec_val));
					}
					else if(strloanpurpose.equalsIgnoreCase("H"))
					{
						arrValues.add(Helper.correctNull((String) hshValues.get("txt_valuation_flat")));
					}
					else if(strloanpurpose.equalsIgnoreCase("R"))
					{
						arrValues.add(Helper.correctNull((String) hshValues.get("txt_rennovation_bldg")));
					}
					else if(strloanpurpose.equalsIgnoreCase("M"))
					{
						if(strpropertytype.equalsIgnoreCase("L"))
						{
							arrValues.add(Helper.correctNull((String) hshValues.get("txt_valuation_site")));
						}
						else
						{
							arrValues.add(Helper.correctNull((String) hshValues.get("txt_valuation_flat")));
						}
					}
					else
					{
						arrValues.add(Helper.correctNull((String) hshValues.get("txt_valuation_site")));
					}
					*//** End **//*
					
					arrValues.add(correctNull((String) hshValues.get("sel_natureCharge")));
					arrValues.add(Helper.correctNull((String) hshValues.get("sel_jointholder")));
					
					*//** For Residual Value **//*
					if(strloanpurpose.equalsIgnoreCase("G"))
					{
						arrValues.add(Helper.correctNull((String) hshValues.get("txt_marketvalue_site")));
					}
					if(strloanpurpose.equalsIgnoreCase("C"))
					{
						arrValues.add(Helper.correctNull((String) hshValues.get("txt_rennovation_bldg")));
					}
					if(strloanpurpose.equalsIgnoreCase("S"))
					{
						strsec_val = Double.parseDouble(Helper.correctDouble((String) hshValues.get("txt_construction_estimate")))
							+Double.parseDouble(Helper.correctDouble((String) hshValues.get("txt_marketvalue_site")));
						arrValues.add(String.valueOf(strsec_val));
					}
					if(strloanpurpose.equalsIgnoreCase("H"))
					{
						arrValues.add(Helper.correctNull((String) hshValues.get("txt_valuation_flat")));
					}
					if(strloanpurpose.equalsIgnoreCase("R"))
					{
						arrValues.add(Helper.correctNull((String) hshValues.get("txt_rennovation_bldg")));
					}
					if(strloanpurpose.equalsIgnoreCase("M"))
					{
						if(strpropertytype.equalsIgnoreCase("L"))
						{
							arrValues.add(Helper.correctNull((String) hshValues.get("txt_valuation_site")));
						}
						else
						{
							arrValues.add(Helper.correctNull((String) hshValues.get("txt_valuation_flat")));
						}
					}
					*//** End **//*
					
					arrValues.add(strSecId);
					
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				}
				*//** End **//*						
				// OWNERSHIP DETAILS
				
				if(intAtuoCount==0)
				{
					String strJointOwner=Helper.correctNull((String) hshValues.get("sel_jointholder"));
					if(strJointOwner.equalsIgnoreCase("Y"))
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQueryValues = new HashMap();					
						for(int i=1;i<=intOwnerCount;i++)
						{
							arrValues=new ArrayList();
							hshQuery = new HashMap();
							String size=Integer.toString(i);
							int j=i;
							--j;
							if(i==1) //To add the Main Applicant
							{
								arrValues.add(strSecId);
								arrValues.add(strAppid);
								arrValues.add(Integer.toString(i));
								hshQuery.put("arrValues", arrValues);
								hshQuery.put("strQueryId", "ins_ownership_securities");
							}
							else //To add Joint Owner newly
							{
								String strOwnerID=Helper.correctNull((String)hshValues.get("hid_jointID["+j+"]"));
								arrValues.add(strSecId);
								arrValues.add(strOwnerID);
								arrValues.add(Integer.toString(i));
								hshQuery.put("arrValues", arrValues);
								hshQuery.put("strQueryId", "ins_ownership_securities");
							}
							hshQueryValues.put(Integer.toString(i),hshQuery);
						}
						hshQueryValues.put("size",Integer.toString(intOwnerCount));
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					}
					else
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQueryValues = new HashMap();
						hshQueryValues.put("size", "1");
						hshQuery.put("strQueryId", "ins_ownership_securities");
						
						arrValues.add(strSecId);
						arrValues.add(strAppid);
						arrValues.add("1");
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("1",hshQuery);
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
	
					}
				}
				else
				{
					arrValues = new ArrayList();
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					hshQueryValues.put("size", "1");
					hshQuery.put("strQueryId", "del_ownership_securities");
					arrValues.add(strSecId);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");												
					hshQueryValues = new HashMap();	
					int j=intOwnerCount;
					int k=1;
					for(int i=1;i<j;i++)
					{						
						arrValues=new ArrayList();
						hshQuery = new HashMap();
						String size=Integer.toString(i);
						if(i==1) //To add the Main Applicant
						{
							arrValues.add(strSecId);
							arrValues.add(strAppid);
							arrValues.add(Integer.toString(i));
							hshQuery.put("arrValues", arrValues);
							hshQuery.put("strQueryId", "ins_ownership_securities");
							hshQueryValues.put(Integer.toString(i),hshQuery);
						}
						else if(intDeleteOwn>0 &&i!=intDeleteOwn) 
						{							
							String strOwnerID=Helper.correctNull((String)hshValues.get("hid_jointID["+i+"]"));
							arrValues.add(strSecId);
							arrValues.add(strOwnerID);
							arrValues.add(Integer.toString(++k));
							hshQuery.put("arrValues", arrValues);
							hshQuery.put("strQueryId", "ins_ownership_securities");
							hshQueryValues.put(Integer.toString(k),hshQuery);
						}else if(intDeleteOwn==0)
						{
							String strOwnerID=Helper.correctNull((String)hshValues.get("hid_jointID["+i+"]"));
							arrValues.add(strSecId);
							arrValues.add(strOwnerID);
							arrValues.add(Integer.toString(++k));
							hshQuery.put("arrValues", arrValues);
							hshQuery.put("strQueryId", "ins_ownership_securities");
							hshQueryValues.put(Integer.toString(k),hshQuery);
						}else
						{
							++j;
						}						
					}					
					hshQueryValues.put("size",Integer.toString(--intOwnerCount));
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}			
				*//** For inserting values into app_securitydetails table **//*
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_secDetails");
				arrValues.add(strSecId);
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_securitydetails");
				
				arrValues.add(strAppno);
				arrValues.add(strSecId);
				arrValues.add("1");
				arrValues.add(strAppid);

				//For Net Sec Value
				if(strloanpurpose.equalsIgnoreCase("G"))
				{
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_marketvalue_site")));
				}
				if(strloanpurpose.equalsIgnoreCase("C"))
				{
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_rennovation_bldg")));
				}
				if(strloanpurpose.equalsIgnoreCase("S"))
				{
					strsec_val = Double.parseDouble(Helper.correctDouble((String) hshValues.get("txt_construction_estimate")))
						+Double.parseDouble(Helper.correctDouble((String) hshValues.get("txt_marketvalue_site")));
					arrValues.add(String.valueOf(strsec_val));
				}
				if(strloanpurpose.equalsIgnoreCase("H"))
				{
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_valuation_flat")));
				}
				if(strloanpurpose.equalsIgnoreCase("R"))
				{
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_rennovation_bldg")));
				}
				if(strloanpurpose.equalsIgnoreCase("M"))
				{
					if(strpropertytype.equalsIgnoreCase("L"))
					{
						arrValues.add(Helper.correctNull((String) hshValues.get("txt_valuation_site")));
					}
					else
					{
						arrValues.add(Helper.correctNull((String) hshValues.get("txt_valuation_flat")));
					}
				}
				
				//For Residual Value
				
				if(strloanpurpose.equalsIgnoreCase("G"))
				{
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_marketvalue_site")));
				}
				if(strloanpurpose.equalsIgnoreCase("C"))
				{
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_rennovation_bldg")));
				}
				if(strloanpurpose.equalsIgnoreCase("S"))
				{
					strsec_val = Double.parseDouble(Helper.correctDouble((String) hshValues.get("txt_construction_estimate")))
						+Double.parseDouble(Helper.correctDouble((String) hshValues.get("txt_marketvalue_site")));
					arrValues.add(String.valueOf(strsec_val));
				}
				if(strloanpurpose.equalsIgnoreCase("H"))
				{
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_valuation_flat")));
				}
				if(strloanpurpose.equalsIgnoreCase("R"))
				{
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_rennovation_bldg")));
				}
				if(strloanpurpose.equalsIgnoreCase("M"))
				{
					if(strpropertytype.equalsIgnoreCase("L"))
					{
						arrValues.add(Helper.correctNull((String) hshValues.get("txt_valuation_site")));
					}
					else
					{
						arrValues.add(Helper.correctNull((String) hshValues.get("txt_valuation_flat")));
					}
				}
				
				arrValues.add("");	//fac type
				arrValues.add("");	//fac nat
				arrValues.add("1");	//sec type
				arrValues.add("");	//loan amt
				arrValues.add("");	//outstanding
				arrValues.add("");	//unsec 
				arrValues.add(strAppid);	//applicant
				arrValues.add("");	//margin
				arrValues.add("");	//fac id
				arrValues.add("P");	//loan type
				arrValues.add("");	//collateral
				arrValues.add("");	//existing
				arrValues.add("A");
				arrValues.add("Y");
				arrValues.add("");
				arrValues.add(strAppid);
				arrValues.add("");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2",hshQuery);
				hshQueryValues.put("size", "2");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");*/
			
			}
			if(strAction.equalsIgnoreCase("update"))
			{
				/*hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","del_per_house_proposed_asset");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);*/
	
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				
 				arrValues.add(correctNull((String) hshValues.get("sel_purpose_of_loan")));//2
				arrValues.add(correctNull((String) hshValues.get("sel_take_over")));//3
				arrValues.add(correctNull((String) hshValues.get("sel_property_type")));//4
				arrValues.add(correctNull((String) hshValues.get("sel_property_nature")));//5
				arrValues.add(correctNull((String) hshValues.get("txt_property_for")));//6
				arrValues.add(Helper.correctInt((String) hshValues.get("txt_premises_age")));//7
				arrValues.add(Helper.correctInt((String) hshValues.get("txt_residual_life")));//8
				arrValues.add(Helper.correctInt((String) hshValues.get("txt_branch_distance")));//9
				arrValues.add(correctNull((String) hshValues.get("sel_already_mortgaged")));//10
				arrValues.add(correctNull((String) hshValues.get("sel_property_location")));//11
				arrValues.add(correctNull((String) hshValues.get("txt_survey_no")));//12
				arrValues.add(correctNull((String) hshValues.get("txt_plot_no")));//13
				arrValues.add(correctNull((String) hshValues.get("txt_addr_street")));//14
				arrValues.add(correctNull((String) hshValues.get("txt_addr_taluk")));//15
				arrValues.add(correctNull((String) hshValues.get("hidcity")));//16
				arrValues.add(correctNull((String) hshValues.get("hid_dist")));//17
				arrValues.add(correctNull((String) hshValues.get("hidstate")));//18
				arrValues.add(correctNull((String) hshValues.get("txt_addr_pincode")));//19
				arrValues.add(Helper.correctDouble((String) hshValues.get("txt_area_site")));//20
				arrValues.add(Helper.correctDouble((String) hshValues.get("txt_area_floorspace")));//21
				arrValues.add(Helper.correctDouble((String) hshValues.get("txt_marketvalue_site")));//22
				arrValues.add(Helper.correctDouble((String) hshValues.get("txt_purchasevalue_site")));//23
				arrValues.add(Helper.correctDouble((String) hshValues.get("txt_valuation_site")));//24
				if(strloanpurpose.equalsIgnoreCase("R")|| strloanpurpose.equalsIgnoreCase("C"))
				{
				    arrValues.add(Helper.correctDouble((String) hshValues.get("txt_marketVal")));//25
				}
				else
				{
					arrValues.add(Helper.correctDouble((String) hshValues.get("txt_marketvalue_flat")));//25	
				}
				arrValues.add(Helper.correctDouble((String) hshValues.get("txt_purchasevalue_flat")));//26
				arrValues.add(Helper.correctDouble((String) hshValues.get("txt_valuation_flat")));//27
				arrValues.add(Helper.correctDouble((String) hshValues.get("txt_construction_estimate")));//28
				arrValues.add(Helper.correctDouble((String) hshValues.get("txt_rennovation_bldg")));//29
				arrValues.add(correctNull((String) hshValues.get("txt_project_name")));//30
				arrValues.add(correctNull((String) hshValues.get("txtar_project_details")));//31
				arrValues.add(correctNull((String) hshValues.get("txt_builder_name")));//32
				arrValues.add(correctNull((String) hshValues.get("txtar_builder_background")));//33
				arrValues.add(correctNull((String) hshValues.get("sel_projfin_sanc")));//34
				arrValues.add(correctNull((String) hshValues.get("chk_mainroad")));//35
				arrValues.add(correctNull((String) hshValues.get("chk_eduinstitution")));//36
				arrValues.add(correctNull((String) hshValues.get("chk_public")));//37
				arrValues.add(correctNull((String) hshValues.get("chk_prime")));//38
				arrValues.add(correctNull((String) hshValues.get("chk_accessible")));//39
				arrValues.add(correctNull((String) hshValues.get("chk_assured")));//40
				arrValues.add(correctNull((String) hshValues.get("chk_drainages")));//41
				arrValues.add(correctNull((String) hshValues.get("chk_currentconnection")));//42
				arrValues.add(correctNull((String) hshValues.get("sel_securitytype")));//43
				arrValues.add(correctNull((String) hshValues.get("sel_securityclassifcation")));//44
				
				/** For Nature of Charge in Loan Particulars by DINESH on 06/02/2014 **/
				arrValues.add(correctNull((String) hshValues.get("sel_natureCharge")));//45
				
				// For per_house_proposed_asset Count
				rs = DBUtils.executeLAPSQuery("sel_perHouse_count^" + strAppno);
				if(rs.next())
				{
					intAtuoCount=rs.getInt("perhouse_count");
				}
				
				if(intAtuoCount==0)
				{
					//strSecId=SM.getOldAppidWithSno(strAppid);
				}
				else
				{
					strSecId = correctNull((String) hshValues.get("hidsecID"));
				}
				arrValues.add(strSecId);
				arrValues.add(correctNull((String) hshValues.get("txt_metloanpremium")));
				
				arrValues.add(correctNull((String) hshValues.get("hidtown")));
				arrValues.add(correctNull((String) hshValues.get("sel_house_type")));
				arrValues.add("Y");
				arrValues.add(correctNull((String) hshValues.get("txt_cost_renovation")));
				arrValues.add(strAppno);
				arrValues.add(correctNull((String) hshValues.get("hidsnmbr")));

				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","upd_per_house_proposed_asset");
				hshQueryValues.put("size","1");					
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			
				if((correctNull((String) hshValues.get("sessionModuleType")).equalsIgnoreCase("DIGI")))
				{
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add(Helper.correctDouble((String)hshValues.get("txt_metloanpremium")));
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","updatemetloan");
					hshQueryValues.put("size","1");					
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				 }
			
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				if(correctNull((String) hshValues.get("hidSecurityId")).equalsIgnoreCase("")){
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("hidsnmbr")));
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","del_per_house_proposed_asset");
					hshQueryValues.put("size","1");					
					hshQueryValues.put("1",hshQuery);
				}
				else{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("hidsnmbr")));
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","del_per_house_proposed_asset");
					hshQueryValues.put("size","1");					
					hshQueryValues.put("1",hshQuery);
					
					if(rs1!=null)
						  rs1.close();
					 String Purpose_Loan="",strCat_id="",strApplicable_for="",strPrd_type="";
					strQuery = SQLParser.getSqlQuery("sel_cat_house^"+strAppno);
		    		rs1 = DBUtils.executeQuery(strQuery);
		    		if(rs1.next())
		    		{
		    			Purpose_Loan = Helper.correctNull((String) rs1.getString("PRD_PURPOSE"));
		    			strCat_id = Helper.correctNull((String) rs1.getString("CAT_ID"));
		    			strApplicable_for = Helper.correctNull((String) rs1.getString("PRD_APPLICABLEFOR"));
		    			strPrd_type = Helper.correctNull((String) rs1.getString("PRD_TYPE"));
		    		}
					
					 String SecID=correctNull((String) hshValues.get("hidSecurityId"));
					 if(rs!=null)
						  rs.close();
						rs = DBUtils.executeLAPSQuery("sel_proposedasset_sec^"+strAppno+"^"+SecID);
						if(rs.next())
						{
							 String srlno="",strmeas="",strbuildmeas="";
							 double totalArea=0,extBuild=0;
							 int intSize=0;
							 double totalArea1=0.00 ,extBuild1=0.00;
		    					hshQuery=new HashMap();
		    					arrValues=new ArrayList();   
		    					arrValues.add(strAppno);	    					
		    					arrValues.add(SecID);	    					
		    					arrValues.add(correctNull((String) hshValues.get("hidsnmbr")));
		    					arrValues.add(Helper.correctNull((String)rs.getString("LOAN_TAKEOVER")));	    					
		    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_PROPERTYTYPE")));	
		    					arrValues.add(Helper.correctNull((String)rs.getString("CUS_SEC_TYPE")));	    
		    					arrValues.add(Helper.correctNull((String)rs.getString("CUS_SEC_CLASSIFICATION")));	    					
		    					arrValues.add(Helper.correctNull((String)rs.getString("CUS_SEC_NATUREOFCHARGE")));	    					
		    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_SURVEYNO")));	    					
		    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_PLOTNO")));	    					
		    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_STREETNO")));	    					
		    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_CITY")));	    					
		    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_DISTRICT")));	    					
		    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_STATE")));	    					
		    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_ZIP")));	    					
		    					//arrValues.add(Helper.correctNull((String)rs.getString("SEC_TOTALAREA")));	  
		    					//arrValues.add(Helper.correctNull((String)rs.getString("SEC_EXTENTOFBUILDING")));
		    					totalArea=Double.parseDouble(Helper.correctDouble((String)rs.getString("SEC_TOTALAREA")));
		    					strmeas=Helper.correctNull((String)rs.getString("sec_measurement"));
		    					if(totalArea!=0){
		    						if(strmeas.equalsIgnoreCase("1"))
		    								totalArea1=(totalArea*43560);
		    						else if(strmeas.equalsIgnoreCase("2"))
		    								totalArea1=(totalArea*107639);
		    						else if(strmeas.equalsIgnoreCase("3"))
	    								totalArea1=totalArea;
		    						else if(strmeas.equalsIgnoreCase("4"))
	    								totalArea1=totalArea*10.76;
		    						else if(strmeas.equalsIgnoreCase("5"))
	    								totalArea1=totalArea*9;
		    						else if(strmeas.equalsIgnoreCase("6"))
	    								totalArea1=totalArea*1088.98;
		    						else if(strmeas.equalsIgnoreCase("7"))
	    								totalArea1=totalArea*435.9;
		    						else if(strmeas.equalsIgnoreCase("8"))
	    								totalArea1=totalArea*5404.89;
		    					}
		    					arrValues.add(String.valueOf(totalArea1));
		    					
		    					extBuild=Double.parseDouble(Helper.correctDouble((String)rs.getString("SEC_EXTENTOFBUILDING")));
		    					strbuildmeas=Helper.correctNull((String)rs.getString("sec_extofbuildmeas"));
		    					if(extBuild!=0){
		    						if(strbuildmeas.equalsIgnoreCase("1"))
		    								extBuild1=(extBuild*43560);
		    						else if(strbuildmeas.equalsIgnoreCase("2"))
		    								extBuild1=(extBuild*107639);
		    						else if(strbuildmeas.equalsIgnoreCase("3"))
	    								extBuild1=extBuild;
		    						else if(strbuildmeas.equalsIgnoreCase("4"))
	    								extBuild1=extBuild*10.76;
		    						else if(strbuildmeas.equalsIgnoreCase("5"))
	    								extBuild1=extBuild*9;
		    						else if(strbuildmeas.equalsIgnoreCase("6"))
	    								extBuild1=extBuild*1088.98;
		    						else if(strbuildmeas.equalsIgnoreCase("7"))
	    								extBuild1=extBuild*435.9;
		    						else if(strbuildmeas.equalsIgnoreCase("8"))
	    								extBuild1=extBuild*5404.89;
		    					}
		    					arrValues.add(String.valueOf(extBuild1));
		    					arrValues.add("N");
		    					if(!Purpose_Loan.equalsIgnoreCase("")){arrValues.add(Purpose_Loan);}
		    					else {arrValues.add("");}
		    					if(strPrd_type.equalsIgnoreCase("pH")){ 
		    						arrValues.add(Helper.correctNull((String)rs.getString("SEC_SALEVALUE")));
		    						arrValues.add(Helper.correctNull((String)rs.getString("sec_valuervalue")));
		    					}
		    					else{
		    						arrValues.add("0.00");
		    						arrValues.add("0.00");
		    					}
		    					if(strPrd_type.equalsIgnoreCase("pC") ||strPrd_type.equalsIgnoreCase("pR") )
		    						arrValues.add(Helper.correctNull((String)rs.getString("loan_metlifepremiumamt")));
		    					else
		    						arrValues.add("0.00");
	    						arrValues.add("0");
		    					hshQuery.put("arrValues",arrValues);
		    					hshQuery.put("strQueryId","ins_proposedasset_house");
		    					hshQueryValues.put("size","2");
		    					hshQueryValues.put("2",hshQuery);
		    					
						}
				 	}
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				
			}
			/** For the purpose of 'Audit Trial' */
			//propAssetAuditTrial(hshValues,strAppno,strAction);
			/** End */
			
			
		/*** For audit trial new data by Guhan.T on 11/10/2013 ***/
			
		
		if(!strAppno.equalsIgnoreCase(""))
			{	
				String strloanpurposenewaudit=correctNull((String) hshValues.get("sel_purpose_of_loan"));
				String strtakeovernewaudit=correctNull((String) hshValues.get("sel_take_over"));
				String strpropertytypenewaudit=correctNull((String) hshValues.get("sel_property_type"));
				String strpropertynaturenewaudit=correctNull((String) hshValues.get("sel_property_nature"));
				String strpropusedfornewaudit=correctNull((String) hshValues.get("txt_property_for"));
				String strpremisesagenewaudit=correctNull((String) hshValues.get("txt_premises_age"));
				String strresiduallifenewaudit=correctNull((String) hshValues.get("txt_residual_life"));
				String strbranchdistnewaudit=correctNull((String) hshValues.get("txt_branch_distance"));
				String strproplocationnewaudit=correctNull((String) hshValues.get("sel_property_location"));
				String strpropsurveynonewaudit=correctNull((String) hshValues.get("txt_survey_no"));
				String strpropplotnonewaudit=correctNull((String) hshValues.get("txt_plot_no"));
				String strpropstreetnewaudit=correctNull((String) hshValues.get("txt_addr_street"));
				String strproptaluknewaudit=correctNull((String) hshValues.get("txt_addr_taluk"));
				String strpropcitynewaudit=correctNull((String) hshValues.get("txt_addr_city"));
				String strpropdistrictnewaudit=correctNull((String) hshValues.get("txt_addr_district"));
				String strpropstatenewaudit=correctNull((String) hshValues.get("txt_addr_state"));
				String strproppinnewaudit=correctNull((String) hshValues.get("txt_addr_pincode"));
				String strpropareanewaudit=correctNull((String) hshValues.get("txt_area_site"));
				String strfloorspaceareanewaudit=correctNull((String) hshValues.get("txt_area_floorspace"));
				String strmarketvaluenewaudit=correctNull((String) hshValues.get("txt_marketvalue_site"));
				String strpurchasevaluenewaudit=correctNull((String) hshValues.get("txt_purchasevalue_site"));
				String strvaluationcostnewaudit=correctNull((String) hshValues.get("txt_valuation_site"));
				String strbldgmarketvaluenewaudit=correctNull((String) hshValues.get("txt_marketvalue_flat"));
				String strbldgpurchasenewaudit=correctNull((String) hshValues.get("txt_purchasevalue_flat"));
				String strbldgvaluationnewaudit=correctNull((String) hshValues.get("txt_valuation_flat"));
				String strbldgestimatecostnewaudit=correctNull((String) hshValues.get("txt_construction_estimate"));
				String strbldgrenovationcostnewaudit=correctNull((String) hshValues.get("txt_cost_renovation"));
				String strprojnamenewaudit=correctNull((String) hshValues.get("txt_project_name"));
				String strprojdetailsnewaudit=correctNull((String) hshValues.get("txtar_project_details"));
				String strbuildernamenewaudit=correctNull((String) hshValues.get("txt_builder_name"));
				String strbuilderbackgrndnewaudit=correctNull((String) hshValues.get("txtar_builder_background"));
				String strprojfinancenewaudit=correctNull((String) hshValues.get("sel_projfin_sanc"));
				String strlocroadnewaudit=correctNull((String) hshValues.get("chk_mainroad"));
				String strlocmarketnewaudit=correctNull((String) hshValues.get("chk_eduinstitution"));
				String strlocpublicnewaudit=correctNull((String) hshValues.get("chk_public"));
				String strlocneighbournewaudit=correctNull((String) hshValues.get("chk_prime"));
				String strameroadnewaudit=correctNull((String) hshValues.get("chk_accessible"));
				String stramewaternewaudit=correctNull((String) hshValues.get("chk_assured"));
				String strdrainagenewaudit=correctNull((String) hshValues.get("chk_drainages"));
				String strelectricitynewaudit=correctNull((String) hshValues.get("chk_currentconnection"));
				String stralrdymortagenewaudit=correctNull((String) hshValues.get("sel_already_mortgaged"));
				String strloanpurposeoption="";
				String strtakeoveroption="";
				String strpropertytypeoption="";
				String strpropertynatureoption="";
				String strpropusedforoption="";
				String strmortageoptionoption="";
				String strproplocationoption="";
				String strprojfinanceoption="";
				String strlocroadoption="";
				String strlocmarketoption="";
				String strlocpublicoption="";
				String strlocneighbouroption="";
				String strameroadoption="";
				String stramewateroption="";
				String strdrainageoption="";
				String strelectricityoption="";
				
				if(strlocroadnewaudit.equalsIgnoreCase("Y"))
					strlocroadoption = "Yes";
				else strlocroadoption = "No";
				if(strlocmarketnewaudit.equalsIgnoreCase("Y"))
					strlocmarketoption = "Yes";
				else strlocmarketoption = "No";
				if(strlocpublicnewaudit.equalsIgnoreCase("Y"))
					strlocpublicoption = "Yes";
				else strlocpublicoption = "No";
				if(strlocneighbournewaudit.equalsIgnoreCase("Y"))
					strlocneighbouroption = "Yes";
				else strlocneighbouroption = "No";
				if(strameroadnewaudit.equalsIgnoreCase("Y"))
					strameroadoption = "Yes";
				else strameroadoption = "No";
				if(stramewaternewaudit.equalsIgnoreCase("Y"))
					stramewateroption = "Yes";
				else stramewateroption = "No";
				if(strdrainagenewaudit.equalsIgnoreCase("Y"))
					strdrainageoption = "Yes";
				else strdrainageoption = "No";
				if(strelectricitynewaudit.equalsIgnoreCase("Y"))
					strelectricityoption = "Yes";
				else strelectricityoption = "No";					
				
				if(strloanpurposenewaudit.equalsIgnoreCase("0"))
					strloanpurposeoption = "Select";
				else if(strloanpurposenewaudit.equalsIgnoreCase("G"))
					strloanpurposeoption = "Purchase of Site";
				else if(strloanpurposenewaudit.equalsIgnoreCase("C"))
					strloanpurposeoption = "Construction of House";
				else if(strloanpurposenewaudit.equalsIgnoreCase("S"))
					strloanpurposeoption = "Purchase of Site & Construction of House";
				else if(strloanpurposenewaudit.equalsIgnoreCase("H"))
					strloanpurposeoption = "Purchase of Ready Built House/Flat";
				else if(strloanpurposenewaudit.equalsIgnoreCase("R"))
					strloanpurposeoption = "Renovation";
				else if(strloanpurposenewaudit.equalsIgnoreCase("M"))
					strloanpurposeoption = "Mortgage";
					
				if(strtakeovernewaudit.equalsIgnoreCase("0"))
					strtakeoveroption = "Select";
				else if(strtakeovernewaudit.equalsIgnoreCase("Y"))
					strtakeoveroption = "Yes";
				else if(strtakeovernewaudit.equalsIgnoreCase("N"))
					strtakeoveroption = "No";
				
				if(strpropertytypenewaudit.equalsIgnoreCase("0"))
					strpropertytypeoption = "Select";
				else if(strpropertytypenewaudit.equalsIgnoreCase("L"))
					strpropertytypeoption = "Land";
				else if(strpropertytypenewaudit.equalsIgnoreCase("F"))
					strpropertytypeoption = "Flat / Apartment";
				else if(strpropertytypenewaudit.equalsIgnoreCase("H"))
					strpropertytypeoption = "House / Building";
				
				if(strpropertynaturenewaudit.equalsIgnoreCase("0"))
					strpropertynatureoption = "Select";
				else if(strpropertynaturenewaudit.equalsIgnoreCase("R"))
					strpropertynatureoption = "Residential";
				else if(strpropertynaturenewaudit.equalsIgnoreCase("C"))
					strpropertynatureoption = "Commercial";
				
				if(strpropusedfornewaudit.equalsIgnoreCase("0"))
					strpropusedforoption = "Select";
				else if(strpropusedfornewaudit.equalsIgnoreCase("R"))
					strpropusedforoption = "Renting Out";
				else if(strpropusedfornewaudit.equalsIgnoreCase("O"))
					strpropusedforoption = "Self Occupation";
				else if(strpropusedfornewaudit.equalsIgnoreCase("L"))
					strpropusedforoption = "Leasing Out";
				else if(strpropusedfornewaudit.equalsIgnoreCase("C"))
					strpropusedforoption = "Commercial";
				
				if(stralrdymortagenewaudit.equalsIgnoreCase("0"))
					strmortageoptionoption = "Select";
				else if(stralrdymortagenewaudit.equalsIgnoreCase("Y"))
					strmortageoptionoption = "Yes";
				else if(stralrdymortagenewaudit.equalsIgnoreCase("N"))
					strmortageoptionoption = "No";
				
				if(strproplocationnewaudit.equalsIgnoreCase("0"))
					strproplocationoption = "Select";
				else if(strproplocationnewaudit.equalsIgnoreCase("M"))
					strproplocationoption = "Metro";
				else if(strproplocationnewaudit.equalsIgnoreCase("U"))
					strproplocationoption = "Urban";
				else if(strproplocationnewaudit.equalsIgnoreCase("S"))
					strproplocationoption = "Semi-Urban";
				else if(strproplocationnewaudit.equalsIgnoreCase("R"))
					strproplocationoption = "Rural";
				
				if(strprojfinancenewaudit.equalsIgnoreCase("0"))
					strprojfinanceoption = "Select";
				else if(strprojfinancenewaudit.equalsIgnoreCase("Y"))
					strprojfinanceoption = "Yes";
				else if(strprojfinancenewaudit.equalsIgnoreCase("N"))
					strprojfinanceoption = "No";
				
				sbAuditTrial.append("~Purpose of Loan= ").append(strloanpurposeoption)
				.append("~Whether Take-Over= ").append(strtakeoveroption)
				.append("~Type of Property= ").append(strpropertytypeoption)
				.append("~Nature of Property= ").append(strpropertynatureoption)
				.append("~Property used for= ").append(strpropusedforoption)
				.append("~Age of the Premises= ").append(strpremisesagenewaudit)
				.append("~Residual Life of Premises= ").append(strresiduallifenewaudit)
				.append("~Distance from Branch = ").append(strbranchdistnewaudit)
				.append("~Whether Property Already Mortgaged= ").append(strmortageoptionoption)
				.append("~Location of Property = ").append(strproplocationoption)
				.append("~Survey No.= ").append(strpropsurveynonewaudit)
				.append("~House/Plot No.= ").append(strpropplotnonewaudit)
				.append("~Street= ").append(strpropstreetnewaudit)
				.append("~Taluk= ").append(strproptaluknewaudit)
				.append("~City/Town= ").append(strpropcitynewaudit)
				.append("~District= ").append(strpropdistrictnewaudit)
				.append("~State= ").append(strpropstatenewaudit)
				.append("~Pincode= ").append(strproppinnewaudit)
				.append("~Area of Site= ").append(strpropareanewaudit)
				.append("~Floor Space/Builtup Area= ").append(strfloorspaceareanewaudit)
				.append("~Market Value of Site= ").append(strmarketvaluenewaudit)
				.append("~Purchase Value of Site= ").append(strpurchasevaluenewaudit)
				.append("~Market Value of Building/Flat= ").append(strbldgmarketvaluenewaudit)
				.append("~Purchase Value of Building/Flat= ").append(strbldgpurchasenewaudit)
				.append("~Estimated Cost of Construction= ").append(strbldgestimatecostnewaudit)
				.append("~Cost of Renovation= ").append(strbldgrenovationcostnewaudit)
				.append("~Valuation Price of Site= ").append(strvaluationcostnewaudit)
				.append("~Valuation Price of Building/Flat= ").append(strbldgvaluationnewaudit)
				.append("~Project Name= ").append(strprojnamenewaudit)
				.append("~Builder Name= ").append(strbuildernamenewaudit)
				.append("~Project Details= ").append(strprojdetailsnewaudit)
				.append("~Background of Builder= ").append(strbuilderbackgrndnewaudit)
				.append("~Whether the project finance is sanctioned in our bank= ").append(strprojfinanceoption)
				.append("~Location [Indicators]")
				.append("~Near by Main Road= ").append(strlocroadoption)
				.append("~Near by Market/ Educational Institution= ").append(strlocmarketoption)
				.append("~Near by Other Public Utilities viz., Hospital/Post Office/Railway Station etc= ").append(strlocpublicoption)
				.append("~Neighbourhood - Prime/ Suburb etc.= ").append(strlocneighbouroption)
				.append("~Amenities [Indicators]")
				.append("~Accessible to Road= ").append(strameroadoption)
				.append("~Assured water supply= ").append(stramewateroption)
				.append("~Proper Drainage System/ Not pruned to water logging= ").append(strdrainageoption)
				.append("~Current Connection available= ").append(strelectricityoption);
				AuditTrial.auditNewLog(hshValues,"239",strAppno,sbAuditTrial.toString(),sbOldAudit.toString());
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateHousingLoanData "+ce.toString());
		}
		finally
		{	
			try
			{
			}
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}
	}
	public HashMap getHousingLoanData(HashMap hshValues) 
	{
		ResultSet rs = null;
		ResultSet rs1 = null,rs2=null;
		HashMap hshResult = new HashMap();
		String strAppno = correctNull((String)hshValues.get("appno"));
		String recordflag="N";
		String strSecId="";
		String strQuery;
		StringBuilder strJointOwnDetails=new StringBuilder();
		int intAtuoCount=0;
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();
		String strPrdcode = Helper.correctNull((String)hshValues.get("prdcode"));
		String strPurpose="",strPur_Name="";
		try 
		{ 
			rs=DBUtils.executeLAPSQuery("sel_per_house_proposed_asset^"+ strAppno);			 
			if (rs.next()) 
			{
				hshResult.put("phpa_loan_purpose",correctNull(rs.getString("phpa_loan_purpose")));
				hshResult.put("phpa_take_over",correctNull(rs.getString("phpa_take_over")));
				hshResult.put("phpa_prop_type",correctNull(rs.getString("phpa_prop_type")));
				hshResult.put("phpa_prop_nature",correctNull(rs.getString("phpa_prop_nature")));
				hshResult.put("phpa_prop_usedfor",correctNull(rs.getString("phpa_prop_usedfor")));
				hshResult.put("phpa_premises_age",correctNull(rs.getString("phpa_premises_age")));
				hshResult.put("phpa_residual_life",correctNull(rs.getString("phpa_residual_life")));
				hshResult.put("phpa_branch_distance",correctNull(rs.getString("phpa_branch_distance")));
				hshResult.put("phpa_prop_location",correctNull(rs.getString("phpa_prop_location")));
				hshResult.put("phpa_prop_surveyno",correctNull(rs.getString("phpa_prop_surveyno")));
				hshResult.put("phpa_prop_plotno",correctNull(rs.getString("phpa_prop_plotno")));
				hshResult.put("phpa_prop_street",correctNull(rs.getString("phpa_prop_street")));
				hshResult.put("phpa_prop_taluk",correctNull(rs.getString("phpa_prop_taluk")));
				
				if(rs1 !=null)
				{
					rs1.close();
				}
				rs1=DBUtils.executeLAPSQuery("sel_citynamebycode^"+ correctNull(rs.getString("phpa_prop_city")));	
				if (rs1.next()) 
				{
					hshResult.put("phpa_prop_city",correctNull(rs1.getString("city_name")));
					hshResult.put("phpa_prop_citycode",correctNull(rs.getString("phpa_prop_city")));
				}
				else
				{
					hshResult.put("phpa_prop_city",correctNull(rs.getString("phpa_prop_city")));
					hshResult.put("phpa_prop_citycode",correctNull(rs.getString("phpa_prop_city")));
				}
				
				
				if(rs1 !=null)
				{
					rs1.close();
				}
				rs1=DBUtils.executeLAPSQuery("sel_distnamebycode^"+ correctNull(rs.getString("phpa_prop_district")));	
				if (rs1.next()) 
				{
					hshResult.put("phpa_prop_district",correctNull(rs1.getString("district_desc")));
					hshResult.put("phpa_prop_districtcode",correctNull(rs.getString("phpa_prop_district")));

				}
				else
				{
					hshResult.put("phpa_prop_district",correctNull(rs.getString("phpa_prop_district")));
					hshResult.put("phpa_prop_districtcode",correctNull(rs.getString("phpa_prop_district")));

					
				}
				
				
				if(rs1 !=null)
				{
					rs1.close();
				}
				rs1=DBUtils.executeLAPSQuery("sel_statenamebycode^"+ correctNull(rs.getString("phpa_prop_state")));	
				if (rs1.next()) 
				{
					hshResult.put("phpa_prop_state",correctNull(rs1.getString("state_name")));
					hshResult.put("phpa_prop_statecode",correctNull(rs.getString("phpa_prop_state")));
				}
				else
				{
					hshResult.put("phpa_prop_state",correctNull(rs.getString("phpa_prop_state")));
					hshResult.put("phpa_prop_statecode",correctNull(rs.getString("phpa_prop_state")));
				}
				
				hshResult.put("phpa_prop_pincode",correctNull(rs.getString("phpa_prop_pincode")));
				hshResult.put("phpa_site_area",correctNull(rs.getString("phpa_site_area")));
				hshResult.put("phpa_floorspace_area",correctNull(rs.getString("phpa_floorspace_area")));
				hshResult.put("phpa_site_market_value",correctNull(rs.getString("phpa_site_market_value")));
				hshResult.put("phpa_site_purchase_price",correctNull(rs.getString("phpa_site_purchase_price")));
				hshResult.put("phpa_site_valuation_cost",correctNull(rs.getString("phpa_site_valuation_cost")));
				hshResult.put("phpa_bldg_market_value",correctNull(rs.getString("phpa_bldg_market_value")));
				hshResult.put("phpa_bldg_purchase_price",correctNull(rs.getString("phpa_bldg_purchase_price")));
				hshResult.put("phpa_bldg_valuation_cost",correctNull(rs.getString("phpa_bldg_valuation_cost")));
				hshResult.put("phpa_bldg_estimate_cost",correctNull(rs.getString("phpa_bldg_estimate_cost")));
				hshResult.put("phpa_bldg_rennovation_cost",correctNull(rs.getString("phpa_bldg_rennovation_cost")));
				hshResult.put("phpa_project_name",correctNull(rs.getString("phpa_project_name")));
				hshResult.put("phpa_project_details",correctNull(rs.getString("phpa_project_details")));
				hshResult.put("phpa_builder_name",correctNull(rs.getString("phpa_builder_name")));
				hshResult.put("phpa_builder_background",correctNull(rs.getString("phpa_builder_background")));
				hshResult.put("phpa_project_finance",correctNull(rs.getString("phpa_project_finance")));
				hshResult.put("phpa_loc_road",correctNull(rs.getString("phpa_loc_road")));
				hshResult.put("phpa_loc_market",correctNull(rs.getString("phpa_loc_market")));
				hshResult.put("phpa_loc_public",correctNull(rs.getString("phpa_loc_public")));
				hshResult.put("phpa_loc_neighbourhood",correctNull(rs.getString("phpa_loc_neighbourhood")));
				hshResult.put("phpa_ame_road",correctNull(rs.getString("phpa_ame_road")));
				hshResult.put("phpa_ame_water",correctNull(rs.getString("phpa_ame_water")));
				hshResult.put("phpa_ame_drainage",correctNull(rs.getString("phpa_ame_drainage")));
				hshResult.put("phpa_ame_electricity",correctNull(rs.getString("phpa_ame_electricity")));
				hshResult.put("phpa_already_mortgage",correctNull(rs.getString("phpa_already_mortgage")));
				hshResult.put("phpa_ame_securtype",correctNull(rs.getString("phpa_ame_securtype")));
				hshResult.put("phpa_ame_securclassific",correctNull(rs.getString("phpa_ame_securclassific")));
				hshResult.put("phpa_natureofcharge",correctNull(rs.getString("phpa_natureofcharge")));
				hshResult.put("phpa_sec_secid",correctNull(rs.getString("phpa_sec_secid")));
				
				hshResult.put("PHPA_HOUSE_TYPE",correctNull(rs.getString("PHPA_HOUSE_TYPE")));

				hshResult.put("phpa_hidtown",correctNull(rs.getString("phpa_hidtown")));

				if(!correctNull(rs.getString("phpa_hidtown")).equalsIgnoreCase(""))
				{
					if(rs1 !=null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeLAPSQuery("sel_townnamebycode^"+ correctNull(rs.getString("phpa_hidtown")));	
					if (rs1.next()) 
					{
						hshResult.put("phpa_town_desc",correctNull(rs1.getString("TOWN_DESC")));
					}
				}
				
				hshResult.put("phpa_metlifepremiumamt",Helper.correctDouble(rs.getString("phpa_metlifepremiumamt")));
				hshResult.put("phpa_constucion_cost",Helper.correctDouble(rs.getString("phpa_constucion_cost")));
				strSecId= correctNull(rs.getString("phpa_sec_secid"));
				recordflag="Y";
			}
			
			rs=null;
			
			//for grid=======================================
			if(rs !=null)
			{rs.close();}
			rs=DBUtils.executeLAPSQuery("sel_per_house_proposed_asset^"+ strAppno);			 
			while(rs.next())
			{
				vecCol = new ArrayList();
				strPur_Name="";
				vecCol.add(correctNull(rs.getString("phpa_appno")));//0
				vecCol.add(correctNull(rs.getString("phpa_loan_purpose")));//1
				strPur_Name= correctNull(rs.getString("phpa_loan_purpose")).trim();
				vecCol.add(correctNull(rs.getString("phpa_take_over")));//2
				vecCol.add(correctNull(rs.getString("phpa_prop_type")));//3
				vecCol.add(correctNull(rs.getString("phpa_prop_nature")));//4
				vecCol.add(correctNull(rs.getString("phpa_prop_usedfor")));//5
				vecCol.add(correctNull(rs.getString("phpa_premises_age")));//6
				vecCol.add(correctNull(rs.getString("phpa_residual_life")));//7
				vecCol.add(correctNull(rs.getString("phpa_branch_distance")));//8
				vecCol.add(correctNull(rs.getString("phpa_prop_location")));//9
				String strSurveyno=correctNull(rs.getString("phpa_prop_surveyno"));
				if(strSurveyno.contains("@")){
					vecCol.add(strSurveyno.replaceAll("@", ","));//10
				}else{
				vecCol.add(correctNull(rs.getString("phpa_prop_surveyno")));//10
				}
				vecCol.add(correctNull(rs.getString("phpa_prop_plotno")));//11
				vecCol.add(correctNull(rs.getString("phpa_prop_street")));//12
				vecCol.add(correctNull(rs.getString("phpa_prop_taluk")));//13
							
				if(rs1 !=null)
				{
					rs1.close();
				}
				rs1=DBUtils.executeLAPSQuery("sel_citynamebycode^"+ correctNull(rs.getString("phpa_prop_city")));	
				if (rs1.next()) 
				{
					vecCol.add(correctNull(rs1.getString("city_name")));//city name//14
					//vecCol.add(correctNull(rs.getString("phpa_prop_city")));//code//15
				}
				else
				{
					vecCol.add(correctNull(rs.getString("phpa_prop_city")));//14
					//vecCol.add(correctNull(rs.getString("phpa_prop_city")));//15
				}
				vecCol.add(correctNull(rs.getString("phpa_prop_city")));//code//15
				
				if(rs1 !=null)
				{
					rs1.close();
				}
				rs1=DBUtils.executeLAPSQuery("sel_distnamebycode^"+ correctNull(rs.getString("phpa_prop_district")));	
				if (rs1.next()) 
				{
					vecCol.add(correctNull(rs1.getString("district_desc")));//name//16
					vecCol.add(correctNull(rs.getString("phpa_prop_district")));//code//17
				}
				else
				{
					vecCol.add(correctNull(rs.getString("phpa_prop_district")));//16
					vecCol.add(correctNull(rs.getString("phpa_prop_district")));//17
				}
				if(rs1 !=null)
				{
					rs1.close();
				}
				rs1=DBUtils.executeLAPSQuery("sel_statenamebycode^"+ correctNull(rs.getString("phpa_prop_state")));	
				if (rs1.next()) 
				{
					vecCol.add(correctNull(rs1.getString("state_name")));//name//18
					vecCol.add(correctNull(rs.getString("phpa_prop_state")));//code//19
				}
				else
				{
					vecCol.add(correctNull(rs.getString("phpa_prop_state")));//18
					vecCol.add(correctNull(rs.getString("phpa_prop_state")));//19
				}
				
				vecCol.add(correctNull(rs.getString("phpa_prop_pincode")));//20
				vecCol.add(correctNull(rs.getString("phpa_site_area")));//21
				vecCol.add(correctNull(rs.getString("phpa_floorspace_area")));//22
				vecCol.add(correctNull(rs.getString("phpa_site_market_value")));//23
				vecCol.add(correctNull(rs.getString("phpa_site_purchase_price")));//24
				vecCol.add(correctNull(rs.getString("phpa_site_valuation_cost")));//25
				vecCol.add(correctNull(rs.getString("phpa_bldg_market_value")));//26
				vecCol.add(correctNull(rs.getString("phpa_bldg_purchase_price")));//27
				vecCol.add(correctNull(rs.getString("phpa_bldg_valuation_cost")));//28
				vecCol.add(correctNull(rs.getString("phpa_bldg_estimate_cost")));//29
				vecCol.add(correctNull(rs.getString("phpa_bldg_rennovation_cost")));//30
				vecCol.add(correctNull(rs.getString("phpa_project_name")));//31
				vecCol.add(correctNull(rs.getString("phpa_project_details")));//32
				vecCol.add(correctNull(rs.getString("phpa_builder_name")));//33
				vecCol.add(correctNull(rs.getString("phpa_builder_background")));//34
				vecCol.add(correctNull(rs.getString("phpa_project_finance")));//35
				vecCol.add(correctNull(rs.getString("phpa_loc_road")));//36
				vecCol.add(correctNull(rs.getString("phpa_loc_market")));//37
				vecCol.add(correctNull(rs.getString("phpa_loc_public")));//38
				vecCol.add(correctNull(rs.getString("phpa_loc_neighbourhood")));//39
				vecCol.add(correctNull(rs.getString("phpa_ame_road")));//40
				vecCol.add(correctNull(rs.getString("phpa_ame_water")));//41
				vecCol.add(correctNull(rs.getString("phpa_ame_drainage")));//42
				vecCol.add(correctNull(rs.getString("phpa_ame_electricity")));//43
				vecCol.add(correctNull(rs.getString("phpa_already_mortgage")));//44
				vecCol.add(correctNull(rs.getString("phpa_ame_securtype")));//45
				vecCol.add(correctNull(rs.getString("phpa_ame_securclassific")));//46
				vecCol.add(correctNull(rs.getString("phpa_natureofcharge")));//47
				vecCol.add(correctNull(rs.getString("phpa_sec_secid")));//48
				vecCol.add(correctNull(rs.getString("PHPA_HOUSE_TYPE")));//49
				vecCol.add(correctNull(rs.getString("phpa_hidtown")));//50
				vecCol.add(correctNull(rs.getString("phpa_metlifepremiumamt")));//51
				vecCol.add(correctNull(rs.getString("PHPA_SNO")));//52
				vecCol.add(correctNull(rs.getString("PHPA_SEC_SECURITYID")));//53
				if(!correctNull(rs.getString("phpa_ame_securtype")).equalsIgnoreCase(""))
				{
					if(rs1 !=null)
					{rs1.close();}
					rs1=DBUtils.executeLAPSQuery("sel_secName^"+ correctNull(rs.getString("phpa_ame_securtype")));	
					if (rs1.next()) 
					{
						vecCol.add(correctNull(rs1.getString("sec_name")));//54
					}
				}
				if(!correctNull(rs.getString("phpa_loan_purpose")).equalsIgnoreCase(""))
				{
					strPurpose="";
					if(strPur_Name.equalsIgnoreCase("0"))
						strPurpose = "Select";
					else if(strPur_Name.equalsIgnoreCase("G"))
						strPurpose = "Purchase of Site";
					else if(strPur_Name.equalsIgnoreCase("C"))
						strPurpose = "Construction of House";
					else if(strPur_Name.equalsIgnoreCase("S"))
						strPurpose = "Purchase of Site & Construction of House";
					else if(strPur_Name.equalsIgnoreCase("H"))
						strPurpose = "Purchase of Ready Built House/Flat";
					else if(strPur_Name.equalsIgnoreCase("R"))
						strPurpose = "Renovation";
					else if(strPur_Name.equalsIgnoreCase("M"))
						strPurpose = "Mortgage";
					vecCol.add(strPurpose);//55
				}else{
				vecCol.add("");//55
				}
				
				if(!correctNull(rs.getString("phpa_hidtown")).equalsIgnoreCase(""))
				{
					if(rs1 !=null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeLAPSQuery("sel_townnamebycode^"+ correctNull(rs.getString("phpa_hidtown")));	
					if (rs1.next()) 
					{
						vecCol.add(correctNull(rs1.getString("TOWN_DESC")));//56
					}
					else
					{
						vecCol.add(correctNull(rs.getString("phpa_hidtown")));//56
					}
					
				}
				else{
					vecCol.add(correctNull(rs.getString("phpa_hidtown")));//56
				}
				//for value as per valuation from property details tab
				if(!correctNull(rs.getString("PHPA_SEC_SECURITYID")).equalsIgnoreCase(""))
				{
					if(rs1 !=null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeLAPSQuery("selsecpropdet^"+ correctNull(rs.getString("PHPA_SEC_SECURITYID")));	
					if (rs1.next()) 
					{
						vecCol.add(correctNull(rs1.getString("SEC_VALUERVALUE")));//57
						vecCol.add(correctNull(rs1.getString("sec_salevalue")));//58
					}
					else{
						vecCol.add("");//57
						vecCol.add("");//58
					}
					
				}
				else{
					vecCol.add("");//57
					vecCol.add("");//58
				}
				vecCol.add(Helper.correctDouble(rs.getString("phpa_constucion_cost")));//59
				
				vecRow.add(vecCol);
				
			}
			hshResult.put("vecRow",vecRow);
			
			if(rs !=null)
			{rs.close();}
			rs=DBUtils.executeLAPSQuery("selecttakeover^"+ strAppno);	
			if (rs.next()) 
			{
				hshResult.put("loan_takeover",correctNull(rs.getString("loan_takeover")));
				hshResult.put("phpa_premises_age",correctNull(rs.getString("loan_ageofveh")));
				hshResult.put("phpa_metlifepremiumamt",Helper.correctDouble(rs.getString("loan_metlifepremiumamt")));
				hshResult.put("govt_scheme",Helper.correctNull(rs.getString("govt_scheme")));
			}
			if(rs !=null)
			{rs.close();}
			String strProdPurpose="";
			if(strPrdcode.length()>0)
			{
			/*Commented by Arsath for performance Tunings
			 * Unwanted Join has been removed from existing query
			 */
			//rs=DBUtils.executeLAPSQuery("selprodpurpose^"+ strPrdcode);
			rs=DBUtils.executeLAPSQuery("selprodpurpose_new^"+ strPrdcode);
			if(rs.next())
			{
				strProdPurpose=Helper.correctNull((String)rs.getString("prd_purpose"));
			}
			}
			/*
			 * 			For Purchase of Ready Built House and Used Vehicle loan, 
			 * 				Margin is based on age of the building / vehicle respectively
			 */
			hshResult.put("strProdPurpose", strProdPurpose);
			
			/*Commented by Arsath for performance Tunings
			 * Unwanted Join has been removed from existing below queries
			 */
			//if(strProdPurpose.equalsIgnoreCase("H") || strProdPurpose.equalsIgnoreCase("U")) 
			//{
			//	rs=DBUtils.executeLAPSQuery("pergetloanProductbymargin^"+ strAppno);
			//}
			//else
			//{
			//	rs=DBUtils.executeLAPSQuery("pergetloanProduct^"+ strAppno);
			//}
			
			rs=DBUtils.executeLAPSQuery("getloanterms^"+ strAppno);
			if(rs.next())
			{
				
				hshResult.put("lreqterms", correctNull((String)rs.getString("loan_terms")));
				hshResult.put("loan_ageofveh", correctNull((String)rs.getString("loan_ageofveh")));	
				hshResult.put("loan_costproj", correctNull((String)rs.getString("loan_costloanprd")));
				
				//strQuery=SQLParser.getSqlQuery("sel_specificeligible^"+strPrdcode);
				strQuery=SQLParser.getSqlQuery("sel_specificeligible_new^"+strPrdcode);
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{  
					hshResult.put("prd_repayperiodhouse",correctNull(rs1.getString("prd_hourepperiod")));					
				}				
			}
			
			/*Commented by Arsath for performance Tunings
			 *Below field inserted already existing above query "getloanterms"
			 */
			//rs=null;
			//rs=DBUtils.executeLAPSQuery("selvehage^"+ strAppno);
			//if(rs.next())
			//{				
			//	hshResult.put("loan_ageofveh", correctNull((String)rs.getString("loan_ageofveh")));												
			//}
			
			/*Commented by Arsath for performance Tunings
			 *Below field not used in the page
			 */
			//if(!strPrdcode.equalsIgnoreCase(""))
			//{
			//	if(rs!=null)
			//	{
			//		rs.close();
			//	}
			//	rs=DBUtils.executeLAPSQuery("sel_proincomeflag^"+strPrdcode);
			//	if(rs.next())
				//{
				//	hshResult.put("housepurpose",correctNull(rs.getString("prd_purpose")));			
				//}
			//}
			
			//*Commented by Arsath - Not used anywhere
			//String strAppid="";
			//if(strAppid.equalsIgnoreCase(""))
			//{
			//	String strAppid=Helper.correctNull((String)hshValues.get("hidapplicantid"));
			//	if(strAppid.equalsIgnoreCase(""))
			//	{
			//		strAppid=Helper.correctNull((String) hshValues.get("hidDemoId"));
			//	}
			//}
			
			//if(!strAppid.equalsIgnoreCase(""))
			//{
			//	rs = DBUtils.executeLAPSQuery("select_perappoldid^" + strAppid);
			//	if(rs.next())
			//	{
			//		strAppid=Helper.correctNull((String)rs.getString("perapp_oldid"));
			//	}
			//}
			
			// For per_house_proposed_asset Count
			//rs = DBUtils.executeLAPSQuery("sel_perHouse_count^" + strAppno);
			//if(rs.next())
			//{
			//	intAtuoCount=rs.getInt("perhouse_count");
			//}
			
			if(recordflag.equalsIgnoreCase("Y"))
			{
				strQuery = SQLParser.getSqlQuery("sel_appsecDetails_secid^" +strAppno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()) 
				{
					strSecId=Helper.correctNull((String)rs.getString("app_sec_secid"));
				}
				
				hshResult.put("strSecId",strSecId);
				
				if(!strSecId.equalsIgnoreCase(""))
				{
					strQuery = SQLParser.getSqlQuery("securities_sel^" + strSecId);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next()) 
					{
						hshResult.put("cus_sec_joint_holder",Helper.correctNull((String)rs.getString("cus_sec_joint_holder")));
					}
				}
			}
			
			if(!strSecId.equalsIgnoreCase(""))
			{
				if (rs != null) 
				{
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("securities_sel^" + strSecId);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()) 
				{
					strQuery = SQLParser.getSqlQuery("securities_owner_sel^" + strSecId);
					rs1 = DBUtils.executeQuery(strQuery);
					while (rs1.next()) 
					{
						String strSeperator="@";
	
						String strId=Helper.correctNull((String)rs1.getString("cus_owner_laps_id"));
						String strName="";
						String strCBSID="";
						String strOldID="";
						strQuery = SQLParser.getSqlQuery("selcustomerdetails^"+strId);
						rs2 = DBUtils.executeQuery(strQuery);
						if(rs2.next())
						{
							
							 strName=Helper.correctNull((String)rs2.getString("perapp_fname"));
							 strOldID=Helper.correctNull((String)rs2.getString("perapp_oldid"));
							 strCBSID=Helper.correctNull((String)rs2.getString("perapp_cbsid"));
						}
						strJointOwnDetails.append(strName)
										  .append(strSeperator)
										  .append(strOldID)
										  .append(strSeperator)
										  .append(strCBSID)
										  .append(strSeperator)
										  .append(strSecId)
										  .append(strSeperator);
						//Commented by Arsath - Changed to string builder for better performance
						//strJointOwnDetails+=strName;
						//strJointOwnDetails+=strSeperator;
						//strJointOwnDetails+=strOldID;
						//strJointOwnDetails+=strSeperator;
						//strJointOwnDetails+=strCBSID;
						//strJointOwnDetails+=strSeperator;
					}
					//strJointOwnDetails+=strSecId;
				}
				hshResult.put("strJointOwnDetails", strJointOwnDetails.toString());
			}
			if (rs != null) 
			{
				rs.close();
			}	
			String strAppid=Helper.correctNull((String)hshValues.get("hidapplicantid"));			
			rs = DBUtils.executeLAPSQuery("select_perappoldid^" + strAppid);
			if(rs.next())
			{
				strAppid=Helper.correctNull((String)rs.getString("perapp_oldid"));
			}
			hshResult.put("oldAppid", strAppid);
			
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("findapptype^"+ strAppno);
    		rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshResult.put("prd_applicablefor", Helper.correctNull((String)rs.getString("PRD_APPLICABLEFOR")));
			}
			
    		//for checking freeze count
    		int strFreezecount=0;
    		String strFreezeflag="N",strPrioityflag="N";
    		strQuery = SQLParser.getSqlQuery("sel_freezecount^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{	
				strFreezecount=Integer.parseInt(Helper.correctInt((String)rs.getString("freezecount")));
				if(strFreezecount!=0 )
				{
					strFreezeflag="Y";
				}
			}
			if( Helper.correctNull((String)hshValues.get("hidAction")).equalsIgnoreCase("undo"))
			{
				strFreezeflag="N";
			}
    		hshResult.put("strFreezeflag",strFreezeflag);
			/********************************************/	
    		//for proposed assets check 
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_editApply_valuation^"+ strAppno);
    		rs = DBUtils.executeQuery(strQuery);
			while(rs.next()) 
			{
				if(Helper.correctNull((String)rs.getString("EDIT_APPLY_FLAG")).equalsIgnoreCase("N")){
					hshResult.put("valuationFlag","N");
				}
			}
    			
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_editApply_house^"+ strAppno);
    		rs = DBUtils.executeQuery(strQuery);
			while(rs.next()) 
			{
				if(Helper.correctNull((String)rs.getString("PHPA_EDIT_APPLYFLAG")).equalsIgnoreCase("N")){
					hshResult.put("HouseEdit_Flag","N");
				}
			}
			
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_editApply_vehicle^"+ strAppno);
    		rs = DBUtils.executeQuery(strQuery);
			while(rs.next()) 
			{
				if(Helper.correctNull((String)rs.getString("AUTO_EDIT_APPLYFLAG")).equalsIgnoreCase("N")){
					hshResult.put("VehicleEdit_Flag","N");
				}
			}
    		
		} 
		catch (Exception ce) 
		{
			throw new EJBException("Error in closing getHousingLoanData" + ce.getMessage());
		}
		finally 
		{
			try 
			{
				if (rs != null) 
				{
					rs.close();
				}
			}
			catch (Exception e) 
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshResult;		
	}
	public String getROIData(HashMap hshValues) 
	{
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		ResultSet rs=null;
		String strQuery="";
		String strPrdCode="";
		String strFinalVal="";
		String strRecAmt="";
		String strLesser = ">=";
		String strGreater = "<=";
		String strAdditionalIntRate ="";
		String strMonths="";
		try
		{
			String strAppNo=Helper.correctNull((String)hshValues.get("appno"));
			if(strAppNo.equalsIgnoreCase(""))
			{
				strAppNo=Helper.correctNull((String)hshValues.get("strappno"));
			}
			String strBankType=Helper.correctNull((String)hshValues.get("sel_banktype"));
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("sel_productcode^"+strAppNo);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strPrdCode=Helper.correctNull((String)rs.getString("app_prdcode"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			if(!strPrdCode.equalsIgnoreCase(""))
			{
				if(strBankType.equalsIgnoreCase("1"))
				{
					String strRateOfInt=Helper.correctNull((String)hshValues.get("txt_rateofint"));
					strQuery=SQLParser.getSqlQuery("sel_prdaddintrate^"+strAppNo);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strAdditionalIntRate=Helper.correctNull((String)rs.getString("prd_addintrate"));
					}
					if(!strRateOfInt.equalsIgnoreCase("")&&!strAdditionalIntRate.equalsIgnoreCase(""))
					{
						double dblAdditionalIntRate=Double.parseDouble(Helper.correctDouble(strAdditionalIntRate));
						double dblRateOfInt=Double.parseDouble(Helper.correctDouble(strRateOfInt));
						double dblFinalVal=dblAdditionalIntRate+dblRateOfInt;
						strFinalVal=Helper.correctNull((String)jtn.format(dblFinalVal));
					}
				}
				else if(strBankType.equalsIgnoreCase("2"))
				{
					strFinalVal="0";
					/*String strMaturityDate=Helper.correctNull((String)hshValues.get("txtmatdate"));
					if(!strMaturityDate.equalsIgnoreCase(""))
					{
						if(rs!=null)
						{
							rs.close();
						}
						strQuery=SQLParser.getSqlQuery("sel_maturemonths^"+strMaturityDate);
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strMonths=Helper.correctNull((String)rs.getString("maturemonths"));
						}
					}
					if(rs!=null)
					{
						rs.close();
					}
					strQuery=SQLParser.getSqlQuery("getApprovedLoanDetails^"+strAppNo);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strRecAmt=Helper.correctNull((String)rs.getString("loan_amtreqd"));
					}
					if(!strRecAmt.equalsIgnoreCase("")&&!strMonths.equalsIgnoreCase(""))
					{
						if(rs!=null)
						{
							rs.close();
						}
						strQuery = SQLParser.getSqlQuery("selinttyperate^" + "fixed" + "^" + strPrdCode + "^" + strGreater + "^"
								+ strRecAmt + "^" + strLesser + "^" + strRecAmt + "^O^" + strGreater + "^" + strMonths + "^"
								+ strLesser + "^" + strMonths);
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strFinalVal=Helper.correctNull((String)rs.getString("prd_interest"));
						}
						else
						{
							if(rs!=null)
							{
								rs.close();
							}
							strQuery=SQLParser.getSqlQuery("sel_maxtermintrate^"+strPrdCode+"^"+strPrdCode);
							rs=DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								strFinalVal=Helper.correctNull((String)rs.getString("prd_interest"));
							}
						}
					}*/
					
				}
				
				rs=DBUtils.executeLAPSQuery("chk_thirdpartydeposit^"+strAppNo);
				if(rs.next())
				{
					strFinalVal=Helper.correctNull((String)rs.getString("LOAN_RATEINCHARGES"));
				}
			}
		}
		catch (Exception ce) 
		{
			throw new EJBException("Error in closing getROIData" + ce.getMessage());
		}
		finally 
		{
			try 
			{
				if (rs != null) 
				{
					rs.close();
				}
			}
			catch (Exception e) 
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return strFinalVal;
	}
	/**
	 * @author:Karthikeyan.S
	 * @date:June 13, 2013-12:41:54 PM
	 * @category to Pull Customer Deposit Details from Finacle
	 * @return
	 * @
	 */
	public void PullCustDepDetails(HashMap hshValues) 
	{
		HashMap hshResult=new HashMap();
		HashMap hshRecord=new HashMap();
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		ResultSet rs=null;
		ResultSet rs1=null;
		String strSecUpdFlag="", strSecId="", str_txtdeppercent="", strAppno="", strid="";
		String txtpresentdate="", strIssuseoffice="", strStandname="", strAccountno="", strIssuedate="", strFacevalue="";
		String str_txtrateofint="", str_txtprsntos="", str_txtmatval="", str_txttenure="", str_txtmatdate="";
		String str_txtmargin="", strBankType="1", strQuery="", strAppId="", strCBSId="", strAction="insert";
		try
		{
			strAppId=Helper.correctNull((String)hshValues.get("hidapplicantid"));
			hshValues.put("strAppid",strAppId);
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("selcustomerdetails^"+strAppId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strCBSId=Helper.correctNull((String)rs.getString("perapp_cbsid"));
			}
			strAppno=Helper.correctNull((String)hshValues.get("appno"));
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=Helper.correctNull((String)hshValues.get("strappno"));
			}
			if(!strCBSId.equalsIgnoreCase(""))
			{
				if(rs!=null)
				{
					rs.close();
				}
				
				if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
				{
						strQuery=SQLParser.getCBSSqlQuery("sel_fddepositdet_newconnection^"+strCBSId);
						rs=DBUtils.executeQueryCBSConnection(strQuery);
				}
				else
				{
					strQuery=SQLParser.getSqlQuery("sel_fddepositdet^"+strCBSId);
					rs=DBUtils.executeQuery(strQuery);
				}
				while(rs.next())
				{
					strIssuseoffice=Helper.correctNull((String)rs.getString("loan_issuebranch"));
					strStandname=Helper.correctNull((String)rs.getString("loan_standname"));
					strAccountno=Helper.correctNull((String)rs.getString("loan_accno"));
					strIssuedate=Helper.correctNull((String)rs.getString("loan_dateofissue"));
					str_txtmatdate=Helper.correctNull((String)rs.getString("loan_matdate"));
					strFacevalue=Helper.correctNull((String)rs.getString("loan_faceval"));
					str_txtprsntos=Helper.correctNull((String)rs.getString("loan_presentos"));
					txtpresentdate=Helper.correctNull((String)rs.getString("loan_presentosason"));
					str_txtmatval=Helper.correctNull((String)rs.getString("loan_maturityval"));
					str_txtrateofint=Helper.correctNull((String)rs.getString("loan_rateofint"));
					hshValues.put("txtaccountno", strAccountno);
					hshValues.put("txt_prsntos", str_txtprsntos);
					hshValues.put("txt_rateofint", str_txtrateofint);
					hshValues.put("txtmatdate", str_txtmatdate);
					SecurityMasterBean SM=new SecurityMasterBean();
					hshResult=updateSecurities(hshValues);
					strSecUpdFlag=Helper.correctNull((String)hshResult.get("strSecUpdFlag"));
					strSecId=Helper.correctNull((String)hshResult.get("hidSecurityId"));
					hshRecord.put("hidSecurityId",strSecId);
					hshRecord.put("hidAction",strAction);
					hshRecord.put("sel_bank",strBankType);
					hshRecord.put("strFldName",strIssuseoffice);
					hshRecord.put("strFldCode","");
					hshRecord.put("txt_accountno",strAccountno);
					hshRecord.put("txt_rateintrest",str_txtrateofint);
					hshRecord.put("txt_Issue_Date",strIssuedate);
					hshRecord.put("txt_Face_PrinciValue",strFacevalue);
					hshRecord.put("txt_Maturity_Value",str_txtmatval);
					hshRecord.put("txt_Present_BookValue",str_txtprsntos);
					hshRecord.put("txt_Due_Date",str_txtmatdate);
					
					SM.updateSecurityBankDeposit(hshRecord);
					hshValues.put("sel_banktype",strBankType);
					str_txtdeppercent=getROIData(hshValues);
					hshQueryValues = new HashMap();
					hshQuery=new HashMap();
					hshQuery.put("strQueryId","Ins_loanagainstdep");
					arrValues=new ArrayList();
					if(rs1!=null)
					{
						rs1.close();
					}
					strQuery=SQLParser.getSqlQuery("Sel_MaxId_loanagainstdep^"+strAppno);
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						strid = correctNull((String)rs1.getString("maxid"));
					}
					arrValues.add(strid);				
					arrValues.add(strAppno);
					arrValues.add(strIssuseoffice);
					arrValues.add(strStandname);
					arrValues.add(strAccountno);				
					arrValues.add(strIssuedate);
					arrValues.add(strFacevalue);
					arrValues.add(str_txtrateofint);	
					arrValues.add(str_txtprsntos);	
					arrValues.add(txtpresentdate);
					arrValues.add(str_txtmatval);	
					arrValues.add(str_txttenure);	
					arrValues.add(str_txtmatdate);	
					arrValues.add(str_txtdeppercent);	
					arrValues.add(str_txtmargin);	
					arrValues.add(strBankType);	
					arrValues.add(strSecId);
					arrValues.add(strSecUpdFlag);
					arrValues.add("F");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in PullCustDepDetails "+ce.toString());
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
	/**
	 * @author:Karthikeyan.S
	 * @date:June 13, 2013-12:41:54 PM
	 * @category to Pull Other Deposit Details from Finacle
	 * @return
	 * @
	 */
	public HashMap getOtherDepDetails(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		ArrayList arryRow=new ArrayList();
		ArrayList arryCol=new ArrayList();
		String strQuery="", strQuery2="";
		String strCBSId="";
		String strExp="$";
		String strCustName="";
		String strAppno="";
		String strCustCBSId="";
		String strBankType="";
		String strUserId="";
		String strAppId="";
		String strSpecialCust="";
		String strPageFrom="";
		try
		{
			strAppno=Helper.correctNull((String)hshValues.get("strappno"));
			strCBSId=Helper.correctNull((String)hshValues.get("txtsearch"));
			strBankType=Helper.correctNull((String)hshValues.get("strBankType"));
			strUserId=Helper.correctNull((String)hshValues.get("strUserId"));
			strAppId=Helper.correctNull((String)hshValues.get("hidapplicantid"));
			strPageFrom=Helper.correctNull((String)hshValues.get("pagefrom"));
			/*
			 * Restricting search for Customer CBS ID in Other Bank Deposits
			 */
			
			
			if((strPageFrom.equalsIgnoreCase("ers")||strPageFrom.equalsIgnoreCase("oth"))&&!strAppno.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("sel_cbsidfordepositdet^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strCustCBSId=Helper.correctNull((String)rs.getString("perapp_cbsid"));
				}
				if(strCustCBSId.equalsIgnoreCase(strCBSId))
				{
					strExp=strExp+"CBS ID "+strCustCBSId+" is related to the Borrower. Please continue search by using some other ID";
					throw new Exception(strExp);
				}
			}
			
			/*
			 * End - Restricting search for Customer CBS ID in Other Bank Deposits
			 */
			
			if(rs!=null)
			{
				rs.close();
			}
			
			/*
			 * Checking whether the Applicant has LAPS ID
			 */
			
			strQuery=SQLParser.getSqlQuery("sel_lapsidfromcbsid^"+strCBSId);
			rs1=DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				String strLAPSCustID=Helper.correctNull((String)rs1.getString("perapp_id"));
				String strWhetherStaff="";
				strQuery2=SQLParser.getSqlQuery("sel_staffandemptype^"+strLAPSCustID);
				rs2=DBUtils.executeQuery(strQuery2);
				if(rs2.next())
				{
					strWhetherStaff=Helper.correctNull((String)rs2.getString("indinfo_is_staff"));
				}
				
				if(rs2!=null)
					rs2.close();
				
				//Existing Staff can pull deposit from all the branchs like staff, Special Customers.
				
				if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
				{
					strQuery=SQLParser.getCBSSqlQuery("cbscusmastersearch_newconnection^"+strCBSId);
					rs2=DBUtils.executeQueryCBSConnection(strQuery);
				}
				else
				{
					strQuery= SQLParser.getSqlQuery("cbscusmastersearch^"+strCBSId);
					rs2=DBUtils.executeQuery(strQuery); 
				}
				if(rs2.next())
				{
					if(Helper.correctNull(rs2.getString("cust_type_code")).equalsIgnoreCase("03"))
						strWhetherStaff="02";	
				}
				
				
				
				
				strCustName=Helper.correctNull((String)rs1.getString("perapp_fname"));
				
				if(strAppId.equalsIgnoreCase(""))
				{
					strAppId=strLAPSCustID;
				}
				/*
				 * Global Deposit Details Search for Staffs
				 */
				if(rs2!=null)
				{
					rs2.close();
				}
				strQuery2=SQLParser.getSqlQuery("getlreq^"+strAppno);
				rs2=DBUtils.executeQuery(strQuery2);
				if(rs2.next())
				{
					strSpecialCust=Helper.correctNull((String)rs2.getString("loan_specialcust"));
				}
				if(rs2!=null)
				{
					rs2.close();
				}
				strQuery2=SQLParser.getSqlQuery("sel_loanaccno_byappno^"+strAppno);
				rs2=DBUtils.executeQuery(strQuery2);
				int iArrLength=0;
				while(rs2.next())
				{
					iArrLength++;
				}
				String strMulLoanAccNo[]=new String[iArrLength];
				strQuery2=SQLParser.getSqlQuery("sel_loanaccno_byappno^"+strAppno);
				rs2=DBUtils.executeQuery(strQuery2);
				int i=0;
				while(rs2.next())
				{
					strMulLoanAccNo[i]=Helper.correctNull((String)rs2.getString("loan_accno"));
					i++;
				}
				String strMulAcNoCollect=" ";
				for(int j=0;j<iArrLength;j++)
				{
					if(j==iArrLength-1)
					{
						strMulAcNoCollect=strMulAcNoCollect.trim()+strMulLoanAccNo[j];
					}
					else
					{
						strMulAcNoCollect=strMulAcNoCollect.trim()+strMulLoanAccNo[j]+",";
					}
					
				}
				
				String strTemp1=" ",strDepType="";
				
				strQuery = SQLParser.getSqlQuery("findapptype^" + strAppno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()) 
				{
					strDepType=Helper.correctNull(rs.getString("prd_deposittype"));
				}
				
				if(strDepType.equalsIgnoreCase("H"))
				{
					strTemp1 = "and SCHM_CODE='HDD11'";
				}
				else
				{
					strTemp1 = "and SCHM_CODE!='HDD11'";
				}
				
				if(rs2!=null)
				{ rs2.close(); }
				
				if(strWhetherStaff.equalsIgnoreCase("02")||strSpecialCust.equalsIgnoreCase("Y"))
				{
					if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
					{
							strQuery=SQLParser.getCBSSqlQuery("sel_fddepositdet_newconnection^"+strCBSId+"^"+strMulAcNoCollect+"^"+strTemp1);
							rs=DBUtils.executeQueryCBSConnection(strQuery);
					}
					else
					{
						strQuery=SQLParser.getSqlQuery("sel_fddepositdet^"+strCBSId+"^"+strAppno);
						rs=DBUtils.executeQuery(strQuery);
					}
					
				}
				
				/*
				 * End - Global Deposit Details Search for Staffs
				 */
				
				/*
				 * Deposits within the Base branch search for other than Staffs
				 */
				
				else
				{
					if(rs2!=null)
					{
						rs2.close();
					}
					String strOrgCode="";
					strQuery2=SQLParser.getSqlQuery("sel_orgbyusrid^"+strUserId);
					rs2=DBUtils.executeQuery(strQuery2);
					if(rs2.next())
					{
						strOrgCode=Helper.correctNull(rs2.getString("org_scode"));
					}
					if(rs2!=null)
					{
						rs2.close();
					}
					
					if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
					{
							strQuery=SQLParser.getCBSSqlQuery("sel_fddepositdetothers_newconnection^"+strCBSId+"^"+strMulAcNoCollect+"^"+strOrgCode+"^"+strTemp1);
							rs=DBUtils.executeQueryCBSConnection(strQuery);
					}
					else
					{
					strQuery=SQLParser.getSqlQuery("sel_fddepositdetothers^"+strCBSId+"^"+strAppno+"^"+strUserId);
					rs=DBUtils.executeQuery(strQuery);
					}
				}
				
				/*
				 * End - Deposits within the Base branch search for other than Staffs
				 */
				
				String currdate = Helper.getCurrentDateTime();
				String strmaturitydate="",strmature="";
				int datecount=0;
			
				while(rs.next())
				{
					arryCol=new ArrayList();
					arryCol.add(strCustName);//0
					arryCol.add(Helper.correctNull((String)rs.getString("loan_issuebranch")));//1
					arryCol.add(Helper.correctNull((String)rs.getString("loan_standname")));//2
					arryCol.add(Helper.correctNull((String)rs.getString("loan_accno")));//3
					arryCol.add(Helper.correctNull((String)rs.getString("loan_dateofissue")));//4
					arryCol.add(Helper.correctNull((String)rs.getString("loan_matdate")));//5
					arryCol.add(Helper.correctDouble((String)rs.getString("loan_faceval")));//6
					arryCol.add(Helper.correctDouble((String)rs.getString("loan_presentos")));//7
					arryCol.add(Helper.correctDouble((String)rs.getString("loan_maturityval")));//8
					arryCol.add(Helper.correctDouble((String)rs.getString("loan_rateofint")));//9
					arryCol.add(Helper.correctNull((String)rs.getString("loan_cbscusid")));//10
					arryRow.add(arryCol);
					/*strmaturitydate=Helper.correctNull((String)rs.getString("loan_matdate"));
					SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
					java.util.Date date1;
					java.util.Date date2;
					date1 = sdf.parse(strmature);
					date2 = sdf.parse(currdate);
					if(date1.after(date2)){
						datecount++;
						log.info("********************datecount************************"+datecount);
					}*/
				}
				/*if(datecount>0){
					hshRecord.put("maturityDate", "Y");
				}*/
			}
			else
			{
				strExp=strExp+"Please create Customer Profile in LAPS for the given CBS ID";
				throw new Exception(strExp);
			}
			
			/*
			 * End - Checking whether the Applicant has LAPS ID
			 */
			hshRecord.put("arryRow", arryRow);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getOtherDepDetails "+ce.toString());
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
	 * @date:June 13, 2013-12:41:54 PM
	 * @category to Undo the Pulled Data
	 * @return
	 * @
	 */
	public void UndoPulledDetails(HashMap hshValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		HashMap hshRecord=new HashMap();
		ArrayList arrValues=new ArrayList();
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		ResultSet rs3=null;
		String strSecId="", strQuery="", strAppno="", strid="", strUpdFlag="";
		String strQuery2="",strAction="";
		StringBuilder sbOldAudit = new StringBuilder();
		StringBuilder sbActionData=new StringBuilder();
		try
		{
			strAction=Helper.correctNull((String)hshValues.get("hidAction"));
			strAppno=Helper.correctNull((String)hshValues.get("appno"));
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=Helper.correctNull((String)hshValues.get("strappno"));
			}
			
			if(strAction.equalsIgnoreCase("undo"))
			{
				strQuery=SQLParser.getSqlQuery("sel_entryflag^"+strAppno+"^F");		// F - for denoting Deposit details which have been pulled from Finacle 
				rs1=DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					strid=Helper.correctNull((String)rs1.getString("loan_slno"));
					strSecId=Helper.correctNull((String)rs1.getString("loan_secid"));
					/***
					 * For Audit Trial Old Data - By Karthikeyan.S on 20/09/2013
					 */
					strQuery2=SQLParser.getSqlQuery("sel_loanagainstdepositbysno^"+strid+"^"+strAppno);
					rs2=DBUtils.executeQuery(strQuery2);
					if(rs2.next())
					{
						String strBankType=Helper.correctNull((String)rs2.getString("loan_banktype"));
						String strBankTypeDesc="";
						if(strBankType.equalsIgnoreCase("1"))
						{
							strBankTypeDesc="Our Bank";
						}
						else if(strBankType.equalsIgnoreCase("2"))
						{
							strBankTypeDesc="3rd Party";
						}
						String strBranchCode=Helper.correctNull((String)rs2.getString("loan_issuebranch"));
						String strBranchDesc="";
						String strQuery3=SQLParser.getSqlQuery("selectorgappl^"+strBranchCode);
						rs3=DBUtils.executeQuery(strQuery3);
						if(rs3.next())
						{
							strBranchDesc=Helper.correctNull((String)rs3.getString("org_name"));
						}
						sbOldAudit.append("~Bank Type=").append(strBankTypeDesc)
						.append("~Issuing branch/ post office=").append(strBranchDesc)
						.append("~Standing in the name of=").append(Helper.correctNull((String)rs2.getString("loan_standname")))
						.append("~Account no.=").append(Helper.correctNull((String)rs2.getString("loan_accno")))
						.append("~Date of issue=").append(Helper.correctNull((String)rs2.getString("laon_dateofissue")))
						.append("~Maturity date=").append(Helper.correctNull((String)rs2.getString("loan_matdate")))
						.append("~Face value (Rs)=").append(Helper.correctDouble((String)rs2.getString("loan_faceval")))
						.append("~Present value (Rs)=").append(Helper.correctDouble((String)rs2.getString("loan_presentos")))
						.append("~Present Value as on=").append(Helper.correctNull((String)rs2.getString("loan_presentason")))
						.append("~Maturity value (Rs)=").append(Helper.correctDouble((String)rs2.getString("loan_maturityval")))
						.append("~Rate of interest on Deposit (%)=").append(Helper.correctDouble((String)rs2.getString("loan_rateofint")))
						.append("~ROI charged on loan against deposit %=").append(Helper.correctDouble((String)rs2.getString("loan_rateincharges")));
						/***
						 * End - Audit Trial Old Data
						 */
					}
//					if(!strSecId.equalsIgnoreCase(""))
//					{
//						if(rs!=null)
//						{
//							rs.close();
//						}
//						strQuery=SQLParser.getSqlQuery("sel_depositupdflag^"+strSecId);
//						rs=DBUtils.executeQuery(strQuery);
//						if(rs.next())
//						{
//							strUpdFlag=Helper.correctNull((String)rs.getString("loan_updflag"));
//						}
//						if(!strUpdFlag.equalsIgnoreCase("Y"))
//						{
//							hshQuery = new HashMap();
//							arrValues = new ArrayList();
//							hshQuery.put("strQueryId", "del_securities");
//							arrValues.add(strSecId);
//							hshQuery.put("arrValues", arrValues);
//							hshQueryValues.put("1", hshQuery);
//			
//							hshQuery = new HashMap();
//							arrValues = new ArrayList();
//							hshQuery.put("strQueryId", "del_ownership_securities");
//							arrValues.add(strSecId);
//							hshQuery.put("arrValues", arrValues);
//							hshQueryValues.put("2", hshQuery);
//							hshQueryValues.put("size", "2");
//							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//							hshRecord.put("hidSecurityId",strSecId);
//							hshRecord.put("hidAction","delete");
//							SecurityMasterBean SM=new SecurityMasterBean();
//							SM.updateSecurityBankDeposit(hshRecord);
//						}
//					}
					hshQueryValues = new HashMap();
					hshQuery=new HashMap();
					hshQuery.put("strQueryId","Del_loanagnstdep");
					arrValues=new ArrayList();
					arrValues.add(strAppno);
					arrValues.add(strid);				
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					/***
					 * For Audit Trial Old Data - By Karthikeyan.S on 20/09/2013
					 */
					AuditTrial.auditNewLog(hshValues, "227", strAppno, sbActionData.toString(), sbOldAudit.toString());
					/***
					 * End - Audit Trial Old Data
					 */
				}
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				
					strid=Helper.correctNull((String)hshValues.get("hid_sno"));
					strSecId=Helper.correctNull((String)hshValues.get("hidSecurityId"));
					String strBankType="";
					strQuery2=SQLParser.getSqlQuery("sel_loanagainstdepositbysno^"+strid+"^"+strAppno);
					rs2=DBUtils.executeQuery(strQuery2);
					if(rs2.next())
					{
						strBankType=Helper.correctNull((String)rs2.getString("loan_banktype"));
						String strBankTypeDesc="";
						if(strBankType.equalsIgnoreCase("1"))
						{
							strBankTypeDesc="Our Bank";
						}
						else if(strBankType.equalsIgnoreCase("2"))
						{
							strBankTypeDesc="3rd Party";
						}
						String strBranchCode=Helper.correctNull((String)rs2.getString("loan_issuebranch"));
						String strBranchDesc="";
						String strQuery3=SQLParser.getSqlQuery("selectorgappl^"+strBranchCode);
						rs3=DBUtils.executeQuery(strQuery3);
						if(rs3.next())
						{
							strBranchDesc=Helper.correctNull((String)rs3.getString("org_name"));
						}
						sbOldAudit.append("~Bank Type=").append(strBankTypeDesc)
						.append("~Issuing branch/ post office=").append(strBranchDesc)
						.append("~Standing in the name of=").append(Helper.correctNull((String)rs2.getString("loan_standname")))
						.append("~Account no.=").append(Helper.correctNull((String)rs2.getString("loan_accno")))
						.append("~Date of issue=").append(Helper.correctNull((String)rs2.getString("laon_dateofissue")))
						.append("~Maturity date=").append(Helper.correctNull((String)rs2.getString("loan_matdate")))
						.append("~Face value (Rs)=").append(Helper.correctDouble((String)rs2.getString("loan_faceval")))
						.append("~Present value (Rs)=").append(Helper.correctDouble((String)rs2.getString("loan_presentos")))
						.append("~Present Value as on=").append(Helper.correctNull((String)rs2.getString("loan_presentason")))
						.append("~Maturity value (Rs)=").append(Helper.correctDouble((String)rs2.getString("loan_maturityval")))
						.append("~Rate of interest on Deposit (%)=").append(Helper.correctDouble((String)rs2.getString("loan_rateofint")))
						.append("~ROI charged on loan against deposit %=").append(Helper.correctDouble((String)rs2.getString("loan_rateincharges")));
						/***
						 * End - Audit Trial Old Data
						 */
					}
//					if(!strSecId.equalsIgnoreCase(""))
//					{
//						if(rs!=null)
//						{
//							rs.close();
//						}
//						strQuery=SQLParser.getSqlQuery("sel_depositupdflag^"+strSecId);
//						rs=DBUtils.executeQuery(strQuery);
//						if(rs.next())
//						{
//							strUpdFlag=Helper.correctNull((String)rs.getString("loan_updflag"));
//						}
//						if(!strUpdFlag.equalsIgnoreCase("Y"))
//						{
//							hshQuery = new HashMap();
//							arrValues = new ArrayList();
//							hshQuery.put("strQueryId", "del_securities");
//							arrValues.add(strSecId);
//							hshQuery.put("arrValues", arrValues);
//							hshQueryValues.put("1", hshQuery);
//			
//							hshQuery = new HashMap();
//							arrValues = new ArrayList();
//							hshQuery.put("strQueryId", "del_ownership_securities");
//							arrValues.add(strSecId);
//							hshQuery.put("arrValues", arrValues);
//							hshQueryValues.put("2", hshQuery);
//							hshQueryValues.put("size", "2");
//							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//							hshRecord.put("hidSecurityId",strSecId);
//							hshRecord.put("hidAction","delete");
//							SecurityMasterBean SM=new SecurityMasterBean();
//							SM.updateSecurityBankDeposit(hshRecord);
//						}
//					}
					hshQueryValues = new HashMap();
					hshQuery=new HashMap();
					hshQuery.put("strQueryId","Del_loanagnstdep");
					arrValues=new ArrayList();
					arrValues.add(strAppno);
					arrValues.add(strid);				
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					if(strBankType.equalsIgnoreCase("2"))
					{
						if(rs2!=null)
							rs2.close();
						
						rs2=DBUtils.executeLAPSQuery("chk_thirdpartydeposit^"+strAppno);
						if(!rs2.next())
						{
							if(rs!=null)
								rs.close();
							rs=DBUtils.executeLAPSQuery("sel_prdaddintrate^"+strAppno);
							if(rs.next())
							{
								hshQueryValues = new HashMap();
								hshQuery=new HashMap();
								hshQuery.put("strQueryId","upd_allloanagainstdeposit_intrate");
								arrValues=new ArrayList();
								arrValues.add(Helper.correctDouble(rs.getString("prd_addintrate")));
								arrValues.add(strAppno);
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("1",hshQuery);
								hshQueryValues.put("size", "1");
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
								
							}
						}
					}
					
					
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in UndoPulledDetails "+ce.toString());
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
	public void PullOtherDepDetails(HashMap hshValues) 
	{
		HashMap hshResult=new HashMap();
		HashMap hshRecord=new HashMap();
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		ResultSet rs3=null;
		ArrayList arrValues=new ArrayList();
		String strAcNo="", strIndAcNo;
		String strAppNo="";
		String strStatus="";
		String strExp="$";
		String strAlert[]= new String[20];
		String[] strAcNos=null;
		String strSecUpdFlag="", strSecId="", str_txtdeppercent="", strAppno="", strid="", strGuardCBSID="", strAppCBSID="", strMinor="";
		String txtpresentdate="", strIssuseoffice="", strStandname="", strAccountno="", strIssuedate="", strFacevalue="";
		String str_txtrateofint="", str_txtprsntos="", str_txtmatval="", str_txttenure="", str_txtmatdate="";
		String str_txtmargin="", strBankType="", strQuery="", strAppId="", strCBSId="", strAction="insert", strQuery2="";
		String strBnkTypeFlg="",strDepType="",strAgriPrd="";
		try
		{
			
			
			strCBSId=Helper.correctNull((String)hshValues.get("txtsearch"));
			strAppno=Helper.correctNull((String)hshValues.get("strappno"));
			if(!strCBSId.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("sel_lapsidfromcbsid^"+strCBSId);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strAppId=Helper.correctNull((String)rs.getString("perapp_oldid"));
				}
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			strQuery = SQLParser.getSqlQuery("findapptype^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()) 
			{
				strDepType=Helper.correctNull(rs.getString("prd_deposittype"));
				strAgriPrd=Helper.correctNull(rs.getString("PRD_WHETHERAGRI"));
			}
			if(rs!=null)
				rs.close();
			if(Helper.correctNull((String)hshValues.get("strBankType")).equalsIgnoreCase("1"))
			{
				strBankType="1";					
			}
			else
			{
				if(Helper.correctNull((String)hshValues.get("hidPageFrom")).equalsIgnoreCase("ers"))
				{
					strBankType="1";
				}
				else
				{
					strBankType="2";
				}
				/*if(!strAppId.equalsIgnoreCase(""))
				{
					strQuery2=SQLParser.getSqlQuery("sel_minordetails^"+strAppId);
					rs2=DBUtils.executeQuery(strQuery2);
					if(rs2.next())
					{
						strMinor=Helper.correctNull((String)rs2.getString("indinfo_is_minor"));
						if(strMinor.equalsIgnoreCase("Y"))
						{
							strGuardCBSID=Helper.correctNull((String)rs2.getString("indinfo_guardian_appid"));
							if(!strAppno.equalsIgnoreCase(""))
							{
								strQuery=SQLParser.getSqlQuery("sel_oldidfromappno^"+strAppno);
								rs=DBUtils.executeQuery(strQuery);
								if(rs.next())
								{
									strAppCBSID=Helper.correctNull((String)rs.getString("perapp_cbsid"));
								}
							}
							if(strGuardCBSID.equalsIgnoreCase(strAppCBSID))
							{
								strBankType="1";
							}
							if(rs!=null)
							{
								rs.close();
							}
						}
					}
				}*/
			}
			strAcNo=Helper.correctNull((String)hshValues.get("selaccno"));
			if(!strAcNo.equalsIgnoreCase(""))
			{
				strAcNos=(String[])strAcNo.split("~");
			}
			if(strAcNos!=null&&strAcNos.length>0)
			{
				for(int i=0;i<strAcNos.length;i++)
				{
					strIndAcNo=strAcNos[i];
					strQuery=SQLParser.getSqlQuery("sel_depositaccno^"+strIndAcNo);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						String strAppNo1=Helper.correctNull((String)rs.getString("loan_appno"));
						strStatus=Helper.correctNull((String)rs.getString("app_status"));
						
						if(strStatus.equalsIgnoreCase("op"))
						{
							strExp=strExp+"Cannot attach the deposit "+strIndAcNo+". It has already been attached with Open/Pending Application "+strAppNo1;
							throw new Exception(strExp);
						}
					}
					
					if(rs!=null)
					{
						rs.close();
					}
					
					String strTemp="to_char(maturity_date,'dd/mm/yyyy')";
					String strTemp1=" ";
					
					if(strDepType.equalsIgnoreCase("H"))
					{
						strTemp="to_char(add_months(sysdate,'24'),'dd/mm/yyyy')";
						strTemp1 = "and SCHM_CODE='HDD11'";
					}

					if(strAgriPrd.equalsIgnoreCase("Y") && !strDepType.equalsIgnoreCase("H"))
					{
						strTemp="to_char(least(to_date(to_char(maturity_date,'dd/mm/yyyy'),'dd/mm/yyyy'),to_date(to_char(add_months(sysdate,'24'),'dd/mm/yyyy'),'dd/mm/yyyy')),'dd/mm/yyyy')";
						strTemp1 = " ";
					}
					
					if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
					{
						strQuery=SQLParser.getCBSSqlQuery("sel_fddepositacc_newconnection^"+strTemp+"^"+strIndAcNo+"^"+strTemp1);
						rs=DBUtils.executeQueryCBSConnection(strQuery);
					}
					else
					{
						strQuery=SQLParser.getSqlQuery("sel_fddepositacc^"+strTemp+"^"+strIndAcNo+"^"+strTemp1);
						rs=DBUtils.executeQuery(strQuery);
					}
					
					
					while(rs.next())
					{
						StringBuffer sbActionData=new StringBuffer();
						StringBuilder sbOldAudit = new StringBuilder();
						strIssuseoffice=Helper.correctNull((String)rs.getString("loan_issuebranch"));
						strStandname=Helper.correctNull((String)rs.getString("loan_standname"));
						strAccountno=Helper.correctNull((String)rs.getString("loan_accno"));
						strIssuedate=Helper.correctNull((String)rs.getString("loan_dateofissue"));
						str_txtmatdate=Helper.correctNull((String)rs.getString("loan_matdate"));
						strFacevalue=Helper.correctNull((String)rs.getString("loan_faceval"));
						str_txtprsntos=Helper.correctNull((String)rs.getString("loan_presentos"));
						txtpresentdate=Helper.correctNull((String)rs.getString("loan_presentosason"));
						str_txtmatval=Helper.correctNull((String)rs.getString("loan_maturityval"));
						str_txtrateofint=Helper.correctNull((String)rs.getString("loan_rateofint"));
						/*if(rs1!=null)
						{
							rs1.close();
						}
						strQuery2=SQLParser.getSqlQuery("sel_bnktypeflg^"+strAccountno);
						rs1=DBUtils.executeQuery(strQuery2);
						if(rs1.next())
						{
							strBnkTypeFlg=Helper.correctNull((String)rs1.getString("bnktypeflg"));
						}
						if(strBnkTypeFlg.equalsIgnoreCase("Y"))
						{
							strBankType="2";
						}*/
						hshValues.put("txtaccountno", strAccountno);
						hshValues.put("txt_prsntos", str_txtprsntos);
						hshValues.put("txt_rateofint", str_txtrateofint);
						hshValues.put("txtmatdate", str_txtmatdate);
						//SecurityMasterBean SM=new SecurityMasterBean();
						hshValues.put("strAppid",strAppId);
						//hshResult=updateSecurities(hshValues);
						strSecUpdFlag=Helper.correctNull((String)hshResult.get("strSecUpdFlag"));
						strSecId=Helper.correctNull((String)hshResult.get("hidSecurityId"));
						hshRecord.put("hidSecurityId",strSecId);
						hshRecord.put("hidAction",strAction);
						hshRecord.put("sel_bank",strBankType);
						hshRecord.put("strFldName",strIssuseoffice);
						hshRecord.put("strFldCode","");
						hshRecord.put("txt_accountno",strAccountno);
						hshRecord.put("txt_rateintrest",str_txtrateofint);
						hshRecord.put("txt_Issue_Date",strIssuedate);
						hshRecord.put("txt_Face_PrinciValue",strFacevalue);
						hshRecord.put("txt_Maturity_Value",str_txtmatval);
						hshRecord.put("txt_Present_BookValue",str_txtprsntos);
						hshRecord.put("txt_Due_Date",str_txtmatdate);
						
						//SM.updateSecurityBankDeposit(hshRecord);
						hshValues.put("sel_banktype",strBankType);
						str_txtdeppercent=getROIData(hshValues);
						hshQueryValues = new HashMap();
						hshQuery=new HashMap();
						hshQuery.put("strQueryId","Ins_loanagainstdep");
						arrValues=new ArrayList();
						if(rs1!=null)
						{
							rs1.close();
						}
						strQuery=SQLParser.getSqlQuery("Sel_MaxId_loanagainstdep^"+strAppno);
						rs1=DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							strid = correctNull((String)rs1.getString("maxid"));
						}
						arrValues.add(strid);				
						arrValues.add(strAppno);
						arrValues.add(strIssuseoffice);
						arrValues.add(strStandname);
						arrValues.add(strAccountno);				
						arrValues.add(strIssuedate);
						arrValues.add(strFacevalue);
						arrValues.add(str_txtrateofint);	
						arrValues.add(str_txtprsntos);
						arrValues.add(txtpresentdate);
						arrValues.add(str_txtmatval);	
						arrValues.add(str_txttenure);	
						arrValues.add(str_txtmatdate);	
						arrValues.add(str_txtdeppercent);	
						arrValues.add(str_txtmargin);	
						arrValues.add(strBankType);	
						arrValues.add(strSecId);
						arrValues.add(strSecUpdFlag);
						arrValues.add("F");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						hshQueryValues.put("size","1");
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						/***
						 * For Audit Trial New Data - By Karthikeyan.S on 19/09/2013
						 */
						String strBankTypeDesc="";
						if(strBankType.equalsIgnoreCase("1"))
						{
							strBankTypeDesc="Our Bank";
						}
						else if(strBankType.equalsIgnoreCase("2"))
						{
							strBankTypeDesc="3rd Party";
						}
						if(rs1!=null)
						{
							rs1.close();
						}
						String strIssuseofficeDesc="";
						String strQuery3=SQLParser.getSqlQuery("selectorgappl^"+strIssuseoffice);
						rs3=DBUtils.executeQuery(strQuery3);
						if(rs3.next())
						{
							strIssuseofficeDesc=Helper.correctNull((String)rs3.getString("org_name"));
						}
						
						sbActionData.append("~Bank Type=").append(strBankTypeDesc)
						.append("~Issuing branch/ post office=").append(strIssuseofficeDesc)
						.append("~Standing in the name of=").append(strStandname)
						.append("~Account no.=").append(strAccountno)
						.append("~Date of issue=").append(strIssuedate)
						.append("~Maturity date=").append(str_txtmatdate)
						.append("~Face value (Rs)=").append(strFacevalue)
						.append("~Present value (Rs)=").append(str_txtprsntos)
						.append("~Present Value as on=").append(txtpresentdate)
						.append("~Maturity value (Rs)=").append(str_txtmatval)
						.append("~Rate of interest on Deposit (%)=").append(str_txtrateofint)
						.append("~ROI charged on loan against deposit %=").append(str_txtdeppercent);

						AuditTrial.auditNewLog(hshValues, "227", strAppno, sbActionData.toString(), sbOldAudit.toString());
						/***
						 * End - Audit Trial New Data
						 */
					}
				}
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in PullCustDepDetails "+ce.toString());
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
	/**
	 * @author:Karthikeyan.S
	 * @date:August 28, 2013-11:10:51 PM
	 * @category to update Recommended Loan Amount for Gold Loan & Deposit Loan
	 * @return
	 * @
	 */
	public void updateLoanRecmdAmtData(String strAppNo, double dblCostLoanPrd) 
	{
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		ResultSet rs=null;
		String strQuery="";
		double dblAmtReqd=0.00, dblMarginPerc=0.00, dblTotalCost=0.00, dblAmtRecommended=0.00, dblMPBFAmt=0.00;
		try
		{
			strQuery=SQLParser.getSqlQuery("get_perloandetails_renew^"+strAppNo);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				dblAmtReqd=Double.parseDouble(Helper.correctDouble((String)rs.getString("LOAN_AMTREQD")));
				dblMarginPerc=Double.parseDouble(Helper.correctDouble((String)rs.getString("LOAN_MARGIN")));
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("selectmpbfeligibleamount^"+strAppNo);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				dblMPBFAmt=Double.parseDouble(Helper.correctDouble((String)rs.getString("mpbf_eligibleamount")));
			}
			dblTotalCost=dblCostLoanPrd*(100-dblMarginPerc)/100;
			dblAmtRecommended=Math.min(dblTotalCost,dblAmtReqd);
			
			if((dblMPBFAmt!=0.00)&&(dblMPBFAmt<dblAmtRecommended))
			{
				dblAmtRecommended=dblMPBFAmt;
			}
			
			String strLoanProcFee = "",strPrdCode="";
			strQuery=SQLParser.getSqlQuery("comfunsel1^"+strAppNo);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strPrdCode=Helper.correctNull(rs.getString("app_prdcode"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			if (!strPrdCode.trim().equals(""))
			{
				HashMap hshTemp=new HashMap();
				hshTemp.put("appid", strAppNo);
				hshTemp.put("prdcode", strPrdCode);
				hshTemp.put("recamt",jtn.format(dblAmtRecommended)); 
																							
				hshTemp = (HashMap) EJBInvoker.executeStateLess("perlimitofloan", hshTemp, "getDocFee");
				strLoanProcFee = Helper.correctDouble((String) hshTemp.get("procfeenew"));
			}
			
			String strCollpercent="";
			PerApplicantBean perapp = new PerApplicantBean();
			strCollpercent = perapp.getCollateralpercent(strAppNo, String.valueOf(dblAmtRecommended));
			hshQuery.put("strQueryId","upd_LoanRecmdAmt");
			arrValues.add(jtn.format(dblAmtRecommended));
			arrValues.add(strCollpercent);
			arrValues.add(strLoanProcFee);
			arrValues.add(strAppNo);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);
			hshQueryValues.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateLoanRecmdAmtData "+ce.toString());
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
	/**
	 * @author:Guhan.T
	 * @date:September 30, 2013-02:33:51 PM
	 * @category to update Security Description for Gold Loan & Deposit Loan
	 * @return
	 * @
	 */
	public void updateSecurityDesc(HashMap hshValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String appno=Helper.correctNull((String)hshValues.get("strappno"));
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		String strComments=Helper.correctNull((String)hshValues.get("txtar_security_desc"));
		try
		{
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues.put("size", "2");
				hshQuery.put("strQueryId", "del_sec_desc");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId", "ins_sec_desc");
				arrValues.add(appno);
				arrValues.add(strComments);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_sec_desc");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
			}
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updatedata");
		}
		catch (Exception e)
		{
			throw new EJBException("Error in updatesecuritydesc Data " + e.getMessage());
		}
	}
	public HashMap getSecurityDesc(HashMap hshValues) 
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery="";
		String appno=Helper.correctNull((String)hshValues.get("strappno"));
		try
		{
			strQuery=SQLParser.getSqlQuery("sel_sec_desc^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				hshResult.put("security_desc", Helper.correctNull(rs.getString("SEC_DESCRIPTION")));
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getSecurityDesc" + e.getMessage());
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
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshResult;
	}
	
	
	public void updatePMAYdata(HashMap hshValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String appno=Helper.correctNull((String)hshValues.get("appno"));
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		
		try
		{
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues.put("size", "2");
				hshQuery.put("strQueryId", "del_pmay_desc");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId", "ins_pmay_desc");
				arrValues.add(appno);
				arrValues.add(correctNull((String) hshValues.get("sel_house_cat")));
				arrValues.add(correctNull((String) hshValues.get("sel_loan_type")));
				arrValues.add(correctNull((String) hshValues.get("sel_own_mode")));
				arrValues.add(correctNull((String) hshValues.get("sel_borr_pucca")));
				arrValues.add(correctNull((String) hshValues.get("sel_pre_cat")));
				arrValues.add(correctNull((String) hshValues.get("sel_subsid_inst")));
				arrValues.add(correctNull((String) hshValues.get("txt_other_category")));
				arrValues.add(correctNull((String) hshValues.get("sel_cert_house_own")));
				arrValues.add(correctNull((String) hshValues.get("sel_source_app")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				
			}
			
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_pmay_desc");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
			}
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updatedata");
	
		}
		catch (Exception e)
		{
			throw new EJBException("Error in updatePMAYdata Data " + e.getMessage());
		}
	}
	
	public HashMap getPMAYdata(HashMap hshValues) 
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null,rs1=null;
		String strQuery="",strgovtsch="";
		String appno=Helper.correctNull((String)hshValues.get("appno"));
		try
		{
			strQuery=SQLParser.getSqlQuery("sel_PMAY_desc^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()) 
			{
				hshResult.put("PMAY_HOUSE_CAT", Helper.correctNull(rs.getString("PMAY_HOUSE_CAT")));
				hshResult.put("PMAY_LOAN_TYPE", Helper.correctNull(rs.getString("PMAY_LOAN_TYPE")));
				hshResult.put("PMAY_OWN_MODE", Helper.correctNull(rs.getString("PMAY_OWN_MODE")));
				hshResult.put("PMAY_BORR_PUCCA", Helper.correctNull(rs.getString("PMAY_BORR_PUCCA")));
				hshResult.put("PMAY_PREFER_CAT", Helper.correctNull(rs.getString("PMAY_PREFER_CAT")));
				hshResult.put("PMAY_SUBSID_INST", Helper.correctNull(rs.getString("PMAY_SUBSID_INST")));
				hshResult.put("PMAY_OTHER_CATEGORY", Helper.CLOBToString(rs.getClob("PMAY_OTHER_CATEGORY")));
				hshResult.put("PMAY_SOURCE_APP", Helper.correctNull(rs.getString("PMAY_SOURCE_APP")));
				hshResult.put("PMAY_CERTIF_HOUSEOWN", Helper.correctNull(rs.getString("PMAY_CERTIF_HOUSEOWN")));
				hshResult.put("recordflag", "Y");
				
			}
			if(rs1!=null)
			{
				rs1.close();
			}
			strQuery=SQLParser.getSqlQuery("pergetloanProduct^"+appno);
			rs1=DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				hshResult.put("PMAY_GOVT_SCHEME", Helper.correctNull(rs1.getString("govt_scheme")));

			}
			hshResult.put("strSubCategory",Helper.correctNull((String)hshValues.get("hidsubcat")));

			
			
		
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getPMAYdata" + e.getMessage());
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
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshResult;
	}
	
	public HashMap getAHPdata(HashMap hshValues) 
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null,rs1=null;
		String strQuery="",strgovtsch="";
		String appno=Helper.correctNull((String)hshValues.get("appno"));
		try
		{
			strQuery=SQLParser.getSqlQuery("sel_ahp_details^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()) 
			{
				hshResult.put("AHP_ALLOTMENT_LETTER", Helper.correctNull(rs.getString("AHP_ALLOTMENT_LETTER")));
				hshResult.put("AHP_INCOME_CERTIFICATE", Helper.correctNull(rs.getString("AHP_INCOME_CERTIFICATE")));
				hshResult.put("AHP_BRANCHNAME", Helper.correctNull(rs.getString("AHP_BRANCHNAME")));
				hshResult.put("AHP_BANKNAME_CODE", Helper.correctNull(rs.getString("AHP_BANKNAME")));
				hshResult.put("AHP_ACCNUMBER", Helper.correctNull(rs.getString("AHP_ACCNUMBER")));
				hshResult.put("AHP_IFSCCODE", Helper.correctNull(rs.getString("AHP_IFSCCODE")));
				hshResult.put("AHP_GOI_AMT", Helper.correctNull(rs.getString("AHP_GOI_AMT")));
				hshResult.put("AHP_GOK_AMT", Helper.correctNull(rs.getString("AHP_GOK_AMT")));
				hshResult.put("AHP_SAVINGS", Helper.correctNull(rs.getString("AHP_SAVINGS")));
				String branchCode="";
				String stat_id="147";
				branchCode=Helper.correctNull(rs.getString("AHP_BANKNAME"));
				strQuery=SQLParser.getSqlQuery("selstatdatabyiddesc^"+stat_id+"^"+branchCode);
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next()) 
				{
					hshResult.put("AHP_BANKNAME", Helper.correctNull(rs1.getString("stat_data_desc1")));
				}
				
				
				hshResult.put("recordflag", "Y");
				
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("selperprdmargin^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshResult.put("AHP_COSTLOANPRD", Helper.correctNull(rs.getString("loan_costloanprd")));

			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_sanccustdet_ahp^" + appno
					+ "^ d.demo_type in('a','c')");
			rs = DBUtils.executeQuery(strQuery);
			String resType="";
			if(rs.next())
			{
				resType=Helper.correctNull(rs.getString("CON_RESTYPE"));
				hshResult.put("AHP_RESIDENT_TYPE", Helper.correctNull(rs.getString("CON_RESTYPE")));
				
			}
		    if(("0").equalsIgnoreCase(resType)){
		    	hshResult.put("custflag", "N");	
		    }else{
			hshResult.put("custflag", "Y"); 
		    }
			
		
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getAHPdata" + e.getMessage());
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
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshResult;
	}
	public void updateAHPdata(HashMap hshValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String appno=Helper.correctNull((String)hshValues.get("appno"));
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		
		try
		{
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues.put("size", "2");
				hshQuery.put("strQueryId", "del_ahp_details");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId", "ins_ahp_details");
				arrValues.add(appno);
				arrValues.add(correctNull((String) hshValues.get("sel_allotment_letter")));
				arrValues.add(correctNull((String) hshValues.get("sel_income_certificate")));
				arrValues.add(correctNull((String) hshValues.get("hid_LeadBankcode")));
				arrValues.add(correctNull((String) hshValues.get("txt_branchname")));
				arrValues.add(correctNull((String) hshValues.get("txt_accnumber")));
				arrValues.add(correctNull((String) hshValues.get("txt_ifsccode")));
				arrValues.add(correctNull((String) hshValues.get("txt_costloanprd")));
				arrValues.add(correctNull((String) hshValues.get("txt_goi_amt")));
				arrValues.add(correctNull((String) hshValues.get("txt_gok_amt")));
				arrValues.add(correctNull((String) hshValues.get("hid_restype")));
				arrValues.add(correctNull((String) hshValues.get("txt_savings")));
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				
			}
			
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_ahp_details");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
			}
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updatedata");
	
		}
		catch (Exception e)
		{
			throw new EJBException("Error in updateAHPdata Data " + e.getMessage());
		}
	}
	

}
	