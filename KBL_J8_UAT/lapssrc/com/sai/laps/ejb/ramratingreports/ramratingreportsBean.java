package com.sai.laps.ejb.ramratingreports;

import java.sql.ResultSet;
import java.util.HashMap;
import java.util.ArrayList;
import com.sai.laps.helper.DBUtils;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "ramratingreportsBean", mappedName = "ramratingreportsHome")
@Remote (ramratingreportsRemote.class)
public class ramratingreportsBean extends BeanAdapter 
{
	static Logger log=Logger.getLogger(ramratingreportsBean.class);	

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public HashMap getram105rep(HashMap hshValues) 
	{
		String strQuery="";
		ResultSet rs2 = null;
		String strAppno="";
		HashMap hshResult = new HashMap();	
		try
		{
			java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
			jtn.setMaximumFractionDigits(2);
			jtn.setMinimumFractionDigits(2);
			jtn.setGroupingUsed(false);
			strAppno=correctNull((String)hshValues.get("appno"));
			
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=correctNull((String)hshValues.get("ApplicationNo"));
			}
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno = Helper.correctNull((String)hshValues.get("strappno"));
			}
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno = Helper.correctNull((String)hshValues.get("comm_appno"));
			}
			strQuery = SQLParser.getSqlQuery("getramrating105details^"+strAppno);			
			rs2 =DBUtils.executeQuery(strQuery);
			if(rs2.next())
			{
				hshResult.put("branchname",correctNull(rs2.getString("branchname")));
				hshResult.put("regionname",correctNull(rs2.getString("regionname")));
				hshResult.put("companyname",correctNull(rs2.getString("companyname")));
				hshResult.put("companycode",correctNull(rs2.getString("companycode")));
				hshResult.put("dateoffinalisation",correctNull(rs2.getString("dateoffinalisation")));
				hshResult.put("lastrateddate_basemodel",correctNull(rs2.getString("lastrateddate_basemodel")));
				hshResult.put("lastrating_basemodel",correctNull(rs2.getString("lastrating_basemodel")));
				hshResult.put("lastscore_basemodel",correctNull(rs2.getString("lastscore_basemodel")));
				hshResult.put("lastgradef_basemodel",correctNull(rs2.getString("lastgradef_basemodel")));
								
				hshResult.put("lastrateddate_dynamicmodel",correctNull(rs2.getString("lastrateddate_dynamicmodel")));
				hshResult.put("lastrating_dynamicmodel",correctNull(rs2.getString("lastrating_dynamicmodel")));
				hshResult.put("lastscore_dynamicmodel",correctNull(rs2.getString("lastscore_dynamicmodel")));
				hshResult.put("lastgradef_dynamicmodel",correctNull(rs2.getString("lastgradef_dynamicmodel")));
				hshResult.put("lastcombinedrating_dm",correctNull(rs2.getString("lastcombinedrating_dm")));
				
				hshResult.put("currentratingdate_basemodel",correctNull(rs2.getString("currentratingdate_basemodel")));
				hshResult.put("currentrating_basemodel",correctNull(rs2.getString("currentrating_basemodel")));
				hshResult.put("currentscore_basemodel",correctNull(rs2.getString("currentscore_basemodel")));
				hshResult.put("currentgradef_basemodel",correctNull(rs2.getString("currentgradef_basemodel")));
				
				hshResult.put("currentratingdate_dynamicmodel",correctNull(rs2.getString("currentratingdate_dynamicmodel")));
				hshResult.put("currentrating_dynamicmodel",correctNull(rs2.getString("currentrating_dynamicmodel")));
				hshResult.put("currentscore_dynamicmodel",correctNull(rs2.getString("currentscore_dynamicmodel")));
				hshResult.put("currentgradef_dynamicmodel",correctNull(rs2.getString("currentgradef_dynamicmodel")));
				hshResult.put("currentcombinedrating_dm",correctNull(rs2.getString("currentcombinedrating_dm")));
				
				hshResult.put("ratingrationale",Helper.CLOBToString(rs2.getClob("ratingrationale")));
				//hshResult.put("ratingpoolremarks",correctNull(rs2.getString("ratingpoolremarks")));
			}	
			if(rs2!=null)
				rs2.close();
			strQuery = SQLParser.getSqlQuery("sel_financial_baseyear^"+strAppno);			
			rs2 =DBUtils.executeQuery(strQuery);
			if(rs2.next())
			{
				hshResult.put("base_year",correctNull(rs2.getString("base_year")));
			}
			return hshResult;
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData "+ce.toString());
		}
		finally 
		{
			try 
			{
				if (rs2 != null) 
				{
					rs2.close();
				}				 
			} 
			catch (Exception e) 
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
}
//	public HashMap getram106rep(HashMap hshValues)  
//	{
//		String strQuery="";
//		ResultSet rs2 = null;
//		
//		ArrayList ArrayList2=new ArrayList();
//		HashMap hshResult = new HashMap();	
//		try
//		{
//			java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
//			jtn.setMaximumFractionDigits(2);
//			jtn.setMinimumFractionDigits(2);
//			jtn.setGroupingUsed(false);
//			String appno=correctNull((String)hshValues.get("strappno"));
//			if(appno.equalsIgnoreCase(""))
//			{
//				appno = Helper.correctNull((String)hshValues.get("appno"));
//			}
//			if(appno.equalsIgnoreCase(""))
//			{
//				appno = Helper.correctNull((String)hshValues.get("comm_appno"));
//			}
//			strQuery=SQLParser.getSqlQuery("ramtolaps_newreport106^"+appno);
//			rs2 =DBUtils.executeQuery(strQuery);
//			while(rs2.next())
//			{
//				hshResult.put("BranchName",correctNull(rs2.getString("BranchName")));
//				hshResult.put("companyname",correctNull(rs2.getString("companyname")));
//				hshResult.put("companycode",correctNull(rs2.getString("companycode")));
//				hshResult.put("DateofFinalisation",correctNull(rs2.getString("DateofFinalisation")));
//				hshResult.put("CreditRatingbyRatingPool",correctNull(rs2.getString("CreditRatingbyRatingPool")));
//				hshResult.put("RatingPoolDate",correctNull(rs2.getString("RatingPoolDate")));
//				hshResult.put("RatingConfirmedbyCG",correctNull(rs2.getString("RatingConfirmedbyCG")));
//				hshResult.put("CGRating",correctNull(rs2.getString("CGRating")));
//				hshResult.put("CGRationale",correctNull(rs2.getString("CGRationale")));
//				hshResult.put("RatingReview",correctNull(rs2.getString("RatingReview")));
//				hshResult.put("CGObservations",correctNull(rs2.getString("CGObservations")));
//				
//			}
//			strQuery=SQLParser.getSqlQuery("ramtolaps_new1report106^"+appno); 
//			if(rs2!=null) 
//			{
//				rs2.close();
//			}
//			rs2=DBUtils.executeQuery(strQuery);
//			
//			while(rs2.next())
//			{
//				ArrayList ArrayList1=new ArrayList();
//				ArrayList1.add(correctNull((String)rs2.getString("FacilityName")));
//				ArrayList1.add(correctNull((String)rs2.getString("InterestRate")));
//				ArrayList2.add(ArrayList1);
//			}
//			hshResult.put("ArrayList2",ArrayList2);	
//			
//		}
//		catch(Exception ce)
//		{
//			throw new EJBException("Error in getData "+ce.toString());
//		}
//		finally 
//		{
//			try 
//			{
//				if (rs2 != null) 
//				{
//					rs2.close();
//				}				 
//			} 
//			catch (Exception e) 
//			{
//				throw new EJBException("Error in closing Connection "+ e.getMessage());
//			}
//		}
//		return hshResult;
//	}
	
	
}