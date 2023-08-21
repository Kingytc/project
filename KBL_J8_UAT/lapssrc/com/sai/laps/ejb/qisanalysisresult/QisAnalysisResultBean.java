
package com.sai.laps.ejb.qisanalysisresult;
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


@Stateless(name = "QisAnalysisResultBean", mappedName = "QisAnalysisResultHome")
@Remote (QisAnalysisResultRemote.class)
public class QisAnalysisResultBean extends BeanAdapter
{	
	static Logger log=Logger.getLogger(QisAnalysisResultBean.class);

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public HashMap getDataList(HashMap hshRequestValues) 
	{
		
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ResultSet rs3 = null;
		ResultSet rs4 = null;
		ResultSet rs5 = null;
		ResultSet rs6 = null;
		ResultSet rs7 = null;
		ResultSet rs10 = null;
		ResultSet rs11 = null;
		ResultSet rs12 = null;
		HashMap hshValues=new HashMap();
		String strQuery="",strValue="";

		ArrayList arr=new ArrayList();
		ArrayList arrVal=new ArrayList();
		try
		{
			strValue=correctNull((String)hshRequestValues.get("appno"));
		String strFiQis="FI";// it's hard coded here take them out
			//--------------- to find the cma format of the particular applications-------



		String strDate=""; 
		String strYear=""; 
		String strYear1=""; 
		strQuery = SQLParser.getSqlQuery("noteassessselect5");
		rs7 = DBUtils.executeQuery(strQuery);
		if(rs7.next())
		{
			strDate=rs7.getString("dat");
			strYear=rs7.getString("txtyear");
			strYear1=rs7.getString("txtyear");
		}
		
		strQuery = SQLParser.getSqlQuery("noteassessselect9^"+strValue+"^"+strDate);
		rs5 = DBUtils.executeQuery(strQuery);
		String strDesc="";
		String strCurDate="";
		if(rs5.next())
		{
			
			if(rs5.getDouble("sumestimated")>0)
			{
				strDesc="e";
			}
			
			strCurDate=rs5.getString("fin_year");

		}

		strQuery = SQLParser.getSqlQuery("noteassessselect10^"+strValue);		
		rs10 = DBUtils.executeQuery(strQuery);
		
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
	
	checkYear=Integer.parseInt(strYear);
	for(int x=1;x<=arrVal.size();x++)
	{
			count=count+1;
			checkYear=checkYear-1;
			strQuery = SQLParser.getSqlQuery("noteassessselect11^"+strValue+"^"+checkYear);
			rs11 = DBUtils.executeQuery(strQuery);
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
				
				strPrevDate=rs11.getString("fin_year");

			}
			if(rs11 != null)
				rs11.close();
			if(!strPrevDesc.trim().equals("") && !strPrevDate.trim().equals(""))
			{
				break;
			}
				
	}

	int chkYear=0;
	String strNextDesc="";
	String strNextDate="";
	chkYear=Integer.parseInt(strYear1);
	for(int y=1;y<=arrVal.size();y++)
	{
			chkYear=chkYear+1;
			strQuery = SQLParser.getSqlQuery("noteassessselect11^"+strValue+"^"+chkYear);
			
			rs12 = DBUtils.executeQuery(strQuery);
			if(rs12.next())
			{
				
				if(rs12.getDouble("sumprojection")>0)
				{
					strNextDesc="p";
				}
				strNextDate=rs12.getString("fin_year");

			}
			if(rs12 != null)
				rs12.close();
			if(!strNextDesc.trim().equals(""))
				break;
	}


// end of year findigs
		String cma="";
		strQuery = SQLParser.getSqlQuery("notefinselect8^"+strValue);		
		rs = DBUtils.executeQuery(strQuery);	 
		if(rs.next())
		{  
			cma=rs.getString("cma_no");
		}
		if (cma.trim().equals(""))
		{
			cma="4";
		}
		ArrayList vecVal=new ArrayList();
		ArrayList vecVal2=new ArrayList();
		ArrayList vecVal3=new ArrayList();
		ArrayList vecid=new ArrayList();
		ArrayList vecdesc=new ArrayList();
		ArrayList vecVar=new ArrayList();
		ArrayList vecVarNext=new ArrayList();
		ArrayList vecComments=new ArrayList();
		ArrayList vecCommentsNext=new ArrayList();
		String strId="";
		double dbVariation=0.00;
		double dbVariationNext=0.00;


				strQuery = SQLParser.getSqlQuery("qisanaresultsel^"+strFiQis+"^"+cma);
				rs2 = DBUtils.executeQuery(strQuery);
				
				int strRowformula=0;
				
				vecVal = new ArrayList();
				vecVal2 = new ArrayList();
				
				
			

				while (rs2.next())
				{
					
					strId=correctNull(rs2.getString("id"));
					strRowformula=rs2.getInt("formula_id");
					String strX="";
					
					if (strRowformula>0 && !strDesc.trim().equals(""))
					{
						HashMap hshformula =  new HashMap();
						hshformula.put("appno",strValue);
						hshformula.put("formulaid",Integer.toString(strRowformula));
						hshformula.put("curryear",strCurDate);
						hshformula.put("prevyear","");
						hshformula.put("currfinancialtype",strDesc);
						hshformula.put("prevfinancialtype","");
						HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
						strX=correctNull((String)hshRes.get("strTotalValue"));
						vecVal.add(strX);
						vecid.add(correctNull(rs2.getString("id")));
						vecdesc.add(correctNull(rs2.getString("ratio_desc")));
						
					}// if IC

					else
					{
						vecVal.add("0.00");
						vecid.add(correctNull(rs2.getString("id")));
						vecdesc.add(correctNull(rs2.getString("ratio_desc")));
					}
				
					 
					// for prev year
					
					String strZ="";
					
					if (  strRowformula>0 && !strPrevDesc.trim().equals(""))
					{
						
						
						HashMap hshformula =  new HashMap();
						hshformula.put("appno",strValue);
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
					

					// for Next Year
					
					if (  strRowformula>0 && !strNextDesc.trim().equals(""))
					{
						
						HashMap hshformula =  new HashMap();
						hshformula.put("appno",strValue);
						hshformula.put("formulaid",Integer.toString(strRowformula));
						hshformula.put("curryear",strNextDate);
						hshformula.put("prevyear","");
						hshformula.put("currfinancialtype",strNextDesc);
						hshformula.put("prevfinancialtype","");
						vecVal3.add(strZ);
					}// if IC

					else
					{
						vecVal3.add("0.00");
						
					}
					String strTemp1=(String)vecVal.get(0);
					String strTemp2=(String)vecVal2.get(0);
					String strTemp3=(String)vecVal3.get(0);
					double dblCurNum=0.00;
					double dblPrevNum=0.00;
					double dblNextNum=0.00;
					if (!strTemp1.trim().equals(""))
					{
						dblCurNum=Double.parseDouble(strTemp1);
					}
					if (!strTemp2.trim().equals(""))
					{
						dblPrevNum=Double.parseDouble(strTemp2);
					}
					
					if (!strTemp3.trim().equals(""))
					{
						dblNextNum=Double.parseDouble(strTemp3);
					}
					double dblDiff=dblCurNum-dblPrevNum;
					if (dblDiff!=0 && dblPrevNum !=0)
					{
						dbVariation=(dblDiff/dblPrevNum)*100;
					}
					else
					{
						dbVariation=0.00;
					}
				strQuery = SQLParser.getSqlQuery("qiscomments^"+dbVariation+"^"+strId+"^"+" and qis_type=CY");
				rs3 = DBUtils.executeQuery(strQuery);
				String strComments="";
				if (rs3.next())
				{
					strComments=correctNull((String)rs3.getString(1));
				}
				if(rs3 != null )
					rs3.close();
					vecComments.add(strComments);
					String strVar=Helper.formatDoubleValue(dbVariation);
					vecVar.add(strVar);

			

				double dblDiffNext=dblNextNum-dblPrevNum;
				if (dblDiffNext!=0 && dblPrevNum !=0)
				{
					dbVariationNext=(dblDiffNext/dblPrevNum)*100;
				}
				else
				{
					dbVariationNext=0.00;
				}
				
				strQuery = SQLParser.getSqlQuery("qiscomments^"+dbVariationNext+"^"+strId+"^"+" and qis_type=CO");
				rs6 = DBUtils.executeQuery(strQuery);
				String strCommentsNext="";
				if (rs6.next())
				{
					strCommentsNext=correctNull((String)rs6.getString(1));
				}
				if(rs6 != null)
					rs6.close();
					vecCommentsNext.add(strCommentsNext);
					String strVarNext=Helper.formatDoubleValue(dbVariationNext);
					vecVarNext.add(strVarNext);

																
				}//while rs2
			
				

					hshValues.put("year",vecVal);	
					hshValues.put("prevyear",vecVal2);	
					hshValues.put("nextyear",vecVal3);	
									
					hshValues.put("vecid",vecid);
					hshValues.put("vecdesc",vecdesc);
					hshValues.put("vecVar",vecVar);	
					hshValues.put("vecComments",vecComments);
					hshValues.put("vecCommentsNext",vecCommentsNext);	


					hshValues.put("strCuryear",strCurDate);	
					hshValues.put("strCurselect",strDesc);	
					hshValues.put("strPrevyear",strPrevDate);	
					hshValues.put("strPrevselect",strPrevDesc);
					hshValues.put("strNextyear",strNextDate);	
					hshValues.put("strNextselect",strNextDesc);	
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
				
				if(rs3 != null)
					rs3.close();
				
				if(rs4!= null)
					rs4.close();
				
				if(rs5 != null)
					rs5.close();
			
				if(rs6 != null)
					rs6.close();
				
				if(rs7 != null)
					rs7.close();
				
				if(rs10!= null)
					rs10.close();
				
				if(rs11 != null)
					rs11.close();
				
				if(rs12 != null)
					rs12.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}

		return hshValues; 

	}
	


	
}