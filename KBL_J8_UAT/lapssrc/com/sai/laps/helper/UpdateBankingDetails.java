package com.sai.laps.helper;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import com.sai.laps.helper.Helper;

import javax.ejb.EJBException;

public class UpdateBankingDetails
{
	public static void calBankSharePercent(HashMap hshValues) throws Exception
	{
		String strQuery="";
		String strAppno="";
		
		ResultSet rs=null;
		
		ArrayList arr=new ArrayList();
		HashMap hshquery=null;
		HashMap hshqueryval=new HashMap();
		
		double wc_funded_existing=0.0;
		double wc_funded_proposed=0.0;
		double wc_nonfunded_existing=0.0;
		double wc_nonfunded_proposed=0.0;
		
		double tl_funded_existing=0.0;
		double tl_funded_proposed=0.0;
		double tl_nonfunded_existing=0.0;
		double tl_nonfunded_proposed=0.0;
		
		double wc_fundexist=0.0;
		double wc_fundprop=0.0;
		double wc_nonfundexist=0.0;
		double wc_nonfundprop=0.0;
		
		double tl_fundexist=0.0;
		double tl_fundprop=0.0;
		double tl_nonfundexist=0.0;
		double tl_nonfundprop=0.0;
		
		
		try
		{
				
			strAppno=Helper.correctNull((String)hshValues.get("appno"));
			
			strQuery=SQLParser.getSqlQuery("selfacilitylimits^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				if(Helper.correctNull(rs.getString("facility_headid")).equals("1"))
				{
					tl_funded_existing=rs.getDouble("existinglimit");
					tl_funded_proposed=rs.getDouble("proposedlimit");
				}
				else if(Helper.correctNull(rs.getString("facility_headid")).equals("2"))
				{
					tl_nonfunded_existing=rs.getDouble("existinglimit");
					tl_nonfunded_proposed=rs.getDouble("proposedlimit");
				}
				else if(Helper.correctNull(rs.getString("facility_headid")).equals("3"))
				{
					wc_funded_existing=rs.getDouble("existinglimit");
					wc_funded_proposed=rs.getDouble("proposedlimit");
				}
				else if(Helper.correctNull(rs.getString("facility_headid")).equals("4"))
				{
					wc_nonfunded_existing=rs.getDouble("existinglimit");
					wc_nonfunded_proposed=rs.getDouble("proposedlimit");
				}
			}
			
			
			rs=DBUtils.executeLAPSQuery("seltotexposure^"+strAppno);
			while(rs.next())
			{				
				if(Helper.correctNull(rs.getString("combk_type")).equalsIgnoreCase("W"))
				{
					wc_fundexist=rs.getDouble("exifundlimit")==0.0?0.0:(wc_funded_existing/rs.getDouble("exifundlimit")*100);
					wc_fundprop=rs.getDouble("propfundlimit")==0.0?0.0:(wc_funded_proposed/rs.getDouble("propfundlimit")*100);
					wc_nonfundexist=rs.getDouble("exinonfundlimit")==0.0?0.0:(wc_nonfunded_existing/rs.getDouble("exinonfundlimit")*100);
					wc_nonfundprop=rs.getDouble("propnonfundlimit")==0.0?0.0:(wc_nonfunded_proposed/rs.getDouble("propnonfundlimit")*100);
				}
				else if(Helper.correctNull(rs.getString("combk_type")).equalsIgnoreCase("T"))
				{
					tl_fundexist=rs.getDouble("exifundlimit")==0.0?0.0:(tl_funded_existing/rs.getDouble("exifundlimit")*100);
					tl_fundprop=rs.getDouble("propfundlimit")==0.0?0.0:(tl_funded_proposed/rs.getDouble("propfundlimit")*100);
					tl_nonfundexist=rs.getDouble("exinonfundlimit")==0.0?0.0:(tl_nonfunded_existing/rs.getDouble("exinonfundlimit")*100);
					tl_nonfundprop=rs.getDouble("propnonfundlimit")==0.0?0.0:(tl_nonfunded_proposed/rs.getDouble("propnonfundlimit")*100);
				}
			}
			
				hshquery = new HashMap();
				arr=new ArrayList();
				hshqueryval.put("size","1");
				hshquery.put("strQueryId","upd_share_percent");
				arr.add(Helper.formatDoubleValue(wc_fundexist));
				arr.add(Helper.formatDoubleValue(wc_nonfundexist));
				arr.add(Helper.formatDoubleValue(wc_fundprop));
				arr.add(Helper.formatDoubleValue(wc_nonfundprop));
				arr.add(Helper.formatDoubleValue(tl_fundexist));
				arr.add(Helper.formatDoubleValue(tl_nonfundexist));
				arr.add(Helper.formatDoubleValue(tl_fundprop));
				arr.add(Helper.formatDoubleValue(tl_nonfundprop));
				arr.add(strAppno);
				hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
		}
		catch(Exception ex)
		{
			throw new EJBException();
		}
	}
	
	public static void UpdateTotalExposure(HashMap hshValues)throws Exception
	{
		try
		{
			
		}
		catch(Exception ex)
		{
			throw new EJBException("Error in UpdateTotalExposure :: "+ex.toString());
		}
	}
	

}
