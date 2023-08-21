package com.sai.laps.ejb.prdsanclimit;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

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

@Stateless(name = "PrdSanclimitBean", mappedName = "PrdSanclimitHome")
@Remote (PrdSanclimitRemote.class)
public class PrdSanclimitBean extends BeanAdapter
{
	static Logger log=Logger.getLogger(PrdSanclimitBean.class);	

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void updateData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = null;
		String strSancclass[] = null;
		String strSanlimit[] = null;
		String strSanDesig[] = null;
 		int intUpdatesize=0;
		int j=0;
		StringBuilder sbAuditTrial=new StringBuilder();
		String strKeyId = "";
		ResultSet rs = null;
		StringBuilder sbolddata=new StringBuilder();
		try
		{
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			String strAction=(String)hshValues.get("hidAction");
			String strPrdCode = correctNull((String)hshValues.get("prdCode"));
			/*rs = DBUtils.executeLAPSQuery("selgroupname^"+strPrdCode);
				while(rs.next())
				{
					sbolddata.append("~ User Designation = "+Helper.correctNull((String)rs.getString("grp_name")))
					.append("~ Powers = "+Helper.correctNull((String)rs.getString("sanction_limit")));
				}
				if(rs!=null)
					rs.close();*/
			if(hshValues.get("txtsanc_class")  instanceof java.lang.String){
				strSancclass=new String[1];
				strSancclass[0]= (String) hshValues.get("txtsanc_class");
			}else{
				strSancclass= (String[]) hshValues.get("txtsanc_class");
			}			
			if(hshValues.get("txtsanc_limit")  instanceof java.lang.String){
				strSanlimit=new String[1];
				strSanlimit[0]= (String) hshValues.get("txtsanc_limit");
			}else{
				strSanlimit= (String[]) hshValues.get("txtsanc_limit");
			}
			
 			if(hshValues.get("txtsanc_desig")  instanceof java.lang.String){
 				strSanDesig=new String[1];
				strSanDesig[0]= (String) hshValues.get("txtsanc_desig");
			}else{
				strSanDesig=(String[]) hshValues.get("txtsanc_desig");
			}
			intUpdatesize = intUpdatesize+1;
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","delsanclimit");
			arrValues.add(correctNull(strPrdCode));
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size",Integer.toString(intUpdatesize));
			hshQueryValues.put(Integer.toString(j+1),hshQuery);	
			j++;

			for( int i=0;i<strSancclass.length;i++)
			{				
				if(!strSancclass[i].trim().equals("") && strSancclass[i]!=null)
				{
					String strclass = correctNull((String)strSancclass[i]);
					String strlimit = correctNull((String)strSanlimit[i]);
					if(strclass.equals(""))
					{
						strclass="0";
					}
					if(strlimit.equals(""))
					{
						strlimit="0";
					}
					intUpdatesize = intUpdatesize+1;
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","inssanclimit");
					arrValues.add(strPrdCode);
					arrValues.add(strclass);
					arrValues.add(strlimit);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(j+1),hshQuery);	
					j++;
				}
			}
			//for Entering the values into auditrial
//			String strActionData = "";
//			for(int wfdata=0;wfdata<strSanDesig.length;wfdata++)
//			{
//				strActionData += "Designation="+strSanDesig[wfdata]+": Powers="+strSanlimit[wfdata]+";";
//			}
//			intUpdatesize = intUpdatesize+1;
//			hshQuery=new HashMap();
//			arrValues=new ArrayList();
//			hshQuery.put("strQueryId","audittrial");
//			arrValues.add("20");
//			arrValues.add(correctNull((String)hshValues.get("strUserId")));
//			arrValues.add(correctNull((String)hshValues.get("strClientIP")));
//			arrValues.add(correctNull((String)hshValues.get("prdCode")));
//			arrValues.add(strActionData);
//			arrValues.add("insert");
//			hshQuery.put("arrValues",arrValues);
//			hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
//			hshQueryValues.put("size",Integer.toString(intUpdatesize));
			
			//---------------------Audittrial---------------------
			String strActionData = "";
			for(int wfdata=0;wfdata<strSanDesig.length;wfdata++)
			{
				strActionData += "~ User Designation = "+strSanDesig[wfdata]+" ~ Powers = "+strSanlimit[wfdata]+";";	
			}
			sbAuditTrial.append(strActionData);
			if(correctNull((String)hshValues.get("hidRecordflag")).equals("Y"))
				hshValues.put("hidAction", "update");
			if(correctNull((String)hshValues.get("hidRecordflag")).equals("N"))
				hshValues.put("hidAction", "insert");
			int intProductCode = Integer.parseInt(strPrdCode);
			String strPrdCode1= Integer.toString(intProductCode);	
			AuditTrial.auditLog(hshValues,"22",strPrdCode1,sbAuditTrial.toString());
			//---------------------End----------------------------
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			HashMap hshTemp = new HashMap();
			hshTemp.put("prdCode",hshValues.get("prdCode"));		
			EJBInvoker.executeStateLess("setproducts",hshTemp,"updateProductSaveStatus");
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

	public  HashMap getData(HashMap hshValues) 
	{		
		String strQuery="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecData1 = new ArrayList();
		ArrayList vecVal=null;
		boolean recordflag=false;
		try
		{
			
			String strPrdCode = correctNull((String)hshValues.get("prdCode"));
			if (!strPrdCode.equals(""))
			{
				strQuery = SQLParser.getSqlQuery("selgroupname^"+strPrdCode);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					
					vecVal = new ArrayList();
					String strclass = correctNull(rs.getString("grp_id"));
					String strdesig = correctNull(rs.getString("grp_name"));
					String strsanction=correctNull(rs.getString("sanction_limit"));
					if(!strsanction.equalsIgnoreCase(""))
						recordflag=true;
					vecVal.add(correctNull(strclass));
					vecVal.add(correctNull(strsanction));
					vecVal.add(correctNull(strdesig));					
					vecData.add(vecVal);				
				}
				hshRecord.put("vecData",vecData);
			}
				if(vecData.size()==0){
					rs.close();
					strQuery = SQLParser.getSqlQuery("selgroupsanctionlimit");
					rs = DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						vecVal = new ArrayList();
						String strclass = correctNull(rs.getString("grp_id"));
						String strdesig = correctNull(rs.getString("grp_name"));				
						vecVal.add(correctNull(strclass));
						vecVal.add(correctNull(strdesig));					
						vecData1.add(vecVal);				
					}
					hshRecord.put("vecDatagroup",vecData1);
				}
				if(recordflag)
					hshRecord.put("recordflag","Y");
				else
					hshRecord.put("recordflag","N");
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs1 != null)
				{
					rs1.close();
				}
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
	public void updateDelegate(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = null;
		String strSancclass[] = null;
		String strSanlimit[] = null;
		String strSanDesig[] = null;
 		int intUpdatesize=0;
		int j=0;
		ResultSet rs = null;
		try
		{
			String strAction=(String)hshValues.get("hidAction");
			String strPrdCode = correctNull((String)hshValues.get("prdCode"));
			String strBankScheme=correctNull((String)hshValues.get("sel_bankscheme"));
			if(hshValues.get("txtsanc_class")  instanceof java.lang.String){
				strSancclass=new String[1];
				strSancclass[0]= (String) hshValues.get("txtsanc_class");
			}else{
				strSancclass= (String[]) hshValues.get("txtsanc_class");
			}			
			if(hshValues.get("txtsanc_limit")  instanceof java.lang.String){
				strSanlimit=new String[1];
				strSanlimit[0]= (String) hshValues.get("txtsanc_limit");
			}else{
				strSanlimit= (String[]) hshValues.get("txtsanc_limit");
			}
			
 			if(hshValues.get("txtsanc_desig")  instanceof java.lang.String){
 				strSanDesig=new String[1];
				strSanDesig[0]= (String) hshValues.get("txtsanc_desig");
			}else{
				strSanDesig=(String[]) hshValues.get("txtsanc_desig");
			}
		
			intUpdatesize = intUpdatesize+1;
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","deldelegate");
			arrValues.add(correctNull(strBankScheme));
		
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size",Integer.toString(intUpdatesize));
			hshQueryValues.put(Integer.toString(j+1),hshQuery);	
			j++;

			for( int i=0;i<strSancclass.length;i++)
			{				
				if(!strSancclass[i].trim().equals("") && strSancclass[i]!=null)
				{
					String strclass = correctNull((String)strSancclass[i]);
					String strlimit = correctNull((String)strSanlimit[i]);
					if(strclass.equals(""))
					{
						strclass="0";
					}
					if(strlimit.equals(""))
					{
						strlimit="0";
					}
					intUpdatesize = intUpdatesize+1;
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","insdelegate");
					arrValues.add(String.valueOf(intUpdatesize));
					arrValues.add(strBankScheme);
					arrValues.add(strclass);
					arrValues.add(strlimit);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(j+1),hshQuery);	
					j++;
				}
			}
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
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
	public  HashMap getDelegate(HashMap hshValues) 
	{		
		String strQuery="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecData1 = new ArrayList();
		ArrayList vecVal=null;
		boolean recordflag=false;
		String strBankScheme=correctNull((String)hshValues.get("sel_bankscheme"));
		try
		{
		  if(!strBankScheme.equalsIgnoreCase(""))
		  {
			strQuery = SQLParser.getSqlQuery("seldelegate^"+strBankScheme);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				
				vecVal = new ArrayList();
				String strclass = correctNull(rs.getString("grp_id"));
				String strdesig = correctNull(rs.getString("grp_name"));
				String strsanction=correctNull(rs.getString("prd_power"));
				if(!strsanction.equalsIgnoreCase(""))
					recordflag=true;
				vecVal.add(correctNull(strclass));
				vecVal.add(correctNull(strsanction));
				vecVal.add(correctNull(strdesig));					
				vecData.add(vecVal);				
			}
			hshRecord.put("vecData",vecData);
			hshRecord.put("strBankScheme",strBankScheme);
		  }	
		  
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs1 != null)
				{
					rs1.close();
				}
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