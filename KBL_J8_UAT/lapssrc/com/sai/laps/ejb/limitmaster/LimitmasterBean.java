package com.sai.laps.ejb.limitmaster;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "LimitmasterBean", mappedName = "LimitmasterHome")
@Remote (LimitmasterRemote.class)
public class LimitmasterBean extends BeanAdapter
{	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public HashMap getLimitList(HashMap hshRequestValues) 
	{		
		ResultSet rs = null;
		ArrayList vecVal = new ArrayList();
		ArrayList vecRec=null;
		HashMap hshRecord = new HashMap();
		String strQuery="";
		String strPrdType="C";
		try
		{				
			hshRecord = new HashMap();
			strPrdType = correctNull((String)hshRequestValues.get("prdtype"));
			strQuery = SQLParser.getSqlQuery("getlimitlist^"+strPrdType);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{   
				vecRec = new ArrayList();
				for (int i=0;i<3;i++ )
				{ 
					vecRec.add(rs.getString(i+1));
				}
				vecVal.add(vecRec);
			}
			hshRecord.put("vecVal",vecVal);
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
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap getData(HashMap hshRequestValues) 
	{		
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strQuery="";
		String strLimitId="";
		String strPrdType="C";
		boolean recordflag=false; 
		try
		{				
			hshRecord = new HashMap();
			strLimitId=correctNull((String)hshRequestValues.get("selectlimit"));
			strPrdType = correctNull((String)hshRequestValues.get("prdtype"));
			strQuery = SQLParser.getSqlQuery("getlimitval^"+strPrdType+"^"+strLimitId);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{  
				recordflag=true;
				hshRecord.put("prd_rng_from",correctNull(rs.getString(1)));
				hshRecord.put("prd_rng_to",correctNull(rs.getString(2)));
				hshRecord.put("prd_term",correctNull(rs.getString(3)));
				hshRecord.put("prd_code",correctNull(strLimitId));
				hshRecord.put("prd_maxappclass",correctNull(rs.getString(4)));
				hshRecord.put("prd_maxskipclass",correctNull(rs.getString(5)));
				if(correctNull(rs.getString(5)).equalsIgnoreCase(""))
				{
					recordflag=false;
				}
				
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

	public void updateData(HashMap hshValues) 
	{	
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String strLimitId = "",strExp="$";
		String strLimitFrom="";
		String strLimitTo = "";
		String strLimitClass ="";
		String strSkipClass="";
		String strPrdType="C";		
		String strQuery="",id = "";
		int intValue = 0;
		int intUpdatesize = 0;
		ResultSet rs = null;
		String strLoanType="";
		String strKeyId = "";
		StringBuilder sbolddata=new StringBuilder();
		try
		{			
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			strLimitId =  correctNull((String )hshValues.get("selectlimit"));
			strLimitFrom = correctNull((String )hshValues.get("txtlimit_from"));
			strLimitTo =  correctNull((String )hshValues.get("txtlimit_to"));
			strLimitClass = correctNull((String )hshValues.get("txtlimit_class"));
			strSkipClass = correctNull((String )hshValues.get("txtskip_class"));
			strPrdType = correctNull((String)hshValues.get("prdtype"));
			strLoanType=correctNull((String)hshValues.get("prdtype"));
			
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				rs = DBUtils.executeLAPSQuery("getlimitval^"+strPrdType+"^"+strLimitId);
				while(rs.next())
				{
					sbolddata.append("~ Loan limit from (Rs.)= "+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("prd_rng_from")))));
					sbolddata.append("~ Loan limit To (Rs.)= "+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("prd_rng_to")))));
					sbolddata.append("~ Minimum Class for Approval / Rejection = "+Helper.correctNull((String)rs.getString("prd_approval")));
					sbolddata.append("~ Minimum Class for Skip flowpoints = "+Helper.correctNull((String)rs.getString("prd_skip")));
				}
				if(rs!=null)
					rs.close();
			}
			
			if(strSkipClass.trim().equals(""))
			{
				strSkipClass="0";
			}
			
			if(strLimitFrom.trim().equals(""))
			{
				strLimitFrom ="0";
			}
			if(strLimitTo.trim().equals(""))
			{
				strLimitTo ="0";
			}

			hshQueryValues = new HashMap();
			hshQuery = new HashMap();					

			if(strAction.trim().equals("update"))
			{
				int curLimitId=0;
				if(!strLimitId.trim().equals(""))
				{
					curLimitId = Integer.parseInt(strLimitId);
				}
				strQuery = SQLParser.getSqlQuery("checklimitrange^"+strPrdType+"^"+strLimitId+"^"+strLimitFrom +"^"+strLimitTo);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					int intLimitid = rs.getInt("prd_code");
					if(intLimitid != curLimitId)
					{
						strExp = strExp + " Check the existing limit range ";
						throw new Exception(strExp);
					}
				}
				intUpdatesize ++ ;
				hshQuery.put("strQueryId","updatelimit");
				arrValues.add(strLimitFrom);
				arrValues.add(strLimitTo);
				arrValues.add(strLimitClass);
				arrValues.add(strPrdType);
				arrValues.add(strLimitId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

				intUpdatesize ++ ;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","updatesancauth");
				arrValues.add(strSkipClass);
				arrValues.add(strLimitClass);
				arrValues.add("0");
				arrValues.add(strLimitId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				intUpdatesize ++ ;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ops_updateprocesscharge");
				arrValues.add(strLimitFrom);
				arrValues.add(strLimitTo);
				arrValues.add(strLimitId);
				arrValues.add("1");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);	
				
				intUpdatesize ++ ;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ops_updatedocumentcharge");
				arrValues.add(strLimitFrom);
				arrValues.add(strLimitTo);
				arrValues.add(strLimitId);
				arrValues.add("1");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);	
				

				intUpdatesize ++ ;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ops_updmargin");
				arrValues.add(strLimitFrom);
				arrValues.add(strLimitTo);
				arrValues.add(strLimitId);
				arrValues.add("1");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				intUpdatesize ++ ;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ops_updinterest");
				arrValues.add(strLimitFrom);
				arrValues.add(strLimitTo);
				arrValues.add(strLimitId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
			}
			else if(strAction.equals("insert"))
			{
				strLimitId =  Integer.toString(getLimitCode());
				strQuery = SQLParser.getSqlQuery("checklimitrange^"+strPrdType+"^"+strLimitId+"^"+strLimitFrom +"^"+strLimitTo);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					strExp = strExp + " Check the existing limit range ";
					throw new Exception(strExp);
				}
				intUpdatesize ++ ;
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insertlimit");
				arrValues.add(strLimitId);
				arrValues.add(strLimitFrom);
				arrValues.add(strLimitTo);
				arrValues.add(strPrdType);
				arrValues.add(strLimitClass);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);	

				intUpdatesize ++ ;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","prdauthins");
				arrValues.add(strLimitId);
				arrValues.add(strSkipClass);
				arrValues.add(strLimitClass );
				arrValues.add("0");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				//by venu for tertiary
				intUpdatesize ++ ;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ops_insprocesscharge");
				arrValues.add(strLimitId);
				arrValues.add(strLimitFrom);
				arrValues.add(strLimitTo );
				arrValues.add("1" );
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				intUpdatesize ++ ;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ops_insdocumentcharge");
				arrValues.add(strLimitId);
				arrValues.add("1" );
				arrValues.add(strLimitFrom);
				arrValues.add(strLimitTo );
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				intUpdatesize ++ ;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ops_insmargin");
				arrValues.add(strLimitId);
				arrValues.add("1");
				arrValues.add(strLimitFrom);
				arrValues.add(strLimitTo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				/*if(rs!=null)
					rs.close();
						
				rs = DBUtils.executeLAPSQuery("intmaxterm");
				if (rs.next()) 
					intValue = (rs.getInt(1));
					
				intValue = intValue + 1;
				id = Integer.toString(intValue);
				
				intUpdatesize ++ ;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ops_insinterest");
				arrValues.add(strLimitId);
				arrValues.add("floating");
				arrValues.add(id);
				arrValues.add(strLimitFrom);
				arrValues.add(strLimitTo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);*/
				
				if(rs!=null)
					rs.close();
						
				rs = DBUtils.executeLAPSQuery("intmaxterm");
				if (rs.next()) 
					intValue = (rs.getInt(1));
					
				intValue = intValue + 1;
				id = Integer.toString(intValue);
				
				intUpdatesize ++ ;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ops_insinterest");
				arrValues.add(strLimitId);
				arrValues.add("fixed");
				arrValues.add(id);
				arrValues.add(strLimitFrom);
				arrValues.add(strLimitTo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
			}
 			else if(strAction.equals("delete"))
			{
 				
 				strQuery = SQLParser.getSqlQuery("checkapplication^"+strLimitId);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					if(!correctNull((String)rs.getString(1)).equals("0"))
					{	
						strExp = strExp + "Application created in this limit range so can't able to delete the limit";
						throw new Exception(strExp);
					}	
				}
 				
 				intUpdatesize ++ ;
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","deletelimit");
				arrValues.add(strPrdType);
				arrValues.add(strLimitId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);	

				intUpdatesize ++ ;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","prdauthdel");
				arrValues.add(strLimitId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				intUpdatesize ++ ;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ops_deleteprocesscharge");
				arrValues.add(strLimitId);
				arrValues.add("1");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				intUpdatesize ++ ;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ops_deletedocumentcharge");
				arrValues.add(strLimitId);
				arrValues.add("1");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				intUpdatesize ++ ;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ops_deletemargin");
				arrValues.add(strLimitId);
				arrValues.add("1");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				intUpdatesize ++ ;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ops_deleteinterest");
				arrValues.add(strLimitId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				
			}
			hshQueryValues.put("size",Integer.toString(intUpdatesize));
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			//for Entering the values into auditrial
			String strActionData = "";
			if(!strAction.equals("delete"))
			{
				strActionData = "Loan limit from ="+strLimitFrom+
				"~Loan limit To="+strLimitTo+
				"~Minimum Class for Approval / Rejection ="+strLimitClass+
				"~Minimum Class for Skip flowpoints="+strSkipClass;
			}
			String strPageType="";
			if(strPrdType.equalsIgnoreCase("T"))
				strPageType="113";
			if(strPrdType.equalsIgnoreCase("C"))
				strPageType="94";
			if(correctNull((String)hshValues.get("hidAction")).equals("delete"))
			{
			   AuditTrial.auditNewLog(hshValues,strPageType,strKeyId,strActionData,sbolddata.toString());
			}	
			if(correctNull((String)hshValues.get("hidRecordflag")).equals("Y"))
			{
			   hshValues.put("hidAction", "update");
			   AuditTrial.auditNewLog(hshValues,strPageType,strKeyId,strActionData,sbolddata.toString());
			}
			if(correctNull((String)hshValues.get("hidRecordflag")).equals("N"))
			{
			   hshValues.put("hidAction", "insert");
			   AuditTrial.auditLog(hshValues,strPageType,strKeyId,strActionData);
			   
			}

			
		}
		catch(Exception ce)
		{
			throw new EJBException(ce.toString());
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
	
	private int getLimitCode()
	{		
		String strQuery="";
		ResultSet rs = null;
		int limitid = 0;
		try
		{				
			strQuery = SQLParser.getSqlQuery("maxlimitid");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				limitid = rs.getInt(1);
			}
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
		return limitid;
	}
	
	public HashMap getAgencyandSymbolList(HashMap hshValues)
	{
		ResultSet rs = null;
		ArrayList arrCol = new ArrayList();
		ArrayList arrValue = new ArrayList();
		String strQuery="",strPageid="";
		
		try
		{	
			strPageid=Helper.correctNull((String)hshValues.get("pageID"));
			String name=correctNull((String)hshValues.get("txt_value")).trim();
			String val=correctNull((String)hshValues.get("hidvalue"));
			
			String strAgency=correctNull((String)hshValues.get("hidagency")).trim();
			String strType=correctNull((String)hshValues.get("hidtype")).trim();
			
			if(strAgency.equals(""))
				strAgency=correctNull((String)hshValues.get("agency")).trim();
			if(strType.equals(""))
				strType=correctNull((String)hshValues.get("type")).trim();
			if(rs != null)
			{
				rs.close();
			}
			if(val.equals("agency"))
			{
				if(!name.equals(""))
				{
					strQuery = SQLParser.getSqlQuery("sel_agencylist^"+name);
				}
				else
				{
					strQuery = SQLParser.getSqlQuery("sel_agencyalllist");
				}
				
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					
					arrCol = new ArrayList();
					arrCol.add(correctNull(rs.getString("external_agency")));//0
					arrValue.add(arrCol);
				}	
			}
			else if(val.equals("symbol"))
			{	
				if(strPageid.equals("setupsymbol")){
					strQuery = SQLParser.getSqlQuery("sel_symbolalllist^"+strAgency+"^"+strType);
				}
				else if(strPageid.equals("setupsymbol")&&!name.equals(""))
				{
					strQuery = SQLParser.getSqlQuery("sel_symbollist^"+name+"^"+strAgency+"^"+strType);
				}
				else if(!name.equals(""))
				{
					strQuery = SQLParser.getSqlQuery("sel_symbollistname^"+name+"^"+strAgency+"^"+strType);
				}
				else
				{
					strQuery = SQLParser.getSqlQuery("sel_symbolalllist_action^"+strAgency+"^"+strType);
				}
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					
					arrCol = new ArrayList();
					arrCol.add(correctNull(rs.getString("external_agency")));//0
					arrCol.add(correctNull(rs.getString("external_instype")));//1
					arrCol.add(correctNull(rs.getString("external_symbol")));//2
					arrCol.add(correctNull(rs.getString("external_meaning")));//3
					arrCol.add(correctNull(rs.getString("external_sno")));//4
					arrCol.add(correctNull(rs.getString("EXTERNAL_ACTION")));//5
					arrCol.add(correctNull(rs.getString("EXTERNAL_DEFINITION")));//6
					arrValue.add(arrCol);
				}	
			}
	       
			
	       	hshValues.put("arrCust",arrValue);

		}
	catch(Exception ce)
	{
		
		throw new EJBException("Error in getAgencyandSymbolList ::  "+ce.toString());
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
	return hshValues;
	}
	
	public HashMap updateExternalCreditRating(HashMap hshValues)
	{
		HashMap	hshRecord = new HashMap();
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues=new ArrayList();
		ResultSet rs = null;
		int intcount=0;
		StringBuilder sbAt=new StringBuilder();
		StringBuilder sbolddata = new StringBuilder();
		String strKeyId = "";
		try
		{
			String strAction=correctNull((String)hshValues.get("hidAction"));
			String strAgency=correctNull((String)hshValues.get("txt_agency")).trim();
			String strType=correctNull((String)hshValues.get("seltype"));;
			String strSymbol=correctNull((String)hshValues.get("txt_symbol")).trim();
			String strMeaning=correctNull((String)hshValues.get("txt_meaning")).trim();
			String strActive=correctNull((String)hshValues.get("sel_active")).trim();
			String strsno=correctNull((String)hshValues.get("hidsno"));
			
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			if(strAction.equalsIgnoreCase("UPDATE") || strAction.equalsIgnoreCase("DELETE"))
			{
				rs = DBUtils.executeLAPSQuery("select_limitmaster_audit^"+strAgency+"^"+strsno);
				while(rs.next())
				{
					sbolddata.append("~ Agency Name = "+Helper.correctNull((String)rs.getString("external_agency")));
					sbolddata.append("~ Type = ");
					String strType1 = Helper.correctNull((String)rs.getString("EXTERNAL_INSTYPE"));
					if(strType1.equalsIgnoreCase("S")) sbolddata.append("Short Term");
					else if(strType1.equalsIgnoreCase("L")) sbolddata.append("Long Term");
					sbolddata.append("~ Rating Symbol = "+Helper.correctNull((String)rs.getString("EXTERNAL_SYMBOL")));
					sbolddata.append("~ Rating Meaning = "+Helper.correctNull((String)rs.getString("EXTERNAL_MEANING")));
				}
			}
			
			if(strAction.equals("INSERT"))
			{
				hshQuery.put("strQueryId","insexternalrating");
				rs = DBUtils.executeLAPSQuery("sel_max_agency^"+strAgency);
				if(rs.next())
				{
					intcount=rs.getInt("snomax");
				}
				arrValues.add(""+intcount);
				arrValues.add(strAgency);
				arrValues.add(strType);
				arrValues.add(strSymbol);
				arrValues.add(strMeaning);
				arrValues.add(strActive);
				arrValues.add(correctNull((String)hshValues.get("txtArea_definition")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			}
			else if(strAction.equals("UPDATE"))
			{
				hshQuery.put("strQueryId","updateexternalrating");
				
				arrValues.add(strType);
				arrValues.add(strSymbol);
				arrValues.add(strMeaning);
				arrValues.add(strActive);
				arrValues.add(correctNull((String)hshValues.get("txtArea_definition")));
				arrValues.add(strAgency);
				arrValues.add(strsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			}
			else if(strAction.equals("DELETE"))
			{
				hshQuery.put("strQueryId","delexternalrating");
				arrValues.add(strAgency);
				arrValues.add(strsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			}
			if(!strAction.equalsIgnoreCase(""))
			{
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			 sbAt = new StringBuilder();
			 if(strAction.equalsIgnoreCase("UPDATE") || strAction.equalsIgnoreCase("Insert")){
			 sbAt.append("~ Agency Name = "+Helper.correctNull((String)hshValues.get("txt_agency")));
			 sbAt.append("~ Type = ");
			 if(Helper.correctNull((String)hshValues.get("seltype")).equalsIgnoreCase("S")) sbAt.append("Short Term");
			 else if(Helper.correctNull((String)hshValues.get("seltype")).equalsIgnoreCase("N")) sbAt.append("Long Term");
			 sbAt.append("~ Rating Symbol = "+Helper.correctNull((String)hshValues.get("txt_symbol")));
			 sbAt.append("~ Rating Meaning = "+Helper.correctNull((String)hshValues.get("txt_meaning")));
			 }
			 AuditTrial.auditNewLog(hshValues,"361",strKeyId,sbAt.toString(),sbolddata.toString());
		}
	catch(Exception ce)
	{		
		throw new EJBException("Error in updateExternalCreditRating ::  "+ce.toString());
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