package com.sai.laps.ejb.setusedby;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.setuprate.setuprateBean;
import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "SetUsedbyBean", mappedName = "SetUsedbyHome")
@Remote (SetUsedbyRemote.class)
public class SetUsedbyBean extends BeanAdapter
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 7837519032114096709L;

	static Logger log=Logger.getLogger(SetUsedbyBean.class);
	/**
	 * 
	 */
	

	public void updateData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strKeyId = "";
		try
		{
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			hshQueryValues.put("size","3");

			hshQuery.put("strQueryId","setprdusedbydel");
			arrValues = new ArrayList();
			arrValues.add(correctNull((String)hshValues.get("prdCode")));
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);

			hshQuery = new HashMap();
			hshQuery.put("strQueryId","setprdusedbyins");
			arrValues = new ArrayList();
			arrValues.add(correctNull((String)hshValues.get("prdCode")));
			arrValues.add(correctNull((String)hshValues.get("radioOrg")));
			arrValues.add(correctNull((String)hshValues.get("hidSeldInsti")));
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("2",hshQuery);
				
			hshQuery = new HashMap();
			hshQuery.put("strQueryId","setprdupd");
			arrValues = new ArrayList();
			arrValues.add(correctNull((String)hshValues.get("prdInternet")));
			arrValues.add(correctNull((String)hshValues.get("prdCode")));
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("3",hshQuery);
	
			//for Entering the values into auditrial
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

			HashMap hshTemp = new HashMap();
			hshTemp.put("prdCode",correctNull((String)hshValues.get("prdCode")));

			EJBInvoker.executeStateLess("setproducts",hshTemp,"updateProductSaveStatus");
			
			
			String strorglevel=correctNull((String)hshValues.get("radioOrg"));
			
			if(strorglevel.trim().equalsIgnoreCase("C"))
			{
				strorglevel=correctNull((String)hshValues.get("hidOrgName1"));
			}
			else if(strorglevel.trim().equalsIgnoreCase("R"))
			{
				strorglevel=correctNull((String)hshValues.get("hidOrgName2"));
			}
			else if(strorglevel.trim().equalsIgnoreCase("D"))
			{
				strorglevel=correctNull((String)hshValues.get("hidOrgName3")); 
			}
			else if(strorglevel.trim().equalsIgnoreCase("A"))
			{
				strorglevel=correctNull((String)hshValues.get("hidOrgName4")); 
			}
			else if(strorglevel.trim().equalsIgnoreCase("B"))
			{
				strorglevel=correctNull((String)hshValues.get("hidOrgName5"));
			}
			
			StringBuilder sbAuditTrial=new StringBuilder();
			int intPrdcode = Integer.parseInt(Helper.correctInt((String)hshValues.get("prdCode")));
			sbAuditTrial.append("Product Code =").append(intPrdcode).append("~Level=").append(strorglevel).
			append("~Selected Institution=").append(correctNull((String)hshValues.get("seldInsti1")));
			if(correctNull((String)hshValues.get("hidRecordflag")).equals("Y"))
				correctNull((String)hshValues.put("hidAction", "update"));
			
			AuditTrial.auditLog(hshValues,"14",Integer.toString(intPrdcode),sbAuditTrial.toString());
		}
		catch(Exception ce)
		{
			log.error("in bean... "+ce);
			throw new EJBException("Error in updateData "+ce.toString());
		}
	}

	public HashMap getData(HashMap hshRequestValues) 
	{		
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = null, hshValues = null;
		HashMap hshSelNames = null;
		String strOrgCode = null;
		boolean recordflag=false;
		try
		{			
			strQuery = SQLParser.getSqlQuery("setprdusedbysel^"+correctNull((String)hshRequestValues.get("prdCode")));
			rs = DBUtils.executeQuery(strQuery);
			hshRecord = new HashMap();
			while(rs.next())
			{
				recordflag=true;
				hshRecord.put("prd_internet",Helper.correctDoubleQuote(correctNull(rs.getString("prd_internet"))) );
				hshRecord.put("prd_code",Helper.correctDoubleQuote(correctNull(rs.getString("prd_code"))) );
				hshRecord.put("prd_org_level",Helper.correctDoubleQuote(correctNull(rs.getString("prd_org_level"))) );
				strOrgCode = Helper.correctDoubleQuote(correctNull(rs.getString("prd_org_scode")));				
				hshRecord.put("prd_org_scode",strOrgCode);
			}
          
			hshRecord = getOrgs(hshRecord);
			if(rs!=null)rs.close();
			strQuery = SQLParser.getSqlQuery("setorgnamesel");
			rs = DBUtils.executeQuery(strQuery);
			hshValues = new HashMap();

			while(rs.next())
			{
				String strTemp = Helper.correctDoubleQuote(correctNull(rs.getString("org_level"))) + Helper.correctDoubleQuote(correctNull(rs.getString("org_name")));
				hshValues.put(Helper.correctDoubleQuote(correctNull(rs.getString("org_scode"))),strTemp);
			}
						
			if( strOrgCode != null )
			{
				StringTokenizer st = new StringTokenizer(strOrgCode,";");
				hshSelNames = new HashMap();
				while(st.hasMoreTokens())
				{
					String strCode = correctNull((String)(String)st.nextToken());
					String strOrgName = correctNull((String)(String)hshValues.get(strCode));
					if(strOrgName != null)
					{
						strOrgName = strOrgName.substring(1,strOrgName.length());
						hshSelNames.put(strCode,strOrgName);
					} 
				}
				hshRecord.put("OrgSelNames",hshSelNames);
			}
			else
			{
				hshRecord.put("OrgSelNames",new HashMap());
			}

			hshRecord.put("OrgNames",hshValues);
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
				if(rs!=null)
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

	public HashMap getOrgs(HashMap hshRecord) 
	{		
		String strQuery = "";
		ResultSet rs = null;
		try
		{			
			strQuery = SQLParser.getSqlQuery("setorgsel");

			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshRecord.put("orgname1",Helper.correctDoubleQuote( 
						correctNull(rs.getString("glp_orgname1"))) );
				hshRecord.put("orgname2",Helper.correctDoubleQuote( 
						correctNull(rs.getString("glp_orgname2"))) );
				hshRecord.put("orgname3",Helper.correctDoubleQuote( 
						correctNull(rs.getString("glp_orgname3"))) );
				hshRecord.put("orgname4",Helper.correctDoubleQuote( 
						correctNull(rs.getString("glp_orgname4"))) );
				hshRecord.put("orgname5",Helper.correctDoubleQuote( 
						correctNull(rs.getString("glp_orgname5"))) );
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
				if(rs!=null)
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
	public HashMap getFacUsedby(HashMap hshRequestValues) 
	{
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = null, hshValues = null;
		HashMap hshNames =null, hshSelNames = null;
		String strOrgCode = null;
		String fac_id="";
		try
		{
			hshRecord = new HashMap();
			fac_id = Helper.correctNull((String) hshRequestValues.get("fac_id"));
			if(fac_id.equalsIgnoreCase(""))
			{
				fac_id = Helper.correctNull((String) hshRequestValues.get("fac_id1"));
			}
			strQuery = SQLParser.getSqlQuery("facility_usedby_select^"+fac_id);
			rs = DBUtils.executeQuery(strQuery);

			hshRecord = new HashMap();
			while(rs.next())
			{
				hshRecord.put("prd_code",Helper.correctDoubleQuote( 
						correctNull(rs.getString("fac_id"))) );
				hshRecord.put("prd_org_level",Helper.correctDoubleQuote( 
						correctNull(rs.getString("fac_org_level"))) );
				strOrgCode = Helper.correctDoubleQuote(correctNull(
						rs.getString("fac_org_scode")));
				
				hshRecord.put("fac_org_scode",strOrgCode);
			}
			hshRecord = getOrgs(hshRecord);
			strQuery = SQLParser.getSqlQuery("setorgnamesel");
			rs = DBUtils.executeQuery(strQuery);
			hshValues = new HashMap();
			hshNames = new HashMap();
			while(rs.next())
			{
				String strTemp = Helper.correctDoubleQuote(Helper.correctDouble(rs.getString("org_level"))) + Helper.correctDoubleQuote(Helper.correctDouble(rs.getString("org_name")));
				hshValues.put(Helper.correctDoubleQuote( 
					correctNull(rs.getString("org_scode"))),strTemp);
			}
			if( strOrgCode != null )
			{
				StringTokenizer st = new StringTokenizer(strOrgCode,";");
				hshSelNames = new HashMap();
				while(st.hasMoreTokens())
				{
					String strCode = (String)st.nextToken();
					String strOrgName = (String)hshValues.get(strCode);
					if(strOrgName != null)
					{
						strOrgName = strOrgName.substring(1,strOrgName.length());
						hshSelNames.put(strCode,strOrgName);
					} 
				}
				hshRecord.put("OrgSelNames",hshSelNames);
			}
			else
			{
				hshRecord.put("OrgSelNames",new HashMap());
			}
			hshRecord.put("OrgNames",hshValues);
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
				hshValues=null;
				hshNames=null;
				hshSelNames=null;
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}
	public void updateFacUsedby(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String fac_id ="";
		fac_id = Helper.correctNull((String) hshValues.get("fac_id1"));
		StringBuilder sbAuditTrial=new StringBuilder();
		StringBuilder sbOldAudit = new StringBuilder();
		ResultSet rs=null;
		ResultSet rs1=null;
		String strQuery="";
		try
		{
			/***
			 * For Audit Trial Old Data - By Karthikeyan.S on 10/10/2013
			 */
			hshValues=getOrgs(hshValues);
			strQuery=SQLParser.getSqlQuery("facility_usedby_select^"+fac_id);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				//Select Organization Level
				String strOrgLevelOldAudit=Helper.correctNull(rs.getString("fac_org_level"));
				String strOrgLevelDescOldAudit="";
				if(strOrgLevelOldAudit.equalsIgnoreCase("C"))
				{
					strOrgLevelDescOldAudit=Helper.correctNull((String)hshValues.get("orgname1"));
				}
				else if(strOrgLevelOldAudit.equalsIgnoreCase("R"))
				{
					strOrgLevelDescOldAudit=Helper.correctNull((String)hshValues.get("orgname2"));
				}
				else if(strOrgLevelOldAudit.equalsIgnoreCase("D"))
				{
					strOrgLevelDescOldAudit=Helper.correctNull((String)hshValues.get("orgname3"));
				}
				else if(strOrgLevelOldAudit.equalsIgnoreCase("A"))
				{
					strOrgLevelDescOldAudit=Helper.correctNull((String)hshValues.get("orgname4"));
				}
				//Selected Institutions
				strQuery = SQLParser.getSqlQuery("setorgnamesel");
				rs1 = DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					String strTemp = Helper.correctDoubleQuote(Helper.correctDouble(rs1.getString("org_level"))) + Helper.correctDoubleQuote(Helper.correctDouble(rs1.getString("org_name")));
					hshRecord.put(Helper.correctDoubleQuote( 
						correctNull(rs1.getString("org_scode"))),strTemp);
				}
				String strOrgCodeOldAudit=Helper.correctNull(rs.getString("fac_org_scode"));
				String strOrgNameDescOldAudit="";
				if( strOrgCodeOldAudit != null )
				{
					StringTokenizer st = new StringTokenizer(strOrgCodeOldAudit,";");
					while(st.hasMoreTokens())
					{
						String strCode = (String)st.nextToken();
						String strOrgName = (String)hshRecord.get(strCode);
						if(strOrgName != null)
						{
							strOrgName = strOrgName.substring(1,strOrgName.length());
							strOrgNameDescOldAudit=strOrgNameDescOldAudit+strOrgName+", ";
						} 
					}
				}
				sbOldAudit.append("~Select Organization Level=").append(strOrgLevelDescOldAudit)
				.append("~Selected Institutions=").append(strOrgNameDescOldAudit);
			}
			if(rs!=null)
			{
				rs.close();
			}
			/***
			 * End - Audit Trial Old Data
			 */
			hshQueryValues.put("size","2");

			hshQuery.put("strQueryId","facility_usedby_delete");
			arrValues = new ArrayList();
			arrValues.add(fac_id);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);

			hshQuery = new HashMap();
			hshQuery.put("strQueryId","facility_usedby_insert");
			arrValues = new ArrayList();
			arrValues.add(fac_id);
			arrValues.add(hshValues.get("radioOrg"));
			arrValues.add(hshValues.get("hidSeldInsti"));
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("2",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			HashMap hshTemp = new HashMap();
			hshTemp.put("fac_id",hshValues.get("fac_id1"));		
			EJBInvoker.executeStateLess("corporatefacility",hshTemp,"updateFacilitySaveStatus");
			/***
			 * For Audit Trial New Data - By Karthikeyan.S on 10/10/2013
			 */
			//Select Organization Level
			String strOrgLevel=Helper.correctNull((String)hshValues.get("radioOrg"));
			String strOrgLevelDesc="";
			if(strOrgLevel.equalsIgnoreCase("C"))
			{
				strOrgLevelDesc=Helper.correctNull((String)hshValues.get("orgname1"));
			}
			else if(strOrgLevel.equalsIgnoreCase("R"))
			{
				strOrgLevelDesc=Helper.correctNull((String)hshValues.get("orgname2"));
			}
			else if(strOrgLevel.equalsIgnoreCase("D"))
			{
				strOrgLevelDesc=Helper.correctNull((String)hshValues.get("orgname3"));
			}
			else if(strOrgLevel.equalsIgnoreCase("A"))
			{
				strOrgLevelDesc=Helper.correctNull((String)hshValues.get("orgname4"));
			}
			//Selected Institutions
			if(rs1!=null)
			{
				rs1.close();
			}
			hshRecord=new HashMap();
			strQuery = SQLParser.getSqlQuery("setorgnamesel");
			rs1 = DBUtils.executeQuery(strQuery);
			while(rs1.next())
			{
				String strTemp = Helper.correctDoubleQuote(Helper.correctDouble(rs1.getString("org_level"))) + Helper.correctDoubleQuote(Helper.correctDouble(rs1.getString("org_name")));
				hshRecord.put(Helper.correctDoubleQuote( 
					correctNull(rs1.getString("org_scode"))),strTemp);
			}
			String strOrgCode=Helper.correctNull((String)hshValues.get("hidSeldInsti"));
			String strOrgNameDesc="";
			if( strOrgCode != null )
			{
				StringTokenizer st = new StringTokenizer(strOrgCode,";");
				while(st.hasMoreTokens())
				{
					String strCode = (String)st.nextToken();
					String strOrgName = (String)hshRecord.get(strCode);
					if(strOrgName != null)
					{
						strOrgName = strOrgName.substring(1,strOrgName.length());
						strOrgNameDesc=strOrgNameDesc+strOrgName+", ";
					} 
				}
			}
			sbAuditTrial.append("~Select Organization Level=").append(strOrgLevelDesc)
			.append("~Selected Institutions=").append(strOrgNameDesc);
			/***
			 * End - Audit Trial New Data
			 */
			AuditTrial.auditNewLog(hshValues,"102",fac_id,sbAuditTrial.toString(),sbOldAudit.toString());
		}
		catch(Exception ce)
		{
			log.error("in bean... "+ce);
			throw new EJBException("Error in updateData "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs!=null)
				{
					rs.close();
				}
				if(rs1!=null)
				{
					rs1.close();
				}
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
			hshQueryValues=null;
			arrValues=null;
			hshQuery=null;
		}
	}
}