package com.sai.laps.ejb.prodavail;

import java.sql.ResultSet;

import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "ProdAvailBean", mappedName = "ProdAvailHome")
@Remote (ProdAvailRemote.class)
public class ProdAvailBean extends BeanAdapter
{
	static Logger log=Logger.getLogger(ProdAvailBean.class);	

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public HashMap getData(HashMap hshValues) 
	{
		HashMap hshRecord = new HashMap();
		String strMethod ="";

		try
		{
			strMethod=(String)hshValues.get("hidMethod");

			if (strMethod.equalsIgnoreCase("getProducts"))
			{
				hshRecord =(HashMap) getProducts(hshValues);
			} 
			else if (strMethod.equalsIgnoreCase("getRepDetails"))
			{
				hshRecord =(HashMap)getRepDetails(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("showProfile"))
			{
				hshRecord =(HashMap)showProfile(hshValues);
			} 
			else if (strMethod.equalsIgnoreCase("getParamList"))
			{
				hshRecord =(HashMap)getParamList(hshValues);
			} 
		
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getdata "+ce.toString());
		}
		
		return hshRecord;

	}

	
	
	private HashMap getProducts(HashMap hshPar) 
	{		
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strQuery = null;
		ArrayList vecProdCode = new ArrayList();
 		ArrayList vecProdName = new ArrayList();		
		String strProdType=null;
		String strProd = null;

		try
		{			
			strProd = (String)hshPar.get("hidProducts");
			if (strProd.equalsIgnoreCase("subprod"))
			{
				strProdType=correctNull((String)hshPar.get("prodtype")); 
				strQuery = SQLParser.getSqlQuery("subproductcat^"+Integer.parseInt(strProdType));
			}
			else if (strProd.equalsIgnoreCase("prod"))
			{
				strProdType=correctNull((String)hshPar.get("prodtype"));
				strQuery = SQLParser.getSqlQuery("productcat^"+strProdType);
			}
			rs = DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				 vecProdCode.add(correctNull(rs.getString("cat_id")));
				 vecProdName.add(correctNull(rs.getString("cat_name")));	
			}
						
			hshRecord.put("hidProducts",strProd);						
			hshRecord.put("vecCodes",vecProdCode);
			hshRecord.put("vecValues",vecProdName);
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in help "+ce.toString());
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
	
	private HashMap getRepDetails(HashMap hshRequestValues) 
	{		
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ArrayList vecRecords=null;
		HashMap hshRec=null;
		ArrayList vecVal =null;
		String strQuery=null;
		String strOrgCode = null;
		String strOpFields = null;
		String strSelFields=null;
		String strCatFields=null;
		String strTemp=null;
		ArrayList vecT = new ArrayList();
		ArrayList vecOrg = new ArrayList();
		ArrayList vecName = new ArrayList();
		String strGen=null;
		String strDate=null;
			
		try
		{
			
			strOrgCode =(String)hshRequestValues.get("hidPrdCode");
			strCatFields =(String)hshRequestValues.get("hidCatFields");
			strSelFields =(String)hshRequestValues.get("hidSelFields");
			strOpFields =(String)hshRequestValues.get("hidOpFields");
			strGen =(String)hshRequestValues.get("strUserId");
			strDate =(String)hshRequestValues.get("txtDate");

			strQuery = SQLParser.getSqlQuery("selusername^"+strGen);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2));//+" "+correctNull(rs.getString(3));
			}
			rs.close();
			StringTokenizer st = new StringTokenizer(strSelFields,",");
			while (st.hasMoreTokens())
			{
				vecT.add(st.nextToken());
			}
			strQuery = SQLParser.getSqlQuery("repprodavail^"+strOpFields+"^"+strOrgCode+"^"+strCatFields);
					
			rs = DBUtils.executeQuery(strQuery);
			
			hshRec = new HashMap();
			vecVal = new ArrayList();
			while (rs.next())
			{
				vecRecords = new ArrayList();
				
				if (vecT.contains("Product Description"))
				{
					strTemp =correctNull(rs.getString("prd_desc"));
					vecRecords.add(strTemp);
					
				}
				if (vecT.contains("Category"))
				{
					strTemp =correctNull(rs.getString("cat_name"));
					vecRecords.add(strTemp);
					
				}
				if (vecT.contains("Sub Category"))
				{
					strTemp =correctNull(rs.getString("scat_name"));
					vecRecords.add(strTemp);
					
				}
				
				if (vecT.contains("Interest Rate"))
				{
					strTemp =correctNull(rs.getString("prd_intrate"));
					vecRecords.add(strTemp);
					
				}
				if (vecT.contains("Range From"))
				{
					vecRecords.add(correctNull(
												rs.getString("prd_rng_from")));
					
				}
				if (vecT.contains("Range To"))
				{
					vecRecords.add(correctNull(
												rs.getString("prd_rng_to")));
					
				}
				if (vecT.contains("Introduction Date"))
				{
					strTemp =correctNull(rs.getString("prd_intro_date"));
					vecRecords.add(strTemp);
					
				}
				if (vecT.contains("Organisation"))
				{
					vecOrg = new ArrayList();
					strTemp =correctNull(rs.getString("prd_org_scode"));
					StringTokenizer sto= new StringTokenizer(strTemp,";");
					while (sto.hasMoreTokens())
					{
						vecOrg.add(sto.nextToken());
					}
					if (vecOrg.size() > 0)
					{
					
						strQuery =			SQLParser.getSqlQuery("selectorgname^"+vecOrg.get(0));	
						
						rs1 = DBUtils.executeQuery(strQuery);
				
						while(rs1.next())
						{
							strTemp = correctNull(rs1.getString("org_name"));	
						}
						rs1.close();
						vecRecords.add(strTemp);
						vecVal.add(vecRecords);				
						if (vecOrg.size() > 1)
						{
							for (int i=1;i<vecOrg.size();i++)
							{
								strQuery =			SQLParser.getSqlQuery("selectorgname^"+vecOrg.get(i));	
								
								rs2 = DBUtils.executeQuery(strQuery);
								while (rs1.next())
								{
									strTemp = correctNull(rs2.getString("org_name"));	
								}
								rs2.close();
								
								vecName = new ArrayList();
								for (int j=0;j<vecRecords.size()-1;j++ )
								{
									vecName.add("&nbsp;");
								}
								
								vecName.add(strTemp);
								vecVal.add(vecName);	
							}
							
						}
						
					}
					
				}
				else
				{
					vecVal.add(vecRecords);
				}
			}
			hshRec.put("vecValues",vecVal);
			hshRec.put("labels",strSelFields);
			hshRec.put("txtDate",strDate);
			hshRec.put("genby",strGen);
		}
		catch(Exception e)
		{
			throw new EJBException("inside getdata"+e.toString());
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
				if(rs2 != null)
				{
					rs2.close();
				}
				
			}
			catch(Exception e)
			{
				throw new EJBException("close"+e.toString()); 
			}
		}
		return hshRec;
	}

	private String getValue(String strQuery) 
	{		
		ResultSet rs = null;
		String strValue = null;
		
		try
		{			
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				strValue = correctNull(rs.getString(1));			
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in help "+ce.toString());
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
		return strValue;
	}

	private HashMap showProfile(HashMap hshPar) 
	{		
		ResultSet rs = null;
		String strQuery = null;
		HashMap hshRecord = new HashMap();
		HashMap hshTemp = new HashMap();
		ArrayList vecLabel = new ArrayList();
		ArrayList vecValue = new ArrayList();
		String strTemp=null;
		String strParam = null;
		String strProdCode = null;
		String strProdCat  = null;
		String hidOpFields = null;
		String hidSelFields = null;
		String strProfileName = null;

		try
		{					
			hshTemp=(HashMap)EJBInvoker.executeStateLess("repData",hshPar,"getParameter");
			strParam = (String)hshTemp.get("param");
			strProfileName =(String)hshTemp.get("profilename");
			StringTokenizer st = new StringTokenizer(strParam,";");
			
			strProdCode = st.nextToken();
			strProdCat =  st.nextToken();
			hidOpFields = st.nextToken();
			strTemp = st.nextToken();
	 		hidSelFields = st.nextToken();
			
			vecLabel.add("Profile Name");
			vecLabel.add("Product Type");
			vecLabel.add("Category");
			vecLabel.add("Product Names");
			vecLabel.add("Output Fields");

			if (strProdCode.equalsIgnoreCase("p"))
			{
				strProdCode = "Personal";
			}
			else if (strProdCode.equalsIgnoreCase("ct"))
			{
				strProdCode = "Comm/Term Loan";
			}
			else if (strProdCode.equalsIgnoreCase("cw"))
			{
				strProdCode = "Comm/Working Capital";
			}
			else if (strProdCode.equalsIgnoreCase("o"))
			{
				strProdCode = "Others";
			}
			
			strQuery = SQLParser.getSqlQuery("selectcatname^"+strProdCat);
			rs = DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				strProdCat = correctNull(rs.getString("cat_name"));			
			}
			vecValue.add(strProfileName);						
			vecValue.add(strProdCode);
			vecValue.add(strProdCat);
			strQuery = SQLParser.getSqlQuery("selectcatname^"+hidOpFields);
			rs = DBUtils.executeQuery(strQuery);
			hidOpFields="";
			while(rs.next())
			{
				hidOpFields += correctNull(rs.getString("cat_name"))+",";			
			}
			hidOpFields = hidOpFields.substring(0,hidOpFields.length()-1);
			
			vecValue.add(hidOpFields);
			vecValue.add(hidSelFields);
			
			hshRecord.put("vecLabel",vecLabel);
			hshRecord.put("vecValue",vecValue);
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in help "+ce.toString());
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

	private HashMap getParamList(HashMap hshPar) 
	{
		HashMap hshRecord = new HashMap();
		HashMap hshTemp = new HashMap();
		String strTemp=null;
		String strParam = null;
		String strPrdCode = null;
		String strPrdCat  = null;
		String hidOpFields = null;
		String hidSelFields = null;
		String strDate =null;
		String strGen =null;

		try
		{
						
			hshTemp=(HashMap)EJBInvoker.executeStateLess("repData",hshPar,"getParameter");
			strGen =(String)hshTemp.get("genby");
			strDate =(String)hshTemp.get("txtDate");
			strParam =(String)hshTemp.get("param");
			StringTokenizer st = new StringTokenizer(strParam,";");
			
			strPrdCode = st.nextToken();
			strTemp= st.nextToken();
			strPrdCat = st.nextToken();
			hidOpFields = st.nextToken();
			hidSelFields =st.nextToken();
			
			hshRecord.put("hidPrdCode",strPrdCode);
			hshRecord.put("hidCatFields",strPrdCat);
			hshRecord.put("hidSelFields",hidSelFields);
			hshRecord.put("hidOpFields",hidOpFields);
			hshRecord.put("strUserId",strGen);
			hshRecord.put("txtDate",strDate);
			
			hshPar = new HashMap();
			hshPar =(HashMap)getRepDetails(hshRecord);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in help "+ce.toString());
		}
		
		return hshPar;
	}
}