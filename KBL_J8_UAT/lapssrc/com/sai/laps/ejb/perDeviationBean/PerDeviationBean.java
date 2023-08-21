package com.sai.laps.ejb.perDeviationBean;

import java.rmi.RemoteException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.concurrent.TimeUnit;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.commworkflow.CommWorkflowBean;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.ConnectionFactory;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.securitymaster.SecurityMasterBean;

@Stateless(name = "PerDeviationBean", mappedName = "PerDeviationHome")
@Remote (PerDeviationRemote.class)
public class PerDeviationBean extends BeanAdapter {
	
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(SecurityMasterBean.class);
public HashMap getPermissionMaster (HashMap hshValues) 
{
		String strQuery="";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arrVal = new ArrayList();
		ArrayList arrRow = new ArrayList();
		ArrayList arrRow2 = new ArrayList();
		String strParent = "";
		try
		{			
			strQuery = SQLParser.getSqlQuery("selPermissionType^0");
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrVal = new ArrayList();
				arrVal.add(correctNull(rs.getString("per_id")));
				arrVal.add(correctNull(rs.getString("per_name")));		
				arrRow.add(arrVal);
			}
			if(rs!=null){
				rs.close();
			}
			strQuery ="";
			strParent =Helper.correctNull((String)hshValues.get("secType"));		
			if(strParent!=null)
			{
				strQuery = SQLParser.getSqlQuery("selPermissionList^0^"+strParent);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrVal = new ArrayList();
					arrVal.add(correctNull(rs.getString("per_id")));
					arrVal.add(correctNull(rs.getString("per_name"))+"~"+correctNull(rs.getString("prd_approval"))+"~"+correctNull(rs.getString("prd_reject"))+"~"+correctNull(rs.getString("PER_ORGAPP"))+"~"+correctNull(rs.getString("PER_ORGREJ"))+"~"+correctNull(rs.getString("PER_TERMSANDCONDID"))+"~"+correctNull(rs.getString("PER_STATUS"))+"~"+correctNull(rs.getString("PER_INTEREST"))+"~"+correctNull(rs.getString("PER_FINANCE"))+"~"+correctNull(rs.getString("per_id")));
					arrVal.add(correctNull(rs.getString("per_name")));
					arrVal.add(correctNull(rs.getString("prd_approval")));
					arrVal.add(correctNull(rs.getString("prd_reject")));
					arrVal.add(correctNull(rs.getString("PER_ORGAPP")));
					arrVal.add(correctNull(rs.getString("PER_ORGREJ")));
					arrVal.add(correctNull(rs.getString("PER_TERMSANDCONDID")));
					arrVal.add(correctNull(rs.getString("PER_STATUS")));
					arrVal.add(correctNull(rs.getString("PER_INTEREST")));
					arrVal.add(correctNull(rs.getString("PER_FINANCE")));

					arrRow2.add(arrVal);
				}
				hshRecord.put("arrRow2",arrRow2);
			}
			hshRecord.put("arrRow",arrRow);
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getPermissionMaster "+ce.toString());
		}
		
		return hshRecord;

}
public HashMap getPermissionClassification (HashMap hshValues) {
	HashMap hshRecord = new HashMap();
	ResultSet rs=null;
	String strsectorType="";
	ArrayList arrCol=new ArrayList();
	ArrayList arrRow=null;
	String strClassification="";
	String strQuery = null;

	try
	{
		strClassification=Helper.correctNull((String)hshValues.get("classificationtype"));
		rs=DBUtils.executeLAPSQuery("selPermissionType^"+strClassification);
		arrRow=new ArrayList();
		while(rs.next())
		{
			arrCol=new ArrayList();
			arrCol.add(Helper.correctNull((String)rs.getString("per_id")));
			arrCol.add(Helper.correctNull((String)rs.getString("per_name")));
			
			arrRow.add(arrCol);
		}
		hshRecord.put("arrRow",arrRow);
		hshRecord.put("strSchemeId",strClassification);
	}
	catch(Exception ce)
	{

		throw new EJBException("Error in getdata "+ce.toString());
	}
	return hshRecord;
	
}

public HashMap getPmayClassification (HashMap hshValues) {
	HashMap hshRecord = new HashMap();
	ResultSet rs=null,rs1=null;
	String strsectorType="";
	ArrayList arrCol=new ArrayList();
	ArrayList arrRow=null;
	String strClassification="";
	String strQuery = null;
	String strFlag="";
	String strAppno="";
	String strsubCat="";
	int val=0;

	try
	{
		strClassification=Helper.correctNull((String)hshValues.get("classificationtype"));
		strFlag=Helper.correctNull((String)hshValues.get("flag"));
		String appno=Helper.correctNull((String)hshValues.get("strappno"));
		
		if(strFlag.equals("y"))
		{
				rs1=DBUtils.executeLAPSQuery("select_Pmay_subcat^"+appno);
				if(rs1.next())
				{
					strsubCat=Helper.correctNull(rs1.getString("PMAY_HOUSE_CAT"));
					
					if(rs!=null)
						rs.close();
					 rs=DBUtils.executeLAPSQuery("select_Pmay_subcat_value^"+strClassification+"^"+strsubCat);
					 arrRow=new ArrayList();
					 arrCol=new ArrayList();
					   if(rs.next())
					   {
						arrCol=new ArrayList();
						arrCol.add(Helper.correctNull((String)rs.getString("PM_SUBCATID")));
						arrCol.add(Helper.correctNull((String)rs.getString("PM_SUBCATEGORY")));
						arrRow.add(arrCol);
					   }
					   
					   if(rs!=null)
							rs.close();
					   rs=DBUtils.executeLAPSQuery("select_Pmay_Active^"+strClassification);
						while(rs.next())
						{
							arrCol=new ArrayList();
							arrCol.add(Helper.correctNull((String)rs.getString("PM_SUBCATID")));
							arrCol.add(Helper.correctNull((String)rs.getString("PM_SUBCATEGORY")));
							arrRow.add(arrCol);
						}
						
					
				}
				else
				{
					rs=DBUtils.executeLAPSQuery("select_Pmay_Active^"+strClassification);
					arrRow=new ArrayList();
					while(rs.next())
					{
						arrCol=new ArrayList();
						arrCol.add(Helper.correctNull((String)rs.getString("PM_SUBCATID")));
						arrCol.add(Helper.correctNull((String)rs.getString("PM_SUBCATEGORY")));
						
						arrRow.add(arrCol);
					}
				}
			   }
			
		  
		
		else
		{
		rs=DBUtils.executeLAPSQuery("select_Pmay^"+strClassification);
		arrRow=new ArrayList();
		while(rs.next())
		{
			arrCol=new ArrayList();
			arrCol.add(Helper.correctNull((String)rs.getString("PM_SUBCATID")));
			arrCol.add(Helper.correctNull((String)rs.getString("PM_SUBCATEGORY")));
			
			arrRow.add(arrCol);
		}
		}
		hshRecord.put("arrRow",arrRow);
		hshRecord.put("strSchemeId",strClassification);
	}
	catch(Exception ce)
	{

		throw new EJBException("Error in getdata "+ce.toString());
	}
	return hshRecord;
	
}

	public void updateFinancial (HashMap hshValues) 
			{
	
			ResultSet rs = null;
			String strQuery="";
			String trmtype="";
			HashMap hshQueryValues = new HashMap();
			HashMap hshQuery = new HashMap();
			ArrayList arrValues = new ArrayList();
			String year1 = "", year2 = "", year3 = "", year4 = "", year5 = "";
			String c1year = "", c2year = "", c3year = "", c4year = "", c5year = "", strDivid = "";
			String strRowCol1 = "", strRowCol2 = "", strRowCol3 = "", strRowCol4 = "", strRowCol5 = "";
			int intUpdatesize = 0;
			String[] id = {"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"};
			String appno = "";
			int idlen= 15;
			String strAction="";
			int intValue = 0;
			String test = Integer.toString(intValue);
			String strAmtType="";
			try{
			appno=Helper.correctNull((String)hshValues.get("appno"));
			strAction=Helper.correctNull((String)hshValues.get("hidAction"));
			if(strAction.equalsIgnoreCase("insert"))
			{
			
			year1 = correctNull((String) hshValues.get("txt_year1"));
			year2 = correctNull((String) hshValues.get("txt_year2"));
			year3 = correctNull((String) hshValues.get("txt_year3"));
			year4 = correctNull((String) hshValues.get("txt_year4"));
			year5 = correctNull((String) hshValues.get("txt_year5"));
			
			c1year = correctNull((String) hshValues.get("combo1"));
			c2year = correctNull((String) hshValues.get("combo2"));
			c3year = correctNull((String) hshValues.get("combo3"));
			c4year = correctNull((String) hshValues.get("combo4"));
			c5year = correctNull((String) hshValues.get("combo5"));
			strAmtType=correctNull((String) hshValues.get("sel_amtType"));
			++intUpdatesize;
			hshQueryValues=new HashMap();
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			arrValues.add(appno);
			hshQuery.put("strQueryId", "delete_data");
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("size", Integer.toString(intUpdatesize));
			hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
			
			++intUpdatesize;
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			arrValues.add(appno);
			hshQuery.put("strQueryId", "del_perm_fin_year");
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
			hshQueryValues.put("size", Integer.toString(intUpdatesize));
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updatedata");
			
			
			intUpdatesize = 0;
			int slno=0;
			
			if(!year1.equals(""))
			{
				++slno;
				++intUpdatesize;
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_perm_finyear");
				arrValues.add(String.valueOf(slno));		
				arrValues.add(appno);
				arrValues.add(c1year);
				arrValues.add(year1);
				arrValues.add(strAmtType);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1",	hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updatedata");
				
			}
			if(!year2.equals(""))
			{
				++slno;
				++intUpdatesize;
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_perm_finyear");
				arrValues.add(String.valueOf(slno));		
				arrValues.add(appno);
				arrValues.add(c2year);
				arrValues.add(year2);
				arrValues.add(strAmtType);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1",	hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updatedata");

			}
			if(!year3.equals(""))
			{
				++slno;
				++intUpdatesize;
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_perm_finyear");
				arrValues.add(String.valueOf(slno));		
				arrValues.add(appno);
				arrValues.add(c3year);
				arrValues.add(year3);
				arrValues.add(strAmtType);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1",	hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updatedata");

			}
			if(!year4.equals(""))
			{
				++slno;
				++intUpdatesize;
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_perm_finyear");
				arrValues.add(String.valueOf(slno));		
				arrValues.add(appno);
				arrValues.add(c4year);
				arrValues.add(year4);
				arrValues.add(strAmtType);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1",	hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updatedata");

			}
			if(!year5.equals(""))
			{
				++slno;
				++intUpdatesize;
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_perm_finyear");
				arrValues.add(String.valueOf(slno));		
				arrValues.add(appno);
				arrValues.add(c5year);
				arrValues.add(year5);
				arrValues.add(strAmtType);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1",	hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updatedata");

			}
			
			 
			 
			for (int i = 1; i <= idlen; i++)
				
			{
				strRowCol1 = Helper.correctDouble((String) hshValues.get("row" + i+ "c1"));
				strRowCol2 = Helper.correctDouble((String) hshValues.get("row" + i+ "c2"));
				strRowCol3 = Helper.correctDouble((String) hshValues.get("row" + i+ "c3"));
				strRowCol4 = Helper.correctDouble((String) hshValues.get("row" + i+ "c4"));
				strRowCol5 = Helper.correctDouble((String) hshValues.get("row" + i+ "c5"));
				
				String strTemp = "";
				String yearselect = "";
				hshQueryValues = new HashMap();
				int sno = 0;
				if (!year1.equals("") && !c1year.trim().equals("")) 
				{
					hshQueryValues = new HashMap();
					strQuery = SQLParser.getSqlQuery("sel_perm_financialYear^"+ appno+'^'+year1+"^"+i);
					if (rs != null) { rs.close(); }
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) 
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize = intUpdatesize + 1;
						if (c1year.trim().equalsIgnoreCase("a")) 
							hshQuery.put("strQueryId", "perm_finappvaluesup1");
						if (c1year.trim().equalsIgnoreCase("u")) 
							hshQuery.put("strQueryId", "perm_finappvaluesup2");
						if (c1year.trim().equalsIgnoreCase("e"))  
							hshQuery.put("strQueryId", "perm_finappvaluesup3");
						if (c1year.trim().equalsIgnoreCase("p"))  
							hshQuery.put("strQueryId", "perm_finappvaluesup4");
							arrValues.add(strRowCol1); 
							arrValues.add(year1);
							arrValues.add(id[i-1]);
							arrValues.add(appno);
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", "1");
							hshQueryValues.put("1",	hshQuery);
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updatedata");
					}
					else
					{
						++sno;
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize = intUpdatesize + 1;
						hshQuery.put("strQueryId", "insert_data");
						arrValues.add(appno);
						arrValues.add(year1);
						arrValues.add(id[i-1]);
						if (c1year.trim().equalsIgnoreCase("a")) {
								arrValues.add(strRowCol1);// get values from
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
						}
						if (c1year.trim().equalsIgnoreCase("u")) {
								arrValues.add(test);
								arrValues.add(strRowCol1);// get values from
								arrValues.add(test);
								arrValues.add(test);
						}
						if (c1year.trim().equalsIgnoreCase("e")) {
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(strRowCol1);// get values from
								arrValues.add(test);
						}
						if (c1year.trim().equalsIgnoreCase("p")) {
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(strRowCol1);// get values from
						}
						arrValues.add(String.valueOf(sno));
						
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("size", "1");
						hshQueryValues.put("1",	hshQuery);
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updatedata");
					}
					
				}
	//year 2
					if (!year2.equals("") && !c2year.trim().equals("")) 
					{
						hshQueryValues = new HashMap();
						if (rs != null) { rs.close(); }
						strQuery = SQLParser.getSqlQuery("sel_perm_financialYear^"+ appno+'^'+year2+"^"+i);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next()) 
						{
							//hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							if (c2year.trim().equalsIgnoreCase("a")) 
								hshQuery.put("strQueryId", "perm_finappvaluesup1");
							if (c2year.trim().equalsIgnoreCase("u")) 
								hshQuery.put("strQueryId", "perm_finappvaluesup2");
							if (c2year.trim().equalsIgnoreCase("e"))  
								hshQuery.put("strQueryId", "perm_finappvaluesup3");
							if (c2year.trim().equalsIgnoreCase("p"))  
								hshQuery.put("strQueryId", "perm_finappvaluesup4");
								arrValues.add(strRowCol2); 
								arrValues.add(year2);
								arrValues.add(id[i-1]);
								arrValues.add(appno);
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", "1");
								hshQueryValues.put("1",	hshQuery);
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updatedata");
						}
						else
						{
							++sno;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "insert_data");
							arrValues.add(appno);
							arrValues.add(year2);
							arrValues.add(id[i-1]);
							if (c2year.trim().equalsIgnoreCase("a")) {
								arrValues.add(strRowCol2);// get values from
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								}
								if (c2year.trim().equalsIgnoreCase("u")) {
										arrValues.add(test);
										arrValues.add(strRowCol2);// get values from
										arrValues.add(test);
										arrValues.add(test);
								}
								if (c2year.trim().equalsIgnoreCase("e")) {
										arrValues.add(test);
										arrValues.add(test);
										arrValues.add(strRowCol2);// get values from
										arrValues.add(test);
								}
								if (c2year.trim().equalsIgnoreCase("p")) {
										arrValues.add(test);
										arrValues.add(test);
										arrValues.add(test);
										arrValues.add(strRowCol2);// get values from
								}
									arrValues.add(String.valueOf(sno));
				
									hshQuery.put("arrValues", arrValues);
									hshQueryValues.put("size", "1");
									hshQueryValues.put("1",	hshQuery);
									EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updatedata");
						}
					}
					
					
		//year 3
					if (!year3.equals("") && !c3year.trim().equals("")) 
					{
						hshQueryValues = new HashMap();
						if (rs != null) { rs.close(); }
						strQuery = SQLParser.getSqlQuery("sel_perm_financialYear^"+ appno+'^'+year3+"^"+i);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next()) 
						{
							//hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							if (c3year.trim().equalsIgnoreCase("a")) 
								hshQuery.put("strQueryId", "perm_finappvaluesup1");
							if (c3year.trim().equalsIgnoreCase("u")) 
								hshQuery.put("strQueryId", "perm_finappvaluesup2");
							if (c3year.trim().equalsIgnoreCase("e"))  
								hshQuery.put("strQueryId", "perm_finappvaluesup3");
							if (c3year.trim().equalsIgnoreCase("p"))  
								hshQuery.put("strQueryId", "perm_finappvaluesup4");
								arrValues.add(strRowCol3); 
								arrValues.add(year3);
								arrValues.add(id[i-1]);
								arrValues.add(appno);
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", "1");
								hshQueryValues.put("1",	hshQuery);
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updatedata");
						}
						else
						{
							++sno;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "insert_data");
							arrValues.add(appno);
							arrValues.add(year3);
							arrValues.add(id[i-1]);
							if (c3year.trim().equalsIgnoreCase("a")) {
								arrValues.add(strRowCol3);// get values from
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								}
								if (c3year.trim().equalsIgnoreCase("u")) {
										arrValues.add(test);
										arrValues.add(strRowCol3);// get values from
										arrValues.add(test);
										arrValues.add(test);
								}
								if (c3year.trim().equalsIgnoreCase("e")) {
										arrValues.add(test);
										arrValues.add(test);
										arrValues.add(strRowCol3);// get values from
										arrValues.add(test);
								}
								if (c3year.trim().equalsIgnoreCase("p")) {
										arrValues.add(test);
										arrValues.add(test);
										arrValues.add(test);
										arrValues.add(strRowCol3);// get values from
								}
									arrValues.add(String.valueOf(sno));
				
									hshQuery.put("arrValues", arrValues);
									hshQueryValues.put("size", "1");
									hshQueryValues.put("1",	hshQuery);
									EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updatedata");
						}
					}
					
					
	//year 4
					if (!year4.equals("") && !c4year.trim().equals("")) 
					{
						hshQueryValues = new HashMap();
						if (rs != null) { rs.close(); }
						strQuery = SQLParser.getSqlQuery("sel_perm_financialYear^"+ appno+'^'+year4+"^"+i);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next()) 
						{
							//hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							if (c4year.trim().equalsIgnoreCase("a")) 
								hshQuery.put("strQueryId", "perm_finappvaluesup1");
							if (c4year.trim().equalsIgnoreCase("u")) 
								hshQuery.put("strQueryId", "perm_finappvaluesup2");
							if (c4year.trim().equalsIgnoreCase("e"))  
								hshQuery.put("strQueryId", "perm_finappvaluesup3");
							if (c4year.trim().equalsIgnoreCase("p"))  
								hshQuery.put("strQueryId", "perm_finappvaluesup4");
								arrValues.add(strRowCol4); 
								arrValues.add(year4);
								arrValues.add(id[i-1]);
								arrValues.add(appno);
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", "1");
								hshQueryValues.put("1",	hshQuery);
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updatedata");
						}
						else
						{
							++sno;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "insert_data");
							arrValues.add(appno);
							arrValues.add(year4);
							arrValues.add(id[i-1]);
							if (c4year.trim().equalsIgnoreCase("a")) {
								arrValues.add(strRowCol4);// get values from
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								}
								if (c4year.trim().equalsIgnoreCase("u")) {
										arrValues.add(test);
										arrValues.add(strRowCol4);// get values from
										arrValues.add(test);
										arrValues.add(test);
								}
								if (c4year.trim().equalsIgnoreCase("e")) {
										arrValues.add(test);
										arrValues.add(test);
										arrValues.add(strRowCol4);// get values from
										arrValues.add(test);
								}
								if (c4year.trim().equalsIgnoreCase("p")) {
										arrValues.add(test);
										arrValues.add(test);
										arrValues.add(test);
										arrValues.add(strRowCol4);// get values from
								}
									arrValues.add(String.valueOf(sno));
				
									hshQuery.put("arrValues", arrValues);
									hshQueryValues.put("size", "1");
									hshQueryValues.put("1",	hshQuery);
									EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updatedata");
						}
					}
					
					
//year 5
					if (!year5.equals("") && !c5year.trim().equals(""))
					{
						hshQueryValues = new HashMap();
						if (rs != null) { rs.close(); }
						strQuery = SQLParser.getSqlQuery("sel_perm_financialYear^"+ appno+'^'+year5+"^"+i);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next()) 
						{
							//hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							if (c5year.trim().equalsIgnoreCase("a")) 
								hshQuery.put("strQueryId", "perm_finappvaluesup1");
							if (c5year.trim().equalsIgnoreCase("u")) 
								hshQuery.put("strQueryId", "perm_finappvaluesup2");
							if (c5year.trim().equalsIgnoreCase("e"))  
								hshQuery.put("strQueryId", "perm_finappvaluesup3");
							if (c5year.trim().equalsIgnoreCase("p"))  
								hshQuery.put("strQueryId", "perm_finappvaluesup4");
								arrValues.add(strRowCol5); 
								arrValues.add(year5);
								arrValues.add(id[i-1]);
								arrValues.add(appno);
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", "1");
								hshQueryValues.put("1",	hshQuery);
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updatedata");
						}
						else
						{
							++sno;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "insert_data");
							arrValues.add(appno);
							arrValues.add(year5);
							arrValues.add(id[i-1]);
							if (c5year.trim().equalsIgnoreCase("a")) {
								arrValues.add(strRowCol5);// get values from
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								}
								if (c5year.trim().equalsIgnoreCase("u")) {
										arrValues.add(test);
										arrValues.add(strRowCol5);// get values from
										arrValues.add(test);
										arrValues.add(test);
								}
								if (c5year.trim().equalsIgnoreCase("e")) {
										arrValues.add(test);
										arrValues.add(test);
										arrValues.add(strRowCol5);// get values from
										arrValues.add(test);
								}
								if (c5year.trim().equalsIgnoreCase("p")) {
										arrValues.add(test);
										arrValues.add(test);
										arrValues.add(test);
										arrValues.add(strRowCol5);// get values from
								}
									arrValues.add(String.valueOf(sno));
				
									hshQuery.put("arrValues", arrValues);
									hshQueryValues.put("size", "1");
									hshQueryValues.put("1",	hshQuery);
									EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updatedata");
						}
					}
					
				
					
			}////end main for loop
			
//			if(intUpdatesize>1)
//				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
					
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				hshQuery.put("strQueryId", "delete_data");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				hshQuery.put("strQueryId", "del_perm_fin_year");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				hshQueryValues.put("size", "2");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updatedata");
			}
				
	
			} catch (Exception e) {
				// TODO Auto-generated catch block
				throw new EJBException("Exception in updateFinancial Method==="+e.getMessage());
			}
}
	
	
	
	public void UpdateTerms(HashMap hshValues)
	{
		boolean boolterms = false;		 
		ResultSet rs=null;
		ResultSet rs1=null;
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = null;
		
		String strAppno="";
		String[] strtermscode=null;
		String[] strTermId=null;
		String[] strtermText=null;
		String[] strselectTermsType=null;
		String actionType = (String)hshValues.get("hidAction");
		StringBuilder sbOldAudit=new StringBuilder();
		String strQuery="";
		int maxsno =0;
		try
		{
			strAppno=Helper.correctNull((String)hshValues.get("appno"));
			if(actionType.equals("insert"))
			{
				rs = DBUtils.executeLAPSQuery("perm_maxtermscond^"+strAppno);
				if(rs.next()){
					maxsno = rs.getInt("snomax");
				}
				hshQueryValues.put("size","1");
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","perm_app_terms_condins1");
				arrValues=new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(String.valueOf(maxsno));
				arrValues.add((String)hshValues.get("txttrmdesc"));
				arrValues.add("N");
				arrValues.add("A");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
			
			}else if(actionType.equals("update"))
			{
				String termid = (String)hshValues.get("hidsno");
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","perm_app_terms_cond_upd");
				arrValues.add((String)hshValues.get("txttrmdesc"));
				arrValues.add(strAppno);
				arrValues.add(termid);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
			
			
			}else if(actionType.equals("delete"))
			{
				String termremarks = (String)hshValues.get("hidcomments");
				String termid = (String)hshValues.get("hidsno");
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","perm_app_terms_cond_del1");
				arrValues.add("Y");
				arrValues.add(termremarks);
				arrValues.add(strAppno);
				arrValues.add(termid);
					
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
			
			}else if(actionType.equals("Print"))
			{
				String strTermID[]=null,strTermPrint[]=null;
				
				
				if(hshValues.get("hidsno1") instanceof java.lang.String)
				{
					strTermID= new String[1];
					strTermID[0]=(String)hshValues.get("hidsno1");
				}
				else
				{
					strTermID=(String[])hshValues.get("hidsno1");
				}
				if(hshValues.get("txt_print") instanceof java.lang.String)
				{
					strTermPrint= new String[1];
					strTermPrint[0]=(String)hshValues.get("txt_print");
				}
				else
				{
					strTermPrint=(String[])hshValues.get("txt_print");
				}
				
				for(int i=0;i<strTermID.length;i++)
				{
					String termid = (String)hshValues.get("hidtermid");
					hshQueryValues.put("size",String.valueOf(i+1));
					hshQuery=new HashMap();
					hshQuery.put("strQueryId","perm_upd_app_terms_cond_print");
					arrValues=new ArrayList();
					arrValues.add(strTermPrint[i]);
					arrValues.add(strAppno);
					arrValues.add(strTermID[i]);
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(i+1),hshQuery);
				}
			}
			
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
		}
	}
	
	public HashMap getTerms(HashMap hshValues)
	{
		ResultSet rs = null;
		
		HashMap hshResult=new HashMap();
		HashMap hshRecord=new HashMap();
		ArrayList vecRow = new ArrayList();
		String strAppno="";
		
		String strQuery="";
		String trmtype="";
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		
		try
		{ 
			strAppno=Helper.correctNull((String)hshValues.get("appno"));
			    strQuery = SQLParser.getSqlQuery("perm_app_terms_cond_sel_2^"+strAppno);
				
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(Helper.correctNull((String)rs.getString("PERM_TERMID")));
					arrCol.add(Helper.correctNull((String)rs.getString("PERM_TERMSCONTENT")));
					arrCol.add(Helper.correctNull((String)rs.getString("PERM_TERMPRINT")));
					arrCol.add(Helper.correctNull((String)rs.getString("PERM_TERMSTYPE")));
					arrRow.add(arrCol);
				}
			
				

				hshRecord.put("arrRow",arrRow);
		
		}catch(Exception e)
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
	
	public HashMap getDeletedTerms(HashMap hshRequestValues) 
	{
		
		ResultSet rs = null;
		ArrayList arrTerms=new ArrayList();
		ArrayList arrTermsComments=new ArrayList();
		ArrayList arrTermId = new ArrayList();
		ArrayList arrTermType = new ArrayList();
		HashMap hshRecord = new HashMap();
		String strQuery="";
		String strAppno = "";
		String strtermdel="y";
		String strAction = correctNull((String)hshRequestValues.get("hidAction"));
		try
		{	
			strAppno=Helper.correctNull((String)hshRequestValues.get("appno"));
			hshRecord = new HashMap();
		    rs=DBUtils.executeLAPSQuery("perm_deleted_app_terms_cond^"+strAppno);
		    
			while (rs.next())
			{  
				arrTerms.add(correctNull(rs.getString(1)));
				arrTermsComments.add(correctNull(rs.getString(2)));
				arrTermId.add(correctNull(rs.getString(3)));
				
			}				
			hshRecord.put("arrTerms",arrTerms);
			hshRecord.put("arrTermsComments",arrTermsComments);
			hshRecord.put("arrTermId",arrTermId);
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getDeletedTerms==="+ce.toString());
		}finally
		{
			try
			{
				if(rs!=null)
					rs.close();
			}catch(Exception exp)
			{
				throw new EJBException("Error in closing the connection in getDeletedTerms "+ exp.toString()); 
			}
		}
		return hshRecord;
		
	}
	
	
	public void UndeleteTermsData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		
		String strAction = correctNull((String)hshValues.get("hidAction"));
		String strAppno="",strTermId="";
		
		try{
			strAppno=Helper.correctNull((String)hshValues.get("appno"));
			strTermId = correctNull((String)hshValues.get("rdtermid"));
			
			hshQueryValues.put("size","1");
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			
			if(strAction.equals("undelete"))
			{
				hshQuery.put("strQueryId","perm_undelete_terms1");
				arrValues.add(strTermId);
				arrValues.add(strAppno);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
		}catch(Exception ex)
		{
			throw new EJBException(ex.toString());
		}
	}
	
	public HashMap getdataFinancial (HashMap hshValues) 
	{
		ResultSet rs = null;
		String strQuery="",strQuery1= "";
		String appno="";
		
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		try
		{
			
			appno=correctNull((String)hshValues.get("appno"));
			String strAmntVal = Helper.correctNull((String) hshValues.get("strAmntVal"));
			
			for(int i=1;i<=15;i++)
			{
				int col=1;
				strQuery= SQLParser.getSqlQuery("sel_permfinancial^"+appno+"^"+i);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					String PERM_FIN_FINTYPE=Helper.correctNull((String)rs.getString("PERM_FIN_FINTYPE"));
					if(PERM_FIN_FINTYPE.equals("a"))
						hshValues.put("hsh_row"+i+"c"+col, Helper.converAmount(jtn.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("FIN_AUDIT")))),strAmntVal ));
					else if(PERM_FIN_FINTYPE.equals("u"))
						hshValues.put("hsh_row"+i+"c"+col, Helper.converAmount(jtn.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("FIN_UNAUDIT")))),strAmntVal ));
					else if(PERM_FIN_FINTYPE.equals("e"))
						hshValues.put("hsh_row"+i+"c"+col, Helper.converAmount(jtn.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("FIN_ESTIMATED")))),strAmntVal ));
					else if(PERM_FIN_FINTYPE.equals("p"))
						hshValues.put("hsh_row"+i+"c"+col, Helper.converAmount(jtn.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("FIN_PROJECTION")))),strAmntVal ));
					
					
					col++;
				}
			}
			
			String[] rowdesc = {"Capital","Networth","Sales/Turnover","Sundry Creditors","Sundry Debtors","Tangible Networth","TOL:TNW","Debt:Equity","Current Assets","Current Liabilities","Net Working Capital","Current Ratio","Net Profit after tax/ (Net loss)","Depreciation","Cash Loss if any (Net Loss+Depr)"};
			for (int j = 1; j <= rowdesc.length; j++)
			{
				hshValues.put("hsh_row"+j+"c0", rowdesc[j-1]);
			}	
			if(rs!=null)
			{
				rs.close();
			}
			int yearsno=1;
			strQuery= SQLParser.getSqlQuery("sel_perm_finyear^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshValues.put("txt_year"+yearsno, Helper.correctNull(rs.getString("PERM_FIN_FINYEAR")));
				hshValues.put("combo"+yearsno, Helper.correctNull(rs.getString("PERM_FIN_FINTYPE")));
				hshValues.put("PERM_AMTTYPE",Helper.correctNull(rs.getString("PERM_AMTTYPE")));
				
				yearsno++;
			}
			hshValues.put("yearno",String.valueOf(yearsno-1));
			
			strQuery= SQLParser.getSqlQuery("sel_perm_fin^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("Financial_Exist","Y");
			}
		}
		
		catch(Exception e)
		{
			throw new EJBException("Error in getdataFinancial "+e.getMessage());
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
		return hshValues;
	}
	
	public HashMap updatePermissionMaster(HashMap hshValues) {
		HashMap hshRecord = new HashMap();
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		int maxsno =0;
		String strAction =null;
		String strPerType =null;
		String strParent="";
		ResultSet rs = null;
		String strSno="";
		String strminclass="";
		String strminskip="";
		String strorgApp="";
		String strorgRej="";
		String strTerm_Con="";
		String str_status="";
		String str_interest="";
		String str_financial="";
		
		
		try{
			
			strAction = Helper.correctNull((String)hshValues.get("hidAction"));
			strPerType= Helper.correctNull((String)hshValues.get("txt_details"));
			//strParent =(String)request.getParameter("sel_classification");//

			strParent =Helper.correctNull((String)hshValues.get("sel_classification"));//
			strminclass=correctNull((String) hshValues.get("prd_approval"));
			strminskip=correctNull((String) hshValues.get("prd_skip"));
			strorgApp=correctNull((String) hshValues.get("sel_orgapp"));
			strorgRej=correctNull((String) hshValues.get("sel_orgrej"));
			strTerm_Con=correctNull((String) hshValues.get("sel_termid"));
			str_status=correctNull((String) hshValues.get("sel_status"));
			str_interest=correctNull((String) hshValues.get("sel_interest"));
			str_financial=correctNull((String) hshValues.get("sel_financial"));

			
			if (strAction.equalsIgnoreCase("insert"))
			{				
				rs = DBUtils.executeLAPSQuery("selmaxpermission");
				if(rs.next()){
					maxsno = rs.getInt("snomax");
				}
				arrValues = new ArrayList();
				hshQuery = new HashMap();
										
				arrValues.add(String.valueOf(maxsno));
				arrValues.add(strPerType);
				arrValues.add(strParent);
				arrValues.add(strminclass);
				arrValues.add(strminskip);
				arrValues.add(strorgApp);
				arrValues.add(strorgRej);
				arrValues.add(strTerm_Con);
				arrValues.add(str_status);
				arrValues.add(str_interest);
				arrValues.add(str_financial);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","insPermission");
				hshQueryValues.put("size","1");					
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}

						
			if (strAction.equalsIgnoreCase("update")){
				
				strSno = Helper.correctNull((String)hshValues.get("hidsno"));
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(strPerType);
				arrValues.add(strParent);
				arrValues.add(strminclass);
				arrValues.add(strminskip);
				arrValues.add(strorgApp);
				arrValues.add(strorgRej);
				arrValues.add(strTerm_Con);
				arrValues.add(str_status);
				arrValues.add(str_interest);
				arrValues.add(str_financial);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","updPermissionList");
				hshQueryValues.put("size","1");					
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}
			
			if (strAction.equalsIgnoreCase("delete")){
				
				strSno = Helper.correctNull((String)hshValues.get("hidsno"));
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","delPermissionList");
				hshQueryValues.put("size","1");					
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}
			hshRecord=getPermissionMaster(hshValues);

		}
		catch(Exception ce){
			log.error(ce.toString());
 			throw new EJBException("Error in updatePermissionMaster "+ce.toString());
		}
		return hshRecord;
		
	}
	public HashMap getSancAuthority(HashMap hshValues) 
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery="";
		
		String strValue=Helper.correctNull((String)hshValues.get("sancdept"));
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		try
		{
			if(strValue.equalsIgnoreCase("006"))
				strValue="RO";
			else if(strValue.equalsIgnoreCase("007"))
				strValue="Branch";
			else if(strValue.equalsIgnoreCase("008"))
				strValue="HEAD','LCFD";
			else if(strValue.equalsIgnoreCase("010"))
				strValue="HEAD','RFD";
			else if(strValue.equalsIgnoreCase("011"))
				strValue="CPC";
			else if(strValue.equalsIgnoreCase("012"))
				strValue="CLPH";
			
			strQuery=SQLParser.getSqlQuery("sel_sanauthoritycode^15^"+strValue);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(correctNull(rs.getString("cbs_static_data_code")));
				arrCol.add(correctNull(rs.getString("cbs_static_data_desc")));
				arrRow.add(arrCol);
			}
			hshResult.put("arrRow",arrRow);
			hshResult.put("strSancAuth",Helper.correctNull((String)hshValues.get("sancauth")));
		}
		catch(Exception e)
		{
			log.error("error occured in getSancAuthority===="+e.toString());
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
				log.error("error occured in getSancAuthority===="+e1.toString());
			}
		}
		return hshResult;
		
	}
	
    public void updateAssessmentMaster(HashMap hshValues) 
    {
    	HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();;
		ArrayList arrValues=new ArrayList();
		String strAction="",strQuery="";
		int maxid=0;
		int maxnmbr=0;
		ResultSet rs=null;
		try
		{	
			strAction=Helper.correctNull((String)hshValues.get("hidAction"));
			if(strAction.equalsIgnoreCase("insert"))
			{
				rs = DBUtils.executeLAPSQuery("selmaxgeneral");
				if(rs.next()){
					maxid = rs.getInt("snomax");
				}
				
			int intquery=0; 
			++intquery;
			hshQueryValues = new HashMap();
    		hshQuery = new HashMap();;
    		arrValues=new ArrayList();
    		arrValues.add(String.valueOf(maxid));
    		arrValues.add(Helper.correctNull((String)hshValues.get("txt_description")));
    		arrValues.add(Helper.correctNull((String)hshValues.get("txt_value")));
    		arrValues.add(Helper.correctNull((String)hshValues.get("sel_asstype")));
    		hshQuery.put("strQueryId", "ins_generalassess");
    		hshQuery.put("arrValues", arrValues);
    		hshQueryValues.put(String.valueOf(intquery), hshQuery);
    		hshQueryValues.put("size", String.valueOf(intquery));
    		
    		if(Helper.correctNull((String)hshValues.get("sel_asstype")).equalsIgnoreCase("R"))
    		{
    			String[] strRange=null; 
    			String[] strMaxScore=null; 
    			
    			if(hshValues.get("txt_range") instanceof java.lang.String)
    			{
    				strRange= new String[1];
    				strRange[0]=(String)hshValues.get("txt_range");
    			}else{
    				strRange=(String[])hshValues.get("txt_range");
    			}
    			if(hshValues.get("txt_value1") instanceof java.lang.String)
    			{
    				strMaxScore= new String[1];
    				strMaxScore[0]=(String)hshValues.get("txt_value1");
    			}else{
    				strMaxScore=(String[])hshValues.get("txt_value1");
    			}
    			
    			
    			for(int i=0;i<strRange.length;i++)
				{
    				++intquery;
    	    		hshQuery = new HashMap();;
    	    		arrValues=new ArrayList();
    	    		arrValues.add(String.valueOf(maxid));
    	    		arrValues.add(String.valueOf(i+1));
    	    		arrValues.add(strRange[i]);
    	    		arrValues.add(strMaxScore[i]);
    	    		hshQuery.put("strQueryId", "ins_generalassess_param");
    	    		hshQuery.put("arrValues", arrValues);
    	    		hshQueryValues.put(String.valueOf(intquery), hshQuery);
    	    		hshQueryValues.put("size", String.valueOf(intquery));
				}
    		}
    		
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		else if(strAction.equals("update"))
		{
			int intquery=0; 
			++intquery;
			hshQueryValues = new HashMap();
    		hshQuery = new HashMap();;
    		arrValues=new ArrayList();
    		arrValues.add(Helper.correctNull((String)hshValues.get("txt_value")));
    		arrValues.add(Helper.correctNull((String)hshValues.get("sel_assessment")));
    		hshQuery.put("strQueryId", "upd_perm_assessment_master");
    		hshQuery.put("arrValues", arrValues);
    		hshQueryValues.put(String.valueOf(intquery), hshQuery);
    		hshQueryValues.put("size", String.valueOf(intquery));
    		
    		if(Helper.correctNull((String)hshValues.get("sel_asstype")).equalsIgnoreCase("R"))
    		{
    			String[] strRange=null; 
    			String[] strMaxScore=null; 
    			
    			if(hshValues.get("txt_range") instanceof java.lang.String)
    			{
    				strRange= new String[1];
    				strRange[0]=(String)hshValues.get("txt_range");
    			}else{
    				strRange=(String[])hshValues.get("txt_range");
    			}
    			if(hshValues.get("txt_value1") instanceof java.lang.String)
    			{
    				strMaxScore= new String[1];
    				strMaxScore[0]=(String)hshValues.get("txt_value1");
    			}else{
    				strMaxScore=(String[])hshValues.get("txt_value1");
    			}
    			
    			++intquery;
	    		hshQuery = new HashMap();;
	    		arrValues=new ArrayList();
	    		arrValues.add(Helper.correctNull((String)hshValues.get("sel_assessment")));
	    		hshQuery.put("strQueryId", "del_perm_assessment_rangeparam");
	    		hshQuery.put("arrValues", arrValues);
	    		hshQueryValues.put(String.valueOf(intquery), hshQuery);
	    		hshQueryValues.put("size", String.valueOf(intquery));
    			
    			for(int i=0;i<strRange.length;i++)
				{
    				++intquery;
    	    		hshQuery = new HashMap();;
    	    		arrValues=new ArrayList();
    	    		arrValues.add(Helper.correctNull((String)hshValues.get("sel_assessment")));
    	    		arrValues.add(String.valueOf(i+1));
    	    		arrValues.add(strRange[i]);
    	    		arrValues.add(strMaxScore[i]);
    	    		hshQuery.put("strQueryId", "ins_generalassess_param");
    	    		hshQuery.put("arrValues", arrValues);
    	    		hshQueryValues.put(String.valueOf(intquery), hshQuery);
    	    		hshQueryValues.put("size", String.valueOf(intquery));
				}
    		}
    		
    		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		else if(strAction.equals("delete"))
		{
			int intquery=0; 
			++intquery;
    		hshQuery = new HashMap();;
    		arrValues=new ArrayList();
    		arrValues.add(Helper.correctNull((String)hshValues.get("sel_assessment")));
			if(Helper.correctNull((String)hshValues.get("hidsubtype")).equalsIgnoreCase("V"))
				hshQuery.put("strQueryId", "del_perm_assessment_value");
			else
				hshQuery.put("strQueryId", "del_perm_assessment_rangeparam");
			hshQuery.put("arrValues", arrValues);
    		hshQueryValues.put(String.valueOf(intquery), hshQuery);
    		hshQueryValues.put("size", String.valueOf(intquery));
    		if(Helper.correctNull((String)hshValues.get("hidsubtype")).equalsIgnoreCase("R"))
    		{
    			++intquery;
        		hshQuery = new HashMap();;
        		arrValues=new ArrayList();
        		arrValues.add(Helper.correctNull((String)hshValues.get("sel_assessment")));
        		hshQuery.put("strQueryId", "del_perm_assessment_value");
        		hshQuery.put("arrValues", arrValues);
        		hshQueryValues.put(String.valueOf(intquery), hshQuery);
        		hshQueryValues.put("size", String.valueOf(intquery));
    		}
    		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
				

		}
		catch(Exception ce)
		{
			throw new EJBException("Exception caught in updateAssessmentMaster====="+ce.toString());
		}
		finally{
			hshQueryValues=null;
			arrValues=null;
			hshQuery=null;
		}
    }
  
    public HashMap getAssessmentMaster(HashMap hshValues)  
    {
    	HashMap hshRecord = new HashMap();
    	ResultSet rs=null,rs1=null;
    	String strQuery = null;
    	ArrayList arrRow=new ArrayList();
    	ArrayList arrCol=new ArrayList();
    	

    	try
    	{
    		rs=DBUtils.executeLAPSQuery("select_PERM_ASSESSMENT_master^"+Helper.correctNull((String)hshValues.get("sel_assessment")));
    		if(rs.next())
    		{
    			hshRecord.put("PERM_TYPE_ASSESSMENT", Helper.correctNull(rs.getString("PERM_TYPE_ASSESSMENT")));
    			hshRecord.put("PERM_TYPE_ID", Helper.correctNull(rs.getString("PERM_TYPE_ID")));
    			hshRecord.put("PERM_TYPE_VALUE", Helper.correctNull(rs.getString("PERM_TYPE_VALUE")));
    			
    			if(Helper.correctNull(rs.getString("PERM_TYPE_ASSESSMENT")).equalsIgnoreCase("R"))
    			{
	    			rs1=DBUtils.executeLAPSQuery("sel_perm_assessment_rangeparam^"+Helper.correctNull(rs.getString("PERM_TYPE_ID")));
	    			while(rs1.next())
	    			{
	    				arrCol=new ArrayList();
	    				arrCol.add(Helper.correctNull(rs1.getString("PERM_SNO")));
	    				arrCol.add(Helper.correctNull(rs1.getString("PERM_RANGE")));
	    				arrCol.add(Helper.correctNull(rs1.getString("PERM_MAXVALUE")));
	    				arrRow.add(arrCol);
	    			}
	    			
	    			hshRecord.put("arrRow", arrRow);
    			}
    		}
    	}
    	catch(Exception ce)
    	{
    	
    		throw new EJBException("Error in getAssessmentMaster "+ce.toString());
    	}
    	
    	return hshRecord;
    
    }
    
    
    
    
    
    
	public HashMap getPermissiontypeData (HashMap hshValues) 
	{

		String strQuery="",strQuery1= "";
		String absPosition="";
		ResultSet rs=null;
		ResultSet rs1=null;
		HashMap hshResult=new HashMap();
		ArrayList arryRow=new ArrayList();
		ArrayList arryCol=null;
		String strpermType=correctNull((String)hshValues.get("permtype"));
		String pagefrom=correctNull((String)hshValues.get("pagefrom"));
		String devsubtype=correctNull((String)hshValues.get("devsubtype"));
		ArrayList arrCol=new ArrayList();
		ArrayList arrRow=null;
		try
		{
				if(rs!=null)
				{
					rs.close();
				}
				if(pagefrom.equals("permParam1"))
				{
					strQuery= SQLParser.getSqlQuery("sel_permMaster^"+strpermType);
				}
				else if(pagefrom.equals("permParam2"))
				{
					strQuery= SQLParser.getSqlQuery("sel_permMaster_enable^"+devsubtype);
				}
				rs=DBUtils.executeQuery(strQuery);
				arrRow=new ArrayList();
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(Helper.correctNull((String)rs.getString("PER_ID")));
					arrCol.add(Helper.correctNull((String)rs.getString("PER_NAME")));
					arrCol.add(Helper.correctNull((String)rs.getString("PER_INTEREST")));
					arrCol.add(Helper.correctNull((String)rs.getString("PER_FINANCE")));
					arrRow.add(arrCol);
				}
				hshValues.put("arrRow",arrRow);
				hshValues.put("btnenable","E");
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getPermissiontypeData "+e.getMessage());
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
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		
		return hshValues;
	} 
	
	
   public void updateAssessment(HashMap hshValues) {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ArrayList arrValues1 = new ArrayList();
		ArrayList arrValues2 = new ArrayList();
		int maxsno =0,totalcount=0;
		String strPerType =null;
		String strParent="";
		ResultSet rs = null;
		String strAppno="",strAction="";
		String[] strID=null,strAssessType=null,strMark=null,strBRScore=null,strHOScore=null,interest=null,duedate=null,arrears=null,strName=null,strCategory=null;

		try{ 
			strAppno=Helper.correctNull((String)hshValues.get("appno"));
			strAction=Helper.correctNull((String)hshValues.get("hidAction"));
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				int intsize=0;
				++intsize;
				hshQuery=new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_perm_assessment");
				hshQueryValues.put("size",String.valueOf(intsize));					
				hshQueryValues.put(String.valueOf(intsize),hshQuery);
				
				if(hshValues.get("txt_id") instanceof String[])
				{
					strID=(String[])hshValues.get("txt_id");
					strAssessType=(String[])hshValues.get("sel_asstype1");
					strMark=(String[])hshValues.get("txt_mark");
					strBRScore=(String[])hshValues.get("txt_branchvalue");
					strHOScore=(String[])hshValues.get("txt_hovalue");
	
					for(int i=0;i<strID.length;i++)
					{
						++intsize;
						hshQuery=new HashMap();
						arrValues = new ArrayList();
						arrValues.add(strAppno);
						arrValues.add(strID[i]);
						arrValues.add(strAssessType[i]);
						arrValues.add(strMark[i]);
						arrValues.add(strBRScore[i]);
						arrValues.add(strHOScore[i]);
						arrValues.add(String.valueOf(i+1));
						hshQuery.put("arrValues",arrValues);
						hshQuery.put("strQueryId","ins_perm_assessment");
						hshQueryValues.put("size",String.valueOf(intsize));					
						hshQueryValues.put(String.valueOf(intsize),hshQuery);
	
					}
				}
				else if(!Helper.correctNull((String)hshValues.get("txt_id")).equalsIgnoreCase(""))
				{
					++intsize;
					hshQuery=new HashMap();
					arrValues = new ArrayList();
					arrValues.add(strAppno);
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_id")));
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_asstype1")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_mark")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_branchvalue")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_hovalue")));
					arrValues.add("1");
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","ins_perm_assessment");
					hshQueryValues.put("size",String.valueOf(intsize));					
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
				}
				
				if(intsize>0)
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_perm_assessment");
				hshQueryValues.put("size","1");					
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}
			

		}
		catch(Exception ce){
			log.error(ce.toString());
				throw new EJBException("Error in updateassessment "+ce.toString());
		}
		
	}
   public HashMap getAssessment(HashMap hshValues) {
	   
	HashMap hshRecord = new HashMap();
   	ResultSet rs=null;
   	String strQuery = null;
   	ArrayList arrRow=new ArrayList();
   	ArrayList arrCol=new ArrayList();
   	String strAppno="";
   	try
   	{	
   		strAppno=Helper.correctNull((String)hshValues.get("appno"));
   		strQuery= SQLParser.getSqlQuery("select_PERM_ASSESSMENT_master11^"+strAppno);
		rs=DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			arrCol=new ArrayList();
			arrCol.add(Helper.correctNull(rs.getString("PERM_TYPE_DESCRIPTION")));//0
			arrCol.add(Helper.correctNull(rs.getString("PERM_TYPE_VALUE")));//1
			arrCol.add(Helper.correctNull(rs.getString("PERM_TYPE_ASSESSMENT")));//2
			arrCol.add(Helper.correctNull(rs.getString("PERM_TYPE_ID")));//3
			arrCol.add(Helper.correctNull(rs.getString("PERM_BRANCH_VALUE")));//4
			arrCol.add(Helper.correctNull(rs.getString("PERM_HO_VALUE")));//5
			arrCol.add(Helper.correctNull(rs.getString("PERM_MAXMARKS")));//6
			arrCol.add(Helper.correctNull(rs.getString("perm_sub_description")));//7
			arrRow.add(arrCol);
		}
		
		hshValues.put("arrRow", arrRow);
		
		if(rs!=null)
		{
			rs.close();
		}
		rs=DBUtils.executeLAPSQuery("sel_per_Assessment^"+ strAppno);
		if(rs.next())	
			hshValues.put("ApplicationExist_Mstr","Y");
		else
			hshValues.put("ApplicationExist_Mstr","N");	
   
   			
   	}
   	catch(Exception ce)
   	{
   	
   		throw new EJBException("Error in getdata "+ce.toString());
   	}
   	
   	return hshValues;
	   
   }
	
		
	public HashMap updatePermissionData(HashMap hshValues) 
	{
		ResultSet rs=null,rs1=null;
		HashMap hshqueryval =new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshResult = new HashMap();
		ArrayList arrValues = new ArrayList();
		int strsno=0;

		  String  strAction="",strUserid="";
		  strAction=correctNull((String)hshValues.get("hidAction"));
		  strUserid=correctNull((String)hshValues.get("strUserId"));
		  String OrgCode="",Strappno="",StrAppno="",str_constitution="",strmanagDet="",strOtherbank="";
		  String str_cbscustid=Helper.correctNull((String)hshValues.get("txt_cbscustid"));
		try
		{
			StrAppno=correctNull((String)hshValues.get("hidAppno"));
		  	hshqueryval = new HashMap();
			hshquery = new HashMap();		
			arrValues=new ArrayList();
				
		   if(strAction.equalsIgnoreCase("new") && StrAppno.equalsIgnoreCase(""))
		   {
				OrgCode=Helper.correctNull((String)hshValues.get("strOrgShortCode"));
				int scodeLength=OrgCode.length();
				if(scodeLength==1){
					OrgCode="000"+OrgCode;
				}
				if(scodeLength==2){
					OrgCode="00"+OrgCode;
				}
				if(scodeLength==3){
					OrgCode="0"+OrgCode;
				}
				
				rs=DBUtils.executeLAPSQuery("sel_maxid_addDeviationdetails^"+OrgCode);
				if(rs.next())
				{
					strsno=Integer.parseInt(rs.getString("DEV_APPNO"));
					
					java.text.NumberFormat nf=java.text.NumberFormat.getNumberInstance();
					nf.setMinimumIntegerDigits(6);
					nf.setGroupingUsed(false);
					Strappno=nf.format(strsno);
					
					StrAppno=OrgCode+"D"+Strappno;
				}
			
			
				hshquery=new HashMap();
				arrValues=new ArrayList();
				hshquery.put("strQueryId","ins_appl_deviaton");
				arrValues.add(StrAppno);
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_perm_type")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_devSubType")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_cus_available")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_cbscustid")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hidParameter")));
				arrValues.add(strUserid);
				arrValues.add(Helper.correctNull((String)hshValues.get("strOrgShortCode")));
				arrValues.add("op");
				arrValues.add(strUserid);
				hshquery.put("arrValues",arrValues);
				hshqueryval.put("1",hshquery);
				hshqueryval.put("size","1");
				
				if(!Helper.correctNull((String)hshValues.get("txt_cbscustid")).equalsIgnoreCase(""))
				{
					String appname="";
					hshquery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add(StrAppno);
					hshquery.put("strQueryId", "ins_dev_permission_gist");
					String perappid="0",strAppOldid="";
					String strPERAPPOLDID="";
					rs=DBUtils.executeLAPSQuery("perapplicant_selcbsid^"+Helper.correctNull((String)hshValues.get("txt_cbscustid")));
					if(rs.next())
					{
						perappid=correctNull(rs.getString("perapp_id"));
						strAppOldid=correctNull(rs.getString("perapp_oldid"));
					}
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("sel_common_customer^"+perappid);				 
					if(rs.next())
					{
						appname=correctNull(rs.getString("perapp_fname"));
						arrValues.add(correctNull(rs.getString("perapp_title")));
						arrValues.add(correctNull(rs.getString("perapp_fname")));
						appname=correctNull(rs.getString("perapp_fname"));
						if(Helper.correctNull((String)hshValues.get("sel_devSubType")).equalsIgnoreCase("7"))
							arrValues.add(correctNull(rs.getString("perapp_fname")));
						else
							arrValues.add("");
						
						str_constitution=correctNull(rs.getString("perapp_constitution"));
						arrValues.add(str_constitution);
						if(Helper.correctNull((String)hshValues.get("sel_devSubType")).equalsIgnoreCase("7"))
							arrValues.add("");
						else
							arrValues.add(correctNull(rs.getString("perapp_banksince")));
						arrValues.add(correctNull(rs.getString("perapp_introname")));
					}
					else
					{
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
					}
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("sel_applKYCNorms^"+perappid);
					if(rs.next())
					{
						arrValues.add(Helper.correctNull(rs.getString("kyc_kycActivity")));
					}
					else
					{
						arrValues.add("");
					}
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("sel_customerdetail^"+perappid);
					if(rs.next())
					{  	
						arrValues.add(correctNull(rs.getString("CON_MOBILE")));
						arrValues.add(correctNull(rs.getString("CON_EMAIL")));

						if(correctNull(rs.getString("INDINFO_RESIDENT_STATUS")).equalsIgnoreCase("N"))
						{
							arrValues.add(correctNull(rs.getString("CON_COMADDR1")));
							arrValues.add(correctNull(rs.getString("CON_COMADDR2")));
							arrValues.add(correctNull(rs.getString("CON_COMZIP")));
							arrValues.add(correctNull(rs.getString("CON_COMCITY")));
							arrValues.add(correctNull(rs.getString("CON_COMDIST")));
							arrValues.add(correctNull(rs.getString("CON_COMSTATE")));
						}
						else
						{
							arrValues.add(correctNull(rs.getString("CON_PERMADDR1")));
							arrValues.add(correctNull(rs.getString("CON_PERMADDR2")));
							arrValues.add(correctNull(rs.getString("CON_PERMZIP")));
							arrValues.add(correctNull(rs.getString("CON_PERMCITY")));
							arrValues.add(correctNull(rs.getString("CON_PERMDIST")));
							arrValues.add(correctNull(rs.getString("CON_PERMSTATE")));
							
						}
					}
					else
					{
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
					}
					
					if(rs!=null)
					{
						rs.close();
					}
					String strQuery="";
				//	String strdepoDet="";
					
				/*	if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
					{
							strQuery=SQLParser.getCBSSqlQuery("sel_deposit_det^"+str_cbscustid);
							rs=DBUtils.executeQueryCBSConnection(strQuery);
					}
					else
					{
						strQuery=SQLParser.getCBSSqlQuery("sel_deposit_val^"+str_cbscustid);
						rs=DBUtils.executeQueryCBSConnection(strQuery);
					}
					
					while(rs.next())
					{
                     	String standname=Helper.correctNull(rs.getString("loan_standname"));
						String accno=Helper.correctNull(rs.getString("loan_accno"));
						String faceval=Helper.correctNull(rs.getString("loan_faceval"));
						String presentos=Helper.correctNull(rs.getString("loan_presentos"));
						String matdate=Helper.correctNull(rs.getString("loan_matdate"));
						String rateofint=Helper.correctNull(rs.getString("loan_rateofint"));

						if(strdepoDet.equalsIgnoreCase(""))
								strdepoDet = standname+"~"+accno+"~"+faceval+"~"+presentos+"~"+matdate+"~"+rateofint+"~Y";
							else
								strdepoDet = strdepoDet+"@"+standname+"~"+accno+"~"+faceval+"~"+presentos+"~"+matdate+"~"+rateofint+"~Y";
					}
					arrValues.add(strdepoDet);
				*/	
					String strcomapp_id="";
					if(!str_constitution.equalsIgnoreCase("01"))
					{
						if(rs!=null)
						{
							rs.close();
						}
						rs=DBUtils.executeLAPSQuery("sel_appnosearchbycbsid^"+str_cbscustid);
						if(rs.next())
						{
							strcomapp_id=Helper.correctNull(rs.getString("perapp_id"));
						}
						if(!strcomapp_id.equalsIgnoreCase(""))
						{
							if(rs!=null)
							{
								rs.close();
							}
							rs=DBUtils.executeLAPSQuery("comapp_division_details_sel^"+strcomapp_id);
							while(rs.next())
							{
								if(strmanagDet.equalsIgnoreCase(""))
									strmanagDet = Helper.correctNull(rs.getString("comapp_div_name"))+"~"+Helper.correctNull(rs.getString("comapp_divisiontype"))+"~"+Helper.correctNull(rs.getString("COMAPP_DIVISIONSUBTYPE"))+"~Y";
									else
										strmanagDet = strmanagDet+"@"+Helper.correctNull(rs.getString("comapp_div_name"))+"~"+Helper.correctNull(rs.getString("comapp_divisiontype"))+"~"+Helper.correctNull(rs.getString("COMAPP_DIVISIONSUBTYPE"))+"~Y";
							}
						}
					}
					arrValues.add(strmanagDet);

				/*	if(rs!=null)
					{
						rs.close();
					}
					String tempdata="";
					String secappno="";
					strQuery=SQLParser.getSqlQuery("sel_permgist_ExistingFacility_corp^"+strAppOldid+"^"+strAppOldid+"^"+strAppOldid);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						if(tempdata.equals(""))
						{
							if(Helper.correctNull((String)hshValues.get("sel_devSubType")).equals("5"))
							{
								tempdata = Helper.correctNull(rs.getString("FACILITY_APPNO"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_SNO"))+" ~ "+
											Helper.correctNull(rs.getString("MODULETYPE"))+" ~ "+appname+" ~ "+
											Helper.correctNull(rs.getString("FACILITY_CATDESC"))+" ~ "+Helper.correctNull(rs.getString("FAC_PROCESSDATE"))+" ~ "+
											Helper.correctNull(rs.getString("FACILITY_SANCAMT"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_OUTSTANDING"))+" ~ "+
											Helper.correctNull(rs.getString("FACILITY_INTEREST"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_DUEDATE"))+" ~ "+
											Helper.correctNull(rs.getString("ARREARS"))+" ~ ";
							}
							else 
							{
								tempdata = Helper.correctNull(rs.getString("FACILITY_APPNO"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_SNO"))+" ~ "+
										Helper.correctNull(rs.getString("FACILITY_CATDESC"))+" ~ "+Helper.correctNull(rs.getString("MODULETYPE"))+" ~ "+
										Helper.correctNull(rs.getString("CBS_ACCOUNTNO"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_SANCAMT"))+" ~ "+
										Helper.correctNull(rs.getString("PURPOSE"))+" ~ "+Helper.correctNull(rs.getString("SANCTIONREFNO"))+" ~ "+
										Helper.correctNull(rs.getString("FAC_PROCESSDATE"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_INTEREST"))+" ~ "+
										Helper.correctNull(rs.getString("PRESENTROI"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_OUTSTANDING"))+" ~ "+
										Helper.correctNull(rs.getString("FACILITY_DUEDATE"))+" ~ "+Helper.correctNull(rs.getString("ARREARS"))+" ~ ";
							}
							secappno=Helper.correctNull(rs.getString("FACILITY_APPNO"));						
						}
						else
						{
							if(Helper.correctNull((String)hshValues.get("sel_devSubType")).equals("5"))
							{
								tempdata = tempdata+"@"+Helper.correctNull(rs.getString("FACILITY_APPNO"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_SNO"))+" ~ "+
											Helper.correctNull(rs.getString("MODULETYPE"))+" ~ "+appname+" ~ "+
											Helper.correctNull(rs.getString("FACILITY_CATDESC"))+" ~ "+Helper.correctNull(rs.getString("FAC_PROCESSDATE"))+" ~ "+
											Helper.correctNull(rs.getString("FACILITY_SANCAMT"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_OUTSTANDING"))+" ~ "+
											Helper.correctNull(rs.getString("FACILITY_INTEREST"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_DUEDATE"))+" ~ "+
											Helper.correctNull(rs.getString("ARREARS"))+" ~ ";
							}
							else
							{
								tempdata = tempdata+"@"+Helper.correctNull(rs.getString("FACILITY_APPNO"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_SNO"))+" ~ "+
										Helper.correctNull(rs.getString("FACILITY_CATDESC"))+" ~ "+Helper.correctNull(rs.getString("MODULETYPE"))+" ~ "+
										Helper.correctNull(rs.getString("CBS_ACCOUNTNO"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_SANCAMT"))+" ~ "+
										Helper.correctNull(rs.getString("PURPOSE"))+" ~ "+Helper.correctNull(rs.getString("SANCTIONREFNO"))+" ~ "+
										Helper.correctNull(rs.getString("FAC_PROCESSDATE"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_INTEREST"))+" ~ "+
										Helper.correctNull(rs.getString("PRESENTROI"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_OUTSTANDING"))+" ~ "+
										Helper.correctNull(rs.getString("FACILITY_DUEDATE"))+" ~ "+Helper.correctNull(rs.getString("ARREARS"))+" ~ ";
							}
							secappno= secappno+"','"+ Helper.correctNull(rs.getString("FACILITY_APPNO"));
						}
					}
					if(rs!=null)
					{
						rs.close();
					}
					strQuery=SQLParser.getSqlQuery("sel_permgist_ExistingFacility_ret^"+strAppOldid+"^"+strAppOldid);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						if(tempdata.equals(""))
						{
							if(Helper.correctNull((String)hshValues.get("sel_devSubType")).equals("5"))
							{
								tempdata = Helper.correctNull(rs.getString("APPLICATIONNO"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_SNO"))+" ~ "+
										Helper.correctNull(rs.getString("MODULETYPE"))+" ~ "+appname+" ~ "+Helper.correctNull(rs.getString("CAT_NAME"))+" ~ "+
										Helper.correctNull(rs.getString("APP_PROCESSDATE"))+" ~ "+Helper.correctNull(rs.getString("LOAN_RECMDAMT"))+" ~ "+
										""+" ~ "+Helper.correctNull(rs.getString("LOAN_MODINTRATE"))+" ~ "+Helper.correctNull(rs.getString("LOAN_DUEDATE"))+" ~ "+
										Helper.correctNull(rs.getString("arrears"))+" ~ ";
							}
							else
							{
								tempdata = Helper.correctNull(rs.getString("APPLICATIONNO"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_SNO"))+" ~ "+
								Helper.correctNull(rs.getString("CAT_NAME"))+" ~ "+Helper.correctNull(rs.getString("MODULETYPE"))+" ~ "+
								Helper.correctNull(rs.getString("CBS_ACCOUNTNO"))+" ~ "+Helper.correctNull(rs.getString("LOAN_RECMDAMT"))+" ~ "+
								Helper.correctNull(rs.getString("PURPOSE"))+" ~ "+Helper.correctNull(rs.getString("SANCTIONREFNO"))+" ~ "+
								Helper.correctNull(rs.getString("APP_PROCESSDATE"))+" ~ "+Helper.correctNull(rs.getString("LOAN_MODINTRATE"))+" ~ "+
								Helper.correctNull(rs.getString("PRESENTROI"))+" ~ "+" "+" ~ "+
								Helper.correctNull(rs.getString("LOAN_DUEDATE"))+" ~ "+Helper.correctNull(rs.getString("ARREARS"))+" ~ ";
							}
							secappno=Helper.correctNull(rs.getString("APPLICATIONNO"));
						}
						else
						{
							if(Helper.correctNull((String)hshValues.get("sel_devSubType")).equals("5"))
							{
								tempdata = tempdata+"@"+Helper.correctNull(rs.getString("APPLICATIONNO"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_SNO"))+" ~ "+
											Helper.correctNull(rs.getString("MODULETYPE"))+" ~ "+appname+" ~ "+Helper.correctNull(rs.getString("CAT_NAME"))+" ~ "+
											Helper.correctNull(rs.getString("APP_PROCESSDATE"))+" ~ "+Helper.correctNull(rs.getString("LOAN_RECMDAMT"))+" ~ "+
											""+" ~ "+Helper.correctNull(rs.getString("LOAN_MODINTRATE"))+" ~ "+Helper.correctNull(rs.getString("LOAN_DUEDATE"))+" ~ "+
											Helper.correctNull(rs.getString("arrears"))+" ~ ";
							}
							else 
							{
								tempdata = tempdata+"@"+Helper.correctNull(rs.getString("APPLICATIONNO"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_SNO"))+" ~ "+
								Helper.correctNull(rs.getString("CAT_NAME"))+" ~ "+Helper.correctNull(rs.getString("MODULETYPE"))+" ~ "+
								Helper.correctNull(rs.getString("CBS_ACCOUNTNO"))+" ~ "+Helper.correctNull(rs.getString("LOAN_RECMDAMT"))+" ~ "+
								Helper.correctNull(rs.getString("PURPOSE"))+" ~ "+Helper.correctNull(rs.getString("SANCTIONREFNO"))+" ~ "+
								Helper.correctNull(rs.getString("APP_PROCESSDATE"))+" ~ "+Helper.correctNull(rs.getString("LOAN_MODINTRATE"))+" ~ "+
								Helper.correctNull(rs.getString("PRESENTROI"))+" ~ "+" "+" ~ "+
								Helper.correctNull(rs.getString("LOAN_DUEDATE"))+" ~ "+Helper.correctNull(rs.getString("ARREARS"))+" ~ ";
							}
							secappno=secappno+"','"+Helper.correctNull(rs.getString("APPLICATIONNO"));
						}
					}
					
					if(rs!=null)
					{
						rs.close();
					}
					String existsecurity="";
					if(!secappno.equals(""))
					{	
						strQuery=SQLParser.getSqlQuery("sel_secappno_permgist^"+secappno);
						rs=DBUtils.executeQuery(strQuery);
						while(rs.next())
						{
							if(existsecurity.equals(""))
							{
								existsecurity = Helper.correctNull(rs.getString("APP_SEC_APPNO"))+" ~ "+Helper.correctNull(rs.getString("APP_SEC_FACSNO"))+" ~ "+
												Helper.correctNull(rs.getString("APP_SEC_SECID"))+" ~ "+appname+" ~ "+ Helper.correctNull(rs.getString("APP_SEC_DESCRIPTION"))+" ~ "+
												Helper.correctNull(rs.getString("APP_SEC_SECURITYVALUE"))+" ~ "+Helper.correctNull(rs.getString("APP_SEC_SECURITYTYPE"))+" ~ "+
												Helper.correctNull(rs.getString("APP_SEC_MARGIN"))+" ~ ";
							}
							else
							{
								existsecurity = existsecurity+"@"+Helper.correctNull(rs.getString("APP_SEC_APPNO"))+" ~ "+Helper.correctNull(rs.getString("APP_SEC_FACSNO"))+" ~ "+
												Helper.correctNull(rs.getString("APP_SEC_SECID"))+" ~ "+appname+" ~ "+ Helper.correctNull(rs.getString("APP_SEC_DESCRIPTION"))+" ~ "+
												Helper.correctNull(rs.getString("APP_SEC_SECURITYVALUE"))+" ~ "+Helper.correctNull(rs.getString("APP_SEC_SECURITYTYPE"))+" ~ "+
												Helper.correctNull(rs.getString("APP_SEC_MARGIN"))+" ~ ";
							}
						}
					}
					
					*/
				//	arrValues.add(tempdata);
				//	arrValues.add(existsecurity);
					
				/*	if(rs!=null)
					{
						rs.close();
					}
					String strbankdesc="";
					strQuery = SQLParser.getSqlQuery("perbankingselectNewOldId^"+strAppOldid);
					rs = DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						if(strOtherbank.equals(""))
						{
							
							strOtherbank=Helper.correctNull((String)rs.getString("perbank_bnkname"))+" ~ "+Helper.correctNull(rs.getString("perbank_facility"))+" ~ "+
										Helper.correctNull(rs.getString("perbank_limit"))+" ~ "+Helper.correctNull(rs.getString("perbank_duedate"))+" ~ "+Helper.CLOBToString(rs.getClob("perbank_arrears"))+" ~ "+"Y";
						}
						else
						{
							
							strOtherbank=strOtherbank+"@"+Helper.correctNull((String)rs.getString("perbank_bnkname"))+" ~ "+Helper.correctNull(rs.getString("perbank_facility"))+" ~ "+
										Helper.correctNull(rs.getString("perbank_limit"))+" ~ "+Helper.correctNull(rs.getString("perbank_duedate"))+" ~ "+Helper.CLOBToString(rs.getClob("perbank_arrears"))+" ~ "+"Y";
						}
					}*/
				//	arrValues.add(strOtherbank);
					arrValues.add("@"+strAppOldid);
					if(rs!=null)
					{
						rs.close();
					}
					strQuery=SQLParser.getSqlQuery("sel_kartaname^"+perappid+"^T^001");
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						arrValues.add(Helper.correctNull(rs.getString("name")));
					}
					else
					{
						arrValues.add("");
					}
					hshquery.put("arrValues",arrValues);
					hshqueryval.put("2",hshquery);
					hshqueryval.put("size","2");
					
					if(!Helper.correctNull((String)hshValues.get("sel_devSubType")).equalsIgnoreCase("7"))
					{
						hshquery=new HashMap();
						arrValues=new ArrayList();
						arrValues.add(StrAppno);
						arrValues.add(strAppOldid);
						arrValues.add("A");
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_cbscustid")));
	
						hshquery.put("strQueryId", "ins_perm_memberslist");
						hshquery.put("arrValues",arrValues);
						hshqueryval.put("3",hshquery);
						hshqueryval.put("size","3");
					}
				}
				else
				{
					hshquery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add(StrAppno);
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");

					hshquery.put("strQueryId", "ins_dev_permission_gist");
					hshquery.put("arrValues",arrValues);
					hshqueryval.put("2",hshquery);
					hshqueryval.put("size","2");
					
				}
				
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			
			    {
					hshqueryval=new HashMap();
					arrValues=new ArrayList();
					hshquery.put("strQueryId","ins_dev_appmailbox");
					arrValues.add(StrAppno);  
					arrValues.add(strUserid);
					arrValues.add(strUserid);
					arrValues.add("1");
					arrValues.add("1");
					arrValues.add("C");
					arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
					if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
						arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
					else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
						arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
					else
						arrValues.add("");
					
					arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
					if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
						arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
					else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
						arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
					else
						arrValues.add("");
					hshquery.put("arrValues",arrValues);
					hshqueryval.put("1",hshquery);
					hshqueryval.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			    }
				
				
				ArrayList arrTerms=new ArrayList();
				ArrayList arrTermsId=new ArrayList();
				ArrayList arrTermsType=new ArrayList(); 
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeLAPSQuery("getperm_termcond^"+Helper.correctNull((String)hshValues.get("sel_devSubType")));
				while(rs.next())
				{
					arrTermsId.add(correctNull(rs.getString(1)));
					arrTerms.add(correctNull(rs.getString(2)));
					arrTermsType.add("P");
				}				 
				if(arrTermsId.size()> 0 && arrTermsId!=null)
				{
					int intSize=0;
					hshqueryval = new HashMap();
					hshquery = new HashMap();
					 arrValues = null;
					for(int i=0;i<arrTermsId.size();i++)
					{
						hshqueryval.put("size",String.valueOf(++intSize));
						hshquery=new HashMap();
						hshquery.put("strQueryId","perm_app_terms_condins");
						arrValues=new ArrayList();
						arrValues.add(StrAppno);
						arrValues.add(String.valueOf(i));
						arrValues.add(correctNull((String)arrTerms.get(i)));
						arrValues.add("N");
						arrValues.add("P");
						hshquery.put("arrValues",arrValues);
						hshqueryval.put(String.valueOf(intSize),hshquery);
					}
					if(arrTermsId.size()>0)
					EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				}
				
				hshValues.put("appno", StrAppno);
				hshResult = getPermissionGistData(hshValues);
		   }
		}
		catch(Exception e)
		{
			throw new EJBException("Error in updatePermissionData "+e.getMessage());
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
		
		return hshResult;
	}

	public HashMap getPermissionData (HashMap hshValues) 
	{

		String strQuery="",strQuery1= "";
		String absPosition="";
		ResultSet rs=null;
		ResultSet rs1=null;
		HashMap hshResult=new HashMap();
		ArrayList arryRow=new ArrayList();
		ArrayList arryCol=null;
		ArrayList arrCol=new ArrayList();
		ArrayList arrRow=null;
		String strpermType=correctNull((String)hshValues.get("permtype"));
		String pagefrom=correctNull((String)hshValues.get("pagefrom"));
		String devsubtype=correctNull((String)hshValues.get("devsubtype"));
		String appno=correctNull((String)hshValues.get("appno"));
		if(appno.equals(""))
		{
			appno=correctNull((String)hshValues.get("hidAppno"));
		}
		try
		{
				if(rs!=null)
				{
					rs.close();
				}
				strQuery= SQLParser.getSqlQuery("sel_appl_deviation^"+appno);
				rs=DBUtils.executeQuery(strQuery);
				arrRow=new ArrayList();
				if(rs.next())
				{
					hshValues.put("DEV_APPNO",correctNull(rs.getString("DEV_APPNO")));
					hshValues.put("DEV_TYPE",correctNull(rs.getString("DEV_TYPE")));
					hshValues.put("DEV_SUBTYPE",correctNull(rs.getString("DEV_SUBTYPE")));
					hshValues.put("DEV_WHTCUSAVAIL",correctNull(rs.getString("DEV_WHTCUSAVAIL")));
					hshValues.put("DEV_CBSID",correctNull(rs.getString("DEV_CBSID")));
					hshValues.put("DEV_DEVPARAM",correctNull(rs.getString("DEV_DEVPARAM")));
					hshValues.put("hidAppholder",correctNull(rs.getString("DEV_USERID")));
					hshValues.put("DEV_APPSTATUS",correctNull(rs.getString("DEV_APPSTATUS")));

				}
				
				if(rs!=null)
				{
					rs.close();
				}
				strQuery= SQLParser.getSqlQuery("sel_permMaster^"+Helper.correctInt((String)hshValues.get("DEV_SUBTYPE")));
				rs=DBUtils.executeQuery(strQuery);
				arrRow=new ArrayList();
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(Helper.correctNull((String)rs.getString("PER_ID")));
					arrCol.add(Helper.correctNull((String)rs.getString("PER_NAME")));
					arrRow.add(arrCol);
				}
				hshValues.put("arrRow",arrRow);
				
				
				
				
				
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getPermissionData "+e.getMessage());
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
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		
		return hshValues;
	}
	
	public HashMap getPermissionLetterData(HashMap hshValues) 
	{
		ResultSet rs = null,rs1=null;
		ArrayList vecRow = new ArrayList();
		String strAppno="";
		String strQuery="";
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		
		try
		{ 
			strAppno=Helper.correctNull((String)hshValues.get("appno"));
			strQuery = SQLParser.getSqlQuery("sel_PERM_TERMSANDCOND_print^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("PERM_TERMSCONTENT")));
				arrRow.add(arrCol);
			}
			hshValues.put("arrRow",arrRow);
			
			if(rs!=null)
			{
				rs.close();					 
			}
			strQuery = SQLParser.getSqlQuery("sel_perm_details^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("borrowername",Helper.correctNull((String)rs.getString("PG_APPLIANTNAME")));
				hshValues.put("reqloanamt",Helper.correctNull((String)rs.getString("reqloanamt")));
				hshValues.put("PG_SCHEME_GUIDELINES",Helper.correctNull((String)rs.getString("PG_SCHEME_GUIDELINES")));
				hshValues.put("DEV_PROCESSDATE",Helper.correctNull((String)rs.getString("DEV_PROCESSDATE")));
				hshValues.put("DEV_SUBTYPE",Helper.correctNull((String)rs.getString("DEV_SUBTYPE")));

			}
			if(rs!=null)
			{
				rs.close();					 
			}
			strQuery = SQLParser.getSqlQuery("sel_SancRefNo^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("sanctionrefno",Helper.correctNull((String)rs.getString("sanctionrefno")));

			}
			if(rs!=null)
				rs.close();
			
			strQuery = SQLParser.getSqlQuery("sel_recomments^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("strComments1", correctNull(Helper.CLOBToString(rs.getClob("PERM_COMMENTS1"))));
				hshValues.put("strComments2", correctNull(Helper.CLOBToString(rs.getClob("PERM_COMMENTS2"))));
			}
			
			if(rs!=null)
				rs.close();
			String strAppCreatedOrg="";
			String strDEV_ORGSNAME="";
			String strDEV_ORGCODE="";
			String strDEV_ORGSCODE="";
			strQuery = SQLParser.getSqlQuery("sel_permcreatedbranch^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strAppCreatedOrg=Helper.correctNull(rs.getString("org_level"));
				hshValues.put("strCBSID",Helper.correctNull(rs.getString("DEV_CBSID")));
			}
			
			if(rs1!=null)
				rs1.close();
			
			strQuery = SQLParser.getSqlQuery("sel_basicinformation^"+strAppno);
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				
				strDEV_ORGSCODE=Helper.correctNull(rs1.getString("PERM_PER_BRANCH"));
				hshValues.put("PERM_HANDLING_CHARGE",Helper.correctDouble(rs1.getString("PERM_HANDLING_CHARGE")));
			}
			if(strAppCreatedOrg.equalsIgnoreCase("A"))
			{
				if(rs1!=null)
					rs1.close();
				
				strQuery = SQLParser.getSqlQuery("sel_permcreatedbranch^"+strAppno);
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					strDEV_ORGCODE=Helper.correctNull(rs1.getString("org_code"));
					strDEV_ORGSNAME=Helper.correctNull(rs1.getString("ORG_NAME"));
				}
				hshValues.put("strDEV_ORGSNAME",strDEV_ORGSNAME);
				
			}else if(strAppCreatedOrg.equalsIgnoreCase("D")||strAppCreatedOrg.equalsIgnoreCase("C"))
			{
				if(rs1!=null)
					rs1.close();
				
				strQuery = SQLParser.getSqlQuery("setorgselectapp^"+strDEV_ORGSCODE);
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					strDEV_ORGCODE=Helper.correctNull(rs1.getString("org_code"));
					strDEV_ORGSNAME=Helper.correctNull(rs1.getString("org_name"));
				}
				
				hshValues.put("strDEV_ORGSNAME",strDEV_ORGSNAME);
			}
			
			String strorg_region=strDEV_ORGCODE.substring(0,6)+"000000000";
			
			if(rs1!=null)
				rs1.close();
			
			strQuery = SQLParser.getSqlQuery("sel_region^"+strorg_region);
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				hshValues.put("strorg_region",Helper.correctNull((String)rs1.getString("org_name")));
			}
			
			if(rs1!=null)
			{
				rs1.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_perm_applbg_comments^"+strAppno);
			rs1 = DBUtils.executeQuery(strQuery);
			while(rs1.next())
			{
				hshValues.put("strBkgroundcmts", correctNull(Helper.CLOBToString(rs1.getClob("APPLBG_COMMENTS"))));
			}
			
		}catch(Exception e)
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
		

		return hshValues;
		
	}
	
	public HashMap updatePermissionParamData(HashMap hshValues) 
	{
		String strQuery="";
		HashMap hshqueryval =new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshResult = new HashMap();
		ArrayList arrValues = new ArrayList();
		String appno=correctNull((String)hshValues.get("appno"));
		if(appno.equals(""))
		{
			appno=correctNull((String)hshValues.get("hidAppno"));
		}
		try
		{
			
			hshquery=new HashMap();
			arrValues=new ArrayList();
			hshquery.put("strQueryId","upd_permParamters");
			arrValues.add(Helper.correctNull((String)hshValues.get("hidParameter")));
			arrValues.add(appno);
			hshquery.put("arrValues",arrValues);
			hshqueryval.put("1",hshquery);
			hshqueryval.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
		
			
			
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in updatePermissionParamData "+e.getMessage());
		}
		
		return hshResult;
	}
	
	public void updatepermissionGistData(HashMap hshValues) 
	{
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		HashMap hshQueryValues =new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strQuery="";
		ResultSet rs=null,rs4=null;
		Connection connectDB= null;
		CallableStatement callableStmt = null;
		String[] borName=null,facnature=null,loandate=null,limit=null,osbalance=null,interest=null,duedate=null,arrears=null,
		strName=null,strCategory=null,strbankScheme=null,strpres=null,strpresnature=null,strpresloanamt=null,strpresint=null,strpresperiod=null,strprespurpose=null,strSubCategory=null;

		String total_facilities="", strAction="",strManagerDet="",strDepaccDet="",strSecExtVal="",strOtherbank="";
		strAction=correctNull((String)hshValues.get("hidAction"));
		String OrgCode="",Strappno="",StrAppno="";
		try
		{
			StrAppno=correctNull((String)hshValues.get("appno"));
			strAction=correctNull((String)hshValues.get("hidAction"));
			if(strAction.equalsIgnoreCase("insert"))
			{
				int intsize=0;
				++intsize;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_permissionGist_Data");
				arrValues.add(StrAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(String.valueOf(intsize),hshQuery);
				hshQueryValues.put("size",String.valueOf(intsize));
				
				++intsize;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ins_permissionGist_Data");
				arrValues.add(StrAppno);
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_applName")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_constitution")));



				if(hshValues.get("txt_managname") instanceof String[])
				{
					strName=(String[])hshValues.get("txt_managname");
					strCategory=(String[])hshValues.get("sel_designation");
					strSubCategory=(String[])hshValues.get("comapp_divisionSubtype");
					String[] strmang_val=(String[])hshValues.get("txt_mang_val");



					for(int i=0;i<strName.length;i++)
					{
						if(!strName[i].equals("") && !strCategory[i].equals("") &&!strSubCategory[i].equals("") &&!strmang_val[i].equals("")) 
						{
							if(strManagerDet.equalsIgnoreCase(""))
								strManagerDet = strName[i]+"~"+strCategory[i]+"~"+strSubCategory[i]+"~"+strmang_val[i];
							else
								strManagerDet = strManagerDet+"@"+strName[i]+"~"+strCategory[i]+"~"+strSubCategory[i]+"~"+strmang_val[i];
						}
					}
					arrValues.add(strManagerDet);
				}
				else if(!(Helper.correctNull((String)hshValues.get("txt_managname")).equalsIgnoreCase("")))
				{
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_managname"))+"~"+Helper.correctNull((String)hshValues.get("sel_designation"))+"~"+Helper.correctNull((String)hshValues.get("comapp_divisionSubtype"))+"~"+Helper.correctNull((String)hshValues.get("txt_mang_val")));
				}
				else
				{
					arrValues.add("");
				}


				arrValues.add(Helper.correctNull((String)hshValues.get("txt_natureofactivity")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_estDate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_grpcrn_busspot")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_employerName")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_noofemployer")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_presentTrustee")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_excessincome_overexp")));
			//	arrValues.add(Helper.correctNull((String)hshValues.get("txt_det_depositacc")));
				
				
				
			/*	if(hshValues.get("txt_dep_accno") instanceof String[])
				{
					String strDepName[]=(String[])hshValues.get("txt_dep_name");
					String strDepAcc[]=(String[])hshValues.get("txt_dep_accno");
					String strDepAmt[]=(String[])hshValues.get("txt_dep_depamt");
					
					String strDepBal[]=(String[])hshValues.get("txt_dep_presbal");
					String strDepdate[]=(String[])hshValues.get("txt_dep_maturdate");
					String strDepROI[]=(String[])hshValues.get("txt_dep_roi");
					//String strDepVal[]=(String[])hshValues.get("txt_dep_val");


					for(int i=0;i<strDepName.length;i++)
					{
						if(!strDepName[i].equals("") && !strDepAcc[i].equals("")) 
						{
							if(strDepaccDet.equalsIgnoreCase(""))
								strDepaccDet = strDepName[i]+"~"+strDepAcc[i]+"~"+strDepAmt[i]+"~"+strDepBal[i]+"~"+strDepdate[i]+"~"+strDepROI[i];
							else
								strDepaccDet = strDepaccDet+"@"+strDepName[i]+"~"+strDepAcc[i]+"~"+strDepAmt[i]+"~"+strDepBal[i]+"~"+strDepdate[i]+"~"+strDepROI[i];
						}
					}
					arrValues.add(strDepaccDet);
				}
				else if(!(Helper.correctNull((String)hshValues.get("txt_dep_accno")).equalsIgnoreCase("")))
				{
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_dep_name"))+"~"+Helper.correctNull((String)hshValues.get("txt_dep_accno"))+"~"+Helper.correctNull((String)hshValues.get("txt_dep_depamt"))+"~"+Helper.correctNull((String)hshValues.get("txt_dep_presbal"))+"~"+Helper.correctNull((String)hshValues.get("txt_dep_maturdate"))+"~"+Helper.correctNull((String)hshValues.get("txt_dep_roi")));
				}
				else
				{
					arrValues.add("");
				}

				*/
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_dealingSince")));
			//	arrValues.add(Helper.correctNull((String)hshValues.get("txt_exstfac_sec_prime")));
				
				
			/*	if(hshValues.get("txt_secur_appname") instanceof String[])
				{
					String txt_secur_propno[]=(String[])hshValues.get("txt_secur_propno");
					String txt_secur_facsno[]=(String[])hshValues.get("txt_secur_facsno");
					String strSecName[]=(String[])hshValues.get("txt_secur_appname");
					String strSecid[]=(String[])hshValues.get("txt_secur_id");
					String strSecDesc[]=(String[])hshValues.get("txt_secur_desp");
					String strSecurVal[]=(String[])hshValues.get("txt_secur_val");
					String strSecType[]=(String[])hshValues.get("txt_secur_type");
					String strSecMarg[]=(String[])hshValues.get("txt_secur_marg");


					for(int i=0;i<strSecName.length;i++)
					{
						if(!txt_secur_propno[i].equals("") && !strSecid[i].equals("")) 
						{
							if(strSecExtVal.equalsIgnoreCase(""))
								strSecExtVal = txt_secur_propno[i]+" ~ "+txt_secur_facsno[i]+" ~ "+strSecName[i]+" ~ "+strSecid[i]+" ~ "+Helper.replaceForJavaScriptString(Helper.correctNull(strSecDesc[i]))+" ~ "+strSecurVal[i]+" ~ "+strSecType[i]+" ~ "+strSecMarg[i]+" ~ ";
							else
								strSecExtVal = strSecExtVal+"@"+txt_secur_propno[i]+" ~ "+txt_secur_facsno[i]+" ~ "+strSecName[i]+" ~ "+strSecid[i]+" ~ "+Helper.replaceForJavaScriptString(Helper.correctNull(strSecDesc[i]))+" ~ "+strSecurVal[i]+" ~ "+strSecType[i]+" ~ "+strSecMarg[i]+" ~ ";
						}
					}
					if(!Helper.correctNull((String)hshValues.get("hid_addexsistingsec")).equals(""))
					{
						strSecExtVal=strSecExtVal+"@"+Helper.correctNull((String)hshValues.get("hid_addexsistingsec"));
					}
					arrValues.add(strSecExtVal);
				}
				else if(!(Helper.correctNull((String)hshValues.get("txt_secur_propno")).equalsIgnoreCase("")) && !(Helper.correctNull((String)hshValues.get("txt_secur_id")).equalsIgnoreCase("")))
				{
					strSecExtVal=Helper.correctNull((String)hshValues.get("txt_secur_propno"))+" ~ "+Helper.correctNull((String)hshValues.get("txt_secur_facsno"))+" ~ "+Helper.correctNull((String)hshValues.get("txt_secur_appname"))+" ~ "+Helper.correctNull((String)hshValues.get("txt_secur_id"))+" ~ "+Helper.replaceForJavaScriptString(Helper.correctNull((String)hshValues.get("txt_secur_desp")))+" ~ "+Helper.correctNull((String)hshValues.get("txt_secur_val"))+" ~ "+Helper.correctNull((String)hshValues.get("sel_secur_type"))+" ~ "+Helper.correctNull((String)hshValues.get("txt_secur_marg"))+" ~ ";
					if(!Helper.correctNull((String)hshValues.get("hid_addexsistingsec")).equals(""))
					{
						strSecExtVal=strSecExtVal+"@"+Helper.correctNull((String)hshValues.get("hid_addexsistingsec"));
					}
					arrValues.add(strSecExtVal);
				}
				else
				{
					arrValues.add("");
				}
				
				*/
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_exstfac_sec_Collateral")));
			//	arrValues.add(Helper.correctNull((String)hshValues.get("txt_det_loanacc_othbank")));
				
				

			/*	if(hshValues.get("hid_other_bankcode") instanceof String[])
				{
					String strother_bankcode[]=(String[])hshValues.get("hid_other_bankcode");
					String strother_facility[]=(String[])hshValues.get("txt_other_facility");
					String strother_limit[]=(String[])hshValues.get("txt_other_limit");
					String strother_duedate[]=(String[])hshValues.get("txt_other_duedate");
					String strother_arrear[]=(String[])hshValues.get("txt_other_arrear");
					String strother_val[]=(String[])hshValues.get("txt_other_val1");
				//	String strother_bankcode[]=(String[])hshValues.get("hid_other_bankcode");

					for(int i=0;i<strother_bankcode.length;i++)
					{
						if(!strother_bankcode[i].equals("") && !strother_facility[i].equals("")) 
						{
							if(strOtherbank.equalsIgnoreCase(""))
								strOtherbank = strother_bankcode[i]+" ~ "+strother_facility[i]+" ~ "+strother_limit[i]+" ~ "+strother_duedate[i]+" ~ "+strother_arrear[i]+" ~ "+strother_val[i]+" ~ ";
							else
								strOtherbank = strOtherbank+"@"+strother_bankcode[i]+" ~ "+strother_facility[i]+" ~ "+strother_limit[i]+" ~ "+strother_duedate[i]+" ~ "+strother_arrear[i]+" ~ "+strother_val[i]+" ~ ";
						}
					}
					arrValues.add(strOtherbank);
				}
				else if(!(Helper.correctNull((String)hshValues.get("hid_other_bankcode")).equalsIgnoreCase("")) && !(Helper.correctNull((String)hshValues.get("txt_other_facility")).equalsIgnoreCase("")))
				{
					arrValues.add(Helper.correctNull((String)hshValues.get("hid_other_bankcode"))+" ~ "+Helper.correctNull((String)hshValues.get("txt_other_facility"))+" ~ "+Helper.correctNull((String)hshValues.get("txt_other_limit"))+" ~ "+Helper.correctNull((String)hshValues.get("txt_other_duedate"))+" ~ "+Helper.correctNull((String)hshValues.get("txt_other_arrear"))+" ~ "+Helper.correctNull((String)hshValues.get("txt_other_val1"))+" ~ ");
				}
				else
				{
					arrValues.add("");
				}
				
				*/
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_itReturns_taxpaid")));

				arrValues.add(Helper.correctNull((String)hshValues.get("txt_propfac_sec_prime")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_propfac_sec_Collateral")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_rsn_switch")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_acc_introdby")));

				arrValues.add(Helper.correctNull((String)hshValues.get("txt_landcost")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_promotcontrib")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_percenttotal1")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_constructionCost")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_advanceamt")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_percenttotal2")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_loanfromKBL")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_percenttotal3")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_totprojectcost")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_totmeansoffinance")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_percenttotal4")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_src_marginmoney")));
				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_src_repayment")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_totArea")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_totBuiltupArea")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_floordetails")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_totconstCost")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_avgSellingPrice_rf")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_avgSellingPrice_cp")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_projectedRent")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_conf_auth_constbuild")));

				arrValues.add(Helper.correctNull((String)hshValues.get("txt_scheme_guidelines")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_devperm_soughtothers")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_earlierConcession")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_justf_specconsid")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_concession_recommended")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_concession_justif")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_detofvisit")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_partyBG_earprojects")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_devobserved")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_whtPerm_extended")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_TA_brtot_acs")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_TA_brtot_amt")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_TA_npa_acs")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_TA_npa_amt")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_TA_npaper_acs")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_TA_npaper_amt")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_sl_brtot_acs")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_sl_brtot_amt")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_sl_npa_acs")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_sl_npa_amt")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_sl_npaper_acs")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_sl_npaper_amt")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_le_brtot_acs")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_le_brtot_amt")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_le_npa_acs")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_le_npa_amt")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_le_npaper_acs")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_le_npaper_amt")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_anyother_info")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_recommend_branch")));

				
			/*	if(Helper.correctNull((String)hshValues.get("hidSubType")).equals("3")||Helper.correctNull((String)hshValues.get("hidSubType")).equals("4")||Helper.correctNull((String)hshValues.get("hidSubType")).equals("6"))
				{
					if(hshValues.get("txt_Proposalnumber") instanceof String[])
					{
						
						String[] txt_Proposalnumber=(String[])hshValues.get("txt_Proposalnumber");
						String[] txt_facsno=(String[])hshValues.get("txt_facsno");
						String[] txt_ModuleType=(String[])hshValues.get("txt_ModuleType");
						String[] fac_name=(String[])hshValues.get("txt_extfac_Name");
						String[] fac_accnum=(String[])hshValues.get("txt_extfac_accnum");
						String[] fac_limit=(String[])hshValues.get("txt_extfac_limit");
						String[] fac_purpose=(String[])hshValues.get("txt_extfac_purpose");
						String[] fac_sancref=(String[])hshValues.get("txt_extfac_sancref");
						String[] fac_sancdate=(String[])hshValues.get("txt_extfac_sancdate");
						String[] fac_sancroi=(String[])hshValues.get("txt_extfac_sancroi");
						String[] fac_presroifac=(String[])hshValues.get("txt_extfac_presroifac");
						String[] fac_bal=(String[])hshValues.get("txt_extfac_bal");
						String[] fac_duedate=(String[])hshValues.get("txt_extfac_duedate");
						String[] fac_arrear=(String[])hshValues.get("txt_extfac_arrear");

						for(int i=0;i<fac_name.length;i++)
						{
							if(!txt_Proposalnumber[i].equals("")) 
								total_facilities = total_facilities+"@"+txt_Proposalnumber[i]+" ~ "+txt_facsno[i]+" ~ "+txt_ModuleType[i]+" ~ "+fac_name[i]+" ~ "+fac_accnum[i]+" ~ "+fac_limit[i]+" ~ "+fac_purpose[i]+" ~ "+fac_sancref[i]+" ~ "+fac_sancdate[i]+" ~ "+fac_sancroi[i]+" ~ "+fac_presroifac[i]+" ~ "+fac_bal[i]+" ~ "+fac_duedate[i]+" ~ "+fac_arrear[i]+" ~ ";
						}
						if(!Helper.correctNull((String)hshValues.get("hid_addexsistingfac")).equals(""))
						{
							total_facilities=total_facilities+"@"+Helper.correctNull((String)hshValues.get("hid_addexsistingfac"));
						}
						total_facilities=total_facilities.replaceFirst("@","");
						arrValues.add(total_facilities);
					}
					else if(!Helper.correctNull((String)hshValues.get("txt_extfac_Name")).equalsIgnoreCase(""))
					{
						total_facilities=Helper.correctNull((String)hshValues.get("txt_Proposalnumber"))+" ~ "+Helper.correctNull((String)hshValues.get("txt_facsno"))+" ~ "+Helper.correctNull((String)hshValues.get("txt_ModuleType"))+" ~ "+Helper.correctNull((String)hshValues.get("txt_extfac_Name"))+" ~ "+Helper.correctNull((String)hshValues.get("txt_extfac_accnum"))+" ~ "+Helper.correctNull((String)hshValues.get("txt_extfac_limit"))+" ~ "+Helper.correctNull((String) hshValues.get("txt_extfac_purpose"))+" ~ "+Helper.correctNull((String) hshValues.get("txt_extfac_sancref"))+" ~ "+Helper.correctNull((String) hshValues.get("txt_extfac_sancdate"))+" ~ "+Helper.correctNull((String) hshValues.get("txt_extfac_sancroi"))+" ~ "+Helper.correctNull((String) hshValues.get("txt_extfac_presroifac"))+" ~ "+Helper.correctNull((String) hshValues.get("txt_extfac_bal"))+" ~ "+Helper.correctNull((String) hshValues.get("txt_extfac_duedate"))+" ~ "+Helper.correctNull((String) hshValues.get("txt_extfac_arrear"))+" ~ ";
						if(!Helper.correctNull((String)hshValues.get("hid_addexsistingfac")).equals(""))
						{
							total_facilities=total_facilities+"@"+Helper.correctNull((String)hshValues.get("hid_addexsistingfac"));
						}
						arrValues.add(total_facilities);
					}
					else
					{
						arrValues.add("");
					}
					
					
				}else if(hshValues.get("hidSubType").equals("5"))
				{
					if(hshValues.get("txt_exst_Proposalnumber") instanceof String[])
					{
						String strProposal[]= (String[])hshValues.get("txt_exst_Proposalnumber");
						String strFacility_SNo[]= (String[])hshValues.get("txt_exst_facsno");
						String strModule_Type[]= (String[])hshValues.get("txt_exst_ModuleType");
						borName=(String[])hshValues.get("txt_exstfac_borName");
						facnature=(String[])hshValues.get("txt_exstfac_facnature");
						loandate=(String[])hshValues.get("txt_exstfac_loandate");
						limit=(String[])hshValues.get("txt_exstfac_limit");
						osbalance=(String[])hshValues.get("txt_exstfac_osbalance");
						interest=(String[])hshValues.get("txt_exstfac_interest");
						duedate=(String[])hshValues.get("txt_exstfac_duedate");
						arrears=(String[])hshValues.get("txt_exstfac_arrears");
						for(int i=0;i<borName.length;i++)
						{
							if(!strProposal[i].equals("") && !borName[i].equals("")) 
								total_facilities = total_facilities+"@"+strProposal[i]+" ~ "+strFacility_SNo[i]+" ~ "+strModule_Type[i]+" ~ "+borName[i]+" ~ "+facnature[i]+" ~ "+loandate[i]+" ~ "+limit[i]+" ~ "+osbalance[i]+" ~ "+interest[i]+" ~ "+duedate[i]+" ~ "+arrears[i]+" ~ ";
						}
						if(!Helper.correctNull((String)hshValues.get("hid_addexsistingfac")).equals(""))
						{
							total_facilities=total_facilities+"@"+Helper.correctNull((String)hshValues.get("hid_addexsistingfac"));
						}
						total_facilities=total_facilities.replaceFirst("@","");
						arrValues.add(total_facilities);
					}
					else if(!Helper.correctNull((String)hshValues.get("txt_exstfac_borName")).equalsIgnoreCase(""))
					{
						total_facilities=Helper.correctNull((String)hshValues.get("txt_exst_Proposalnumber"))+" ~ "+Helper.correctNull((String)hshValues.get("txt_exst_facsno"))+" ~ "+Helper.correctNull((String)hshValues.get("txt_exst_ModuleType"))+" ~ "+Helper.correctNull((String)hshValues.get("txt_exstfac_borName"))+" ~ "+Helper.correctNull((String)hshValues.get("txt_exstfac_facnature"))+" ~ "+Helper.correctNull((String)hshValues.get("txt_exstfac_loandate"))+" ~ "+Helper.correctNull((String) hshValues.get("txt_exstfac_limit"))+" ~ "+Helper.correctNull((String) hshValues.get("txt_exstfac_osbalance"))+" ~ "+Helper.correctNull((String) hshValues.get("txt_exstfac_interest"))+" ~ "+Helper.correctNull((String) hshValues.get("txt_exstfac_duedate"))+" ~ "+Helper.correctNull((String) hshValues.get("txt_exstfac_arrears"))+" ~ "+Helper.correctNull((String) hshValues.get("txt_exst_val"))+" ~ ";
						if(!Helper.correctNull((String)hshValues.get("hid_addexsistingfac")).equals(""))
						{
							total_facilities=total_facilities+"@"+Helper.correctNull((String)hshValues.get("hid_addexsistingfac"));
						}
						arrValues.add(total_facilities);
					}
					else
					{
						arrValues.add("");
					}
				}else
				{
					arrValues.add("");
				}
				*/
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_applAddress1")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_applAddress2")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hidcity")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_dist")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hidstate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_appl_pincode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_appl_phno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_appl_mail")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_constitutedOn")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_applt_title")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_incexpen_date")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_existingBowid")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_cre_exposure")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_bor_Rating")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_ratingDate")));
				// for cibil score and crif score
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_cibilscore")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_datecibil")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_cibilComment")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_crifscore")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_crif_date")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_crifdetails")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_prime_val")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_collateral_val")));
			

				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(String.valueOf(intsize),hshQuery);
				hshQueryValues.put("size",String.valueOf(intsize));


				++intsize;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_permissionGist_loanreq");
				arrValues.add(StrAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(String.valueOf(intsize),hshQuery);
				hshQueryValues.put("size",String.valueOf(intsize));


				if(hshValues.get("txt_present_nature") instanceof String[])
				{
					strpresnature=(String[])hshValues.get("txt_present_nature");
					strbankScheme=(String[])hshValues.get("sel_bankscheme");
					strpresloanamt=(String[])hshValues.get("txt_present_loanamt");
					strpresint=(String[])hshValues.get("txt_present_interest");
					strpresperiod=(String[])hshValues.get("txt_present_period");
					strprespurpose=(String[])hshValues.get("txt_present_purpose");
					
					for(int j=0;j<strpresnature.length;j++)
					{
						if(!strpresnature[j].equalsIgnoreCase(""))
						{
							++intsize;
							arrValues=new ArrayList();
							hshQuery=new HashMap();
							arrValues.add(StrAppno);							
							arrValues.add((String.valueOf(j+1)));
							arrValues.add(strpresnature[j]);
							arrValues.add(strpresloanamt[j]);
							arrValues.add(strpresint[j]);
							arrValues.add(strpresperiod[j]);
							arrValues.add(strprespurpose[j]);
							arrValues.add(strbankScheme[j]);
							hshQuery.put("arrValues",arrValues);
							hshQuery.put("strQueryId","ins_permissionGist_loanreq");
							hshQueryValues.put(String.valueOf(intsize),hshQuery);
							hshQueryValues.put("size",String.valueOf(intsize));
						}
					}
				}
				else
				{
					if(!Helper.correctNull((String)hshValues.get("txt_present_nature")).equalsIgnoreCase(""))
					{
						++intsize;
						arrValues=new ArrayList();
						hshQuery=new HashMap();
						arrValues.add(StrAppno);							
						arrValues.add("1");
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_present_nature")));
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_present_loanamt")));
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_present_interest")));
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_present_period")));
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_present_purpose")));
						arrValues.add(Helper.correctNull((String)hshValues.get("sel_bankscheme")));
						hshQuery.put("arrValues",arrValues);
						hshQuery.put("strQueryId","ins_permissionGist_loanreq");
						hshQueryValues.put(String.valueOf(intsize),hshQuery);
						hshQueryValues.put("size",String.valueOf(intsize));
					}
				}
				
				
				++intsize;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_perm_memberslist");
				arrValues.add(StrAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(String.valueOf(intsize),hshQuery);
				
				
				hshQueryValues.put("size",String.valueOf(intsize));
				
				String[] demoList=Helper.correctNull((String)hshValues.get("hid_demoList")).split("@");
				String[] cbsList=Helper.correctNull((String)hshValues.get("hid_SecOwnerList")).split("@");

				if(demoList.length>0 && !demoList[0].equalsIgnoreCase(""))
				{
					for(int j=0;j<demoList.length;j++)
					{
							++intsize;
							arrValues=new ArrayList();
							hshQuery=new HashMap();
							arrValues.add(StrAppno);							
							arrValues.add(demoList[j]);
							arrValues.add("C");
							arrValues.add(cbsList[j]);
							hshQuery.put("arrValues",arrValues);
							hshQuery.put("strQueryId","ins_perm_memberslist");
							hshQueryValues.put(String.valueOf(intsize),hshQuery);
							hshQueryValues.put("size",String.valueOf(intsize));
					}
				}
				
				if(intsize>0)
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

				hshValues.put("appno", StrAppno);
			}
			else if(strAction.equalsIgnoreCase("Delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_PERMapplications");
				arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));
				arrValues.add(StrAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if (strAction.equalsIgnoreCase("Freeze"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","update_freeze_permissiongist");
				arrValues.add("Y");
				arrValues.add(Helper.correctNull((String)hshValues.get("strappno")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

				String strappcbsid="";
				strQuery= SQLParser.getSqlQuery("sel_appl_deviation^"+StrAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strappcbsid=Helper.correctInt(rs.getString("DEV_CBSID"));
				}
				
					if(rs!=null)
					{
						rs.close();
					}
					String perappid="",perappoldid="",perappname="";
					rs=DBUtils.executeLAPSQuery("perapplicant_selcbsid^"+strappcbsid);
					if(rs.next())
					{
						perappid=Helper.correctInt(rs.getString("perapp_id"));
						perappoldid=Helper.correctInt(rs.getString("PERAPP_OLDID"));
					}
					log.info("**************************Execute procedure*********************************");
		    		log.info("Old laps id... " + perappoldid);
		    		log.info("Appno.... " + StrAppno);
		    		connectDB= ConnectionFactory.getConnection();
					callableStmt=connectDB.prepareCall("call PERM_EXISTFACILITY(?,?)");
					callableStmt.setString(1,Helper.correctNull(perappoldid));
					callableStmt.setString(2,Helper.correctNull(StrAppno));
					callableStmt.execute();
					callableStmt.clearParameters();
					callableStmt.close();
					connectDB.close();
					log.info("**************************End procedure*********************************");
					
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();		
					arrValues=new ArrayList();
					
					int size=0;
					if(rs4!=null) rs4.close();
					strQuery = SQLParser.getSqlQuery("sel_perm_moredet_extfac^"+StrAppno);
					rs4 = DBUtils.executeQuery(strQuery);
		    		while(rs4.next())
		    		{
		    			String strCbsACno="",strPrefix="",strSuffix="";
		    			String strWhetherACOpening=Helper.correctNull((String)rs4.getString("PERM_ACCOUNTOPEN"));
		    			strCbsACno=Helper.correctNull((String)rs4.getString("PERM_EXIST_ACCNO"));
		    			strPrefix=Helper.correctNull((String)rs4.getString("PERM_PREFIX"));
		    			strSuffix=Helper.correctNull((String)rs4.getString("PERM_SUFFIX"));
		    			
		    			if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
						{
			    			if(strWhetherACOpening.equalsIgnoreCase("Y"))
			    			{
			    				strQuery = SQLParser.getCBSSqlQuery("selliabpullingdirectacopening^"+strCbsACno);
			    			}
			    			else
			    			{
			    				if(!strPrefix.equalsIgnoreCase("")&& !strSuffix.equalsIgnoreCase(""))
			    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopening^"+strPrefix+"^"+strSuffix);
			    				else
			    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopeningbg^"+strCbsACno);
			    			}
						}
		    			else
		    			{
		    				if(strWhetherACOpening.equalsIgnoreCase("Y"))
			    			{
			    				strQuery = SQLParser.getCBSSqlQuery("selliabpullingdirectacopening1^"+strCbsACno);
			    			}
			    			else
			    			{
			    				if(!strPrefix.equalsIgnoreCase("")&& !strSuffix.equalsIgnoreCase(""))
			    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopening1^"+strPrefix+"^"+strSuffix);
			    				else
			    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopeningbg1^"+strCbsACno);
			    			}
		    			}
		    			if(rs!=null) rs.close();
		    			rs = DBUtils.executeQueryCBSConnection(strQuery);
		    			if(rs.next())
		    			{
		    				String strDueDate =Helper.correctNull((String)rs.getString("duedate"));
		    				String strOutstanding = jtn.format(Double.parseDouble((String)Helper.correctDouble(rs.getString("outstanding"))));
		    				String strFlag="";
		    				
		    				double dbl_Sancamount=Double.parseDouble((String)Helper.correctDouble(rs.getString("SANCT_LIMIT")));
		    				double dblOutstanding=Double.parseDouble((String)Helper.correctDouble(rs.getString("outstanding")));
		        			if(dblOutstanding<0)
		    				{
		    					dblOutstanding=Double.parseDouble(strOutstanding.substring(1));//for converting negative value to positive
		    					strFlag="DR";
		    				}	
		        			else
		        			{
		        				strFlag="CR";
		        			}
		        			
		    			
		    				hshQuery = new HashMap();
		       			 	arrValues = new ArrayList();
		       			    arrValues.add(strDueDate);
		       			 	arrValues.add(Helper.formatDoubleValue(dblOutstanding));
		       			 	arrValues.add(strFlag);
		       			    arrValues.add(StrAppno);
		       			 	size+=1;
		       			 	hshQueryValues.put("size",""+(size));
		       			    if(strWhetherACOpening.equalsIgnoreCase("Y"))
		       			    {
		       			    	arrValues.add(strCbsACno);
		       			    	hshQuery.put("strQueryId","updpermdirliab"); 
		       			    }
		       			    else
		       			    {
		       			    	arrValues.add(strPrefix);
		       			    	arrValues.add(strSuffix);
		       			    	hshQuery.put("strQueryId","updpermindirliab"); 
		       			    }
		       			 	hshQuery.put("arrValues",arrValues);
		       			 	hshQueryValues.put(""+(size),hshQuery);	
		    			}
		    		}
		    		if(size>0){
		    			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		    		}
					
					
					if(!Helper.correctNull((String)hshValues.get("hidSubType")).equalsIgnoreCase("8"))
					{	
					String secappno="";
					strQuery= SQLParser.getSqlQuery("sel_perm_exstFacility^"+StrAppno);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						if(secappno.equalsIgnoreCase(""))
							secappno="'"+Helper.correctNull(rs.getString("perm_exist_appno"))+"'";
						else
							secappno=secappno+",'"+Helper.correctNull(rs.getString("perm_exist_appno"))+"'";
					}
						if(!secappno.equals(""))
						{	
							strQuery=SQLParser.getSqlQuery("sel_secappno_permgist^"+secappno);
							rs=DBUtils.executeQuery(strQuery);
							while(rs.next())
							{
								hshQueryValues = new HashMap();
								hshQuery = new HashMap();		
								arrValues=new ArrayList();
								hshQuery.put("strQueryId","ins_perm_exstsec");
								arrValues.add(StrAppno);
								arrValues.add(Helper.correctNull(rs.getString("APP_SEC_APPNO")));
								arrValues.add(Helper.correctNull(rs.getString("APP_SEC_FACSNO")));
								arrValues.add(Helper.correctNull(rs.getString("APP_SEC_SECID")));
								arrValues.add(Helper.correctNull(rs.getString("PERAPP_FNAME")));
								arrValues.add(Helper.correctNull(rs.getString("APP_SEC_DESCRIPTION")));
								arrValues.add(Helper.correctNull(rs.getString("APP_SEC_SECURITYVALUE")));
								arrValues.add(Helper.correctNull(rs.getString("APP_SEC_SECURITYTYPE")));
								arrValues.add(Helper.correctNull(rs.getString("APP_SEC_MARGIN")));
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("1",hshQuery);
								hshQueryValues.put("size","1");
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
							}
						}
						
						if(!Helper.correctNull((String)hshValues.get("hidSubType")).equalsIgnoreCase("5"))
						{
							
							String strbankdesc="";
							strQuery = SQLParser.getSqlQuery("perbankingselectNewOldId_perm^"+StrAppno);
							rs = DBUtils.executeQuery(strQuery);
							while(rs.next())
							{
								hshQueryValues = new HashMap();
								hshQuery = new HashMap();		
								arrValues=new ArrayList();
								hshQuery.put("strQueryId","ins_perm_exstotherbank");
								arrValues.add(StrAppno);
								arrValues.add(Helper.correctNull(rs.getString("perbank_bnkname")));
								arrValues.add(Helper.correctNull(rs.getString("perbank_facility")));
								arrValues.add(Helper.correctNull(rs.getString("perbank_limit")));
								arrValues.add(Helper.correctNull(rs.getString("perbank_duedate")));
								arrValues.add(Helper.CLOBToString(rs.getClob("perbank_arrears")));
								arrValues.add("E");
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("1",hshQuery);
								hshQueryValues.put("size","1");
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
							}
							
							String strcbsid="";
							strQuery= SQLParser.getSqlQuery("sel_perm_memberslist^"+StrAppno);
							rs=DBUtils.executeQuery(strQuery);
							while(rs.next())
							{
								strcbsid=strcbsid+"','"+Helper.correctNull(rs.getString("PERAPP_CBSID"));
							
							}
								if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
								{
										strQuery=SQLParser.getCBSSqlQuery("sel_deposit_det_perm^"+strcbsid.replaceFirst("','",""));
										rs=DBUtils.executeQueryCBSConnection(strQuery);
								}
								else
								{
									strQuery=SQLParser.getCBSSqlQuery("sel_deposit_val_perm^"+strcbsid.replaceFirst("','",""));
									rs=DBUtils.executeQueryCBSConnection(strQuery);
								}
								while(rs.next())
								{
									hshQueryValues = new HashMap();
									hshQuery = new HashMap();		
									arrValues=new ArrayList();
									hshQuery.put("strQueryId","ins_perm_exstdeposit");
									arrValues.add(StrAppno);
									arrValues.add(Helper.correctNull(rs.getString("loan_standname")));
									arrValues.add(Helper.correctNull(rs.getString("loan_accno")));
									arrValues.add(Helper.correctNull(rs.getString("loan_faceval")));
									arrValues.add(Helper.correctNull(rs.getString("loan_presentos")));
									arrValues.add(Helper.correctNull(rs.getString("loan_matdate")));
									arrValues.add(Helper.correctNull(rs.getString("loan_rateofint")));
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put("1",hshQuery);
									hshQueryValues.put("size","1");
									EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
								}
							}	
						}
			}
			else if (strAction.equalsIgnoreCase("Undo"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","update_freeze_permissiongist");
				arrValues.add("N");
				arrValues.add(Helper.correctNull((String)hshValues.get("strappno")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_perm_exstfac");
				arrValues.add(StrAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_perm_exstsec");
				arrValues.add(StrAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				hshQueryValues.put("size","2");
				
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_perm_exstotherbank");
				arrValues.add(StrAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("3",hshQuery);
				hshQueryValues.put("size","3");
				
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_perm_exstdeposit");
				arrValues.add(StrAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("4",hshQuery);
				hshQueryValues.put("size","4");

				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}

		}
		catch(Exception e)
		{
			throw new EJBException("Error in updatepermissionGistData "+e.getMessage());
		}

	}	

	
	public HashMap getPermissionGistData (HashMap hshValues) 
	{

		String strQuery="",strQuery1= "",strHunterCheck="";
		String absPosition="";
		ResultSet rs=null;
		ResultSet rs1=null;
		HashMap hshResult=new HashMap();
		ArrayList arryRow=new ArrayList();
		ArrayList arryCol=null;
		ArrayList arrCol=new ArrayList();
		ArrayList arrRow=null;
		ArrayList arrRow7=new ArrayList();
		ArrayList arrCol7=new ArrayList();
		ArrayList arrRow6=new ArrayList();
		ArrayList arrCol6=new ArrayList();
		ArrayList arrRow5=new ArrayList();
		ArrayList arrCol5=new ArrayList();
		ArrayList arrRow8=new ArrayList();
		ArrayList arrCol8=new ArrayList();
		ArrayList arrRow9=new ArrayList();
		ArrayList arrCol9=new ArrayList();
		
		ArrayList arrRow_mem=new ArrayList();
		ArrayList arrCol_mem=new ArrayList();
		String strpermType=correctNull((String)hshValues.get("permtype"));
		String pagefrom=correctNull((String)hshValues.get("pagefrom"));
		String devsubtype=correctNull((String)hshValues.get("devsubtype"));
		String appno=correctNull((String)hshValues.get("appno"));
		String strCBDSID=correctNull((String)hshValues.get("DEV_CBSID"));
		
		if(appno.equals(""))
		{
			appno=correctNull((String)hshValues.get("hidAppno"));
		}
		try
		{
			if(rs!=null)
			{
				rs.close();
			}
			strQuery= SQLParser.getSqlQuery("sel_appl_deviation^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			arrRow=new ArrayList();
			if(rs.next())
			{
				
				hshValues.put("DEV_FREEZE_FLAG",correctNull(rs.getString("DEV_FREEZE_FLAG")));

				hshValues.put("DEV_APPNO",correctNull(rs.getString("DEV_APPNO")));
				hshValues.put("DEV_TYPE",correctNull(rs.getString("DEV_TYPE")));
				hshValues.put("DEV_SUBTYPE",correctNull(rs.getString("DEV_SUBTYPE")));
				hshValues.put("DEV_WHTCUSAVAIL",correctNull(rs.getString("DEV_WHTCUSAVAIL")));
				hshValues.put("DEV_CBSID",correctNull(rs.getString("DEV_CBSID")));
				if(!correctNull(rs.getString("DEV_CBSID")).equalsIgnoreCase(""))
					hshValues.put("PG_APPL_EXIST","Yes");
				else
					hshValues.put("PG_APPL_EXIST","No");
				hshValues.put("DEV_DEVPARAM",correctNull(rs.getString("DEV_DEVPARAM")));
				hshValues.put("hidAppholder",correctNull(rs.getString("dev_applholder")));
				hshValues.put("DEV_APPSTATUS",correctNull(rs.getString("DEV_APPSTATUS")));
				hshValues.put("DEV_TYPE",correctNull(rs.getString("DEV_TYPE")));
				char readFlag=correctNull((String)hshValues.get("strGroupRights")).charAt(18);
				String btnenable=(""+readFlag).equals("r")?"N":(correctNull(rs.getString("DEV_APPSTATUS")).equalsIgnoreCase("OP") && correctNull(rs.getString("dev_applholder")).equals(correctNull((String)hshValues.get("strUserId"))))?"Y":"N";
				hshValues.put("btnenable",btnenable);
				
				rs1=DBUtils.executeLAPSQuery("getorgcode^"+Helper.correctNull(rs.getString("DEV_ORGSCODE")));
				if(rs1.next())
				{
					if(Helper.correctNull(rs1.getString("org_level")).equalsIgnoreCase("D"))
					hshValues.put("strCreatedOrg",correctNull(rs1.getString("org_name"))+" [CLPH]");
					else
					hshValues.put("strCreatedOrg",correctNull(rs1.getString("org_name")));
				}
				
				if(rs1!=null)
					rs1.close();
				strQuery = SQLParser.getSqlQuery("sel_SancRefNo^"+appno);
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{  
					hshValues.put("strSancRefno",Helper.correctNull(rs1.getString("sanctionrefno")));
				}
			}
			
			if(rs1!=null)
			{
				rs1.close();
			}
			strQuery= SQLParser.getSqlQuery("sel_perm_details^"+appno);
			rs1=DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				hshValues.put("hshorg_code",correctNull(rs1.getString("org_code")));
			}
		if(!Helper.correctNull((String)hshValues.get("hshorg_code")).equalsIgnoreCase(""))
		{
			String apporgcode=Helper.correctNull((String)hshValues.get("hshorg_code")).substring(0,6)+"000000000";
			if(rs1!=null)
			{
				rs1.close();
			}
			strQuery= SQLParser.getSqlQuery("selorgname^"+ apporgcode);
			rs1=DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				hshValues.put("hshorg_Regionname",correctNull(rs1.getString("org_name")));
			}
		}
			
			
				if(rs!=null)
				{
					rs.close();
				}
				strQuery= SQLParser.getSqlQuery("sel_permissionGist_Data^"+appno);
				rs=DBUtils.executeQuery(strQuery);
				arrRow=new ArrayList();
				if(rs.next())
				{
					hshValues.put("PG_APPLIANTNAME",correctNull(rs.getString("PG_APPLIANTNAME")));
					hshValues.put("PG_CONSTITUTION",correctNull(rs.getString("PG_CONSTITUTION")));
					hshValues.put("PG_MANAGEMENTDET",correctNull(rs.getString("PG_MANAGEMENTDET")));
					hshValues.put("PG_ACTIVITY",correctNull(rs.getString("PG_ACTIVITY")));
					hshValues.put("PG_ESTBDATE",correctNull(rs.getString("PG_ESTBDATE")));
					hshValues.put("PG_GRPCRCN_POT",correctNull(rs.getString("PG_GRPCRCN_POT")));
					
					hshValues.put("PG_EMPLOYERNAME",correctNull(rs.getString("PG_EMPLOYERNAME")));
					hshValues.put("PG_NOOFEMP_SALDRAW",correctNull(rs.getString("PG_NOOFEMP_SALDRAW")));
					hshValues.put("PG_NAMEOFTRUSTEE",correctNull(rs.getString("PG_NAMEOFTRUSTEE")).toUpperCase());
					hshValues.put("PG_EXCESSINCOME",correctNull(rs.getString("PG_EXCESSINCOME")));
				//	hshValues.put("PG_DET_DEPACC_PRESENTBAL",correctNull(rs.getString("PG_DET_DEPACC_PRESENTBAL")));
					

					/*
					if(!correctNull(rs.getString("PG_DET_DEPACC_PRESENTBAL")).equals(""))
					{
					String[] strDepAcc=Helper.correctNull(rs.getString("PG_DET_DEPACC_PRESENTBAL")).split("@");
					
					int deposite_acc=strDepAcc.length;
						for(int i=0;i<deposite_acc;i++)
						{
							String[] valtemp=strDepAcc[i].split("~");
							if(!valtemp.equals(""))
						      {
									arrCol6=new ArrayList(); 
									  
									arrCol6.add((valtemp[0].trim()).toUpperCase());
									arrCol6.add(valtemp[1].trim());
									arrCol6.add(valtemp[2].trim());
									arrCol6.add(valtemp[3].trim());
									arrCol6.add(valtemp[4].trim());
									arrCol6.add(valtemp[5].trim());
									
									arrRow6.add(arrCol6);				
							  }		
							  hshValues.put("arrData6", arrRow6);
						}
						
					}
					*/
					hshValues.put("PG_DEALINGSINCE",correctNull(rs.getString("PG_DEALINGSINCE")));

				//	hshValues.put("PG_EXSTFAC_PRIMESEC",correctNull(rs.getString("PG_EXSTFAC_PRIMESEC")));

					
					/*	if(!Helper.correctNull(Helper.CLOBToString(rs.getClob("PG_EXSTFAC_PRIMESEC"))).equals(""))
						{
						String[] strSecurity_fac=Helper.correctNull(Helper.CLOBToString(rs.getClob("PG_EXSTFAC_PRIMESEC"))).split("@");
						
						int Security_fac=strSecurity_fac.length;
							for(int i=0;i<Security_fac;i++)
							{
								String[] valtemp=strSecurity_fac[i].split("~");
								if(!valtemp.equals(""))
							      {
										arrCol9=new ArrayList(); 
										arrCol9.add(valtemp[0].trim());
										arrCol9.add(valtemp[1].trim());
										arrCol9.add(valtemp[2].trim());
										arrCol9.add(valtemp[3].trim());
										arrCol9.add(valtemp[4].trim());
										arrCol9.add(valtemp[5].trim());
										if(!valtemp[6].trim().equalsIgnoreCase(""))
										{
											if(valtemp[6].trim().equals("1"))
											{
												arrCol9.add("Primary");
											}
											else if(valtemp[6].trim().equals("2"))
											{
												arrCol9.add("Collateral");
											}
											else
											{
												arrCol9.add(valtemp[6].trim());
											}
										}
										else
										{
											arrCol9.add(valtemp[6].trim());
										}
										arrCol9.add(valtemp[7].trim());
										arrRow9.add(arrCol9);				
								  }		
								  hshValues.put("arrData9", arrRow9);
							}
							
						}else
						{
							hshValues.put("PG_EXSTFAC_PRIMESEC",Helper.correctNull(Helper.CLOBToString(rs.getClob("PG_EXSTFAC_PRIMESEC"))));
						}
						
					*/
					hshValues.put("PG_EXSTFAC_COLSEC",correctNull(rs.getString("PG_EXSTFAC_COLSEC")));
				//	hshValues.put("PG_DET_LOANACC_OTHBANK",correctNull(rs.getString("PG_DET_LOANACC_OTHBANK")));
					
					
					/*
					if(!Helper.correctNull(Helper.CLOBToString(rs.getClob("PG_DET_LOANACC_OTHBANK"))).equals(""))
					{
					String[] strOtherBank=Helper.correctNull(Helper.CLOBToString(rs.getClob("PG_DET_LOANACC_OTHBANK"))).split("@");
					
					int Other_Bank=strOtherBank.length;
						for(int i=0;i<Other_Bank;i++)
						{
							String[] valtemp=strOtherBank[i].split("~");
							if(!valtemp.equals(""))
						      {
									arrCol8=new ArrayList(); 
									arrCol8.add(valtemp[0].trim());
																		
									arrCol8.add(valtemp[1].trim());
									arrCol8.add(valtemp[2].trim());
									arrCol8.add(valtemp[3].trim());
									arrCol8.add(valtemp[4].trim());
									arrCol8.add(valtemp[5].trim());
									if(!valtemp[0].trim().equals(""))
									{
										if(rs1!=null)
										{
											rs1.close();
										}
										rs1 = DBUtils.executeLAPSQuery("getstaticdescription^"+"147"+"^"+valtemp[0].trim());
										if(rs1.next())
										{
											arrCol8.add(Helper.correctNull(rs1.getString("STAT_DATA_DESC1")));
										}
										else
										{
											arrCol8.add(valtemp[0].trim());
										}
									}	
									else
									{
										arrCol8.add(valtemp[0].trim());
									}
									arrRow8.add(arrCol8);				
							  }		
							  hshValues.put("arrData8", arrRow8);
						}
						
					}else
					{
						hshValues.put("PG_DET_LOANACC_OTHBANK",Helper.correctNull(Helper.CLOBToString(rs.getClob("PG_DET_LOANACC_OTHBANK"))));
					}
					*/
					hshValues.put("PG_ITRETURNS_TAXPAID",correctNull(rs.getString("PG_ITRETURNS_TAXPAID")));
				
					hshValues.put("PG_PROPFAC_SEC_PRIME",correctNull(rs.getString("PG_PROPFAC_SEC_PRIME")));
					
					
					hshValues.put("PG_PROPFAC_SEC_COLLATERAL",correctNull(rs.getString("PG_PROPFAC_SEC_COLLATERAL")));
					hshValues.put("PG_RSN_SWITCH",correctNull(rs.getString("PG_RSN_SWITCH")));
					hshValues.put("PG_ACC_INTRODBY",correctNull(rs.getString("PG_ACC_INTRODBY")));
					
					hshValues.put("PG_LANDCOST",correctNull(rs.getString("PG_LANDCOST")));
					hshValues.put("PG_PROMOTCONTRIB",correctNull(rs.getString("PG_PROMOTCONTRIB")));
					hshValues.put("PG_PERCENTTOTAL1",correctNull(rs.getString("PG_PERCENTTOTAL1")));
					hshValues.put("PG_CONSTRUCTIONCOST",correctNull(rs.getString("PG_CONSTRUCTIONCOST")));
					hshValues.put("PG_ADVANCEAMT",correctNull(rs.getString("PG_ADVANCEAMT")));
					hshValues.put("PG_PERCENTTOTAL2",correctNull(rs.getString("PG_PERCENTTOTAL2")));
					hshValues.put("PG_LOANFROMKBL",correctNull(rs.getString("PG_LOANFROMKBL")));
					hshValues.put("PG_PERCENTTOTAL3",correctNull(rs.getString("PG_PERCENTTOTAL3")));
					hshValues.put("PG_TOTPROJECTCOST",correctNull(rs.getString("PG_TOTPROJECTCOST")));
					hshValues.put("PG_TOTMEANSOFFINANCE",correctNull(rs.getString("PG_TOTMEANSOFFINANCE")));
					hshValues.put("PG_PERCENTTOTAL4",correctNull(rs.getString("PG_PERCENTTOTAL4")));
					hshValues.put("PG_SRC_MARGINMONEY",correctNull(rs.getString("PG_SRC_MARGINMONEY")));
				
					hshValues.put("PG_SRC_REPAYMENT",correctNull(rs.getString("PG_SRC_REPAYMENT")));
					hshValues.put("PG_TOTAREA",correctNull(rs.getString("PG_TOTAREA")));
					hshValues.put("PG_TOTBUILTUPAREA",correctNull(rs.getString("PG_TOTBUILTUPAREA")));
					hshValues.put("PG_FLOORDETAILS",correctNull(rs.getString("PG_FLOORDETAILS")));
					hshValues.put("PG_TOTCONSTCOST",correctNull(rs.getString("PG_TOTCONSTCOST")));
					hshValues.put("PG_AVGSELLINGPRICE_RF",correctNull(rs.getString("PG_AVGSELLINGPRICE_RF")));
					hshValues.put("PG_AVGSELLINGPRICE_CP",correctNull(rs.getString("PG_AVGSELLINGPRICE_CP")));
					hshValues.put("PG_PROJECTEDRENT",correctNull(rs.getString("PG_PROJECTEDRENT")));
					hshValues.put("PG_CONF_AUTH_CONSTBUILD",correctNull(rs.getString("PG_CONF_AUTH_CONSTBUILD")));

					hshValues.put("PG_SCHEME_GUIDELINES",correctNull(rs.getString("PG_SCHEME_GUIDELINES")));
					hshValues.put("PG_DEVPERM_SOUGHTOTHERS",correctNull(rs.getString("PG_DEVPERM_SOUGHTOTHERS")));
					hshValues.put("PG_EARLIERCONCESSION",correctNull(rs.getString("PG_EARLIERCONCESSION")));
					hshValues.put("PG_JUSTF_SPECCONSID",correctNull(rs.getString("PG_JUSTF_SPECCONSID")));
					hshValues.put("PG_CONCESSION_RECOMMENDED",correctNull(rs.getString("PG_CONCESSION_RECOMMENDED")));
					hshValues.put("PG_CONCESSION_JUSTIF",correctNull(rs.getString("PG_CONCESSION_JUSTIF")));
					hshValues.put("PG_DETOFVISIT",correctNull(rs.getString("PG_DETOFVISIT")));
					hshValues.put("PG_PARTYBG_EARPROJECTS",correctNull(rs.getString("PG_PARTYBG_EARPROJECTS")));
					hshValues.put("PG_DEVOBSERVED",correctNull(rs.getString("PG_DEVOBSERVED")));
					hshValues.put("PG_WHTPERM_EXTENDED",correctNull(rs.getString("PG_WHTPERM_EXTENDED")));
					hshValues.put("PG_TA_BRTOT_ACS",correctNull(rs.getString("PG_TA_BRTOT_ACS")));
					hshValues.put("PG_TA_BRTOT_AMT",correctNull(rs.getString("PG_TA_BRTOT_AMT")));
					hshValues.put("PG_TA_NPA_ACS",correctNull(rs.getString("PG_TA_NPA_ACS")));
					hshValues.put("PG_TA_NPA_AMT",correctNull(rs.getString("PG_TA_NPA_AMT")));
					hshValues.put("PG_TA_NPAPER_ACS",correctNull(rs.getString("PG_TA_NPAPER_ACS")));
					hshValues.put("PG_TA_NPAPER_AMT",correctNull(rs.getString("PG_TA_NPAPER_AMT")));
					hshValues.put("PG_SL_BRTOT_ACS",correctNull(rs.getString("PG_SL_BRTOT_ACS")));
					hshValues.put("PG_SL_BRTOT_AMT",correctNull(rs.getString("PG_SL_BRTOT_AMT")));
					hshValues.put("PG_SL_NPA_ACS",correctNull(rs.getString("PG_SL_NPA_ACS")));
					hshValues.put("PG_SL_NPA_AMT",correctNull(rs.getString("PG_SL_NPA_AMT")));
					hshValues.put("PG_SL_NPAPER_ACS",correctNull(rs.getString("PG_SL_NPAPER_ACS")));
					hshValues.put("PG_SL_NPAPER_AMT",correctNull(rs.getString("PG_SL_NPAPER_AMT")));
					hshValues.put("PG_LE_BRTOT_ACS",correctNull(rs.getString("PG_LE_BRTOT_ACS")));
					hshValues.put("PG_LE_BRTOT_AMT",correctNull(rs.getString("PG_LE_BRTOT_AMT")));
					hshValues.put("PG_LE_NPA_ACS",correctNull(rs.getString("PG_LE_NPA_ACS")));
					hshValues.put("PG_LE_NPA_AMT",correctNull(rs.getString("PG_LE_NPA_AMT")));
					hshValues.put("PG_LE_NPAPER_ACS",correctNull(rs.getString("PG_LE_NPAPER_ACS")));
					hshValues.put("PG_LE_NPAPER_AMT",correctNull(rs.getString("PG_LE_NPAPER_AMT")));
					hshValues.put("PG_ANYOTHER_INFO",correctNull(rs.getString("PG_ANYOTHER_INFO")));
					hshValues.put("PG_RECOMMEND_BRANCH",correctNull(rs.getString("PG_RECOMMEND_BRANCH")));
					//hshValues.put("PG_EXISTING_FACILITY",correctNull(rs.getString("PG_EXISTING_FACILITY")));
					hshValues.put("PG_CIBIL_SCORE",correctNull(rs.getString("PG_CIBIL_SCORE")));
					hshValues.put("PG_CIBIL_REPORTEDDATE",correctNull(rs.getString("PG_CIBIL_REPORTEDDATE")));
					hshValues.put("PG_CIBIL_DETAILS",correctNull(rs.getString("PG_CIBIL_DETAILS")));
					hshValues.put("PG_CRIF_SCORE",correctNull(rs.getString("PG_CRIF_SCORE")));
					hshValues.put("PG_CRIF_DATE",correctNull(rs.getString("PG_CRIF_DATE")));
					hshValues.put("PG_CRIF_DETAILS",correctNull(rs.getString("PG_CRIF_DETAILS")));
					hshValues.put("PG_PRIME_SECVAL",correctNull(rs.getString("PG_PRIME_SECVAL")));
					hshValues.put("PG_COLLATERAL_SECVAL",correctNull(rs.getString("PG_COLLATERAL_SECVAL")));
					
					if(rs1!=null)
					{
						rs1.close();
					}
					String strdev_type="";
					strQuery= SQLParser.getSqlQuery("sel_appl_deviation^"+appno);
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						strdev_type=Helper.correctNull(rs1.getString("DEV_SUBTYPE"));
					}	
					
					hshValues.put("strdev_type",strdev_type);
					/*
					if(strdev_type.equalsIgnoreCase("5"))
					{	
						if(!Helper.correctNull(Helper.CLOBToString(rs.getClob("PG_EXISTING_FACILITY"))).equals(""))
						{
						String[] strfacilitydet=Helper.correctNull(Helper.CLOBToString(rs.getClob("PG_EXISTING_FACILITY"))).split("@");
						
						int strfacdet=strfacilitydet.length;
							for(int i=0;i<strfacdet;i++)
							{
								String[] valtemp=strfacilitydet[i].split("~");
								if(!valtemp.equals(""))
							      {
										arrCol5=new ArrayList(); 
										  
										arrCol5.add(valtemp[0].trim());
										arrCol5.add(valtemp[1].trim());
										arrCol5.add(valtemp[2].trim());
										arrCol5.add(valtemp[3].trim());
										arrCol5.add(valtemp[4].trim());
										arrCol5.add(valtemp[5].trim());
										arrCol5.add(valtemp[6].trim());
										arrCol5.add(valtemp[7].trim());
										arrCol5.add(valtemp[8].trim());
										arrCol5.add(valtemp[9].trim());
										arrCol5.add(valtemp[10].trim());
										arrRow5.add(arrCol5);				
								  }		
								  hshValues.put("arrData5", arrRow5);
							}
							
						}
						
					}else if(strdev_type.equalsIgnoreCase("3")||strdev_type.equalsIgnoreCase("4")||strdev_type.equalsIgnoreCase("6"))
					{
						
						if(!Helper.correctNull(Helper.CLOBToString(rs.getClob("PG_EXISTING_FACILITY"))).equals(""))
						{
						String[] strfacilitydet=Helper.correctNull(Helper.CLOBToString(rs.getClob("PG_EXISTING_FACILITY"))).split("@");
						
						int strfacdet=strfacilitydet.length;
							for(int i=0;i<strfacdet;i++)
							{
								String[] valtemp=strfacilitydet[i].split("~");
								System.out.print(valtemp.length);
								if(!valtemp.equals(""))
							      {
										arrCol5=new ArrayList(); 
										  
										arrCol5.add(valtemp[0].trim());
										arrCol5.add(valtemp[1].trim());
										arrCol5.add(valtemp[2].trim());
										arrCol5.add(valtemp[3].trim());
										arrCol5.add(valtemp[4].trim());
										arrCol5.add(valtemp[5].trim());
										arrCol5.add(valtemp[6].trim());
										arrCol5.add(valtemp[7].trim());
										arrCol5.add(valtemp[8].trim());
										arrCol5.add(valtemp[9].trim());
										arrCol5.add(valtemp[10].trim());
										arrCol5.add(valtemp[11].trim());
										arrCol5.add(valtemp[12].trim());
										arrCol5.add(valtemp[13].trim());
										arrRow5.add(arrCol5);				
								  }		
								  hshValues.put("arrData5", arrRow5);
							}
							
						}
						
					}
					else
					{
						//hshValues.put("PG_EXISTING_FACILITY",correctNull(rs.getString("PG_EXISTING_FACILITY")));
					}
					
					*/
					hshValues.put("PG_APPLADDRESS1",correctNull(rs.getString("PG_APPLADDRESS1")));
					hshValues.put("PG_APPLADDRESS2",correctNull(rs.getString("PG_APPLADDRESS2")));
					hshValues.put("PG_PINCODE",correctNull(rs.getString("PG_PINCODE")));
					hshValues.put("PG_PHONE_NUMBER",correctNull(rs.getString("PG_PHONE_NUMBER")));
					hshValues.put("PG_MAIL_ID",correctNull(rs.getString("PG_MAIL_ID")));
					hshValues.put("PG_CONSTITUTED_ON",correctNull(rs.getString("PG_CONSTITUTED_ON")));

					hshValues.put("PG_APPL_TITLE",correctNull(rs.getString("PG_APPL_TITLE")));
					hshValues.put("PG_INCEXPEN_DATE",correctNull(rs.getString("PG_INCEXPEN_DATE")));

					
					if(rs1 !=null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeLAPSQuery("sel_citynamebycode^"+ correctNull(rs.getString("PG_CITYCODE")));	
					if (rs1.next()) 
					{
						hshValues.put("PG_HIDCITYNAME",correctNull(rs1.getString("city_name")));
						hshValues.put("PG_HIDCITY_CODE",correctNull(rs.getString("PG_CITYCODE")));
					}
										
					
					if(rs1 !=null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeLAPSQuery("sel_distnamebycode^"+ correctNull(rs.getString("PG_DISTCODE")));	
					if (rs1.next()) 
					{
						hshValues.put("PG_HID_DISTNAME",correctNull(rs1.getString("district_desc")));
						hshValues.put("PG_HID_DIST_CODE",correctNull(rs.getString("PG_DISTCODE")));

					}
					
					
					
					if(rs1 !=null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeLAPSQuery("sel_statenamebycode^"+ correctNull(rs.getString("PG_STATECODE")));	
					if (rs1.next()) 
					{
						hshValues.put("PG_HIDSTATENAME",correctNull(rs1.getString("state_name")));
						hshValues.put("PG_HIDSTATE_CODE",correctNull(rs.getString("PG_STATECODE")));
					}
					
					hshValues.put("PG_EXISINGFAC_BOWID",correctNull(rs.getString("PG_EXISINGFAC_BOWID")));
				    hshValues.put("PG_CRE_EXPOSURE",correctNull(rs.getString("PG_CRE_EXPOSURE")));
				    hshValues.put("PG_BOR_RATING",correctNull(rs.getString("PG_BOR_RATING")));
				    hshValues.put("PG_RATINGDATE",correctNull(rs.getString("PG_RATINGDATE")));
				}
				if(Helper.correctNull((String)hshValues.get("PG_APPL_EXIST")).equalsIgnoreCase("Yes"))
				{
					
					if(rs!=null)
					{
						rs.close();
					}
					String perappid="";
					rs=DBUtils.executeLAPSQuery("perapplicant_selcbsid^"+Helper.correctNull((String)hshValues.get("DEV_CBSID")));
					if(rs.next())
					{
						perappid=correctNull(rs.getString("perapp_id"));
					}
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("sel_common_customer^"+perappid);				 
					if(rs.next())
					{
						hshValues.put("PG_APPL_TITLE",correctNull(rs.getString("perapp_title")));
						hshValues.put("PG_APPLIANTNAME",correctNull(rs.getString("perapp_fname")));
						hshValues.put("PG_CONSTITUTION",correctNull(rs.getString("perapp_constitution")));
						hshValues.put("PG_DEALINGSINCE",correctNull(rs.getString("perapp_banksince")));
						hshValues.put("PG_ACC_INTRODBY",correctNull(rs.getString("perapp_introname")));
						hshValues.put("perapp_bank",correctNull(rs.getString("perapp_bank")));
					}
					
					if(rs!=null)
					{
						rs.close();
					}
					strQuery=SQLParser.getSqlQuery("sel_applKYCNorms^"+perappid);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshValues.put("PG_ACTIVITY",Helper.correctNull(rs.getString("kyc_kycActivity")));
					}
					
										
					if(rs!=null)
					{
						rs.close();
					}
					strQuery=SQLParser.getSqlQuery("sel_customerdetail^"+perappid);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{  	
						hshValues.put("PG_PHONE_NUMBER",correctNull(rs.getString("CON_MOBILE")));
						hshValues.put("PG_MAIL_ID",correctNull(rs.getString("CON_EMAIL")));

						if(correctNull(rs.getString("INDINFO_RESIDENT_STATUS")).equalsIgnoreCase("N"))
						{
							hshValues.put("PG_APPLADDRESS1",correctNull(rs.getString("CON_COMADDR1")));
							hshValues.put("PG_APPLADDRESS2",correctNull(rs.getString("CON_COMADDR2")));
							hshValues.put("PG_PINCODE",correctNull(rs.getString("CON_COMZIP")));
							if(rs1 !=null)
							{
								rs1.close();
							}
							rs1=DBUtils.executeLAPSQuery("sel_citynamebycode^"+ correctNull(rs.getString("CON_COMCITY")));	
							if (rs1.next()) 
							{
								hshValues.put("PG_HIDCITYNAME",correctNull(rs1.getString("city_name")));
								hshValues.put("PG_HIDCITY_CODE",correctNull(rs.getString("CON_COMCITY")));
							}
												
							
							if(rs1 !=null)
							{
								rs1.close();
							}
							rs1=DBUtils.executeLAPSQuery("sel_distnamebycode^"+ correctNull(rs.getString("CON_COMDIST")));	
							if (rs1.next()) 
							{
								hshValues.put("PG_HID_DISTNAME",correctNull(rs1.getString("district_desc")));
								hshValues.put("PG_HID_DIST_CODE",correctNull(rs.getString("CON_COMDIST")));
	
							}
							
							
							
							if(rs1 !=null)
							{
								rs1.close();
							}
							rs1=DBUtils.executeLAPSQuery("sel_statenamebycode^"+ correctNull(rs.getString("CON_COMSTATE")));	
							if (rs1.next()) 
							{
								hshValues.put("PG_HIDSTATENAME",correctNull(rs1.getString("state_name")));
								hshValues.put("PG_HIDSTATE_CODE",correctNull(rs.getString("CON_COMSTATE")));
							}
						}
						else
						{
							hshValues.put("PG_APPLADDRESS1",correctNull(rs.getString("CON_PERMADDR1")));
							hshValues.put("PG_APPLADDRESS2",correctNull(rs.getString("CON_PERMADDR2")));
							hshValues.put("PG_PINCODE",correctNull(rs.getString("CON_PERMZIP")));
							if(rs1 !=null)
							{
								rs1.close();
							}
							rs1=DBUtils.executeLAPSQuery("sel_citynamebycode^"+ correctNull(rs.getString("CON_PERMCITY")));	
							if (rs1.next()) 
							{
								hshValues.put("PG_HIDCITYNAME",correctNull(rs1.getString("city_name")));
								hshValues.put("PG_HIDCITY_CODE",correctNull(rs.getString("CON_PERMCITY")));
							}
												
							
							if(rs1 !=null)
							{
								rs1.close();
							}
							rs1=DBUtils.executeLAPSQuery("sel_distnamebycode^"+ correctNull(rs.getString("CON_PERMDIST")));	
							if (rs1.next()) 
							{
								hshValues.put("PG_HID_DISTNAME",correctNull(rs1.getString("district_desc")));
								hshValues.put("PG_HID_DIST_CODE",correctNull(rs.getString("CON_PERMDIST")));

							}
							
							
							
							if(rs1 !=null)
							{
								rs1.close();
							}
							rs1=DBUtils.executeLAPSQuery("sel_statenamebycode^"+ correctNull(rs.getString("CON_PERMSTATE")));	
							if (rs1.next()) 
							{
								hshValues.put("PG_HIDSTATENAME",correctNull(rs1.getString("state_name")));
								hshValues.put("PG_HIDSTATE_CODE",correctNull(rs.getString("CON_PERMSTATE")));
							}
						}
					}
					
					if(rs!=null)
					{
						rs.close();
					}
					String strmanagDet="";
					rs=DBUtils.executeLAPSQuery("comapp_division_details_sel^"+perappid);
					while(rs.next())
					{
						if(strmanagDet.equalsIgnoreCase(""))
							strmanagDet = Helper.correctNull(rs.getString("comapp_div_name"))+"~"+Helper.correctNull(rs.getString("comapp_divisiontype"))+"~"+Helper.correctNull(rs.getString("COMAPP_DIVISIONSUBTYPE"))+"~Y";
							else
								strmanagDet = strmanagDet+"@"+Helper.correctNull(rs.getString("comapp_div_name"))+"~"+Helper.correctNull(rs.getString("comapp_divisiontype"))+"~"+Helper.correctNull(rs.getString("COMAPP_DIVISIONSUBTYPE"))+"~Y";
					}
					if(!strmanagDet.equalsIgnoreCase(""))
					hshValues.put("PG_MANAGEMENTDET",strmanagDet);
					
					if(rs!=null)
					{
						rs.close();
					}
					strQuery=SQLParser.getSqlQuery("sel_kartaname^"+perappid+"^T^001");
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshValues.put("PG_NAMEOFTRUSTEE",Helper.correctNull(rs.getString("name")));
					}
					
					
					
				}
				
				if(rs!=null)
					rs.close();
				strQuery= SQLParser.getSqlQuery("sel_permissionGist_loanreq^"+appno);
				ArrayList arrCol1= new ArrayList();
				ArrayList arrRow1 = new ArrayList();
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol1 = new ArrayList();
					arrCol1.add(Helper.correctNull(rs.getString("DEV_PRESENT_NATURE")));
					arrCol1.add(Helper.correctNull(rs.getString("DEV_PRESENT_LOANAMT")));
					arrCol1.add(Helper.correctNull(rs.getString("DEV_PRESENT_INTEREST")));
					arrCol1.add(Helper.correctNull(rs.getString("DEV_PRESENT_PERIOD")));
					arrCol1.add(Helper.correctNull(rs.getString("DEV_PRESENT_PURPOSE")));
					arrCol1.add(Helper.correctNull(rs.getString("DEV_PRESENT_BANKSCHEME")));
					arrRow1.add(arrCol1);				
				}		
				hshValues.put("arrData", arrRow1);
				
				if(rs!=null)
				{
					rs.close();
				}
				strQuery= SQLParser.getSqlQuery("sel_appl_deviation_int^"+appno);
				rs=DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{
					String strQuery11="";
				
					String parameter=correctNull(rs.getString("DEV_DEVPARAM"));
					if(rs!=null)
					{rs.close();}
					if(!parameter.equalsIgnoreCase(""))
					{
						int countA=0;
						int countB=0;
						String strArr[]=parameter.split("@");
						for(int i=0;i<strArr.length;i++)
						{
							strQuery11 = SQLParser.getSqlQuery("sel_parameter^"+strArr[i]);
							rs = DBUtils.executeQuery(strQuery11);
						if (rs.next())
							{
								if(Helper.correctNull(rs.getString("PER_INTEREST")).equalsIgnoreCase("Y"))
								{
									countA++;
								}
								if(Helper.correctNull(rs.getString("PER_FINANCE")).equalsIgnoreCase("Y"))
								{
									countB++;
								}
								
							}
						}
						if(countA>0)
						{
							hshValues.put("ParamA","Y");
						}
						else
						{
							hshValues.put("ParamA","N");
						}
						if(countB>0)
						{
							hshValues.put("ParamB","Y");
						}
						else
						{
							hshValues.put("ParamB","N");
						}
						
					}
				}			
				
				if(rs!=null)
				{
					rs.close();
				}
				String strOrgSelect=correctNull((String)hshValues.get("strOrgSelect"));
				String demoid="";
				strQuery= SQLParser.getSqlQuery("sel_perm_memberslist^"+appno);
				rs=DBUtils.executeQuery(strQuery);
				String srt_memdet="";
				while(rs.next())
				{
					//demoid=Helper.correctNull(rs.getString("PERM_MEM_LAPSID"));
					
					srt_memdet=srt_memdet+"@"+Helper.correctNull(rs.getString("PERAPP_FNAME")).replace("@", "~")+"@"+Helper.correctNull(rs.getString("PERM_MEM_LAPSID"))+"@"+Helper.correctNull(rs.getString("PERAPP_CBSID"))+"@"+Helper.correctNull(rs.getString("PERM_MEM_ID"));
					
					/*
						arrCol_mem = new ArrayList();
						arrCol_mem.add(Helper.correctNull(rs.getString("PERAPP_FNAME")));
						arrCol_mem.add(demoid);
						arrCol_mem.add(Helper.correctNull(rs.getString("PERAPP_CBSID")));
						arrRow_mem.add(arrCol_mem);*/
				}		
				hshValues.put("arrRow_Mem", srt_memdet);
				
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeLAPSQuery("sel_querystatus^"+appno);
				if(rs.next())
				{
					if(Integer.parseInt(Helper.correctInt(rs.getString("cnt")))>0)
						hshValues.put("Query_Status", "No");
				}
				if(rs!=null)
				{
					rs.close();
				}
				

				/*strQuery1=SQLParser.getSqlQuery("sel_paramcheck^"+appno);
				rs = DBUtils.executeQuery(strQuery1);
				if(rs.next())
				{
					 strHunterCheck = Helper.correctNull((String) rs.getString("DEV_DEVPARAM"));
				}
				hshValues.put("strHunterCheck",strHunterCheck);
				
				
				String flag = "N";
				if (strHunterCheck.contains("@40@")) {
					flag = "Y";
				} else {
					flag = "N";
				}
				*/
				
				String strQuery2=null;
				ResultSet  rs4=null;
				   ArrayList arrCol4 = new ArrayList();
				   strQuery2=SQLParser.getSqlQuery("sel_permissionmaster");
				rs = DBUtils.executeQuery(strQuery2);
				while(rs.next()){
					strQuery2=SQLParser.getSqlQuery("sel_paramcheck^"+appno+"^"+Helper.correctInt((String) rs.getString("PER_ID")));
					rs4 = DBUtils.executeQuery(strQuery2);
					while(rs4.next())
					{
						   arrCol4.add(correctNull(rs.getString(1)));
						   arrCol4.add(correctNull(rs.getString(2)));
					}
				 
			}
				
				
				 int	intHuntScore=0;
				 String flag="";
				 
				 if (arrCol4 != null && arrCol4.size()> 0) {
						flag = "Y";
					}
					else
					{
						flag = "N";
					}

				 if(flag.equalsIgnoreCase("Y")){
				strQuery1 = SQLParser.getSqlQuery("sel_perpropcheck^"+Helper.correctNull((String)hshValues.get("DEV_CBSID")));
				rs=DBUtils.executeQuery(strQuery1); 

				if(rs.next()) {
					intHuntScore=Integer.parseInt( Helper.correctInt((String) rs.getString("DEF_HUNTER_SCORE")));
					 
				}
				 }
				
				/* strQuery1="";
				 int	intHuntScore=0;
				 
				 if(flag.equalsIgnoreCase("Y")){
				strQuery1 = SQLParser.getSqlQuery("sel_perpropcheck^"+strCBDSID);
				rs=DBUtils.executeQuery(strQuery1); 

				if(rs.next()) {
					intHuntScore=Integer.parseInt( Helper.correctNull((String) rs.getString("DEF_HUNTER_SCORE")));
					 
				}
				 }*/
				// hshValues.put("arrRow",arrRow);
				 hshValues.put("intHuntScore1",String.valueOf(intHuntScore));
				 hshValues.put("flag",flag);
		
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getPermissionGistData "+e.getMessage());
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
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		
		return hshValues;
	}
	
	
	public HashMap get_PermApplBackgroundData (HashMap hshValues) 
	{	
		HashMap hshRecord=new HashMap();
		String strQuery="";
		ResultSet rs = null;
		
		String strContent=correctNull((String) hshValues.get("txt_comments"));
		String hidAppno=correctNull((String) hshValues.get("appno"));  
		HashMap hshResult=new HashMap();
		try
		{
			strQuery = SQLParser.getSqlQuery("sel_perm_applbg_comments^"+hidAppno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshValues.put("CONTENT", correctNull(Helper.CLOBToString(rs.getClob("APPLBG_COMMENTS"))));
			}
		}
		catch (Exception ce) {
			throw new EJBException("Error in get_PermApplBackgroundData " + ce.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshValues;
	}
	
	
	public void updateBasicInformation(HashMap hshValues)
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		ResultSet rs = null;
	
		String strAction="";
		strAction=Helper.correctNull((String) hshValues.get("hidAction"));
		String strAppno="";
		
		try {
			strAppno=Helper.correctNull((String)hshValues.get("appno"));
		if(strAction.equals("delete"))
		{
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_basicinformation");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		} 
		else if(strAction.equalsIgnoreCase("edit"))
		{
			arrValues.add(strAppno);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","del_basicinformation");
			
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
				
			hshQuery=new HashMap();	
			arrValues=new ArrayList();	
			arrValues.add(strAppno);//050
			arrValues.add(correctNull((String)hshValues.get("sel_proposalsubmit")));//006
			arrValues.add(correctNull((String)hshValues.get("sel_SancDept")));//008
			arrValues.add(correctNull((String)hshValues.get("sel_SancAuth")));//26
			arrValues.add(correctNull((String)hshValues.get("sel_SancLevel")));//02
			arrValues.add(correctNull((String)hshValues.get("txt_procfee")));
			arrValues.add(correctNull((String)hshValues.get("txt_sancrefno")));
			arrValues.add(correctNull((String)hshValues.get("sanctiondate")));
			String sel_SancDept = Helper.correctNull((String)hshValues.get("sel_SancDept"));
			if(sel_SancDept.equalsIgnoreCase("017")){
				arrValues.add("CLPSC");
				}else{
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_SancBranch")));
				}
			arrValues.add(correctNull((String)hshValues.get("hid_perbranch")));
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","ins_perm_basicinformation");
			hshQueryValues.put("size","2");
			hshQueryValues.put("2",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		
			if(correctNull((String)hshValues.get("hid_sancdept_flag")).equals("Y"))
			{
				hshQuery=new HashMap();	
				arrValues=new ArrayList();	
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_recomments");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}			
		}
		
		}
		catch (Exception e) {
					// TODO Auto-generated catch block
			throw new EJBException("Error in updateBasicInformation "+e.toString());
				} 
		
	}
	
	public HashMap getAction(HashMap hshRequestValues) 
	{
		String strQuery = null,strQuery1="";
		ResultSet rs = null,rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null;
		HashMap hshRecord = new HashMap();
		HashMap hshValues = new HashMap();
		ArrayList arrWorkid = new ArrayList();
		ArrayList arrMaxclass = new ArrayList();
		ArrayList arrDuration = new ArrayList();
		ArrayList arrWorkflowname = new ArrayList();
		ArrayList arrflowpoint = new ArrayList();
		String strPrdCode ="3", perCbsId="";
		String strWorkflowType ="p",strPermissions="",strAction="",cbsStatus="",strSersaiDetail="",strOtherInfo="";
		HashMap hshCbsStatus = null;
		String strAppno=correctNull((String)hshRequestValues.get("appno"));
		String strAppstatus=correctNull((String)hshRequestValues.get("appstatus"));
		ArrayList arrDone=new ArrayList();
		String StrLoanTYpe="",strAppStatus="";
		ArrayList arrFlowpoint=new ArrayList();
		ArrayList arrAction=new ArrayList();	
		ArrayList arrClassDesc=new ArrayList();
		String strUserId=correctNull((String)hshRequestValues.get("strUserId"));  
	    String sessionModuleType =	correctNull((String)hshRequestValues.get("sessionModuleType"));
	    String appholder =	correctNull((String)hshRequestValues.get("appholder"));

		try
		{	
			/*rs=DBUtils.executeLAPSQuery("sel_loan_recalc_fac^"+ strAppno);			 
			if(rs.next()) 
			{
				hshRecord.put("LOAN_RECALCULATE_FACILITY",Helper.correctNull((String)rs.getString("LOAN_RECALCULATE_FACILITY")));
			}*/
			
			String currdate = Helper.getCurrentDateTime();
			SimpleDateFormat currformatdate = new SimpleDateFormat("dd/MM/yyyy");
			java.util.Date date7;
			date7 = currformatdate.parse(currdate);
			
			rs=DBUtils.executeLAPSQuery("sel_app_perm_no^"+ strAppno);			 
			if(rs.next()) 
			{
				StrLoanTYpe=Helper.correctNull((String)rs.getString("APP_LOANSUBTYPE_DIGI"));
	    		hshRecord.put("StrDigiLoanType",StrLoanTYpe);

			}
			if(StrLoanTYpe.equalsIgnoreCase("PR"))
			{
				//For Action
				strQuery=SQLParser.getSqlQuery("commworkflowsel2^"+strAppno);
	     		rs3=DBUtils.executeQuery(strQuery);
				if(rs3.next())
				{
					hshRecord.put("perm_sanccomments",correctNull(rs3.getString("app_sanctioningcomments")));
				}
				
				
				String strId="7";
				strQuery=SQLParser.getSqlQuery("commworkflowsel2^"+strAppno);
	     		rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strAppStatus=rs.getString("app_status");
					hshRecord.put("CBS_ACCOUNTNO",correctNull(rs.getString("CBS_ACCOUNTNO")));
					hshRecord.put("ApproveRejectedby",correctNull(rs.getString("app_approvedby")));

					if(!Helper.correctNull(rs.getString("APP_PROCESSDATE")).equalsIgnoreCase(""))
					{
						long intDatediff=0;
						intDatediff=Helper.dateDiff(Helper.correctNull(rs.getString("APP_PROCESSDATE")),Helper.getCurrentDateTime());
				    	if(intDatediff>7)
				    	{
				    		hshRecord.put("DEV_PROCESSDATE","Y");
				    	}
					}
					
		    		hshRecord.put("DEV_PROCESSDATE","N");
				}
				strQuery=SQLParser.getSqlQuery("commworkflowsel2^"+strAppno);
	     		rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("app_loantype",correctNull(rs.getString("app_loantype")));
					hshRecord.put("app_legalcomp",correctNull(rs.getString("app_legalcomp")));

				}
				rs=DBUtils.executeLAPSQuery("findapptype^"+strAppno);
				if(rs.next())
				{
					hshRecord.put("strPrdType",correctNull(rs.getString("prd_type")));
					hshRecord.put("prd_type", correctNull(rs.getString("prd_type")));

				}
				strQuery=SQLParser.getSqlQuery("commworkflowsel1^"+strAppno+"^<^9^>^0");
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					strQuery=SQLParser.getSqlQuery("commworkflowsel4^"+strAppno+"^"+rs.getString(1));
					if(rs1!=null)
					rs1.close();
					
					if(rs2!=null)
					rs2.close();
					
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						arrDone.add(rs1.getString(1));
					}		
					

					arrFlowpoint.add(rs.getString(1));
					arrAction.add(rs.getString(2));
					arrMaxclass.add(rs.getString(3));
					
					strQuery1=SQLParser.getSqlQuery("selclasslist_workflow^"+strId+"^"+correctNull(rs.getString(3)));
					rs2=DBUtils.executeQuery(strQuery1);
					if(rs2.next())
					{
						arrClassDesc.add(rs2.getString(4));
					}
				}
				
				if(strAppStatus.equalsIgnoreCase("op"))
				{
					arrDone.add("0");
				}
				else
				{
					arrDone.add("1");
				}

				if(!(strAppStatus.equalsIgnoreCase("op")||strAppStatus.equalsIgnoreCase("ol")))
				{
					if((strAppStatus.equalsIgnoreCase("pa")) || (strAppStatus.equalsIgnoreCase("ca"))) 
					{
						strQuery=SQLParser.getSqlQuery("commworkflowsel1^"+strAppno+"^<^17^>^8");
					}
					else if(strAppStatus.equalsIgnoreCase("pr") || strAppStatus.equalsIgnoreCase("cr"))
					{
						strQuery=SQLParser.getSqlQuery("commworkflowsel1^"+strAppno+"^<^25^>^16");
					}
					if(rs!=null)
					rs.close();	
					
					strId="7";
					
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						strQuery=SQLParser.getSqlQuery("commworkflowsel4^"+strAppno+"^"+rs.getString(1));
						if(rs1!=null)
						rs1.close();
						
						rs1=DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							arrDone.add(rs1.getString(1));
						}
						arrFlowpoint.add(rs.getString(1));
						arrAction.add(rs.getString(2));
						arrMaxclass.add(rs.getString(3));
						
						strQuery1=SQLParser.getSqlQuery("selclasslist_workflow^"+strId+"^"+correctNull(rs.getString(3)));
						if(rs2!=null)
							rs2.close();
							
						rs2=DBUtils.executeQuery(strQuery1);
						if(rs2.next())
						{
							arrClassDesc.add(rs2.getString(4));
						}
					}
				}
				hshRecord.put("arrDone",arrDone);
				hshRecord.put("arrflowpoint",arrFlowpoint);
				hshRecord.put("arrAction",arrAction);
				hshRecord.put("arrMaxclass",arrMaxclass);
				hshRecord.put("arrClassDesc",arrClassDesc);
				hshRecord.put("arrDone",arrDone);
				strQuery=SQLParser.getSqlQuery("commworkflowsel5^"+strAppno+"^"+strAppno+"^"+strAppno);
				if(rs!=null)
				rs.close();	
				
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("dev_toflowpoint",rs.getString(1));
					hshRecord.put("dev_sentdate",rs.getString(2));
					hshRecord.put("dueon_date",rs.getString(3));
					hshRecord.put("strMaxClass",rs.getString(4));
				}
				else
				{
					strQuery=SQLParser.getSqlQuery("commworkflowsel6^"+strAppno+"^"+strAppno);
					if(rs!=null)
					rs.close();	
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshRecord.put("dev_toflowpoint",rs.getString(1));
						hshRecord.put("dev_sentdate",rs.getString(2));
						hshRecord.put("dueon_date"," ");
					}
					else
					{
						strQuery=SQLParser.getSqlQuery("commworkflowsel7^"+strAppno+"^"+strAppno);
						if(rs!=null)
						rs.close();	
						
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							hshRecord.put("dev_toflowpoint","1");
							hshRecord.put("strMaxClass",rs.getString(1));
							hshRecord.put("dev_sentdate",rs.getString(2));
							hshRecord.put("dueon_date",rs.getString(3));
						}
					}
				}
				strAction=correctNull((String)hshRequestValues.get("hidAction"));
				if(strAction.trim().equalsIgnoreCase("send"))
				{
					hshRecord.put("status","SUCCESS");
					
				}
				
				String strFlowDateFlag="";
				
				//selloan_account_details
				String strQuery12=SQLParser.getSqlQuery("selloan_account_details^"+strAppno+"^"+"1");
				ResultSet rs12=DBUtils.executeQuery(strQuery12);
				if(rs12.next())
				{
					strFlowDateFlag="Y";
				}
				else
				{
					strFlowDateFlag="N";
				}
				hshRecord.put("strFlowDateFlag",strFlowDateFlag);
				
				if(rs!=null)
					rs.close();		
				
				rs=DBUtils.executeLAPSQuery("workflowusersanlimit^"+correctNull((String)hshRequestValues.get("strUserId")));
				if(rs.next())
				{
					hshRecord.put("usrfunction",correctNull(rs.getString("usr_function")));
				}
				
				String sendtoCBS="N";
				strQuery=SQLParser.getSqlQuery("sel_AccountHandOffDetails^"+strAppno);
				rs1=DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					sendtoCBS="Y";
				}
				strQuery=SQLParser.getSqlQuery("sel_AccountHandOffDetails_nfb^"+strAppno);
				rs1=DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					sendtoCBS="Y";
				}
				hshRecord.put("strSendToCBSFlag",sendtoCBS);
				
				// LMS Check
				
				if(rs!=null)
					rs.close();
				String strLmsCheck="";
				strQuery=SQLParser.getSqlQuery("sel_lapsapplicationparameters^122");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strLmsCheck=Helper.correctNull(rs.getString("LOAN_PARAMVAL"));
				}
				
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeLAPSQuery("sel_inward_proposed_values^" + strAppno);
				if (rs.next()) 
				{
					if(strLmsCheck.equalsIgnoreCase("Y") && (strAppStatus.equalsIgnoreCase("op")||strAppStatus.equalsIgnoreCase("ol")))
					{
						if(!(correctNull(rs.getString("inw_leadno")).equalsIgnoreCase("") || correctNull(rs.getString("inw_leadno")).equalsIgnoreCase("NA")))
						{
							ArrayList arrParam=new ArrayList();
							arrParam.add(correctNull(rs.getString("inw_leadno")).toUpperCase());
							if(ApplicationParams.getStrLMSConnection().equalsIgnoreCase("TRUE"))
								rs=DBUtils.executeLMSQuery("chk_leadstatus1", arrParam);
							else
								rs=DBUtils.executeLAPSQuery("chk_leadstatus^"+correctNull(rs.getString("inw_leadno")).toUpperCase());
							if(rs.next())
							{
								hshRecord.put("strLeadStatus", Helper.correctNull(rs.getString("lead_status")));
							}
							else
							{
								hshRecord.put("strLeadStatus","N");
							}
						}
					}
				}				
				
			}
			else
			{
				strAction=correctNull((String)hshRequestValues.get("hidAction"));
				strQuery = SQLParser.getSqlQuery("sel_appl_deviation^"+strAppno);
				rs = DBUtils.executeQuery(strQuery);	
				if(rs.next())
				{
					hshRecord.put("DEV_SUBTYPE",correctNull(rs.getString("DEV_SUBTYPE")));
					hshRecord.put("perm_appstatus",correctNull(rs.getString("DEV_APPSTATUS")));
					strAppstatus=correctNull(rs.getString("DEV_APPSTATUS"));
					strPermissions=correctNull(rs.getString("DEV_DEVPARAM"));
					hshRecord.put("perm_sanccomments",correctNull(rs.getString("dev_sanccmts")));
					hshRecord.put("ApproveRejectedby",correctNull(rs.getString("dev_processedby")));
					hshRecord.put("Appholdercheck",correctNull(rs.getString("dev_applholder")));
				}
	
				if(!strPrdCode.equals(""))
				{
					if(strAppstatus.equalsIgnoreCase("op"))
					{
						strQuery = SQLParser.getSqlQuery("prdsolkpowsel^" + strPrdCode + "^" +strWorkflowType);
						rs = DBUtils.executeQuery(strQuery);	
						while (rs.next()) 
						{
							arrWorkid.add(rs.getString("prd_workid"));
							arrMaxclass.add(rs.getString("prd_minclass"));
							arrDuration.add(rs.getString("prd_duration"));
							arrflowpoint.add(rs.getString("prd_flowpoint"));
							arrWorkflowname.add(rs.getString("wrk_flowname"));
						}
					}
				}
	
				if(!strAppstatus.equalsIgnoreCase("op"))
				{
					if((strAppstatus.equalsIgnoreCase("PA")) || (strAppstatus.equalsIgnoreCase("CA"))) 
					{
						strQuery=SQLParser.getSqlQuery("sel_prd_solkpowflowpoint1^<17^>8");
						rs = DBUtils.executeQuery(strQuery);	
						while (rs.next()) 
						{
							arrMaxclass.add(rs.getString("prd_minclass"));
							arrflowpoint.add(rs.getString("prd_flowpoint"));
							arrWorkflowname.add(rs.getString("wrk_flowname"));
						}
					}
					if((strAppstatus.equalsIgnoreCase("pr")) || (strAppstatus.equalsIgnoreCase("cr"))) 
					{
						strQuery=SQLParser.getSqlQuery("sel_prd_solkpowflowpoint1^<25^>16");
						rs = DBUtils.executeQuery(strQuery);	
						while (rs.next()) 
						{
							arrMaxclass.add(rs.getString("prd_minclass"));
							arrflowpoint.add(rs.getString("prd_flowpoint"));
							arrWorkflowname.add(rs.getString("wrk_flowname"));
						}
					}
				}
				hshRecord.put("strPrdCode", strPrdCode);
				hshRecord.put("prd_workid", arrWorkid);
				hshRecord.put("prd_minclass", arrMaxclass);
				hshRecord.put("prd_duration", arrDuration);
				hshRecord.put("arrflowpoint", arrflowpoint);
				hshRecord.put("wrk_flowname", arrWorkflowname);
	
				if(rs!=null)
					rs.close();
	
				strQuery = SQLParser.getSqlQuery("sel_perm_appmailbox^"+strAppno +"^"+strAppno);
				rs = DBUtils.executeQuery(strQuery);	
				if(rs.next())
				{
					hshRecord.put("dev_toflowpoint",correctNull(rs.getString("dev_toflowpoint")));
					hshRecord.put("dev_sentdate",correctNull(rs.getString("dev_sentdate")));
					hshRecord.put("dueon_date",correctNull(rs.getString("dueon_date")));
				}
				//code for enable by raja---
				String strQuery2="";
				String strEnableFlag="N";
				int count=0;
				if (rs != null)
				{rs.close();}
				if(!strPermissions.equalsIgnoreCase(""))
				{
					String strArr[]=strPermissions.split("@");
					for(int i=0;i<strArr.length;i++)
					{
						strQuery2 = SQLParser.getSqlQuery("sel_permMaster_flow^"+strArr[i]);
						rs = DBUtils.executeQuery(strQuery2);
						if (rs.next())
						{
							if(Helper.correctNull(rs.getString("per_status")).equalsIgnoreCase("E"))
							{
								hshRecord.put("strEnableFlag","Y");
							}
							if(Helper.correctNull(rs.getString("per_status")).equalsIgnoreCase("D"))
							{
								count++;
							}
							if(count>0)
							{
								hshRecord.put("strEnableFlag","N");
							}
						}
					}
				}
				
				//===end======
				
				String Authority="",strorghead="";
				String Del_Power="";
				strQuery= SQLParser.getSqlQuery("selapplnholderhead1^"+strAppno);
				if(rs1!=null)
					rs1.close();
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					strorghead=correctNull(rs1.getString("org_head"));
				}
				if(strorghead.equals(correctNull((String)hshRequestValues.get("strUserId"))))
				{
					hshRecord.put("orghead","Y");
				}
				else
				{
					hshRecord.put("orghead","N");
				}
				
				if(rs!=null)
					rs.close();		
				
				rs=DBUtils.executeLAPSQuery("workflowusersanlimit^"+correctNull((String)hshRequestValues.get("strUserId")));
				if(rs.next())
				{
					hshRecord.put("usrfunction",correctNull(rs.getString("usr_function")));
				}
				
				String strApproveFlag="",strRejectFlag="";
				String strUserClass=Helper.correctInt((String)hshRequestValues.get("strUserClass"));
				String strOrgLevel=Helper.correctNull((String)hshRequestValues.get("strOrgLevel"));
				int idLevel=0;
				if(strOrgLevel.equalsIgnoreCase("A"))
					idLevel=1;
				else if(strOrgLevel.equalsIgnoreCase("D"))
					idLevel=2;
				else if(strOrgLevel.equalsIgnoreCase("R"))
					idLevel=3;
				else if(strOrgLevel.equalsIgnoreCase("C"))
					idLevel=4;
				if(!strPermissions.equalsIgnoreCase(""))
				{
					String strArr[]=strPermissions.split("@");
					for(int i=0;i<strArr.length;i++)
					{
						if(rs!=null)
							rs.close();
						rs=DBUtils.executeLAPSQuery("sel_permission_master^"+strArr[i]);
						if(rs.next())
						{
							if(!strApproveFlag.equalsIgnoreCase("N"))
							{
								if((Integer.parseInt(Helper.correctInt(rs.getString("prd_approval")))<=Integer.parseInt(strUserClass))&&
										(idLevel>=Integer.parseInt(Helper.correctInt(rs.getString("per_orgapp")))))
								{
									strApproveFlag="Y";
								}
								else
								{
									strApproveFlag="N";
								}
							}
							if(!strRejectFlag.equalsIgnoreCase("N"))
							{
								if((Integer.parseInt(Helper.correctInt(rs.getString("prd_reject")))<=Integer.parseInt(strUserClass))&&
										(idLevel>=Integer.parseInt(Helper.correctInt(rs.getString("per_orgrej")))))
								{
									strRejectFlag="Y";
								}
								else
								{
									strRejectFlag="N";
								}
							}
						}	
					}
				}
				hshRecord.put("strApproveFlag",strApproveFlag);
				hshRecord.put("strRejectFlag",strRejectFlag);
				
				if(strAction.trim().equalsIgnoreCase("send"))
				{
					hshRecord.put("status","SUCCESS");
					
				}
				
				
				if(rs!=null)
					rs.close();
				
				rs = DBUtils.executeLAPSQuery("sel_basicinformation^" + strAppno);
				if (rs.next()) 
				{
					hshRecord.put("strBasicInfoFlag","Y");
				}
				
			///////////////	
				
	//			if(rs!=null)
	//				rs.close();
	//			
	//			strQuery= SQLParser.getSqlQuery("sel_permissionGist_Data^"+strAppno);
	//			rs=DBUtils.executeQuery(strQuery);
	//			if(rs.next())
	//			{
	//				if(correctNull(rs.getString("PG_RECOMMEND_HOVIEW")).equalsIgnoreCase(""))
	//				{
	//					hshRecord.put("PG_RECOMMEND_HOVIEW","Yes");
	//				}
	//				
	//				if(correctNull(rs.getString("PG_RECOMMEND_HO")).equalsIgnoreCase(""))
	//				{
	//					hshRecord.put("PG_RECOMMEND_HO","Yes");
	//				}
	//			}
				
				if(rs!=null)
				{
					rs.close();
				}
				ArrayList arrParam=new ArrayList();
				strQuery= SQLParser.getSqlQuery("sel_appl_deviation_int^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{
					String strQuery11="";
				
					String parameter=correctNull(rs.getString("DEV_DEVPARAM"));
					if(rs!=null)
					{rs.close();}
					if(!parameter.equalsIgnoreCase(""))
					{
						int countA=0;
						int countB=0;
						String strArr[]=parameter.split("@");
						for(int i=0;i<strArr.length;i++)
						{
							arrParam.add(strArr[i]);
							strQuery11 = SQLParser.getSqlQuery("sel_parameter^"+strArr[i]);
							rs = DBUtils.executeQuery(strQuery11);
							if (rs.next())
							{
								if(Helper.correctNull(rs.getString("PER_INTEREST")).equalsIgnoreCase("Y"))
								{
									countA++;
								}
								if(Helper.correctNull(rs.getString("PER_FINANCE")).equalsIgnoreCase("Y"))
								{
									countB++;
								}
								
							}
						}
						if(countA>0)
						{
							hshValues.put("ParamA","Y");
							
							if(rs1!=null)
								rs1.close();
							
							strQuery= SQLParser.getSqlQuery("select_PERM_ASSESSMENT_master11^"+strAppno);
							rs1=DBUtils.executeQuery(strQuery);
							if(rs1.next())
							{
								
								if(!correctNull(rs1.getString("PERM_HO_VALUE")).equalsIgnoreCase(""))
								{
									hshRecord.put("PERM_HO_VALUE","Y");
								}
								
								hshRecord.put("Int_con_Asses","Y");
							}
						}
						if(countB>0)
						{
							hshValues.put("ParamB","Y");
							
							if(rs1!=null)
								rs1.close();
							
								strQuery= SQLParser.getSqlQuery("sel_permfinancial^"+strAppno+"^"+"1");
								rs1=DBUtils.executeQuery(strQuery);
								if(rs1.next())
								{
									hshRecord.put("PERM_FINANCE","Y");
								}
						}
					}
				}
				
				hshRecord.put("arrParam",arrParam);
				//Query
				if(rs!=null)
					rs.close();
				
				rs=DBUtils.executeLAPSQuery("sel_app_querydetails^"+strAppno);
				int val=0,val1=0;
				while(rs.next())
				{
					val++;
					if(Helper.correctNull(rs.getString("aq_status")).equalsIgnoreCase("QC"))
					{
						val1++;
					}
				}
				if(val==val1)
				{
						hshRecord.put("QUERY_STATUS","Y");
				}
				
				//Document Attached
				if(rs!=null)
					rs.close();
				
				 strQuery=SQLParser.getSqlQuery("sel_app_attacheddocments^"+strAppno +"^"+"O");
				 rs=DBUtils.executeQuery(strQuery);
				 if(rs.next())
				 {
					 hshRecord.put("DOCUMNET_STATUS","Y");
				 }
				 else
				 {
					 hshRecord.put("DOCUMNET_STATUS","N");
				 }
				 
				//sanction undo button enable
				 if(rs!=null)
						rs.close();
					
				long intDatediff=0;
				strQuery=SQLParser.getSqlQuery("sel_appl_deviation^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					if(!Helper.correctNull(rs.getString("DEV_PROCESSDATE")).equalsIgnoreCase(""))
					{
						intDatediff=Helper.dateDiff(Helper.correctNull(rs.getString("DEV_PROCESSDATE")),Helper.getCurrentDateTime());
				    	if(intDatediff>7)
				    	{
				    		hshRecord.put("DEV_PROCESSDATE","Y");
				    	}
					}	
				} 
				//recommendation tab
				if(rs!=null)
					rs.close();
				
				strQuery = SQLParser.getSqlQuery("sel_recomments^"+strAppno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("strComments","Y");
				}
				//recommendation tab
				if(rs!=null)
					rs.close();
				
				strQuery = SQLParser.getSqlQuery("sel_permappno^"+strAppno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("strProposalFlag","Y");
				}
			
			}
			
			
			
			strQuery = SQLParser.getSqlQuery("sel_cbs_status^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				String custflag=correctNull(rs.getString("PERAPP_CBSCUSTFLAG"));
				if(custflag.equals("N"))
				{
					hshRecord.put("ctrcustflag",custflag);
				}
			}
			strQuery=SQLParser.getSqlQuery("sel_sanctionstatus^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				
				hshRecord.put("strsanction","Y");	
			
			}
		
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_applications_freeze_flag^"+strAppno);
    		rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("strCoAppFreezeflag",Helper.correctNull((String)rs.getString("app_freeze_flag")));
			}
			
			if(rs!=null) rs.close();
			strQuery=SQLParser.getSqlQuery("sel_attachedsecurities_retail^"+strAppno);
    		rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("strSecuirtyFlag","N");
			}
			else
			{
				hshRecord.put("strSecuirtyFlag","Y");
			}
			
			
			if(rs1!=null) rs1.close();
			strQuery=SQLParser.getSqlQuery("sel_cuscbsacdetails^"+strAppno);
			rs1=DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				if(!Helper.correctNull(rs1.getString("NATUREOFADV")).equalsIgnoreCase(""))
					hshRecord.put("CBSDetails","Y");
			}
			
			if(rs1!=null)
			{	  rs1.close(); 	}
			strQuery=SQLParser.getSqlQuery("sel_mispagedetails^"+strAppno);
			rs1=DBUtils.executeQuery(strQuery);
			String strPriorityType="";
			if(rs1.next())
			{
				strPriorityType=Helper.correctNull((String)rs1.getString("app_sector"));
			}
			if(!strPriorityType.equalsIgnoreCase(""))
			{
				hshRecord.put("MISDetails","Y");
			}	
			
			strQuery=SQLParser.getSqlQuery("sel_per_bir^"+strAppno);
			rs1=DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				hshRecord.put("strbirdata","Y");	
			}
			else
			{
				hshRecord.put("strbirdata","N");	
			}	

			ArrayList arrDoc=new ArrayList();
			strQuery=SQLParser.getSqlQuery("chk_perapp_docattach^"+strAppno+"^O");					
			rs1=DBUtils.executeQuery(strQuery);
			while(rs1.next())
			{
				arrDoc.add(Helper.correctNull(rs1.getString("apa_doccode")));
			}
			hshRecord.put("arrDoc", arrDoc);

	
			
			String strAmberexist="N",strAMBERRULES="",amberApproval="";
			rs = DBUtils.executeLAPSQuery("sel_appl_cibildetails^" + strAppno);
			while(rs.next())
			{
				 strAMBERRULES=Helper.correctNull((String)rs.getString("DEMO_DIGI_AMBERRULES"));
				if(!strAMBERRULES.equals("")){
					strAmberexist="Y";
					rs4 = DBUtils.executeLAPSQuery("sel_approve^" + strAppno+"^"+Helper.correctNull((String)rs.getString("PERAPP_ID")));
					if(rs4.next())
					{
						if(!(Helper.correctNull((String)rs4.getString("DEMO_AMBER_APPROVAL")).equals("")||
								Helper.correctNull((String)rs4.getString("DEMO_AMBER_APPROVAL")).equals("N")))
							amberApproval="YN";
					}
				
				}
			
			}
			if(strAmberexist.equals("N"))
				amberApproval="YN";
			hshRecord.put("amberApproval", amberApproval);


			if(rs1!=null)
			{	  rs1.close(); 	}
			strQuery=SQLParser.getSqlQuery("sel_amber_approval^"+strAppno);
			rs1=DBUtils.executeQuery(strQuery);
			String strAmberCheck="";
			if(rs1.next())
			{
				strAmberCheck=Helper.correctNull((String)rs1.getString("DEMO_AMBER_APPROVAL"));
			}
			hshRecord.put("strAmberCheck", strAmberCheck);
			
			if(rs1!=null)
			{	  rs1.close(); 	}
			strQuery=SQLParser.getSqlQuery("sel_Usrclass^"+strAppno);
			rs1=DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
					hshRecord.put("strUsrClass",Helper.correctNull((String)rs1.getString("USR_CLASS")));
					hshRecord.put("strUsrFctn",Helper.correctNull((String)rs1.getString("USR_FUNCTION")));
			}
			if(rs1!=null)
			{	  rs1.close(); 	}
			strQuery=SQLParser.getSqlQuery("sel_classAuth^"+strAppno);
			rs1=DBUtils.executeQuery(strQuery);
			String strOrgLevel="";
			if(rs1.next())
			{
				/*strOrgLevel=Helper.correctNull((String)rs1.getString("org_level"));
				
				if(strOrgLevel.equalsIgnoreCase("C")){
					hshRecord.put("strClassAuth",Helper.correctNull((String)rs1.getString("PRD_HO")));
				}
				if(strOrgLevel.equalsIgnoreCase("R")){
					hshRecord.put("strClassAuth",Helper.correctNull((String)rs1.getString("PRD_RO")));
				}
				if(strOrgLevel.equalsIgnoreCase("D")){
					hshRecord.put("strClassAuth",Helper.correctNull((String)rs1.getString("PRD_CLPU")));
				}
				if(strOrgLevel.equalsIgnoreCase("A")){
					hshRecord.put("strClassAuth",Helper.correctNull((String)rs1.getString("PRD_BRANCH")));
				}*/
				hshRecord.put("strClassAuth",Helper.correctNull((String)rs1.getString("PRD_APPROVAL")));
			}
	

			strQuery = SQLParser.getSqlQuery("sel_cbs_status^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				perCbsId=correctNull(rs.getString("PERAPP_CBSID"));
				if(perCbsId.equals(""))
				{
				break;				
				}
			}
			hshRecord.put("perCbsId",perCbsId);
			
			String StrLoanMclrType="",StrMclrType="",StrMclrEFFECTIVEFROM="",Strappdate="",Strroiupdflag="",Strroiupddate="";
			java.util.Date date1;
			java.util.Date date2;
			java.util.Date date3;
			if(rs1!=null)
			{	  rs1.close(); 
			}
			strQuery = SQLParser.getSqlQuery("sel_roiUpdate_mclrdate^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				StrLoanMclrType = Helper.correctNull(rs.getString("loan_mclrtype"));
				 Strappdate = Helper.correctNull(rs.getString("APP_CREATEDATE"));//rs.getDate("APP_CREATEDATE");
				 Strroiupdflag = Helper.correctNull(rs.getString("LOAN_UPDROI_FLAG"));
				 Strroiupddate = Helper.correctNull(rs.getString("LOAN_UPDROI_DATE"));
			}
			
			if(!Strroiupdflag.equalsIgnoreCase("Y"))
			{
				hshRecord.put("RoiUpdate", "Y");
			}
			
			if(!StrLoanMclrType.equalsIgnoreCase(""))
			{
				String strArr1[]=StrLoanMclrType.split("@");
				for(int i=0;i<strArr1.length;i++)
				{
					StrMclrType = strArr1[0]; 
				}
			}
			if (!StrMclrType.equalsIgnoreCase("")) {
				strQuery = SQLParser.getSqlQuery("sel_roiUpdate_mclr^"
						+ StrMclrType + "^" + 'Y');
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					StrMclrEFFECTIVEFROM = Helper.correctNull(rs
							.getString("MCLR_EFFECTIVEFROM"));
				}
				SimpleDateFormat roiDate = new SimpleDateFormat("yyyy-MM-dd");//"yyyy-MM-dd"
				date1 = roiDate.parse(Strappdate);
				date2 = roiDate.parse(StrMclrEFFECTIVEFROM);
				if (Strroiupdflag.equals("Y")) {
					date3 = roiDate.parse(Strroiupddate);
					if (date3.before(date2)) {
						hshRecord.put("RoiUpdate", "Y");
					}
				} else {
					if (date1.before(date2)) {
						hshRecord.put("RoiUpdate", "Y");
					}
				}
				
			}
			
			
			strQuery = SQLParser.getSqlQuery("sel_cersaicibildetails^"+ strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()){
				strSersaiDetail= Helper.replaceForJavaScriptString((String) rs.getString("CER_CERSAIDETAILS"));
				strOtherInfo= Helper.replaceForJavaScriptString((String) rs.getString("CER_OTHERINFORMATION"));
			}
			
			if(!(strSersaiDetail.equalsIgnoreCase("") || strOtherInfo.equalsIgnoreCase("")))
				hshRecord.put("Cersai", "Exist");
			
			hshRecord.put("StrLoanTYpe", StrLoanTYpe);
			
			if(rs1!=null)
			{	  rs1.close(); 
			}
			String prdcode="";
			rs1=DBUtils.executeLAPSQuery("sel_prdloantype^"+ strAppno);			 
			if(rs1.next()) 
			{
				hshRecord.put("strPrdLoanType",correctNull(rs1.getString("prd_loantype")));
				prdcode = correctNull(rs1.getString("PRD_CODE"));
			}
			if(rs1!=null){
				rs1.close();
			}
			String strRepaymentType="";
			if(!prdcode.equalsIgnoreCase("")){
				rs1=DBUtils.executeLAPSQuery("selprodpurpose_new^"+prdcode);
				if(rs1.next())
				{
					strRepaymentType = correctNull(rs1.getString("PRD_REPAYTYPE"));
					if(!strRepaymentType.equalsIgnoreCase(""))
					{
						String strArrRepaymentType[]=strRepaymentType.split("@");
						for(int i=0;i<strArrRepaymentType.length;i++)
						{
							String strAB = strArrRepaymentType[i];
							if(strAB.equals("1"))
							{
								hshRecord.put("strNonEMIPrd","N");
							}
						}
					}
				}
			}
			if(rs1!=null)
				rs1.close();
			String strFacility="1",strRNEcheckflag="Y";//FOr Retail
			double dbemi=0.00,dbsancamt=0.00;
			strQuery1=SQLParser.getSqlQuery("get_RepayTypeAndPurpose^"+strAppno);
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeQuery(strQuery1);
			if(rs.next())
			{
				dbsancamt=  Double.parseDouble(Helper.correctDouble(rs.getString("sancamount"))); 
			}
			if(rs1!=null)
				rs1.close();
			strQuery1=SQLParser.getSqlQuery("sel_nerepaymentsum^"+strAppno+"^"+strFacility+"^P");
			rs1=DBUtils.executeQuery(strQuery1);
			if(rs1.next())
			{
				dbemi=Double.parseDouble(Helper.correctDouble(rs1.getString("TOTALSUM")));
				if(dbemi!=0.00)
				{
				if(!(dbsancamt==dbemi))
				{
					strRNEcheckflag="N";
				}
				}else{
					strRNEcheckflag="N";
				}
			}
			hshRecord.put("strRNEcheckflag",strRNEcheckflag);	
			
			if(rs1!=null)
			{	  rs1.close(); 	}
			strQuery=SQLParser.getSqlQuery("getappamt^"+strAppno);
			rs1=DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				String StrInterstType = Helper.correctNull((String)rs1.getString("loan_inttype"));
				String StrCReditRisk = Helper.correctNull((String)rs1.getString("loan_creditrskval"));
				String StrBussinStra = Helper.correctNull((String)rs1.getString("loan_busstatval"));
				
				if(StrCReditRisk.equalsIgnoreCase("") || StrBussinStra.equalsIgnoreCase("")){
					hshRecord.put("strCReditRisk","Y");	
				}else{
					double dblCReditRisk = Double.parseDouble(Helper.correctNull((String)rs1.getString("loan_creditrskval")));
					double dblBussinStra = Double.parseDouble(Helper.correctNull((String)rs1.getString("loan_busstatval")));
					if(StrInterstType.equalsIgnoreCase("Floating")){
						if(dblCReditRisk < 0.00 || dblBussinStra < 0.00){
							hshRecord.put("strCReditRisk","Y");	
						}
					}
				}
			}
			
			if(rs2 != null)
			{
				rs2.close();
			}
			strQuery = SQLParser.getSqlQuery("selsecpropdet_cersai_appno^"+strAppno);
			rs2 = DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				
				String cus_sec_type = correctNull(rs2.getString("cus_sec_type"));
				String secID = correctNull(rs2.getString("Sec_Id"));
				String SEC_CERSAIREFNO="",SEC_SEARCHPERFORM_DATE="",SEC_ALREADY_MORTG="",sec_croptype="";

				if(cus_sec_type.equalsIgnoreCase("10")||cus_sec_type.equalsIgnoreCase("11")||cus_sec_type.equalsIgnoreCase("12")
						||cus_sec_type.equalsIgnoreCase("13")||cus_sec_type.equalsIgnoreCase("15")||cus_sec_type.equalsIgnoreCase("16")
						||cus_sec_type.equalsIgnoreCase("17"))
				{
					SEC_CERSAIREFNO = correctNull(rs2 .getString("SEC_CERSAIREFNO"));
					if(SEC_CERSAIREFNO.equalsIgnoreCase(""))
					{
						hshRecord.put("SEC_CERSAIREFNO","Y");
					}
					SEC_SEARCHPERFORM_DATE = correctNull(rs2.getString("SEC_SEARCHPERFORM_DATE"));
					if(SEC_SEARCHPERFORM_DATE.equalsIgnoreCase(""))
					{
						hshRecord.put("SEC_SEARCHPERFORM_DATE","Y");
					}
					SEC_ALREADY_MORTG = correctNull(rs2.getString("SEC_ALREADY_MORTG"));
					if(SEC_ALREADY_MORTG.equalsIgnoreCase(""))
					{
						hshRecord.put("SEC_ALREADY_MORTG","Y");
					}
					if(rs1 != null)
					{
						rs1.close();
					}
					strQuery = SQLParser.getSqlQuery("selsecpropdet_cersai_statdata");
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						String datadesc = correctNull(rs1.getString("stat_data_desc1"));
						int intdatadesc = Integer.parseInt(Helper.correctInt(rs1.getString("stat_data_desc1")));

						if(rs != null)
						{
							rs.close();
						}
						String strcersiDate = correctNull(rs2.getString("SEC_SEARCHPERFORM_DATE"));
						
						if(!strcersiDate.equalsIgnoreCase(""))
						{
							String strArr1[]=strcersiDate.split("@");
							for(int i=0;i<strArr1.length;i++)
							{
								strcersiDate = strArr1[i]; 
								SimpleDateFormat cersaiDate = new SimpleDateFormat("dd/MM/yyyy");//"yyyy-MM-dd""16/4/2021"
								java.util.Date date4;
								java.util.Date date5;
								date4 = cersaiDate.parse(strcersiDate);
								date5 = cersaiDate.parse(currdate);
								long diffInMillies = Math.abs(date5.getTime() - date4.getTime());
							    long diff = TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);
								if(diff > intdatadesc)
								{
									hshRecord.put("cersaidate", "Y");
								}
							}
						}
					}
					
				}
				
				if(cus_sec_type.equalsIgnoreCase("14")){
					sec_croptype=correctNull(rs2.getString("sec_croptype"));
					if(sec_croptype.equalsIgnoreCase(""))
					{
						hshRecord.put("sec_croptype","Y");
					}
				}
			}
			
			if(rs1 != null)
			{
				rs1.close();
			}
			strQuery = SQLParser.getSqlQuery("select_verifydocument^"+strAppno);
			rs1 = DBUtils.executeQuery(strQuery);
			while(rs1.next())
			{
				String strgstcheck = Helper.correctNull((String)rs1.getString("VERI_GSTCHECK_AUTO"));
				if(strgstcheck.equals("MC")){
					hshRecord.put("strgstcheck", "Y");
				}
			}
			
			java.util.Date date6;
			if(rs!=null)
			{	  rs.close(); 
			}
			String StrpmayExpDate="";
			strQuery = SQLParser.getSqlQuery("sel_digipmay^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				 StrpmayExpDate = Helper.correctNull(rs.getString("PM_FINISH_DATE"));
				 SimpleDateFormat pmaydate = new SimpleDateFormat("yyyy-MM-dd");//"yyyy-MM-dd"

				 if(!StrpmayExpDate.equalsIgnoreCase("")){
				 date6 = pmaydate.parse(StrpmayExpDate);
				 if(date6.before(date7)){ 
					 hshRecord.put("pmayexp","Y");
				 }
				 }
			}
			
			//To check the Key Fact Statement Details
			if(rs1!=null)
				rs1.close();
			String strKFS = "";
			strQuery=SQLParser.getSqlQuery("select_keyfactfeesdata^"+strAppno);
			rs1=DBUtils.executeQuery(strQuery);
			while(rs1.next())
			{
				if(strKFS.equalsIgnoreCase(""))
					strKFS = Helper.correctNull(rs1.getString("KF_FACSNO"));
				else
					strKFS = strKFS+"@"+Helper.correctNull(rs1.getString("KF_FACSNO"));
			}
			hshRecord.put("strKFSDetails",strKFS);
			
			
			if(rs1!=null)
				rs1.close();
			strQuery=SQLParser.getSqlQuery("get_govtscheme^"+strAppno);
			rs1=DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				if(Helper.correctNull(rs1.getString("LOAN_GOVT")).equalsIgnoreCase("1")&&(Helper.correctNull(rs1.getString("GOVT_SCHEME")).equalsIgnoreCase("078")
						||Helper.correctNull(rs1.getString("GOVT_SCHEME")).equalsIgnoreCase("079"))){
					if(rs!=null)
						rs.close();
					strQuery=SQLParser.getSqlQuery("getstaticdatavaldispcorporate1^11^"+ Helper.correctNull(rs1.getString("GOVT_SCHEME")));
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						if(Helper.correctNull(rs.getString("stat_data_active")).equalsIgnoreCase("N"))
						{
							hshRecord.put("pmayAlert","N");
						}
					}
					
				}
			}

			if(sessionModuleType.equalsIgnoreCase("PERM"))	 
			 {
			if(appholder.equalsIgnoreCase(strUserId))
			{
				hshRecord.put("persend","Y");
			}
			else
			{
				hshRecord.put("persend","N");
			}
		} 
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getAction  "+ce.toString());
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
	
	public HashMap getHistory(HashMap hshValues)
	{
		
		ResultSet rs=null;
		String strEnableFlag="N";
		String strPermissions="";
		String strQuery="";
		int count=0;
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		ArrayList arrCol=new ArrayList();
		ArrayList arrRow=new ArrayList();
		try
		{
			rs=DBUtils.executeLAPSQuery("sel_dev_workflowhistory^"+strAppno);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("fromusrname")));
				arrCol.add(Helper.correctNull(rs.getString("tousername")));
				arrCol.add(Helper.correctNull(rs.getString("DEV_FROMFLOWPOINT")));
				arrCol.add(Helper.correctNull(rs.getString("DEV_TOFLOWPOINT")));
				arrCol.add(Helper.correctNull(rs.getString("sentdate")));
				arrCol.add(Helper.correctNull(rs.getString("DEV_MAILTYPE")));
				arrRow.add(arrCol);
			}
			hshValues.put("arrhistory",arrRow);
			
			if(rs!=null)rs.close();
			rs=DBUtils.executeLAPSQuery("sel_appl_deviation^"+strAppno);
			if(rs.next())
			{
				hshValues.put("appstatus",correctNull(rs.getString("DEV_APPSTATUS")));
			}
			if(rs!=null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("sel_recomments^"+strAppno);
			if(rs.next())
			{
				if(!(correctNull(Helper.CLOBToString(rs.getClob("PERM_COMMENTS1"))).equalsIgnoreCase("")) || !(correctNull(Helper.CLOBToString(rs.getClob("PERM_COMMENTS2"))).equalsIgnoreCase("")))
				hshValues.put("strRecmdFlag", "Y");
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
	
		return hshValues;
	
	}
	
	
	
	

	public HashMap update_PermApplBackgroundData(HashMap hshValues)
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		
		String strAction=correctNull((String) hshValues.get("hidAction"));
		String hidAppno=correctNull((String) hshValues.get("appno"));  

		try
		{
			if(strAction.equals("update"))
			{
				arrValues.add(hidAppno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_perm_applbg_comments");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
					
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(hidAppno);
				arrValues.add(correctNull((String) hshValues.get("txt_comments")));
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","ins_perm_applbg_comments");
				hshQueryValues.put("2",hshQuery);
				hshQueryValues.put("size","2");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equals("delete"))
			{
				arrValues.add(hidAppno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_perm_applbg_comments");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
 				
		}
		catch(Exception e)
		{
			throw new EJBException("Error in update_PermApplBackgroundData "+e.getMessage());
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
		return hshValues;
		
	}
		
		
		
	public void updatePermDocument(HashMap hshValues)
	{
		ResultSet rs=null;
		String strQuery="";
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAppno=null;
		int intSize=0;
		String strAction = (String)hshValues.get("hidAction");
		String strNewDocCode = "";
		String strNewDocDate = "";
		String strAppDocType = (String)hshValues.get("hidAppDocType");
		
		//For Document Remarks adding 
		String remarkflag=Helper.correctNull((String)hshValues.get("remarkflag"));
		String remarkdoccode=Helper.correctNull((String)hshValues.get("remarkdoccode"));
		String remarksdocvalue=Helper.correctNull((String)hshValues.get("remarksdocvalue"));
		
		String dcode=(String)hshValues.get("hidNewDocCode");
		
		String strdoccode[]=dcode.split("#");
		try
		{
			 strAppno=Helper.correctNull((String)hshValues.get("appno"));
			 if(strAppno.equals(""))
			 {
				 strAppno=Helper.correctNull((String)hshValues.get("hidAppno"));
			 }
			 if(strAppno.equals(""))
			 {
				 strAppno=Helper.correctNull((String)hshValues.get("app_no"));
			 }
			 if(strAppno.equals(""))
			 {
				 strAppno=Helper.correctNull((String)hshValues.get("strappno"));
			 }
			 String strsessionModuleType = correctNull((String)hshValues.get("sessionModuleType"));
				if(strsessionModuleType.equals(""))
				{
					  strsessionModuleType = correctNull((String)hshValues.get("cattype"));
				}
					 
			 if (strAction.trim().equalsIgnoreCase("New"))
			 {
				for(int i=0;i<strdoccode.length;i++)
				{
					intSize++;
					strNewDocDate = (String)hshValues.get("hidNewDocDate");		
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","perm_commdocumentins");
					arrValues.add(strAppno);
					arrValues.add(strdoccode[i]);
					arrValues.add("Y");
					arrValues.add(null);
					arrValues.add("0");
					arrValues.add(null);					
					arrValues.add("O");
					arrValues.add("");
					arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));
					arrValues.add("");

					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intSize),hshQuery);
				}
			}			
			else if(strAction.trim().equalsIgnoreCase("delete"))
			{	
				strNewDocCode = (String)hshValues.get("hidDocID");	
				hshQuery=new HashMap();
				arrValues=new ArrayList();				
				intSize++;
				arrValues=new ArrayList();	
				hshQuery=new HashMap();
				arrValues.add("Y");
				arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));
				arrValues.add(strAppno);
				arrValues.add(strNewDocCode);
				hshQuery.put("strQueryId","upd_perm_delDocFlag");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intSize),hshQuery);
				
				
			}			 
			 hshQueryValues.put("size",String.valueOf(intSize));
		 	 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
		}
		finally
		{
			try
			{
				//EJBInvoker.executeStateLess("appeditlock",hshValues,"unLockApplication");
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
	}
		
	
	
	
	public HashMap getpermDocumentDetails(HashMap hshValues)
	{
	ResultSet rs=null,rs1=null;
	String strAppno="",strQuery="",docpagetype="";
	ArrayList arrCol=new ArrayList();
	ArrayList arrOtherRow=new ArrayList();
	try
	{
		String strAppOrg="",strHolder="",OrgCode="",UserId="";
		OrgCode=Helper.correctNull((String)hshValues.get("strOrgCode"));
		UserId=Helper.correctNull((String)hshValues.get("strUserId"));
		String strOrgLevel=Helper.correctNull((String)hshValues.get("strOrgLevel"));
		strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strpageName="";
		
			strpageName=Helper.correctNull((String)hshValues.get("varPageName"));
			if(strpageName.equalsIgnoreCase("")){
				strpageName=Helper.correctNull((String)hshValues.get("hidpageName"));
			}
		
		
		if(strAppno.equals(""))
		{
			strAppno=Helper.correctNull((String)hshValues.get("hidAppno"));
		}
		if(strAppno.equals(""))
		{
			strAppno=Helper.correctNull((String)hshValues.get("hidRatAppNo"));
		}
		if(strAppno.equals(""))
		{
			strAppno=Helper.correctNull((String)hshValues.get("app_no"));
		}
		if(strAppno.equals(""))
		{
			strAppno=Helper.correctNull((String)hshValues.get("appno"));
		}
		if(strAppno.equals(""))
		{
			strAppno=Helper.correctNull((String)hshValues.get("strmsmeappno"));
		}
		log.info("<<<<<<<<<<<<=============strpageName====>>>>>>>>>>>>>>>>"+strpageName);
		log.info("<<<<<<<<<<============strAppno==================>>>>>>>>"+strAppno);
       log.info("<<<<<<<<<<<<===============OrgCode===============>>>>>>>>>"+OrgCode);
		docpagetype=Helper.correctNull((String)hshValues.get("docpagetype"));
		log.info("<<<<<<<<<<============docpagetype==================>>>>>>>>"+docpagetype);
		 strQuery=SQLParser.getSqlQuery("sel_perm_documentdetails_postsanc^"+strAppno);
		rs=DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			arrCol=new ArrayList();
			arrCol.add(Helper.correctNull(rs.getString("doc_jspname")));//0
			arrCol.add(Helper.correctNull(rs.getString("doc_docname")));//1
			arrCol.add(Helper.correctNull(rs.getString("doc_id")));//2
			arrCol.add(Helper.correctNull(rs.getString("APDOC_FAC_SLNO")));//3
			{
				if(rs1!=null)
					rs1.close();
				rs1=DBUtils.executeLAPSQuery("sel_docattachcnt^"+strAppno+"^O^"+Helper.correctNull(rs.getString("doc_jspname")));
				if(rs1.next())
					arrCol.add(Helper.correctNull(rs1.getString("cnt")));//4
				else
					arrCol.add("0");
				arrOtherRow.add(arrCol);
			}
		}
		hshValues.put("arrOtherRow", arrOtherRow);
		log.info("<<<<<<<<<<============Module Type==================>>>>>>>>"+Helper.correctNull((String)hshValues.get("sessionModuleType")));
		log.info("<<<<<<<<<<<=================strOrgLevel=====================>>>>>>>>>>>>>>"+strOrgLevel);
		log.info("<<<<<<<<<<<<<=============hidpageFrom============>>>>>>>>>>>>"+Helper.correctNull((String)hshValues.get("hidpagefrom")));
	
		if(!Helper.correctNull((String)hshValues.get("sessionModuleType")).equalsIgnoreCase("PERM")&& !Helper.correctNull((String)hshValues.get("hidpagefrom")).equalsIgnoreCase("MSME"))
		{
			ArrayList vecRec=new ArrayList();
			ArrayList vecVal=new ArrayList();
			String cma = Helper.correctNull((String) hshValues.get("hidcmasno"));
			String finance_id = Helper.correctNull((String) hshValues.get("hidfinanceid"));
			if (cma.equalsIgnoreCase("")) {
				cma = Helper.correctNull((String) hshValues
						.get("hidCMANo"));
			}
			if (cma.equalsIgnoreCase("")) {
				if (rs != null) {
					rs.close();
				}

				if (!finance_id.equals("")) {
					strQuery = SQLParser.getSqlQuery("fin_cmano_select^"
							+ finance_id);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {

						cma = Helper.correctNull((String) rs
								.getString("fin_cmano"));
					}
				}
			}
			if (cma.equalsIgnoreCase("")) {
				cma = "0";
			}
			strQuery = SQLParser.getSqlQuery("com_fintabselect^" + cma);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			int y = 0;
			while (rs.next()) {
				vecRec = new ArrayList();
				vecRec.add(correctNull(rs.getString("fin_tabname")));
				vecVal.add(vecRec);
			}
			
			hshValues.put("tabdetails", vecVal);
			hshValues.put("finace_id", finance_id);
			hshValues.put("fintype", cma);
			
			if(rs!=null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("sel_fin_rating^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);	
            if(rs.next())
           {
            	hshValues.put("appstatus",correctNull(rs.getString("fin_status")).toLowerCase());
            	hshValues.put("fin_appholder",correctNull(rs.getString("fin_appholder")));
            	strAppOrg=correctNull(rs.getString("fin_orgcode"));
            	strHolder=correctNull(rs.getString("fin_appholder"));
           } 
            hshValues.put("strAppno", strAppno); 
            
		}
		else if(!Helper.correctNull((String)hshValues.get("hidpagefrom")).equalsIgnoreCase("MSME"))
		{
			if(rs!=null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("selectdeviationdet^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);	
            if(rs.next())
           {
            	strAppOrg=correctNull(rs.getString("org_code"));
            	strHolder=correctNull(rs.getString("dev_applholder"));
           }
		}
		else
		{
			if(rs!=null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("sel_msmeApproval^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);	
            if(rs.next())
           {
            	if(!Helper.correctNull(rs.getString("MSME_INITIATE_FLAG")).equalsIgnoreCase("Y"))
            	hshValues.put("appstatus",correctNull(rs.getString("MSME_APPSTATUS")));
           }
            hshValues.put("strAppno", strAppno);
		}
		
		int docAttCount=0;
		if(strAppOrg.contains(OrgCode))
		{
			docAttCount++;
		}
		else if(strHolder.equals(UserId))
		{
			docAttCount++;
		}
		else if(strOrgLevel.equalsIgnoreCase("D") &&(!strAppOrg.equalsIgnoreCase(""))&&(strAppOrg.length()>8)&& (strAppOrg.substring(0, 9)).equals(OrgCode.substring(0, 9)))
		{
			docAttCount++;
		}
		else if(strOrgLevel.equalsIgnoreCase("R") &&(!strAppOrg.equalsIgnoreCase(""))&&(strAppOrg.length()>5)&& (strAppOrg.substring(0, 6)).equals(OrgCode.substring(0, 6)))
		{
			docAttCount++;
		}
		else if(strOrgLevel.equalsIgnoreCase("C"))
		{
			docAttCount++;
		}
		else if(Helper.correctNull((String)hshValues.get("hidpagefrom")).equalsIgnoreCase("MSME"))
		{
			docAttCount++;
		}
		hshValues.put("docAttCount", Integer.toString(docAttCount));
		hshValues.put("strpageName", strpageName);
		
	}
	catch(Exception e)
	{
		log.info("Exception in getpermDocumentDetails ==="+e.getMessage());

		throw new EJBException("Exception in getpermDocumentDetails ========"+e.toString());
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
	return hshValues;
	}
	
	
	public HashMap getpermBorrowerDetails(HashMap hshRequestValues) 
	{		
		ResultSet rs = null;
		String strQuery="",areacheckval="",catval="",desc="",bownameval="",subj="",absPosition="";
		String area2="",area3="",area4="",area5="",glptotlevel="",pagetype="",ddesc="";
		String strCusCBSStatus="",str_statuscust="",strApplicantId="",strCBSID="";
		try
		{
			strQuery = SQLParser.getSqlQuery("glpoption");
			rs =DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				glptotlevel = (String)Helper.correctNull(rs.getString(1));						
			}
			pagetype= correctNull((String)hshRequestValues.get("link"));
			absPosition=correctNull((String)hshRequestValues.get("hid_rowcount"));
			area2= correctNull((String)hshRequestValues.get("area2"));
			area3 = correctNull((String)hshRequestValues.get("area3"));
			area4 = correctNull((String)hshRequestValues.get("area4"));
			area5 = correctNull((String)hshRequestValues.get("area5"));
			
			if(area4.equals("undefined"))
				area4="";
			
			if(!area5.equals(""))
			{
				areacheckval=area5;
			}
			else if(!area4.equals(""))
			{
				if(glptotlevel.equals("4"))
				{
					areacheckval=area4.substring(0,12)+"%%%";
				}
				else if(glptotlevel.equals("5"))
				{
					areacheckval=area4.substring(0,15);
				}
			}
			else if(!area3.equals(""))
			{
				areacheckval=area3.substring(0,9)+"%%%%%%";
			}
			else if(!area2.equals(""))
			{
				areacheckval=area2.substring(0,6)+"%%%%%%%%%";
			}
			else
			{
				areacheckval="";			
			}
			
			catval = correctNull((String)hshRequestValues.get("cat"));
			bownameval = correctNull((String)hshRequestValues.get("bow_name"));
			if (!catval.equals("") && !bownameval.equals("") )
			{
				if(catval.equals("1"))//proposal Number search
				{
					strQuery = SQLParser.getSqlQuery("sel_appnosearchbyappno_perm^"+bownameval);
				}
				else if(catval.equals("2")) //CBS ID search
				{	
					desc=bownameval;
					strQuery = SQLParser.getSqlQuery("sel_appnosearchbycbsid_perm^"+desc);
				}
				else if(catval.equals("3"))//Name search
				{	
					desc= "(upper(PG_APPLIANTNAME) like upper('%"+bownameval+"%'))" ;
					strQuery = SQLParser.getSqlQuery("sel_appnosearchbyname_perm^"+desc+"^"+areacheckval);
				}
			}
			ArrayList vecval =  new ArrayList();
			ArrayList vecdata =  new ArrayList();
			if(rs != null)
				rs.close();
			rs =DBUtils.executeQuery(strQuery);
		    rs.last();			
			int RowCount = rs.getRow();			    
			rs.beforeFirst();
				
			if(RowCount != 0)
			{					
				if (!absPosition.equals("0"))
				{
					if(Integer.parseInt(absPosition) > RowCount)
					{
						rs.absolute(RowCount);
					}
					else
					{
						rs.absolute(Integer.parseInt(absPosition));
					}				
				}			
			}
			String tempstr="";
			ResultSet rs1=null;
			while(rs.next())
			{
				vecval =  new ArrayList();
				vecval.add(rs.getString(2));//1		
				vecval.add(rs.getString(1));//2
				vecval.add(rs.getString(3));//2
				
				vecdata.add(vecval);
			}
			hshRequestValues.put("vecval",vecdata);		
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
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRequestValues;
	}
	
	
	public HashMap getPermDataFinal(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = null;
		String strQuery="",status="",appno="",strProposalType="";
		ArrayList vecval =  new ArrayList();
		ArrayList vecdata =  new ArrayList();
		String sel_cat="";
		try
		{
			hshRecord = new HashMap();
			sel_cat = Helper.correctNull((String)hshRequestValues.get("select_cat"));
			
			if(sel_cat.equalsIgnoreCase("1"))//Application No
			{
				appno="and ap.DEV_APPNO='"+correctNull((String)hshRequestValues.get("appno"))+"'";
			}
			else if (sel_cat.equalsIgnoreCase("2"))//CBS ID and Name
			{
				appno="and DEV_CBSID='"+correctNull((String)hshRequestValues.get("cbsid"))+"'";
			}
			else
			{
				appno="and upper(PG_APPLIANTNAME)='"+correctNull((String)hshRequestValues.get("name"))+"'";
			}
			
			strQuery = SQLParser.getSqlQuery("sel_permappsearchFinal^"+appno);
			rs =DBUtils.executeQuery(strQuery);	
			while(rs.next())
			{		
				vecval =  new ArrayList();
				
				vecval.add(correctNull(rs.getString("DEV_APPNO")));
				vecval.add(correctNull(rs.getString("appname")));
				status=correctNull(rs.getString("DEV_APPSTATUS"));
				
				if(status.equalsIgnoreCase("op"))
				{
					status="OPEN/PENDING";
				}
				else if(status.equalsIgnoreCase("ol"))
				{
					status="OPEN/LODGED";
				}
				else if(status.equalsIgnoreCase("pa"))
				{
					status="PROCESSED/APPROVED";
				}
				else if(status.equalsIgnoreCase("pr"))
				{
					status="PROCESSED/REJECTED";
				}
				else if(status.equalsIgnoreCase("ca"))
				{
					status="CLOSED/APPROVED";
				}
				else if(status.equalsIgnoreCase("cr"))
				{
					status="CLOSED/REJECTED";
				}
				vecval.add(status);
				
				
				String strAppholderid=correctNull(rs.getString("DEV_APPLHOLDER"));
				String strAppholdername=correctNull(rs.getString("USR_FNAME"));
				
			
					if(!strAppholderid.equals(""))
					{
						if(correctNull((String)hshRequestValues.get("strUserId")).equals(strAppholderid))
						{
							vecval.add("Y");
							vecval.add(strAppholdername);
						}
						else
						{
							vecval.add("N");	
							vecval.add(strAppholdername);
						}
						
					}
				vecval.add("Fresh");
				vecdata.add(vecval);	
			}
			hshRecord.put("vecval",vecdata);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getPermDataFinal====  "+ce.toString());
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
	public HashMap getBasicInformation (HashMap hshValues) 
	{	
		String strQuery="";
		ResultSet rs = null,rs1=null;
		try
		{
			String strAppno=Helper.correctNull((String)hshValues.get("appno"));
			String strSubtype=Helper.correctNull((String)("DEV_SUBTYPE"));
			strQuery = SQLParser.getSqlQuery("sel_basicinformation^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshValues.put("PERM_APPNO", correctNull(rs.getString("PERM_APPNO")));
				hshValues.put("PERM_PROP_SUBMITTED", correctNull(rs.getString("PERM_PROP_SUBMITTED")));
				hshValues.put("PERM_SANC_DEPT", correctNull(rs.getString("PERM_SANC_DEPT")));
				hshValues.put("PERM_SANC_AUTH", correctNull(rs.getString("PERM_SANC_AUTH")));
				hshValues.put("PERM_SANC_INTIMATE", correctNull(rs.getString("PERM_SANC_INTIMATE")));
				hshValues.put("PERM_HANDLING_CHARGE", correctNull(rs.getString("PERM_HANDLING_CHARGE")));	
				hshValues.put("PERM_REFNO", correctNull(rs.getString("PERM_REFNO")));		
				hshValues.put("PERM_SANC_DATE", correctNull(rs.getString("PERM_SANC_DATE")));
				hshValues.put("PERM_SANC_BRANCH", correctNull(rs.getString("PERM_SANC_BRANCH")));
				
				strQuery = SQLParser.getSqlQuery("getorgcode^"+correctNull(rs.getString("PERM_PER_BRANCH")));
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					hshValues.put("strBranchName", Helper.correctNull(rs1.getString("org_name")));
					hshValues.put("strBranchCode", Helper.correctNull(rs.getString("PERM_PER_BRANCH")));
				}
			}
			
			if(rs1!=null)
				rs1.close();
			
			strQuery = SQLParser.getSqlQuery("sel_permcreatedbranch^"+strAppno);
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				hshValues.put("strAppCreatedOrg", Helper.correctNull(rs1.getString("org_level")));
			}
			if(rs!=null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("sel_appl_deviation^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				if(Helper.correctNull(rs.getString("DEV_SUBTYPE")).equalsIgnoreCase("7"))
				{	if(rs1!=null)rs1.close();
					strQuery = SQLParser.getSqlQuery("sel_permissionGist_Data^"+strAppno);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						if(Helper.correctNull(rs1.getString("PG_RECOMMEND_BRANCH")).equalsIgnoreCase(""))
							hshValues.put("RECOMMEND_BRANCH_VAL","Y");
					}
				}
			}
			
			
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getBasicInformation "+ce.toString());
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

public void updateProposalflow(HashMap hshValues)
{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String strSno = correctNull((String) hshValues.get("hidsno"));
		String strQuery="";
		ResultSet rs=null;
		String strAction=correctNull((String) hshValues.get("hidAction"));
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		int intUpdatesize=0;
		
		
	try{
		
		if(strAction.equals("update"))
		{
            
			arrValues.add(correctNull((String)hshValues.get("txt_name")));
			arrValues.add(correctNull((String)hshValues.get("txt_desig")));
			arrValues.add(correctNull((String)hshValues.get("txtuserID")));
			arrValues.add(strAppno);
			arrValues.add(strSno);
		
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","upd_proposalflow");
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

		}
		else if(strAction.equals("delete"))
		{
			arrValues.add(strAppno);
			arrValues.add(strSno);
			
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","del_proposalflow");
			
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
		}
		else
		{
			
			
			
			intUpdatesize++;
			hshQuery.put("strQueryId","ins_proposalflow");
			strQuery=SQLParser.getSqlQuery("prposalflowmax^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strSno = correctNull(rs.getString(1));				
			}
			arrValues.add(correctNull((String)hshValues.get("txt_name")));
			arrValues.add(correctNull((String)hshValues.get("txt_desig")));
			arrValues.add(correctNull((String)hshValues.get("txtuserID")));
			arrValues.add(strAppno);
			arrValues.add(strSno);
			hshQuery.put("arrValues",arrValues);
			
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
	}
	catch(Exception e)
	{
		throw new EJBException("Exception caught in  UpdateProposalflow==="
				+ e.getMessage());
	}
}
public HashMap getProposalflow (HashMap hshValues) 
{	
		
		HashMap hshRecord=new HashMap();
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		String strQuery="",strAppno="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshResult=new HashMap();
		String strDecId="";
		
		try
		{
			strAppno=Helper.correctNull((String)hshValues.get("appno"));
			strQuery = SQLParser.getSqlQuery("sel_proposalflow^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString(1)));
				strDecId=correctNull(rs.getString(2));
				arrCol.add(strDecId);
				arrCol.add(correctNull(rs.getString(3)));
				arrCol.add(correctNull(rs.getString(4)));
				arrCol.add(correctNull(rs.getString(5)));
				if(rs1!=null)
				rs1.close();
				strQuery = SQLParser.getSqlQuery("sel_CBSStaticDataPassingCode^"+"27^"+strDecId);
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					arrCol.add(Helper.correctNull((String)rs1.getString("CBS_STATIC_DATA_DESC")));//13
				}
				else
				{
					arrCol.add(strDecId);
				}
				
				
				
				arrRow.add(arrCol);		
					
			}
			
			hshRecord.put("arrRow",arrRow);
		}
		catch (Exception ce) {
			throw new EJBException("Error in getProposalflow method=== " + ce.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshRecord;
	}
public HashMap getAnnexure (HashMap hshValues) 
	{
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		nf.setGroupingUsed(false);
		ResultSet rs = null, rs1 = null, rs2 = null;
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
	
		String strQuery = "";
		String appno = "", strdev_type = "", strMaintype = "", strAmntVal = "",strType="";
		ArrayList arrRow4=new ArrayList();
		ArrayList arrCol4=new ArrayList();
		ArrayList arrRow5=new ArrayList();
		ArrayList arrCol5=new ArrayList();
		ArrayList arrCol6=new ArrayList();
		ArrayList arrRow6=new ArrayList();
		ArrayList arrRow7=new ArrayList();
		ArrayList arrCol7=new ArrayList();
		ArrayList arrRow8=new ArrayList();
		ArrayList arrCol8=new ArrayList();
	
		try
		{
			appno=Helper.correctNull((String)hshValues.get("appno"));
			strAmntVal = Helper.correctNull((String) hshValues
					.get("strAmntVal"));
			if(strAmntVal.equalsIgnoreCase("R"))
				strType="Rupees";
			else if(strAmntVal.equalsIgnoreCase("L"))
				strType="Lakhs";
			else if(strAmntVal.equalsIgnoreCase("C"))
				strType="Crores";
			hshValues.put("strAmntType", strType);
			strQuery= SQLParser.getSqlQuery("sel_permannexureData^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
		
				hshValues.put("DEV_APPNO",correctNull(rs.getString("DEV_APPNO")));
				if(!Helper.correctNull(rs.getString("PG_APPL_TITLE")).equalsIgnoreCase(""))
				{
					String title=Helper.correctNull(rs.getString("PG_APPL_TITLE"));
					hshValues.put("PG_APPLIANTNAME",title +"."+correctNull(rs.getString("PG_APPLIANTNAME")).toUpperCase());
			
				}else{
					hshValues.put("PG_APPLIANTNAME",correctNull(rs.getString("PG_APPLIANTNAME")).toUpperCase());
				}
				
				//hshValues.put("PG_APPLADDRESS",correctNull(rs.getString("PG_APPLADDRESS")));
				
				hshValues.put("PG_CONSTITUTIONS",Helper.correctInt((String)rs.getString("PG_CONSTITUTION")));

				
				strQuery= SQLParser.getSqlQuery("selconstitutiondesc^"+Helper.correctInt((String)rs.getString("PG_CONSTITUTION")));
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					hshValues.put("PG_CONSTITUTION",correctNull(rs1.getString("cbs_static_data_desc")));
				}
				
		//		hshValues.put("PG_MANAGEMENTDET",correctNull(rs.getString("PG_MANAGEMENTDET")));
				
				if(!correctNull(rs.getString("PG_MANAGEMENTDET")).equals(""))
				{
				String[] strManagdet=Helper.correctNull(rs.getString("PG_MANAGEMENTDET")).split("@");
				
				int strdet=strManagdet.length;
					for(int i=0;i<strdet;i++)
					{
						 String[] valtemp=strManagdet[i].split("~");
						if(!valtemp.equals(""))
					      {
							arrCol4=new ArrayList();
							  
							  arrCol4.add(valtemp[0].trim());
							   
							  	if(rs1!=null)
								{
									rs1.close();
								}
							  	boolean bflag=false;
								if(valtemp[1].equalsIgnoreCase("Division"))
								{
									bflag=true;
									arrCol4.add("Division");
									rs1=DBUtils.executeLAPSQuery("selstatdatabyiddesc^193^"+valtemp[2].trim());
									
								}
								else if(valtemp[1].equalsIgnoreCase("Sister concern"))
								{
									bflag=true;
									arrCol4.add("Sister concern");
									rs1=DBUtils.executeLAPSQuery("selstatdatabyiddesc^194^"+valtemp[2].trim());
								}
								else if(valtemp[1].equalsIgnoreCase("Group concern"))
								{
									bflag=true;
									arrCol4.add("Group concern");
									rs1=DBUtils.executeLAPSQuery("selstatdatabyiddesc^195^"+valtemp[2].trim());
								}
								else if(valtemp[1].equalsIgnoreCase("O"))
								{
									bflag=true;
									arrCol4.add("Share Holders");
									rs1=DBUtils.executeLAPSQuery("selstatdatabyiddesc^196^"+valtemp[2].trim());
								}
								else if(valtemp[1].equalsIgnoreCase("D"))
								{
									bflag=true;
									arrCol4.add("Directors");
									rs1=DBUtils.executeLAPSQuery("selstatdatabyiddesc^197^"+valtemp[2].trim());
								}
								else if(valtemp[1].equalsIgnoreCase("SP"))
								{
									bflag=true;
									arrCol4.add("Sole Proprietor");
									rs1=DBUtils.executeLAPSQuery("selstatdatabyiddesc^198^"+valtemp[2].trim());
								}
								else if(valtemp[1].equalsIgnoreCase("PT"))
								{
									bflag=true;
									arrCol4.add("Partner");
									rs1=DBUtils.executeLAPSQuery("selstatdatabyiddesc^199^"+valtemp[2].trim());
								}
								else if(valtemp[1].equalsIgnoreCase("T"))
								{
									bflag=true;
									arrCol4.add("Trustee");
									rs1=DBUtils.executeLAPSQuery("selstatdatabyiddesc^200^"+valtemp[2].trim());
								}
								else if(valtemp[1].equalsIgnoreCase("K"))
								{
									bflag=true;
									arrCol4.add("Karta");
									rs1=DBUtils.executeLAPSQuery("selstatdatabyiddesc^201^"+valtemp[2].trim());
								}
								else if(valtemp[1].equalsIgnoreCase("PA"))
								{
									bflag=true;
									arrCol4.add("Power of Attorney");
									rs1=DBUtils.executeLAPSQuery("selstatdatabyiddesc^202^"+valtemp[2].trim());
								}
								else if(valtemp[1].equalsIgnoreCase("OT"))
								{
									bflag=true;
									arrCol4.add("Others");
									rs1=DBUtils.executeLAPSQuery("selstatdatabyiddesc^203^"+valtemp[2].trim());
								}
								else
								{
									arrCol4.add("");
								}
								if(bflag)
								{
								if(rs1.next())
									arrCol4.add(correctNull(rs1.getString("stat_data_desc1")));			
								else
									arrCol4.add("");
								}
								else
								{
									arrCol4.add("");
								}
							  
							  arrRow4.add(arrCol4);				
							}		
						  hshValues.put("arrData4", arrRow4);
					}
					
				}	
				else
				{
					//hshValues.put("PG_MANAGEMENTDET",correctNull(rs.getString("PG_MANAGEMENTDET")));
				}
				hshValues.put("PG_ACTIVITY",correctNull(rs.getString("PG_ACTIVITY")));
				hshValues.put("PG_ESTBDATE",correctNull(rs.getString("PG_ESTBDATE")));
				hshValues.put("PG_GRPCRCN_POT",correctNull(rs.getString("PG_GRPCRCN_POT")));
				
				hshValues.put("PG_EMPLOYERNAME",correctNull(rs.getString("PG_EMPLOYERNAME")));
				hshValues.put("PG_NOOFEMP_SALDRAW",correctNull(rs.getString("PG_NOOFEMP_SALDRAW")));
				hshValues.put("PG_NAMEOFTRUSTEE",correctNull(rs.getString("PG_NAMEOFTRUSTEE")));
				hshValues.put("PG_EXCESSINCOME",correctNull(rs.getString("PG_EXCESSINCOME")));
			/*	hshValues.put("PG_DET_DEPACC_PRESENTBAL",correctNull(rs.getString("PG_DET_DEPACC_PRESENTBAL")));
				
				
				
				if(!correctNull(rs.getString("PG_DET_DEPACC_PRESENTBAL")).equals(""))
				{
				String[] strDepAcc=Helper.correctNull(rs.getString("PG_DET_DEPACC_PRESENTBAL")).split("@");
				
				int deposite_acc=strDepAcc.length;
					for(int i=0;i<deposite_acc;i++)
					{
						String[] valtemp=strDepAcc[i].split("~");
						if(!valtemp.equals(""))
					      {
								arrCol6=new ArrayList(); 
								  
								arrCol6.add(valtemp[0].trim());
								arrCol6.add(valtemp[1].trim());
								arrCol6.add(valtemp[2].trim());
								arrCol6.add(valtemp[3].trim());
								arrCol6.add(valtemp[4].trim());
								arrCol6.add(valtemp[5].trim());
								
								arrRow6.add(arrCol6);				
						  }		
						  hshValues.put("arrData6", arrRow6);
					}
					
				}
				*/
				
				hshValues.put("PG_DEALINGSINCE",correctNull(rs.getString("PG_DEALINGSINCE")));

			/*	hshValues.put("PG_EXSTFAC_PRIMESEC",Helper.correctNull(Helper.CLOBToString(rs.getClob("PG_EXSTFAC_PRIMESEC"))));
				
				
				
				if(!Helper.correctNull(Helper.CLOBToString(rs.getClob("PG_EXSTFAC_PRIMESEC"))).equals(""))
				{
				String[] strSecPrime=Helper.correctNull(Helper.CLOBToString(rs.getClob("PG_EXSTFAC_PRIMESEC"))).split("@");
				
				int Security_Prime=strSecPrime.length;
					for(int i=0;i<Security_Prime;i++)
					{
						String[] valtemp=strSecPrime[i].split("~");
						if(!valtemp.equals(""))
					      {
								arrCol7=new ArrayList(); 
								  
								arrCol7.add(valtemp[0].trim());
								arrCol7.add(valtemp[1].trim());
								arrCol7.add(valtemp[2].trim());
								arrCol7.add(valtemp[3].trim());
								arrCol7.add(valtemp[4].trim());
								arrCol7.add(valtemp[5].trim());
								
								if(!valtemp[6].equalsIgnoreCase(""))
								{
									if(valtemp[6].trim().equals("1"))
									{
										arrCol7.add("Primary");
									}
									else if(valtemp[6].trim().equals("2"))
									{
										arrCol7.add("Collateral");
									}
									else
									{
										arrCol7.add(valtemp[6].trim());
									}
								}
								else
								{
									arrCol7.add(valtemp[6].trim());
								}
								
								arrCol7.add(valtemp[7].trim());
								
								arrRow7.add(arrCol7);				
						  }		
						  hshValues.put("arrData7", arrRow7);
					}
					
				}
				*/
				hshValues.put("PG_EXSTFAC_COLSEC",correctNull(rs.getString("PG_EXSTFAC_COLSEC")));
				
//				hshValues.put("PG_DET_LOANACC_OTHBANK",correctNull(rs.getString("PG_DET_LOANACC_OTHBANK")));
				
			/*	if(!Helper.correctNull(Helper.CLOBToString(rs.getClob("PG_DET_LOANACC_OTHBANK"))).equals(""))
				{
				String[] strOtherBank=Helper.correctNull(Helper.CLOBToString(rs.getClob("PG_DET_LOANACC_OTHBANK"))).split("@");
				
				int Other_Bank=strOtherBank.length;
					for(int i=0;i<Other_Bank;i++)
					{
						String[] valtemp=strOtherBank[i].split("~");
						if(!valtemp.equals(""))
					      {
								arrCol8=new ArrayList(); 
								arrCol8.add(valtemp[0].trim());
								arrCol8.add(valtemp[1].trim());
								arrCol8.add(valtemp[2].trim());
								arrCol8.add(valtemp[3].trim());
								arrCol8.add(valtemp[4].trim());
								arrCol8.add(valtemp[5].trim());
								
								if(!valtemp[0].trim().equals(""))
								{
									if(rs1!=null)
									{
										rs1.close();
									}
									rs1 = DBUtils.executeLAPSQuery("getstaticdescription^"+"147"+"^"+valtemp[0].trim());
									if(rs1.next())
									{
										arrCol8.add(Helper.correctNull(rs1.getString("STAT_DATA_DESC1")));
									}
									else
									{
										arrCol8.add(valtemp[0].trim());
									}
								}	
								else
								{
									arrCol8.add(valtemp[0].trim());
								}
								arrRow8.add(arrCol8);				
						  }		
						  hshValues.put("arrData8", arrRow8);
					}
					
				}else
				{
					hshValues.put("PG_DET_LOANACC_OTHBANK",Helper.correctNull(Helper.CLOBToString(rs.getClob("PG_DET_LOANACC_OTHBANK"))));
				}
				*/
				
				hshValues.put("PG_ITRETURNS_TAXPAID",correctNull(rs.getString("PG_ITRETURNS_TAXPAID")));
				hshValues.put("PG_PRESENT_NATURE",correctNull(rs.getString("PG_PRESENT_NATURE")));
				hshValues.put("PG_PRESENT_LOANAMT",Helper.converAmount(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("PG_PRESENT_LOANAMT")))),strAmntVal));
				hshValues.put("PG_PRESENT_INTEREST",correctNull(rs.getString("PG_PRESENT_INTEREST")));
				hshValues.put("PG_PRESENT_PERIOD",correctNull(rs.getString("PG_PRESENT_PERIOD")));
				hshValues.put("PG_PRESENT_PURPOSE",correctNull(rs.getString("PG_PRESENT_PURPOSE")));
				hshValues.put("PG_PROPFAC_SEC_PRIME",correctNull(rs.getString("PG_PROPFAC_SEC_PRIME")));
				hshValues.put("PG_PROPFAC_SEC_COLLATERAL",correctNull(rs.getString("PG_PROPFAC_SEC_COLLATERAL")));
				hshValues.put("PG_RSN_SWITCH",correctNull(rs.getString("PG_RSN_SWITCH")));
				hshValues.put("PG_ACC_INTRODBY",correctNull(rs.getString("PG_ACC_INTRODBY")));
				hshValues.put("PG_LANDCOST", Helper.converAmount(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("PG_LANDCOST")))),strAmntVal));
				//hshValues.put("PG_LANDCOST",correctNull(rs.getString("PG_LANDCOST")));
				//hshValues.put("PG_PROMOTCONTRIB",correctNull(rs.getString("PG_PROMOTCONTRIB")));
				hshValues.put("PG_PROMOTCONTRIB",Helper.converAmount(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("PG_PROMOTCONTRIB")))),strAmntVal));
				hshValues.put("PG_PERCENTTOTAL1",correctNull(rs.getString("PG_PERCENTTOTAL1")));
				//hshValues.put("PG_CONSTRUCTIONCOST",correctNull(rs.getString("PG_CONSTRUCTIONCOST")));
				hshValues.put("PG_CONSTRUCTIONCOST",Helper.converAmount(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("PG_CONSTRUCTIONCOST")))),strAmntVal));
				//hshValues.put("PG_ADVANCEAMT",correctNull(rs.getString("PG_ADVANCEAMT")));
				hshValues.put("PG_ADVANCEAMT",Helper.converAmount(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("PG_ADVANCEAMT")))),strAmntVal));
				hshValues.put("PG_PERCENTTOTAL2",correctNull(rs.getString("PG_PERCENTTOTAL2")));
				//hshValues.put("PG_LOANFROMKBL",correctNull(rs.getString("PG_LOANFROMKBL")));
				hshValues.put("PG_LOANFROMKBL",Helper.converAmount(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("PG_LOANFROMKBL")))),strAmntVal));
				hshValues.put("PG_PERCENTTOTAL3",correctNull(rs.getString("PG_PERCENTTOTAL3")));
				//hshValues.put("PG_TOTPROJECTCOST",correctNull(rs.getString("PG_TOTPROJECTCOST")));
				hshValues.put("PG_TOTPROJECTCOST",Helper.converAmount(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("PG_TOTPROJECTCOST")))),strAmntVal));
				//hshValues.put("PG_TOTMEANSOFFINANCE",correctNull(rs.getString("PG_TOTMEANSOFFINANCE")));
				hshValues.put("PG_TOTMEANSOFFINANCE",Helper.converAmount(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("PG_TOTMEANSOFFINANCE")))),strAmntVal));
				hshValues.put("PG_PERCENTTOTAL4",correctNull(rs.getString("PG_PERCENTTOTAL4")));
				hshValues.put("PG_SRC_MARGINMONEY",correctNull(rs.getString("PG_SRC_MARGINMONEY")));
				hshValues.put("PG_PERIOD_SOUGHT",correctNull(rs.getString("PG_PERIOD_SOUGHT")));
				hshValues.put("PG_HOLIDAYPERIOD",correctNull(rs.getString("PG_HOLIDAYPERIOD")));
				hshValues.put("PG_SRC_REPAYMENT",correctNull(rs.getString("PG_SRC_REPAYMENT")));
				hshValues.put("PG_TOTAREA",correctNull(rs.getString("PG_TOTAREA")));
				hshValues.put("PG_TOTBUILTUPAREA",correctNull(rs.getString("PG_TOTBUILTUPAREA")));
				hshValues.put("PG_FLOORDETAILS",correctNull(rs.getString("PG_FLOORDETAILS")));
				hshValues.put("PG_TOTCONSTCOST",correctNull(rs.getString("PG_TOTCONSTCOST")));
				hshValues.put("PG_AVGSELLINGPRICE_RF",correctNull(rs.getString("PG_AVGSELLINGPRICE_RF")));
				hshValues.put("PG_AVGSELLINGPRICE_CP",correctNull(rs.getString("PG_AVGSELLINGPRICE_CP")));
				hshValues.put("PG_PROJECTEDRENT",correctNull(rs.getString("PG_PROJECTEDRENT")));
				hshValues.put("PG_CONF_AUTH_CONSTBUILD",correctNull(rs.getString("PG_CONF_AUTH_CONSTBUILD")));

				hshValues.put("PG_SCHEME_GUIDELINES",correctNull(rs.getString("PG_SCHEME_GUIDELINES")).replaceAll("\n","<br/>"));
				hshValues.put("PG_DEVPERM_SOUGHTOTHERS",correctNull(rs.getString("PG_DEVPERM_SOUGHTOTHERS")));
				hshValues.put("PG_EARLIERCONCESSION",correctNull(rs.getString("PG_EARLIERCONCESSION")));
				hshValues.put("PG_JUSTF_SPECCONSID",correctNull(rs.getString("PG_JUSTF_SPECCONSID")));
				hshValues.put("PG_CONCESSION_RECOMMENDED",correctNull(rs.getString("PG_CONCESSION_RECOMMENDED")));
				hshValues.put("PG_CONCESSION_JUSTIF",correctNull(rs.getString("PG_CONCESSION_JUSTIF")));
				hshValues.put("PG_DETOFVISIT",correctNull(rs.getString("PG_DETOFVISIT")));
				hshValues.put("PG_PARTYBG_EARPROJECTS",correctNull(rs.getString("PG_PARTYBG_EARPROJECTS")));
				hshValues.put("PG_DEVOBSERVED",correctNull(rs.getString("PG_DEVOBSERVED")));
				hshValues.put("PG_WHTPERM_EXTENDED",correctNull(rs.getString("PG_WHTPERM_EXTENDED")));
				hshValues.put("PG_TA_BRTOT_ACS",correctNull(rs.getString("PG_TA_BRTOT_ACS")));
				//hshValues.put("PG_TA_BRTOT_AMT",correctNull(rs.getString("PG_TA_BRTOT_AMT")));
				hshValues.put("PG_TA_BRTOT_AMT",Helper.converAmount(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("PG_TA_BRTOT_AMT")))),strAmntVal));
				hshValues.put("PG_TA_NPA_ACS",correctNull(rs.getString("PG_TA_NPA_ACS")));
				//hshValues.put("PG_TA_NPA_AMT",correctNull(rs.getString("PG_TA_NPA_AMT")));
				hshValues.put("PG_TA_NPA_AMT",Helper.converAmount(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("PG_TA_NPA_AMT")))),strAmntVal));
				hshValues.put("PG_TA_NPAPER_ACS",correctNull(rs.getString("PG_TA_NPAPER_ACS")));
				hshValues.put("PG_TA_NPAPER_AMT",correctNull(rs.getString("PG_TA_NPAPER_AMT")));
				hshValues.put("PG_SL_BRTOT_ACS",correctNull(rs.getString("PG_SL_BRTOT_ACS")));
				//hshValues.put("PG_SL_BRTOT_AMT",correctNull(rs.getString("PG_SL_BRTOT_AMT")));
				hshValues.put("PG_SL_BRTOT_AMT",Helper.converAmount(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("PG_SL_BRTOT_AMT")))),strAmntVal)); 
				hshValues.put("PG_SL_NPA_ACS",correctNull(rs.getString("PG_SL_NPA_ACS")));
				//hshValues.put("PG_SL_NPA_AMT",correctNull(rs.getString("PG_SL_NPA_AMT")));
				hshValues.put("PG_SL_NPA_AMT",Helper.converAmount(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("PG_SL_NPA_AMT")))),strAmntVal));
				hshValues.put("PG_SL_NPAPER_ACS",correctNull(rs.getString("PG_SL_NPAPER_ACS")));
				hshValues.put("PG_SL_NPAPER_AMT",correctNull(rs.getString("PG_SL_NPAPER_AMT")));
				hshValues.put("PG_LE_BRTOT_ACS",correctNull(rs.getString("PG_LE_BRTOT_ACS")));
				//hshValues.put("PG_LE_BRTOT_AMT",correctNull(rs.getString("PG_LE_BRTOT_AMT")));
				hshValues.put("PG_LE_BRTOT_AMT",Helper.converAmount(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("PG_LE_BRTOT_AMT")))),strAmntVal));
				hshValues.put("PG_LE_NPA_ACS",correctNull(rs.getString("PG_LE_NPA_ACS")));
				hshValues.put("PG_LE_NPA_AMT",Helper.converAmount(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("PG_LE_NPA_AMT")))),strAmntVal));
				hshValues.put("PG_LE_NPAPER_ACS",correctNull(rs.getString("PG_LE_NPAPER_ACS")));
				hshValues.put("PG_LE_NPAPER_AMT",correctNull(rs.getString("PG_LE_NPAPER_AMT")));
				hshValues.put("PG_ANYOTHER_INFO",correctNull(rs.getString("PG_ANYOTHER_INFO")));
				hshValues.put("PG_RECOMMEND_BRANCH",correctNull(rs.getString("PG_RECOMMEND_BRANCH")));
//				hshValues.put("PG_EXISTING_FACILITY",Helper.correctNull(Helper.CLOBToString(rs.getClob("PG_EXISTING_FACILITY"))));
				
				hshValues.put("PG_INCEXPEN_DATE",correctNull(rs.getString("PG_INCEXPEN_DATE")));

				
				if(rs1!=null)
				{
					rs1.close();
				}
				strQuery= SQLParser.getSqlQuery("sel_appl_deviation^"+appno);
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					strdev_type=Helper.correctNull(rs1.getString("DEV_SUBTYPE"));
					if (rs2 != null) {
						rs2.close();
					}
					strQuery = SQLParser.getSqlQuery("sel_permEnable^"+ strdev_type);
					rs2 = DBUtils.executeQuery(strQuery);
					if (rs2.next()) {
						hshValues.put("DEV_SUBTYPE", correctNull(rs2.getString("PER_NAME")));
					}
					strMaintype = Helper.correctNull(rs1.getString("DEV_TYPE"));
					if (rs2 != null) {
						rs2.close();
					}
					strQuery = SQLParser.getSqlQuery("sel_permEnable^"+ strMaintype);
					rs2 = DBUtils.executeQuery(strQuery);
					if (rs2.next()) {
						hshValues.put("DEV_MAINTYPE", correctNull(rs2.getString("PER_NAME")));
					}
				}	
				// for dev_parameters
				if(rs1!=null)
				{
					rs1.close();
				}
				String param_desc="";
				strQuery= SQLParser.getSqlQuery("sel_appl_deviation^"+appno);
				rs1=DBUtils.executeQuery(strQuery);
				arrRow=new ArrayList();
				if(rs1.next())
				{
					String strParams=correctNull(rs1.getString("DEV_DEVPARAM"));
					String[] strparam_ind=strParams.split("@");
					for(int i=0;i<strparam_ind.length;i++){
						
						if (rs2 != null) {rs2.close();}
						strQuery = SQLParser.getSqlQuery("sel_parameter^"+ strparam_ind[i]);
						rs2 = DBUtils.executeQuery(strQuery);
						if (rs2.next()) {
							param_desc=param_desc+","+correctNull(rs2.getString("PER_NAME"));
						}
					}
					hshValues.put("DEV_DEVPARAMDESC",param_desc.replaceFirst(",", ""));
				}
				
				
			/*	if(strdev_type.equalsIgnoreCase("5"))
				{	
					if(!Helper.correctNull(Helper.CLOBToString(rs.getClob("PG_EXISTING_FACILITY"))).equals(""))
					{
					String[] strfacilitydet=Helper.correctNull(Helper.CLOBToString(rs.getClob("PG_EXISTING_FACILITY"))).split("@");
					
					int strfacdet=strfacilitydet.length;
						for(int i=0;i<strfacdet;i++)
						{
							String[] valtemp=strfacilitydet[i].split("~");
							if(!valtemp.equals(""))
						      {
									arrCol5=new ArrayList(); 
									  
								//	arrCol5.add(valtemp[1].trim());
								/*	String nature_loan=valtemp[1];
									
									if(!nature_loan.equalsIgnoreCase(""))
									{
									if(rs1!=null)
										rs1.close();
										strQuery = SQLParser.getSqlQuery("selstatdatabyiddesc^"+"144^"+nature_loan);
										rs1 = DBUtils.executeQuery(strQuery);
										if(rs1.next())
										{
											arrCol5.add(Helper.correctNull(rs1.getString("stat_data_desc1")));
										}
										else
										{
											arrCol5.add("");
										}
									}
									else
									{
										arrCol5.add("");
									}
									
									
									arrCol5.add(valtemp[0].trim());
									arrCol5.add(valtemp[1].trim());
									arrCol5.add(valtemp[2].trim());
									arrCol5.add(valtemp[3].trim());
									arrCol5.add(valtemp[4].trim());
									arrCol5.add(valtemp[5].trim());
									arrCol5.add(valtemp[6].trim());
									arrCol5.add(valtemp[7].trim());
									arrCol5.add(valtemp[8].trim());
									arrCol5.add(valtemp[9].trim());
									arrCol5.add(valtemp[10].trim());
									arrRow5.add(arrCol5);				
							  }		
							  hshValues.put("arrData5", arrRow5);
						}
						
					}
					
				}else if(strdev_type.equalsIgnoreCase("3")||strdev_type.equalsIgnoreCase("4")||strdev_type.equalsIgnoreCase("6"))
				{
					
					if(!Helper.correctNull(Helper.CLOBToString(rs.getClob("PG_EXISTING_FACILITY"))).equals(""))
					{
					String[] strfacilitydet=Helper.correctNull(Helper.CLOBToString(rs.getClob("PG_EXISTING_FACILITY"))).split("@");
					
					int strfacdet=strfacilitydet.length;
						for(int i=0;i<strfacdet;i++)
						{
							String[] valtemp=strfacilitydet[i].split("~");
							if(!valtemp.equals(""))
						      {
									arrCol5=new ArrayList(); 
									  
									/*arrCol5.add(valtemp[0].trim());
									
									String nature_loan=valtemp[0];
									
									if(!nature_loan.equalsIgnoreCase(""))
									{
									if(rs1!=null)
										rs1.close();
										strQuery = SQLParser.getSqlQuery("selstatdatabyiddesc^"+"144^"+nature_loan);
										rs1 = DBUtils.executeQuery(strQuery);
										if(rs1.next())
										{
											arrCol5.add(Helper.correctNull(rs1.getString("stat_data_desc1")));
										}
										else
										{
											arrCol5.add("");
										}
									}
									else
									{
										arrCol5.add("");
									}
									
									arrCol5.add(valtemp[0].trim());
									arrCol5.add(valtemp[1].trim());
									
									arrCol5.add(valtemp[2].trim());
									arrCol5.add(valtemp[3].trim());
									arrCol5.add(valtemp[4].trim());
									arrCol5.add(valtemp[5].trim());
									arrCol5.add(valtemp[6].trim());
									arrCol5.add(valtemp[7].trim());
									arrCol5.add(valtemp[8].trim());
									arrCol5.add(valtemp[9].trim());
									arrCol5.add(valtemp[10].trim());
									arrCol5.add(valtemp[11].trim());
									arrCol5.add(valtemp[12].trim());
									arrCol5.add(valtemp[13].trim());
									arrRow5.add(arrCol5);				
							  }		
							  hshValues.put("arrData5", arrRow5);
						}
						
					}
					
				}
				else
				{
					//hshValues.put("PG_EXISTING_FACILITY",correctNull(rs.getString("PG_EXISTING_FACILITY")));
				}
				*/
				hshValues.put("PG_CONSTITUTED_ON",correctNull(rs.getString("PG_CONSTITUTED_ON")));
				
				String strAddress=correctNull(rs.getString("PG_APPLADDRESS1"));
				if(!correctNull(rs.getString("PG_APPLADDRESS2")).equalsIgnoreCase(""))
				{
					strAddress=strAddress+",<br/>"+correctNull(rs.getString("PG_APPLADDRESS2"));
				}
				
				if(rs1 !=null)
				{
					rs1.close();
				}
				rs1=DBUtils.executeLAPSQuery("sel_distnamebycode^"+ correctNull(rs.getString("PG_DISTCODE")));	
				if (rs1.next()) 
				{
					strAddress=strAddress+",<br/>"+correctNull(rs1.getString("district_desc"));

				}
				if(rs1 !=null)
				{
					rs1.close();
				}
				rs1=DBUtils.executeLAPSQuery("sel_citynamebycode^"+ correctNull(rs.getString("PG_CITYCODE")));	
				if (rs1.next()) 
				{
					strAddress=strAddress+",<br/>"+correctNull(rs1.getString("city_name"));
				}
				if(rs1 !=null)
				{
					rs1.close();
				}
				rs1=DBUtils.executeLAPSQuery("sel_statenamebycode^"+ correctNull(rs.getString("PG_STATECODE")));	
				if (rs1.next()) 
				{
					strAddress=strAddress+",<br/>"+correctNull(rs1.getString("state_name"));
				}
				
				if(!correctNull(rs.getString("PG_PINCODE")).equalsIgnoreCase(""))
				{
					strAddress=strAddress+",<br/>Pin - "+correctNull(rs.getString("PG_PINCODE"));
				}
				if(!correctNull(rs.getString("PG_PHONE_NUMBER")).equalsIgnoreCase(""))
				{
					strAddress=strAddress+",<br/>Phone - "+correctNull(rs.getString("PG_PHONE_NUMBER"));
				}
				if(!correctNull(rs.getString("PG_MAIL_ID")).equalsIgnoreCase(""))
				{
					strAddress=strAddress+",<br/>EMail - "+correctNull(rs.getString("PG_MAIL_ID"));
				}
				
				hshValues.put("PG_APPLADDRESS",strAddress.toUpperCase());

				hshValues.put("PG_RATINGDATE",correctNull(rs.getString("PG_RATINGDATE")));
				String borrating=Helper.correctNull(rs.getString("PG_BOR_RATING"));
				
				if(rs1!=null)
					rs1.close();
				strQuery= SQLParser.getSqlQuery("sel_ratingCode_desc^"+borrating);
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					hshValues.put("PG_BOR_RATING",correctNull(rs1.getString("RATING_DESC")));

				}
				
				hshValues.put("PG_CIBIL_SCORE",correctNull(rs.getString("PG_CIBIL_SCORE")));
				hshValues.put("PG_CIBIL_DETAILS",correctNull(rs.getString("PG_CIBIL_DETAILS")));
				hshValues.put("PG_CIBIL_REPORTEDDATE",correctNull(rs.getString("PG_CIBIL_REPORTEDDATE")));
				hshValues.put("PG_CRIF_SCORE",correctNull(rs.getString("PG_CRIF_SCORE")));
				hshValues.put("PG_CRIF_DETAILS",correctNull(rs.getString("PG_CRIF_DETAILS")));
				hshValues.put("PG_CRIF_DATE",correctNull(rs.getString("PG_CRIF_DATE")));
				hshValues.put("PG_PRIME_SECVAL",Helper.converAmount(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("PG_PRIME_SECVAL")))),strAmntVal));
				hshValues.put("PG_COLLATERAL_SECVAL",Helper.converAmount(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("PG_COLLATERAL_SECVAL")))),strAmntVal));
				//hshValues.put("PG_PRIME_SECVAL",Helper.correctDouble(rs.getString("PG_PRIME_SECVAL")));
				//hshValues.put("PG_COLLATERAL_SECVAL",Helper.correctDouble(rs.getString("PG_COLLATERAL_SECVAL")));
				
			}
			
			if(rs!=null)
			rs.close();
			strQuery = SQLParser.getSqlQuery("sel_proposalflow^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString(1)));
				
				if(rs1!=null)
				rs1.close();
				strQuery = SQLParser.getSqlQuery("sel_CBSStaticDataPassingCode^"+"27^"+correctNull(rs.getString(2)));
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					arrCol.add(Helper.correctNull((String)rs1.getString("CBS_STATIC_DATA_DESC")));//13
				}
				else
				{
					arrCol.add(correctNull(rs.getString(2)));
				}
					
				arrRow.add(arrCol);		
						
			}
				
			hshValues.put("arrRow1",arrRow);
		
			strQuery= SQLParser.getSqlQuery("sel_permissionGist_loanreq^"+appno);
			ArrayList arrCol1= new ArrayList();
			ArrayList arrRow1 = new ArrayList();
			rs1=DBUtils.executeQuery(strQuery);
			while(rs1.next())
			{
				arrCol1 = new ArrayList();
				
				if(!Helper.correctNull(rs1.getString("DEV_PRESENT_NATURE")).equalsIgnoreCase("")){
				if(rs!=null)
				rs.close();
				strQuery = SQLParser.getSqlQuery("selstatdatabyiddesc^"+"144^"+Helper.correctNull(rs1.getString("DEV_PRESENT_NATURE")));
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					arrCol1.add(Helper.correctNull(rs.getString("stat_data_desc1")));
				}
				else
				{
					arrCol1.add("");
				}
				}
				else
				{
					arrCol1.add("");
				}
				arrCol1.add(Helper.converAmount(nf.format(Double.parseDouble(Helper.correctDouble(rs1.getString("DEV_PRESENT_LOANAMT")))),strAmntVal));
				//arrCol1.add(Helper.correctNull(rs1.getString("DEV_PRESENT_LOANAMT")));
				arrCol1.add(Helper.correctNull(rs1.getString("DEV_PRESENT_INTEREST")));
				arrCol1.add(Helper.correctNull(rs1.getString("DEV_PRESENT_PERIOD")));
				arrCol1.add(Helper.correctNull(rs1.getString("DEV_PRESENT_PURPOSE")));
				if(!Helper.correctNull(rs1.getString("DEV_PRESENT_BANKSCHEME")).equalsIgnoreCase("")){
					if(rs!=null)
					rs.close();
					strQuery = SQLParser.getSqlQuery("selmisschemflagdetails^"+"1^"+Helper.correctNull(rs1.getString("DEV_PRESENT_BANKSCHEME")));
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{arrCol1.add(Helper.correctNull(rs.getString("mis_static_data_desc")));	}
					else
					{arrCol1.add("");}
				}else
					{
						arrCol1.add("");
					}
				arrRow1.add(arrCol1);				
			}		
			hshValues.put("arrData", arrRow1);
			
			if(rs1!=null)
				rs1.close();
			strQuery= SQLParser.getSqlQuery("sel_perm_assessment^"+appno);
			ArrayList arrCol2= new ArrayList();
			ArrayList arrRow2 = new ArrayList();
			String marksum="",branchsum="";
			String hosum="";
			double temp=0,temp1=0,temp2=0;
			rs1=DBUtils.executeQuery(strQuery);
			String sl_no="";
			int count=0;
			while(rs1.next())
			{
				arrCol2 = new ArrayList();
				if(!correctNull(rs1.getString("PERM_DESCRIPTION")).equals(""))
				{
					if(rs != null)
					rs.close();					
					strQuery = SQLParser.getSqlQuery("sel_deviationdesc^"+Helper.correctNull(rs1.getString("PERM_DESCRIPTION")));
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						arrCol2.add(Helper.correctNull(rs.getString("perm_type_description"))); //0
					}
					else
					{
						arrCol2.add("");//0
					}
					
				}
				else
				{
					arrCol2.add("");//0
				}
				
				if(!correctNull(rs1.getString("PERM_SUB_DESCRIPTION")).equals(""))
				{
					String[] strModifiedField=Helper.correctNull(rs1.getString("PERM_SUB_DESCRIPTION")).split("@");
					for(int i=0;i<strModifiedField.length;i++)
					{
						sl_no=strModifiedField[1];
						
					}
					if(rs != null)
					rs.close();					
					strQuery = SQLParser.getSqlQuery("sel_annexure_assessment^"+Helper.correctNull(rs1.getString("PERM_DESCRIPTION"))+"^"+sl_no);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						arrCol2.add(Helper.correctNull(rs.getString("PERM_RANGE"))); //1
					}
					else
					{
						arrCol2.add("");//1
					}
					
				}
				else
				{
					arrCol2.add("");//1
				}
				
				
				
				arrCol2.add(Helper.correctNull(rs1.getString("PERM_MAXMARKS"))); //2
				marksum=Helper.correctInt(rs1.getString("PERM_MAXMARKS"));
				temp+=Integer.parseInt(marksum);
				hshValues.put("temp", String.valueOf(temp));
				
				arrCol2.add(Helper.correctNull(rs1.getString("PERM_BRANCH_VALUE"))); //3
				branchsum=Helper.correctDouble(rs1.getString("PERM_BRANCH_VALUE"));
				temp1+=Double.parseDouble(branchsum);
				hshValues.put("temp1",  String.valueOf(temp1));
				
				arrCol2.add(Helper.correctNull(rs1.getString("PERM_HO_VALUE"))); //4
				hosum=Helper.correctDouble(rs1.getString("PERM_HO_VALUE"));
				temp2+=Double.parseDouble(hosum);
				hshValues.put("temp2", String.valueOf(temp2));
				
				arrRow2.add(arrCol2);				
			}		
			hshValues.put("arrData1", arrRow2);
			
		
			if(rs1!=null)
			{
				rs1.close();
			}
			strQuery= SQLParser.getSqlQuery("sel_perm_details^"+appno);
			rs1=DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				hshValues.put("hshorg_code",correctNull(rs1.getString("org_code")));
				hshValues.put("hshorg_scode",correctNull(rs1.getString("org_scode")));
				hshValues.put("hshorg_name",correctNull(rs1.getString("org_name")));
				hshValues.put("hshORG_MANAGER_CTNUM",correctNull(rs1.getString("ORG_MANAGER_CTNUM")));
			}
			if(rs1!=null)
			{
				rs1.close();
			}
			strQuery= SQLParser.getSqlQuery("sel_basicinformation^"+ appno);
			rs1=DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				hshValues.put("PERM_SANC_AUTH",Helper.correctNull(rs1.getString("PERM_SANC_AUTH")));
				hshValues.put("PERM_REFNO",Helper.correctNull(rs1.getString("PERM_REFNO")));
				hshValues.put("PERM_SANC_DATE",Helper.correctNull(rs1.getString("PERM_SANC_DATE")));
				String PERM_PROP_SUBMITTED=correctNull(rs1.getString("PERM_PROP_SUBMITTED"));
				strQuery= SQLParser.getSqlQuery("getstaticdata_soldid^21^"+PERM_PROP_SUBMITTED);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshValues.put("PERM_PROP_SUBMITTED",correctNull(rs.getString("stat_data_desc1")));

				}
				
				if(!Helper.correctNull(rs1.getString("PERM_PER_BRANCH")).equalsIgnoreCase(""))
				{
					if(rs!=null)
						rs.close();
					strQuery= SQLParser.getSqlQuery("selectorgname^"+Helper.correctNull(rs1.getString("PERM_PER_BRANCH")));
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshValues.put("hshorg_code",correctNull(rs.getString("org_code")));
						hshValues.put("hshorg_scode",correctNull(rs.getString("org_scode")));
						hshValues.put("hshorg_name",correctNull(rs.getString("org_name")));
						hshValues.put("hshORG_MANAGER_CTNUM",correctNull(rs.getString("ORG_MANAGER_CTNUM")));

					}
					
				}
				
				hshValues.put("PERM_SANC_DEPT", Helper.correctNull(rs1.getString("PERM_SANC_DEPT")));
				hshValues.put("PERM_SANC_BRANCH", Helper.correctNull(rs1.getString("PERM_SANC_BRANCH")));
			}
			if(!Helper.correctNull((String)hshValues.get("hshorg_code")).equalsIgnoreCase(""))
			{
				String apporgcode=Helper.correctNull((String)hshValues.get("hshorg_code")).substring(0,6)+"000000000";
				if(rs1!=null)
				{
					rs1.close();
				}
				strQuery= SQLParser.getSqlQuery("selorgname^"+ apporgcode);
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					hshValues.put("hshorg_Regionname",correctNull(rs1.getString("org_name")));
				}
			}
			
			hshValues=getdataFinancial(hshValues);	
			
			if(rs1!=null)
			{
				rs1.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_perm_applbg_comments^"+appno);
			rs1 = DBUtils.executeQuery(strQuery);
			while(rs1.next())
			{
				hshValues.put("strBkgroundcmts", correctNull(Helper.CLOBToString(rs1.getClob("APPLBG_COMMENTS"))));
			}
			
			ArrayList arrPermID=new ArrayList();
			String strCBSID="";
			if(rs!=null)
			{
				rs.close();
			}
			strQuery= SQLParser.getSqlQuery("sel_appl_deviation_int^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{
				String strQuery11="";
				strCBSID=correctNull(rs.getString("DEV_CBSID"));
				String parameter=correctNull(rs.getString("DEV_DEVPARAM"));
				if(rs1!=null)
				{rs1.close();}
				if(!parameter.equalsIgnoreCase(""))
				{
					int countA=0;
					int countB=0;
					String strArr[]=parameter.split("@");
					for(int i=0;i<strArr.length;i++)
					{
						arrPermID.add(strArr[i]);
						strQuery11 = SQLParser.getSqlQuery("sel_parameter^"+strArr[i]);
						rs1 = DBUtils.executeQuery(strQuery11);
						if (rs1.next())
						{
							if(Helper.correctNull(rs1.getString("PER_INTEREST")).equalsIgnoreCase("Y"))
							{
								countA++;
							}
							if(Helper.correctNull(rs1.getString("PER_FINANCE")).equalsIgnoreCase("Y"))
							{
								countB++;
							}
							
						}
					}
					if(countA>0)
					{
						hshValues.put("assessment","Y");
					}
					if(countB>0)
					{
						hshValues.put("finance","Y");
					}
				}
			}
			hshValues.put("arrPermID",arrPermID);
			
			
			if(!strCBSID.equalsIgnoreCase(""))
			{
				if(rs!=null)
					rs.close();
				
				strQuery= SQLParser.getSqlQuery("sel_cuscibildetails^"+strCBSID);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshValues.put("PG_CIBIL_SCORE",correctNull(rs.getString("cibil_score")));
					hshValues.put("PG_CIBIL_DETAILS",correctNull(rs.getString("cibil_details")));
					hshValues.put("PG_CIBIL_REPORTEDDATE",correctNull(rs.getString("cibil_reporteddate")));
					hshValues.put("PG_CRIF_SCORE",correctNull(rs.getString("CRIF_SCORE")));
					hshValues.put("PG_CRIF_DETAILS",correctNull(rs.getString("CRIF_DETAILS")));
					hshValues.put("PG_CRIF_DATE",correctNull(rs.getString("CRIF_DATE")));
				}
				
			}
			
			if(rs!=null)
			{
				rs.close();
			}
			strQuery= SQLParser.getSqlQuery("sel_perm_moredet_depacc^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				arrCol6=new ArrayList(); 
				  
				arrCol6.add(correctNull(rs.getString("PERM_EXISTDEP_NAME")));
				arrCol6.add(correctNull(rs.getString("PERM_EXISTDEP_ACCNO")));
				arrCol6.add(Helper.converAmount(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("PERM_EXISTDEP_DEPOSITAMT")))),strAmntVal));
				arrCol6.add(Helper.converAmount(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("PERM_EXISTDEP_PRESENTBAL")))),strAmntVal));
				//arrCol6.add(correctNull(rs.getString("PERM_EXISTDEP_DEPOSITAMT")));
				//arrCol6.add(correctNull(rs.getString("PERM_EXISTDEP_PRESENTBAL")));
				arrCol6.add(correctNull(rs.getString("PERM_EXISTDEP_MATURITYDATE")));
				arrCol6.add(correctNull(rs.getString("PERM_EXISTDEP_ROI")));
				arrRow6.add(arrCol6);				
		  }		
		  hshValues.put("arrData6", arrRow6);
			
		  
		  if(rs!=null)
			{
				rs.close();
			}
			strQuery= SQLParser.getSqlQuery("sel_perm_moredet_secdet^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			ArrayList lstTemp=new ArrayList();
			double dblSecTot=0.0;
			while(rs.next())
			{
				arrCol7=new ArrayList(); 
				  
				arrCol7.add(correctNull(rs.getString("PERM_EXISTSEC_PROPOSALNO")));
				arrCol7.add(correctNull(rs.getString("PERM_EXISTSEC_FACSNO")));
				arrCol7.add(correctNull(rs.getString("PERM_EXISTSEC_SECID")));
				arrCol7.add(correctNull(rs.getString("PERM_EXISTSEC_APPLNAME")));
				arrCol7.add(correctNull(rs.getString("PERM_EXISTSEC_SECDESCRIP")));
				arrCol7.add(Helper.converAmount(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("PERM_EXISTSEC_SECVALUE")))),strAmntVal));
				//arrCol7.add(correctNull(rs.getString("PERM_EXISTSEC_SECVALUE")));
				
				if(!correctNull(rs.getString("PERM_EXISTSEC_SECTYPE")).equalsIgnoreCase(""))
				{
					if(correctNull(rs.getString("PERM_EXISTSEC_SECTYPE")).equals("1"))
					{
						arrCol7.add("Primary");
					}
					else if(correctNull(rs.getString("PERM_EXISTSEC_SECTYPE")).equals("2"))
					{
						arrCol7.add("Collateral");
					}
					else
					{
						arrCol7.add(correctNull(rs.getString("PERM_EXISTSEC_SECTYPE")));
					}
				}
				else
				{
					arrCol7.add(correctNull(rs.getString("PERM_EXISTSEC_SECTYPE")));
				}
				
				arrCol7.add(correctNull(rs.getString("PERM_EXISTSEC_MARGIN")));
				
				arrRow7.add(arrCol7);
				
				if(!lstTemp.contains(correctNull(rs.getString("PERM_EXISTSEC_SECID"))))
				{
					lstTemp.add(correctNull(rs.getString("PERM_EXISTSEC_SECID")));
					dblSecTot+=Double.parseDouble(Helper.correctDouble(rs.getString("PERM_EXISTSEC_SECVALUE")));
				}
		  }		
		  hshValues.put("arrData7", arrRow7);
		  hshValues.put("dblSecTotal", Helper.converAmount(nf.format(dblSecTot),strAmntVal));
		  
		  
		  
		  if(rs!=null)
			{
				rs.close();
			}
			strQuery= SQLParser.getSqlQuery("sel_perm_moredet_othbank^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				arrCol8=new ArrayList(); 
				arrCol8.add(correctNull(rs.getString("PERM_EXST_BANKNAME")));
				arrCol8.add(correctNull(rs.getString("PERM_EXST_FACILITY")));
				arrCol8.add(Helper.converAmount(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("PERM_EXST_LIMIT")))),strAmntVal));
				//arrCol8.add(correctNull(rs.getString("PERM_EXST_LIMIT")));
				arrCol8.add(correctNull(rs.getString("PERM_EXST_DUEDATE")));
				arrCol8.add(correctNull(rs.getString("PERM_EXST_ARREARS")));
				
				if(!correctNull(rs.getString("PERM_EXST_BANKNAME")).equals(""))
				{
					if(rs1!=null)
					{
						rs1.close();
					}
					rs1 = DBUtils.executeLAPSQuery("getstaticdescription^"+"147"+"^"+correctNull(rs.getString("PERM_EXST_BANKNAME")));
					if(rs1.next())
					{
						arrCol8.add(Helper.correctNull(rs1.getString("STAT_DATA_DESC1")));
					}
					else
					{
						arrCol8.add(correctNull(rs.getString("PERM_EXST_BANKNAME")));
					}
				}	
				else
				{
					arrCol8.add(correctNull(rs.getString("PERM_EXST_BANKNAME")));
				}
				arrRow8.add(arrCol8);				
		  }		
		  hshValues.put("arrData8", arrRow8);
		 double dblSanctionAmt=0.0,dblOutstanding=0.0;
		  
		  if(rs!=null)
			{
				rs.close();
			}
			strQuery= SQLParser.getSqlQuery("sel_perm_moredet_extfac^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			
		  if(strdev_type.equalsIgnoreCase("5"))
		  {
			  while(rs.next())
				{	
			  		arrCol5=new ArrayList(); 
					
					arrCol5.add(correctNull(rs.getString("PERM_EXIST_APPNO")));
					arrCol5.add(correctNull(rs.getString("PERM_EXIST_FACSNO")));
					arrCol5.add(correctNull(rs.getString("PERM_EXIST_MODTYPE")));
					arrCol5.add(correctNull(rs.getString("PERM_EXIST_BORNAME")));
					arrCol5.add(correctNull(rs.getString("PERM_EXIST_FACNAME")));
					arrCol5.add(correctNull(rs.getString("PERM_EXIST_SANCDATE")));
					arrCol5.add(Helper.converAmount(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("PERM_EXIST_LIMIT")))),strAmntVal));
					arrCol5.add(Helper.converAmount(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("PERM_EXIST_BALANCEOS")))),strAmntVal));
					//arrCol5.add(correctNull(rs.getString("PERM_EXIST_LIMIT")));
					//arrCol5.add(correctNull(rs.getString("PERM_EXIST_BALANCEOS")));
					arrCol5.add(correctNull(rs.getString("PERM_EXIST_PRESENTROI")));
					arrCol5.add(correctNull(rs.getString("PERM_EXIST_DUEDATE")));
					arrCol5.add(correctNull(rs.getString("PERM_EXIST_ARREARSTATUS")));
					arrRow5.add(arrCol5);	
					
					dblSanctionAmt+=Double.parseDouble(Helper.correctDouble(rs.getString("PERM_EXIST_LIMIT")));
					dblOutstanding+=Double.parseDouble(Helper.correctDouble(rs.getString("PERM_EXIST_BALANCEOS")));
			  }		
			  hshValues.put("arrData5", arrRow5);
			  hshValues.put("strExposureTot", Helper.converAmount(nf.format(dblSanctionAmt),strAmntVal));
			  hshValues.put("strOutstandingTot", Helper.converAmount(nf.format(dblOutstanding),strAmntVal));
			  
		  }else if(strdev_type.equalsIgnoreCase("3")||strdev_type.equalsIgnoreCase("4")||strdev_type.equalsIgnoreCase("6"))
		  {
			  while(rs.next())
				{
				  	arrCol5=new ArrayList();
					arrCol5.add(correctNull(rs.getString("PERM_EXIST_APPNO")));//0
					arrCol5.add(correctNull(rs.getString("PERM_EXIST_FACSNO")));//1
					arrCol5.add(correctNull(rs.getString("PERM_EXIST_FACNAME")));//2
					arrCol5.add(correctNull(rs.getString("PERM_EXIST_MODTYPE")));//3
					arrCol5.add(correctNull(rs.getString("PERM_EXIST_ACCNO")));//4
					arrCol5.add(Helper.converAmount(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("PERM_EXIST_LIMIT")))),strAmntVal));// 5
					//arrCol5.add(correctNull(rs.getString("PERM_EXIST_LIMIT")));//5
					arrCol5.add(correctNull(rs.getString("PERM_EXIST_PURPOSE")));//6
					arrCol5.add(correctNull(rs.getString("PERM_EXIST_SANCREFNO")));//7
					arrCol5.add(correctNull(rs.getString("PERM_EXIST_SANCDATE")));//8
					arrCol5.add(correctNull(rs.getString("PERM_EXIST_SANCROI")));//9
					arrCol5.add(correctNull(rs.getString("PERM_EXIST_PRESENTROI")));//10
					arrCol5.add(Helper.converAmount(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("PERM_EXIST_BALANCEOS")))),strAmntVal));// 5
					//arrCol5.add(correctNull(rs.getString("PERM_EXIST_BALANCEOS")));//11
					arrCol5.add(correctNull(rs.getString("PERM_EXIST_DUEDATE")));//12
					arrCol5.add(correctNull(rs.getString("PERM_EXIST_ARREARSTATUS")));//13
					arrCol5.add(correctNull(rs.getString("PERM_EXIST_BORNAME")));//14
					arrRow5.add(arrCol5);
					
					dblSanctionAmt+=Double.parseDouble(Helper.correctDouble(rs.getString("PERM_EXIST_LIMIT")));
					dblOutstanding+=Double.parseDouble(Helper.correctDouble(rs.getString("PERM_EXIST_BALANCEOS")));
				}
			  hshValues.put("arrData5", arrRow5);
			  hshValues.put("strExposureTot", Helper.converAmount(nf.format(dblSanctionAmt),strAmntVal));
			  hshValues.put("strOutstandingTot", Helper.converAmount(nf.format(dblOutstanding),strAmntVal));
				
		  }
		  
		  	if(rs!=null)
			{
				rs.close();
			}
		  	strQuery = SQLParser.getSqlQuery("sel_recomments^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("PG_RECOMMEND_HO", correctNull(Helper.CLOBToString(rs.getClob("PERM_COMMENTS2"))));
				hshValues.put("PG_RECOMMEND_HOVIEW", correctNull(Helper.CLOBToString(rs.getClob("PERM_COMMENTS3"))));
			}
			
			arrRow=new ArrayList();
			arrCol=new ArrayList();
			strQuery = SQLParser.getSqlQuery("sel_PERM_TERMSANDCOND_print^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("PERM_TERMSCONTENT")));
				arrRow.add(arrCol);
			}
			hshValues.put("arrRow9",arrRow);
			
			if(rs1!=null)
				rs1.close();
			strQuery = SQLParser.getSqlQuery("sel_basicinformation^"+appno);
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				hshValues.put("PERM_HANDLING_CHARGE",Helper.correctDouble(rs1.getString("PERM_HANDLING_CHARGE")));
			}
			
			
			if(rs1!=null){
				rs1.close();
			}
	
			String strQuery1=null;
			ResultSet  rs4=null;
			   ArrayList arrCol14 = new ArrayList();
			strQuery1=SQLParser.getSqlQuery("sel_permissionmaster");
			rs = DBUtils.executeQuery(strQuery1);
			while(rs.next()){
				strQuery1=SQLParser.getSqlQuery("sel_paramcheck^"+appno+"^"+Helper.correctInt((String) rs.getString("PER_ID")));
				rs4 = DBUtils.executeQuery(strQuery1);
				while(rs4.next())
				{		
					   arrCol4.add(correctNull(rs.getString(1)));
					   arrCol4.add(correctNull(rs.getString(2)));
				}
			 
		}
			
			
			 int	intHuntScore=0;
			 String flag="";
			 
			 if (arrCol4 != null && arrCol4.size()> 0) {
					flag = "Y";
				}
				else
				{
					flag = "N";
				}

			 if(flag.equalsIgnoreCase("Y")){
			strQuery1 = SQLParser.getSqlQuery("sel_perpropcheck^"+strCBSID);
			rs=DBUtils.executeQuery(strQuery1); 

			if(rs.next()) {
				intHuntScore=Integer.parseInt( Helper.correctInt((String) rs.getString("DEF_HUNTER_SCORE")));
				 
			}
			 }
			// hshValues.put("arrRow",arrRow);
			 hshValues.put("intHuntScore1",String.valueOf(intHuntScore));
			 hshValues.put("flag",flag);
			 hshValues.put("arrCol4", arrCol4);
			 
			if(rs!=null)
			{
				rs.close();
			}
			
			
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getAnnexure===== "+e.getMessage());
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
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		
		return hshValues;
	}
public HashMap getExecutive(HashMap hshValues) {
	   
   	ResultSet rs=null;
   	String strQuery = null;
   	String strAppno="";
   	try
   	{	
   		strAppno=Helper.correctNull((String)hshValues.get("appno"));
   		strQuery= SQLParser.getSqlQuery("sel_appl_deviation^"+strAppno);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			hshValues.put("strAnnexure",Helper.correctNull(rs.getString("DEV_SUBTYPE")));
		}
		
   		
   	}
   	catch(Exception ce)
   	{
   	
   		throw new EJBException("Error in getExecutive "+ce.toString());
   	}
   	
   	return hshValues;
	   
   }
public HashMap updateAction(HashMap hshValues) 
{
	String strAppno="",strExcep="$";
	ResultSet rs1=null;
	String strAction="";
	String strFromflowpoint="";
	String strToflowpoint="";
	String strFromuserid="",strQuery="";
	String strTouserid="";
	ResultSet rs=null;
	ResultSet rs2=null;
	int intUpdateSize = 0;
	HashMap hshQueryValues=new HashMap();
	HashMap hshQuery=new HashMap();
	ArrayList arrValues=new ArrayList();
	String appstatus="";
	String str_sent_orgcode="";
	String strOrgLevel="";
	String strExp= "$";
	String strModeOfOperation= "";
	String strDeptHead="";
	String application_flag="";
	String devorgscode="";
	String applholder="";
	
	try
	{
		strAction=(String)hshValues.get("hidAction");
		strAppno=(String)hshValues.get("appno");
		strFromflowpoint=correctNull((String)hshValues.get("mail_fromflowpoint"));
		strToflowpoint=(String)hshValues.get("mail_toflowpoint");
		strFromuserid=(String)hshValues.get("strUserId");
		strTouserid=(String)hshValues.get("hidmail_tousrid");
		appstatus=correctNull((String)hshValues.get("appstatus"));
		str_sent_orgcode=correctNull((String)hshValues.get("org_code"));
		strOrgLevel=correctNull((String)hshValues.get("strOrgLevel"));
		if(rs1!=null)
		{
			rs1.close();
		}
		
		if(strTouserid.equals(""))
		{
			strTouserid=strFromuserid;
		}
		
		if(strAction.equalsIgnoreCase("send"))
		{
			if(strToflowpoint.equalsIgnoreCase("")||strFromflowpoint.equalsIgnoreCase(""))
			{
				throw new Exception("$ Flow Point Not found. Please again");
			}
		}
		else if(strAction.equalsIgnoreCase("approve")||strAction.equalsIgnoreCase("reject"))
		{
			if(strFromflowpoint.equalsIgnoreCase(""))
			{
				throw new Exception("$ Flow Point Not found. Please again");
			}
		}
		
		String strPermissions="",strPermStatus="";
		strQuery = SQLParser.getSqlQuery("sel_appl_deviation^"+strAppno);
		rs = DBUtils.executeQuery(strQuery);	
		if(rs.next())
		{
			strPermissions=correctNull(rs.getString("DEV_DEVPARAM"));
			devorgscode=correctNull(rs.getString("DEV_ORGSCODE"));
			applholder=correctNull(rs.getString("dev_applholder"));
			
		}
		String StrLoanType="";
		rs=DBUtils.executeLAPSQuery("sel_app_perm_no^"+ strAppno);			 
		if(rs.next()) 
		{
			StrLoanType=Helper.correctNull((String)rs.getString("APP_LOANSUBTYPE_DIGI"));
		}
		if(StrLoanType.equalsIgnoreCase("PR"))
		{
			if(strAction!=null && strAction.equalsIgnoreCase("send"))
			{
				
				hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","updmailbxchkstatus");
				arrValues.add("Y");
				arrValues.add(strTouserid);
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				/* ********************* CC to FGMO/RO/both from sending branch proposal to FGMO or CO ***************** */
				String str_curorgcode=correctNull((String)hshValues.get("strOrgCode"));
				String strIsSaral=correctNull((String)hshValues.get("strIsSaral"));
				String strreg_head="";
				String strzon_head="";
				String strBranchtype="";
				String str_temporgcode="";
				HashMap hshQueryCC;
				ArrayList arrValuesCC;
				String str_sentorglevel="",strOrgHead="";
				HashMap hshQueryValuesCC=new HashMap();
				if(rs!=null)
					rs.close();
				if(rs!=null)
					rs.close();
				strQuery=SQLParser.getSqlQuery("selorg_level^"+str_sent_orgcode);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					str_sentorglevel = correctNull((String)rs.getString("org_level"));
					strOrgHead = correctNull((String)rs.getString("org_head"));
				}
				if(str_sentorglevel.equalsIgnoreCase("C"))
				{
					String strUsrDept=Helper.correctNull((String)hshValues.get("usr_department"));
					if(rs!=null)
					{
						rs.close();
					}
					strQuery=SQLParser.getSqlQuery("sel_CBSStaticDataPassingCode^20^"+strUsrDept);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strDeptHead=Helper.correctNull((String)rs.getString("cbs_static_data_passing_code"));
					}
					if(strDeptHead.equalsIgnoreCase(""))
					{
						throw new Exception("$ The Selected Department does not have Department Head ");
					}
					
					if(rs!=null)
						rs.close();
					
					String strOrgScode="";
					strQuery=SQLParser.getSqlQuery("workflowusersanlimit^"+strDeptHead);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strOrgScode=Helper.correctNull(rs.getString("org_scode"));
					}
					
					hshQueryCC=new HashMap();
					arrValuesCC=new ArrayList();
					hshQueryCC.put("strQueryId","commworkflowins");
					arrValuesCC.add(strAppno);
					arrValuesCC.add(strFromuserid);
					arrValuesCC.add(strDeptHead);
					arrValuesCC.add(strFromflowpoint);
					arrValuesCC.add(strToflowpoint);
					arrValuesCC.add("CC");
					
					arrValuesCC.add(correctNull((String)hshValues.get("strOrgShortCode")));
					if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
						arrValuesCC.add(correctNull((String)hshValues.get("strUserDepartment")));
					else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
						arrValuesCC.add(correctNull((String)hshValues.get("strRLPFUser")));
					else
						arrValuesCC.add("");
					
					arrValuesCC.add(strOrgScode);
					arrValuesCC.add(strUsrDept);
					
					hshQueryCC.put("arrValues",arrValuesCC);
					hshQueryValuesCC.put("1",hshQueryCC);
				}
				else
				{
					
					if(rs!=null)
						rs.close();
					
					String strOrgScode="",strDept="";
					strQuery=SQLParser.getSqlQuery("workflowusersanlimit^"+strOrgHead);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strOrgScode=Helper.correctNull(rs.getString("org_scode"));
						strDept=Helper.correctNull(rs.getString("usr_rlpftype"));
					}
					
					hshQueryCC=new HashMap();
					arrValuesCC=new ArrayList();
					hshQueryCC.put("strQueryId","commworkflowins");
					arrValuesCC.add(strAppno);
					arrValuesCC.add(strFromuserid);
					arrValuesCC.add(strOrgHead);
					arrValuesCC.add(strFromflowpoint);
					arrValuesCC.add(strToflowpoint);
					arrValuesCC.add("CC");
					
					arrValuesCC.add(correctNull((String)hshValues.get("strOrgShortCode")));
					if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
						arrValuesCC.add(correctNull((String)hshValues.get("strUserDepartment")));
					else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
						arrValuesCC.add(correctNull((String)hshValues.get("strRLPFUser")));
					else
						arrValuesCC.add("");
					
					arrValuesCC.add(strOrgScode);
					if(str_sentorglevel.equalsIgnoreCase("D"))
						arrValuesCC.add(strDept);
					else
						arrValuesCC.add("");
					
					hshQueryCC.put("arrValues",arrValuesCC);
					hshQueryValuesCC.put("1",hshQueryCC);
				}
				hshQueryValuesCC.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValuesCC,"updateData");
				
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","commworkflowins");
				arrValues.add(strAppno);
				arrValues.add(strFromuserid);
				arrValues.add(strTouserid);
				arrValues.add(strFromflowpoint);
				arrValues.add(strToflowpoint);
				arrValues.add("C");
				
				
				if(rs!=null)
					rs.close();
				
				String strOrgScode="",strDept="",strHeadUsrDept="";
				strQuery=SQLParser.getSqlQuery("workflowusersanlimit^"+strTouserid);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strOrgScode=Helper.correctNull(rs.getString("org_scode"));
					strDept=Helper.correctNull(rs.getString("usr_rlpftype"));
					strHeadUsrDept=Helper.correctNull(rs.getString("usr_department"));
				}
				
				arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
				if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
					arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
				else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
					arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
				else
					arrValues.add("");

				arrValues.add(strOrgScode);
				if(str_sentorglevel.equalsIgnoreCase("C"))
					arrValues.add(strHeadUsrDept);
				else if(str_sentorglevel.equalsIgnoreCase("D"))
					arrValues.add(strDept);
				else
					arrValues.add("");
				
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);

				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				if(rs!=null)
					rs.close();
				//-----------------------------------End--------------------------------
			}
		}
		else
		{
		
		String str_sentorglevel=""; 
		String strOrgHead="";
		
		if(rs!=null)
			rs.close();
		strQuery=SQLParser.getSqlQuery("selorg_level^"+str_sent_orgcode);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			str_sentorglevel = correctNull((String)rs.getString("org_level"));
			strOrgHead = correctNull((String)rs.getString("org_head"));
		}
		if(strAction!=null && strAction.equalsIgnoreCase("send"))
		{
			
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","updholderdetails");
			arrValues.add(strTouserid);
			arrValues.add(strAppno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			HashMap hshQueryCC;
			ArrayList arrValuesCC;
			HashMap hshQueryValuesCC=new HashMap();
			if(rs!=null)
				rs.close();
			
			if(str_sentorglevel.equalsIgnoreCase("C"))
			{
				String strUsrDept=Helper.correctNull((String)hshValues.get("usr_department"));
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("sel_CBSStaticDataPassingCode^20^"+strUsrDept);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strDeptHead=Helper.correctNull((String)rs.getString("cbs_static_data_passing_code"));
				}
				if(strDeptHead.equalsIgnoreCase(""))
				{
					throw new Exception("$ The Selected Department does not have Department Head ");
				}
				
				if(rs!=null)
					rs.close();
				
				String strOrgScode="";
				strQuery=SQLParser.getSqlQuery("workflowusersanlimit^"+strDeptHead);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strOrgScode=Helper.correctNull(rs.getString("org_scode"));
				}
				
				hshQueryCC=new HashMap();
				arrValuesCC=new ArrayList();
				hshQueryCC.put("strQueryId","ins_dev_appmailbox");
				arrValuesCC.add(strAppno);
				arrValuesCC.add(strFromuserid);
				arrValuesCC.add(strDeptHead);
				arrValuesCC.add(strFromflowpoint);
				arrValuesCC.add(strToflowpoint);
				arrValuesCC.add("CC");
				
				arrValuesCC.add(correctNull((String)hshValues.get("strOrgShortCode")));
				if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
					arrValuesCC.add(correctNull((String)hshValues.get("strUserDepartment")));
				else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
					arrValuesCC.add(correctNull((String)hshValues.get("strRLPFUser")));
				else
					arrValuesCC.add("");
				
				arrValuesCC.add(strOrgScode);
				arrValuesCC.add(strUsrDept);
				
				hshQueryCC.put("arrValues",arrValuesCC);
				hshQueryValuesCC.put("1",hshQueryCC);
			}
			else
			{
				
				if(rs!=null)
					rs.close();
				
				String strOrgScode="",strDept="";
				strQuery=SQLParser.getSqlQuery("workflowusersanlimit^"+strOrgHead);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strOrgScode=Helper.correctNull(rs.getString("org_scode"));
					strDept=Helper.correctNull(rs.getString("usr_rlpftype"));
				}
				
				hshQueryCC=new HashMap();
				arrValuesCC=new ArrayList();
				hshQueryCC.put("strQueryId","ins_dev_appmailbox");
				arrValuesCC.add(strAppno);
				arrValuesCC.add(strFromuserid);
				arrValuesCC.add(strOrgHead);
				arrValuesCC.add(strFromflowpoint);
				arrValuesCC.add(strToflowpoint);
				arrValuesCC.add("CC");
				
				arrValuesCC.add(correctNull((String)hshValues.get("strOrgShortCode")));
				if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
					arrValuesCC.add(correctNull((String)hshValues.get("strUserDepartment")));
				else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
					arrValuesCC.add(correctNull((String)hshValues.get("strRLPFUser")));
				else
					arrValuesCC.add("");
				
				arrValuesCC.add(strOrgScode);
				if(str_sentorglevel.equalsIgnoreCase("D"))
					arrValuesCC.add(strDept);
				else
					arrValuesCC.add("");
				
				hshQueryCC.put("arrValues",arrValuesCC);
				hshQueryValuesCC.put("1",hshQueryCC);
			}
			hshQueryValuesCC.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValuesCC,"updateData");
			
			hshQueryValues=new HashMap();
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","ins_dev_appmailbox");
			arrValues.add(strAppno);
			arrValues.add(strFromuserid);
			arrValues.add(strTouserid);
			arrValues.add(strFromflowpoint);
			arrValues.add(strToflowpoint);
			arrValues.add("C");
			
			
			if(rs!=null)
				rs.close();
			
			String strOrgScode="",strDept="",strHeadUsrDept="";
			strQuery=SQLParser.getSqlQuery("workflowusersanlimit^"+strTouserid);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strOrgScode=Helper.correctNull(rs.getString("org_scode"));
				strDept=Helper.correctNull(rs.getString("usr_rlpftype"));
				strHeadUsrDept=Helper.correctNull(rs.getString("usr_department"));
			}
			
			arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
			if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
				arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
			else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
				arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
			else
				arrValues.add("");

			arrValues.add(strOrgScode);
			if(str_sentorglevel.equalsIgnoreCase("C"))
				arrValues.add(strHeadUsrDept);
			else if(str_sentorglevel.equalsIgnoreCase("D"))
				arrValues.add(strDept);
			else
				arrValues.add("");
			
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);

			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
		}
		if(strAction.equalsIgnoreCase("approve") || strAction.equalsIgnoreCase("reject"))
		{
			intUpdateSize = intUpdateSize + 1;
			
			
			hshQuery.put("strQueryId","upd_appl_deviation");
			String SanctioningAuthority="",Sanction_Ref_Num="";
			if(strAction.equalsIgnoreCase("approve"))
			{
				strQuery = SQLParser.getSqlQuery("sel_corporate_breifbackground^"+ strAppno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					SanctioningAuthority=correctNull(rs.getString("com_sancauthority"));
					Sanction_Ref_Num=correctNull(rs.getString("com_sancrefno"));
					
					if(Sanction_Ref_Num.equalsIgnoreCase("") && (SanctioningAuthority.equalsIgnoreCase("14")|| SanctioningAuthority.equalsIgnoreCase("15")||SanctioningAuthority.equalsIgnoreCase("16")))
					{
						throw new Exception("$ Please Enter Sanction Reference Number in Basic information Tab ");
					}
				}
				
				
				String strUserID=Helper.correctNull((String)hshValues.get("strUserId"));
				String strAppUserID="";
				strQuery=SQLParser.getSqlQuery("sel_appl_deviation^"+strAppno);
				rs2=DBUtils.executeQuery(strQuery);
				if(rs2.next())
				{
					strAppUserID=Helper.correctNull((String)rs2.getString("dev_userid"));
				}
				if(strAppUserID.equals(strUserID))
				{
					strExcep=strExcep+"You cannot Sanction the Proposal you created";
					throw new Exception(strExcep);
				}
				
			}
			CommWorkflowBean com=new CommWorkflowBean();
			hshValues.put("strModule", "DEV");
			String strReferenceno=com.getSanctionRefernceNumber(hshValues);
			if(strAction.equalsIgnoreCase("approve"))
			{
				arrValues.add("pa");

			}
			else
			{
				arrValues.add("pr");
			}

				arrValues.add((String)hshValues.get("strUserId"));
				arrValues.add((String)hshValues.get("strOrgShortCode"));
				arrValues.add((String)hshValues.get("txt_sanctioncomments"));
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
								
				intUpdateSize = intUpdateSize + 1;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ins_dev_appmailbox");
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
				arrValues.add("");
				
				arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
				if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
					arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
				else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
					arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
				else
					arrValues.add("");
				
				arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
				if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
					arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
				else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
					arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
				else
					arrValues.add("");
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
				
				hshQueryValues.put("size",Integer.toString(intUpdateSize));
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		
		if(strAction.equalsIgnoreCase("undo"))
		{
			hshQuery.put("strQueryId","upd_appl_deviation_undo");
			arrValues.add(strAppno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			arrValues.add("y");
			arrValues.add(strAppno);
			hshQuery.put("strQueryId", "updreferencenum");
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);
			hshQueryValues.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			
			/* 
			 * Updating Undo Details
			 */
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			arrValues.add(strFromuserid);
			arrValues.add("Y");
			arrValues.add(strAppno);
			hshQuery.put("strQueryId","upd_undoappldeviationdet");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","upd_retailapplicantid");
			arrValues.add(strAppno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		}
        //--------------------------------------------End-------------------------------------------		
		HashMap hshResult = new HashMap();
		if(strAction.trim().equalsIgnoreCase("send"))
		{
			hshResult.put("status","success");
		}
		if(rs!=null)
		{
			rs.close();
		}
		if(StrLoanType.equalsIgnoreCase(""))
		{
		if(strAction.equalsIgnoreCase("approve")||strAction.equalsIgnoreCase("reject"))
		{
			String orghead="";
			String orglevel="";
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("getorgheadfromorgnisation^"+devorgscode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				orghead=Helper.correctNull(rs.getString("ORG_HEAD"));
				orglevel=Helper.correctNull(rs.getString("ORG_LEVEL"));
			}
			if(orglevel.equalsIgnoreCase("A"))
			{
			
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ins_dev_appmailboxnew");
				arrValues.add(strAppno);
				arrValues.add(applholder);
				arrValues.add(orghead);
				arrValues.add(strFromflowpoint);
				arrValues.add(strToflowpoint);
				arrValues.add("C");
				if(rs != null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("workflowusersanlimit^"+applholder);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					arrValues.add(Helper.correctNull(rs.getString("org_scode")));
					arrValues.add(Helper.correctNull(rs.getString("usr_department")));
				}
				if(rs != null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("workflowusersanlimit^"+orghead);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					arrValues.add(Helper.correctNull(rs.getString("org_scode")));
					arrValues.add(Helper.correctNull(rs.getString("usr_department")));
				}
				arrValues.add("Y");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","updholderdetails");
				arrValues.add(orghead);
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","2");
				hshQueryValues.put("2",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
			else
			{
				String newstrorgcode="";
				String neworghead="";
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("getperproposalorgscode^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					newstrorgcode=Helper.correctNull(rs.getString("PERM_PER_BRANCH"));
				}
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("getorgheadfromorgnisation^"+newstrorgcode);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					neworghead=Helper.correctNull(rs.getString("ORG_HEAD"));
				}
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ins_dev_appmailboxnew");
				arrValues.add(strAppno);
				arrValues.add(applholder);
				arrValues.add(neworghead);
				arrValues.add(strFromflowpoint);
				arrValues.add(strToflowpoint);
				arrValues.add("C");
				if(rs != null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("workflowusersanlimit^"+applholder);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					arrValues.add(Helper.correctNull(rs.getString("org_scode")));
					arrValues.add(Helper.correctNull(rs.getString("usr_departmentn")));
				}
				if(rs != null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("workflowusersanlimit^"+neworghead);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					arrValues.add(Helper.correctNull(rs.getString("org_scode")));
					arrValues.add(Helper.correctNull(rs.getString("usr_department")));
				}
				arrValues.add("Y");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","updholderdetails");
				arrValues.add(neworghead);
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","2");
				hshQueryValues.put("2",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		}


	return hshResult;
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
			if(rs1!= null)
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
public HashMap updatePayMaster(HashMap hshValues) {
	HashMap hshRecord = new HashMap();
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = new HashMap();
	ArrayList arrValues = new ArrayList();
	int maxsno =0;
	String strAction =null;
	ResultSet rs = null;
	String strSno="";
	String strCatagory="";
	String strAnnualInc="";
	String strFe_Ownership="";
	String strElig_Sub="";
	String strInt_Sub="";
	String strMax_Loan="";
	String strArea="";
	String strNRI_Borr="";
	String strSel_xtension="";
	String strFrom_Date="";
	String strTo_Date="";
	String strMax_Sub="";
	String strAadhar="";
	String strMainCat="";
	String strSelctType="";
	try{
		strAction = Helper.correctNull((String)hshValues.get("hidAction"));
		strCatagory= Helper.correctNull((String)hshValues.get("txt_cat"));
		strAnnualInc =Helper.correctNull((String)hshValues.get("txt_income"));//
		strFe_Ownership=correctNull((String) hshValues.get("sel_female"));
		strElig_Sub=correctNull((String) hshValues.get("txt_subsidy"));
		strInt_Sub=correctNull((String) hshValues.get("txt_subinterest"));
		strMax_Loan=correctNull((String) hshValues.get("txt_maxloan"));
		strArea=correctNull((String) hshValues.get("txt_area"));
		strNRI_Borr= Helper.correctNull((String)hshValues.get("sel_eligible"));
		strSel_xtension =Helper.correctNull((String)hshValues.get("sel_xtension"));//
		strFrom_Date=correctNull((String) hshValues.get("txt_fromdate"));
		strTo_Date=correctNull((String) hshValues.get("txt_todate"));
		strMax_Sub=correctNull((String) hshValues.get("txt_maxsub"));
		strAadhar=correctNull((String) hshValues.get("sel_Aadhar"));
		strMainCat=correctNull((String) hshValues.get("select_category"));
		strSelctType=correctNull((String) hshValues.get("sel_active"));
		
		if (strAction.equalsIgnoreCase("insert"))
		{				
			rs = DBUtils.executeLAPSQuery("selmaxpmay");
			if(rs.next()){
				maxsno = rs.getInt("snomax");
			}

			arrValues.add(strCatagory);
			arrValues.add(strAnnualInc);
			arrValues.add(strFe_Ownership);
			arrValues.add(strElig_Sub);
			arrValues.add(strInt_Sub);
			arrValues.add(strMax_Loan);
			arrValues.add(strArea);
			arrValues.add(strNRI_Borr);
			arrValues.add(strSel_xtension);
			arrValues.add(strFrom_Date);
			arrValues.add(strTo_Date);
			arrValues.add(strMax_Sub);
			arrValues.add(strAadhar);
			arrValues.add(String.valueOf(maxsno));
			arrValues.add(strMainCat);
			arrValues.add(strSelctType);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","insert_Pmay");
			hshQueryValues.put("size","1");					
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
		}

					
		if (strAction.equalsIgnoreCase("update")){
			
			strSno = Helper.correctNull((String)hshValues.get("hidsno"));
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strCatagory);
			arrValues.add(strAnnualInc);
			arrValues.add(strFe_Ownership);
			arrValues.add(strElig_Sub);
			arrValues.add(strInt_Sub);
			arrValues.add(strMax_Loan);
			arrValues.add(strArea);
			arrValues.add(strNRI_Borr);
			arrValues.add(strSel_xtension);
			arrValues.add(strFrom_Date);
			arrValues.add(strTo_Date);
			arrValues.add(strMax_Sub);
			arrValues.add(strAadhar);
		    arrValues.add(strMainCat);
			arrValues.add(strSelctType);
			arrValues.add(strSno);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","update_Pmay");
			hshQueryValues.put("size","1");					
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
		}
		
		if (strAction.equalsIgnoreCase("delete")){
			
			strSno = Helper.correctNull((String)hshValues.get("hidsno"));
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strSno);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","del_Pmay");
			hshQueryValues.put("size","1");					
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
		}

	}
	catch(Exception ce){
		log.error(ce.toString());
			throw new EJBException("Error in updatepayMaster "+ce.toString());
	}
	return hshValues;
	
}	
public HashMap getPayMasterData(HashMap hshValues) {
	String strQuery="";
	ResultSet rs=null;
	String sno="";
	String main="";

	try
	{	main=Helper.correctNull((String)hshValues.get("select_category"));
		sno=Helper.correctNull((String)hshValues.get("sel_pmay"));
		strQuery= SQLParser.getSqlQuery("selPmayData^"+main+"^"+sno);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			hshValues.put("PM_SUBCATEGORY",correctNull(rs.getString("PM_SUBCATEGORY")));
			hshValues.put("PM_SUBCATEGORYFAMILY_INCOME",correctNull(rs.getString("PM_SUBCATEGORYFAMILY_INCOME")));
			hshValues.put("PM_FEMALE_OWNERSHIP",correctNull(rs.getString("PM_FEMALE_OWNERSHIP")));
			hshValues.put("PM_LOAN_SUBSIDY",correctNull(rs.getString("PM_LOAN_SUBSIDY")));
			hshValues.put("PM_INTEREST_SUBSIDY",correctNull(rs.getString("PM_INTEREST_SUBSIDY")));
			hshValues.put("PM_MAXLOAN_TENOR",correctNull(rs.getString("PM_MAXLOAN_TENOR")));
			hshValues.put("PM_AREA",correctNull(rs.getString("PM_AREA")));
			hshValues.put("PM_NRI_BORROWER",correctNull(rs.getString("PM_NRI_BORROWER")));
			
			hshValues.put("PM_ELIGIBILITY_HOMEEXT",correctNull(rs.getString("PM_ELIGIBILITY_HOMEEXT")));
			hshValues.put("PM_FROM_DATE",correctNull(rs.getString("PM_FROM_DATE")));
			hshValues.put("PM_FINISH_DATE",correctNull(rs.getString("PM_FINISH_DATE")));
			hshValues.put("PM_MAX_SUBSIDY",correctNull(rs.getString("PM_MAX_SUBSIDY")));
			hshValues.put("PM_AADHAR_MANDATORY",correctNull(rs.getString("PM_AADHAR_MANDATORY")));
			hshValues.put("PM_SUBCATID",correctNull(rs.getString("PM_SUBCATID")));
			hshValues.put("PM_MAIN_CATEGORY",correctNull(rs.getString("PM_MAIN_CATEGORY")));
			hshValues.put("PM_ACTIVE_TYPE",correctNull(rs.getString("PM_ACTIVE_TYPE")));

			
		}
		
	}
	catch(Exception e)
	{
		throw new EJBException("Error in getPayMasterData===== "+e.getMessage());
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
	
	return hshValues;
}
public HashMap updateRecommendations (HashMap hshValues) 
{
	
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = new HashMap();
	ArrayList arrValues = new ArrayList();
	ResultSet rs = null;
	
	String strAction=correctNull((String) hshValues.get("hidAction"));
	String hidAppno=correctNull((String) hshValues.get("appno"));  

	try
	{
		if(strAction.equals("update"))
		{
			arrValues.add(hidAppno);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","del_recomments");
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
				
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			arrValues.add(hidAppno);
			arrValues.add(correctNull((String) hshValues.get("txt_comments1")));
			arrValues.add(correctNull((String) hshValues.get("txt_comments2")));
			arrValues.add(correctNull((String) hshValues.get("txt_comments3")));
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","ins_recomments");
			hshQueryValues.put("2",hshQuery);
			hshQueryValues.put("size","2");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		else if(strAction.equals("delete"))
		{
			arrValues.add(hidAppno);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","del_recomments");
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
				
	}
	catch(Exception e)
	{
		throw new EJBException("Error in updateRecommendation======= "+e.getMessage());
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
	return hshValues;
	
}

public HashMap getRecommendations (HashMap hshValues) 
{
	String strQuery="";
	String strQuery1="";
	ResultSet rs = null;
	ResultSet rs1 = null;
	String strAppno=correctNull((String) hshValues.get("appno"));  
	String strUserId=correctNull((String) hshValues.get("strUserId"));  
    String sessionModuleType =	correctNull((String)hshValues.get("sessionModuleType"));
    String applholder="";
	try
	{
		strQuery = SQLParser.getSqlQuery("sel_recomments^"+strAppno);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			hshValues.put("strComments1", correctNull(Helper.CLOBToString(rs.getClob("PERM_COMMENTS1"))));
			hshValues.put("strComments2", correctNull(Helper.CLOBToString(rs.getClob("PERM_COMMENTS2"))));
			hshValues.put("strComments3", correctNull(Helper.CLOBToString(rs.getClob("PERM_COMMENTS3"))));
		}
		if (rs != null) {
			rs.close();
		}
		strQuery = SQLParser.getSqlQuery("ins_perm_basic^"+strAppno);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			hshValues.put("CBS_STATIC_DATA_CODE", correctNull(rs.getString("CBS_STATIC_DATA_CODE")));
			hshValues.put("CBS_STATIC_DATA_PASSING_CODE", correctNull(rs.getString("CBS_STATIC_DATA_PASSING_CODE")));
			hshValues.put("CBS_STATIC_CGTMSE", correctNull(rs.getString("CBS_STATIC_CGTMSE")));
			hshValues.put("strBasicInfoFlag","Y");
		}
		if (rs != null) {
			rs.close();
		}
		if(sessionModuleType.equalsIgnoreCase("PERM"))	 
		 {
		strQuery = SQLParser.getSqlQuery("sel_appl_deviation^"+strAppno);
		rs = DBUtils.executeQuery(strQuery);	
		if(rs.next())
		{
			applholder=correctNull(rs.getString("dev_applholder"));
			
		}
		if(strUserId.equalsIgnoreCase(applholder))
		{
			int rightss=0;
	        int rightstouser=0;
			  strQuery1=SQLParser.getSqlQuery("checkRightsforeditper");
				rs1=DBUtils.executeQuery(strQuery1);
				if(rs1.next())
				{
					rightss=Integer.parseInt(Helper.correctNull((String)rs1.getString("STAT_DATA_DESC")));
				}
				if(rs1 != null)
				{
					rs1.close();
				}
				strQuery1=SQLParser.getSqlQuery("checkUserclassforLodgeRights^"+applholder);
				rs1=DBUtils.executeQuery(strQuery1);
				if(rs1.next())
				{
					rightstouser=Integer.parseInt(Helper.correctNull((String)rs1.getString("USR_CLASS")));
				}
				if(rightss<=rightstouser)
				{
					hshValues.put("rightstousercheck","Y");
				}
				else
				{
					hshValues.put("rightstousercheck","N");
				}
			
		}
		 }
	}
	catch (Exception ce) {
		throw new EJBException("Error in getRecommendations " + ce.toString());
	} finally {
		try {
			if (rs != null) {
				rs.close();
			}
			if(rs1 != null)
			{
				rs1.close();
			}
		} catch (Exception cf) {
			throw new EJBException("Error closing the connection "
					+ cf.getMessage());
		}
	}
	return hshValues;
	
}

public HashMap getPrintDetails (HashMap hshValues) 
{
	
	ResultSet rs=null;
	ResultSet rs1=null;
	String strAppno="";
	HashMap hshRecord = new HashMap();
	ArrayList arrCol=new ArrayList();
	ArrayList arrRow=new ArrayList();
	String strQuery = null,strAQ_SNO="",strStatus="",strStatus1="";
	int childCount=0;
	try
	{
		 strAppno=correctNull((String) hshValues.get("appno")); 
		 strQuery = SQLParser.getSqlQuery("sel_Queryprint^"+strAppno+"^0");
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				childCount=0;
				arrCol=new ArrayList();
				arrCol.add(correctNull(rs.getString("AQ_APPNO")));//0
				arrCol.add(correctNull(rs.getString("AQ_QUERY")));//1
				arrCol.add(correctNull(rs.getString("AQ_RAISEDBY")));//2
				arrCol.add(correctNull(rs.getString("created_user")));//3
				arrCol.add(correctNull(rs.getString("AQ_RAISEDON")));//4
				arrCol.add(correctNull(rs.getString("created_org")));//5
				
				if(correctNull(rs.getString("AQ_STATUS")).equalsIgnoreCase("QE"))
					strStatus="Query Entered";
				else if(correctNull(rs.getString("AQ_STATUS")).equalsIgnoreCase("QS"))
					strStatus="Query Sent";
				else if(correctNull(rs.getString("AQ_STATUS")).equalsIgnoreCase("QR"))
					strStatus="Query Replied";
				else if(correctNull(rs.getString("AQ_STATUS")).equalsIgnoreCase("QC"))
					strStatus="Query Closed";
				else if(correctNull(rs.getString("AQ_STATUS")).equalsIgnoreCase("QO"))
					strStatus="Query Re-Open";
				else
					strStatus="";
				
				arrCol.add(strStatus);
				arrCol.add(correctNull(rs.getString("AQ_REPLIEDBY")));//7
				arrCol.add(correctNull(rs.getString("replied_user")));//8
				arrCol.add(correctNull(rs.getString("AQ_REPLIEDON")));//9
				arrCol.add(correctNull(rs.getString("AQ_REPLY")));//10
				arrCol.add(correctNull(rs.getString("replied_org")));//11
				arrCol.add(correctNull(rs.getString("AQ_PARENTID")));//12
			
				strAQ_SNO=correctNull(rs.getString("AQ_SNO")); 
				strQuery = SQLParser.getSqlQuery("sel_Queryprint^"+strAppno+"^"+strAQ_SNO);
				rs1 = DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					childCount++;
				}
				arrCol.add(String.valueOf(childCount));//13
				arrRow.add(arrCol);
							
				strAQ_SNO=correctNull(rs.getString("AQ_SNO")); 
				strQuery = SQLParser.getSqlQuery("sel_Queryprint^"+strAppno+"^"+strAQ_SNO);
				rs1 = DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					arrCol=new ArrayList();
					arrCol.add(correctNull(rs1.getString("AQ_APPNO")));//0
					arrCol.add(correctNull(rs1.getString("AQ_QUERY")));//1
					arrCol.add(correctNull(rs1.getString("AQ_RAISEDBY")));//2
					arrCol.add(correctNull(rs1.getString("created_user")));//3
					arrCol.add(correctNull(rs1.getString("AQ_RAISEDON")));//4
					arrCol.add(correctNull(rs1.getString("created_org")));//5
					if(correctNull(rs.getString("AQ_STATUS")).equalsIgnoreCase("QE"))
						strStatus1="Query Entered";
					else if(correctNull(rs.getString("AQ_STATUS")).equalsIgnoreCase("QS"))
						strStatus1="Query Sent";
					else if(correctNull(rs.getString("AQ_STATUS")).equalsIgnoreCase("QR"))
						strStatus1="Query Replied";
					else if(correctNull(rs.getString("AQ_STATUS")).equalsIgnoreCase("QC"))
						strStatus1="Query Closed";
					else if(correctNull(rs.getString("AQ_STATUS")).equalsIgnoreCase("QO"))
						strStatus1="Query Re-Open";
					else
						strStatus1="";
					
					arrCol.add(strStatus1);
					arrCol.add(correctNull(rs1.getString("AQ_REPLIEDBY")));//7
					arrCol.add(correctNull(rs1.getString("replied_user")));//8
					arrCol.add(correctNull(rs1.getString("AQ_REPLIEDON")));//9
					arrCol.add(correctNull(rs1.getString("AQ_REPLY")));//10
					arrCol.add(correctNull(rs1.getString("replied_org")));//11
					arrCol.add(correctNull(rs1.getString("AQ_PARENTID")));//12
					arrCol.add("0");//12
					arrRow.add(arrCol);
				}
			}
			
			if(rs!=null)
			strQuery= SQLParser.getSqlQuery("sel_permannexureData^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
		
				if(!Helper.correctNull(rs.getString("PG_APPL_TITLE")).equalsIgnoreCase(""))
				{
					String title=Helper.correctNull(rs.getString("PG_APPL_TITLE"));
					hshValues.put("PG_APPLIANTNAME",title +"."+correctNull(rs.getString("PG_APPLIANTNAME")).toUpperCase());
			
				}else{
					hshValues.put("PG_APPLIANTNAME",correctNull(rs.getString("PG_APPLIANTNAME")).toUpperCase());
				}
			}
			hshValues.put("arrRow", arrRow);
		
	}catch(Exception e)
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
	
	return hshValues;
	
}



public HashMap getPermissionGistMoreDet (HashMap hshValues) 
{
	ResultSet rs=null,rs1=null;
	HashMap hshRecord = new HashMap();
	ArrayList arrCol=new ArrayList();
	ArrayList arrRow=new ArrayList();
	ArrayList arrCol1=new ArrayList();
	ArrayList arrRow1=new ArrayList();
	ArrayList arrCol2=new ArrayList();
	ArrayList arrRow2=new ArrayList();
	ArrayList arrCol3=new ArrayList();
	ArrayList arrRow3=new ArrayList();
	
	String strQuery = null;
	
	try
	{
		String strAppno=correctNull((String) hshValues.get("appno")); 
		
		String strdev_type="";
		strQuery= SQLParser.getSqlQuery("sel_appl_deviation^"+strAppno);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strdev_type=Helper.correctNull(rs.getString("DEV_SUBTYPE"));
			hshValues.put("DEV_CBSID", Helper.correctNull(rs.getString("DEV_CBSID")));		
		}	
		hshValues.put("strDEV_SUBTYPE", strdev_type);
		
		if(strdev_type.equalsIgnoreCase("3")||strdev_type.equalsIgnoreCase("4")||strdev_type.equalsIgnoreCase("6") ||strdev_type.equalsIgnoreCase("8"))
		{
		
			if(rs!=null)
			{
				rs.close();
			}
		
			 strQuery = SQLParser.getSqlQuery("sel_perm_moredet_extfac^"+strAppno);
			 rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(correctNull(rs.getString("PERM_EXIST_APPNO")));//0
					arrCol.add(correctNull(rs.getString("PERM_EXIST_FACSNO")));//1
					arrCol.add(correctNull(rs.getString("PERM_EXIST_FACNAME")));//2
					arrCol.add(correctNull(rs.getString("PERM_EXIST_MODTYPE")));//3
					arrCol.add(correctNull(rs.getString("PERM_EXIST_ACCNO")));//4
					arrCol.add(correctNull(rs.getString("PERM_EXIST_LIMIT")));//5
					arrCol.add(correctNull(rs.getString("PERM_EXIST_PURPOSE")));//6
					arrCol.add(correctNull(rs.getString("PERM_EXIST_SANCREFNO")));//7
					arrCol.add(correctNull(rs.getString("PERM_EXIST_SANCDATE")));//8
					arrCol.add(correctNull(rs.getString("PERM_EXIST_SANCROI")));//9
					arrCol.add(correctNull(rs.getString("PERM_EXIST_PRESENTROI")));//10
					arrCol.add(correctNull(rs.getString("PERM_EXIST_BALANCEOS")));//11
					arrCol.add(correctNull(rs.getString("PERM_EXIST_DUEDATE")));//12
					arrCol.add(correctNull(rs.getString("PERM_EXIST_ARREARSTATUS")));//13
					arrCol.add(correctNull(rs.getString("PERM_BORROWERID")));//14
					arrRow.add(arrCol);
				}
				hshValues.put("arrRow", arrRow);
		}else if(strdev_type.equalsIgnoreCase("5"))
		{	
		
			if(rs!=null)
			{
				rs.close();
			}
		
			 strQuery = SQLParser.getSqlQuery("sel_perm_moredet_extfac^"+strAppno);
			 rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(correctNull(rs.getString("PERM_EXIST_APPNO")));//0
					arrCol.add(correctNull(rs.getString("PERM_EXIST_FACSNO")));//1
					arrCol.add(correctNull(rs.getString("PERM_EXIST_MODTYPE")));//2
					arrCol.add(correctNull(rs.getString("PERM_EXIST_BORNAME")));//3
					arrCol.add(correctNull(rs.getString("PERM_EXIST_FACNAME")));//4
					arrCol.add(correctNull(rs.getString("PERM_EXIST_SANCDATE")));//5
					arrCol.add(correctNull(rs.getString("PERM_EXIST_LIMIT")));//6
					arrCol.add(correctNull(rs.getString("PERM_EXIST_BALANCEOS")));//7
					arrCol.add(correctNull(rs.getString("PERM_EXIST_PRESENTROI")));//8
					arrCol.add(correctNull(rs.getString("PERM_EXIST_DUEDATE")));//9
					arrCol.add(correctNull(rs.getString("PERM_EXIST_ARREARSTATUS")));//10
					arrCol.add(correctNull(rs.getString("PERM_BORROWERID")));//11
					arrRow.add(arrCol);
				}
				hshValues.put("arrRow1", arrRow);
			
		}
		if(rs!=null)
		{
			rs.close();
		}
		 strQuery = SQLParser.getSqlQuery("sel_perm_moredet_secdet^"+strAppno);
		 rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol1=new ArrayList();
				arrCol1.add(correctNull(rs.getString("PERM_EXISTSEC_PROPOSALNO")));//0
				arrCol1.add(correctNull(rs.getString("PERM_EXISTSEC_FACSNO")));//1
				arrCol1.add(correctNull(rs.getString("PERM_EXISTSEC_SECID")));//2
				arrCol1.add(correctNull(rs.getString("PERM_EXISTSEC_APPLNAME")));//3
				arrCol1.add(correctNull(rs.getString("PERM_EXISTSEC_SECDESCRIP")));//4
				arrCol1.add(correctNull(rs.getString("PERM_EXISTSEC_SECVALUE")));//5
				
				if(!correctNull(rs.getString("PERM_EXISTSEC_SECTYPE")).equalsIgnoreCase(""))
				{
					if(correctNull(rs.getString("PERM_EXISTSEC_SECTYPE")).equals("1"))
					{
						arrCol1.add("Primary");
					}
					else if(correctNull(rs.getString("PERM_EXISTSEC_SECTYPE")).equals("2"))
					{
						arrCol1.add("Collateral");
					}
					else
					{
						arrCol1.add(correctNull(rs.getString("PERM_EXISTSEC_SECTYPE")));
					}
				}
				else
				{
					arrCol1.add(correctNull(rs.getString("PERM_EXISTSEC_SECTYPE")));
				}
				
				
			//	arrCol1.add(correctNull(rs.getString("PERM_EXISTSEC_SECTYPE")));//6
				arrCol1.add(correctNull(rs.getString("PERM_EXISTSEC_MARGIN")));//7
				arrRow1.add(arrCol1);
			}
			hshValues.put("arrRow_sec", arrRow1);	
			
			if(rs!=null)
			{
				rs.close();
			}
			 strQuery = SQLParser.getSqlQuery("sel_perm_moredet_othbank^"+strAppno);
			 rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol2=new ArrayList();
					arrCol2.add(correctNull(rs.getString("PERM_EXST_BANKNAME")));//0
					
					arrCol2.add(correctNull(rs.getString("PERM_EXST_FACILITY")));//1
					arrCol2.add(correctNull(rs.getString("PERM_EXST_LIMIT")));//2
					arrCol2.add(correctNull(rs.getString("PERM_EXST_DUEDATE")));//3
					arrCol2.add(correctNull(rs.getString("PERM_EXST_ARREARS")));//4
					
					
					if(!correctNull(rs.getString("PERM_EXST_BANKNAME")).equals(""))
					{
						if(rs1!=null)
						{
							rs1.close();
						}
						rs1 = DBUtils.executeLAPSQuery("getstaticdescription^"+"147"+"^"+correctNull(rs.getString("PERM_EXST_BANKNAME")));
						if(rs1.next())
						{
							arrCol2.add(Helper.correctNull(rs1.getString("STAT_DATA_DESC1")));
						}
						else
						{
							arrCol2.add(correctNull(rs.getString("PERM_EXST_BANKNAME")));
						}
					}	
					else
					{
						arrCol2.add(correctNull(rs.getString("PERM_EXST_BANKNAME")));
					}
					arrCol2.add(correctNull(rs.getString("PERM_EXST_FLAG")));
					
					
					
					
					
					arrRow2.add(arrCol2);
				}
				hshValues.put("arrRow_bank", arrRow2);	
				
				if(rs!=null)
				{
					rs.close();
				}
				 strQuery = SQLParser.getSqlQuery("sel_perm_moredet_depacc^"+strAppno);
				 rs = DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						arrCol3=new ArrayList();
						arrCol3.add(correctNull(rs.getString("PERM_EXISTDEP_NAME")));//0
						arrCol3.add(correctNull(rs.getString("PERM_EXISTDEP_ACCNO")));//1
						arrCol3.add(correctNull(rs.getString("PERM_EXISTDEP_DEPOSITAMT")));//2
						arrCol3.add(correctNull(rs.getString("PERM_EXISTDEP_PRESENTBAL")));//3
						arrCol3.add(correctNull(rs.getString("PERM_EXISTDEP_MATURITYDATE")));//4
						arrCol3.add(correctNull(rs.getString("PERM_EXISTDEP_ROI")));//5
						arrRow3.add(arrCol3);
					}
					hshValues.put("arrRow_depacc", arrRow3);	
				
		
	}catch(Exception e)
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
	return hshValues;
}
	public HashMap getpermQueryDetails(HashMap hshRequestValues) 
	{		
		ResultSet rs = null;
		String strQuery="",areacheckval="",catval="",desc="",bownameval="",subj="",absPosition="";
		String area2="",area3="",area4="",area5="",glptotlevel="",pagetype="",ddesc="";
		String strCusCBSStatus="",str_statuscust="",strApplicantId="",strCBSID="";
		try
		{
			String hidcategoryType=Helper.correctNull((String)hshRequestValues.get("hidCategoryType"));
			String strOrgCode=Helper.correctNull((String)hshRequestValues.get("strOrgCode"));
			String strOrgLevel=Helper.correctNull((String)hshRequestValues.get("strOrgLevel"));
			strQuery = SQLParser.getSqlQuery("glpoption");
			rs =DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				glptotlevel = (String)Helper.correctNull(rs.getString(1));						
			}
			pagetype= correctNull((String)hshRequestValues.get("link"));
			absPosition=correctNull((String)hshRequestValues.get("hid_rowcount"));
			area2 = correctNull((String)hshRequestValues.get("area2"));
			area3 = correctNull((String)hshRequestValues.get("area3"));
			area4 = correctNull((String)hshRequestValues.get("area4"));
			area5 = correctNull((String)hshRequestValues.get("area5"));
			
			if(area4.equals("undefined"))
				area4="";
			
			if(!area5.equals(""))
			{
				areacheckval=area5;
			}
			else if(!area4.equals(""))
			{
				if(glptotlevel.equals("4"))
				{
					areacheckval=area4;
					areacheckval=areacheckval.substring(0, 12);
				}
				else if(glptotlevel.equals("5"))
				{
					areacheckval=area4;
				}
			}
			else if(!area3.equals(""))
			{
				areacheckval=area3;
				areacheckval=areacheckval.substring(0, 9);
			}
			else if(!area2.equals(""))
			{
				areacheckval=area2;
				areacheckval=areacheckval.substring(0, 6);
			}
			else
			{
				areacheckval="";			
			}
			
			if(areacheckval.equalsIgnoreCase(""))
			{
				if(strOrgLevel.equalsIgnoreCase("C"))
				{
					areacheckval="001";
				}
				else if(strOrgLevel.equalsIgnoreCase("R"))
				{
					areacheckval=strOrgCode.substring(0, 6);
				}
				else if(strOrgLevel.equalsIgnoreCase("D"))
				{
					areacheckval=strOrgCode.substring(0, 9);
				}

			}
			
			if(rs != null)
				rs.close();
			
			String strqueryType=Helper.correctNull((String)hshRequestValues.get("hidqueryType"));

			if(strqueryType.equals("REQ"))
			{
				if(correctNull((String)hshRequestValues.get("strOrgLevel")).equals("A"))
				{
					desc=" ";
				}
				else
				{
					//desc="and q.AQ_SENTORGCODE like '"+areacheckval+"%%%'";
					desc=" ";
				}
				
				if(hidcategoryType.equals("PERM"))
				{
					strQuery = SQLParser.getSqlQuery("sel_queryReceived_result^"+strOrgCode+"^"+desc);
				}
				else if(hidcategoryType.equals("RET"))
				{
					//strQuery = SQLParser.getSqlQuery("sel_queryReceived_result_ret^"+strOrgCode+"^"+desc);
					strQuery = SQLParser.getSqlQuery("sel_queryReceived_result_ret_RET^"+strOrgCode+"^"+desc);
				}
				else if(hidcategoryType.equals("LAD"))
				{
					strQuery = SQLParser.getSqlQuery("sel_queryReceived_result_ret_LAD^"+strOrgCode+"^"+desc);
				}
				else if(hidcategoryType.equals("CORP"))
				{
					strQuery = SQLParser.getSqlQuery("sel_queryReceived_result_corpagri^C^"+strOrgCode+"^"+desc);
				}
				else if(hidcategoryType.equals("AGR"))
				{
					strQuery = SQLParser.getSqlQuery("sel_queryReceived_result_corpagri^A^"+strOrgCode+"^"+desc);
				}
			}
			else
			{
				if(correctNull((String)hshRequestValues.get("strOrgLevel")).equals("A"))
				{
					desc=" ";
				}
				else
				{
					//desc="and q.AQ_ORGCODE like '"+areacheckval+"%%%%'";
					desc=" ";
				}
				
				if(hidcategoryType.equals("PERM"))
				{
					strQuery = SQLParser.getSqlQuery("sel_querySent_result^"+strOrgCode+"^"+desc);
				}
				else if(hidcategoryType.equals("RET"))
				{
					strQuery = SQLParser.getSqlQuery("sel_querySent_result_ret1^"+strOrgCode+"^"+desc);
				}
				else if(hidcategoryType.equals("CORP"))
				{
					strQuery = SQLParser.getSqlQuery("sel_querySent_result_corpagri^C^"+strOrgCode+"^"+desc);
				}
				else if(hidcategoryType.equals("AGR"))
				{
					strQuery = SQLParser.getSqlQuery("sel_querySent_result_corpagri^A^"+strOrgCode+"^"+desc);
				}
				else if(hidcategoryType.equals("LAD"))
				{
					strQuery = SQLParser.getSqlQuery("sel_querySent_result_LAD^"+strOrgCode+"^"+desc);
				}
			}
			rs =DBUtils.executeQuery(strQuery);
		
		
			String tempstr="";
			ArrayList vecval =  new ArrayList();
			ArrayList vecdata =  new ArrayList();
			while(rs.next())
			{
				vecval =  new ArrayList();
				vecval.add(rs.getString("AQ_APPNO"));//1		
				vecval.add(rs.getString("PERAPP_FNAME"));//2
				vecval.add(rs.getString("AQ_RAISEDBY"));//3 
				vecval.add(rs.getString("AQ_CREATEDON"));//4		
				vecval.add(rs.getString("Moduletype"));//5		
				vecval.add(rs.getString("AQ_SNO"));//5	
				vecdata.add(vecval);
			}
			hshRequestValues.put("vecval",vecdata);		
			hshRequestValues.put("strqueryType",strqueryType);		
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getpermQueryDetails  "+ce.toString());
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
		return hshRequestValues;
	}
	public void updatePermissionGistMoreDet(HashMap hshValues) 
	{

    	HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();;
		ArrayList arrValues=new ArrayList();
		String strAction="",strQuery="",StrAppno="";
		String strdev_type="";
		int maxid=0;
		int maxnmbr=0;
		ResultSet rs=null;
		try
		{	
			String[] strpresentROI=null,strArrear=null,strExist_appno=null,strFac_no=null,strexst_duedate=null;
		strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		StrAppno=correctNull((String)hshValues.get("appno"));
		strQuery= SQLParser.getSqlQuery("sel_appl_deviation^"+StrAppno);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strdev_type=Helper.correctNull(rs.getString("DEV_SUBTYPE"));
		}
		if(strAction.equals("update"))
		{
			int intquery=0; 
			hshQueryValues = new HashMap();
    		hshQuery = new HashMap();;
    		arrValues=new ArrayList();    	
    		if(strdev_type.equalsIgnoreCase("3")||strdev_type.equalsIgnoreCase("4")||strdev_type.equalsIgnoreCase("6") ||strdev_type.equalsIgnoreCase("8"))
    		{
    			if(hshValues.get("txt_extfac_presroifac") instanceof String[])
				{
    			strpresentROI=(String[])hshValues.get("txt_extfac_presroifac"); 
    			strArrear=(String[])hshValues.get("txt_extfac_arrear");
    			strExist_appno=(String[])hshValues.get("txt_Proposalnumber");
    			strFac_no=(String[])hshValues.get("txt_facsno");
    			strexst_duedate=(String[])hshValues.get("txt_extfac_duedate");
				for(int i=0;i<strpresentROI.length;i++)
				{
					++intquery;
					hshQuery=new HashMap();
					arrValues = new ArrayList();
					arrValues.add(strpresentROI[i]);
					arrValues.add(strArrear[i]);
					arrValues.add(strexst_duedate[i]);
					arrValues.add(StrAppno);
					arrValues.add(strExist_appno[i]);
					arrValues.add(strFac_no[i]);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","upd_fac_adddata");
					hshQueryValues.put("size",String.valueOf(intquery));					
					hshQueryValues.put(String.valueOf(intquery),hshQuery);
				}
				}
    			else
    			{
    				if(!Helper.correctNull((String)hshValues.get("txt_Proposalnumber")).equalsIgnoreCase(""))
    				{
	    				++intquery;
						hshQuery=new HashMap();
						arrValues = new ArrayList();
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_extfac_presroifac")));
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_extfac_arrear")));
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_extfac_duedate")));
						arrValues.add(StrAppno);
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_Proposalnumber")));
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_facsno")));
						hshQuery.put("arrValues",arrValues);
						hshQuery.put("strQueryId","upd_fac_adddata");
						hshQueryValues.put("size",String.valueOf(intquery));					
						hshQueryValues.put(String.valueOf(intquery),hshQuery);
    				}
    			}
    		   		
		}
    		else if(strdev_type.equalsIgnoreCase("5")){
    			
    			if(hshValues.get("txt_exstfac_interest") instanceof String[])
				{
    			strpresentROI=(String[])hshValues.get("txt_exstfac_interest"); 
    			strArrear=(String[])hshValues.get("txt_exstfac_arrears");
    			strExist_appno=(String[])hshValues.get("txt_exst_Proposalnumber");
    			strFac_no=(String[])hshValues.get("txt_exst_facsno");
    			strexst_duedate=(String[])hshValues.get("txt_exstfac_duedate");
    			for(int i=0;i<strpresentROI.length;i++)
				{
					++intquery;
					hshQuery=new HashMap();
					arrValues = new ArrayList();
					arrValues.add(strpresentROI[i]);
					arrValues.add(strArrear[i]);
					arrValues.add(strexst_duedate[i]);
					arrValues.add(StrAppno);
					arrValues.add(strExist_appno[i]);
					arrValues.add(strFac_no[i]);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","upd_fac_adddata");
					hshQueryValues.put("size",String.valueOf(intquery));					
					hshQueryValues.put(String.valueOf(intquery),hshQuery);
				}
				}
    			else
    			{
    				if(!Helper.correctNull((String)hshValues.get("txt_exst_Proposalnumber")).equalsIgnoreCase(""))
    				{
	    				++intquery;
						hshQuery=new HashMap();
						arrValues = new ArrayList();
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_exstfac_interest")));
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_exstfac_arrears")));
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_exstfac_duedate")));
						arrValues.add(StrAppno);
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_exst_Proposalnumber")));
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_exst_facsno")));
						hshQuery.put("arrValues",arrValues);
						hshQuery.put("strQueryId","upd_fac_adddata");
						hshQueryValues.put("size",String.valueOf(intquery));					
						hshQueryValues.put(String.valueOf(intquery),hshQuery);
    				}
    			}
    		   		
    		}
    		
    		if(hshValues.get("txt_other_bankname") instanceof String[])
			{
				String strother_val[]=(String[])hshValues.get("txt_other_val1");
				String strother_bankname[]=(String[])hshValues.get("hid_other_bankcode");
				String strother_facility[]=(String[])hshValues.get("txt_other_facility");
				String strother_limit[]=(String[])hshValues.get("txt_other_limit");
				String strother_duedate[]=(String[])hshValues.get("txt_other_duedate");
				String strother_arrear[]=(String[])hshValues.get("txt_other_arrear");
				
				++intquery;
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				arrValues.add(StrAppno);
				arrValues.add("N");
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_perm_exstotherbank_new");
				hshQueryValues.put(String.valueOf(intquery),hshQuery);
				hshQueryValues.put("size",String.valueOf(intquery));	
				
				for(int i=0;i<strother_bankname.length;i++)
				{
					if(strother_val[i].equals("N")) 
					{
						++intquery;
						hshQuery = new HashMap();		
						arrValues=new ArrayList();
						arrValues.add(StrAppno);
						arrValues.add(strother_bankname[i]);
						arrValues.add(strother_facility[i]);
						arrValues.add(strother_limit[i]);
						arrValues.add(strother_duedate[i]);
						arrValues.add(strother_arrear[i]);
						arrValues.add(strother_val[i]);
						hshQuery.put("arrValues",arrValues);
						hshQuery.put("strQueryId","ins_perm_exstotherbank");
						hshQueryValues.put(String.valueOf(intquery),hshQuery);
						hshQueryValues.put("size",String.valueOf(intquery));					
					}
				}
			}
    		
    		if(intquery>0)
    		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

		}	//action

		}//try
		catch(Exception ce)
		{
			throw new EJBException("Exception caught in updateAssessmentMaster====="+ce.toString());
		}
		finally{
			hshQueryValues=null;
			arrValues=null;
			hshQuery=null;
		}
	}

}
	
