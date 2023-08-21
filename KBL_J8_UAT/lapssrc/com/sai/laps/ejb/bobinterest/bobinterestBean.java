package com.sai.laps.ejb.bobinterest;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.ConnectionFactory;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;

@Stateless(name = "bobinterestBean", mappedName = "bobinterestHome")
@Remote (bobinterestRemote.class)
public class bobinterestBean extends BeanAdapter
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public HashMap updateData(HashMap hshValues) 
	{
		HashMap hshRecord = null;
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String strExp ="$";		 
		ResultSet rs = null;
		Connection connectDB= null;
		CallableStatement callableStmt = null;
		int intValue = 0,intUpdatesize=0;
		String id="";
		String strDiffVal="";
		StringBuilder sbAuditTrial=new StringBuilder();
		StringBuilder sbolddata=new StringBuilder();
		String strKeyId = "";
		try
		{
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			if(strAction.equalsIgnoreCase("update")|| strAction.equalsIgnoreCase("Delete"))
			{
				rs=DBUtils.executeLAPSQuery("sel_intindex_audit^"+Helper.correctNull((String)hshValues.get("id")));
				while(rs.next())
				{
					sbolddata.append("Interest Descrption=").append(Helper.correctNull((String)rs.getString("int_intdesc")))
			       	.append("~Interest Rate (%)=").append(Helper.correctNull((String)rs.getString("int_intvalue")))
			       	.append("~Circular Ref No =").append(Helper.correctNull((String)rs.getString("cir_ref_no")))
			       	.append("~Circular Date =").append(Helper.correctNull((String)rs.getString("cir_date")));
					sbolddata.append("~ Active = ");
			       		if(correctNull((String)rs.getString("int_active")).equalsIgnoreCase("Y"))
			       	{
			       			sbolddata.append("Yes");
			       	}
			       	else if(correctNull((String)rs.getString("int_active")).equalsIgnoreCase("N"))
			       	{
			       		sbolddata.append("No");
				    }
			       	else{
			       		sbolddata.append("");
			       	}
					sbolddata.append("~Created Date=").append(Helper.correctNull((String)rs.getString("int_intmoddate")));
				}
				if(rs!=null)
				{
					rs.close();
				}
			}
			if(strAction.equalsIgnoreCase("insert"))
			{
				rs=DBUtils.executeLAPSQuery("bobinterestmax");
				while(rs.next())
				{
					intValue = (rs.getInt(1));				
				}			
				id= Integer.toString(intValue);		
				hshQuery.put("strQueryId","bobintinsert");
				arrValues.add(id);
				arrValues.add(hshValues.get("txtinterest").toString().toUpperCase());
				arrValues.add(hshValues.get("txtrate"));
				arrValues.add(hshValues.get("txtcircrefno").toString().toUpperCase());
				arrValues.add(hshValues.get("txtcircdate"));
				arrValues.add(hshValues.get("circulartext").toString().toUpperCase());
				arrValues.add(hshValues.get("selactive"));
				arrValues.add("Y");
				
				intUpdatesize=intUpdatesize+1;
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
			}
			if(strAction.equalsIgnoreCase("update") && Helper.correctNull((String)hshValues.get("hidIdChange")).equalsIgnoreCase(""))
			{
				hshQuery.put("strQueryId","bobintupdate");
				arrValues.add(hshValues.get("txtinterest").toString().toUpperCase());
				arrValues.add(hshValues.get("txtrate"));				
				arrValues.add(hshValues.get("txtcircrefno").toString().toUpperCase());
				arrValues.add(hshValues.get("txtcircdate"));
				arrValues.add(hshValues.get("circulartext").toString().toUpperCase());
				arrValues.add(hshValues.get("selactive"));
				arrValues.add(hshValues.get("id"));
				
				intUpdatesize=intUpdatesize+1;
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
			}
			
			if(strAction.equalsIgnoreCase("update") && Helper.correctNull((String)hshValues.get("hidIdChange")).equalsIgnoreCase("Y"))
			{
				hshQuery.put("strQueryId","Intindx_olddataupdate");
				arrValues.add(hshValues.get("id"));
				
				intUpdatesize=intUpdatesize+1;
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","bobintinsert");
				arrValues.add(hshValues.get("id"));
				arrValues.add(hshValues.get("txtinterest").toString().toUpperCase());
				arrValues.add(hshValues.get("txtrate"));
				arrValues.add(hshValues.get("txtcircrefno").toString().toUpperCase());
				arrValues.add(hshValues.get("txtcircdate"));
				arrValues.add(hshValues.get("circulartext").toString().toUpperCase());
				arrValues.add(hshValues.get("selactive"));
				arrValues.add("Y");
				
				intUpdatesize=intUpdatesize+1;
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
				
				
				strDiffVal = String.valueOf(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txtrate"))) - Double.parseDouble(Helper.correctDouble((String)hshValues.get("txtrate_old"))));
	    		
				connectDB= ConnectionFactory.getConnection();
				callableStmt=connectDB.prepareCall("call Interest_update(?,?,?)");
				callableStmt.setString(1,String.valueOf(hshValues.get("id")));
				callableStmt.setString(2,String.valueOf(hshValues.get("txtrate")));
				callableStmt.setString(3,strDiffVal);
				callableStmt.execute();
				callableStmt.clearParameters();
				callableStmt.close();
				connectDB.close();
			}
			
			
/** For Entering the values into auditrial */
	       	sbAuditTrial.append("Interest Descrption=").append(correctNull((String)hshValues.get("txtinterest")).toUpperCase())
	       	.append("~Interest Rate (%)=").append(correctNull((String)hshValues.get("txtrate")))
	       	.append("~Circular Ref No =").append(correctNull((String)hshValues.get("txtcircrefno")))
	       	.append("~Circular Date =").append(correctNull((String)hshValues.get("txtcircdate")));
	       	sbAuditTrial.append("~ Active = ");
	       	if(correctNull((String)hshValues.get("selactive")).equalsIgnoreCase("Y"))
	       	{
	       		sbAuditTrial.append("Yes");
	       	}
	       	else if(correctNull((String)hshValues.get("selactive")).equalsIgnoreCase("N"))
	       	{
		       	sbAuditTrial.append("No");
		    }
	       	else{
	       		sbAuditTrial.append("");
	       	}
	       	sbAuditTrial.append("~Created Date=").append(Helper.getCurrentDateTime());
	       	AuditTrial.auditNewLog(hshValues,"9",strKeyId,sbAuditTrial.toString(),sbolddata.toString());
	       	/** End*/		
			
			try
			{
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");				
			}			
			catch(Exception se)
			{
				throw new Exception(strExp);
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
		catch(Exception ce)
		{
			throw new EJBException("Error in updateData "+ce.toString());
		}		
		return hshRecord;
	}

	public HashMap getDataHelp(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		ArrayList arr2 = new ArrayList();
		ArrayList arr3 = new ArrayList();
		ArrayList arr4 = new ArrayList();
		ArrayList arr5 = new ArrayList();
		ArrayList arr6 = new ArrayList();
		ArrayList arr7 = new ArrayList();
		boolean recordflag=false;
		try
		{			 
		    rs=DBUtils.executeLAPSQuery("bobinterest"); 
			hshRecord = new HashMap();			
			while(rs.next())
			{
				recordflag=true;
				arr.add(correctNull(rs.getString("int_intid")));
				arr1.add(correctNull(rs.getString("int_intdesc")));
				arr2.add(correctNull(rs.getString("int_intvalue")));
				arr3.add(correctNull(rs.getString("int_intmoddate")));
				arr4.add(Helper.replaceForJavaScriptString(Helper.correctNull(rs.getString("cir_ref_no"))));	
				arr5.add(correctNull(rs.getString("cir_date")));
				arr6.add(correctNull(rs.getString("cir_details")));		
				arr7.add(correctNull(rs.getString("int_active")));
			}
			hshRecord.put("arrVal",arr);
			hshRecord.put("arrValdesc",arr1);
			hshRecord.put("arrValint",arr2);
			hshRecord.put("arrValdate",arr3);
			hshRecord.put("arrValrefno",arr4);
			hshRecord.put("arrValrefdt",arr5);
			hshRecord.put("arrValdet",arr6);
			hshRecord.put("arrValActive",arr7);
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
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
}
