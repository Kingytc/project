package com.sai.laps.ejb.netownedfunds;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "NetOwnedFundsBean", mappedName = "NetOwnedFundsHome")
@Remote (NetOwnedFundsRemote.class)

public class NetOwnedFundsBean extends BeanAdapter
{	

/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(NetOwnedFundsBean.class);



public HashMap UpdateNetOwnedFundsData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshRecord =new HashMap();
		ArrayList arrValues=new ArrayList();		
		String strQuery="";			
		String strNetOwnedFundsId="";		
		ResultSet rs=null;
		String netownedfunds="";
		netownedfunds=Helper.correctDouble((String)hshValues.get("netownedfunds"));
		String sinexposure= Helper.correctDouble((String)hshValues.get("sinexposure"));
		String grpexposure= Helper.correctDouble((String)hshValues.get("grpexposure"));
		String strKeyId = "";
		if((netownedfunds.equals("0.00"))&&(sinexposure.equals("0.00"))&&(grpexposure.equals("0.00")))
		{
			hshRecord=getData(hshValues);
			return hshRecord;
		}
		else
		{
		
		try
		{	
				strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
				strQuery = SQLParser.getSqlQuery("maxNetOwnedFunds");
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
					{
						
						strNetOwnedFundsId =correctNull(rs.getString("net_id"));
					}

	
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");					
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","NetOwnedFundsins");				
				arrValues.add(strNetOwnedFundsId);
				arrValues.add(netownedfunds);
				arrValues.add(sinexposure);
				arrValues.add(grpexposure);		
				arrValues.add(Helper.correctDouble((String)hshValues.get("netownedfunds_date")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("totbankcredit_date")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("totbankcredit")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("sininfra")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("grpinfra")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("oilcmpy")));
				hshQuery.put("arrValues",arrValues);				
				hshQueryValues.put("1",hshQuery);	
				
				
				//for Entering the values into auditrial
			String strActionData = "Bank Net Owned Funds="+netownedfunds+"As on "+Helper.correctDouble((String)hshValues.get("netownedfunds_date"))+
									"~ Total Bank Credit as of previous year or previous quarter (Rs. in Crores) = "+
									Helper.correctDouble((String)hshValues.get("totbankcredit"))+
									"As on"+Helper.correctDouble((String)hshValues.get("totbankcredit_date"))+									
									"~ Single Borrower Exposure Limit="+sinexposure+"% of Bank Net Owned Funds"+
									"~ Single Borrower with Infrastructure = "+Helper.correctDouble((String)hshValues.get("sininfra"))+"% of Bank Net Owned Funds"+
				"~Group Exposure Limit="+grpexposure+"% of Bank Net Owned Funds"+
				"~ Group of Borrower with infrastructure Project = "+Helper.correctDouble((String)hshValues.get("grpinfra"))+"% of Bank Net Owned Funds"+
				"~ For Oil Companies = "+Helper.correctDouble((String)hshValues.get("oilcmpy"))+"% of Bank Net Owned Funds"+
				"~Modified date="+correctNull((String)hshValues.get("mdate"));
			if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("Y"))
			{
				hshValues.put("hidAction","Update");
			}
			else if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("N"))
			{
				hshValues.put("hidAction","Insert");
			} 
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
			
			 AuditTrial.auditLog(hshValues,"105",strKeyId,strActionData);
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

		hshRecord=getData(hshValues);

		return hshRecord;
		} //close else

	}




public HashMap getData(HashMap hshValues) 
	{		
		String strQuery="";
		ResultSet rs = null;		
		HashMap hshRecord = new HashMap();
		String recordflag = "N";
		
		try
		{
						
				strQuery=SQLParser.getSqlQuery("NetOwnedFundsselect");
				
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{	
				recordflag = "Y";
				hshRecord.put("netownedfunds",correctNull(rs.getString("net_bankfunds")));						
				hshRecord.put("sinexposure",correctNull(rs.getString("net_singleborrexp")));	
				hshRecord.put("grpexposure",correctNull(rs.getString("net_groupborrexp")));	
				hshRecord.put("mdate",correctNull(rs.getString("net_updatedate")));	
				hshRecord.put("ownedfundsasno",correctNull(rs.getString("net_ownedfundsasno")));	
				hshRecord.put("totbankcreditasno",correctNull(rs.getString("net_totbankcreditasno")));	
				hshRecord.put("totbankcredit",correctNull(rs.getString("net_totbankcredit")));	
				hshRecord.put("singleborrinfra",correctNull(rs.getString("net_singleborrinfra")));	
				hshRecord.put("groupborrinfra",correctNull(rs.getString("net_groupborrinfra")));	
				hshRecord.put("olicompany",correctNull(rs.getString("net_olicompany")));	
			}	
					
			
			hshRecord.put("recordflag",recordflag);
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getExpData "+ce.toString());
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






}//	end of class //


							
