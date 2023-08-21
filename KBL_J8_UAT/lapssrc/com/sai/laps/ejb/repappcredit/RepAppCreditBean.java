/******************************************************************************
 * Package:			com.sai.laps.ejb.repappcredit
 * File:			RepAppCreditBean.java
 * Description:		Bean Implementation Class for Credit Activity Report
 * @author			R.Saraswathi 
 ******************************************************************************/

package com.sai.laps.ejb.repappcredit;


import java.sql.ResultSet;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "RepAppCreditBean", mappedName = "RepAppCreditHome")
@Remote (RepAppCreditRemote.class)
public class RepAppCreditBean extends BeanAdapter
{
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(RepAppCreditBean.class);
	private static final long serialVersionUID = 1L;
	NumberFormat nf=NumberFormat.getInstance();

	public HashMap getData(HashMap hshValues) 
	{
		HashMap hshRecord = new HashMap();
		String strMethod ="";
	
		try
		{
			strMethod=(String)hshValues.get("hidMethod");

			if (strMethod.equalsIgnoreCase("getRepDetails"))
			{
				hshRecord =(HashMap)getRepDetails(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("showProfile"))
			{
				hshRecord =(HashMap)showProfile(hshValues);
			} 
			else if (strMethod.equalsIgnoreCase("getParamList"))
			{
				hshRecord =(HashMap)getParamList(hshValues);
			} 
			else if (strMethod.equalsIgnoreCase("getProductRepDetails"))
			{
				hshRecord =(HashMap)getProductRepDetails(hshValues);
			} 
			
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getdata "+ce.toString());
		}
		
		return hshRecord;

	}

	private HashMap getRepDetails(HashMap hshRequestValues) 
	{
		
		ResultSet rs = null;
		ResultSet rs1 = null;
		ArrayList vecRecords=null;
		HashMap hshVal=new HashMap();
		HashMap hshRec=new HashMap();
		ArrayList vecVal =new ArrayList();
		String strQuery=null;
		String strOrgCode = null;
		String strid=null;
		String strTemp=null;
		String strToDate=null;
		String strDate=null;
		String strFromDate=null;
		String strLoanType = null;
		String strPrdType = null;
		double grandtot=0.00;
		double subtot=0.00;
		String strQ=" ";
		String strSaveDate=null;
		String strGen=null;
		String strOrg = null;
			
		try
		{
			
			
			strSaveDate =(String)hshRequestValues.get("txtSaveDate");
			strGen =(String)hshRequestValues.get("strUserId");
			
			strOrgCode =(String)hshRequestValues.get("hidOrgCode");
			strid =(String)hshRequestValues.get("hidCatFields");
			strPrdType =(String)hshRequestValues.get("hidPrdCode");
			strLoanType =(String)hshRequestValues.get("hidLoanType");
			strDate =(String)hshRequestValues.get("txtDate");
			rs=DBUtils.executeLAPSQuery("selusername^"+strGen);
			while (rs.next())
			{
				strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2));
			}
			if(!strDate.equals("All"))
			{
				strFromDate = strDate.substring(0,strDate.indexOf("-"));
				strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				strQ = SQLParser.getSqlQuery("seldatewise^"+strFromDate+"^"+strToDate);
			}
					hshVal = new HashMap();
					subtot=0.00;
					
					strQuery="";
					if (strLoanType.equalsIgnoreCase("P"))
					{
					strQuery =SQLParser.getSqlQuery("selcreditactivitydata^"+strPrdType+"^"+strOrgCode+"^"+strLoanType+"^"+strid);
					
					}
					else
					{
						strQuery =SQLParser.getSqlQuery("selcomcreditdata^"+strPrdType+"^"+strOrgCode+"^"+strLoanType+"^"+strid);	
					}
					if(!strDate.equals("All"))
					{
						strQuery = strQuery + strQ ;
					}
					String tmp ="";

					String  cate = "";
					String parcate = "";
					if(rs != null)
						rs.close();
					
					rs=DBUtils.executeQuery(strQuery);
					while (rs.next())
					{
						vecRecords = new ArrayList();
						for(int i=1;i<13;i++)
						{
							strTemp =correctNull(rs.getString(i));
							 //this code has been included for retail credit activity report 
							 //due to certain valuye showing the value in lac to avoid that we included this.
							 if (strLoanType.equalsIgnoreCase("P") && i==5)
							 {
							 	if(Double.parseDouble(strTemp)<100)
							 	{
							 		strTemp =  Helper.formatDoubleValue(Double.parseDouble(strTemp) * 100000);
							 	}
							 }
							 vecRecords.add(strTemp);
							 tmp = correctNull(rs.getString(12));
							 	
							
							if(!tmp.equals(""))
							{
								if(rs1 != null)
									rs1.close();
								
								rs1=DBUtils.executeLAPSQuery("selparentcat^"+tmp);
								if(rs1.next())
								{
									parcate = correctNull(rs1.getString(1));
								}
							}
						}
						strOrg= rs.getString(9);
						cate = correctNull(rs.getString(11));
						if (strLoanType.equalsIgnoreCase("P"))
						{
							subtot=subtot+rs.getDouble(8);
							grandtot=grandtot+rs.getDouble(8);
						}
						else
						{
							subtot=subtot+rs.getDouble(5);
							grandtot=grandtot+rs.getDouble(5);
						}

						
						vecVal.add(vecRecords);	
					}
					hshVal.put("subtot",String.valueOf(subtot));

					 hshRec.put("cate",cate);
					 hshRec.put("parcate",parcate);
					 
					vecVal.add(hshVal);
			hshRec.put("vecValues",vecVal);
			
			hshRec.put("grandtot",String.valueOf(grandtot));
			
			hshRec.put("txtDate",strDate);
			
			hshRec.put("genby",strGen);
			
			if(strOrg!=null)
			{
			hshRec.put("OrgName",strOrg);
			}
			else
			{
			hshRec.put("OrgName","");
			}
			
			hshRec.put("txtSaveDate",strSaveDate);
			
		}
		catch(Exception e)
		{
			log.error("error in getData method.."+e.toString());
			throw new EJBException("inside getdata"+e.toString());
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
				throw new EJBException("close"+e.toString()); 
			}
		}
		return hshRec;
	}

	
	private HashMap showProfile(HashMap hshPar) 
	{
		
		ResultSet rs = null;
		String strQuery = null;
		HashMap hshRecord = new HashMap();
		HashMap hshTemp = new HashMap();
		ArrayList vecLabel = new ArrayList();
		ArrayList vecValue = new ArrayList();
		String strParam = null;
		String strPeriod=null;
		String strOrgLevel = null;
		String hidOrgCode = null;
		String hidOpFields = null;
		String hidSelFields = null;
		String hidCatFields = null;
		String hidLoanType = null;
		String strProfileName = null;
		String strPrdType =null;

		try
		{
				
			hshTemp=(HashMap)EJBInvoker.executeStateLess("repData",hshPar,"getParameter");
			strParam = (String)hshTemp.get("param");
			strProfileName =(String)hshTemp.get("profilename");
		
			StringTokenizer st = new StringTokenizer(strParam,";");
			
			strOrgLevel = st.nextToken();
			hidOrgCode = st.nextToken();
			hidCatFields = st.nextToken();
			strPeriod = st.nextToken();
			hidLoanType =st.nextToken();
			strPrdType =st.nextToken();
			hidOpFields =st.nextToken();
	 		hidSelFields = st.nextToken();
			
			vecLabel.add("Profile Name");
			vecLabel.add("Organisation Level");
			vecLabel.add("Organisation Names");
			vecLabel.add("Product Names");
			vecLabel.add("Peroid");
			vecLabel.add("Output Fields");

			vecValue.add(strProfileName);						
			vecValue.add(strOrgLevel);
			
			rs=DBUtils.executeLAPSQuery("repbanknames^"+hidOrgCode);
			hidOrgCode="";
			while(rs.next())
			{
				hidOrgCode += correctNull(rs.getString("org_name"))+",";		
			}
			hidOrgCode = hidOrgCode.substring(0,hidOrgCode.length()-1);
			vecValue.add(hidOrgCode);
			strQuery = SQLParser.getSqlQuery("selallproddet^"+strPrdType+"^"+hidCatFields);
			
			rs=DBUtils.executeQuery(strQuery);
			hidCatFields="";
			while(rs.next())
			{
				hidCatFields += correctNull(rs.getString("prd_desc"))+",";		
			}
			hidCatFields = hidCatFields.substring(0,hidCatFields.length()-1);
			vecValue.add(hidCatFields);
			vecValue.add(strPeriod);
			vecValue.add(hidSelFields);

			
			hshRecord.put("vecLabel",vecLabel);
			hshRecord.put("vecValue",vecValue);
			
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in help "+ce.toString());
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

	private HashMap getParamList(HashMap hshPar) 
	{
		HashMap hshRecord = new HashMap();
		HashMap hshTemp = new HashMap();
		String strParam = null;
		String strOrgCode= null;
		String hidCatFields = null;
		String strPeriod=null;
		String strOrgLevel =null;
		String strLoanType=null;
		String strPrdType=null;
		String strSaveDate =null;
		String strGen =null;

		try
		{
						
			hshTemp=(HashMap)EJBInvoker.executeStateLess("repData",hshPar,"getParameter");
			strGen =(String)hshTemp.get("genby");
			strSaveDate =(String)hshTemp.get("txtDate");
			strParam =(String)hshTemp.get("param");
			StringTokenizer st = new StringTokenizer(strParam,";");
			
			strOrgLevel = st.nextToken();
			strOrgCode =  st.nextToken();
			hidCatFields =st.nextToken();
			strPeriod =  st.nextToken();
			strLoanType =st.nextToken();
			strPrdType =st.nextToken();

			hshRecord.put("hidOrgCode",strOrgCode);
			hshRecord.put("hidCatFields",hidCatFields);
			hshRecord.put("txtDate",strPeriod);
			hshRecord.put("hidLoanType",strLoanType);
			hshRecord.put("hidPrdCode",strPrdType);
			hshRecord.put("txtSaveDate",strSaveDate);
			hshRecord.put("strUserId",strGen);


			hshPar = new HashMap();
			hshPar =(HashMap)getRepDetails(hshRecord);
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in help "+ce.toString());
		}
		
		return hshPar;
	}

	
	private HashMap getProductRepDetails(HashMap hshRequestValues) 
	{
		
		ResultSet rs = null;
		ResultSet rs1 = null;
		ArrayList vecRecords=null;
		HashMap hshRec=new HashMap();
		ArrayList vecVal =new ArrayList();
		String strQuery=null;
		String strOrgCode = null;
		String strid=null;
		String strToDate=null;
		String strDate=null;
		String strFromDate=null;
		String strLoanType = null;
		String strPrdType = null;
		double grandtot=0.00;
		double subtot=0.00;
		double dblTemp=0.00;
		String strQ=" ";
		String strSaveDate=null;
		String strGen=null;
		String strOrg = null;
		String strTemp=null;	
		String strOrgName = null;
		String strprodcat = null,strprd=null;
		
		String strOrglevel=null;
		StringBuffer strbufOrgcode=new StringBuffer();
		try
		{
			
			
			strSaveDate =(String)hshRequestValues.get("txtSaveDate");
			strGen =(String)hshRequestValues.get("strUserId");
			
			strOrgCode =(String)hshRequestValues.get("hidOrgCode");
			strid =(String)hshRequestValues.get("hidCatFields");
			strPrdType =(String)hshRequestValues.get("hidPrdCode");
			strLoanType =(String)hshRequestValues.get("hidLoanType");
			strDate =(String)hshRequestValues.get("txtDate");
			strOrgName =(String)hshRequestValues.get("hidOrgName");
			strprodcat =(String)hshRequestValues.get("hidprodcat_text");
			strprd =(String)hshRequestValues.get("hidprd");
			strOrglevel=correctNull((String)hshRequestValues.get("orglevel"));
			
			rs=DBUtils.executeLAPSQuery("selusername^"+strGen);
			while (rs.next())
			{
				strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2));
			}
			if(!strDate.equals("All"))
			{
				strFromDate = strDate.substring(0,strDate.indexOf("-"));
				strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				strQ = SQLParser.getSqlQuery("seldatewise^"+strFromDate+"^"+strToDate);
			}
			
			if(strOrglevel.equalsIgnoreCase("C"))
			{
				strbufOrgcode.append("org_code like '001%'");
			}
			else if(strOrglevel.equalsIgnoreCase("R")||strOrglevel.equalsIgnoreCase("CPC"))
			{
				strbufOrgcode.append("org_code like '").append(strOrgCode.substring(0,6)).append("%'");
			}
			else if(strOrglevel.equalsIgnoreCase("D"))
			{
				strbufOrgcode.append("org_code like '").append(strOrgCode.substring(0,9)).append("%'");
			}
			else if(strOrglevel.equalsIgnoreCase("A"))
			{
				strbufOrgcode.append("org_code like '").append(strOrgCode.substring(0,12)).append("%'");
			}
			else if(strOrglevel.equalsIgnoreCase("B"))
			{
				strbufOrgcode.append("org_code = '").append(strOrgCode).append("'");
			}
			
			
					subtot=0.00;
					
					strQuery="";
					if(strOrglevel.equalsIgnoreCase("CPC"))
						strQuery =SQLParser.getSqlQuery("selperrepProductwise_cpc^"+strLoanType.toUpperCase()+"^"+strbufOrgcode+"^"+strPrdType+"^"+strid);	
					else
					strQuery =SQLParser.getSqlQuery("selperrepProductwise^"+strLoanType.toUpperCase()+"^"+strbufOrgcode+"^"+strPrdType+"^"+strid);
					
					if(!strDate.equals("All"))
					{
						StringTokenizer st=new StringTokenizer(strQ,"#");
						if(st.hasMoreElements()){
							st.nextElement();
							strQ=(String)st.nextElement();
						}
						strQuery = strQuery + strQ ;
					}
					String tmp ="";

					if(rs != null)
						rs.close();
					
					rs=DBUtils.executeQuery(strQuery);
					while (rs.next())
					{
						vecRecords = new ArrayList();
						
						vecRecords.add(correctNull((String)rs.getString("app_no")));
						vecRecords.add(correctNull((String)rs.getString("appname")));
						if(!correctNull((String)rs.getString("processddate")).equalsIgnoreCase(""))
						vecRecords.add(correctNull((String)rs.getString("processddate")));
						else
							vecRecords.add("&nbsp;");
						dblTemp = Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_appamt")));
						dblTemp=dblTemp/100000;
						/*if(Double.parseDouble(strTemp)<100)
					 	{
					 		strTemp =  Helper.formatDoubleValue(Double.parseDouble(strTemp) * 100000);
					 	}*/
						vecRecords.add(String.valueOf(dblTemp));
						dblTemp = Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_recmdamt")));
						dblTemp=dblTemp/100000;
						vecRecords.add(String.valueOf(dblTemp));
						vecRecords.add(correctNull((String)rs.getString("prd_desc")));
						vecRecords.add(correctNull((String)rs.getString("app_renew_flag")));
						subtot=subtot + Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_recmdamt")));
						vecVal.add(vecRecords);	
					}
					subtot=subtot/100000;
					hshRec.put("vecValues",vecVal);
					hshRec.put("subtot",String.valueOf(subtot));
					hshRec.put("txtDate",strDate);
					hshRec.put("genby",strGen);
					hshRec.put("OrgName",strOrgName);
					hshRec.put("prodcat",strprodcat);
					hshRec.put("txtSaveDate",strSaveDate);
					hshRec.put("LoanType",strLoanType);
					hshRec.put("prd",strprd);
			
		}
		catch(Exception e)
		{
			log.error("error in getData method.."+e.toString());
			throw new EJBException("inside getdata"+e.toString());
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
				throw new EJBException("close"+e.toString()); 
			}
		}
		return hshRec;
	}
	public HashMap getCashFlowBudget(HashMap hshRequestValues) 
	{
		ResultSet rs=null,rs1=null,rs2=null;
		String strAppno="",YearlyType="",WhichYear="",particularYear="",finYear="";
		ArrayList ArrColumn=new ArrayList();
		ArrayList ArrRow=new ArrayList();
		ArrayList ArrDefRow=new ArrayList();
		int RowNo=21;
		int ColNo=0;
		HashMap hshValues=new HashMap();
		double a=0;
		nf=NumberFormat.getInstance();
		nf.setGroupingUsed(false);
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		String strQuery="";
		int count=12;
		String[] Sno=null;
		String[] rowVal1=null;
		String[] rowVal2=null;
		String[] rowVal3=null;
		String[] rowVal4=null;
		String[] rowVal5=null;
		String[] rowVal6=null;
		String[] rowVal7=null;
		String[] rowVal8=null;
		
		String[] rowVal9=null;
		String[] rowVal10=null;
		
		String[] rowVal11=null;
		String[] rowVal12=null;
		String[] rowVal13=null;
		String[] rowVal14=null;
		String[] rowVal15=null;
		String[] rowVal16=null;
		String[] rowVal17=null;
		String[] rowVal18=null;
		String[] rowVal19=null;
		String[] rowVal20=null;
		String[] rowVal21=null;
		String[] rowVal22=null;
		String[] particulars=null;
		boolean DisableYear=false;
		boolean ReadOnlyLastYearFields=false;
		try
		{
			strAppno=correctNull((String)hshRequestValues.get("appno"));
			YearlyType="";
			WhichYear=Helper.correctNull((String)hshRequestValues.get("sel_year"));
			strQuery=SQLParser.getSqlQuery("com_cbm_appno_sel^"+strAppno);
			rs1=DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				YearlyType=(Helper.correctNull((String)rs1.getString(3)));
				DisableYear=true;
			}
			else
			{
				YearlyType=Helper.correctNull((String)hshRequestValues.get("sel_ass_type"));
			}
			hshValues.put("DisableYear",Boolean.toString(DisableYear));
			if(rs1!=null)
			{
				rs1.close();
			}
			if((WhichYear.equals("") || WhichYear.equals(null)))
			{	 
				/*
				 * When the page is loaded by navigating from other page
				 */
				strQuery=SQLParser.getSqlQuery("com_cbm_appno_sel^"+strAppno);
				rs1=DBUtils.executeQuery(strQuery);
				
				if(rs1.next())
				{
					YearlyType=(Helper.correctNull((String)rs1.getString(3)));
					WhichYear=(Helper.correctNull((String)rs1.getString(4)));
					finYear=(Helper.correctNull((String)rs1.getString(28)));
					count=Integer.parseInt(YearlyType);
					Sno=new String[count];
					particulars=new String[count];
					rowVal1=new String[count];
					rowVal2=new String[count];
					rowVal3=new String[count];
					rowVal4=new String[count];
					rowVal5=new String[count];
					rowVal6=new String[count];
					rowVal7=new String[count];
					rowVal8=new String[count];
					rowVal9=new String[count];
					rowVal10=new String[count];
					rowVal11=new String[count];
					rowVal12=new String[count];
					rowVal13=new String[count];
					rowVal14=new String[count];
					rowVal15=new String[count];
					rowVal16=new String[count];
					rowVal17=new String[count];
					rowVal18=new String[count];
					rowVal19=new String[count];
					rowVal20=new String[count];
					rowVal21=new String[count];
					rowVal22=new String[count];
				strQuery=SQLParser.getSqlQuery("com_cash_budget_method_sel^"+strAppno+"^"+WhichYear);
				rs=DBUtils.executeQuery(strQuery);
				int i=0;
				ArrColumn=new ArrayList();	
				ArrRow=new ArrayList();
				if (rs.next() && WhichYear.equals("y1"))
				{
						ArrColumn.add(Helper.correctNull((String)rs.getString(5)));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(6)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(7)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(8)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(9)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(10)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(11)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(12)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(13)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(14)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(15)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(16)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(17)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(18)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(19)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(20)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(21)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(22)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(23)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(24)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(25)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(26)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(27)))));

				}	
				else
				{
					if(rs2!=null){rs.close();}
					String PreviousYear=WhichYear.substring(1,2);
					PreviousYear="y"+(Integer.parseInt(PreviousYear)-1);
					String lstYear="Last Year";
					strQuery=SQLParser.getSqlQuery("com_cash_budget_method_sno^"+strAppno+"^"+PreviousYear+"^"+"13");
					rs2=DBUtils.executeQuery(strQuery);
					if(rs2.next())
					{
					ArrColumn.add(lstYear);
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(6)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(7)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(8)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(9)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(10)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(11)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(12)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(13)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(14)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(15)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(16)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(17)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(18)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(19)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(20)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(21)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(22)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(23)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(24)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(25)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(26)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(27)))));
					}
					else
					{
						ArrColumn.add("");
						ArrColumn.add(nf.format(a));
						ArrColumn.add(nf.format(a));
						ArrColumn.add(nf.format(a));
						ArrColumn.add(nf.format(a));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(10)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(11)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(12)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(13)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(14)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(15)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(16)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(17)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(18)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(19)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(20)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(21)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(22)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(23)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(24)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(25)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(26)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(27)))));
					}
				}
				while(rs.next())
				{
					String sno=(Helper.correctNull((String)rs.getString(2)));
					if(sno.equals("13"))
					{
						ArrRow.add(Helper.correctNull((String)rs.getString(5)));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(6)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(7)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(8)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(9)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(10)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(11)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(12)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(13)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(14)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(15)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(16)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(17)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(18)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(19)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(20)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(21)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(22)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(23)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(24)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(25)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(26)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(27)))));
					}
					else
					{
					YearlyType=(Helper.correctNull((String)rs.getString(3)));
					WhichYear=(Helper.correctNull((String)rs.getString(4)));
					finYear=(Helper.correctNull((String)rs.getString(28)));
					particulars[i]=(Helper.correctNull((String)rs.getString(5)));
					rowVal1[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(6))));
					rowVal2[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(7))));
					rowVal3[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(8))));
					rowVal4[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(9))));
					rowVal5[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(10))));
					rowVal6[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(11))));
					rowVal7[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(12))));
					rowVal8[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(13))));
					rowVal9[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(14))));
					rowVal10[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(15))));
					rowVal11[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(16))));
					rowVal12[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(17))));
					rowVal13[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(18))));
					rowVal14[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(19))));
					rowVal15[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(20))));
					rowVal16[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(21))));
					rowVal17[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(22))));
					rowVal18[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(23))));
					rowVal19[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(24))));
					rowVal20[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(25))));
					rowVal21[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(26))));
					rowVal22[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(27))));
					i++;
					}
				}
				}
				else
				{
					YearlyType="1";
					WhichYear="y1";
					
					count=Integer.parseInt(YearlyType);
					Sno=new String[count];
					particulars=new String[count];
					rowVal1=new String[count];
					rowVal2=new String[count];
					rowVal3=new String[count];
					rowVal4=new String[count];
					rowVal5=new String[count];
					rowVal6=new String[count];
					rowVal7=new String[count];
					rowVal8=new String[count];
					rowVal9=new String[count];
					rowVal10=new String[count];
					rowVal11=new String[count];
					rowVal12=new String[count];
					rowVal13=new String[count];
					rowVal14=new String[count];
					rowVal15=new String[count];
					rowVal16=new String[count];
					rowVal17=new String[count];
					rowVal18=new String[count];
					rowVal19=new String[count];
					rowVal20=new String[count];
					rowVal21=new String[count];
					rowVal22=new String[count];
					
					for(int i=0;i<count;i++)
					{
						particulars[i]="";
						rowVal1[i]=nf.format(a);
						rowVal2[i]=nf.format(a);
						rowVal3[i]=nf.format(a);
						rowVal4[i]=nf.format(a);
						rowVal5[i]=nf.format(a);
						rowVal6[i]=nf.format(a);
						rowVal7[i]=nf.format(a);
						rowVal8[i]=nf.format(a);
						rowVal9[i]=nf.format(a);
						rowVal10[i]=nf.format(a);
						rowVal11[i]=nf.format(a);
						rowVal12[i]=nf.format(a);
						rowVal13[i]=nf.format(a);
						rowVal14[i]=nf.format(a);
						rowVal15[i]=nf.format(a);
						rowVal16[i]=nf.format(a);
						rowVal17[i]=nf.format(a);
						rowVal18[i]=nf.format(a);
						rowVal19[i]=nf.format(a);
						rowVal20[i]=nf.format(a);
						rowVal21[i]=nf.format(a);
						rowVal22[i]=nf.format(a);
					}
					ArrRow.add("");
					ArrRow.add(nf.format(a));
					ArrRow.add(nf.format(a));
					ArrRow.add(nf.format(a));
					ArrRow.add(nf.format(a));
					ArrRow.add(nf.format(a));
					ArrRow.add(nf.format(a));
					ArrRow.add(nf.format(a));
					ArrRow.add(nf.format(a));
					ArrRow.add(nf.format(a));
					ArrRow.add(nf.format(a));
					ArrRow.add(nf.format(a));
					ArrRow.add(nf.format(a));
					ArrRow.add(nf.format(a));
					ArrRow.add(nf.format(a));
					ArrRow.add(nf.format(a));
					ArrRow.add(nf.format(a));
					ArrRow.add(nf.format(a));
					ArrRow.add(nf.format(a));
					ArrRow.add(nf.format(a));
					ArrRow.add(nf.format(a));
					ArrRow.add(nf.format(a));
					ArrRow.add(nf.format(a));
					
					ArrColumn.add("");
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
				}
			}
			else 
			{/*page reloaded by selection of  assessment type or  year */
				count=12;
				Sno=new String[count];
				particulars=new String[count];
				rowVal1=new String[count];
				rowVal2=new String[count];
				rowVal3=new String[count];
				rowVal4=new String[count];
				rowVal5=new String[count];
				rowVal6=new String[count];
				rowVal7=new String[count];
				rowVal8=new String[count];
				rowVal9=new String[count];
				rowVal10=new String[count];
				rowVal11=new String[count];
				rowVal12=new String[count];
				rowVal13=new String[count];
				rowVal14=new String[count];
				rowVal15=new String[count];
				rowVal16=new String[count];
				rowVal17=new String[count];
				rowVal18=new String[count];
				rowVal19=new String[count];
				rowVal20=new String[count];
				rowVal21=new String[count];
				rowVal22=new String[count];
			strQuery=SQLParser.getSqlQuery("com_cash_budget_method_sel^"+strAppno+"^"+WhichYear);
			rs=DBUtils.executeQuery(strQuery);
			int i=0;
			if (rs.next())
			{
				if(WhichYear.equals("y1"))
				{
				ArrColumn.add(Helper.correctNull((String)rs.getString(5)));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(6)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(7)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(8)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(9)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(10)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(11)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(12)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(13)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(14)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(15)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(16)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(17)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(18)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(19)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(20)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(21)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(22)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(23)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(24)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(25)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(26)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(27)))));
				}
				else
				{
					if(rs2!=null){rs.close();}
					String PreviousYear=WhichYear.substring(1,2);
					PreviousYear="y"+(Integer.parseInt(PreviousYear)-1);
					String lstYear=" Last Year";
					strQuery=SQLParser.getSqlQuery("com_cash_budget_method_sno^"+strAppno+"^"+PreviousYear+"^"+"13");
					rs2=DBUtils.executeQuery(strQuery);
					if(rs2.next())
					{
					
					ArrColumn.add(lstYear);
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(6)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(7)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(8)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(9)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(10)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(11)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(12)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(13)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(14)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(15)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(16)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(17)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(18)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(19)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(20)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(21)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(22)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(23)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(24)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(25)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(26)))));
					ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(27)))));
					}
					else
					{
						ArrColumn.add("");
						ArrColumn.add(nf.format(a));
						ArrColumn.add(nf.format(a));
						ArrColumn.add(nf.format(a));
						ArrColumn.add(nf.format(a));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(10)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(11)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(12)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(13)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(14)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(15)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(16)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(17)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(18)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(19)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(20)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(21)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(22)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(23)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(24)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(25)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(26)))));
						ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(27)))));
					}
				}
				i=0;
				while(rs.next())
				{
					String sno=(Helper.correctNull((String)rs.getString(2)));
					YearlyType=(Helper.correctNull((String)rs.getString(3)));
					WhichYear=(Helper.correctNull((String)rs.getString(4)));
					finYear=(Helper.correctNull((String)rs.getString(28)));
					if(sno.equals("13"))
					{
						ArrRow.add(Helper.correctNull((String)rs.getString(5)));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(6)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(7)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(8)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(9)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(10)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(11)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(12)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(13)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(14)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(15)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(16)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(17)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(18)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(19)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(20)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(21)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(22)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(23)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(24)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(25)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(26)))));
						ArrRow.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(27)))));
					}
					else
					{	
					particulars[i]=(Helper.correctNull((String)rs.getString(5)));
					rowVal1[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(6))));
					rowVal2[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(7))));
					rowVal3[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(8))));
					rowVal4[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(9))));
					rowVal5[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(10))));
					rowVal6[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(11))));
					rowVal7[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(12))));
					rowVal8[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(13))));
					rowVal9[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(14))));
					rowVal10[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(15))));
					rowVal11[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(16))));
					rowVal12[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(17))));
					rowVal13[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(18))));
					rowVal14[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(19))));
					rowVal15[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(20))));
					rowVal16[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(21))));
					rowVal17[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(22))));
					rowVal18[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(23))));
					rowVal19[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(24))));
					rowVal20[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(25))));
					rowVal21[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(26))));
					rowVal22[i]=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(27))));
					i++;
					}
				}
			}
			else
			{
				if(rs2!=null){rs.close();}
				String PreviousYear=WhichYear.substring(1,2);
				PreviousYear="y"+(Integer.parseInt(PreviousYear)-1);
				String lstYear="Last Year";
				strQuery=SQLParser.getSqlQuery("com_cash_budget_method_sno^"+strAppno+"^"+PreviousYear+"^"+"13");
				rs2=DBUtils.executeQuery(strQuery);
				if(rs2.next())
				{
				ArrColumn.add(lstYear);
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(6)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(7)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(8)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(9)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(10)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(11)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(12)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(13)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(14)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(15)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(16)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(17)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(18)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(19)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(20)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(21)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(22)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(23)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(24)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(25)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(26)))));
				ArrColumn.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs2.getString(27)))));
				}
				else
				{
					ArrColumn.add("");
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
					ArrColumn.add(nf.format(a));
				}
				for( i=0;i<count;i++)
				{
					particulars[i]="";
					rowVal1[i]=nf.format(a);
					rowVal2[i]=nf.format(a);
					rowVal3[i]=nf.format(a);
					rowVal4[i]=nf.format(a);
					rowVal5[i]=nf.format(a);
					rowVal6[i]=nf.format(a);
					rowVal7[i]=nf.format(a);
					rowVal8[i]=nf.format(a);
					rowVal9[i]=nf.format(a);
					rowVal10[i]=nf.format(a);
					rowVal11[i]=nf.format(a);
					rowVal12[i]=nf.format(a);
					rowVal13[i]=nf.format(a);
					rowVal14[i]=nf.format(a);
					rowVal15[i]=nf.format(a);
					rowVal16[i]=nf.format(a);
					rowVal17[i]=nf.format(a);
					rowVal18[i]=nf.format(a);
					rowVal19[i]=nf.format(a);
					rowVal20[i]=nf.format(a);
					rowVal21[i]=nf.format(a);
					rowVal22[i]=nf.format(a);	
				}
				ArrRow.add("");
				ArrRow.add(nf.format(a));
				ArrRow.add(nf.format(a));
				ArrRow.add(nf.format(a));
				ArrRow.add(nf.format(a));
				ArrRow.add(nf.format(a));
				ArrRow.add(nf.format(a));
				ArrRow.add(nf.format(a));
				ArrRow.add(nf.format(a));
				ArrRow.add(nf.format(a));
				ArrRow.add(nf.format(a));
				ArrRow.add(nf.format(a));
				ArrRow.add(nf.format(a));
				ArrRow.add(nf.format(a));
				ArrRow.add(nf.format(a));
				ArrRow.add(nf.format(a));
				ArrRow.add(nf.format(a));
				ArrRow.add(nf.format(a));
				ArrRow.add(nf.format(a));
				ArrRow.add(nf.format(a));
				ArrRow.add(nf.format(a));
				ArrRow.add(nf.format(a));
				ArrRow.add(nf.format(a));
			}
			}
			if(rs1!=null){rs1.close();}
			if(rs!=null){rs.close();}
			if(rs2!=null){rs2.close();}
if(YearlyType.equals("")||YearlyType.equals(null))
{
	YearlyType="1";
}
if(!WhichYear.equals("y1"))
{
	ReadOnlyLastYearFields=true;
}				

				/** Added by DINESH on 29/03/2014 for Cash Budget - Peak Deficit **/

				int temp = 999999999,m=0;
				ArrDefRow=new ArrayList();
				strQuery=SQLParser.getSqlQuery("sel_cashbudget_surdeficit^"+strAppno);
				rs2=DBUtils.executeQuery(strQuery);
				while(rs2.next())
				{
					ArrDefRow.add(correctNull((String)rs2.getString("ccbm_srpls_dfct")));
					
					
					Object rowvalue[]=ArrDefRow.toArray();
					
					if(ArrDefRow!=null && ArrDefRow.size()>0)
					{
						for(int i=0;i<ArrDefRow.size();i++)
						{
							if(rowvalue[i]!=null && !rowvalue[i].equals("0"))
							{
								if(temp > (int)Math.round(Double.parseDouble(Helper.correctDouble((String)rowvalue[i]))))
								{
									temp = (int)Math.round(Double.parseDouble(Helper.correctDouble((String)rowvalue[i])));
								}
							}
						}
					}
					else
					{
						if(temp==999999999)
						{
							temp = 0;
						}
					}
				}
				if(temp==999999999)
				{
					temp = 0;
				}
		/*		String rowvalue2[]=new String[ArrDefRow.size()];
				
				for(int i=0;i<ArrDefRow.size();i++)
				{
					rowvalue2[i]=(String)ArrDefRow.get(i);
				}
		*/		
				/** End **/


				hshValues.put("particulars", particulars);
				hshValues.put("Lastyear",ArrColumn);
				hshValues.put("TotalValues",ArrRow);
				hshValues.put("rowVal1", rowVal1);
				hshValues.put("rowVal2", rowVal2);
				hshValues.put("rowVal3", rowVal3);
				hshValues.put("rowVal4", rowVal4);
				hshValues.put("rowVal5", rowVal5);
				hshValues.put("rowVal6", rowVal6);
				hshValues.put("rowVal7", rowVal7);
				hshValues.put("rowVal8", rowVal8);
				hshValues.put("rowVal9", rowVal9);
				hshValues.put("rowVal10", rowVal10);
				hshValues.put("rowVal11", rowVal11);
				hshValues.put("rowVal12", rowVal12);
				hshValues.put("rowVal13", rowVal13);
				hshValues.put("rowVal14", rowVal14);
				hshValues.put("rowVal15", rowVal15);
				hshValues.put("rowVal16", rowVal16);
				hshValues.put("rowVal17", rowVal17);
				hshValues.put("rowVal18", rowVal18);
				hshValues.put("rowVal19", rowVal19);
				hshValues.put("rowVal20", rowVal20);
				hshValues.put("rowVal21", rowVal21);
				hshValues.put("rowVal22", rowVal22);
				hshValues.put("YearlyType",YearlyType);
				hshValues.put("WhichYear",WhichYear);
				hshValues.put("finYear",finYear);
				hshValues.put("ReadOnlyLastYearFields", Boolean.toString(ReadOnlyLastYearFields));
				hshValues.put("maxDeficit", ""+nf.format(temp));
				
				String strFinID="0",strValuesin="";
				strQuery = SQLParser.getSqlQuery("sel_financeid^" + strAppno);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					strFinID = Helper.correctInt((String) rs
							.getString("DEMO_FINSTANDARD"));
				}
				if (!strFinID.equals("0")) {
					strQuery = SQLParser
							.getSqlQuery("fin_cmano_select^" + strFinID);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
						strValuesin = Helper.correctNull((String) rs
								.getString("fin_valuesarein"));
					}
				}
				if(strValuesin.equalsIgnoreCase("C"))
				{
					hshValues.put("strValuesin", "Crore");
				}
				else if(strValuesin.equalsIgnoreCase("L"))
				{
					hshValues.put("strValuesin", "Lacs");
				}else{
					hshValues.put("strValuesin", "Rupees");
				}
		}
		catch (Exception e) {
			throw new EJBException("Error in getdata "+e.toString());
		}
		return hshValues;
	}
	public void deleteCashFlowBudget(HashMap hshRequestValues) 
	{
		ResultSet rs=null;
		String strAppno="",WhichYear="",particularYear="";
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues=new ArrayList();
		int updateSize=0;
		try
		{
		strAppno=correctNull((String)hshRequestValues.get("appno"));
		WhichYear=Helper.correctNull((String)hshRequestValues.get("sel_year"));
		arrValues=new ArrayList();
		hshQuery=new HashMap();
		hshQuery.put("strQueryId","com_cash_budget_method_del");
		arrValues.add(strAppno);
		arrValues.add(WhichYear);
		updateSize++;
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put(""+updateSize,hshQuery);
		hshQueryValues.put("size",""+updateSize);
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		catch (Exception e) {
			throw new EJBException("Error in getdata "+e.toString());
		}
	}
	public void updateCashFlowBudget(HashMap hshRequestValues) 
	{
		ResultSet rs=null;
		String strAppno="",YearlyType="",WhichYear="",particularYear="",strfinYr="";
		ArrayList ArrColumn=new ArrayList();
		ArrayList ArrRow=new ArrayList();

		String [] particulars=null;
		String[] row1=null,row2=null,row3=null,row4=null,row5=null,row6=null,row7=null;
		String[] row8=null,row9=null,row10=null,row11=null,row12=null,row13=null,row14=null;
		String[] row15=null,row16=null,row17=null,row18=null,row19=null,row20=null,row21=null,row22=null;

		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList a=new ArrayList();
		ArrayList arrValues=new ArrayList();
		int updateSize=0;
		try
		{
			strAppno=correctNull((String)hshRequestValues.get("appno"));
			YearlyType=Helper.correctNull((String)hshRequestValues.get("sel_ass_type"));
			WhichYear=Helper.correctNull((String)hshRequestValues.get("sel_year"));
			strfinYr = Helper.correctNull((String)hshRequestValues.get("txt_finYear"));
			
			double cshFlow=0.00,totalRecpt=0.00,sd=0.00;
			cshFlow=Double.parseDouble(Helper.correctDouble((String)hshRequestValues.get("txt_totyear18")));
			totalRecpt=Double.parseDouble(Helper.correctDouble((String)hshRequestValues.get("txt_totyear4")));
			sd=Double.parseDouble(Helper.correctDouble((String)hshRequestValues.get("txt_totyear22")));
			if(totalRecpt>0 ||  cshFlow>0 || sd>0)
			{
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			hshQuery.put("strQueryId","com_cash_budget_method_del");
			arrValues.add(strAppno);
			arrValues.add(WhichYear);
			updateSize++;
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+updateSize,hshQuery);
			hshQueryValues.put("size",""+updateSize);
			
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			updateSize++;
			//Insertion of Last year values
			hshQuery.put("strQueryId","com_cash_budget_method_ins");
			arrValues.add(strAppno);
			arrValues.add("0");
			arrValues.add(YearlyType);
			arrValues.add(WhichYear);
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_lastYear0")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_lastYear1")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_lastYear2")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_lastYear3")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_lastYear4")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_lastYear5")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_lastYear6")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_lastYear7")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_lastYear8")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_lastYear9")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_lastYear10")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_lastYear11")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_lastYear12")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_lastYear13")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_lastYear14")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_lastYear15")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_lastYear16")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_lastYear17")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_lastYear18")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_lastYear19")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_lastYear20")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_lastYear21")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_lastYear22")));
			arrValues.add(strfinYr);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+updateSize,hshQuery);
			hshQueryValues.put("size",""+updateSize);
			
			if(YearlyType.equalsIgnoreCase("1"))
			{
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				updateSize++;
				
				//Insertion of Yearly details
				hshQuery.put("strQueryId","com_cash_budget_method_ins");
				arrValues.add(strAppno);
				arrValues.add("1");
				arrValues.add(YearlyType);
				arrValues.add(WhichYear);
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_particulars")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_row1")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_row2")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_row3")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_row4")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_row5")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_row6")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_row7")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_row8")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_row9")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_row10")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_row11")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_row12")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_row13")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_row14")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_row15")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_row16")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_row17")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_row18")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_row19")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_row20")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_row21")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_row22")));
				arrValues.add(strfinYr);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+updateSize,hshQuery);
				hshQueryValues.put("size",""+updateSize);
				
				
				
				
			}
			else
			{
			particulars=(String[])hshRequestValues.get("txt_particulars");
			row1=(String[])hshRequestValues.get("txt_row1");
			row2=(String[])hshRequestValues.get("txt_row2");
			row3=(String[])hshRequestValues.get("txt_row3");
			row4=(String[])hshRequestValues.get("txt_row4");
			row5=(String[])hshRequestValues.get("txt_row5");
			row6=(String[])hshRequestValues.get("txt_row6");
			row7=(String[])hshRequestValues.get("txt_row7");
			row8=(String[])hshRequestValues.get("txt_row8");
			row9=(String[])hshRequestValues.get("txt_row9");
			row10=(String[])hshRequestValues.get("txt_row10");
			row11=(String[])hshRequestValues.get("txt_row11");
			row12=(String[])hshRequestValues.get("txt_row12");
			row13=(String[])hshRequestValues.get("txt_row13");
			row14=(String[])hshRequestValues.get("txt_row14");
			row15=(String[])hshRequestValues.get("txt_row15");
			row16=(String[])hshRequestValues.get("txt_row16");
			row17=(String[])hshRequestValues.get("txt_row17");
			row18=(String[])hshRequestValues.get("txt_row18");
			row19=(String[])hshRequestValues.get("txt_row19");
			row20=(String[])hshRequestValues.get("txt_row20");
			row21=(String[])hshRequestValues.get("txt_row21");
			row22=(String[])hshRequestValues.get("txt_row22");
			
			for(int i=0;i<particulars.length;i++)
			{
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			updateSize++;
			hshQuery.put("strQueryId","com_cash_budget_method_ins");
			
			arrValues.add(strAppno);
			String sno=""+(i+1);
			arrValues.add(sno);//sno
			arrValues.add(YearlyType);
			arrValues.add(WhichYear);
			arrValues.add(Helper.correctNull(particulars[i]));
			arrValues.add(row1[i]);
			arrValues.add(row2[i]);
			arrValues.add(row3[i]);
			arrValues.add(row4[i]);
			arrValues.add(row5[i]);
			arrValues.add(row6[i]);
			arrValues.add(row7[i]);
			arrValues.add(row8[i]);
			arrValues.add(row9[i]);
			arrValues.add(row10[i]);
			arrValues.add(row11[i]);
			arrValues.add(row12[i]);
			arrValues.add(row13[i]);
			arrValues.add(row14[i]);
			arrValues.add(row15[i]);
			arrValues.add(row16[i]);
			arrValues.add(row17[i]);
			arrValues.add(row18[i]);
			arrValues.add(row19[i]);
			arrValues.add(row20[i]);
			arrValues.add(row21[i]);
			arrValues.add(row22[i]);
			arrValues.add(strfinYr);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+updateSize,hshQuery);
			hshQueryValues.put("size",""+updateSize);
			}
			}
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			updateSize++;
			//Insertion of total 
			hshQuery.put("strQueryId","com_cash_budget_method_ins");
			arrValues.add(strAppno);
			arrValues.add("13");
			arrValues.add(YearlyType);
			arrValues.add(WhichYear);
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_totyear1")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_totyear2")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_totyear3")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_totyear4")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_totyear5")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_totyear6")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_totyear7")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_totyear8")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_totyear9")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_totyear10")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_totyear11")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_totyear12")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_totyear13")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_totyear14")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_totyear15")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_totyear16")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_totyear17")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_totyear18")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_totyear19")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_totyear20")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_totyear21")));
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_totyear22")));
			arrValues.add(strfinYr);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+updateSize,hshQuery);
			hshQueryValues.put("size",""+updateSize);
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch (Exception e) {
			throw new EJBException("Error in getdata "+e.toString());
		}
	}
	
}