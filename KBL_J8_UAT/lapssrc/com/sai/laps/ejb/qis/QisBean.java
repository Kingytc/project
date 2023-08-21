package com.sai.laps.ejb.qis;

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
 
@Stateless(name = "QisBean", mappedName = "QisHome")
@Remote (QisRemote.class)
public class QisBean extends BeanAdapter
{
	
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(QisBean.class);
	private static final long serialVersionUID = 1L;

	public  HashMap getData(HashMap hshValues) 
	{
		ResultSet rs = null;
		String strQuery="";
		HashMap hshRecord = new HashMap();
		HashMap hshformula = new HashMap();
		ArrayList vecVal=null;
		ArrayList vecData=new ArrayList();
		String strCmano="",strBorrowerId="",strBorrowerName="",strQisType="",strFrom="",strTo="";
		String strQuarter="",strYear="";
		int intQuarter=0,intYear=0;
		try
		{
			strBorrowerId = correctNull((String)hshValues.get("comapp_id"));
			rs=DBUtils.executeLAPSQuery("selcomapcmano^"+strBorrowerId);
			if(rs.next())
			{
				strCmano = correctNull((String)rs.getString("cma_no"));
			}
			strQisType = correctNull((String)hshValues.get("qistype"));

			strBorrowerName = correctNull((String)hshValues.get("comapp_name"));
			strYear = correctNull((String)hshValues.get("year"));
			if(!strYear.trim().equals(""))
			{
				intYear = Integer.parseInt(strYear);
			}
			strQuarter = correctNull((String)hshValues.get("quarter"));
			if(!strQuarter.trim().equals(""))
			{
				intQuarter = Integer.parseInt(strQuarter);
			}
				if( (strQisType.trim().equals("Q1")) || (strQisType.trim().equals("Q2")) )
				{
					if(intQuarter==1)
					{
						strFrom ="01/04/"+Integer.toString(intYear);
						strTo ="30/06/"+Integer.toString(intYear);
					}
					if(intQuarter==2)
					{
						strFrom ="01/07/"+Integer.toString(intYear);
						strTo ="30/09/"+Integer.toString(intYear);
					}
					if(intQuarter==3)
					{
						strFrom ="01/10/"+Integer.toString(intYear);
						strTo ="31/12/"+Integer.toString(intYear);
					}
					if(intQuarter==4)
					{
						strFrom ="01/01/"+Integer.toString(intYear+1);
						strTo ="31/03/"+Integer.toString(intYear+1);
					}
				}
				else if( (strQisType.trim().equals("H1")) || (strQisType.trim().equals("H2")) )
				{
					if(intQuarter==1)
					{
						strFrom ="01/04/"+Integer.toString(intYear);
						strTo ="30/09/"+Integer.toString(intYear);
					}
					if(intQuarter==2)
					{
						strFrom ="01/10/"+Integer.toString(intYear);
						strTo ="31/12/"+Integer.toString(intYear+1);
					}
				}
			if( (!strCmano.trim().equals("")) && (!strQisType.trim().equals("")) && (!strBorrowerId.trim().equals("")) && (intYear>0) && (intQuarter>0) )
			{
String	strQisResType="";	
				if(strQisType.trim().equals("Q1")) 
				{
 					 strQisResType ="'Q1'";
					strQuery = SQLParser.getSqlQuery("selqisvalues^"+strCmano+"^"+strQisResType +"^"+strBorrowerId+"^>^"+strFrom+"^<^"+strTo);

				}
				else if (strQisType.trim().equals("Q2"))
				{
					 strQisResType = "'Q1','Q2'" ;
					strQuery = SQLParser.getSqlQuery("selqisvalues^"+strCmano+"^"+strQisResType +"^"+strBorrowerId+"^>^"+strFrom+"^<^"+strTo);
				}
				else if (strQisType.trim().equals("H1"))
				{
					strQisResType ="'H1'";
					strQuery = SQLParser.getSqlQuery("selhalfyearvalues^"+strCmano+"^"+strQisResType +"^"+strBorrowerId+"^>^"+strFrom+"^<^"+strTo);
				}
				else if (strQisType.trim().equals("H2"))
				{
					strQisResType ="'H2'";
					strQuery = SQLParser.getSqlQuery("selhalfyearvalues^"+strCmano+"^"+strQisResType +"^"+strBorrowerId+"^>^"+strFrom+"^<^"+strTo);
				}
				if(rs != null)
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					vecVal = new ArrayList();
					HashMap hshRes = new HashMap();
					String strColName="";
					String strQid = correctNull((String)rs.getString("qis_id"));
					String strRowType = correctNull((String)rs.getString("qis_row_type"));
					String strGroupname = correctNull((String)rs.getString("qis_group_name"));
					String strRowname = correctNull((String)rs.getString("qis_row_name"));
					int intFormulaAmt = rs.getInt(6);
					String strCol1 = correctNull((String)rs.getString(7));
					String strCol2 = correctNull((String)rs.getString(8));
					vecVal.add(strQid);
					vecVal.add(strRowType);
					vecVal.add(strGroupname);
					vecVal.add(strRowname);
					if(intFormulaAmt>0 && (strRowType.trim().equals("C")))
					{
						String str="";
						if ( (strQisType.trim().equals("Q1")) || (strQisType.trim().equals("Q2")))
						{
							strColName ="qis_estimates";	
							str="QIS1";
 						}
						else if ( (strQisType.trim().equals("H1")) || (strQisType.trim().equals("H2")))
						{
							strColName ="hf_cur_budget";	
							str="QIS2";
 						}

						hshformula.put("appno",strBorrowerId);
						hshformula.put("formulaid",Integer.toString(intFormulaAmt));
						hshformula.put("colname",strColName);
						hshformula.put("datefrom",strFrom);
						hshformula.put("dateto",strTo);
						hshformula.put("formulaapply",str);
						hshformula.put("curryear"," ");
						hshformula.put("prevyear"," ");
						hshformula.put("currfinancialtype","");
						hshformula.put("prevfinancialtype","");
						hshformula.put("internalcalc","N");
						hshformula.put("hshdata",new HashMap());
						 hshRes = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
						strCol1 = correctNull((String)hshRes.get("strTotalValue"));
					}
					vecVal.add(strCol1);
					if(intFormulaAmt>0 && (strRowType.trim().equals("C")))
					{
						String str="";
						if ( (strQisType.trim().equals("Q1")) || (strQisType.trim().equals("Q2")))
						{
							strColName ="qis_actuals";	
							str="QIS1";							
						}
						else if ( (strQisType.trim().equals("H1")) || (strQisType.trim().equals("H2")))
						{
							strColName ="hf_estimate";	
							str="QIS2";
						}

						hshformula.put("appno",strBorrowerId);
						hshformula.put("formulaid",Integer.toString(intFormulaAmt));
						hshformula.put("colname",strColName);
						hshformula.put("datefrom",strFrom);
						hshformula.put("dateto",strTo);
						hshformula.put("formulaapply",str);
						hshformula.put("curryear"," ");
						hshformula.put("prevyear"," ");
						hshformula.put("currfinancialtype","");
						hshformula.put("prevfinancialtype","a");
						hshformula.put("internalcalc","N");
						hshformula.put("hshdata",new HashMap());
						 hshRes = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
						strCol2 = correctNull((String)hshRes.get("strTotalValue"));
					}
					vecVal.add(strCol2);
					if ( (strQisType.trim().equals("H1")) || (strQisType.trim().equals("H2")))
					{
						String strCol3 = correctNull((String)rs.getString(9));
						String strCol4 = correctNull((String)rs.getString(10));
						if(intFormulaAmt>0 && (strRowType.trim().equals("C")))
						{
							hshformula.put("appno",strBorrowerId);
							hshformula.put("formulaid",Integer.toString(intFormulaAmt));
							hshformula.put("colname","hf_actual");
							hshformula.put("datefrom",strFrom);
							hshformula.put("dateto",strTo);
						hshformula.put("formulaapply","QIS2");
							hshformula.put("curryear"," ");
							hshformula.put("prevyear"," ");
							hshformula.put("currfinancialtype","");
							hshformula.put("prevfinancialtype","");
							hshformula.put("internalcalc","N");
							hshformula.put("hshdata",new HashMap());
							 hshRes = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
							strCol3 = correctNull((String)hshRes.get("strTotalValue"));
						}
						vecVal.add(strCol3);
						if(intFormulaAmt>0 && (strRowType.trim().equals("C")))
						{
							hshformula.put("appno",strBorrowerId);
							hshformula.put("formulaid",Integer.toString(intFormulaAmt));
							hshformula.put("colname","hf_cur_hf_estimate");
							hshformula.put("datefrom",strFrom);
							hshformula.put("dateto",strTo);
						hshformula.put("formulaapply","QIS2");
							hshformula.put("curryear"," ");
							hshformula.put("prevyear"," ");
							hshformula.put("currfinancialtype","");
							hshformula.put("prevfinancialtype","a");
							hshformula.put("internalcalc","N");
							hshformula.put("hshdata",new HashMap());
							 hshRes = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
							strCol4 = correctNull((String)hshRes.get("strTotalValue"));
						}
						vecVal.add(strCol4);
					}
 					vecData.add(vecVal);
	
				}
			}
			hshRecord.put("vecData",vecData);
			hshRecord.put("comapp_id",strBorrowerId);
			hshRecord.put("comapp_name",strBorrowerName);
			hshRecord.put("qistype",strQisType);
			hshRecord.put("year",strYear);
			hshRecord.put("quarter",strQuarter);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs!=null)
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
		ResultSet rs = null;
		String strQuery="";
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String strFrom="",strTo="",strEstimate="0",strActual="0",strHolding="0",strAmount="0";
		String strBorrowerId="0",strQisType="",strQid="",strCount="0";
		int intUpdatesize =0,intCount=0;
		String strQuarter="",strYear="";
		int intQuarter=0,intYear=0;

		try
		{
			strCount = correctNull((String)hshValues.get("count"));
			if(!strCount.trim().equals(""))
			{
				intCount = Integer.parseInt(strCount);
			}
			strQisType = correctNull((String)hshValues.get("qistype"));
			strBorrowerId = correctNull((String)hshValues.get("comapp_id"));
 			strYear = correctNull((String)hshValues.get("year"));
			if(!strYear.trim().equals(""))
			{
				intYear = Integer.parseInt(strYear);
			}
			strQuarter = correctNull((String)hshValues.get("quarter"));
			if(!strQuarter.trim().equals(""))
			{
				intQuarter = Integer.parseInt(strQuarter);
			}

				if( (strQisType.trim().equals("Q1")) || (strQisType.trim().equals("Q2")) )
				{
					if(intQuarter==1)
					{
						strFrom ="01/04/"+Integer.toString(intYear);
						strTo ="30/06/"+Integer.toString(intYear);
					}
					if(intQuarter==2)
					{
						strFrom ="01/07/"+Integer.toString(intYear);
						strTo ="30/09/"+Integer.toString(intYear);
					}
					if(intQuarter==3)
					{
						strFrom ="01/10/"+Integer.toString(intYear);
						strTo ="31/12/"+Integer.toString(intYear);
					}
					if(intQuarter==4)
					{
						strFrom ="01/01/"+Integer.toString(intYear+1);
						strTo ="31/03/"+Integer.toString(intYear+1);
					}
				}
				else if( (strQisType.trim().equals("H1")) || (strQisType.trim().equals("H2")) )
				{
					if(intQuarter==1)
					{
						strFrom ="01/04/"+Integer.toString(intYear);
						strTo ="30/09/"+Integer.toString(intYear);
					}
					if(intQuarter==2)
					{
						strFrom ="01/10/"+Integer.toString(intYear);
						strTo ="31/12/"+Integer.toString(intYear+1);
					}
				}
			for(int i=1;i<=intCount;i++)
			{
				String strCurBudget="0",strHalfEstimate="0",strHalfActual="0",strCurHalfEstimate="0";
				double dblEstimate=0.00,dblActual =0.00;
				double dblCurBudget=0.00,dblHalfEstimate=0.00,dblHalfActual=0.00,dblCurHalfEstimate=0.00;
				strQid = correctNull((String)hshValues.get("qisid"+i));
				if(strQisType.trim().equals("Q1")) 
				{
					strEstimate = correctNull((String)hshValues.get("txt_estimate"+i));
					strActual = correctNull((String)hshValues.get("txt_actual"+i));
				}
				else if(strQisType.trim().equals("Q2"))
				{
					strEstimate = correctNull((String)hshValues.get("txt_estimate"+i));
					strActual = correctNull((String)hshValues.get("txt_actual"+i));
				}
				else if( (strQisType.trim().equals("H1")) || (strQisType.trim().equals("H2")) )
				{
					strCurBudget = correctNull((String)hshValues.get("txt_cur_budget"+i));
					strHalfEstimate = correctNull((String)hshValues.get("txt_half_estimate"+i));
					strHalfActual = correctNull((String)hshValues.get("txt_half_actual"+i));
					strCurHalfEstimate = correctNull((String)hshValues.get("txt_cur_half_estimate"+i));
				}
				if(!strEstimate.trim().equals(""))
				{
					dblEstimate = Double.parseDouble(strEstimate);
				}
				if(!strActual.trim().equals(""))
				{
					dblActual = Double.parseDouble(strActual);
				}

				if(!strCurBudget.trim().equals(""))
				{
					dblCurBudget = Double.parseDouble(strCurBudget);
				}
				if(!strHalfEstimate.trim().equals(""))
				{
					dblHalfEstimate = Double.parseDouble(strHalfEstimate);
				}
				if(!strHalfActual.trim().equals(""))
				{
					dblHalfActual = Double.parseDouble(strHalfActual);
				}
				if(!strCurHalfEstimate.trim().equals(""))
				{
					dblCurHalfEstimate = Double.parseDouble(strCurHalfEstimate);
				}
				if( (!strQid.trim().equals("")) && ( (dblEstimate > 0) || (dblActual>0) ) )
				{
					intUpdatesize = intUpdatesize+1;
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					strQuery = SQLParser.getSqlQuery("checkqis^"+strQid +"^"+strBorrowerId +"^>^"+strFrom+"^<^"+strTo);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshQuery.put("strQueryId","updqisdetails");
						arrValues.add(strHolding);
						arrValues.add(strAmount);
						arrValues.add(Helper.formatDoubleValue(dblEstimate));
						arrValues.add(Helper.formatDoubleValue(dblActual)); 
						arrValues.add(strQid);
						arrValues.add(strBorrowerId);
						arrValues.add(strFrom);
						arrValues.add(strTo);

					}
					else
					{
						hshQuery.put("strQueryId","insqisdetails");
						arrValues.add(strQid);
						arrValues.add(strBorrowerId);
						arrValues.add(strFrom);
						arrValues.add(strTo);
						arrValues.add(strHolding);
						arrValues.add(strAmount);
						arrValues.add(Helper.formatDoubleValue(dblEstimate));
						arrValues.add(Helper.formatDoubleValue(dblActual)); 
					}
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);	
				}
				else if( (!strQid.trim().equals("")) && ( (dblCurBudget > 0) || (dblHalfEstimate>0) || (dblHalfActual > 0) || (dblCurHalfEstimate>0) ) )
				{
					intUpdatesize = intUpdatesize+1;
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					strQuery = SQLParser.getSqlQuery("checkhalfqis^"+strQid +"^"+strBorrowerId +"^>^"+strFrom+"^<^"+strTo);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshQuery.put("strQueryId","updhalfqisdetails");
						arrValues.add(Helper.formatDoubleValue(dblCurBudget));
						arrValues.add(Helper.formatDoubleValue(dblHalfEstimate));
						arrValues.add(Helper.formatDoubleValue(dblHalfActual));
						arrValues.add(Helper.formatDoubleValue(dblCurHalfEstimate)); 
						arrValues.add(strQid);
						arrValues.add(strBorrowerId);
						arrValues.add(strFrom);
						arrValues.add(strTo);

					}
					else
					{
						hshQuery.put("strQueryId","inshalfqisdetails");
						arrValues.add(strQid);
						arrValues.add(strBorrowerId);
						arrValues.add(strFrom);
						arrValues.add(strTo);
						arrValues.add(Helper.formatDoubleValue(dblCurBudget));
						arrValues.add(Helper.formatDoubleValue(dblHalfEstimate));
						arrValues.add(Helper.formatDoubleValue(dblHalfActual));
						arrValues.add(Helper.formatDoubleValue(dblCurHalfEstimate)); 
					}
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);	
				}


			}
			if(hshQueryValues!=null)
			{
				if(hshQueryValues.size()>0)
				{
	 				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateData "+ce.toString());
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
			catch(Exception e )
			{
				throw new EJBException("Error closing the connection "+e.getMessage());
			}
		}
 
	}


	public  HashMap getQisAna(HashMap hshValues) 
	{
		ResultSet rs = null;
		String strQuery="",strAppno="",finalstring ="";
		HashMap hshRecord = new HashMap();
		ArrayList vecVal=null;
		ArrayList vecData=new ArrayList();
		String strCmano="",strBorrowerId="",strBorrowerName="",strQisType="",strFrom="",strTo="";
		String strQuarter="",strYear="";
		int intQuarter=0,intYear=0;
		try
		{
			strBorrowerId = correctNull((String)hshValues.get("comapp_id"));
			rs=DBUtils.executeLAPSQuery("selcomapcmano^"+strBorrowerId);
			if(rs.next())
			{
				strCmano = correctNull((String)rs.getString("cma_no"));
			}
			strQisType = correctNull((String)hshValues.get("qistype"));

			strBorrowerName = correctNull((String)hshValues.get("comapp_name"));
			strYear = correctNull((String)hshValues.get("year"));
			if(!strYear.trim().equals(""))
			{
				intYear = Integer.parseInt(strYear);
			}
			strQuarter = correctNull((String)hshValues.get("quarter"));
			if(!strQuarter.trim().equals(""))
			{
				intQuarter = Integer.parseInt(strQuarter);
			}
			String strCurYear="";
			rs=DBUtils.executeLAPSQuery("selcurrentyear");
			if(rs.next())
			{
				strCurYear = rs.getString(1);
			}
			rs=DBUtils.executeLAPSQuery("getborrowerappno^"+strBorrowerId);
			if(rs.next())
			{
				strAppno = rs.getString(1);
			}


				if(strQisType.trim().equals("QIS")) 
				{
					if(intQuarter==1)
					{
						strFrom ="01/04/"+Integer.toString(intYear);
						strTo ="30/06/"+Integer.toString(intYear);
					}
					if(intQuarter==2)
					{
						strFrom ="01/07/"+Integer.toString(intYear);
						strTo ="30/09/"+Integer.toString(intYear);
					}
					if(intQuarter==3)
					{
						strFrom ="01/10/"+Integer.toString(intYear);
						strTo ="31/12/"+Integer.toString(intYear);
					}
					if(intQuarter==4)
					{
						strFrom ="01/01/"+Integer.toString(intYear+1);
						strTo ="31/03/"+Integer.toString(intYear+1);
					}
				}
				else if( (strQisType.trim().equals("H1")) || (strQisType.trim().equals("H2")) )
				{
					if(intQuarter==1)
					{
						strFrom ="01/04/"+Integer.toString(intYear);
						strTo ="30/09/"+Integer.toString(intYear);
					}
					if(intQuarter==2)
					{
						strFrom ="01/10/"+Integer.toString(intYear);
						strTo ="31/12/"+Integer.toString(intYear+1);
					}
				}
			if( (!strCmano.trim().equals("")) && (!strQisType.trim().equals("")) && (!strBorrowerId.trim().equals("")) && (intYear>0) && (intQuarter>0) )
			{
				String	strQisResType="";
				if (strQisType.trim().equals("QIS"))
				{
					strQisResType = "'Q1','Q2'" ;
					strQuery = SQLParser.getSqlQuery("selqisvalues^"+strCmano+"^"+strQisResType +"^"+strBorrowerId+"^>^"+strFrom+"^<^"+strTo);
				}
				else if (strQisType.trim().equals("H1"))
				{
					strQisResType ="'H1'";
					strQuery = SQLParser.getSqlQuery("selhalfyearvalues^"+strCmano+"^"+strQisResType +"^"+strBorrowerId+"^>^"+strFrom+"^<^"+strTo);
				}
				else if (strQisType.trim().equals("H2"))
				{
					strQisResType ="'H2'";
					strQuery = SQLParser.getSqlQuery("selhalfyearvalues^"+strCmano+"^"+strQisResType +"^"+strBorrowerId+"^>^"+strFrom+"^<^"+strTo);
				}
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					vecVal = new ArrayList();
					String strCol1="",strCol2="",strCol3="",strCol4="",strCol5="",strCol6="",strTemp="";
					String strQid = correctNull((String)rs.getString("qis_id"));
					String strRowType = correctNull((String)rs.getString("qis_row_type"));
					String strGroupname = correctNull((String)rs.getString("qis_group_name"));
					String strRowname = correctNull((String)rs.getString("qis_row_name"));
					int intFormulaHolding = rs.getInt(5);
					int intFormulaAmt = rs.getInt(6);
					  strCol3 = correctNull((String)rs.getString(7));
					  strCol4 = correctNull((String)rs.getString(8));
					if( (strQisType.trim().equals("H1")) || (strQisType.trim().equals("H2")) )
					{
						strCol5 = correctNull((String)rs.getString(9));
						strCol6 = correctNull((String)rs.getString(10));
					}
					vecVal.add(strQid);
					vecVal.add(strRowType);
					vecVal.add(strGroupname);
					vecVal.add(strRowname);
					if(strQisType.trim().equals("QIS"))
					{
						if(intFormulaHolding>0 )
						{
							strCol1 =  getResultValue("Financial",strAppno,Integer.toString(intFormulaHolding),strCurYear,"","e","",""); 					
						}
						if(intFormulaAmt>0)
						{
							strCol2 =  getResultValue("Financial",strAppno,Integer.toString(intFormulaAmt),strCurYear,"","e","",""); 
						}
						if(intFormulaHolding>0) 
						{
							strCol3 =  getResultValue("QIS",strBorrowerId,Integer.toString(intFormulaHolding),strFrom,strTo,"","qis_estimates","QIS1"); 			
						}
						if(intFormulaAmt>0)
						{
							strCol4 =  getResultValue("QIS",strBorrowerId,Integer.toString(intFormulaAmt),strFrom,strTo,"","qis_estimates","QIS1"); 					
						}
						else
						{
							strTemp  = strCol4;
							strCol4 = strCol3;
							strCol3 = "";
						}
						if(intFormulaHolding>0)
						{
							strCol5 =  getResultValue("QIS",strBorrowerId,Integer.toString(intFormulaHolding),strFrom,strTo,"","qis_actuals","QIS1"); 			
						}
						if(intFormulaAmt>0)
						{
							strCol6 =  getResultValue("QIS",strBorrowerId,Integer.toString(intFormulaAmt),strFrom,strTo,"","qis_actuals","QIS1"); 					
						}
						else
						{
							strCol6 = strTemp;
							strCol5 = "";
						}
						finalstring = "0.00";
						
					}
					else if( (strQisType.trim().equals("H1")) || (strQisType.trim().equals("H2")) )
					{
						if(intFormulaAmt>0)
						{
							strCol1 =  getResultValue("Financial",strAppno,Integer.toString(intFormulaAmt),strCurYear,"","e","",""); 
						}
						strCol2 = strCol3;
						strCol3 = strCol4;
						strCol4 = strCol5;
						strCol5 = strCol6;
						finalstring =getLastYearActuals(strCmano,strGroupname,strCurYear,strAppno,strQid); 
					}
					vecVal.add(strCol1);
					vecVal.add(strCol2);
					vecVal.add(strCol3);
					vecVal.add(strCol4);
					vecVal.add(strCol5);
					vecVal.add(strCol6);
					
					vecVal.add(finalstring);
 					vecData.add(vecVal);
	
				}
			}
			hshRecord.put("vecData",vecData);
			hshRecord.put("comapp_id",strBorrowerId);
			hshRecord.put("comapp_name",strBorrowerName);
			hshRecord.put("qistype",strQisType);
			hshRecord.put("year",strYear);
			hshRecord.put("quarter",strQuarter);
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getData "+ce.toString());

		}
		finally
		{
			try
			{
				if(rs!=null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
						
			}
		}
		return hshRecord;
}

	private String getResultValue(String strFormulaTo,String strAppno,String strFormulaId,String strFrom,String strTo,String strFinType,String strQisColName,String strQisType) 
	{
		String strResult="";
		HashMap hshformula = new HashMap();
		try
		{
			
			if(strFormulaTo.trim().equals("Financial"))
			{
				hshformula =  new HashMap();
				hshformula.put("appno",strAppno);
				hshformula.put("formulaid",strFormulaId);
				hshformula.put("curryear",strFrom);
				hshformula.put("prevyear"," ");
				hshformula.put("currfinancialtype",strFinType);
				hshformula.put("prevfinancialtype",strFinType);
				hshformula.put("internalcalc","N");
				hshformula.put("hshdata",new HashMap());
			}
			else if(strFormulaTo.trim().equals("QIS"))
			{
//strAppno represents borrower id
				hshformula.put("appno",strAppno);
				hshformula.put("formulaid",strFormulaId);
				hshformula.put("colname",strQisColName);
				hshformula.put("datefrom",strFrom);
				hshformula.put("dateto",strTo);
				hshformula.put("formulaapply",strQisType);
				hshformula.put("curryear"," ");
				hshformula.put("prevyear"," ");
				hshformula.put("currfinancialtype","");
				hshformula.put("prevfinancialtype","");
				hshformula.put("internalcalc","N");
				hshformula.put("hshdata",new HashMap());
			}
			HashMap  hshRes = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
			strResult = correctNull((String)hshRes.get("strTotalValue"));

		}
		catch(Exception e)
		{
			throw new EJBException("Error closing the connection "+e.getMessage());
		}
		finally
		{
			try
			{
				log.error("test");
 			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
						
			}
		}
		return strResult;
	}

	private String getLastYearActuals(String cma,String tabname,String yeardesc,String appno,String  qisid)
	{
		String selection="",prevyear="",strQuery="",finalstring="",desc="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshformula = new HashMap();
		
		try
		{
			rs=DBUtils.executeLAPSQuery("qisprevfind^"+appno+"^<^"+yeardesc);
			if(rs.next())
			{
				prevyear =(rs.getString("prevyear")) ;
				if(rs.getDouble(2)>0)
				{
					selection = "fin_audit";
					desc = "a";
				}
				else if(rs.getDouble(3)>0)
				{ 
					selection = "fin_unaudit";
					desc = "u";
				}
				else if(rs.getDouble(4)>0)
				{ 
					selection = "fin_estimated";
					desc="e";
				}
				else if(rs.getDouble(5)>0)
				{ 
					selection = "fin_projection";
					desc = "p";
				}
				

			}
			
	if(!selection.equals(""))
			{
			
			strQuery =SQLParser.getSqlQuery("qisprevactuals^"+selection+"^"+cma+"^"+tabname+"^"+prevyear+"^"+appno+"^"+qisid);
			rs=DBUtils.executeQuery(strQuery);
			if (rs.next())
					{
						int formuladesc=0;
						formuladesc =(rs.getInt("formula")) ;
						if (formuladesc > 0 )
						{
						 hshformula =  new HashMap();
						hshformula.put("appno",appno);
						hshformula.put("formulaid",Integer.toString(formuladesc));
						hshformula.put("curryear",prevyear);
						hshformula.put("prevyear"," ");
						hshformula.put("currfinancialtype",desc);
						hshformula.put("prevfinancialtype","a");
						hshformula.put("internalcalc","N");
						hshformula.put("hshdata",new HashMap());
						HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
							finalstring = correctNull((String)hshRes.get("strTotalValue"));
							

						}
						else
						{
							finalstring=correctNull(rs.getString("txtvalue"));
							

						}
					}
			else
			{
				finalstring = "0.00";
			}
		}
		else
			{
				finalstring = "0.00";
			}

		}
		catch(Exception e)
		{
			throw new EJBException("Error closing the connection "+e.getMessage());
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
		return finalstring;
	}


 
}


