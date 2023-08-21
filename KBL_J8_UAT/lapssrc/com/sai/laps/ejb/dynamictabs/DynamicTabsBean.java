package com.sai.laps.ejb.dynamictabs;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.duplicatequeries.DuplicateQueriesBean;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = " DynamicTabsBean", mappedName = "DynamicTabsHome")
@Remote ( DynamicTabsRemote.class)
public class DynamicTabsBean extends BeanAdapter 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(DynamicTabsBean.class);

	public HashMap getData(HashMap hshRequestValues) 
	{		
		ResultSet rs = null;
		ResultSet rs1 = null;
		String strQuery = "";
		ArrayList arrValues = new ArrayList();
		HashMap hshRecord = new HashMap();
		String screen_type = "Agriculture";
		String strProductType = correctNull((String)hshRequestValues.get("strProductType"));
		String appno = correctNull((String)hshRequestValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshRequestValues.get("appno"));
		}
		String strTopPage = correctNull((String) hshRequestValues.get("hidTopPage"));
		String strChildPage = correctNull((String) hshRequestValues.get("hidChildPage"));
		String strChildTab = correctNull((String) hshRequestValues.get("hidChildTab"));
		String strTabId = correctNull((String) hshRequestValues.get("hidTabId"));
		String strParentId = correctNull((String) hshRequestValues.get("hidParentId"));
		String strChildId = correctNull((String) hshRequestValues.get("hidChildId"));
		
		try 
		{			
			String strprodtype ="";
			strprodtype = strProductType.substring(0,1);
			if(strprodtype.equalsIgnoreCase("a"))
			{
				strQuery = SQLParser.getSqlQuery("get_main_tabs^"+ strProductType + "^" + screen_type);
				rs = DBUtils.executeQuery(strQuery);				
				while (rs.next()) 
				{
					ArrayList arrRow = new ArrayList();
					arrRow.add(correctNull(rs.getString("screen_id")));
					arrRow.add(correctNull(rs.getString("screen_name")));
					arrRow.add(correctNull(rs.getString("screen_jsp_page")));
					arrValues.add(arrRow);
				}
				hshRecord.put("arrValues", arrValues);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("get_main_tabs1");
				rs = DBUtils.executeQuery(strQuery);	
				while (rs.next()) 
				{
					ArrayList arrRow = new ArrayList();
					arrRow.add(correctNull(rs.getString("screen_id")));
					arrRow.add(correctNull(rs.getString("screen_name")));
					arrRow.add(correctNull(rs.getString("screen_jsp_page")));
					arrValues.add(arrRow);
				}
				hshRecord.put("arrValues", arrValues);
			}
			String strhidFlag = correctNull((String) hshRequestValues.get("hidFlag"));
			if (strhidFlag.trim().equalsIgnoreCase("orgChange"))
			{
				String strOrgCode = correctNull((String) hshRequestValues.get("OrgCode"));
				String strOrgName = correctNull((String) hshRequestValues.get("OrgName"));
				String strOrgShortCode = correctNull((String) hshRequestValues.get("org_scode"));
				String strOrgLevel = correctNull((String) hshRequestValues.get("OrgLevel"));
				hshRecord.put("hidFlag", strhidFlag);
				hshRecord.put("OrgCode", strOrgCode);
				hshRecord.put("OrgName", strOrgName);
				hshRecord.put("OrgScode", strOrgShortCode);
				hshRecord.put("Orglevel", strOrgLevel);
				hshRecord.put("strTopPage", strTopPage);
				hshRecord.put("strTabId", strTabId);
			}
			hshRecord.put("hidParentId", strParentId);
			hshRecord.put("hidChildId", strChildId);
			hshRecord.put("hidChildPage", strChildPage);
			hshRecord.put("hidChildTab", strChildTab);
			hshRecord.put("appno", appno);
		} 
		catch (Exception ce) 
		{
			throw new EJBException("Error in getData..." + ce.toString());
		} 
		finally 
		{
			try
			{
				if (rs != null) 
				{
					rs.close();
				}
				if (rs1 != null)
				{
					rs1.close();
				}
				
			} 
			catch (Exception cf) 
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap getChildTabs(HashMap hshRequestValues) 
	{
		HashMap hshRecord = new HashMap();		
		ResultSet rs = null;
		String strQuery = "";
		String strParentTabId = correctNull((String) hshRequestValues.get("strParent"));
		String strChildTabId = correctNull((String) hshRequestValues.get("strChild"));
		String strFlag= correctNull((String) hshRequestValues.get("flag"));

		try 
		{			
			if(!(strParentTabId.trim().equalsIgnoreCase("")))
			{
				strParentTabId = correctNull((String) hshRequestValues.get("strParent"));
				strQuery = SQLParser.getSqlQuery("get_child_tabs^" + strParentTabId);	
				rs = DBUtils.executeQuery(strQuery);
				ArrayList arrValues = new ArrayList();
				while (rs.next())
				{
					ArrayList arrRow = new ArrayList();
					arrRow.add(correctNull(rs.getString("screen_id")));
					arrRow.add(correctNull(rs.getString("screen_name")));
					arrRow.add(correctNull(rs.getString("screen_jsp_page")));
					arrRow.add(correctNull(rs.getString("screen_grp")));
					arrValues.add(arrRow);
				}
				hshRecord.put("strParent", strParentTabId);
				hshRecord.put("strChild", strChildTabId);
				hshRecord.put("arrValues", arrValues);
				hshRecord.put("flag", strFlag);
			}
		} 
		catch (Exception e) 
		{
			throw new EJBException("Error while retrieving child tabs..."+ e.toString());
		}
		finally 
		{
			try 
			{
				if (rs != null) 
				{
					rs.close();
				}
				
			} 
			catch (Exception cf)
			{
				throw new EJBException("Error while closing the connection..."+ cf.getMessage());
			}
		}
		return hshRecord;
	}
	
	public HashMap getAppraisalTabData(HashMap hshRequestValues) 
	{
		
		ResultSet rs = null;
		ResultSet rs1 = null;
		String strQuery = "";
		String pageid = "10";
		ArrayList arrValues = new ArrayList();
		HashMap hshRecord = new HashMap();
		String Govt_Scheme="",Screen_Name="",UGC_LOAN="0";
		String screen_type ="Appraisal";
		String strProductType = correctNull((String)hshRequestValues.get("strProductType"));
		String appno = correctNull((String)hshRequestValues.get("appno"));
		String strTopPage = correctNull((String) hshRequestValues.get("hidTopPage"));
		String strChildPage = correctNull((String) hshRequestValues.get("hidChildPage"));
		String strChildTab = correctNull((String) hshRequestValues.get("hidChildTab"));
		String strTabId = correctNull((String) hshRequestValues.get("hidTabId"));
		String strParentId = correctNull((String) hshRequestValues.get("hidParentId"));
		String strChildId = correctNull((String) hshRequestValues.get("hidChildId"));
		
		try 
		{			
			String strprodtype ="";
			strprodtype = strProductType.substring(0,1);
			if(strprodtype.equalsIgnoreCase("a"))
			{
				strQuery = SQLParser.getSqlQuery("getloanterms^"+appno);
				rs = DBUtils.executeQuery(strQuery);				
				if(rs.next()) 
				{
					Govt_Scheme=Helper.correctNull((String)rs.getString("loan_govt"));
				}
				
				if(rs!=null)
				{
					rs.close();
				}
				
				if(strProductType.equals("aC"))
				{
					strQuery = SQLParser.getSqlQuery("agrgettechdetails^"+appno);
					rs = DBUtils.executeQuery(strQuery);				
					if(rs.next()) 
					{
						UGC_LOAN=Helper.correctNull((String)rs.getString("tech_ugc"));
					}
				}
				
				if(rs!=null)
				{
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("get_main_tabs^"+ strProductType + "^" + screen_type);
				rs = DBUtils.executeQuery(strQuery);				
				if(Govt_Scheme.equalsIgnoreCase("1"))
				{
					while (rs.next()) 
					{				
						Screen_Name=Helper.correctNull((String)rs.getString("screen_name"));
						ArrayList arrRow = new ArrayList();
						if(UGC_LOAN.equalsIgnoreCase("2"))
						{
							if(!(Screen_Name.equalsIgnoreCase("Ass - scale of finance") 
									|| Screen_Name.equalsIgnoreCase("UGC Eligibility")))
							{
								arrRow.add(correctNull(rs.getString("screen_id")));
								arrRow.add(correctNull(rs.getString("screen_name")));
								arrRow.add(correctNull(rs.getString("screen_jsp_page")));
								arrValues.add(arrRow);
							}
						}
						else if(UGC_LOAN.equalsIgnoreCase("3"))
						{
							if(!(Screen_Name.equalsIgnoreCase("Ass- without scale of finance") 
									|| Screen_Name.equalsIgnoreCase("Ass - scale of finance")
									|| Screen_Name.equalsIgnoreCase("UGC Eligibility")))
							{
								arrRow.add(correctNull(rs.getString("screen_id")));
								arrRow.add(correctNull(rs.getString("screen_name")));
								arrRow.add(correctNull(rs.getString("screen_jsp_page")));
								arrValues.add(arrRow);
							}
						}
						else if(UGC_LOAN.equalsIgnoreCase("1"))
						{
							if(!(Screen_Name.equalsIgnoreCase("Ass- without scale of finance") 
										|| Screen_Name.equalsIgnoreCase("UGC Eligibility")))
								{
									arrRow.add(correctNull(rs.getString("screen_id")));
									arrRow.add(correctNull(rs.getString("screen_name")));
									arrRow.add(correctNull(rs.getString("screen_jsp_page")));
									arrValues.add(arrRow);
								}
						}else{
							
							if(!(Screen_Name.equalsIgnoreCase("Ass- without scale of finance") 
									|| Screen_Name.equalsIgnoreCase("UGC Eligibility")
									|| Screen_Name.equalsIgnoreCase("Ass - scale of finance")))
									
							{
								arrRow.add(correctNull(rs.getString("screen_id")));
								arrRow.add(correctNull(rs.getString("screen_name")));
								arrRow.add(correctNull(rs.getString("screen_jsp_page")));
								arrValues.add(arrRow);
							}
							
						}
						
					}
				}
				else
				{
					while (rs.next()) 
					{
						ArrayList arrRow = new ArrayList();
						Screen_Name=Helper.correctNull((String)rs.getString("screen_name"));
						if(UGC_LOAN.equalsIgnoreCase("2"))
						{
							if(!(Screen_Name.equalsIgnoreCase("Ass - scale of finance") 
									|| Screen_Name.equalsIgnoreCase("Check list for govt. scheme")
									|| Screen_Name.equalsIgnoreCase("UGC Eligibility")))
							{
								arrRow.add(correctNull(rs.getString("screen_id")));
								arrRow.add(correctNull(rs.getString("screen_name")));
								arrRow.add(correctNull(rs.getString("screen_jsp_page")));
								arrValues.add(arrRow);
							}
						}
						else if(UGC_LOAN.equalsIgnoreCase("3"))
						{
							if(!(Screen_Name.equalsIgnoreCase("Ass- without scale of finance") 
									|| Screen_Name.equalsIgnoreCase("Check list for govt. scheme")
									|| Screen_Name.equalsIgnoreCase("Ass - scale of finance")
									|| Screen_Name.equalsIgnoreCase("Eligibility")))
							{
								arrRow.add(correctNull(rs.getString("screen_id")));
								arrRow.add(correctNull(rs.getString("screen_name")));
								arrRow.add(correctNull(rs.getString("screen_jsp_page")));
								arrValues.add(arrRow);
							}
						}
						else if(UGC_LOAN.equalsIgnoreCase("1"))
						{
							if(!(Screen_Name.equalsIgnoreCase("Ass- without scale of finance") 
										|| Screen_Name.equalsIgnoreCase("Check list for govt. scheme")
										|| Screen_Name.equalsIgnoreCase("UGC Eligibility")))
								{
									arrRow.add(correctNull(rs.getString("screen_id")));
									arrRow.add(correctNull(rs.getString("screen_name")));
									arrRow.add(correctNull(rs.getString("screen_jsp_page")));
									arrValues.add(arrRow);
								}
						}else{
							
							if(!(Screen_Name.equalsIgnoreCase("Ass- without scale of finance") 
									|| Screen_Name.equalsIgnoreCase("Check list for govt. scheme")
									|| Screen_Name.equalsIgnoreCase("UGC Eligibility")
									|| Screen_Name.equalsIgnoreCase("Ass - scale of finance")))
									
							{
								arrRow.add(correctNull(rs.getString("screen_id")));
								arrRow.add(correctNull(rs.getString("screen_name")));
								arrRow.add(correctNull(rs.getString("screen_jsp_page")));
								arrValues.add(arrRow);
							}
							
						}
					}
				}
				
				hshRecord.put("arrValues", arrValues);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("get_main_tabs1");
				rs = DBUtils.executeQuery(strQuery);	
				while (rs.next()) 
				{
					ArrayList arrRow = new ArrayList();
					arrRow.add(correctNull(rs.getString("screen_id")));
					arrRow.add(correctNull(rs.getString("screen_name")));
					arrRow.add(correctNull(rs.getString("screen_jsp_page")));
					arrValues.add(arrRow);
				}
				hshRecord.put("arrValues", arrValues);
			}
			String strhidFlag = correctNull((String) hshRequestValues.get("hidFlag"));
			if (strhidFlag.trim().equalsIgnoreCase("orgChange"))
			{
				String strOrgCode = correctNull((String) hshRequestValues.get("OrgCode"));
				String strOrgName = correctNull((String) hshRequestValues.get("OrgName"));
				String strOrgShortCode = correctNull((String) hshRequestValues.get("org_scode"));
				String strOrgLevel = correctNull((String) hshRequestValues.get("OrgLevel"));
				hshRecord.put("hidFlag", strhidFlag);
				hshRecord.put("OrgCode", strOrgCode);
				hshRecord.put("OrgName", strOrgName);
				hshRecord.put("OrgScode", strOrgShortCode);
				hshRecord.put("Orglevel", strOrgLevel);
				hshRecord.put("strTopPage", strTopPage);
				hshRecord.put("strTabId", strTabId);
			}
			hshRecord.put("hidParentId", strParentId);
			hshRecord.put("hidChildId", strChildId);
			hshRecord.put("hidChildPage", strChildPage);
			hshRecord.put("hidChildTab", strChildTab);
			hshRecord.put("appno", appno);
			hshRecord.put("pageid", pageid);
		} 
		catch (Exception ce) 
		{
			throw new EJBException("Error in getData..." + ce.toString());
		} 
		finally 
		{
			try
			{
				if (rs != null) 
				{
					rs.close();
				}
				if (rs1 != null)
				{
					rs1.close();
				}
				
			} 
			catch (Exception cf) 
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}
		return hshRecord;
	}
}