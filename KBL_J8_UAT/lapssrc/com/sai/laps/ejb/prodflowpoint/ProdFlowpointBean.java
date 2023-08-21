package com.sai.laps.ejb.prodflowpoint;

import java.sql.ResultSet;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "ProdFlowpointBean", mappedName = "ProdFlowpointHome")
@Remote (ProdFlowpointRemote.class)
public class ProdFlowpointBean extends BeanAdapter
{
	static Logger log=Logger.getLogger(ProdFlowpointBean.class);
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
				hshRecord =(HashMap)getProducts(hshValues);
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
			log.error(ce.toString());
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
			log.error(ce.toString());
			throw new EJBException("Error in help "+ce.toString());
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
	
	private HashMap getRepDetails(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		HashMap hshRec = null;
		HashMap hshVal=null;
		ArrayList vecVal =null;
		String strQuery=null;
		String strPrdCode = null;
		String strOpFields = null;
		String strSelFields=null;
		String strCatFields=null;
		String strTemp=null;
		ArrayList vecT = new ArrayList();
		String strProdDesc = "";
		String strDate=null;
		String strGen=null;
			
		try
		{
			strGen =(String)hshRequestValues.get("strUserId");
			strDate =(String)hshRequestValues.get("txtDate");
			strPrdCode =(String)hshRequestValues.get("hidPrdCode");
			strCatFields =(String)hshRequestValues.get("hidCatFields");
			strSelFields =(String)hshRequestValues.get("hidSelFields");
			strOpFields =(String)hshRequestValues.get("hidOpFields");
			StringTokenizer st = new StringTokenizer(strOpFields,",");
			while (st.hasMoreTokens())
			{
				vecT.add(st.nextToken());
			}
			strQuery = SQLParser.getSqlQuery("repprodflowdet^"+strOpFields+"^"+strPrdCode+"^"+strCatFields);
					
			rs = DBUtils.executeQuery(strQuery);
			
			hshVal = new HashMap();
			vecVal = new ArrayList();
			while (rs.next())
			{
				hshRec = new HashMap();
				
				if (vecT.contains("prd_desc"))
				{
					strTemp =correctNull(rs.getString("prd_desc"));
					if (strTemp.equals(strProdDesc))
					{
						hshRec.put("prd_desc","&nbsp;");
					}
					else
					{
						hshRec.put("prd_desc",strTemp);
					}
					
				}
				if (vecT.contains("prd_rng_from"))
				{
					if (strTemp.equals(strProdDesc))
					{
						hshRec.put("prd_rng_from","&nbsp;");
					}
					else
					{
						hshRec.put("prd_rng_from",correctNull(
												rs.getString("prd_rng_from")));
					}
				}
				if (vecT.contains("prd_rng_to"))
				{
					if (strTemp.equals(strProdDesc))
					{
						hshRec.put("prd_rng_to","&nbsp;");
					}
					else
					{
						hshRec.put("prd_rng_to",correctNull(
												rs.getString("prd_rng_to")));
					}
				}
				strProdDesc = strTemp;
				if (vecT.contains("prd_flowpoint"))
				{
					strTemp =correctNull(rs.getString("prd_flowpoint"));
					hshRec.put("prd_flowpoint",strTemp);
					
				}
				if (vecT.contains("prd_maxclass"))
				{
					strTemp =correctNull(rs.getString("prd_maxclass"));
					hshRec.put("prd_maxclass",strTemp);
					
				}
				if (vecT.contains("wrk_flowname"))
				{
					strTemp =correctNull(rs.getString("wrk_flowname"));
					hshRec.put("wrk_flowname",strTemp);
					
				}
				if (vecT.contains("wrk_flowtype"))
				{
					strTemp =correctNull(rs.getString("wrk_flowtype"));
					if (strTemp.equalsIgnoreCase("p"))
					{
						strTemp ="InProcess";
					}
					else if (strTemp.equalsIgnoreCase("a"))
					{
						strTemp ="Post Approval";
					}
					else if (strTemp.equalsIgnoreCase("r"))
					{
						strTemp = "Post Rejection";
					}
					
					hshRec.put("wrk_flowtype",strTemp);
				}
				if (vecT.contains("prd_duration"))
				{
					strTemp =correctNull(rs.getString("prd_duration"));
					hshRec.put("prd_duration",strTemp);
				}
				
				vecVal.add(hshRec);
			}
			hshVal.put("vecValues",vecVal);
			hshVal.put("labels",strSelFields);
			hshVal.put("txtDate",strDate);
			hshVal.put("genby",strGen);
		}
		catch(Exception e)
		{
			log.error("error in getData method.."+e .toString());
			throw new EJBException("inside getdata"+e.toString());
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
			catch(Exception e)
			{
				throw new EJBException("close"+e.toString()); 
			}
		}
		return hshVal;
	}

	
	private HashMap showProfile(HashMap hshPar) 
	{
		ResultSet rs = null;
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
			
			rs=DBUtils.executeLAPSQuery("selectcatname^"+strProdCat);
			while(rs.next())
			{
				strProdCat = correctNull(rs.getString("cat_name"));			
			}
			vecValue.add(strProfileName);						
			vecValue.add(strProdCode);
			vecValue.add(strProdCat);
			rs=DBUtils.executeLAPSQuery("selectcatname^"+hidOpFields);
			while(rs.next())
			{
				hidOpFields = correctNull(rs.getString("cat_name"));			
			}
			vecValue.add(hidOpFields);
			vecValue.add(hidSelFields);
			
			hshRecord.put("vecLabel",vecLabel);
			hshRecord.put("vecValue",vecValue);
		
			
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
			hshRecord.put("txtDate",strDate);
			hshRecord.put("strUserId",strGen);
			
			hshPar = new HashMap();
			hshPar =(HashMap)getRepDetails(hshRecord);
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in help "+ce.toString());
		}
		
		return hshPar;
	}
}