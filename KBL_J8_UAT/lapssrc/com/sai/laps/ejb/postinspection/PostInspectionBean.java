package com.sai.laps.ejb.postinspection;

import java.sql.ResultSet;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.StringTokenizer;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "PostInspectionBean", mappedName = "PostInspectionHome")
@Remote (PostInspectionRemote.class)
public class PostInspectionBean extends BeanAdapter
{	
	static Logger log=Logger.getLogger(PostInspectionBean.class);	

	/**
	 * 
	 */
	private static final long serialVersionUID = 1313820960349153234L;

	/**
	 * 
	 */
	
	public HashMap getPostInspecSearch(HashMap hshValues)
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;

		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=null;
		String cbsaccno=correctNull((String)hshValues.get("cbsaccno"));
		String cbsid=correctNull((String)hshValues.get("cbsid"));
		String postinspec_year=correctNull((String)hshValues.get("postinspec_year"));
		String flag="false"; 
		String strQuery="";
		try
		{
			strQuery=SQLParser.getSqlQuery("getpostinspecsearchbyyear^"+cbsid+"^"+postinspec_year);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol=new ArrayList();
				String strInstype=correctNull(rs.getString("postins_type"));
				
				arrCol.add(correctNull(rs.getString("postins_year")));
				arrCol.add(correctNull(rs.getString("postins_month")));
				arrCol.add(correctNull(rs.getString("postins_date")));
				arrCol.add(correctNull(rs.getString("postins_orgscode")));
				arrCol.add(correctNull(rs.getString("postins_status")));
				arrCol.add(correctNull(rs.getString("postins_no")));
				arrCol.add(strInstype);
				arrCol.add(correctNull(rs.getString("postins_cbsid")));
				if(strInstype.equalsIgnoreCase("R"))
				{
					arrCol.add("Retail");
				}
				else if(strInstype.equalsIgnoreCase("A"))
				{
					arrCol.add("Agriculture");
				}
				else if(strInstype.equalsIgnoreCase("C"))
				{
					arrCol.add("Corporate / SME / Tertiary");
				}
				else
				{
					arrCol.add("");
				}
				arrCol.add(correctNull(rs.getString("postins_usrid")));
				arrRow.add(arrCol);
				flag="true";
			}
			
			
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("postins_year",postinspec_year);
			hshRecord.put("cbsid",cbsid);
			hshRecord.put("cbsaccno",cbsaccno);
			hshRecord.put("flag",flag);
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getPostInspecSearch in PostInspectionBean Bean"+e.getMessage());
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

	public HashMap getTypePostInspection(HashMap hshValues)
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;

		String postins_no=correctNull((String)hshValues.get("postins_no"));
		String strQuery="";
		try
		{
			if(postins_no.equals(""))
			{
				postins_no = correctNull((String)hshValues.get("hidpostins_no"));
			}
			strQuery=SQLParser.getSqlQuery("getpostinspection^"+postins_no);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("postins_type",correctNull(rs.getString("postins_type")));
				hshRecord.put("postins_no",correctNull(rs.getString("postins_no")));
				hshRecord.put("postins_status",correctNull((String) rs.getString("postins_status")));
				hshRecord.put("postins_month",correctNull(rs.getString("postins_month")));
				hshRecord.put("postins_year",correctNull(rs.getString("postins_year")));
				hshRecord.put("postins_cbsid",correctNull(rs.getString("postins_cbsid")));
				if(correctNull(rs.getString("postins_status")).equalsIgnoreCase("P") &&
						correctNull(rs.getString("postins_usrid")).equalsIgnoreCase(correctNull((String)hshValues.get("strUserId"))) &&
						correctNull(rs.getString("postins_holder")).equalsIgnoreCase(correctNull((String)hshValues.get("strUserId")))
						)
				{
					hshRecord.put("btnenable","Y");
				}
				else
				{
					hshRecord.put("btnenable","N");
				}
				hshRecord.put("postins_holder",correctNull(rs.getString("postins_holder")));
				hshRecord.put("org_name",correctNull(rs.getString("org_name")));
							
			}
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getTypePostInspection in PostInspectionBean Bean"+e.getMessage());
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
	
	public void updateTypePostInspection(HashMap hshValues) 
	{
		try
		{	
				
		 		String reviewOf=correctNull((String)hshValues.get("reviewOf"));
		 		String postins_no=correctNull((String)hshValues.get("hidpostins_no"));
		 		HashMap hshQuery = new HashMap();
		 		HashMap hshQueryValues=new HashMap();
		 		ArrayList arrValues=new ArrayList();
				arrValues.add(reviewOf);
				arrValues.add(postins_no);
				hshQuery.put("arrValues",arrValues); 
				hshQuery.put("strQueryId","update_postinspection"); 
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	 			
	 		
		}
		catch(Exception ce)
		{
			throw new EJBException("updateTypePostInspection in PostInspectionBean Bean"+ce.toString());
		}
	}
	
	public HashMap getPostInspectionFaclity(HashMap hshValues)
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;

		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=null;
		String postinspec_no=correctNull((String)hshValues.get("hidpostins_no"));
		String strQuery="";
		try
		{
			strQuery=SQLParser.getSqlQuery("getpostinspecfacility^"+postinspec_no);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(correctNull(rs.getString("postins_facsno")));
				arrCol.add(correctNull(rs.getString("postins_facname")));
				arrCol.add(correctNull(rs.getString("postins_purpose")));
				arrCol.add(correctNull(rs.getString("postins_faclimit")));
				arrCol.add(correctNull(rs.getString("postins_facos")));
				arrCol.add(correctNull(rs.getString("postins_facoverdueamt")));
				arrRow.add(arrCol);
				
			}
			
			
			hshRecord.put("arrRow",arrRow);
			
			
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getPostInspectionFaclity in PostInspectionBean Bean"+e.getMessage());
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
	
	public HashMap getPostInspectionReport(HashMap hshValues)
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=null;

		
		String postinspec_no=correctNull((String)hshValues.get("hidpostins_no"));
		String cbsid=correctNull((String)hshValues.get("cbsid"));
		if(postinspec_no.equals(""))
		{
			postinspec_no = correctNull((String)hshValues.get("newpostinspec"));
		}
		String strQuery="";
		try
		{
			
			strQuery=SQLParser.getSqlQuery("getpostinspectionretreport^"+postinspec_no);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{

				hshRecord.put("inspec_date",correctNull(rs.getString("postins_visitdate")));
				hshRecord.put("previous_inspecdate",correctNull(rs.getString("postins_previsitdate")));
				hshRecord.put("inspec_official1",correctNull(rs.getString("postins_inspectofficial1")));
				hshRecord.put("inspec_official2",correctNull(rs.getString("postins_inspectofficial2")));
				hshRecord.put("inspec_official3",correctNull(rs.getString("postins_inspectofficial3")));
				hshRecord.put("inspec_officialdesig1",correctNull(rs.getString("postins_insofficialdesn1")));
				hshRecord.put("inspec_officialdesig2",correctNull(rs.getString("postins_insofficialdesn2")));
				hshRecord.put("inspec_officialdesig3",correctNull(rs.getString("postins_insofficialdesn3")));
				
				hshRecord.put("landmarknorth",correctNull(rs.getString("postins_north")));
				hshRecord.put("landmarkeast",correctNull(rs.getString("postins_east")));
				hshRecord.put("landmarkwest",correctNull(rs.getString("postins_west")));
				hshRecord.put("landmarksouth",correctNull(rs.getString("postins_south")));
				hshRecord.put("primesecurity",correctNull(rs.getString("postins_prisecurity")));
				
				hshRecord.put("collateralsecurity",correctNull(rs.getString("postins_collsecurity")));
				hshRecord.put("presentstatus",correctNull(rs.getString("postins_presentstatus")));
				hshRecord.put("official_observation",correctNull(Helper.CLOBToString(rs.getClob("postins_COMMENTS"))));
				hshRecord.put("operations",correctNull(rs.getString("postins_document")));
				hshRecord.put("adverse_features",correctNull(rs.getString("postins_features")));
				
				hshRecord.put("banknameboard",correctNull(rs.getString("postins_banknameboard")));
				hshRecord.put("borrnameboard",correctNull(rs.getString("postins_borrowernamebord")));
				hshRecord.put("bookmaintanance",correctNull(rs.getString("postins_bookmaintanance")));
				hshRecord.put("documentvalidity",correctNull(rs.getString("postins_documentvalidity")));
				
				hshRecord.put("shortfall",correctNull(rs.getString("postins_shorfalldeficiency")));
				hshRecord.put("development",correctNull(rs.getString("postins_developmentpurpose")));
				hshRecord.put("sinking",correctNull(rs.getString("postins_sinkingloan")));
				hshRecord.put("machinery",correctNull(rs.getString("postins_machinerypurchase")));
				hshRecord.put("seasonalcrops",correctNull(rs.getString("postins_seasonaloperation")));
				hshRecord.put("mediumtermloan",correctNull(rs.getString("postins_mediumtermloan")));
				
				hshRecord.put("from_place",correctNull(rs.getString("postins_place")));
				hshRecord.put("filled_date",correctNull(rs.getString("postins_date")));
				hshRecord.put("user_name",correctNull(rs.getString("postins_name")));
				hshRecord.put("user_desig",correctNull(rs.getString("postins_designation")));
				hshRecord.put("reviewdue",correctNull(rs.getString("postins_reviewdue")));
				
				
				
				
			}
			
			if(rs != null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("getpostinspection^"+postinspec_no);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("postins_type",correctNull(rs.getString("postins_type")));
				hshRecord.put("postins_no",correctNull(rs.getString("postins_no")));
				hshRecord.put("postins_status",correctNull((String) rs.getString("postins_status")));
				hshRecord.put("postins_month",correctNull(rs.getString("postins_month")));
				hshRecord.put("postins_year",correctNull(rs.getString("postins_year")));
				hshRecord.put("postins_cbsid",correctNull(rs.getString("postins_cbsid")));
				if(correctNull(rs.getString("postins_status")).equalsIgnoreCase("P") &&
						correctNull(rs.getString("postins_usrid")).equalsIgnoreCase(correctNull((String)hshValues.get("strUserId"))) &&
						correctNull(rs.getString("postins_holder")).equalsIgnoreCase(correctNull((String)hshValues.get("strUserId")))
						)
				{
					hshRecord.put("btnenable","Y");
				}
				else
				{
					hshRecord.put("btnenable","N");
				}
				hshRecord.put("postins_holder",correctNull(rs.getString("postins_holder")));
				hshRecord.put("org_name",correctNull(rs.getString("org_name")));
			}
			if(rs != null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("getpostinspectionmonth^"+cbsid);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(correctNull(rs.getString("postins_month")));
				arrCol.add(correctNull(rs.getString("postins_year")));
				arrCol.add(correctNull(rs.getString("postins_date")));
				arrRow.add(arrCol);
				
			}
		
			hshRecord.put("arrRow",arrRow);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getPostInspectionReport in PostInspectionBean Bean"+e.getMessage());
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
	
	public HashMap updatePostInspectionReport(HashMap hshValues) 
	{
		HashMap hshQuery = new HashMap();
 		HashMap hshQueryValues=new HashMap();
 		ArrayList arrValues=new ArrayList();
 		HashMap hshRecord =  new HashMap();
		String hidAction = 	correctNull((String)hshValues.get("hidAction"));
		String cbsid = 	correctNull((String)hshValues.get("cbsid"));
		String postinspec_no=correctNull((String)hshValues.get("hidpostins_no"));
		String inspec_date = 	correctNull((String)hshValues.get("txt_dateinspec"));
		//String preinspec_date = 	;
		String  inspec_official1 = 	correctNull((String)hshValues.get("txt_officialname1"));
		String  inspec_official2 = 	correctNull((String)hshValues.get("txt_officialname2"));
		String  inspec_official3 = 	correctNull((String)hshValues.get("txt_officialname3"));
		String  inspec_officialdesig1 = 	correctNull((String)hshValues.get("txt_officialdesig1"));
		String  inspec_officialdesig2 = 	correctNull((String)hshValues.get("txt_officialdesig2"));
		String  inspec_officialdesig3 = 	correctNull((String)hshValues.get("txt_officialdesig3"));
		String  official_observation = correctNull((String)hshValues.get("txtarea_officialobser")); 
		String  adverse_features = correctNull((String)hshValues.get("txtarea_features"));
		String from_place =  correctNull((String)hshValues.get("txt_place"));
		String filled_date =  correctNull((String)hshValues.get("txt_date"));
		String type =  correctNull((String)hshValues.get("hidreviewtype"));
		String user_name = correctNull((String)hshValues.get("txt_name"));
		String user_desgi = correctNull((String)hshValues.get("txt_desig"));
		int intUpdatesize=0;
		String strQuery="";
		String newpostinspec_no="";
		ResultSet rs= null;
		java.text.NumberFormat nf=java.text.NumberFormat.getNumberInstance();
		nf.setMinimumIntegerDigits(3);
		nf.setGroupingUsed(false);
		try
		{	if(!postinspec_no.equals(""))
			{
				if(hidAction.equals("update"))
				{
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					intUpdatesize++;
					arrValues.add(postinspec_no);
					hshQuery.put("strQueryId","del_postinspectionreport");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					intUpdatesize++;
			 		arrValues.add(cbsid);
			 		arrValues.add(inspec_date);
			 		arrValues.add(correctNull((String)hshValues.get("txt_previousdate")));
			 		arrValues.add(inspec_official1);
			 		arrValues.add(inspec_official2);
			 		arrValues.add(inspec_official3);
			 		arrValues.add(inspec_officialdesig1);
			 		arrValues.add(inspec_officialdesig2);
			 		arrValues.add(inspec_officialdesig3);
			 		arrValues.add(correctNull((String)hshValues.get("txt_north")));
			 		arrValues.add(correctNull((String)hshValues.get("txt_east")));
			 		arrValues.add(correctNull((String)hshValues.get("txt_west")));
			 		arrValues.add(correctNull((String)hshValues.get("txt_south")));
			 		arrValues.add(correctNull((String)hshValues.get("txt_primarysecurity")));
			 		arrValues.add(correctNull((String)hshValues.get("txt_collsecurity")));
			 		arrValues.add(correctNull((String)hshValues.get("txt_presentstatus")));
			 		arrValues.add(official_observation);
			 		arrValues.add(correctNull((String)hshValues.get("txt_accntoperations")));
			 		arrValues.add("");
			 		arrValues.add(correctNull((String)hshValues.get("sel_banknameboard")));
			 		arrValues.add(correctNull((String)hshValues.get("sel_borrowernamebord")));
			 		arrValues.add(correctNull((String)hshValues.get("sel_maintanance")));
			 		
			 		arrValues.add(correctNull((String)hshValues.get("txt_document")));
			 		arrValues.add(adverse_features);
			 		arrValues.add(correctNull((String)hshValues.get("text_development")));
			 		arrValues.add(correctNull((String)hshValues.get("text_sinking")));
			 		arrValues.add(correctNull((String)hshValues.get("text_purpose")));
			 		arrValues.add(correctNull((String)hshValues.get("text_seasonal")));
			 		arrValues.add(correctNull((String)hshValues.get("text_availed")));
			 		arrValues.add(from_place);
			 		arrValues.add(filled_date);
			 		arrValues.add(user_name);
			 		arrValues.add(user_desgi);
			 		arrValues.add(correctNull((String)hshValues.get("txt_reviewdue")));
			 		if(!inspec_date.equals(""))
			 		{
			 			arrValues.add(inspec_date.substring(3,5));//month
			 			arrValues.add(inspec_date.substring(6,10));//year
			 		}
			 		else
			 		{
			 			arrValues.add("");
				 		arrValues.add("");
			 		}
					arrValues.add(postinspec_no);
					hshQuery.put("arrValues",arrValues); 
					hshQuery.put("strQueryId","ins_postinspectionreport"); 
					hshQueryValues.put(""+intUpdatesize,hshQuery);
				}
				
				if(hidAction.equals("delete"))
				{
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					intUpdatesize++;
					arrValues.add(postinspec_no);
					hshQuery.put("strQueryId","del_postinspectionreport");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					intUpdatesize++;
					arrValues.add(postinspec_no);
					hshQuery.put("strQueryId","del_postinspection_facilities");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					intUpdatesize++;
					arrValues.add(postinspec_no);
					hshQuery.put("strQueryId","del_postinspection");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					
				}
				
			}	
		else
		{
			String date = "";
			String month = "";
			String year = "";
			String solid = correctNull((String)hshValues.get("strSolid"));
			String orgscode = correctNull((String)hshValues.get("strOrgShortCode"));
			if(!inspec_date.equals(""))
	 		{
				 date = inspec_date.substring(0,2);
				 month = inspec_date.substring(3,5);
				 year = inspec_date.substring(6,10);
	 		}
			Calendar calen = Calendar.getInstance();
			calen.set(Integer.parseInt(year), (Integer.parseInt(month)-1), Integer.parseInt(date));
			String dayofyear = String.valueOf(calen.get(Calendar.DAY_OF_YEAR));
			int int_dayofyear = Integer.parseInt(dayofyear);
			newpostinspec_no = solid+year+nf.format(int_dayofyear)+cbsid;//solid+year+month(2 digit)+csbid;
			
			
			//make old inspection to be closed	
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			intUpdatesize++;
			arrValues.add("C");
			arrValues.add(correctNull((String)hshValues.get("strUserId")));
			arrValues.add(cbsid);
			arrValues.add(orgscode);
			hshQuery.put("strQueryId","upd_postinspection");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize,hshQuery);
			
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			intUpdatesize++;
			arrValues.add(newpostinspec_no);
			arrValues.add(date);
			arrValues.add(month);
	 		arrValues.add(year);
	 		arrValues.add(orgscode);//orgscode
	 		arrValues.add("P");
			arrValues.add(cbsid);
			arrValues.add(type);//Type
			arrValues.add(correctNull((String)hshValues.get("strUserId")));
			arrValues.add(correctNull((String)hshValues.get("strUserId")));
			arrValues.add("Y");
			hshQuery.put("strQueryId","ins_postinspection");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize,hshQuery);
			
			
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			intUpdatesize++;
			arrValues.add(cbsid);
	 		arrValues.add(inspec_date);
	 		arrValues.add(correctNull((String)hshValues.get("txt_previousdate")));
	 		arrValues.add(inspec_official1);
	 		arrValues.add(inspec_official2);
	 		arrValues.add(inspec_official3);
	 		arrValues.add(inspec_officialdesig1);
	 		arrValues.add(inspec_officialdesig2);
	 		arrValues.add(inspec_officialdesig3);
	 		arrValues.add(correctNull((String)hshValues.get("txt_north")));
	 		arrValues.add(correctNull((String)hshValues.get("txt_east")));
	 		arrValues.add(correctNull((String)hshValues.get("txt_west")));
	 		arrValues.add(correctNull((String)hshValues.get("txt_south")));
	 		arrValues.add(correctNull((String)hshValues.get("txt_primarysecurity")));
	 		arrValues.add(correctNull((String)hshValues.get("txt_collsecurity")));
	 		arrValues.add(correctNull((String)hshValues.get("txt_presentstatus")));
	 		arrValues.add(official_observation);
	 		arrValues.add(correctNull((String)hshValues.get("txt_accntoperations")));
	 		arrValues.add("");
	 		arrValues.add(correctNull((String)hshValues.get("sel_banknameboard")));
	 		arrValues.add(correctNull((String)hshValues.get("sel_borrowernamebord")));
	 		arrValues.add(correctNull((String)hshValues.get("sel_maintanance")));
	 		
	 		arrValues.add(correctNull((String)hshValues.get("txt_document")));
	 		arrValues.add(adverse_features);
	 		arrValues.add(correctNull((String)hshValues.get("text_development")));
	 		arrValues.add(correctNull((String)hshValues.get("text_sinking")));
	 		arrValues.add(correctNull((String)hshValues.get("text_purpose")));
	 		arrValues.add(correctNull((String)hshValues.get("text_seasonal")));
	 		arrValues.add(correctNull((String)hshValues.get("text_availed")));
	 		arrValues.add(from_place);
	 		arrValues.add(filled_date);
	 		arrValues.add(user_name);
	 		arrValues.add(user_desgi);
	 		arrValues.add(correctNull((String)hshValues.get("txt_reviewdue")));
	 		arrValues.add(month);
	 		arrValues.add(year);
	 		arrValues.add(newpostinspec_no);
			hshQuery.put("arrValues",arrValues); 
			hshQuery.put("strQueryId","ins_postinspectionreport"); 
			hshQueryValues.put(""+intUpdatesize,hshQuery);
			
			strQuery=SQLParser.getSqlQuery("getpostfundbased^"+cbsid);
			rs=DBUtils.executeQuery(strQuery);
			int index=0;
			while(rs.next())
			{
				index++;
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize++;
				arrValues.add(newpostinspec_no);
				arrValues.add(""+index);
				arrValues.add(correctNull(rs.getString("fund_schemecode")));
				arrValues.add(correctNull(rs.getString("facility")));
				arrValues.add(correctNull(rs.getString("fund_sancamt")));
				arrValues.add(correctNull(rs.getString("fund_osamt")));
				arrValues.add(correctNull(rs.getString("fund_overdueamt")));
				arrValues.add(correctNull(rs.getString("purpose")));
				hshQuery.put("strQueryId","ins_postinspection_facilities");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				
			}
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize++;
			hshQuery.put("strQueryId","inspostinsmailbox");
			arrValues.add(correctNull((String)hshValues.get("strUserId")));
			arrValues.add(correctNull((String)hshValues.get("strUserId")));
			arrValues.add(newpostinspec_no);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize,hshQuery);
			
		}
		hshQueryValues.put("size",""+intUpdatesize);	
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		if(newpostinspec_no.equalsIgnoreCase(""))
		{
			newpostinspec_no=postinspec_no;
		}
		hshValues.put("hidpostins_no",newpostinspec_no);
		hshRecord = getPostInspectionReport(hshValues);
		hshRecord.put("hidpostins_no",newpostinspec_no);	
		}
		catch(Exception e)
		{
			throw new EJBException("Error in updatePostInspectionReport in PostInspectionBean Bean"+e.getMessage());
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
	
	public HashMap getNewPostInspectionReport(HashMap hshValues)
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=null;

		String postinspec_no=correctNull((String)hshValues.get("hidpostins_no"));
		String cbsid=correctNull((String)hshValues.get("cbsid"));
		String strQuery="";
		
		try
		{
			
			/*strQuery=SQLParser.getSqlQuery("getnewpostinspectionreport^"+cbsid);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("previous_inspecdate",correctNull(rs.getString("postins_visitdate")));
			}
			if(rs != null)
				rs.close();*/
			strQuery=SQLParser.getSqlQuery("getpostinspectionmonth^"+cbsid);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(correctNull(rs.getString("postins_month")));
				arrCol.add(correctNull(rs.getString("postins_year")));
				arrCol.add(correctNull(rs.getString("postins_date")));
				arrRow.add(arrCol);
				
			}
			hshRecord.put("postins_cbsid",cbsid);
			hshRecord.put("arrRow",arrRow);
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getPostInspectionReport in PostInspectionBean Bean"+e.getMessage());
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
	
	public HashMap getPostInspectionPrint(HashMap hshValues)
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=null;
		String postinspec_no=correctNull((String)hshValues.get("hidpostins_no"));
		String cbsid=correctNull((String)hshValues.get("cbsid"));
		String strQuery="";
		String branchscode="";
		try
		{
			
			strQuery=SQLParser.getSqlQuery("getpostinspectionretreport^"+postinspec_no);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{

				hshRecord.put("inspec_date",correctNull(rs.getString("postins_visitdate")));
				hshRecord.put("previous_inspecdate",correctNull(rs.getString("postins_previsitdate")));
				hshRecord.put("inspec_official1",correctNull(rs.getString("postins_inspectofficial1")));
				hshRecord.put("inspec_official2",correctNull(rs.getString("postins_inspectofficial2")));
				hshRecord.put("inspec_official3",correctNull(rs.getString("postins_inspectofficial3")));
				hshRecord.put("inspec_officialdesig1",correctNull(rs.getString("postins_insofficialdesn1")));
				hshRecord.put("inspec_officialdesig2",correctNull(rs.getString("postins_insofficialdesn2")));
				hshRecord.put("inspec_officialdesig3",correctNull(rs.getString("postins_insofficialdesn3")));
				hshRecord.put("official_observation",correctNull(Helper.CLOBToString(rs.getClob("postins_comments"))));
				
				hshRecord.put("landmarknorth",correctNull(rs.getString("postins_north")));
				hshRecord.put("landmarkeast",correctNull(rs.getString("postins_east")));
				hshRecord.put("landmarkwest",correctNull(rs.getString("postins_west")));
				hshRecord.put("landmarksouth",correctNull(rs.getString("postins_south")));
				hshRecord.put("primesecurity",correctNull(rs.getString("postins_prisecurity")));
				
				hshRecord.put("collateralsecurity",correctNull(rs.getString("postins_collsecurity")));
				hshRecord.put("presentstatus",correctNull(rs.getString("postins_presentstatus")));
				hshRecord.put("official_observation",correctNull(Helper.CLOBToString(rs.getClob("postins_COMMENTS"))));
				hshRecord.put("operations",correctNull(rs.getString("postins_document")));
				hshRecord.put("adverse_features",correctNull(rs.getString("postins_features")));
				
				hshRecord.put("banknameboard",correctNull(rs.getString("postins_banknameboard")).equals("1")?"Yes":correctNull(rs.getString("postins_banknameboard")).equals("2")?"No":"");
				hshRecord.put("borrnameboard",correctNull(rs.getString("postins_borrowernamebord")).equals("1")?"Yes":correctNull(rs.getString("postins_borrowernamebord")).equals("2")?"No":"");
				hshRecord.put("bookmaintanance",correctNull(rs.getString("postins_bookmaintanance")).equals("1")?"Yes":correctNull(rs.getString("postins_bookmaintanance")).equals("2")?"No":"");
				hshRecord.put("documentvalidity",correctNull(rs.getString("postins_documentvalidity")));
				
				hshRecord.put("shortfall",correctNull(rs.getString("postins_shorfalldeficiency")));
				hshRecord.put("development",correctNull(rs.getString("postins_developmentpurpose")));
				hshRecord.put("sinking",correctNull(rs.getString("postins_sinkingloan")));
				hshRecord.put("machinery",correctNull(rs.getString("postins_machinerypurchase")));
				hshRecord.put("seasonalcrops",correctNull(rs.getString("postins_seasonaloperation")));
				hshRecord.put("mediumtermloan",correctNull(rs.getString("postins_mediumtermloan")));
				
				
				hshRecord.put("adverse_features",correctNull(rs.getString("postins_features")));
				hshRecord.put("from_place",correctNull(rs.getString("postins_place")));
				hshRecord.put("filled_date",correctNull(rs.getString("postins_date")));
				hshRecord.put("user_name",correctNull(rs.getString("postins_name")));
				hshRecord.put("user_desig",correctNull(rs.getString("postins_designation")));
				hshRecord.put("reviewdue",correctNull(rs.getString("postins_reviewdue")));
			}
			
			if(rs != null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("getpostinspectionaddress^"+cbsid);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("personal_custname",correctNull(rs.getString("personal_custname")));
				hshRecord.put("personal_address",correctNull(rs.getString("personal_address")));
				hshRecord.put("personal_address1",correctNull(rs.getString("personal_address1")));
				hshRecord.put("city_name",correctNull(rs.getString("city_name")));
				hshRecord.put("state_name",correctNull(rs.getString("state_name")));
				hshRecord.put("personal_pincode",correctNull(rs.getString("personal_pincode")));
				
			}	
			if(rs != null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("getpostinspecfacility^"+postinspec_no);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(correctNull(rs.getString("postins_facsno")));
				arrCol.add(correctNull(rs.getString("postins_facname")));
				arrCol.add(correctNull(rs.getString("postins_purpose")));
				arrCol.add(correctNull(rs.getString("postins_faclimit")));
				arrCol.add(correctNull(rs.getString("postins_facos")));
				arrCol.add(correctNull(rs.getString("postins_facoverdueamt")));
				arrRow.add(arrCol);
				
			}
			hshRecord.put("arrRow",arrRow);
			
			if(rs != null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("getpostinspection^"+postinspec_no);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				branchscode = correctNull(rs.getString("postins_orgscode"));
				
			}
			if(rs != null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("getbranchaddress^"+branchscode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("orgname",correctNull(rs.getString("org_name")));
				hshRecord.put("orgadd1",correctNull(rs.getString("org_add1")));
				hshRecord.put("orgadd2",correctNull(rs.getString("org_add2")));
				hshRecord.put("orgcity",correctNull(rs.getString("city_name")));
				hshRecord.put("orgstate",correctNull(rs.getString("state_name")));
				hshRecord.put("orgzip",correctNull(rs.getString("org_zip")));
				
			}
			
			
			strQuery=SQLParser.getSqlQuery("sel_standingcrops^"+postinspec_no);
			rs=DBUtils.executeQuery(strQuery);
			arrRow = new ArrayList();
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull((String)rs.getString("MMR_SLNO")));
				arrCol.add(correctNull((String)rs.getString("CROP")));
				arrCol.add(correctNull((String)rs.getString("ACERAGE")));
				arrCol.add(correctNull((String)rs.getString("CONDITION")));
				arrRow.add(arrCol);
			}			
			hshRecord.put("arrCrops",arrRow);
			
			strQuery=SQLParser.getSqlQuery("getpostinspection^"+postinspec_no);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshRecord.put("sanccomments",correctNull(rs.getString("postins_sancauthcomments")));
				hshRecord.put("approvedate",correctNull(rs.getString("postins_approvedate")));
			}			
			
	
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getPostInspectionPrint in PostInspectionBean Bean"+e.getMessage());
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
	
	public HashMap getPostInspectionAnnexure(HashMap hshValues)
	{
		ResultSet rs=null;
		HashMap hshRecord=new HashMap();
		String strInspectionno="";
		double totalSanction = 0.00,totalOS = 0.00,totalOverDue = 0.00;
		try
		{
			
			strInspectionno=correctNull((String)hshValues.get("hidpostins_no"));
			String strQuery ="";
			
			ArrayList arrRow = new ArrayList();
	 		ArrayList arrCol = new ArrayList();
	 		
			
	 		strQuery=SQLParser.getSqlQuery("getpostinsfacannex^"+strInspectionno);
	 		
	 		rs=DBUtils.executeQuery(strQuery);
	 		while(rs.next())
			{
	 			arrCol = new ArrayList();
	 			arrCol.add(correctNull(rs.getString("fac_headid")));  //0
	 			arrCol.add(correctNull(rs.getString("fac_parent")));  //1
	 			arrCol.add(correctNull(rs.getString("fac_facid")));   //2
	 			arrCol.add(correctNull(rs.getString("facility")));    //3
	 			arrCol.add(correctNull(rs.getString("fac_group")));   //4
	 			arrCol.add(correctNull(rs.getString("fac_category")));//5
	 			arrCol.add(Helper.formatDoubleValue(rs.getDouble("fac_sancamt"))); //6
	 			arrCol.add(Helper.formatDoubleValue(rs.getDouble("fac_os")));      //7
	 			arrCol.add(Helper.formatDoubleValue(rs.getDouble("fac_overdue"))); //8
	 			arrCol.add(correctNull(rs.getString("fac_reasons"))); //9
	 			arrCol.add(correctNull(rs.getString("fac_sno")));     //10
	 			
	 			arrRow.add(arrCol);
	 			if(correctNull(rs.getString("fac_group")).equals(correctNull(rs.getString("fac_sno"))))
	 			{	
	 				totalSanction = totalSanction + Double.parseDouble(Helper.correctDouble(correctNull(rs.getString("fac_sancamt"))));
	 			}
	 			
	 			if(Double.parseDouble(Helper.correctDouble(correctNull(rs.getString("fac_os"))))<0)
	 			{
	 				totalOS = totalOS + Double.parseDouble(Helper.correctDouble(correctNull(rs.getString("fac_os"))));
	 			
	 			}
	 			
	 				totalOverDue = totalOverDue + Double.parseDouble(Helper.correctDouble(correctNull(rs.getString("fac_overdue"))));
	 			
	 	    }
	 		NumberFormat nf = NumberFormat.getInstance();
	 		nf.setGroupingUsed(false);
	 		nf.setMaximumFractionDigits(6);
	 		nf.setMinimumFractionDigits(2);
	 		
	 		hshRecord.put("arrRow",arrRow);
	 		hshRecord.put("totalSanction", nf.format(totalSanction));
	 		hshRecord.put("totalOS", nf.format(totalOS));
	 		hshRecord.put("totalOverDue", nf.format(totalOverDue));
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getPostInspectionAnnexure :: "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection in getPostInspectionAnnexure :: "+cf.getMessage());
			}
		}
		return hshRecord;
	}
	public void updatePostInspectionAnnexure(HashMap hshValues)
	{
		
		ResultSet rs = null;
		String strAction="";
		String strQuery = "";
		String strInspectionno="";
		
		String strSno="";
		String strFacHead=""; 
		String strFacility=""; 
		String strGroupId ="0";
		String strCategory="";
		String strReasons="";
		String strLimit="";
		String strOs="";
		String strOverdue="";
		
		String strCheckSublimit="";
		
		StringTokenizer stk = null;
		
		try
		{
			
			strAction=correctNull((String)hshValues.get("hidAction"));
			strInspectionno=correctNull((String)hshValues.get("hidpostins_no"));
			strCheckSublimit=correctNull((String)hshValues.get("checkSublimit"));
			strSno=correctNull((String)hshValues.get("hid_sno"));
			
			if(!strCheckSublimit.equals(""))
			{
				strFacHead = correctNull((String) hshValues.get("facility_head"));
				stk = new StringTokenizer(strFacHead,"-");
				if(stk.hasMoreTokens())
				{
					strFacHead = (String)stk.nextToken();
				}

				strFacility =correctNull((String) hshValues.get("facility"));
				stk = new StringTokenizer(strFacility,"-");
				if(stk.hasMoreTokens())
				{
					strFacility = (String)stk.nextToken();
				}
				strCategory=correctNull((String)hshValues.get("category"));
				strReasons=correctNull((String)hshValues.get("txt_desc"));
				strOs=Helper.correctDouble((String)hshValues.get("txt_outstanding"));
				strLimit=Helper.correctDouble((String)hshValues.get("txt_sanclimit"));
				strOverdue=Helper.correctDouble((String)hshValues.get("txt_overdue"));
				strGroupId = correctNull((String)hshValues.get("hidgrpno"));
				
			}
			else
			{
				strFacHead =correctNull((String) hshValues.get("subfacility_head"));
				stk = new StringTokenizer(strFacHead,"-");
				if(stk.hasMoreTokens())
				{
					strFacHead = (String)stk.nextToken();
				}
				
				strFacility =correctNull((String) hshValues.get("subfacility"));
				stk = new StringTokenizer(strFacility,"-");
				if(stk.hasMoreTokens())
				{
					strFacility = (String)stk.nextToken();
				}
				
				strGroupId = correctNull((String)hshValues.get("hidgrpno"));
				strCategory=correctNull((String)hshValues.get("category"));
				strReasons=correctNull((String)hshValues.get("txt_remarks"));
				strOs=Helper.correctDouble((String)hshValues.get("txt_sub_outstanding"));
				strLimit=Helper.correctDouble((String)hshValues.get("txt_subsanclimit"));
				strOverdue=Helper.correctDouble((String)hshValues.get("txt_sub_overdue"));
			}
			
			HashMap hshQuery=new HashMap();
			HashMap hshQueryValues=new HashMap();
			ArrayList arrValues=new ArrayList();
			
			if(strAction.equals("insert"))
			{
				strQuery = SQLParser.getSqlQuery("maxinsannexfacility^"+strInspectionno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strSno = rs.getString(1);
				}
				if(!strCheckSublimit.equals(""))
				{
					strGroupId=strSno;
				}
				
				arrValues.add(strInspectionno);
				arrValues.add(strSno);
				arrValues.add(strFacHead);
				arrValues.add(strFacility);
				arrValues.add(strGroupId);
				arrValues.add(strCategory);
				arrValues.add(strReasons);
				arrValues.add(strOs);
				arrValues.add(strLimit);
				arrValues.add(strOverdue);
				
				hshQuery.put("arrValues",arrValues); 
				hshQuery.put("strQueryId","inspostinsfacannex"); 
				
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equals("update"))
			{
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				
				arrValues.add(strFacHead);
				arrValues.add(strFacility);
				arrValues.add(strGroupId);
				arrValues.add(strCategory);
				arrValues.add(strReasons);
				arrValues.add(strOs);
				arrValues.add(strLimit);
				arrValues.add(strOverdue);
				
				arrValues.add(strSno);
				arrValues.add(strInspectionno);
				hshQuery.put("arrValues",arrValues); 
				hshQuery.put("strQueryId","updpostinsfacannex"); 
				
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equals("delete"))
			{
				if(!correctNull((String)hshValues.get("checkbox")).equals(""))
				{
					strSno = correctNull((String)hshValues.get("subLimitSno"));
				}
				else
				{
					strSno = correctNull((String)hshValues.get("hid_sno"));
				}
				
				arrValues.add(strInspectionno);
				arrValues.add(strSno);
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "delpostinsfacannex");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updatedata");
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in updateAnnexureFacility :: "+e.getMessage());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection in updateAnnexureFacility :: "+cf.getMessage());
			}
		}
	}
	
	public void updatePostInspectionAction(HashMap hshValues)
	{
		String strAction="";
		String strInspectionno="";
		String strFromuserid="";
		String strTouserid="";
		
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		
		try
		{
			strAction=(String)hshValues.get("hidAction");
			strInspectionno=(String)hshValues.get("hidpostins_no");
			strFromuserid=(String)hshValues.get("strUserId");
			strTouserid=(String)hshValues.get("hidmail_tousrid");
			
			if(strAction.equalsIgnoreCase("send"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","inspostinsmailbox");
				arrValues.add(strFromuserid);
				arrValues.add(strTouserid);
				arrValues.add(strInspectionno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","updpostinspectionholder");
				arrValues.add(strTouserid);
				arrValues.add(strInspectionno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","2");
				hshQueryValues.put("2",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("approve"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","updpostinsapprove");
				arrValues.add("C");
				arrValues.add(strFromuserid);
				arrValues.add(correctNull((String)hshValues.get("txt_sanctioncomments")));
				arrValues.add(strInspectionno);
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
	}

	public HashMap getPostInspectionHistory(HashMap hshValues)
	{
		String strInspectionno="";
		String strAction="";
		ResultSet rs=null;
		HashMap hshRecord=new HashMap();
		ArrayList arrFromUsr=new ArrayList();
		ArrayList arrToUsr=new ArrayList();
		ArrayList arrDate=new ArrayList();
		try
		{
			strInspectionno=(String)hshValues.get("hidpostins_no");
			strAction=(String)hshValues.get("hidAction");
			
			rs=DBUtils.executeLAPSQuery("postinsworkflowhistory^"+strInspectionno);
			while(rs.next())
			{
				arrFromUsr.add(rs.getString(1));
				arrToUsr.add(rs.getString(2));
				arrDate.add(rs.getString(3));
			}
			hshRecord.put("arrFromUsr",arrFromUsr);
			hshRecord.put("arrToUsr",arrToUsr);
			hshRecord.put("arrDate",arrDate);
			
			if(strAction.equals("send"))
			{
				hshRecord.put("status","send");
			}
			else if(strAction.equals("approve"))
			{
				hshRecord.put("status","closed");
			}
			
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
				throw new EJBException("Error closing connection.."+e1);
			}
		}
		return hshRecord;
	}

	public HashMap getPostInspectionAction(HashMap hshValues) 
	{
		String strQuery="";

		ResultSet rs=null;
		
		HashMap hshRecord=new HashMap();
		String strUserId = (String)hshValues.get("strUserId");
		String strInspectionno="";
		try
			{
			strInspectionno=(String)hshValues.get("hidpostins_no");
			
			strQuery = SQLParser.getSqlQuery("getpostinspection^"+strInspectionno);
			rs = DBUtils.executeQuery(strQuery);	
			if (rs.next())
			{ 	
				hshRecord.put("sendenable",correctNull(rs.getString("postins_holder")).equalsIgnoreCase(strUserId)?"YES":"NO");
				hshRecord.put("sanccomments",correctNull(rs.getString("postins_sancauthcomments")));
			}

			rs=DBUtils.executeLAPSQuery("workflowusersanlimit^"+strUserId);
			if(rs.next())
			{
				hshRecord.put("usrfunction",correctNull(rs.getString("usr_function")));
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
			}
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}
	}
}
