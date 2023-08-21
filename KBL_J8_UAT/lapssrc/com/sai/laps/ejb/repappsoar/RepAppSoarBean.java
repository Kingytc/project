/******************************************************************************
 * Package:			com.sai.laps.ejb.repappsoar
 * File:			RepAppSoarBean.java
 * Description:		Bean Implementation Class for SOAR Report
 * @author			R.Saraswathi 
 ******************************************************************************/

package com.sai.laps.ejb.repappsoar;


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
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
@Stateless(name = "RepAppSoarBean", mappedName = "RepAppSoarHome")
@Remote (RepAppSoarRemote.class)
public class RepAppSoarBean extends BeanAdapter
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -3100031353466320785L;
	static Logger log=Logger.getLogger(RepAppSoarBean.class);
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

			if (strMethod.equalsIgnoreCase("getRepDetails"))
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

	private HashMap getRepDetails(HashMap hshRequestValues) 
	{
		
		ResultSet rs = null;
		ArrayList vecRecords=null;
		ArrayList vecVal =new ArrayList();
		String strQuery=null;
		String strOrgCode = null;
		String strid=null;
		String strTemp="";
		String strToDate=null;
		String strDate=null;
		String strFromDate=null;
		//String strLoanType = null;
		//String strPrdType = null;
		int grandtot=0;
		int grandtot1=0;
		int grandtot2=0;
		int grandtot3=0;
		int grandtot4=0;
		ArrayList vecid=new ArrayList();
		String strQ=" ";
		HashMap hshRec = new HashMap();
		int count=0;
		String strOrg =null;
		String strGen=null;
		String strSaveDate=null;	
		String strProdcat=null;
		String strProdType=null;
		String strOrglevel=null,strOrgName=null;
		
		StringBuffer strbufOrgcode=new StringBuffer();
		
		
		try
		{
			
			
			strSaveDate =(String)hshRequestValues.get("txtSaveDate");
			strGen =(String)hshRequestValues.get("strUserId");
			
			strOrgCode =(String)hshRequestValues.get("hidOrgCode");
			strid =(String)hshRequestValues.get("hidCatFields");
			//strPrdType =(String)hshRequestValues.get("hidPrdCode");
			//strLoanType =(String)hshRequestValues.get("hidLoanType");
			strDate =(String)hshRequestValues.get("txtDate");
			strOrglevel=correctNull((String)hshRequestValues.get("orglevel"));
			strProdcat=correctNull((String)hshRequestValues.get("hidprodcat_text"));
			strProdType=correctNull((String)hshRequestValues.get("prodttype"));
			strOrgName=correctNull((String)hshRequestValues.get("hidOrgName"));
			
			rs=DBUtils.executeLAPSQuery("selusername^"+strGen);
			
			while (rs.next())
			{
				strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2));
			}
			
			strOrgCode=strOrgCode.replaceAll("'","");
			if(strOrglevel.equalsIgnoreCase("C"))
			{
				strbufOrgcode.append("app_orgcode like '001%'");
			}
			else if(strOrglevel.equalsIgnoreCase("R"))
			{
				strbufOrgcode.append("app_orgcode like '").append(strOrgCode.substring(0,6)).append("%'");
			}
			else if(strOrglevel.equalsIgnoreCase("CPC"))
			{
				strbufOrgcode.append("org_code like '").append(strOrgCode.substring(0,6)).append("%'");
			}
			else if(strOrglevel.equalsIgnoreCase("D"))
			{
				strbufOrgcode.append("app_orgcode like '").append(strOrgCode.substring(0,9)).append("%'");
			}
			else if(strOrglevel.equalsIgnoreCase("A"))
			{
				strbufOrgcode.append("app_orgcode like '").append(strOrgCode.substring(0,12)).append("%'");
			}
			else if(strOrglevel.equalsIgnoreCase("B"))
			{
				strbufOrgcode.append("app_orgcode = '").append(strOrgCode).append("'");
			}
			
			if(strOrglevel.equalsIgnoreCase("CPC"))
				strQuery =  SQLParser.getSqlQuery("selcountprd_cpc^"+strbufOrgcode.toString()+"^"+strid);
			else
				strQuery =  SQLParser.getSqlQuery("selcountprd^"+strbufOrgcode.toString()+"^"+strid);
				
			if(!strDate.equals("All"))
			{
				strFromDate = strDate.substring(0,strDate.indexOf("-"));
				strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				//strQ =SQLParser.getSqlQuery("seldatewise^"+strFromDate+"^"+strToDate);
				strQ=" and TO_DATE(to_char(app_createdate,'DD/MM/YYYY'),'DD/MM/YYYY') between TO_DATE('"+strFromDate +"','DD/MM/YYYY') and TO_DATE('"+strToDate +"','DD/MM/YYYY')";
				
				strQuery = strQuery + strQ;
			}
			if(rs != null)
				rs.close();
			
			rs=DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				count = rs.getInt(1);
			}
			if (count > 0)
			{
			
				StringTokenizer st = new StringTokenizer(strid,",");
				while (st.hasMoreTokens())
				{
					vecid.add(st.nextToken());
				}
				if (vecid.size() > 0)
				{
					for (int j=0;j<vecid.size();j++)
					{

						vecRecords = new ArrayList();
						strid=(String)vecid.get(j);
						
						if(strOrglevel.equalsIgnoreCase("CPC"))
							strQuery =  SQLParser.getSqlQuery("selsoarcat_cpc^"+strbufOrgcode.toString()+"^"+strid);	
						else
						strQuery =  SQLParser.getSqlQuery("selsoarcat^"+strbufOrgcode.toString()+"^"+strid);
					
						if(!strDate.equals("All"))
						{
							strFromDate = strDate.substring(0,strDate.indexOf("-"));
							strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
							//strQ =SQLParser.getSqlQuery("seldatewise^"+strFromDate+"^"+strToDate);
							
							strQ=" and TO_DATE(to_char(app_createdate,'DD/MM/YYYY'),'DD/MM/YYYY') between TO_DATE('"+strFromDate +"','DD/MM/YYYY') and TO_DATE('"+strToDate +"','DD/MM/YYYY')";
							strQuery = strQuery + strQ;
						}
						if(rs != null)
							rs.close();
					
						rs=DBUtils.executeQuery(strQuery);
						while (rs.next())
						{
							strTemp =correctNull(rs.getString(1));
							vecRecords.add(strTemp);
							strTemp =correctNull(rs.getString(2));
							vecRecords.add(strTemp);
							strTemp =correctNull(rs.getString(3));
							vecRecords.add(strTemp);
							strTemp =correctNull(rs.getString(4));
							vecRecords.add(strTemp);
							strTemp =correctNull(rs.getString(5));
							vecRecords.add(strTemp);
							strTemp =correctNull(rs.getString(6));
							vecRecords.add(strTemp);
							strTemp =correctNull(rs.getString(7));
							strOrg =strTemp;
							vecRecords.add(strTemp);
						}
						if(vecRecords.size()==0)
						{
							strQuery =  SQLParser.getSqlQuery("sel_maxterms^"+strid);
							rs=DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								vecRecords.add("");
								vecRecords.add(Helper.correctNull((String)rs.getString("prd_desc")));
								vecRecords.add("");
								vecRecords.add("");
								vecRecords.add("");
								vecRecords.add("");
								vecRecords.add("");
							}
						}
						// to get count of all loans
						if(strOrglevel.equalsIgnoreCase("CPC"))
							strQuery =SQLParser.getSqlQuery("selapploans_cpc^"+strbufOrgcode.toString()+"^"+strid);	
						else
						strQuery =SQLParser.getSqlQuery("selallloans^"+strbufOrgcode.toString()+"^"+strid);	
						
						if(!strDate.equals("All"))
						{
							strQuery = strQuery + strQ;
						}
						if(rs != null)
							rs.close();
						
						rs=DBUtils.executeQuery(strQuery);
						
						if (rs.next())
						{
							strTemp =correctNull(rs.getString(1));
							vecRecords.add(strTemp);
							
							grandtot=grandtot+rs.getInt(1);
							
						}
						else
						{
							vecRecords.add("0");
						}

						// to get all approved loans
						if(strOrglevel.equalsIgnoreCase("CPC"))
							strQuery =SQLParser.getSqlQuery("selapploans_cpc^"+strbufOrgcode.toString()+"^"+strid);
						else
						strQuery =SQLParser.getSqlQuery("selapploans^"+strbufOrgcode.toString()+"^"+strid);	
						
						if(!strDate.equals("All"))
						{
							strQuery = strQuery + strQ;
						}
						if(rs != null)
							rs.close();
						
						rs=DBUtils.executeQuery(strQuery);
						if (rs.next())
						{
							strTemp =correctNull(rs.getString(1));
							vecRecords.add(strTemp);
							
							grandtot1=grandtot1+rs.getInt(1);
							
						}
						else
						{
							vecRecords.add("0");
						}


						// to get all rejected loans
						if(strOrglevel.equalsIgnoreCase("CPC"))
							strQuery =SQLParser.getSqlQuery("selrejloans_cpc^"+strbufOrgcode.toString()+"^"+strid);	
						else
						strQuery =SQLParser.getSqlQuery("selrejloans^"+strbufOrgcode.toString()+"^"+strid);	
						
						if(!strDate.equals("All"))
						{
							strQuery = strQuery + strQ;
						}
						if(rs != null)
							rs.close();
						
						rs=DBUtils.executeQuery(strQuery);
						if (rs.next())
						{
							strTemp =correctNull(rs.getString(1));
							vecRecords.add(strTemp);
							grandtot2=grandtot2+rs.getInt(1);
							
						}
						else
						{
							vecRecords.add("0");
						}


						// to get all pending loans
						if(strOrglevel.equalsIgnoreCase("CPC"))
							strQuery =SQLParser.getSqlQuery("selprocloans_cpc^"+strbufOrgcode.toString()+"^"+strid);	
						else
						strQuery =SQLParser.getSqlQuery("selprocloans^"+strbufOrgcode.toString()+"^"+strid);	
						
						if(!strDate.equals("All"))
						{
							strQuery = strQuery + strQ;
						}
						if(rs != null)
							rs.close();
						
						rs=DBUtils.executeQuery(strQuery);
						if (rs.next())
						{
							strTemp =correctNull(rs.getString(1));
							vecRecords.add(strTemp);
							
							grandtot3=grandtot3+rs.getInt(1);
						}
						else
						{
							vecRecords.add("0");
						}
						
						// to get all Lodged loans
						if(strOrglevel.equalsIgnoreCase("CPC"))
							strQuery =SQLParser.getSqlQuery("sel_ol_loans_cpc^"+strbufOrgcode.toString()+"^"+strid);	
						else
						strQuery =SQLParser.getSqlQuery("sel_ol_loans^"+strbufOrgcode.toString()+"^"+strid);	
						
						if(!strDate.equals("All"))
						{
							strQuery = strQuery + strQ;
						}
						if(rs != null)
							rs.close();
						
						rs=DBUtils.executeQuery(strQuery);
						if (rs.next())
						{
							strTemp =correctNull(rs.getString(1));
							vecRecords.add(strTemp);
							
							grandtot4=grandtot4+rs.getInt(1);
						}
						else
						{
							vecRecords.add("0");
						}
						
						vecVal.add(vecRecords);		
						if(rs != null)
							rs.close();
					}//for
				}
			}
			hshRec.put("vecValues",vecVal);
			hshRec.put("grandtot",String.valueOf(grandtot));
			hshRec.put("grandtot1",String.valueOf(grandtot1));
			hshRec.put("grandtot2",String.valueOf(grandtot2));
			hshRec.put("grandtot3",String.valueOf(grandtot3));
			hshRec.put("grandtot4",String.valueOf(grandtot4));
			hshRec.put("txtDate",strDate);
			hshRec.put("genby",strGen);
			hshRec.put("strProdcat",strProdcat);
			hshRec.put("strProdType",strProdType);
			hshRec.put("OrgName",strOrgName);
			/*if(strOrg!=null)
			{
			hshRec.put("OrgName",strOrg);
			}
			else
			{
				hshRec.put("OrgName","");
			}*/
			hshRec.put("txtSaveDate",strSaveDate);
		}
		catch(Exception e)
		{
			log.error("error in getData method.."+e.toString());
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
		return hshRec;
	}

	private HashMap showProfile(HashMap hshPar) 
	{
		ResultSet rs = null;
		String strQuery = null;
		HashMap hshRecord = new HashMap();
		HashMap hshTemp = new HashMap();
		ArrayList vecLabel = new ArrayList();
		ArrayList vecValue = new ArrayList();
		String strParam = null;
		String strPeriod=null;
		String strOrgLevel = null;
		String hidOrgCode = null;
		String hidOpFields = null;
		String hidSelFields = null;
		String hidCatFields = null;
		String hidLoanType = null;
		String strProfileName = null;
		String strPrdType =null;

		try
		{
						
			hshTemp=(HashMap)EJBInvoker.executeStateLess("repData",hshPar,"getParameter");
			strParam = (String)hshTemp.get("param");
			strProfileName =(String)hshTemp.get("profilename");
			StringTokenizer st = new StringTokenizer(strParam,";");
			strOrgLevel = st.nextToken();
			hidOrgCode = st.nextToken();
			hidCatFields = st.nextToken();
			strPeriod = st.nextToken();
			hidLoanType =st.nextToken();
			strPrdType =st.nextToken();
			hidOpFields =st.nextToken();
	 		hidSelFields = st.nextToken();
			vecLabel.add("Profile Name");
			vecLabel.add("Organisation Level");
			vecLabel.add("Organisation Names");
			vecLabel.add("Product Names");
			vecLabel.add("Peroid");
			vecLabel.add("Output Fields");

			vecValue.add(strProfileName);						
			vecValue.add(strOrgLevel);
			
			rs=DBUtils.executeLAPSQuery("repbanknames^"+hidOrgCode);
			hidOrgCode="";
			while(rs.next())
			{
				hidOrgCode += correctNull(rs.getString("org_name"))+",";		
			}
			hidOrgCode = hidOrgCode.substring(0,hidOrgCode.length()-1);
			vecValue.add(hidOrgCode);
			strQuery = SQLParser.getSqlQuery("selallproddet^"+strPrdType+"^"+hidCatFields);
			if(rs != null)
				rs.close();
			
			rs=DBUtils.executeQuery(strQuery);
			hidCatFields="";
			while(rs.next())
			{
				hidCatFields += correctNull(rs.getString("prd_desc"))+",";		
			}
			hidCatFields = hidCatFields.substring(0,hidCatFields.length()-1);
			vecValue.add(hidCatFields);
			vecValue.add(strPeriod);
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
		String strParam = null;
		String strOrgCode= null;
		String hidCatFields = null;
		String strPeriod=null;
		String strOrgLevel =null;
		String strLoanType=null;
		String strPrdType=null;
		String strSaveDate =null;
		String strGen =null;

		try
		{
						
			hshTemp=(HashMap)EJBInvoker.executeStateLess("repData",hshPar,"getParameter");
			strGen =(String)hshTemp.get("genby");
			strSaveDate =(String)hshTemp.get("txtDate");
			strParam =(String)hshTemp.get("param");
			StringTokenizer st = new StringTokenizer(strParam,";");
			
			strOrgLevel = st.nextToken();
			strOrgCode =  st.nextToken();
			hidCatFields =st.nextToken();
			strPeriod =  st.nextToken();
			strLoanType =st.nextToken();
			strPrdType =st.nextToken();

			hshRecord.put("hidOrgCode",strOrgCode);
			hshRecord.put("hidCatFields",hidCatFields);
			hshRecord.put("txtDate",strPeriod);
			hshRecord.put("hidLoanType",strLoanType);
			hshRecord.put("hidPrdCode",strPrdType);
			hshRecord.put("txtSaveDate",strSaveDate);
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