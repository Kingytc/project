package com.sai.laps.ejb.repappdove;


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

@Stateless(name = "RepAppDoveBean", mappedName = "RepAppDoveHome")
@Remote (RepAppDoveRemote.class)
public class RepAppDoveBean extends BeanAdapter
{
	static Logger log=Logger.getLogger(RepAppDoveBean.class);
	/**
	 * 
	 */
	private static final long serialVersionUID = 4221568874033185138L;

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
			else if (strMethod.equalsIgnoreCase("getUserDetails"))
			{
				hshRecord =(HashMap)getUserDetails(hshValues);
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
		ResultSet rs1 = null;
		ArrayList vecRecords=null;
		HashMap hshRec =null;
		ArrayList vecVal =null;
		String strQuery=null;
		String strOrgCode = null;
		String strSelFields=null;
		String strTemp=null;
		String strToDate=null;
		String strDate=null;
		String strFromDate=null;
		String strQ = " ";
		String strName="";
		String strLoanType=null;
		String strGen=null;
		String strSaveDate = null;
		String strTempCode="";
		String strAppno="";
		String strDocCode ="";
		int i=0;
			
		try
		{
			strSaveDate =(String)hshRequestValues.get("txtSaveDate");
			strGen =(String)hshRequestValues.get("strUserId");
			strOrgCode =(String)hshRequestValues.get("hidOrgCode");
			strSelFields =(String)hshRequestValues.get("hidSelFields");
			strLoanType =(String)hshRequestValues.get("loantype");
			strDate =(String)hshRequestValues.get("txtDate");
			rs=DBUtils.executeLAPSQuery("selusername^"+strGen);
			while (rs.next())
			{
				strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2));
			}
			
			if (strLoanType.equalsIgnoreCase("P"))
			{
			
				strQuery = SQLParser.getSqlQuery("seldovedetails^"+strOrgCode);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("seldovedetailscom^"+strOrgCode);
			}
			if(!strDate.equals("All"))
			{
				strFromDate = strDate.substring(0,strDate.indexOf("-"));
				strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				strQ =SQLParser.getSqlQuery("selappdate^"+strFromDate+"^"+strToDate);
				strQuery = strQuery + strQ;
			}
			rs=null;			
			rs=DBUtils.executeQuery(strQuery);
			hshRec = new HashMap();
			vecVal = new ArrayList();
			while (rs.next())
			{
				vecRecords = new ArrayList();
					strDocCode =correctNull(rs.getString("apdoc_doccode"));
					strTemp =correctNull(rs.getString("app_no"));
					strAppno=strTemp;
					if (strAppno.equals(strTempCode))
					{
						vecRecords.add("&nbsp;");
					}
					else
					{
						vecRecords.add(strTemp);
					}
					vecRecords.add("left");
				
				
					if (strLoanType.equalsIgnoreCase("P"))
					{
						strTemp =correctNull(rs.getString("perapp_fname"));
						strName =correctNull(rs.getString("perapp_lname"));
					}
					else
					{
						strTemp =correctNull(rs.getString("comapp_companyname"));
					}
					if (strAppno.equals(strTempCode))
					{
						vecRecords.add("&nbsp;");
					}
					else
					{
						vecRecords.add(strTemp);
					}
					vecRecords.add("left");
			
					strTemp =correctNull(rs.getString("category"));
					if (strAppno.equals(strTempCode))
					{
						vecRecords.add("&nbsp;");
					}
					else
					{
						vecRecords.add(strTemp);
					}
					vecRecords.add("left");
				
					strTemp =correctNull(rs.getString("subcategory"));
					if (strAppno.equals(strTempCode))
					{
						vecRecords.add("&nbsp;");
					}
					else
					{
						vecRecords.add(strTemp);
					}
					vecRecords.add("left");
				
					strTemp =correctNull(rs.getString("prd_desc"));
					if (strAppno.equals(strTempCode))
					{
						vecRecords.add("&nbsp;");
					}
					else
					{
						vecRecords.add(strTemp);
					}
					vecRecords.add("left");
				
					strTemp =correctNull(rs.getString("appdate"));
					if (strAppno.equals(strTempCode))
					{
						vecRecords.add("&nbsp;");
					}
					else
					{
						vecRecords.add(strTemp);
					}
					vecRecords.add("center");
				
					if (strAppno.equals(strTempCode))
					{
						vecRecords.add("&nbsp;");
					}
					else
					{
						vecRecords.add(correctNull(
												rs.getString("appamt")));
					}
					vecRecords.add("right");
				
				if (!strDocCode.trim().equals(""))
				{
					
					
						vecRecords.add(correctNull(
													rs.getString("doc_desc")));
						vecRecords.add("left");
					
						strTemp =correctNull(rs.getString("doc_type"));
						if (strTemp.equalsIgnoreCase("A"))
						{
							strTemp ="Applicant";
						}
						else
						{
							strTemp ="Internal";
						}
						vecRecords.add(strTemp);
						vecRecords.add("left");
					
						strTemp =correctNull(rs.getString("days"));
						vecRecords.add(strTemp);
						vecRecords.add("center");
					
					vecVal.add(vecRecords);
				}
				if (strDocCode.trim().equals(""))
				{
					
					i=0;
					
					if(rs1 != null)
						rs1.close();
					
					rs1=DBUtils.executeLAPSQuery("seldocdesc^"+strAppno);
					while (rs1.next())
					{
						if (i>0)
						{
							ArrayList vecDesc = new ArrayList();
							for(int j=0;j<7;j++)
							{
								vecDesc.add("&nbsp;");
								vecDesc.add("left");										
							}
							vecDesc.add(correctNull(
														rs1.getString(1)));
							vecDesc.add("left");
						
							strTemp =correctNull(rs1.getString(2));
							if (strTemp.equalsIgnoreCase("A"))
							{
								strTemp ="Applicant";
							}
							else
							{
								strTemp ="Internal";
							}
							vecDesc.add(strTemp);
							vecDesc.add("left");
						
							strTemp =correctNull(rs1.getString(3));
							vecDesc.add(strTemp);
							vecDesc.add("center");
							

							vecVal.add(vecDesc);
						}
						else
						{
							vecRecords.add(correctNull(
													rs1.getString(1)));
							vecRecords.add("left");
						
							strTemp =correctNull(rs1.getString(2));
							if (strTemp.equalsIgnoreCase("A"))
							{
								strTemp ="Applicant";
							}
							else
							{
								strTemp ="Internal";
							}
							vecRecords.add(strTemp);
							vecRecords.add("left");
						
							strTemp =correctNull(rs1.getString(3));
							vecRecords.add(strTemp);
							vecRecords.add("center");
						

							vecVal.add(vecRecords);
						}
						i++;
						
					}
					rs1.close();
				}
				strTempCode=strAppno;
			}
			hshRec.put("vecValues",vecVal);
			hshRec.put("txtDate",strDate);
			hshRec.put("labels",strSelFields);
			hshRec.put("genby",strGen);
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
				if(rs1 != null)
				{
					rs1.close();
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
		HashMap hshRecord = new HashMap();
		HashMap hshTemp = new HashMap();
		ArrayList vecLabel = new ArrayList();
		ArrayList vecValue = new ArrayList();
		String strParam = null;
		String strOrgCode = null;
		String strOrg=null;
		String strDate=null;
		String hidOpFields = null;
		String hidSelFields = null;
		String strProfileName = null;

		try
		{
					
			hshTemp=(HashMap)EJBInvoker.executeStateLess("repData",hshPar,"getParameter");
			strParam = (String)hshTemp.get("param");
			strProfileName =(String)hshTemp.get("profilename");
			StringTokenizer st = new StringTokenizer(strParam,";");
			
			strOrgCode = st.nextToken();
			strOrg	=  st.nextToken();
			strDate	=  st.nextToken();
			hidOpFields = st.nextToken();
	 		hidSelFields = st.nextToken();
			
			vecLabel.add("Profile Name");
			vecLabel.add("Organisation Level");
			vecLabel.add("Organisation Name");
			vecLabel.add("Period");
			vecLabel.add("Output Fields");

			
			rs=DBUtils.executeLAPSQuery("repbanknames^"+strOrg);
			strOrg="";
			while(rs.next())
			{
				strOrg += correctNull(rs.getString("org_name"))+",";		
			}
			strOrg = strOrg.substring(0,strOrg.length()-1);		
			
			vecValue.add(strProfileName);						
			vecValue.add(strOrgCode);
			vecValue.add(strOrg);
			vecValue.add(strDate);
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
		String strOrgCode = null;
		String strOrg  = null;
		String strDate  = null;
		String hidOpFields = null;
		String hidSelFields = null;
		String strLoanType = null;
		String strSaveDate =null;
		String strGen =null;

		try
		{
						
			hshTemp=(HashMap)EJBInvoker.executeStateLess("repData",hshPar,"getParameter");
			strGen =(String)hshTemp.get("genby");
			strSaveDate =(String)hshTemp.get("txtDate");
			strParam =(String)hshTemp.get("param");
			StringTokenizer st = new StringTokenizer(strParam,";");
			
			strOrgCode = st.nextToken();
			strOrg= st.nextToken();
			strDate = st.nextToken();
			hidOpFields = st.nextToken();
			hidSelFields =st.nextToken();
			strLoanType =st.nextToken();
			
			hshRecord.put("hidOrgCode",strOrg);
			hshRecord.put("txtDate",strDate);
			hshRecord.put("hidOpFields",hidOpFields);
			hshRecord.put("hidSelFields",hidSelFields);
			hshRecord.put("loantype",strLoanType);
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
	
	private HashMap getUserDetails(HashMap hshRequestValues) 
	{
	 HashMap hshRecord=new HashMap();
	 
		
		ResultSet rs = null;
		ResultSet rs1 = null;
		ArrayList vecRecords=null;
		ArrayList vecVal =null;
		String strQuery=null;
		String strOrgCode = null;
		String strOpFields = null;
		String strSelFields=null;
		String strTemp=null;
		String strToDate=null;
		String strDate=null;
		String strFromDate=null;
		ArrayList vecT = new ArrayList();
		String strQ = " ";
		String strGen=null;
		String strSaveDate = null;
		String strAvail="";
			
		try
		{
			
			
			strSaveDate =(String)hshRequestValues.get("txtSaveDate");
			strGen =(String)hshRequestValues.get("strUserId");
			
			strOrgCode =(String)hshRequestValues.get("hidOrgCode");
			strOpFields =(String)hshRequestValues.get("hidOpFields");
			strSelFields =(String)hshRequestValues.get("hidSelFields");
			strDate =(String)hshRequestValues.get("txtDate");
            if(strOpFields.equals("")&& strSelFields.equals(""))
				
			{	strSelFields="User Name,Employee ID,Organisation Name,Group Name,Class,Availablity";
				strOpFields="usr_fname as usr_name,usr_id,org_name,grp_name,usr_class,usr_avail";
						
			}
            
			StringTokenizer st = new StringTokenizer(strSelFields,",");
			while (st.hasMoreTokens())
			{
				vecT.add(st.nextToken());
			}


			
			strQuery = SQLParser.getSqlQuery("selrepuserpass^"+strOpFields+"^"+strOrgCode);
			
			if(!strDate.equals("All"))
			{
				strFromDate = strDate.substring(0,strDate.indexOf("-"));
				strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				strQ =SQLParser.getSqlQuery("selappdate^"+strFromDate+"^"+strToDate);
				strQuery = strQuery + strQ;
			}
			if(rs != null)
				rs.close();
			rs=DBUtils.executeQuery(strQuery);
			vecVal = new ArrayList();
			while (rs.next())
			{
				vecRecords = new ArrayList();
				
				
				if (vecT.contains("User Name"))
				{
					strTemp =correctNull(rs.getString("usr_name"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if (vecT.contains("Employee ID"))
				{
					strTemp =correctNull(rs.getString("usr_id")); 
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if (vecT.contains("Organisation Name"))
				{
					strTemp =correctNull(rs.getString("org_name"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				
				if (vecT.contains("Group Name"))
				{
					strTemp =correctNull(rs.getString("grp_name"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}

						
				if (vecT.contains("Class"))
				{
					strTemp =correctNull(rs.getString("usr_class"));
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}
				
				
				
                
				if (vecT.contains("Availablity"))
				{
					strAvail=rs.getString("usr_avail");
					if (strAvail.equalsIgnoreCase("a"))
					{
						strAvail="Available";
					}
					else if(strAvail.equalsIgnoreCase("u"))
					{
						strAvail="UnAvailable";	
					}
					vecRecords.add(strAvail);
					vecRecords.add("center");
				}
				vecVal.add(vecRecords);
				
				
									
			}
			
			hshRecord.put("vecValues",vecVal);
			hshRecord.put("txtDate",strDate);
			hshRecord.put("labels",strSelFields);
			hshRecord.put("genby",strGen);
			hshRecord.put("txtSaveDate",strSaveDate);
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
				if(rs1 != null)
				{
					rs1.close();
				}
				
			}
			catch(Exception e)
			{
				throw new EJBException("close"+e.toString()); 
			}
		}
	 
	 return hshRecord;
		
	}

	
}