
package com.sai.laps.ejb.combobassessment;

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


@Stateless(name = "ComBobAssessmentBean", mappedName = "ComBobAssessmentHome")
@Remote (ComBobAssessmentRemote.class)
public class ComBobAssessmentBean extends BeanAdapter
{	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(ComBobAssessmentBean.class);
	public HashMap getData(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		ResultSet rs2 = null;
		ResultSet rs5 = null;
		ResultSet rs7 = null;
		ResultSet rs10 = null;
		ResultSet rs11 = null;
		ResultSet rs12 = null;
		HashMap hshValues=null;
		String strQuery="",strValue="";
		ArrayList arr=new ArrayList();
		ArrayList arrVal=new ArrayList();
		//int str=0;
		
		try
		{	
			strValue=correctNull((String)hshRequestValues.get("appno"));
			String page = correctNull((String)hshRequestValues.get("pageval"));
			hshValues = new HashMap();
			ArrayList vecVal=new ArrayList();
			//ArrayList vecVal1=new ArrayList();
			ArrayList vecVal2=new ArrayList();
			//ArrayList vecVal3=new ArrayList();
			ArrayList vecVal4=new ArrayList();
			//ArrayList vecVal5=new ArrayList();
			ArrayList vecrec=new ArrayList();
			ArrayList vecid = new ArrayList();
			ArrayList vecdesc = new ArrayList();
			ArrayList vectype = new ArrayList();
			ArrayList vecVal6=new ArrayList();
			ArrayList vecVal7=new ArrayList();
			
			ArrayList arrRow=new ArrayList();
			ArrayList arrCol=new ArrayList();
			/*strQuery = SQLParser.getSqlQuery("finselect1^"+strValue+"^0");
			if(rs!=null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{  
				str=rs.getInt("cnt");
			}*/
			
			String cma="";
			//strQuery = SQLParser.getSqlQuery("finselect8^"+strValue);
			strQuery=SQLParser.getSqlQuery("comfintrendsel1^"+strValue);
			if(rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery); 
			if(rs.next())
			{  
				//cma=rs.getString("cma_no");
				cma=correctNull(rs.getString("demo_finstandard"));
			}
			hshValues.put("cma_index",cma);
			vecVal = new ArrayList();		
			String strDate="";
			//String strDate2="";//after checking take out
			String strYear=""; //after checking take out
			String strYear1=""; //after checking take out
			
			
			if(rs!=null)
				rs.close();
				
			strQuery = SQLParser.getSqlQuery("sel_financial_baseyear^"+strValue);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{	
				strDate=Helper.correctNull((String)rs.getString("base_year"));
				strYear=Helper.correctNull((String)rs.getString("year"));
				strYear1=Helper.correctNull((String)rs.getString("year"));
			}
			
			strQuery = SQLParser.getSqlQuery("assessselect9^"+strValue+"^"+"0^"+strDate);
			if(rs5!=null)
				rs5.close();
			rs5 = DBUtils.executeQuery(strQuery);
			String strDesc="";
			String strDescription="";
			String strCurDate="";
	
			if(rs5.next())
			{
				if(rs5.getDouble("sumaudit")>0)
				{
					strDesc="a";
					strDescription="Audited";
				}
				else if(rs5.getDouble("sumunaudit")>0)
				{
					strDesc="u";
					strDescription="Unaudited";
				}
				else if(rs5.getDouble("sumestimated")>0)
				{
					strDesc="e";
					strDescription="Estimated";
				}
				else if(rs5.getDouble("sumprojection")>0)
				{
					strDesc="p";
					strDescription="Projection";
				}
				strCurDate=rs5.getString("fin_year");
			}
			strQuery = SQLParser.getSqlQuery("noteassessselect10^"+strValue);
			if(rs10!=null)
			rs10.close();
			rs10 = DBUtils.executeQuery(strQuery);		
			while(rs10.next())
			{
				arr=new ArrayList();
				arr.add(rs10.getString(1));
				arrVal.add(arr);
			}		
			int checkYear=0;
			String strPrevDesc="";
			String strPrevDescription="";
			String strPrevDate="";
			String strPrevDesc1="";
			String strPrevDescription1="";
			String strPrevDate1="";
			int count=0;
			checkYear=Integer.parseInt(Helper.correctInt(strYear));
			for(int x=1;x<=arrVal.size();x++)
			{
				if(count>1)
					break;
				
				count=count+1;
				checkYear=checkYear-1;
				strQuery = SQLParser.getSqlQuery("assessselect11^"+strValue+"^"+checkYear);
				if(rs11!=null)
					rs11.close();
				rs11 = DBUtils.executeQuery(strQuery);
				if(rs11.next())
				{
					if(rs11.getDouble("sumaudit")>0)
					{
						strPrevDesc="a";
						strPrevDescription="Audited";
					}
					else if(rs11.getDouble("sumunaudit")>0)
					{
						strPrevDesc="u";
						strPrevDescription="Unaudited";
					}
					else if(rs11.getDouble("sumestimated")>0)
					{
						strPrevDesc="e";
						strPrevDescription="Estimated";
					}
					else if(rs11.getDouble("sumprojection")>0)
					{
						strPrevDesc="p";
						strPrevDescription="Projection";
					}
					strPrevDate=rs11.getString("fin_year");
				}
				else
				{
					strPrevDate="";
					strPrevDesc="";
					strPrevDescription="";
				}
				if(rs11 != null)
					rs11.close();
				if(!strPrevDesc.trim().equals("") && strPrevDesc1.equals(""))
				{
					strPrevDate1=strPrevDate;
					strPrevDesc1=strPrevDesc;
					strPrevDescription1=strPrevDescription;
				}
					//break;
			}
			int chkYear=0;
			count=0;
			String strNextDesc="";
			String strNextDescription="";
			String strNextDate="";
			String strNextDesc1="";
			String strNextDate1="";
			String strNextDescription1="";
			chkYear=Integer.parseInt(Helper.correctInt(strYear1));
			for(int y=1;y<=arrVal.size();y++)
			{
				if(count>1)
					break;
				count++;
				chkYear=chkYear+1;
				strQuery = SQLParser.getSqlQuery("assessselect11^"+strValue+"^"+chkYear);
				if(rs12!=null)
					rs12.close();
				rs12 = DBUtils.executeQuery(strQuery);
				if(rs12.next())
				{
					if(rs12.getDouble("sumaudit")>0)
					{
						strNextDesc="a";
						strNextDescription="Audited";
					}
					else if(rs12.getDouble("sumunaudit")>0)
					{
						strNextDesc="u";
						strNextDescription="Unaudited";
					}
					else if(rs12.getDouble("sumestimated")>0)
					{
						strNextDesc="e";
						strNextDescription="Estimated";
					}
					else if(rs12.getDouble("sumprojection")>0)
					{
						strNextDesc="p";
						strNextDescription="Projection";
					}
					strNextDate=rs12.getString("fin_year");
				}
				else
				{
					strNextDate="";
					strNextDesc="";
					strNextDescription="";
				}
				if(rs12 != null)
					rs12.close();
				if(!strNextDesc.trim().equals("") && strNextDesc1.equals(""))
				{
					strNextDate1=strNextDate;
					strNextDesc1=strNextDesc;
					strNextDescription1=strNextDescription;
				}
					//break;
				}
			arrCol.add("");
			arrCol.add("<div align='center'><b>Particulars</b></div>");
			arrCol.add("");
			arrCol.add(strPrevDate);
			arrCol.add(strPrevDate1);
			arrCol.add(strDate);
			arrCol.add(strNextDate1);
			arrCol.add(strNextDate);
			arrRow.add(arrCol);
			
			arrCol=new ArrayList();
			arrCol.add("");
			arrCol.add("");
			arrCol.add("");
			arrCol.add(strPrevDescription);
			arrCol.add(strPrevDescription1);
			arrCol.add(strDescription);
			arrCol.add(strNextDescription1);
			arrCol.add(strNextDescription);
			arrRow.add(arrCol);
			
			String strRowtype="";
			String strRowid ="";
			int strRowformula=0;
			int strRowformula2=0;
			vecVal = new ArrayList();
			//vecVal1 = new ArrayList();
			vecVal2 = new ArrayList();
			//vecVal3 = new ArrayList();
			vecVal4 = new ArrayList();
			//vecVal5 = new ArrayList();
			vecVal6 = new ArrayList();
			vecVal7 = new ArrayList();
			vecid  = new ArrayList();
			vecdesc=new ArrayList();
			vectype=new ArrayList();
			
				strQuery = SQLParser.getSqlQuery("assessselect1^"+cma+"^"+page);
				if(rs2!=null)
				{
					rs2.close();
				}
				rs2 = DBUtils.executeQuery(strQuery);
				
				while (rs2.next())
				{
					arrCol=new ArrayList();
					
					strRowtype=correctNull(rs2.getString("fin_rowtype"));
					strRowid=correctNull(rs2.getString("fin_rowid"));
					String strRowdesc=correctNull(rs2.getString("fin_rowdesc"));
					strRowformula=rs2.getInt("fin_formula");
					strRowformula2=rs2.getInt("fin_formula2");
					vectype.add(strRowtype);
					String strX="";
					arrCol.add(strRowid);
					arrCol.add(strRowdesc);
					arrCol.add(strRowtype);
					if (strRowtype.trim().equals("FO") && strRowformula>0 && !strDesc.trim().equals(""))
					{
						HashMap hshformula =  new HashMap();
						hshformula.put("appno",strValue);
						hshformula.put("formulaid",Integer.toString(strRowformula));
						hshformula.put("curryear",strCurDate);
						hshformula.put("prevyear"," ");
						hshformula.put("currfinancialtype",strDesc);
						hshformula.put("prevfinancialtype","");
						HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
						strX=correctNull((String)hshRes.get("strTotalValue"));
						vecVal.add(strX);
						vecid.add(strRowid);
						vecdesc.add(strRowdesc);
						
						
						
					}
					else
					{
						vecVal.add("");
						vecid.add(strRowid);
						vecdesc.add(strRowdesc);
					}
					/*String strY="";
					if (strRowtype.trim().equals("FO") && strRowformula2>0 && !strDesc.trim().equals(""))
					{
						HashMap hshformula1 =  new HashMap();
						hshformula1.put("appno",strValue);
						hshformula1.put("formulaid",Integer.toString(strRowformula2));
						hshformula1.put("curryear",strCurDate);
						hshformula1.put("prevyear"," ");
						hshformula1.put("currfinancialtype",strDesc);
						hshformula1.put("prevfinancialtype","");
						HashMap hshRes1 = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula1,"GetFinValue");
						strY = correctNull((String)hshRes1.get("strTotalValue"));
						vecVal1.add(strY);
					}
					else
					{
						vecVal1.add("0.00");
					}*/
					String strZ="";
					if (strRowtype.trim().equals("FO") && strRowformula>0 && !strPrevDesc.trim().equals(""))
					{
						HashMap hshformula =  new HashMap();
						hshformula.put("appno",strValue);
						hshformula.put("formulaid",Integer.toString(strRowformula));
						hshformula.put("curryear",strPrevDate);
						hshformula.put("prevyear"," ");
						hshformula.put("currfinancialtype",strPrevDesc);
						hshformula.put("prevfinancialtype","");
						HashMap hshRes2 = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
						strZ = correctNull((String)hshRes2.get("strTotalValue"));
						vecVal2.add(strZ);
					}
					else
					{
						vecVal2.add("");
						
					}
					/*String strA="";
					if (strRowtype.trim().equals("FO") && strRowformula2>0 && !strPrevDesc.trim().equals(""))
					{
						HashMap hshformula1 =  new HashMap();
						hshformula1.put("appno",strValue);
						hshformula1.put("formulaid",Integer.toString(strRowformula2));
						hshformula1.put("curryear",strPrevDate);
						hshformula1.put("prevyear"," ");
						hshformula1.put("currfinancialtype",strPrevDesc);
						hshformula1.put("prevfinancialtype","");
						HashMap hshRes3 = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula1,"GetFinValue");
						strA = correctNull((String)hshRes3.get("strTotalValue"));
						vecVal3.add(strA);
					}
					else
					{
							vecVal3.add("0.00");
					}	*/				
					String strB="";
					if (strRowtype.trim().equals("FO") && strRowformula>0 && !strNextDesc.trim().equals(""))
					{
						HashMap hshformula =  new HashMap();
						hshformula.put("appno",strValue);
						hshformula.put("formulaid",Integer.toString(strRowformula));
						hshformula.put("curryear",strNextDate);
						hshformula.put("prevyear"," ");
						hshformula.put("currfinancialtype",strNextDesc);
						hshformula.put("prevfinancialtype","");
						HashMap hshRes4 = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
						strB = correctNull((String)hshRes4.get("strTotalValue"));
						vecVal4.add(strB);
					}
					else
					{
						vecVal4.add("");						
					}
					/*String strT = "0.00";				
					 if (strRowtype.trim().equals("FO") && strRowformula2>0 && !strNextDesc.trim().equals(""))
					{
						HashMap hshformula1 =  new HashMap();
						hshformula1.put("appno",strValue);
						hshformula1.put("formulaid",Integer.toString(strRowformula2));
						hshformula1.put("curryear",strNextDate);
						hshformula1.put("prevyear"," ");
						hshformula1.put("currfinancialtype",strNextDesc);
						hshformula1.put("prevfinancialtype","");
						HashMap hshRes5 = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula1,"GetFinValue");
						strT=correctNull((String)hshRes5.get("strTotalValue"));
						vecVal5.add(strT);
					}
					else
					{
						vecVal5.add("0.00");
					}	*/	
					
					
					String strC="";
					if (strRowtype.trim().equals("FO") && strRowformula>0 && !strNextDesc1.trim().equals(""))
					{
						HashMap hshformula =  new HashMap();
						hshformula.put("appno",strValue);
						hshformula.put("formulaid",Integer.toString(strRowformula));
						hshformula.put("curryear",strNextDate1);
						hshformula.put("prevyear"," ");
						hshformula.put("currfinancialtype",strNextDesc1);
						hshformula.put("prevfinancialtype","");
						HashMap hshRes6 = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
						strC = correctNull((String)hshRes6.get("strTotalValue"));
						vecVal6.add(strC);
					}
					else
					{
						vecVal6.add("");						
					}
					
					String strD="";
					if (strRowtype.trim().equals("FO") && strRowformula>0 && !strPrevDesc1.trim().equals(""))
					{
						HashMap hshformula =  new HashMap();
						hshformula.put("appno",strValue);
						hshformula.put("formulaid",Integer.toString(strRowformula));
						hshformula.put("curryear",strPrevDate1);
						hshformula.put("prevyear"," ");
						hshformula.put("currfinancialtype",strPrevDesc1);
						hshformula.put("prevfinancialtype","");
						HashMap hshRes7 = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
						strD = correctNull((String)hshRes7.get("strTotalValue"));
						vecVal7.add(strD);
					}
					else
					{
						vecVal7.add("");						
					}
					
					arrCol.add(strZ);
					arrCol.add(strD);
					arrCol.add(strX);
					arrCol.add(strC);
					arrCol.add(strB);
					
					arrRow.add(arrCol);
				}
				hshValues.put("year",vecVal);	
				//hshValues.put("yearhold",vecVal1);
				hshValues.put("prevyear",vecVal2);	
				//hshValues.put("prevyearhold",vecVal3);	
				hshValues.put("nextyear",vecVal4);	
				//hshValues.put("nextyearhold",vecVal5);
				hshValues.put("prevyear1",vecVal7);	
				hshValues.put("nextyear1",vecVal6);	
				hshValues.put("vecid",vecid);
				hshValues.put("vecdesc",vecdesc);
				hshValues.put("vectype",vectype);

				vecrec.add(strCurDate);				
				vecrec.add(strDesc);
				vecrec.add(strPrevDate);
				vecrec.add(strPrevDesc);	
				vecrec.add(strNextDate);
				vecrec.add(strNextDesc);	
				vecrec.add(strPrevDate1);
				vecrec.add(strPrevDesc1);	
				vecrec.add(strNextDate1);
				vecrec.add(strNextDesc1);
				hshValues.put("yearvalue",vecrec);
				vecrec=new ArrayList();
				vecrec.add(strPrevDescription);
				vecrec.add(strPrevDate);
				vecrec.add(strPrevDescription1);
				vecrec.add(strPrevDate1);
				vecrec.add(strDescription);
				vecrec.add(strCurDate);	
				vecrec.add(strNextDescription1);
				vecrec.add(strNextDate1);
				vecrec.add(strNextDescription);
				vecrec.add(strNextDate);
				hshValues.put("yearvalue1",vecrec);
				hshValues.put("page",page); //old one
				hshValues.put("arrRow",arrRow);
				/*strQuery=SQLParser.getSqlQuery("sel_assessmentoflimit^"+strValue);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshValues.put("com_limitassessmnent_comments",correctNull(Helper.CLOBToString(rs.getClob("com_limitassessmnent_comments"))));
				}*/
				
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
				}
				catch(Exception cf)
				{
					throw new EJBException("Error closing the connection "+cf.getMessage());
				}
			}
			log.info(hshValues);
			return hshValues; 
		}
	
	public void UpdateAssessmentoflimit(HashMap hshValues)
	{
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues=new ArrayList();
		
		String strComments=Helper.correctNull((String)hshValues.get("txt_assessmentoflimit"));
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		String strAppno=correctNull((String)hshValues.get("appno"));
		try
		{
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_assessmentoflimit");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","ins_assessmentoflimit");
				
				arrValues.add(strAppno);
				arrValues.add(strComments);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_assessmentoflimit");
				arrValues.add(strAppno);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in UpdateAssessmentoflimit" + e.getMessage());
		} 
	}
	
	public HashMap UpdateAssessmentdatas(HashMap hshValues)
	{
		//boolean boolresult=false;
		HashMap hshRecord=new HashMap();
		ArrayList arrRow=new ArrayList();
		
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAppno="";
		int intupdatesize=0;
		try{
			
			if(correctNull((String)hshValues.get("pageval")).equals(""))
			{
				hshValues.put("pageval","TO");
				hshValues.put("assessmenttype","TO");
			}
			else{
				hshValues.put("assessmenttype",correctNull((String)hshValues.get("pageval")));
			}
			strAppno=correctNull((String)hshValues.get("appno"));
			hshRecord=getData(hshValues);
			arrRow=(ArrayList)hshRecord.get("arrRow");
			if(arrRow!=null && arrRow.size()>0)
			{
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intupdatesize++;
				hshQuery.put("strQueryId","delfinassessvalues");
				arrValues.add(strAppno);
				arrValues.add("0");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intupdatesize,hshQuery);
				
				for(int i=0;i<arrRow.size();i++)
				{
					ArrayList arrCol=new ArrayList();
					arrCol=(ArrayList)arrRow.get(i);
					log.info("\n\t"+arrCol.get(0)+"\t"+arrCol.get(1)+"\t"+arrCol.get(2)
							+"\t"+arrCol.get(3)+"\t"+arrCol.get(4)+"\t"+arrCol.get(5)+"\t"+arrCol.get(6)
							+"\t"+arrCol.get(7)+"\t");
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					intupdatesize++;
					hshQuery.put("strQueryId","insfinassessvalues");
					arrValues.add(strAppno);
					arrValues.add("0");
					arrValues.add(""+(i+1));
					arrValues.add(arrCol.get(0));
					arrValues.add(arrCol.get(1));
					arrValues.add(arrCol.get(2));
					arrValues.add(arrCol.get(3));
					arrValues.add(arrCol.get(4));
					arrValues.add(arrCol.get(5));
					arrValues.add(arrCol.get(6));
					arrValues.add(arrCol.get(7));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intupdatesize,hshQuery);
				}
				hshQueryValues.put("size",""+intupdatesize);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			hshValues.put("finassessavailable","Y");
			
		}catch(Exception Ex)
		{
			throw new EJBException("Error in UpdateAssessmentdatas :: "+ Ex.toString());
		}
		return hshValues;
	}
	
	
	public HashMap getDataList(HashMap hshRequestValues) 
	{
		ResultSet rs = null;	
		HashMap hshValues=null;
		try
		{
		/*	
			strValue=correctNull((String)hshRequestValues.get("appno"));
			
			//strValue ="ABCIABCI00000005";
			String txtyear="",combo="";
			String yearvalue[] = new String[4];
			String comboselect[] = new String[4];
			hshValues = new HashMap();
			ArrayList vecVal=new ArrayList();
			ArrayList vecRec=new ArrayList();
			ArrayList vecrec=new ArrayList();
			ArrayList vecData=new ArrayList();
			ArrayList vecid = new ArrayList();
			// to find the cma format of the particular applications

			String cma="";
			strQuery = SQLParser.getSqlQuery("finselect8^"+strValue);
			rs = stmt.executeQuery(strQuery);
				 
			while(rs.next())
			{  
				cma=rs.getString("cma_no");
			}
			
			// to find the tab
			
			String page = correctNull((String)hshRequestValues.get("pageval"));
				
			
		/*	strQuery = SQLParser.getSqlQuery("finselect9^"+cma);
			rs=stmt.executeQuery(strQuery);
			int y=0;
			
			while(rs.next())
			{		
				if((y==0) && (page.trim().equals("")) )
					{
						page = correctNull((String)rs.getString("fin_tabname"));
					}
					vecRec = new ArrayList();
					vecRec.add(correctNull(rs.getString("fin_tabname")));
					vecVal.add(vecRec);
					y++;
					
			}
				
				hshValues.put("tabdetails",vecVal);*/
			
		/*		vecVal= new ArrayList();
				strQuery = SQLParser.getSqlQuery("assessselect3^"+strValue+"^"+cma);
				
				rs=stmt.executeQuery(strQuery);
				String temp="";
				String tempsno="";

				while(rs.next())
					{
						vecRec = new ArrayList();
						vecRec.add(correctNull(rs.getString("rowid")));

						temp = Helper.correctNull(rs.getString("desc1"));
						if (temp.equals(""))
						{
							vecRec.add(correctNull(rs.getString("desc2")));
						}
						else 
						{
							vecRec.add(correctNull(rs.getString("desc1")));
						}

						vecRec.add(correctNull(rs.getString("fin_rowtype")));
						tempsno=correctNull(rs.getString("fin_sno"));
						if (tempsno=="")
						{
							tempsno=" ";
						}
						vecRec.add(tempsno);
						
						vecVal.add(vecRec);
					}
						
						hshValues.put("labeldetails",vecVal);
						vecVal= new ArrayList();
						String desc="";
			int k=0;
			
			yearvalue[0]=correctNull((String)hshRequestValues.get("txtyear1"));
			comboselect[0]=correctNull((String)hshRequestValues.get("combo1"));
			yearvalue[1]=correctNull((String)hshRequestValues.get("txtyear2"));
			comboselect[1]=correctNull((String)hshRequestValues.get("combo2"));
			yearvalue[2]=correctNull((String)hshRequestValues.get("txtyear3"));
			comboselect[2]=correctNull((String)hshRequestValues.get("combo3"));
			yearvalue[3]=correctNull((String)hshRequestValues.get("txtyear4"));
			comboselect[3]=correctNull((String)hshRequestValues.get("combo4"));
			



	for (int i=0;i<=3 ;i++ )
		{
			vecVal = new ArrayList();
			vecid  = new ArrayList();
			if (comboselect[i].equals("a"))
				{
					comboselect[i] = "fin_audit";
					desc = "a";
				}
			else if(comboselect[i].equals("u"))
				{
					comboselect[i] = "fin_unaudit";
					desc = "u";
				}
			else if(comboselect[i].equals("e"))
				{
					comboselect[i] = "fin_estimated";
					desc ="e";
				}
			else if(comboselect[i].equals("p"))
				{
					comboselect[i] = "fin_projection";
					desc = "p";
				}
			
				
		if (!yearvalue[i].equals("") && !comboselect[i].equals("S"))
			{
				k=k+1;
				
						strQuery = SQLParser.getSqlQuery("assessselect1^"+cma);
						rs2=stmt.executeQuery(strQuery);
						String strRowtype="";
						String strRowid="";
						int strRowformula=0;
						while (rs2.next())
						{
							strRowtype=correctNull(rs2.getString("fin_rowtype"));
							strRowid=correctNull(rs2.getString("fin_rowid"));
							strRowformula=rs2.getInt("fin_formula");
							
							
								 if (strRowtype.trim().equals("FO") && strRowformula>0)
								{
									HashMap hshformula =  new HashMap();
									hshformula.put("appno",strValue);
									hshformula.put("formulaid",Integer.toString(strRowformula));
									hshformula.put("curryear",yearvalue[i]);
									hshformula.put("prevyear"," ");
									hshformula.put("currfinancialtype",desc);
									hshformula.put("prevfinancialtype","");
									HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
									vecVal.add(correctNull((String)hshRes.get("strTotalValue")));
									
									vecid.add(correctNull(rs2.getString("fin_rowid")));
								}// if IC

								else
								{
									vecVal.add("0.00");
									vecid.add(correctNull(rs2.getString("fin_rowid")));
								}
							
							hshValues.put("year"+k,vecVal);	
							hshValues.put("vecid"+k,vecid);	

						}//while rs2
						

					vecrec.add(yearvalue[i]);
					vecrec.add(comboselect[i]);

			}
										
					
		}
		hshValues.put("from",correctNull((String)hshRequestValues.get("fromvalue")));
		hshValues.put("totalyear",correctNull((String)hshRequestValues.get("totvalue")));
		hshValues.put("upto",correctNull((String)hshRequestValues.get("uptovalue")));
		hshValues.put("yearvalue",vecrec);
		hshValues.put("page",page);
	*/
			
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
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshValues; 
	}
	
	public HashMap updateHoldingLevels(HashMap hshValues)
	{
		
		HashMap hshRecord=new HashMap();
		ArrayList arrRow=new ArrayList();
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAppno="";
		int intupdatesize=0;
		ResultSet rs =null;
		String strQuery="";
		try{
			
			
			hshValues.put("assessmenttype",correctNull((String)hshValues.get("pageval")));
			strAppno=correctNull((String)hshValues.get("appno"));
			hshRecord=getData(hshValues);
			arrRow=(ArrayList)hshRecord.get("arrRow");
			hshValues.put("arrRow",arrRow);
			strAppno=correctNull((String)hshValues.get("appno"));
			hshRecord=getData(hshValues);
			
			if(arrRow!=null && arrRow.size()>0)
			{
				for(int i=0;i<arrRow.size();i++)
				{
					ArrayList arrCol=new ArrayList();
					arrCol=(ArrayList)arrRow.get(i);
					arrCol.add(8,"");
					arrRow.set(i,arrCol);
				}
				
			}
			arrRow=(ArrayList)hshRecord.get("arrRow");
			if(arrRow!=null && arrRow.size()>0)
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intupdatesize++;
				hshQuery.put("strQueryId","delfinhoidingvalues");
				arrValues.add(strAppno);
				arrValues.add("0");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intupdatesize,hshQuery);
				
				for(int i=0;i<arrRow.size();i++)
				{
					ArrayList arrCol=new ArrayList();
					arrCol=(ArrayList)arrRow.get(i);
						
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					intupdatesize++;
					hshQuery.put("strQueryId","insfinhoidingvalues");
					arrValues.add(strAppno);
					arrValues.add("0");
					arrValues.add(""+(i+1));
					arrValues.add(arrCol.get(0));
					arrValues.add(arrCol.get(1));
					arrValues.add(arrCol.get(2));
					arrValues.add(arrCol.get(3));
					arrValues.add(arrCol.get(4));
					arrValues.add(arrCol.get(5));
					arrValues.add(arrCol.get(6));
					arrValues.add(arrCol.get(7));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intupdatesize,hshQuery);
				}
				hshQueryValues.put("size",""+intupdatesize);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			if(rs != null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("sel_holdinglevel^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("com_holdinglevel_comments",correctNull(Helper.CLOBToString(rs.getClob("com_holdinglevel_comments"))));
			}
	
		}catch(Exception Ex)
		{
			throw new EJBException("Error in UpdateHoldingLevels :: "+ Ex.toString());
		}
		finally
		{
			try
			{	
				if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshValues;
	}
}