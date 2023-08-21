package com.sai.laps.ejb.notefinmaster;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "NoteFinMasterBean", mappedName = "NoteFinMasterHome")
@Remote (NoteFinMasterRemote.class)
public class NoteFinMasterBean extends BeanAdapter
{
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(NoteFinMasterBean.class);
	private static final long serialVersionUID = 1L;

	public HashMap updateData(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshValues = new HashMap();
		ArrayList arr = new ArrayList();		
		ResultSet rs=null;
		ResultSet rs6=null;
		String val="",id="",strQuery ="";
		String value1="",value2="",value3="",value4="",value5="",value6="",value3a="";
		String value7="",value8="",value10="",value11="",value12="";
		int intValue = 0;
		String strKeyId = "";
		StringBuilder sbolddata = new StringBuilder();
		
		try
		{	
			strKeyId = Helper.correctNull((String)hsh.get("hidkeyid"));
			if(Helper.correctNull((String)hsh.get("hidval")).equalsIgnoreCase("update") || 
					Helper.correctNull((String)hsh.get("hidval")).equalsIgnoreCase("delete"))
			{
				rs = DBUtils.executeLAPSQuery("sel_notecomfinmaster_audit^"+Helper.correctNull((String)hsh.get("sno")));
				if(rs.next())
				{
					String strCategory = Helper.correctNull((String)rs.getString("fin_page"));
					String strRowFor = Helper.correctNull((String)rs.getString("FIN_ROWTYPE"));
					sbolddata.append("~ Category = ");
					if(strCategory.equalsIgnoreCase("FI")) sbolddata.append("Financial - Note To Dir");
					else if(strCategory.equalsIgnoreCase("CA")) sbolddata.append("CashFlow - Note To Dir");
					else if(strCategory.equalsIgnoreCase("FU")) sbolddata.append("FundFlow -Note To Dir");
					else if(strCategory.equalsIgnoreCase("RA")) sbolddata.append("Ratios -Note To Dir");
					else if(strCategory.equalsIgnoreCase("MPBF1")) sbolddata.append("Assessment - MPBF1 -Note To Dir");
					else if(strCategory.equalsIgnoreCase("MST")) sbolddata.append("Modification of Sanction");
					sbolddata.append("~ CMA Index = "+Helper.correctNull((String)rs.getString("cma_format_desc")));
					sbolddata.append("~ Title = "+Helper.correctNull((String)rs.getString("fin_tabname")));
					sbolddata.append("~ Row Description = "+Helper.correctNull((String)rs.getString("FIN_ROWDESC")));
					if(strCategory.equalsIgnoreCase("FI"))
					{
						sbolddata.append("~ Attach Financial Indicators = "+Helper.correctNull((String)rs.getString("fin_attach")));
						if(Helper.correctNull((String)rs.getString("fin_attach")).equalsIgnoreCase("1")) sbolddata.append("fin_indicator");
					}
					sbolddata.append("~ Row For = ");
					if(strRowFor.equalsIgnoreCase("C")) sbolddata.append("Calculated");
					else if(strRowFor.equalsIgnoreCase("H")||strRowFor.equalsIgnoreCase("HE")) sbolddata.append("Heading");
					else if(strRowFor.equalsIgnoreCase("FO")) sbolddata.append("Formula");
					else sbolddata.append("");
					sbolddata.append("~ S.No = "+Helper.correctNull((String)rs.getString("fin_sno")));
					if(strRowFor.equalsIgnoreCase("C"))
					{
						sbolddata.append("~ Formula = "+Helper.correctNull((String)rs.getString("FORMULA_ROWNAME")));
						sbolddata.append("~ Formula 2= "+Helper.correctNull((String)rs.getString("")));
					}
				}
				if(rs!=null)
				rs.close();
			}
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
			if (value8.equals(""))
			{
				if (value7.equals("FI"))
				{
					strQuery = SQLParser.getSqlQuery("notefinsnomaxa^"+value7+"^"+value6+"^"+value5);
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
					strQuery = SQLParser.getSqlQuery("notefinsnomaxb^"+value7+"^"+value6);
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
			
			
			strQuery = SQLParser.getSqlQuery("notefinmastermax");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				intValue = (rs.getInt(1));
			}
			intValue = intValue + 1;
			id= Integer.toString(intValue);
			
			
			if (val.equals("insert"))
			{
				strQuery = SQLParser.getSqlQuery("notefinmastermax");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					intValue = (rs.getInt(1));
				}
				intValue = intValue + 1;
				id= Integer.toString(intValue);
				if (value7.equals("FI") )
				{
					arr.add(id);
					arr.add(value2);
					arr.add(value3);
					arr.add(value4);
					arr.add(value5);
					arr.add(value6);
					arr.add(value7);
					arr.add(value8);
					arr.add(value11);
					
					arr.add(Helper.correctNull((String)hsh.get("sel_attach")));
					arr.add(Helper.correctNull((String)hsh.get("sel_finind")));
					hshquery.put("arrValues",arr);
					hshquery.put("strQueryId","notefinmasterinsert");
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
					
					arr.add("");
					arr.add("");
					hshquery.put("arrValues",arr);
					hshquery.put("strQueryId","notefinmasterinsert");
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
				if (value7.equals("FI") )
				{
					
					
					//added by s.sathya moorthy bcoz of the note to mcb row desc problem.
					
					
					strQuery = SQLParser.getSqlQuery("notefinmaster_Fin_UpdateCheck^"+value3+"^"+value6+"^"+value7+"^"+value8);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
								
					
					arr.add(value2);
					arr.add(value3);
					arr.add(value4);
					arr.add(value5);
					arr.add(value6);
					arr.add(value7);
					arr.add(value8);
					arr.add(value11);
					
					arr.add(Helper.correctNull((String)hsh.get("sel_attach")));
					arr.add(Helper.correctNull((String)hsh.get("sel_finind")));
					arr.add(value1);
					
					
					hshquery.put("arrValues",arr);
					hshquery.put("strQueryId","notefinmasterupdate");
					hshqueryval.put("size","1");
					hshqueryval.put("1",hshquery);
					
					}
					else
					{
						//other wise insert into database
						
						arr.add(id);
						arr.add(value2);
						arr.add(value3);
						arr.add(value4);
						arr.add(value5);
						arr.add(value6);
						arr.add(value7);
						arr.add(value8);
						arr.add(value11);
						
						arr.add(Helper.correctNull((String)hsh.get("sel_attach")));
						arr.add(Helper.correctNull((String)hsh.get("sel_finind")));
						hshquery.put("arrValues",arr);
						hshquery.put("strQueryId","notefinmasterinsert");
						hshqueryval.put("size","1");
						hshqueryval.put("1",hshquery);
						hshValues.put("tabtitle",hsh.get("tabtitle"));
					
						
					}
				
				}
				else
				{
					
//added by s.sathya moorthy bcoz of the note to mcb row desc problem. for other than financials.
					
					
					strQuery = SQLParser.getSqlQuery("notefinmaster_Fin_UpdateCheck^"+value3+"^"+value6+"^"+value7+"^"+value8);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
					
					arr.add(value2);
					arr.add(value3);
					arr.add(value4);
					arr.add("");
					arr.add(value6);
					arr.add(value7);
					arr.add(value8);
					arr.add(value11);
					arr.add("");
					arr.add("");
					arr.add(value1);
					
					
					hshquery.put("arrValues",arr);
					hshquery.put("strQueryId","notefinmasterupdate");
					hshqueryval.put("size","1");
					hshqueryval.put("1",hshquery);
					
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
						
						arr.add("");
						arr.add("");
						hshquery.put("arrValues",arr);
						hshquery.put("strQueryId","notefinmasterinsert");
						hshqueryval.put("size","1");
						hshqueryval.put("1",hshquery);
						hshValues.put("tabtitle",hsh.get("tabtitle"));
						
						
						
						
					}
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
				hshValues.put("attach",hsh.get("sel_attach"));
				hshValues.put("indicator",hsh.get("sel_finind"));
			}
			if (val.equals("delete"))
			{
				intValue=0;
				strQuery = SQLParser.getSqlQuery("notefinmasterdelcheck^"+value1);
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
					hshquery.put("strQueryId","notefinmasterdelete");
					arr.add(value1);
					hshquery.put("arrValues",arr);
					hshqueryval.put("1",hshquery);
					EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
					hshValues.put("success","Y");
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
			
			//putting into the Audit Trial Logs...
			StringBuilder sbAt = new StringBuilder();
			if(Helper.correctNull((String)hsh.get("hidval")).equalsIgnoreCase("update") || 
					Helper.correctNull((String)hsh.get("hidval")).equalsIgnoreCase("insert")){
			String strCat=correctNull((String)hsh.get("select_page"));
			if(strCat.equalsIgnoreCase("FI"))strCat="Financial - Note To Dir";
			else if(strCat.equalsIgnoreCase("CA"))strCat="CashFlow - Note To Dir";
			else if(strCat.equalsIgnoreCase("FU"))strCat="FundFlow -Note To Dir";
			else if(strCat.equalsIgnoreCase("RA"))strCat="Ratios -Note To Dir";
			else if(strCat.equalsIgnoreCase("MPBF1"))strCat="Assessment - MPBF1 -Note To Dir";
			else if(strCat.equalsIgnoreCase("MST")) strCat="Modification of Sanction";
			sbAt.append("~Category=").append(strCat);
			sbAt.append("~CMA Index=").append(correctNull((String)hsh.get("cmaformat")));
			sbAt.append("~Title=").append(correctNull((String)hsh.get("tabtitle")));
			sbAt.append("~Row Description=").append(correctNull((String)hsh.get("rowdesc")));
			String strType=correctNull((String)hsh.get("select_type"));
			if(strType.equalsIgnoreCase("C"))strType="Calculated";
			else if(strType.equalsIgnoreCase("H")||strType.equalsIgnoreCase("HE"))strType="Heading";
			else if(strType.equalsIgnoreCase("FO"))strType="Formula";
			else strType="";
			sbAt.append("~Row For=").append(strType);
			sbAt.append("~S.no=").append(correctNull((String)hsh.get("txtorder")));
			if(strType.equalsIgnoreCase("C"))
			{
			sbAt.append("~Formula=").append(correctNull((String)hsh.get("formula")));
			sbAt.append("~Formula1=").append(correctNull((String)hsh.get("formulano2")));
			}
			}
			hsh.put("hidAction",val);
			if(val.equalsIgnoreCase("update"))
				AuditTrial.auditNewLog(hsh,"112",strKeyId,sbAt.toString(),sbolddata.toString());
			if(val.equalsIgnoreCase("insert"))
				AuditTrial.auditLog(hsh,"112",strKeyId,sbAt.toString());
				
		}
		catch (Exception e)
		{
			log.error("in bean"+e);
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
		String strQuery3="";
		ResultSet rs=null;
		ResultSet rs3=null;
		HashMap hshvalues = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		String str="",value5="",value6="",value7="";
		boolean recordflag=false;
		try
		{			
			str=(String)hsh.get("hidval");
			str=str.trim();
			value5 =Helper.correctNull((String)hsh.get("tabtitle"));
			value6 =Helper.correctNull((String)hsh.get("cmano"));
			value7 =Helper.correctNull((String)hsh.get("pagetitle"));
			String strFI="FI";		
			
			if (str.equals("formula") || str.equals("formula2") )
			{
				strQuery = SQLParser.getSqlQuery("noteformulachoice^"+value6);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arr.add(correctNull(rs.getString("formula_rowid")));
					arr1.add(correctNull(rs.getString("formula_rowname")));
				}
				rs.close();
				strQuery = SQLParser.getSqlQuery("description1^"+strFI+"^"+value6);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arr.add(correctNull(rs.getString("fin_rowid")));
					arr1.add(correctNull(rs.getString("fin_rowdesc")));
				}
				hshvalues.put("arrVal",arr);
				hshvalues.put("arrValdesc",arr1);
				rs.close();
			}

			if (str.equals("cma")|| str.equals("cma1") || str.equals("ratingcma") )
			{
				strQuery = SQLParser.getSqlQuery("notecmachoice");				
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					recordflag=true;
					arr.add(correctNull(rs.getString("cma_no")));
					arr1.add(correctNull(rs.getString("cma_format_desc")));
				}
				hshvalues.put("arrVal",arr);
				hshvalues.put("arrValdesc",arr1);
				rs.close();
			}
			if (str.equals("tabtitle"))
			{
				strQuery = SQLParser.getSqlQuery("tabchoice^"+value6+"^"+value7);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arr.add(correctNull(rs.getString("fin_tabname")));
					arr1.add(correctNull(rs.getString("fin_tabname")));
				}
				hshvalues.put("arrVal",arr);
				hshvalues.put("arrValdesc",arr1);
				rs.close();
			}

			if (str.equals("selfdescription") )
			{
				strQuery = SQLParser.getSqlQuery("notedescription1^"+value7+"^"+value6);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arr.add(correctNull(rs.getString("fin_rowid")));
					arr1.add(correctNull(rs.getString("fin_rowdesc")));
				}
				hshvalues.put("arrVal",arr);
				hshvalues.put("arrValdesc",arr1);
				rs.close();
			}

			if (str.equals("description") )
			{
				strQuery = SQLParser.getSqlQuery("notedescription2^"+value6);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arr.add(correctNull(rs.getString("fin_rowid")));
					arr1.add(correctNull(rs.getString("fin_rowdesc")));
				}
				hshvalues.put("arrVal",arr);
				hshvalues.put("arrValdesc",arr1);
				rs.close();
			}

			if(str.equals("rowdesc"))
			{
				if (value7.equals("FI") && !value5.trim().equals(""))
				{
					strQuery = SQLParser.getSqlQuery("noterowchoice^"+value6+"^"+value5+"^"+value7);
				}
				else
				{
					strQuery = SQLParser.getSqlQuery("noterowchoicea^"+value6+"^"+value7);
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
							strQuery3 = SQLParser.getSqlQuery("notefinformuladesc^"+formula2);
							rs3=DBUtils.executeQuery(strQuery3);
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
						totalval=formuladesc+"^"+rowid+"^"+correctNull(rs.getString("fin_rowtype"))+"^"+correctNull(rs.getString("fin_rowid"))+"^"+correctNull(rs.getString("fin_sno"))+"^"+value7+"^"+correctNull(rs.getString("fin_formula"))+"^"+formula2+"^"+formula2desc;
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
				rs.close();
			}
		}
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
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
				log.error("error occured"+e1.toString());
			}
		}
		return hshvalues;
	}
}