package com.sai.laps.ejb.finmaster;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import com.sai.laps.ejb.financial.FinancialRemote;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "FinMasterBean", mappedName = "FinMasterHome")
@Remote (FinMasterRemote.class)
public class FinMasterBean extends BeanAdapter
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;



	public HashMap updateData(HashMap hsh) 
	{
		
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshValues = new HashMap();
		HashMap hshQuery ;
		ArrayList arr = new ArrayList();
		ArrayList arrValues ;		
		ResultSet rs=null;
		ResultSet rs6=null;
		String val="",id="",strValue="",strQuery ="";
		String value1="",value2="",value3="",value4="",value5="",value6="",value3a="";
		String value7="",value8="",value9="",value10="",value11="",value12="",value13="",value14="",strKalyptoCode="",strExperianCode="";
		int intValue = 0;
		String strKeyId = "";
		StringBuilder sbolddata = new StringBuilder();
		try
		{
				strKeyId = Helper.correctNull((String)hsh.get("hidkeyid"));
				value1 =Helper.correctNull((String)hsh.get("sno"));
				value2 =Helper.correctNull((String)hsh.get("rowdesc"));
				value3 =Helper.correctNull((String)hsh.get("select_type"));
				value3a =Helper.correctNull((String)hsh.get("select_type"));
				value4 =Helper.correctNull((String)hsh.get("formulano"));				
				
				if (value4.equals(""))
				{
					value4="0";
				}
				value5 =Helper.correctNull((String)hsh.get("tabtitle"));
				value6 =Helper.correctNull((String)hsh.get("cmano"));
				value7 =Helper.correctNull((String)hsh.get("select_page"));
				value8 =Helper.correctNull((String)hsh.get("txtorder"));
				value10 = Helper.correctNull((String)hsh.get("formula"));
				value11 = Helper.correctNull((String)hsh.get("formulano2"));
				value12 = Helper.correctNull((String)hsh.get("formula2"));
				value13 = Helper.correctNull((String)hsh.get("stressrdo"));
				value14 = Helper.correctNull((String)hsh.get("stresspercent"));
				strKalyptoCode = Helper.correctNull((String)hsh.get("txt_kalypto_code"));
				strExperianCode=Helper.correctNull((String)hsh.get("txt_experian_code"));
				if(Helper.correctNull((String)hsh.get("hidval")).equalsIgnoreCase("update") || 
						Helper.correctNull((String)hsh.get("hidval")).equalsIgnoreCase("delete"))
				{
					rs = DBUtils.executeLAPSQuery("sel_cmamaster_audit^"+value1);
					if(rs.next())
					{
						String strCategory = Helper.correctNull((String)rs.getString("fin_page"));
						String strStress = Helper.correctNull((String)rs.getString("FIN_STRESS"));
						String strRowfor = Helper.correctNull((String)rs.getString("FIN_ROWTYPE"));
						sbolddata.append("~ Category = ");
						if(strCategory.equalsIgnoreCase("FI")) sbolddata.append("Financial");
						else if(strCategory.equalsIgnoreCase("CA")) sbolddata.append("Cash Flow");
						else if(strCategory.equalsIgnoreCase("FU")) sbolddata.append("Fund Flow");
						else if(strCategory.equalsIgnoreCase("RA")) sbolddata.append("Ratios");
						else if(strCategory.equalsIgnoreCase("SCA")) sbolddata.append("Stress Flow");						
						else if(strCategory.equalsIgnoreCase("MPBF1")) sbolddata.append("Assessment - MPBF1");
						else if(strCategory.equalsIgnoreCase("MPBF2")) sbolddata.append("Assessment - MPBF2");
						else if(strCategory.equalsIgnoreCase("PBF1")) sbolddata.append("Assessment - PBF1");
						else if(strCategory.equalsIgnoreCase("PBF2")) sbolddata.append("Assessment - PBF2");
						else if(strCategory.equalsIgnoreCase("PBF3")) sbolddata.append("Assessment - PBF3");
						else if(strCategory.equalsIgnoreCase("PBF4")) sbolddata.append("Assessment - PBF4");
						else if(strCategory.equalsIgnoreCase("TO")) sbolddata.append("Assessment - Turn Over");
						sbolddata.append("~ CMA Index = "+Helper.correctNull((String)rs.getString("cma_format_desc")));
						sbolddata.append("~ Title = "+Helper.correctNull((String)rs.getString("fin_tabname")));
						sbolddata.append("~ Row Description = "+Helper.correctNull((String)rs.getString("FIN_ROWDESC")));
						sbolddata.append("~ Row For = ");
						if(strRowfor.equalsIgnoreCase("I")) sbolddata.append("Blank");
						else if(strRowfor.equalsIgnoreCase("C")) sbolddata.append("Calculated");
						else if(strRowfor.equalsIgnoreCase("H")) sbolddata.append("Heading");
						else if(strRowfor.equalsIgnoreCase("E")) sbolddata.append("Enterable");
						sbolddata.append("~ S.No = "+Helper.correctNull((String)rs.getString("FIN_SNO")));
						sbolddata.append("~ Formula = "+Helper.correctNull((String)rs.getString("FORMULA_ROWNAME")));
						sbolddata.append("~ Stress Analysis = ");
						if(strStress.equalsIgnoreCase("N")) sbolddata.append("No");
						else sbolddata.append("Yes");
						//sbolddata.append("~ Stress Percentage = "+Helper.correctNull((String)rs.getString("FIN_STRESS_PERCENT")));
					}
					if(rs!=null)
					rs.close();
				}
				if (value14.equals(""))
				{
					value14="0";
				}
				
				if (value8.equals(""))
				{
					if (value7.equals("FI"))
					{						
						strQuery = SQLParser.getSqlQuery("finsnomaxa^"+value7+"^"+value6+"^"+value5);
						rs6=DBUtils.executeQuery(strQuery);
						if(rs6.next())
							{
								intValue = (rs6.getInt(1));
							}
						intValue = intValue + 1;
						value8= Integer.toString(intValue);
					}
					else
					{								
						strQuery = SQLParser.getSqlQuery("finsnomaxb^"+value7+"^"+value6);
						rs6=DBUtils.executeQuery(strQuery);
						if(rs6.next())
							{
								intValue = (rs6.getInt(1));
							}
						intValue = intValue + 1;
						value8= Integer.toString(intValue);
					}
				}

				
				if (value11.equals(""))
				{
					value11="0";
				}

				val=correctNull((String)hsh.get("hidval"));
				val=val.trim();

				if (val.equals("insert"))
				{						
						strQuery = SQLParser.getSqlQuery("finmastermax");
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
							{
								intValue = (rs.getInt(1));
							}
						intValue = intValue + 1;
						id= Integer.toString(intValue);						
						
						if (value7.equals("FI")|| value7.equals("RA")|| value7.equals("MA")|| value7.equals("MU") || value7.equals("INV"))
							
						{
							
						hshqueryval = new HashMap();
						hshquery = new HashMap();
						arr = new ArrayList();
						arr.add(value6);
						arr.add(value7);
						arr.add(value5);
						arr.add(value8);
						hshquery.put("arrValues",arr);
						hshquery.put("strQueryId","finmaster_sno_update");
						hshqueryval.put("size","1");
						hshqueryval.put("1",hshquery);
						EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
						
						hshqueryval = new HashMap();
						hshquery = new HashMap();
						arr = new ArrayList();
						arr.add(id);
						arr.add(value2);
						arr.add(value3);
						arr.add(value4);
						arr.add(value5);
						arr.add(value6);
						arr.add(value7);
						arr.add(value8);
						arr.add(value11);
						arr.add(value13);
						arr.add(value14);
						arr.add(strKalyptoCode);
						arr.add(strExperianCode);
						hshquery.put("arrValues",arr);
						hshquery.put("strQueryId","finmasterinsert");
						hshqueryval.put("size","1");
						hshqueryval.put("1",hshquery);
						hshValues.put("tabtitle",hsh.get("tabtitle"));
						}
						else
						{
						arr.add(id);
						arr.add(value2);
						arr.add(value3);
						arr.add(value4);
						arr.add("");
						arr.add(value6);
						arr.add(value7);
						arr.add(value8);
						arr.add(value11);
						arr.add(value13);
						arr.add(value14);
						arr.add(strKalyptoCode);
						arr.add(strExperianCode);
						hshquery.put("arrValues",arr);
						hshquery.put("strQueryId","finmasterinsert");
						hshqueryval.put("size","1");
						hshqueryval.put("1",hshquery);
						hshValues.put("tabtitle",hsh.get("tabtitle"));
						}
					EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
					hshValues.put("sno",id);
					hshValues.put("cmano",hsh.get("cmano"));
					hshValues.put("cmaformat",hsh.get("cmaformat"));
					hshValues.put("select_page",hsh.get("select_page"));
						
					}
				if (val.equals("update"))
				{
					if (value7.equals("FI") || value7.equals("RA") || value7.equals("MA")|| value7.equals("MU")|| value7.equals("INV"))
						{
						arr.add(value2);
						arr.add(value3);
						arr.add(value4);
						arr.add(value5);
						arr.add(value6);
						arr.add(value7);
						arr.add(value8);
						arr.add(value11);
						arr.add(value13);
						arr.add(value14);
						arr.add(strKalyptoCode);
						arr.add(strExperianCode);
						arr.add(value1);
						hshquery.put("arrValues",arr);
						hshquery.put("strQueryId","finmasterupdate");
						hshqueryval.put("size","1");
						hshqueryval.put("1",hshquery);
						}
						else
						{
						arr.add(value2);
						arr.add(value3);
						arr.add(value4);
						arr.add("");
						arr.add(value6);
						arr.add(value7);
						arr.add(value8);
						arr.add(value11);
						arr.add(value13);
						arr.add(value14);
						arr.add(strKalyptoCode);
						arr.add(strExperianCode);
						arr.add(value1);
						hshquery.put("arrValues",arr);
						hshquery.put("strQueryId","finmasterupdate");
						hshqueryval.put("size","1");
						hshqueryval.put("1",hshquery);
							
						}
						
						EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
						hshValues.put("sno",hsh.get("sno"));
						hshValues.put("rowdesc",hsh.get("rowdesc"));
						hshValues.put("select_type",hsh.get("select_type"));
						hshValues.put("formulano",hsh.get("formulano"));
						hshValues.put("formula",hsh.get("formula"));
						hshValues.put("tabtitle",hsh.get("tabtitle"));
						hshValues.put("cmano",hsh.get("cmano"));
						hshValues.put("cmaformat",hsh.get("cmaformat"));
						hshValues.put("select_page",hsh.get("select_page"));
						hshValues.put("order",hsh.get("txtorder"));
						hshValues.put("formula2",hsh.get("formula2"));
						hshValues.put("formulano2",hsh.get("formulano2"));
						hshValues.put("stressrdo",hsh.get("stressrdo"));
						hshValues.put("stresspercent",hsh.get("stresspercent"));
						hshValues.put("txt_kalypto_code",hsh.get("txt_kalypto_code"));
						hshValues.put("txt_experian_code",hsh.get("txt_experian_code"));
				}

				if (val.equals("delete"))
				{
					  intValue=0;
					  strQuery = SQLParser.getSqlQuery("finmasterdelcheck^"+value1);
					  rs=DBUtils.executeQuery(strQuery);
					  while(rs.next())
					  {
							intValue = (rs.getInt(1));
					  }
					  if (intValue <= 0)
					  {
							
						hshqueryval = new HashMap();
						hshquery = new HashMap();
						arr = new ArrayList();
						hshqueryval.put("size","1");
						hshquery.put("strQueryId","finmasterdelete");
						arr.add(value1);
						hshquery.put("arrValues",arr);
						hshqueryval.put("1",hshquery);
						EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
						hshValues.put("success","Y");
							
						hshqueryval = new HashMap();
						hshquery = new HashMap();
						arr = new ArrayList();
						arr.add(value6);
						arr.add(value7);
						arr.add(value5);
						arr.add(value8);
						hshquery.put("arrValues",arr);
						hshquery.put("strQueryId","finmaster_sno_update_minus");
						hshqueryval.put("size","1");
						hshqueryval.put("1",hshquery);
						EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
					  } 
					  else
					  {
						hshValues.put("success","N");
							
					  }
					hshValues.put("tabtitle",hsh.get("tabtitle"));
					hshValues.put("cmano",hsh.get("cmano"));
					hshValues.put("cmaformat",hsh.get("cmaformat"));
					hshValues.put("select_page",hsh.get("select_page"));
						
				}
				
				StringBuilder sbAuditTrial=new  StringBuilder();
				
				if(!val.equals("delete")){
				String strstressnew="";
				if(value13.equalsIgnoreCase("N")){strstressnew="No";
				}else{ strstressnew="Yes";}
				
				if(value7.equals("FI"))value7="Financial";
				if(value7.equals("CA"))value7="CashFlow";
				if(value7.equals("FU"))value7="FundFlow";
				if(value7.equals("RA"))value7="Ratios";
				if(value7.equals("SCA"))value7="StressCashFlow";
				if(value7.equals("MPBF1"))value7="Assessment - MPBF1";
				if(value7.equals("MPBF2"))value7="Assessment - MPBF2";
				if(value7.equals("PBF1"))value7="Assessment  - PBF1";
				if(value7.equals("PBF2"))value7="Assessment - PBF2";
				if(value7.equals("PBF3"))value7="Assessment - PBF3";
				if(value7.equals("PBF4"))value7="Assessment - PBF4";
				if(value7.equals("TO"))value7="Assessment  - Turn Over";
				sbAuditTrial.append("Category=").append(value7);
				sbAuditTrial.append("~CMA Index=").append(correctNull((String)hsh.get("cmaformat")));
				sbAuditTrial.append("~Title=").append(value5);
				sbAuditTrial.append("~Row Description=").append(value2);
	           if(value3.equals("C"))value3="Calculated";
               if(value3.equals("H"))value3="Heading";
               if(value3.equals("E"))value3="Enterable";
				sbAuditTrial.append("~Row For=").append(value3);
				sbAuditTrial.append("~S.no=").append(value8);
				sbAuditTrial.append("~Formula=").append(value10);
				//sbAuditTrial.append("~Formula2=").append(value12);
				sbAuditTrial.append("~Stress Analysis=").append(strstressnew);
				//sbAuditTrial.append("~Stress Percentage=").append(value14);
				}
				
				hsh.put("strAction",hsh.get("hidval"));
				AuditTrial.auditNewLog(hsh,"103",strKeyId,sbAuditTrial.toString(),sbolddata.toString());
		}
			
	
		catch (Exception e)
		{
			throw new EJBException("Error Occured  "+e.getMessage());
		}
		finally
		{
			try
			{
				
				if(rs != null)
				{
					rs.close();
				}
				if(rs6 != null)
				{
					rs6.close();
				}
				

			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
						
			}
		}
		hshValues.put("hidval",val);
		return hshValues;
		
		
	}

	
	
	public HashMap getDataHelp(HashMap hsh) 
	{		
		String strQuery="";
		String strQuery1="";
		ResultSet rs=null;
		ResultSet rs3=null;		
		HashMap hshvalues = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		String str="",value5="",value6="",value7="";
		boolean recordflag=false; 
		try
			{		
				
				str=correctNull((String)hsh.get("val"));
				str=str.trim();
				value5 =Helper.correctNull((String)hsh.get("tabtitle"));
				value6 =Helper.correctNull((String)hsh.get("cmano"));
				value7 =Helper.correctNull((String)hsh.get("pagetitle"));
				
				if (str.equals("formula") || str.equals("formula2") )
				{										
					strQuery = SQLParser.getSqlQuery("formulachoice^"+value6);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						arr.add(correctNull(rs.getString("formula_rowid")));
						arr1.add(correctNull(rs.getString("formula_rowname")));
					}
					hshvalues.put("arrVal",arr);
					hshvalues.put("arrValdesc",arr1);
				}

				if (str.equals("cma")|| str.equals("cma1") || str.equals("ratingcma") )
				{
					strQuery = SQLParser.getSqlQuery("cmachoice");					
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						arr.add(correctNull(rs.getString("cma_no")));
						arr1.add(correctNull(rs.getString("cma_format_desc")));
					}
					hshvalues.put("arrVal",arr);
					hshvalues.put("arrValdesc",arr1);
				}
				if (str.equals("tabtitle"))
				{
					strQuery = SQLParser.getSqlQuery("tabchoice^"+value6+"^"+value7);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						recordflag=true;
						arr.add(correctNull(rs.getString("fin_tabname")));
						arr1.add(correctNull(rs.getString("fin_tabname")));
					}
					hshvalues.put("arrVal",arr);
					hshvalues.put("arrValdesc",arr1);
				}

				if (str.equals("selfdescription") )
				{
					strQuery = SQLParser.getSqlQuery("description1^"+value7+"^"+value6);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						arr.add(correctNull(rs.getString("fin_rowid")));
						arr1.add(correctNull(rs.getString("fin_rowdesc")));
					}
					hshvalues.put("arrVal",arr);
					hshvalues.put("arrValdesc",arr1);
				}

				if (str.equals("description") )
				{
					strQuery = SQLParser.getSqlQuery("description2^"+value6);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						arr.add(correctNull(rs.getString("fin_rowid")));
						arr1.add(correctNull(rs.getString("fin_rowdesc")));
					}
					hshvalues.put("arrVal",arr);
					hshvalues.put("arrValdesc",arr1);
				}

				if(str.equals("rowdesc"))
				{
					if (value7.equals("FI"))
					{
					strQuery = SQLParser.getSqlQuery("rowchoice^"+value6+"^"+value5+"^"+value7);
					}
					else
					{
					strQuery = SQLParser.getSqlQuery("rowchoicea^"+value6+"^"+value7);
					}
						
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						String totalval;
						String rowid = "",formuladesc="",coltype="",formula2="",formula2desc="";
						
										
						if(!correctNull(rs.getString("fin_rowdesc").trim()).equals(""))
						{
							
							rowid=correctNull(rs.getString("formula_rowid"));
							coltype=correctNull(rs.getString("fin_rowtype"));
							coltype=coltype.trim();
							
							if (rowid.equals(""))
							{
								rowid="0";
							}
							
							formuladesc=correctNull(rs.getString("formula_rowname"));
							formula2=correctNull(rs.getString("fin_formula2"));
							if (!formula2.equals("0") && !formula2.equals("") )
							{								
								strQuery1 = SQLParser.getSqlQuery("finformuladesc^"+formula2);
								rs3=DBUtils.executeQuery(strQuery1);
								while(rs3.next())
								{
									formula2desc=correctNull(rs3.getString("formula_rowname"));
								}
									formula2=correctNull(rs.getString("fin_formula2"));
							}
							else
							{
								formula2="";
								formula2desc="";

							}
							formuladesc.trim();
							totalval=formuladesc+"^"+rowid+"^"+correctNull(rs.getString("fin_rowtype"))+"^"+correctNull(rs.getString("fin_rowid"))+"^"+correctNull(rs.getString("fin_sno"))+"^"+value7+"^"+correctNull(rs.getString("fin_formula"))+"^"+formula2+"^"+formula2desc+"^"+correctNull(rs.getString("fin_stress"))+"^"+correctNull(rs.getString("fin_stress_percent"));
							
							arr.add(totalval);
							arr1.add(correctNull(rs.getString("fin_rowdesc")));
						}
					}
					hshvalues.put("arrVal",arr);
					hshvalues.put("arrValdesc",arr1);
					if(recordflag)
						hshvalues.put("recordflag","Y");
					else
						hshvalues.put("recordflag","N");
				}
				
			}
		
		catch (Exception e)
			{
			throw new EJBException("Error Occured  "+e.getMessage());
			}

			finally
			{
				try
				{
					if(rs!= null)
					{
						rs.close();
					}
					if(rs3!= null)
					{
						rs3.close();
					}
					
				}
				catch (Exception e1)
				{
					throw new EJBException("Error Occured  "+e1.getMessage());
				}
			}
			
			return hshvalues;
	}
	

	public HashMap updateBenchmarkRatio(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshValues = new HashMap();
		HashMap hshQuery ;
		ArrayList arr = new ArrayList();
		ArrayList arrValues ;
		ResultSet rs=null;
		ResultSet rs6=null;
		String val="",id="",strValue="",strQuery ="";
		String value1="",value2="",value3="",value4="",value5="",value6="",value3a="";
		String value7="",value8="",value9="",value10="",value11="",value12="",value13="",value14="";
		int intValue = 0;
		try
		{
				value1 =Helper.correctNull((String)hsh.get("sno"));
				value2 =Helper.correctNull((String)hsh.get("rowdesc"));
				value3 =Helper.correctNull((String)hsh.get("select_type"));
				value4 =Helper.correctNull((String)hsh.get("formulano"));
				value6 =Helper.correctNull((String)hsh.get("cmano"));
				value8 =Helper.correctNull((String)hsh.get("txtorder"));
				value10 = Helper.correctNull((String)hsh.get("formula"));
				if (value14.equals(""))
				{
					value14="0";
				}

				val=correctNull((String)hsh.get("hidval"));
				val=val.trim();


				if (val.equals("insert"))
				{
						
						strQuery = SQLParser.getSqlQuery("com_benchmarkRatio_max^" +Helper.correctNull((String)hsh.get("cmano")));
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
							{
								intValue = (rs.getInt(1));
							}
						intValue = intValue + 1;
						id= Integer.toString(intValue);
							arr.add(id);
							arr.add(Helper.correctNull((String)hsh.get("cmano")));
							arr.add(Helper.correctNull((String)hsh.get("rowdesc")));
							arr.add(Helper.correctNull((String)hsh.get("txt_lending")));
							arr.add(Helper.correctNull((String)hsh.get("sel_depends")));
							arr.add(Helper.correctNull((String)hsh.get("formulano")));
							hshquery.put("arrValues",arr);
							hshquery.put("strQueryId","com_benchmarkRatio_ins");
							hshqueryval.put("size","1");
							hshqueryval.put("1",hshquery);
						
					EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
					hshValues.put("sno",id);
					hshValues.put("cmano",hsh.get("cmano"));
					hshValues.put("cmaformat",hsh.get("cmaformat"));
					
				}
				if (val.equals("update"))
				{
						
							arr.add(Helper.correctNull((String)hsh.get("cmano")));
							arr.add(Helper.correctNull((String)hsh.get("rowdesc")));
							arr.add(Helper.correctNull((String)hsh.get("txt_lending")));
							arr.add(Helper.correctNull((String)hsh.get("sel_depends")));
							arr.add(Helper.correctNull((String)hsh.get("formulano")));
							arr.add(Helper.correctNull((String)hsh.get("sno")));
							arr.add(Helper.correctNull((String)hsh.get("cmano")));
							hshquery.put("arrValues",arr);
							hshquery.put("strQueryId","com_benchmarkRatio_upd");
							hshqueryval.put("size","1");
							hshqueryval.put("1",hshquery);
						
						EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
						hshValues.put("sno",hsh.get("sno"));
						hshValues.put("cmano",hsh.get("cmano"));
						hshValues.put("cmaformat",hsh.get("cmaformat"));
				}
				if (val.equals("delete"))
				{
					    intValue=0;
					  	hshqueryval = new HashMap();
						hshquery = new HashMap();
						arr = new ArrayList();
						hshqueryval.put("size","1");
						hshquery.put("strQueryId","com_benchmarkRatio_del");
						arr.add(value1);
						hshquery.put("arrValues",arr);
						hshqueryval.put("1",hshquery);
						EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
						hshValues.put("cmano",hsh.get("cmano"));
						hshValues.put("cmaformat",hsh.get("cmaformat"));	
					
				}
				hshValues.put("val",val);	
		}
	
		catch (Exception e)
		{
			throw new EJBException("Error Occured  "+e.getMessage());
		}
		finally
		{
			try
			{
				
				if(rs != null)
				{
					rs.close();
				}
				if(rs6 != null)
				{
					rs6.close();
				}
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
						
			}
		}
		return hshValues;
	}
	
	public HashMap getBenchmarkRatio(HashMap hshValues)  
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();		
		ArrayList vecData1 = new ArrayList();
		ArrayList vecRec1 = new ArrayList();
		ArrayList vecData2 = new ArrayList();
		ArrayList vecRec2 = new ArrayList();
		boolean bstate=false;
		try 
		{			
			String rowid=Helper.correctNull((String)hshValues.get("sno"));
			String cmano=Helper.correctNull((String)hshValues.get("cmano"));
			
			if(!(rowid.equalsIgnoreCase("") && cmano.equalsIgnoreCase("")))
			{
				rs =DBUtils.executeLAPSQuery("com_benchmarkRatio_sel^" +rowid +"^"+cmano);
				while (rs.next()) 
				{	
					hshRecord.put("rowid",correctNull(rs.getString("BENCH_ROWID")));
					hshRecord.put("cmano",correctNull(rs.getString("BENCH_CMANO")));					
					hshRecord.put("rowdes",correctNull(rs.getString("BENCH_ROWDESC")));		
					hshRecord.put("policy",correctNull(rs.getString("BENCH_POLICY")));		
					hshRecord.put("dependson",correctNull(rs.getString("BENCH_DEPENDSON")));		
					hshRecord.put("formula",correctNull(rs.getString("BENCH_FORMULA")));		
					
				}	
			}
			hshRecord.put("hidval",Helper.correctNull((String)hshValues.get("hidval")));
			
			if(rs!=null)
			{
				rs.close();
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
				if(rs!=null)
				{
					rs.close();
				}	
			} 
			catch (Exception cf) 
			{
				throw new EJBException("Error closing the getBenchmarkRatio connection "+ cf.getMessage());
			}
		}
		return hshRecord;
	}
	
	
		

}




