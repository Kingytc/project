package com.sai.laps.ejb.agrcommon;


import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.borrowersearch.borrowersearchBean;
import com.sai.laps.helper.ApplicantParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.LAlerts;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "AgrCommonBean", mappedName = "AgrCommonHome")
@Remote (AgrCommonRemote.class)
public class AgrCommonBean extends BeanAdapter {
	
	static Logger log=Logger.getLogger(AgrCommonBean.class);	
	/**
	 * 
	 */
	private static final long serialVersionUID = 8495930953066190618L;


	/**
	 * 
	 */
	

	public void updateLoanRequirements(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String appno="";			
		String strQuery="";
		ResultSet rs = null;
		StringBuilder sbAuditTrialOld=new StringBuilder();
		String strschemetype="",strfacsno="",stragrschemetype="";
		HashMap hshScheme = new HashMap();
		try
		{	
			appno=correctNull((String)hshValues.get("appno"));
			if(appno.equalsIgnoreCase(""))
			{
				appno=Helper.correctNull((String)hshValues.get("strAppno"));
			}
			strschemetype	= Helper.correctNull((String )hshValues.get("schemetype"));	
			hshScheme = Helper.splitScheme(strschemetype);
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();					
			hshQueryValues.put("size","1");		
			if(!hshValues.get("hidAction").toString().equals("update"))
			{
				    arrValues=new ArrayList();
			        hshQuery.put("strQueryId","agrcommonrequirementsins");
			        arrValues.add(appno);
			        arrValues.add(getLoanReqMaxId(appno));
			        arrValues.add(correctNull((String )hshValues.get("txt_agrcommon_particulars")));
			        arrValues.add(correctNull((String )hshValues.get("sel_agrcommon_type")));
			        arrValues.add(correctNull((String )hshValues.get("txt_agrcommon_units")));
			        arrValues.add(Helper.correctDouble((String )hshValues.get("txt_agrcommon_unitcost")));
			        arrValues.add(Helper.correctDouble((String )hshValues.get("txt_agrcommon_amount")));		
			        arrValues.add(strfacsno);		
			        arrValues.add(stragrschemetype);		
			        hshQuery.put("arrValues",arrValues);
			        hshQueryValues.put("1",hshQuery);			
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("agrcommonrequirementselbyappnoandseqno^"+appno+"^"+correctNull((String)hshValues.get("seqno")));
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					sbAuditTrialOld
					.append("~Particulars = ")
					.append(correctNull(rs.getString("agr_common_particulars")))
					.append("~Type = ")
					.append(correctNull(rs.getString("agr_common_type")))
					.append("~No. of Units = ")
					.append(correctNull(rs.getString("agr_common_units_num")))
					.append("~Unit Cost = ")
					.append(correctNull(rs.getString("agr_common_unitcost")))
					.append("~Amount = ")
					.append(correctNull(rs.getString("agr_common_amount")));
												
				}
				
				   arrValues=new ArrayList();
				   hshQuery.put("strQueryId","agrcommonrequirementsupdate");			
				   arrValues.add(correctNull((String )hshValues.get("txt_agrcommon_particulars")));
				   arrValues.add(correctNull((String )hshValues.get("sel_agrcommon_type")));
				   arrValues.add(correctNull((String )hshValues.get("txt_agrcommon_units")));
				   arrValues.add(Helper.correctDouble((String )hshValues.get("txt_agrcommon_unitcost")));
				   arrValues.add(Helper.correctDouble((String )hshValues.get("txt_agrcommon_amount")));	
				   arrValues.add(appno);
				   arrValues.add(Helper.correctDouble((String )hshValues.get("seqno")));
				   arrValues.add(strfacsno);		
			        arrValues.add(stragrschemetype);
				   hshQuery.put("arrValues",arrValues);
				   hshQueryValues.put("1",hshQuery);	
				
			}		
		
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			
			
			StringBuilder sbAuditTrial=new StringBuilder();
			 sbAuditTrial
			.append("~Particulars = ")
			.append(correctNull((String )hshValues.get("txt_agrcommon_particulars")))
			.append("~Type = ")
			.append(correctNull((String )hshValues.get("sel_agrcommon_type_text")))
			.append("~No. of Units = ")
			.append(correctNull((String )hshValues.get("txt_agrcommon_units")))
			.append("~Unit Cost = ")
			.append(correctNull((String )hshValues.get("txt_agrcommon_unitcost")))
			.append("~Amount = ")
			.append(correctNull((String )hshValues.get("txt_agrcommon_amount")));
			
			
			if(Helper.correctNull((String)hshValues.get("hidAction")).equalsIgnoreCase(""))
			{
				hshValues.put("hidAction","insert");
			}
			
		   AuditTrial.auditNewLog(hshValues, "260", appno, sbAuditTrial.toString(), sbAuditTrialOld.toString());
		
		}
		catch(Exception e)
		{
			throw new EJBException("Error in updateLoanRequirements - AgrCommonBean "+e.toString());
		}		
	}
	
	
	public String getLoanReqMaxId(String appno) throws Exception
	{
		ResultSet rs = null;
		try
		{
			String strQuery = SQLParser.getSqlQuery("agrcommonrequirementselmaxid^" +appno );
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
				return rs.getString(1);
			else
				return "1";
		
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getLoanReqMaxId - AgrCommonBean "+e.toString());
		}
		finally
		{
			try
			{
				if(rs != null)
					rs.close();
			}
			catch(Exception exp)
			{
				throw new EJBException("Error in closing the connection in getLoanReqMaxId - AgrCommonBean "+ exp.toString()); 
			}
		}
	}
	
	
	public void deleteLoanRequirements(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery=new HashMap();
		HashMap hshScheme=new HashMap();
		ArrayList arrValues=new ArrayList();
		ResultSet rs = null;
		String strQuery="";
		String appno="";
		StringBuilder sbAuditTrial=new StringBuilder();
		StringBuilder sbAuditTrialOld=new StringBuilder();
		String strfacsno="",stragrschemetype="";
		try
		{		
			appno=correctNull((String)hshValues.get("appno"));
			String strschemetype	= Helper.correctNull((String )hshValues.get("schemetype"));	
			hshScheme = Helper.splitScheme(strschemetype);
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			strQuery = SQLParser.getSqlQuery("agrcommonrequirementselbyappnoandseqno^"+appno+"^"+correctNull((String)hshValues.get("seqno")));
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				sbAuditTrialOld
				.append("~Particulars = ")
				.append(correctNull(rs.getString("agr_common_particulars")))
				.append("~Type = ")
				.append(correctNull(rs.getString("agr_common_type")))
				.append("~No. of Units = ")
				.append(correctNull(rs.getString("agr_common_units_num")))
				.append("~Unit Cost = ")
				.append(correctNull(rs.getString("agr_common_unitcost")))
				.append("~Amount = ")
				.append(correctNull(rs.getString("agr_common_amount")));
											
			}
			
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();					
			hshQueryValues.put("size","1");		
			
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","agrcommonrequirementdelete");
			arrValues.add(appno);
			arrValues.add(strfacsno);	
			arrValues.add(stragrschemetype);	
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			
			
			 hshValues.put("hidAction","delete");
			 AuditTrial.auditNewLog(hshValues, "260", appno, sbAuditTrial.toString(), sbAuditTrialOld.toString());
		}
		catch(Exception e)
		{
			throw new EJBException("Error in deleteLoanRequirements - AgrCommonBean "+e.toString());
		}		
	}
	
	
	public HashMap getLoanRequirementsData(HashMap hshValues)  
	{
		String strQuery="";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecVal=new ArrayList();
		String strschemetype="",strfacsno="",stragrschemetype="";
		HashMap hshScheme = new HashMap();
		String appno="";
		try 
		{
			appno=correctNull((String)hshValues.get("appno"));
			if(appno.equalsIgnoreCase(""))
			{
				appno=Helper.correctNull((String)hshValues.get("strAppno"));
			}
			strschemetype	= Helper.correctNull((String )hshValues.get("schemetype"));	
			hshScheme = Helper.splitScheme(strschemetype);
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			if(correctNull((String)hshValues.get("hidAction")).equals("edit"))
			strQuery = SQLParser.getSqlQuery("agrcommonrequirementselbyappnoandseqno^"+appno +"^"+correctNull((String)hshValues.get("seqno"))+"^"+strfacsno+"^"+stragrschemetype);
			else
			strQuery = SQLParser.getSqlQuery("agrcommonrequirementselbyappno^"+appno+"^"+strfacsno+"^"+stragrschemetype);	
			
			if(rs!=null)
				rs.close();					
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					vecVal = new ArrayList();
					vecVal.add(correctNull(rs.getString("agr_common_appno")));
					vecVal.add(correctNull(rs.getString("agr_common_seqno")));
					vecVal.add(correctNull(rs.getString("agr_common_particulars")));
					vecVal.add(correctNull(rs.getString("agr_common_type")));
					vecVal.add(correctNull(rs.getString("agr_common_units_num")));
					vecVal.add(correctNull(rs.getString("agr_common_unitcost")));
					vecVal.add(correctNull(rs.getString("agr_common_amount")));
					vecData.add(vecVal);							
				}					
				hshRecord.put("vecData",vecData);
				hshRecord.put("appno",appno);
		} 
		catch (Exception e) 
		{			
			throw new EJBException("Error in getLoanRequirementsData - AgrCommonBean "+e.toString());
		}
		finally
		{
			try 
			{
				rs.close();
			}
			catch (SQLException e) 
			{
				throw new EJBException("Error in getLoanRequirementsData - AgrCommonBean "+e.toString());
			}
		}
		return hshRecord;
		
	}


	
	public void updateIncomeandExpense(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String appno="",strQuery="",schemename="",facno="";	
		ResultSet rs=null;
		try
		{		
			appno=correctNull((String)hshValues.get("strappno"));
			if(appno.equalsIgnoreCase("") || appno.equalsIgnoreCase(null) )
			{
				appno=correctNull((String)hshValues.get("appno"));
			}
			StringBuilder sbAuditTrialOld=new StringBuilder();
			//Added By Zahoorunnisa.S for Audit Trial
			schemename=Helper.getfacilitySchemetype(correctNull((String)hshValues.get("schemetype")));
			facno=Helper.getfacilitySno(correctNull((String)hshValues.get("schemetype")));
			if(hshValues.get("hidAction").toString().equals("update")){
			
			strQuery = SQLParser.getSqlQuery("agrcommonincomeexpenseselbyappnoandseqno^"+appno +"^"+hshValues.get("radio_seqno")+"^"+hshValues.get("type"));
			if(rs!=null){
				rs.close();	}
			
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next()) {
					
					if(correctNull((String )rs.getString("agr_common_type")).equalsIgnoreCase("I"))
					{
						sbAuditTrialOld
						.append("~Income Details  =");
					}
					 else if(correctNull((String )rs.getString("agr_common_type")).equalsIgnoreCase("E"))
					{
						 sbAuditTrialOld
							.append("~Expenditure Details  =");
					}
					sbAuditTrialOld
					.append(correctNull((String) rs.getString("agr_common_expenditure")))
					.append("~I Year =")
					.append(correctNull((String) rs.getString("agr_common_year1")))
					.append("~II Year =")
					.append(correctNull((String) rs.getString("agr_common_year2")))
					.append("~III Year =")
					.append(correctNull((String) rs.getString("agr_common_year3")))
					.append("~IV Year = ")
					.append(correctNull((String) rs.getString("agr_common_year4")))
					.append("~V Year  = ")
					.append(correctNull((String) rs.getString("agr_common_year5")))
					.append("~VI Year =")
					.append(correctNull((String) rs.getString("agr_common_year6")))
					.append("~VII Year =")
					.append(correctNull((String) rs.getString("agr_common_year7")))
					.append("~VIII Year =")
					.append(correctNull((String) rs.getString("agr_common_year8")));
					
				}
			}
			if(rs!=null){
				rs.close();}	
			//End
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();					
			hshQueryValues.put("size","1");		
			if(hshValues.get("hidAction").toString().equals("insert"))
			{
			        arrValues=new ArrayList();
			        hshQuery.put("strQueryId","agrcommonincomeexpenseins");
			        arrValues.add(appno);
			        arrValues.add(getIncomeAndExpenseMaxId(appno,correctNull((String )hshValues.get("type"))));
			        arrValues.add(correctNull((String )hshValues.get("type")));		        
			        arrValues.add(correctNull((String )hshValues.get("txt_agr_common_incomeandexpense")));
			        arrValues.add(Helper.correctDouble((String )hshValues.get("txt_agr_common_year1")));
			        arrValues.add(Helper.correctDouble((String )hshValues.get("txt_agr_common_year2")));
			        arrValues.add(Helper.correctDouble((String )hshValues.get("txt_agr_common_year3")));
			        arrValues.add(Helper.correctDouble((String )hshValues.get("txt_agr_common_year4")));
			        arrValues.add(Helper.correctDouble((String )hshValues.get("txt_agr_common_year5")));
			        arrValues.add(Helper.correctDouble((String )hshValues.get("txt_agr_common_year6")));
			        arrValues.add(Helper.correctDouble((String )hshValues.get("txt_agr_common_year7")));
			        arrValues.add(Helper.correctDouble((String )hshValues.get("txt_agr_common_year8")));	
			        arrValues.add(correctNull((String )hshValues.get("agr_common_producttype")));
			        arrValues.add(schemename);
			        arrValues.add(facno);
			        hshQuery.put("arrValues",arrValues);
			        hshQueryValues.put("1",hshQuery);			
			}
			
			if(hshValues.get("hidAction").toString().equals("delete"))
			{								
			 	arrValues = new ArrayList();
				hshQueryValues = new HashMap();
				hshQueryValues.put("size","1");	
				hshQuery = new HashMap();					
				hshQuery.put("strQueryId","agrcommonincomeexpensedelete"+"^"+appno +"^"+hshValues.get("seqno")+"^"+hshValues.get("type"));
				arrValues.add(appno);
				arrValues.add(correctNull((String )hshValues.get("seqno")));
				arrValues.add(correctNull((String )hshValues.get("type")));	
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			}			
			if(hshValues.get("hidAction").toString().equals("update"))
			{
				
				    arrValues=new ArrayList();
				    hshQuery.put("strQueryId","agrcommonincomeexpenseupdate");			
				    arrValues.add(correctNull((String )hshValues.get("txt_agr_common_incomeandexpense")));
			        arrValues.add(Helper.correctDouble((String )hshValues.get("txt_agr_common_year1")));
			        arrValues.add(Helper.correctDouble((String )hshValues.get("txt_agr_common_year2")));
			        arrValues.add(Helper.correctDouble((String )hshValues.get("txt_agr_common_year3")));
			        arrValues.add(Helper.correctDouble((String )hshValues.get("txt_agr_common_year4")));
			        arrValues.add(Helper.correctDouble((String )hshValues.get("txt_agr_common_year5")));
			        arrValues.add(Helper.correctDouble((String )hshValues.get("txt_agr_common_year6")));
			        arrValues.add(Helper.correctDouble((String )hshValues.get("txt_agr_common_year7")));
			        arrValues.add(Helper.correctDouble((String )hshValues.get("txt_agr_common_year8")));
			        arrValues.add(schemename);
			        arrValues.add(facno);
			        arrValues.add(appno);
				    arrValues.add(correctNull((String )hshValues.get("seqno")));
				    arrValues.add(correctNull((String )hshValues.get("type")));		
				    arrValues.add(schemename);
			        arrValues.add(facno);
				    hshQuery.put("arrValues",arrValues);
				    hshQueryValues.put("1",hshQuery);				
			}	
		
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			
			
			StringBuilder sbAuditTrial=new StringBuilder();
		
				if(correctNull((String )hshValues.get("type")).equalsIgnoreCase("I"))
				{
					sbAuditTrial
					.append("~Income Details  =");
				}
				 else if(correctNull((String )hshValues.get("type")).equalsIgnoreCase("E"))
				{
					 sbAuditTrial
						.append("~Expenditure Details  =");
				}
				
				if(hshValues.get("hidAction").toString().equals("insert") || hshValues.get("hidAction").toString().equals("update")){
				sbAuditTrial
				.append(correctNull((String) hshValues.get("txt_agr_common_incomeandexpense")))
				.append("~I Year =")
				.append(correctNull((String) hshValues.get("txt_agr_common_year1")))
				.append("~II Year =")
				.append(correctNull((String) hshValues.get("txt_agr_common_year2")))
				.append("~III Year =")
				.append(correctNull((String) hshValues.get("txt_agr_common_year3")))
				.append("~IV Year = ")
				.append(correctNull((String) hshValues.get("txt_agr_common_year4")))
				.append("~V Year  = ")
				.append(correctNull((String) hshValues.get("txt_agr_common_year5")))
				.append("~VI Year =")
				.append(correctNull((String) hshValues.get("txt_agr_common_year6")))
				.append("~VII Year =")
				.append(correctNull((String) hshValues.get("txt_agr_common_year7")))
				.append("~VIII Year =")
				.append(correctNull((String) hshValues.get("txt_agr_common_year8")));
				
				}
				
				if(correctNull((String )hshValues.get("type")).equalsIgnoreCase("I")){
					AuditTrial.auditNewLog(hshValues,"263",appno,sbAuditTrial.toString(),sbAuditTrialOld.toString());
				
				}else if(correctNull((String )hshValues.get("type")).equalsIgnoreCase("E")){
					AuditTrial.auditNewLog(hshValues,"264",appno,sbAuditTrial.toString(),sbAuditTrialOld.toString());
					
				}
				
		}
		catch(Exception e)
		{
			throw new EJBException("Error in updateLoanRequirements - AgrCommonBean "+e.toString());
		}		
	    
	}
	
	
	
	public String getIncomeAndExpenseMaxId(String appno,String type) throws Exception
	{
		ResultSet rs = null;
		try
		{
			String strQuery = SQLParser.getSqlQuery("agrcommonincomeexpenseselmaxid^" +appno +"^"+type );
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
				return rs.getString(1);
			else
				return "1";
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getIncomeAndExpenseMaxId - AgrCommonBean "+e.toString());
		}
		finally
		{
			try
			{
				if(rs != null)
					rs.close();
			}
			catch(Exception exp)
			{
				throw new EJBException("Error in closing the connection in getIncomeAndExpenseMaxId - AgrCommonBean "+ exp.toString()); 
			}
		}
	}
	
	
	
	public void deleteIncomeAndExpense(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String appno="",strQuery=null,schemename="",facno="";	
		ResultSet rs = null;
		try
		{		
			appno=correctNull((String)hshValues.get("strappno"));
			if(appno.equalsIgnoreCase("") || appno.equalsIgnoreCase(null))
			{
				appno=correctNull((String)hshValues.get("appno"));
			}
			StringBuilder sbAuditTrialOld=new StringBuilder();
			//Added By Zahoorunnisa.S for Audit Trial
			schemename=Helper.getfacilitySchemetype(correctNull((String)hshValues.get("schemetype")));
			facno=Helper.getfacilitySno(correctNull((String)hshValues.get("schemetype")));
			
			strQuery = SQLParser.getSqlQuery("agrcommonincomeexpenseselbyappnoandseqno^"+appno +"^"+hshValues.get("seqno")+"^"+hshValues.get("type"));
			if(rs!=null){
				rs.close();	}
			
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next()) {
					sbAuditTrialOld.append("Expenditure Details  =")
					.append(correctNull((String) rs.getString("agr_common_expenditure")))
					.append("~I Year =")
					.append(correctNull((String) rs.getString("agr_common_year1")))
					.append("~II Year =")
					.append(correctNull((String) rs.getString("agr_common_year2")))
					.append("~III Year =")
					.append(correctNull((String) rs.getString("agr_common_year3")))
					.append("~IV Year = ")
					.append(correctNull((String) rs.getString("agr_common_year4")))
					.append("~V Year  = ")
					.append(correctNull((String) rs.getString("agr_common_year5")))
					.append("~VI Year =")
					.append(correctNull((String) rs.getString("agr_common_year6")))
					.append("~VII Year =")
					.append(correctNull((String) rs.getString("agr_common_year7")))
					.append("~VIII Year =")
					.append(correctNull((String) rs.getString("agr_common_year8")));
					
				}
			
			if(rs!=null){
				rs.close();}	
			//End
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();					
			hshQueryValues.put("size","1");				
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","agrcommonincomeexpensedelete");
			arrValues.add(appno);
			arrValues.add(Helper.correctDouble((String )hshValues.get("seqno")));	
			arrValues.add(Helper.correctDouble((String )hshValues.get("type")));
			arrValues.add(schemename);
			arrValues.add(facno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			StringBuilder sbAuditTrial=new StringBuilder();
			if(hshValues.get("hidAction").toString().equals("insert") || hshValues.get("hidAction").toString().equals("update")){
			if(correctNull((String )hshValues.get("type")).equalsIgnoreCase("I"))
			{
				sbAuditTrial
				.append("~Income Details  =");
			}
			 else if(correctNull((String )hshValues.get("type")).equalsIgnoreCase("E"))
			{
				 sbAuditTrial
					.append("~Expenditure Details  =");
			}
			
			sbAuditTrial
			.append(correctNull((String) hshValues.get("txt_agr_common_incomeandexpense")))
			.append("~I Year =")
			.append(correctNull((String) hshValues.get("txt_agr_common_year1")))
			.append("~II Year =")
			.append(correctNull((String) hshValues.get("txt_agr_common_year2")))
			.append("~III Year =")
			.append(correctNull((String) hshValues.get("txt_agr_common_year3")))
			.append("~IV Year = ")
			.append(correctNull((String) hshValues.get("txt_agr_common_year4")))
			.append("~V Year  = ")
			.append(correctNull((String) hshValues.get("txt_agr_common_year5")))
			.append("~VI Year =")
			.append(correctNull((String) hshValues.get("txt_agr_common_year6")))
			.append("~VII Year =")
			.append(correctNull((String) hshValues.get("txt_agr_common_year7")))
			.append("~VIII Year =")
			.append(correctNull((String) hshValues.get("txt_agr_common_year8")));
			
			}
			hshValues.put("strAction", "delete");
			
			if(correctNull((String )hshValues.get("type")).equalsIgnoreCase("I"))
			{
			AuditTrial.auditNewLog(hshValues,"263",appno,sbAuditTrial.toString(),sbAuditTrialOld.toString());
			}
			else if(correctNull((String )hshValues.get("type")).equalsIgnoreCase("E"))
			{
			AuditTrial.auditNewLog(hshValues,"264",appno,sbAuditTrial.toString(),sbAuditTrialOld.toString());
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in deleteIncomeAndExpense - AgrCommonBean "+e.toString());
		}		
	}
	
	
	public HashMap getIncomeandExpense(HashMap hshValues)  
	{
		String strQuery="";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecVal=new ArrayList();
		String appno="";
		String schemename="",facno="";
		try 
		{
			appno=correctNull((String)hshValues.get("strappno"));
			if(appno.equalsIgnoreCase("") || appno.equalsIgnoreCase(null))
			{
				appno=correctNull((String)hshValues.get("appno"));
			}
			schemename=Helper.getfacilitySchemetype(correctNull((String)hshValues.get("schemetype")));
			facno=Helper.getfacilitySno(correctNull((String)hshValues.get("schemetype")));
			
			if(correctNull((String)hshValues.get("hidAction")).equals("edit"))
			strQuery = SQLParser.getSqlQuery("agrcommonincomeexpenseselbyappnoandseqno^"+appno +"^"+hshValues.get("seqno")+"^"+hshValues.get("type"));
			else
			strQuery = SQLParser.getSqlQuery("agrcommonincomeexpenseselbyappno^"+appno+"^"+hshValues.get("type").toString()+"^"+schemename+"^"+facno);	
			
			if(rs!=null)
				rs.close();	
			
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					
					vecVal = new ArrayList();
					vecVal.add(correctNull(rs.getString("agr_common_appno")));
					vecVal.add(correctNull(rs.getString("agr_common_seqno")));
					vecVal.add(correctNull(rs.getString("agr_common_type")));
					vecVal.add(correctNull(rs.getString("agr_common_expenditure")));
					vecVal.add(correctNull(rs.getString("agr_common_year1")));
					vecVal.add(correctNull(rs.getString("agr_common_year2")));
					vecVal.add(correctNull(rs.getString("agr_common_year3")));
					vecVal.add(correctNull(rs.getString("agr_common_year4")));
					vecVal.add(correctNull(rs.getString("agr_common_year5")));
					vecVal.add(correctNull(rs.getString("agr_common_year6")));
					vecVal.add(correctNull(rs.getString("agr_common_year7")));
					vecVal.add(correctNull(rs.getString("agr_common_year8")));
					vecVal.add(correctNull(rs.getString("agr_common_producttype")));				
					vecData.add(vecVal);							
				}					
				hshRecord.put("vecData",vecData);
				
				
				strQuery = SQLParser.getSqlQuery("agrcommontotal^"+appno+"^"+hshValues.get("type").toString()+"^"+schemename+"^"+facno);
				rs=DBUtils.executeQuery(strQuery);
				//hshRecord = new HashMap();
				while (rs.next()) 
				{
					hshRecord.put("txt_agr_total_year1",Helper.correctNull((String)rs.getString("agr_common_year1")));
					hshRecord.put("txt_agr_total_year2",Helper.correctNull((String)rs.getString("agr_common_year2")));
					hshRecord.put("txt_agr_total_year3",Helper.correctNull((String)rs.getString("agr_common_year3")));
					hshRecord.put("txt_agr_total_year4",Helper.correctNull((String)rs.getString("agr_common_year4")));
					hshRecord.put("txt_agr_total_year5",Helper.correctNull((String)rs.getString("agr_common_year5")));
					hshRecord.put("txt_agr_total_year6",Helper.correctNull((String)rs.getString("agr_common_year6")));
					hshRecord.put("txt_agr_total_year7",Helper.correctNull((String)rs.getString("agr_common_year7")));
					hshRecord.put("txt_agr_total_year8",Helper.correctNull((String)rs.getString("agr_common_year8")));
					
				}
				
			    hshRecord.put("appno",appno);
		} 
		catch (Exception e) 
		{		
			e.printStackTrace();
			//throw new EJBException("Error in getLoanRequirementsData - AgrCommonBean "+e.toString());
		}
		finally
		{
			try 
			{
				rs.close();
			}
			catch (SQLException e) 
			{
				throw new EJBException("Error in getIncomeandExpense - AgrCommonBean "+e.toString());
			}
		}
		return hshRecord;
		
	}
	
	
	public HashMap getIncome(HashMap hshValues)  
	{
		hshValues.put("type","I");
		return getIncomeandExpense(hshValues);
	}
	
	public HashMap getExpense(HashMap hshValues)  
	{
		hshValues.put("type","E");
		return getIncomeandExpense(hshValues);
	}
	
	public HashMap getIncomeExpenseTotal(HashMap hshValues) 
	{
		HashMap expense=new HashMap();
		HashMap income=new HashMap();
		ArrayList gridData= new ArrayList();
		hshValues.put("type","E");
		expense= getIncomeandExpense(hshValues);
		hshValues.put("type","I");
		income= getIncomeandExpense(hshValues);
		
		HashMap hshRecord=new  HashMap();
		double ey1=0,ey2=0,ey3=0,ey4=0,ey5=0,ey6=0,ey7=0,ey8=0;
		double iy1=0,iy2=0,iy3=0,iy4=0,iy5=0,iy6=0,iy7=0,iy8=0;
		
	    if(expense.get("vecData")!=null)
	    {
	    	gridData=(ArrayList)expense.get("vecData"); 
	    }
	    
	    hshRecord.put("expense",gridData);
	    
	    for(int i=0;i<=gridData.size()-1;i++)
	    { 
	           ArrayList data=(ArrayList)gridData.get(i); 
	           ey1=ey1+(Double.parseDouble(Helper.correctDouble((String)data.get(4))));
	           ey2=ey2+(Double.parseDouble(Helper.correctDouble((String)data.get(5))));
	           ey3=ey3+(Double.parseDouble(Helper.correctDouble((String)data.get(6))));
	           ey4=ey4+(Double.parseDouble(Helper.correctDouble((String)data.get(7))));
	           ey5=ey5+(Double.parseDouble(Helper.correctDouble((String)data.get(8))));
	           ey6=ey6+(Double.parseDouble(Helper.correctDouble((String)data.get(9))));
	           ey7=ey7+(Double.parseDouble(Helper.correctDouble((String)data.get(10))));
	           ey8=ey8+(Double.parseDouble(Helper.correctDouble((String)data.get(11))));	           
	    }  
	    
	    if(income.get("vecData")!=null)
	    {
	    	gridData=(ArrayList)income.get("vecData"); 
	    }
	    
	    hshRecord.put("income",gridData);
	    
	    for(int i=0;i<=gridData.size()-1;i++)
	    { 
	           ArrayList data=(ArrayList)gridData.get(i); 
	           iy1=iy1+(Double.parseDouble(Helper.correctDouble((String)data.get(4))));
	           iy2=iy2+(Double.parseDouble(Helper.correctDouble((String)data.get(5))));
	           iy3=iy3+(Double.parseDouble(Helper.correctDouble((String)data.get(6))));
	           iy4=iy4+(Double.parseDouble(Helper.correctDouble((String)data.get(7))));
	           iy5=iy5+(Double.parseDouble(Helper.correctDouble((String)data.get(8))));
	           iy6=iy6+(Double.parseDouble(Helper.correctDouble((String)data.get(9))));
	           iy7=iy7+(Double.parseDouble(Helper.correctDouble((String)data.get(10))));
	           iy8=iy8+(Double.parseDouble(Helper.correctDouble((String)data.get(11))));
	           
	    }       
	    hshRecord.put("incomeYear1",Helper.formatDoubleValue(iy1));
	    hshRecord.put("incomeYear2",Helper.formatDoubleValue(iy2));  
	    hshRecord.put("incomeYear3",Helper.formatDoubleValue(iy3));  
	    hshRecord.put("incomeYear4",Helper.formatDoubleValue(iy4));  
	    hshRecord.put("incomeYear5",Helper.formatDoubleValue(iy5));  
	    hshRecord.put("incomeYear6",Helper.formatDoubleValue(iy6));  
	    hshRecord.put("incomeYear7",Helper.formatDoubleValue(iy7));  
	    hshRecord.put("incomeYear8",Helper.formatDoubleValue(iy8));  
	    
	    hshRecord.put("expenseYear1",Helper.formatDoubleValue(ey1));
	    hshRecord.put("expenseYear2",Helper.formatDoubleValue(ey2));  
	    hshRecord.put("expenseYear3",Helper.formatDoubleValue(ey3));  
	    hshRecord.put("expenseYear4",Helper.formatDoubleValue(ey4));  
	    hshRecord.put("expenseYear5",Helper.formatDoubleValue(ey5));  
	    hshRecord.put("expenseYear6",Helper.formatDoubleValue(ey6));  
	    hshRecord.put("expenseYear7",Helper.formatDoubleValue(ey7));  
	    hshRecord.put("expenseYear8",Helper.formatDoubleValue(ey8));  
	    
	    hshRecord.put("total1",Helper.formatDoubleValue(iy1-ey1));
	    hshRecord.put("total2",Helper.formatDoubleValue(iy2-ey2));
	    hshRecord.put("total3",Helper.formatDoubleValue(iy3-ey3));
	    hshRecord.put("total4",Helper.formatDoubleValue(iy4-ey4));
	    hshRecord.put("total5",Helper.formatDoubleValue(iy5-ey5));
	    hshRecord.put("total6",Helper.formatDoubleValue(iy6-ey6));
	    hshRecord.put("total7",Helper.formatDoubleValue(iy7-ey7));
	    hshRecord.put("total8",Helper.formatDoubleValue(iy8-ey8));
	    
		return hshRecord;
	}
	
	
	/**
	 * @author: S.SATHYA MOORTHY
	 * @since : 03/12/2008
	 * @todo  : For Agriculture Tehchincal Details(getdata)
	 * @version 1.1
	 * @exception throws.
	 */
	public HashMap getTechData(HashMap hashmap)
	{
		HashMap hshReturn=new HashMap();
		ResultSet rs=null;
		String recordflag="N";
		try
		{
			String strAppno=correctNull((String)hashmap.get("strappno"));
			if(strAppno.equals(""))strAppno=correctNull((String)hashmap.get("appno"));
			hshReturn.put("appno",strAppno);
			rs=DBUtils.executeQuery(SQLParser.getSqlQuery("get_agr_technical_details^"+correctNull(strAppno)));
			if(rs.next())
			{	
			recordflag="Y";
			hshReturn.put("agr_appno",correctNull(rs.getString("agr_appno")));
			hshReturn.put("select_qualified",correctNull(rs.getString("agr_qualified")));
			hshReturn.put("txtarea_variety_corp",correctNull(rs.getString("agr_var_crop")));
			hshReturn.put("txt_avg_production",correctNull(rs.getString("agr_avg_prod")));
			hshReturn.put("avg_sales",correctNull(rs.getString("agr_avg_sale")));
			hshReturn.put("agr_loanfor",correctNull(rs.getString("agr_loanfor")));
			hshReturn.put("recordflag",recordflag);
			}	
			
		}
		catch(Exception e)
		{
			throw new EJBException("$"+e.toString());
		}
		finally
		{
			try{if(rs!=null)rs.close();}catch(Exception e){e.printStackTrace();}
			
		}
		
		return hshReturn;
	}
	
	
	/**
	 * @author: S.SATHYA MOORTHY
	 * @since : 03/12/2008
	 * @todo  : For Agriculture Tehchincal Details(getdata)
	 * @param hashmap
	 * @version 1.1
	 * @exception throws.
	 */
	public void updateTechData(HashMap hashmap)
	{
	 
		  ArrayList arraylist=new ArrayList();
		  HashMap hshQueryValues=new HashMap();
		  HashMap hshQuery=new HashMap();
		  try
		  {
			  
			    String strAppno=correctNull((String)hashmap.get("strappno"));
				if(strAppno.equals(""))strAppno=correctNull((String)hashmap.get("appno"));
				hashmap.put("appno",strAppno);
				
			    hshQueryValues.put("size","1");				
				hshQuery.put("strQueryId","del_agr_technical_details");
			    arraylist.add(correctNull((String )hashmap.get("appno")));	
				hshQuery.put("arrValues",arraylist);
				hshQueryValues.put("1",hshQuery);
			  
			  if(correctNull((String)hashmap.get("hidAction")).equals("update"))
			  {
				    hshQuery=null;
				    hshQuery=new HashMap();
				    hshQueryValues.put("size","2");				
					hshQuery.put("strQueryId","ins_agr_technical_details");
					arraylist=null;arraylist=new ArrayList();
				    arraylist.add(correctNull((String )hashmap.get("appno")));	
				    arraylist.add(correctNull((String )hashmap.get("select_qualified")));
				    arraylist.add(correctNull((String )hashmap.get("txtarea_variety_corp")));
				    arraylist.add(correctNull((String )hashmap.get("txt_avg_production")));
				    arraylist.add(correctNull((String )hashmap.get("avg_sales")));
				    arraylist.add(correctNull((String )hashmap.get("sel_loanfor")));
				    
					hshQuery.put("arrValues",arraylist);
					hshQueryValues.put("2",hshQuery);
				    
			  }
			  
			  EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			  			  		  
			  //Added By Zahoorunnisa.S for audit Trial
			  StringBuilder sbAuditTrial=new StringBuilder();
			  if (correctNull((String)hashmap.get("hidAction")).equalsIgnoreCase("update")) {
				  sbAuditTrial.append("Loan For=").append(ApplicantParams.getApplicantParams("CommonLoanfor",correctNull((String )hashmap.get("sel_loanfor"))))
				  .append("~Whether the borrower is technically qualified ?=").append(ApplicantParams.getApplicantParams("OTSCOMMENTS",correctNull((String )hashmap.get("select_qualified"))));
				  
				  if(correctNull((String )hashmap.get("sel_loanfor")).equalsIgnoreCase("1")){
					  sbAuditTrial.append("~Average production of plant through Tissue culture per month/year  =").append(correctNull((String )hashmap.get("txt_avg_production")))
					  .append("~Average sale price per plant  =").append(correctNull((String )hashmap.get("avg_sales")));  
				  }
					if(correctNull((String)hashmap.get("hidRecordflag")).equalsIgnoreCase("Y")){
						hashmap.put("strAction", "update");
					}else{
						hashmap.put("strAction", "Insert");
					}
			  }
			  AuditTrial.auditLog(hashmap, "405", strAppno, sbAuditTrial.toString());	
			  //End
		  }
		  catch(Exception e)
		  {
			  throw new EJBException ("$"+e.toString());
		  }
		  finally
		  {
			  arraylist=null;
			  hshQueryValues=null;
			  hshQuery=null;
			  
		  }
				
	}
	
	/**
	 * @author: G.SURESHKUMAR
	 * @since : 25/03/2009
	 * @todo  : For ensuring whether datas has been entered in some of the pages
	 * @param hashmap
	 * @version 1.1
	 * @exception throws.
	 */
	
	
	/**********************
	strQuery=SQLParser.getSqlQuery(""+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data Not Entered in ");
				}
	***********************/
	public HashMap checkMandatoryPages (HashMap hshValues) 
	{
		HashMap hshRecord=null;
		String strAppno=correctNull((String)hshValues.get("appno"));
		String strProducttype=correctNull((String)hshValues.get("prdtype"));
		ResultSet rs=null;
		String strQuery="";
		ArrayList arrMessages=new ArrayList();
		try
		{
			if(strProducttype.equalsIgnoreCase("aH")) // Gold Loan
			{
				// Checking Data available in Gold Laon Page
				strQuery=SQLParser.getSqlQuery("selgolddetails^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Applicant-> Loan Product -> Gold Loan");
				}
				
				//Checking Data available in Land holding Page
				strQuery=SQLParser.getSqlQuery("agrlandholdingsselection^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture-> Land Holding");
				}
				
	
			}
			else if(strProducttype.equals("aC")) // Crop Loan & Union Green Card (UGC)
			{
				//Checking Data available in Land holding Page
				strQuery=SQLParser.getSqlQuery("agrlandholdingsselection^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture-> Land Holding");
				}
				
				//Checking Data available in Technical Aspects
				strQuery=SQLParser.getSqlQuery("agrgettechdetails^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture-> Technical Aspects");
				}
				
				//Checking Data available or not in Proposed Crops
				strQuery=SQLParser.getSqlQuery("agrcropselection^"+strAppno+"^PO");
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture-> Proposed Crops");
				}
				
				
			}
			else if(strProducttype.equals("aF")) // Farm Mechanisation
			{
				// Checking Data available in Land holding Page
				strQuery=SQLParser.getSqlQuery("agrlandholdingsselection^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture-> Land Holding");
				}
				
				// Checking Data available in Cropping Pattern
				strQuery=SQLParser.getSqlQuery("agr_selcroppingpattern^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture-> Cropping Pattern");
				}
				
				// Checking Data available in Particulars of Investment Page
				strQuery=SQLParser.getSqlQuery("sel_farmmechparticulars^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture-> Particulars of Investment");
				}
				
				// Checking Data available in Farm mechanisation page
				strQuery=SQLParser.getSqlQuery("agr_selfarmmechanism^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture-> Farm Mechanization");
				}
				
			}
			else if(strProducttype.equals("aU")) // Minor Irrigation
			{
				// Checking Data available in Land holding Page
				strQuery=SQLParser.getSqlQuery("agrlandholdingsselection^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture-> Land Holding");
				}
				
				// Checking Data available in Cropping Pattern
				strQuery=SQLParser.getSqlQuery("agr_selcroppingpattern^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture-> Cropping Pattern");
				}
					
				// Checking Data available in Minor Irrigation - I page
				strQuery=SQLParser.getSqlQuery("agr_selfarmmechMinorIrrig^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture-> Minor Irrigation -I");
				}
				
				// Checking Data available in Minor Irrigation -II  Page
				strQuery=SQLParser.getSqlQuery("sel_farmmechparticulars^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture-> Minor Irrigation -II");
				}
			}
			else if(strProducttype.equals("aD")) // Dairy Farming
			{
				// Checking Data available in Live stock Details
				strQuery=SQLParser.getSqlQuery("agrsel_stockdetails^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture-> Live Stock Details");
				}
				
				// Checking Data available in Technical Data
				strQuery=SQLParser.getSqlQuery("sel_agreconomic^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture-> Technical Data");
				}
					
				// Checking Data available in Economic Data page
				strQuery=SQLParser.getSqlQuery("agrdiaryfindatasel^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture-> Economic Data");
				}
				
				// Checking Data available in Milk Flow Chart  Page
				strQuery=SQLParser.getSqlQuery("selmilkflow_total^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture-> Milk Flow Chart");
				}
			}
			else if(strProducttype.equals("aL")) // Ware House Receipts
			{
				// Checking Data available in Particulars of warehouse
				strQuery=SQLParser.getSqlQuery("per_get_capldata^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture-> Particulars of warehouse");
				}
			}
			else if(strProducttype.equals("aR")) // Loan Against deposits
			{
				// Checking Data available in Deposit Details
				strQuery=SQLParser.getSqlQuery("sel_loanagainstdeposit^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Applicant -> Deposit Details");
				}
			}
			else if(strProducttype.equals("aP")) // Poultry Layer
			{
				// Checking Data available in Technical Data
				strQuery=SQLParser.getSqlQuery("agr_get_poultrytechdata^"+strAppno+"^"+strProducttype);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture -> Technical Data");
				}
				// Checking Data available in Economic Data
				strQuery=SQLParser.getSqlQuery("agr_get_poultryfindata^"+strAppno+"^aP");
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture -> Economic Data");
				}
				// Checking Data available in Layer Flock Replacement
				strQuery=SQLParser.getSqlQuery("agr_selflockrep^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture -> Layer Flock Replacment");
				}
			}
			else if(strProducttype.equals("aA")) // Poultry Broiler
			{
				// Checking Data available in Technical Data
				strQuery=SQLParser.getSqlQuery("agr_get_poultrytechdata^"+strAppno+"^aA");
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture -> Technical Data");
				}
				// Checking Data available in Economic Data
				strQuery=SQLParser.getSqlQuery("agr_get_poultrybroifindata^"+strAppno+"^aA");
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture -> Economic Data");
				}
				// Checking Data available in Layer Flock Replacement
				strQuery=SQLParser.getSqlQuery("agr_broiselflockrep^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture -> Layer Flock Replacment");
				}
			}
			else if(strProducttype.equals("aE")) // Animal Rearing
			{
				// Checking Data available in Technical Data
				strQuery=SQLParser.getSqlQuery("agr_get_sheeptechdata^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture -> Technical Data");
				}
				// Checking Data available in Economic Data
				strQuery=SQLParser.getSqlQuery("agr_get_sheepecodata^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture -> Economic Data");
				}
				// Checking Data available in Live Stock Replacement
				strQuery=SQLParser.getSqlQuery("agr_get_sheepflock^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture -> Live Stock Replacement");
				}
			}
			else if(strProducttype.equals("aN")) // Fisheries
			{
				// Checking Data available in Fisheries Investment
				strQuery=SQLParser.getSqlQuery("selagrfishinvest^"+strAppno+"^1");
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture -> Fisheries Investment");
				}
				// Checking Data available in Particulars Page
				strQuery=SQLParser.getSqlQuery("agrcommonrequirementselbyappno^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture -> Particulars");
				}
				// Checking Data available in Technical Aspects
				strQuery=SQLParser.getSqlQuery("selagrfishinvestmarketing^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture -> Technical Aspects");
				}
			}
			
			else if(strProducttype.equals("aQ")) // Plantation Crops
			{
				// Checking Data available in Land Holdings
				strQuery=SQLParser.getSqlQuery("agrlandholdingsselection^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture -> Land Holding");
				}
				// Checking Data available in Cropping Pattern
				strQuery=SQLParser.getSqlQuery("agr_selcroppingpattern^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture -> Cropping Pattern");
				}
				// Checking Data available in Technical I
				strQuery=SQLParser.getSqlQuery("agr_sel_coffeeterm_tech^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture -> Technical I");
				}
				//	Checking Data available in Technical II
				strQuery=SQLParser.getSqlQuery("agr_sel_plantation_tech^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture -> Technical II");
				}
			}
			else if(strProducttype.equals("aK")) // Common Products
			{
				// Checking Data available in Land Holdings
				strQuery=SQLParser.getSqlQuery("agrcommonrequirementselbyappno^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture -> Loan Particulars");
				}
			}
			else if(strProducttype.equals("aJ")) // Sericulture
			{
				// Checking Data available in Technical Data
				strQuery=SQLParser.getSqlQuery("agr_sel_seritechdata^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture -> Technical Data");
				}
			}
			else if(strProducttype.equals("aM")) // Vehicle Loan
			{
				// Checking Data available in Land Holdings
				strQuery=SQLParser.getSqlQuery("agrlandholdingsselection^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture -> Land Holding");
				}
				// Checking Data available in Particulars of Vehicles
				strQuery=SQLParser.getSqlQuery("agr_Selvehicleparticulars^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Data's Not Entered in Home -> Agriculture -> Particulars of Vehicles");
				}
				
				
			}
			
			
			
			
			
			hshRecord=new HashMap();
			if(arrMessages.size()>0)
			{
				hshRecord.put("Message",arrMessages);
				hshRecord.put("Status","FAILED");
			}
			else
			{
				hshRecord.put("Status","SUCCESS");
			}
		}
		catch(Exception e)
		{
			throw new EJBException ("Error Occured in checkMandatoryPages  ::  "+e.toString());
		}
		finally
		{
			
		}
		return hshRecord;
	}
	
	
	
	
	public void updateAgr_targetmastedate(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction="";
		String strOrgCode=null;
		String strSchemeId=null;
		String strUserId=null;
		String strSolid=null;
		String org_code="";
		String scheme_name="";
		double dbl_Amount=0.00;
		int intupdatesize=0;
		ResultSet rs=null;
		String strQuery="";
		String strMsg="";
		
		try
		{
			strAction=Helper.correctNull((String)hshValues.get("hidAction"));
			
			strOrgCode=Helper.correctNull((String)hshValues.get("strOrgCode"));
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId","ins_agr_targetmaster");
				arrValues.add(Helper.correctNull((String)hshValues.get("strOrgCode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("strSolid")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_schemename")));
				arrValues.add(Helper.correctDouble(((String)hshValues.get("txt_amount"))));
				arrValues.add(Helper.getCurrentDateTime());
				arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_noapplications")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_subsidyamt")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Financialfrom")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Financialto")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_bankloan")));
				
				hshQuery.put("arrValues",arrValues);	
				hshQueryValues.put("1",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId","del_agr_targetmaster");
				arrValues.add(Helper.correctNull((String)hshValues.get("strOrgCode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_schemename")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size", "2");
				hshQuery.put("strQueryId","ins_agr_targetmaster");
				arrValues.add(Helper.correctNull((String)hshValues.get("strOrgCode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("strSolid")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_schemename")));
				arrValues.add(Helper.correctDouble(((String)hshValues.get("txt_amount"))));
				arrValues.add(Helper.getCurrentDateTime());
				arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_noapplications")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_subsidyamt")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Financialfrom")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Financialto")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_bankloan")));
				hshQuery.put("arrValues",arrValues);	
				hshQueryValues.put("2",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId","del_agr_targetmaster");
				arrValues.add(Helper.correctNull((String)hshValues.get("strOrgCode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_schemename")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		
		 }
		catch(Exception e)
		 {
			throw new EJBException(LAlerts.EXCEPTION+"Exception caught");
	     }
		
	}
	
	
	
	public HashMap getAgr_targetmastedate(HashMap hshValues)  
	{
		  
		  HashMap hshRecord=new HashMap();
		  ArrayList arrCol=new ArrayList();
		  ArrayList arrRow=new ArrayList();
		  
		  ResultSet rs=null;
		  String strQuery="";
		  String strSolid="";
		  String strOrgLevel="";
		  String strOrgCode="";
		  java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		  nf.setMaximumFractionDigits(2);
		  nf.setMinimumFractionDigits(2);
		  nf.setGroupingUsed(false);
		  
		  try
		  {
			  strOrgLevel=Helper.correctNull((String)hshValues.get("strOrgLevel"));
			  
			  if(strOrgLevel.equalsIgnoreCase("A"))
			    {
				  strOrgCode=Helper.correctNull((String)hshValues.get("strOrgCode"));
				}
			  else
			  {
				  strOrgCode=Helper.correctNull((String)hshValues.get("hidBranches"));
			  }
			  
			  
			  // strSolid=Helper.correctNull((String)hshValues.get("strSolid"));
			  
			   if(!strOrgCode.equalsIgnoreCase(""))
			   {
		       strQuery = SQLParser.getSqlQuery("sel_agr_targetmaster^"+strOrgCode );	
		       rs=DBUtils.executeQuery(strQuery);
				
				
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(correctNull(rs.getString("agrtm_Solid")));//0
					arrCol.add(correctNull(rs.getString("stat_data_desc1")));//1
					arrCol.add(nf.format(rs.getDouble("agrtm_Amount")));//2
					//arrCol.add(Helper.correctNull((String)rs.getString("")));
					arrCol.add(correctNull(rs.getString("agrtm_SystemDate")));//3
					arrCol.add(correctNull(rs.getString("agrtm_useid")));//4
					arrCol.add(correctNull(rs.getString("agrtm_NoofApplications")));//5
					arrCol.add(nf.format(rs.getDouble("agrtm_SubsidyAmount")));//6
					arrCol.add(correctNull(rs.getString("agrtm_FinancialYearFrom")));//7
					arrCol.add(correctNull(rs.getString("agrtm_FinancialYearto")));//8
					arrCol.add(correctNull(rs.getString("agrtm_SchemeCode")));//9
					arrCol.add(correctNull(rs.getString("agrtm_bankloan")));//10
					arrRow.add(arrCol);
					
					
				}
			   }
				
				borrowersearchBean borrser=new borrowersearchBean();
				HashMap hshRecordBS=new HashMap();
				hshRecordBS=(HashMap)borrser.getData(hshRecord);
				ArrayList arrbs = null;
				arrbs=(ArrayList)hshRecordBS.get("arr");
				hshRecord.put("arrRowtargetmaster", arrRow);
				hshRecord.put("arr",arrbs);
				
				
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
			return hshRecord;
			
		
		
	}
	
	
	
	
	
	
	
	
	
	
}
