 package com.sai.laps.ejb.bankapp;

import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.StringTokenizer;
import java.util.ArrayList;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
@Stateless(name = "BankAppBean", mappedName = "BankAppHome")
@Remote (BankAppRemote.class)
public class BankAppBean extends BeanAdapter
{
	private static final long serialVersionUID = 1L;
	public  HashMap getData(HashMap hshValues) 
	{
		ResultSet rs = null;
		String strQuery="";
		String strcomapp_id="";
		ResultSet rs1 = null;
	    HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecVal=new ArrayList();
		String strSourcePage="";
		boolean recordflag=false;
		String strQuery1="";
		try
		{
			strSourcePage=correctNull((String)hshValues.get("hidPageSource"));
			strcomapp_id=correctNull((String)hshValues.get("hidapplicantid"));
			if(strcomapp_id.equalsIgnoreCase(""))
			{
				strcomapp_id=Helper.correctNull((String)hshValues.get("hidAppId"));
			}
			if(!strSourcePage.trim().equalsIgnoreCase("COP"))
			{
				String appno=correctNull((String)hshValues.get("appno"));
				String strAction = correctNull((String)hshValues.get("hidAction"));
				String strGradeNo= correctNull((String)hshValues.get("selsno"));
				
				/*if(strAction.trim().equals("edit"))
				{
					strQuery = SQLParser.getSqlQuery("combankingsel^"+appno+"^"+strGradeNo);
				}
				else
				{
					strQuery = SQLParser.getSqlQuery("combankingselection^"+appno);
				}				
				if(rs!=null)
				{
					rs.close();					
				}
				rs = DBUtils.executeQuery(strQuery);
				double netlmtfundexist=0.00;double netlmtfundprop=0.00;
				double netlmtnonfundexist=0.00;double netlmtnonfundprop=0.00;
				while(rs.next())
				{	 
					vecVal = new ArrayList();
					vecVal.add(correctNull(rs.getString("combk_id")));//0
					vecVal.add(Helper.correctDouble(rs.getString("combk_lmtfundexist")));//1
					vecVal.add(Helper.correctDouble(rs.getString("combk_lmtfundprop")));//2
					vecVal.add(Helper.correctDouble(rs.getString("combk_lmtnonfundexist")));//3
					vecVal.add(Helper.correctDouble(rs.getString("combk_lmtnonfundprop")));//4
					vecVal.add(correctNull(rs.getString("combk_overdue")));//5
					vecVal.add(correctNull(rs.getString("combk_type")));//6
					vecVal.add(correctNull(rs.getString("combk_bankname")));//7
					vecVal.add(correctNull(rs.getString("combk_compname")));//8
					vecVal.add(correctNull(rs.getString("combk_selbank")));//9
					String strCompname=correctNull(rs.getString("combk_compname"));
					
					rs1 = DBUtils.executeLAPSQuery("selectCompName^"+strCompname+"^"+strcomapp_id);
					if(rs1.next())
					{
						vecVal.add(correctNull(rs1.getString("comapp_div_name")));//10
					}
					else{
						if(strCompname.equalsIgnoreCase("0")){
							vecVal.add("");//10
						}
						else
						{
							vecVal.add("");//10
						}
					}
					vecVal.add(correctNull(rs.getString("combk_consortium")));//11
					
					netlmtfundexist = netlmtfundexist + Double.parseDouble((Helper.correctDouble(rs.getString("combk_lmtfundexist"))));
					netlmtfundprop = netlmtfundprop + Double.parseDouble((Helper.correctDouble(rs.getString("combk_lmtfundprop"))));
					netlmtnonfundexist = netlmtnonfundexist + Double.parseDouble((Helper.correctDouble(rs.getString("combk_lmtnonfundexist"))));
					netlmtnonfundprop = netlmtnonfundprop + Double.parseDouble((Helper.correctDouble(rs.getString("combk_lmtnonfundprop"))));
					
					if(rs1!=null){
						rs1.close();
					}
				 	vecData.add(vecVal);	
				 	recordflag=true;
				}	
				hshRecord.put("vecData",vecData);
				hshRecord.put("netlmtfundexist",Helper.formatDoubleValue(netlmtfundexist));
				hshRecord.put("netlmtfundprop",Helper.formatDoubleValue(netlmtfundprop));
				hshRecord.put("netlmtnonfundexist",Helper.formatDoubleValue(netlmtnonfundexist));
				hshRecord.put("netlmtnonfundprop",Helper.formatDoubleValue(netlmtnonfundprop));
				 if(recordflag)
						hshRecord.put("recordflag","Y");
					else
						hshRecord.put("recordflag","N");*/
				
				strQuery = SQLParser.getSqlQuery("combankingselectNEW^"+appno+"^W^ ");
				if(rs!=null)
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					vecVal=new ArrayList();
					vecVal.add(Helper.correctInt((String)rs.getString("combk_id")));//0
					vecVal.add(Helper.correctNull((String)rs.getString("combk_facility")));//1
					vecVal.add(Helper.correctNull((String)rs.getString("combk_osasondate")));//2
					vecVal.add(Helper.correctNull((String)rs.getString("combk_bnktype")));//3
					vecVal.add(Helper.correctNull((String)rs.getString("combk_inttype")));//4
					vecVal.add(Helper.correctNull((String)rs.getString("combk_credittype")));//5
					vecVal.add(Helper.correctNull((String)rs.getString("combk_sancrefno")));//6
					vecVal.add(Helper.correctNull((String)rs.getString("combk_sancdate")));//7
					vecVal.add(Helper.correctNull((String)rs.getString("combk_duedate")));//8
					vecVal.add(Helper.correctNull((String)rs.getString("combk_arrears")));//9
					/*String strCompname=Helper.correctNull((String)rs.getString("combk_companyname"));
					strQuery1=SQLParser.getSqlQuery("selectCompName^"+strCompname+"^"+strcomapp_id);
					rs1 = DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						vecVal.add(Helper.correctNull(rs1.getString("comapp_div_name")));//10
					}
					else
					{
						if(strCompname.equalsIgnoreCase("0"))
						{
							vecVal.add("");//10
						}
						else
						{
							vecVal.add("");//10
						}
					}*/
					vecVal.add(Helper.correctNull((String)rs.getString("combk_companyname")));//10
					String strBank=Helper.correctNull((String)rs.getString("combk_bnk"));
					vecVal.add(strBank);//11
					vecVal.add(Helper.correctNull((String)rs.getString("combk_bnkname")));//12
					vecVal.add(Helper.correctNull((String)rs.getString("combk_fundtype")));//13
					vecVal.add(Helper.correctDouble((String)rs.getString("combk_limit")));//14
					vecVal.add(Helper.correctDouble((String)rs.getString("combk_os")));//15
					vecVal.add(Helper.correctDouble((String)rs.getString("combk_spread")));//16
					vecVal.add(Helper.correctNull((String)rs.getString("combk_remarks")));//17
					if(strBank.equalsIgnoreCase("Our"))
					{
						String strcombk_modtype=Helper.correctNull((String)rs.getString("combk_modtype"));
						
						if(strcombk_modtype.equalsIgnoreCase("c"))
						{
							strQuery1=SQLParser.getSqlQuery("sel_FacilityCorpDesc^"+Helper.correctNull((String)rs.getString("combk_facility"))+"^c");
							rs1 = DBUtils.executeQuery(strQuery1);
							if(rs1.next())
							{
								vecVal.add(Helper.correctNull(rs1.getString("com_facdesc")));//18
							}
							else
							{
								vecVal.add("");//18
							}
						
						}
						else if(strcombk_modtype.equalsIgnoreCase("a"))
						{
								strQuery1=SQLParser.getSqlQuery("sel_FacilityCorpDesc^"+Helper.correctNull((String)rs.getString("combk_facility"))+"^a");
								rs1 = DBUtils.executeQuery(strQuery1);
								if(rs1.next())
								{
									vecVal.add(Helper.correctNull(rs1.getString("com_facdesc")));//18
								}
								else
								{
									vecVal.add("");//18
								}
						
						}
						else
						{
							vecVal.add("");//18
						}
					}
					else
					{
						vecVal.add("");//18
					}
					vecVal.add(Helper.correctNull((String)rs.getString("combk_facility_sno")));//19
					vecVal.add(Helper.correctNull((String)rs.getString("combk_modtype")));//19
					
					vecData.add(vecVal);
					recordflag=true;
				}
				hshRecord.put("vecData",vecData);
				if(recordflag)
					hshRecord.put("recordflag","Y");
				else
					hshRecord.put("recordflag","N");
			}
			else
			{
				ArrayList vecOthers = new ArrayList();
				ArrayList vecIncurred = new ArrayList();
				ArrayList vecTobeIncurred = new ArrayList();
				ArrayList vecTotal= new ArrayList();
				hshRecord = new HashMap();
				String strAppno="";
				double dblTotalCapital1=0;
				double dblTotalCapital2=0;
				double dblTotalCapital3=0;

				double dblTotalCost1=0;
				double dblTotalCost2=0;
				double dblTotalCost3=0;
				double dblTotal1=0;
				double dblTotal2=0;
				double dblTotal3=0;
				hshRecord = new HashMap();
				strAppno=correctNull((String)hshValues.get("appno"));
				rs=DBUtils.executeLAPSQuery("costofprojectsel^"+strAppno);
				vecIncurred=new ArrayList();
				int i=1;
				while(rs.next())
				{   
					vecIncurred.add(correctNull(rs.getString("com_costincurred")));
					vecTobeIncurred.add(correctNull(rs.getString("com_costtobe")));
					vecTotal.add(correctNull(rs.getString("totalcost")));
					if(i<=15)
					{
						dblTotalCapital1+=Double.parseDouble(rs.getString("com_costincurred"));
						dblTotalCapital2+=Double.parseDouble(rs.getString("com_costtobe"));
						dblTotalCapital3+=Double.parseDouble(rs.getString("totalcost"));
					}
					else if(i==16)
					{
						dblTotalCost1= dblTotalCapital1+ Double.parseDouble(rs.getString("com_costincurred"));
						dblTotalCost2= dblTotalCapital2+ Double.parseDouble(rs.getString("com_costtobe"));
						dblTotalCost3= dblTotalCapital3+ Double.parseDouble(rs.getString("totalcost"));
					}
					else
					{
						dblTotal1+=Double.parseDouble(rs.getString("com_costincurred"));
						dblTotal2+=Double.parseDouble(rs.getString("com_costtobe"));
						dblTotal3+=Double.parseDouble(rs.getString("totalcost"));
					}
					i++;
					vecOthers.add(correctNull(rs.getString("com_others")));
					 recordflag=true;
				}
				hshRecord.put("vecOthers",vecOthers);
				hshRecord.put("vecIncurred",vecIncurred);
				hshRecord.put("vecTobeIncurred",vecTobeIncurred);
				hshRecord.put("vecTotal",vecTotal);
				hshRecord.put("dblTotalCapital1",Helper.formatDoubleValue(dblTotalCapital1));
				hshRecord.put("dblTotalCapital2",Helper.formatDoubleValue(dblTotalCapital2));
				hshRecord.put("dblTotalCapital3",Helper.formatDoubleValue(dblTotalCapital3));
				hshRecord.put("dblTotalCost1",Helper.formatDoubleValue(dblTotalCost1));
				hshRecord.put("dblTotalCost2",Helper.formatDoubleValue(dblTotalCost2));
				hshRecord.put("dblTotalCost3",Helper.formatDoubleValue(dblTotalCost3));
				hshRecord.put("dblTotal1",Helper.formatDoubleValue(dblTotal1));
				hshRecord.put("dblTotal2",Helper.formatDoubleValue(dblTotal2));
				hshRecord.put("dblTotal3",Helper.formatDoubleValue(dblTotal3));
				 if(recordflag)
						hshRecord.put("recordflag","Y");
					else
						hshRecord.put("recordflag","N");
			}
			hshRecord.put("hidAppId",strcomapp_id);
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
	public  HashMap getCostofData(HashMap hshValues) 
	{
		ResultSet rs = null;
		String strQuery="";
		String strcomapp_id="";
		
	    HashMap hshRecord = new HashMap();
	    
		ArrayList vecData = new ArrayList();
		ArrayList vecVal=new ArrayList();
		String strSourcePage="";
		boolean recordflag=false;
		
		try
		{
			strSourcePage=correctNull((String)hshValues.get("hidPageSource"));
			strcomapp_id=correctNull((String)hshValues.get("hidapplicantid"));

			ArrayList vecOthers = new ArrayList();
			ArrayList vecIncurred = new ArrayList();
			ArrayList vecTobeIncurred = new ArrayList();
			ArrayList vecTotal= new ArrayList();
			hshRecord = new HashMap();
			String strAppno="";
			double dblTotalCapital1=0;
			double dblTotalCapital2=0;
			double dblTotalCapital3=0;

			double dblTotalCost1=0;
			double dblTotalCost2=0;
			double dblTotalCost3=0;
			double dblTotal1=0;
			double dblTotal2=0;
			double dblTotal3=0;
			hshRecord = new HashMap();
			strAppno=correctNull((String)hshValues.get("appno"));
			rs=DBUtils.executeLAPSQuery("costofprojectsel^"+strAppno);
			vecIncurred=new ArrayList();
			int i=1;
			while(rs.next())
			{   
				vecIncurred.add(correctNull(rs.getString("com_costincurred")));
				vecTobeIncurred.add(correctNull(rs.getString("com_costtobe")));
				vecTotal.add(correctNull(rs.getString("totalcost")));
				if(i<=15)
				{
					dblTotalCapital1+=Double.parseDouble(rs.getString("com_costincurred"));
					dblTotalCapital2+=Double.parseDouble(rs.getString("com_costtobe"));
					dblTotalCapital3+=Double.parseDouble(rs.getString("totalcost"));
				}
				else if(i==16)
				{
					dblTotalCost1= dblTotalCapital1+ Double.parseDouble(rs.getString("com_costincurred"));
					dblTotalCost2= dblTotalCapital2+ Double.parseDouble(rs.getString("com_costtobe"));
					dblTotalCost3= dblTotalCapital3+ Double.parseDouble(rs.getString("totalcost"));
				}
				else
				{
					dblTotal1+=Double.parseDouble(rs.getString("com_costincurred"));
					dblTotal2+=Double.parseDouble(rs.getString("com_costtobe"));
					dblTotal3+=Double.parseDouble(rs.getString("totalcost"));
				}
				i++;
				vecOthers.add(correctNull(rs.getString("com_others")));
				 recordflag=true;
			}
				
			hshRecord.put("vecOthers",vecOthers);
			hshRecord.put("vecIncurred",vecIncurred);
			hshRecord.put("vecTobeIncurred",vecTobeIncurred);
			hshRecord.put("vecTotal",vecTotal);
			hshRecord.put("dblTotalCapital1",Helper.formatDoubleValue(dblTotalCapital1));
			hshRecord.put("dblTotalCapital2",Helper.formatDoubleValue(dblTotalCapital2));
			hshRecord.put("dblTotalCapital3",Helper.formatDoubleValue(dblTotalCapital3));
			hshRecord.put("dblTotalCost1",Helper.formatDoubleValue(dblTotalCost1));
			hshRecord.put("dblTotalCost2",Helper.formatDoubleValue(dblTotalCost2));
			hshRecord.put("dblTotalCost3",Helper.formatDoubleValue(dblTotalCost3));
			hshRecord.put("dblTotal1",Helper.formatDoubleValue(dblTotal1));
			hshRecord.put("dblTotal2",Helper.formatDoubleValue(dblTotal2));
			hshRecord.put("dblTotal3",Helper.formatDoubleValue(dblTotal3));
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
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

	private int getMaxGradeId(String appno)
	{
		ResultSet rs = null;
		int termId = 0;
		try
		{	
			rs=DBUtils.executeLAPSQuery("combankingmax^"+appno);
			
			while(rs.next())
			{
				if(rs.getString(1) != null)
				{
					termId = Integer.parseInt(rs.getString(1)) + 1;
				}
				else
				{
					termId = 1;
				}
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

	public void updateData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String strGradeId = Helper.correctNull((String)hshValues.get("idno"));
		String appno=correctNull((String)hshValues.get("appno"));
		String strSourcePage="";
		StringBuilder sbAuditTrial=new StringBuilder();
		int intupdatesize=0;
		ResultSet rs=null;
		StringBuilder sbolddata=new StringBuilder();
		try
		{
			/*strSourcePage=correctNull((String)hshValues.get("hidPageSource"));
			if(!strSourcePage.trim().equalsIgnoreCase("COP"))
			{
				if(correctNull((String)hshValues.get("sel_Bank")).equalsIgnoreCase("Other"))
				{
					if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
					{
						strGradeId =  correctNull((String )hshValues.get("idno"));
						String strQuery=SQLParser.getSqlQuery("combankingsel^"+appno+"^"+strGradeId);
						rs=DBUtils.executeQuery(strQuery);	
						if(rs.next())
						{
							if(correctNull(rs.getString("combk_selbank")).equalsIgnoreCase("Our"))
							{
								sbolddata.append("Bank Type = ").append("Our Bank");
							}
							else if(correctNull(rs.getString("combk_selbank")).equalsIgnoreCase("Other"))
							{
								sbolddata.append("Bank Type = ").append("Other Bank");
								
							}
							else
							{
								sbolddata.append("Bank Type = ").append("");
							}
							sbolddata.append("~Bank= ").append(correctNull(rs.getString("combk_bankname")));
							if(Helper.correctNull((String)rs.getString("combk_consortium")).equalsIgnoreCase("Y"))
							{
								sbolddata.append("~Under Consortium= ").append("Yes");
							}
							else if(Helper.correctNull((String)rs.getString("combk_consortium")).equalsIgnoreCase("N"))
							{
								sbolddata.append("~Under Consortium= ").append("No");
							}
							else
							{
								sbolddata.append("~Under Consortium= ").append("");
							}
							sbolddata.append("~Limit (Funded Existing) = ").append(correctNull(rs.getString("combk_lmtfundexist")))
							.append("~Limit (Funded  Proposed) = ").append(correctNull(rs.getString("combk_lmtfundprop")))
							.append("~Limit (Non-Funded Existing) = ").append(correctNull(rs.getString("combk_lmtnonfundexist")))
							.append("~Limit (Non-Funded Proposed) = ").append(correctNull(rs.getString("combk_lmtnonfundprop")))
							.append("~Conduct of the Account =").append(correctNull(rs.getString("combk_overdue")));
						}
					}
				}
			}
			if(!strSourcePage.trim().equalsIgnoreCase("COP"))
			{
				if(strAction.equals("update"))
				{					
					hshQueryValues = new HashMap();
					intupdatesize++;
					hshQueryValues.put("size",""+intupdatesize);
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","combankingupdate");					
					
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_Limit")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_OS")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_SpreadVal")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("lmtnonfundedprop")));
					arrValues.add(correctNull((String )hshValues.get("txtarea_Remarks")));
					arrValues.add(correctNull((String )hshValues.get("txt_Bank")));
					arrValues.add(correctNull((String )hshValues.get("sel_CompName")));
					arrValues.add(correctNull((String )hshValues.get("sel_Bank")));
					arrValues.add(correctNull((String )hshValues.get("sel_Type")));
					arrValues.add(appno);
					arrValues.add(correctNull((String )hshValues.get("idno")));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intupdatesize,hshQuery);
					
					if(correctNull((String )hshValues.get("sel_Bank")).equals("Other"))
					{
						String strQuery=SQLParser.getSqlQuery("com_banking_banksel^"+appno+"^T^"+correctNull((String )hshValues.get("txt_Bank"))+"^"+correctNull((String )hshValues.get("sel_Type")));
						rs=DBUtils.executeQuery(strQuery);
						if(!rs.next())
						{
							hshQuery = new HashMap();	
							intupdatesize++;
							hshQueryValues.put("size",""+intupdatesize);				
							strGradeId = Integer.toString(getMaxGradeId(appno,"T"));
							
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","combankinginsert1");
							arrValues.add(appno);
							arrValues.add(strGradeId);
							arrValues.add(correctNull((String )hshValues.get("txt_Bank")));
							arrValues.add("0.00");
							arrValues.add("0.00");
							arrValues.add("0.00");
							arrValues.add("0.00");
							arrValues.add("");
							arrValues.add("T");
							arrValues.add(correctNull((String )hshValues.get("sel_CompName")));
							arrValues.add(correctNull((String )hshValues.get("sel_Bank")));
							arrValues.add(correctNull((String )hshValues.get("sel_Type")));
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(""+intupdatesize,hshQuery);
						}
					}
				}
				else if(strAction.equals("insert"))
				{					
					strGradeId = Integer.toString(getMaxGradeId(appno,"W"));
					String strTemp=correctNull((String )hshValues.get("txt_Bank"));	
					if (!strTemp.trim().equals(""))
					{
						hshQueryValues = new HashMap();
						hshQuery = new HashMap();	
						intupdatesize++;
						hshQueryValues.put("size",""+intupdatesize);				
						
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","combankinginsert1");
						arrValues.add(appno);
						arrValues.add(strGradeId);
						arrValues.add(correctNull((String )hshValues.get("txt_Bank")));
						arrValues.add(Helper.correctDouble((String )hshValues.get("txt_Limit")));
						arrValues.add(Helper.correctDouble((String )hshValues.get("txt_OS")));
						arrValues.add(Helper.correctDouble((String )hshValues.get("txt_SpreadVal")));
						arrValues.add(Helper.correctDouble((String )hshValues.get("lmtnonfundedprop")));
						arrValues.add(correctNull((String )hshValues.get("txtarea_Remarks")));
						arrValues.add(Helper.correctDouble((String )hshValues.get("type")));
						arrValues.add(correctNull((String )hshValues.get("sel_CompName")));
						arrValues.add(correctNull((String )hshValues.get("sel_Bank")));
						arrValues.add(correctNull((String )hshValues.get("sel_Type")));
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intupdatesize,hshQuery);
						
						String strQuery=SQLParser.getSqlQuery("com_banking_banksel^"+appno+"^T^"+correctNull((String )hshValues.get("txt_Bank"))+"^"+correctNull((String )hshValues.get("sel_Type")));
						rs=DBUtils.executeQuery(strQuery);
						if(!rs.next())
						{
							hshQuery = new HashMap();	
							intupdatesize++;
							hshQueryValues.put("size",""+intupdatesize);				
							strGradeId = Integer.toString(getMaxGradeId(appno,"T"));
							
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","combankinginsert1");
							arrValues.add(appno);
							arrValues.add(strGradeId);
							arrValues.add(correctNull((String )hshValues.get("txt_Bank")));
							arrValues.add("0.00");
							arrValues.add("0.00");
							arrValues.add("0.00");
							arrValues.add("0.00");
							arrValues.add("");
							arrValues.add("T");
							arrValues.add(correctNull((String )hshValues.get("sel_CompName")));
							arrValues.add(correctNull((String )hshValues.get("sel_Bank")));
							arrValues.add(correctNull((String )hshValues.get("sel_Type")));
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(""+intupdatesize,hshQuery);
						}
						
					}
				}
				else if(strAction.equals("delete"))
				{
					strGradeId =  correctNull((String )hshValues.get("idno"));
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					intupdatesize++;
					hshQueryValues.put("size",""+intupdatesize);					
					hshQuery.put("strQueryId","combankingdelete");
					arrValues.add(appno);
					arrValues.add(strGradeId);
					arrValues.add("W");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intupdatesize,hshQuery);
					
					if(rs!=null)
						rs.close();
					String strQuery=SQLParser.getSqlQuery("com_banking_banksel^"+appno+"^T^"+correctNull((String )hshValues.get("txt_Bank"))+"^"+correctNull((String )hshValues.get("sel_Type")));
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strGradeId=correctNull(rs.getString("combk_id"));
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intupdatesize++;
						hshQuery.put("strQueryId","combankingdelete");
						arrValues.add(appno);
						arrValues.add(strGradeId);
						arrValues.add("T");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",""+intupdatesize);
						hshQueryValues.put(""+intupdatesize,hshQuery);
					}
					
				}
				
				if(strAction.equals("update") || strAction.equals("delete") || strAction.trim().equals("insert"))
				{
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					intupdatesize++;
					hshQuery.put("strQueryId","comtotaldel");
					arrValues.add(appno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",""+intupdatesize);
					hshQueryValues.put(""+intupdatesize,hshQuery);
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					intupdatesize++;
					hshQuery.put("strQueryId","combanktotallimit");
					arrValues.add(appno);
					arrValues.add(appno);
					arrValues.add("Y");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",""+intupdatesize);
					hshQueryValues.put(""+intupdatesize,hshQuery);
					
					
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}
			else
			{	
				strAction="";
				String strIncurred="";
				String strTobeIncurred="";
				String strAppno="";
				String strRepay="";
				String strRowid="";
				int intUpdated=1;
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				strAction=correctNull((String)hshValues.get("hidAction"));
				strAppno=correctNull((String)hshValues.get("appno"));
				strRepay=correctNull((String)hshValues.get("txt_repay"));
				if(strAction.trim().equalsIgnoreCase("update"))
				{
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","29");
					hshQuery.put("strQueryId","costofprojectdel");
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdated),hshQuery);
					intUpdated++;
					// Loop for 28 times, since the input screen has 28 Different Rows.
					for(int i=1;i<=28;i++)
					{
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						
						strRowid=correctNull((String)hshValues.get("rowid"+i));
						strIncurred=correctNull((String)hshValues.get("txt_incurred"+i));
						strTobeIncurred=correctNull((String)hshValues.get("txt_tobeincurred"+i));
						if(i>1)
						{
							strRepay="";
						}
						if(strIncurred.trim().equalsIgnoreCase(""))
						{
							strIncurred="0.00";
						}
						if(strTobeIncurred.trim().equalsIgnoreCase(""))
						{
							strTobeIncurred="0.00";
						}
						arrValues.add(strAppno);
						arrValues.add(strRowid);
						arrValues.add(strIncurred);
						arrValues.add(strTobeIncurred);
						arrValues.add(strRepay);
						
						if(strRowid.equalsIgnoreCase("11"))
						{
							arrValues.add(correctNull((String)hshValues.get("others1")));
						}
						else if(strRowid.equalsIgnoreCase("12"))
						{
							arrValues.add(correctNull((String)hshValues.get("others2")));
						}
						else if(strRowid.equalsIgnoreCase("13"))
						{
							arrValues.add(correctNull((String)hshValues.get("others3")));
						}
						else if(strRowid.equalsIgnoreCase("14"))
						{
							arrValues.add(correctNull((String)hshValues.get("others4")));
						}
						
						
						else if(strRowid.equalsIgnoreCase("26"))
						{
							arrValues.add(correctNull((String)hshValues.get("others5")));
						}
						else if(strRowid.equalsIgnoreCase("27"))
						{
							arrValues.add(correctNull((String)hshValues.get("others6")));
						}
						else if(strRowid.equalsIgnoreCase("28"))
						{
							arrValues.add(correctNull((String)hshValues.get("others7")));
						}
						else
						{
							arrValues.add("");
						}
						
						
						hshQuery.put("arrValues",arrValues);
						hshQuery.put("strQueryId","costofprojectins");
						hshQueryValues.put(Integer.toString(intUpdated),hshQuery);
						intUpdated++;					
					}
				}
				else if(strAction.equalsIgnoreCase("delete"))
				{
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","costofprojectdel");
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
				}
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			if(!strSourcePage.trim().equalsIgnoreCase("COP"))
			{
				if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
				{
					if(correctNull((String)hshValues.get("sel_Bank")).equalsIgnoreCase("Our"))
					{
						sbAuditTrial.append("Bank Type = ").append("Our Bank");
					}
					else if(correctNull((String)hshValues.get("sel_Bank")).equalsIgnoreCase("Other"))
					{
						sbAuditTrial.append("Bank Type = ").append("Other Bank");
					}
					else
					{
						sbAuditTrial.append("Bank Type = ").append("");
					}
					sbAuditTrial.append("~Bank= ").append(correctNull((String)hshValues.get("txt_Bank")));
					if(Helper.correctNull((String)hshValues.get("sel_Type")).equalsIgnoreCase("Y"))
					{
						sbAuditTrial.append("~Under Consortium= ").append("Yes");
					}
					else if(Helper.correctNull((String)hshValues.get("sel_Type")).equalsIgnoreCase("N"))
					{
						sbAuditTrial.append("~Under Consortium= ").append("No");
					}
					else
					{
						sbAuditTrial.append("~Under Consortium= ").append("");
					}
					
					sbAuditTrial.append("~Limit (Funded Existing) = ").append(correctNull((String)hshValues.get("txt_Limit")))
					.append("~Limit (Funded  Proposed) = ").append(correctNull((String)hshValues.get("txt_OS")))
					.append("~Limit (Non-Funded Existing) = ").append(correctNull((String)hshValues.get("txt_SpreadVal")))
					.append("~Limit (Non-Funded Proposed) = ").append(correctNull((String)hshValues.get("lmtnonfundedprop")))
					.append("~Conduct of the Account =").append(correctNull((String)hshValues.get("txtarea_Remarks")));
				}
				AuditTrial.auditNewLog(hshValues,"145",appno,sbAuditTrial.toString(),sbolddata.toString());
			}
			else
			{
				String strdesc[]= {"Land","Site Development","Buildings","Imported CIF",
				"Import Duty","Indigenous","Transportation Charges","Other Fixed Assests","Tech Knowhow, Engg. Fee and Expenses"
				,"Preliminary and pre-operative Expenses",correctNull((String)hshValues.get("others1")),
				correctNull((String)hshValues.get("others2")),correctNull((String)hshValues.get("others3")),
				correctNull((String)hshValues.get("others4")),
				"Provision for Contingencies Incl. Prices escalation etc",
				"Margin for Working capital","Equity","Promoters contribution",
				"Loans","Borrowings from Promoters/ Directors. Friends and relatives","Internal Generation"
				,"Bonds / Debentures and others debt instruments","Deferred Credit from Suppliers/Bankers",
				"Venture Capital","Other Sources (Pl. specify)",correctNull((String)hshValues.get("others5"))
				,correctNull((String)hshValues.get("others6")),correctNull((String)hshValues.get("others7"))};
				int j=0;
				for(int i=1;i<=28;i++)
				{
					
					if(i<=16)
					{
						if(i==1)
						{
							sbAuditTrial
							.append("Cost of Project^");		
						}
							sbAuditTrial.append("~").append(strdesc[j]).append("^").append("~Already incurred= ")
							.append(correctNull((String)hshValues.get("txt_incurred"+i)))
							.append("~To be incurred= ").append(correctNull((String)hshValues.get("txt_tobeincurred"+i)))
							.append("~");
							
					}
					else
					{
						if(i==17)
						{
							sbAuditTrial
							.append("<br>")
							.append("Source Of Finance^");
						}
						sbAuditTrial.append("~").append(strdesc[j]).append("^").append("~Already Tied Up= ")
						.append(correctNull((String)hshValues.get("txt_incurred"+i)))
						.append("~To be Tied Up= ").append(correctNull((String)hshValues.get("txt_tobeincurred"+i)))
						;
					}
					j++;
				}
				AuditTrial.auditLog(hshValues,"147",appno,sbAuditTrial.toString());
				
			}*/
			String strBank=Helper.correctNull((String)hshValues.get("sel_Bank"));
			String strFacility="";
			if(strBank.equalsIgnoreCase("Our"))
			{
				strFacility=Helper.correctNull((String)hshValues.get("sel_Facility"));
			}
			else
			{
				strFacility=Helper.correctNull((String)hshValues.get("txt_Facility"));
			}
			String strOSAsOnDate=Helper.correctNull((String)hshValues.get("txt_OSAsOnDate"));
			String strBnkType=Helper.correctNull((String)hshValues.get("sel_BnkType"));
			String strIntType=Helper.correctNull((String)hshValues.get("sel_IntType"));
			String strCreditType=Helper.correctNull((String)hshValues.get("sel_CreditType"));
			String strSancRefNo=Helper.correctNull((String)hshValues.get("txt_SancRefNo"));
			String strSancDate=Helper.correctNull((String)hshValues.get("txt_SancDate"));
			String strDueDate=Helper.correctNull((String)hshValues.get("txt_DueDate"));
			String strArrears=Helper.correctNull((String)hshValues.get("txtArea_Arrears"));
			String strCompName=Helper.correctNull((String)hshValues.get("sel_CompName"));
			String strBankName=Helper.correctNull((String)hshValues.get("txt_Bank"));
			String strType=Helper.correctNull((String)hshValues.get("sel_Type"));
			String strLimit=Helper.correctNull((String)hshValues.get("txt_Limit"));
			String strOS=Helper.correctNull((String)hshValues.get("txt_OS"));
			String strSpreadVal=Helper.correctNull((String)hshValues.get("txt_SpreadVal"));
			String strRemarks=Helper.correctNull((String)hshValues.get("txtarea_Remarks"));
			String strFacSNo=Helper.correctNull((String)hshValues.get("hidFacSNo"));
			String strFacType="W";
			String strModuleType=Helper.correctNull((String)hshValues.get("sel_Module"));
			if(strAction.equalsIgnoreCase("insert"))
			{
				strGradeId = Integer.toString(getMaxGradeId(appno));
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","combankinginsertNEW");
				arrValues.add(appno);//0
				arrValues.add(strGradeId);//1
				arrValues.add(strFacType);//2
				arrValues.add(strFacility);//3
				//arrValues.add(strOSAsOnDate);//4
				arrValues.add(strBnkType);//5
				arrValues.add(strIntType);//6
				arrValues.add(strCreditType);//7
				arrValues.add(strSancRefNo);//8
				arrValues.add(strSancDate);//9
				arrValues.add(strDueDate);//10
				arrValues.add(strArrears);//11
				arrValues.add(strCompName);//12
				arrValues.add(strBank);//13
				arrValues.add(strBankName);//14
				arrValues.add(strType);//15
				arrValues.add(strLimit);//16
				arrValues.add(strOS);//17
				arrValues.add(strSpreadVal);//18
				arrValues.add(strRemarks);//19
				arrValues.add(strFacSNo);//20
				arrValues.add(strModuleType);//21
				arrValues.add("0");//22
				arrValues.add("");//23
				arrValues.add("");//24
				arrValues.add("");//25
				arrValues.add("");//26
				arrValues.add("");//27
				arrValues.add("");//28
				arrValues.add("");//29
				arrValues.add("");//30
				arrValues.add("");//31
				arrValues.add("");//32
				arrValues.add("");//33
				arrValues.add("");//34
				arrValues.add("");//35
				arrValues.add("");//36
				arrValues.add("");//37
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","combankingupdateNEW");
				arrValues.add(strFacility);
				//arrValues.add(strOSAsOnDate);
				arrValues.add(strBnkType);
				arrValues.add(strIntType);
				arrValues.add(strCreditType);
				arrValues.add(strSancRefNo);
				arrValues.add(strSancDate);
				arrValues.add(strDueDate);
				arrValues.add(strArrears);
				arrValues.add(strCompName);
				arrValues.add(strBank);
				arrValues.add(strBankName);
				//arrValues.add(strType);
				arrValues.add(strLimit);
				arrValues.add(strOS);
				arrValues.add(strSpreadVal);
				arrValues.add(strRemarks);
				arrValues.add(strFacSNo);
				arrValues.add(strModuleType);
				arrValues.add("0");
				arrValues.add(appno);
				arrValues.add(strGradeId);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","combankingdeleteNEW");
				arrValues.add(appno);
				arrValues.add(strGradeId);
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
	public void updateCostofData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String strGradeId = "";
		String appno=correctNull((String)hshValues.get("appno"));
		String strSourcePage="";
		StringBuilder sbAuditTrial=new StringBuilder();
		int intupdatesize=0;
		ResultSet rs=null;
		StringBuilder sbolddata=new StringBuilder();
		try
		{
			strSourcePage=correctNull((String)hshValues.get("hidPageSource"));
				{	
				strAction="";
				String strIncurred="";
				String strTobeIncurred="";
				String strAppno="";
				String strRepay="";
				String strRowid="";
				int intUpdated=1;
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				strAction=correctNull((String)hshValues.get("hidAction"));
				strAppno=correctNull((String)hshValues.get("appno"));
				strRepay=correctNull((String)hshValues.get("txt_repay"));
				if(strAction.trim().equalsIgnoreCase("update"))
				{
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","29");
					hshQuery.put("strQueryId","costofprojectdel");
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdated),hshQuery);
					intUpdated++;
					// Loop for 28 times, since the input screen has 28 Different Rows.
					for(int i=1;i<=28;i++)
					{
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						
						strRowid=correctNull((String)hshValues.get("rowid"+i));
						strIncurred=correctNull((String)hshValues.get("txt_incurred"+i));
						strTobeIncurred=correctNull((String)hshValues.get("txt_tobeincurred"+i));
						if(i>1)
						{
							strRepay="";
						}
						if(strIncurred.trim().equalsIgnoreCase(""))
						{
							strIncurred="0.00";
						}
						if(strTobeIncurred.trim().equalsIgnoreCase(""))
						{
							strTobeIncurred="0.00";
						}
						arrValues.add(strAppno);
						arrValues.add(strRowid);
						arrValues.add(strIncurred);
						arrValues.add(strTobeIncurred);
						arrValues.add(strRepay);
						
						if(strRowid.equalsIgnoreCase("11"))
						{
							arrValues.add(correctNull((String)hshValues.get("others1")));
						}
						else if(strRowid.equalsIgnoreCase("12"))
						{
							arrValues.add(correctNull((String)hshValues.get("others2")));
						}
						else if(strRowid.equalsIgnoreCase("13"))
						{
							arrValues.add(correctNull((String)hshValues.get("others3")));
						}
						else if(strRowid.equalsIgnoreCase("14"))
						{
							arrValues.add(correctNull((String)hshValues.get("others4")));
						}
						
						
						else if(strRowid.equalsIgnoreCase("26"))
						{
							arrValues.add(correctNull((String)hshValues.get("others5")));
						}
						else if(strRowid.equalsIgnoreCase("27"))
						{
							arrValues.add(correctNull((String)hshValues.get("others6")));
						}
						else if(strRowid.equalsIgnoreCase("28"))
						{
							arrValues.add(correctNull((String)hshValues.get("others7")));
						}
						else
						{
							arrValues.add("");
						}
						
						
						hshQuery.put("arrValues",arrValues);
						hshQuery.put("strQueryId","costofprojectins");
						hshQueryValues.put(Integer.toString(intUpdated),hshQuery);
						intUpdated++;					
					}
				}
				else if(strAction.equalsIgnoreCase("delete"))
				{
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","costofprojectdel");
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
				}
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			

		if(!(strAction.equalsIgnoreCase("delete")))
		{
				
				String strdesc[]= {"Land","Site Development","Buildings","Imported CIF",
				"Import Duty","Indigenous","Transportation Charges","Other Fixed Assests","Tech Knowhow, Engg. Fee and Expenses"
				,"Preliminary and pre-operative Expenses",correctNull((String)hshValues.get("others1")),
				correctNull((String)hshValues.get("others2")),correctNull((String)hshValues.get("others3")),
				correctNull((String)hshValues.get("others4")),
				"Provision for Contingencies Incl. Prices escalation etc",
				"Margin for Working capital","Equity","Promoters contribution",
				"Loans","Borrowings from Promoters/ Directors. Friends and relatives","Internal Generation"
				,"Bonds / Debentures and others debt instruments","Deferred Credit from Suppliers/Bankers",
				"Venture Capital","Other Sources (Pl. specify)",correctNull((String)hshValues.get("others5"))
				,correctNull((String)hshValues.get("others6")),correctNull((String)hshValues.get("others7"))};
				int j=0;
				for(int i=1;i<=28;i++)
				{
					
					if(i<=16)
					{
						if(i==1)
						{
							sbAuditTrial
							.append("Cost of Project^");		
						}
							sbAuditTrial.append("~").append(strdesc[j]).append("^").append("~Already incurred= ")
							.append(Helper.formatDoubleValue(Double.parseDouble((Helper.correctDouble((String)hshValues.get("txt_incurred"+i))))))
							.append("~To be incurred= ").append(Helper.formatDoubleValue(Double.parseDouble((Helper.correctDouble((String)hshValues.get("txt_tobeincurred"+i))))))
							.append("~");
							
					}
					else
					{
						if(i==17)
						{
							sbAuditTrial
							.append("<br>")
							.append("Source Of Finance^");
						}
						sbAuditTrial.append("~").append(strdesc[j]).append("^").append("~Already Tied Up= ")
						.append(Helper.formatDoubleValue(Double.parseDouble((Helper.correctDouble((String)hshValues.get("txt_incurred"+i))))))
						.append("~To be Tied Up= ").append(Helper.formatDoubleValue(Double.parseDouble((Helper.correctDouble((String)hshValues.get("txt_tobeincurred"+i))))))
						;
					}
					j++;
				}
		}
				//AuditTrial.auditLog(hshValues,"147",appno,sbAuditTrial.toString());
				
			
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
	public HashMap getTermLoanAssesment(HashMap hshValues)  
	{ 
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		ResultSet rs = null;
		ResultSet rs1 = null; 
		HashMap hshRecord = new HashMap();
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		ArrayList arrRowMOF = new ArrayList();
		int sel_facility=0;
		String recordflag="N";
		String strdescSno="";
		double dbl_BankSubLoan=0.00;
		double dbl_Othermfinance=0.00;
		double dbl_Debit=0.00;
		String strComtype = "",strQuery="";
				
		try
		{
			double dblTotalCostofProject=0,dbldata=0,dblTotalMeansofFinance=0,dblTotalCOPMOF=0;
			String appno=Helper.correctNull((String)hshValues.get("appno1"));
			String strFacilities=correctNull((String)hshValues.get("sel_facility"));
			if(appno.equalsIgnoreCase("")){
				appno=Helper.correctNull((String)hshValues.get("appno"));
			}
			if(appno.equalsIgnoreCase("") || appno.equalsIgnoreCase("null")){
				appno=Helper.correctNull((String)hshValues.get("strappno"));
			}
			String strFacilitySno=Helper.correctInt((String)hshValues.get("sel_facility"));
			
			DecimalFormat dc = new DecimalFormat();
			dc.setGroupingUsed(false);
			dc.setMaximumFractionDigits(2);
			dc.setMinimumFractionDigits(2);
			
			if (!strFacilities.trim().equals("")  && !strFacilities.equalsIgnoreCase("s"))
			{
				sel_facility=Integer.parseInt((String)hshValues.get("sel_facility"));
			}
		
			if (sel_facility>0)
			{
				rs=DBUtils.executeLAPSQuery("sel_com_copmof_desc^"+appno+"^"+sel_facility);
			}
			/*rs=DBUtils.executeLAPSQuery("sel_com_copmof^"+appno);
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("COPMOF_SNO")));//0
				arrCol.add(Helper.correctNull(rs.getString("COPMOF_TYPE")));//1
				arrCol.add(Helper.correctDouble(rs.getString("COPMOF_COSTINCURR")));//2
				arrCol.add(Helper.correctDouble(rs.getString("COPMOF_COSTTOBEINCURR")));//3
				arrCol.add(Helper.correctDouble(rs.getString("COPMOF_TOTALVALUE")));//4
				if(!(Helper.correctNull(rs.getString("COPMOF_DESC"))).equalsIgnoreCase(""))
				{	
					if (rs1 != null) 
					{
						rs1.close();					 
					}
					rs1=DBUtils.executeLAPSQuery("getstaticdatavaldispcorporate^46^"+Helper.correctNull(rs.getString("COPMOF_DESC")));
					if(rs1.next())
						arrCol.add(Helper.correctNull(rs1.getString("stat_data_corporate_desc1")));//5
					else
						arrCol.add("");//5
				}
				arrCol.add(Helper.correctNull(rs.getString("COPMOF_DESC_SNO")));//6
				arrCol.add(Helper.correctNull(rs.getString("COPMOF_DESC_TEXT")));//7
				arrCol.add(Helper.correctNull(rs.getString("COPMOF_DESC")));//8
				
				if(Helper.correctNull((String)arrCol.get(1)).equalsIgnoreCase("C"))
				{
					dblTotalCostofProject+=Double.parseDouble(Helper.correctDouble((String)rs.getString("COPMOF_TOTALVALUE")));
					arrRow.add(arrCol);
				}
				else if(Helper.correctNull((String)arrCol.get(1)).equalsIgnoreCase("M"))
				{
					dblTotalMeansofFinance+=Double.parseDouble(Helper.correctDouble((String)rs.getString("COPMOF_TOTALVALUE")));
					arrRowMOF.add(arrCol);
				}
			}
			
	
			if(rs!= null)
			{
				rs.close();
			}*/
		
			//SaravanaRaj
				arrRow = new ArrayList();
			
				if(rs!=null)
				{
				while(rs.next())
				{
					recordflag="Y";
					arrCol = new ArrayList();
					arrCol.add(Helper.correctNull(rs.getString("COM_SNO")));//0
					arrCol.add(Helper.correctNull(rs.getString("COM_TYPE")));//1
					strComtype = Helper.correctNull(rs.getString("COM_TYPE"));
					arrCol.add(Helper.correctNull(rs.getString("COM_DESC_SNO")));//2
					arrCol.add(Helper.correctNull(rs.getString("COM_DESC_TEXT")));//3
					arrCol.add(Helper.correctDouble(rs.getString("COM_COSTINCURR")));//4
					arrCol.add(Helper.correctDouble(rs.getString("COM_COSTTOBEINCURR")));//5
					arrCol.add(Helper.correctDouble(rs.getString("COM_TOTALVALUE")));//6
					dbldata=Double.parseDouble(Helper.correctDouble((String)rs.getString("COM_TOTALVALUE")));
					if(Helper.correctNull(rs.getString("COM_TYPE")).equalsIgnoreCase("C"))
					{
					rs1=DBUtils.executeLAPSQuery("getstaticdescription^"+"132"+"^"+Helper.correctDouble(rs.getString("COM_DESC_SNO")) );
					}
					else if(Helper.correctNull(rs.getString("COM_TYPE")).equalsIgnoreCase("M"))
					{
					rs1=DBUtils.executeLAPSQuery("getstaticdescription^"+"137"+"^"+Helper.correctDouble(rs.getString("COM_DESC_SNO")) );	
					}
					if(rs1.next())
					{
						arrCol.add(Helper.correctNull(rs1.getString("STAT_DATA_DESC1")));//7
						arrCol.add(Helper.correctNull(rs.getString("COM_FACSNO")));//8
					}
					else
					{
						arrCol.add("");//7
						arrCol.add(Helper.correctNull(rs.getString("COM_FACSNO")));//8
					}
					if(Helper.correctNull((String)arrCol.get(1)).equalsIgnoreCase("C"))
					{
						dblTotalCostofProject+=dbldata;
						arrRow.add(arrCol);
					}
					else if(Helper.correctNull((String)arrCol.get(1)).equalsIgnoreCase("M"))
					{
						dblTotalMeansofFinance+=Double.parseDouble(Helper.correctDouble((String)rs.getString("COM_TOTALVALUE")));
						arrRowMOF.add(arrCol);
					}
					
					
					/*dbldata=Double.parseDouble(Helper.correctDouble((String)rs.getString("COM_TOTALVALUE")));
					if(Helper.correctNull((String)arrCol.get(1)).equalsIgnoreCase("C"))
					{
						dblTotalCostofProject+=dbldata;
						arrRow.add(arrCol);
					}
					else if(Helper.correctNull((String)arrCol.get(1)).equalsIgnoreCase("M"))
					{
						dblTotalMeansofFinance+=Double.parseDouble(Helper.correctDouble((String)rs.getString("COPMOF_TOTALVALUE")));
						arrRowMOF.add(arrCol);
					}*/
					
					strdescSno=Helper.correctNull(rs.getString("COM_DESC_SNO")); //Added by ganesan for Debit:Equity should be displayed
					if((strdescSno.endsWith("1"))||(strdescSno.endsWith("2")))
					{
						if(strComtype.equalsIgnoreCase("M"))
						{
						dbl_BankSubLoan+=Double.parseDouble(Helper.correctDouble(rs.getString("COM_TOTALVALUE")));
						}
					}
					else 
					{
						if(strComtype.equalsIgnoreCase("M"))
						{
							dbl_Othermfinance+=Double.parseDouble(Helper.correctDouble(rs.getString("COM_TOTALVALUE")));
						}
						
					}
										
				}
				
				}
				if(dbl_Othermfinance!=0.0)
				{
				dbl_Debit=dbl_BankSubLoan/dbl_Othermfinance;  //Added by ganesan for Debit:Equity should be displayed
				}
				else
				{
					dbl_Debit=dbl_BankSubLoan;
				}
				dblTotalCOPMOF=dblTotalCostofProject+dblTotalMeansofFinance;
			hshRecord.put("recordflag",recordflag);	
			hshRecord.put("hshFacility",Helper.correctNull((String)hshValues.get("sel_facility")));	
			hshRecord.put("arrRow",arrRow);	
			hshRecord.put("arrRowMOF",arrRowMOF);
			hshRecord.put("TotalCostofProject",dc.format(dblTotalCostofProject));	
			hshRecord.put("TotalMeansofFinance",dc.format(dblTotalMeansofFinance));
			hshRecord.put("TotalCOPMOF",jtn.format(dblTotalCOPMOF));
			hshRecord.put("dbl_Debit",dc.format(dbl_Debit));//Added by ganesan for Debit:Equity should be displayed
			
			//added by bhaskar for COP and means of finance data
			ArrayList vecRow=new ArrayList();
			ArrayList vecCol=null;
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("SelStaticDataCorpQuestionMast^"+"132");
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString(1)));//0
				vecCol.add(correctNull(rs.getString(2)));//1
				vecCol.add(correctNull(rs.getString(3)));//2
				vecRow.add(vecCol);	
			}
			hshRecord.put("vecCopRow", vecRow);
		    vecRow=new ArrayList();
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("SelStaticDataCorpQuestionMast^"+"137");
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString(1)));//0
				vecCol.add(correctNull(rs.getString(2)));//1
				vecCol.add(correctNull(rs.getString(3)));//2
				vecRow.add(vecCol);	
			}
			hshRecord.put("vecMofRow", vecRow);	
			
			String strFinID="0",strValuesin="";
			strQuery = SQLParser.getSqlQuery("sel_financeid^" + appno);
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
				hshRecord.put("strValuesin", "Crore");
			}
			else if(strValuesin.equalsIgnoreCase("L"))
			{
				hshRecord.put("strValuesin", "Lacs");
			}else{
				hshRecord.put("strValuesin", "Rupees");
			}
		} 		
		catch (Exception e) 
		{
			throw new EJBException(e.getMessage());
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
			catch (Exception cf) 
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}		
		return hshRecord;
	}


public void updateTermLoanAssesment(HashMap hshValues)  
	{
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		ArrayList arrValues ;		 
		ResultSet rs=null;
		String strAction =correctNull((String)hshValues.get("hidAction"));
		String strSno = correctNull((String)hshValues.get("hidsno"));
		String strappno = correctNull((String)hshValues.get("appno"));
		String strsel_facility = correctNull((String)hshValues.get("sel_facility"));
		String strType = correctNull((String)hshValues.get("sel_operation"));	
		String strDesc = correctNull((String)hshValues.get("sel_description"));
		if(strDesc.equalsIgnoreCase("") || strDesc.equalsIgnoreCase("s"))
		{
			strDesc=correctNull((String)hshValues.get("sel_descriptionmof"));
		}
		String strDesctext =Helper.correctNull((String)hshValues.get("txt_description"));	
		String strIncur = Helper.correctDouble((String)hshValues.get("txt_procostinc"));	
		String strToIncur = Helper.correctDouble((String)hshValues.get("txt_procosttobeinc"));
		String strTotal = Helper.correctDouble((String)hshValues.get("txt_total"));
			
		if(strappno.equalsIgnoreCase(""))
		strappno = correctNull((String)hshValues.get("strappno"));
		try
		{ 
			if(strAction.equalsIgnoreCase("insert"))
			{
				rs=DBUtils.executeLAPSQuery("selmaxcomcopmof");
				if(rs.next())
				{
					strSno = correctNull((String)rs.getString("snomax"));
				}
				if(rs != null)
				{
					rs.close();
				}
				
				hshQuery.put("strQueryId","ins_com_copmof");
				arrValues=new ArrayList();
				arrValues.add(strSno);
				arrValues.add(strappno);
				arrValues.add(strsel_facility);	
				arrValues.add(strType);	
				arrValues.add(strDesc);
				arrValues.add(strDesctext);
				arrValues.add(strIncur);
				arrValues.add(strToIncur);
				arrValues.add(strTotal);
				hshQuery.put("arrValues",arrValues);					
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
								
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQuery.put("strQueryId","upd_com_copmof");
				arrValues=new ArrayList();
				arrValues.add(strType);	
				arrValues.add(strDesc);
				arrValues.add(strDesctext);
				arrValues.add(strIncur);
				arrValues.add(strToIncur);
				arrValues.add(strTotal);
				arrValues.add(strappno);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);					
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();				
				arrValues=new ArrayList();	
				hshQuery.put("strQueryId","del_com_copmof");		
				arrValues.add(strSno);
				arrValues.add(strappno);
				arrValues.add(strsel_facility);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				
				hshQuery=new HashMap();				
				arrValues=new ArrayList();	
				hshQuery.put("strQueryId","del_com_copmof_marginsno");		
				arrValues.add(strSno);
				arrValues.add(strappno);
				arrValues.add(strsel_facility);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				hshQueryValues.put("size","2");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
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
				 hshQuery = null;
				 hshQueryValues =null ;
				 arrValues =null;	
			}
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}		
	}
	public void updateCopMofComments(HashMap hshValues)  
	{

		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String appno=Helper.correctNull((String)hshValues.get("hidAppNo"));
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		String strType=Helper.correctNull((String)hshValues.get("PageType"));
		String strSno=Helper.correctNull((String)hshValues.get("facilitysno"));
		String strComments=Helper.correctNull((String)hshValues.get("txt_copmof"));
		try
		{
			if(strAction.equalsIgnoreCase("insert") || (strAction.equalsIgnoreCase("delete")))
			{			
				hshQuery.put("strQueryId","del_comcommentscopmof");
				arrValues=new ArrayList();
				arrValues.add(strType);
				arrValues.add(strSno);
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);					
				hshQueryValues.put("1",hshQuery);
				if(strAction.equalsIgnoreCase("insert"))
				{ 
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","ins_comcomments");
				arrValues=new ArrayList();
				arrValues.add(appno);
				arrValues.add(strType);
				arrValues.add(strComments);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);					
				hshQueryValues.put("2",hshQuery);
				hshQueryValues.put("size","2");
				}
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
		}
	}
	public HashMap getCopMofComments(HashMap hshValues) 
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery="";
		String strappno=Helper.correctNull((String)hshValues.get("hidAppNo"));
		String strType=Helper.correctNull((String)hshValues.get("PageType"));
		String strSno=Helper.correctNull((String)hshValues.get("facilitysno"));
		if(strType.equalsIgnoreCase(""))
		{
			strType = Helper.correctNull((String)hshValues.get("PageType"));
		}
		try
		{
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("sel_comcommentscopmof^"+strType+"^"+strSno+"^"+strappno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshResult.put("txt_copmof", Helper.CLOBToString(rs.getClob("com_comments")));
			}
			hshResult.put("varPageType",strType);
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getComments" + e.getMessage());
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
				throw new EJBException("Error in closing Connection "
						+ e.getMessage());
			}
		}
		return hshResult;
	}
	public void updateOthers(HashMap hshValues)
	{
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues=new ArrayList();
		
		String strComments=Helper.correctNull((String)hshValues.get("txt_termloan"));
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		String strAppno=correctNull((String)hshValues.get("appno"));
		String eco_date=correctNull((String)hshValues.get("txt_commercialdate"));
		
		try
		{
			String today_date=(String)Helper.getCurrentDateTime();
			if(strAction.equalsIgnoreCase("insert") || (strAction.equalsIgnoreCase("delete")))
			{			
				hshQuery.put("strQueryId","del_tlothers");
				arrValues=new ArrayList();
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);					
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				if(strAction.equalsIgnoreCase("insert"))
				{
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","ins_tlothers");
				arrValues=new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(eco_date);
				arrValues.add(strComments);
				arrValues.add(today_date);
				hshQuery.put("arrValues",arrValues);					
				hshQueryValues.put("2",hshQuery);
				hshQueryValues.put("size","2");
				}
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in  updateOthers method"+ e.getMessage());
		} 
	}
	public HashMap getOthers(HashMap hshValues) 
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery="";
		String strappno=Helper.correctNull((String)hshValues.get("appno"));
		try
		{
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("sel_tlothers^"+ strappno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshResult.put("com_date",Helper.correctNull(rs.getString("com_date")));
				hshResult.put("com_termloan_comments", Helper.CLOBToString(rs.getClob("com_comments")));
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getOthers" + e.getMessage());
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
				throw new EJBException("Error in closing Connection "
						+ e.getMessage());
			}
		}
		return hshResult;
	}
	public void updateSourceOfMargin(HashMap hshValues)
	{
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues=new ArrayList();
		
		String strComments=Helper.correctNull((String)hshValues.get("txt_termloan"));
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		String strAppno=correctNull((String)hshValues.get("appno"));
		String strType=Helper.correctNull((String)hshValues.get("pageType"));
		String strSno=Helper.correctNull((String)hshValues.get("sel_facility"));
		try
		{
			if(strAction.equalsIgnoreCase("insert") || (strAction.equalsIgnoreCase("delete")))
			{		
				if(strType.equalsIgnoreCase("CommentsProj"))
				{
					hshQuery.put("strQueryId","del_comcomments1");
					arrValues=new ArrayList();
					arrValues.add(strType);
					arrValues.add(strSno);
					arrValues.add(strAppno);
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_options")));
					hshQuery.put("arrValues",arrValues);					
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					if(strAction.equalsIgnoreCase("insert"))
					{
					hshQuery=new HashMap();
					hshQuery.put("strQueryId","ins_comcomments1");
					arrValues=new ArrayList();
					arrValues.add(strAppno);
					arrValues.add(strType);
					arrValues.add(strComments);
					arrValues.add(strSno);
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_options")));
					hshQuery.put("arrValues",arrValues);					
					hshQueryValues.put("2",hshQuery);
					hshQueryValues.put("size","2");
					}
				}
				else
				{
					hshQuery.put("strQueryId","del_comcomments");
					arrValues=new ArrayList();
					arrValues.add(strType);
					arrValues.add(strSno);
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);					
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					if(strAction.equalsIgnoreCase("insert"))
					{
					hshQuery=new HashMap();
					hshQuery.put("strQueryId","ins_comcomments");
					arrValues=new ArrayList();
					arrValues.add(strAppno);
					arrValues.add(strType);
					arrValues.add(strComments);
					arrValues.add(strSno);
					hshQuery.put("arrValues",arrValues);					
					hshQueryValues.put("2",hshQuery);
					hshQueryValues.put("size","2");
					}
				}
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			if((strAction.equalsIgnoreCase("insert") || (strAction.equalsIgnoreCase("delete")))&& strType.equalsIgnoreCase("CommentsProj") 
					&& Helper.correctNull((String)hshValues.get("sel_options")).equalsIgnoreCase("3"))
			{
				
				hshQueryValues=new HashMap();	
				hshQuery.put("strQueryId","delcom_machineryDet");
				arrValues=new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);					
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				if(strAction.equalsIgnoreCase("insert"))
				{
					
				hshQueryValues=new HashMap();	
				int intSize=0;
				if(hshValues.get("txt_particulars") instanceof java.lang.String)
				{
					if(!Helper.correctNull((String)hshValues.get("txt_particulars")).equalsIgnoreCase(""))
					{
						hshQuery = new HashMap();
						++intSize;
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "inscom_machineryDet");
						arrValues.add(strAppno);
						arrValues.add(String.valueOf(intSize));
						
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_particulars")));
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_name")));
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_quantity")));
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_costperunit")));
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_amttotal")));
						arrValues.add(strSno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("size", String.valueOf(intSize));
						hshQueryValues.put(String.valueOf(intSize), hshQuery);
					}
				}
				else
				{
					String[] strParticulars=(String [])hshValues.get("txt_particulars");
					String[] strSupplierName=(String [])hshValues.get("txt_name");
					String[] strQuantity=(String [])hshValues.get("txt_quantity");
					String[] strCostperUnit=(String [])hshValues.get("txt_costperunit");
					String[] strAmtTotal=(String [])hshValues.get("txt_amttotal");
					
					for(int i=0;i<strParticulars.length;i++)
					{
						if(!strParticulars[i].equalsIgnoreCase(""))
						{
							hshQuery = new HashMap();
							++intSize;
							arrValues = new ArrayList();
							hshQuery.put("strQueryId", "inscom_machineryDet");
							arrValues.add(strAppno);
							arrValues.add(String.valueOf(intSize));
							
							arrValues.add(Helper.correctNull(strParticulars[i]));
							arrValues.add(Helper.correctNull(strSupplierName[i]));
							arrValues.add(Helper.correctNull(strQuantity[i]));
							arrValues.add(Helper.correctNull(strCostperUnit[i]));
							arrValues.add(Helper.correctNull(strAmtTotal[i]));
							arrValues.add(strSno);
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", String.valueOf(intSize));
							hshQueryValues.put(String.valueOf(intSize), hshQuery);
						}
					}
				}
				if(intSize>0)
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
				}
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in UpdateAssessmentoflimit" + e.getMessage());
		} 
	}
	
	public HashMap getSourceOfMargin(HashMap hshValues) 
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery="";
		String strappno=Helper.correctNull((String)hshValues.get("appno"));
		String strType=Helper.correctNull((String)hshValues.get("pageType"));
		String strFacilities=correctNull((String)hshValues.get("sel_facility"));	
		String strOptionVal=Helper.correctInt((String)hshValues.get("sel_options"));
		if(strType.equalsIgnoreCase(""))
		{
			strType=Helper.correctNull((String)hshValues.get("hidPageSource"));
		}
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		
		try
		{
			if(rs!=null)
			{
				rs.close();
			}
			if (!strFacilities.trim().equals("")  && !strFacilities.equalsIgnoreCase("s")&& !strType.equalsIgnoreCase(""))
			{
				if(strType.equalsIgnoreCase("CommentsProj"))
				{
					strQuery=SQLParser.getSqlQuery("sel_comcomments1^"+strType+"^"+strFacilities+"^"+strappno+"^"+strOptionVal);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) 
					{
						hshResult.put("com_termloan_comments", Helper.CLOBToString(rs.getClob("com_comments")));
					}
					
					
					
					if(strOptionVal.equalsIgnoreCase("3"))
					{
						if(rs!=null)
							rs.close();
						
						strQuery=SQLParser.getSqlQuery("selcom_machineryDet^"+strappno+"^"+strFacilities);
						rs = DBUtils.executeQuery(strQuery);
						while (rs.next()) 
						{
							arrCol=new ArrayList();
							arrCol.add(Helper.correctNull(rs.getString("COM_particulars")));
							arrCol.add(Helper.correctNull(rs.getString("COM_supplier")));
							arrCol.add(Helper.correctNull(rs.getString("COM_quantity")));
							arrCol.add(Helper.correctNull(rs.getString("COM_unitpercost")));
							arrCol.add(Helper.correctNull(rs.getString("COM_amount")));
							arrRow.add(arrCol);
						}
						hshResult.put("arrRow",arrRow);
						
					}
				}
				else
				{
					strQuery=SQLParser.getSqlQuery("sel_comcomments^"+strType+"^"+strFacilities+"^"+strappno);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) 
					{
						hshResult.put("com_termloan_comments", Helper.CLOBToString(rs.getClob("com_comments")));
					}
				}
			}
			hshResult.put("hshFacility",Helper.correctNull((String)hshValues.get("sel_facility")));
			hshResult.put("hshOptionVal",Helper.correctNull((String)hshValues.get("sel_options")));
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getComments" + e.getMessage());
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
				throw new EJBException("Error in closing Connection "
						+ e.getMessage());
			}
		}
		return hshResult;
	}
	public void updateReleasePattern(HashMap hshValues)
	{
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		ArrayList arrValues ;		 
		ResultSet rs=null;
		String strAction =correctNull((String)hshValues.get("hidAction"));
		String strappno = correctNull((String)hshValues.get("appno"));
	//	String strDescSno = correctNull((String)hshValues.get("hiddescsno"));
		String strsel_facility = correctNull((String)hshValues.get("sel_facility"));
	
		String strDescSno[]=null;
		String strTotalamt[]=null;
		String strMargn[]=null;
		String strMarginamt[]=null;
		String strBankloan[]=null;
		String strBankloanamt[]=null;
		String strCOPMOFSno[]=null;
		
		//ADDED BY BHASKAR TO check string or string array
		 if(hshValues.get("hiddescsno") instanceof java.lang.String)
		 {
			 strDescSno=new String[1];
			 strDescSno[0]=Helper.correctNull((String)hshValues.get("hiddescsno"));
		 }
		 else
		 {
			 strDescSno=((String[])hshValues.get("hiddescsno"));
		 }		
		
		 if(hshValues.get("hidtotal") instanceof java.lang.String)
		 {
			 strTotalamt=new String[1];
			 strTotalamt[0]=Helper.correctNull((String)hshValues.get("hidtotal"));
		 }
		 else
		 {
			 strTotalamt=((String[])hshValues.get("hidtotal"));
		 }	
		 

		 if(hshValues.get("txt_margin") instanceof java.lang.String)
		 {
			 strMargn=new String[1];
			 strMargn[0]=Helper.correctNull((String)hshValues.get("txt_margin"));
		 }
		 else
		 {
			 strMargn= ((String[])hshValues.get("txt_margin"));
		 }	
		 
		 if(hshValues.get("txt_marginamt") instanceof java.lang.String)
		 {
			 strMarginamt=new String[1];
			 strMarginamt[0]=Helper.correctNull((String)hshValues.get("txt_marginamt"));
		 }
		 else
		 {
			 strMarginamt= ((String[])hshValues.get("txt_marginamt"));
		 }		 
		 if(hshValues.get("txt_bankloan") instanceof java.lang.String)
		 {
			 strBankloan=new String[1];
			 strBankloan[0]=Helper.correctNull((String)hshValues.get("txt_bankloan"));
		 }
		 else
		 {
			 strBankloan= ((String[])hshValues.get("txt_bankloan"));
		 }
		 
		 if(hshValues.get("txt_bankloanamt") instanceof java.lang.String)
		 {
				strBankloanamt=new String[1];
				strBankloanamt[0]=Helper.correctNull((String)hshValues.get("txt_bankloanamt"));
		 }
		 else
		 {
				strBankloanamt=((String[])hshValues.get("txt_bankloanamt"));
		 }
		 
		 if(hshValues.get("hidcopmofsno") instanceof java.lang.String)
		 {
			 strCOPMOFSno=new String[1];
			 strCOPMOFSno[0]=Helper.correctNull((String)hshValues.get("hidcopmofsno"));
		 }
		 else
		 {
			 strCOPMOFSno= ((String[])hshValues.get("hidcopmofsno"));
		 }	
		 //ended

		
		int size=strDescSno.length;
		if(strappno.equalsIgnoreCase(""))
		strappno = correctNull((String)hshValues.get("strappno"));
		try
		{ 
			if(strAction.equalsIgnoreCase("insert"))
			{
				
				
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();				
				arrValues=new ArrayList();	
				hshQuery.put("strQueryId","del_com_copmof_margin");		
				arrValues.add(strappno);
				arrValues.add(strsel_facility);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("size","1");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				
				for(int i=0;i<size;i++)
				{
				hshQuery.put("strQueryId","ins_com_copmof_margin");
				arrValues=new ArrayList();
				arrValues.add(strappno);
				arrValues.add(strsel_facility);
				arrValues.add(strDescSno[i]);
				arrValues.add(strTotalamt[i]);
				arrValues.add(strMargn[i]);
				arrValues.add(strMarginamt[i]);
				arrValues.add(strBankloan[i]);
				arrValues.add(strBankloanamt[i]);
				arrValues.add(strCOPMOFSno[i]);
				hshQuery.put("arrValues",arrValues);					
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
								
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQuery.put("strQueryId","upd_com_copmof_margin");
				arrValues=new ArrayList();
				arrValues.add(strsel_facility);
				arrValues.add(strDescSno);
				arrValues.add(strMargn);
				arrValues.add(strMarginamt);
				arrValues.add(strBankloan);
				arrValues.add(strBankloanamt);
								
				arrValues.add(strappno);
				
				hshQuery.put("arrValues",arrValues);					
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();				
				arrValues=new ArrayList();	
				hshQuery.put("strQueryId","del_com_copmof_margin");		
				arrValues.add(strappno);
				arrValues.add(strsel_facility);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("size","1");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
			//throw new EJBException(e.getMessage());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
				 hshQuery = null;
				 hshQueryValues =null ;
				 arrValues =null;	
			}
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}	
	}
	public HashMap getReleasePattern(HashMap hshValues) 
	{
		 
		ResultSet rs = null;
		ResultSet rs1 = null; 
		HashMap hshRecord = new HashMap();
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		ArrayList arrRowMOF = new ArrayList();
		int sel_facility=0;
		String strFacilitySno="";
		try
		{
			double dblTotalCostofProject=0,dbldata=0;
			String appno=Helper.correctNull((String)hshValues.get("appno1"));
			String strFacilities=correctNull((String)hshValues.get("sel_facility"));
			if(appno.equalsIgnoreCase("")){
				appno=Helper.correctNull((String)hshValues.get("appno"));
			}
			if(appno.equalsIgnoreCase("") || appno.equalsIgnoreCase("null")){
				appno=Helper.correctNull((String)hshValues.get("strappno"));
			}
			if(!strFacilities.equalsIgnoreCase("") && !strFacilities.equalsIgnoreCase("s"))
			{
			strFacilitySno=Helper.correctInt((String)hshValues.get("sel_facility"));
			}
			
			DecimalFormat dc = new DecimalFormat();
			dc.setGroupingUsed(false);
			dc.setMaximumFractionDigits(2);
			dc.setMinimumFractionDigits(2);
			
			if (!strFacilities.trim().equals("")  && !strFacilities.equalsIgnoreCase("s"))
			{
				sel_facility=Integer.parseInt((String)hshValues.get("sel_facility"));
			}
		
			if (sel_facility>0)
			{
				rs=DBUtils.executeLAPSQuery("sel_com_copmof_margin^"+appno+"^"+sel_facility+"^"+"132");
			}
				arrRow = new ArrayList();
		        
				if(rs!=null)
				{				
				while(rs.next())
				{
					arrCol = new ArrayList();
					
					arrCol.add(Helper.correctNull(rs.getString("COM_DESC_TEXT")));//0
					arrCol.add(Helper.correctDouble(rs.getString("COM_TOTALVALUE")));//1
					arrCol.add(Helper.correctDouble(rs.getString("COM_DESC_SNO")));//2
					dbldata=Double.parseDouble(Helper.correctDouble((String)rs.getString("COM_TOTALVALUE")));
					arrCol.add(Helper.correctNull(rs.getString("desc1")));//3
					rs1=DBUtils.executeLAPSQuery("sel_com_copmof_margin1^"+appno+"^"+sel_facility+"^"+Helper.correctNull(rs.getString("COM_SNO")));
					if(rs1.next())
					{
						arrCol.add(Helper.correctNull(rs1.getString("COM_MARGIN")));//4
						arrCol.add(Helper.correctNull(rs1.getString("COM_MARGINAMT")));//5
						arrCol.add(Helper.correctNull(rs1.getString("COM_BANKLOAN")));//6
						arrCol.add(Helper.correctNull(rs1.getString("COM_BANKLOANAMT")));//7
					}
					else
					{
						arrCol.add("");//4
						arrCol.add("0.00");//5
						arrCol.add("0.00");//6
						arrCol.add("0.00");//7					
					}	
					arrCol.add(Helper.correctDouble(rs.getString("COM_SNO")));//8		
					arrRow.add(arrCol);
					dblTotalCostofProject+=dbldata;
						
						
				}	
				}
			hshRecord.put("com_appno",appno);		
			hshRecord.put("hshFacility",Helper.correctNull((String)hshValues.get("sel_facility")));	
			hshRecord.put("arrRow",arrRow);	
			hshRecord.put("arrRowMOF",arrRowMOF);
			hshRecord.put("TotalCostofProject",dc.format(dblTotalCostofProject));
			
			String strFinID="0",strValuesin="",strQuery="";
			strQuery = SQLParser.getSqlQuery("sel_financeid^" + appno);
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
				hshRecord.put("strValuesin", "Crore");
			}
			else if(strValuesin.equalsIgnoreCase("L"))
			{
				hshRecord.put("strValuesin", "Lacs");
			}else{
				hshRecord.put("strValuesin", "Rupees");
			}
			
		} 		
		catch (Exception e) 
		{
			throw new EJBException(e.getMessage());
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
			catch (Exception cf) 
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}		
		return hshRecord;
	}	
	public void updateBankingdetailsData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String appno=correctNull((String)hshValues.get("appno"));
		String strSourcePage="";
		StringBuilder sbAuditTrial=new StringBuilder();
		ResultSet rs=null;
		StringBuilder sbolddata=new StringBuilder();
		try
		{
			
			String strAssetclass=Helper.correctNull((String)hshValues.get("sel_assetclass"));
			String strWhetsuit=Helper.correctNull((String)hshValues.get("sel_whetsuit"));
			String strActionComment=Helper.correctNull((String)hshValues.get("txt_actioncomment"));
			String strArrearComment=Helper.correctNull((String)hshValues.get("txt_arrearcmt"));
			
		
	 if(strAction.equalsIgnoreCase("update"))
			{

				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_combankingdetails");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","ins_combankingdetails");
				arrValues.add(appno);
				arrValues.add(strAssetclass);
				arrValues.add(strWhetsuit);
				
				if(strWhetsuit.equalsIgnoreCase("Y")){
				arrValues.add(strActionComment);
				}
				else
				{
					arrValues.add("");
				}
				arrValues.add(strArrearComment);
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_assdate")));//added by ganesan date 
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_combankingdetails");
				arrValues.add(appno);
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
	
	public  HashMap getBankingdetailsData(HashMap hshValues) 
	{
		ResultSet rs = null;
		String strQuery="";
		String strcomapp_id="";
		ResultSet rs1 = null;
	    HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecVal=new ArrayList();
		String strSourcePage="";
		boolean recordflag=false;
		String strQuery1="";
		try
		{
			
				String appno=correctNull((String)hshValues.get("appno"));
				strQuery = SQLParser.getSqlQuery("sel_combankingdetails^"+appno);
				if(rs!=null)
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("COM_ASSETCLASS",correctNull(rs.getString("COM_ASSETCLASS")));
					hshRecord.put("COM_WHTRSUIT",correctNull(rs.getString("COM_WHTRSUIT")));
					hshRecord.put("COM_ACTIONCMT",correctNull(rs.getString("COM_ACTIONCMT")));
					hshRecord.put("COM_ARREARCMT",Helper.CLOBToString(rs.getClob("COM_ARREARCMT")));
					hshRecord.put("com_asscladate",Helper.correctNull(rs.getString("com_asscladate")));//added by ganesan
					
				}
				
				//Added by Amaravathi for Consortium Tab
				if(rs!=null){rs.close();}
				rs = DBUtils.executeLAPSQuery("sel_BAConsVal^"+appno);
				if(rs.next())
				{
					hshRecord.put("com_tl_bnkarg",correctNull(rs.getString("com_tl_bnkarg")));
					hshRecord.put("com_tl_type",correctNull(rs.getString("com_tl_type")));
					hshRecord.put("com_wc_bnkarg",correctNull(rs.getString("com_wc_bnkarg")));
					hshRecord.put("com_wc_type",correctNull(rs.getString("com_wc_type")));
				}
				//End
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
	
	/** Added by vinoth kumar for Breif Details of the project under Termloan Assessment*/
	
	public void updateBreifDetailOfProject(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String appno=correctNull((String)hshValues.get("appno"));
		String strFacilities=correctNull((String)hshValues.get("sel_facility"));
		String strPageVal="BreifDetaisTL";
		String comments=(String)hshValues.get("txt_comments");		
		String commdate=(String)hshValues.get("txt_commercialdate");
		String strDACCOdate=(String)hshValues.get("txt_actualcommercialdate");
		String strProjectLoan=(String)hshValues.get("sel_projectloan");
		
		ResultSet rs=null;		
		try
		{
	        if(strAction.equalsIgnoreCase("insert"))
			{

				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_management");
				arrValues.add(strPageVal);
				arrValues.add(strFacilities);
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","ins_managementnew");
				arrValues.add(appno);
				arrValues.add(strFacilities);				
				arrValues.add(comments);
				arrValues.add(strPageVal);
				arrValues.add(commdate);
				arrValues.add(strProjectLoan);
				arrValues.add(strDACCOdate);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_management");
				arrValues.add(strPageVal);
				arrValues.add(strFacilities);
				arrValues.add(appno);
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
	
	public HashMap getBreifDetailOfProject(HashMap hshValues) 
	{
		ResultSet rs = null;
		ResultSet rs1 = null; 
		HashMap hshRecord = new HashMap();		
		int sel_facility=0;
		try
		{			
			String appno=Helper.correctNull((String)hshValues.get("appno1"));
			String strFacilities=correctNull((String)hshValues.get("sel_facility"));			
			String strPageVal = "BreifDetaisTL";
			
			if(appno.equalsIgnoreCase(""))
			{
				appno=Helper.correctNull((String)hshValues.get("appno"));
			}
			if(appno.equalsIgnoreCase("") || appno.equalsIgnoreCase("null")){
				appno=Helper.correctNull((String)hshValues.get("strappno"));
			}	
			
			if (!strFacilities.trim().equals("")  && !strFacilities.equalsIgnoreCase("s"))
			{
				rs=DBUtils.executeLAPSQuery("sel_management^"+strPageVal+"^"+strFacilities+"^"+appno);
				if(rs.next())
				{
					hshRecord.put("COM_COMMENTS",Helper.CLOBToString(rs.getClob("COM_COMMENTS")));	
					hshRecord.put("COM_DATE",Helper.correctNull((String)rs.getString("COM_DATE")));	
					hshRecord.put("com_projectloan",Helper.correctNull((String)rs.getString("com_projectloan")));	
					hshRecord.put("com_daccodate",Helper.correctNull((String)rs.getString("com_daccodate")));	
				}
			}								
			if(rs!=null)
			{				
				rs.close();
			}
			hshRecord.put("com_appno",appno);		
			hshRecord.put("hshFacility",Helper.correctNull((String)hshValues.get("sel_facility")));		
			hshRecord.put("strEditFlag","N");
			String strQueryPS = SQLParser.getSqlQuery("sel_postsanctiondet^"+strFacilities+"^"+appno);
			ResultSet rsPS = DBUtils.executeQuery(strQueryPS);
			if(rsPS.next())
			{
				hshRecord.put("strPostSancParam", Helper.correctNull(rsPS.getString("PS_MODIFY_TERMS")));
				hshRecord.put("strEditFlag","Y");
			}
		} 		
		catch (Exception e) 
		{
			throw new EJBException(e.getMessage());
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
			catch (Exception cf) 
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}		
		return hshRecord;
	}	
	public void UpdateBankingArrangement(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String appno=correctNull((String)hshValues.get("appno"));
		String strQuery="",strWCbnkarg="",strTLbnkarg="",strWCtype="",strTLtype="";
		ResultSet rs = null;
		int intUpdatesize=0;
		try
		{
			strQuery = SQLParser.getSqlQuery("sel_BankingArrangement^"+appno);
			if(rs!=null)
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strWCbnkarg = Helper.correctNull(rs.getString("com_wc_bnkarg"));
				strTLbnkarg = Helper.correctNull(rs.getString("com_tl_bnkarg"));
				
				strWCtype = Helper.correctNull(rs.getString("com_wc_type"));
				strTLtype = Helper.correctNull(rs.getString("com_tl_type"));
				
			}
			
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("delete"))
			{
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId", "del_BankingArrangment");
			arrValues.add(appno);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			hshQueryValues=new HashMap();
			 if(strAction.equalsIgnoreCase("insert"))
				{
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","ins_BankingArrangment");
					arrValues.add(appno);
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_bnk_arg")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_bnk_type")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_no_consortium")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_bnk_arg_TL")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_bnk_type_TL")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_no_consortium_TL")));
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_Type")));
					
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				
			
				if((strWCbnkarg.equalsIgnoreCase("M") && !Helper.correctNull((String)hshValues.get("txt_bnk_arg")).equalsIgnoreCase("M")) ||
				   (strWCbnkarg.equalsIgnoreCase("S") && !Helper.correctNull((String)hshValues.get("txt_bnk_arg")).equalsIgnoreCase("S")) ||
				   (strWCbnkarg.equalsIgnoreCase("C") && !Helper.correctNull((String)hshValues.get("txt_bnk_arg")).equalsIgnoreCase("C")) ||
				   (strTLbnkarg.equalsIgnoreCase("M") && !Helper.correctNull((String)hshValues.get("txt_bnk_arg_TL")).equalsIgnoreCase("M")) ||
				   (strTLbnkarg.equalsIgnoreCase("S") && !Helper.correctNull((String)hshValues.get("txt_bnk_arg_TL")).equalsIgnoreCase("S"))||
				   (strTLbnkarg.equalsIgnoreCase("C") && !Helper.correctNull((String)hshValues.get("txt_bnk_arg_TL")).equalsIgnoreCase("C"))||
				   (strWCbnkarg.equalsIgnoreCase("C") && strWCtype.equalsIgnoreCase("S") && !Helper.correctNull((String)hshValues.get("txt_bnk_type")).equalsIgnoreCase("S"))||
				   (strWCbnkarg.equalsIgnoreCase("C") && strWCtype.equalsIgnoreCase("M") && !Helper.correctNull((String)hshValues.get("txt_bnk_type")).equalsIgnoreCase("M"))||
				   (strTLbnkarg.equalsIgnoreCase("C") && strTLtype.equalsIgnoreCase("S") && !Helper.correctNull((String)hshValues.get("txt_bnk_type_TL")).equalsIgnoreCase("S"))||
				   (strTLbnkarg.equalsIgnoreCase("C") && strTLtype.equalsIgnoreCase("M") && !Helper.correctNull((String)hshValues.get("txt_bnk_type_TL")).equalsIgnoreCase("M"))
				)

				{
					
					if((strWCbnkarg.equalsIgnoreCase("M") && !Helper.correctNull((String)hshValues.get("txt_bnk_arg")).equalsIgnoreCase("M")) ||
							(strWCbnkarg.equalsIgnoreCase("S") && !Helper.correctNull((String)hshValues.get("txt_bnk_arg")).equalsIgnoreCase("S"))||
							   (strWCbnkarg.equalsIgnoreCase("C") && !Helper.correctNull((String)hshValues.get("txt_bnk_arg")).equalsIgnoreCase("C"))||
							   (strWCbnkarg.equalsIgnoreCase("C") && strWCtype.equalsIgnoreCase("S") && !Helper.correctNull((String)hshValues.get("txt_bnk_type")).equalsIgnoreCase("S"))||
							   (strWCbnkarg.equalsIgnoreCase("C") && strWCtype.equalsIgnoreCase("M") && !Helper.correctNull((String)hshValues.get("txt_bnk_type")).equalsIgnoreCase("M"))
							   )

					{
						intUpdatesize++;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId", "del_revBAConsortium");
						arrValues.add(appno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						intUpdatesize++;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId", "del_BAConsortiumLeadpropdelete");
						arrValues.add(appno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

					}
					if((strTLbnkarg.equalsIgnoreCase("M") && !Helper.correctNull((String)hshValues.get("txt_bnk_arg_TL")).equalsIgnoreCase("M")) ||
					   (strTLbnkarg.equalsIgnoreCase("S") && !Helper.correctNull((String)hshValues.get("txt_bnk_arg_TL")).equalsIgnoreCase("S"))||
						   (strTLbnkarg.equalsIgnoreCase("C") && !Helper.correctNull((String)hshValues.get("txt_bnk_arg_TL")).equalsIgnoreCase("C"))||
						   (strTLbnkarg.equalsIgnoreCase("C") && strTLtype.equalsIgnoreCase("S") && !Helper.correctNull((String)hshValues.get("txt_bnk_type_TL")).equalsIgnoreCase("S"))||
						   (strTLbnkarg.equalsIgnoreCase("C") && strTLtype.equalsIgnoreCase("M") && !Helper.correctNull((String)hshValues.get("txt_bnk_type_TL")).equalsIgnoreCase("M")))

					{
						intUpdatesize++;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId", "del_revBAConsortium_tl");
						arrValues.add(appno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						intUpdatesize++;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId", "del_BAConsortiumLeadpropdelete_tl");
						arrValues.add(appno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

					}
					
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

					/*hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size", "2");
					hshQuery.put("strQueryId", "upd_proposalnotecheck");
					arrValues.add("N");
					arrValues.add("N");
					arrValues.add(appno);
					if((strWCbnkarg.equalsIgnoreCase("M") && !Helper.correctNull((String)hshValues.get("txt_bnk_arg")).equalsIgnoreCase("M")) ||
					   (strWCbnkarg.equalsIgnoreCase("S") && !Helper.correctNull((String)hshValues.get("txt_bnk_arg")).equalsIgnoreCase("S")))
					{
						arrValues.add("WC");
					}
					if((strTLbnkarg.equalsIgnoreCase("M") && !Helper.correctNull((String)hshValues.get("txt_bnk_arg_TL")).equalsIgnoreCase("M")) ||
					   (strTLbnkarg.equalsIgnoreCase("S") && !Helper.correctNull((String)hshValues.get("txt_bnk_arg_TL")).equalsIgnoreCase("S")))
					{
						arrValues.add("TL");
					}
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("2", hshQuery);
					*/
					
					if((strWCbnkarg.equalsIgnoreCase("S") && !Helper.correctNull((String)hshValues.get("txt_bnk_arg")).equalsIgnoreCase("S")) ||
					   (strTLbnkarg.equalsIgnoreCase("S") && !Helper.correctNull((String)hshValues.get("txt_bnk_arg_TL")).equalsIgnoreCase("S")))
					{
						hshQueryValues = new HashMap();
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						hshQueryValues.put("size", "1");
						hshQuery.put("strQueryId", "del_revMultipleBanking");
						arrValues.add(appno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("1", hshQuery);
						
						/*hshQuery = new HashMap();
						arrValues=new ArrayList();
						hshQueryValues.put("size", "2");
						hshQuery.put("strQueryId", "upd_proposalnotecheck");
						arrValues.add("N");
						arrValues.add("N");
						arrValues.add(appno);
						arrValues.add("MB");
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("2", hshQuery);
						*/
						
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
				}
				
				if(strAction.equalsIgnoreCase("delete"))
				{
					intUpdatesize++;
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "del_revBAConsortium_tl");
					arrValues.add(appno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					
					intUpdatesize++;
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "del_BAConsortiumLeadpropdelete_tl");
					arrValues.add(appno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					
					intUpdatesize++;
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "del_revBAConsortium");
					arrValues.add(appno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					
					intUpdatesize++;
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "del_BAConsortiumLeadpropdelete");
					arrValues.add(appno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

				}
		}
		catch(Exception ex)
		{
			throw new EJBException("Error in UpdateBankingArrangement" + ex.getMessage());
		}
	}
	public HashMap getBankingArrangement(HashMap hshValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();		
		String strQuery="";
	try
	{
		String appno=correctNull((String)hshValues.get("appno"));
		strQuery = SQLParser.getSqlQuery("sel_BankingArrangement^"+appno);
		if(rs!=null)
		{
			rs.close();
		}
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			hshRecord.put("com_wc_bnkarg",correctNull(rs.getString("com_wc_bnkarg")));
			hshRecord.put("com_wc_type",correctNull(rs.getString("com_wc_type")));
			hshRecord.put("com_wc_no",correctNull(rs.getString("com_wc_no")));
			hshRecord.put("com_tl_bnkarg",Helper.correctNull(rs.getString("com_tl_bnkarg")));
			hshRecord.put("com_tl_type",Helper.correctNull(rs.getString("com_tl_type")));
			hshRecord.put("com_tl_no",Helper.correctNull(rs.getString("com_tl_no")));
			hshRecord.put("com_ba_type",Helper.correctNull(rs.getString("com_ba_type")));
		}
		else
		{
			hshRecord.put("com_wc_bnkarg","0");
			hshRecord.put("com_wc_type","0");
			hshRecord.put("com_wc_no","0");
			hshRecord.put("com_tl_bnkarg","0");
			hshRecord.put("com_tl_type","0");
			hshRecord.put("com_tl_no","0");
			hshRecord.put("com_ba_type","S");
		}
		
		//Added by Amaravathi for Consortium Tab
		if(rs!=null){rs.close();}
		rs = DBUtils.executeLAPSQuery("sel_BAConsVal^"+appno);
		if(rs.next())
		{
			hshRecord.put("com_tl_bnkarg1",correctNull(rs.getString("com_tl_bnkarg")));
			hshRecord.put("com_tl_type1",correctNull(rs.getString("com_tl_type")));
			hshRecord.put("com_wc_bnkarg1",correctNull(rs.getString("com_wc_bnkarg")));
			hshRecord.put("com_wc_type1",correctNull(rs.getString("com_wc_type")));
		}
		//End
		
		if(rs!=null){
			rs.close();
		}
		String bankingarrangement="N";
		strQuery = SQLParser.getSqlQuery("sel_bankarrangemarrentchk^"+appno);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next()){
			bankingarrangement="Y";
			
		}
		
		
		hshRecord.put("bankingarrangement", bankingarrangement);
		
	}
	catch(Exception ex)
	{
		throw new EJBException("Error in getBankingArrangement" + ex.getMessage());
	}
		return hshRecord;
	}
	public void UpdateMultipleBaking(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		ResultSet rs=null,rs1=null;
		String Sno="",strQuery="",ConsType="";
		int Size=1;
		double FbSum=0.00,NfbSum=0.00,ExistSum=0.00,ProFbSum=0.00,ProNfbSum=0.00,ProSum=0.00;
		try
		{
			String appno=correctNull((String)hshValues.get("appno"));
			if(strAction.equalsIgnoreCase("insert")){
				strQuery = SQLParser.getSqlQuery("sel_com_multipleBankingSno^"+appno);
				if(rs!=null)
				{	rs.close();		}
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					Sno=Helper.correctInt((String)rs.getString("Com_Sno"));
//					if(Sno.equalsIgnoreCase("0")){Sno="1";}
				}
				if(rs!=null)
				{	rs.close();	}
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "ins_MultipleBanking");
				arrValues.add(appno);
				arrValues.add(Sno);
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_bankName")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_existFb")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_existFbExpo")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_existNfb")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_existNfbExpo")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_existTot")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_existTotExpo")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_PropFb")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_PropFbExpo")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_PropNfb")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_PropNfbExpo")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_PropTot")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_PropTotExpo")));
				if(correctNull((String)hshValues.get("sel_ConsType")).equals(""))
				{
					arrValues.add("1");
				}
				else
				{
					arrValues.add(correctNull((String)hshValues.get("sel_ConsType")));
				}
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", ""+Size);
				hshQueryValues.put(""+Size, hshQuery);
				
				/*Size++;
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId", "del_com_proposalNoteCheck");
				arrValues.add(appno);
				arrValues.add("MB");//page name-  multiple banking
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", ""+Size);
				hshQueryValues.put(""+Size, hshQuery);
				
				Size++;
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId", "ins_com_proposalNoteCheck");
				arrValues.add(appno);
				arrValues.add("MB");//page name-  multiple banking
				String proposalNoteCheck=Helper.correctNull((String)hshValues.get("proposalNote"));
				if(proposalNoteCheck.equalsIgnoreCase("on")){proposalNoteCheck="Y";}
				else{proposalNoteCheck="N";}
				arrValues.add(proposalNoteCheck);
				String AnnexureCheck=Helper.correctNull((String)hshValues.get("Annexure3"));
				if(AnnexureCheck.equalsIgnoreCase("on")){AnnexureCheck="Y";}
				else{AnnexureCheck="N";}
				arrValues.add(AnnexureCheck);
				hshQuery.put("arrValues", arrValues);
				
				hshQueryValues.put("size", ""+Size);
				hshQueryValues.put(""+Size, hshQuery);
				*/
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				Sno=Helper.correctInt((String)hshValues.get("hid_sno"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", ""+Size);
				hshQuery.put("strQueryId", "upd_com_multipleBanking");
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_bankName")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_existFb")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_existFbExpo")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_existNfb")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_existNfbExpo")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_existTot")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_existTotExpo")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_PropFb")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_PropFbExpo")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_PropNfb")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_PropNfbExpo")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_PropTot")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_PropTotExpo")));
				arrValues.add(appno);
				arrValues.add(Sno);
				if(correctNull((String)hshValues.get("sel_ConsType")).equals(""))
				{
					arrValues.add("1");
				}
				else
				{
					arrValues.add(correctNull((String)hshValues.get("sel_ConsType")));
				}
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(""+Size, hshQuery);
				
				/*Size++;
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId", "del_com_proposalNoteCheck");
				arrValues.add(appno);
				arrValues.add("MB");//page name-  multiple banking
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", ""+Size);
				hshQueryValues.put(""+Size, hshQuery);
				Size++;
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId", "ins_com_proposalNoteCheck");
				arrValues.add(appno);
				arrValues.add("MB");//page name-  multiple banking
				String proposalNoteCheck=Helper.correctNull((String)hshValues.get("proposalNote"));
				if(proposalNoteCheck.equalsIgnoreCase("on")){proposalNoteCheck="Y";}
				else{proposalNoteCheck="N";}
				arrValues.add(proposalNoteCheck);
				String AnnexureCheck=Helper.correctNull((String)hshValues.get("Annexure3"));
				if(AnnexureCheck.equalsIgnoreCase("on")){AnnexureCheck="Y";}
				else{AnnexureCheck="N";}
				arrValues.add(AnnexureCheck);
				hshQuery.put("arrValues", arrValues);
				
				hshQueryValues.put("size", ""+Size);
				hshQueryValues.put(""+Size, hshQuery);
				*/
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				Sno=Helper.correctInt((String)hshValues.get("hid_sno"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "del_multipleBanking");
				arrValues.add(appno);
				arrValues.add(Sno);
				if(correctNull((String)hshValues.get("sel_ConsType")).equals(""))
				{
					arrValues.add("1");
				}
				else
				{
					arrValues.add(correctNull((String)hshValues.get("sel_ConsType")));
				}
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",""+Size);
				hshQueryValues.put(""+Size, hshQuery);
				
				/*Size++;
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId", "del_com_proposalNoteCheck");
				arrValues.add(appno);
				arrValues.add("MB");//page name-  multiple banking
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",""+Size );
				hshQueryValues.put(""+Size, hshQuery);
				*/
			}
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			Size=0;
			if(correctNull((String)hshValues.get("sel_ConsType")).equals(""))
			{
				ConsType="1";
			}
			else
			{
				ConsType = correctNull((String)hshValues.get("sel_ConsType"));
			}
			if(rs!=null){rs.close();}
			strQuery = SQLParser.getSqlQuery("sel_SumMultipleBanking^"+appno+"^"+ConsType);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				FbSum=Double.parseDouble(Helper.correctDouble((String)rs.getString("FbSum")));
				NfbSum=Double.parseDouble(Helper.correctDouble((String)rs.getString("NfbSum")));
				ExistSum =Double.parseDouble(Helper.correctDouble((String)rs.getString("ExistSum")));
				ProFbSum=Double.parseDouble(Helper.correctDouble((String)rs.getString("ProFbSum")));
				ProNfbSum=Double.parseDouble(Helper.correctDouble((String)rs.getString("ProNfbSum")));
				ProSum=Double.parseDouble(Helper.correctDouble((String)rs.getString("ProSum")));
			}
			else
			{
			FbSum=1;
			NfbSum=1;
			ExistSum =1;
			ProFbSum=1;
			ProNfbSum=1;
			ProSum=1;
			}
			hshQueryValues = new HashMap();
		 strQuery = SQLParser.getSqlQuery("sel_multipleBanking^"+appno+"^"+ConsType);
			if(rs!=null)
			{	rs.close();	}
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{	
				double ExistFb=Double.parseDouble((String)Helper.correctNull(rs.getString("com_fb")));
				double ExistNFb=Double.parseDouble((String)Helper.correctNull(rs.getString("Com_Nfb")));
				double ExistTot=Double.parseDouble((String)Helper.correctNull(rs.getString("Com_Tot")));
				double ProFb=Double.parseDouble((String)Helper.correctNull(rs.getString("Com_Pro_Fb")));
				double ProNFb=Double.parseDouble((String)Helper.correctNull(rs.getString("Com_Pro_Nfb")));
				double ProTot=Double.parseDouble((String)Helper.correctNull(rs.getString("Com_Pro_Tot")));
				Sno=Helper.correctInt((String)rs.getString("Com_Sno"));
				
				double ExistFbExposure=0;
				double ExistNFbExposure=0;
				double ExistTotalExposure=0;
				double PropFbExposure=0;
				double PropNFbExposure=0;
				double PropTotalExposure=0;
				
				if(FbSum!=0)
				 ExistFbExposure=ExistFb*100/FbSum;
				if(NfbSum!=0)
				 ExistNFbExposure=ExistNFb*100/NfbSum;
				if(ExistSum!=0)
				 ExistTotalExposure=ExistTot*100/ExistSum;
				if(ProFbSum!=0)
				 PropFbExposure=ProFb*100/ProFbSum;
				if(ProNfbSum!=0)
				 PropNFbExposure=ProNFb*100/ProNfbSum;
				if(ProSum!=0)
				 PropTotalExposure=ProTot*100/ProSum;
				
				hshQuery = new HashMap();
				hshQueryValues.put("size", ""+(++Size));
				hshQuery.put("strQueryId", "upd_MultipleBankingExposure");
				
				arrValues=new ArrayList();
				arrValues.add(""+ExistFbExposure);
				arrValues.add(""+ExistNFbExposure);
				arrValues.add(""+ExistTotalExposure);
				arrValues.add(""+PropFbExposure);
				arrValues.add(""+PropNFbExposure);
				arrValues.add(""+PropTotalExposure);
				arrValues.add(appno);
				arrValues.add(Sno);
				if(correctNull((String)hshValues.get("sel_ConsType")).equals(""))
				{
					arrValues.add("1");
				}
				else
				{
					arrValues.add(correctNull((String)hshValues.get("sel_ConsType")));
				}
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(""+Size, hshQuery);
			}
			if(Size>0)
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		catch(Exception ex)
		{
			throw new EJBException("Error in UpdateMultipleBaking" + ex.getMessage());
		}
	}
	public HashMap getMultipleBanking(HashMap hshValues) 
	{
		 ResultSet rs=null;
		 ArrayList vecRow=new ArrayList();
		 ArrayList vecCol=new ArrayList();
		 int RowCount=0;
		 String strBAConsType="";
		try
		{
			String appno=correctNull((String)hshValues.get("appno"));
			
			//Consortium Value from Banking Arrangement
			if(rs!=null){rs.close();}
			rs = DBUtils.executeLAPSQuery("sel_BAConsVal^"+appno);
			if(rs.next())
			{
				hshValues.put("com_wc_bnkarg",correctNull((String)rs.getString("com_wc_bnkarg")));
				hshValues.put("com_wc_type",correctNull((String)rs.getString("com_wc_type")));
				
				strBAConsType	= correctNull((String)rs.getString("com_wc_type"));
			}
			
			if(correctNull((String)hshValues.get("hidGetFLAG")).equalsIgnoreCase("Yes") || !strBAConsType.equals("M"))
			{
				String strConSno	= "";
				strConSno	= Helper.correctInt((String)hshValues.get("sel_ConsType"));
				
				if(strConSno.equals("0"))
				{
					strConSno	= "1";
				}
				String strQuery = SQLParser.getSqlQuery("sel_multipleBanking^"+appno+"^"+strConSno);
				if(rs!=null)
				{	rs.close();	}
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{	
					RowCount++;
					vecCol=new ArrayList();
					vecCol.add(Helper.correctNull(rs.getString("com_sno")));//0
					vecCol.add(Helper.correctNull(rs.getString("com_bankname")));//1
					vecCol.add(Helper.correctNull(rs.getString("com_fb")));//2
					vecCol.add(Helper.correctNull(rs.getString("com_fb_expo")));//3
					vecCol.add(Helper.correctNull(rs.getString("com_nfb")));//4
					vecCol.add(Helper.correctNull(rs.getString("com_nfb_expo")));//5
					vecCol.add(Helper.correctNull(rs.getString("com_tot")));//6
					vecCol.add(Helper.correctNull(rs.getString("com_tot_expo")));//7
					vecCol.add(Helper.correctNull(rs.getString("com_pro_fb")));//8
					vecCol.add(Helper.correctNull(rs.getString("com_pro_fb_expo")));//9
					vecCol.add(Helper.correctNull(rs.getString("com_pro_nfb")));//10
					vecCol.add(Helper.correctNull(rs.getString("com_pro_nfb_expo")));//11
					vecCol.add(Helper.correctNull(rs.getString("com_pro_tot")));//12
					vecCol.add(Helper.correctNull(rs.getString("com_pro_tot_expo")));//13
					vecRow.add(vecCol);
				}
				hshValues.put("vecRow", vecRow);
				hshValues.put("RowCount",""+RowCount);
				if(rs!=null){rs.close();}
				strQuery = SQLParser.getSqlQuery("sel_SumMultipleBanking^"+appno+"^"+strConSno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{	hshValues.put("FbSum",Helper.correctDouble((String)rs.getString("FbSum")));
					hshValues.put("NfbSum",Helper.correctDouble((String)rs.getString("NfbSum")));
					hshValues.put("ExistSum",Helper.correctDouble((String)rs.getString("ExistSum")));
					hshValues.put("ProFbSum",Helper.correctDouble((String)rs.getString("ProFbSum")));
					hshValues.put("ProNfbSum",Helper.correctDouble((String)rs.getString("ProNfbSum")));
					hshValues.put("ProSum",Helper.correctDouble((String)rs.getString("ProSum")));
				}
				else
				{	hshValues.put("FbSum","0.00");
					hshValues.put("NfbSum","0.00");
					hshValues.put("ExistSum","0.00");
					hshValues.put("ProFbSum","0.00");
					hshValues.put("ProNfbSum","0.00");
					hshValues.put("ProSum","0.00");
				}
				if(rs!=null){rs.close();}
				/*
				 * By Kishan
				strQuery = SQLParser.getSqlQuery("sel_com_proposalNoteCheck^"+appno+"^"+"MB");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshValues.put("com_proposalnote",Helper.correctNull(rs.getString("com_proposalnote")));
					hshValues.put("com_annexure",Helper.correctNull(rs.getString("com_annexure")));
				}
				*/
				// For Consortium Tab
				if(rs!=null){rs.close();}
				rs = DBUtils.executeLAPSQuery("sel_BAConsVal^"+appno);
				if(rs.next())
				{
					hshValues.put("com_tl_bnkarg",correctNull(rs.getString("com_tl_bnkarg")));
					hshValues.put("com_tl_type",correctNull(rs.getString("com_tl_type")));
					hshValues.put("com_wc_bnkarg",correctNull(rs.getString("com_wc_bnkarg")));
					hshValues.put("com_wc_type",correctNull(rs.getString("com_wc_type")));
				}	//End
				hshValues.put("sel_ConsType", strConSno);
				hshValues.put("hidGetFLAG", "Yes");
			}
		}
		catch (Exception e) {
			throw new EJBException("Error in getMultipleBanking" + e.getMessage());
		}
		return hshValues;
	}
	
	public HashMap getConsortiumDetails(HashMap hshValues) 
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null,rs1=null,rs2=null,rs5=null;
		String strQuery="",strQuery2="",strValuesIn="";
		String strAppNo=Helper.correctNull((String)hshValues.get("hidAppNo"));
		String strType=Helper.correctNull((String)hshValues.get("PageType"));
		
		ArrayList arrOutRowCons	= new ArrayList();
		ArrayList arrOutRow	= new ArrayList();
		ArrayList arrOutCol	= new ArrayList();
		ArrayList arrRow	= new ArrayList();
		ArrayList arrCol	= new ArrayList();
		ArrayList arrLeaderBankTL	= new ArrayList();
		ArrayList arrLeaderBankWC	= new ArrayList();
		ArrayList arrOtherBankTL	= new ArrayList();
		ArrayList arrOtherBankWC	= new ArrayList();
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		  nf.setMaximumFractionDigits(2);
		  nf.setMinimumFractionDigits(2);
		  nf.setGroupingUsed(false);
		  String StrRemarksFlag="N";
		  String postsanctionflag="";
			String applicationStatus="";
			// check when application is created
			String appcreatedate="";
		try
		{
			String livedate=ApplicationParams.getStrCLPHdate();
			
			
				strQuery = SQLParser.getSqlQuery("getcreatedate^"+strAppNo);
				rs5= DBUtils.executeQuery(strQuery);
				if (rs5.next()){
					
					appcreatedate= rs5.getString("createddate");
					applicationStatus= rs5.getString("APP_STATUS");
				}
				System.out.println("Application created date-->"+appcreatedate);
				System.out.println("Sanction  Live Date-->"+livedate);
				   
			if(rs!=null){rs.close();}
			rs	= DBUtils.executeLAPSQuery("selorgno^"+strAppNo);
			if(rs.next())
			{
				strValuesIn	= correctNull(rs.getString("app_valuesin"));
			}
			
			if(strValuesIn.equals("C")){strValuesIn			= "Crore";}
			else if(strValuesIn.equals("L")){strValuesIn	= "Lacs";}
			else if(strValuesIn.equals("R")){strValuesIn	= "Rs.";}
			hshValues.put("strValuesIn", strValuesIn);
			
			String strAnnxWC="",strAnnxMB="",strAnnxTL="";
			// For Consortium by DINESH on 28/04/2014
			
			String strBnkargWC="",strTypeWC="",strNoWC="0",strBnkargTL="",strTypeTL="",strNoTL="0",strConSno="",intrate1="";
			arrOutRow	= new ArrayList();
			if(rs!=null){rs.close();}
			rs	= DBUtils.executeLAPSQuery("sel_BankingArrangement^"+strAppNo);
			if(rs.next())
			{
				strBnkargWC = Helper.correctNull(rs.getString("com_wc_bnkarg"));
				strTypeWC = Helper.correctNull(rs.getString("com_wc_type"));
				strNoWC = Helper.correctNull(rs.getString("com_wc_no"));
				strBnkargTL = Helper.correctNull(rs.getString("com_tl_bnkarg"));
				strTypeTL = Helper.correctNull(rs.getString("com_tl_type"));
				strNoTL = Helper.correctNull(rs.getString("com_tl_no"));
				
				if(correctNull(rs.getString("com_wc_bnkarg")).equalsIgnoreCase("C")&&correctNull(rs.getString("com_wc_type")).equalsIgnoreCase("S"))
					hshValues.put("com_wc_bnkarg","Single Consortium");
				if(correctNull(rs.getString("com_wc_bnkarg")).equalsIgnoreCase("C")&&correctNull(rs.getString("com_wc_type")).equalsIgnoreCase("M"))
					hshValues.put("com_wc_bnkarg","Multiple Consortium");
				if(correctNull(rs.getString("com_wc_bnkarg")).equalsIgnoreCase("M"))
					hshValues.put("com_wc_bnkarg","Multiple");
				if(correctNull(rs.getString("com_wc_bnkarg")).equalsIgnoreCase("S"))
					hshValues.put("com_wc_bnkarg","Single");
				
				if(correctNull(rs.getString("com_wc_bnkarg")).equalsIgnoreCase("C")&&correctNull(rs.getString("com_tl_type")).equalsIgnoreCase("S"))
					hshValues.put("com_tl_bnkarg","Single Consortium");
				if(correctNull(rs.getString("com_wc_bnkarg")).equalsIgnoreCase("C")&&correctNull(rs.getString("com_tl_type")).equalsIgnoreCase("M"))
					hshValues.put("com_tl_bnkarg","Multiple Consortium");
				if(correctNull(rs.getString("com_wc_bnkarg")).equalsIgnoreCase("M"))
					hshValues.put("com_tl_bnkarg","Multiple");
				if(correctNull(rs.getString("com_wc_bnkarg")).equalsIgnoreCase("S"))
					hshValues.put("com_tl_bnkarg","Single");
			}
			
			if(strBnkargTL.equalsIgnoreCase("C") && strTypeTL.equalsIgnoreCase("S"))
			{
				if(strNoTL.equals("0"))
				{
					strConSno	= "1";
				}
				
				double dblSglLimit=0.00, dblSglOutstand=0.00, dblSglIntRate=0.00,dblSglExposure=0.0;
				strQuery2 = SQLParser.getSqlQuery("sel_BAConsortium_tl^"+strAppNo+"^"+strConSno);
				if(rs!=null){rs.close();}
				rs = DBUtils.executeQuery(strQuery2);
				
				while(rs.next())
				{
					arrOutCol	= new ArrayList();
					
					arrOutCol.add(Helper.correctInt((String)rs.getString("com_con_sno")));//0
					arrOutCol.add(correctNull((String)rs.getString("com_con_bank_code")));//1
					arrOutCol.add(correctNull((String)rs.getString("com_con_fac_nature")));//2
					
					if(correctNull((String)rs.getString("com_con_fac_type")).equalsIgnoreCase("M"))
					{
						arrOutCol.add("Main-Limit");
					}
					else
					{
						arrOutCol.add("Sub-Limit");
					}
				//	arrOutCol.add(correctNull((String)rs.getString("com_con_fac_type")));//3
					arrOutCol.add(correctNull((String)rs.getString("com_con_fac_limitof")));//4
					
					if(correctNull((String)rs.getString("com_con_fac_nature")).equalsIgnoreCase("15"))
					{
						arrOutCol.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("com_con_limit")))/50));//5
						arrOutCol.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("com_con_outstanding")))/50));//6
						
						if(correctNull((String)rs.getString("com_con_fac_type")).equalsIgnoreCase("M"))
						{
							dblSglLimit = dblSglLimit + (Double.parseDouble(Helper.correctDouble((String)rs.getString("com_con_limit")))/50);
							dblSglOutstand = dblSglOutstand + (Double.parseDouble(Helper.correctDouble((String)rs.getString("com_con_outstanding")))/50);
							dblSglExposure+=(Double.parseDouble(Helper.correctDouble((String)rs.getString("com_con_outstanding")))+Double.parseDouble(Helper.correctDouble((String)rs.getString("com_con_unreleased_portion"))))/50;
						}
					}
					else
					{
						if(correctNull((String)rs.getString("com_con_fac_type")).equalsIgnoreCase("M"))
						{
							dblSglLimit = dblSglLimit + Double.parseDouble((String)rs.getString("com_con_limit"));
							dblSglOutstand = dblSglOutstand + Double.parseDouble((String)rs.getString("com_con_outstanding"));
							dblSglExposure+=Double.parseDouble(Helper.correctDouble((String)rs.getString("com_con_outstanding")))+Double.parseDouble(Helper.correctDouble((String)rs.getString("com_con_unreleased_portion")));;
						}
						arrOutCol.add(Helper.correctDouble((String)rs.getString("com_con_limit")));//5
						arrOutCol.add(Helper.correctInt((String)rs.getString("com_con_outstanding")));//6
					}
					
					
					intrate1=Helper.correctInt((String)rs.getString("com_con_int_rate"));
					if(intrate1.equalsIgnoreCase("0"))
					{
						arrOutCol.add("");
					}
					else
					{
						arrOutCol.add(Helper.correctDouble(intrate1));//7
					}
					//arrOutCol.add(Helper.correctInt((String)rs.getString("com_con_int_rate")));//7
					
					dblSglIntRate = dblSglIntRate + Double.parseDouble((String)rs.getString("com_con_int_rate"));
					
					arrOutCol.add(correctNull(Helper.CLOBToString(rs.getClob("com_con_remarks"))));//8
					if(!correctNull(Helper.CLOBToString(rs.getClob("com_con_remarks"))).equalsIgnoreCase(""))
					{
						StrRemarksFlag="Y";
					}
					
					if(rs1!=null){rs1.close();}
					if(!livedate.equalsIgnoreCase("") && !appcreatedate.equalsIgnoreCase("")){
						 String Pattern="dd/MM/yyyy";
							DateFormat df=new SimpleDateFormat(Pattern);
							Date appcreationdate=df.parse(appcreatedate);
							Date postsanclivedate=df.parse(livedate);
							if(appcreationdate.before(postsanclivedate) && applicationStatus.equalsIgnoreCase("pa"))
							{
					rs1 = DBUtils.executeLAPSQuery("getstaticdescription^147^"+correctNull((String)rs.getString("com_con_bank_code")));
					if(!rs1.next())
					{
						arrOutCol.add("");
					}
					rs1.beforeFirst();
					while(rs1.next())
					{
						arrOutCol.add(Helper.correctNull(rs1.getString("stat_data_desc1")));//9
						arrOtherBankTL.add(Helper.correctNull(rs1.getString("stat_data_desc1")));
						break;
					}
					}else{
						arrOutCol.add(Helper.correctNull(rs.getString("com_con_bank_code")));//9
					}
				}
					if(rs1!=null){rs1.close();}
					rs1 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^144^"+correctNull((String)rs.getString("com_con_fac_nature")));
					if(!rs1.next())
					{
						arrOutCol.add("");
					}
					rs1.beforeFirst();
					while(rs1.next())
					{
						arrOutCol.add(Helper.correctNull(rs1.getString("stat_data_desc1")));//10
						break;
					}
					arrOutCol.add(Helper.correctNull(rs.getString("com_con_outstanding_as_on")));//11
					if(correctNull((String)rs.getString("com_con_fac_nature")).equalsIgnoreCase("15"))
						arrOutCol.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("com_con_unreleased_portion")))/50));//5
					else
						arrOutCol.add(Helper.correctNull(rs.getString("com_con_unreleased_portion")));//12
					arrOutCol.add(Helper.correctNull(rs.getString("COM_CON_BRANCH_NAME")));//13
					arrOutCol.add(Helper.correctNull(rs.getString("COM_CON_EMAIL_ID")));//14
					if(rs1!=null){rs1.close();}
					if(!livedate.equalsIgnoreCase("") && !appcreatedate.equalsIgnoreCase("")){
						 String Pattern="dd/MM/yyyy";
							DateFormat df=new SimpleDateFormat(Pattern);
							Date appcreationdate=df.parse(appcreatedate);
							Date postsanclivedate=df.parse(livedate);
							if(appcreationdate.before(postsanclivedate) && applicationStatus.equalsIgnoreCase("pa"))
							{
					rs1 = DBUtils.executeLAPSQuery("getstaticdescription^259^"+correctNull((String)rs.getString("COM_CON_BRANCH_NAME")));
					if(rs1.next())
					{
						arrOutCol.add(Helper.correctNull(rs1.getString("stat_data_desc1")));//12
					}else
					{
						arrOutCol.add("");
					}
							}else{
								arrOutCol.add(correctNull((String)rs.getString("COM_CON_BRANCH_NAME")));//12
							}
					}
					arrOutRow.add(arrOutCol);
				}
				
				//Consortium Details
				strQuery2 = SQLParser.getSqlQuery("sel_BAConsortiumLead_tl^"+strAppNo+"^"+strConSno);
				if(rs!=null){rs.close();}
				rs = DBUtils.executeQuery(strQuery2);
				if(rs.next())
				{
					if(rs1!=null){rs1.close();}
					 String Pattern="dd/MM/yyyy";
						DateFormat df=new SimpleDateFormat(Pattern);
						Date appcreationdate=df.parse(appcreatedate);
						Date postsanclivedate=df.parse(livedate);
						if(appcreationdate.before(postsanclivedate) && applicationStatus.equalsIgnoreCase("pa"))
						{
					rs1 = DBUtils.executeLAPSQuery("getstaticdescription^147^"+correctNull((String)rs.getString("com_cons_bank_code")));
					while(rs1.next())
					{
						hshValues.put("com_cons_bank_name",correctNull((String)rs1.getString("stat_data_desc1")));
						arrLeaderBankTL.add(Helper.correctNull(rs1.getString("stat_data_desc1")));
						break;
					}
						}else{
							hshValues.put("com_cons_bank_name",correctNull((String)rs.getString("com_cons_bank_code")));
							arrLeaderBankTL.add(correctNull((String)rs.getString("com_cons_bank_code")));

						}
					hshValues.put("com_cons_asondate", correctNull((String)rs.getString("com_cons_asondate")));
				}
				hshValues.put("arrSingleCons",arrOutRow);
				hshValues.put("dblSglLimit",""+dblSglLimit);
				hshValues.put("dblSglOutstand",""+dblSglOutstand);
				hshValues.put("dblSglIntRate",""+dblSglIntRate);
				hshValues.put("StrRemarksFlagTL",StrRemarksFlag);
				hshValues.put("dblSglExposure",""+dblSglExposure);
			}
			
			// WC - Single Consortium
			StrRemarksFlag="N";
			double dblWCSinConsLimit=0.00,dblWCSinConsOutstand=0.00,dblWCSinConsIntRate=0.00;
			if(strBnkargWC.equalsIgnoreCase("C") && strTypeWC.equalsIgnoreCase("S"))
			{
				if(strNoWC.equals("0"))
				{
					strConSno	= "1";
				}
				arrOutRow	= new ArrayList();
				
				strQuery2 = SQLParser.getSqlQuery("sel_BAConsortium^"+strAppNo+"^"+strConSno);
				if(rs!=null){rs.close();}
				rs = DBUtils.executeQuery(strQuery2);
				String checkint="N";intrate1="";
				while(rs.next())
				{
					arrOutCol	= new ArrayList();
					
					arrOutCol.add(Helper.correctInt((String)rs.getString("com_con_sno")));//0
					arrOutCol.add(correctNull((String)rs.getString("com_con_bank_code")));//1
					arrOutCol.add(correctNull((String)rs.getString("com_con_fac_nature")));//2
					
					if(correctNull((String)rs.getString("com_con_fac_type")).equalsIgnoreCase("M"))
					{
						arrOutCol.add("Main-Limit");
					}
					else
					{
						arrOutCol.add("Sub-Limit");
					}
				//	arrOutCol.add(correctNull((String)rs.getString("com_con_fac_type")));//3
					
					arrOutCol.add(correctNull((String)rs.getString("com_con_fac_limitof")));//4
					if(correctNull((String)rs.getString("com_con_fac_type")).equalsIgnoreCase("M"))
					{
						dblWCSinConsLimit = dblWCSinConsLimit + Double.parseDouble((String)rs.getString("com_con_limit"));
						dblWCSinConsOutstand = dblWCSinConsOutstand + Double.parseDouble((String)rs.getString("com_con_outstanding"));
						dblWCSinConsIntRate = dblWCSinConsIntRate + Double.parseDouble((String)rs.getString("com_con_int_rate"));
					}
					
					arrOutCol.add(Helper.correctInt((String)rs.getString("com_con_limit")));//5
					arrOutCol.add(Helper.correctInt((String)rs.getString("com_con_outstanding")));//6
					intrate1=Helper.correctInt((String)rs.getString("com_con_int_rate"));
					if(intrate1.equalsIgnoreCase("0"))
					{
						arrOutCol.add("");
					}
					else
					{
						arrOutCol.add(Helper.checkDecimal(intrate1));//7
					}
					//arrOutCol.add(Helper.correctInt((String)rs.getString("com_con_int_rate")));//7
					if(Helper.correctInt((String)rs.getString("com_con_int_rate")).equalsIgnoreCase("") || Helper.correctInt((String)rs.getString("com_con_int_rate")).equalsIgnoreCase("0"))
					{
						checkint="Y";
						hshValues.put("checkint",checkint);
					}
					arrOutCol.add(correctNull(Helper.CLOBToString(rs.getClob("com_con_remarks"))));//8
					if(!correctNull(Helper.CLOBToString(rs.getClob("com_con_remarks"))).equalsIgnoreCase(""))
					{
						StrRemarksFlag="Y";
					}
					
					if(rs1!=null){rs1.close();}
					if(!livedate.equalsIgnoreCase("") && !appcreatedate.equalsIgnoreCase("")){
						 String Pattern="dd/MM/yyyy";
							DateFormat df=new SimpleDateFormat(Pattern);
							Date appcreationdate=df.parse(appcreatedate);
							Date postsanclivedate=df.parse(livedate);
							if(appcreationdate.before(postsanclivedate) && applicationStatus.equalsIgnoreCase("pa"))
							{
					rs1 = DBUtils.executeLAPSQuery("getstaticdescription^147^"+correctNull((String)rs.getString("com_con_bank_code")));
					if(!rs1.next())
					{
						arrOutCol.add("");
					}
					rs1.beforeFirst();
					while(rs1.next())
					{
						arrOutCol.add(Helper.correctNull(rs1.getString("stat_data_desc1")));//9
						arrOtherBankWC.add(Helper.correctNull(rs1.getString("stat_data_desc1")));
						break;
					}
							}else{
								arrOutCol.add(correctNull((String)rs.getString("com_con_bank_code")));//9
								arrOtherBankWC.add(correctNull((String)rs.getString("com_con_bank_code")));
							}
							}
					if(rs1!=null){rs1.close();}
					rs1 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^144^"+correctNull((String)rs.getString("com_con_fac_nature")));
					if(!rs1.next())
					{
						arrOutCol.add("");
					}
					rs1.beforeFirst();
					while(rs1.next())
					{
						arrOutCol.add(Helper.correctNull(rs1.getString("stat_data_desc1")));//10
						break;
					}
					arrOutCol.add(Helper.correctNull((String)rs.getString("COM_CON_BRANCH_NAME")));//13
					arrOutCol.add(Helper.correctNull((String)rs.getString("COM_CON_EMAIL_ID")));//14
					if(rs1!=null){rs1.close();}
					if(!livedate.equalsIgnoreCase("") && !appcreatedate.equalsIgnoreCase("")){
						 String Pattern="dd/MM/yyyy";
							DateFormat df=new SimpleDateFormat(Pattern);
							Date appcreationdate=df.parse(appcreatedate);
							Date postsanclivedate=df.parse(livedate);
							if(appcreationdate.before(postsanclivedate) && applicationStatus.equalsIgnoreCase("pa"))
							{
					rs1 = DBUtils.executeLAPSQuery("getstaticdescription^259^"+correctNull((String)rs.getString("COM_CON_BRANCH_NAME")));
					if(rs1.next())
					{
						arrOutCol.add(Helper.correctNull(rs1.getString("stat_data_desc1")));//12
					}else
					{
						arrOutCol.add("");
					}
							}else{
								arrOutCol.add(correctNull((String)rs.getString("COM_CON_BRANCH_NAME")));//12

							}
					}
					arrOutRow.add(arrOutCol);
				}
				
				//Consortium Details
				strQuery2 = SQLParser.getSqlQuery("sel_BAConsortiumLead^"+strAppNo+"^"+strConSno);
				if(rs!=null){rs.close();}
				rs = DBUtils.executeQuery(strQuery2);
				if(rs.next())
				{
					if(rs1!=null){rs1.close();}
					if(!livedate.equalsIgnoreCase("") && !appcreatedate.equalsIgnoreCase("")){
						 String Pattern="dd/MM/yyyy";
							DateFormat df=new SimpleDateFormat(Pattern);
							Date appcreationdate=df.parse(appcreatedate);
							Date postsanclivedate=df.parse(livedate);
							if(appcreationdate.before(postsanclivedate) && applicationStatus.equalsIgnoreCase("pa"))
							{
					rs1 = DBUtils.executeLAPSQuery("getstaticdescription^147^"+correctNull((String)rs.getString("com_cons_bank_code")));
					while(rs1.next())
					{
						hshValues.put("com_cons_bank_name_WC",correctNull((String)rs1.getString("stat_data_desc1")));
						arrLeaderBankWC.add(Helper.correctNull(rs1.getString("stat_data_desc1")));
						break;
					}
							}else{
								hshValues.put("com_cons_bank_name_WC",correctNull((String)rs.getString("com_cons_bank_code")));
								arrLeaderBankWC.add(correctNull((String)rs.getString("com_cons_bank_code")));
							}
							}
					hshValues.put("com_cons_asondate_WC",correctNull((String)rs.getString("com_cons_asondate")));
				}
				hshValues.put("arrSingleConsWC",arrOutRow);
				hshValues.put("dblWCSinConsLimit",""+dblWCSinConsLimit);
				hshValues.put("dblWCSinConsOutstand",""+dblWCSinConsOutstand);
				hshValues.put("dblWCSinConsIntRate",""+dblWCSinConsIntRate);
				hshValues.put("StrRemarksFlagWC",StrRemarksFlag);
			}
			
			// TL - Multiple Consortium
			StrRemarksFlag="N";
			if(strBnkargTL.equalsIgnoreCase("C") && strTypeTL.equalsIgnoreCase("M"))
			{
				int ConSno = 0;
				
				ConSno	= Integer.parseInt(strNoTL);
				
				arrOutRowCons = new ArrayList();
				double dblMtplConsLimit=0.00, dblMtplConsOutstand=0.00, dblMtplConsIntRate=0.00,dblMultipleExp=0.0;
				String intrate="";
				int intcount=0,fac=0;
				for(int i=1; i<=ConSno; i++)
				{
					dblMtplConsLimit=0.00; dblMtplConsOutstand=0.00; dblMtplConsIntRate=0.00;
					arrOutRow	= new ArrayList();
					
					strQuery2 = SQLParser.getSqlQuery("sel_BAConsortium_tl^"+strAppNo+"^"+i);
					if(rs!=null){rs.close();}
					rs = DBUtils.executeQuery(strQuery2);
					
					while(rs.next())
					{
						arrOutCol	= new ArrayList();
						
						arrOutCol.add(Helper.correctInt((String)rs.getString("com_con_sno")));//0
						arrOutCol.add(correctNull((String)rs.getString("com_con_bank_code")));//1
						arrOutCol.add(correctNull((String)rs.getString("com_con_fac_nature")));//2
						
						if(correctNull((String)rs.getString("com_con_fac_type")).equalsIgnoreCase("M"))
						{
							arrOutCol.add("Main-Limit");
						}
						else
						{
							arrOutCol.add("Sub-Limit");
						}
					//	arrOutCol.add(correctNull((String)rs.getString("com_con_fac_type")));//3
						
						arrOutCol.add(correctNull((String)rs.getString("com_con_fac_limitof")));//4
						
						
						
						if(correctNull((String)rs.getString("com_con_fac_nature")).equalsIgnoreCase("15"))
						{
							arrOutCol.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("com_con_limit")))/50));//5
							arrOutCol.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("com_con_outstanding")))/50));//6
							
							if(correctNull((String)rs.getString("com_con_fac_type")).equalsIgnoreCase("M"))
							{
								dblMtplConsLimit = dblMtplConsLimit + (Double.parseDouble(Helper.correctDouble((String)rs.getString("com_con_limit")))/50);
								dblMtplConsOutstand = dblMtplConsOutstand + (Double.parseDouble(Helper.correctDouble((String)rs.getString("com_con_outstanding")))/50);
								dblMultipleExp+=(Double.parseDouble(Helper.correctDouble((String)rs.getString("com_con_outstanding")))+Double.parseDouble(Helper.correctDouble((String)rs.getString("com_con_unreleased_portion"))))/50;
							}
						}
						else
						{
							if(correctNull((String)rs.getString("com_con_fac_type")).equalsIgnoreCase("M"))
							{
								dblMtplConsLimit = dblMtplConsLimit + Double.parseDouble((String)rs.getString("com_con_limit"));
								dblMtplConsOutstand = dblMtplConsOutstand + Double.parseDouble((String)rs.getString("com_con_outstanding"));
								dblMultipleExp+=Double.parseDouble(Helper.correctDouble((String)rs.getString("com_con_outstanding")))+Double.parseDouble(Helper.correctDouble((String)rs.getString("com_con_unreleased_portion")));;
							}
							arrOutCol.add(Helper.correctDouble((String)rs.getString("com_con_limit")));//5
							arrOutCol.add(Helper.correctInt((String)rs.getString("com_con_outstanding")));//6
						}
						
						intrate=Helper.correctInt((String)rs.getString("com_con_int_rate"));
						if(intrate.equalsIgnoreCase("0"))
						{
							arrOutCol.add("");
							fac++;
							hshValues.put("intrcount"+i,"y");
							hshValues.put("fac"+i,fac);
						}
						else
						{
							arrOutCol.add(Helper.correctInt((String)rs.getString("com_con_int_rate")));//7
							fac++;
							hshValues.put("intrcount"+i,"n");
							hshValues.put("fac"+i,fac);
						}
						dblMtplConsIntRate = dblMtplConsIntRate + Double.parseDouble((String)rs.getString("com_con_int_rate"));
						
						arrOutCol.add(correctNull(Helper.CLOBToString(rs.getClob("com_con_remarks"))));//8
						if(!correctNull(Helper.CLOBToString(rs.getClob("com_con_remarks"))).equalsIgnoreCase(""))
						{
							StrRemarksFlag="Y";
						}
						if(!livedate.equalsIgnoreCase("") && !appcreatedate.equalsIgnoreCase("")){
							 String Pattern="dd/MM/yyyy";
								DateFormat df=new SimpleDateFormat(Pattern);
								Date appcreationdate=df.parse(appcreatedate);
								Date postsanclivedate=df.parse(livedate);
								if(appcreationdate.before(postsanclivedate) && applicationStatus.equalsIgnoreCase("pa"))
								{
						if(rs1!=null){rs1.close();}
						rs1 = DBUtils.executeLAPSQuery("getstaticdescription^147^"+correctNull((String)rs.getString("com_con_bank_code")));
						if(!rs1.next())
						{
							arrOutCol.add("");
						}
						rs1.beforeFirst();
						while(rs1.next())
						{
							arrOutCol.add(Helper.correctNull(rs1.getString("stat_data_desc1")));//9
							arrOtherBankTL.add(Helper.correctNull(rs1.getString("stat_data_desc1")));
							break;
						}
								}else{
									arrOutCol.add(correctNull((String)rs.getString("com_con_bank_code")));//9
									arrOtherBankTL.add(correctNull((String)rs.getString("com_con_bank_code")));
								}
								}
						if(rs1!=null){rs1.close();}
						rs1 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^144^"+correctNull((String)rs.getString("com_con_fac_nature")));
						if(!rs1.next())
						{
							arrOutCol.add("");
						}
						rs1.beforeFirst();
						while(rs1.next())
						{
							arrOutCol.add(Helper.correctNull(rs1.getString("stat_data_desc1")));//10
							break;
						}
						arrOutCol.add(Helper.correctNull(rs.getString("com_con_outstanding_as_on")));//11
						if(correctNull((String)rs.getString("com_con_fac_nature")).equalsIgnoreCase("15"))
							arrOutCol.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("com_con_unreleased_portion")))/50));//5
						else
							arrOutCol.add(Helper.correctNull(rs.getString("com_con_unreleased_portion")));//12
						arrOutCol.add(Helper.correctNull((String)rs.getString("COM_CON_BRANCH_NAME")));//13
						arrOutCol.add(Helper.correctNull((String)rs.getString("COM_CON_EMAIL_ID")));//14
						if(rs1!=null){rs1.close();}
						if(!livedate.equalsIgnoreCase("") && !appcreatedate.equalsIgnoreCase("")){
							 String Pattern="dd/MM/yyyy";
								DateFormat df=new SimpleDateFormat(Pattern);
								Date appcreationdate=df.parse(appcreatedate);
								Date postsanclivedate=df.parse(livedate);
								if(appcreationdate.before(postsanclivedate) && applicationStatus.equalsIgnoreCase("pa"))
								{
						rs1 = DBUtils.executeLAPSQuery("getstaticdescription^259^"+correctNull((String)rs.getString("COM_CON_BRANCH_NAME")));
						if(rs1.next())
						{
							arrOutCol.add(Helper.correctNull(rs1.getString("stat_data_desc1")));//12
						}else
						{
							arrOutCol.add("");
						}
								}else{
									arrOutCol.add(correctNull((String)rs.getString("COM_CON_BRANCH_NAME")));//12
								}
								}
						arrOutRow.add(arrOutCol);
					}
					
					//Consortium Details
					strQuery2 = SQLParser.getSqlQuery("sel_BAConsortiumLead_tl^"+strAppNo+"^"+i);
					if(rs!=null){rs.close();}
					rs = DBUtils.executeQuery(strQuery2);
					if(rs.next())
					{
						if(rs1!=null){rs1.close();}
						if(!livedate.equalsIgnoreCase("") && !appcreatedate.equalsIgnoreCase("")){
							 String Pattern="dd/MM/yyyy";
								DateFormat df=new SimpleDateFormat(Pattern);
								Date appcreationdate=df.parse(appcreatedate);
								Date postsanclivedate=df.parse(livedate);
								if(appcreationdate.before(postsanclivedate) && applicationStatus.equalsIgnoreCase("pa"))
								{
						rs1 = DBUtils.executeLAPSQuery("getstaticdescription^147^"+correctNull((String)rs.getString("com_cons_bank_code")));
						while(rs1.next())
						{
							hshValues.put("com_cons_bank_name"+i,correctNull((String)rs1.getString("stat_data_desc1")));
							arrLeaderBankTL.add(Helper.correctNull(rs1.getString("stat_data_desc1")));
							break;
						}
								}else{
									hshValues.put("com_cons_bank_name"+i,correctNull((String)rs.getString("com_cons_bank_code")));
									arrLeaderBankTL.add(correctNull((String)rs.getString("com_cons_bank_code")));
								}
						}
						hshValues.put("com_cons_asondate",correctNull((String)rs.getString("com_cons_asondate")));
					}
					if(arrOutRow!=null && arrOutRow.size()>0)
						arrOutRowCons.add(arrOutRow);
					hshValues.put("dblMtplConsLimit"+i,""+dblMtplConsLimit);
					hshValues.put("dblMtplConsOutstand"+i,""+dblMtplConsOutstand);
					hshValues.put("dblMtplConsIntRate"+i,""+dblMtplConsIntRate);
				}
				hshValues.put("arrMultipleCons",arrOutRowCons);
				hshValues.put("StrRemarksFlagTL_MC",StrRemarksFlag);
				hshValues.put("dblMultipleExp",dblMultipleExp+"");
			}
			
			// WC - Multiple Consortium
			StrRemarksFlag="N";
			double dblWCMulConsLimit=0.00,dblWCMulConsOutstand=0.00,dblWCMulConsIntRate=0.00;
			if(strBnkargWC.equalsIgnoreCase("C") && strTypeWC.equalsIgnoreCase("M"))
			{
				int ConSno = 0;
				intrate1=""; 
				ConSno	= Integer.parseInt(strNoWC);
				int intratecount=0;
				arrOutRowCons = new ArrayList();
				
				
				for(int i=1; i<=ConSno; i++)
				{	
					dblWCMulConsLimit=0.00;dblWCMulConsOutstand=0.00;dblWCMulConsIntRate=0.00;
					arrOutRow	= new ArrayList();
					
					strQuery2 = SQLParser.getSqlQuery("sel_BAConsortium^"+strAppNo+"^"+i);
					if(rs!=null){rs.close();}
					rs = DBUtils.executeQuery(strQuery2);
					
					while(rs.next())
					{
						arrOutCol	= new ArrayList();
						
						arrOutCol.add(Helper.correctInt((String)rs.getString("com_con_sno")));//0
						arrOutCol.add(correctNull((String)rs.getString("com_con_bank_code")));//1
						arrOutCol.add(correctNull((String)rs.getString("com_con_fac_nature")));//2
						
						if(correctNull((String)rs.getString("com_con_fac_type")).equalsIgnoreCase("M"))
						{
							arrOutCol.add("Main-Limit");
						}
						else
						{
							arrOutCol.add("Sub-Limit");
						}
						strQuery2 = SQLParser.getSqlQuery("sel_countint^"+strAppNo+"^"+i);
						if(rs1!=null){rs1.close();}
						rs1 = DBUtils.executeQuery(strQuery2);
						if(rs1.next())
						{
							 intratecount=Integer.parseInt(correctNull((String)rs1.getString("com_con_int_rate")));
							if(intratecount==0)
							{
								hshValues.put("intrcount"+i,"N");
								hshValues.put("com_lead"+i,"N");
							}
							else
							{
								hshValues.put("intrcount"+i,"Y");
								hshValues.put("com_lead"+i,"Y");
							}
							
						}
										
						if(rs1!=null){rs1.close();}
						
					//	arrOutCol.add(correctNull((String)rs.getString("com_con_fac_type")));//3
						
						arrOutCol.add(correctNull((String)rs.getString("com_con_fac_limitof")));//4
						arrOutCol.add(Helper.correctInt((String)rs.getString("com_con_limit")));//5
						arrOutCol.add(Helper.correctInt((String)rs.getString("com_con_outstanding")));//6
						
						intrate1=Helper.correctInt((String)rs.getString("com_con_int_rate"));
						if(correctNull((String)rs.getString("com_con_fac_type")).equalsIgnoreCase("M"))
						{
							dblWCMulConsLimit = dblWCMulConsLimit + Double.parseDouble((String)rs.getString("com_con_limit"));
							dblWCMulConsOutstand = dblWCMulConsOutstand + Double.parseDouble((String)rs.getString("com_con_outstanding"));
							dblWCMulConsIntRate = dblWCMulConsIntRate + Double.parseDouble((String)rs.getString("com_con_int_rate"));
						}
						
						if(intrate1.equalsIgnoreCase("0"))
						{
							arrOutCol.add("");
						}
						else
						{
							arrOutCol.add(Helper.checkDecimal(intrate1));//7
						}
						
						//arrOutCol.add(Helper.correctInt((String)rs.getString("com_con_int_rate")));//7
						arrOutCol.add(correctNull(Helper.CLOBToString(rs.getClob("com_con_remarks"))));//8
						if(!correctNull(Helper.CLOBToString(rs.getClob("com_con_remarks"))).equalsIgnoreCase(""))
						{
							StrRemarksFlag="Y";
						}
						
						if(rs1!=null){rs1.close();}
						if(!livedate.equalsIgnoreCase("") && !appcreatedate.equalsIgnoreCase("")){
							 String Pattern="dd/MM/yyyy";
								DateFormat df=new SimpleDateFormat(Pattern);
								Date appcreationdate=df.parse(appcreatedate);
								Date postsanclivedate=df.parse(livedate);
								if(appcreationdate.before(postsanclivedate) && applicationStatus.equalsIgnoreCase("pa"))
								{
						rs1 = DBUtils.executeLAPSQuery("getstaticdescription^147^"+correctNull((String)rs.getString("com_con_bank_code")));
						if(!rs1.next())
						{
							arrOutCol.add("");
						}
						rs1.beforeFirst();
						while(rs1.next())
						{
							arrOutCol.add(Helper.correctNull(rs1.getString("stat_data_desc1")));//9
							arrOtherBankWC.add(Helper.correctNull(rs1.getString("stat_data_desc1")));
							break;
						}
								}else{
									arrOutCol.add(correctNull((String)rs.getString("com_con_bank_code")));//9
									arrOtherBankWC.add(correctNull((String)rs.getString("com_con_bank_code")));
								}
								}
						
						if(rs1!=null){rs1.close();}
						rs1 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^144^"+correctNull((String)rs.getString("com_con_fac_nature")));
						if(!rs1.next())
						{
							arrOutCol.add("");
						}
						rs1.beforeFirst();
						while(rs1.next())
						{
							arrOutCol.add(Helper.correctNull(rs1.getString("stat_data_desc1")));//10
							break;
						}
						arrOutCol.add(Helper.correctNull((String)rs.getString("COM_CON_BRANCH_NAME")));//13
						arrOutCol.add(Helper.correctNull((String)rs.getString("COM_CON_EMAIL_ID")));//14
						if(rs1!=null){rs1.close();}
						if(!livedate.equalsIgnoreCase("") && !appcreatedate.equalsIgnoreCase("")){
							 String Pattern="dd/MM/yyyy";
								DateFormat df=new SimpleDateFormat(Pattern);
								Date appcreationdate=df.parse(appcreatedate);
								Date postsanclivedate=df.parse(livedate);
								if(appcreationdate.before(postsanclivedate) && applicationStatus.equalsIgnoreCase("pa"))
								{
						rs1 = DBUtils.executeLAPSQuery("getstaticdescription^259^"+correctNull((String)rs.getString("COM_CON_BRANCH_NAME")));
						if(rs1.next())
						{
							arrOutCol.add(Helper.correctNull(rs1.getString("stat_data_desc1")));//12
						}else
						{
							arrOutCol.add("");
						}
								}else{
									arrOutCol.add(correctNull((String)rs.getString("COM_CON_BRANCH_NAME")));//12
								}
								
								}
						arrOutRow.add(arrOutCol);
					}
					
					//Consortium Details
					strQuery2 = SQLParser.getSqlQuery("sel_BAConsortiumLead^"+strAppNo+"^"+i);
					if(rs!=null){rs.close();}
					rs = DBUtils.executeQuery(strQuery2);
					if(rs.next())
					{
						if(rs1!=null){rs1.close();}
						if(!livedate.equalsIgnoreCase("") && !appcreatedate.equalsIgnoreCase("")){
							 String Pattern="dd/MM/yyyy";
								DateFormat df=new SimpleDateFormat(Pattern);
								Date appcreationdate=df.parse(appcreatedate);
								Date postsanclivedate=df.parse(livedate);
								if(appcreationdate.before(postsanclivedate) && applicationStatus.equalsIgnoreCase("pa"))
								{
						rs1 = DBUtils.executeLAPSQuery("getstaticdescription^147^"+correctNull((String)rs.getString("com_cons_bank_code")));
						while(rs1.next())
						{
							hshValues.put("com_cons_bank_name_WC"+i,correctNull((String)rs1.getString("stat_data_desc1")));
							arrLeaderBankWC.add(Helper.correctNull(rs1.getString("stat_data_desc1")));
							break;
						}
								}else{
									hshValues.put("com_cons_bank_name_WC"+i,correctNull((String)rs.getString("com_cons_bank_code")));
									arrLeaderBankWC.add(correctNull((String)rs.getString("com_cons_bank_code")));
								}
								
								}
						hshValues.put("com_cons_asondate_WC",correctNull((String)rs.getString("com_cons_asondate")));
					}
					if(arrOutRow!=null && arrOutRow.size()>0)
						arrOutRowCons.add(arrOutRow);
					
					hshValues.put("dblWCMulConsLimit"+i,""+dblWCMulConsLimit);
					hshValues.put("dblWCMulConsOutstand"+i,""+dblWCMulConsOutstand);
					hshValues.put("dblWCMulConsIntRate"+i,""+dblWCMulConsIntRate);
				}
				hshValues.put("arrMultipleConsWC",arrOutRowCons);
				hshValues.put("StrRemarksFlagWC_MC",StrRemarksFlag);
			}
			
			// TL - Multiple 
			intrate1="";
			StrRemarksFlag="N";
			double dblMtplLimit=0.00,dblMtplOutstand=0.00,dblMtplIntRate=0.00,dblMultiExp=0.0;
			if(strBnkargTL.equalsIgnoreCase("M"))
			{
				if(strNoTL.equals("0"))
				{
					strConSno	= "1";
				}
				arrOutRow	= new ArrayList();
				strQuery2 = SQLParser.getSqlQuery("sel_BAConsortium_tl^"+strAppNo+"^"+strConSno);
				if(rs!=null){rs.close();}
				rs = DBUtils.executeQuery(strQuery2);
				
				while(rs.next())
				{
					arrOutCol	= new ArrayList();
					
					arrOutCol.add(Helper.correctInt((String)rs.getString("com_con_sno")));//0
					arrOutCol.add(correctNull((String)rs.getString("com_con_bank_code")));//1
					arrOutCol.add(correctNull((String)rs.getString("com_con_fac_nature")));//2
					
					if(correctNull((String)rs.getString("com_con_fac_type")).equalsIgnoreCase("M"))
					{
						arrOutCol.add("Main-Limit");
					}
					else
					{
						arrOutCol.add("Sub-Limit");
					}
				//	arrOutCol.add(correctNull((String)rs.getString("com_con_fac_type")));//3
					
					arrOutCol.add(correctNull((String)rs.getString("com_con_fac_limitof")));//4
					
					if(correctNull((String)rs.getString("com_con_fac_nature")).equalsIgnoreCase("15"))
					{
						arrOutCol.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("com_con_limit")))/50));//5
						arrOutCol.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("com_con_outstanding")))/50));//6
						
						if(correctNull((String)rs.getString("com_con_fac_type")).equalsIgnoreCase("M"))
						{
							dblMtplLimit = dblMtplLimit + (Double.parseDouble(Helper.correctDouble((String)rs.getString("com_con_limit")))/50);
							dblMtplOutstand = dblMtplOutstand + (Double.parseDouble(Helper.correctDouble((String)rs.getString("com_con_outstanding")))/50);

							dblMultiExp+=(Double.parseDouble((Helper.correctDouble((String)rs.getString("com_con_outstanding"))))+Double.parseDouble(Helper.correctDouble((String)rs.getString("com_con_unreleased_portion"))))/50;

						}
					}
					else
					{
						if(correctNull((String)rs.getString("com_con_fac_type")).equalsIgnoreCase("M"))
						{

							dblMtplLimit = dblMtplLimit + Double.parseDouble(Helper.correctDouble((String)rs.getString("com_con_limit")));
							dblMtplOutstand = dblMtplOutstand + Double.parseDouble(Helper.correctDouble((String)rs.getString("com_con_outstanding")));
							dblMultiExp+=Double.parseDouble(Helper.correctDouble((String)rs.getString("com_con_outstanding")))+Double.parseDouble(Helper.correctDouble((String)rs.getString("com_con_unreleased_portion")));

						}
						arrOutCol.add(Helper.correctDouble((String)rs.getString("com_con_limit")));//5
						arrOutCol.add(Helper.correctInt((String)rs.getString("com_con_outstanding")));//6
					}
					
					
					intrate1=Helper.correctInt((String)rs.getString("com_con_int_rate"));
					if(intrate1.equalsIgnoreCase("0"))
					{
						arrOutCol.add("");
					}
					else
					{
						arrOutCol.add(Helper.checkDecimal(intrate1));//7
					}
					//arrOutCol.add(Helper.correctDouble((String)rs.getString("com_con_int_rate")));//7
					
					dblMtplIntRate = dblMtplIntRate + Double.parseDouble(Helper.correctDouble((String)rs.getString("com_con_int_rate")));
					
					arrOutCol.add(correctNull(Helper.CLOBToString(rs.getClob("com_con_remarks"))));//8
					if(!correctNull(Helper.CLOBToString(rs.getClob("com_con_remarks"))).equalsIgnoreCase(""))
					{
						StrRemarksFlag="Y";
					}
					
					if(rs1!=null){rs1.close();}
					if(!livedate.equalsIgnoreCase("") && !appcreatedate.equalsIgnoreCase("")){
						 String Pattern="dd/MM/yyyy";
							DateFormat df=new SimpleDateFormat(Pattern);
							Date appcreationdate=df.parse(appcreatedate);
							Date postsanclivedate=df.parse(livedate);
							if(appcreationdate.before(postsanclivedate) && applicationStatus.equalsIgnoreCase("pa"))
							{
					rs1 = DBUtils.executeLAPSQuery("getstaticdescription^147^"+correctNull((String)rs.getString("com_con_bank_code")));
					if(!rs1.next())
					{
						arrOutCol.add("");
					}
					rs1.beforeFirst();
					while(rs1.next())
					{
						arrOutCol.add(Helper.correctNull(rs1.getString("stat_data_desc1")));//9
						arrOtherBankTL.add(Helper.correctNull(rs1.getString("stat_data_desc1")));
						break;
					}
							}else{
								arrOutCol.add(correctNull((String)rs.getString("com_con_bank_code")));//9
								arrOtherBankTL.add(correctNull((String)rs.getString("com_con_bank_code")));
							}
					}
					
					if(rs1!=null){rs1.close();}
					rs1 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^144^"+correctNull((String)rs.getString("com_con_fac_nature")));
					if(!rs1.next())
					{
						arrOutCol.add("");
					}
					rs1.beforeFirst();
					while(rs1.next())
					{
						arrOutCol.add(Helper.correctNull(rs1.getString("stat_data_desc1")));//10
						break;
					}
					arrOutCol.add(Helper.correctNull(rs.getString("com_con_outstanding_as_on")));//11
					if(correctNull((String)rs.getString("com_con_fac_nature")).equalsIgnoreCase("15"))
						arrOutCol.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("com_con_unreleased_portion")))/50));//5
					else
						arrOutCol.add(Helper.correctNull(rs.getString("com_con_unreleased_portion")));//12
					arrOutCol.add(Helper.correctNull((String)rs.getString("COM_CON_BRANCH_NAME")));//13
					arrOutCol.add(Helper.correctNull((String)rs.getString("COM_CON_EMAIL_ID")));//14
					if(rs1!=null){rs1.close();}
					if(!livedate.equalsIgnoreCase("") && !appcreatedate.equalsIgnoreCase("")){
						 String Pattern="dd/MM/yyyy";
							DateFormat df=new SimpleDateFormat(Pattern);
							Date appcreationdate=df.parse(appcreatedate);
							Date postsanclivedate=df.parse(livedate);
							if(appcreationdate.before(postsanclivedate) && applicationStatus.equalsIgnoreCase("pa"))
							{
					rs1 = DBUtils.executeLAPSQuery("getstaticdescription^259^"+correctNull((String)rs.getString("COM_CON_BRANCH_NAME")));
					if(rs1.next())
					{
						arrOutCol.add(Helper.correctNull(rs1.getString("stat_data_desc1")));//12
					}else
					{
						arrOutCol.add("");
					}
							}else{
								arrOutCol.add(correctNull((String)rs.getString("COM_CON_BRANCH_NAME")));//12
							}
							}
					arrOutRow.add(arrOutCol);
					
				}
				
				//Consortium Details
				strQuery2 = SQLParser.getSqlQuery("sel_BAConsortiumLead_tl^"+strAppNo+"^"+strConSno);
				if(rs!=null){rs.close();}
				rs = DBUtils.executeQuery(strQuery2);
				if(rs.next())
				{
					if(rs1!=null){rs1.close();}
					if(!livedate.equalsIgnoreCase("") && !appcreatedate.equalsIgnoreCase("")){
						 String Pattern="dd/MM/yyyy";
							DateFormat df=new SimpleDateFormat(Pattern);
							Date appcreationdate=df.parse(appcreatedate);
							Date postsanclivedate=df.parse(livedate);
							if(appcreationdate.before(postsanclivedate) && applicationStatus.equalsIgnoreCase("pa"))
							{
					rs1 = DBUtils.executeLAPSQuery("getstaticdescription^147^"+correctNull((String)rs.getString("com_cons_bank_code")));
					while(rs1.next())
					{
						hshValues.put("com_cons_bank_name",correctNull((String)rs1.getString("stat_data_desc1")));
						break;
					}
							}else{
								hshValues.put("com_cons_bank_name",correctNull((String)rs.getString("com_cons_bank_code")));
							}
							}
					hshValues.put("com_cons_asondate", correctNull((String)rs.getString("com_cons_asondate")));
				}
				/*String strIntRate = Helper.correctDouble(jtn.format(dblMtplIntRate));
				if(strIntRate.equals("0.0") || strIntRate.equals("0.00"))
				{
					for(int i=0;i<arrOutRow.size();i++) {
						arrOutCol = (ArrayList) arrOutRow.get(i);
						arrOutCol.set(7, "");
						arrOutRow.set(i, arrOutCol);
					}
				}*/
					
				hshValues.put("arrMultiple",arrOutRow);
				hshValues.put("dblMtplLimit",""+dblMtplLimit);
				hshValues.put("dblMtplOutstand",""+dblMtplOutstand);
				hshValues.put("dblMtplIntRate",""+dblMtplIntRate);
				hshValues.put("StrRemarksFlagTL_M",StrRemarksFlag);
				hshValues.put("dblMultiExp",dblMultiExp+"");
			}
			
			// WC - Multiple 
			intrate1="";
			StrRemarksFlag="N";
			dblMtplLimit=0.00;dblMtplOutstand=0.00;dblMtplIntRate=0.00;
			if(strBnkargWC.equalsIgnoreCase("M"))
			{
				if(strNoWC.equals("0"))
				{
					strConSno	= "1";
				}
				arrOutRow	= new ArrayList();
				strQuery2 = SQLParser.getSqlQuery("sel_BAConsortium^"+strAppNo+"^"+strConSno);
				if(rs!=null){rs.close();}
				rs = DBUtils.executeQuery(strQuery2);
				
				while(rs.next())
				{
					arrOutCol	= new ArrayList();
					
					arrOutCol.add(Helper.correctInt((String)rs.getString("com_con_sno")));//0
					arrOutCol.add(correctNull((String)rs.getString("com_con_bank_code")));//1
					arrOutCol.add(correctNull((String)rs.getString("com_con_fac_nature")));//2
					
					if(correctNull((String)rs.getString("com_con_fac_type")).equalsIgnoreCase("M"))
					{
						arrOutCol.add("Main-Limit");
					}
					else
					{
						arrOutCol.add("Sub-Limit");
					}
				//	arrOutCol.add(correctNull((String)rs.getString("com_con_fac_type")));//3
					
					arrOutCol.add(correctNull((String)rs.getString("com_con_fac_limitof")));//4
					arrOutCol.add(Helper.correctInt((String)rs.getString("com_con_limit")));//5
					arrOutCol.add(Helper.correctInt((String)rs.getString("com_con_outstanding")));//6
					
					intrate1=Helper.correctInt((String)rs.getString("com_con_int_rate"));
					if(intrate1.equalsIgnoreCase("0"))
					{
						arrOutCol.add("");
					}
					else
					{
						arrOutCol.add(Helper.checkDecimal(intrate1));//7
					}
					//arrOutCol.add(Helper.correctInt((String)rs.getString("com_con_int_rate")));//7
					if(correctNull((String)rs.getString("com_con_fac_type")).equalsIgnoreCase("M"))
					{
						dblMtplLimit = dblMtplLimit + Double.parseDouble((String)rs.getString("com_con_limit"));
						dblMtplOutstand = dblMtplOutstand + Double.parseDouble((String)rs.getString("com_con_outstanding"));
						dblMtplIntRate = dblMtplIntRate + Double.parseDouble((String)rs.getString("com_con_int_rate"));
					}
					
					arrOutCol.add(correctNull(Helper.CLOBToString(rs.getClob("com_con_remarks"))));//8
					if(!correctNull(Helper.CLOBToString(rs.getClob("com_con_remarks"))).equalsIgnoreCase(""))
					{
						StrRemarksFlag="Y";
					}
					
					if(rs1!=null){rs1.close();}
					if(!livedate.equalsIgnoreCase("") && !appcreatedate.equalsIgnoreCase("")){
						 String Pattern="dd/MM/yyyy";
							DateFormat df=new SimpleDateFormat(Pattern);
							Date appcreationdate=df.parse(appcreatedate);
							Date postsanclivedate=df.parse(livedate);
							if(appcreationdate.before(postsanclivedate) && applicationStatus.equalsIgnoreCase("pa"))
							{
					rs1 = DBUtils.executeLAPSQuery("getstaticdescription^147^"+correctNull((String)rs.getString("com_con_bank_code")));
					if(!rs1.next())
					{
						arrOutCol.add("");
					}
					rs1.beforeFirst();
					while(rs1.next())
					{
						arrOutCol.add(Helper.correctNull(rs1.getString("stat_data_desc1")));//9
						break;
					}
							}else{
								arrOutCol.add(correctNull((String)rs.getString("com_con_bank_code")));//9
							}
					}
					if(rs1!=null){rs1.close();}
					rs1 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^144^"+correctNull((String)rs.getString("com_con_fac_nature")));
					if(!rs1.next())
					{
						arrOutCol.add("");
					}
					rs1.beforeFirst();
					while(rs1.next())
					{
						arrOutCol.add(Helper.correctNull(rs1.getString("stat_data_desc1")));//10
						break;
					}
					arrOutCol.add(Helper.correctNull((String)rs.getString("COM_CON_BRANCH_NAME")));//13
					arrOutCol.add(Helper.correctNull((String)rs.getString("COM_CON_EMAIL_ID")));//14
					if(rs1!=null){rs1.close();}
					if(!livedate.equalsIgnoreCase("") && !appcreatedate.equalsIgnoreCase("")){
						 String Pattern="dd/MM/yyyy";
							DateFormat df=new SimpleDateFormat(Pattern);
							Date appcreationdate=df.parse(appcreatedate);
							Date postsanclivedate=df.parse(livedate);
							if(appcreationdate.before(postsanclivedate) && applicationStatus.equalsIgnoreCase("pa"))
							{
					rs1 = DBUtils.executeLAPSQuery("getstaticdescription^259^"+correctNull((String)rs.getString("COM_CON_BRANCH_NAME")));
					if(rs1.next())
					{
						arrOutCol.add(Helper.correctNull(rs1.getString("stat_data_desc1")));//12
					}else
					{
						arrOutCol.add("");
					}
							}else{
								arrOutCol.add(correctNull((String)rs.getString("COM_CON_BRANCH_NAME")));//12
							}
							}
					arrOutRow.add(arrOutCol);
				}
				
				//Consortium Details
				strQuery2 = SQLParser.getSqlQuery("sel_BAConsortiumLead^"+strAppNo+"^"+strConSno);
				if(rs!=null){rs.close();}
				rs = DBUtils.executeQuery(strQuery2);
				if(rs.next())
				{
					if(rs1!=null){rs1.close();}
					if(!livedate.equalsIgnoreCase("") && !appcreatedate.equalsIgnoreCase("")){
						 String Pattern="dd/MM/yyyy";
							DateFormat df=new SimpleDateFormat(Pattern);
							Date appcreationdate=df.parse(appcreatedate);
							Date postsanclivedate=df.parse(livedate);
							if(appcreationdate.before(postsanclivedate) && applicationStatus.equalsIgnoreCase("pa"))
							{
					rs1 = DBUtils.executeLAPSQuery("getstaticdescription^147^"+correctNull((String)rs.getString("com_cons_bank_code")));
					while(rs1.next())
					{
						hshValues.put("com_cons_bank_name_WC",correctNull((String)rs1.getString("stat_data_desc1")));
						arrOtherBankWC.add(Helper.correctNull(rs1.getString("stat_data_desc1")));
						break;
					}
							}else{
								hshValues.put("com_cons_bank_name_WC",correctNull((String)rs.getString("com_cons_bank_code")));
							}
							}
					hshValues.put("com_cons_asondate_WC",correctNull((String)rs.getString("com_cons_asondate")));
				}
				
				/*String strIntRate = Helper.correctDouble(jtn.format(dblMtplIntRate));
				if(strIntRate.equals("0.0") || strIntRate.equals("0.00"))
				{
					for(int i=0;i<arrOutRow.size();i++) {
						arrOutCol = (ArrayList) arrOutRow.get(i);
						arrOutCol.set(7, "");
						arrOutRow.set(i, arrOutCol);
					}
				}*/
				
				hshValues.put("arrMultipleWC",arrOutRow);
				hshValues.put("dblWCMtplLimit",""+dblMtplLimit);
				hshValues.put("dblWCMtplOutstand",""+dblMtplOutstand);
				hshValues.put("dblWCMtplIntRate",""+dblMtplIntRate);
				hshValues.put("StrRemarksFlagWC_M",StrRemarksFlag);
			}
			
			hshValues.put("strBnkargTL",strBnkargTL);
			hshValues.put("strTypeTL",strTypeTL);
			hshValues.put("strBnkargWC",strBnkargWC);
			hshValues.put("strTypeWC",strTypeWC);
			
			// Multiple Banking
			
			//if(strAnnxMB.equalsIgnoreCase("Y"))
			//{
				int ConSno = 0;
				
				ConSno	= Integer.parseInt(strNoWC);
				arrOutRowCons = new ArrayList();
				if(ConSno>0)
				{
					for(int i=1; i<=ConSno; i++)
						{
							arrOutRow	= new ArrayList();
							strQuery2 = SQLParser.getSqlQuery("sel_consDet^"+strAppNo);
							if(rs!=null){rs.close();}
							rs = DBUtils.executeQuery(strQuery2);
							String countexi="";
							if(rs.next())
							{
								countexi=Helper.correctNull(rs.getString("com_wc_no"));
								if(countexi.equalsIgnoreCase("1"))
								{
									hshValues.put("countexiting","Y");
								}
								else
								{
									hshValues.put("countexiting","N");
								}
							}
							
							if(rs!=null){rs.close();}
							strQuery2 = SQLParser.getSqlQuery("sel_multipleBanking^"+strAppNo+"^"+i);
							if(rs!=null){rs.close();}
							rs = DBUtils.executeQuery(strQuery2);
							
							while(rs.next())
							{
								arrOutCol	= new ArrayList();
								arrOutCol.add(Helper.correctNull(rs.getString("com_sno")));//0
								arrOutCol.add(Helper.correctNull(rs.getString("com_bankname")));//1
								arrOutCol.add(Helper.correctNull(rs.getString("com_fb")));//2
								arrOutCol.add(Helper.correctNull(rs.getString("com_fb_expo")));//3
								arrOutCol.add(Helper.correctNull(rs.getString("com_nfb")));//4
								arrOutCol.add(Helper.correctNull(rs.getString("com_nfb_expo")));//5
								arrOutCol.add(Helper.correctNull(rs.getString("com_tot")));//6
								arrOutCol.add(Helper.correctNull(rs.getString("com_tot_expo")));//7
								arrOutCol.add(Helper.correctNull(rs.getString("com_pro_fb")));//8
								arrOutCol.add(Helper.correctNull(rs.getString("com_pro_fb_expo")));//9
								arrOutCol.add(Helper.correctNull(rs.getString("com_pro_nfb")));//10
								arrOutCol.add(Helper.correctNull(rs.getString("com_pro_nfb_expo")));//11
								arrOutCol.add(Helper.correctNull(rs.getString("com_pro_tot")));//12
								arrOutCol.add(Helper.correctNull(rs.getString("com_pro_tot_expo")));//13
								
								arrOutRow.add(arrOutCol);
							}
							
							if(rs!=null){rs.close();}
							strQuery2 = SQLParser.getSqlQuery("sel_SumMultipleBanking^"+strAppNo+"^"+i);
							rs=DBUtils.executeQuery(strQuery2);
							if(rs.next())
							{	hshValues.put("FbSum"+i,Helper.correctDouble((String)rs.getString("FbSum")));
								hshValues.put("NfbSum"+i,Helper.correctDouble((String)rs.getString("NfbSum")));
								hshValues.put("ExistSum"+i,Helper.correctDouble((String)rs.getString("ExistSum")));
								hshValues.put("ProFbSum"+i,Helper.correctDouble((String)rs.getString("ProFbSum")));
								hshValues.put("ProNfbSum"+i,Helper.correctDouble((String)rs.getString("ProNfbSum")));
								hshValues.put("ProSum"+i,Helper.correctDouble((String)rs.getString("ProSum")));
							}
							if(arrOutRow != null && arrOutRow.size()>0)
							arrOutRowCons.add(arrOutRow);
					}
				}else
				{

					arrOutRow	= new ArrayList();
					strQuery2 = SQLParser.getSqlQuery("sel_multiplebanking_appno^"+strAppNo);
					if(rs!=null){rs.close();}
					rs = DBUtils.executeQuery(strQuery2);
					
					while(rs.next())
					{
						arrOutCol	= new ArrayList();
						arrOutCol.add(Helper.correctNull(rs.getString("com_sno")));//0
						arrOutCol.add(Helper.correctNull(rs.getString("com_bankname")));//1
						arrOutCol.add(Helper.correctNull(rs.getString("com_fb")));//2
						arrOutCol.add(Helper.correctNull(rs.getString("com_fb_expo")));//3
						arrOutCol.add(Helper.correctNull(rs.getString("com_nfb")));//4
						arrOutCol.add(Helper.correctNull(rs.getString("com_nfb_expo")));//5
						arrOutCol.add(Helper.correctNull(rs.getString("com_tot")));//6
						arrOutCol.add(Helper.correctNull(rs.getString("com_tot_expo")));//7
						arrOutCol.add(Helper.correctNull(rs.getString("com_pro_fb")));//8
						arrOutCol.add(Helper.correctNull(rs.getString("com_pro_fb_expo")));//9
						arrOutCol.add(Helper.correctNull(rs.getString("com_pro_nfb")));//10
						arrOutCol.add(Helper.correctNull(rs.getString("com_pro_nfb_expo")));//11
						arrOutCol.add(Helper.correctNull(rs.getString("com_pro_tot")));//12
						arrOutCol.add(Helper.correctNull(rs.getString("com_pro_tot_expo")));//13
						hshValues.put("countexiting","Y");
						arrOutRow.add(arrOutCol);
					}
					
					if(rs!=null){rs.close();}
					strQuery2 = SQLParser.getSqlQuery("sel_summultiplebanking_appno^"+strAppNo);
					rs=DBUtils.executeQuery(strQuery2);
					if(rs.next())
					{	hshValues.put("FbSum1",Helper.correctDouble((String)rs.getString("FbSum")));
						hshValues.put("NfbSum1",Helper.correctDouble((String)rs.getString("NfbSum")));
						hshValues.put("ExistSum1",Helper.correctDouble((String)rs.getString("ExistSum")));
						hshValues.put("ProFbSum1",Helper.correctDouble((String)rs.getString("ProFbSum")));
						hshValues.put("ProNfbSum1",Helper.correctDouble((String)rs.getString("ProNfbSum")));
						hshValues.put("ProSum1",Helper.correctDouble((String)rs.getString("ProSum")));
					}
					if(arrOutRow != null && arrOutRow.size()>0)
						arrOutRowCons.add(arrOutRow);
				}
				if(arrOutRowCons != null && arrOutRowCons.size()>0)
					hshValues.put("arrMultiBnk",arrOutRowCons);
			//}
				
				hshValues.put("arrLeaderBankTL",arrLeaderBankTL);
				hshValues.put("arrLeaderBankWC",arrLeaderBankWC);
				hshValues.put("arrOtherBankTL",arrOtherBankTL);
				hshValues.put("arrOtherBankWC",arrOtherBankWC);
				
				if((strBnkargWC.equalsIgnoreCase("C") && strTypeWC.equalsIgnoreCase("S"))||strBnkargWC.equalsIgnoreCase("M"))
				{

					arrOutRow	= new ArrayList();
					
					if(rs!=null){rs.close();}
					rs = DBUtils.executeLAPSQuery("sel_distinct_BAConsortium^"+strAppNo+"^1");
					while(rs.next())
					{
						double dblFundAmt=0.0,dblNFundAmt=0.0;
						arrOutCol	= new ArrayList();
						arrRow	= new ArrayList();
						String strbarnchname="",stremalid="";
						if(rs1!=null){rs1.close();}
						rs1 = DBUtils.executeLAPSQuery("select_BAConsortium^"+strAppNo+"^1^"+Helper.correctNull(rs.getString("bankcode")));
						while(rs1.next())
						{
							arrCol	= new ArrayList();
							arrCol.add(Helper.correctNull(rs1.getString("bank_name")));
							arrCol.add(Helper.correctNull(rs1.getString("com_con_int_rate")));
							arrCol.add(Helper.correctNull(rs1.getString("nature")));
							arrCol.add(Helper.correctNull(rs1.getString("asset_classification")));
							arrCol.add(Helper.correctNull(rs1.getString("COM_CON_BRANCH_NAME")));//13
							arrCol.add(Helper.correctNull(rs1.getString("COM_CON_EMAIL_ID")));//14
							if(rs2!=null){rs2.close();}
							rs2 = DBUtils.executeLAPSQuery("getstaticdescription^259^"+correctNull((String)rs1.getString("COM_CON_BRANCH_NAME")));
							if(rs2.next())
							{
								arrCol.add(Helper.correctNull(rs2.getString("stat_data_desc1")));//12
							}else
							{
								arrCol.add("");
							}
							arrRow.add(arrCol);
							if(correctNull(rs1.getString("com_con_fac_type")).equalsIgnoreCase("M"))
							{
								if(Helper.correctNull(rs1.getString("com_con_fac_nature")).equalsIgnoreCase("15"))
								{
									if(Helper.correctNull(rs1.getString("nature")).equalsIgnoreCase("F"))
										dblFundAmt+=Double.parseDouble(Helper.correctDouble(rs1.getString("com_con_limit")))/50;
									else if(Helper.correctNull(rs1.getString("nature")).equalsIgnoreCase("NF"))
										dblNFundAmt+=Double.parseDouble(Helper.correctDouble(rs1.getString("com_con_limit")))/50;
								}
								else
								{
									if(Helper.correctNull(rs1.getString("nature")).equalsIgnoreCase("F"))
										dblFundAmt+=Double.parseDouble(Helper.correctDouble(rs1.getString("com_con_limit")));
									else if(Helper.correctNull(rs1.getString("nature")).equalsIgnoreCase("NF"))
										dblNFundAmt+=Double.parseDouble(Helper.correctDouble(rs1.getString("com_con_limit")));
								}
							}
						
						}
						arrOutCol.add(arrRow);
						arrOutCol.add(dblFundAmt+"");
						arrOutCol.add(dblNFundAmt+"");
						arrOutRow.add(arrOutCol);
						
						}
					
					hshValues.put("arrConsortDet",arrOutRow);
					
					//Consortium Details
					if(rs!=null){rs.close();}
					rs = DBUtils.executeLAPSQuery("sel_BAConsortiumLead^"+strAppNo+"^"+strConSno);
					if(rs.next())
					{
						if(rs1!=null){rs1.close();}
						rs1 = DBUtils.executeLAPSQuery("getstaticdescription^147^"+correctNull((String)rs.getString("com_cons_bank_code")));
						if(rs1.next())
						{
							hshValues.put("com_cons_bank_name_WC",correctNull((String)rs1.getString("stat_data_desc1")));
						}
					}
				
				}
				if(strBnkargWC.equalsIgnoreCase("C") && strTypeWC.equalsIgnoreCase("M"))
				{
					ConSno	= Integer.parseInt(strNoWC);
					int intratecount=0;
					arrOutRowCons = new ArrayList();
					
					
					for(int i=1; i<=ConSno; i++)
					{
						ArrayList arrOutColCons = new ArrayList();
						arrOutRow=new ArrayList();
						if(rs!=null){rs.close();}
						rs = DBUtils.executeLAPSQuery("sel_distinct_BAConsortium^"+strAppNo+"^"+i);
						while(rs.next())
						{
							double dblFundAmt=0.0,dblNFundAmt=0.0;
							arrOutCol	= new ArrayList();
							arrRow	= new ArrayList();
							if(rs1!=null){rs1.close();}
							rs1 = DBUtils.executeLAPSQuery("select_BAConsortium^"+strAppNo+"^"+i+"^"+Helper.correctNull(rs.getString("bankcode")));
							while(rs1.next())
							{
								arrCol	= new ArrayList();
								arrCol.add(Helper.correctNull(rs1.getString("bank_name")));
								arrCol.add(Helper.correctNull(rs1.getString("com_con_int_rate")));
								arrCol.add(Helper.correctNull(rs1.getString("nature")));
								arrCol.add(Helper.correctNull(rs1.getString("asset_classification")));
								arrCol.add(Helper.correctNull(rs1.getString("COM_CON_BRANCH_NAME")));//13
								arrCol.add(Helper.correctNull(rs1.getString("COM_CON_EMAIL_ID")));//14
								if(rs2!=null){rs2.close();}
								rs2 = DBUtils.executeLAPSQuery("getstaticdescription^259^"+correctNull((String)rs1.getString("COM_CON_BRANCH_NAME")));
								if(rs2.next())
								{
									arrCol.add(Helper.correctNull(rs2.getString("stat_data_desc1")));//12
								}else
								{
									arrCol.add("");
								}
								arrRow.add(arrCol);
								
								if(correctNull(rs1.getString("com_con_fac_type")).equalsIgnoreCase("M"))
								{
									if(Helper.correctNull(rs1.getString("com_con_fac_nature")).equalsIgnoreCase("15"))
									{
										if(Helper.correctNull(rs1.getString("nature")).equalsIgnoreCase("F"))
											dblFundAmt+=Double.parseDouble(Helper.correctDouble(rs1.getString("com_con_limit")))/50;
										else if(Helper.correctNull(rs1.getString("nature")).equalsIgnoreCase("NF"))
											dblNFundAmt+=Double.parseDouble(Helper.correctDouble(rs1.getString("com_con_limit")))/50;
									}
									else
									{
										if(Helper.correctNull(rs1.getString("nature")).equalsIgnoreCase("F"))
											dblFundAmt+=Double.parseDouble(Helper.correctDouble(rs1.getString("com_con_limit")));
										else if(Helper.correctNull(rs1.getString("nature")).equalsIgnoreCase("NF"))
											dblNFundAmt+=Double.parseDouble(Helper.correctDouble(rs1.getString("com_con_limit")));
									}
								}
									
								
							}
							arrOutCol.add(arrRow);
							arrOutCol.add(dblFundAmt+"");
							arrOutCol.add(dblNFundAmt+"");
							arrOutRow.add(arrOutCol);
							}
						arrOutColCons.add(arrOutRow);
						arrOutRowCons.add(arrOutColCons);
						
						
						//Consortium Details
						strQuery2 = SQLParser.getSqlQuery("sel_BAConsortiumLead^"+strAppNo+"^"+i);
						if(rs!=null){rs.close();}
						rs = DBUtils.executeQuery(strQuery2);
						if(rs.next())
						{
							if(rs1!=null){rs1.close();}
							rs1 = DBUtils.executeLAPSQuery("getstaticdescription^147^"+correctNull((String)rs.getString("com_cons_bank_code")));
							while(rs1.next())
							{
								hshValues.put("com_cons_bank_name_WC"+i,correctNull((String)rs1.getString("stat_data_desc1")));
								arrLeaderBankWC.add(Helper.correctNull(rs1.getString("stat_data_desc1")));
								break;
							}
							hshValues.put("com_cons_asondate_WC",correctNull((String)rs.getString("com_cons_asondate")));
						}
						
					}
					hshValues.put("arrMultipleConsWC1",arrOutRowCons);
				}
			
		}
		catch (Exception e) {
			throw new EJBException("Error in getMultipleBanking" + e.getMessage());
		}
		return hshValues;
	}
	public HashMap getPostSanctionParameters(HashMap hshValues) 
	{
		ResultSet rs = null;
		ResultSet rs1 = null,rs2 = null; 
		int sel_facility=0;
		String strQuery="",strPageIdPSApp="",strParams="";
		ArrayList arrFacRow = new ArrayList();
		String strSessionModuleType = Helper.correctNull((String)hshValues.get("sessionModuleType"));
		try
		{			
			String appno=Helper.correctNull((String)hshValues.get("appno1"));
			String strFacilities=correctNull((String)hshValues.get("sel_facilitysno"));			
			
			if(appno.equalsIgnoreCase(""))
			{
				appno=Helper.correctNull((String)hshValues.get("appno"));
			}
			if(appno.equalsIgnoreCase("") || appno.equalsIgnoreCase("null")){
				appno=Helper.correctNull((String)hshValues.get("strappno"));
			}	
			if(strFacilities.equalsIgnoreCase(""))
				strFacilities="0";
			if(strSessionModuleType.equalsIgnoreCase("RET"))
				strFacilities="1";
			
			strQuery = SQLParser.getSqlQuery("sel_PS_oldaccnum^"+appno+"^ and PS_APP_SNO='"+strFacilities+"'");
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				hshValues.put("strSanctionTerms",Helper.correctNull(rs1.getString("PS_MODIFY_TERMS")));
			}
			hshValues.put("strFacSNo", strFacilities);
			
			if(rs!=null) rs.close();
			strQuery = SQLParser.getSqlQuery("sel_pageid_PSapp^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(strPageIdPSApp.equalsIgnoreCase(""))
					strPageIdPSApp = "@"+Helper.correctNull((String)rs.getString("ps_modify_pageid"));
				else
					strPageIdPSApp = strPageIdPSApp+Helper.correctNull((String)rs.getString("ps_modify_pageid"));
				
				if(strParams.equalsIgnoreCase(""))
					strParams = "@"+Helper.correctNull((String)rs.getString("ps_modify_terms"));
				else
					strParams = strParams+Helper.correctNull((String)rs.getString("ps_modify_terms"));
				
				if(strSessionModuleType.equalsIgnoreCase("RET"))
				{
					if(rs1!=null)
					rs1.close();
					rs1 = DBUtils.executeLAPSQuery("cnt_post_sanction_appl^" + Helper.correctNull(rs.getString("ps_old_app_no")));
					if(rs1.next())
					{
						hshValues.put("strAppCount", correctNull(rs1.getString("appno")));
					}
					
					if(rs1!=null)
					rs1.close();
					strQuery=SQLParser.getSqlQuery("selloanagainstparams^120");
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						if(Helper.correctNull(rs1.getString("LOAN_PARAMSLNO")).equalsIgnoreCase("119"))
							hshValues.put("strAppMaxCount", correctNull(rs1.getString("LOAN_PARAMVAL")));
					}
				}
				
			}
			
			if(strPageIdPSApp.equalsIgnoreCase(""))
				strPageIdPSApp="@1@";
			hshValues.put("Page_Id_PS", strPageIdPSApp);
			hshValues.put("strModifyterms", "@"+strParams);
			
			//To get loan type and staff loan check flag
			if(rs!=null) rs.close();
			strQuery = SQLParser.getSqlQuery("sel_postsancdetails^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("staffPrd", Helper.correctNull((String)rs.getString("PRD_STAFFPRD")));
				hshValues.put("PRD_TYPE", Helper.correctNull((String)rs.getString("PRD_TYPE")));
				hshValues.put("LOAN_INTTYPE", Helper.correctNull((String)rs.getString("LOAN_INTTYPE")));
				
				if(Helper.correctNull(rs.getString("prd_loantype")).equalsIgnoreCase("TL")||Helper.correctNull(rs.getString("prd_loantype")).equalsIgnoreCase("DL"))
				{
					hshValues.put("strCHDPOWER", "Y");
				}
				
				if(Helper.correctNull(rs.getString("scheme_code")).equalsIgnoreCase("ODGEN")||Helper.correctNull(rs.getString("scheme_code")).equalsIgnoreCase("DGDQ")||
						Helper.correctNull(rs.getString("scheme_code")).equalsIgnoreCase("ODPSA")||Helper.correctNull(rs.getString("scheme_code")).equalsIgnoreCase("ODPS")
						||Helper.correctNull(rs.getString("scheme_code")).equalsIgnoreCase("ODAG")||Helper.correctNull(rs.getString("scheme_code")).equalsIgnoreCase("ODSEC")
						||Helper.correctNull(rs.getString("scheme_code")).equalsIgnoreCase("ODSECPS"))
				{
					hshValues.put("strCHSCHEME", "Y");
				}
			}
			
			
			if(!strSessionModuleType.equalsIgnoreCase("RET"))
			{
				strQuery = SQLParser.getSqlQuery("sel_chck_lst_doc^"+appno+"^"+strFacilities);
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					if(Helper.correctNull(rs1.getString("COM_FACNATURE")).equalsIgnoreCase("2")&&(Helper.correctNull(rs1.getString("COM_FACILITY_LOANTYPE")).equalsIgnoreCase("TL")||Helper.correctNull(rs1.getString("COM_FACILITY_LOANTYPE")).equalsIgnoreCase("DL"))
							&&Helper.correctNull(rs1.getString("FACILITY_ACCOUNTOPEN")).equalsIgnoreCase("Y"))
					{
						hshValues.put("strCHDPOWER", "Y");
					}
					
					if(Helper.correctNull(rs1.getString("com_facility_emischeme")).equalsIgnoreCase("DGDQ")||Helper.correctNull(rs1.getString("com_facility_emischeme")).equalsIgnoreCase("ODGEN")||
							Helper.correctNull(rs1.getString("com_facility_emischeme")).equalsIgnoreCase("ODPSA")||Helper.correctNull(rs1.getString("com_facility_emischeme")).equalsIgnoreCase("ODPS")
							||Helper.correctNull(rs1.getString("com_facility_emischeme")).equalsIgnoreCase("ODAG")||Helper.correctNull(rs1.getString("com_facility_emischeme")).equalsIgnoreCase("ODSEC")
							||Helper.correctNull(rs1.getString("com_facility_emischeme")).equalsIgnoreCase("ODSECPS"))
					{
						hshValues.put("strCHSCHEME", "Y");
					}
				}
			}
			if(rs!=null) rs.close();
			strQuery = SQLParser.getSqlQuery("sel_postsancdetails_pendingfac^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				if(rs2!=null) rs2.close();
				strQuery = SQLParser.getSqlQuery("chk_subfacility^"+Helper.correctNull(rs.getString("PS_OLD_APP_SNO"))+"^"+Helper.correctNull(rs.getString("PS_OLD_APP_NO")));
				rs2 = DBUtils.executeQuery(strQuery);
				if(rs2.next())
				{
					if("0".equalsIgnoreCase(strFacilities))
					{
						hshValues.put("strFacSNo", Helper.correctNull(rs.getString("ps_app_sno")));
					}
				}
				else
				{
					hshValues.put("strPendingFac", "Y");
				}
			}
			hshValues.put("hidpage", "param");
			
			//To get the Migration required flag in Interest rate  
			if(rs!=null) rs.close();
			strQuery = SQLParser.getSqlQuery("sel_oldfac_processdate^" + appno + "^" + strFacilities);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				if(Integer.parseInt(Helper.correctInt((String)rs.getString("dayval")))<0)
				{
					hshValues.put("mclrmigreq", "Y");
				}
				if(Helper.correctNull((String)hshValues.get("LOAN_INTTYPE")).equalsIgnoreCase("Fixed"))
				{
					hshValues.put("mclrmigreq", "Y");
				}
			}
			
			if(rs!=null) rs.close();
			strQuery = SQLParser.getSqlQuery("sel_doc_FacRejCheck^" + appno + "^" + strFacilities);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("strFacGrp", Helper.correctInt(rs.getString("facility_group")));
			}
			
			// check post sanction parameter enable/disable starts
			 String livedate=ApplicationParams.getStrPostSancEnabDisablelivedate();
				String postsanctionflag="";
				String applicationStatus="";
				// check when application is created
				String appcreatedate="";
				if(appno.equalsIgnoreCase("NEW")){
					postsanctionflag="NEW";  // new application created on live date or  after live date,Mode of Payment has to come,NEW - New one
				}else{
					strQuery = SQLParser.getSqlQuery("getcreatedate^"+appno);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
						
						appcreatedate= rs.getString("createddate");
						applicationStatus= rs.getString("APP_STATUS");
					}
					System.out.println("Application created date-->"+appcreatedate);
					System.out.println("Post Sanction  Live Date-->"+livedate);
			       if(!livedate.equalsIgnoreCase("") && !appcreatedate.equalsIgnoreCase("")){
					 String Pattern="dd/MM/yyyy";
						DateFormat df=new SimpleDateFormat(Pattern);
						Date appcreationdate=df.parse(appcreatedate);
						Date postsanclivedate=df.parse(livedate);
						if(appcreationdate.before(postsanclivedate) && applicationStatus.equalsIgnoreCase("op"))
						{
							postsanctionflag="EOP";  // existing old open/pending application,data has to come based on enable/disablein setup and also saved parameters  must come infront end,EOP - exiting open pending
						}
						if(appcreationdate.before(postsanclivedate) && applicationStatus.equalsIgnoreCase("pa"))
						{
							postsanctionflag="EPA"; // existing old approved application,data should not come based on enable/disablein setup,EPA - existing process approved/undo
						}
						if(appcreationdate.equals(postsanclivedate) || appcreationdate.after(postsanclivedate))
						{
							postsanctionflag="NEW";    // new applcication created on live date or  after live date,data has to come based on enable/disablein setup,NEW - New one
						}
			       }
					
				}
				
		       hshValues.put("postSanctionFlag", postsanctionflag);
		       System.out.println("Post Sanction Flag-->"+postsanctionflag);
		    // ends
		       
		       // check params enabled in post sanction setup starts
		       Map<String,String> paramenableMap=new HashMap<String,String>();
		       Map<String,String> paramDescriptionMap=new HashMap<String,String>();
		       Map<String,String> setupParamMap=new HashMap<String,String>();
		       String strTemp="";
		     if(strSessionModuleType.equalsIgnoreCase("CORP")){
		    	 strTemp="'C'";
		    	 }else{
				strTemp="'P'";
					}
		    	
		    	
		    			strQuery = SQLParser.getSqlQuery("sel_PostSancparamertersCorp^"+strTemp);
						rs = DBUtils.executeQuery(strQuery);
						while (rs.next()) {
							String paramId= rs.getString("PS_PARAM_ID");
							String flag= rs.getString("PS_ENABLE_DISABLE_FLAG");
							String paramdesc= rs.getString("PS_PARAM_DESC");
							paramenableMap.put(paramId, flag); // stores all flags of Enable and disable of paramIDS
							setupParamMap.put(paramId, flag); // stores all flags of Enable and disable of paramIDS
							paramDescriptionMap.put(paramId, paramdesc); // stores all param description of paramIDS
						}
		    	 hshValues.put("setupParamMap", paramenableMap); // original setup data
		       // ends
		    	 
		    	 // check save paramters in APP_POST_SANCTION that marked as disable in setup
		    	 String insertedparam="";
		    	 StringBuilder insertedParamters=new StringBuilder();
		    	 if(!strParams.equalsIgnoreCase("")){
		    		String[] savedparamArray= strParams.split("@");
		    		if(savedparamArray.length > 0){
		    			for(int i=0;i<savedparamArray.length;i++){
		    				
		    				if(!savedparamArray[i].equalsIgnoreCase("")){
		    					if(paramenableMap.containsKey(savedparamArray[i])){
			    					String flag=paramenableMap.get(savedparamArray[i]);
			    					if(flag.equalsIgnoreCase("D")){ // get disable paramids
			    						String paramdesc=paramDescriptionMap.get(savedparamArray[i]); // get description of paramids
			    						insertedParamters.append(paramdesc);
				    					insertedParamters.append(",");
				    					paramenableMap.put(savedparamArray[i], "E"); // override eventhough it is marked as D in setup but to display marked as E.
			    					}
			    					
			    				}else{
			    					paramenableMap.put(savedparamArray[i], "E"); // added into because it is saved in APP_POST_SANCTION for display 
			    				}
			    			}
		    				}
		    				
		    			 insertedparam=insertedParamters.toString();
		    			 if(!insertedparam.equalsIgnoreCase("")){
		    				 insertedparam = insertedparam.substring(0, insertedparam.length() - 1); 
		    			 }
		    			
		    		}
		    	 }
		    	 hshValues.put("insertedParamters", insertedparam);
		    	 hshValues.put("paramenableMap", paramenableMap);
		    	 //ends
		} 		
		catch (Exception e) 
		{
			throw new EJBException(e.getMessage());
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
			catch (Exception cf) 
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}		
		return hshValues;
	}
	public void updatePostSanctionParameters(HashMap hshValues) 
	{
		ResultSet rs = null;
		ResultSet rs1 = null; 
		HashMap hshRecord = new HashMap();		
		int sel_facility=0;
		String strQuery="",strPSparams="",strPageIdPS="";
		String strSessionModuleType = Helper.correctNull((String)hshValues.get("sessionModuleType"));
		try
		{			
			String appno=Helper.correctNull((String)hshValues.get("appno1"));
			String strFacilities=correctNull((String)hshValues.get("sel_facilitysno"));			
			
			if(appno.equalsIgnoreCase(""))
			{
				appno=Helper.correctNull((String)hshValues.get("appno"));
			}
			if(appno.equalsIgnoreCase("") || appno.equalsIgnoreCase("null")){
				appno=Helper.correctNull((String)hshValues.get("strappno"));
			}	
			if(strFacilities.equalsIgnoreCase(""))
				strFacilities="0";
			
			if(strSessionModuleType.equalsIgnoreCase("RET"))
				strFacilities="1";
			
			strPSparams="";
			StringTokenizer st = new StringTokenizer(Helper.correctNull((String)hshValues.get("hidParameters")),"@");
			while(st.hasMoreElements())
			{
				if(strPSparams.equalsIgnoreCase(""))
					strPSparams = "'"+(String)st.nextElement()+"'";
				else
					strPSparams = strPSparams+",'"+(String)st.nextElement()+"'";
			}
			if(!strPSparams.equalsIgnoreCase(""))
			{
				if(strSessionModuleType.equalsIgnoreCase("RET"))
					strQuery = SQLParser.getSqlQuery("selretailpageid_PS^"+strPSparams);
				else
					strQuery = SQLParser.getSqlQuery("sel_pageid_PS^"+strPSparams);
				rs = DBUtils.executeQuery(strQuery);
				strPageIdPS = "";
				while(rs.next())
				{
					if(strPageIdPS.equalsIgnoreCase(""))
						strPageIdPS = Helper.correctNull((String)rs.getString("ps_pageid"));
					else
						strPageIdPS = strPageIdPS+Helper.correctNull((String)rs.getString("ps_pageid"));
				}
			}
			if(!strPageIdPS.equalsIgnoreCase(""))
			{
				ArrayList arrValues=new ArrayList();
				HashMap hshQuery=new HashMap();
				HashMap hshQueryValues=new HashMap();
				hshQuery.put("strQueryId","upd_apppostsanction");
				arrValues.add(Helper.correctNull((String)hshValues.get("hidParameters")));
				arrValues.add(strPageIdPS);
				arrValues.add(appno);
				arrValues.add(strFacilities);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
		} 		
		catch (Exception e) 
		{
			throw new EJBException(e.getMessage());
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
			catch (Exception cf) 
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}		
	}
	
	public HashMap getLimitOfTLData(HashMap hshValues) 
	{	
		ResultSet rs = null, rs1 = null;
		HashMap hshRecord = null;
		ArrayList arrRow	= new ArrayList();
		ArrayList arrCol	= new ArrayList();
		
		try
		{
			String appno	= correctNull((String)hshValues.get("appno"));
			String consortiumtype = correctNull((String)hshValues.get("consortiumtype"));
			String bankcode = correctNull((String)hshValues.get("bankcode"));
			
			rs = DBUtils.executeLAPSQuery("sel_FacNature_tl^"+appno+"^"+consortiumtype+"^"+bankcode);
			hshRecord = new HashMap();
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("com_con_fac_nature")));
				
				if(rs1!=null){rs1.close();}
				rs1 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^144^"+correctNull(rs.getString("com_con_fac_nature")));
				
				if(!rs1.next())
				{
					arrCol.add("");
				}
				rs1.beforeFirst();
				while(rs1.next())
				{
					arrCol.add(correctNull(rs1.getString("stat_data_desc1")));
					break;
				}
				
				arrRow.add(arrCol);	
			}
			
			
			hshRecord.put("arrRow",arrRow);				
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getLimitOfData "+ce.toString());
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
	
	public HashMap getLimitOfData(HashMap hshValues) 
	{	
		ResultSet rs = null, rs1 = null;
		HashMap hshRecord = null;
		ArrayList arrRow	= new ArrayList();
		ArrayList arrCol	= new ArrayList();
		
		try
		{
			String appno	= correctNull((String)hshValues.get("appno"));
			String consortiumtype = correctNull((String)hshValues.get("consortiumtype"));
			String bankcode = correctNull((String)hshValues.get("bankcode"));
			
			rs = DBUtils.executeLAPSQuery("sel_FacNature^"+appno+"^"+consortiumtype+"^"+bankcode);
			hshRecord = new HashMap();
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("com_con_fac_nature")));
				
				if(rs1!=null){rs1.close();}
				rs1 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^144^"+correctNull(rs.getString("com_con_fac_nature")));
				
				if(!rs1.next())
				{
					arrCol.add("");
				}
				rs1.beforeFirst();
				while(rs1.next())
				{
					arrCol.add(correctNull(rs1.getString("stat_data_desc1")));
					break;
				}
				
				arrRow.add(arrCol);	
			}
			
			
			hshRecord.put("arrRow",arrRow);				
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getLimitOfData "+ce.toString());
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