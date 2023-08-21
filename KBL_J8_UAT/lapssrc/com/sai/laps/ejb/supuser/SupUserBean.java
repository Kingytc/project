package com.sai.laps.ejb.supuser;

import java.sql.ResultSet;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.facilities.FacilitiesBean;
import com.sai.laps.ejb.financial.FinancialBean;
import com.sai.laps.ejb.staticdata.staticdataBean;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "SupUserBean", mappedName = "SupUserHome")
@Remote (SupUserRemote.class)
public class SupUserBean extends BeanAdapter
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 7517029164394424338L;
	static Logger log=Logger.getLogger(SupUserBean.class);

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
			throw new EJBException("Error in getdata "+ce.toString());
		}
		
		return hshRecord;

	}

	private HashMap getRepDetails(HashMap hshRequestValues) 
	{		
		ResultSet rs = null;
		ResultSet rs1 = null;
		ArrayList vecRecords=null;
		HashMap hshRec=null;
		ArrayList vecVal =null;
		String strQuery=null;
		String strOrgCode = null;
		String strOpFields = null;
		String strSelFields=null;
		String strTemp=null;
		ArrayList vecT = new ArrayList();
		String strOrgName = "";
		String strDate=null;
		String strGen=null;
			
		try
		{
			
			strDate =(String)hshRequestValues.get("txtDate");
			strGen =(String)hshRequestValues.get("strUserId");
			strOrgCode =(String)hshRequestValues.get("hidOrgCode");
			strSelFields =(String)hshRequestValues.get("hidSelFields");
			strOpFields =(String)hshRequestValues.get("hidOpFields");
			strQuery = SQLParser.getSqlQuery("selusername^"+strGen);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2))+" "+correctNull(rs.getString(3));
			}
			rs.close();
			StringTokenizer st = new StringTokenizer(strOpFields,",");
			while (st.hasMoreTokens())
			{
				vecT.add(st.nextToken());
			}
			strQuery = SQLParser.getSqlQuery("repsupuser^"+strOpFields+"^"+strOrgCode);
					
			rs = DBUtils.executeQuery(strQuery);
			
			hshRec = new HashMap();
			vecVal = new ArrayList();
			while (rs.next())
			{
				vecRecords = new ArrayList();
				
				if (vecT.contains("org_name"))
				{
					strTemp =correctNull(rs.getString("org_name"));
					if (strTemp.equals(strOrgName))
					{
						vecRecords.add("&nbsp;");
					}
					else
					{
						vecRecords.add(strTemp);
					}
					vecRecords.add("left");
					strOrgName=strTemp;
										
				}
				if (vecT.contains("usr_id"))
				{
					vecRecords.add(correctNull(
												rs.getString("usr_id")));
					vecRecords.add("left");
				}
				if (vecT.contains("usr_fname"))
				{
					strTemp =correctNull(rs.getString("usr_fname"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if (vecT.contains("usr_lname"))
				{
					strTemp =correctNull(rs.getString("usr_lname"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if (vecT.contains("usr_supid"))
				{
					strTemp =correctNull(rs.getString("usr_supid"));
					strQuery=SQLParser.getSqlQuery("selectusername^"+strTemp);
					
					rs1 = DBUtils.executeQuery(strQuery);
					strTemp="&nbsp;";
					while (rs1.next())
					{
						strTemp =correctNull(rs1.getString(1)).trim();
						if (strTemp.equals(""))
						{
							strTemp ="&nbsp;";
						}
					}
					rs1.close();
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if (vecT.contains("usr_class"))
				{
					vecRecords.add(correctNull(
												rs.getString("usr_class")));
					vecRecords.add("center");
				}
				if (vecT.contains("usr_avail"))
				{
					strTemp =correctNull(rs.getString("usr_avail"));
					if (strTemp.equalsIgnoreCase("a"))
					{
						strTemp ="Available";
					}
					else
					{
						strTemp="Un Available";
					}
					vecRecords.add(strTemp);
					vecRecords.add("left");
					
				}
				if (vecT.contains("grp_name"))
				{
					strTemp =correctNull(rs.getString("grp_name"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				
				
				vecVal.add(vecRecords);
			}
			hshRec.put("vecValues",vecVal);
			hshRec.put("labels",strSelFields);
			hshRec.put("txtDate",strDate);
			hshRec.put("genby",strGen);
			if(rs != null)
				rs.close();				
			if(rs1 != null)
				rs1.close();
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
					rs.close();				
				if(rs1 != null)
					rs1.close();
				
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
		String strOrgLevel = null;
		//String strOrgCode= null;
		String hidOrgCode = null;
		String hidOpFields = null;
		String hidSelFields = null;
		String strProfileName = null;

		try
		{					
			hshTemp=(HashMap)EJBInvoker.executeStateLess("repData",hshPar,"getParameter");
			strParam = (String)hshTemp.get("param");
			strProfileName =(String)hshTemp.get("profilename");
			StringTokenizer st = new StringTokenizer(strParam,";");
			
			strOrgLevel = st.nextToken();
			hidOrgCode = st.nextToken();
			hidOpFields =st.nextToken();
	 		hidSelFields = st.nextToken();
			
			vecLabel.add("Profile Name");
			vecLabel.add("Organisation Level");
			vecLabel.add("Organisation Names");
			vecLabel.add("Output Fields");

			vecValue.add(strProfileName);						
			vecValue.add(strOrgLevel);
			strQuery = SQLParser.getSqlQuery("repbanknames^"+hidOrgCode);
			rs = DBUtils.executeQuery(strQuery);
			hidOrgCode="";
			while(rs.next())
			{
				hidOrgCode += correctNull(rs.getString("org_name"))+",";		
			}
			hidOrgCode = hidOrgCode.substring(0,hidOrgCode.length()-1);
			vecValue.add(hidOrgCode);
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
		String strOrgCode= null;
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
			
			strTemp= st.nextToken();
			strOrgCode = st.nextToken();
			hidOpFields = st.nextToken();
			hidSelFields =st.nextToken();
			
			hshRecord.put("hidOrgCode",strOrgCode);
			hshRecord.put("hidSelFields",hidSelFields);
			hshRecord.put("hidOpFields",hidOpFields);
			hshRecord.put("txtDate",strDate);
			hshRecord.put("strUserId",strGen);
			hshPar = new HashMap();
			hshPar =(HashMap)getRepDetails(hshRecord);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in help "+ce.toString());
		}
		
		return hshPar;
	}
	
	public HashMap getRetailAnnexure (HashMap hshValues) 
	{
		 
           ResultSet rs=null;
           ResultSet rs1=null;
           ResultSet rs2=null;
           ResultSet rs3=null;
           ResultSet rs4=null;
         
		HashMap hshRecord=new HashMap();
		HashMap hshVal=new HashMap();
		String appno=Helper.correctNull((String)hshValues.get("appno"));
		String strQuery="",strQuery1="",strQuery2="",strQuery3="",CG_NATUREINDUSTRY="",CG_INDUSTRYSECTOR="",CG_SOCIALCATGRY="",CG_LEGALID="",CG_NAMESCHEME="",CG_TYPEOFLOAN="";
		String strappId = Helper.correctNull((String)hshValues.get("comappid"));
		String nature = Helper.correctNull((String)hshValues.get("hidnature"));
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		nf.setGroupingUsed(false);
		String sectype="", cbsid="",cusid="";
		String strCity="",strState="",strCountry = "",strdistrict="",MCLRtype="",strAppId="",retloantype="",loanRenewFlag="",proposed="",Existing="";
		try
		{
			
			String cheifFlag="";
			strQuery = SQLParser.getSqlQuery("sel_appl_details^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				
				hshRecord.put("fullname",correctNull((String)rs.getString("fullname")));
				hshRecord.put("PERAPP_CONSTITUTION_code",correctNull((String)rs.getString("PERAPP_CONSTITUTIONNEW")));
				hshRecord.put("PERAPP_AADHAAR",correctNull((String)rs.getString("PERAPP_AADHAAR")));
				hshRecord.put("CONSTITUTION",correctNull((String)rs.getString("PERAPP_CONSTITUTION")));
				
				if(rs1!= null)
				{
					rs1.close();
				}
				rs1=DBUtils.executeLAPSQuery("retLoanType^"+appno);
				if(rs1.next())
				{
					loanRenewFlag=Helper.correctNull((String)rs1.getString("APP_RENEW_FLAG"));
					Existing=Helper.correctNull((String)rs1.getString("loan_recmdamt"));
					proposed=Helper.correctNull((String)rs1.getString("LOAN_AMTREQD"));
				}
				hshRecord.put("ExsistingAmt",Existing);
				hshRecord.put("proposedAmt",proposed);
				hshRecord.put("loanRenewFlag",loanRenewFlag);
						
				if(rs1!= null)
				{
					rs1.close();
				}
					rs1=DBUtils.executeLAPSQuery("sel_CBSStaticDataPassingCode^2^"+Helper.correctInt(rs.getString("PERAPP_CONSTITUTIONNEW")));
					if(rs1.next())
					{
						hshRecord.put("PERAPP_CONSTITUTION",Helper.correctNull(rs1.getString("cbs_static_data_desc"))) ;
					}
				if(!correctNull((String)rs.getString("PERAPP_CONSTITUTIONNEW")).equalsIgnoreCase("01"))
				{
					hshRecord.put("PERAPP_PANNO",correctNull((String)rs.getString("PERAPP_PANNO")));
				}
				else
				{
					cheifFlag="Y";
					hshRecord.put("PERAPP_PANNO1",correctNull((String)rs.getString("PERAPP_PANNO")));
				}
				
				hshRecord.put("PERAPP_NETWORTH",correctNull((String)rs.getString("PERAPP_NETWORTH")));
				hshRecord.put("PERAPP_CBSID",correctNull((String)rs.getString("PERAPP_CBSID")));
				hshRecord.put("PERAPP_MSE_REGNO",correctNull((String)rs.getString("PERAPP_MSE_REGNO")));
				hshRecord.put("PERAPP_UDYOG_AADHAR",correctNull((String)rs.getString("PERAPP_UDYOG_AADHAR")));
				String PERAPP_SEX= correctNull((String)rs.getString("PERAPP_SEX"));
				if(PERAPP_SEX.equals("M"))
					hshRecord.put("PERAPP_SEX","Male");
				else if(PERAPP_SEX.equals("F"))
					hshRecord.put("PERAPP_SEX","Female");
				hshRecord.put("PERAPP_DOB",correctNull((String)rs.getString("dob")));
				
				if(rs1!= null)
				{
					rs1.close();
				}
					rs1=DBUtils.executeLAPSQuery("selkyc_kycActivity^"+Helper.correctInt(rs.getString("perapp_id")));
					if(rs1.next())
					{
						hshRecord.put("KYC_KYCactivity",correctNull((String)rs1.getString("KYC_KYCactivity")));
					}
					if(rs1!= null)
					{
						rs1.close();
					}
						rs1=DBUtils.executeLAPSQuery("selborrowerdet_company^"+Helper.correctInt(rs.getString("perapp_id")));
						if(rs1.next())
						{
							hshRecord.put("cominfo_total_employees",correctNull((String)rs1.getString("cominfo_total_employees")));
						}
						if(rs1!= null)
						{	rs1.close();  }
						rs1=DBUtils.executeLAPSQuery("sel_customerdetail^"+ strappId);
						
						if(rs1.next())
						{
							hshRecord.put("CON_MOBILE",correctNull((String)rs1.getString("CON_MOBILE")));
						}
					
					strQuery2 = SQLParser.getSqlQuery("sel_customerdetail^"+ strappId);
					rs2 = DBUtils.executeQuery(strQuery2);
					if(rs2.next())
					{
						  String residentType=correctNull(rs2.getString("INDINFO_RESIDENT_STATUS"));
						  hshRecord.put("residentType", residentType);
						if(residentType.equals("N"))
						{	
							hshRecord.put("txtperapp_address1",correctNull(rs2.getString("CON_COMADDR1")));
							hshRecord.put("txtperapp_address2",correctNull(rs2.getString("CON_COMADDR2")));
							hshRecord.put("txtperapp_address3",correctNull(rs2.getString("CON_COMVILLAGE")));
							hshRecord.put("txtperapp_zip",correctNull(rs2.getString("CON_COMZIP")));
							strCity = Helper.correctNull(rs2.getString("CON_COMCITY"));
							strState = Helper.correctNull(rs2.getString("CON_COMSTATE"));
							strCountry = Helper.correctNull(rs2.getString("CON_COMCOUNTRY"));
							strdistrict = Helper.correctNull(rs2.getString("CON_COMDIST"));
						}
						else
						{
							hshRecord.put("txtperapp_address1",correctNull(rs2.getString("CON_PERMADDR1")));
							hshRecord.put("txtperapp_address2",correctNull(rs2.getString("CON_PERMADDR2")));
							hshRecord.put("txtperapp_address3",correctNull(rs2.getString("CON_PERMVILLAGE")));
							hshRecord.put("txtperapp_zip",correctNull(rs2.getString("CON_PERMZIP")));
							strCity = Helper.correctNull(rs2.getString("CON_PERMCITY"));
							strState = Helper.correctNull(rs2.getString("CON_PERMSTATE"));
							strCountry = Helper.correctNull(rs2.getString("CON_PERMCOUNTRY"));
							strdistrict = Helper.correctNull(rs2.getString("CON_PERMDIST"));
						}
						
						if(!strCity.equalsIgnoreCase(""))
					    {
					    	if(rs!=null)
					    	{
					    		rs.close();
					    	}
					    	strQuery2 = SQLParser.getSqlQuery("sel_cityname^"+ strCity);
							rs = DBUtils.executeQuery(strQuery2);
							if(rs.next())
							{
								hshRecord.put("txtperapp_city",correctNull(rs.getString("city_name")));
								strCity = Helper.correctNull(rs.getString("city_name"));
							}
					    }
					  
					    if(!strState.equalsIgnoreCase(""))
					    {
					    	if(rs!=null)
					    	{
					    		rs.close();
					    	}
					    	strQuery2 = SQLParser.getSqlQuery("sel_statename^"+ strState);
							rs = DBUtils.executeQuery(strQuery2);
							if(rs.next())
							{
								hshRecord.put("txtperapp_state",correctNull(rs.getString("state_name")));
								strState = Helper.correctNull(rs.getString("state_name"));
							}
					    }
					   
					    if(!strCountry.equalsIgnoreCase(""))
					    {
					    	if(rs!=null)
					    	{
					    		rs.close();
					    	}
					    	strQuery2 = SQLParser.getSqlQuery("sel_countrynamebycode^"+ strCountry);
							rs = DBUtils.executeQuery(strQuery2);
							if(rs.next())
							{
								hshRecord.put("txtperapp_country",correctNull(rs.getString("con_country")));
								strCountry = Helper.correctNull(rs.getString("con_country"));
							}
					    }
					    if(rs != null)rs.close();
					    strQuery2 = SQLParser.getSqlQuery("sel_districtmaster^"+ strdistrict );
						rs = DBUtils.executeQuery(strQuery2);
						if(rs.next())
						{
							hshRecord.put("txtperapp_district",correctNull(rs.getString("district_desc")));
						}
						
					}
			
			}

			if(rs3!= null)
			{
				rs3.close();
			}
			
			rs3=DBUtils.executeLAPSQuery("sel_indinfo_perapplicant^"+strappId);
			if(rs3.next())
			{
				hshRecord.put("PHYSICALLY_CHALLENGED",Helper.correctNull(rs3.getString("INDINFO_PHYSICALLY_CHALLANGED")));
				
			}
             

			if(rs3!= null)
			{
				rs3.close();
			}
			
			rs3=DBUtils.executeLAPSQuery("sel_cbsid_promoterExperience^"+strappId);
			if(rs3.next())
			{
				hshRecord.put("emp_experience",Helper.correctNull(rs3.getString("PEREMP_EXPINYRS")));
				
			}
			
			if(rs3!= null)
			{
				rs3.close();
			}
			rs3=DBUtils.executeLAPSQuery("sel_cbsidPerapplicant^"+strappId);//Individual
			if(rs3.next())
			{
				hshRecord.put("CHF_PROMOTER",Helper.correctNull(rs3.getString("COMAPP_CHF_PROMOTER")));				
				
				cbsid=Helper.correctNull(rs3.getString("COMAPP_CBSID"));

			}
			if(rs3!= null)
			{
				rs3.close();
			}
			rs3=DBUtils.executeLAPSQuery("sel_cbsid_promoter^"+strappId); //chief promoter 
			if(rs3.next()) 
			{
	
				hshRecord.put("PROMOTER_AADHAAR",Helper.correctNull(rs3.getString("PERAPP_AADHAAR")));
				hshRecord.put("PHY_CHALLANGED",Helper.correctNull(rs3.getString("INDINFO_PHYSICALLY_CHALLANGED")));
				hshRecord.put("PROMOTER_MOBILE",Helper.correctNull(rs3.getString("CON_MOBILE")));
				hshRecord.put("promNetworth",Helper.correctNull(rs3.getString("PERAPP_NETWORTH")));
				
						
			}
			if(rs3!= null)
			{
				rs3.close();
			}
			rs3=DBUtils.executeLAPSQuery("selappincomekycdetails^"+strappId);
			if(rs3.next())
			{
				hshRecord.put("PERAPP_ID",Helper.correctNull(rs3.getString("PERAPP_ID")));//0
				hshRecord.put("PERAPP_TITLE",Helper.correctNull(rs3.getString("PERAPP_TITLE")));//1
				hshRecord.put("PERAPP_FNAME",Helper.correctNull(rs3.getString("PERAPP_FNAME")));//2
				hshRecord.put("PERAPP_LNAME",Helper.correctNull(rs3.getString("PERAPP_LNAME")));//3
				
				hshRecord.put("KYC_IDPROOFREF",Helper.correctNull(rs3.getString("KYC_IDPROOFREF")));//7
				
				if(Helper.correctNull(rs3.getString("indinfo_caste")).equalsIgnoreCase("001"))
					hshRecord.put("indinfo_caste","Scheduled Caste");//8
				else if(Helper.correctNull(rs3.getString("indinfo_caste")).equalsIgnoreCase("002"))
					hshRecord.put("indinfo_caste","Scheduled Tribes");//8
				else if(Helper.correctNull(rs3.getString("indinfo_caste")).equalsIgnoreCase("003"))
					hshRecord.put("indinfo_caste","General");//8
				else if(Helper.correctNull(rs3.getString("indinfo_caste")).equalsIgnoreCase("099"))
					hshRecord.put("indinfo_caste","OBC");//8
				else
					hshRecord.put("indinfo_caste","");//8
				
				if(Helper.correctNull(rs3.getString("indinfo_minority")).equalsIgnoreCase("Y"))
					hshRecord.put("indinfo_minority","Yes");//9
				else if(Helper.correctNull(rs3.getString("indinfo_minority")).equalsIgnoreCase("N")) 
					hshRecord.put("indinfo_minority","No");//9
				else
					hshRecord.put("indinfo_minority","");//9
				rs3=DBUtils.executeLAPSQuery("sel_applKYCNorms^"+correctNull((String)rs3.getString("PERAPP_ID")));
				if(rs3.next())
				{	
					hshRecord.put("idprooftypedesc",Helper.correctNull(rs3.getString("idprooftypedesc")));//10
				}
			}
		
           strQuery = SQLParser.getSqlQuery("sel_cgtmseanx2^"+appno);
			
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				
				hshRecord.put("LOAN_RECMDAMT",correctNull((String)rs.getString("LOAN_RECMDAMT")));
				hshRecord.put("LOAN_REQTERMS",correctNull((String)rs.getString("LOAN_REQTERMS")));
				hshRecord.put("LOAN_MCLRTYPE",correctNull((String)rs.getString("LOAN_MCLRTYPE")));
				hshRecord.put("LOAN_MODINTRATE",correctNull((String)rs.getString("LOAN_MODINTRATE")));
				hshRecord.put("LOAN_REPAYMENTTYPE",correctNull((String)rs.getString("LOAN_REPAYMENTTYPE")));
				hshRecord.put("LOAN_NOOFINSTALLMENT",correctNull((String)rs.getString("LOAN_NOOFINSTALLMENT")));
				hshRecord.put("LOAN_PERIODICITY",correctNull((String)rs.getString("LOAN_PERIODICITY")));
				hshRecord.put("APP_PROCESSDATE",correctNull((String)rs.getString("APP_PROCESSDATE")));
				hshRecord.put("CBS_ACCOUNTNO",correctNull((String)rs.getString("CBS_ACCOUNTNO")));
				hshRecord.put("APP_NO",correctNull((String)rs.getString("APP_NO")));
				hshRecord.put("LOAN_RELEASEDATEOFMCLR",Helper.correctNull((String)rs.getString("LOAN_RELEASEDATEOFMCLR")));
				hshRecord.put("LOAN_DUEDATE",Helper.correctNull((String)rs.getString("LOAN_DUEDATE")));
				hshRecord.put("mclr_baseratespread",Helper.correctNull((String)rs.getString("LOAN_BASERATE")));
				hshRecord.put("LOAN_INTTYPE",Helper.correctNull((String)rs.getString("LOAN_INTTYPE")));
				hshRecord.put("LOAN_INTRATE",Helper.correctNull((String)rs.getString("LOAN_INTRATE")));   //MONDATE
				hshRecord.put("MONDATE",Helper.correctNull((String)rs.getString("MONDATE"))); 
				MCLRtype=Helper.correctNull((String)rs.getString("LOAN_MCLRTYPE"));
				 if(!MCLRtype.equalsIgnoreCase("")) 
				 {
					 MCLRtype = MCLRtype.split("@")[0];
				 }
			}
			
			
			
			strQuery = SQLParser.getSqlQuery("sel_cgtmseCorp3^"+appno+"^1");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("CG_MIC_ENTP",correctNull((String)rs.getString("CG_MIC_ENTP")));
				hshRecord.put("CG_PROJ_OPTI_SALES",correctNull((String)rs.getString("CG_PROJ_OPTI_SALES")));
				hshRecord.put("CG_PROJ_OPTI_EXPORT",correctNull((String)rs.getString("CG_PROJ_OPTI_EXPORT")));
				hshRecord.put("CG_ASISTBANK",correctNull((String)rs.getString("CG_ASISTBANK")));
				hshRecord.put("CG_NOEMP",correctNull((String)rs.getString("CG_NOEMP")));
				hshRecord.put("CG_MINCOMMUITY",correctNull((String)rs.getString("CG_MINCOMMUITY")));
				CG_SOCIALCATGRY=Helper.correctNull((String)rs.getString("CG_SOCIALCATGRY"));
				CG_LEGALID=Helper.correctNull((String)rs.getString("CG_LEGALID"));
				hshRecord.put("CG_NEW_UNIT",correctNull((String)rs.getString("CG_NEW_UNIT")));
				hshRecord.put("CG_NEW_UNIT_WO",correctNull((String)rs.getString("CG_NEW_UNIT_WO")));
				hshRecord.put("CG_MSE_UNIT",correctNull((String)rs.getString("CG_MSE_UNIT")));
				hshRecord.put("CG_COLSEC",correctNull((String)rs.getString("CG_COLSEC")));
				hshRecord.put("CG_THIRDPARTY",correctNull((String)rs.getString("CG_THIRDPARTY")));
				hshRecord.put("CG_JOINTFINANCE",correctNull((String)rs.getString("CG_JOINTFINANCE")));
				hshRecord.put("CG_JFCGPAN",correctNull((String)rs.getString("CG_JFCGPAN")));
				hshRecord.put("CG_ARTISAN_CC",correctNull((String)rs.getString("CG_ARTISAN_CC")));
				hshRecord.put("CG_GF_ASF",correctNull((String)rs.getString("CG_GF_ASF")));
				hshRecord.put("CG_IDENTY_DC",correctNull((String)rs.getString("CG_IDENTY_DC")));
				hshRecord.put("CG_HANDLOOMSCHEME",correctNull((String)rs.getString("CG_HANDLOOMSCHEME")));
				//String handloomschemename=correctNull((String)rs.getString("CG_NAMESCHEME"));
				
				 CG_NAMESCHEME=correctNull((String)rs.getString("CG_NAMESCHEME"));
				
				//hshRecord.put("CG_INTERNAL_RATING",correctNull((String)rs.getString("CG_INTERNAL_RATING")));
				hshRecord.put("CG_TC_PROMOTERS",correctNull((String)rs.getString("CG_TC_PROMOTERS")));
				hshRecord.put("CG_TL_MARGIN_MONEY",correctNull((String)rs.getString("CG_TL_MARGIN_MONEY")));
				hshRecord.put("CG_TC_SUBSIDY",correctNull((String)rs.getString("CG_TC_SUBSIDY")));
				hshRecord.put("CG_TC_OTHERS",correctNull((String)rs.getString("CG_TC_OTHERS")));
				hshRecord.put("CG_TC_PROJ_COST",correctNull((String)rs.getString("CG_TC_PROJ_COST")));
				hshRecord.put("CG_TC_PROJ_OUTLAY",correctNull((String)rs.getString("CG_TC_PROJ_OUTLAY")));
				hshRecord.put("CG_LEGALIDNO",correctNull((String)rs.getString("CG_LEGALIDNO")));
				hshRecord.put("CG_OTHERIDNAME",correctNull((String)rs.getString("CG_OTHERIDNAME")));
				hshRecord.put("CG_OTHERIDNO",correctNull((String)rs.getString("CG_OTHERIDNO")));
				hshRecord.put("CG_NPA",correctNull((String)rs.getString("CG_NPA")));
				
				hshRecord.put("CG_PRV_CGP",correctNull((String)rs.getString("CG_PRV_CGP")));
				hshRecord.put("CG_CHECKBX",correctNull((String)rs.getString("CG_CHECKBX")));
				CG_NATUREINDUSTRY=Helper.correctNull((String)rs.getString("CG_NATUREINDUSTRY"));
				CG_INDUSTRYSECTOR=Helper.correctNull((String)rs.getString("CG_INDUSTRYSECTOR"));
				CG_TYPEOFLOAN=Helper.correctNull((String)rs.getString("CG_TYPEOFLOAN"));
				hshRecord.put("CG_INTERNAL_RATING",correctNull((String)rs.getString("CG_INTERNAL_RATING")));
				hshRecord.put("CG_PREV_CGPAN",correctNull((String)rs.getString("CG_PREV_CGPAN")));				
				hshRecord.put("CG_APPDET_OUTSTAN_AMT",correctNull((String)rs.getString("CG_APPDET_OUTSTAN_AMT")));
				hshRecord.put("CG_APPDET_NPA",correctNull((String)rs.getString("CG_APPDET_NPA")));
				hshRecord.put("CG_HANDICRAFT_AVAIL_AMT",correctNull((String)rs.getString("CG_HANDICRAFT_AVAIL_AMT")));
				hshRecord.put("cg_firstcharge",correctNull((String)rs.getString("CG_FIRSTCHARGE")));
				hshRecord.put("CG_MSE_UNIT_WO",correctNull((String)rs.getString("CG_MSE_UNIT_WO")));
				hshRecord.put("CG_CIBIL_MSME_RANK",correctNull((String)rs.getString("CG_CIBIL_MSME_RANK")));
				hshRecord.put("CG_REPAY_YEAR",correctNull((String)rs.getString("CG_REPAY_YEAR")));
				hshRecord.put("CG_ISSUEDATE",correctNull(rs.getString("CG_ISSUEDATE")));
				hshRecord.put("CG_UNIT_ENGAGED",correctNull(rs.getString("CG_UNIT_ENGAGED")));
				hshRecord.put("CG_EDUCATION",correctNull(rs.getString("CG_EDUCATION")));
				hshRecord.put("CG_NCGTC",correctNull(rs.getString("CG_NCGTC")));
			}	
			
			strQuery=SQLParser.getSqlQuery("sel_cgtmseanx4^210^"+CG_NATUREINDUSTRY);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{				
				String STAT_DATA_DESC1=Helper.correctNull((String)rs.getString("STAT_DATA_DESC1"));
				hshRecord.put("STAT_DATA_DESC1",Helper.correctNull((String)rs.getString("STAT_DATA_DESC"))+"-"+Helper.correctNull((String)rs.getString("STAT_DATA_DESC1")));
							
			}
			strQuery=SQLParser.getSqlQuery("sel_cgtmseanx4^283^"+CG_TYPEOFLOAN);
			rs2=DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{				
				hshRecord.put("STAT_DATA_DESC2",correctNull((String)rs2.getString("STAT_DATA_DESC1")));						
			}
			strQuery=SQLParser.getSqlQuery("sel_cgtmseanx4^211^"+CG_INDUSTRYSECTOR);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{				
				hshRecord.put("STAT_DATA_DESC",correctNull((String)rs.getString("STAT_DATA_DESC1")));						
			}
			strQuery=SQLParser.getSqlQuery("sel_cgtmseanx4^242^"+CG_SOCIALCATGRY);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{				
				hshRecord.put("CG_SOCIALCATGRY",correctNull((String)rs.getString("STAT_DATA_DESC1")));
							
			}
			strQuery=SQLParser.getSqlQuery("sel_cgtmseanx4^54^"+CG_LEGALID);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{				
				hshRecord.put("CG_LEGALID",correctNull((String)rs.getString("STAT_DATA_DESC1")));
							
			}
			strQuery = SQLParser.getSqlQuery("sel_tl_repayschedule^"+appno+"^1");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				//hshRecord.put("LOAN_PERIODICITY",correctNull((String)rs.getString("TL_FEQUENCY")));
				String frq=correctNull((String)rs.getString("TL_FEQUENCY"));
				if(frq.equalsIgnoreCase("M"))
					frq="Monthly";
				else if(frq.equalsIgnoreCase("Y"))
					frq="Yearly";
				else if(frq.equalsIgnoreCase("Q"))
					frq="Quarterly";
				else if(frq.equalsIgnoreCase("H"))
					frq="Half Yearly";
				else
					frq="";
				hshRecord.put("LOAN_PERIODICITY",frq);
			}
		strQuery=SQLParser.getSqlQuery("sel_cgtmseanx4^241^"+CG_NAMESCHEME);
		rs=DBUtils.executeQuery(strQuery);
		while(rs.next())
		{				
			hshRecord.put("CG_NAMESCHEME",correctNull((String)rs.getString("STAT_DATA_DESC1")));						
		}
			// added by harish for annexure mapping
			
				ArrayList arrOutCol= new ArrayList();
				ArrayList arrOutRow=new ArrayList();
				ArrayList arrOutCol1= new ArrayList();
				ArrayList arrOutRow1=new ArrayList();
				String strCityDesc="",strStateDesc="",strDistcode="",strDistDesc="",strType="";
				rs=DBUtils.executeLAPSQuery("selcomappdivision_cgtmse^"+strappId);
				while(rs.next())
				{
					String strAadharno="";
					if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("O"))
						strType="Share Holders";
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("D"))
						strType="Directors";
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("SP"))
						strType="Sole Proprietor";
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("PT"))
						strType="Partner";
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("OT"))
						strType="Others";
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("K"))
						strType="Karta";
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("PA"))
						strType="Power of Attorney";
					else
						strType=correctNull((String)rs.getString("comapp_divisiontype"));
					
					String DIVISIONSUBTYPE=Helper.correctNull((String)rs.getString("COMAPP_DIVISIONSUBTYPE"));
					
					if( (correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("D")) || (correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("PT")))
					{
						arrOutCol = new ArrayList();
						arrOutCol.add(strType);//0
						arrOutCol.add(correctNull((String)rs.getString("comapp_div_name")));//1
						if(!correctNull((String)rs.getString("comapp_div_appid")).equalsIgnoreCase(""))
						{
							rs3=DBUtils.executeLAPSQuery("selappincomekycdetails^"+correctNull((String)rs.getString("comapp_div_appid")));
							if(rs3.next())
							{
								arrOutCol.add(Helper.correctNull(rs3.getString("perapp_dob")));//2
								arrOutCol.add(Helper.correctNull(rs3.getString("perapp_panno")));//3
								strAadharno=Helper.correctNull(rs3.getString("perapp_aadhaar"));//4
							}
							else
							{
								arrOutCol.add("");//2
								arrOutCol.add("");//3
								arrOutCol.add("");//4
							}
						}
						else
						{
							arrOutCol.add("");//2
							arrOutCol.add("");//3
							arrOutCol.add("");//4
						}
						arrOutRow.add(arrOutCol);
					}
				}
				hshRecord.put("arrGroupInfo", arrOutRow);
				
				if(rs!=null)
		    	{
		    		rs.close();
		    	}
				rs=DBUtils.executeLAPSQuery("comapp_division_details_sel_Chiefprom^"+strappId);
				while(rs.next())
				{
					String strAadharno="";
					if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("O"))
						strType="Share Holders";
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("D"))
						strType="Directors";
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("SP"))
						strType="Sole Proprietor";
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("PT"))
						strType="Partner";
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("OT"))
						strType="Others";
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("K"))
						strType="Karta";
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("PA"))
						strType="Power of Attorney";
					else
						strType=correctNull((String)rs.getString("comapp_divisiontype"));
					
					String DIVISIONSUBTYPE=Helper.correctNull((String)rs.getString("COMAPP_DIVISIONSUBTYPE"));
				
				// added by raja sekhar
				arrOutCol1 = new ArrayList();
				if(!correctNull((String)rs.getString("comapp_div_appid")).equalsIgnoreCase(""))
				{
					rs3=DBUtils.executeLAPSQuery("selappincomekycdetails^"+correctNull((String)rs.getString("comapp_div_appid")));
					if(rs3.next())
					{
						arrOutCol1.add(Helper.correctNull(rs3.getString("PERAPP_ID")));//0
						arrOutCol1.add(Helper.correctNull(rs3.getString("PERAPP_TITLE")));//1
						arrOutCol1.add(Helper.correctNull(rs3.getString("PERAPP_FNAME")));//2
						arrOutCol1.add(Helper.correctNull(rs3.getString("PERAPP_LNAME")));//3
						arrOutCol1.add(Helper.correctNull(rs3.getString("PERAPP_PANNO")));//4
						arrOutCol1.add(Helper.correctNull(rs3.getString("PERAPP_DOB")));//5
						
						if(Helper.correctNull(rs3.getString("PERAPP_SEX")).equalsIgnoreCase("M"))
						arrOutCol1.add("Male");//6
						else if(Helper.correctNull(rs3.getString("PERAPP_SEX")).equalsIgnoreCase("F"))
						arrOutCol1.add("Female");//6
						else
						arrOutCol1.add("Others");//6
						//arrOutCol1.add(Helper.correctNull(rs3.getString("KYC_IDPROOFTYPE")));//7
						arrOutCol1.add(Helper.correctNull(rs3.getString("KYC_IDPROOFREF")));//7
						arrOutCol1.add(Helper.correctNull(rs3.getString("con_mobile")));//8
						arrOutCol1.add(Helper.correctNull(rs3.getString("perapp_aadhaar")));//9
						//arrOutCol1.add(Helper.correctNull(rs3.getString("INDINFO_PHYSICALLY_CHALLANGED")));//13
						if(Helper.correctNull(rs3.getString("indinfo_physically_challanged")).equalsIgnoreCase("Y"))
							arrOutCol1.add("Yes");//10
						else if(Helper.correctNull(rs3.getString("indinfo_physically_challanged")).equalsIgnoreCase("N"))
							arrOutCol1.add("No");//10
						else
							arrOutCol1.add("");//10
						if(Helper.correctNull(rs3.getString("indinfo_caste")).equalsIgnoreCase("001"))
							arrOutCol1.add("Scheduled Caste");//11
						else if(Helper.correctNull(rs3.getString("indinfo_caste")).equalsIgnoreCase("002"))
							arrOutCol1.add("Scheduled Tribes");//11
						else if(Helper.correctNull(rs3.getString("indinfo_caste")).equalsIgnoreCase("003"))
							arrOutCol1.add("General");//11
						else if(Helper.correctNull(rs3.getString("indinfo_caste")).equalsIgnoreCase("099"))
							arrOutCol1.add("OBC");//11
						else
							arrOutCol1.add("");//11
						
						if(Helper.correctNull(rs3.getString("indinfo_minority")).equalsIgnoreCase("Y"))
							arrOutCol1.add("Yes");//12
						else if(Helper.correctNull(rs3.getString("indinfo_minority")).equalsIgnoreCase("N"))
							arrOutCol1.add("No");//12
						else
							arrOutCol1.add("");//12
						rs3=DBUtils.executeLAPSQuery("sel_applKYCNorms^"+correctNull((String)rs3.getString("PERAPP_ID")));
						if(rs3.next())
						{	
							arrOutCol1.add(Helper.correctNull(rs3.getString("idprooftypedesc")));//13
						}
						
						arrOutRow1.add(arrOutCol1);
					}
				   }
				}
				hshRecord.put("arrOtherInfo", arrOutRow1);
				
				ArrayList arrGuardetails=new ArrayList();
				ArrayList arrGuardetailsRow=new ArrayList();
				String app_type="";
				strQuery = SQLParser.getSqlQuery("sel_GrApp_details^"+ appno);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					app_type=Helper.correctNull((String)rs.getString("app_type"));
					if(app_type.equals("g")||app_type.equalsIgnoreCase("o"))
					{
						arrGuardetails=new ArrayList();
						arrGuardetails.add(Helper.correctNull((String)rs.getString("fullname"))); //0
						arrGuardetails.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("perapp_networth"))))); //1
						
						arrGuardetailsRow.add(arrGuardetails);
					}
				}
				hshRecord.put("arrGuardetailsRow", arrGuardetailsRow);

				//Security - LAND
				ArrayList arrAppSec_Land=new ArrayList();
				ArrayList arrAppSec_LandRow=new ArrayList();
				sectype="10";
				strQuery = SQLParser.getSqlQuery("sel_app_secClasstype^"+ appno+"^1^P^"+sectype);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrAppSec_Land=new ArrayList();
					arrAppSec_Land.add(Helper.correctNull((String)rs.getString("sec_name"))); //0
					arrAppSec_Land.add(Helper.CLOBToString(rs.getClob("APP_SEC_DESCRIPTION"))); //1
					arrAppSec_Land.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("APP_SEC_SECURITYVALUE"))))); //2
					arrAppSec_LandRow.add(arrAppSec_Land);
				}
				hshRecord.put("arrAppSec_LandRow", arrAppSec_LandRow);

				//Security - BUILDING
				ArrayList arrAppSec_Build=new ArrayList();
				ArrayList arrAppSec_BuildRow=new ArrayList();
				sectype="11','12','13','14','15','16','17";
				strQuery = SQLParser.getSqlQuery("sel_app_secClasstype^"+ appno+"^1^P^"+sectype);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrAppSec_Build=new ArrayList();
					arrAppSec_Build.add(Helper.correctNull((String)rs.getString("sec_name"))); //0
					arrAppSec_Build.add(Helper.CLOBToString(rs.getClob("APP_SEC_DESCRIPTION"))); //1
					arrAppSec_Build.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("APP_SEC_SECURITYVALUE"))))); //2
					arrAppSec_BuildRow.add(arrAppSec_Build);
				}
				hshRecord.put("arrAppSec_BuildRow", arrAppSec_BuildRow);

				//Security - Plant and Machinery
				ArrayList arrAppSec_plantmach=new ArrayList();
				ArrayList arrAppSec_plantmachRow=new ArrayList();
				sectype="19";
				strQuery = SQLParser.getSqlQuery("sel_app_secClasstype^"+ appno+"^1^P^"+sectype);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrAppSec_plantmach=new ArrayList();
					arrAppSec_plantmach.add(Helper.correctNull((String)rs.getString("sec_name"))); //0
					arrAppSec_plantmach.add(Helper.CLOBToString(rs.getClob("APP_SEC_DESCRIPTION"))); //1
					arrAppSec_plantmach.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("APP_SEC_SECURITYVALUE"))))); //2
					arrAppSec_plantmachRow.add(arrAppSec_plantmach);
				}
				hshRecord.put("arrAppSec_plantmachRow", arrAppSec_plantmachRow);
			
				//Security - Other Fixed/ Movable Assets
				ArrayList arrAppSec_vehicleFur=new ArrayList();
				ArrayList arrAppSec_vehicleFurRow=new ArrayList();
				sectype="18','20";
				strQuery = SQLParser.getSqlQuery("sel_app_secClasstype^"+ appno+"^1^P^"+sectype);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrAppSec_vehicleFur=new ArrayList();
					arrAppSec_vehicleFur.add(Helper.correctNull((String)rs.getString("sec_name"))); //0
					arrAppSec_vehicleFur.add(Helper.CLOBToString(rs.getClob("APP_SEC_DESCRIPTION"))); //1
					arrAppSec_vehicleFur.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("APP_SEC_SECURITYVALUE"))))); //2
					arrAppSec_vehicleFurRow.add(arrAppSec_vehicleFur);
				}
				hshRecord.put("arrAppSec_vehicleFurRow", arrAppSec_vehicleFurRow);
			

				//Security - Current Assets
				ArrayList arrAppSec_stockbook=new ArrayList();
				ArrayList arrAppSec_stockbookRow=new ArrayList();
				sectype="3','4";
				strQuery = SQLParser.getSqlQuery("sel_app_secClasstype^"+ appno+"^1^P^"+sectype);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrAppSec_stockbook=new ArrayList();
					arrAppSec_stockbook.add(Helper.correctNull((String)rs.getString("sec_name"))); //0
					arrAppSec_stockbook.add(Helper.CLOBToString(rs.getClob("APP_SEC_DESCRIPTION"))); //1
					arrAppSec_stockbook.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("APP_SEC_SECURITYVALUE"))))); //2
					arrAppSec_stockbookRow.add(arrAppSec_stockbook);
				}
				hshRecord.put("arrAppSec_stockbookRow", arrAppSec_stockbookRow);
				
				//Security - Others
				ArrayList arrAppSec_others=new ArrayList();
				ArrayList arrAppSec_othersRow=new ArrayList();
				sectype="1','2','5','6','7','8','9','21','22','23','24";
				strQuery = SQLParser.getSqlQuery("sel_app_secClasstype^"+ appno+"^1^P^"+sectype);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrAppSec_others=new ArrayList();
					arrAppSec_others.add(Helper.correctNull((String)rs.getString("sec_name"))); //0
					arrAppSec_others.add(Helper.CLOBToString(rs.getClob("APP_SEC_DESCRIPTION"))); //1
					arrAppSec_others.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("APP_SEC_SECURITYVALUE"))))); //2
					arrAppSec_othersRow.add(arrAppSec_others);
				}
				hshRecord.put("arrAppSec_othersRow", arrAppSec_othersRow);
			
				
				if(rs!= null)
				{	rs.close();  }
				if(Helper.correctNull((String)hshRecord.get("LOAN_RELEASEDATEOFMCLR")).equalsIgnoreCase(""))
				strQuery = SQLParser.getSqlQuery("sel_mclrspreadrate^"+Helper.getCurrentDateTime()+"^"+MCLRtype);
				else
				strQuery = SQLParser.getSqlQuery("sel_mclrspreadrate^"+Helper.correctNull((String)hshRecord.get("LOAN_RELEASEDATEOFMCLR"))+"^"+MCLRtype);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					//hshRecord.put("mclr_baseratespread",Helper.correctNull((String)rs.getString("mclr_baseratespread")));
				}
				
				if(rs!= null)
				{	rs.close();  }
				/*rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("processedorg_name",Helper.correctNull((String)rs.getString("org_name")));
					hshRecord.put("processedORG_SCODE",Helper.correctNull((String)rs.getString("ORG_SCODE")));
				}*/
				strQuery =SQLParser.getSqlQuery("sel_cbsdetails^"+appno+"^1"); 
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					String strDisbBrCode=Helper.correctInt(rs.getString("LOANDISBBRANCH"));
					hshRecord.put("processedORG_SCODE",strDisbBrCode);
					if(!strDisbBrCode.equalsIgnoreCase(""))
					{
						if(rs1!=null){rs1.close();}
						rs1=DBUtils.executeLAPSQuery("sel_organisationname^"+strDisbBrCode);		 
						if(rs1.next())
						{
							hshRecord.put("processedorg_name",Helper.correctNull((String)rs1.getString("org_name")));
							//hshRecord.put("processedorg_state",Helper.correctNull((String)rs1.getString("org_state")));
						    String processedorg_state = Helper.correctNull(rs1.getString("org_state"));
						if(rs!= null)
						{	rs.close();  }
						strQuery = SQLParser.getSqlQuery("Statename^"+processedorg_state);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							hshRecord.put("process_orgstate",Helper.correctNull((String)rs.getString("STATE_NAME")));
						}
						}
					}
				}
				
				if(rs!= null)
				{	rs.close();  }
				strQuery = SQLParser.getSqlQuery("sel_rating_nonPoolFlag^"+appno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("cre_weight",Helper.correctNull((String)rs.getString("cre_weight")));
				}
				else
				{
					if(rs1!= null)
					{	rs1.close();  }
					strQuery = SQLParser.getSqlQuery("sel_rating_poolFlag^"+appno);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						hshRecord.put("cre_weight",Helper.correctNull((String)rs1.getString("cre_weight")));
					}
				}
					
				if(rs!=null){ rs.close(); }
			 	strQuery=SQLParser.getSqlQuery("sel_tl_repayschedule^"+appno+"^1");
				rs=DBUtils.executeQuery(strQuery);
				int totalinst=0;
				while(rs.next())
				{
						totalinst=totalinst + (Integer.parseInt(Helper.correctInt((String)rs.getString("TL_NOOFINST"))));
				} 
				if(Helper.correctNull((String)hshRecord.get("LOAN_REPAYMENTTYPE")).equalsIgnoreCase("1"))
					hshRecord.put("loan_noofinstall",String.valueOf(Integer.parseInt(Helper.correctInt((String)hshRecord.get("LOAN_REQTERMS")))-Integer.parseInt(Helper.correctInt((String)hshRecord.get("LOAN_NOOFINSTALLMENT")))));
				else
					hshRecord.put("loan_noofinstall",String.valueOf(totalinst));
				
				// end for harish
				
				
				
				
			hshRecord.put("strAppno",appno);	
			
			if(rs!= null)
			{	rs.close();  }
			strQuery = SQLParser.getSqlQuery("sel_facilityval^"+appno+"^1");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("TXNDET_CRDT_AMT",Helper.correctNull((String)rs.getString("TXNDET_CRDT_AMT")));
				hshRecord.put("TXNDET_AMT_DISBURSED",Helper.correctNull((String)rs.getString("TXNDET_AMT_DISBURSED")));
				hshRecord.put("TXNDET_OUTS_BAL_AMT",Helper.correctNull((String)rs.getString("TXNDET_OUTS_BAL_AMT")));
				hshRecord.put("TXNDET_OUTS_BAL_DT",Helper.correctNull((String)rs.getString("TXNDET_OUTS_BAL_DT")));
				hshRecord.put("TXNDET_FST_INS_DUE_DT",Helper.correctNull((String)rs.getString("TXNDET_FST_INS_DUE_DT")));
				hshRecord.put("TXNDET_DT_FST_DISB",Helper.correctNull((String)rs.getString("TXNDET_DT_FST_DISB")));
				hshRecord.put("TXNDET_DT_LST_DISB",Helper.correctNull((String)rs.getString("TXNDET_DT_LST_DISB")));
				hshRecord.put("TXNDET_CRDT_FUNDBASED",Helper.correctNull((String)rs.getString("TXNDET_CRDT_FUNDBASED")));
				hshRecord.put("TXNDET_CRDT_NONFUNDBASED",Helper.correctNull((String)rs.getString("TXNDET_CRDT_NONFUNDBASED")));
				hshRecord.put("TXNDET_OUTSTD_FUND",Helper.correctNull((String)rs.getString("TXNDET_OUTSTD_FUND")));
				hshRecord.put("TXNDET_OUTFB_DT",Helper.correctNull((String)rs.getString("TXNDET_OUTFB_DT")));
				hshRecord.put("TXNDET_OUTSTD_NONFUND",Helper.correctNull((String)rs.getString("TXNDET_OUTSTD_NONFUND")));
				hshRecord.put("TXNDET_OUTNFB_DT",Helper.correctNull((String)rs.getString("TXNDET_OUTNFB_DT")));
				hshRecord.put("TXNDET_CGPAN_NO",Helper.correctNull((String)rs.getString("TXNDET_CGPAN_NO")));
				hshRecord.put("TXNDET_AMT_DISBURSEDWC",Helper.correctNull((String)rs.getString("TXNDET_AMT_DISBURSEDWC")));
				hshRecord.put("TXNDET_DT_FST_DISBWC",Helper.correctNull((String)rs.getString("TXNDET_DT_FST_DISBWC")));
				hshRecord.put("TXNDET_DT_LST_DISBWC",Helper.correctNull((String)rs.getString("TXNDET_DT_LST_DISBWC")));
				
			}
			hshRecord.put("appno",appno);
			FinancialBean FinancialBean=new FinancialBean();
			hshVal=FinancialBean.getRetailData(hshRecord);
			//hshVal=FinancialBean.getCorpAnnexureII(hshRecord);
			hshRecord.put("hshVal", hshVal);
			
			if(rs!= null)
			{	rs.close();  }
			strQuery=SQLParser.getSqlQuery("getprddesc^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("FacilityNature",Helper.correctNull(rs.getString("PRD_LOANTYPE")));	
			}
			
		}
	
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
				
			}
			catch(Exception e1)
			{
				throw new EJBException("Error closing connection"+e1);
			}
		}
		return hshRecord;		
	} 
	
	public void updateCropCgtmse(HashMap hshValues)  
	{

		HashMap hshQuery=new HashMap();
		HashMap hshRecord = new HashMap();
		HashMap hshQueryValues = null;
		String strQuery = "";
	
		ArrayList arr= new ArrayList() ;
		
		HashMap hshQuery1=new HashMap();
		HashMap hshRecord1 = new HashMap();
		HashMap hshQueryValues1 = null;
		String strQuery1 = "";
	
		ArrayList arr1= new ArrayList();
		
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strAction = Helper.correctNull((String)hshValues.get("hidAction"));
		//String strAppno=Helper.correctNull((String)hshValues.get("hidProposalNum"));
		String strFacilitySno=Helper.correctNull((String)hshValues.get("sel_facilitysno"));
		String []strCGPan=null;
		String txt_cgpan="";
		if(hshValues.get("PrevCGPan") instanceof String[])
		{
			strCGPan = (String[])hshValues.get("PrevCGPan");
			  for(int i=0;i<strCGPan.length;i++)
			  {
				  if(!strCGPan[i].equals(""))
					  txt_cgpan=txt_cgpan+"@"+strCGPan[i];
			  }
			  txt_cgpan=txt_cgpan.replaceFirst("@","");
		}
		else
		{
			txt_cgpan=Helper.correctNull((String) hshValues.get("PrevCGPan"));
		}
		ArrayList arrValues = new ArrayList();
		ArrayList arrValues1 = new ArrayList();
		try
		{
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery1 = new HashMap();
				arrValues1 = new ArrayList();
				hshQueryValues1=new HashMap();
				arrValues1.add(strAppno);
				arrValues1.add(strFacilitySno);
				hshQuery1.put("strQueryId", "delExt_CropCgtmse");
				hshQuery1.put("arrValues", arrValues1);
				hshQueryValues1.put("size","1");
				hshQueryValues1.put("1",hshQuery1);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues1,"updateData");
			}
			else if(strAction.equalsIgnoreCase("insert"))
			{
				hshQuery1 = new HashMap();
				arrValues1 = new ArrayList();
				hshQueryValues1=new HashMap();
				arrValues1.add(strAppno);
				arrValues1.add(strFacilitySno);
				hshQuery1.put("strQueryId", "delExt_CropCgtmse");
				hshQuery1.put("arrValues", arrValues1);
				hshQueryValues1.put("size","1");
				hshQueryValues1.put("1",hshQuery1);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues1,"updateData");
				

		 		arrValues = new ArrayList();
			    hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_facilitysno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("inwardno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("appno")));
				//arrValues.add(Helper.correctNull((String)hshValues.get("CGPan")));
				arrValues.add(Helper.correctNull((String)hshValues.get("Npa")));
				arrValues.add(Helper.correctNull((String)hshValues.get("MicEntp")));
				//arrValues.add(Helper.correctNull((String)hshValues.get("MSERegNo")));
				//arrValues.add(Helper.correctNull((String)hshValues.get("UdyogAadharNo")));
				arrValues.add(Helper.correctNull((String)hshValues.get("ProjOptiSales")));
				arrValues.add(Helper.correctNull((String)hshValues.get("ProjOptiExport")));
			//	arrValues.add(Helper.correctNull((String)hshValues.get("TurnOver")));
				
			
				arrValues.add(Helper.correctNull((String)hshValues.get("Newunit")));//9
				arrValues.add(Helper.correctNull((String)hshValues.get("NewunitWO")));
				arrValues.add(Helper.correctNull((String)hshValues.get("MSEunit")));
				arrValues.add(Helper.correctNull((String)hshValues.get("MSEunitWO")));
				arrValues.add(Helper.correctNull((String)hshValues.get("MSMEDunit")));
				arrValues.add(Helper.correctNull((String)hshValues.get("ArtisanCC")));
				arrValues.add(Helper.correctNull((String)hshValues.get("GF_ASF")));
				arrValues.add(Helper.correctNull((String)hshValues.get("IdentyDC")));
				
				//arrValues.add(Helper.correctNull((String)hshValues.get("InternalRating")));	//17			
			//	arrValues.add(Helper.correctDouble((String)hshValues.get("TermCredtSanc")));
			//	arrValues.add(Helper.correctDouble((String)hshValues.get("TC_FundBased")));
			//	arrValues.add(Helper.correctDouble((String)hshValues.get("TC_NonFundBased")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("TC_PromoContrbtn")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("TC_Subsidy")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("TC_Others")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("TC_ProjCost")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("TC_ProjOutlay")));//25				
		       // arrValues.add(Helper.correctDouble((String)hshValues.get("WorkCapitalSanc")));
			//	arrValues.add(Helper.correctDouble((String)hshValues.get("WC_FundBased")));				
			//	arrValues.add(Helper.correctDouble((String)hshValues.get("WC_NonFundBased")));
				arrValues.add(Helper.correctNull((String)hshValues.get("TL_MarginMoney")));
			//	arrValues.add(Helper.correctDouble((String)hshValues.get("WC_PromoContrbtn")));
			//	arrValues.add(Helper.correctDouble((String)hshValues.get("WC_Subsidy")));
			//	arrValues.add(Helper.correctDouble((String)hshValues.get("WC_Others")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("WC_Assesse")));								
				//arrValues.add(Helper.correctDouble((String)hshValues.get("TL_CrdtAmt")));
				//arrValues.add(Helper.correctDouble((String)hshValues.get("TL_AmtDisbursment")));//35
				//arrValues.add(Helper.correctDouble((String)hshValues.get("CrdtFundBased")));
				//arrValues.add(Helper.correctDouble((String)hshValues.get("CrdtNonFundBased")));				
				//arrValues.add(Helper.correctDouble((String)hshValues.get("OutsdFundBased")));
				//arrValues.add(Helper.correctDouble((String)hshValues.get("OutsdNonFundBased")));
			//	arrValues.add(Helper.correctNull((String)hshValues.get("TransID")));//40				
		//	arrValues.add(Helper.correctDouble((String)hshValues.get("TransAmt")));
				
				
				arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));//40
				arrValues.add(Helper.correctNull((String)hshValues.get("strOrgCode")));
				
				arrValues.add(Helper.correctNull((String)hshValues.get("AsistBank")));
				arrValues.add(Helper.correctNull((String)hshValues.get("NatureIndustry")));
				arrValues.add(Helper.correctNull((String)hshValues.get("IndustrySector")));
				arrValues.add(Helper.correctNull((String)hshValues.get("NoEmp")));
			//	arrValues.add(Helper.correctNull((String)hshValues.get("PromoName")));
				arrValues.add(Helper.correctNull((String)hshValues.get("MinCommuity")));
				arrValues.add(Helper.correctNull((String)hshValues.get("SocialCatgry")));
				arrValues.add(Helper.correctNull((String)hshValues.get("legalId")));
				arrValues.add(Helper.correctNull((String)hshValues.get("LegalIdNo")));
				arrValues.add(Helper.correctNull((String)hshValues.get("OtherIDName")));
				
				
			
				arrValues.add(Helper.correctNull((String)hshValues.get("OtherIDNo")));
				arrValues.add(Helper.correctNull((String)hshValues.get("ColSec")));
				arrValues.add(Helper.correctNull((String)hshValues.get("ThirdParty")));
				arrValues.add(Helper.correctNull((String)hshValues.get("JointFinance")));
				arrValues.add(Helper.correctNull((String)hshValues.get("JFCGpan")));
				
				arrValues.add(Helper.correctNull((String)hshValues.get("HandloomScheme")));
				arrValues.add(Helper.correctNull((String)hshValues.get("Namescheme")));
				arrValues.add(Helper.correctNull((String)hshValues.get("checkBx")));
				//arrValues.add(Helper.correctNull((String)hshValues.get("TL_OutsAmount")));
				arrValues.add(Helper.correctNull((String)hshValues.get("PrevCGTMSE")));
				arrValues.add(txt_cgpan);
				//arrValues.add(Helper.correctNull((String)hshValues.get("PrevCGPan")));
				//arrValues.add(Helper.correctNull((String)hshValues.get("TL_DtOutsAmnt")));
				//arrValues.add(Helper.correctNull((String)hshValues.get("TL_DtFstInsDue")));
			//	arrValues.add(Helper.correctNull((String)hshValues.get("TransDate")));
				//arrValues.add(Helper.correctNull((String)hshValues.get("TL_DtFstDisbursment")));
				//arrValues.add(Helper.correctNull((String)hshValues.get("TL_DtLstDisbursment")));//44
				arrValues.add(Helper.getCurrentDateTime());
				//arrValues.add(Helper.correctNull((String)hshValues.get("OFBDt")));
				//arrValues.add(Helper.correctNull((String)hshValues.get("ONFBdT")));
				
			 // arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));
				//arrValues.add(Helper.getCurrentDateTime());
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_cgtmse_coverage")));
				
				arrValues.add(Helper.correctNull((String)hshValues.get("Outstand_Amt")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_npa")));
				arrValues.add(Helper.correctNull((String)hshValues.get("availamt_gurantee")));				
				arrValues.add(Helper.correctNull((String)hshValues.get("selfirstcharge")));				
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_internalRating")));				
				arrValues.add(Helper.correctNull((String)hshValues.get("IssueDate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_ourbankcover")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_cgtmse_defaulter")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_Existing")));
				arrValues.add(Helper.correctNull((String)hshValues.get("cgtmse_cibil_msme_rank")));
				arrValues.add(Helper.correctNull((String)hshValues.get("cgtmse_rep_year")));
				//arrValues.add(Helper.correctNull((String)hshValues.get("sel_Loantype")));
				//arrValues.add(Helper.correctNull((String)hshValues.get("sel_Constitution")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_Treagri")));
				arrValues.add(Helper.correctNull((String)hshValues.get("NewNCGTC")));
				arrValues.add(Helper.correctNull((String)hshValues.get("TypeOfActivity")));
				//arrValues.add(Helper.correctDouble((String)hshValues.get("TC_PromoEntity")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("unit_engaged")));// Whether unit is Engaged with EDU/tri/Agri
				
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","CropCgtmse_insert");			
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				
				arrValues = new ArrayList();
			    hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_cgtmse_coverage")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_ourbankcover")));
				arrValues.add(Helper.correctNull((String)hshValues.get("availamt_gurantee")));			
				arrValues.add(Helper.correctNull((String)hshValues.get("appno")));
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","upd_CGTMSE_AMOUNTCoverage");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			
		}	
		
		catch (Exception e)
		{
			throw new EJBException(e.toString());
		} 
	
	}
	
	
	
	public HashMap getCropCgtmse(HashMap hshValues) 
	{

		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		ResultSet rs3=null;
		
		HashMap hshRecord=new HashMap();
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strSno=Helper.correctInt((String)hshValues.get("sel_facilitysno"));
		String strCondition = Helper.correctNull((String)hshValues.get("hidCondtion"));
	
		String strQuery="";
		String strQuery2="";
		String strQuery3="";
		String strQuery4="",strAppid="";
		String strPrevCGPan = "",strperappId="";
		double dblCGTMSEAmt=0.0;
		try
		{
			strQuery=SQLParser.getSqlQuery("sel_for_cgdetails_new^"+strAppno+"^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				strAppid=Helper.correctNull(rs.getString("perapp_oldid"));
				hshRecord.put("MSERegNo",correctNull((String)rs.getString("PERAPP_MSE_REGNO")));
				hshRecord.put("UdyogAadharNo",correctNull((String)rs.getString("PERAPP_UDYOG_AADHAR")));
				hshRecord.put("PERAPP_CONSTITUTION",correctNull((String)rs.getString("PERAPP_CONSTITUTION")));
				hshRecord.put("owned_by_women",correctNull((String)rs.getString("owned_by_women")));
				strperappId=Helper.correctInt(rs.getString("perapp_id"));
				
				rs1=DBUtils.executeLAPSQuery("selborrowerdet_company^"+Helper.correctInt(rs.getString("perapp_id")));
				if(rs1.next())
				{
					hshRecord.put("cominfo_total_employees",correctNull((String)rs1.getString("cominfo_total_employees")));
				}
				rs2=DBUtils.executeLAPSQuery("sel_minordetails^"+Helper.correctInt(rs.getString("perapp_id")));
				if(rs2.next())
				{
					hshRecord.put("indinfo_minority",correctNull((String)rs2.getString("indinfo_minority")));
					hshRecord.put("indinfo_caste",correctNull((String)rs2.getString("indinfo_caste")));
					String strCaste=correctNull((String)rs2.getString("indinfo_caste"));
					
					rs3=DBUtils.executeLAPSQuery("sel_caste^"+strCaste);
					if(rs3.next())
					{
						hshRecord.put("CBS_STATIC_DATA_DESC",correctNull((String)rs3.getString("CBS_STATIC_DATA_DESC")));
					}
					
					
				}
			
				
			
			}
			hshRecord.put("strAppno",strAppno);
			 //social Category:
			String socialCat="",strSocialCategory="";
			
			

			if(rs!=null){
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("sel_cbsid_promoter^"+strperappId);
			while(rs.next())
			{
				socialCat=Helper.correctNull((String)rs.getString("indinfo_caste"));		
				if(rs2!=null)
				rs2.close();
				rs2=DBUtils.executeLAPSQuery("sel_caste^"+socialCat);
				if(rs2.next())
				{
					strSocialCategory=correctNull((String)rs2.getString("CBS_STATIC_DATA_DESC"));
				}
			}
			
			
			hshRecord.put("strSocialCategory",strSocialCategory);//casteName
			hshRecord.put("promoterCaste",socialCat);//casteno
			
			//System.out.println(socialCat+"social Value Number");
			
			//Previous CGTMSE Cover Details
			
			if(!strAppid.equalsIgnoreCase(""))
			{
				StringBuilder str=new StringBuilder();
				
				
				if(rs2!=null)
					rs2.close();
				strQuery3=SQLParser.getSqlQuery("sel_cgtmsecoveredval^"+strAppid+"^"+strAppid);
				rs2=DBUtils.executeQuery(strQuery3);
				while(rs2.next())
				{
					hshRecord.put("strPreviousCGTMSECover","Y");
					str.append(Helper.correctNull(rs2.getString("TXNDET_CGPAN_NO"))).append("@");
					dblCGTMSEAmt+=Double.parseDouble(Helper.correctDouble(rs2.getString("Coveramt")));
				}
				if(str.length()>1)
				{

					hshRecord.put("PrevCGPan_Fix",str.substring(0, str.length()-1).toString());
				}
				
				hshRecord.put("PrevCGPan1",str.toString());
				
				NumberFormat nf = NumberFormat.getInstance();
				nf.setMaximumFractionDigits(2);
				nf.setMinimumFractionDigits(2);
				nf.setGroupingUsed(false);
				if(rs != null)
				{
					rs.close();
				}
				Double totalAmount=0.00;
				if(Helper.correctNull((String)hshValues.get("sessionModuleType")).equalsIgnoreCase("RET"))
				{
					strQuery = SQLParser.getSqlQuery("CGTMSEFlag_SancAmot_RET^"+strAppno);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						totalAmount=rs.getDouble("LOAN_RECMDAMT");
						dblCGTMSEAmt=dblCGTMSEAmt+totalAmount;
						hshRecord.put("totalamount",String.valueOf(nf.format(totalAmount)));					
					}
				}
				else
				{
					strQuery = SQLParser.getSqlQuery("CGTMSEFlag_SancAmot^"+strAppno);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						totalAmount=rs.getDouble("totalamount");
						dblCGTMSEAmt=dblCGTMSEAmt+totalAmount;
						hshRecord.put("totalamount",String.valueOf(nf.format(totalAmount)));					
					}
				}
				
				hshRecord.put("dblCGTMSECover",Helper.formatDoubleValue(dblCGTMSEAmt));
			}
			
			
			
			if(Helper.correctNull((String)hshValues.get("sessionModuleType")).equalsIgnoreCase("RET"))
			{
				strQuery4=SQLParser.getSqlQuery("getlreq^"+strAppno);
				rs3=DBUtils.executeQuery(strQuery4);
				if(rs3.next())
				{
					//hshRecord.put("FacilityNature","2");
					hshRecord.put("FacilityCgtmse",Helper.correctNull(rs3.getString("LOAN_CGTMSE_APPLICABLE")));	
				}
				strQuery4=SQLParser.getSqlQuery("getprddesc^"+strAppno);
				rs3=DBUtils.executeQuery(strQuery4);
				if(rs3.next())
				{
					hshRecord.put("FacilityNature",Helper.correctNull(rs3.getString("PRD_LOANTYPE")));	
				}
			}
			else
			{
				strQuery4=SQLParser.getSqlQuery("editCropCgtmse^"+strAppno+"^"+strSno);
				rs3=DBUtils.executeQuery(strQuery4);
				if(rs3.next())
				{
					hshRecord.put("FacilityNature",Helper.correctNull(rs3.getString("COM_FACNATURE")));
					hshRecord.put("FacilityCgtmse",Helper.correctNull(rs3.getString("FACILITY_WHT_CGTMSEAPPLY")));	
				}
				
				if(rs!=null)
					rs.close();
				strQuery=SQLParser.getSqlQuery("sel_cgtmsedetails^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					if(Helper.correctNull(rs.getString("CG_PROPOSALNO")).equalsIgnoreCase(""))
					{
						hshRecord.put("strCGTMSEFlag","N");
					}
				}
			}
			if(rs!=null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("selloanagainstparams^115");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
					hshRecord.put("strParamVal",Helper.correctNull(rs.getString("LOAN_PARAMVAL")));
			}
			
			strQuery2=SQLParser.getSqlQuery("sel_CropCgtmse_app_Exstng^"+strAppno+"^"+strSno);
			rs1=DBUtils.executeQuery(strQuery2);
			
			
				if(rs1.next())
				{	
				hshRecord.put("isThere","YES");
				hshRecord.put("facility",strSno);
				}
				else
				{
					hshRecord.put("isThere","NO");
					hshRecord.put("facility",strSno);
					if(Helper.correctNull((String)hshValues.get("sessionModuleType")).equalsIgnoreCase("RET"))
						hshRecord.put("strCGTMSEFlag","N");
				}
				
				strQuery=SQLParser.getSqlQuery("sel_applicationExstng_fac^"+strAppno+"^"+strSno);
				rs1=DBUtils.executeQuery(strQuery2);
				if(rs1.next())
				{	
					hshRecord.put("Corp_ApplicationExist","YES");
				}
				else
				{
					hshRecord.put("Corp_ApplicationExist","NO");
				}
				strQuery3=SQLParser.getSqlQuery("sel_CropCgtmse^"+strAppno+"^"+strSno);
				rs2=DBUtils.executeQuery(strQuery3);
				if(rs2.next())
				{		
					hshRecord.put("Sno",correctNull((String)rs2.getString("CG_SNO")));
					hshRecord.put("Npa",correctNull((String)rs2.getString("CG_NPA")));
					hshRecord.put("MicEntp",correctNull((String)rs2.getString("CG_MIC_ENTP")));
					hshRecord.put("ProjOptiSales",correctNull((String)rs2.getString("CG_PROJ_OPTI_SALES")));
					hshRecord.put("ProjOptiExport",correctNull((String)rs2.getString("CG_PROJ_OPTI_EXPORT")));
			
					hshRecord.put("Newunit",correctNull((String)rs2.getString("CG_NEW_UNIT")));
					
					
					hshRecord.put("NewunitWO",correctNull((String)rs2.getString("CG_NEW_UNIT_WO")));
					hshRecord.put("MSEunit",correctNull((String)rs2.getString("CG_MSE_UNIT")));
					hshRecord.put("MSEunitWO",correctNull((String)rs2.getString("CG_MSE_UNIT_WO")));
					hshRecord.put("MSMEDunit",correctNull((String)rs2.getString("CG_MSMED")));
					hshRecord.put("ArtisanCC",correctNull((String)rs2.getString("CG_ARTISAN_CC")));
					hshRecord.put("GF_ASF",correctNull((String)rs2.getString("CG_GF_ASF")));
					
					
					hshRecord.put("IdentyDC",correctNull((String)rs2.getString("CG_IDENTY_DC")));
			
					hshRecord.put("TC_PromoContrbtn",correctNull((String)rs2.getString("CG_TC_PROMOTERS")));
					
					hshRecord.put("TC_Subsidy",correctNull((String)rs2.getString("CG_TC_SUBSIDY")));
					hshRecord.put("TC_Others",correctNull((String)rs2.getString("CG_TC_OTHERS")));
					hshRecord.put("TC_ProjCost",correctNull((String)rs2.getString("CG_TC_PROJ_COST")));
					hshRecord.put("TC_ProjOutlay",correctNull((String)rs2.getString("CG_TC_PROJ_OUTLAY")));
			
					
			
					hshRecord.put("TL_MarginMoney",correctNull((String)rs2.getString("CG_TL_MARGIN_MONEY")));
			
					hshRecord.put("WC_Assesse",correctNull((String)rs2.getString("CG_WC_ASSESSED")));
					
					
					
					
					
					hshRecord.put("CreateDate",correctNull((String)rs2.getString("CG_CREATED_DATE")));
	
					
					
					hshRecord.put("AsistBank",correctNull((String)rs2.getString("CG_ASISTBANK")));
					hshRecord.put("NatureIndustry",correctNull((String)rs2.getString("CG_NATUREINDUSTRY")));
					hshRecord.put("IndustrySector",correctNull((String)rs2.getString("CG_INDUSTRYSECTOR")));
					hshRecord.put("NoEmp",correctNull((String)rs2.getString("CG_NOEMP")));
					
					hshRecord.put("MinCommuity",correctNull((String)rs2.getString("CG_MINCOMMUITY")));	
					
					hshRecord.put("SocialCatgry",correctNull((String)rs2.getString("CG_SOCIALCATGRY")));
					hshRecord.put("legalId",correctNull((String)rs2.getString("CG_LEGALID")));						
					hshRecord.put("LegalIdNo",correctNull((String)rs2.getString("CG_LEGALIDNO")));
					hshRecord.put("OtherIDName",correctNull((String)rs2.getString("CG_OTHERIDNAME")));
					hshRecord.put("OtherIDNo",correctNull((String)rs2.getString("CG_OTHERIDNO")));
					hshRecord.put("ColSec",correctNull((String)rs2.getString("CG_COLSEC")));
					
					
					hshRecord.put("ThirdParty",correctNull((String)rs2.getString("CG_THIRDPARTY")));
					hshRecord.put("JointFinance",correctNull((String)rs2.getString("CG_JOINTFINANCE")));
					hshRecord.put("JFCGpan",correctNull((String)rs2.getString("CG_JFCGPAN")));
					hshRecord.put("HandloomScheme",correctNull((String)rs2.getString("CG_HANDLOOMSCHEME")));
					hshRecord.put("Namescheme",correctNull((String)rs2.getString("CG_NAMESCHEME")));
					hshRecord.put("checkBx",correctNull((String)rs2.getString("CG_CHECKBX")));
					hshRecord.put("PrevCGTMSE",correctNull((String)rs2.getString("CG_PRV_CGP")));
					hshRecord.put("PrevCGPan",correctNull((String)rs2.getString("CG_PREV_CGPAN")));	
					hshRecord.put("CG_CGTMSE_COVERAGE",correctNull((String)rs2.getString("CG_CGTMSE_COVERAGE")));	
					hshRecord.put("CG_APPDET_OUTSTAN_AMT",correctNull((String)rs2.getString("CG_APPDET_OUTSTAN_AMT")));
					hshRecord.put("CG_APPDET_NPA",correctNull((String)rs2.getString("CG_APPDET_NPA")));
					hshRecord.put("CG_HANDICRAFT_AVAIL_AMT",correctNull((String)rs2.getString("CG_HANDICRAFT_AVAIL_AMT")));
					hshRecord.put("CG_FIRSTCHARGE",correctNull((String)rs2.getString("cg_firstcharge")));
					hshRecord.put("CG_INTERNAL_RATING",correctNull((String)rs2.getString("CG_INTERNAL_RATING")));
					hshRecord.put("IssueDate",correctNull(rs2.getString("CG_ISSUEDATE")));
					//hshRecord.put("dblCGTMSECover",Helper.correctDouble(rs2.getString("cg_ourbank_coverage")));
					hshRecord.put("CG_DEFAULTER",correctNull((String)rs2.getString("CG_DEFAULTER")));
					hshRecord.put("CG_Existing",correctNull((String)rs2.getString("CG_Existing")));
					hshRecord.put("CG_CIBIL_MSME_RANK",correctNull((String)rs2.getString("CG_CIBIL_MSME_RANK")));
					hshRecord.put("CG_REPAY_YEAR",correctNull((String)rs2.getString("CG_REPAY_YEAR")));
					//hshRecord.put("CG_LOANTYPE",correctNull((String)rs2.getString("CG_LOANTYPE")));
					//hshRecord.put("CG_CONSTITUTION",correctNull((String)rs2.getString("CG_CONSTITUTION")));
					hshRecord.put("CG_EDUCATION",correctNull((String)rs2.getString("CG_EDUCATION")));
					hshRecord.put("CG_NCGTC",correctNull((String)rs2.getString("CG_NCGTC")));
					hshRecord.put("CG_TYPEOFLOAN",correctNull((String)rs2.getString("CG_TYPEOFLOAN")));
					//hshRecord.put("TC_PromoEntity",correctNull((String)rs2.getString("CG_TC_PROMOENTITY")));
					hshRecord.put("CG_UNIT_ENGAGED",correctNull((String)rs2.getString("CG_UNIT_ENGAGED")));
				}
				strQuery3=SQLParser.getSqlQuery("sel_CropCgtmse_flagcheck^"+strAppno+"^"+strSno);
				rs2=DBUtils.executeQuery(strQuery3);
				if(rs2.next())
				{
					hshRecord.put("CG_FlagCheck","Y");
				}
				else
				{
					hshRecord.put("CG_FlagCheck","N");
				}
				strQuery3=SQLParser.getSqlQuery("sel_CGTMSE_AMOUNTCoverage^"+strAppno);
				rs2=DBUtils.executeQuery(strQuery3);
				if(rs2.next())
				{
					hshRecord.put("CG_CGTMSE_COVERAGE",correctNull((String)rs2.getString("Other_coverage")));
					hshRecord.put("CG_HANDICRAFT_AVAIL_AMT",correctNull((String)rs2.getString("Balance_AMT")));
				}
				
				
		}
	
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
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
				if(rs3 != null)
				{
					rs3.close();
				}
			}
			catch(Exception e1)
			{
				throw new EJBException("Error closing connection"+e1);
			}
		}
		return hshRecord;
		
	
	}
	public HashMap getCropCgtmseAnnexure(HashMap hshValues) 
	{      
		ResultSet rs=null;
    ResultSet rs1=null;
    ResultSet rs2=null;
    ResultSet rs3=null;
    ResultSet rs4=null;
	HashMap hshRecord=new HashMap();
	String appno=Helper.correctNull((String)hshValues.get("appno"));
	String strQuery="",strQuery1="",strQuery2="",strQuery3="",strQuery4="",CG_NATUREINDUSTRY="",CG_INDUSTRYSECTOR="",CG_SOCIALCATGRY="",CG_LEGALID="",CG_NAMESCHEME="",CG_TYPEOFLOAN="";
	String strappId = Helper.correctNull((String)hshValues.get("comappid"));
	String nature = Helper.correctNull((String)hshValues.get("hidnature"));
	String strSno=Helper.correctNull((String)hshValues.get("facilityload"));
	int sno=Integer.parseInt(strSno);
	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
	nf.setMinimumFractionDigits(2);
	nf.setMaximumFractionDigits(2);
	nf.setGroupingUsed(false);
	String sectype="",cbsid="",cusid="";
	String strCity="",strState="",strCountry = "",strdistrict="",MCLRtype="",strAppId="",loanType="",facilityLoanType="";
	double ExistingAmt=0,proposedAmt=0;
	try
		{	
		
		
		strQuery4=SQLParser.getSqlQuery("editCropCgtmse^"+appno+"^"+strSno);
		rs3=DBUtils.executeQuery(strQuery4);
		while(rs3.next())
		{
			hshRecord.put("FacilityNature",Helper.correctNull((String)rs3.getString("COM_FACNATURE")));
			hshRecord.put("FacilityCgtmse",Helper.correctNull((String)rs3.getString("FACILITY_WHT_CGTMSEAPPLY")));	
			hshRecord.put("Facilitytype",Helper.correctNull((String)rs3.getString("com_factype")));	
			String cgtMseFlag= Helper.correctNull((String)rs3.getString("FACILITY_WHT_CGTMSEAPPLY"));
			ExistingAmt=Double.parseDouble(Helper.correctNull((String)rs3.getString("FACILITY_EXISTING")));
			proposedAmt=Double.parseDouble(Helper.correctNull((String)rs3.getString("FACILITY_PROPOSED")));
			
			if(cgtMseFlag.equalsIgnoreCase("Y"))
			{
				//loanType=correctNull((String)rs3.getString("COM_FACCODE"));
				loanType=correctNull((String)rs3.getString("COM_FACNATURE"));
				facilityLoanType=correctNull((String)rs3.getString("facility_sel_type"));
				
				    if(loanType.equalsIgnoreCase("1") &&  !facilityLoanType.equalsIgnoreCase("2"))
				    {
				    	 if(ExistingAmt > proposedAmt)
				    	 {
				    		 loanType="Enhancement in WC";
				    	 }else{
				    		 loanType="Working Capital";
				    	 }
				    	
				    }else if(loanType.equalsIgnoreCase("1") &&  facilityLoanType.equalsIgnoreCase("2"))
				      {
				    	 
				    		 loanType="Renewal of Cover for WC";
				    	 
				      }else if(loanType.equalsIgnoreCase("WC")){
				    	     loanType="Working Capital";
				      }
				      else if(loanType.equalsIgnoreCase("2")){
				    	  loanType="Term Loan";
				      }
				       
				
			}
		}
		 hshRecord.put("loantype",loanType);
		
		
		
	if(rs!= null)
	{	rs.close();  }
		strQuery = SQLParser.getSqlQuery("sel_cgtmseCorp3^"+appno+"^"+sno);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			hshRecord.put("CG_MIC_ENTP",correctNull((String)rs.getString("CG_MIC_ENTP")));
			hshRecord.put("CG_PROJ_OPTI_SALES",correctNull((String)rs.getString("CG_PROJ_OPTI_SALES")));
			hshRecord.put("CG_PROJ_OPTI_EXPORT",correctNull((String)rs.getString("CG_PROJ_OPTI_EXPORT")));
			hshRecord.put("CG_ASISTBANK",correctNull((String)rs.getString("CG_ASISTBANK")));
			hshRecord.put("CG_NOEMP",correctNull((String)rs.getString("CG_NOEMP")));
			hshRecord.put("CG_MINCOMMUITY",correctNull((String)rs.getString("CG_MINCOMMUITY")));
			CG_SOCIALCATGRY=Helper.correctNull((String)rs.getString("CG_SOCIALCATGRY"));
			CG_LEGALID=Helper.correctNull((String)rs.getString("CG_LEGALID"));
			hshRecord.put("CG_NEW_UNIT",correctNull((String)rs.getString("CG_NEW_UNIT")));
			hshRecord.put("CG_NEW_UNIT_WO",correctNull((String)rs.getString("CG_NEW_UNIT_WO")));
			hshRecord.put("CG_MSE_UNIT",correctNull((String)rs.getString("CG_MSE_UNIT")));
			hshRecord.put("CG_COLSEC",correctNull((String)rs.getString("CG_COLSEC")));
			hshRecord.put("CG_THIRDPARTY",correctNull((String)rs.getString("CG_THIRDPARTY")));
			hshRecord.put("CG_JOINTFINANCE",correctNull((String)rs.getString("CG_JOINTFINANCE")));
			hshRecord.put("CG_JFCGPAN",correctNull((String)rs.getString("CG_JFCGPAN")));
			hshRecord.put("CG_ARTISAN_CC",correctNull((String)rs.getString("CG_ARTISAN_CC")));
			hshRecord.put("CG_GF_ASF",correctNull((String)rs.getString("CG_GF_ASF")));
			hshRecord.put("CG_IDENTY_DC",correctNull((String)rs.getString("CG_IDENTY_DC")));
			hshRecord.put("CG_HANDLOOMSCHEME",correctNull((String)rs.getString("CG_HANDLOOMSCHEME")));
			/*String handloomschemename=correctNull((String)rs.getString("CG_NAMESCHEME"));
			if(handloomschemename.equals("MCS"))
				hshRecord.put("CG_NAMESCHEME","Mega cluster scheme (varanashi/murshidabad)");
			else if(handloomschemename.equals("IHDS"))
				hshRecord.put("CG_NAMESCHEME","Integrated handloom development scheme");*/
			CG_NAMESCHEME=correctNull((String)rs.getString("CG_NAMESCHEME"));
			hshRecord.put("CG_TC_PROMOTERS",correctNull((String)rs.getString("CG_TC_PROMOTERS")));
		
			hshRecord.put("CG_TC_SUBSIDY",correctNull((String)rs.getString("CG_TC_SUBSIDY")));
			hshRecord.put("CG_TC_OTHERS",correctNull((String)rs.getString("CG_TC_OTHERS")));
		
			hshRecord.put("CG_TC_PROJ_COST",correctNull((String)rs.getString("CG_TC_PROJ_COST")));
			hshRecord.put("CG_TC_PROJ_OUTLAY",correctNull((String)rs.getString("CG_TC_PROJ_OUTLAY")));
			
			hshRecord.put("CG_LEGALIDNO",correctNull((String)rs.getString("CG_LEGALIDNO")));
			hshRecord.put("CG_OTHERIDNAME",correctNull((String)rs.getString("CG_OTHERIDNAME")));
			hshRecord.put("CG_OTHERIDNO",correctNull((String)rs.getString("CG_OTHERIDNO")));
			
			hshRecord.put("CG_NPA",correctNull((String)rs.getString("CG_NPA")));
			
			hshRecord.put("CG_PRV_CGP",correctNull((String)rs.getString("CG_PRV_CGP")));
			hshRecord.put("CG_CHECKBX",correctNull((String)rs.getString("CG_CHECKBX")));
			CG_NATUREINDUSTRY=Helper.correctNull((String)rs.getString("CG_NATUREINDUSTRY"));
			//CG_INDUSTRYSECTOR=Helper.correctNull((String)rs.getString("CG_INDUSTRYSECTOR"));
			CG_TYPEOFLOAN=Helper.correctNull((String)rs.getString("CG_TYPEOFLOAN"));
			CG_INDUSTRYSECTOR=Helper.correctNull((String)rs.getString("CG_INDUSTRYSECTOR"));
			hshRecord.put("CG_PREV_CGPAN",correctNull((String)rs.getString("CG_PREV_CGPAN")));
			hshRecord.put("CG_TL_MARGIN_MONEY",correctNull((String)rs.getString("CG_TL_MARGIN_MONEY")));
			hshRecord.put("CG_WC_ASSESSED",correctNull((String)rs.getString("CG_WC_ASSESSED")));
			
			hshRecord.put("CG_APPDET_OUTSTAN_AMT",correctNull((String)rs.getString("CG_APPDET_OUTSTAN_AMT")));
			hshRecord.put("CG_APPDET_NPA",correctNull((String)rs.getString("CG_APPDET_NPA")));
			hshRecord.put("CG_HANDICRAFT_AVAIL_AMT",correctNull((String)rs.getString("CG_HANDICRAFT_AVAIL_AMT")));
			hshRecord.put("cg_firstcharge",correctNull(rs.getString("cg_firstcharge")));
			hshRecord.put("CG_INTERNAL_RATING",correctNull((String)rs.getString("CG_INTERNAL_RATING")));
			hshRecord.put("CG_ISSUEDATE",correctNull(rs.getString("CG_ISSUEDATE")));
			hshRecord.put("CG_MSE_UNIT_WO",correctNull((String)rs.getString("CG_MSE_UNIT_WO")));
			hshRecord.put("CG_CIBIL_MSME_RANK",correctNull((String)rs.getString("CG_CIBIL_MSME_RANK")));
			hshRecord.put("CG_REPAY_YEAR",correctNull((String)rs.getString("CG_REPAY_YEAR")));
			//hshRecord.put("CG_TC_PROMOENTITY",correctNull((String)rs.getString("CG_TC_PROMOENTITY")));
			hshRecord.put("CG_UNIT_ENGAGED",correctNull((String)rs.getString("CG_UNIT_ENGAGED")));
			hshRecord.put("CG_NCGTC",correctNull((String)rs.getString("CG_NCGTC")));
		}	
		
		strQuery=SQLParser.getSqlQuery("sel_cgtmseanx4^210^"+CG_NATUREINDUSTRY);
		rs1=DBUtils.executeQuery(strQuery);
		while(rs1.next())
		{				
			 //hshRecord.put("STAT_DATA_DESC1",correctNull((String)rs1.getString("STAT_DATA_DESC1")));
			hshRecord.put("STAT_DATA_DESC1",Helper.correctNull((String)rs1.getString("STAT_DATA_DESC"))+"-"+Helper.correctNull((String)rs1.getString("STAT_DATA_DESC1")));
						
		}
		/*if(rs1!= null)
		{	rs1.close();  }*/
		strQuery=SQLParser.getSqlQuery("sel_cgtmseanx4^283^"+CG_TYPEOFLOAN);
		rs2=DBUtils.executeQuery(strQuery);
		while(rs2.next())
		{				
			hshRecord.put("STAT_DATA_DESC2",correctNull((String)rs2.getString("STAT_DATA_DESC1")));						
		}
		strQuery=SQLParser.getSqlQuery("sel_cgtmseanx4^211^"+CG_INDUSTRYSECTOR);
		rs2=DBUtils.executeQuery(strQuery);
		while(rs2.next())
		{				
			hshRecord.put("STAT_DATA_DESC",correctNull((String)rs2.getString("STAT_DATA_DESC1")));						
		}
		strQuery=SQLParser.getSqlQuery("sel_cgtmseanx4^242^"+CG_SOCIALCATGRY);
		rs=DBUtils.executeQuery(strQuery);
		while(rs.next())
		{				
			hshRecord.put("CG_SOCIALCATGRY",correctNull((String)rs.getString("STAT_DATA_DESC1")));
						
		}
		strQuery=SQLParser.getSqlQuery("sel_cgtmseanx4^54^"+CG_LEGALID);
		rs=DBUtils.executeQuery(strQuery);
		while(rs.next())
		{				
			hshRecord.put("CG_LEGALID",correctNull((String)rs.getString("STAT_DATA_DESC1")));
						
		}
	
	strQuery=SQLParser.getSqlQuery("sel_cgtmseanx4^241^"+CG_NAMESCHEME);
	rs=DBUtils.executeQuery(strQuery);
	while(rs.next())
	{				
		hshRecord.put("CG_NAMESCHEME",correctNull((String)rs.getString("STAT_DATA_DESC1")));						
	}

		//Security - LAND
		ArrayList arrAppSec_Land=new ArrayList();
		ArrayList arrAppSec_LandRow=new ArrayList();
		sectype="10";
		strQuery = SQLParser.getSqlQuery("sel_CropCgtmseApp_secClasstype^"+ appno+"^1^P^"+sectype+"^"+sno);
		rs = DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			arrAppSec_Land=new ArrayList();
			arrAppSec_Land.add(Helper.correctNull((String)rs.getString("sec_name"))); //0
			arrAppSec_Land.add(Helper.CLOBToString(rs.getClob("APP_SEC_DESCRIPTION"))); //1
			arrAppSec_Land.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("APP_SEC_SECURITYVALUE"))))); //2
			arrAppSec_LandRow.add(arrAppSec_Land);
		}
		hshRecord.put("arrAppSec_LandRow", arrAppSec_LandRow);

		//Security - BUILDING
		ArrayList arrAppSec_Build=new ArrayList();
		ArrayList arrAppSec_BuildRow=new ArrayList();
		sectype="11','12','13','14','15','16','17";
		strQuery = SQLParser.getSqlQuery("sel_CropCgtmseApp_secClasstype^"+ appno+"^1^P^"+sectype+"^"+sno);
		rs = DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			arrAppSec_Build=new ArrayList();
			arrAppSec_Build.add(Helper.correctNull((String)rs.getString("sec_name"))); //0
			arrAppSec_Build.add(Helper.CLOBToString(rs.getClob("APP_SEC_DESCRIPTION"))); //1
			arrAppSec_Build.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("APP_SEC_SECURITYVALUE"))))); //2
			arrAppSec_BuildRow.add(arrAppSec_Build);
		}
		hshRecord.put("arrAppSec_BuildRow", arrAppSec_BuildRow);

		//Security - Plant and Machinery
		ArrayList arrAppSec_plantmach=new ArrayList();
		ArrayList arrAppSec_plantmachRow=new ArrayList();
		sectype="19";
		strQuery = SQLParser.getSqlQuery("sel_CropCgtmseApp_secClasstype^"+ appno+"^1^P^"+sectype+"^"+sno);
		rs = DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			arrAppSec_plantmach=new ArrayList();
			arrAppSec_plantmach.add(Helper.correctNull((String)rs.getString("sec_name"))); //0
			arrAppSec_plantmach.add(Helper.CLOBToString(rs.getClob("APP_SEC_DESCRIPTION"))); //1
			arrAppSec_plantmach.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("APP_SEC_SECURITYVALUE"))))); //2
			arrAppSec_plantmachRow.add(arrAppSec_plantmach);
		}
		hshRecord.put("arrAppSec_plantmachRow", arrAppSec_plantmachRow);
	
		//Security - Other Fixed/ Movable Assets
		ArrayList arrAppSec_vehicleFur=new ArrayList();
		ArrayList arrAppSec_vehicleFurRow=new ArrayList();
		sectype="18','20";
		strQuery = SQLParser.getSqlQuery("sel_CropCgtmseApp_secClasstype^"+ appno+"^1^P^"+sectype+"^"+sno);
		rs = DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			arrAppSec_vehicleFur=new ArrayList();
			arrAppSec_vehicleFur.add(Helper.correctNull((String)rs.getString("sec_name"))); //0
			arrAppSec_vehicleFur.add(Helper.CLOBToString(rs.getClob("APP_SEC_DESCRIPTION"))); //1
			arrAppSec_vehicleFur.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("APP_SEC_SECURITYVALUE"))))); //2
			arrAppSec_vehicleFurRow.add(arrAppSec_vehicleFur);
		}
		hshRecord.put("arrAppSec_vehicleFurRow", arrAppSec_vehicleFurRow);
	

		//Security - Current Assets
		ArrayList arrAppSec_stockbook=new ArrayList();
		ArrayList arrAppSec_stockbookRow=new ArrayList();
		sectype="3','4";
		strQuery = SQLParser.getSqlQuery("sel_CropCgtmseApp_secClasstype^"+ appno+"^1^P^"+sectype+"^"+sno);
		rs = DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			arrAppSec_stockbook=new ArrayList();
			arrAppSec_stockbook.add(Helper.correctNull((String)rs.getString("sec_name"))); //0
			arrAppSec_stockbook.add(Helper.CLOBToString(rs.getClob("APP_SEC_DESCRIPTION"))); //1
			arrAppSec_stockbook.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("APP_SEC_SECURITYVALUE"))))); //2
			arrAppSec_stockbookRow.add(arrAppSec_stockbook);
		}
		hshRecord.put("arrAppSec_stockbookRow", arrAppSec_stockbookRow);
		
		//Security - Others
		ArrayList arrAppSec_others=new ArrayList();
		ArrayList arrAppSec_othersRow=new ArrayList();
		sectype="1','2','5','6','7','8','9','21','22','23','24";
		strQuery = SQLParser.getSqlQuery("sel_CropCgtmseApp_secClasstype^"+ appno+"^1^P^"+sectype+"^"+sno);
		rs = DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			arrAppSec_others=new ArrayList();
			arrAppSec_others.add(Helper.correctNull((String)rs.getString("sec_name"))); //0
			arrAppSec_others.add(Helper.CLOBToString(rs.getClob("APP_SEC_DESCRIPTION"))); //1
			arrAppSec_others.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("APP_SEC_SECURITYVALUE"))))); //2
			arrAppSec_othersRow.add(arrAppSec_others);
		}
		hshRecord.put("arrAppSec_othersRow", arrAppSec_othersRow);
		
		if(rs!= null)
		{
			rs.close();
		}
		rs3=DBUtils.executeLAPSQuery("sel_cbsidPerapplicant^"+strappId);
		if(rs.next())
		{
			hshRecord.put("CHF_PROMOTER",Helper.correctNull(rs3.getString("COMAPP_CHF_PROMOTER")));
			cbsid=Helper.correctNull(rs3.getString("COMAPP_CBSID"));	
		}
		if(rs!= null)
		{
			rs.close();
		}
		rs3=DBUtils.executeLAPSQuery("sel_cbsid_promoter^"+strappId);
		if(rs.next())
		{
			
			hshRecord.put("PROMOTER_AADHAAR",Helper.correctNull(rs3.getString("PERAPP_AADHAAR")));
			hshRecord.put("phyCallenged",Helper.correctNull(rs3.getString("INDINFO_PHYSICALLY_CHALLANGED")));
			hshRecord.put("PROMOTER_MOBILE",Helper.correctNull(rs3.getString("CON_MOBILE")));
			hshRecord.put("promoNetworth",Helper.correctNull(rs3.getString("PERAPP_NETWORTH")));
		}
		
		if(rs!= null)
		{
			rs.close();
		}
		rs3=DBUtils.executeLAPSQuery("sel_cbsid_promoterExperience^"+strappId);
		if(rs.next())
		{
			hshRecord.put("emp_experience",Helper.correctNull(rs3.getString("PEREMP_EXPINYRS")));
		}
	
		
		if(rs!= null)
		{	rs.close();  }
		
	/*	strQuery = SQLParser.getSqlQuery("sel_app_processorgscode^"+appno);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			hshRecord.put("processedorg_name",Helper.correctNull((String)rs.getString("org_name")));
			hshRecord.put("processedORG_SCODE",Helper.correctNull((String)rs.getString("ORG_SCODE")));
		}*/
		strQuery =SQLParser.getSqlQuery("sel_cbsdetails^"+appno+"^"+sno); 
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			String strDisbBrCode=Helper.correctInt(rs.getString("LOANDISBBRANCH"));
			hshRecord.put("processedORG_SCODE",strDisbBrCode);
			if(!strDisbBrCode.equalsIgnoreCase(""))
			{
				if(rs1!=null){rs1.close();}
				rs1=DBUtils.executeLAPSQuery("sel_organisationname^"+strDisbBrCode);		 
				if(rs1.next())
				{
					hshRecord.put("processedorg_name",Helper.correctNull((String)rs1.getString("org_name")));
					//hshRecord.put("processedorg_state",Helper.correctNull((String)rs1.getString("org_state")));
					String processedorg_state = Helper.correctNull(rs1.getString("org_state"));
					if(rs!= null)
					{	rs.close();  }
					strQuery = SQLParser.getSqlQuery("Statename^"+processedorg_state);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshRecord.put("process_orgstate",Helper.correctNull((String)rs.getString("STATE_NAME")));
					}
				}
			}
		}
		if(rs!= null)
		{	rs.close();  }
		strQuery = SQLParser.getSqlQuery("sel_rating_nonPoolFlag^"+appno);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			hshRecord.put("cre_weight",Helper.correctNull((String)rs.getString("cre_weight")));
		}
		else
		{
			if(rs1!= null)
			{	rs1.close();  }
			strQuery = SQLParser.getSqlQuery("sel_rating_poolFlag^"+appno);
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				hshRecord.put("cre_weight",Helper.correctNull((String)rs1.getString("cre_weight")));
			}
		}
		
		if(rs!=null){ rs.close(); }
	 	strQuery=SQLParser.getSqlQuery("sel_tl_repayschedule^"+appno+"^"+sno);
		rs=DBUtils.executeQuery(strQuery);
		int totalinst=0;
		while(rs.next())
		{
			String frq=correctNull((String)rs.getString("TL_FEQUENCY"));
			if(frq.equalsIgnoreCase("M"))
				frq="Monthly";
			else if(frq.equalsIgnoreCase("Y"))
				frq="Yearly";
			else if(frq.equalsIgnoreCase("Q"))
				frq="Quarterly";
			else if(frq.equalsIgnoreCase("H"))
				frq="Half Yearly";
			else
				frq="";
			hshRecord.put("LOAN_PERIODICITY",frq);
				totalinst=totalinst + (Integer.parseInt(Helper.correctInt((String)rs.getString("TL_NOOFINST"))));
		} 
		hshRecord.put("loan_noofinstall",String.valueOf(totalinst));
		
		// end for harish
		
		hshRecord.put("strAppno",appno);	
		if(rs!= null)
		{	rs.close(); 
		}
		String StrValuesin="";
		strQuery1 = SQLParser.getSqlQuery("selprosalvaluesin^"+appno);
		rs = DBUtils.executeQuery(strQuery1);
		if(rs.next())
		{
			StrValuesin=Helper.correctNull((String)rs.getString("prop_valuesin"));
		}
		if(rs!= null)
		{	rs.close(); 
		}
		
		double dblSanctionAmt=0.00;
		strQuery1 = SQLParser.getSqlQuery("sel_cgtmseanxFac_new^"+appno+"^"+sno);
		rs = DBUtils.executeQuery(strQuery1);
		if(rs.next())
		{
			hshRecord.put("FACILITY_HOLIDAYPERIOD",Helper.correctNull((String)rs.getString("FACILITY_HOLIDAYPERIOD")));
			hshRecord.put("FACILITY_PERINSTALL",Helper.correctNull((String)rs.getString("FACILITY_PERINSTALL")));
			hshRecord.put("FACILITY_APPNO",Helper.correctNull((String)rs.getString("FACILITY_APPNO")));
			hshRecord.put("FACILITY_SNO",Helper.correctNull((String)rs.getString("FACILITY_SNO")));
			hshRecord.put("FACILITY_MONTHS",Helper.correctNull((String)rs.getString("FACILITY_MONTHS")));
			hshRecord.put("FACILITY_SANCAMT",Helper.correctNull((String)rs.getString("FACILITY_SANCAMT")));
			hshRecord.put("COM_FACTYPE",Helper.correctNull((String)rs.getString("COM_FACTYPE")));
			dblSanctionAmt=Double.parseDouble(Helper.correctDouble((String)rs.getString("FACILITY_SANCAMT")));
			hshRecord.put("FACILITY_SANCINTEREST",Helper.correctNull((String)rs.getString("FACILITY_SANCINTEREST")));
			hshRecord.put("FACILITY_OSASON",Helper.correctNull((String)rs.getString("FACILITY_OSASON")));
			hshRecord.put("APP_PROCESSDATE",correctNull((String)rs.getString("APP_PROCESSDATE")));
			hshRecord.put("CBS_ACCOUNTNO",correctNull((String)rs.getString("CBS_ACCOUNTNO")));
			hshRecord.put("APP_NO",correctNull((String)rs.getString("FACILITY_APPNO")));
			hshRecord.put("FACILITY_DUEDATE",Helper.correctNull(rs.getString("FACILITY_DUEDATE")));
			hshRecord.put("FACILITY_REPAYTYPE",Helper.correctNull(rs.getString("FACILITY_REPAYTYPE")));
			hshRecord.put("FACILITY_INTSUBTYPE",Helper.correctNull(rs.getString("FACILITY_INTSUBTYPE")));
			//hshRecord.put("facility_inttype",Helper.correctNull(rs.getString("facility_inttype")));
			hshRecord.put("FACILITY_BASERATE",Helper.correctNull(rs.getString("FACILITY_BASERATE")));
			String facint=correctNull((String)rs.getString("facility_inttype"));
			if(facint.equalsIgnoreCase("Fix"))
				facint="Fixed";
			else if(facint.equalsIgnoreCase("Flo"))
				facint="Floating";
			else
				facint="";
			hshRecord.put("facility_inttypes",facint);
			
			if(Helper.correctNull(rs.getString("facility_inttype")).equalsIgnoreCase("Flo"))
			{
				if(rs2!=null)
					rs2.close();
				rs2=DBUtils.executeLAPSQuery("sel_facility_mclrspread^"+sno+"^"+appno);
				if(rs2.next())
				{
					MCLRtype=Helper.correctNull(rs2.getString("facility_mclrtype"));
					 if(!MCLRtype.equalsIgnoreCase("")) 
					 {
						 MCLRtype = MCLRtype.split("@")[0];
						 
						 if(rs1!=null)
							 rs1.close();
						 if(Helper.correctNull(rs.getString("FACILITY_MCLR_RELDATE")).equalsIgnoreCase(""))
						 strQuery = SQLParser.getSqlQuery("sel_mclrspreadrate^"+Helper.getCurrentDateTime()+"^"+MCLRtype);
						 else
						 strQuery = SQLParser.getSqlQuery("sel_mclrspreadrate^"+Helper.correctNull(rs.getString("FACILITY_MCLR_RELDATE"))+"^"+MCLRtype);
						 rs1 = DBUtils.executeQuery(strQuery);
						 if(rs1.next())
						 {
							// hshRecord.put("mclr_baseratespread",Helper.correctNull(rs1.getString("mclr_baseratespread")));
						 }
					 }
				}
			}
		
			
		}
		//strQuery1 = DBUtils.executeLAPSQuery("sel_facility_mclrspread^"+sno+"^"+appno);
		if(rs!= null)
		{	rs.close();  }
		rs = DBUtils.executeLAPSQuery("sel_CGTMSEcorp_mclrspread^"+sno+"^"+appno);
		if(rs.next())
		{
			 hshRecord.put("mclr_baseratespread",Helper.correctNull(rs.getString("MCLR_SPREADVAL")));
		}
		String cheifFlag="";
		if(rs!= null)
		{	rs.close();  }
		strQuery = SQLParser.getSqlQuery("sel_cropCgtAppli^"+appno+"^"+sno);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{

			hshRecord.put("fullname",correctNull((String)rs.getString("fullname")));
			hshRecord.put("PERAPP_CONSTITUTION_code",correctNull((String)rs.getString("PERAPP_CONSTITUTIONNEW")));
			hshRecord.put("CONSTITUTION",correctNull((String)rs.getString("PERAPP_CONSTITUTION")));
			hshRecord.put("AADHAAR",correctNull((String)rs.getString("PERAPP_AADHAAR")));	
			if(rs1!= null)
			{
				rs1.close();
			}
				rs1=DBUtils.executeLAPSQuery("sel_CBSStaticDataPassingCode^2^"+Helper.correctInt(rs.getString("PERAPP_CONSTITUTIONNEW")));
				if(rs1.next())
				{
					hshRecord.put("PERAPP_CONSTITUTION",Helper.correctNull(rs1.getString("cbs_static_data_desc"))) ;
				}
			
				if(!correctNull((String)rs.getString("PERAPP_CONSTITUTIONNEW")).equalsIgnoreCase("01"))
				{
					hshRecord.put("PERAPP_PANNO",correctNull((String)rs.getString("PERAPP_PANNO")));
				}
				else
				{
					cheifFlag="Y";
					hshRecord.put("PERAPP_PANNO1",correctNull((String)rs.getString("PERAPP_PANNO")));
				}
			hshRecord.put("PERAPP_NETWORTH",correctNull((String)rs.getString("PERAPP_NETWORTH")));
			hshRecord.put("PERAPP_CBSID",correctNull((String)rs.getString("PERAPP_CBSID")));
			hshRecord.put("PERAPP_MSE_REGNO",correctNull((String)rs.getString("PERAPP_MSE_REGNO")));
			hshRecord.put("PERAPP_UDYOG_AADHAR",correctNull((String)rs.getString("PERAPP_UDYOG_AADHAR")));
			String PERAPP_SEX= correctNull((String)rs.getString("PERAPP_SEX"));
			if(PERAPP_SEX.equals("M"))
				hshRecord.put("PERAPP_SEX","Male");
			else if(PERAPP_SEX.equals("F"))
				hshRecord.put("PERAPP_SEX","Female");
			hshRecord.put("PERAPP_DOB",correctNull((String)rs.getString("dob")));
			if(rs1!= null)
			{	rs1.close();  }
			rs1=DBUtils.executeLAPSQuery("selkyc_kycActivity^"+Helper.correctInt(rs.getString("perapp_id")));
			if(rs1.next())
			{
				hshRecord.put("KYC_KYCactivity",correctNull((String)rs1.getString("KYC_KYCactivity")));
			}
			
			//sel_applKYCNorms
			
			if(rs!= null)
			{	rs.close();  }
			strQuery=SQLParser.getSqlQuery("sel_applKYCNorms^"+strappId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("custoccupdesc",correctNull(rs.getString("occupationcodedesc")));
			}
			if(rs!= null)
			{	rs.close();  }
			strQuery=SQLParser.getSqlQuery("selborrowerdet_company^"+strappId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("cominfo_total_employees",correctNull(rs.getString("cominfo_total_employees")));
			}
			if(rs1!= null)
			{	rs1.close();  }
			rs1=DBUtils.executeLAPSQuery("sel_customerdetail^"+ strappId);
			
			if(rs1.next())
			{
				hshRecord.put("CON_MOBILE",correctNull((String)rs1.getString("CON_MOBILE")));
			}
			if(rs2!= null)
			{	rs2.close();  }
			strQuery2 = SQLParser.getSqlQuery("sel_customerdetail^"+ strappId);
			rs2 = DBUtils.executeQuery(strQuery2);
			if(rs2.next())
			{
				  String residentType=correctNull(rs2.getString("INDINFO_RESIDENT_STATUS"));
				  hshRecord.put("residentType", residentType);
				if(residentType.equals("N"))
				{	
					hshRecord.put("txtperapp_address1",correctNull(rs2.getString("CON_COMADDR1")));
					hshRecord.put("txtperapp_address2",correctNull(rs2.getString("CON_COMADDR2")));
					hshRecord.put("txtperapp_address3",correctNull(rs2.getString("CON_COMVILLAGE")));
					hshRecord.put("txtperapp_zip",correctNull(rs2.getString("CON_COMZIP")));
					//hshRecord.put("CON_MOBILE",correctNull((String)rs2.getString("CON_MOBILE")));
					strCity = Helper.correctNull(rs2.getString("CON_COMCITY"));
					strState = Helper.correctNull(rs2.getString("CON_COMSTATE"));
					strCountry = Helper.correctNull(rs2.getString("CON_COMCOUNTRY"));
					strdistrict = Helper.correctNull(rs2.getString("CON_COMDIST"));
				}
				else
				{
					hshRecord.put("txtperapp_address1",correctNull(rs2.getString("CON_PERMADDR1")));
					hshRecord.put("txtperapp_address2",correctNull(rs2.getString("CON_PERMADDR2")));
					hshRecord.put("txtperapp_address3",correctNull(rs2.getString("CON_PERMVILLAGE")));
					hshRecord.put("txtperapp_zip",correctNull(rs2.getString("CON_PERMZIP")));
					//hshRecord.put("CON_MOBILE",correctNull((String)rs2.getString("CON_MOBILE")));
					strCity = Helper.correctNull(rs2.getString("CON_PERMCITY"));
					strState = Helper.correctNull(rs2.getString("CON_PERMSTATE"));
					strCountry = Helper.correctNull(rs2.getString("CON_PERMCOUNTRY"));
					strdistrict = Helper.correctNull(rs2.getString("CON_PERMDIST"));
				}
				
				if(!strCity.equalsIgnoreCase(""))
			    {
			    	if(rs!=null)
			    	{
			    		rs.close();
			    	}
			    	strQuery2 = SQLParser.getSqlQuery("sel_cityname^"+ strCity);
					rs = DBUtils.executeQuery(strQuery2);
					if(rs.next())
					{
						hshRecord.put("txtperapp_city",correctNull(rs.getString("city_name")));
						strCity = Helper.correctNull(rs.getString("city_name"));
					}
			    }
			  
			    if(!strState.equalsIgnoreCase(""))
			    {
			    	if(rs!=null)
			    	{
			    		rs.close();
			    	}
			    	strQuery2 = SQLParser.getSqlQuery("sel_statename^"+ strState);
					rs = DBUtils.executeQuery(strQuery2);
					if(rs.next())
					{
						hshRecord.put("txtperapp_state",correctNull(rs.getString("state_name")));
						strState = Helper.correctNull(rs.getString("state_name"));
					}
			    }
			   
			    if(!strCountry.equalsIgnoreCase(""))
			    {
			    	if(rs!=null)
			    	{
			    		rs.close();
			    	}
			    	strQuery2 = SQLParser.getSqlQuery("sel_countrynamebycode^"+ strCountry);
					rs = DBUtils.executeQuery(strQuery2);
					if(rs.next())
					{
						hshRecord.put("txtperapp_country",correctNull(rs.getString("con_country")));
						strCountry = Helper.correctNull(rs.getString("con_country"));
					}
			    }
			    if(rs != null)rs.close();
			    strQuery2 = SQLParser.getSqlQuery("sel_districtmaster^"+ strdistrict );
				rs = DBUtils.executeQuery(strQuery2);
				if(rs.next())
				{
					hshRecord.put("txtperapp_district",correctNull(rs.getString("district_desc")));
				}
				
				
				if(rs3!= null)
				{
					rs3.close();
				}
				rs3=DBUtils.executeLAPSQuery("selappincomekycdetails^"+strappId);
				if(rs3.next())
				{
					hshRecord.put("PERAPP_ID",Helper.correctNull(rs3.getString("PERAPP_ID")));//0
					hshRecord.put("PERAPP_TITLE",Helper.correctNull(rs3.getString("PERAPP_TITLE")));//1
					hshRecord.put("PERAPP_FNAME",Helper.correctNull(rs3.getString("PERAPP_FNAME")));//2
					hshRecord.put("PERAPP_LNAME",Helper.correctNull(rs3.getString("PERAPP_LNAME")));//3
					
					hshRecord.put("KYC_IDPROOFREF",Helper.correctNull(rs3.getString("KYC_IDPROOFREF")));//7
					
					
					if(rs != null)rs.close();
				    strQuery2 = SQLParser.getSqlQuery("sel_CBSStaticDataPassingCode^7^"+ Helper.correctNull(rs3.getString("indinfo_caste")) );
					rs = DBUtils.executeQuery(strQuery2);
					if(rs.next())
					{
						hshRecord.put("indinfo_caste",correctNull(rs.getString("cbs_static_data_desc")));
					}
					
					if(Helper.correctNull(rs3.getString("indinfo_minority")).equalsIgnoreCase("Y"))
						hshRecord.put("indinfo_minority","Yes");//9
					else if(Helper.correctNull(rs3.getString("indinfo_minority")).equalsIgnoreCase("N"))
						hshRecord.put("indinfo_minority","No");//9
					else
						hshRecord.put("indinfo_minority","");//9
					rs3=DBUtils.executeLAPSQuery("sel_applKYCNorms^"+correctNull((String)rs3.getString("PERAPP_ID")));
					if(rs3.next())
					{	
						hshRecord.put("idprooftypedesc",Helper.correctNull(rs3.getString("idprooftypedesc")));//10
					}
				}
				
				if(rs3!= null)
				{
					rs3.close();
				}
				rs3=DBUtils.executeLAPSQuery("sel_indinfo_perapplicant^"+strappId);
				if(rs3.next())
				{
					hshRecord.put("PHYSICALLY_CHALLENGED",Helper.correctNull(rs3.getString("INDINFO_PHYSICALLY_CHALLANGED")));
					
				}
				
				// added by harish for annexure mapping
				
				ArrayList arrOutCol= new ArrayList();
				ArrayList arrOutRow=new ArrayList();
				String strCityDesc="",strStateDesc="",strDistcode="",strDistDesc="",strType="";
				rs=DBUtils.executeLAPSQuery("selcomappdivision_cgtmse^"+strappId);
				while(rs.next())
				{
					String strAadharno="";
					if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("O"))
						strType="Share Holders";
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("D"))
						strType="Directors";
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("SP"))
						strType="Sole Proprietor";
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("PT"))
						strType="Partner";
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("OT"))
						strType="Others";
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("K"))
						strType="Karta";
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("PA"))
						strType="Power of Attorney";
					else
						strType=correctNull((String)rs.getString("comapp_divisiontype"));
					
					
					//if( (correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("D")) || (correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("PT")))
					{
						arrOutCol = new ArrayList();
						arrOutCol.add(strType);//0
						arrOutCol.add(correctNull((String)rs.getString("comapp_div_name")));//1
						if(!correctNull((String)rs.getString("comapp_div_appid")).equalsIgnoreCase(""))
						{
							rs3=DBUtils.executeLAPSQuery("selappincomekycdetails^"+correctNull((String)rs.getString("comapp_div_appid")));
							if(rs3.next())
							{
								arrOutCol.add(Helper.correctNull(rs3.getString("perapp_dob")));//2
								arrOutCol.add(Helper.correctNull(rs3.getString("perapp_panno")));//3
								strAadharno=Helper.correctNull(rs3.getString("perapp_aadhaar"));//4
							}
							else
							{
								arrOutCol.add("");//2
								arrOutCol.add("");//3
								arrOutCol.add("");//4
							}
						}
						else
						{
							arrOutCol.add("");//2
							arrOutCol.add("");//3
							arrOutCol.add("");//4
						}
						arrOutRow.add(arrOutCol);
					}
				}
				hshRecord.put("arrGroupInfo", arrOutRow);
				
				ArrayList arrOutCol1= new ArrayList();
				ArrayList arrOutRow1=new ArrayList();
				if(rs!=null)
		    	{
		    		rs.close();
		    	}
				rs=DBUtils.executeLAPSQuery("comapp_division_details_sel_Chiefprom^"+strappId);
				while(rs.next())
				{
					String strAadharno="";
					if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("O"))
						strType="Share Holders";
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("D"))
						strType="Directors";
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("SP"))
						strType="Sole Proprietor";
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("PT"))
						strType="Partner";
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("OT"))
						strType="Others";
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("K"))
						strType="Karta";
					else if(correctNull((String)rs.getString("comapp_divisiontype")).equalsIgnoreCase("PA"))
						strType="Power of Attorney";
					else
						strType=correctNull((String)rs.getString("comapp_divisiontype"));
					
					String DIVISIONSUBTYPE=Helper.correctNull((String)rs.getString("COMAPP_DIVISIONSUBTYPE"));
				
				// added by raja sekhar
				arrOutCol1 = new ArrayList();
				if(!correctNull((String)rs.getString("comapp_div_appid")).equalsIgnoreCase(""))
				{
					rs3=DBUtils.executeLAPSQuery("selappincomekycdetails^"+correctNull((String)rs.getString("comapp_div_appid")));
					if(rs3.next())
					{
						arrOutCol1.add(Helper.correctNull(rs3.getString("PERAPP_ID")));//0
						arrOutCol1.add(Helper.correctNull(rs3.getString("PERAPP_TITLE")));//1
						arrOutCol1.add(Helper.correctNull(rs3.getString("PERAPP_FNAME")));//2
						arrOutCol1.add(Helper.correctNull(rs3.getString("PERAPP_LNAME")));//3
						arrOutCol1.add(Helper.correctNull(rs3.getString("PERAPP_PANNO")));//4
						arrOutCol1.add(Helper.correctNull(rs3.getString("PERAPP_DOB")));//5
						
						if(Helper.correctNull(rs3.getString("PERAPP_SEX")).equalsIgnoreCase("M"))
						arrOutCol1.add("Male");//6
						else if(Helper.correctNull(rs3.getString("PERAPP_SEX")).equalsIgnoreCase("F"))
						arrOutCol1.add("Female");//6
						else
						arrOutCol1.add("Others");//6
						//arrOutCol1.add(Helper.correctNull(rs3.getString("KYC_IDPROOFTYPE")));//7
						arrOutCol1.add(Helper.correctNull(rs3.getString("KYC_IDPROOFREF")));//7
						arrOutCol1.add(Helper.correctNull(rs3.getString("con_mobile")));//8
						arrOutCol1.add(Helper.correctNull(rs3.getString("perapp_aadhaar")));//9
						//arrOutCol1.add(Helper.correctNull(rs3.getString("INDINFO_PHYSICALLY_CHALLANGED")));//13
						if(Helper.correctNull(rs3.getString("indinfo_physically_challanged")).equalsIgnoreCase("Y"))
							arrOutCol1.add("Yes");//10
						else if(Helper.correctNull(rs3.getString("indinfo_physically_challanged")).equalsIgnoreCase("N"))
							arrOutCol1.add("No");//10
						else
							arrOutCol1.add("");//10
						if(rs4 != null)rs4.close();
					    strQuery2 = SQLParser.getSqlQuery("sel_CBSStaticDataPassingCode^7^"+ Helper.correctNull(rs3.getString("indinfo_caste")) );
						rs4 = DBUtils.executeQuery(strQuery2);
						if(rs4.next())
						{
							arrOutCol1.add(correctNull(rs4.getString("cbs_static_data_desc")));
						}
						else
						{
							arrOutCol1.add("");//11
						}
						
						if(Helper.correctNull(rs3.getString("indinfo_minority")).equalsIgnoreCase("Y"))
							arrOutCol1.add("Yes");//12
						else if(Helper.correctNull(rs3.getString("indinfo_minority")).equalsIgnoreCase("N"))
							arrOutCol1.add("No");//12
						else
							arrOutCol1.add("");//12
						rs3=DBUtils.executeLAPSQuery("sel_applKYCNorms^"+correctNull((String)rs3.getString("PERAPP_ID")));
						if(rs3.next())
						{	
							arrOutCol1.add(Helper.correctNull(rs3.getString("idprooftypedesc")));//13
						}

						
						arrOutRow1.add(arrOutCol1);
					}
				   }
				}
				hshRecord.put("arrOtherInfo", arrOutRow1);
				
				
				// gurantor
				ArrayList arrGuardetails=new ArrayList();
				ArrayList arrGuardetailsRow=new ArrayList();
				String app_type="";
				strQuery = SQLParser.getSqlQuery("corpCgtmsguarAnx^"+ appno+"^"+sno);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					app_type=Helper.correctNull((String)rs.getString("app_type"));
					if(app_type.equalsIgnoreCase("G")||app_type.equalsIgnoreCase("CO"))
					{
						arrGuardetails=new ArrayList();
						arrGuardetails.add(Helper.correctNull((String)rs.getString("fullname"))); //0
						arrGuardetails.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("perapp_networth"))))); //1
						
						arrGuardetailsRow.add(arrGuardetails);
					}
				}
				hshRecord.put("arrGuardetailsRow", arrGuardetailsRow);
			}
		}
		
		
		if(rs!= null)
		{	rs.close();  }
		strQuery = SQLParser.getSqlQuery("sel_facilityval^"+appno+"^"+sno);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			hshRecord.put("TXNDET_CRDT_AMT",Helper.correctNull((String)rs.getString("TXNDET_CRDT_AMT")));
			hshRecord.put("TXNDET_AMT_DISBURSED",Helper.correctNull((String)rs.getString("TXNDET_AMT_DISBURSED")));
			hshRecord.put("TXNDET_OUTS_BAL_AMT",Helper.correctNull((String)rs.getString("TXNDET_OUTS_BAL_AMT")));
			hshRecord.put("TXNDET_OUTS_BAL_DT",Helper.correctNull((String)rs.getString("TXNDET_OUTS_BAL_DT")));
			hshRecord.put("TXNDET_FST_INS_DUE_DT",Helper.correctNull((String)rs.getString("TXNDET_FST_INS_DUE_DT")));
			hshRecord.put("TXNDET_DT_FST_DISB",Helper.correctNull((String)rs.getString("TXNDET_DT_FST_DISB")));
			hshRecord.put("TXNDET_DT_LST_DISB",Helper.correctNull((String)rs.getString("TXNDET_DT_LST_DISB")));
			hshRecord.put("TXNDET_CRDT_FUNDBASED",Helper.correctNull((String)rs.getString("TXNDET_CRDT_FUNDBASED")));
			hshRecord.put("TXNDET_CRDT_NONFUNDBASED",Helper.correctNull((String)rs.getString("TXNDET_CRDT_NONFUNDBASED")));
			hshRecord.put("TXNDET_OUTSTD_FUND",Helper.correctNull((String)rs.getString("TXNDET_OUTSTD_FUND")));
			hshRecord.put("TXNDET_OUTFB_DT",Helper.correctNull((String)rs.getString("TXNDET_OUTFB_DT")));
			hshRecord.put("TXNDET_OUTSTD_NONFUND",Helper.correctNull((String)rs.getString("TXNDET_OUTSTD_NONFUND")));
			hshRecord.put("TXNDET_OUTNFB_DT",Helper.correctNull((String)rs.getString("TXNDET_OUTNFB_DT")));
			hshRecord.put("TXNDET_CGPAN_NO",Helper.correctNull((String)rs.getString("TXNDET_CGPAN_NO")));
			hshRecord.put("TXNDET_AMT_DISBURSEDWC",Helper.correctNull((String)rs.getString("TXNDET_AMT_DISBURSEDWC")));
			hshRecord.put("TXNDET_DT_FST_DISBWC",Helper.correctNull((String)rs.getString("TXNDET_DT_FST_DISBWC")));
			hshRecord.put("TXNDET_DT_LST_DISBWC",Helper.correctNull((String)rs.getString("TXNDET_DT_LST_DISBWC")));
		}
		String Strfinancialrequired="";
		strQuery = SQLParser.getSqlQuery("sel_facilityrequired^"+appno);
		if(rs!=null)
		{ 
			 rs.close();
		} 
		rs  = DBUtils.executeQuery(strQuery);
		if (rs.next())
		{ 
			 Strfinancialrequired=correctNull(rs.getString("app_facilityrequired"));
		}  
		strQuery = SQLParser.getSqlQuery("proposed_agriappdata^"+appno+"^"+sno);
		ResultSet rsfac = DBUtils.executeQuery(strQuery);
		if  ( rsfac.next())
		{  
			  dblSanctionAmt=Double.parseDouble(Helper.correctDouble((String)rsfac.getString("FACILITY_PROPOSED")));
		}  
		  
		String cattype=Helper.correctNull((String)hshValues.get("cattype"));
		if  (cattype.equalsIgnoreCase("AGR") && Strfinancialrequired.equalsIgnoreCase("N"))
		{  
			 ArrayList ListFinYear=new ArrayList();
			ArrayList ListFinStartYear=new ArrayList();
			ArrayList ListFinType=new ArrayList();
			ArrayList ListFinValuesCol=new ArrayList();
			ArrayList ListFinValuesRow=new ArrayList();
			int finYear=0;
			String  StrLessthan="<=" , StrGraterthan=">=";
			String StrFacilityLimit=String.valueOf(dblSanctionAmt);
			strQuery  = SQLParser.getSqlQuery("sel_retfinancialcgtmse^"+StrLessthan+"^"+StrFacilityLimit+"^"+StrGraterthan+"^"+StrFacilityLimit);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{ 
				 String StrRowDesc=Helper.correctNull((String)rs.getString("RETFIN_ROWDESC"));
				ListFinValuesCol=new ArrayList();
				ListFinValuesCol.add(String.valueOf(StrRowDesc));
				String Strretsno=Helper.correctNull((String)rs.getString("RETFIN_ROWID"));
				
				strQuery = SQLParser.getSqlQuery("sel_retfinancialyearcgtmse^"+appno);
				rs1 = DBUtils.executeQuery(strQuery);
				while (rs1.next())
				{
				
					String StrFinYear=  Helper.correctNull((String) rs1.getString("RET_FINYEAR"));
					String StrFinStartDate=Helper.correctNull((String)rs1.getString("RET_FINYEAR_START"));
					String StrFinancialType=Helper.correctNull((String)rs1.getString("RET_FINTYPE"));
					
					if(finYear==0)
					{
						
						ListFinYear.add(StrFinYear);
						ListFinStartYear.add(StrFinStartDate);
						ListFinType.add(StrFinancialType);
					}
					
					double dblFinValues=0.00;
					boolean flag=true;
					strQuery = SQLParser.getSqlQuery("sel_cgsmefindata^"+appno+"^"+Strretsno+"^"+StrFinYear);
					ResultSet rs10 = DBUtils.executeQuery(strQuery);
                	if (rs10.next())
					{
                		flag=false;
					  String strTotalValue ="";
					  if(StrFinancialType.equalsIgnoreCase("AUDITED"))
					  {
						  strTotalValue = Helper.correctNull((String) rs10.getString("CGTMSE_AUDIT"));
					  }
					  else if(StrFinancialType.equalsIgnoreCase("ESTIMATED"))
					  {
						  strTotalValue = Helper.correctNull((String) rs10.getString("CGTMSE_ESTIMATED"));
					  }
					  else if(StrFinancialType.equalsIgnoreCase("UNAUDITED"))
					  {
						  strTotalValue = Helper.correctNull((String) rs10.getString("CGTMSE_UNAUDIT")); 
					  }
					  else if(StrFinancialType.equalsIgnoreCase("PROJECTION"))
					  {
						  strTotalValue = Helper.correctNull((String) rs10.getString("CGTMSE_PROJECTION")); 
					  }
						dblFinValues=Double.parseDouble(Helper.correctDouble(strTotalValue));  
						ListFinValuesCol.add(String.valueOf(dblFinValues));
					}
				}
				ListFinValuesRow.add(ListFinValuesCol);
				finYear++;	
				System.out.println(ListFinType);
				System.out.println(ListFinYear);
				System.out.println(ListFinStartYear);
				System.out.println(ListFinValuesRow);
				
				hshRecord.put("ListFinType", ListFinType);
				hshRecord.put("ListFinYear",ListFinYear);
				hshRecord.put("ListFinStartYear",ListFinStartYear);
				hshRecord.put("ListFinValuesRow",ListFinValuesRow);
			}
		}
		else
		{
			 //For Financial Entry and display
			ResultSet rs10=null,rs11=null;
			String StrFinancialId="";
			String sel_divID = "0";
			String StrFacilityLimit=String.valueOf(dblSanctionAmt);
			//String StrFacilityLimit="1000000000";
			String StrLessthan="<=" , StrGraterthan=">=",Strcmano="";
			ArrayList ListFinYear=new ArrayList();
			ArrayList ListFinStartYear=new ArrayList();
			ArrayList ListFinType=new ArrayList();
			ArrayList ListFinValuesCol=new ArrayList();
			ArrayList ListFinValuesRow=new ArrayList();
			ArrayList ListFinValuesins=new ArrayList();
			int intUpdatesize=0;
			String sumaudit="",sumunaudit="",sumestimated="",sumprojection="";
			String valarray[] = new String[6];
			HashMap hshQueryValues=new HashMap();
			HashMap hshQuery=new HashMap();
			valarray[0] = "0";
			int finYear=0;
			if (!appno.equalsIgnoreCase(""))
			{
				strQuery = SQLParser.getSqlQuery("comdemographics_sel^"+appno);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					StrFinancialId = (Helper.correctInt((String) rs.getString("demo_finstandard")));
				}
				if(!StrFinancialId.equalsIgnoreCase(""))
				{
					
					ListFinValuesins=new ArrayList();
					hshQuery=new HashMap();
					hshQuery.put("strQueryId","del_cgtmsefinvalues");
					ListFinValuesins.add(appno);
					hshQuery.put("arrValues", ListFinValuesins);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					hshQueryValues=new HashMap();
					strQuery = SQLParser.getSqlQuery("fin_cmano_select^"+StrFinancialId);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next())
					{
						Strcmano=Helper.correctNull((String)rs.getString("fin_cmano"));
					}
					strQuery = SQLParser.getSqlQuery("sel_corpfinancialcgtmse^"+StrLessthan+"^"+StrFacilityLimit+"^"+StrGraterthan+"^"+StrFacilityLimit+"^"+Strcmano);
					rs = DBUtils.executeQuery(strQuery);
					while (rs.next())
					{
						
						String StrRowFormula=Helper.correctNull((String)rs.getString("RETFIN_FORMULADEF"));
						String StrRowID=Helper.correctNull((String)rs.getString("RETFIN_ROWID"));
						String StrRowDesc=Helper.correctNull((String)rs.getString("RETFIN_ROWDESC"));
						String StrRowType=Helper.correctNull((String)rs.getString("RETFIN_ROWTYPE"));
						
						ListFinValuesCol=new ArrayList();
						ListFinValuesCol.add(String.valueOf(StrRowDesc));
						
						strQuery = SQLParser.getSqlQuery("corp_app_financials_select_distinctyear^"+StrFinancialId+"^"+sel_divID);
						rs1 = DBUtils.executeQuery(strQuery);
						while (rs1.next())
						{
							String StrFinYear=  Helper.correctNull((String) rs1.getString("fin_year"));
							String StrFinStartDate=Helper.correctNull((String)rs1.getString("COM_FINYEAR_START"));
							String Strcomsno=Helper.correctNull((String)rs1.getString("com_sno"));
							String StrFinancialType=Helper.correctNull((String)rs1.getString("COM_FINTYPE"));

							if(finYear==0)
							{
								ListFinYear.add(StrFinYear);
								ListFinStartYear.add(StrFinStartDate);
								ListFinType.add(StrFinancialType);
							}
							
							String strQuery10 = SQLParser.getSqlQuery("assessselect9^"+ StrFinancialId + "^" + sel_divID + "^" + StrFinYear+ "^" + Strcomsno);
							rs10 = DBUtils.executeQuery(strQuery10);
							if (rs10.next())
							{
								
								sumaudit = Helper.correctDouble(rs10.getString("sumaudit"));
								sumunaudit = Helper.correctDouble(rs10.getString("sumunaudit"));
								sumestimated = Helper.correctDouble(rs10.getString("sumestimated"));
								sumprojection = Helper.correctDouble(rs10.getString("sumprojection"));
								if (!sumaudit.equals("0"))
								{
									valarray[0] = "fin_audit";
								}
								if (!sumunaudit.equals("0")) {
									valarray[0]  = "fin_unaudit";
								}
								if (!sumestimated.equals("0")) {
									valarray[0]  = "fin_estimated";
								}
								if (!sumprojection.equals("0")) {
									valarray[0]  = "fin_projection";
								}
								if (!sumprojection.equals("0")) {
									valarray[0] = "fin_projection";
								}
								String desc="";
								if (valarray[0].equals("fin_audit")) {
									desc = "a";
								} else if (valarray[0].equals("fin_unaudit")) {
									desc = "u";
								} else if (valarray[0]
										.equals("fin_estimated")) {
									desc = "e";
								} else if (valarray[0]
										.equals("fin_projection")) {
									desc = "p";
								}
								double dblFinValues=0.00;
								if(StrRowType.equalsIgnoreCase("E"))
								{
									strQuery10 = SQLParser.getSqlQuery("selcgtmsefinvalues^"+ valarray[0]+"^" +StrFinancialId+"^" + StrFinYear+ "^" + Strcomsno+ "^"+StrRowFormula);
									rs11 = DBUtils.executeQuery(strQuery10);
									if (rs11.next())
									{
										dblFinValues=Double.parseDouble(Helper.correctDouble((String)rs11.getString("finvalues")));
									}
								}
								else
								{
									HashMap hshformula = new HashMap();
									hshformula.put("appno", StrFinancialId);
									hshformula.put("sel_divID", sel_divID);
									hshformula.put("formulaid", StrRowFormula);
									hshformula.put("curryear", StrFinYear);
									hshformula.put("prevyear", " ");
									hshformula.put("currfinancialtype",desc);
									hshformula.put("prevfinancialtype", "a");
									hshformula.put("internalcalc", "N");
									hshformula.put("sno", Strcomsno);
									hshformula.put("frompage", "cgtmse");
									hshformula.put("hshdata", new HashMap());
									HashMap hshRes = (HashMap) EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
									String strTotalValue = correctNull((String) hshRes.get("strTotalValue"));
									dblFinValues=Double.parseDouble(Helper.correctDouble(strTotalValue));              
								}
								
								ListFinValuesCol.add(String.valueOf(dblFinValues));
								
								 //Retail Table Insert
								ListFinValuesins=new ArrayList();
								hshQuery=new HashMap();
								intUpdatesize++;
								if (valarray[0].equalsIgnoreCase("fin_audit")) {
									hshQuery.put("strQueryId","ins_cgtmsefinvaluesaudit");
								}
								if (valarray[0].equalsIgnoreCase("fin_unaudit")) {
									hshQuery.put("strQueryId","ins_cgtmsefinvaluesunaudit");
								}
								if (valarray[0].equalsIgnoreCase("fin_estimated")) {
									hshQuery.put("strQueryId","ins_cgtmsefinvaluesestimated");
								}
								if (valarray[0].equalsIgnoreCase("fin_projection")) {
									hshQuery.put("strQueryId","ins_cgtmsefinvaluesprojection");
								}
								
								ListFinValuesins.add(appno);
								ListFinValuesins.add(StrFinYear);
								ListFinValuesins.add(StrRowID);
								ListFinValuesins.add(String.valueOf(dblFinValues));
								ListFinValuesins.add(sel_divID);
								ListFinValuesins.add(Strcomsno);
								ListFinValuesins.add(String.valueOf(sno));
								hshQuery.put("arrValues", ListFinValuesins);
								
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
								
							}
						}
						ListFinValuesRow.add(ListFinValuesCol);
						finYear++;
					}
					if(intUpdatesize!=0)
					 {
						hshQueryValues.put("size", Integer.toString(intUpdatesize));	
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					 }
					
					System.out.println(ListFinType);
					System.out.println(ListFinYear);
					System.out.println(ListFinStartYear);
					System.out.println(ListFinValuesRow);
					
					hshRecord.put("ListFinType", ListFinType);
					hshRecord.put("ListFinYear",ListFinYear);
					hshRecord.put("ListFinStartYear",ListFinStartYear);
					hshRecord.put("ListFinValuesRow",ListFinValuesRow);

				}
		}
		}	
		
		
		strQuery = SQLParser.getSqlQuery("cgtmse_sel_agrappid^" + appno);
		rs = DBUtils.executeQuery(strQuery);
		
		if (rs.next()) 
		{	
			strAppId=Helper.correctNull((String) rs.getString("DEMO_COMAPPID"));
		}
		FinancialBean financial=new FinancialBean();
		FacilitiesBean facBean = new  FacilitiesBean();
		HashMap hshRequestValues	= new HashMap();
		HashMap hshVal= new HashMap();
		HashMap hshfinVal= new HashMap();


		hshRequestValues.put("strAppId",strAppId);
		hshRequestValues.put("strAppNo", appno);
		hshRequestValues.put("pageval","CorpAnnexure");
		hshRequestValues=financial.getCorpAnnexureII(hshRequestValues);
		//hshfinVal=financial.getData(hshfinVal);
		
		hshRequestValues.put("page","CorpAnnexure");
		hshRecord.put("hshReqValues5",hshRequestValues);	
		hshRecord.put("AmtValue",dblSanctionAmt);
		FinancialBean FinancialBean=new FinancialBean();
		hshVal=FinancialBean.getData(hshRecord);
		hshRecord.put("hshVal", hshVal);
		
		//getCorpDataRatio
		hshVal.put("APP_NO", appno);
		hshfinVal=financial.getCorpDataRatio(hshRecord);
		
		
		hshVal.put("page","getRetailData");
		hshRecord.put("financialdata",hshVal);
		hshRecord.put("hshfinVal",hshfinVal);

		
	
	}
	

	catch(Exception e)
	{
		throw new EJBException(e.getMessage());
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
			if(rs3 != null)
			{
				rs3.close();
			}
		}
		catch(Exception e1)
		{
			throw new EJBException("Error closing connection"+e1);
		}
	}
		return hshRecord;
	
	}
	
	
	public void updateCorpNcgtc(HashMap hshValues)  
	{
		HashMap hshQuery=new HashMap();
		HashMap hshRecord = new HashMap();
		HashMap hshQueryValues = null;
		String strQuery = "";
	
		ArrayList arr= new ArrayList() ;
		
		HashMap hshQuery1=new HashMap();
		HashMap hshRecord1 = new HashMap();
		HashMap hshQueryValues1 = null;
		String strQuery1 = "";
	
		ArrayList arr1= new ArrayList();
		
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strAction = Helper.correctNull((String)hshValues.get("hidAction"));
		String strFacilitySno=Helper.correctNull((String)hshValues.get("sel_facility"));
		String []strCGPan=null;
		String txt_cgpan="";
		
		ArrayList arrValues = new ArrayList();
		ArrayList arrValues1 = new ArrayList();
		try
		{
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery1 = new HashMap();
				arrValues1 = new ArrayList();
				hshQueryValues1=new HashMap();
				arrValues1.add(strAppno);
				arrValues1.add(strFacilitySno);
				hshQuery1.put("strQueryId", "delete_corp_ncgtc");
				hshQuery1.put("arrValues", arrValues1);
				hshQueryValues1.put("size","1");
				hshQueryValues1.put("1",hshQuery1);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues1,"updateData");
			}
			else if(strAction.equalsIgnoreCase("insert"))
			{
				hshQuery1 = new HashMap();
				arrValues1 = new ArrayList();
				hshQueryValues1=new HashMap();
				arrValues1.add(strAppno);
				arrValues1.add(strFacilitySno);
				hshQuery1.put("strQueryId", "delete_corp_ncgtc");
				hshQuery1.put("arrValues", arrValues1);
				hshQueryValues1.put("size","1");
				hshQueryValues1.put("1",hshQuery1);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues1,"updateData");
				

		 		arrValues = new ArrayList();
			    hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues.add(Helper.correctNull((String)hshValues.get("appno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_facility")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_projecttype")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_greenfield")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_brownfield")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_metro")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_metroeligibility")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_industrysector")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_industryeligibility")));//9
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_udyogaadhaar")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_projectunitpincode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_natureofproject")));
				arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","insert_corp_ncgtc");			
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}	
		catch (Exception e)
		{
			throw new EJBException(e.toString());
		} 
	}
	
	public HashMap getCorpNcgtc(HashMap hshValues) 
	{
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		ResultSet rs3=null;
		
		HashMap hshRecord=new HashMap();
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		if(strAppno.equals(""))
		{
			strAppno=Helper.correctNull((String)hshValues.get("strAppno"));
		}
		String strSno=Helper.correctInt((String)hshValues.get("facilityNcgtc"));
		if(strSno.equals(""))
		{
			Helper.correctInt((String)hshValues.get("sel_facility"));
		}
		String strCondition = Helper.correctNull((String)hshValues.get("hidCondtion"));
	
		String strQuery="";
		String strQuery2="";
		String strQuery3="";
		String strQuery4="",strAppid="", UdyogAadharNo="";
		try
		{
			strQuery=SQLParser.getSqlQuery("sel_for_cgdetails^"+strAppno+"^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				strAppid=Helper.correctNull(rs.getString("perapp_oldid"));
				hshRecord.put("MSERegNo",correctNull((String)rs.getString("PERAPP_MSE_REGNO")));
				hshRecord.put("UdyogAadharNo",correctNull((String)rs.getString("PERAPP_UDYOG_AADHAR")));
				hshRecord.put("PERAPP_CONSTITUTION",correctNull((String)rs.getString("PERAPP_CONSTITUTION")));
				UdyogAadharNo=correctNull((String)rs.getString("PERAPP_UDYOG_AADHAR"));
				rs1=DBUtils.executeLAPSQuery("selborrowerdet_company^"+Helper.correctInt(rs.getString("perapp_id")));
				if(rs1.next())
				{
					hshRecord.put("cominfo_total_employees",correctNull((String)rs1.getString("cominfo_total_employees")));
				}
				
				rs1=DBUtils.executeLAPSQuery("sel_minordetails^"+Helper.correctInt(rs.getString("perapp_id")));
				if(rs1.next())
				{
					hshRecord.put("indinfo_minority",correctNull((String)rs1.getString("indinfo_minority")));
				}
			
			}
			hshRecord.put("strAppno",strAppno);
			
			
			//Previous NCGTC Cover Details
			
			if(!strSno.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("select_corp_ncgtc^"+strAppno+"^"+strSno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("CORP_APPNO",Helper.correctNull(rs.getString("CORP_APPNO")));
					hshRecord.put("CORP_FACILITY",Helper.correctNull(rs.getString("CORP_FACILITY")));
					hshRecord.put("CORP_TYPEOFPROJECT",Helper.correctNull(rs.getString("CORP_TYPEOFPROJECT")));
					hshRecord.put("CORP_GREENFIELD",Helper.correctNull(rs.getString("CORP_GREENFIELD")));
					hshRecord.put("CORP_BROWNFIELD",Helper.correctNull(rs.getString("CORP_BROWNFIELD")));
					hshRecord.put("CORP_METROPROJECT",Helper.correctNull(rs.getString("CORP_METROPROJECT")));
					hshRecord.put("CORP_METROPROJELIGIBLE",Helper.correctNull(rs.getString("CORP_METROPROJELIGIBLE")));
					hshRecord.put("CORP_INDUSTRYSECTOR",Helper.correctNull(rs.getString("CORP_INDUSTRYSECTOR")));
					hshRecord.put("CORP_INDUSTRYSECTORELIGI",Helper.correctNull(rs.getString("CORP_INDUSTRYSECTORELIGI")));
					hshRecord.put("CORP_UDYOGAADHAAR",Helper.correctNull(rs.getString("CORP_UDYOGAADHAAR")));
					hshRecord.put("CORP_PROJECTUNITPIN",Helper.correctNull(rs.getString("CORP_PROJECTUNITPIN")));
					hshRecord.put("CORP_PROJECTNATURE",Helper.correctNull(rs.getString("CORP_PROJECTNATURE")));
				}
			}
			strQuery=SQLParser.getSqlQuery("select_corp_ncgtc_all^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			int rowcount=0;
			int rowcount1=0;
			if (rs.last()) {
				  rowcount = rs.getRow();
				  rs.beforeFirst(); // not rs.first() because the rs.next() below will move on, missing the first element
			}
			if(rs!=null)
			rs.close();
			
			strQuery=SQLParser.getSqlQuery("get_facilities_schemecount^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(rowcount1==0)
				{
					rowcount1=1;
				}
				else
				{
					rowcount1=rowcount1+1;
				}
			}
			if(rowcount==rowcount1)
			{
				hshRecord.put("strncgtcflag","Y");
			}
			else
			{
				hshRecord.put("strncgtcflag","N");
			}
			if(rs!=null)rs.close();
			if(!UdyogAadharNo.equals(""))
			{
				HashMap hshQuery1 = new HashMap();
				ArrayList arrValues1 = new ArrayList();
				HashMap hshQueryValues1=new HashMap();
				arrValues1.add(UdyogAadharNo);
				arrValues1.add(strAppno);
				hshQuery1.put("strQueryId", "update_udyogaadhaar_corp_ncgtc");
				hshQuery1.put("arrValues", arrValues1);
				hshQueryValues1.put("size","1");
				hshQueryValues1.put("1",hshQuery1);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues1,"updateData");
			}
			hshRecord.put("CORP_FACILITY",strSno);
		}
	
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
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
			catch(Exception e1)
			{
				throw new EJBException("Error closing connection"+e1);
			}
		}
		return hshRecord;
	}
}