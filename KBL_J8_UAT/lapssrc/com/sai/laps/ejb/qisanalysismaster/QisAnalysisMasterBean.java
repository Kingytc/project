package com.sai.laps.ejb.qisanalysismaster;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;


@Stateless(name = "QisAnalysisMasterBean", mappedName = "QisAnalysisMasterHome")
@Remote (QisAnalysisMasterRemote.class)
public class QisAnalysisMasterBean extends BeanAdapter
{
	static Logger log=Logger.getLogger(QisAnalysisMasterBean.class);
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	


	public HashMap updateData(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshValues = new HashMap();
		ArrayList arr = new ArrayList();		
		ResultSet rs=null;
		String val="",id="",strQuery ="";
		String value1="",value2="",value4="",value6="";
		String value12="";
		int intValue = 0;
		
		try
		{
				
				value1 =Helper.correctNull((String)hsh.get("sno"));
				value2 =Helper.correctNull((String)hsh.get("rowdesc"));
				value4 =Helper.correctNull((String)hsh.get("formulano"));
				value12=Helper.correctNull((String)hsh.get("select_type"));
				if (value4.equals(""))
				{
					value4="0";
				}
				
				value6 =Helper.correctNull((String)hsh.get("cmano"));
				val=correctNull((String)hsh.get("hidval"));
				val=val.trim();


				if (val.equals("insert"))
				{
						
						strQuery = SQLParser.getSqlQuery("qisanalysismax");
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
							{
								intValue = (rs.getInt(1));
							}
						intValue = intValue + 1;
						id= Integer.toString(intValue);
						
						
						arr.add(id);
						arr.add(value2);
						arr.add(value4);
						arr.add(value6);
						arr.add(value12);
						
					
						hshquery.put("arrValues",arr);
						hshquery.put("strQueryId","qisanalysisinsert");
						hshqueryval.put("size","1");
						hshqueryval.put("1",hshquery);
												
					EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
					hshValues.put("sno",id);
					hshValues.put("cmano",hsh.get("cmano"));
					hshValues.put("cmaformat",hsh.get("cmaformat"));
				
				
						
					}
					
				

				if (val.equals("update"))
				{
						
						
						arr.add(value2);
						arr.add(value4);
						arr.add(value6);
						arr.add(value12);
						arr.add(value1);
						hshquery.put("arrValues",arr);
						hshquery.put("strQueryId","qisanalysisupdate");
						hshqueryval.put("size","1");
						hshqueryval.put("1",hshquery);
					
						EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
							
				}
				if (val.trim().equals("update"))
				{
					
						hshValues.put("sno",correctNull((String)hsh.get("sno")));
						hshValues.put("rowdesc",hsh.get("rowdesc"));
						hshValues.put("formulano",correctNull((String)hsh.get("formulano")));
						hshValues.put("formula",hsh.get("formula"));
						hshValues.put("cmano",hsh.get("cmano"));
						hshValues.put("cmaformat",hsh.get("cmaformat"));
						hshValues.put("select_type",hsh.get("select_type"));
				
				}
				
				if (val.equals("delete"))
				{
							
						hshqueryval = new HashMap();
						hshquery = new HashMap();
						arr = new ArrayList();
						hshqueryval.put("size","1");
						hshquery.put("strQueryId","qisanalysisdelete");
						arr.add(value1);
						hshquery.put("arrValues",arr);
						hshqueryval.put("1",hshquery);
						EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
						hshValues.put("success","Y");
						
					hshValues.put("cmano",hsh.get("cmano"));
					hshValues.put("cmaformat",hsh.get("cmaformat"));
					
						
				}
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
		ResultSet rs=null;
		HashMap hshvalues = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		String str="",value6="";
		try
			{
			
				str=(String)hsh.get("hidval");
				str=str.trim();
				value6 =Helper.correctNull((String)hsh.get("cmano"));
				if (str.equals("formula") )
				{
										
					strQuery = SQLParser.getSqlQuery("noteformulachoice^"+value6);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						arr.add(correctNull(rs.getString("formula_rowid")));
						arr1.add(correctNull(rs.getString("formula_rowname")));
					}
					hshvalues.put("arrVal",arr);
					hshvalues.put("arrValdesc",arr1);
				}

				if (str.equals("cma") )
				{
					strQuery = SQLParser.getSqlQuery("notecmachoice");
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						arr.add(correctNull(rs.getString("cma_no")));
						arr1.add(correctNull(rs.getString("cma_format_desc")));
					}
					hshvalues.put("arrVal",arr);
					hshvalues.put("arrValdesc",arr1);
				}
				

				if (str.equals("selfdescription") )
				{
					strQuery = SQLParser.getSqlQuery("notedescription1^"+value6);
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
					strQuery = SQLParser.getSqlQuery("notedescription2^"+value6);
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
					
					strQuery = SQLParser.getSqlQuery("qisanalysiarow^"+value6);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						String totalval;
						String rowid = "",formuladesc="",coltype="";
						
										
						if(!correctNull(rs.getString("ratio_desc").trim()).equals(""))
						{
							
							rowid=correctNull(rs.getString("id"));
							coltype=correctNull(rs.getString("ratio_desc"));
							coltype=coltype.trim();
							
							if (rowid.equals(""))
							{
								rowid="0";
							}
							
							formuladesc=correctNull(rs.getString("formula_rowname"));
						
							
							formuladesc.trim();
							totalval=formuladesc+"^"+rowid+"^"+correctNull(rs.getString("ratio_type"))+"^"+correctNull(rs.getString("id"))+"^"+correctNull(rs.getString("formula_rowid"));
							
							arr.add(totalval);
							arr1.add(correctNull(rs.getString("ratio_desc")));
						}
					}
					hshvalues.put("arrVal",arr);
					hshvalues.put("arrValdesc",arr1);
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
					
				}
				catch (Exception e1)
				{
				log.error("error occured"+e1.toString());
				}
			}
			return hshvalues;
	}
}




