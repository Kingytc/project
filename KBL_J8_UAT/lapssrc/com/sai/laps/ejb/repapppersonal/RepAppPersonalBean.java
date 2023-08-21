package com.sai.laps.ejb.repapppersonal;

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
import com.sai.laps.helper.SQLParser;

@Stateless(name = "RepAppPersonalBean", mappedName = "RepAppPersonalHome")
@Remote (RepAppPersonalRemote.class)
public class RepAppPersonalBean extends BeanAdapter
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -795065579321945842L;
	static Logger log=Logger.getLogger(RepAppPersonalBean.class);

	/**
	 * 
	 */
	


	public HashMap getData(HashMap hshValues) 
	{
		HashMap hshRecord = new HashMap();
		String strMethod ="";

		try
		{
			strMethod=(String)hshValues.get("hidMethod");

			if (strMethod.equalsIgnoreCase("getProducts"))
			{
				hshRecord =(HashMap)getProducts(hshValues);
			} 
			else if (strMethod.equalsIgnoreCase("getOrgNames"))
			{
				hshRecord =(HashMap)getOrgNames(hshValues);
			} 
			else if (strMethod.equalsIgnoreCase("getAllUsableProducts"))
			{
				hshRecord =(HashMap)getAllUsableProducts(hshValues);
			} 
			else if (strMethod.equalsIgnoreCase("getAllProductsDesc"))
			{
				hshRecord =(HashMap)getAllProductsDesc(hshValues);
			} 
			else if (strMethod.equalsIgnoreCase("getStateCityNames"))
			{
				hshRecord =(HashMap)getStateCityNames(hshValues);
			} 
			
			
			
		
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getdata "+ce.toString());
		}
		
		return hshRecord;

	}

	
	
	
	
	private HashMap getOrgNames(HashMap hshValues) 
	{
	
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecBnkCode = new ArrayList();
		ArrayList vecBnkName = new ArrayList();
		String strGrpRights = null;
		String strChild = null;
		String strOther = null;
		String strBnkLevel  = null;
		String strOrgCode=null;
		String strOrgLevel=null;
		String strTemp=null;
		String strSolid="";
		boolean bState=false;

		try
		{
			strOrgLevel =(String)hshValues.get("strOrgLevel");
			strBnkLevel=correctNull((String)hshValues.get("bnklevel"));
			strGrpRights=(String)hshValues.get("strGroupRights");
			strOrgCode =(String)hshValues.get("strOrgCode");
			strSolid =(String)hshValues.get("strSolid");
			
			/*if (strGrpRights.substring(0,1).equals("0"))
			{
				vecBnkCode.add("nil");
				vecBnkName.add("nil");
			}
			else
			{*/
				//strChild = strGrpRights.substring(18,19);
				//strOther = strGrpRights.substring(19,20);
				/*if (strChild.equals("x") && strOther.equals("x"))
				{
					// To select current organization
					strQuery = SQLParser.getSqlQuery("selorgcurnames^"+strOrgCode+"^"+strBnkLevel);
				}
				else if (!strChild.equals("x") && !strOther.equals("x"))
				{
					// To select all organization
					strQuery = SQLParser.getSqlQuery("selallorgnames^"+strBnkLevel);
				}
				else if (!strChild.equals("x") && strOther.equals("x"))
				{
					//To Select only Child organization
					strOrgCode =getOrgCode(strOrgLevel,strOrgCode);
					strQuery = SQLParser.getSqlQuery("selorgchildnames^"+strOrgCode+"^"+strBnkLevel);
					
				}
				else if (!strOther.equals("x") && strChild.equals("x"))
				{
					//To Select  other organization
					strOrgCode =getOrgCode(strOrgLevel,strOrgCode);
					strOrgCode =strOrgCode +"001";
					strQuery = SQLParser.getSqlQuery("selorgothernames^"+strOrgCode+"^"+strBnkLevel);
					
				}*/
				
				
				if(strBnkLevel.equalsIgnoreCase(""))
				{
					strBnkLevel=" ";
				}
				String level1=correctNull((String)hshValues.get("strOrgLevel"));
				String orgcode1= correctNull((String)hshValues.get("strOrgCode"));
				String strAppend=" ";
				if (level1.equals("C"))
				{
					orgcode1=orgcode1.substring(0,3)+"%%%%%%%%%%%";
				}
				else if(level1.equals("R"))
				{
					orgcode1=orgcode1.substring(0,6)+"%%%%%%%%";
				}
				else if(level1.equals("D"))
				{
					orgcode1=orgcode1.substring(0,9)+"%%%%%%";
				}
				else if(level1.equals("A"))
				{
					orgcode1=orgcode1.substring(0,12)+"%%%%%";
				}
				else if(level1.equals("B"))
				{
					orgcode1=orgcode1.substring(0,15);
				}
				
				if(strBnkLevel.equalsIgnoreCase("CPC"))
				{
					orgcode1="001001000000000";
				}
				
				if(strBnkLevel.equalsIgnoreCase("C"))
				{
					strAppend=" ";
				}
				else if(strBnkLevel.equalsIgnoreCase("R"))
				{
					strAppend="and org_code  in (select RPAD(SUBSTR(org_code,0,6),15,0) from organisations where org_level ='A')";
				}
				else if(strBnkLevel.equalsIgnoreCase("D"))
				{
					strAppend="and org_code  in (select RPAD(SUBSTR(org_code,0,9),15,0) from organisations where org_level ='A')";
				}
				else if(strBnkLevel.equalsIgnoreCase("A"))
				{
					strAppend=" ";
				}
				else if(strBnkLevel.equalsIgnoreCase("CPC"))
				{
					strAppend="and org_code not in (select RPAD(SUBSTR(org_code,0,6),15,0) from organisations where org_level ='A')";
					strBnkLevel="R";
				}
				
				
				strQuery = SQLParser.getSqlQuery("selorgchildnames^"+orgcode1+"^"+strBnkLevel+"^"+strAppend);
			/*}*/
			
			if(rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			bState = rs.next();
			if (bState)
			{
				rs.beforeFirst();
				while(rs.next())
				{
					strTemp = rs.getString("org_level")+"-"+rs.getString("org_code");
					vecBnkCode.add(strTemp);
					vecBnkName.add(rs.getString("org_name"));
				}
			}
			else
			{
				if(strSolid.equalsIgnoreCase("223"))
				{
					strTemp = "C-001000000000000";
					vecBnkCode.add(strTemp);
					vecBnkName.add("HEAD OFFICE");
				}
//				else{
//				vecBnkCode.add("nil");
//				vecBnkName.add("nil");
//				}
		}
			hshRecord.put("vecCodes",vecBnkCode);
			hshRecord.put("vecValues",vecBnkName);
			
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
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


	private String getOrgCode(String strBankLevel,String strBankCode) 
	{
		if (strBankLevel.equalsIgnoreCase("C"))
		{
			strBankCode = strBankCode.substring(0,3);
		}
		else if (strBankLevel.equalsIgnoreCase("R"))
		{
			strBankCode = strBankCode.substring(0,6);
		}
		else if (strBankLevel.equalsIgnoreCase("D"))
		{
			strBankCode = strBankCode.substring(0,9);
		}
		else if (strBankLevel.equalsIgnoreCase("A"))
		{
			strBankCode = strBankCode.substring(0,12);
		}
		else if (strBankLevel.equalsIgnoreCase("B"))
		{
			strBankCode = strBankCode.substring(0,15);
		}

		return strBankCode;
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
		String strPrdid=null;
		String strLoanType=null;
		String strOrgCode =null;

		try
		{
			strProd = correctNull((String)hshPar.get("hidProducts"));
			strOrgCode = correctNull((String)hshPar.get("hidOrgCode"));
			strLoanType =correctNull((String)hshPar.get("hidLoanType"));
			strProdType=correctNull((String)hshPar.get("prodtype"));
			strPrdid=correctNull((String)hshPar.get("prodid"));

			if (strProd.equalsIgnoreCase("subprod"))
			{				
				strQuery = SQLParser.getSqlQuery("subproductcat^"+Integer.parseInt(strProdType));
			}
			else if (strProd.equalsIgnoreCase("prod"))
			{
				strQuery = SQLParser.getSqlQuery("productcat^"+strProdType);
			}
			else if (strProd.equalsIgnoreCase("allprod"))
			{
				strQuery = SQLParser.getSqlQuery("selallprod^"+strProdType+"^"+Integer.parseInt(strPrdid)+"^"+strLoanType+"^"+strOrgCode);
			}
			else if (strProd.equalsIgnoreCase("soarprod"))
			{
				strQuery = SQLParser.getSqlQuery("selsoarprod^"+strProdType+"^"+Integer.parseInt(strPrdid)+"^"+strLoanType+"^"+strOrgCode);
			}
			
			rs = DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				 vecProdCode.add(correctNull(rs.getString(1)));
				 vecProdName.add(correctNull(rs.getString(2)));	
			}
						
			hshRecord.put("hidProducts",strProd);						
			hshRecord.put("vecCodes",vecProdCode);
			hshRecord.put("vecValues",vecProdName);
			
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
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


	private HashMap getAllUsableProducts(HashMap hshPar) 
	{
		
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecProdCode = new ArrayList();
 		ArrayList vecProdName = new ArrayList();		
		String strProd = null;
		String strPrdid=null;
		String strOrgCode =null;
		String strQry="";
		String strShortCode="";
		try
		{
			
			strProd = correctNull((String)hshPar.get("hidProducts"));
			strOrgCode = correctNull((String)hshPar.get("hidOrgCode"));
			strPrdid=correctNull((String)hshPar.get("prodid"));

			strQry=SQLParser.getSqlQuery("selorgsortcode^"+ strOrgCode);
			rs=DBUtils.executeQuery(strQry);
			while(rs.next())
			{
				strShortCode= rs.getString(1);
				if(!strShortCode.equals(""))
				{
					if(rs1 != null)
						rs1.close();

					strQry=SQLParser.getSqlQuery("selallusableprdlist^" + strShortCode+"^"+strPrdid);
					rs1=DBUtils.executeQuery(strQry);
					while(rs1.next() )
					{
						vecProdName.add(correctNull((String)rs1.getString("prd_desc")));
						vecProdCode.add(correctNull((String)rs1.getString("prd_code")));
					}
				}					
			}
			hshRecord.put("hidProducts",strProd);						
			hshRecord.put("vecCodes",vecProdCode);
			hshRecord.put("vecValues",vecProdName);
			
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
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
		return hshRecord;
	}
	
	
	private HashMap getAllProductsDesc(HashMap hshPar) 
	{
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecProdCode = new ArrayList();
 		ArrayList vecProdName = new ArrayList();		
		String strProd = null; 	
		String strPrdType=null;
		String strOrgCode =null;
		String strQry="";
		String strShortCode="";
		try
		{
			
			strProd = correctNull((String)hshPar.get("hidProducts"));
			strOrgCode = correctNull((String)hshPar.get("hidOrgCode"));
			strPrdType=correctNull((String)hshPar.get("prodtype"));

			strQry=SQLParser.getSqlQuery("selorgsortcode^"+ strOrgCode);
			rs=DBUtils.executeQuery(strQry);
			while(rs.next())
			{
				strShortCode= rs.getString(1);
				if(!strShortCode.equals(""))
				{
					if(rs1 != null)
						rs1.close();

					strQry=SQLParser.getSqlQuery("selallusableprdDesc^" + strShortCode+"^"+strPrdType);
					rs1=DBUtils.executeQuery(strQry);
					while(rs1.next() )
					{
						vecProdName.add(correctNull((String)rs1.getString("cat_name"))+" "+correctNull(rs1.getString("prd_desc")));
						vecProdCode.add(correctNull((String)rs1.getString("prd_code")));
					}
				}					
			}
			hshRecord.put("hidProducts",strProd);						
			hshRecord.put("vecCodes",vecProdCode);
			hshRecord.put("vecValues",vecProdName);
			
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
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
		return hshRecord;
	}
	
	
	private HashMap getStateCityNames(HashMap hshValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecName = new ArrayList();
 		ArrayList vecCode = new ArrayList();		
		String strStateName = null; 	
		String strQry="";
		
		try
		{
			if(correctNull((String)hshValues.get("hidval")).equalsIgnoreCase("B"))
			{
				if(correctNull((String)hshValues.get("hidOption_name")).equalsIgnoreCase("State"))
				{
					strQry=SQLParser.getSqlQuery("sel_lapsstate");
					rs=DBUtils.executeQuery(strQry);
					while(rs.next())
					{
						vecName.add(correctNull((String)rs.getString("state_name")));
						vecCode.add(correctNull((String)rs.getString("state_code")));
					}
				}
				else if(correctNull((String)hshValues.get("hidOption_name")).equalsIgnoreCase("City"))
				{
					strQry=SQLParser.getSqlQuery("sel_lapscity");
					rs=DBUtils.executeQuery(strQry);
					while(rs.next())
					{
						vecName.add(correctNull((String)rs.getString("city_name")));
						vecCode.add(correctNull((String)rs.getString("city_code")));
					}
				}
			}
			else
			{
				strStateName = correctNull((String)hshValues.get("hidstate_name"));
				strQry=SQLParser.getSqlQuery("getCityDetails^"+ strStateName);
				rs=DBUtils.executeQuery(strQry);
				while(rs.next())
				{
					vecName.add(correctNull((String)rs.getString("city_name")));
					vecCode.add(correctNull((String)rs.getString("city_code")));
				}
			}
			hshRecord.put("hidStateName",strStateName);						
			hshRecord.put("vecName",vecName);
			hshRecord.put("vecCode",vecCode);
			
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getStateCityNames "+ce.toString());
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
}