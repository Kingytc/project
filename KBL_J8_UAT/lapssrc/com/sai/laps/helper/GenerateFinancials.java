package com.sai.laps.helper;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;

public class GenerateFinancials
{
	public static void GenerateMCMFinancials(HashMap hshValues) throws Exception
	{
		ResultSet rs=null;
		
		String strAppno="";
		String strPage="";
		String strDivId="";
		String strQuery="";
		String strCMA="";
		String strDate="";
		String strYear="";
		String strYear1="";
		
		String strDesc="";
		String strPrevDesc="";
		String strPrevDesc1="";
		String strNextDesc="";
		String strNextDesc2="";
		
		String strDescription="";
		String strPrevDescription="";
		String strPrevDescription1="";
		String strNextDescription="";
		String strNextDescription2="";
		
		String strCurDate="";
		String strPrevDate="";
		String strPrevDate1="";
		String strNextDate="";	
		String strNextDate2="";
		
		
		int intCount=0;
		int intupdatesize=0;
		
		ArrayList arrValues=new ArrayList();
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();

		try
		{			
			strAppno=Helper.correctNull((String)hshValues.get("appno"));
			strPage =Helper.correctNull((String)hshValues.get("flowtype"));
			strDivId=Helper.correctNull((String)hshValues.get("sel_divID"));
			if(strDivId.equalsIgnoreCase(""))
			{
				strDivId="0";
			}
			
			strQuery = SQLParser.getSqlQuery("executive_finselect1^"+strAppno+"^"+strDivId);
			if(rs!=null)
				rs.close();
			
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{  
				intCount=rs.getInt("cnt");
			}
			
			if(intCount>0)
			{
				strQuery=SQLParser.getSqlQuery("comfintrendsel1^"+strAppno);
				
				if(rs!=null)
					rs.close();

				rs = DBUtils.executeQuery(strQuery);
					 
				if(rs.next())
				{  
					strCMA=Helper.correctNull(rs.getString("demo_finstandard"));
				}
				
				if(rs!=null)
					rs.close();
					
				strQuery = SQLParser.getSqlQuery("sel_financial_baseyear^"+strAppno);
				rs = DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{	
					strDate=Helper.correctNull((String)rs.getString("base_year"));
					strYear=Helper.correctNull((String)rs.getString("year"));
					strYear1=Helper.correctNull((String)rs.getString("year"));
				}
				
				if(rs!=null)
					rs.close();
				strQuery = SQLParser.getSqlQuery("executive_finselect9^"+strAppno+"^"+strDivId+"^"+strDate);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					if(rs.getDouble("sumaudit")>0)
					{
						strDesc="a";
						strDescription="Audited";
					}
					else if(rs.getDouble("sumunaudit")>0)
					{
						strDesc="u";
						strDescription="Unaudited";
					}
					else if(rs.getDouble("sumestimated")>0)
					{
						strDesc="e";
						strDescription="Estimated";
					}
					else if(rs.getDouble("sumprojection")>0)
					{
						strDesc="p";
						strDescription="Projection";
					}
					strCurDate=rs.getString("fin_year");
				}
				
				strQuery = SQLParser.getSqlQuery("noteassessselect10^"+strAppno+"^"+strDivId);
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeQuery(strQuery);
				
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(rs.getString(1));
					arrRow.add(arrCol);
				}	
				
				int checkYear=0;
				int count=0;
				checkYear=Integer.parseInt(Helper.correctInt(strYear));
		      	
				for(int x=1;x<=arrRow.size();x++)
		    	{
					count=count+1;			
					if(count>2)				
						break;
					
					checkYear=checkYear-1;
					
					if(rs!=null)
						rs.close();
					
					strQuery = SQLParser.getSqlQuery("executive_finselect11^"+strAppno+"^"+strDivId+"^"+checkYear);
					
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						if(rs.getDouble("sumaudit")>0)
						{
							strPrevDesc="a";
							strPrevDescription="Audited";
						}
						else if(rs.getDouble("sumunaudit")>0)
						{
							strPrevDesc="u";
							strPrevDescription="Unaudited";
						}
						else if(rs.getDouble("sumestimated")>0)
						{
							strPrevDesc="e";
							strPrevDescription="Estimated";
						}
						else if(rs.getDouble("sumprojection")>0)
						{
							strPrevDesc="p";
							strPrevDescription="Estimated";
						}
						strPrevDate=rs.getString("fin_year");

					}
					else
					{
						strPrevDate="";
						strPrevDesc="";
						strPrevDescription="";
					}
					if(!strPrevDesc.trim().equals("") && strPrevDate1.trim().equals(""))
					{
						strPrevDate1=strPrevDate;
						strPrevDesc1=strPrevDesc;	
						strPrevDescription1=strPrevDescription;
					}
				}
				
				int chkYear=0;			
				
				chkYear=Integer.parseInt(Helper.correctInt(strYear1));
				
				for(int y=1;y<=2;y++)
				{
					chkYear=chkYear+1;
					
					if(rs!=null)
						rs.close();
					
					strQuery = SQLParser.getSqlQuery("executive_finselect11^"+strAppno+"^"+strDivId+"^"+chkYear);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						if(rs.getDouble("sumaudit")>0)
						{
							strNextDesc="a";
							strNextDescription="Audited";
						}
						else if(rs.getDouble("sumunaudit")>0)
						{
							strNextDesc="u";
							strNextDescription="Unaudited";
						}
						else if(rs.getDouble("sumestimated")>0)
						{
							strNextDesc="e";
							strNextDescription="Estimated";
						}
						else if(rs.getDouble("sumprojection")>0)
						{
							strNextDesc="p";
							strNextDescription="Projected";
						}
						strNextDate=rs.getString("fin_year");
					}
					else
					{
						strNextDate="";
						strNextDesc="";
						strNextDescription="";
					}
					if(!strNextDesc.trim().equals("") && strNextDate2.trim().equals(""))
					{
						strNextDate2=strNextDate;
						strNextDesc2=strNextDesc;
						strNextDescription2=strNextDescription;
					}
				}
				/*****************************************************************
				 * Inserting into the tables with deleteion and insertion
				 */
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intupdatesize++;
				hshQuery.put("strQueryId","del_execfin");
				arrValues.add(strAppno);
				arrValues.add(strDivId);
				arrValues.add(strPage);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intupdatesize,hshQuery);
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intupdatesize++;
				hshQuery.put("strQueryId","ins_execfin");
				
				arrValues.add(strAppno);
				arrValues.add(strDivId);
				arrValues.add(strPage);
				arrValues.add(""+(intupdatesize-1));
				arrValues.add("H");
				arrValues.add("");
				arrValues.add("<div align='center'><b>Particulars</b></div>");
				arrValues.add(strPrevDate);
				arrValues.add(strPrevDate1);
				arrValues.add(strDate);
				arrValues.add(strNextDate2);
				arrValues.add(strNextDate);
				arrValues.add("0.00");
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intupdatesize,hshQuery);
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intupdatesize++;
				hshQuery.put("strQueryId","ins_execfin");
				
				arrValues.add(strAppno);
				arrValues.add(strDivId);
				arrValues.add(strPage);
				arrValues.add(""+(intupdatesize-1));
				arrValues.add("H");
				arrValues.add("");
				arrValues.add("");
				arrValues.add(strPrevDescription);
				arrValues.add(strPrevDescription1);
				arrValues.add(strDescription);
				arrValues.add(strNextDescription2);
				arrValues.add(strNextDescription);
				arrValues.add("0.00");
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intupdatesize,hshQuery);
				/*****************************************************************
				 * Inserting into the tables with deleteion and insertion
				 */
				if(rs!=null)
					rs.close();
				
				strQuery = SQLParser.getSqlQuery("noteassessselect1^"+strCMA+"^"+strPage);
				rs=DBUtils.executeQuery(strQuery);
				String strRowtype="";
				String strRowid="";
				String strRowdesc="";
				int strRowformula=0;
				while (rs.next())
				{
					
					strRowtype=Helper.correctNull(rs.getString("fin_rowtype"));
					strRowid=Helper.correctNull(rs.getString("fin_rowid"));
					strRowdesc=Helper.correctNull(rs.getString("fin_rowdesc"));
					strRowformula=rs.getInt("fin_formula");
					HashMap hshResult=new HashMap();
					
					
					String strPrevValue="";
					String strPrevValue1="";
					String strCurrValue="";
					String strNextValue="";
					String strNextValue2="";
					
					if ((strRowtype.trim().equals("FO") || strRowtype.trim().equals("C")) && strRowformula>0 && !strDesc.trim().equals(""))
					{						
						HashMap hshformula =  new HashMap();
						hshformula.put("appno",strAppno);
						hshformula.put("sel_divID",strDivId);
						hshformula.put("formulaid",Integer.toString(strRowformula));
						hshformula.put("curryear",strCurDate);
						hshformula.put("prevyear","");
						hshformula.put("currfinancialtype",strDesc);
						hshformula.put("prevfinancialtype","");
						
						hshResult=new HashMap();
						hshResult = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
						strCurrValue=Helper.correctNull((String)hshResult.get("strTotalValue"));
					}
					if ( (strRowtype.trim().equals("FO")|| strRowtype.trim().equals("C")) && strRowformula>0 && !strPrevDesc.trim().equals(""))
					{
						
						HashMap hshformula =  new HashMap();
						hshformula.put("appno",strAppno);
						hshformula.put("sel_divID",strDivId);
						hshformula.put("formulaid",Integer.toString(strRowformula));
						hshformula.put("curryear",strPrevDate);
						hshformula.put("prevyear","");
						hshformula.put("currfinancialtype",strPrevDesc);
						hshformula.put("prevfinancialtype","");
						
						hshResult=new HashMap();
						hshResult = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
						strPrevValue = Helper.correctNull((String)hshResult.get("strTotalValue"));
					}
					if ((strRowtype.trim().equals("FO")|| strRowtype.trim().equals("C"))&& strRowformula>0 && !strPrevDesc1.trim().equals(""))
					{
						HashMap hshformula =  new HashMap();
						hshformula.put("appno",strAppno);
						hshformula.put("sel_divID",strDivId);
						hshformula.put("formulaid",Integer.toString(strRowformula));
						hshformula.put("curryear",strPrevDate1);
						hshformula.put("prevyear","");
						hshformula.put("currfinancialtype",strPrevDesc1);
						hshformula.put("prevfinancialtype","");
						
						hshResult=new HashMap();
						hshResult=(HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
						strPrevValue1= Helper.correctNull((String)hshResult.get("strTotalValue"));
					}
					if ((strRowtype.trim().equals("FO")|| strRowtype.trim().equals("C")) && strRowformula>0 && !strNextDesc.trim().equals(""))
					{
						
						HashMap hshformula =  new HashMap();
						hshformula.put("appno",strAppno);
						hshformula.put("sel_divID",strDivId);
						hshformula.put("formulaid",Integer.toString(strRowformula));
						hshformula.put("curryear",strNextDate);
						hshformula.put("prevyear","");
						hshformula.put("currfinancialtype",strNextDesc);
						hshformula.put("prevfinancialtype","");
						
						hshResult=new HashMap();
						hshResult=(HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
						strNextValue = Helper.correctNull((String)hshResult.get("strTotalValue"));
					}
					if ((strRowtype.trim().equals("FO")|| strRowtype.trim().equals("C")) && strRowformula>0 && !strNextDesc2.trim().equals(""))
					{
						
						HashMap hshformula =  new HashMap();
						hshformula.put("appno",strAppno);
						hshformula.put("sel_divID",strDivId);
						hshformula.put("formulaid",Integer.toString(strRowformula));
						hshformula.put("curryear",strNextDate2);
						hshformula.put("prevyear","");
						hshformula.put("currfinancialtype",strNextDesc2);
						hshformula.put("prevfinancialtype","");
						
						hshResult=new HashMap();
						hshResult=(HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
						strNextValue2 = Helper.correctNull((String)hshResult.get("strTotalValue"));
					}
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					intupdatesize++;
					hshQuery.put("strQueryId","ins_execfin");
					
					arrValues.add(strAppno);
					arrValues.add(strDivId);
					arrValues.add(strPage);
					arrValues.add(""+(intupdatesize-1));
					arrValues.add(strRowtype);
					arrValues.add(strRowid);
					arrValues.add(strRowdesc);
					arrValues.add(strPrevValue);
					arrValues.add(strPrevValue1);
					arrValues.add(strCurrValue);
					arrValues.add(strNextValue2);
					arrValues.add(strNextValue);
					arrValues.add("0.00");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intupdatesize,hshQuery);
					
				}
				
				hshQueryValues.put("size",""+intupdatesize);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
		}
		catch(Exception Ex)
		{
			throw new EJBException("Error in GenerateMCMFinancials :: "+Ex.toString());
		}
	}
}