package com.sai.laps.ejb.eduscholar;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.eduparticulars.eduparticularsBean;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;


@Stateless(name = "EduscholarBean", mappedName = "EduscholarHome")
@Remote (EduscholarRemote.class)
public class EduscholarBean extends BeanAdapter
{
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(EduscholarBean.class);

	public  HashMap getData(HashMap hshValues) 
	{
		String strQuery="";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecVal=new ArrayList();
	
		try
		{
			java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
			jtn.setMaximumFractionDigits(2);
			jtn.setMinimumFractionDigits(2);
			jtn.setGroupingUsed(false);
			String appno=correctNull((String)hshValues.get("appno"));
			String strAction = correctNull((String)hshValues.get("hidAction"));
			String strGradeNo= correctNull((String)hshValues.get("selsno"));
		
			if(strAction.trim().equals("edit"))
			{
				strQuery = SQLParser.getSqlQuery("eduscholarssel^"+appno+"^"+strGradeNo);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("eduscholarsselection^"+appno);
			}
				
			if(rs!=null)
			rs.close();	
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				vecVal = new ArrayList();
				vecVal.add(correctNull(rs.getString("edu_id")));
				vecVal.add(correctNull(rs.getString("edu_exam")));
				vecVal.add(correctNull(rs.getString("edu_academic")));
				vecVal.add(correctNull(rs.getString("edu_name")));
				vecVal.add(correctNull(rs.getString("edu_amount")));
				String strFrom=correctNull(rs.getString("edu_from"));
				String strTo=correctNull(rs.getString("edu_to"));
				if (strFrom.trim().equals("01/01/1900"))
				{
					vecVal.add("");
				}
				else
				{
					vecVal.add(strFrom);
				}
				if (strTo.trim().equals("01/01/1900"))
				{
					vecVal.add("");
				}
				else
				{
					vecVal.add(strTo);
				}
				vecData.add(vecVal);							
			}	
			hshRecord.put("vecData",vecData);
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
			rs=DBUtils.executeLAPSQuery("eduscholarsmax^"+appno);
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
			if(rs != null)rs.close();
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
		String strGradeId = "";
		String appno=correctNull((String)hshValues.get("appno"));
		StringBuilder sbolddata=new StringBuilder();
		String strQuery="";
		ResultSet rs=null;
		try
		{
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				strGradeId =  correctNull((String )hshValues.get("idno"));	
				strQuery=SQLParser.getSqlQuery("eduscholarssel^"+appno+"^"+strGradeId);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					sbolddata.append("~Examination =").append(correctNull(rs.getString("edu_exam"))).
					append("~Academic Distinction =").append(correctNull(rs.getString("edu_academic"))).
					append("~Name of Scholarship =").append(correctNull(rs.getString("edu_name"))).
					append("~Amount =").append(correctNull(rs.getString("edu_amount"))).
					append("~Duration From =").append(correctNull(rs.getString("edu_from"))).
					append("~Duration To =").append(correctNull(rs.getString("edu_to")));
					
				}
				
				}
			
			

			 if(strAction.trim().equals("insert"))
			{
				
					strGradeId = Integer.toString(getMaxGradeId(appno));
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();					
					hshQueryValues.put("size","1");				
					
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","eduscholarsinsert");
					arrValues.add(appno);
					arrValues.add(strGradeId);
					arrValues.add(correctNull((String )hshValues.get("selyear")));
					arrValues.add(Helper.correctNull((String )hshValues.get("tution")));
					arrValues.add(Helper.correctNull((String )hshValues.get("exam")));
					arrValues.add(Helper.correctNull((String )hshValues.get("books")));
					arrValues.add(Helper.correctNull((String )hshValues.get("lodge")));
					arrValues.add(Helper.correctNull((String )hshValues.get("lab")));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);	
					hshQuery=new HashMap();
					arrValues=new ArrayList();

				    EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			 }
			 else if(strAction.equals("update"))
				{
					strGradeId =  correctNull((String )hshValues.get("idno"));				
					
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();					
					hshQueryValues.put("size","1");
					arrValues=new ArrayList();

					hshQuery.put("strQueryId","eduscholarsupdate");
				
					arrValues.add(correctNull((String )hshValues.get("selyear")));
					arrValues.add(correctNull((String )hshValues.get("tution")));
					arrValues.add(correctNull((String )hshValues.get("exam")));
					arrValues.add(correctNull((String )hshValues.get("books")));
					arrValues.add(correctNull((String )hshValues.get("lodge")));
					arrValues.add(correctNull((String )hshValues.get("lab")));
					arrValues.add(appno);
					arrValues.add(strGradeId);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);	
					hshQuery=new HashMap();
					arrValues=new ArrayList();

					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			else if(strAction.equals("delete"))
			{
				strGradeId =  correctNull((String )hshValues.get("idno"));				
	
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","eduscholarsdelete");
				arrValues.add(appno);
				arrValues.add(strGradeId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}

//			for Entering the values into auditrial

			 StringBuilder sbActionData = new StringBuilder();

			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("insert"))
			{
			sbActionData.append("~Examination =").append(correctNull((String)hshValues.get("selyear"))).
			append("~Academic Distinction =").append(correctNull((String)hshValues.get("tution"))).
			append("~Name of Scholarship =").append(correctNull((String)hshValues.get("exam"))).
			append("~Amount =").append(correctNull((String)hshValues.get("books"))).
			append("~Duration From =").append(correctNull((String)hshValues.get("lodge"))).
			append("~Duration To =").append(correctNull((String)hshValues.get("lab")));
			
			}				
		//	AuditTrial.auditLog(hshValues,"42",appno,sbActionData.toString());
			AuditTrial.auditNewLog(hshValues,"43",appno,sbActionData.toString(),sbolddata.toString());
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
		finally
		{
			try
			{
//				if(rs != null)
//				{
//					rs.close();
//				}

			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
						
			}
		}
	}
	
	//addes by karthikeyan for course expences.	
	
	public  HashMap getDataExp(HashMap hshValues) 
	{
		 
		ResultSet rs=null;
		String strQuery ="";
		String recordflag="N";
		HashMap hshRecord=new HashMap();
		try
		{
			 
			String strAppno="";
			strAppno=Helper.correctNull((String)hshValues.get("appno"));
			strQuery=SQLParser.getSqlQuery("sel_educoursedet^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			 
			ArrayList vecRow = new ArrayList();
			ArrayList vecCol = new ArrayList();
			while(rs.next())
			{
				vecRow = new ArrayList();
				vecRow.add(Helper.correctNull((String)rs.getString("edu_year1")));
				vecRow.add(Helper.correctNull((String)rs.getString("edu_year2")));
				vecRow.add(Helper.correctNull((String)rs.getString("edu_year3")));
				vecRow.add(Helper.correctNull((String)rs.getString("edu_year4")));
				vecRow.add(Helper.correctNull((String)rs.getString("edu_year5")));
				vecRow.add(Helper.correctNull((String)rs.getString("edu_year6")));
				//vecRow.add(Helper.correctNull((String)rs.getString("totalexpenses")));
				vecRow.add(Helper.correctNull((String)rs.getString("edu_comments")));
				vecRow.add(Helper.correctNull((String)rs.getString("edu_type")));
				vecCol.add(vecRow);
				recordflag="Y";
			}
			hshRecord.put("vecCol",vecCol);
			hshRecord.put("recordflag",recordflag);
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
				 
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;			
	}
	
	public void updateDataExp(HashMap hshRequestValues) 
	{
		HashMap hshQuery = new HashMap();
		ArrayList arr = new ArrayList();
		HashMap hshqueryval = new HashMap();
		 
		ResultSet rs = null;
		String strAppno;
		String strAction=Helper.correctNull((String)hshRequestValues.get("hidAction"));
		try
		{
			strAppno=Helper.correctNull((String)hshRequestValues.get("appno"));
			 
			String eduyearexp1[];
			String eduyearexp2[];
			String eduyearexp3[];
			String eduyearexp4[];
			String eduyearexp5[];
			String eduyearexp6[];
			String totalexpenses[];
			String eduexp_comments[];
			String eduyearsrc1[];
			String eduyearsrc2[];
			String eduyearsrc3[];
			String eduyearsrc4[];
			String eduyearsrc5[];
			String eduyearsrc6[];
			String edusec_expenses[];
			String edutot_means[];
			
			eduyearexp1= (String [])hshRequestValues.get("txt_Iyear");
			eduyearexp2= (String [])hshRequestValues.get("txt_2year");
			eduyearexp3 = (String [])hshRequestValues.get("txt_3year");
			eduyearexp4 = (String [])hshRequestValues.get("txt_4year");
			eduyearexp5 = (String [])hshRequestValues.get("txt_5year");
			eduyearexp6 = (String [])hshRequestValues.get("txt_6year");
			totalexpenses = (String [])hshRequestValues.get("txt_totalexpenses");
			eduexp_comments= (String [])hshRequestValues.get("description");
			eduyearsrc1 = (String [])hshRequestValues.get("exp_1year");
			eduyearsrc2 = (String [])hshRequestValues.get("exp_2year");
			eduyearsrc3 = (String [])hshRequestValues.get("exp_3year");
			eduyearsrc4 = (String [])hshRequestValues.get("exp_4year");
			eduyearsrc5 = (String [])hshRequestValues.get("exp_5year");
			eduyearsrc6 = (String [])hshRequestValues.get("exp_6year");
			edusec_expenses = (String [])hshRequestValues.get("expenses");
			edutot_means = (String[])hshRequestValues.get("txt_newexpenses");
			if(strAction.equalsIgnoreCase("delete"))
			{
				arr = new ArrayList();
				hshQuery.put("strQueryId","del_educourse");
				arr.add(strAppno);
				hshQuery.put("arrValues",arr);
				hshqueryval.put("size","1");
				hshqueryval.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			if(strAction.equalsIgnoreCase("update"))
			{
				if(!strAppno.equalsIgnoreCase(""))
				{
					arr = new ArrayList();
					hshQuery.put("strQueryId","del_educourse");
					arr.add(strAppno);
					hshQuery.put("arrValues",arr);
					hshqueryval.put("size","1");
					hshqueryval.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				}
				if(!strAppno.equalsIgnoreCase(""))
				{
					int count = 0,expensesid = 0,sourceid = 0;
					int  expenses1 = 0,source1= 0,source2=0,source3= 0,source4=0,source5=0,source6=0;
				
					for(int k=0;k<27;k++)
					{	
						arr=new ArrayList();
						hshQuery.put("strQueryId","ins_educoursedet");
						arr.add(strAppno);
						count = count + 1;
						if(count>15)
						{
							sourceid = sourceid +1;
							if(Integer.toString(sourceid)=="")
							{
								arr.add("0");
							}
							else
							{
								arr.add(Helper.correctNull(Integer.toString(sourceid)));
							}
						}
						else
						{
							expensesid = expensesid +1;
							if(Integer.toString(sourceid)=="")
							{
								arr.add("0");
							}
							else
							{
								arr.add(Helper.correctNull(Integer.toString(expensesid)));
							}
						}
						if (count > 15)
						{
							arr.add("s");
						}
						else
						{
							arr.add("e");
						}
						if (count > 15)
						{
							arr.add(Helper.correctNull(edusec_expenses[expenses1]));
							expenses1  = expenses1+1;
						}
						else
						{						
							arr.add(Helper.correctNull(eduexp_comments[k]));
						}
						if (count > 15)
						{		
							if(Helper.correctNull(eduyearsrc1[source1])=="")
								arr.add("0.0");
							else
								arr.add(Helper.correctNull(eduyearsrc1[source1]));
							source1 = source1 + 1;
						}
						else
						{	
							if(Helper.correctNull(eduyearexp1[k])=="")
								arr.add("0.0");
							else
								arr.add(Helper.correctNull(eduyearexp1[k]));
						}
						if (count > 15)
						{		
							if(Helper.correctNull(eduyearsrc2[source2])=="")
								arr.add("0.0");
							else
								arr.add(Helper.correctNull(eduyearsrc2[source2]));
							source2 = source2 + 1;
						}
						else
						{
							if(Helper.correctNull(eduyearexp2[k])=="")
								arr.add("0.0");
							else
								arr.add(Helper.correctNull(eduyearexp2[k]));
						}
						if (count > 15)
						{	
							if(Helper.correctNull(eduyearsrc3[source3])=="")
								arr.add("0.0");
							else
								arr.add(Helper.correctNull(eduyearsrc3[source3]));
							source3 = source3 + 1;
						}
						else
						{
							if(Helper.correctNull(eduyearexp3[k])=="")
								arr.add("0.0");
							else
								arr.add(Helper.correctNull(eduyearexp3[k]));
						}
						if (count > 15)
						{
							if(Helper.correctNull(eduyearsrc4[source4])=="")
								arr.add("0.0");
							else
								arr.add(Helper.correctNull(eduyearsrc4[source4]));
							source4 = source4 + 1;
						}
						else
						{
							if(Helper.correctNull(eduyearexp4[k])=="")
								arr.add("0.0");
							else
								arr.add(Helper.correctNull(eduyearexp4[k]));
						}
						if (count > 15)
						{		
							if(Helper.correctNull(eduyearsrc5[source5])=="")
								arr.add("0.0");
							else
								arr.add(Helper.correctNull(eduyearsrc5[source5]));
							source5 = source5 + 1;
						}
						else
						{
							if(Helper.correctNull(eduyearexp5[k])=="")
								arr.add("0.0");
							else
								arr.add(Helper.correctNull(eduyearexp5[k]));
						}
						if (count > 15)
						{
							if(Helper.correctNull(eduyearsrc6[source6])=="")
								arr.add("0.0");
							else
								arr.add(Helper.correctNull(eduyearsrc6[source6]));
							source6 = source6 + 1;
						}
						else
						{
							if(Helper.correctNull(eduyearexp6[k])=="")
								arr.add("0.0");
							else
								arr.add(Helper.correctNull(eduyearexp6[k]));
						}
						if (count > 15)
						{						
							arr.add("0.0");
						}
						else
						{
							if(Helper.correctNull(totalexpenses[k])=="")
								arr.add("0.0");
							else
								arr.add(Helper.correctNull(totalexpenses[k]));
						}
						hshQuery.put("arrValues",arr);
						hshqueryval.put("size","1");
						hshqueryval.put("1",hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
					}		
				}
			}
//			FOR AUDIT TRIAL
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if((strAction.equalsIgnoreCase("update"))||(strAction.equalsIgnoreCase("insert")))
			{
				int exp=0,source=0;
				for(int k=0;k<27;k++)
				{
					if(exp<15)
					{
						if(exp==0)
						{
							sbAuditTrial.append("<b>");
							sbAuditTrial.append("Cost of Estimates ");
							sbAuditTrial.append("</b>");
							sbAuditTrial.append("<br>");
						}
						sbAuditTrial.
						append(eduexp_comments[exp]).
						append(" ~1st Year ").append(Helper.correctNull(eduyearexp1[exp])).
						append(" ~2nd Year ").append(Helper.correctNull(eduyearexp2[exp])).
						append(" ~3rd Year ").append(Helper.correctNull(eduyearexp3[exp])).
						append(" ~4th Year ").append(Helper.correctNull(eduyearexp4[exp])).
						append(" ~5th Year ").append(Helper.correctNull(eduyearexp5[exp])).
						append(" ~6th Year ").append(Helper.correctNull(eduyearexp6[exp])).
						append(" ~Total Expenses for ").append( eduexp_comments[exp]).
						append("  "+Helper.correctNull(totalexpenses[exp])+"<br><br>");
					
						if(exp==12)
						{
							sbAuditTrial.append(" 1st year Total Expenses ").append(Helper.correctNull((String) hshRequestValues.get("total_1year"))+"<br>").
						    append(" 2nd year Total Expenses ").append(Helper.correctNull((String) hshRequestValues.get("total_2year"))+"<br>").
							append(" 3rd year Total Expenses ").append(Helper.correctNull((String) hshRequestValues.get("total_3year"))+"<br>").
							append(" 4th year Total Expenses ").append(Helper.correctNull((String) hshRequestValues.get("total_4year"))+"<br>").
							append(" 5th year Total Expenses ").append(Helper.correctNull((String) hshRequestValues.get("total_5year"))+"<br>").
							append(" 6th year Total Expenses ").append(Helper.correctNull((String) hshRequestValues.get("total_6year"))+"<br>").
							append(" Total Expenses ").append(Helper.correctNull((String)hshRequestValues.get("txt_TotalExpensesValue"))+"<br>");
						}
						exp = exp + 1;
					}
					else
					{
						if(source==0)
						{
							sbAuditTrial.append("<b>");
							sbAuditTrial.append("Means of finance ");
							sbAuditTrial.append("</b>");
							sbAuditTrial.append("<br>");
						}
						if(source==7)
						{
							sbAuditTrial.append("Non Repayable Scholarship ");
						}
						else if(source==8)
						{
							sbAuditTrial.append("Repayable Scholarship ");
						}
						else if(source==9)
						{
							sbAuditTrial.append("Sponsorship by close relatives ");
						}
						else if(source==10)
						{
							sbAuditTrial.append("If Advance Payment ");
						}
						sbAuditTrial.
						append(edusec_expenses[source]).
						append(" ~1st Year ").append(Helper.correctNull(eduyearsrc1[source])).
						append(" ~2nd Year ").append(Helper.correctNull(eduyearsrc2[source])).
						append(" ~3rd Year ").append(Helper.correctNull(eduyearsrc3[source])).
						append(" ~4th Year ").append(Helper.correctNull(eduyearsrc4[source])).
						append(" ~5th Year ").append(Helper.correctNull(eduyearsrc5[source])).
						append(" ~6th Year ").append(Helper.correctNull(eduyearsrc6[source])).
						append(" ~Total Means for ");
						if(source==7)
						{
							sbAuditTrial.append("Non Repayable Scholarship ");
						}
						else if(source==8)
						{
							sbAuditTrial.append("Repayable Scholarship ");
						}
						else if(source==9)
						{
							sbAuditTrial.append("Sponsorship by close relatives ");
						}
						else if(source==10)
						{
							sbAuditTrial.append("If Advance Payment ");
						}
						sbAuditTrial.append( edusec_expenses[source]+" ").append(Helper.correctNull(edutot_means[source])+"<br><br>");
						
						if(source==11)
						{
							sbAuditTrial.append("<br>");
							sbAuditTrial.append(" 1st year Total Means ").append(Helper.correctNull((String) hshRequestValues.get("total_exp1year"))+"<br>").
						    append(" 2nd year Total Means ").append(Helper.correctNull((String) hshRequestValues.get("total_exp2year"))+"<br>").
							append(" 3rd year Total Means ").append(Helper.correctNull((String) hshRequestValues.get("total_exp3year"))+"<br>").
							append(" 4th year Total Means ").append(Helper.correctNull((String) hshRequestValues.get("total_exp4year"))+"<br>").
							append(" 5th year Total Means ").append(Helper.correctNull((String) hshRequestValues.get("total_exp5year"))+"<br>").
							append(" 6th year Total Means ").append(Helper.correctNull((String) hshRequestValues.get("total_exp6year"))+"<br>").
							append(" Total Means ").append(Helper.correctNull((String)hshRequestValues.get("txt_totalnewexpenses"))+"<br>");
						}
						source = source + 1;
					}
				}
				if(correctNull((String)hshRequestValues.get("hidRecordflag")).equalsIgnoreCase("N"))
				{
					hshRequestValues.put("hidAction","insert");
				}
			}		
			AuditTrial.auditLog(hshRequestValues,"45",strAppno,sbAuditTrial.toString());
			
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
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
	}
}