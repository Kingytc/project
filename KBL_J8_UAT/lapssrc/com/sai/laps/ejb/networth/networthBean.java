package com.sai.laps.ejb.networth;

import java.sql.ResultSet;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "networthBean", mappedName = "networthHome")
@Remote (networthRemote.class)
public class networthBean extends BeanAdapter
{	
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(networthBean.class);
	private static final long serialVersionUID = 1L;

	public HashMap getData(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshValues=new HashMap();
		String strQuery="";
		String strAppno="";
		String applnt = "";
		try
		{
			strAppno=correctNull((String)hshRequestValues.get("appno"));
			if(strAppno.equals(""))
			{
				strAppno=correctNull((String)hshRequestValues.get("strappno"));
			}
			
			/**
			 * For Getting Applicant Name
			 */
			strQuery = SQLParser.getSqlQuery("comfunsel2^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
			hshValues.put("appname",correctNull((String)rs.getString("app_name")));
			}
			
			/**
			 * For Getting Bank Balance of applicant
			 */
			rs=null;
			rs=DBUtils.executeLAPSQuery("apprep11^"+strAppno);			
			while(rs.next())
			{				
				hshValues.put("totmova1",correctNull(rs.getString("totmov1")));															
			}	

			/**
			 * For Getting Insurance Surrendar of applicant 
			 */
			rs=null;
			rs=DBUtils.executeLAPSQuery("apprep12^"+strAppno);			
			while(rs.next())
			{				
				hshValues.put("totmova2",correctNull(rs.getString("totmov2")));															
			}

			/**
			 * For Getting Value of Movable Assests of applicant 
			 */
			rs=null;
			applnt = "a%";
			//asstype="M";
			strQuery = SQLParser.getSqlQuery("apprep13a^"+applnt+"^"+strAppno);
		    rs =DBUtils.executeQuery(strQuery);
		    while(rs.next())
			{				
				hshValues.put("permova",correctNull(rs.getString("perprop")));															
			}	
		    
		    /**
			 * For Getting Value of Immovable Assests of applicant 
			 */
			rs=null;
			applnt = "a%";
			//asstype="M";
			strQuery = SQLParser.getSqlQuery("apprep13b^"+applnt+"^"+strAppno);
		    rs =DBUtils.executeQuery(strQuery);

			while(rs.next())
			{				
				hshValues.put("perimova",correctNull(rs.getString("perprop")));															
			}
			
			/**
			 * For Getting Shares Current Total Value of applicant 
			 */
			rs=null;
			
			rs=DBUtils.executeLAPSQuery("apprep23^"+strAppno);
			while(rs.next())
			{				
				hshValues.put("mov3a",correctNull(rs.getString("mov3")));															
			}
			
			/**
			 * For Getting Liabilities of applicant 
			 */
			rs=DBUtils.executeLAPSQuery("apprep14^"+strAppno);
			while(rs.next())
			{				
				hshValues.put("totliaa",correctNull(rs.getString("totlia")));															
			}
			/**
			 *  For getting Networth of coapplicant and guarantor
			 */
			java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
			nf.setGroupingUsed(false);
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);
			ArrayList vecReport=new ArrayList();
			ArrayList vecCoapp=null;
			String strType="";
			String strbankbal="";
			String strshare="";
			String strinsurance="";
			String strpermovprop="";
			String strperimmovprop="";
			String strtotlia="";	
			String TotalMoveable ="";
			String TotalAssets="";
			String NetAssets="";	
			String strName="";
			String strId="";
			String Means="";
			rs=DBUtils.executeLAPSQuery("appreport_1^"+strAppno);

			while(rs.next())
			{
				vecCoapp=new ArrayList();
				strType=correctNull(rs.getString("demo_type"));
				
			
				strId=strType+correctNull(rs.getString("demo_appid"));
				if (strType.trim().equalsIgnoreCase("c"))
				{
					strType="Co-Applicant";
				}
				else if (strType.trim().equalsIgnoreCase("g"))
				{	
					strType="Guarantor";					
				}
				else if (strType.trim().equalsIgnoreCase("o"))
				{	
					strType="Co-Obligant";					
				}
				vecCoapp.add(strType);
				strName=correctNull(rs.getString("coappname"));
				vecCoapp.add(strName);
				
				strQuery=SQLParser.getSqlQuery("appreport_2_1^"+strAppno+"^"+strId);
				rs1 =DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					strbankbal=Helper.correctDouble((String)rs1.getString("bankbal"));			
				}
				
				rs1=null;
				strQuery=SQLParser.getSqlQuery("appreport_2_2^"+strAppno+"^"+strId);
				rs1 =DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					strshare=Helper.correctDouble((String)rs1.getString("shares"));	
				}
				
				rs1=null;
				strQuery=SQLParser.getSqlQuery("appreport_2_3^"+strAppno+"^"+strId);
				rs1 =DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					strperimmovprop=Helper.correctDouble((String)rs1.getString("perimmovprop"));
				}
				
				rs1=null;
				strQuery=SQLParser.getSqlQuery("appreport_2_4^"+strAppno+"^"+strId);
				rs1 =DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					strpermovprop=Helper.correctDouble((String)rs1.getString("permovprop"));
				}
				
				rs1=null;
				strQuery=SQLParser.getSqlQuery("appreport_2_5^"+strAppno+"^"+strId);
				rs1 =DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					strinsurance=Helper.correctDouble((String)rs1.getString("insurance"));
				}
				
				rs1=null;
				strQuery=SQLParser.getSqlQuery("appreport_2_6^"+strAppno+"^"+strId);
				rs1 =DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					strtotlia=Helper.correctDouble((String)rs1.getString("totlia"));
				}
				rs1=null;		
				
				Means="0.00";
				
				strQuery=SQLParser.getSqlQuery("creditapptotmeans^"+strAppno+"^"+strId);
				rs1 =DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					Means=Helper.correctDouble((String)rs1.getString("CR_Total_MEANS"));
				}
				
				rs1=null;
				
				vecCoapp.add(strbankbal);
				vecCoapp.add(strshare);
				vecCoapp.add(strinsurance);
				vecCoapp.add(strpermovprop);					
				vecCoapp.add(strperimmovprop);
				vecCoapp.add(strtotlia);	
				TotalMoveable=nf.format(Double.parseDouble(Helper.correctDouble((String)strbankbal))+
						Double.parseDouble(Helper.correctDouble((String)strinsurance))+
						Double.parseDouble(Helper.correctDouble((String)strpermovprop))+
						Double.parseDouble(Helper.correctDouble((String)strshare)));		
				TotalAssets=nf.format(Double.parseDouble(Helper.correctDouble((String)TotalMoveable))+
						Double.parseDouble(Helper.correctDouble((String)strperimmovprop)));
				NetAssets=nf.format(Double.parseDouble(Helper.correctDouble((String)TotalAssets)) - 
						Double.parseDouble(Helper.correctDouble((String)strtotlia)));
				vecCoapp.add(TotalMoveable);
				vecCoapp.add(TotalAssets);
				vecCoapp.add(NetAssets);	
				vecCoapp.add(Means);	
				
				vecReport.add(vecCoapp);
			}
			hshValues.put("vecReport",vecReport);
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("appreport_g^"+strAppno);
			vecReport=new ArrayList();
			while(rs.next())
			{
				vecCoapp=new ArrayList();
				strType=correctNull(rs.getString("demo_type"));
			
				strId=strType+correctNull(rs.getString("demo_appid"));
				if (strType.trim().equalsIgnoreCase("c"))
				{
					strType="Co-Applicant";
				}
				else if (strType.trim().equalsIgnoreCase("g"))
				{	
					strType="Guarantor";
				}
				else if (strType.trim().equalsIgnoreCase("o"))
				{	
					strType="Co-Obligant";
				}
				vecCoapp.add(strType);
				strName=correctNull(rs.getString("coappname"));
				vecCoapp.add(strName);
				
				strQuery=SQLParser.getSqlQuery("appreport_2_1^"+strAppno+"^"+strId);
				rs1 =DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					strbankbal=Helper.correctDouble((String)rs1.getString("bankbal"));			
				}
				
				rs1=null;
				strQuery=SQLParser.getSqlQuery("appreport_2_2^"+strAppno+"^"+strId);
				rs1 =DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					strshare=Helper.correctDouble((String)rs1.getString("shares"));	
				}
				
				rs1=null;
				strQuery=SQLParser.getSqlQuery("appreport_2_3^"+strAppno+"^"+strId);
				rs1 =DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					strperimmovprop=Helper.correctDouble((String)rs1.getString("perimmovprop"));
				}
				
				rs1=null;
				strQuery=SQLParser.getSqlQuery("appreport_2_4^"+strAppno+"^"+strId);
				rs1 =DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					strpermovprop=Helper.correctDouble((String)rs1.getString("permovprop"));
				}
				
				rs1=null;
				strQuery=SQLParser.getSqlQuery("appreport_2_5^"+strAppno+"^"+strId);
				rs1 =DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					strinsurance=Helper.correctDouble((String)rs1.getString("insurance"));
				}
				
				rs1=null;
				strQuery=SQLParser.getSqlQuery("appreport_2_6^"+strAppno+"^"+strId);
				rs1 =DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					strtotlia=Helper.correctDouble((String)rs1.getString("totlia"));
				}
				rs1=null;
				
				Means="0.00";
				
				strQuery=SQLParser.getSqlQuery("creditapptotmeans^"+strAppno+"^"+strId);
				rs1 =DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					Means=Helper.correctDouble((String)rs1.getString("CR_Total_MEANS"));
				}
				
				vecCoapp.add(strbankbal);
				vecCoapp.add(strshare);
				vecCoapp.add(strinsurance);
				vecCoapp.add(strpermovprop);					
				vecCoapp.add(strperimmovprop);
				vecCoapp.add(strtotlia);	
				TotalMoveable=nf.format(Double.parseDouble(Helper.correctDouble((String)strbankbal))+
						Double.parseDouble(Helper.correctDouble((String)strinsurance))+
						Double.parseDouble(Helper.correctDouble((String)strpermovprop))+
						Double.parseDouble(Helper.correctDouble((String)strshare)));		
				TotalAssets=nf.format(Double.parseDouble(Helper.correctDouble((String)TotalMoveable))+
						Double.parseDouble(Helper.correctDouble((String)strperimmovprop)));
				NetAssets=nf.format(Double.parseDouble(Helper.correctDouble((String)TotalAssets)) - 
						Double.parseDouble(Helper.correctDouble((String)strtotlia)));
				vecCoapp.add(TotalMoveable);
				vecCoapp.add(TotalAssets);
				vecCoapp.add(NetAssets);
				vecCoapp.add(Means);	
				vecReport.add(vecCoapp);
			}
			hshValues.put("vecReportGuarantor", vecReport);
		}
		catch(Exception Ex)
		{
			log.error("Exception in getting data for Networth" + Ex.toString());
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
		return hshValues;
	}
}