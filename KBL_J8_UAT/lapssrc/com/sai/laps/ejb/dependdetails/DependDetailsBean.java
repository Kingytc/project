package com.sai.laps.ejb.dependdetails;
 
import java.sql.ResultSet;
 
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import com.sai.laps.helper.*;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

@Stateless(name = "DependDetailsBean", mappedName = "DependDetailsHome")
@Remote (DependDetailsRemote.class)
public class DependDetailsBean extends BeanAdapter
{
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(DependDetailsBean.class);

	public void updateCreditCardData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		ResultSet rs = null;		
		int iMaxId = 0;
		String strcardno = "";
		String strissuedby ="";
		String strissuelimit ="";
		String strexpirydate ="";
		String strotherinfo ="";
		String strGradeId = "";
		try
		{
			String strTemp = (String)hshValues.get("cardno");
			String strTemp1 = (String)hshValues.get("txt_custid1");			
			String strTemp2 = (String)hshValues.get("txt_custid2");			
			String strTemp3 = (String)hshValues.get("txt_custid3");	
			strcardno = strTemp+"-"+strTemp1+"-"+strTemp2+"-"+strTemp3;
			strissuedby = correctNull((String)hshValues.get("issuedby"));
			strissuelimit = correctNull((String)hshValues.get("issuelimit"));
			strexpirydate = correctNull((String)hshValues.get("expirydate"));	
			strotherinfo = correctNull((String)hshValues.get("otherinfo"));
			String applicantid=correctNull((String)hshValues.get("app_id"));
			String strAction=(String)hshValues.get("hidAction");
			if(strAction.equals("update"))
			{
				strGradeId =  Helper.correctDouble((String )hshValues.get("idno"));				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","updcreditcarddet");			
				arrValues.add(strcardno);
				arrValues.add(strissuedby);
				arrValues.add(strissuelimit);
				arrValues.add(strexpirydate);
				arrValues.add(strotherinfo);
				arrValues.add(applicantid);
				arrValues.add(strGradeId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
         		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.trim().equals("insert"))
			{
				iMaxId = getMaxCardId(applicantid);	
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");						
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","InsCreditcards");
				arrValues.add(applicantid);
				arrValues.add(Integer.toString(iMaxId));					
				arrValues.add(strcardno);
				arrValues.add(strissuedby);
				arrValues.add(strissuelimit);
				arrValues.add(strexpirydate);
				arrValues.add(strotherinfo);				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");				
			}
			else if(strAction.equals("delete"))
			{
				strGradeId =  correctNull((String )hshValues.get("idno"));				
				arrValues=new ArrayList();
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");				
				hshQuery.put("strQueryId","delcreditcarddet");				
				arrValues.add(applicantid);
				arrValues.add(strGradeId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}			
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
	
	public  HashMap getCreditCardData(HashMap hshValues) 
	{
		String strQuery="";
		ResultSet rs = null;
		ResultSet rs1 = null;		
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecVal=new ArrayList();
		
		try
		{
			java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
			jtn.setMaximumFractionDigits(2);
			jtn.setMinimumFractionDigits(2);
			jtn.setGroupingUsed(false);			
			String applicantid=correctNull((String)hshValues.get("app_id"));
			String strAction = correctNull((String)hshValues.get("hidAction"));
			String strSlNo= correctNull((String)hshValues.get("selsno"));
			 		
			if(strAction.trim().equals("edit"))
			{
				strQuery = SQLParser.getSqlQuery("selparcreditcards^"+applicantid+"^"+strSlNo);
				rs =DBUtils.executeQuery(strQuery);
			}
			else
			{
				  rs=DBUtils.executeLAPSQuery("selallcreditcards^"+applicantid);
			}
			while(rs.next())
			{
				vecVal = new ArrayList();				
				vecVal.add(correctNull(rs.getString("PERAPP_ID")));
				vecVal.add(correctNull(rs.getString("PERAPP_CARDSLNO")));
				vecVal.add(correctNull(rs.getString("PERAPP_CARDNO")));
				vecVal.add(correctNull(rs.getString("PERAPP_ISSUEDBY")));
				vecVal.add(correctNull(rs.getString("PERAPP_ISSUEDLIMIT")));				
				vecVal.add(correctNull(rs.getString("PERAPP_EXPIRYDATE")));
				vecVal.add(correctNull(rs.getString("PERAPP_OTHERINFO")));
				vecData.add(vecVal);							
			}	
			rs1=DBUtils.executeLAPSQuery("creditcardailsrecrods^"+applicantid);
			String noofrecords = "";
			while(rs1.next())
			{
				noofrecords = correctNull(rs1.getString("noofrec"));
			}
			hshRecord.put("vecData",vecData);
			hshRecord.put("noofrec",noofrecords);
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
		return hshRecord;
	}
	
	private int getMaxCardId(String applicantid)
	{
		ResultSet rs = null;
		int termId = 0;
		try
		{	
			rs=DBUtils.executeLAPSQuery("maxcreditcard^"+applicantid);

			if (rs.next())
			{				
				termId = rs.getInt(1);				
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
	
	private int getMaxGradeId(String applicantid)
	{
		ResultSet rs = null;
		int termId = 0;

		try
		{	 
			rs=DBUtils.executeLAPSQuery("dependdetailsmax^"+applicantid);

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
	
	public  HashMap getData(HashMap hshValues) 
	{
		String strQuery="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecVal=new ArrayList();
		try
		{
			java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
			jtn.setMaximumFractionDigits(2);
			jtn.setMinimumFractionDigits(2);
			jtn.setGroupingUsed(false);
			String applicantid="1";//correctNull((String)hshValues.get("appid"));
			String strAction = correctNull((String)hshValues.get("hidAction"));
			String strGradeNo= correctNull((String)hshValues.get("selsno"));
		
			if(strAction.trim().equals("edit"))
			{
				  rs=DBUtils.executeLAPSQuery("dependdetailssel^"+applicantid+"^"+strGradeNo);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("dependdetailsselection^"+applicantid);
				rs =DBUtils.executeQuery(strQuery);
			}
			while(rs.next())
			{
				vecVal = new ArrayList();
				vecVal.add(correctNull(rs.getString("depid")));
				vecVal.add(correctNull(rs.getString("depname")));
				vecVal.add(correctNull(rs.getString("depage")));
				vecVal.add(correctNull(rs.getString("deprelation")));
				vecVal.add(correctNull(rs.getString("depmobile")));
				vecVal.add(correctNull(rs.getString("depofficeno")));
				vecVal.add(correctNull(rs.getString("depaddress")));
				vecVal.add(correctNull(rs.getString("depresino")));
				vecData.add(vecVal);							
			}	
			rs1=DBUtils.executeLAPSQuery("dependdetailsrecrods^"+applicantid);
			String noofrecords = "";
			while(rs1.next())
			{
				noofrecords = correctNull(rs1.getString("noofrec"));
			}
			hshRecord.put("vecData",vecData);
			hshRecord.put("noofrec",noofrecords);
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
		return hshRecord;
	}
	
	public void updateData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String strGradeId = "";
		String applicantid="1"; //correctNull((String)hshValues.get("appid"));
		ResultSet rs = null;
		try
		{
			if(strAction.equals("update"))
			{
				strGradeId =  correctNull((String )hshValues.get("idno"));	
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","dependetailsupdate");
				arrValues.add(correctNull((String )hshValues.get("name")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("age")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("relation")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("mobile")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("officeno")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("address")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("residenceno")));
				arrValues.add(applicantid);
				arrValues.add(strGradeId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.trim().equals("insert"))
			{				
				strGradeId = Integer.toString(getMaxGradeId(applicantid));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");	
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","dependdetailsinsert");
				arrValues.add(applicantid);
				arrValues.add(strGradeId);
				arrValues.add(correctNull((String )hshValues.get("name")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("age")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("relation")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("mobile")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("officeno")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("address")));
				arrValues.add(Helper.correctDouble((String )hshValues.get("residenceno")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");				
			}
			else if(strAction.equals("delete"))
			{
				strGradeId =  correctNull((String )hshValues.get("idno"));				
				arrValues=new ArrayList();
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","dependdetailsdelete");
				arrValues.add(applicantid);
				arrValues.add(strGradeId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}			
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