package com.sai.laps.ejb.appeditlock;

import java.io.FileReader;
import java.security.SecureRandom;
import java.sql.ResultSet;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.google.gson.Gson;
import com.sai.laps.ejb.agrstandardreport.AgrStandardReportBean;
import com.sai.laps.filter.AESEncyrptionDecyrption;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
//import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "AppEditLockBean", mappedName = "AppEditLockHome")
@Remote (AppEditLockRemote.class)
public class AppEditLockBean extends BeanAdapter
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(AppEditLockBean.class);

	public HashMap getProductList(HashMap hshValues) 
	{		 
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		ResultSet rs3=null;
		ResultSet rslt=null;
		HashMap hshResult=new HashMap();
		ArrayList arryRow=new ArrayList();
		ArrayList arryCol=null;
		String strLapsOldId="";
		String strProducttype=correctNull((String)hshValues.get("prd_type"));
		String strCommappId=correctNull((String)hshValues.get("comappid"));
		String strPrdName=correctNull((String)hshValues.get("prdname"));
		String strOrgScode=correctNull((String)hshValues.get("orgscode"));
		String strCompAppOldid=correctNull((String)hshValues.get("varStrAppid"));
		String strAppNo=correctNull((String)hshValues.get("appno"));
		String strAppType=correctNull((String)hshValues.get("strAppType"));
		if(strOrgScode.equalsIgnoreCase(""))
		{
			strOrgScode = correctNull((String)hshValues.get("orgscode1"));
		}
		String strOrgLevel=correctNull((String)hshValues.get("orglevel"));
		if(strOrgLevel.equalsIgnoreCase(""))
		{
			strOrgLevel = correctNull((String)hshValues.get("orglevel1"));
		}
		if(strCommappId.equalsIgnoreCase(""))
		{
			strCommappId = correctNull((String)hshValues.get("varStrAppid"));
		}
		String strCategorytype=correctNull((String)hshValues.get("hidCategoryType"));
		String strOrgCode=correctNull((String)hshValues.get("orgcode"));
		if(strOrgCode.equalsIgnoreCase(""))
		{
			strOrgCode = correctNull((String)hshValues.get("orgcode1"));
		}
		String strBankVal="";
		String strQuery ="";
		String strShortCode="",strprd_code="";
		String strEmpStatus="", strWhetherStaff="", strDocRecvd="";
		strDocRecvd=Helper.correctNull((String)hshValues.get("DocReceived"));
		String comappid=Helper.correctNull((String)hshValues.get("comappid"));
		try
		{
			if(comappid.equals(""))
			{
				comappid=Helper.correctNull((String)hshValues.get("Str_ApplicantId"));
			}
			if (strOrgLevel.equalsIgnoreCase("C"))
			{
				strBankVal = "'"+strOrgCode.substring(0,3)+"000000000000'";
			}
			else if (strOrgLevel.equalsIgnoreCase("R"))
			{
				strBankVal = "'"+strOrgCode.substring(0,6)+"000000000";
				strBankVal = strBankVal +"','"+ strOrgCode.substring(0,3)+"000000000000'";
			}
			else if (strOrgLevel.equalsIgnoreCase("D"))
			{
				strBankVal = "'"+strOrgCode.substring(0,9)+"000000";
				strBankVal = strBankVal+"','"+ strOrgCode.substring(0,6)+"000000000";
				strBankVal = strBankVal +"','"+ strOrgCode.substring(0,3)+"000000000000'";
			}
			else if (strOrgLevel.equalsIgnoreCase("A"))
			{
				strBankVal = "'"+strOrgCode.substring(0,12)+"000";
				strBankVal = strBankVal+"','"+strOrgCode.substring(0,9)+"000000";
				strBankVal = strBankVal+"','"+ strOrgCode.substring(0,6)+"000000000";
				strBankVal = strBankVal +"','"+ strOrgCode.substring(0,3)+"000000000000'";
			}
			else if (strOrgLevel.equalsIgnoreCase("B"))
			{
				strBankVal = "'"+strOrgCode.substring(0,15);
				strBankVal = strBankVal+"','"+strOrgCode.substring(0,12)+"000";
				strBankVal = strBankVal+"','"+strOrgCode.substring(0,9)+"000000";
				strBankVal = strBankVal+"','"+ strOrgCode.substring(0,6)+"000000000";
				strBankVal = strBankVal +"','"+ strOrgCode.substring(0,3)+"000000000000'";
			}
			String strType ="";
			String strorgScode = "";
			if(!comappid.equals(""))
			{
				strQuery= SQLParser.getSqlQuery("sel_ncgtcfacility_constitution^"+comappid);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshResult.put("strconstitution", Helper.correctNull((String)rs.getString("PERAPP_CONSTITUTIONNEW")));
				}
			}
			if(!strCategorytype.equals("") && !strProducttype.equals(""))
			{				 
				strQuery= SQLParser.getSqlQuery("selorgsortcode^"+strBankVal);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					String strSchemeType=" ";
					strQuery=SQLParser.getSqlQuery("sel_staffandemptype^"+comappid);
					rs2=DBUtils.executeQuery(strQuery);
					if(rs2.next())
					{
						strEmpStatus=Helper.correctNull((String)rs2.getString("perapp_employment"));
						strWhetherStaff=Helper.correctNull((String)rs2.getString("indinfo_is_staff"));
					}
					strShortCode= rs.getString(1);
					if(!strShortCode.equals(""))
					{ 
						strorgScode = "%"+strShortCode+"%";
						if(strCategorytype.equalsIgnoreCase("LAD"))
						{
							strType="p"+strProducttype;
							if(strType.equalsIgnoreCase("pG"))
							{
								if(strDocRecvd.equalsIgnoreCase("1")||strDocRecvd.equalsIgnoreCase("2")||strDocRecvd.equalsIgnoreCase("3"))
								{
									//strSchemeType=strSchemeType+" and (upper(prd_schemetype) not in ('S') or prd_schemetype is null)";
								}
								else
								{
									//strSchemeType=strSchemeType+" and (upper(prd_schemetype) not in ('M') or prd_schemetype is null)";
								}
							}
							if(strType.equalsIgnoreCase("pG")||strType.equalsIgnoreCase("pR"))
							{
								/*if(strEmpStatus.equalsIgnoreCase("4"))
								{*/
									if(strDocRecvd.equalsIgnoreCase("1")||strDocRecvd.equalsIgnoreCase("2")||strDocRecvd.equalsIgnoreCase("3"))
									{
										strSchemeType=strSchemeType+" and upper(prd_whetheragri)='Y'";
									}
									else
									{
										strSchemeType=strSchemeType+" and upper(prd_whetheragri)='N'";
									}
								/*}
								else
								{
									strSchemeType=strSchemeType+" and upper(prd_whetheragri)='N'";
								}*/
							}
						}
						else if(strCategorytype.equalsIgnoreCase("AGR"))
						{
							strType="a"+strProducttype;
						}
						else if(strCategorytype.equalsIgnoreCase("RET"))
						{
							strType="p"+strProducttype;
						}
						if(!strWhetherStaff.equalsIgnoreCase("02"))
						{
							strSchemeType=strSchemeType+" and (upper(prd_staffprd)!='Y' or prd_staffprd is null) ";
						}
						if(!strType.equalsIgnoreCase("pSL"))
						{
						strQuery=SQLParser.getSqlQuery("sel_productlist^"+strorgScode+"^"+strType+"^<=^"+strSchemeType);
						rs1=DBUtils.executeQuery(strQuery);							
						while (rs1.next())
						{
							arryCol=new ArrayList();
							arryCol.add(correctNull((String)rs1.getString("prdcode")));//0
							arryCol.add(correctNull((String)rs1.getString("category")));//1
							arryCol.add(correctNull((String)rs1.getString("subcategory")));//2
							arryCol.add(correctNull((String)rs1.getString("rangefrom")));//3
							arryCol.add(correctNull((String)rs1.getString("rangeto")));//4
							if(strAppType.equalsIgnoreCase("S")){
								arryCol.add(correctNull((String)rs1.getString("PRD_TERM_REST")));//5
							}else{
							arryCol.add(correctNull((String)rs1.getString("term")));//5
							}
							arryCol.add(correctNull((String)rs1.getString("prd_type")));//6
							arryCol.add(correctNull((String)rs1.getString("prd_principal")));//7
							arryCol.add(correctNull((String)rs1.getString("prd_interest")));//8
							arryCol.add(correctNull((String)rs1.getString("prd_staffprd")));//9
							arryCol.add(correctNull((String)rs1.getString("prd_appminage")));//10
							arryCol.add(correctNull((String)rs1.getString("nsc_loan")));//11
							arryCol.add(correctNull((String)rs1.getString("scheme_code")));//12
							if(strAppType.equalsIgnoreCase("S")){
							arryCol.add(correctNull((String)rs1.getString("PRD_MINTERM_REST")));//13
							}else{
								arryCol.add(correctNull((String)rs1.getString("minterm")));//13
							}
							arryCol.add(correctNull((String)rs1.getString("prd_desc")));//14
							arryCol.add(correctNull((String)rs1.getString("prd_purpose")));//15
							if(strAppType.equalsIgnoreCase("S")){
							arryCol.add(correctNull((String)rs1.getString("PRD_HOLIDAY_REST")));//16
							}else{
								arryCol.add(correctNull((String)rs1.getString("PRD_HOLIDAY")));//16
							}
							strprd_code=correctNull((String)rs1.getString("prdcode"));
							if((strType.equalsIgnoreCase("pA") && correctNull((String)rs1.getString("prd_purpose")).equalsIgnoreCase("U"))||(strType.equalsIgnoreCase("pH") && correctNull((String)rs1.getString("prd_purpose")).equalsIgnoreCase("H"))||(strType.equalsIgnoreCase("pU")  && correctNull((String)rs1.getString("prd_vehitype")).equalsIgnoreCase("2")))
							{
								rs3=DBUtils.executeLAPSQuery("sel_specificeligible^"+strprd_code);
								if(rs3.next())
								{
									arryCol.add(Helper.correctInt((String)rs3.getString("PRD_MAXAGEOFVEHICLE")));//17
								}
								else
								{
									arryCol.add("0");//17
								}
								
							}
							else 
							{
								arryCol.add("");//17
							}
							
							//Added by Kishan
							strQuery=SQLParser.getSqlQuery("setproductstypebyprdcode^" + strprd_code);
							rslt=DBUtils.executeQuery(strQuery);
							String prdLoanType="";
							if(rslt.next())
							{
								prdLoanType=Helper.correctInt((String)rslt.getString("prd_loantype"));
							}
							arryCol.add(prdLoanType);
							arryCol.add(correctNull((String)rs1.getString("staff_under")));//19
							arryCol.add(correctNull((String)rs1.getString("prd_repaytype")));//20
							arryCol.add(correctNull(rs1.getString("prd_staff_maxterm_prin")));//21
							arryCol.add(correctNull(rs1.getString("prd_staff_maxterm_intr")));//22
							arryCol.add(correctNull(rs1.getString("prd_deposittype")));//23
							arryCol.add(correctNull(rs1.getString("prd_bankscheme")));//24
							arryCol.add(correctNull(rs1.getString("MIS_STATIC_DATA_DESC")));//25
							arryCol.add(correctNull(rs1.getString("prd_vehitype")));//26
							arryCol.add(correctNull(rs1.getString("prd_sharetype")));//27
							arryCol.add(correctNull(rs1.getString("prd_CGTMSEFALG")));//28
							arryRow.add(arryCol);
							
						}
						}
						else
						{
							if(strWhetherStaff.equalsIgnoreCase("02"))
							{
								strType="pH','pA','pP";
								strSchemeType=strSchemeType+" and (upper(prd_staffprd)='Y')";
							}
							strQuery=SQLParser.getSqlQuery("sel_productliststaffloan^"+strorgScode+"^"+strType+"^<=^"+strSchemeType);
							rs1=DBUtils.executeQuery(strQuery);							
							while (rs1.next())
							{
								arryCol=new ArrayList();
								arryCol.add(correctNull((String)rs1.getString("prdcode")));//0
								arryCol.add(correctNull((String)rs1.getString("category")));//1
								arryCol.add(correctNull((String)rs1.getString("subcategory")));//2
								arryCol.add(correctNull((String)rs1.getString("rangefrom")));//3
								arryCol.add(correctNull((String)rs1.getString("rangeto")));//4
								arryCol.add(correctNull((String)rs1.getString("term")));//5
								arryCol.add(correctNull((String)rs1.getString("prd_type")));//6
								arryCol.add(correctNull((String)rs1.getString("prd_principal")));//7
								arryCol.add(correctNull((String)rs1.getString("prd_interest")));//8
								arryCol.add(correctNull((String)rs1.getString("prd_staffprd")));//9
								arryCol.add(correctNull((String)rs1.getString("prd_appminage")));//10
								arryCol.add(correctNull((String)rs1.getString("nsc_loan")));//11
								arryCol.add(correctNull((String)rs1.getString("scheme_code")));//12
								arryCol.add(correctNull((String)rs1.getString("minterm")));//13
								arryCol.add(correctNull((String)rs1.getString("prd_desc")));//14
								arryCol.add(correctNull((String)rs1.getString("prd_purpose")));//15
								arryCol.add(correctNull((String)rs1.getString("PRD_HOLIDAY")));//16
								
								strprd_code=correctNull((String)rs1.getString("prdcode"));
								if(correctNull((String)rs1.getString("prd_purpose")).equalsIgnoreCase("H") || correctNull((String)rs1.getString("prd_purpose")).equalsIgnoreCase("U") || correctNull((String)rs1.getString("prd_vehitype")).equalsIgnoreCase("2"))
								{
									rs3=DBUtils.executeLAPSQuery("sel_specificeligible^"+strprd_code);
									if(rs3.next())
									{
										arryCol.add(Helper.correctInt((String)rs3.getString("PRD_MAXAGEOFVEHICLE")));//17
									}
									else
									{
										arryCol.add("0");//17
									}
									
								}
								else
								{
									arryCol.add("");//17
								}
								
								//Added by Kishan
								strQuery=SQLParser.getSqlQuery("setproductstypebyprdcode^" + strprd_code);
								rslt=DBUtils.executeQuery(strQuery);
								String prdLoanType="";
								if(rslt.next())
								{
									prdLoanType=Helper.correctInt((String)rslt.getString("prd_loantype"));
								}
								arryCol.add(prdLoanType);
								arryCol.add(correctNull((String)rs1.getString("staff_under")));//19
								arryCol.add(correctNull((String)rs1.getString("prd_repaytype")));//20
								arryCol.add(correctNull(rs1.getString("prd_staff_maxterm_prin")));//21
								arryCol.add(correctNull(rs1.getString("prd_staff_maxterm_intr")));//22
								arryCol.add(correctNull(rs1.getString("prd_deposittype")));//23
								arryCol.add(correctNull(rs1.getString("prd_bankscheme")));//24
								arryCol.add(correctNull(rs1.getString("MIS_STATIC_DATA_DESC")));//25
								arryCol.add(correctNull(rs1.getString("prd_vehitype")));//26
								arryCol.add(correctNull(rs1.getString("prd_sharetype")));//27
								arryCol.add(correctNull(rs1.getString("prd_CGTMSEFALG")));//28
								arryRow.add(arryCol);
								
							}
						}
					}						
				}									
			}
			hshResult.put("appprdtype", strProducttype);
			hshResult.put("arryRow",arryRow);
			hshResult.put("comappid",comappid);
			
			if(rs!=null)
				rs.close();
			if(!strCommappId.equalsIgnoreCase(""))
			{
				strQuery= SQLParser.getSqlQuery("seloldrefidforapp^"+strCommappId);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strLapsOldId=Helper.correctInt(rs.getString("perapp_oldid")); 
				}
				strQuery= SQLParser.getSqlQuery("selrenewappid^"+strLapsOldId);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strCommappId=Helper.correctInt(rs.getString("perapp_id")); 
				}
			}
			if(rs!=null)
				rs.close();
			String strQuery1 = SQLParser.getSqlQuery("findBorrowerOrgPer^"+strCommappId);
			if(!strCommappId.equalsIgnoreCase(""))
			{
			rs = DBUtils.executeQuery(strQuery1);
		    while(rs.next())
			{
				hshResult.put("app_gender", Helper.correctNull(rs.getString("perapp_sex")));
				hshResult.put("app_employment", Helper.correctNull(rs.getString("perapp_employment")));
				hshResult.put("perapp_stakeheld_women", Helper.correctNull(rs.getString("perapp_stakeheld_women")));
				
				if(Integer.parseInt(Helper.correctInt(rs.getString("perapp_constitutionnew")))>=183 && Integer.parseInt(Helper.correctInt(rs.getString("perapp_constitutionnew")))<=191)
				{
					String strDesc="";
					strQuery1 = SQLParser.getSqlQuery("sel_cbsstaticdatacode^2^183','186','189");
					rs3=DBUtils.executeQuery(strQuery1);
					while(rs3.next())
					{
						if(strDesc.equalsIgnoreCase(""))
							strDesc=Helper.correctNull(rs3.getString("cbs_static_data_desc"));
						else
						strDesc=strDesc+","+Helper.correctNull(rs3.getString("cbs_static_data_desc"));
					}
					hshResult.put("strConstDesc", strDesc);
				}
			}
			}
			if(rs!=null)
				rs.close();
			if(!strCompAppOldid.equalsIgnoreCase(""))
			{
				rs=DBUtils.executeLAPSQuery("selappidnewwithconsleanding^"+strCompAppOldid);			
				if(rs.next())
				{
					hshResult.put("PERAPP_CONSTITUTIONNEW", Helper.correctNull((String)rs.getString("PERAPP_CONSTITUTIONNEW")));
					hshResult.put("PERAPP_LENDING", Helper.correctNull((String)rs.getString("PERAPP_LENDING")));
					
				}
			}
			
			//Get Number of Gold Loan Proposals Utilized
			strQuery=SQLParser.getSqlQuery("get_perdemographics_oldid_renew^"+strCommappId);
			rs=DBUtils.executeQuery(strQuery);
			String countgoldloan="0",maxgoldloan="0";
			if(rs.next()) {
				strQuery=SQLParser.getSqlQuery("sel_GoldLoansCount^"+correctNull((String)rs.getString("perapp_oldid"))+"^"+correctNull((String)hshValues.get("strappno")));
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
					countgoldloan=Helper.correctInt((String)rs1.getString("goldloans"));
			}
			strQuery=SQLParser.getSqlQuery("selgoldratemaster^Y");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
				maxgoldloan=Helper.correctInt((String)rs.getString("grm_maxgoldloans"));
			hshResult.put("countgoldloan", countgoldloan);
			hshResult.put("maxgoldloan", maxgoldloan);
			
			
			//Existing Vehicle loan under TSCQV scheme check 
			if(rs!=null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("selstaffvehicleloanchk^"+strLapsOldId+"^"+correctNull((String)hshValues.get("strappno")));
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next()) 
			{
				hshResult.put("strStaffVechChk", "Y");
			}
			//Existing Housing loan check for Home Top up Loan
			if(rs!=null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("sel_existinghousingloanchk^"+strLapsOldId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next()) 
			{
				hshResult.put("strExistingHousingLoanChk", "Y");;
			}
			//Check Whether the applicant have any pending application in suvidha OD Loan
			if(rs!=null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("sel_existingsuvidhaloanchk^"+strLapsOldId+"^"+correctNull((String)hshValues.get("strappno")));
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next()) 
			{
				hshResult.put("strExistingSuvidhaLoanChk", "Y");;
			}
			
			if(rs!=null)
				rs.close();
			if(rs3!=null)
				rs3.close();
			String  strdepositNriValid="N";
			
				
				if (!strCommappId.equalsIgnoreCase("")) {
				strQuery = SQLParser.getSqlQuery("sel_customerdetail^"+ strCommappId);
				rs3 = DBUtils.executeQuery(strQuery);
				if (rs3.next()) {
					
						hshResult.put("INDINFO_RESIDENT_STATUS", Helper.correctNull(rs3.getString("INDINFO_RESIDENT_STATUS")));
					
				}
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in closing getData"+ce.getMessage());
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
			catch(Exception e)
			{
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}		
		return hshResult;
	}

	public HashMap getAppData(HashMap hshRequestValues)
	{		 
		String strQuery = "";
		String flag="";
		ResultSet rs = null;
		ResultSet rs1=null;
		HashMap hshRecord = new HashMap();		
		String appno = Helper.correctNull((String)hshRequestValues.get("appno"));
		String strApptype=Helper.correctNull((String)hshRequestValues.get("strApptype"));
		String strSanctionReferenceno="";
		
		if(appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshRequestValues.get("strappno"));
		}
		String formtype = "";
		try
		{
			if(!appno.equalsIgnoreCase("new"))
			{
				if(strApptype.equalsIgnoreCase(""))
				{
				strQuery= SQLParser.getSqlQuery("comfunsel1^"+appno);
 				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					formtype = Helper.correctDoubleQuote(correctNull(rs.getString("app_loantype")));
				}
				}
				else
				{
					formtype = strApptype;
				}
				
				
				if(formtype.equalsIgnoreCase("P") || formtype.equalsIgnoreCase("D"))
				{			 
					strQuery= SQLParser.getSqlQuery("comfunsel2_apptag^"+appno);
				}
				else if((formtype.equalsIgnoreCase("C")) || (formtype.equalsIgnoreCase("E"))|| (formtype.equalsIgnoreCase("U")) || (formtype.equalsIgnoreCase("H")) || formtype.equalsIgnoreCase("A"))
				{	
					flag="true";
					strQuery= SQLParser.getSqlQuery("comfunsel3_apptag^"+appno);
				}		 
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					hshRecord = new HashMap();
					hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
					hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
					hshRecord.put("applicantid", rs.getString("demo_appid"));
					hshRecord.put("apporgcode", rs.getString("app_orgcode"));
					hshRecord.put("inwardno", rs.getString("app_inwardno"));
					hshRecord.put("applevel", rs.getString("app_orglevel"));
					hshRecord.put("valuesin", rs.getString("app_valuesin"));
					hshRecord.put("applnholder",correctNull(rs.getString("app_applnholder")));
					strQuery=SQLParser.getSqlQuery("sel_inwardrlpc^"+Helper.correctNull(rs.getString("app_inwardno")));
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						hshRecord.put("apporgname",correctNull(rs.getString("org_name"))+" [CLPH]");
					}
					
					else if(Helper.correctNull(rs.getString("inward_applnprocessat")).equalsIgnoreCase("3"))
						hshRecord.put("apporgname",correctNull(rs.getString("org_name"))+" [CLPU]");
					else
						hshRecord.put("apporgname",correctNull(rs.getString("org_name")));
					
					hshRecord.put("apploantype",formtype);
					hshRecord.put("repaytype",correctNull(rs.getString("loan_repaymenttype")));
					hshRecord.put("CBSACCOUNTNO",Helper.correctNull(rs.getString("CBS_ACCOUNTNO")));
					hshRecord.put("applicantnewid",correctNull(rs.getString("demo_appnewid")));
					if(flag=="true")
					{
						//hshRecord.put("app_proptype",correctNull(rs.getString("inward_proptype")));
						hshRecord.put("app_proptype",formtype.toUpperCase());
					}
					hshRecord.put("ApplicantType",correctNull(rs.getString("app_renew_flag")));
				}
			}
			hshRecord.put("appno", appno);
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_SancRefNo^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strSanctionReferenceno= Helper.correctNull(rs.getString("sanctionrefno"));
			}
			hshRecord.put("sanctionrefno", strSanctionReferenceno);
			
			if(formtype.equalsIgnoreCase("P"))
			{
				if (rs != null) {
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("sel_accountopeningretail^" + appno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("strAccopenDate", Helper.correctNull(rs.getString("laps_handoff_time")));
					hshRecord.put("strAccopenFlag", "Done");
				}
				else
				{
					hshRecord.put("strAccopenFlag", "Not Done");
				}
			}
			
			if(rs!=null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("select_revalidationstat^" + appno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				if(Helper.correctNull(rs.getString("app_status")).equalsIgnoreCase("op"))
						hshRecord.put("strRevalidationFlag","Pending");
				else if(Helper.correctNull(rs.getString("app_status")).equalsIgnoreCase("pa"))
					hshRecord.put("strRevalidationFlag","Approved");
				else if(Helper.correctNull(rs.getString("app_status")).equalsIgnoreCase("pr"))
					hshRecord.put("strRevalidationFlag","Rejected");
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

	/*public void unLockApplication(HashMap hshValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String strUserId="";
		try
		{
			strUserId=correctNull((String)hshValues.get("strUserId"));
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","unlockapplication");
			arrValues.add(strUserId);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
		}			
	}
	
	public String lockApplication(HashMap hshValues) 
	{		 
		ResultSet rs=null;
		String strQuery="";
		String strAppno="";
		String strUserId="";
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		int intCount=0;
		String strLockFlag="n";
		try
		{
			strAppno=correctNull((String)hshValues.get("appno"));
			strUserId=correctNull((String)hshValues.get("strUserId"));
			strQuery=SQLParser.getSqlQuery("lockapplicationsel^"+strAppno+"^"+strUserId);
			rs =DBUtils.executeQuery(strQuery);
 
			if(rs.next())
			{
				intCount=rs.getInt(1);
			}
			if(intCount==0)
			{
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","lockapplicationupd");
				arrValues.add(strAppno);
				arrValues.add(strUserId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				strLockFlag="y";
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
				if(rs!=null)
				{
					rs.close();
				}
			}
			catch(Exception e1)
			{
				throw new EJBException("Error closing connection.. "+e1);
			}
		}		
		return strLockFlag;
	}*/
	
	public String getAppno(HashMap hshValues) 
	{
		String strOrgShortCode="",strBorrowerId="";
		ResultSet rs=null;
		String strAppno="";
		long longAppno=0;
		String strQuery="",strExp="$";
		int intLen=0;
		String strSolid=Helper.correctNull((String)hshValues.get("strSolid"));
		java.text.NumberFormat nf=java.text.NumberFormat.getNumberInstance();
		nf.setMinimumIntegerDigits(7);
		nf.setGroupingUsed(false);
		try
		{
 			String strApptype = correctNull((String)hshValues.get("apptype"));
			strBorrowerId = correctNull((String)hshValues.get("comapp_id"));
			/*if(strApptype.trim().equals("C"))
			{
				strQuery=SQLParser.getSqlQuery("findBorrowerOrgCom^"+strBorrowerId);
				if(rs != null)
				{
					rs.close();
				}
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strOrgShortCode =correctNull((String)rs.getString(1));
				}
			}
			else if(strApptype.trim().equals("P") || strApptype.trim().equals("A") || strApptype.trim().equals("T"))
			{
				strQuery=SQLParser.getSqlQuery("findBorrowerOrgPer^"+strBorrowerId);
				if(rs != null)
				{
					rs.close();
				}
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strOrgShortCode =correctNull((String)rs.getString(1));
				}
			}	*/
			strOrgShortCode=strSolid;
			strOrgShortCode = strOrgShortCode.trim();
			int scodeLength=strOrgShortCode.length();
			if(strOrgShortCode.equals(""))
			{
				strExp =strExp + "There is no organisation attached with user";
				throw new Exception(strExp);
			}
			else{
				if(scodeLength==1){
					strOrgShortCode="000"+strOrgShortCode;
				}
				if(scodeLength==2){
					strOrgShortCode="00"+strOrgShortCode;
				}
				if(scodeLength==3){
					strOrgShortCode="0"+strOrgShortCode;
				}
			}
			intLen=strOrgShortCode.length();
			strQuery=SQLParser.getSqlQuery("getAppno^"+(intLen+1)+"^"+intLen+"^"+strOrgShortCode);
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				longAppno=(rs.getLong(1));
			}
			longAppno++;
			strAppno=strOrgShortCode+nf.format(longAppno);
		}
		catch(Exception e)
		{
 			throw new EJBException(e.toString());
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
			catch(Exception e1)
			{
				throw new EJBException("Error closing connection.. "+e1);
			}
		}
		return strAppno;
	}
	public String getRatingAppno(HashMap hshValues) 
	{
		String strOrgShortCode="",strBorrowerId="";
		ResultSet rs=null;
		String strAppno="";
		long longAppno=0;
		String strQuery="",strExp="$";
		int intLen=0;
		String strSolid=Helper.correctNull((String)hshValues.get("strSolid"));
		java.text.NumberFormat nf=java.text.NumberFormat.getNumberInstance();
		nf.setMinimumIntegerDigits(6);
		nf.setGroupingUsed(false);
		try
		{
			strBorrowerId = correctNull((String)hshValues.get("comapp_id"));
			strOrgShortCode=strSolid;
			strOrgShortCode = strOrgShortCode.trim();
			int scodeLength=strOrgShortCode.length();
			if(strOrgShortCode.equals(""))
			{
				strExp =strExp + "There is no organisation attached with user";
				throw new Exception(strExp);
			}
			else{
				if(scodeLength==1){
					strOrgShortCode="000"+strOrgShortCode;
				}
				if(scodeLength==2){
					strOrgShortCode="00"+strOrgShortCode;
				}
				if(scodeLength==3){
					strOrgShortCode="0"+strOrgShortCode;
				}
			}
			intLen=strOrgShortCode.length();
			strQuery=SQLParser.getSqlQuery("getRatAppno^"+(intLen+2)+"^"+intLen+"^"+strOrgShortCode);
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				longAppno=(rs.getLong(1));
			}
			longAppno++;
			strAppno=strOrgShortCode+'O'+nf.format(longAppno);
		}
		catch(Exception e)
		{
 			throw new EJBException(e.toString());
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
			catch(Exception e1)
			{
				throw new EJBException("Error closing connection.. "+e1);
			}
		}
		return strAppno;
	}
	
	public HashMap getOrgCode(HashMap hshOrgcode)
	{
		ResultSet rs = null;
		String strOrgCode = "";
		HashMap hshOrg = new HashMap();

		try
		{
			strOrgCode = (String)hshOrgcode.get("OrgCode");
			if(strOrgCode == null)
			{
				strOrgCode = "";
			}
			hshOrg = new HashMap();
			rs=DBUtils.executeLAPSQuery("getorgcode^"+strOrgCode);
			if(rs.next())
			{
				hshOrg.put("OrgCode",correctNull((String)rs.getString(1)));
			}
			else
			{
				hshOrg.put("OrgCode","");
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
		return hshOrg;
	}

	public HashMap getParentName(HashMap hshValues) 
	{
		ResultSet rs=null;
		int flag=0;
		int flags=0;
		int flagb=0;
		String crpno="";
		String zonno="";
		String regno="";
		String brnno="";
		String crpname="";
		String zonname="";
		String regname="";
		String brnname="";
		String CO="",Zone="",Region="",Branch="";
		HashMap hshResult=new HashMap();			
		String appno=correctNull((String)hshValues.get("appno"));
		String bid="0";
	    bid=correctNull((String)hshValues.get("bid"));
		appno= appno.trim();
		String strAppno="000000000000000";		
		try
		{			 
			if(!appno.equals(""))
			{ 
				rs=DBUtils.executeLAPSQuery("selorgno^"+appno);
			}
			else
			{			 
				rs=DBUtils.executeLAPSQuery("selorgwithborrower^"+bid);
			}			 			
			while(rs.next())
			{
				strAppno=correctNull(rs.getString(1));
			}
			crpno=strAppno.substring(0,3)+"000000000000";
			zonno=strAppno.substring(0,6)+"000000000";
			regno=strAppno.substring(0,9)+"000000";
			brnno=strAppno.substring(0,12)+"000";

		    if(zonno.equals(crpno))
			{
				flag=1;
			}
			else
			{
				flag=0;
			}
			if(regno.equals(zonno))
			{
				flags=1;
			}
			else
			{
				flags=0;
			}
			if(brnno.equals(regno))
			{
				flagb=1;
			}
			else
			{
				flagb=0;
			}
			rs=DBUtils.executeLAPSQuery("selorgname^"+crpno);
			while(rs.next())
			{
				crpname=correctNull(rs.getString("org_name"));
			}
			if(flag==0)
			{				 
				rs=DBUtils.executeLAPSQuery("selorgname^"+zonno);			
				while(rs.next())
				{
					zonname=correctNull(rs.getString("org_name"));
				}
			}
			if(flags==0)
			{
				rs=DBUtils.executeLAPSQuery("selorgwithborrower^"+bid);

				while(rs.next())
				{
					regname=correctNull(rs.getString("org_name"));
				}
			}
			if(flagb==0)
			{				 
				rs=DBUtils.executeLAPSQuery("selorgname^"+brnno);

				while(rs.next())
				{
					brnname=correctNull(rs.getString("org_name"));
				}
			}
			rs=DBUtils.executeLAPSQuery("selOrgLabel");
			while(rs.next())
			{
				CO=correctNull(rs.getString("glp_orgname1"));
				Zone=correctNull(rs.getString("glp_orgname2"));
				Region=correctNull(rs.getString("glp_orgname3"));
				Branch=correctNull(rs.getString("glp_orgname4"));
			}
			hshResult.put("crpname",crpname);
			hshResult.put("zonname",zonname);
			hshResult.put("regname",regname);
			hshResult.put("brnname",brnname);	
			hshResult.put("CO",CO);
			hshResult.put("Zone",Zone);
			hshResult.put("Region",Region);
			hshResult.put("Branch",Branch);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in closing getParentName"+ce.getMessage());
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
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}		
		return hshResult;
	}
	
	public HashMap getToolBarData(HashMap hshRequestValues)
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arryRow=new ArrayList();
		ArrayList arryCol=new ArrayList();
		String strModule = (String) hshRequestValues.get("strModule");
		try
		{
			rs=DBUtils.executeLAPSQuery("seltbarall^"+ strModule);
			while(rs.next())
			{
				arryCol=new ArrayList();
				arryCol.add(correctNull((String)rs.getString(1)));
				arryCol.add(correctNull((String)rs.getString(2)));
				arryCol.add(correctNull((String)rs.getString(3)));
				arryCol.add(correctNull((String)rs.getString(4)));
				arryCol.add(correctNull((String)rs.getString(5)));			
				arryRow.add(arryCol);
			}
			hshRecord.put("arryRow",arryRow);	
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
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}
	
	//creating NPA Application NO
	
	public String getNPAAppno(HashMap hshValues) 
	{
		//String strOrgShortCode="",strBorrowerId="";
		ResultSet rs=null;
		String strAppno="";
		long longAppno=0;
		String strQuery="";
		String strNPA="NPA";
		java.text.NumberFormat nf=java.text.NumberFormat.getNumberInstance();
		//nf.setMinimumIntegerDigits(12);
		/*
		 * if the application number is changed as like the following format use this one
		 * "NPAOTSCO9999999"*/
		 nf.setMinimumIntegerDigits(7);
		 String strnpamoduletype=correctNull((String)hshValues.get("npatype"));
		 int intLen=0;
		
		nf.setGroupingUsed(false);
		try
		{
			if(!strnpamoduletype.equalsIgnoreCase(""))
			{
				if(rs!=null)
				{
					rs.close();
				}
				/*
				 * if the application number is changed as like the following format use this one
				 "NPAOTSCO9999999"*/
				intLen = strnpamoduletype.length();
				strQuery=SQLParser.getSqlQuery("getNPA_appno^"+(intLen+4)+"^"+(intLen+3)+"^NPA"+strnpamoduletype);
			 
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					longAppno=(rs.getLong(1));
				}
				longAppno++;
				/*
				 * if the application number is changed as like the following format use this one
				 "NPAOTSCO9999999"*/
				strAppno=strNPA+strnpamoduletype+nf.format(longAppno);
			}
			else
			{
				throw new Exception("$" + "Define the npa module type");
			}
		}
		catch(Exception e)
		{
 			throw new EJBException(e.toString());
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
			catch(Exception e1)
			{
				throw new EJBException("Error closing connection.. "+e1);
			}
		}
		return strAppno;
	}
	
	public HashMap getProductAppList(HashMap hshValues) 
	{		 
		ResultSet rs=null;
		ResultSet rs1=null;
		HashMap hshResult=new HashMap();
		ArrayList arryRow=new ArrayList();
		ArrayList arryCol=null;
		
		String strPrdName=correctNull((String)hshValues.get("prdname"));
		String strOrgScode=correctNull((String)hshValues.get("orgscode"));
		if(strOrgScode.equalsIgnoreCase(""))
		{
			strOrgScode = correctNull((String)hshValues.get("orgscode1"));
		}
		String strOrgLevel=correctNull((String)hshValues.get("orglevel"));
		if(strOrgLevel.equalsIgnoreCase(""))
		{
			strOrgLevel = correctNull((String)hshValues.get("orglevel1"));
		}
		String strCategorytype=correctNull((String)hshValues.get("hidCategoryType"));
		String strOrgCode=correctNull((String)hshValues.get("orgcode"));
		if(strOrgCode.equalsIgnoreCase(""))
		{
			strOrgCode = correctNull((String)hshValues.get("orgcode1"));
		}
		String strBankVal="";
		String strQuery ="";
		String strShortCode="";
		String strProducttype="";
		try
		{
			
			strProducttype = Helper.correctNull((String)hshValues.get("strProductType"));
			
			if (strOrgLevel.equalsIgnoreCase("C"))
			{
				strBankVal = "'"+strOrgCode.substring(0,3)+"000000000000'";
			}
			else if (strOrgLevel.equalsIgnoreCase("R"))
			{
				strBankVal = "'"+strOrgCode.substring(0,6)+"000000000";
				strBankVal = strBankVal +"','"+ strOrgCode.substring(0,3)+"000000000000'";
			}
			else if (strOrgLevel.equalsIgnoreCase("D"))
			{
				strBankVal = "'"+strOrgCode.substring(0,9)+"000000";
				strBankVal = strBankVal+"','"+ strOrgCode.substring(0,6)+"000000000";
				strBankVal = strBankVal +"','"+ strOrgCode.substring(0,3)+"000000000000'";
			}
			else if (strOrgLevel.equalsIgnoreCase("A"))
			{
				strBankVal = "'"+strOrgCode.substring(0,12)+"000";
				strBankVal = strBankVal+"','"+strOrgCode.substring(0,9)+"000000";
				strBankVal = strBankVal+"','"+ strOrgCode.substring(0,6)+"000000000";
				strBankVal = strBankVal +"','"+ strOrgCode.substring(0,3)+"000000000000'";
			}
			else if (strOrgLevel.equalsIgnoreCase("B"))
			{
				strBankVal = "'"+strOrgCode.substring(0,15);
				strBankVal = strBankVal+"','"+strOrgCode.substring(0,12)+"000";
				strBankVal = strBankVal+"','"+strOrgCode.substring(0,9)+"000000";
				strBankVal = strBankVal+"','"+ strOrgCode.substring(0,6)+"000000000";
				strBankVal = strBankVal +"','"+ strOrgCode.substring(0,3)+"000000000000'";
			}
			String strType ="";
			String strorgScode = "";
			
			if(!strCategorytype.equals("") && !strPrdName.equals(""))
			{				 
				strQuery= SQLParser.getSqlQuery("selorgsortcode^"+strBankVal);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					strShortCode= rs.getString(1);
					if(!strShortCode.equals(""))
					{ 
						strorgScode = "%"+strShortCode+"%";
						if(strCategorytype.equalsIgnoreCase("LAD"))
						{
							strType="prd_type in ('aR','aH','pR','pG') ";
						}
						else if(strCategorytype.equalsIgnoreCase("AGR"))
						{
							strType="prd_type like 'a%' ";
						}
						else if(strCategorytype.equalsIgnoreCase("RET"))
						{
							strType="prd_type like 'p%' ";
						}
						strQuery=SQLParser.getSqlQuery("sel_productlist_afterapp^"+strorgScode+"^<=^"+strType+"^"+strPrdName+"^"+strProducttype);
						rs1=DBUtils.executeQuery(strQuery);							
						while (rs1.next())
						{
							arryCol=new ArrayList();
							arryCol.add(correctNull((String)rs1.getString("prdcode")));//0
							arryCol.add(correctNull((String)rs1.getString("category")));//1
							arryCol.add(correctNull((String)rs1.getString("subcategory")));//2
							arryCol.add(correctNull((String)rs1.getString("rangefrom")));//3
							arryCol.add(correctNull((String)rs1.getString("rangeto")));//4
							arryCol.add(correctNull((String)rs1.getString("term")));//5
							arryCol.add(correctNull((String)rs1.getString("prd_type")));//6
							arryCol.add(correctNull((String)rs1.getString("prd_principal")));//7
							arryCol.add(correctNull((String)rs1.getString("prd_interest")));//8
							arryCol.add(correctNull((String)rs1.getString("prd_staffprd")));//9
							arryCol.add(correctNull((String)rs1.getString("prd_appminage")));//10
							arryCol.add(correctNull((String)rs1.getString("nsc_loan")));//11
							arryCol.add(correctNull((String)rs1.getString("scheme_code")));//12
							arryCol.add(correctNull((String)rs1.getString("minterm")));//13
							arryRow.add(arryCol);
							
						}
						rs1.close();
					}						
				}									
			}
			
			hshResult.put("arryRow",arryRow);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in closing getData"+ce.getMessage());
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
			catch(Exception e)
			{
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}		
		return hshResult;
	}
	
	public HashMap getActivityList(HashMap hshValues) 
	{		 
		ResultSet rs=null,rs1=null;
		HashMap hshResult=new HashMap();
		ArrayList arryRow=new ArrayList();
		ArrayList arryCol=null;
		String strSchemetype="'"+Helper.correctNull((String)hshValues.get("facscheme"))+"'";
		if(strSchemetype.equalsIgnoreCase(""))
		{
			strSchemetype=Helper.correctNull((String)hshValues.get("schemetype"));
		}
		String appno=Helper.correctNull((String)hshValues.get("appno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno=Helper.correctNull((String)hshValues.get("hidappno"));
		}
		String strQuery="",strSearch="",strValue="";
		strSearch=Helper.correctNull((String)hshValues.get("hidvalue"));
		strValue=Helper.correctNull((String)hshValues.get("txt_value"));
		NumberFormat nft=NumberFormat.getInstance();
		nft.setMinimumFractionDigits(2);
		nft.setMaximumFractionDigits(2);
		nft.setGroupingUsed(false);
		
		String strUnitCostAvail="";
		String strUnitCostavailSecond="",branchdet="",ORG_STATE="",STATE_ID="",actname="";
		actname=Helper.correctNull((String)hshValues.get("actname"));
		try
		{
			if(!Helper.correctNull((String)hshValues.get("strfrom")).equalsIgnoreCase("plantdet"))
			{
				strQuery= SQLParser.getSqlQuery("sel_agriculture_facilities^"+appno);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					if(strSchemetype.equalsIgnoreCase(""))
					{
						strSchemetype="'"+Helper.correctNull((String)rs.getString("facility_agrschemetype"))+"'";
					}
					else
					{
						strSchemetype=strSchemetype+",'"+Helper.correctNull((String)rs.getString("facility_agrschemetype"))+"'";
					}
					
				}
			}
			
			
			strQuery= SQLParser.getSqlQuery("agr_unitcostbrabchapp^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{				
				branchdet=Helper.correctNull((String)rs.getString("APP_ORGCODE"));								
			}
			
			if(rs!=null)
			{
				rs.close();
			}
			strQuery= SQLParser.getSqlQuery("agr_unitcostorgbranchdet^"+branchdet);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{				
				ORG_STATE=Helper.correctNull((String)rs.getString("ORG_STATE"));								
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery= SQLParser.getSqlQuery("agr_unitcoststatedet^"+ORG_STATE);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{				
				STATE_ID=Helper.correctNull((String)rs.getString("STATE_ID"));								
			}
			
			if(rs!=null)
			{
				rs.close();
			}
			
			
			
			if(strSearch.equalsIgnoreCase("activity"))
			{
				
				strQuery= SQLParser.getSqlQuery("sel_activitymaster_byname^"+strValue+"^"+strSchemetype);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
							arryCol=new ArrayList();
							arryCol.add(correctNull((String)rs.getString("ACT_SCHEME")));//0
							//arryCol.add(correctNull((String)rs.getString("ACT_DESC")));//1
							
							strQuery = SQLParser.getSqlQuery("sel_static_data_masterauc1^"+"286"+"^"+correctNull((String)rs.getString("ACT_DESC")));
							rs1 = DBUtils.executeQuery(strQuery);
							
							if(rs1.next())
							{
								arryCol.add(Helper.correctNull((String)rs1.getString("stat_data_desc1")));
							}
							else
							{
								arryCol.add(correctNull((String)rs.getString("ACT_DESC")));
							}
							
							
							if(rs1!=null)							
							{
								rs1.close();
							}
							
							arryCol.add(correctNull((String)rs.getString("ACT_AVAILABLE")));//2
							arryCol.add(nft.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("ACT_RANGEFROM")))));//3
							arryCol.add(nft.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("ACT_RANGETO")))));//4
							arryCol.add(correctNull((String)rs.getString("ACT_SNO")));//5
							arryCol.add(correctNull((String)rs.getString("ACT_YEARS")));//6
							arryCol.add(correctNull((String)rs.getString("ACT_DESC2")));//7
							arryCol.add(correctNull((String)rs.getString("ACT_AMT2")));//8
							arryCol.add(correctNull((String)rs.getString("ACT_WHETHER2")));//9
							arryCol.add(correctNull((String)rs.getString("ACT_SCHEME_SNO")));//10
							//arryCol.add(correctNull((String)rs.getString("ACT_SPECIFICATIONS")));//11
							
							strQuery = SQLParser.getSqlQuery("sel_static_data_masterauc1^"+"287"+"^"+correctNull((String)rs.getString("ACT_SPECIFICATIONS")));
							rs1 = DBUtils.executeQuery(strQuery);
							
							if(rs1.next())
							{
								arryCol.add(Helper.correctNull((String)rs1.getString("stat_data_desc1")));
							}
							else
							{
								arryCol.add(correctNull((String)rs.getString("ACT_SPECIFICATIONS")));
							}
							
							
							if(rs1!=null)							
							{
								rs1.close();
							}
							
							arryCol.add(correctNull((String)rs.getString("ACT_RANGEPER")));//12
							arryRow.add(arryCol);
				}
			}
			
			if(strSearch.equalsIgnoreCase("Specifications"))
			{
				
				strQuery= SQLParser.getSqlQuery("sel_activitymaster_byspecname^"+strValue+"^"+strSchemetype);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
							arryCol=new ArrayList();
							arryCol.add(correctNull((String)rs.getString("ACT_SCHEME")));//0
							//arryCol.add(correctNull((String)rs.getString("ACT_DESC")));//1
							strQuery = SQLParser.getSqlQuery("sel_static_data_masterauc1^"+"286"+"^"+correctNull((String)rs.getString("ACT_DESC")));
							rs1 = DBUtils.executeQuery(strQuery);
							
							if(rs1.next())
							{
								arryCol.add(Helper.correctNull((String)rs1.getString("stat_data_desc1")));
							}
							else
							{
								arryCol.add(correctNull((String)rs.getString("ACT_DESC")));
							}
							
							
							if(rs1!=null)							
							{
								rs1.close();
							}
							
							arryCol.add(correctNull((String)rs.getString("ACT_AVAILABLE")));//2
							arryCol.add(nft.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("ACT_RANGEFROM")))));//3
							arryCol.add(nft.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("ACT_RANGETO")))));//4
							arryCol.add(correctNull((String)rs.getString("ACT_SNO")));//5
							arryCol.add(correctNull((String)rs.getString("ACT_YEARS")));//6
							arryCol.add(correctNull((String)rs.getString("ACT_DESC2")));//7
							arryCol.add(correctNull((String)rs.getString("ACT_AMT2")));//8
							arryCol.add(correctNull((String)rs.getString("ACT_WHETHER2")));//9
							arryCol.add(correctNull((String)rs.getString("ACT_SCHEME_SNO")));//10
							//arryCol.add(correctNull((String)rs.getString("ACT_SPECIFICATIONS")));//11
							
							strQuery = SQLParser.getSqlQuery("sel_static_data_masterauc1^"+"287"+"^"+correctNull((String)rs.getString("ACT_SPECIFICATIONS")));
							rs1 = DBUtils.executeQuery(strQuery);
							
							if(rs1.next())
							{
								arryCol.add(Helper.correctNull((String)rs1.getString("stat_data_desc1")));
							}
							else
							{
								arryCol.add(correctNull((String)rs.getString("ACT_SPECIFICATIONS")));
							}
							
							
							if(rs1!=null)							
							{
								rs1.close();
							}
							arryCol.add(correctNull((String)rs.getString("ACT_RANGEPER")));//12
							arryRow.add(arryCol);
				}
			}
			
			else if((!STATE_ID.equalsIgnoreCase("")) && actname.equalsIgnoreCase(""))
			{
				strQuery= SQLParser.getSqlQuery("sel_activitymasterstatewiseagrunitcostact^"+strSchemetype+"^"+STATE_ID);
				rs=DBUtils.executeQuery(strQuery);
				//actname
				while(rs.next())
				{
							arryCol=new ArrayList();
							arryCol.add(correctNull((String)rs.getString("ACT_SCHEME")));//0
							//arryCol.add(correctNull((String)rs.getString("ACT_DESC")));//1
							
							strQuery = SQLParser.getSqlQuery("sel_static_data_masterauc1^"+"286"+"^"+correctNull((String)rs.getString("ACT_DESC")));
							rs1 = DBUtils.executeQuery(strQuery);
							
							if(rs1.next())
							{
								arryCol.add(Helper.correctNull((String)rs1.getString("stat_data_desc1")));
							}
							else
							{
								arryCol.add(correctNull((String)rs.getString("ACT_DESC")));
							}
							
							
							if(rs1!=null)							
							{
								rs1.close();
							}
							
							arryCol.add(correctNull((String)rs.getString("ACT_AVAILABLE")));//2
							strUnitCostAvail=Helper.correctNull((String)rs.getString("ACT_AVAILABLE"));
							if(strUnitCostAvail.equalsIgnoreCase("Y"))
							{
								arryCol.add(nft.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("ACT_RANGEFROM")))));//3
								arryCol.add(nft.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("ACT_RANGETO")))));//4	
							}
							else
							{
								arryCol.add("0.00");	
								arryCol.add("0.00");	
							}
							arryCol.add(correctNull((String)rs.getString("ACT_SNO")));//5
							if(strUnitCostAvail.equalsIgnoreCase("Y")){
								
								strUnitCostavailSecond=Helper.correctNull((String)rs.getString("ACT_WHETHER2"));
								
								if(strUnitCostavailSecond.equalsIgnoreCase("Y"))
								{
									arryCol.add(correctNull((String)rs.getString("ACT_YEARS")));//6
									arryCol.add(correctNull((String)rs.getString("ACT_DESC2")));//7
									arryCol.add(correctNull((String)rs.getString("ACT_AMT2")));//8
									arryCol.add(correctNull((String)rs.getString("ACT_WHETHER2")));//9		
								}
								else
								{
									arryCol.add("0");//6
									arryCol.add("");//7
									arryCol.add("0.00");//8
									arryCol.add("");//9		
								}
							}
							else
							{
								arryCol.add("0");//6
								arryCol.add("");//7
								arryCol.add("0.00");//8
								arryCol.add("");//9	
							}
							arryCol.add(correctNull((String)rs.getString("ACT_SCHEME_SNO")));//10
							//arryCol.add(correctNull((String)rs.getString("ACT_SPECIFICATIONS")));//11
							
							
							strQuery = SQLParser.getSqlQuery("sel_static_data_masterauc1^"+"287"+"^"+correctNull((String)rs.getString("ACT_SPECIFICATIONS")));
							rs1 = DBUtils.executeQuery(strQuery);
							
							if(rs1.next())
							{
								arryCol.add(Helper.correctNull((String)rs1.getString("stat_data_desc1")));
							}
							else
							{
								arryCol.add(correctNull((String)rs.getString("ACT_SPECIFICATIONS")));
							}
							
							
							if(rs1!=null)							
							{
								rs1.close();
							}
							arryCol.add(correctNull((String)rs.getString("ACT_RANGEPER")));//12
							arryRow.add(arryCol);
				}
			}
			
			
			else if(!STATE_ID.equalsIgnoreCase("") && !actname.equalsIgnoreCase(""))
			{
				
				strQuery = SQLParser.getSqlQuery("sel_static_data_masterauc1des^"+"286"+"^"+actname);
				rs1 = DBUtils.executeQuery(strQuery);
				
				if(rs1.next())
				{
					actname=Helper.correctNull((String)rs1.getString("stat_data_desc"));
				}
				else
				{
					actname=correctNull((String)rs.getString("ACT_DESC"));
				}
				
				
				if(rs1!=null)							
				{
					rs1.close();
				}
				
				
				strQuery= SQLParser.getSqlQuery("sel_activitymasterstatewiseagrunitcostspec^"+strSchemetype+"^"+STATE_ID+"^"+actname);
				rs=DBUtils.executeQuery(strQuery);
				//actname
				while(rs.next())
				{
							arryCol=new ArrayList();
							arryCol.add(correctNull((String)rs.getString("ACT_SCHEME")));//0
							//arryCol.add(correctNull((String)rs.getString("ACT_DESC")));//1
							
							strQuery = SQLParser.getSqlQuery("sel_static_data_masterauc1^"+"286"+"^"+correctNull((String)rs.getString("ACT_DESC")));
							rs1 = DBUtils.executeQuery(strQuery);
							
							if(rs1.next())
							{
								arryCol.add(Helper.correctNull((String)rs1.getString("stat_data_desc1")));
							}
							else
							{
								arryCol.add(correctNull((String)rs.getString("ACT_DESC")));
							}
							
							
							if(rs1!=null)							
							{
								rs1.close();
							}
							arryCol.add(correctNull((String)rs.getString("ACT_AVAILABLE")));//2
							strUnitCostAvail=Helper.correctNull((String)rs.getString("ACT_AVAILABLE"));
							if(strUnitCostAvail.equalsIgnoreCase("Y"))
							{
								arryCol.add(nft.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("ACT_RANGEFROM")))));//3
								arryCol.add(nft.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("ACT_RANGETO")))));//4	
							}
							else
							{
								arryCol.add("0.00");	
								arryCol.add("0.00");	
							}
							arryCol.add(correctNull((String)rs.getString("ACT_SNO")));//5
							if(strUnitCostAvail.equalsIgnoreCase("Y")){
								
								strUnitCostavailSecond=Helper.correctNull((String)rs.getString("ACT_WHETHER2"));
								
								if(strUnitCostavailSecond.equalsIgnoreCase("Y"))
								{
									arryCol.add(correctNull((String)rs.getString("ACT_YEARS")));//6
									arryCol.add(correctNull((String)rs.getString("ACT_DESC2")));//7
									arryCol.add(correctNull((String)rs.getString("ACT_AMT2")));//8
									arryCol.add(correctNull((String)rs.getString("ACT_WHETHER2")));//9		
								}
								else
								{
									arryCol.add("0");//6
									arryCol.add("");//7
									arryCol.add("0.00");//8
									arryCol.add("");//9		
								}
							}
							else
							{
								arryCol.add("0");//6
								arryCol.add("");//7
								arryCol.add("0.00");//8
								arryCol.add("");//9	
							}
							arryCol.add(correctNull((String)rs.getString("ACT_SCHEME_SNO")));//10
							//arryCol.add(correctNull((String)rs.getString("ACT_SPECIFICATIONS")));//11
							
							strQuery = SQLParser.getSqlQuery("sel_static_data_masterauc1^"+"287"+"^"+correctNull((String)rs.getString("ACT_SPECIFICATIONS")));
							rs1 = DBUtils.executeQuery(strQuery);
							
							if(rs1.next())
							{
								arryCol.add(Helper.correctNull((String)rs1.getString("stat_data_desc1")));
							}
							else
							{
								arryCol.add(correctNull((String)rs.getString("ACT_SPECIFICATIONS")));
							}
							
							
							if(rs1!=null)							
							{
								rs1.close();
							}
							
							
							arryCol.add(correctNull((String)rs.getString("ACT_RANGEPER")));//12
							arryRow.add(arryCol);
				}
			}
			hshResult.put("arryRow",arryRow);
			hshResult.put("appno",appno);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getActivityList"+ce.getMessage());
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
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}		
		return hshResult;
	}
	
	
	
	public HashMap generateTokenVal(HashMap hshValues)throws EJBException
	 {
	 	HashMap hshQuery 						= new HashMap();
	 	HashMap hshQueryValues 					= new HashMap();
	 	FileReader fr 							= null;
	 //	String formattedDate 					= ESBWebserviceHelper.getEsbDateFormat();
	 	ArrayList arrValues						= new ArrayList();
	 	Date myDate 							= new Date();
	 	com.sai.laps.pojo.JsonData response = new com.sai.laps.pojo.JsonData();
	 	SimpleDateFormat mdyFormat 				= new SimpleDateFormat("dd/MM/yyyy");//(DD/MM/YYYY)
	 	Gson g 									= new Gson(); 
	 	ResultSet rs1=null;
	 	String Responsecode="",mdy="",strDOB="",response1="";
	 	String orderno="";
		    com.sai.laps.pojo.JsonData readValue = g.fromJson(Helper.correctNull((String)hshValues.get("strServerResponse")), com.sai.laps.pojo.JsonData.class);
		    mdy = mdyFormat.format(myDate);
		    try {
				System.out.println(mdyFormat.parse(mdy));
			} catch (ParseException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		   String ActualRequest="",ActualResponse="",strQuery="",strUniqueMsgId="";
			try
			{
				String reqTime=Helper.correctDateFinacle();
				System.out.println("reqTime========="+reqTime);
				
				
				 SecureRandom secureRandom = new SecureRandom(); //threadsafe
				 Base64.Encoder base64Encoder = Base64.getUrlEncoder(); //threadsafe

				
				
				    byte[] randomBytes = new byte[128];
				    secureRandom.nextBytes(randomBytes);
				    String token= base64Encoder.encodeToString(randomBytes);
					
				response.setToken(token);
				response.setErrorcode("000");
				response.setStatus("Success");
				response.setResTime(Helper.correctDateFinacle());
			}		
	 	
	 	catch(Exception e)
	 	{
	 		System.out.println("Exception  in getorderstatustracker  is ==========="+e.toString());
	 		response = new com.sai.laps.pojo.JsonData();
	 		response.setErrorcode("001");
	 		response.setStatus("Failure");
	 		response.setErrorDescription(e.toString());

	 	}
	 	finally
	 	{
				try
				{
					
				hshValues.put("response",response);
//				GsonBuilder gsonBuilder1 = new GsonBuilder();
//				Gson jsonobject1 = gsonBuilder1.create();
//				ArrayList arrValues1= new ArrayList();
//				arrValues1.add(strUniqueMsgId);
//				arrValues1.add(jsonobject1.toJson(readValue));
//				arrValues1.add(jsonobject1.toJson(response));
//				arrValues1.add(ActualRequest);
//				arrValues1.add(ActualResponse);
//			    arrValues1.add("TAB");	 
//				arrValues1.add("getorderstatustracker");
//				arrValues1.add("CC");
//				arrValues1.add(""+Responsecode);	
//				//ext_services_logger_seqno
//				String seqno="";
//				//ResultSet rs1=null;
//				strQuery= SQLParser.getSqlQuery("ext_services_logger_seqno");	
//				rs1=DBUtils.executeQuery(strQuery);
//				if(rs1.next())
//				{
//					seqno=Helper.correctNull(rs1.getString("seqno"));
//				}
//				if(rs1!=null)rs1.close();
//				arrValues1.add(""+seqno);	
//				hshQuery.put("strQueryId", "ext_services_logger");
//				hshQuery.put("arrValues", arrValues1);
//				hshQueryValues.put("1", hshQuery);
//				hshQueryValues.put("size", "1");
//				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
//					
				}
				catch (Exception e) {
					System.out.println("Exception in Token Generation--------->"+e.toString());
				}
			}
	 return hshValues;	 
	 }
	
}

