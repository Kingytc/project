package com.sai.laps.ejb.agrfarmmachinery;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.rules.AgrFarmMachineryBO;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "AgrFarmMachineryBean", mappedName = "AgrFarmMachineryHome")
@Remote (AgrFarmMachineryRemote.class)
public class AgrFarmMachineryBean extends BeanAdapter 
{
	static Logger log=Logger.getLogger(AgrFarmMachineryBean.class);	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public void updateFarmMachineryDetails(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String appno="",strfacsno="",stragrschemetype="";
				
		if(appno.trim().equalsIgnoreCase("")){
			appno=Helper.correctNull((String)hshValues.get("hidappno"));
		}
		
		if(appno.trim().equalsIgnoreCase("")){
			appno=Helper.correctNull((String)hshValues.get("appno"));
		}
		strfacsno = Helper.correctNull((String)hshValues.get("hidfacsno"));
		stragrschemetype = Helper.correctNull((String)hshValues.get("hidscheme"));
		
		try
		{
			if(strAction.equals("Edit"))
			{
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
				hshQueryValues.put("size","2");	
				hshQuery = new HashMap();					
				hshQuery.put("strQueryId","agrfarmmachinery_delete");
				arrValues.add(appno);
				arrValues.add(strfacsno);
				arrValues.add(stragrschemetype);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);			 
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agrfarmmachinery_insert");
				arrValues.add(appno);
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_category")));
				arrValues.add(Helper.correctNull((String )hshValues.get("sel_typeofvehicle")));
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_brandname")));
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_make")));
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_model")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_costoftractor")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_costoftrailer")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_costofimplements")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_totalcost")));
				if(Helper.correctNull((String )hshValues.get("txt_dateofproforma")).equalsIgnoreCase(""))
					arrValues.add(null);
				else
					arrValues.add(Helper.correctNull((String )hshValues.get("txt_dateofproforma")));
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_valuationdone")));
				if(Helper.correctNull((String )hshValues.get("txt_dateofvaluation")).equalsIgnoreCase(""))
					arrValues.add(null);
				else
					arrValues.add(Helper.correctNull((String )hshValues.get("txt_dateofvaluation")));				
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_nameofdealer")));
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_dealersince")));
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_address1")));
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_address2")));
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_district")));
				arrValues.add(Helper.correctNull((String )hshValues.get("sel_authoriseddealer")));
				if(Helper.correctNull((String )hshValues.get("txt_dateofdelivery")).equalsIgnoreCase(""))
					arrValues.add(null);
				else
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_dateofdelivery")));
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_city")));
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_state")));
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_pincode")));
				arrValues.add(Helper.correctNull((String )hshValues.get("txtarea_comments")));
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_others")));
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_othercost")));
				arrValues.add(stragrschemetype);
				arrValues.add(strfacsno);
				arrValues.add(Helper.correctNull((String )hshValues.get("txt_deprciation")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");		
			}
			else if(strAction.equals("delete"))
			{
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");					
				hshQuery.put("strQueryId","agrfarmmachinery_delete");
				arrValues.add(appno);
				arrValues.add(strfacsno);
				arrValues.add(stragrschemetype);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");				
			}
	
		/*	By Guhan.T
		 	StringBuilder sbAuditTrial=new StringBuilder();
			sbAuditTrial.append("Type of vehicle = ").append(Helper.correctNull((String )hshValues.get("sel_typeofvehicle")))
			.append("~Brand Name= ").append(Helper.correctDouble((String )hshValues.get("txt_brandname")))
			.append("~Make= ").append(Helper.correctDouble((String )hshValues.get("txt_make")))
			.append("~Model= ").append(Helper.correctDouble((String )hshValues.get("txt_model")))
			.append("~Cost of Tractor= ").append(Helper.correctDouble((String )hshValues.get("txt_costoftractor")))
			.append("~Cost of Trailor= ").append(Helper.correctDouble((String )hshValues.get("txt_costoftrailer")))
			.append("~Cost of Impliments= ").append(Helper.correctDouble((String )hshValues.get("txt_costofimplements")))
			.append("~Total Cost= ").append(Helper.correctDouble((String )hshValues.get("txt_totalcost")))
			.append("~Date of Proforma= ").append(Helper.correctDouble((String )hshValues.get("txt_dateofproforma")))
			.append("~Valuation Done= ").append(Helper.correctDouble((String )hshValues.get("txt_valuationdone")))
			.append("~Date of valuation= ").append(Helper.correctDouble((String )hshValues.get("txt_dateofvaluation")))
			.append("~Name of Dealer= ").append(Helper.correctDouble((String )hshValues.get("txt_nameofdealer")))
			.append("~Dealer Since= ").append(Helper.correctDouble((String )hshValues.get("txt_dealersince")))
			.append("~Address 1= ").append(Helper.correctDouble((String )hshValues.get("txt_address1")))
			.append("~Address 2= ").append(Helper.correctDouble((String )hshValues.get("txt_address2")))
			.append("~District= ").append(Helper.correctDouble((String )hshValues.get("txt_district")))
			.append("~Authorised Dealer= ").append(Helper.correctDouble((String )hshValues.get("sel_authoriseddealer")))
			.append("~Date of Delivery= ").append(Helper.correctDouble((String )hshValues.get("txt_dateofdelivery")))
			.append("~City= ").append(Helper.correctDouble((String )hshValues.get("txt_city")))
			.append("~State= ").append(Helper.correctDouble((String )hshValues.get("txt_state")))
			.append("~Pincode= ").append(Helper.correctDouble((String )hshValues.get("txt_pincode")))
			.append("~Remarks= ").append(Helper.correctDouble((String )hshValues.get("txtarea_comments")))
			.append("~Others= ").append(Helper.correctDouble((String )hshValues.get("txt_others")))
			.append("~Other Cost= ").append(Helper.correctDouble((String )hshValues.get("txt_othercost")));
			
			AuditTrial.auditLog(hshValues,"212",appno,sbAuditTrial.toString()); */
	
		}
		catch(Exception ce)
		{
			log.error("Error in updateCropAssessmentDetails of BankAppBean"+ce.getMessage());
			throw new EJBException("inside updateCropAssessmentDetails"+ce.toString());
		}
		finally
		{
			try
			{
				
			}
			catch(Exception cf)
			{
				log.error("Error in updateCropAssessmentDetails of BankAppBean"+cf.getMessage());
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}		
	}
	
	public HashMap getFarmMachineryDetails(HashMap hshValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strschemetype="",strfacsno="",stragrschemetype="";
		HashMap hshScheme = new HashMap();
				
		String appno=null;
		HashMap hshFarmMachinery=null;
		//String schemetype = correctNull((String)hshValues.get("schemetype"));		
		try
		{
			appno=Helper.correctNull((String)hshValues.get("hidappno")).trim();
			strschemetype	= Helper.correctNull((String )hshValues.get("schemetype"));	
			hshScheme = Helper.splitScheme(strschemetype);
			
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			if(appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("appno")).trim();
			}			
			if(rs!=null){rs.close();}			
			hshFarmMachinery= new AgrFarmMachineryBO().getFarmMachineryDetByAppNo(appno,strfacsno,stragrschemetype);
			hshRecord.put("hshFarmMachinery",hshFarmMachinery);
			if(rs!=null){rs.close();}
			rs=DBUtils.executeLAPSQuery("selgovtsceme^"+appno);
			if(rs.next())
			{
				hshRecord.put("PROJECTCOST",Helper.correctNull(rs.getString("facility_proposed")));
			}		
		}
		catch(Exception ce)
		{
			log.error("Error in getCropAssessmentDetails of agrcropsBean"+ce.getMessage());
			throw new EJBException("Error in getCropAssessmentDetails "+ce.toString());
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
				log.error("Error in getCropAssessmentDetails of agrcropsBean"+cf.getMessage());
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}
	
	public void updateIncomeHireDetails(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String appno="",strfacsno="",stragrschemetype="";
	
		if(appno.trim().equalsIgnoreCase("")){
			appno=Helper.correctNull((String)hshValues.get("hidappno"));
		}
		
		if(appno.trim().equalsIgnoreCase("")){
			appno=Helper.correctNull((String)hshValues.get("appno"));
		}
		
		strfacsno = Helper.correctNull((String)hshValues.get("hidfacsno"));
		stragrschemetype = Helper.correctNull((String)hshValues.get("hidscheme"));
		
		try
		{				
			if(strAction.equals("Edit"))
			{
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
				hshQueryValues.put("size","2");	
				hshQuery = new HashMap();					
				hshQuery.put("strQueryId","agrincomehireserv_delete");
				arrValues.add(appno);
				arrValues.add(strfacsno);
				arrValues.add(stragrschemetype);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agrincomehireserv_insert");
							
				arrValues.add(appno);
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_onfarm")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_offfarm")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_hiringfortransport")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_totalhours")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_incfromcustom")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_totincfromcustom")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_lessoperations")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_dieseloil")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_dieselamt")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_dieselhrsusage")));//
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_fuellubricant")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_lubfuelcost")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_driversal")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_drivertotsal")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_insurancetax")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_repairmaintain")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_overheadtot")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_netincome")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_owmfarm")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_familyholding")));
				arrValues.add(stragrschemetype);
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_otrexpen")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("txt_extentofland")));
				arrValues.add(strfacsno);

				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			}
			else if(strAction.equals("delete"))
			{
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");					
				hshQuery.put("strQueryId","agrincomehireserv_delete");
				arrValues.add(appno);
				arrValues.add(strfacsno);
				arrValues.add(stragrschemetype);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
	
			/* 
			StringBuilder sbAuditTrial=new StringBuilder();
			sbAuditTrial.append("On Farm = ").append(Helper.correctDouble((String )hshValues.get("txt_onfarm")))
			.append("~Off Farm= ").append(Helper.correctDouble((String )hshValues.get("txt_offfarm")))
			.append("~Hiring for transport= ").append(Helper.correctDouble((String )hshValues.get("txt_hiringfortransport")))
			.append("~Total hours= ").append(Helper.correctDouble((String )hshValues.get("txt_totalhours")))
			.append("~Income from Custom Hire= ").append(Helper.correctDouble((String )hshValues.get("txt_incfromcustom")))
			.append("~Total Income= ").append(Helper.correctDouble((String )hshValues.get("txt_totincfromcustom")))
			.append("~Operations= ").append(Helper.correctDouble((String )hshValues.get("txt_lessoperations")))
			.append("~Diesel litre= ").append(Helper.correctDouble((String )hshValues.get("txt_dieseloil")))
			.append("~Diesel Amount= ").append(Helper.correctDouble((String )hshValues.get("txt_dieselamt")))
			.append("~Hours of usage= ").append(Helper.correctDouble((String )hshValues.get("txt_dieselhrsusage")))
			.append("~Fuel Lubrications= ").append(Helper.correctDouble((String )hshValues.get("txt_fuellubricant")))
			.append("~Lubrication Cost= ").append(Helper.correctDouble((String )hshValues.get("txt_lubfuelcost")))
			.append("~Driver salary per month= ").append(Helper.correctDouble((String )hshValues.get("txt_driversal")))
			.append("~Driver salary per year= ").append(Helper.correctDouble((String )hshValues.get("txt_drivertotsal")))
			.append("~Insurance Cost= ").append(Helper.correctDouble((String )hshValues.get("txt_insurancetax")))
			.append("~Repair Maintain= ").append(Helper.correctDouble((String )hshValues.get("txt_repairmaintain")))
			.append("~Over Head Cost= ").append(Helper.correctDouble((String )hshValues.get("txt_overheadtot")))
			.append("~Net Income= ").append(Helper.correctDouble((String )hshValues.get("txt_netincome")))
			.append("~Otr Expense= ").append(Helper.correctDouble((String )hshValues.get("txt_otrexpen")));
	
			AuditTrial.auditLog(hshValues,"213",appno,sbAuditTrial.toString());
			*/	
		}
		catch(Exception ce)
		{
			log.error("Error in updateCropAssessmentDetails::"+ce.getMessage());
			throw new EJBException("inside updateCropAssessmentDetails"+ce.toString());
		}
		finally
		{
			try
			{
				
			}
			catch(Exception cf)
			{
				log.error("Error in updateCropAssessmentDetails ::"+cf.getMessage());
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}		
	}
	
	public HashMap getIncomeHireDetails(HashMap hshValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strschemetype="",strfacsno="",stragrschemetype="";
		HashMap hshScheme = new HashMap();
		String schemetype = correctNull((String)hshValues.get("schemetype"));	
		String strAppNo="";
		HashMap hshFarmMachinery=null;
		HashMap hshLimits=null;
		HashMap hshtotalcost=null;
		String strPrdCode="";
		String strQuery="";
		
		try
		{
			strAppNo=Helper.correctNull((String)hshValues.get("strappno"));
			
			if(strAppNo.equalsIgnoreCase(""))
			{
				strAppNo=Helper.correctNull((String)hshValues.get("appno"));
			}
			strschemetype	= Helper.correctNull((String )hshValues.get("schemetype"));	
			hshScheme = Helper.splitScheme(strschemetype);
			
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			
				strQuery = SQLParser.getSqlQuery("select_facilityCode^"+strAppNo+"^"+strfacsno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strPrdCode = Helper.correctNull((String)rs.getString("facility_code"));
				}
				
			if(rs!=null)rs.close();		
			hshLimits	=	new AgrFarmMachineryBO().getLimitsDataByPrdCode(strPrdCode);
			hshFarmMachinery= new AgrFarmMachineryBO().getIncomeHireDetByAppNo(strAppNo,strfacsno,stragrschemetype);
			hshtotalcost=new AgrFarmMachineryBO().getFarmMachineryTotalCostByAppNo(strAppNo,strfacsno,stragrschemetype);

			hshRecord.put("hshFarmMachinery",hshFarmMachinery);
			hshRecord.put("hshLimitsDet",hshLimits);
			hshRecord.put("hshtotalcost",hshtotalcost);
			if(rs!=null)rs.close();
		
		}
		catch(Exception ce)
		{
			log.error("Error in getIncomeHireDetails of agrcropsBean"+ce.getMessage());
			throw new EJBException("Error in getIncomeHireDetails "+ce.toString());
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
				log.error("Error in getIncomeHireDetails "+cf.getMessage());
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}
	
	
	
	public  HashMap getSheepFinancialAnalysis(HashMap hshValues) 
	{
		
		HashMap hshRecord = new HashMap();
		
		String strAppNo=null;
		String schemetype = correctNull((String)hshValues.get("schemetype"));	
		if(!schemetype.equalsIgnoreCase(""))
		{
			hshRecord = Helper.splitScheme(schemetype);
			if(hshRecord!=null)
			{
				schemetype = Helper.correctNull((String)hshRecord.get("facility_schemetype"));
			}
		}
		hshRecord=new HashMap();
	
		
		HashMap hshCashFlow = new HashMap();
		try
		{
			strAppNo = Helper.correctNull((String)hshValues.get("appno"));
			hshCashFlow=new AgrFarmMachineryBO().calculateSheepFinancialAnalysis(strAppNo,Helper.correctNull((String)hshValues.get("strprdcode")),schemetype);
			hshRecord.put("arryRow",(ArrayList)hshCashFlow.get("arryRow"));	
			hshRecord.put("NetWorth",Helper.correctNull((String)hshCashFlow.get("NetWorth")));		
			hshRecord.put("df",Helper.correctNull((String)hshCashFlow.get("df")));		
		}
		catch(Exception ce)
		{
			log.error("Error in getSheepFinancialAnalysis ::" + ce.getMessage());
			throw new EJBException("Error in getSheepFinancialAnalysis "+ce.toString());
		}
		
		return hshRecord;
	}
	
	
	
	
	/**
	 * Author : M. Arsath Ayub
	 * Date : 27/02/2014
	 * @param hshValues
	 * @return
	 * @
	 */
	private int getForestryMaxid(String appno)
	{
		ResultSet rs = null;
		int termId = 0;
	
		try
		{
			rs=DBUtils.executeLAPSQuery("sel_maxforestry^"+appno);
			if(rs.next())
			{
			    termId = Integer.parseInt(Helper.correctInt((String)rs.getString("ff_sno")));
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
	
	
	/**Author : M. Arsath Ayub
	 * Date	  : 27/02/2014
	 * Page	  : Farm Forestry 
	 * */
	public void updateFarmForestrydet(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshScheme =  new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String appno=correctNull((String)hshValues.get("appno"));
		ResultSet rs=null;
		int intUpdatesize=0;
		int intForestryid = 0,intDataMaxid=0,intDataSno=0;
		String strFacSNo="",stragrschemetype="";
		String strschemetype	= Helper.correctNull((String )hshValues.get("schemetype"));	
		hshScheme = Helper.splitScheme(strschemetype);
		if(hshScheme!=null)
		{
			strFacSNo = Helper.correctNull((String)hshScheme.get("facility_sno"));
			stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
		}
		String strhidsno = Helper.correctNull((String)hshValues.get("hidsno"));
		try
		{
		
			if(strAction.equalsIgnoreCase("insert"))
			{
			intForestryid = getForestryMaxid(appno);
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","ins_forestrydet");
			arrValues.add(appno);
			arrValues.add(strFacSNo);
			arrValues.add(stragrschemetype);
			arrValues.add(String.valueOf(intForestryid));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_totareaval")));
			arrValues.add(Helper.correctInt((String)hshValues.get("sel_part")));
			arrValues.add(Helper.correctInt((String)hshValues.get("txt_yieldyear")));
			arrValues.add(Helper.correctInt((String)hshValues.get("txt_yieldno")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_salepricemain")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_incomemain")));
			arrValues.add(Helper.correctInt((String)hshValues.get("txt_yieldnoprod")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_salepriceprod")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_incomeprod")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_grossinc")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_grossexp")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_netinc")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_totnetinc")));
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
				
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","upd_forestrydet");
				arrValues = new ArrayList();
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_totareaval")));
				arrValues.add(Helper.correctInt((String)hshValues.get("txt_yieldyear")));
				arrValues.add(Helper.correctInt((String)hshValues.get("txt_yieldno")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_salepricemain")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_incomemain")));
				arrValues.add(Helper.correctInt((String)hshValues.get("txt_yieldnoprod")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_salepriceprod")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_incomeprod")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_grossinc")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_grossexp")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_netinc")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_totnetinc")));
				arrValues.add(appno);
				arrValues.add(strFacSNo);
				arrValues.add(stragrschemetype);
				arrValues.add(String.valueOf(strhidsno));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_forestrydet");
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(strFacSNo);
				arrValues.add(stragrschemetype);
				arrValues.add(String.valueOf(strhidsno));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
		finally
		{
			try
			{
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
	}
	
	
	 public HashMap getFarmForestrydet(HashMap hshValues) 
		{
		 	java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
			jtn.setMaximumFractionDigits(2);
			jtn.setMinimumFractionDigits(2);
			jtn.setGroupingUsed(false);
			
			ResultSet rs = null,rs1=null,rs2=null;
			HashMap hshRecord = new HashMap();
			String strAppno="",strQuery="";
			HashMap hshResult=new HashMap();
			HashMap hshQueryValues=new HashMap();
			HashMap hshQuery = new HashMap();
			ArrayList arrRow = new ArrayList();
			ArrayList arrCol = new ArrayList();
			ArrayList arrValues = new ArrayList();
			String strPart = Helper.correctNull((String)hshValues.get("varsno"));
			String stragrschemetype="",strFacSno="",strSchemetype="";
			double dblamnt = 0.00,dblrepayyear = 0.00,dblfinalamnt=0.00;
			String strschemetype	= Helper.correctNull((String )hshValues.get("schemetype"));	
			HashMap hshScheme = Helper.splitScheme(strschemetype);
			String strFirstYearAvail="",strSecnondYearAvail="";
			double dblFirstYrAmt=0,dblSecondYrAmt=0,dblYears=0;
			double dblTotAmt=0;
			if(hshScheme!=null)
			{
				strFacSno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			try
			{
				strAppno=Helper.correctNull((String)hshValues.get("appno"));
				if(!strPart.equalsIgnoreCase(""))
				{  
					if(rs!=null)
					{
						rs.close();
					}
					strQuery= SQLParser.getSqlQuery("sel_agriculture_facilities^"+strAppno);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						if(strSchemetype.equalsIgnoreCase(""))
						{
							strSchemetype="'"+Helper.correctNull((String)rs.getString("facility_agrschemetype"))+"'";
						}else
						{
							strSchemetype=strSchemetype+",'"+Helper.correctNull((String)rs.getString("facility_agrschemetype"))+"'";
						}
						
					}
					if(rs1!=null)
					{
						rs1.close();
					}
					strQuery= SQLParser.getSqlQuery("sel_activitylist^"+strSchemetype+"^"+strPart);
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						strFirstYearAvail=Helper.correctNull((String)rs1.getString("act_available"));
						strSecnondYearAvail=Helper.correctNull((String)rs1.getString("act_whether2"));
						dblFirstYrAmt=Double.parseDouble((String)Helper.correctDouble(rs1.getString("act_rangeto")));
						dblSecondYrAmt=Double.parseDouble((String)Helper.correctDouble(rs1.getString("act_amt2")));
						dblYears=Double.parseDouble((String)Helper.correctDouble(rs1.getString("act_years")));
						if(strFirstYearAvail.equalsIgnoreCase("Y"))
						{
							dblTotAmt = dblTotAmt + dblFirstYrAmt;
							
							if(strSecnondYearAvail.equalsIgnoreCase("Y"))
							{
								dblSecondYrAmt =	dblSecondYrAmt *(dblYears - 1);
								
								dblTotAmt= dblTotAmt + dblSecondYrAmt;
							}
						}
						hshRecord.put("unitcost",Helper.checkDecimal(Helper.correctDouble(jtn.format(dblTotAmt))));
						dblamnt = Double.parseDouble(Helper.correctDouble((String)rs1.getString("act_years")));
						hshRecord.put("partsno",strPart);
					}
					
				}
				else
				{
					
					if(rs!=null)
					{
						rs.close();
					}
					strQuery = SQLParser.getSqlQuery("sel_forestrydet^"+strAppno+"^"+strFacSno+"^"+stragrschemetype);
					rs2 = DBUtils.executeQuery(strQuery);
					while(rs2.next())
					{
						arrCol = new ArrayList();
						arrCol.add(Helper.checkDecimal(Helper.correctDouble((String)rs2.getString("ff_totarea"))));//0
						arrCol.add(Helper.correctInt((String)rs2.getString("ff_part")));//1
						arrCol.add(Helper.correctInt((String)rs2.getString("ff_yieldyr")));//2
						arrCol.add(Helper.correctInt((String)rs2.getString("ff_mainyield")));//3
						arrCol.add(Helper.checkDecimal(Helper.correctDouble((String)rs2.getString("ff_mainprdsale"))));//4
						arrCol.add(Helper.checkDecimal(Helper.correctDouble((String)rs2.getString("ff_mainprdinc"))));//5
						arrCol.add(Helper.correctInt((String)rs2.getString("ff_byprdyield")));//6
						arrCol.add(Helper.checkDecimal(Helper.correctDouble((String)rs2.getString("ff_byprdsale"))));//7
						arrCol.add(Helper.checkDecimal(Helper.correctDouble((String)rs2.getString("ff_byprdinc"))));//8
						arrCol.add(Helper.checkDecimal(Helper.correctDouble((String)rs2.getString("ff_grossinc"))));//9
						arrCol.add(Helper.checkDecimal(Helper.correctDouble((String)rs2.getString("ff_grossexp"))));//10
						arrCol.add(Helper.checkDecimal(Helper.correctDouble((String)rs2.getString("ff_netinc"))));//11
						arrCol.add(Helper.checkDecimal(Helper.correctDouble((String)rs2.getString("ff_totnetinc"))));//12
						arrCol.add(Helper.correctInt(Helper.correctInt((String)rs2.getString("ff_sno"))));//13
						arrRow.add(arrCol);
					}
			      	   	
					hshRecord.put("arrRow",arrRow);
				}
					
				
			}
			catch(final Exception ce)
			{
				throw new EJBException("Error in getFreezeData : "+ce.getMessage());
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
				catch(Exception ce)
				{
					throw new EJBException("Error in closing connection : "+ce.getMessage());
							
				}
			}
		   
			return hshRecord;
		}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
