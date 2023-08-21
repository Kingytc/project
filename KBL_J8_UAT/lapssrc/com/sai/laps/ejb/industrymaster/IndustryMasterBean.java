package com.sai.laps.ejb.industrymaster;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "IndustryMasterBean", mappedName = "IndustryMasterHome")
@Remote (IndustryMasterRemote.class)
public class IndustryMasterBean extends BeanAdapter
{	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public HashMap getIndustryData(HashMap hshRequestValues) 
	{		
		ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol=null;
		boolean bState = false;
		HashMap hshRecord = new HashMap();
		String strQuery="";
		try
		{			
			hshRecord = new HashMap();
			strQuery = SQLParser.getSqlQuery("selindustryname");
			rs = DBUtils.executeQuery(strQuery);
			bState=rs.next();
			if(!bState)
			{
				hshRecord.put("noData","noData");
			}
			else
			{
				hshRecord.put("noData","Data");
			}
			while (bState)
			{   
				vecCol = new ArrayList();
				for (int i=0;i<7;i++ )
				{ 
					vecCol.add(rs.getString(i+1));
				}
				vecRow.add(vecCol);
				bState=rs.next();
			}
			hshRecord.put("vecRow",vecRow);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
		}
		finally
		{	
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}	

	public HashMap getData(HashMap hshRequestValues) 
	{		
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strQuery="";
		String strDesc="0";
		boolean recordflag=false;
		try
		{				
			hshRecord = new HashMap();
			strDesc=correctNull((String)hshRequestValues.get("hidinudstryname"));
			if(strDesc.equals(""))
			{
				strDesc ="0";
			}
			hshRecord.put("newmode",(String)hshRequestValues.get("newmode"));
			strQuery = SQLParser.getSqlQuery("selindustrydetails^"+strDesc);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{   
				recordflag=true;
				hshRecord.put("hidinudstryname",rs.getString("ind_no"));
				hshRecord.put("ind_bsr_code",rs.getString("ind_bsr_code"));
				hshRecord.put("ind_name",rs.getString("ind_name"));
				hshRecord.put("ind_desc",rs.getString("ind_desc"));
				hshRecord.put("ind_grp",rs.getString("ind_grp"));
				hshRecord.put("ind_grpcode",rs.getString("ind_grpcode"));
				hshRecord.put("ind_active",rs.getString("ind_active"));
				//hshRecord.put("ind_inprinciple",rs.getString("ind_inprinciple"));
			}
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}
	
	public HashMap updateData(HashMap hshValues) 
	{	
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String strID="";
		String strExp ="$";
		ResultSet rs =null;
		StringBuilder sbAuditTrial=new StringBuilder();
		StringBuilder sbolddata = new StringBuilder();
		String strKeyId = "";
		try
		{
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				rs = DBUtils.executeLAPSQuery("selindustrydetails^"+Helper.correctNull(((String)hshValues.get("hidinudstryname"))));
				if(rs.next())
				{
					sbolddata.append("~ Industry Group = "+Helper.correctNull((String)rs.getString("ind_grp")));
					sbolddata.append("~ Industry Name = "+Helper.correctNull((String)rs.getString("ind_name")));
					sbolddata.append("~ BSR Code = "+Helper.correctNull((String)rs.getString("ind_bsr_code")));
					if(Helper.correctNull((String)rs.getString("ind_active")).equalsIgnoreCase("Y"))
					{
						sbolddata.append("~ Active = Yes");
					}
					else
					{
						sbolddata.append("~ Active = No");
					}
				}
				if(rs!=null)
				rs.close();
			}
			if(strAction.equals("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");				
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","updindustrydetials");
				arrValues.add(correctNull((String )hshValues.get("txt_bsrcode")));
				arrValues.add(correctNull((String )hshValues.get("txt_industryname")));
				arrValues.add(correctNull((String )hshValues.get("txt_prddesc")));
				arrValues.add(correctNull((String )hshValues.get("txt_indgrpcode")));
				arrValues.add(correctNull((String )hshValues.get("selactive")));
				arrValues.add(correctNull((String )hshValues.get("hidinudstryname")));				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				hshValues.put("hidinudstryname",((String)hshValues.get("hidinudstryname")));
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equals("insert"))
			{
				strID =  Integer.toString(getTermCode());
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");				
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insindustrydetials");
				arrValues.add(strID);
				arrValues.add(correctNull((String )hshValues.get("txt_bsrcode")));
				arrValues.add(correctNull((String )hshValues.get("txt_industryname")));				
				arrValues.add(correctNull((String )hshValues.get("txt_prddesc")));
				arrValues.add(correctNull((String )hshValues.get("txt_indgrpcode")));
				arrValues.add(correctNull((String )hshValues.get("selactive")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				hshValues.put("hidinudstryname",strID);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
			else if(strAction.equals("delete"))
			{
			    strExp = strExp+"Cannot delete the Industry,the Industry is attached to a CMA.";
			    String  strQuery = SQLParser.getSqlQuery("selcmano^"+correctNull((String )hshValues.get("hidinudstryname")));
			    if (rs != null) {
					rs.close();
				}
			    rs = DBUtils.executeQuery(strQuery);
			    if (rs.next()) {
			    	throw new Exception(strExp);
			    }
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");				
				hshQuery.put("strQueryId","delindustrydetials");
				arrValues.add(correctNull((String )hshValues.get("hidinudstryname")));				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				try
				{
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				catch(Exception se)
				{
					throw new Exception(strExp);
				}
			}
			if(!strAction.equalsIgnoreCase("delete")){
			sbAuditTrial.append("~Industry Group = ").append(correctNull((String)hshValues.get("txt_indgrp")))
			.append("~Industry Name = "+correctNull((String )hshValues.get("txt_industryname")))
			.append("~BSR Code = ").append(correctNull((String )hshValues.get("txt_bsrcode")))
			.append("~Active = ");
			if(Helper.correctNull((String)hshValues.get("selactive")).equalsIgnoreCase("Y"))
			{
				sbAuditTrial.append("Yes");
			}
			else
			{
				sbAuditTrial.append("No");
			}
			}
			AuditTrial.auditNewLog(hshValues,"92",strKeyId,sbAuditTrial.toString(),sbolddata.toString());
			
			//if(strAction.equalsIgnoreCase("insert"))
				//hshValues = (HashMap)getData(hshValues);
			
		}
		catch(Exception ce)
		{
			throw new EJBException(ce.toString());
		}
		return hshValues;
	}
	
	private int getTermCode()
	{		
		String strQuery="";
		ResultSet rs = null;
		int termId = 0;
		try
		{			
			strQuery = SQLParser.getSqlQuery("maxindustrydetials");
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				termId = Integer.parseInt(rs.getString(1));
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
}