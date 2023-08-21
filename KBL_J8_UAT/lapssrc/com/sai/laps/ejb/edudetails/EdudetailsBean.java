package com.sai.laps.ejb.edudetails;


import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.dynamictabs.DynamicTabsBean;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "EdudetailsBean", mappedName = "EdudetailsHome")
@Remote (EdudetailsRemote.class)
public class EdudetailsBean extends BeanAdapter
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(EdudetailsBean.class);

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
				strQuery = SQLParser.getSqlQuery("edudetailssel^"+appno+"^"+strGradeNo);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("edudetailsselection^"+appno);
			}
				
			if(rs!=null)
			rs.close();	
			
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				vecVal = new ArrayList();
				vecVal.add(correctNull(rs.getString("edu_id")));
				vecVal.add(correctNull(rs.getString("edu_exam")));
				vecVal.add(correctNull(rs.getString("edu_university")));
				vecVal.add(correctNull(rs.getString("edu_yearpass")));
				vecVal.add(correctNull(rs.getString("edu_attempts")));
				vecVal.add(correctNull(rs.getString("edu_marks")));
				vecVal.add(correctNull(rs.getString("edu_class")));

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
			
			rs=DBUtils.executeLAPSQuery("edudetailsmax^"+appno);
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
		String strGradeId = "";
		StringBuilder sbolddata=new StringBuilder();
		String strQuery="";
		ResultSet rs=null;
		String appno=correctNull((String)hshValues.get("appno"));		
		
		try
		{			
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				strGradeId =  correctNull((String )hshValues.get("idno"));				
				strQuery=SQLParser.getSqlQuery("edudetailssel^"+appno+"^"+strGradeId);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					sbolddata.append("~Examination=").append(correctNull(rs.getString("edu_exam"))).
					append("~Institution=").append(correctNull(rs.getString("edu_university"))).
					append("~Year of passing=").append(correctNull(rs.getString("edu_yearpass"))).
					append("~Attempts made=").append(correctNull(rs.getString("edu_attempts"))).
					append("~Percentage of marks(%)=").append(correctNull(rs.getString("edu_marks"))).
					append("~Class obtained=").append(correctNull(rs.getString("edu_class")));
					
				}
				
				}
			

			 if(strAction.trim().equals("insert"))
			{
				
					strGradeId = Integer.toString(getMaxGradeId(appno));					
				
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();					
					hshQueryValues.put("size","1");				
					
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","edudetailsinsert");
					arrValues.add(appno);
					arrValues.add(strGradeId);
					arrValues.add(correctNull((String )hshValues.get("selyear")));
					arrValues.add(Helper.correctNull((String )hshValues.get("tution")));
					arrValues.add(Helper.correctNull((String )hshValues.get("exam")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("books")));
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
					hshQuery.put("strQueryId","edudetailsupdate");
				
					arrValues.add(correctNull((String )hshValues.get("selyear")));
					arrValues.add(Helper.correctNull((String )hshValues.get("tution")));
					arrValues.add(Helper.correctNull((String )hshValues.get("exam")));
					arrValues.add(Helper.correctNull((String )hshValues.get("books")));
					arrValues.add(Helper.correctNull((String )hshValues.get("lodge")));
					arrValues.add(Helper.correctNull((String )hshValues.get("lab")));
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
				hshQuery.put("strQueryId","edudetailsdelete");
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
				sbActionData.append("~Examination=").append(correctNull((String)hshValues.get("selyear"))).
				append("~Institution=").append(correctNull((String)hshValues.get("tution"))).
				append("~Year of passing=").append(correctNull((String)hshValues.get("exam"))).
				append("~Attempts made=").append(correctNull((String)hshValues.get("books"))).
				append("~Percentage of marks(%)=").append(correctNull((String)hshValues.get("lodge"))).
				append("~Class obtained=").append(correctNull((String)hshValues.get("lab")));
			
							
			//AuditTrial.auditLog(hshValues,"42",appno,sbActionData.toString());
			}
			AuditTrial.auditNewLog(hshValues,"42",appno,sbActionData.toString(),sbolddata.toString());
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
}