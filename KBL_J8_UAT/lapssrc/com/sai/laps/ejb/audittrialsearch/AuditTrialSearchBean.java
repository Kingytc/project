package com.sai.laps.ejb.audittrialsearch;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.audittrial.AuditTrialBean;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;


@Stateless(name = "AuditTrialSearchBean", mappedName = "AuditTrialSearchHome")
@Remote (AuditTrialSearchRemote.class)
public class AuditTrialSearchBean extends BeanAdapter
{	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(AuditTrialSearchBean.class);

	public HashMap getData(HashMap hshRequestValues) 
	{		
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList arr = null;
		String strQuery="";
		
		try
		{
			
			hshRecord = new HashMap();
			arr =  new ArrayList();
			strQuery = SQLParser.getSqlQuery("glpoption");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				arr.add(Helper.correctNull(rs.getString(1)));	
				arr.add(Helper.correctNull(rs.getString(2)));	
				arr.add(Helper.correctNull(rs.getString(3)));	
				arr.add(Helper.correctNull(rs.getString(4)));	
				arr.add(Helper.correctNull(rs.getString(5)));	
				arr.add(Helper.correctNull(rs.getString(6)));	
			}
			hshRecord.put("arr",arr);			
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
	
	public HashMap getDataFinal(HashMap hshRequestValues) 
	{		
		ResultSet rs = null;
		HashMap hshRecord = null;
		String strid="",strQuery="",status="",appno="";
		ArrayList vecval =  new ArrayList();
		ArrayList vecdata =  new ArrayList();
		String hidPageType="";	
		try
		{			
			hshRecord = new HashMap();
			strid = correctNull((String)hshRequestValues.get("id"));
			appno= correctNull((String)hshRequestValues.get("appno"));
			appno=appno.trim();
			hidPageType=correctNull((String)hshRequestValues.get("hidPageType"));
			if(appno.equals("") && (hidPageType.trim().equals("audit_trial")))
			{
				strQuery = SQLParser.getSqlQuery("appgeneration^"+strid);
			}
			else if(!appno.equals("") && (hidPageType.trim().equals("audit_trial")))
			{
				strQuery = SQLParser.getSqlQuery("appgeneration1^"+strid+"^"+appno);
			}
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				vecval =  new ArrayList();
				vecval.add(rs.getString(1));
				status=rs.getString(2);
				if(status.equalsIgnoreCase("op"))
				{
					status="OPEN/PENDING";
				}
				else
				{
					status="COMPLETED";
				}
				vecval.add(status);
				vecdata.add(vecval);						
			}
			hshRecord.put("vecval",vecdata);			
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
	
	public HashMap getBorrowerDetails(HashMap hshRequestValues) 
	{		
		ResultSet rs = null;
		String strQuery="",areacheckval="",catval="",selcatval="";
		String area2="",area3="",area4="",area5="",glptotlevel="",pagetype="",ddesc="";
		try
		{			
			
			strQuery = SQLParser.getSqlQuery("glpoption");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				glptotlevel = (String)Helper.correctNull(rs.getString(1));	
			}
			pagetype= correctNull((String)hshRequestValues.get("hidPageType"));
			area2= correctNull((String)hshRequestValues.get("area2"));
			area3 = correctNull((String)hshRequestValues.get("area3"));
			area4 = correctNull((String)hshRequestValues.get("area4"));
			area5 = correctNull((String)hshRequestValues.get("area5"));
			if(area4.equals("undefined"))
			{
				area4="";
			}
			if(!area5.equals(""))
			{
				areacheckval=area5;
			}
			else if(!area4.equals(""))
			{
				if(glptotlevel.equals("4"))
				{
					areacheckval=area4;
				}
				else if(glptotlevel.equals("5"))
				{
					areacheckval=area4.substring(0,15);
				}
			}
			else if(!area3.equals(""))
			{
				areacheckval=area3.substring(0,9)+"%%%%%%";
			}
			else if(!area2.equals(""))
			{
				areacheckval=area2.substring(0,6)+"%%%%%%%%%";
			}
			else
			{
				areacheckval="";			
			}
			catval = correctNull((String)hshRequestValues.get("cat"));
			selcatval = correctNull((String)hshRequestValues.get("select_cat"));
			// start audit trial 
			if (pagetype.equals("audit_trial"))
			{
				if(areacheckval.equals(""))
				{
					String level1=correctNull((String)hshRequestValues.get("strOrgLevel"));
					String orgcode1= correctNull((String)hshRequestValues.get("strOrgCode"));
					if (level1.equals("C"))
					{
						orgcode1=orgcode1.substring(0,3)+"%%%%%%%%%%%%";
						ddesc=" usr_orgcode in (select org_code from organisations where org_code like '"+orgcode1+"')";
					}
					else if(level1.equals("R"))
					{
						orgcode1=orgcode1.substring(0,6)+"%%%%%%%%%";
						ddesc=" usr_orgcode in (select org_code from organisations where org_code like '"+orgcode1+"')";
					}
					else if(level1.equals("D"))
					{
						orgcode1=orgcode1.substring(0,9)+"%%%%%%";
						ddesc=" usr_orgcode in (select org_code from organisations where org_code like '"+orgcode1+"')";
					}
					else if(level1.equals("A"))
					{
						if(glptotlevel.equals("4"))
						{
							orgcode1=orgcode1.substring(0,9)+"%%%%%%";
						}
						else if(glptotlevel.equals("5"))
						{
							orgcode1=orgcode1.substring(0,15);
						}
						ddesc=" usr_orgcode in (select org_code from organisations where org_code like '"+orgcode1+"')";
					}
					else if(level1.equals("B"))
					{
						orgcode1=orgcode1.substring(0,15);
						ddesc=" usr_orgcode in (select org_code from organisations where org_code like '"+orgcode1+"')";
					}
					if(catval.equals("user"))
					{	
						strQuery = SQLParser.getSqlQuery("userAuditSearch^"+ddesc);
					}
					else if(catval.equals("borrower"))
					{
						if(selcatval.startsWith("Commercial"))
						{
							ddesc="";
							ddesc= "in (select org_scode from organisations where org_code like '"+orgcode1+"') order by comapp_companyname";							
							strQuery=SQLParser.getSqlQuery("AuditBorrowerSearch^"+ddesc);
						}
						else
						{
							ddesc="in (select org_scode from organisations where org_code like '"+orgcode1+"')";
							strQuery=SQLParser.getSqlQuery("apporgsela^"+ddesc);
						}
					}
				}
				else if (!areacheckval.equals(""))
				{
					if(catval.equals("user"))
					{	
						ddesc=" usr_orgcode in (select org_code from organisations where org_code like'"+areacheckval+"')" ;
						strQuery = SQLParser.getSqlQuery("userAuditSearch^"+ddesc);
					}						
					else if(catval.equals("borrower"))
					{
						if(selcatval.startsWith("Commercial"))
						 {
							ddesc="";
							ddesc= "in (select org_scode from organisations where org_code like '"+areacheckval+"') order by comapp_companyname";
							strQuery=SQLParser.getSqlQuery("AuditBorrowerSearch^"+ddesc);
						 }
						 else
						 {
							ddesc="in (select org_scode from organisations where org_code like '"+areacheckval+"')";
							strQuery=SQLParser.getSqlQuery("apporgsela^"+ddesc);
						}
					}		
				}
				rs.close();
         		if(catval.equals("user"))
         		{
					ArrayList vecval =  new ArrayList();
					ArrayList vecdata =  new ArrayList();
					rs = DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						vecval =  new ArrayList();
						vecval.add(rs.getString(1));					
						vecval.add(rs.getString(2));	
						vecval.add(rs.getString(3));	
						vecdata.add(vecval);						
					}
					hshRequestValues.put("vecval",vecdata);	
					hshRequestValues.put("mode",catval);	
				}
				else if(catval.equals("borrower"))
				{
					ArrayList vecval =  new ArrayList();
					ArrayList vecdata =  new ArrayList();
					rs = DBUtils.executeQuery(strQuery);
					if(selcatval.startsWith("Commercial"))
					{
						while(rs.next())
						{
							vecval =  new ArrayList();
							vecval.add(rs.getString(1));	
							vecval.add(rs.getString(2));	
							vecval.add(rs.getString(5));						
							vecdata.add(vecval);						
						}
					}
					else
					{
						while(rs.next())
						{
							vecval =  new ArrayList();
							vecval.add(rs.getString(1));	
							vecval.add(rs.getString(2));	
							vecval.add(rs.getString(4));						
							vecdata.add(vecval);
						}
					}
					hshRequestValues.put("vecval",vecdata);	
					hshRequestValues.put("mode",catval);
				}
			}
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
				{
					rs.close();
				}
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRequestValues;
	}	
}