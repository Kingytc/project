package com.sai.laps.ejb.corpexecutivesummarytwopdf;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
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

@Stateless(name = "ExecutiveSummaryTwoBean", mappedName = "ExecutiveSummaryTwoHome")
@Remote (ExecutiveSummaryTwoRemote.class)
public class ExecutiveSummaryTwoBean extends BeanAdapter {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	


	static Logger log=Logger.getLogger(ExecutiveSummaryTwoBean.class);	

	
	public HashMap getFinancialData(HashMap hshRequestValues)  
	{
		

		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ResultSet rs5 = null;
		ResultSet rs7 = null;	
		ResultSet rs10 = null;
		ResultSet rs11 = null;
		ResultSet rs12 = null;
		ResultSet rs13 = null;
		
		HashMap hshValues=null;
		String strQuery="",strValue="";
		ArrayList arr=new ArrayList();
		ArrayList arrVal=new ArrayList();
		String sel_divID="";
		int str=0;
		
		
	try
	{			
		strValue=correctNull((String)hshRequestValues.get("appno"));
		String page = correctNull((String)hshRequestValues.get("flowtype"));
		if(page.equals(""))
		{
			page="FI";
		}
		sel_divID=correctNull((String)hshRequestValues.get("sel_divID"));
		if(sel_divID.equalsIgnoreCase("") || sel_divID.equalsIgnoreCase("null"))
		{
			sel_divID="0";
		}
		
		rs1=null;
		
		hshValues = new HashMap();
		ArrayList vecVal=new ArrayList();
		ArrayList vecVal1=new ArrayList();
		ArrayList vecVal2=new ArrayList();
		ArrayList vecVal3=new ArrayList();
		ArrayList vecVal4=new ArrayList();
		ArrayList vecVal5=new ArrayList();
		ArrayList vecVal41=new ArrayList();
		ArrayList vecVal51=new ArrayList();
		ArrayList vecVal6=new ArrayList();
		ArrayList vecVal7=new ArrayList();
	
		ArrayList vecrec=new ArrayList();
	
		ArrayList vecid = new ArrayList();
		ArrayList vecdesc = new ArrayList();
		ArrayList vectype = new ArrayList();

		//-------------- to find the time of review-----------------
	
		strQuery = SQLParser.getSqlQuery("executive_finselect1^"+strValue+"^"+sel_divID);
		if(rs!=null)
			rs.close();
		
		rs = DBUtils.executeQuery(strQuery);
		while(rs.next())
		{  
			str=rs.getInt("cnt");
		}
		

		//--------------- to find the cma format of the particular applications-------
		if(	rs!=null)
		{
			rs.close();
			
		}
		String cma="";
		//strQuery = SQLParser.getSqlQuery("notefinselect8^"+strValue);
		strQuery=SQLParser.getSqlQuery("comfintrendsel1^"+strValue);
		
		if(rs!=null)
			rs.close();

		rs = DBUtils.executeQuery(strQuery);
			 
		if(rs.next())
		{  
			cma=correctNull(rs.getString("demo_finstandard"));
			//cma=rs.getString("cma_no");
		}
		/*if (cma.trim().equals(""))
		{
			cma="4";
		}*/
			
		String strDate=""; 
		String strYear=""; 
		String strYear1="";
		/*String moncurryear="";
		int monthcurryear=0;
		
			strQuery = SQLParser.getSqlQuery("selmon_curyear");
			if(rs12!=null)
				rs12.close();
			rs12=DBUtils.executeQuery(strQuery);
			if(rs12.next())
			{
				moncurryear=rs12.getString("mon_curryear");
			}
			monthcurryear=Integer.parseInt(moncurryear);
		
			if (monthcurryear>3)
			{			
				strQuery = SQLParser.getSqlQuery("noteassessselect5");
				if(rs7!=null)
					rs7.close();
				
				rs7=DBUtils.executeQuery(strQuery);
				if(rs7.next())
				{
					strDate=rs7.getString("dat");
					int valcon=Integer.parseInt(val)+1;
					val=Integer.toString(valcon);
					//strDate=val1.concat(val);					
					strYear=rs7.getString("txtyear");
					strYear1=rs7.getString("txtyear");					
				}
				
			}
					
			else
			{
				strQuery = SQLParser.getSqlQuery("noteassessselect5");
				if(rs7!=null)
					rs7.close();
				rs7=DBUtils.executeQuery(strQuery);
				if(rs7.next())
				{
					strDate=rs7.getString("dat");
					strYear=rs7.getString("txtyear");
					strYear1=rs7.getString("txtyear");					
				}
				
			}*/
		
			/**
			 * Get the Base Year
			 * by venu
			 */
			if(rs!=null)
			rs.close();
			
			String baseyear_query = SQLParser.getSqlQuery("sel_financial_baseyear^"+strValue);
			rs = DBUtils.executeQuery(baseyear_query);
			if(rs.next())
			{	
				strDate=Helper.correctNull((String)rs.getString("base_year"));
				strYear=Helper.correctNull((String)rs.getString("year"));
				strYear1=Helper.correctNull((String)rs.getString("year"));
			}
			if(rs!=null){
				rs.close();
			}
			/**
			 * end
			 */
			
		strQuery = SQLParser.getSqlQuery("executive_finselect9^"+strValue+"^"+sel_divID+"^"+strDate);
		if(rs5!=null)
			rs5.close();
		rs5=DBUtils.executeQuery(strQuery);
		
		String strDesc="";
		String strCurDate="";
		if(rs5.next())
		{
			if(rs5.getDouble("sumaudit")>0)
			{
				strDesc="a";
			}
			else if(rs5.getDouble("sumunaudit")>0)
			{
				strDesc="u";
			}
			else if(rs5.getDouble("sumestimated")>0)
			{
				strDesc="e";
			}
			else if(rs5.getDouble("sumprojection")>0)
			{
				strDesc="p";
			}
			strCurDate=rs5.getString("fin_year");

		}
			strQuery = SQLParser.getSqlQuery("noteassessselect10^"+strValue+"^"+sel_divID);
			if(rs10!=null)
				rs10.close();
			rs10=DBUtils.executeQuery(strQuery);
			
			
		while(rs10.next())
		{
			arr=new ArrayList();
			arr.add(rs10.getString(1));
			arrVal.add(arr);
		}			

		
		int checkYear=0;
		int count=0;
		String strPrevDesc="";
		String strPrevDate="";
		String strPrevDesc1="";
		String strPrevDate1="";
		checkYear=Integer.parseInt(Helper.correctInt(strYear));
      	for(int x=1;x<=arrVal.size();x++)
    	{
			count=count+1;			
			if(count>2)				
			break;
			
			checkYear=checkYear-1;
			
			strQuery = SQLParser.getSqlQuery("executive_finselect11^"+strValue+"^"+sel_divID+"^"+checkYear);
			if(rs11!=null)
				rs11.close();
			rs11=DBUtils.executeQuery(strQuery);
			if(rs11.next())
			{
				if(rs11.getDouble("sumaudit")>0)
				{
					strPrevDesc="a";
				}
				else if(rs11.getDouble("sumunaudit")>0)
				{
					strPrevDesc="u";
				}
				else if(rs11.getDouble("sumestimated")>0)
				{
					strPrevDesc="e";
				}
				else if(rs11.getDouble("sumprojection")>0)
				{
					strPrevDesc="p";
				}
				strPrevDate=rs11.getString("fin_year");

			}
			else
			{
				strPrevDate="";
				strPrevDesc="";
			}
			if(!strPrevDesc.trim().equals("") && strPrevDate1.trim().equals(""))
			{
				strPrevDate1=strPrevDate;
				strPrevDesc1=strPrevDesc;				
			}
				//break;
	}

			
			int chkYear=0;			
			String strNextDesc="";
			String strNextDate="";	
			String strNextDesc2="";
			String strNextDate2="";
			chkYear=Integer.parseInt(Helper.correctInt(strYear1));
			
	for(int y=1;y<=2;y++)
	{
			chkYear=chkYear+1;
			strQuery = SQLParser.getSqlQuery("executive_finselect11^"+strValue+"^"+sel_divID+"^"+chkYear);
			if(rs12!=null)
				rs12.close();
			rs12=DBUtils.executeQuery(strQuery);
			if(rs12.next())
			{
				if(rs12.getDouble("sumaudit")>0)
				{
					strNextDesc="a";
				}
				else if(rs12.getDouble("sumunaudit")>0)
				{
					strNextDesc="u";
				}
				else if(rs12.getDouble("sumestimated")>0)
				{
					strNextDesc="e";
				}
				else if(rs12.getDouble("sumprojection")>0)
				{
					strNextDesc="p";
				}
				strNextDate=rs12.getString("fin_year");

			}
			else
			{
				strNextDate="";
				strNextDesc="";
			}
			if(!strNextDesc.trim().equals("") && strNextDate2.trim().equals(""))
			{
				strNextDate2=strNextDate;
				strNextDesc2=strNextDesc;				
			}
			
			
	}

				strQuery = SQLParser.getSqlQuery("noteassessselect1^"+cma+"^"+page);
				
				if(rs2!=null)
					rs2.close();
				rs2=DBUtils.executeQuery(strQuery);
				String strRowtype="";
				String strRowid="";
				int strRowformula=0;
				int strRowformula2=0;
				vecVal  = new ArrayList();
				vecVal1 = new ArrayList();
				vecVal2 = new ArrayList();
				vecVal3 = new ArrayList();
				vecVal4 = new ArrayList();
				vecVal5 = new ArrayList();
				vecVal41 = new ArrayList();
				vecVal51 = new ArrayList();
				vecVal6 = new ArrayList();
				vecVal7 = new ArrayList();
				vecid   = new ArrayList();
				vecdesc = new ArrayList();
				vectype = new ArrayList();
				while (rs2.next())
				{
					strRowtype=correctNull(rs2.getString("fin_rowtype"));
					strRowid=correctNull(rs2.getString("fin_rowid"));
					strRowformula=rs2.getInt("fin_formula");
					strRowformula2=rs2.getInt("fin_formula2");
					vectype.add(strRowtype);
					
					String strX="";
					
					if ((strRowtype.trim().equals("FO") || strRowtype.trim().equals("C")) && strRowformula>0 && !strDesc.trim().equals(""))
					{						
						HashMap hshformula =  new HashMap();
						hshformula.put("appno",strValue);
						hshformula.put("sel_divID",sel_divID);
						hshformula.put("formulaid",Integer.toString(strRowformula));
						hshformula.put("curryear",strCurDate);
						hshformula.put("prevyear","");
						hshformula.put("currfinancialtype",strDesc);
						hshformula.put("prevfinancialtype","");
						HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
						strX=correctNull((String)hshRes.get("strTotalValue"));
						vecVal.add(strX);
						vecid.add(correctNull(rs2.getString("fin_rowid")));
						vecdesc.add(correctNull(rs2.getString("fin_rowdesc")));
						
					}// if IC

					else
					{
						vecVal.add("0.00");
						vecid.add(correctNull(rs2.getString("fin_rowid")));
						vecdesc.add(correctNull(rs2.getString("fin_rowdesc")));
					}
						
						String strY="";
					 if ((strRowtype.trim().equals("FO") || strRowtype.trim().equals("C"))&& strRowformula2>0 && !strDesc.trim().equals(""))
					{
						
						HashMap hshformula1 =  new HashMap();
						hshformula1.put("appno",strValue);
						hshformula1.put("sel_divID",sel_divID);
						hshformula1.put("formulaid",Integer.toString(strRowformula2));
						hshformula1.put("curryear",strCurDate);
						hshformula1.put("prevyear","");
						hshformula1.put("currfinancialtype",strDesc);
						hshformula1.put("prevfinancialtype","");
						HashMap hshRes1 = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula1,"GetFinValue");
						strY = correctNull((String)hshRes1.get("strTotalValue"));						
						vecVal1.add(strY);
					}
					else
					{
							vecVal1.add("0.00");
					}
					// for prev year
					
					String strZ="";
					
					if ( (strRowtype.trim().equals("FO")|| strRowtype.trim().equals("C")) && strRowformula>0 && !strPrevDesc.trim().equals(""))
					{
						
						HashMap hshformula =  new HashMap();
						hshformula.put("appno",strValue);
						hshformula.put("sel_divID",sel_divID);
						hshformula.put("formulaid",Integer.toString(strRowformula));
						hshformula.put("curryear",strPrevDate);
						hshformula.put("prevyear","");
						hshformula.put("currfinancialtype",strPrevDesc);
						hshformula.put("prevfinancialtype","");
						HashMap hshRes2 = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
						strZ = correctNull((String)hshRes2.get("strTotalValue"));
						vecVal2.add(strZ);
					}// if IC

					else
					{
						vecVal2.add("0.00");						
					}
							
						String strA="";
					 if ((strRowtype.trim().equals("FO")|| strRowtype.trim().equals("C")) && strRowformula2>0 && !strPrevDesc.trim().equals(""))
					{
						
						HashMap hshformula1 =  new HashMap();
						hshformula1.put("appno",strValue);
						hshformula1.put("sel_divID",sel_divID);
						hshformula1.put("formulaid",Integer.toString(strRowformula2));
						hshformula1.put("curryear",strPrevDate);
						hshformula1.put("prevyear","");
						hshformula1.put("currfinancialtype",strPrevDesc);
						hshformula1.put("prevfinancialtype","");
						HashMap hshRes3 = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula1,"GetFinValue");
						strA = correctNull((String)hshRes3.get("strTotalValue"));
						vecVal3.add(strA);
					}
					else
					{
							vecVal3.add("0.00");
					}
						// for prev2 year
						
						String strZ1="";						
					if ((strRowtype.trim().equals("FO")|| strRowtype.trim().equals("C"))&& strRowformula>0 && !strPrevDesc1.trim().equals(""))
					{
						HashMap hshformula =  new HashMap();
						hshformula.put("appno",strValue);
						hshformula.put("sel_divID",sel_divID);
						hshformula.put("formulaid",Integer.toString(strRowformula));
						hshformula.put("curryear",strPrevDate1);
						hshformula.put("prevyear","");
						hshformula.put("currfinancialtype",strPrevDesc1);
						hshformula.put("prevfinancialtype","");
						HashMap hshRes2 = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
						strZ1= correctNull((String)hshRes2.get("strTotalValue"));
						vecVal6.add(strZ1);
					}// if IC

					else
					{
						vecVal6.add("0.00");
						
					}
						
						String strA1="";
					 if ((strRowtype.trim().equals("FO")|| strRowtype.trim().equals("C")) && strRowformula2>0 && !strPrevDesc1.trim().equals(""))
					{
						
						HashMap hshformula1 =  new HashMap();
						hshformula1.put("appno",strValue);
						hshformula1.put("sel_divID",sel_divID);
						hshformula1.put("formulaid",Integer.toString(strRowformula2));
						hshformula1.put("curryear",strPrevDate1);
						hshformula1.put("prevyear","");
						hshformula1.put("currfinancialtype",strPrevDesc1);
						hshformula1.put("prevfinancialtype","");
						HashMap hshRes3a = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula1,"GetFinValue");
						strA1 = correctNull((String)hshRes3a.get("strTotalValue"));
						vecVal7.add(strA1);
					}
					else
					{
							vecVal7.add("0.00");
					}

						// for next year
										
						String strB1="0.00";
						
					if ((strRowtype.trim().equals("FO")|| strRowtype.trim().equals("C")) && strRowformula>0 && !strNextDesc.trim().equals(""))
					{
						
						HashMap hshformula =  new HashMap();
						hshformula.put("appno",strValue);
						hshformula.put("sel_divID",sel_divID);
						hshformula.put("formulaid",Integer.toString(strRowformula));
						hshformula.put("curryear",strNextDate);
						hshformula.put("prevyear","");
						hshformula.put("currfinancialtype",strNextDesc);
						hshformula.put("prevfinancialtype","");
						HashMap hshRes4 = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
						strB1 = correctNull((String)hshRes4.get("strTotalValue"));
						vecVal4.add(strB1);
					}// if IC

					else
					{
						vecVal4.add("0.00");
						
					}
						String strT1 = "0.00";
									
					 if ((strRowtype.trim().equals("FO") || strRowtype.trim().equals("C"))&& strRowformula2>0 && !strNextDesc.trim().equals(""))
					{
						
						HashMap hshformula1 =  new HashMap();
						hshformula1.put("appno",strValue);
						hshformula1.put("sel_divID",sel_divID);
						hshformula1.put("formulaid",Integer.toString(strRowformula2));
						hshformula1.put("curryear",strNextDate);
						hshformula1.put("prevyear","");
						hshformula1.put("currfinancialtype",strNextDesc);
						hshformula1.put("prevfinancialtype","");
						HashMap hshRes5 = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula1,"GetFinValue");
						strT1=correctNull((String)hshRes5.get("strTotalValue"));
						vecVal5.add(strT1);
					}
					else
					{
							vecVal5.add("0.00");
					}
					
					// for next year
						
						String strB2="0.00";
						
					if ((strRowtype.trim().equals("FO")|| strRowtype.trim().equals("C")) && strRowformula>0 && !strNextDesc2.trim().equals(""))
					{
						
						HashMap hshformula =  new HashMap();
						hshformula.put("appno",strValue);
						hshformula.put("sel_divID",sel_divID);
						hshformula.put("formulaid",Integer.toString(strRowformula));
						hshformula.put("curryear",strNextDate2);
						hshformula.put("prevyear","");
						hshformula.put("currfinancialtype",strNextDesc2);
						hshformula.put("prevfinancialtype","");
						HashMap hshRes4 = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
						strB2 = correctNull((String)hshRes4.get("strTotalValue"));
						vecVal41.add(strB2);
					}// if IC

					else
					{
						vecVal41.add("0.00");
						
					}
						String strT2 = "0.00";
									
					 if ((strRowtype.trim().equals("FO") || strRowtype.trim().equals("C"))&& strRowformula2>0 && !strNextDesc2.trim().equals(""))
					{
						
						HashMap hshformula1 =  new HashMap();
						hshformula1.put("appno",strValue);
						hshformula1.put("sel_divID",sel_divID);
						hshformula1.put("formulaid",Integer.toString(strRowformula2));
						hshformula1.put("curryear",strNextDate2);
						hshformula1.put("prevyear","");
						hshformula1.put("currfinancialtype",strNextDesc2);
						hshformula1.put("prevfinancialtype","");
						HashMap hshRes5 = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula1,"GetFinValue");
						strT2=correctNull((String)hshRes5.get("strTotalValue"));
						vecVal51.add(strT2);
					}
					else
					{
							vecVal51.add("0.00");
					}
				}
				//while rs2
				

					hshValues.put("year",vecVal);	
					hshValues.put("yearhold",vecVal1);
					hshValues.put("prevyear",vecVal2);	
					hshValues.put("prevyearhold",vecVal3);	
					hshValues.put("nextyear2",vecVal4);	
					hshValues.put("nextyearhold2",vecVal5);
					hshValues.put("nextyear",vecVal41);	
					hshValues.put("nextyearhold",vecVal51);
					hshValues.put("prevyear1",vecVal5);	
					hshValues.put("prevyearhold1",vecVal6);	
					hshValues.put("vecid",vecid);
					hshValues.put("vecdesc",vecdesc);
					hshValues.put("vectype",vectype);
					hshValues.put("sel_divID",sel_divID);
					
					//if(!strCurDate.trim().equals(""))
						
					{
						vecrec.add(strCurDate);
					}

					/*else 
					{
						strDate=strDate.substring(6,10);
						vecrec.add(strDate);
					}*/
						vecrec.add(strDesc);
						vecrec.add(strPrevDate);
						vecrec.add(strPrevDesc);	
						vecrec.add(strNextDate2);
						vecrec.add(strNextDesc2);	
						vecrec.add(strPrevDate1);
						vecrec.add(strPrevDesc1);
						vecrec.add(strNextDate);
						vecrec.add(strNextDesc);

					hshValues.put("yearvalue",vecrec);
					hshValues.put("page",page); //old one
					
					strQuery = SQLParser.getSqlQuery("executive_finnotes_sel^"+strValue+"^"+page+"^"+sel_divID);
					if(rs5!=null)
						rs5.close();
					rs5=DBUtils.executeQuery(strQuery);
					if(rs5.next())
					{
						if(!correctNull((String)rs5.getString("notes")).equalsIgnoreCase(""))
						{
							hshValues.put("exec_notes",correctNull(Helper.CLOBToString(rs5.getClob("notes"))));
						}
						else
						{
							hshValues.put("exec_notes","");
						}
					}
					

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
					rs.close();
				if(rs1 != null)
					rs1.close();
				if(rs2 != null)
					rs2.close();
				if(rs5 != null)
					rs5.close();
				if(rs7 != null)
					rs7.close();
				if(rs10 != null)
					rs10.close();
				if(rs11 != null)
					rs11.close();
				if(rs12 != null)
					rs12.close();
				if(rs13 != null)
					rs13.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
			
			return hshValues; 
	
		
	}

}
