
package com.sai.laps.ejb.npaappreport;


import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "npaapprepBean", mappedName = "npaapprepHome")
@Remote (npaappreportRemote.class)
public class npaapprepBean extends BeanAdapter
{
	
	/**
	 * 
	 */
	//static Logger log=Logger.getLogger(npaapprepBean.class);
	private static final long serialVersionUID = 230961992313664424L;

	public HashMap getData(HashMap hshValues) 
	{
		HashMap hshRecord = new HashMap();
		String strMethod ="";

		try
		{
			strMethod=correctNull((String)hshValues.get("hidMethod"));

			if(strMethod.equalsIgnoreCase("getLegalCases"))
			{
				hshRecord=getLegalCases(hshValues);
			}
			else if(strMethod.equalsIgnoreCase("getDecreedCases"))
			{
				hshRecord=getDecreedCases(hshValues);
			}
			else if(strMethod.equalsIgnoreCase("getDecreedEP"))
			{
				hshRecord=getDecreedEP(hshValues);
			}
			else if(strMethod.equalsIgnoreCase("getSuitbyAdvocate"))
			{
				hshRecord=getSuitbyAdvocate(hshValues);
			}
			else if(strMethod.equalsIgnoreCase("getSarfaesiCases"))
			{
				hshRecord=getSarfaesiCases(hshValues);
			}
			else if(strMethod.equalsIgnoreCase("getWriteoff"))
			{
				hshRecord=getWriteoff(hshValues);
			}
			else if(strMethod.equalsIgnoreCase("getCompromiseSettlement"))
			{
				hshRecord=getCompromiseSettlement(hshValues);
			}
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getdata "+ce.toString());
		}
		
		return hshRecord;

	}
	
	
	private HashMap getLegalCases(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		String strOrglevel="";
		String strCourt="";
		String strOrgcode="";
		String strSchemes="";
		String strPeriod="";
		String strAmtfrom="";
		String strToamt="";
		String strFromdate="";
		String strTodate="";
		String strQuery="";
		String strorgcodes="";
		
		StringBuffer strAppendQuery=new StringBuffer();
		
		ResultSet rs=null;
		
		ArrayList arrCol=new ArrayList();
		ArrayList arrRow=new ArrayList();
		try
		{
			String strPrint = Helper.correctNull((String)hshValues.get("hidPrint"));
			strOrglevel=correctNull((String)hshValues.get("hidOrgLevel"));
			strCourt=correctNull((String)hshValues.get("hidCourt"));
			strAmtfrom=correctNull((String)hshValues.get("txtfromamt"));
			strToamt=correctNull((String)hshValues.get("txttoamt"));
			strPeriod=correctNull((String)hshValues.get("hidPeriod"));
			strOrgcode=correctNull((String)hshValues.get("hidOrgcode"));
			strSchemes=correctNull((String)hshValues.get("hidSchemes"));
			
			hshRecord.put("strOrglevel", strOrglevel);
			hshRecord.put("strCourt", strCourt);
			hshRecord.put("strAmtfrom", strAmtfrom);
			hshRecord.put("strToamt", strToamt);
			hshRecord.put("strPeriod", strPeriod);
			hshRecord.put("strOrgcode", strOrgcode);
			hshRecord.put("strSchemes", strSchemes);
			hshRecord.put("strPrint", strPrint);
			
			if(strPeriod.equalsIgnoreCase(""))
			{
				strPeriod="All";
			}
			
			strAppendQuery.append("suit.suit_amount between '"+strAmtfrom+"' and '"+strToamt+"'");
			
			if(!strPeriod.equals("All"))
			{
				strFromdate = strPeriod.substring(0,strPeriod.indexOf("-"));
				strTodate = strPeriod.substring(strPeriod.indexOf("-")+1,strPeriod.length());
				strAppendQuery.append(" and to_date(to_char(suit.suit_date,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date('"
						+strFromdate+"','dd/mm/yyyy') and to_date('"+strTodate+"','dd/mm/yyyy')");
			}
			
			if(strOrglevel.equals("C"))
			{	
				strorgcodes="ORG_CODE like '"+strOrgcode.substring(2,5)+"%'";
			}
			else if(strOrglevel.equals("R"))
			{
				strorgcodes="ORG_CODE like '"+strOrgcode.substring(2,8)+"%'";
			}
			else if(strOrglevel.equals("D"))
			{
				strorgcodes="ORG_CODE like '"+strOrgcode.substring(2,11)+"%'";
			}
			else if(strOrglevel.equals("A"))
			{
				strorgcodes="ORG_CODE in ('"+strOrgcode.substring(2,17)+"')";
			}
			else if(strOrglevel.equals("B"))
			{
				strorgcodes="ORG_CODE in ('"+strOrgcode.substring(2,17)+"')";
			}
			
			strQuery=SQLParser.getSqlQuery("selnpasuitreport^"+strCourt+"^"+strAppendQuery.toString()+"^"+strorgcodes);
			
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				arrCol=new ArrayList();
				//arrCol.add(correctNull(rs.getString("cbsnpa_custname")));
				arrCol.add(correctNull(rs.getString("personal_custname")));
				arrCol.add(correctNull(rs.getString("suit_no")));
				arrCol.add(correctNull(rs.getString("suit_date")));
				arrCol.add(correctNull(rs.getString("suit_amount")));
				arrCol.add(correctNull(rs.getString("sta_npa_sincedate")));
				arrCol.add(correctNull(rs.getString("pre_running_outstand")));
				arrCol.add(correctNull(rs.getString("suit_presentposition")));
				arrCol.add(correctNull(rs.getString("suit_advocatename")));
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow",arrRow);
			
		}
		catch(Exception ex)
		{
			throw new EJBException("Error in getLegalcases :: "+ex.getMessage());
		}finally
		{
			
		}
		return hshRecord;
	}
	
	private HashMap getDecreedCases(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		String strOrglevel="";
		String strOrgcode="";
		String strSchemes="";
		String strPeriod="";
		String strAmtfrom="";
		String strToamt="";
		String strFromdate="";
		String strTodate="";
		String strQuery="";
		String strorgcodes="";
		
		StringBuffer strAppendQuery=new StringBuffer();
		
		ResultSet rs=null;
		
		ArrayList arrCol=new ArrayList();
		ArrayList arrRow=new ArrayList();
		try
		{
			String strPrint = Helper.correctNull((String)hshValues.get("hidPrint"));
			strOrglevel=correctNull((String)hshValues.get("hidOrgLevel"));
			strAmtfrom=correctNull((String)hshValues.get("txtfromamt"));
			strToamt=correctNull((String)hshValues.get("txttoamt"));
			strPeriod=correctNull((String)hshValues.get("hidPeriod"));
			strOrgcode=correctNull((String)hshValues.get("hidOrgcode"));
			strSchemes=correctNull((String)hshValues.get("hidSchemes"));
			
			hshRecord.put("strOrglevel",strOrglevel);
			hshRecord.put("strAmtfrom",strAmtfrom);
			hshRecord.put("strToamt",strToamt);
			hshRecord.put("strPeriod",strPeriod);
			hshRecord.put("strOrgcode",strOrgcode);
			hshRecord.put("strSchemes",strSchemes);
			hshRecord.put("strPrint",strPrint);
			
			if(strPeriod.equalsIgnoreCase(""))
			{
				strPeriod="All";
			}
			
			strAppendQuery.append("suit.suit_decreeamount between '"+strAmtfrom+"' and '"+strToamt+"'");
			
			if(!strPeriod.equals("All"))
			{
				strFromdate = strPeriod.substring(0,strPeriod.indexOf("-"));
				strTodate = strPeriod.substring(strPeriod.indexOf("-")+1,strPeriod.length());
				strAppendQuery.append(" and to_date(to_char(suit.suit_dateofdecree,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date('"
						+strFromdate+"','dd/mm/yyyy') and to_date('"+strTodate+"','dd/mm/yyyy')");
			}
			
			if(strOrglevel.equals("C"))
			{	
				strorgcodes="ORG_CODE like '"+strOrgcode.substring(2,5)+"%'";
			}
			else if(strOrglevel.equals("R"))
			{
				strorgcodes="ORG_CODE like '"+strOrgcode.substring(2,8)+"%'";
			}
			else if(strOrglevel.equals("D"))
			{
				strorgcodes="ORG_CODE like '"+strOrgcode.substring(2,11)+"%'";
			}
			else if(strOrglevel.equals("A"))
			{
				strorgcodes="ORG_CODE in ('"+strOrgcode.substring(2,17)+"')";
			}
			else if(strOrglevel.equals("B"))
			{
				strorgcodes="ORG_CODE in ('"+strOrgcode.substring(2,17)+"')";
			}
			
			strQuery=SQLParser.getSqlQuery("selnpadecreedcases^"+strAppendQuery.toString()+"^"+strorgcodes);
			
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				arrCol=new ArrayList();
				//arrCol.add(correctNull(rs.getString("cbsnpa_custname")));
				arrCol.add(correctNull(rs.getString("personal_custname")));
				arrCol.add(correctNull(rs.getString("suit_no")));
				arrCol.add(correctNull(rs.getString("suit_decreeamount")));
				arrCol.add(correctNull(rs.getString("suit_dateofdecree")));
				String strCourt=correctNull(rs.getString("suit_courtname"));
				if(strCourt.equals("1"))
					arrCol.add("Civil");
				else if(strCourt.equals("2"))
					arrCol.add("DRT");
				else if(strCourt.equals("3"))
					arrCol.add("Revenue Recovery");
				else if(strCourt.equals("4"))
					arrCol.add("High Court");
				else if(strCourt.equals("5"))
					arrCol.add("Others");
				else
					arrCol.add("");
				arrCol.add(correctNull(rs.getString("suit_totalrecovery")));
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow",arrRow);
			
		}
		catch(Exception ex)
		{
			throw new EJBException("Error in getLegalcases :: "+ex.getMessage());
		}finally
		{
			
		}
		return hshRecord;
	}
	
	
	private HashMap getDecreedEP(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		String strOrglevel="";
		String strOrgcode="";
		String strSchemes="";
		String strPeriod="";
		String strAmtfrom="";
		String strToamt="";
		String strFromdate="";
		String strTodate="";
		String strQuery="";
		String strorgcodes="";
		
		StringBuffer strAppendQuery=new StringBuffer();
		
		ResultSet rs=null;
		
		ArrayList arrCol=new ArrayList();
		ArrayList arrRow=new ArrayList();
		try
		{
			String strPrint = Helper.correctNull((String)hshValues.get("hidPrint"));
			strOrglevel=correctNull((String)hshValues.get("hidOrgLevel"));
			strAmtfrom=correctNull((String)hshValues.get("txtfromamt"));
			strToamt=correctNull((String)hshValues.get("txttoamt"));
			strPeriod=correctNull((String)hshValues.get("hidPeriod"));
			strOrgcode=correctNull((String)hshValues.get("hidOrgcode"));
			strSchemes=correctNull((String)hshValues.get("hidSchemes"));
			
			hshRecord.put("strOrglevel", strOrglevel);
			hshRecord.put("strAmtfrom", strAmtfrom);
			hshRecord.put("strToamt", strToamt);
			hshRecord.put("strPeriod", strPeriod);
			hshRecord.put("strOrgcode", strOrgcode);
			hshRecord.put("strSchemes", strSchemes);
			hshRecord.put("strPrint", strPrint);
			
			if(strPeriod.equalsIgnoreCase(""))
			{
				strPeriod="All";
			}
			
			strAppendQuery.append("suit.suit_decreeamount between '"+strAmtfrom+"' and '"+strToamt+"'");
			
			if(!strPeriod.equals("All"))
			{
				strFromdate = strPeriod.substring(0,strPeriod.indexOf("-"));
				strTodate = strPeriod.substring(strPeriod.indexOf("-")+1,strPeriod.length());
				strAppendQuery.append(" and to_date(to_char(suit.suit_dateofdecree,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date('"
						+strFromdate+"','dd/mm/yyyy') and to_date('"+strTodate+"','dd/mm/yyyy')");
			}
			
			if(strOrglevel.equals("C"))
			{	
				strorgcodes="ORG_CODE like '"+strOrgcode.substring(2,5)+"%'";
			}
			else if(strOrglevel.equals("R"))
			{
				strorgcodes="ORG_CODE like '"+strOrgcode.substring(2,8)+"%'";
			}
			else if(strOrglevel.equals("D"))
			{
				strorgcodes="ORG_CODE like '"+strOrgcode.substring(2,11)+"%'";
			}
			else if(strOrglevel.equals("A"))
			{
				strorgcodes="ORG_CODE in ('"+strOrgcode.substring(2,17)+"')";
			}
			else if(strOrglevel.equals("B"))
			{
				strorgcodes="ORG_CODE in ('"+strOrgcode.substring(2,17)+"')";
			}
			
			strQuery=SQLParser.getSqlQuery("selnpadecreedEP^"+strAppendQuery.toString()+"^"+strorgcodes);
			
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				arrCol=new ArrayList();
				//arrCol.add(correctNull(rs.getString("cbsnpa_custname")));
				arrCol.add(correctNull(rs.getString("personal_custname")));
				arrCol.add(correctNull(rs.getString("suit_no")));
				arrCol.add(correctNull(rs.getString("suit_decreeamount")));
				arrCol.add(correctNull(rs.getString("suit_dateofdecree")));
				arrCol.add(correctNull(rs.getString("suit_dateoffilling")));
				arrCol.add(correctNull(rs.getString("suit_presentposition")));
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow",arrRow);
			
		}
		catch(Exception ex)
		{
			throw new EJBException("Error in getLegalcases :: "+ex.getMessage());
		}finally
		{
			
		}
		return hshRecord;
	}
	
	private HashMap getSuitbyAdvocate(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		String strOrglevel="";
		String strOrgcode="";
		String stradvocate="";
		String strPeriod="";
		String strAmtfrom="";
		String strToamt="";
		String strFromdate="";
		String strTodate="";
		String strQuery="";
		String strorgcodes="";
		
		StringBuffer strAppendQuery=new StringBuffer();
		
		ResultSet rs=null;
		
		ArrayList arrCol=new ArrayList();
		ArrayList arrRow=new ArrayList();
		try
		{
			String strPrint = Helper.correctNull((String)hshValues.get("hidPrint"));
			strOrglevel=correctNull((String)hshValues.get("hidOrgLevel"));
			stradvocate=correctNull((String)hshValues.get("hidadvocate"));
			strAmtfrom=correctNull((String)hshValues.get("txtfromamt"));
			strToamt=correctNull((String)hshValues.get("txttoamt"));
			strPeriod=correctNull((String)hshValues.get("hidPeriod"));
			strOrgcode=correctNull((String)hshValues.get("hidOrgcode"));
			
			if(strPeriod.equalsIgnoreCase(""))
			{
				strPeriod="All";
			}
			hshRecord.put("strPrint",strPrint);
			hshRecord.put("strOrglevel",strOrglevel);
			hshRecord.put("stradvocate",stradvocate);
			hshRecord.put("strAmtfrom",strAmtfrom);
			hshRecord.put("strToamt",strToamt);
			hshRecord.put("strPeriod",strPeriod);
			hshRecord.put("strOrgcode",strOrgcode);
			strAppendQuery.append("suit.suit_amount between '"+strAmtfrom+"' and '"+strToamt+"'");
			
			if(!strPeriod.equals("All"))
			{
				strFromdate = strPeriod.substring(0,strPeriod.indexOf("-"));
				strTodate = strPeriod.substring(strPeriod.indexOf("-")+1,strPeriod.length());
				strAppendQuery.append(" and to_date(to_char(suit.suit_date,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date('"
						+strFromdate+"','dd/mm/yyyy') and to_date('"+strTodate+"','dd/mm/yyyy')");
			}
			
			if(strOrglevel.equals("C"))
			{	
				strorgcodes="org.org_code like '"+strOrgcode.substring(2,5)+"%'";
			}
			else if(strOrglevel.equals("R"))
			{
				strorgcodes="org.org_code like '"+strOrgcode.substring(2,8)+"%'";
			}
			else if(strOrglevel.equals("D"))
			{
				strorgcodes="org.org_code like '"+strOrgcode.substring(2,11)+"%'";
			}
			else if(strOrglevel.equals("A"))
			{
				strorgcodes="org.org_code in ('"+strOrgcode.substring(2,17)+"')";
			}
			else if(strOrglevel.equals("B"))
			{
				strorgcodes="org.org_code in ('"+strOrgcode.substring(2,17)+"')";
			}
			
			strQuery=SQLParser.getSqlQuery("selnparepadvocatewise^"+stradvocate+"^"+strAppendQuery.toString()+"^"+strorgcodes);
			
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				arrCol=new ArrayList();
				//arrCol.add(correctNull(rs.getString("cbsnpa_custname")));
				arrCol.add(correctNull(rs.getString("personal_custname")));
				String strCourt=correctNull(rs.getString("suit_courtname"));
				if(strCourt.equals("1"))
					arrCol.add("Civil");
				else if(strCourt.equals("2"))
					arrCol.add("DRT");
				else if(strCourt.equals("3"))
					arrCol.add("Revenue Recovery");
				else if(strCourt.equals("4"))
					arrCol.add("High Court");
				else if(strCourt.equals("5"))
					arrCol.add("Others");
				else
					arrCol.add("");
				arrCol.add(correctNull(rs.getString("suit_date")));
				arrCol.add(correctNull(rs.getString("suit_amount")));
				arrCol.add(correctNull(rs.getString("suit_presentposition")));
				arrCol.add(correctNull(rs.getString("lawyer_name")));
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow",arrRow);
			
		}
		catch(Exception ex)
		{
			throw new EJBException("Error in getLegalcases :: "+ex.getMessage());
		}finally
		{
			
		}
		return hshRecord;
	}
	
	private HashMap getSarfaesiCases(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		String strOrglevel="";
		String strOrgcode="";
		String strSchemes="";
		String strPeriod="";
		String strAmtfrom="";
		String strToamt="";
		String strFromdate="";
		String strTodate="";
		String strQuery="";
		String strorgcodes="";
		String hidorgname="";
		
		StringBuffer strAppendQuery=new StringBuffer();
		
		ResultSet rs=null;
		
		ArrayList arrCol=new ArrayList();
		ArrayList arrRow=new ArrayList();
		try
		{
			
			String strPrint = Helper.correctNull((String)hshValues.get("hidPrint"));
			strOrglevel=correctNull((String)hshValues.get("hidlevel"));
			strAmtfrom=correctNull((String)hshValues.get("hidfromamt"));
			strToamt=correctNull((String)hshValues.get("hidtoamt"));
			strPeriod=correctNull((String)hshValues.get("hidperiod"));
			strOrgcode=correctNull((String)hshValues.get("hidorgcode"));
			strSchemes=correctNull((String)hshValues.get("hidSchemes"));
			hidorgname=correctNull((String)hshValues.get("hidorgname"));
			
			hshRecord.put("strOrglevel", strOrglevel);
			hshRecord.put("strAmtfrom", strAmtfrom);
			hshRecord.put("strToamt", strToamt);
			hshRecord.put("strPeriod", strPeriod);
			hshRecord.put("strOrgcode", strOrgcode);
			hshRecord.put("strSchemes", strSchemes);
			hshRecord.put("hidorgname", hidorgname);
			hshRecord.put("strPrint", strPrint);
			
			
			if(strOrglevel.equals("C"))
			{	
				strAppendQuery.append(" and ORG_CODE like '"+strOrgcode.substring(2,5)+"%'");
			}
			else if(strOrglevel.equals("R"))
			{
				strAppendQuery.append(" and ORG_CODE like '"+strOrgcode.substring(2,8)+"%'");
			}
			else if(strOrglevel.equals("D"))
			{
				strAppendQuery.append(" and ORG_CODE like '"+strOrgcode.substring(2,11)+"%'");
			}
			else if(strOrglevel.equals("A"))
			{
				strAppendQuery.append(" and ORG_CODE in ('"+strOrgcode.substring(2,17)+"')");
			}
			else if(strOrglevel.equals("B"))
			{
				strAppendQuery.append(" and ORG_CODE in ('"+strOrgcode.substring(2,17)+"')");
			}
			
			
			if(strPeriod.equalsIgnoreCase(""))
			{
				strPeriod="All";
			}
			if(!(strAmtfrom.equalsIgnoreCase("") && strToamt.equalsIgnoreCase("")))
			{
			strAppendQuery.append("and PRE_AMOUNT between '"+strAmtfrom+"' and '"+strToamt+"'");
			}
			if(!strPeriod.equals("All"))
			{
				strFromdate = strPeriod.substring(0,strPeriod.indexOf("-"));
				strTodate = strPeriod.substring(strPeriod.indexOf("-")+1,strPeriod.length());
				strAppendQuery.append(" and to_date(to_char(f.npa_createddate,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date('"
						+strFromdate+"','dd/mm/yyyy') and to_date('"+strTodate+"','dd/mm/yyyy')");
			}
			
			
			
			strQuery=SQLParser.getSqlQuery("selnpasarfaesireport^"+strAppendQuery.toString());
			
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(correctNull(rs.getString("PRE_AMOUNT")));//0
				arrCol.add(correctNull(rs.getString("sta_npa_sincedate")));//1
				arrCol.add(correctNull(rs.getString("bifr_account")));//2
				arrCol.add(correctNull(rs.getString("ref_date")));//3
				arrCol.add(correctNull(rs.getString("sta_demandnoticedate")));//4
				arrCol.add(correctNull(rs.getString("sta_positionnoticedate")));//5
				//arrCol.add(correctNull(rs.getString("cbsnpa_custname")));//6
				arrCol.add(correctNull(rs.getString("personal_custname")));//6
				arrCol.add(correctNull(rs.getString("pre_accno")));//7
				arrCol.add(correctNull(rs.getString("pre_running_outstand")));//8
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("orgname",hidorgname); 
		}
		catch(Exception ex)
		{
			throw new EJBException("Error in getSarfaesiCases :: "+ex.getMessage());
		}
		finally
		{
			
		}
		return hshRecord;
	}
	
	private HashMap getWriteoff(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		String strOrglevel="";
		String strOrgcode="";
		String strSchemes="";
		String strPeriod="";
		String strAmtfrom="";
		String strToamt="";
		String strFromdate="";
		String strTodate="";
		String strQuery="";
		String hidorgname="";
		String writeofftype="";
		String processstatus="";
		
		StringBuffer strAppendQuery=new StringBuffer();
		
		ResultSet rs=null;
		
		ArrayList arrCol=new ArrayList();
		ArrayList arrRow=new ArrayList();
		try
		{
			
			String strPrint = Helper.correctNull((String)hshValues.get("hidPrint"));
			strOrglevel=correctNull((String)hshValues.get("hidlevel"));
			strAmtfrom=correctNull((String)hshValues.get("hidfromamt"));
			strToamt=correctNull((String)hshValues.get("hidtoamt"));
			strPeriod=correctNull((String)hshValues.get("hidperiod"));
			strOrgcode=correctNull((String)hshValues.get("hidorgcode"));
			strSchemes=correctNull((String)hshValues.get("hidSchemes"));
			hidorgname=correctNull((String)hshValues.get("hidorgname"));
			writeofftype=correctNull((String)hshValues.get("hidwriteofftype"));
			processstatus=correctNull((String)hshValues.get("hidprocessstatus"));
			
			hshRecord.put("strOrglevel", strOrglevel);
			hshRecord.put("strAmtfrom", strAmtfrom);
			hshRecord.put("strToamt", strToamt);
			hshRecord.put("strPeriod", strPeriod);
			hshRecord.put("strOrgcode", strOrgcode);
			hshRecord.put("strSchemes", strSchemes);
			hshRecord.put("hidorgname", hidorgname);
			hshRecord.put("writeofftype", writeofftype);
			hshRecord.put("processstatus", processstatus);
			hshRecord.put("strPrint", strPrint);
			
			if(strOrglevel.equals("C"))
			{	
				strAppendQuery.append(" and ORG_CODE like '"+strOrgcode.substring(2,5)+"%'");
			}
			else if(strOrglevel.equals("R"))
			{
				strAppendQuery.append(" and ORG_CODE like '"+strOrgcode.substring(2,8)+"%'");
			}
			else if(strOrglevel.equals("D"))
			{
				strAppendQuery.append(" and ORG_CODE like '"+strOrgcode.substring(2,11)+"%'");
			}
			else if(strOrglevel.equals("A"))
			{
				strAppendQuery.append(" and ORG_CODE in ('"+strOrgcode.substring(2,17)+"')");
			}
			else if(strOrglevel.equals("B"))
			{
				strAppendQuery.append(" and ORG_CODE in ('"+strOrgcode.substring(2,17)+"')");
			}
			
			
			if(strPeriod.equalsIgnoreCase(""))
			{
				strPeriod="All";
			}
			if(!(strAmtfrom.equalsIgnoreCase("") && strToamt.equalsIgnoreCase("")))
			{
			strAppendQuery.append("and PRE_RUNNING_OUTSTAND between '"+strAmtfrom+"' and '"+strToamt+"'");
			}
			if(!strPeriod.equals("All"))
			{
				strFromdate = strPeriod.substring(0,strPeriod.indexOf("-"));
				strTodate = strPeriod.substring(strPeriod.indexOf("-")+1,strPeriod.length());
				strAppendQuery.append(" and to_date(to_char(npa_createddate,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date('"
						+strFromdate+"','dd/mm/yyyy') and to_date('"+strTodate+"','dd/mm/yyyy')");
			}
			
			
			
			strQuery=SQLParser.getSqlQuery("selnpawriteoffreport^"+"^"+processstatus+"^"+strAppendQuery.toString());
			
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(correctNull(rs.getString("pre_accno")));//0
				//arrCol.add(correctNull(rs.getString("cbsnpa_custname")));//1
				arrCol.add(correctNull(rs.getString("personal_custname")));//1
				arrCol.add("");//2
				arrCol.add(correctNull(rs.getString("PRE_RUNNING_OUTSTAND")));//3
				arrCol.add(correctNull(rs.getString("PRE_TOTAL_DUES")));//4
				arrCol.add(correctNull(rs.getString("PRE_ECGC_CLAIM")));//5
				arrCol.add(correctNull(rs.getString("PRE_EXPENSES")));//6
				arrCol.add(correctNull(rs.getString("PRE_PRODENTIAL")));//7
				arrCol.add(correctNull(rs.getString("PRE_UNRECOVER")));//8
				arrCol.add("");//9
				
				
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("orgname",hidorgname); 
			hshRecord.put("status",processstatus);
		}
		catch(Exception ex)
		{
			throw new EJBException("Error in getWriteoff :: "+ex.getMessage());
		}
		finally
		{
			
		}
		return hshRecord;
	}

	
	private HashMap getCompromiseSettlement(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		String strOrglevel="";
		String strOrgcode="";
		String strSchemes="";
		String strCompromisetype="";
		String strPeriod="";
		String strAmtfrom="";
		String strToamt="";
		String strFromdate="";
		String strTodate="";
		String strQuery="";
		String strorgcodes="";
		
		StringBuffer strAppendQuery=new StringBuffer();
		
		ResultSet rs=null;
		
		ArrayList arrCol=new ArrayList();
		ArrayList arrRow=new ArrayList();
		try
		{
			String strPrint = Helper.correctNull((String)hshValues.get("hidPrint"));
			strOrglevel=correctNull((String)hshValues.get("hidOrgLevel"));
			strSchemes=correctNull((String)hshValues.get("hidSchemes"));
			strAmtfrom=correctNull((String)hshValues.get("txtfromamt"));
			strToamt=correctNull((String)hshValues.get("txttoamt"));
			strPeriod=correctNull((String)hshValues.get("hidPeriod"));
			strOrgcode=correctNull((String)hshValues.get("hidOrgcode"));
			strCompromisetype=correctNull((String)hshValues.get("hidotstype"));
			
			hshRecord.put("strOrglevel",strOrglevel);
			hshRecord.put("strSchemes",strSchemes);
			hshRecord.put("strAmtfrom",strAmtfrom);
			hshRecord.put("strToamt",strToamt);
			hshRecord.put("strPeriod",strPeriod);
			hshRecord.put("strOrgcode",strOrgcode);
			hshRecord.put("strCompromisetype",strCompromisetype);
			hshRecord.put("strPrint",strPrint);
			
			if(strPeriod.equalsIgnoreCase(""))
			{
				strPeriod="All";
			}
			
			strAppendQuery.append("ots.sta_pwoamount between '"+strAmtfrom+"' and '"+strToamt+"'");
			
			if(!strPeriod.equals("All"))
			{
				strFromdate = strPeriod.substring(0,strPeriod.indexOf("-"));
				strTodate = strPeriod.substring(strPeriod.indexOf("-")+1,strPeriod.length());
				strAppendQuery.append(" and to_date(to_char(app.npa_createddate,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date('"
						+strFromdate+"','dd/mm/yyyy') and to_date('"+strTodate+"','dd/mm/yyyy')");
			}
			
			if(strOrglevel.equals("C"))
			{	
				strorgcodes="org.org_code like '"+strOrgcode.substring(2,5)+"%'";
			}
			else if(strOrglevel.equals("R"))
			{
				strorgcodes="org.org_code like '"+strOrgcode.substring(2,8)+"%'";
			}
			else if(strOrglevel.equals("D"))
			{
				strorgcodes="org.org_code like '"+strOrgcode.substring(2,11)+"%'";
			}
			else if(strOrglevel.equals("A"))
			{
				strorgcodes="org.org_code in ('"+strOrgcode.substring(2,17)+"')";
			}
			else if(strOrglevel.equals("B"))
			{
				strorgcodes="org.org_code in ('"+strOrgcode.substring(2,17)+"')";
			}
			
			//strQuery=SQLParser.getSqlQuery("selnpaotsreport^"+strCompromisetype+"^"+strAppendQuery.toString()+"^"+strorgcodes);
			strQuery=SQLParser.getSqlQuery("selnpaotsreport^"+strAppendQuery.toString()+"^"+strorgcodes);
			
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(correctNull(rs.getString("pre_accno")));
				//arrCol.add(correctNull(rs.getString("cbsnpa_custname")));
				arrCol.add(correctNull(rs.getString("personal_custname")));
				arrCol.add(correctNull(rs.getString("sta_pwoamount")));
				arrCol.add(correctNull(rs.getString("sta_totaldues")));
				arrCol.add(correctNull(rs.getString("pre_ecgc_claim")));
				arrCol.add(correctNull(rs.getString("pre_expenses")));
				arrCol.add(correctNull(rs.getString("sta_settleamount")));
				arrCol.add(correctNull(rs.getString("sta_writeoff")));
				arrCol.add(correctNull(rs.getString("sta_waiver")));
				arrCol.add(correctNull(rs.getString("NPA_OTSCOMINMODULEAMT"))+" - "+correctNull(rs.getString("NPA_OTSCOMAXMODULEAMT")));
				//arrCol.add(correctNull(rs.getString("sta_waiver")));
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow",arrRow);
			
		}
		catch(Exception ex)
		{
			throw new EJBException("Error in getLegalcases :: "+ex.getMessage());
		}finally
		{
			
		}
		return hshRecord;
	}
}