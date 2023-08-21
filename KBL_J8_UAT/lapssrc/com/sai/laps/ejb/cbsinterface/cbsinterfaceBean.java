package com.sai.laps.ejb.cbsinterface;

import java.io.Serializable;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;

import com.fasterxml.jackson.databind.AnnotationIntrospector.ReferenceProperty.Type;
import com.google.gson.Gson;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.KblEncyrptionDecyrption;
import com.sai.laps.helper.OAuthTokenGeneration;
import com.sai.laps.helper.SQLParser;

import sun.misc.BASE64Encoder;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayInputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.StringReader;
import java.io.StringWriter;
import java.net.HttpURLConnection;
import java.util.concurrent.TimeUnit;

import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.PrivateKey;
import java.security.cert.X509Certificate;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.TrustManager;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.log4j.Logger;

import org.json.JSONObject;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;


import org.w3c.dom.Node;
import javax.naming.NamingException;
import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;


@Stateless(name = "cbsinterfaceBean", mappedName = "cbsinterfaceHome")
@Remote (cbsinterfaceRemote.class)
public class cbsinterfaceBean extends BeanAdapter 
{

	static Logger log=Logger.getLogger(cbsinterfaceBean.class);	
public HashMap getCbsApplicantData(HashMap hshValues)  
{
		HashMap hshRecord = new HashMap();
		String strCustomer=Helper.correctNull((String) hshValues.get("strCustomer")); //To identify whether the customer is new or existing
		try 
		{
			if(strCustomer.equalsIgnoreCase("existing"))
			{
				hshRecord.put("arryRow", updateLapsDatabase(hshValues, "Update"));
			}
			else if(strCustomer.equalsIgnoreCase("new"))
			{
				hshRecord.put("arryRow", updateLapsDatabase(hshValues,"Insert"));	
			}
			else
			{
				/*
				 * No funciton
				 */
			}
		
		} catch (Exception e) {
			throw new EJBException("Error in getCbsApplicantData" + e.toString());
			
		}
	return hshRecord;
}
private ArrayList updateLapsDatabase(HashMap hshValues, String action)  
{
	HashMap hshQueryValues = new HashMap();
	
	ArrayList arrValues = new ArrayList();
	ResultSet rs = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	
	HashMap hshQuery = new HashMap();//For Perapplicant table
	HashMap hshIndQuery=new HashMap();//For Individual_Info table
	HashMap hshKycQuery=new HashMap();//For applicant_kyc table
	HashMap hshConQuery=new HashMap();//For cust_contactinfo table
	HashMap hshEmpQuery=new HashMap();//For peremployer table
	HashMap hshNRIQuery=new HashMap();//For perapplicant_nri table

	
	
	
	String strQuery = "";
	String strQuery1="";
	String  prefix = "", fname = "", lname = "",strSolid="";
	String strdob = "", strsex = "", strMarital = "", strEmail = "", strReligion = "", strLocation = "";
	String strPresentAdr1 = "",strPresentAdr2="",strPresentCity = "", strPresentZip = "", strPresentState = "", strPresentPho = "";
	String strPerAdrs1 = "",strPerAdrs2="",strPerCity = "";
	String strPerPin = "", strPerState = "", strPresentPho2="";
	
	String strCaste= "",strEmpStatus="",strResidentialStatus="",
	strPassportNo= "",strPassportIssDate= "",strPassportExpDate="",strPassportIssuedBy="",strPanno="",
	strIntroducerName= "",strIntroducerId= "";
	String strAccount_Opening_Year="";
	String strSel_add1="",strSel_add2="";
	String strSel_City="";
	String strSel_state="";
	String strSel_pin="";
	String strSel_country="";
	String strCustConstitution="",strTDSTableCode="",strCustStatusCode="",
	strIDProof="",strAdrsProof1="",strAdrsProof2="",strStaffYN="",strCustEmpID="",
	strCustIntrostatus="",strCustIntroID="",strIntroEmpID="",strIntroTitleCode="",
	strCustIntroName="",strIntroAdrs="",strCustOccCode="", strCustConstitutionNew="";
	
	String strTradeFinance="",strTradeAllowed="",strIsStaff="",strIsMinor="",strPresentCountry="";
	String strPerCountry="",strPresentFax="",strPerFax="",strPerPho="",strPerEmail="";
	String strEmployerZip="",strEmployerState="",strEmployerAdr1="",strEmployerAdr2="",strEmployerCity="";
	String strEmployerPho1="",strEmployerFax="",strEmployerEmail="",strEmployerNo="",strFatherName="";
	String strEducationQua="",strSpouseName="",strSpouseOccupation="",strSpouseQua="",strSpouseAdd1="";
	String strSpouseAdd2="",strCusIDProof="",strCusIDRef="",strCusRating="",strGuarName="";
	String strGuarCode="",strGuarAddr1="",strGuarAddr2="",strGuarCity="",strGuarState="";
	String strGuarPincode="",strGuarCountry="",strNRICountry="",strIntroducerStatus="";
	String strPassportNumber="",strLAPSIntroducerType="",strComGroupId="",strAadharNo="",defid="",cus_def_id="";
	
	ArrayList arryRow = new ArrayList();
	ArrayList arryCol = new ArrayList();
	
	ArrayList arrIndValues=new ArrayList();//For Individual_Info table
	ArrayList arrKycValues=new ArrayList();//For applicant_kyc table
	ArrayList arrConValues=new ArrayList();//For cust_contactinfo table
	ArrayList arrEmpValues=new ArrayList();//For peremployer table
	ArrayList arrNRIValues=new ArrayList();//For perapplicant_nri table

	
	
	try 
	{
		// For Getting the Applicant Details From CBS
		int count=0;
		int NRICount=0;
		String strcustid = Helper.correctNull((String) hshValues.get("custid"));
		String strLapscustid=Helper.correctNull((String) hshValues.get("strLapscustid"));
		if(!strcustid.equalsIgnoreCase(""))
		{
			strQuery = SQLParser.getSqlQuery("sel_nrioverseasdetails^"+ strLapscustid);
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				NRICount=1;
			}
			
			if(rs!=null)
			{
				rs.close();
			}
			if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
			{
				strQuery=SQLParser.getCBSSqlQuery("cbs_custdetails_select_newconnection^"+strcustid);
				rs=DBUtils.executeQueryCBSConnection(strQuery);
			}
			else
			{
				strQuery= SQLParser.getSqlQuery("cbs_custdetails_select^"+strcustid);
				rs=DBUtils.executeQuery(strQuery); 
			}
			if (rs.next()) {
				count++;
				
				/*
				 * The following details are related to perapplicant table
				 */
				strSolid= Helper.correctNull(rs.getString("solid"));//done
				prefix = Helper.correctNull(rs.getString("cust_title_code"));//done
				fname = (String) Helper.correctNull(rs.getString("cust_name"));//done
				lname = (String) Helper.correctNull(rs.getString("cust_short_name"));//done
				strCustConstitutionNew = (String) Helper.correctNull(rs.getString("cust_const"));//done
				if(rs1!=null)
				{
					rs1.close();
				}
				strQuery1=SQLParser.getSqlQuery("sel_CBSStaticDataPassingCode^2^"+strCustConstitutionNew);
				rs1=DBUtils.executeQuery(strQuery1);
				if(rs1.next())
				{
					strCustConstitution=Helper.correctNull((String)rs1.getString("cbs_static_data_passing_code"));
				}
				if(strCustConstitution.trim().equalsIgnoreCase("01")||
						strCustConstitution.trim().equalsIgnoreCase("02"))
				{
					strdob = (String) Helper.correctNull(rs.getString("date_of_birth")).trim();//done
				}
				else
				{
					strdob = (String) Helper.correctNull(rs.getString("dateof_est")).trim();//done
				}
				strsex = (String) Helper.correctNull(rs.getString("cust_sex"));//done
				strMarital = (String) Helper.correctNull(rs.getString("cust_marital_status"));//done
				strPanno = (String) Helper.correctNull(rs.getString("pan_gir_num"));//done
				if(strPanno.equalsIgnoreCase(""))
				{
					strPanno="NOPAN";
				}
				strIntroducerName = (String) Helper.correctNull(rs.getString("cust_introd_name"));//done
				strTradeFinance=(String) Helper.correctNull(rs.getString("party_flg"));//Trade Finance
				strTradeAllowed=(String) Helper.correctNull(rs.getString("inland_trade_allowed"));//Whether Trade Allowed
				strTDSTableCode = (String) Helper.correctNull(rs.getString("tds_tbl_code"));//done
				strFatherName = (String) Helper.correctNull(rs.getString("father_name"));//Father Name
				strCustStatusCode = (String) Helper.correctNull(rs.getString("cust_stat_code"));//done
				strIntroducerStatus=(String) Helper.correctNull(rs.getString("cust_introd_stat_code"));// Introducer status

				
				if(rs1!=null)
				{
					rs1.close();
				}
				strQuery1=SQLParser.getSqlQuery("sel_CBSStaticDataPassingCode^6^"+strIntroducerStatus);
				rs1=DBUtils.executeQuery(strQuery1);
				if(rs1.next())
				{
					strLAPSIntroducerType=Helper.correctNull((String)rs1.getString("cbs_static_data_passing_code"));
				}
				
				if(rs1!=null)
				{
					rs1.close();
				}
				strQuery1=SQLParser.getSqlQuery("sel_CBSStaticDataPassingCode^2^"+strCustConstitutionNew);
				rs1=DBUtils.executeQuery(strQuery1);
				if(rs1.next())
				{
					strCustConstitution=Helper.correctNull((String)rs1.getString("cbs_static_data_passing_code"));
				}
				
				
				/*
				 * The following details are related to INDIVIDUAL_INFO table
				 */
				
				strCaste =(String) Helper.correctNull(rs.getString("cust_caste_code"));//done
				strReligion = (String) Helper.correctNull(rs.getString("cust_commu_code"));//done
				strResidentialStatus = (String) Helper.correctNull(rs.getString("cust_nre_flg")); //done
				strPassportNumber=(String) Helper.correctNull(rs.getString("psprt_num")); //done
				strPassportIssDate=(String) Helper.correctNull(rs.getString("psprt_issu_date"));
				strPassportExpDate=(String) Helper.correctNull(rs.getString("psprt_exp_date"));
				
				strIsStaff=(String) Helper.correctNull(rs.getString("cust_type_code"));//To identify whether staff
				if(!strIsStaff.equalsIgnoreCase("02") && !strIsStaff.equalsIgnoreCase("03"))
				{
					strIsStaff="01";
				}
				strIsMinor=(String) Helper.correctNull(rs.getString("cust_minor_flg"));//To identify minor
				strCustEmpID = (String) Helper.correctNull(rs.getString("cust_emp_id"));//done
				strEducationQua =(String) Helper.correctNull(rs.getString("ed_qualification"));//Education qualification
				strSpouseName = (String) Helper.correctNull(rs.getString("spouse_name"));//Spouse Name
				strSpouseOccupation = (String) Helper.correctNull(rs.getString("spouse_occup"));//Spouse Occupation
				strSpouseQua = (String) Helper.correctNull(rs.getString("spouse_qualif"));//Spouse Qualification
				strSpouseAdd1= (String) Helper.correctNull(rs.getString("spouse_addr_1"));//Spouse Address
				strSpouseAdd2 = (String) Helper.correctNull(rs.getString("spouse_addr_2"));//Spouse Address
				strGuarName = (String) Helper.correctNull(rs.getString("minor_guard_name"));//Guardian Name
				strGuarCode = (String) Helper.correctNull(rs.getString("minor_guard_code"));//Guardian Code
				strGuarAddr1 = (String) Helper.correctNull(rs.getString("minor_guard_addr1"));//Guardian Address1
				strGuarAddr2 = (String) Helper.correctNull(rs.getString("minor_guard_addr2"));//Guardian Address2
				strGuarCity = (String) Helper.correctNull(rs.getString("minor_guard_city_code"));//Guardian City
				if(!strGuarCity.equalsIgnoreCase(""))
				{
					strQuery1=SQLParser.getSqlQuery("selcitycode^"+strGuarCity);
					if(rs1!=null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						strGuarCity=Helper.correctNull((String)rs1.getString("city_name"));
					}
				}
				strGuarState = (String) Helper.correctNull(rs.getString("minor_guard_state_code"));//Guardian State
				if(!strGuarState.equalsIgnoreCase(""))
				{
					strQuery1=SQLParser.getSqlQuery("selstatename2^"+strGuarState);
					if(rs1!=null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						strGuarState=Helper.correctNull((String)rs1.getString("state_name"));
					}
				}
				strGuarPincode = (String) Helper.correctNull(rs.getString("minor_guard_pin_code"));//Guardian Zip
				strGuarCountry = (String) Helper.correctNull(rs.getString("minor_guard_cntry_code"));//Guardian Country
				if(!strGuarCountry.equalsIgnoreCase(""))
				{
					strQuery1=SQLParser.getSqlQuery("sel_countryList^where con_countrycode='"+strGuarCountry+"'");
					if(rs1!=null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						strGuarCountry=Helper.correctNull((String)rs1.getString("con_country"));
					}
				}
				strNRICountry = (String) Helper.correctNull(rs.getString("nre_nationality"));//Country code if the customer is NRI
				if(!strNRICountry.equalsIgnoreCase(""))
				{
					strQuery1=SQLParser.getSqlQuery("sel_countryList^where con_countrycode='"+strNRICountry+"'");
					if(rs1!=null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						strNRICountry=Helper.correctNull((String)rs1.getString("con_country"));
					}
				}
				/* KBL doesn't provide the view for the following
				 * 
				 * strLocation = (String) Helper.correctNull(rs.getString("br_code"));  
				strPassportNo = (String) Helper.correctNull(rs.getString("psprt_num"));
				strPassportIssDate =(String) Helper.correctNull(rs.getString("psprt_issu_date"));
				strPassportExpDate =(String) Helper.correctNull(rs.getString("psprt_exp_date"));
				strPassportIssuedBy =(String) Helper.correctNull(rs.getString("psprt_issuedby"));
				
				strIntroducerId = (String) Helper.correctNull(rs.getString("cust_introducer_id"));//modified at datacenter
				*/
				
				/*
				 * The following details related to CUST_CONTACTINFO Table
				 */
				
				strPresentAdr1 = (String) Helper.correctNull(rs.getString("cust_comu_addr1"));//done
				strPresentAdr2=(String) Helper.correctNull(rs.getString("cust_comu_addr2"));//done
				strPresentCity = (String) Helper.correctNull(rs.getString("cust_comu_city_code"));//done
				if(!strPresentCity.equalsIgnoreCase(""))
				{
					strQuery1=SQLParser.getSqlQuery("selcitycode^"+strPresentCity);
					if(rs1!=null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						strPresentCity=Helper.correctNull(rs1.getString("city_code"));
					}
					else
					{
						strPresentCity="";
					}
				}
				strPresentZip = (String) Helper.correctNull(rs.getString("cust_comu_pin_code"));//done
				strPresentState = (String) Helper.correctNull(rs.getString("cust_comu_state_code"));//done
				if(!strPresentState.equalsIgnoreCase(""))
				{
					strQuery1=SQLParser.getSqlQuery("selstatename2^"+strPresentState);
					if(rs1!=null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						strPresentState=Helper.correctNull(rs1.getString("state_code"));
					}
					else
					{
						strPresentState="";
					}
				}
				strPresentCountry =(String) Helper.correctNull(rs.getString("cust_comu_cntry_code"));//Communication Country Code
				/*if(!strPresentCountry.equalsIgnoreCase(""))
				{
					strQuery1=SQLParser.getSqlQuery("sel_countryList^where con_countrycode='"+strPresentCountry+"'");
					if(rs1!=null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						strPresentCountry=Helper.correctNull((String)rs1.getString("con_country"));
					}
				}*/
				strPresentFax =(String) Helper.correctNull(rs.getString("cust_comu_telex_num"));//Communication Fax No.
				strPresentPho = (String) Helper.correctNull(rs.getString("cust_comu_phone_num_1"));//done
				strPresentPho2 = (String) Helper.correctNull(rs.getString("cust_comu_phone_num_2"));//done
				strEmail = (String) Helper.correctNull(rs.getString("email_id"));//done

				strPerAdrs1 = (String) Helper.correctNull(rs.getString("cust_perm_addr1"));//done
				strPerAdrs2=(String) Helper.correctNull(rs.getString("cust_perm_addr2"));//done
				strPerCity = (String) Helper.correctNull(rs.getString("cust_perm_city_code"));//done
				if(!strPerCity.equalsIgnoreCase(""))
				{
					strQuery1=SQLParser.getSqlQuery("selcitycode^"+strPerCity);
					if(rs1!=null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						strPerCity=Helper.correctNull((String)rs1.getString("city_code"));
					}
					else
					{
						strPerCity="";
					}
				}
				strPerPin = (String) Helper.correctNull(rs.getString("cust_perm_pin_code"));//done
				strPerState = (String) Helper.correctNull(rs.getString("cust_perm_state_code")); //done
				if(!strPerState.equalsIgnoreCase(""))
				{
					strQuery1=SQLParser.getSqlQuery("selstatename2^"+strPerState);
					if(rs1!=null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						strPerState=Helper.correctNull((String)rs1.getString("state_code"));
					}
					else
					{
						strPerState="";
					}
				}
				strPerCountry =(String) Helper.correctNull(rs.getString("cust_perm_cntry_code")); //Permanent country code
				/*if(!strPerCountry.equalsIgnoreCase(""))
				{
					strQuery1=SQLParser.getSqlQuery("sel_countryList^where con_countrycode='"+strPerCountry+"'");
					if(rs1!=null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						strPerCountry=Helper.correctNull((String)rs1.getString("con_country"));
					}
				}*/
				strPerFax =(String) Helper.correctNull(rs.getString("cust_perm_telex_num"));//Communication Fax No.
				strPerPho = (String) Helper.correctNull(rs.getString("cust_perm_phone_num"));//Permanent phone no.
				strPerEmail=(String) Helper.correctNull(rs.getString("cust_perm_email_id"));//Permanent Email id
				
				
				if(strPresentAdr1.equalsIgnoreCase(strPerAdrs1))
				{
					strSel_add1="1";
				}
				else
				{
					strSel_add1="2";
				}
				if(strPresentAdr2.equalsIgnoreCase(strPerAdrs2))
				{
					strSel_add2="1";
				}
				else
				{
					strSel_add2="2";
				}
				if(strPresentCity.equalsIgnoreCase(strPerCity))
				{
					strSel_City="1";
				}
				else
				{
					strSel_City="2";
				}
				if(strPresentZip.equalsIgnoreCase(strPerPin))
				{
					strSel_pin="1";
				}
				else
				{
					strSel_pin="2";
				}
				if(strPresentState.equalsIgnoreCase(strPerState))
				{
					strSel_state="1";
				}
				else
				{
					strSel_state="2";
				}
				if(strPresentCountry.equalsIgnoreCase(strPerCountry))
				{
					strSel_country="1";
				}
				else
				{
					strSel_country="2";
				}
				
				/*
				 * The following details related to PEREMPLOYER table
				 */
				
				strEmployerAdr1 = (String) Helper.correctNull(rs.getString("cust_emp_addr1"));//Employer company address
				strEmployerAdr2=(String) Helper.correctNull(rs.getString("cust_emp_addr2"));//Employer company address
				strEmployerCity = (String) Helper.correctNull(rs.getString("cust_emp_city_code"));//Employer company city
				/*if(!strEmployerCity.equalsIgnoreCase(""))
				{
					strQuery1=SQLParser.getSqlQuery("selcitycode^"+strEmployerCity);
					if(rs1!=null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						strEmployerCity=Helper.correctNull((String)rs1.getString("city_name"));
					}
				}*/
				strEmployerZip = (String) Helper.correctNull(rs.getString("cust_emp_pin_code"));//Employer company zip
				strEmployerState = (String) Helper.correctNull(rs.getString("cust_emp_state_code"));//Employer company state
				/*if(!strEmployerState.equalsIgnoreCase(""))
				{
					strQuery1=SQLParser.getSqlQuery("selstatename2^"+strEmployerState);
					if(rs1!=null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						strEmployerState=Helper.correctNull((String)rs1.getString("state_name"));
					}
				}*/
				strEmployerPho1 = (String) Helper.correctNull(rs.getString("cust_emp_phone_num_1"));//Employer company phone1
				strEmployerFax = (String) Helper.correctNull(rs.getString("cust_emp_phone_num_2"));//Employer company Fax No
				strEmployerEmail = (String) Helper.correctNull(rs.getString("cust_emp_email_id"));//Employer company Email id
				strEmployerNo = (String) Helper.correctNull(rs.getString("cust_employee_no"));//Employee Number
				
				/*
				 * The following details related to APPLICANT_KYCNORMS table
				 */
				strCustOccCode = (String) Helper.correctNull(rs.getString("cust_occp_code"));//done
				strCusIDProof = (String) Helper.correctNull(rs.getString("id_doc")); // ID proof of the customer
				strCusIDRef=(String) Helper.correctNull(rs.getString("id_number"));//ID Refernce number of the customer proof
				strCusRating=(String) Helper.correctNull(rs.getString("riskrating"));//Rating of the customer
				


		
				
				/*KBL doesn't provide the view for the following
				 * 
				 * strIDProof = (String) Helper.correctNull(rs.getString("ID_PROOF"));
				strAdrsProof1 = (String) Helper.correctNull(rs.getString("ADDR_PROOF1"));
				strAdrsProof2 = (String) Helper.correctNull(rs.getString("ADDR_PROOF2"));
				strStaffYN = (String) Helper.correctNull(rs.getString("STAFF_YN"));
				if(strStaffYN.trim().equals(""))
					strStaffYN="0";
				
				strCustIntrostatus  = (String) Helper.correctNull(rs.getString("CUST_INTROD_STAT_CODE"));
				strCustIntroID = (String) Helper.correctNull(rs.getString("CUST_INTROD_CUST_ID"));
				strIntroEmpID = (String) Helper.correctNull(rs.getString("INTROD_EMP_ID"));
				strIntroTitleCode = (String) Helper.correctNull(rs.getString("INTROD_TITLE_CODE"));
				strCustIntroName = (String) Helper.correctNull(rs.getString("CUST_INTROD_NAME"));
				strIntroAdrs = (String) Helper.correctNull(rs.getString("INTRO_ADDRESS"));
				 
				strAccount_Opening_Year=(String) Helper.correctNull(rs.getString("acct_opn_year")); 
				*/
				
				/*
				 * The group id value related to COMPANY_INFO table
				 */
				
				strComGroupId= Helper.correctNull(rs.getString("cust_grp"));//Rating of the customer
				strAadharNo= Helper.correctNull(rs.getString("nat_id_card_num"));//Rating of the customer
			}
			if(count !=0)
			{
				// For Updating the values to LAPS DATABASE
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				if (action.equalsIgnoreCase("Update")) 
				{
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("checkapplicantstatusper^"+strLapscustid);				 
					if(rs.next())
					{
						//No update if the borrower has processed approved/processed closed application
						return arryRow;
					}
					else
					{
						if (action.equalsIgnoreCase("Update")) 
						{
							if(rs!=null)
							{
								rs.close();
							}
							rs=DBUtils.executeLAPSQuery("sel_genderdet^"+strLapscustid);				 
							if(rs.next())
							{
								if(strCustConstitution.trim().equalsIgnoreCase("01")||
										strCustConstitution.trim().equalsIgnoreCase("02"))
								{
									if(!Helper.correctNull(rs.getString("perapp_sex")).equalsIgnoreCase(strsex)||!Helper.correctNull(rs.getString("indinfo_caste")).equalsIgnoreCase(strCaste))
									{
										hshQuery = new HashMap();
										arrValues=new ArrayList();
										arrValues.add(strLapscustid);
										arrValues.add(strLapscustid);
										hshQuery.put("strQueryId","upd_misreselectflag"); 
										hshQuery.put("arrValues",arrValues); 
										hshQueryValues.put("1",hshQuery);
										hshQueryValues.put("size","1");
										EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
										
										
										hshQueryValues = new HashMap();
										hshQuery = new HashMap();
										arrValues = new ArrayList();
									}
								}
							}
						}
						
						
						hshQuery.put("strQueryId", "perapplicant_updatecbsdata");
						hshIndQuery.put("strQueryId", "perindividual_updatecbsdata");
						hshConQuery.put("strQueryId", "percontact_updatecbsdata");
						hshKycQuery.put("strQueryId", "perkyc_updatecbsdata");
						//hshEmpQuery.put("strQueryId", "peremployer_updatecbsdata");
						if(strResidentialStatus.equalsIgnoreCase("Y"))
						{
							if(NRICount==0)
							{
								hshNRIQuery.put("strQueryId", "perapplicant_insertnridet1");
							}
							else
							{
								hshNRIQuery.put("strQueryId", "perapplicant_updatenridet");
							}
						}

					}
				}
				else if (action.equalsIgnoreCase("Insert")) 
				{				
					hshQuery.put("strQueryId", "perapplicant_insertcbsdata");
					hshIndQuery.put("strQueryId", "perindividual_insertcbsdata");
					hshConQuery.put("strQueryId", "percontact_insertcbsdata");
					hshKycQuery.put("strQueryId", "perkyc_insertcbsdata");
					//hshEmpQuery.put("strQueryId", "peremployer_insertcbsdata");
					if(strResidentialStatus.equalsIgnoreCase("Y"))
					hshNRIQuery.put("strQueryId", "perapplicant_insertnridet");
					
					arrValues.add(Helper.correctNull((String) strLapscustid));//0
					arrValues.add(strLapscustid);//1
					arrValues.add(strcustid);//2
					arrValues.add("P");//3
					arrValues.add("Y");//4
					arrIndValues.add(strLapscustid);//0
					arrConValues.add(strLapscustid);//0
					arrConValues.add("P");//1
					arrKycValues.add(strLapscustid);//0
					arrKycValues.add("P");//1
					arrEmpValues.add(strLapscustid);
					arrEmpValues.add("P");
					if(strResidentialStatus.equalsIgnoreCase("Y"))
					arrNRIValues.add(strLapscustid);
				}
				
				/*
				 * Values for the table perapplicant
				 */
				
				arrValues.add(Helper.correctNull((String)prefix));//5
				arrValues.add(Helper.correctNull((String)fname));//6
				arrValues.add(Helper.correctNull((String)lname));//7
				arrValues.add(Helper.correctNull((String)strdob));//8
				arrValues.add(Helper.correctNull((String)strsex));//9
				arrValues.add(Helper.correctNull((String)strMarital));//10
				arrValues.add(Helper.correctNull((String)strPanno));//11
				arrValues.add(Helper.correctNull((String)strIntroducerName));//12
				arrValues.add(Helper.correctNull((String)strTradeFinance));//13
				arrValues.add(Helper.correctNull((String)strTradeAllowed));//14
				arrValues.add(Helper.correctNull((String)strCustConstitution));//15
				arrValues.add(Helper.correctNull((String)strTDSTableCode));//16
				arrValues.add(Helper.correctNull((String)strFatherName));//17
				arrValues.add(Helper.correctNull((String)strCustStatusCode));//18
				arrValues.add(Helper.correctNull((String)strIntroducerStatus));//19
				arrValues.add(Helper.correctNull((String)strSolid));//20
				arrValues.add(Helper.correctNull((String)strCustConstitutionNew));//21
				arrValues.add(Helper.correctNull((String)strLAPSIntroducerType));//22
				arrValues.add(Helper.correctNull((String)strAadharNo));//23

				
				
				/*
				 * Values for the table individual_info
				 */
				
				arrIndValues.add(Helper.correctNull((String)strCaste));//0
				arrIndValues.add(Helper.correctNull((String)strReligion));//1
				arrIndValues.add(Helper.correctNull((String)strResidentialStatus));//2
				arrIndValues.add(Helper.correctNull((String)strNRICountry));//3
				arrIndValues.add(Helper.correctNull((String)strIsStaff));//4
				arrIndValues.add(Helper.correctNull((String)strCustEmpID));//5
				arrIndValues.add(Helper.correctNull((String)strIsMinor));//6
				arrIndValues.add(Helper.correctNull((String)strEducationQua));//7
				arrIndValues.add(Helper.correctNull((String)strSpouseName));//8
				arrIndValues.add(Helper.correctNull((String)strSpouseOccupation));//9
				arrIndValues.add(Helper.correctNull((String)strSpouseQua));//10
				arrIndValues.add(Helper.correctNull((String)(strSpouseAdd1+"/n"+strSpouseAdd2)));//11
				arrIndValues.add(Helper.correctNull((String)strGuarName));//12
				arrIndValues.add(Helper.correctNull((String)strGuarCode));//13
				arrIndValues.add(Helper.correctNull((String)(strGuarAddr1+"/n"+strGuarAddr2)));//14
				
				/*
				 * Values for the table cust_contactinfo
				 */
				
				arrConValues.add(Helper.correctNull((String)strPresentAdr1));//2
				arrConValues.add(Helper.correctNull((String)strPresentAdr2));//3
				arrConValues.add(Helper.correctNull((String)strPresentCity));//4
				arrConValues.add(Helper.correctNull((String)strPresentState));//5
				arrConValues.add(Helper.correctNull((String)strPresentZip));//6
				arrConValues.add(Helper.correctNull((String)strPresentCountry));//7
				arrConValues.add(Helper.correctNull((String)strPresentPho));//8
				arrConValues.add(Helper.correctNull((String)strPresentPho2));//9
				arrConValues.add(Helper.correctNull((String)strPresentFax));//10
				arrConValues.add(Helper.correctNull((String)strEmail));//11
				arrConValues.add(Helper.correctNull((String)strPerAdrs1));//12
				arrConValues.add(Helper.correctNull((String)strPerAdrs2));//13
				arrConValues.add(Helper.correctNull((String)strPerCity));//14
				arrConValues.add(Helper.correctNull((String)strPerState));//15
				arrConValues.add(Helper.correctNull((String)strPerPin));//16
				arrConValues.add(Helper.correctNull((String)strPerCountry));//17
				arrConValues.add(Helper.correctNull((String)strPerPho));//18
				arrConValues.add(Helper.correctNull((String)strPerFax));//19
				arrConValues.add(Helper.correctNull((String)strPerEmail));//20
				if(strSel_add1.equalsIgnoreCase("1") && strSel_add2.equalsIgnoreCase("1") && strSel_City.equalsIgnoreCase("1") &&
						strSel_pin.equalsIgnoreCase("1") && strSel_state.equalsIgnoreCase("1") && strSel_country.equalsIgnoreCase("1"))
				{
					arrConValues.add("1");//21
				}
				else
				{
					arrConValues.add("2");//21
				}
				
				/*
				 * Values for the table applicant_kycnorms
				 */
				
				arrKycValues.add(Helper.correctNull((String)strCustOccCode));//2
				arrKycValues.add(Helper.correctNull((String)strCusIDProof));//3
				arrKycValues.add(Helper.correctNull((String)strCusIDRef));//4
				arrKycValues.add(Helper.correctNull((String)strCusRating));//5
				/*
				 * Values for the table peremployer
				 */
				arrEmpValues.add(Helper.correctNull((String)strEmployerAdr1));
				arrEmpValues.add(Helper.correctNull((String)strEmployerAdr2));
				arrEmpValues.add(Helper.correctNull((String)strEmployerCity));
				arrEmpValues.add(Helper.correctNull((String)strEmployerState));
				arrEmpValues.add(Helper.correctNull((String)strEmployerZip));
				arrEmpValues.add(Helper.correctNull((String)strEmployerPho1));
				arrEmpValues.add(Helper.correctNull((String)strEmployerFax));
				arrEmpValues.add(Helper.correctNull((String)strEmployerEmail));
				arrEmpValues.add(Helper.correctNull((String)strEmployerNo));
				
				/*
				 * Values for the table perapplicant_nri
				 */
				if(strResidentialStatus.equalsIgnoreCase("Y"))
				{
					arrNRIValues.add(Helper.correctNull((String)strPassportNumber));
					arrNRIValues.add(Helper.correctNull((String)strPassportIssDate));
					arrNRIValues.add(Helper.correctNull((String)strPassportExpDate));
				}
			
				if (action.equalsIgnoreCase("Update")) 
				{
					
					if(rs!=null)
						rs.close();
					rs=DBUtils.executeLAPSQuery("chk_districtavailability^"+strLapscustid+"^"+strPresentState+"^"+strPerState);
					if(rs.next())
					{
						arrConValues.add(Helper.correctNull(rs.getString("con_comdist")));
						arrConValues.add(Helper.correctNull(rs.getString("con_permdist")));
					}
					else
					{
						arrConValues.add("");
						arrConValues.add("");
					}
					
					arrValues.add(Helper.correctNull((String) strLapscustid));
					arrIndValues.add(Helper.correctNull((String) strLapscustid));
					arrConValues.add(Helper.correctNull((String) strLapscustid));
					arrKycValues.add(Helper.correctNull((String) strLapscustid));
					arrEmpValues.add(Helper.correctNull((String) strLapscustid));
					if(strResidentialStatus.equalsIgnoreCase("Y"))
					{
						arrNRIValues.add(Helper.correctNull((String) strLapscustid));
					}
				}
				
				hshQueryValues.put("size","1");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);			
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				hshQueryValues=new HashMap();
				hshQueryValues.put("size", "1");
				hshIndQuery.put("arrValues", arrIndValues);
				hshQueryValues.put("1", hshIndQuery);			
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
				
				hshQueryValues=new HashMap();
				hshQueryValues.put("size", "1");
				hshConQuery.put("arrValues", arrConValues);
				hshQueryValues.put("1", hshConQuery);			
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
				
				hshQueryValues=new HashMap();
				hshQueryValues.put("size", "1");
				hshKycQuery.put("arrValues", arrKycValues);
				hshQueryValues.put("1", hshKycQuery);			
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
				
				/*hshQueryValues=new HashMap();
				hshQueryValues.put("size", "1");
				hshEmpQuery.put("arrValues", arrEmpValues);
				hshQueryValues.put("1", hshEmpQuery);			
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); */
				
				if(strResidentialStatus.equalsIgnoreCase("Y"))
				{
					hshQueryValues=new HashMap();
					hshQueryValues.put("size", "1");
					hshNRIQuery.put("arrValues", arrNRIValues);
					hshQueryValues.put("1", hshNRIQuery);			
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
				}
				
				//To insert a row in perincexpenses
				if (action.equalsIgnoreCase("Insert")) 
				{
					hshQueryValues.put("size","2");
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","mastdemographicsincins");
					arrValues.add(strLapscustid);
					arrValues.add("P");
					arrValues.add("A");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					
					//To insert a row in company_info
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","percompanyinfo_insertdata");
					arrValues.add(strLapscustid);
					arrValues.add(strComGroupId);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("2",hshQuery);
					
					int intsize=2;
					//CIBIL Entry
					if(rs!=null)
						rs.close();
					rs=DBUtils.executeLAPSQuery("sel_burcibildetails^"+strdob+"^"+strPanno+"^"+strAadharNo);
					if(rs.next())
					{
						if(!Helper.correctNull(rs.getString("BUR_CIBIL_SCORE")).equalsIgnoreCase("")&& !Helper.correctNull(rs.getString("BUR_CRIF_SCORE")).equalsIgnoreCase(""))
						{
							++intsize;
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","ins_cibilScore");
							arrValues.add(Helper.correctNull(rs.getString("BUR_CRIF_SCORE")));
							arrValues.add(Helper.correctNull(rs.getString("bur_crifdate")));
							arrValues.add(Helper.correctNull(rs.getString("BUR_CIBIL_SCORE")));
							arrValues.add(Helper.correctNull(rs.getString("bur_cibildate")));
							arrValues.add(strLapscustid);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(String.valueOf(intsize),hshQuery);
							hshQueryValues.put("size",String.valueOf(intsize));
						}
						else if(!Helper.correctNull(rs.getString("BUR_CIBIL_SCORE")).equalsIgnoreCase(""))
						{
							++intsize;
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","upd_cibilScore_CIBIL1");
							arrValues.add(Helper.correctNull(rs.getString("BUR_CIBIL_SCORE")));
							arrValues.add(Helper.correctNull(rs.getString("bur_cibildate")));
							arrValues.add(strLapscustid);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(String.valueOf(intsize),hshQuery);
							hshQueryValues.put("size",String.valueOf(intsize));
						}
						
						else if(!Helper.correctNull(rs.getString("BUR_CRIF_SCORE")).equalsIgnoreCase(""))
						{
							++intsize;
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","upd_cibilScore_CRIF1");
							arrValues.add(Helper.correctNull(rs.getString("BUR_CRIF_SCORE")));
							arrValues.add(Helper.correctNull(rs.getString("bur_crifdate")));
							arrValues.add(strLapscustid);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(String.valueOf(intsize),hshQuery);
							hshQueryValues.put("size",String.valueOf(intsize));
						}
					}
					
					if(rs!=null)
						rs.close();
					rs=DBUtils.executeLAPSQuery("sel_bur_details^"+strdob+"^"+strPanno+"^"+strAadharNo);
					if(rs.next())
					{
					
						if (rs2 != null) 
						{
							rs2.close();
						}
						rs2=DBUtils.executeLAPSQuery("sel_defid^"+strLapscustid);
						if(rs2.next())
						{
							cus_def_id=Helper.correctNull((String)rs2.getString("DEF_ID"));
						}
					if(!cus_def_id.equalsIgnoreCase(""))
					{
						++intsize;
								hshQuery=new HashMap();
								arrValues=new ArrayList();
								hshQuery.put("strQueryId","update_cus_score");
								arrValues.add(Helper.correctNull(rs.getString("BUR_HUNTER_SCORE")));
								arrValues.add(cus_def_id);
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put(String.valueOf(intsize),hshQuery);
								hshQueryValues.put("size",String.valueOf(intsize));
					}
					else if(cus_def_id.equalsIgnoreCase("")){
						
						++intsize;
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","ins_hun_score");
						arrValues.add(strLapscustid);
						arrValues.add(Helper.correctNull(rs.getString("BUR_HUNTER_SCORE")));
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(intsize),hshQuery);
						hshQueryValues.put("size",String.valueOf(intsize));
					}
					}
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
				}
				else if (action.equalsIgnoreCase("update")) 
				{
					hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size", "1");
					hshQuery.put("strQueryId","percompanyinfo_updatedata");
					arrValues.add(strComGroupId);
					arrValues.add(strLapscustid);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
				}
				
				if (action.equalsIgnoreCase("update")) 
				{
					if(rs!=null)
						rs.close();
					if(rs1!=null)
						rs1.close();
					rs=DBUtils.executeLAPSQuery("sel_CBScustomerdetails^"+strcustid);
					if(rs.next())
					{
						String strIntroName=Helper.correctNull(rs.getString("PERAPP_INTRONAME"));
						String strIntroCBSID=Helper.correctNull(rs.getString("PERAPP_INTROCBSID"));
						
						if(Helper.correctNull(rs.getString("PERAPP_INTROTYPE")).equalsIgnoreCase("1"))
						{
							rs1=DBUtils.executeLAPSQuery("selectusername^"+Helper.correctNull(rs.getString("PERAPP_INTROSTAFFID")));
							if(rs1.next())
							{
								strIntroName=Helper.correctNull(rs1.getString("name"));
							}
						}
						else if(Helper.correctNull(rs.getString("PERAPP_INTROTYPE")).equalsIgnoreCase("2"))
						{
							if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
							{
								strQuery=SQLParser.getCBSSqlQuery("cbs_custdetails_select_newconnection^"+strIntroCBSID);
								rs1=DBUtils.executeQueryCBSConnection(strQuery);
							}
							else
							{
								strQuery= SQLParser.getSqlQuery("cbs_custdetails_select^"+strIntroCBSID);
								rs1=DBUtils.executeQuery(strQuery); 
							}
							if (rs1.next()) 
							{
								strIntroName=Helper.correctNull(rs1.getString("cust_name"));
							}
						}
						
						hshQueryValues=new HashMap();
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQueryValues.put("size", "1");
						hshQuery.put("strQueryId","upd_CBScustomerdetails");
						arrValues.add(strIntroName);
						arrValues.add(strIntroCBSID);
						arrValues.add(strLapscustid);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
					}
				}
			}
			 
		// End of Inserting Applicant Details in LAPS DataBase
		
		/*strQuery = SQLParser.getSqlQuery("mastsearch");
		strQuery = strQuery + " "
				+ SQLParser.getSqlQuery("mastOrderID^" + strLapscustid);
		if(rs!=null)
		{
			
			rs.close();
		}
		rs = DBUtils.executeQuery(strQuery);
		while (rs.next()) {
			arryCol = new ArrayList();
			arryCol.add(Helper.correctNull(rs.getString("perapp_id"))); //0
			arryCol.add(Helper.correctNull(rs.getString("perapp_fname")));
			arryCol.add(Helper.correctNull(rs.getString("perapp_lname")));
			arryCol.add(Helper.correctNull(rs.getString("perapp_mname")));
			arryCol.add(Helper.correctNull(rs.getString("org_name")));
			arryRow.add(arryCol);
		}*/
		
		} 
	}catch (Exception ce) {
	throw new EJBException("Error in updateLapsDatabase" + ce.toString());
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
		catch (Exception e1) {
			throw new EJBException(e1.getMessage());
		}
	}
	return arryRow;
}
public HashMap checkMandatoryFieldsFromCBS(HashMap hshCustomerDetails)
{
	ResultSet rs=null;
	ResultSet rs1=null;
	ResultSet rs2=null;
	ResultSet rs3=null;
	HashMap hshCBSMandatoryFields=new HashMap();
	String strQuery="";
	String strQuery1="";
	String strCustomerCBSID="";
	String strCustomerName="";
	String strConstitution="";
	String strCustConstitution="";
	String strforcheckid="";
	ArrayList arrNotFilledMandatoryCBSFields=null;
	boolean boolMandatoryCBSFieldsFilled=true;
	String splitat="";
	ArrayList arrRow=new ArrayList();
	ArrayList arrCol= null;
	String[] valArray=null;
	String custconst="";
	String strQueryfornew="",hidDemoId="";
	String benownid="";
	int count=0;
	String PanC="";
	String CINc="";
	
	try
	{
		 strCustomerCBSID=Helper.correctNull((String)hshCustomerDetails.get("hidDemoId"));//("hidDemoId"));
		   // hidDemoId=Helper.correctNull((String)hshCustomerDetails.get("hidDemoId"));
		if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
		{
			strQuery=SQLParser.getCBSSqlQuery("cbs_custdetails_select_newconnection^"+strCustomerCBSID);
			rs=DBUtils.executeQueryCBSConnection(strQuery);
		}
		else
		{
			strQuery= SQLParser.getSqlQuery("cbs_custdetails_select^"+strCustomerCBSID);
			rs=DBUtils.executeQuery(strQuery); 
		}
		
		if (rs.next())  
		{
			arrNotFilledMandatoryCBSFields=new ArrayList();
			
			if(Helper.correctNull(rs.getString("cust_title_code")).equalsIgnoreCase(""))
			{
				arrNotFilledMandatoryCBSFields.add("Title");
			}		
			if(Helper.correctNull(rs.getString("cust_name")).equalsIgnoreCase(""))
			{
				arrNotFilledMandatoryCBSFields.add("First Name");
			}
			if(Helper.correctNull(rs.getString("cust_short_name")).equalsIgnoreCase(""))
			{
				arrNotFilledMandatoryCBSFields.add("Last Name");
			}
			if(Helper.correctNull(rs.getString("cust_const")).equalsIgnoreCase(""))
			{
				arrNotFilledMandatoryCBSFields.add("Constitution");
			}
			custconst=Helper.correctNull(rs.getString("cust_const"));
			
			
			strforcheckid=SQLParser.getSqlQuery("checkbenownid^"+custconst);
			rs2=DBUtils.executeQuery(strforcheckid);
			while(rs2.next())
			{
				
				benownid=correctNull(rs2.getString("CBS_BEN"));
			}
			
			if(rs2!=null)
			{
				rs2.close();
		}
			if(benownid.equalsIgnoreCase("Y"))
			{
				
				if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
				{
					strQueryfornew=SQLParser.getCBSSqlQuery("beneficialownerid_new_con^"+strCustomerCBSID);
					rs2=DBUtils.executeQueryCBSConnection(strQueryfornew);
				}
				else
				{
					strQueryfornew= SQLParser.getSqlQuery("beneficialownerid^"+strCustomerCBSID);
					rs2=DBUtils.executeQuery(strQueryfornew); 
				}
				
				

				while(rs2.next())
				{
					
					splitat=correctNull(rs2.getString("BENF_DET"));

					valArray=splitat.split("\\@");
					for(int k=0;k<valArray.length;k++)
					{
					   String getstringat=valArray[k];
					   String[] getattilt=getstringat.split("\\~");
					   for(int j=0;j<getattilt.length;j++)
					   {
						   if(getattilt[j].equalsIgnoreCase("")){
							   if(count==0){
							   arrNotFilledMandatoryCBSFields.add("Kindly update Beneficial owner details in Finacle-CRM-Relationship tab-Relationship Type-Beneficiary");
							   ++count;
							   }
							   }
						   
					   }
					   
					}
					
					if(splitat.equalsIgnoreCase(""))
					{
						arrNotFilledMandatoryCBSFields.add("Kindly update Beneficial owner details in Finacle-CRM-Relationship tab-Relationship Type-Beneficiary");
						  
					}
					
				}
			}
			
			if(rs2!=null)
			{
			rs2.close();
			}
			if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
			{
				strQueryfornew=SQLParser.getCBSSqlQuery("beneficialownerid_new_con^"+strCustomerCBSID);
				rs2=DBUtils.executeQueryCBSConnection(strQueryfornew);
			}
			else
			{
				strQueryfornew= SQLParser.getSqlQuery("beneficialownerid^"+strCustomerCBSID);
				rs2=DBUtils.executeQuery(strQueryfornew); 
			}
			
			while(rs2.next())
			{
			
				PanC=correctNull(rs2.getString("PAN_GIR_NUM"));
				CINc=correctNull(rs2.getString("CIN_NUM"));
			}
			
			if(!PanC.equalsIgnoreCase(""))
			{
				char ch = PanC.charAt(3);
				String checkc=Character.toString(ch);
				if(checkc.equalsIgnoreCase("C"))
				{
					int checkcindig=CINc.length();
					if(checkcindig!=21)
					{
						arrNotFilledMandatoryCBSFields.add("Kindly update CIN number details in Finacle-CRM-General tab-Identification Document-CIN");
					}
				}
				
			}
			
			
			strConstitution=Helper.correctNull(rs.getString("cust_const"));
			if(rs1!=null)
			{
				rs1.close();
			}
			strQuery1=SQLParser.getSqlQuery("sel_CBSStaticDataPassingCode^2^"+strConstitution);
			rs1=DBUtils.executeQuery(strQuery1);
			if(rs1.next())
			{
				strCustConstitution=Helper.correctNull((String)rs1.getString("cbs_static_data_passing_code"));
			}
			if(strCustConstitution.equalsIgnoreCase("01")||
					strCustConstitution.equalsIgnoreCase("02"))
			{
				
				if(Helper.correctNull(rs.getString("date_of_birth")).trim().equalsIgnoreCase(""))
				{
					arrNotFilledMandatoryCBSFields.add("Date of Birth");
				}
				if(Helper.correctNull(rs.getString("cust_sex")).equalsIgnoreCase(""))
				{
					arrNotFilledMandatoryCBSFields.add("Sex");
				} 
				String strMarital=Helper.correctNull(rs.getString("cust_marital_status"));
				if(strMarital.equalsIgnoreCase("") || strMarital.equalsIgnoreCase("0"))
				{
					arrNotFilledMandatoryCBSFields.add("Marital Status");
				}
				if(strMarital.equalsIgnoreCase("MARID"))
				{
					if(Helper.correctNull(rs.getString("spouse_name")).equalsIgnoreCase(""))
					{
						arrNotFilledMandatoryCBSFields.add("Spouse Name");
					} 
				}
				String strRes=Helper.correctNull(rs.getString("cust_nre_flg"));
				
				if(strRes.equalsIgnoreCase("") || strRes.equalsIgnoreCase("0"))
				{
					arrNotFilledMandatoryCBSFields.add("Residential Status");
				}
				if(strRes.equalsIgnoreCase("Y"))
				{
					if(Helper.correctNull(rs.getString("nre_nationality")).equalsIgnoreCase(""))
					{
						arrNotFilledMandatoryCBSFields.add("Residing Country");
					}
					if(Helper.correctNull(rs.getString("psprt_num")).equalsIgnoreCase(""))
					{
						arrNotFilledMandatoryCBSFields.add("Passport Number");
					}
				}
				String strStaff=Helper.correctNull(rs.getString("cust_type_code"));
				
				if(strStaff.equalsIgnoreCase("02"))
				{
					if(Helper.correctNull(rs.getString("cust_emp_id")).equalsIgnoreCase(""))
					{
						arrNotFilledMandatoryCBSFields.add("Staff Id");
					}
				}
				if(Helper.correctNull(rs.getString("cust_commu_code")).trim().equalsIgnoreCase("") || Helper.correctNull(rs.getString("cust_commu_code")).trim().equalsIgnoreCase("0") )
				{
					arrNotFilledMandatoryCBSFields.add("Religion");
				}
				if(Helper.correctNull(rs.getString("cust_caste_code")).trim().equalsIgnoreCase("") || Helper.correctNull(rs.getString("cust_caste_code")).trim().equalsIgnoreCase("0") )
				{
					arrNotFilledMandatoryCBSFields.add("Caste");
				}
				if(Helper.correctNull(rs.getString("ed_qualification")).trim().equalsIgnoreCase("") || Helper.correctNull(rs.getString("ed_qualification")).trim().equalsIgnoreCase("0") )
				{
					arrNotFilledMandatoryCBSFields.add("Education Qualification");
				}
				
				String strMinor=Helper.correctNull(rs.getString("cust_minor_flg"));
				
				if(strMinor.equalsIgnoreCase("Y"))
				{
					if(Helper.correctNull(rs.getString("minor_guard_name")).equalsIgnoreCase(""))
					{
						arrNotFilledMandatoryCBSFields.add("Guardian Name");
					}
					if(Helper.correctNull(rs.getString("minor_guard_code")).equalsIgnoreCase(""))
					{
						arrNotFilledMandatoryCBSFields.add("Guardian Relationship");
					}
					if(Helper.correctNull(rs.getString("minor_guard_addr1")).equalsIgnoreCase(""))
					{
						arrNotFilledMandatoryCBSFields.add("Guardian Address");
					}
				}
			}
			else
			{
				if(Helper.correctNull(rs.getString("dateof_est")).trim().equalsIgnoreCase(""))
				{
					arrNotFilledMandatoryCBSFields.add("Date of Establishment");
				}
			}
			if(Helper.correctNull(rs.getString("cust_stat_code")).equalsIgnoreCase(""))
			{
				arrNotFilledMandatoryCBSFields.add("Status");
			}
			if(Helper.correctNull(rs.getString("tds_tbl_code")).equalsIgnoreCase(""))
			{
				arrNotFilledMandatoryCBSFields.add("Tax Slab");
			}
			if(Helper.correctNull(rs.getString("cust_comu_addr1")).equalsIgnoreCase(""))
			{
				arrNotFilledMandatoryCBSFields.add("Communication Address");
			}
			if(Helper.correctNull(rs.getString("cust_comu_city_code")).equalsIgnoreCase(""))
			{
				arrNotFilledMandatoryCBSFields.add("Communication Address City");
			}
			else
			{
				strQuery1=SQLParser.getSqlQuery("selcitycode^"+Helper.correctNull(rs.getString("cust_comu_city_code")));
//				if(rs1!=null)
//				{
//					rs1.close();
//				}
				rs1=DBUtils.executeQuery(strQuery1);
				if(!rs1.next())
				{
					arrNotFilledMandatoryCBSFields.add("Communication City Code is not Available in LAPS, Please contact LAPS Helpdesk");
				}
			}
			if(Helper.correctNull(rs.getString("cust_comu_state_code")).equalsIgnoreCase(""))
			{
				arrNotFilledMandatoryCBSFields.add("Communication Address State");
			}
			else
			{
				strQuery1=SQLParser.getSqlQuery("selstatename2^"+Helper.correctNull(rs.getString("cust_comu_state_code")));
				if(rs1!=null)
				{
					rs1.close();
				}
				rs1=DBUtils.executeQuery(strQuery1);
				if(!rs1.next())
				{
					arrNotFilledMandatoryCBSFields.add("Communication State Code is not Available in LAPS, Please contact LAPS Helpdesk");
				}
			}
			if(Helper.correctNull(rs.getString("cust_comu_pin_code")).equalsIgnoreCase(""))
			{
				arrNotFilledMandatoryCBSFields.add("Communication Address Pincode");
			}
			if(Helper.correctNull(rs.getString("cust_comu_cntry_code")).equalsIgnoreCase(""))
			{
				arrNotFilledMandatoryCBSFields.add("Communication Address Country");
			}
			if(Helper.correctNull(rs.getString("cust_occp_code")).equalsIgnoreCase(""))
			{
				arrNotFilledMandatoryCBSFields.add("Customer Occupation");
			}
			if(Helper.correctNull(rs.getString("id_doc")).equalsIgnoreCase(""))
			{
				arrNotFilledMandatoryCBSFields.add("Customer ID Proof Type");
			}
			if(Helper.correctNull(rs.getString("id_number")).equalsIgnoreCase(""))
			{
				arrNotFilledMandatoryCBSFields.add("Customer ID Reference Number");
			}
			if(Helper.correctNull(rs.getString("riskrating")).equalsIgnoreCase(""))
			{
				arrNotFilledMandatoryCBSFields.add("Customer Risk Categorization");
			}
			if(Helper.correctNull(rs.getString("cust_occp_code")).equalsIgnoreCase("MIGR"))
			{
				arrNotFilledMandatoryCBSFields.add("Please modify occupation code in Finacle - CRM and then visit LAPS customer profile");
			}
			if(!Helper.correctNull(rs.getString("cust_perm_city_code")).equalsIgnoreCase(""))
			{
				strQuery1=SQLParser.getSqlQuery("selcitycode^"+Helper.correctNull(rs.getString("cust_perm_city_code")));
				if(rs1!=null)
				{
					rs1.close();
				}
				rs1=DBUtils.executeQuery(strQuery1);
				if(!rs1.next())
				{
					arrNotFilledMandatoryCBSFields.add("Permanent City Code is not Available in LAPS, Please contact LAPS Helpdesk");
				}
			}
			if(!Helper.correctNull(rs.getString("cust_perm_state_code")).equalsIgnoreCase(""))
			{
				strQuery1=SQLParser.getSqlQuery("selstatename2^"+Helper.correctNull(rs.getString("cust_perm_state_code")));
				if(rs1!=null)
				{
					rs1.close();
				}
				rs1=DBUtils.executeQuery(strQuery1);
				if(!rs1.next())
				{
					arrNotFilledMandatoryCBSFields.add("Permanent State Code is not Available in LAPS, Please contact LAPS Helpdesk");
				}
			}
			if(arrNotFilledMandatoryCBSFields.size()==0)
			{
				boolMandatoryCBSFieldsFilled=true;
			}
			else
			{
			boolMandatoryCBSFieldsFilled=false;
			strCustomerName=Helper.correctNull(rs.getString("cust_name"));
				if(!Helper.correctNull(rs.getString("cust_short_name")).equalsIgnoreCase(""))
				{
					strCustomerName=strCustomerName+" "+rs.getString("cust_short_name");
				}
				
			hshCBSMandatoryFields.put("keyCBSID",strCustomerCBSID);
			hshCBSMandatoryFields.put("keyCBSCustomerName",strCustomerName);
			hshCBSMandatoryFields.put("keyArrCBSNotFilledMandatoryFields",arrNotFilledMandatoryCBSFields);
			}
			hshCBSMandatoryFields.put("keyBoolMandatoryCBSFieldsFilled",Boolean.valueOf(boolMandatoryCBSFieldsFilled));
		}
	}
	catch(Exception e)
	{
		throw new EJBException("Error in Method:checkMandatoryFieldsFromCBS  BeanID:cbsinterface ->" +e.toString());
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
			log.error(e.toString());
		}
	}
	return hshCBSMandatoryFields;
}


//////////////////////////////


public HashMap checkLoanInterestModifyhttpheader(HashMap hshRequestValues)throws NamingException, Exception
{
	HashMap hshRequest= new HashMap();
	
	TrustManager[] trustAllCerts = new TrustManager[] {new X509TrustManager() {
        public java.security.cert.X509Certificate[] getAcceptedIssuers() {
            return null;
        }
        public void checkClientTrusted(X509Certificate[] certs, String authType) {
        }
        public void checkServerTrusted(X509Certificate[] certs, String authType) {
        }
    }
};
	
	
	HashMap hsh= new HashMap();
	String strResponse2="",interestrate="";
	
	HashMap hshQueryValues= new HashMap();
	HashMap hshQuery = new HashMap();
	ArrayList arrValues = new ArrayList();
	double douintval=0.00;
	String sessionModuleType=Helper.correctNull((String)hshRequestValues.get("sessionModuleType"));	
	String appno=Helper.correctNull((String)hshRequestValues.get("appno"));		
	if(appno.equalsIgnoreCase(""))
	{
		appno=Helper.correctNull((String)hshRequestValues.get("appno1"));	
	}
	
	String hidapplicationType="",hidappid="",strOrgCode="",strUserId="",inwardno="",strOrgShortCode="",userclass="";
	String strUserDesignation="",apporgname="",appname="",strAppType="",appholder="",strOrgLevel="",hidFacSno="";
	
	hidapplicationType=Helper.correctNull((String)hshRequestValues.get("hidapplicationType"));
	hidappid=Helper.correctNull((String)hshRequestValues.get("hidapplicantid"));
	if(hidappid.equalsIgnoreCase(""))
	{
		
		hidappid=Helper.correctNull((String)hshRequestValues.get("hidapplicantnewid"));
	}
	strOrgCode=Helper.correctNull((String)hshRequestValues.get("strOrgCode"));
	strUserId=Helper.correctNull((String)hshRequestValues.get("strUserId"));
	inwardno=Helper.correctNull((String)hshRequestValues.get("inwardno"));
	strOrgShortCode=Helper.correctNull((String)hshRequestValues.get("strOrgShortCode"));
	userclass=Helper.correctNull((String)hshRequestValues.get("userclass"));
	strUserDesignation=Helper.correctNull((String)hshRequestValues.get("strUserDesignation"));
	apporgname=Helper.correctNull((String)hshRequestValues.get("apporgname"));
	appname=Helper.correctNull((String)hshRequestValues.get("appname"));
	strAppType=Helper.correctNull((String)hshRequestValues.get("strAppType"));
	appholder=Helper.correctNull((String)hshRequestValues.get("appholder"));
	strOrgLevel=Helper.correctNull((String)hshRequestValues.get("strOrgLevel"));
	hidFacSno=Helper.correctNull((String)hshRequestValues.get("hidFacSno"));
	String ActNum="",startdate="",FreqMonths="",FreqMonthsdata="",mclrtabcode="",plainresponse="",plainresponse2="";
	String strQuery="",strcustid="",parentappno="";
	String strRequest="",ReqUUID="",ServiceReqId="Req_LINTTM101"+appno,strVersionId="10.2",strChannelId="COR",strBankId="01",StrMessageDateTime="2012-10-02T14:14:27.262";
	String StrCustId="114021219",strAppurl="",strResponse="",Req_LINTTM101="Req_LINTTM101";
	ResultSet rs=null;
	String strintdiff="",Loan_Sanct_Eff_ROI_date="",MCLR_EFFECTIVEFROM="",MCLR_BASERATESPREAD="",MCLR_TYPE="",FACILITY_SANCINTEREST="",FACILITY_MCLRTYPE="";
	String	StrSecondReq="";
	double intrate1=0.00,intrate2=0.00,intdiff=0.00;
	hsh.put("updroiinfin", "updroiinfin");
	hsh.put("hidFacSnoroi", "hidFacSno");
	try
	{	
		
	
	strQuery = SQLParser.getSqlQuery("sel_perappidcbsid^" + hidappid);
	rs = DBUtils.executeQuery(strQuery);
	if (rs.next()) {
		strcustid = Helper.correctNull((String) rs
				.getString("perapp_cbsid"));
	}
	
			
	strQuery = SQLParser.getSqlQuery("selparentappnodet^" + appno);
	rs = DBUtils.executeQuery(strQuery);
	if (rs.next()) {
		parentappno = Helper.correctNull((String) rs
				.getString("app_parent_appno"));
	}
	
	
	
	
	
	if(sessionModuleType.equalsIgnoreCase("RET"))
	{
	strQuery = SQLParser.getSqlQuery("retaccno^" + parentappno);
	rs = DBUtils.executeQuery(strQuery);
	if (rs.next()) {
		ActNum = Helper.correctNull((String) rs
				.getString("CBS_ACCOUNTNO"));
	}
	
	
	
	
	strQuery = SQLParser.getSqlQuery("selretduedate^" + appno);
	rs = DBUtils.executeQuery(strQuery);
	if (rs.next()) {
		startdate = Helper.correctNull((String) rs
				.getString("LOAN_DUEDATE"));
		mclrtabcode= Helper.correctNull((String) rs
				.getString("loan_mclrtabcode"));
		Loan_Sanct_Eff_ROI_date=Helper.correctNull((String) rs
				.getString("Loan_Sanct_Eff_ROI_date"));
	}
	
	
			
	
	
	strQuery = SQLParser.getSqlQuery("maxeffectdateinmclr^" +Loan_Sanct_Eff_ROI_date +"^"+mclrtabcode+"^"+mclrtabcode);
	rs = DBUtils.executeQuery(strQuery);
	if (rs.next()) {
		MCLR_EFFECTIVEFROM = Helper.correctNull((String) rs
				.getString("MCLR_EFFECTIVEFROM"));
		
	}
	//2022-08-30 00:00:00.0
	if(!MCLR_EFFECTIVEFROM.equalsIgnoreCase(""))
	{
	MCLR_EFFECTIVEFROM=MCLR_EFFECTIVEFROM.substring(8,10)+"/"+MCLR_EFFECTIVEFROM.substring(5,7)+"/"+MCLR_EFFECTIVEFROM.substring(0,4);
	}
	strQuery = SQLParser.getSqlQuery("postsanroibaserateslab^" +MCLR_EFFECTIVEFROM+"^"+mclrtabcode+"^"+MCLR_EFFECTIVEFROM+"^"+mclrtabcode);
	rs = DBUtils.executeQuery(strQuery);
	if (rs.next()) {
		MCLR_TYPE = Helper.correctNull((String) rs
				.getString("MCLR_TYPE"));
		MCLR_BASERATESPREAD=Helper.correctNull((String) rs
				.getString("MCLR_BASERATESPREAD"));
		
	}
	
	
//	strQuery = SQLParser.getSqlQuery("selretfreq^" + parentappno);
//	rs = DBUtils.executeQuery(strQuery);
//	if (rs.next()) {
//		FreqMonthsdata = Helper.correctNull((String) rs
//				.getString("TL_FEQUENCY"));
//	}
	
	FreqMonthsdata=MCLR_TYPE;
	if(FreqMonthsdata.equalsIgnoreCase("M"))
	{
		FreqMonths="1";
	}
	else if(FreqMonthsdata.equalsIgnoreCase("Y"))
	{
		FreqMonths="12";
	}
	else if(FreqMonthsdata.equalsIgnoreCase("H"))
	{
		FreqMonths="6";
	}
	else if(FreqMonthsdata.equalsIgnoreCase("Q"))
	{
		FreqMonths="3";
	}
	else
	{
		FreqMonths="12";
	}
	
	if(mclrtabcode.equalsIgnoreCase("AGSEC") || mclrtabcode.equalsIgnoreCase("ATBIL" )|| mclrtabcode.equalsIgnoreCase("NTBIL"))					
	{
FreqMonths="3";
	}
	
	String int1="",int2="";
	strQuery = SQLParser.getSqlQuery("selupdateROIInFInancleoldroi^" + appno);
	rs = DBUtils.executeQuery(strQuery);
	if (rs.next()) {
		//intrate1=Double.parseDouble(Helper.correctNull((String) rs
			//	.getString("old_modified_roi")));
		intrate2= Double.parseDouble(Helper.correctNull((String) rs
				.getString("loan_modintrate")));
	}
		intrate1=Double.parseDouble(MCLR_BASERATESPREAD);
		if(intrate1>intrate2)
		{
		intdiff=intrate1-intrate2;
		}
		else
		{
			intdiff=intrate2-intrate1;	
		}
		//intdiff=Math.round(intdiff);
		
		java.text.NumberFormat nf = java.text.NumberFormat
				.getNumberInstance();
				nf.setGroupingUsed(false);
				nf.setMaximumFractionDigits(2);
				nf.setMinimumFractionDigits(2);
				 strintdiff=nf.format((intdiff));
				
	//}
	}
	
	if(sessionModuleType.equalsIgnoreCase("CORP") || sessionModuleType.equalsIgnoreCase("AGR"))
	{

		
		String FACILITY_OLDAPPSNO="";
		strQuery = SQLParser.getSqlQuery("selfaciparentappnodet^" + appno+"^"+hidFacSno);
		rs = DBUtils.executeQuery(strQuery);
		if (rs.next()) {
			parentappno = Helper.correctNull((String) rs
					.getString("app_parent_appno"));
			FACILITY_OLDAPPSNO = Helper.correctNull((String) rs
					.getString("app_parent_appno"));
			
		
		}
		
		
		//strQuery = SQLParser.getSqlQuery("selcorpagractno^" + appno+"^"+parentappno);
		strQuery = SQLParser.getSqlQuery("selcorpagractno^"+parentappno+"^"+ appno+"^"+hidFacSno);
	rs = DBUtils.executeQuery(strQuery);
	if (rs.next()) {
		ActNum = Helper.correctNull((String) rs
				.getString("CBS_ACCOUNTNO"));
	}
	
	
	strQuery = SQLParser.getSqlQuery("sel_postsanfacmclrrate^" + appno+"^"+hidFacSno);
	rs = DBUtils.executeQuery(strQuery);
	if (rs.next()) {
//		FreqMonthsdata = Helper.correctNull((String) rs
//				.getString("FACILITY_PERINSTALL"));
		FACILITY_SANCINTEREST=Helper.correctNull((String) rs
				.getString("FACILITY_SANCINTEREST"));
		startdate = Helper.correctNull((String) rs
				.getString("LOAN_DUEDATE"));
		Loan_Sanct_Eff_ROI_date=Helper.correctNull((String) rs
				.getString("facility_effintroidate"));
//		mclrtabcodeval=Helper.correctNull((String) rs
//				.getString("FACILITY_INTSUBTYPE"));
	}
	
	
	strQuery = SQLParser.getSqlQuery("sel_postsanfacroidet^" + appno+"^"+hidFacSno);
	rs = DBUtils.executeQuery(strQuery);
	if (rs.next()) {
		FACILITY_MCLRTYPE = Helper.correctNull((String) rs
				.getString("FACILITY_MCLRTYPE"));
		if(!FACILITY_MCLRTYPE.equalsIgnoreCase(""))
		{
			MCLR_TYPE=FACILITY_MCLRTYPE.substring(0,1);
		}
		mclrtabcode=Helper.correctNull((String) rs
				.getString("MCLR_TABLECODE"));
	}
	
	
	
	
	FreqMonthsdata=MCLR_TYPE;
	if(FreqMonthsdata.equalsIgnoreCase("M"))
	{
		FreqMonths="1";
	}
	else if(FreqMonthsdata.equalsIgnoreCase("Y"))
	{
		FreqMonths="12";
	}
	else if(FreqMonthsdata.equalsIgnoreCase("H"))
	{
		FreqMonths="6";
	}
	else if(FreqMonthsdata.equalsIgnoreCase("Q"))
	{
		FreqMonths="3";
	}
	else
	{
		FreqMonths="12";
	}
	
	if(mclrtabcode.equalsIgnoreCase("AGSEC") || (mclrtabcode.equalsIgnoreCase("ATBIL" )) || mclrtabcode.equalsIgnoreCase("NTBIL"))					
	{
FreqMonths="3";
	}	
	
	
	strQuery = SQLParser.getSqlQuery("maxeffectdateinmclr^" +Loan_Sanct_Eff_ROI_date +"^"+mclrtabcode+"^"+mclrtabcode);
	rs = DBUtils.executeQuery(strQuery);
	if (rs.next()) {
		MCLR_EFFECTIVEFROM = Helper.correctNull((String) rs
				.getString("MCLR_EFFECTIVEFROM"));
		
	}
	//2022-08-30 00:00:00.0
	if(!MCLR_EFFECTIVEFROM.equalsIgnoreCase(""))
	{
	MCLR_EFFECTIVEFROM=MCLR_EFFECTIVEFROM.substring(8,10)+"/"+MCLR_EFFECTIVEFROM.substring(5,7)+"/"+MCLR_EFFECTIVEFROM.substring(0,4);
	}

	
	
	
	strQuery = SQLParser.getSqlQuery("postsanroibaserateslab^" +MCLR_EFFECTIVEFROM+"^"+mclrtabcode+"^"+MCLR_EFFECTIVEFROM+"^"+mclrtabcode);
	rs = DBUtils.executeQuery(strQuery);
	if (rs.next()) {
		MCLR_TYPE = Helper.correctNull((String) rs
				.getString("MCLR_TYPE"));
		MCLR_BASERATESPREAD=Helper.correctNull((String) rs
				.getString("MCLR_BASERATESPREAD"));
		
	}
	
	intrate2= Double.parseDouble(FACILITY_SANCINTEREST);
	
	intrate1=Double.parseDouble(MCLR_BASERATESPREAD);

	if(intrate1>intrate2)
	{
	intdiff=intrate1-intrate2;
	}
	else
	{
		intdiff=intrate2-intrate1;	
	}
	//intdiff=Math.round(intdiff);
	
	java.text.NumberFormat nf = java.text.NumberFormat
			.getNumberInstance();
			nf.setGroupingUsed(false);
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);
			 strintdiff=nf.format((intdiff));
	
	
	}
	
	
	
	
	String executeFinacleScript="executeFinacleScript";
	String BankId="01";
	
	strRequest="<?xml version=\'1.0\' encoding=\'UTF-8\'?>"+
	"<FIXML xsi:schemaLocation=\'http://www.finacle.com/fixml executeFinacleScript.xsd\' xmlns=\'http://www.finacle.com/fixml\' xmlns:xsi=\'http://www.w3.org/2001/XMLSchema-instance\'>"+
	"<Header>"+
	"<RequestHeader>"+
	"<MessageKey>"+
	"<RequestUUID>"+ServiceReqId+"</RequestUUID>"+
	"<ServiceRequestId>"+executeFinacleScript+"</ServiceRequestId>"+
	"<ServiceRequestVersion>"+strVersionId+"</ServiceRequestVersion>"+
	"<ChannelId>COR</ChannelId>"+
	"<LanguageId></LanguageId>"+
	"</MessageKey>"+
    "<RequestMessageInfo>"+
	"<BankId>"+BankId+"</BankId>"+
	"<TimeZone></TimeZone>"+
	"<EntityId></EntityId>"+
	"<EntityType></EntityType>"+
	"<ArmCorrelationId></ArmCorrelationId>"+
	"<MessageDateTime>"+Helper.correctDateFinacle()+"</MessageDateTime>"+
	"</RequestMessageInfo>"+
	"<Security>"+
	"<Token>"+
	"<PasswordToken>"+
	"<UserId></UserId>"+
	"<Password></Password>"+
	"</PasswordToken>"+
	"</Token>"+
	"<FICertToken></FICertToken>"+
	"<RealUserLoginSessionId></RealUserLoginSessionId>"+
	"<RealUser></RealUser>"+
	"<RealUserPwd></RealUserPwd>"+
	"<SSOTransferToken></SSOTransferToken>"+
	"</Security>"+
	"</RequestHeader>"+
	"</Header>"+
	"<Body>"+
	"<executeFinacleScriptRequest>"+
	"<ExecuteFinacleScriptInputVO>"+
	"<requestId>FI_LINTTModify.scr</requestId>"+
	"</ExecuteFinacleScriptInputVO>"+
	"<executeFinacleScript_CustomData>"+
	"<AcctNum>"+ActNum+"</AcctNum>"+
	"<tblCode>"+mclrtabcode+"</tblCode>"+
	"<startDate>"+startdate+"</startDate>"+
	"<peggedFreqInMnths>"+FreqMonths+"</peggedFreqInMnths>"+
	"<PrefIntRate>"+strintdiff+"</PrefIntRate>"+
	"<peggedFlg>Y</peggedFlg>"+
	"</executeFinacleScript_CustomData>"+
	"</executeFinacleScriptRequest>"+
	"</Body>"+
	"</FIXML>";
	
	System.out.println("==========strRequest============"+strRequest);
	
	
	String strEncyrpteddata="",EncyrptedAesSessionKey="";
	byte[] Sessionkey=KblEncyrptionDecyrption.generateAESKey();
	System.out.println("==========Sessionkey=======1====="+Sessionkey);
	 strEncyrpteddata=KblEncyrptionDecyrption.getAESEncryptedData(strRequest, Sessionkey);   //strRequest
	System.out.println("==========strEncyrpteddata============"+strEncyrpteddata);
	 EncyrptedAesSessionKey=KblEncyrptionDecyrption.encryptAESKey(ApplicationParams.getStrPostSancationEncryptionFile(), Sessionkey);
	System.out.println("==========EncyrptedAesSessionKey============"+EncyrptedAesSessionKey);
	
	
	
	String encrequest = "<?xml version=\"1.0\" encoding=\"UTF-8\"?> <xenc:EncryptedData Type=\"http://www.w3.org/2001/04/xmlenc#Element\"  xmlns:xenc=\"http://www.w3.org/2001/04/xmlenc#\"> <xenc:EncryptionMethod Algorithm=\"http://www.w3.org/2009/xmlenc11#aes256-gcm\"/> <dsig:KeyInfo xmlns:dsig=\"http://www.w3.org/2000/09/xmldsig#\"> <xenc:EncryptedKey> <xenc:EncryptionMethod Algorithm=\"http://www.w3.org/2009/xmlenc11#rsa-oaep\"> <dsig:DigestMethod Algorithm=\"http://www.w3.org/2001/04/xmlenc#sha256\"/> <xenc:OAEPparams/> <xenc:MGFAlgorithm Algorithm=\"http://www.w3.org/2009/xmlenc11#mgf1sha256\"/> </xenc:EncryptionMethod> <dsig:KeyInfo> <dsig:KeyName>pronteff_sha</dsig:KeyName> </dsig:KeyInfo> <xenc:CipherData> <xenc:CipherValue>" + 
	        EncyrptedAesSessionKey + "</xenc:CipherValue> " + 
	        "</xenc:CipherData> " + 
	        "</xenc:EncryptedKey> " + 
	        "</dsig:KeyInfo> " + 
	        "<xenc:CipherData> " + 
	        "<xenc:CipherValue>" + strEncyrpteddata + "</xenc:CipherValue> " + 
	        "</xenc:CipherData>" + 
	        "</xenc:EncryptedData>";
	
	System.out.println("==============encrequest========="+encrequest);
	
	
	String privatekey1="", publicKey="",strprivateKeyfile="",strprivate_key_req="";


	 strprivate_key_req = "yes";
	  strprivateKeyfile = "MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDuqhqoOkp/AysN8fnaOIl2pubeCj+HuYvZhnzvYHhwoMgklFv4Jzx8cioDdOMRmVRVGFMt5cOQWt/6JuJqr34h9NE7wYJOepQO2e5DnuwczFy0K1Ad5CXoJrX7v72Fimn/AGJtZ9jUcyu6BzK2ryBYvA4qyI7em7+EnOix/c2TtTHybklXKry2BIV43Cc5EXW7++YCn1TM+qkebXAcRp/ROnWPWx8rR/bO1PfOfDrvNcbS+un7e7EPMFpP90W6nw2euI0n3TSLq/92cI2chmK1B5d0EYXQxqxoNw6IUsZDD9sI6caD8Bf1mHAfEUwLZR/S3uAZHRik5hR7LMa9Gi+lAgMBAAECggEAE7JU3N64AzTJutmQ2zegm1A5lshAZ1J4KOL2hfLvkwFR7eLoltmgyPcgYdn7BhrMtkZ5pudiymkVjwQ32hd9pg5vA4Am4ZSFikGQw7fmmJctF27I/+Pc/68iLxKrRiLJjf1Zd4St2mq0MyLLm/68AVa+fJLCEmZxhIpGkgSg5g2nXY90Zfh8dNuE5WNtXZr5hOsTwwpjIt7Nq4RCo+puIvAh+6GAOHOGgMKgKTgpl7UIxsnUkEMNO1e/DYs9d84tjKzEPA4ezBerRI4NskyeqGifUMkuUFLCnEBzYMv4AAMnCxCJxHlcAlQ+aKe7DyrtmcRGcDBvz/Xg9YGSRpyEQQKBgQD4AH12tF3tH3KQjGueH7cipP/0XH33H4Mfem6ulTQxAG/S2NfcgZAaxckbVGJhCarDI1/T1Qq78BzUGBqV3G1e4BE2dwzqfBkVj63kDXFVojJTIX1ILAyjy67GKtOLBi3ZCRAa+crTFzjOPMuM8aumP5M+XEz6tfKBHwINY+eJHQKBgQD2XIYbrgXnaUJjcmdhcxO/W44SPSx29MhSmEKfMC8U6m60tcelRbwS/UlJEAgcWy3oBW+y0Bhol2jcJIFiUjRVBu36KoiGqqQkG8Wt/cqRtfCTDAgehdjpo+3PdAawFZMincSNa6RxByE273SePdK+vbXVdvEfZcywUw3ctk8CKQKBgQDWspXrTfqCbdcgjHAeVBaXR4DOa8QhTIaXmcZ4HXMxeM9WGaPGoeO/Sbrwjf0dROEwTk+Hc8f3K8fJVZSuaEXG/PPp0ua7mPOeVuSTqY+UMvaeQT/UW04V/x8vL6QzlwXZ/p6Su+17EX98C+Wr/ww6wI8YTY/W++0VG2MLdJHdgQKBgAuU8/UPLFXhu+5C7ZtGNrJzUm2HFLUO8u/3GoKzWDNKhiPWu+kIKzxVTgGyUD9NBg53WvX0FIGuRI685JxDsxQgPEXbhAmYshjEeXmhiclp3UJ8eVE+B6GMRFzRXpMeoIkrE5d2bQenRyd3AGuEColPD+JWMiXAumu7q9Ypd/NpAoGBALKDdzeyzd/swvWCY1bPbSpUp7liskSFPW7RpjxvNWoGVXoer5hares0oj26ylSB/GJEKH8Zf6kxtFnXEa68eXWF9BjUFGVgNJdnheUIU1tzgz7kZ8QXeHxpkhnByMq5UzfGwpgN4TG/K9bnrQTPWsjXKZovKOpdxgnMJ9CBa9Si";
	
publicKey = "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";
			String strNeslPasswordKey ="ApiUat@12345";  //"Kbl@12345";
	// char[] pwd = "Kbl@12345".toCharArray();	
			char[] pwd = "ApiUat@12345".toCharArray();	
	 String deckeyfile ="D://API//KBLAPIMGMTNEW.pem";
	 String deckeypfxfile ="D://API/APIGATEWAY_08-06-2022T102933.pfx";
	 
		
	String token="";
	OAuthTokenGeneration oauth = new OAuthTokenGeneration();
	HashMap Result= new HashMap();
	Result=oauth.getOAuthAuth(hshRequestValues);
	token=Helper.correctNull((String)Result.get("access_token"));
	strAppurl=ApplicationParams.getStrPostSancationEncryptionURL();//"https://apiuat.ktkbank.com:8443/non-production/development/fi-lintmodify/filint";

	
	String finalToken="",accessToken="",headerStatus="",clientId="",clientSecret="",TokenUrl="",Method="",Scope="",certiPath="",gType="",reqConcat="",testCommand="",location="",errCode="",errMessage="";
	Map<String,Object> responseMap = new HashMap<String, Object>();
	Map<String,String> ser = new HashMap<String, String>();
	Gson gson = new Gson();
	Type mapType = null;

		  gType="client_credentials";
		  clientId="92c2d9b9793695f7bd9aaa411d7657e0";
		  clientSecret="7a1980519b524854cfdf25cef98a95e9";
		  Scope="CCFM";
		
		 certiPath="/home/lapsuat/patches/NationalPortal/ktk1/ktk.crt";
		 
		 
		 System.out.println("----------IN "+Method+" Method | SSLContext-----------------");
			SSLContext ssl_ctx = SSLContext.getInstance("TLSv1.2");
			ssl_ctx.init(null,trustAllCerts,null);
			HostnameVerifier allHostsValid = new HostnameVerifier(){
				public boolean verify(String hostname,SSLSession session){
					return true;
				}
			};
					
		
			URL url = new URL(ApplicationParams.getStrPostSanctionURLEnc1());
		System.out.println("----------IN "+Method+" Method | "+ApplicationParams.getStrPostSanctionURLEnc1()+"-----------------");
		HttpsURLConnection con = (HttpsURLConnection)url.openConnection();
		HttpsURLConnection.setDefaultSSLSocketFactory(ssl_ctx.getSocketFactory());
		// Install the all-trusting host verifier
		HttpsURLConnection.setDefaultHostnameVerifier(allHostsValid);
		location =certiPath;
		if(!location.equalsIgnoreCase("0")){
			System.out.println("----------IN "+Method+" Method | With certificate-----------------");
			System.setProperty("javax.net.ssl.trustStore", location);
		}
		else{
			System.out.println("----------IN "+Method+" Method | Without certificate-----------------");
		}

		StringBuilder data = new StringBuilder();
		//testCommand
		if(testCommand.equalsIgnoreCase("1")){
			data.append("grant_type="+gType);
			data.append("client_id="+clientId);
			data.append("client_secret="+clientSecret);
			data.append("scope="+Scope);
		}
		else{
			data.append("grant_type="+gType+"&client_id="+clientId+"&client_secret="+clientSecret+"&scope="+Scope);
		}
		System.out.println("----------IN "+Method+" Method | data"+data+"-----------------");
		
		//encrequest=URLEncoder.encode(encrequest, "UTF-8");
		
		byte[] byteArray = encrequest.toString().getBytes("UTF-8");

		System.out.println("byteArray-----------------"+byteArray);

		if(reqConcat.equalsIgnoreCase("Basic")){
			System.out.println("----------IN "+Method+" Method | Encoding Client ID & Secret-----------------");
			//con.setRequestProperty("Authorization",reqConcat+" "+getEncodedIdAndPassword(clientId,clientSecret));
		}
		
		/*Map<String, String> headers = new HashMap<>();

		headers.put("X-IBM-Client-Id", clientId);
		headers.put("X-IBM-Client-Secret", clientSecret);
		headers.put("Authorization", "Bearer "+token);
		for (String headerKey : headers.keySet()) {
			con.setRequestProperty(headerKey, headers.get(headerKey));
			System.out.println("======headerKey========="+headerKey+"========="+headers.get(headerKey));
		}*/
		
		//con.setDoInput(true);
		        con.setRequestProperty("X-IBM-Client-Id",clientId);
				con.setRequestProperty("X-IBM-Client-Secret",clientSecret);
				con.setRequestProperty("Authorization","Bearer "+token);
				
				
		con.setRequestProperty("Content-Type","application/xml");
		//con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");		
		con.setRequestProperty("Accept","*/*");		
		con.setRequestProperty("Accept-Encoding" ,"gzip, deflate, br");
		con.setRequestProperty("Connection", "keep-alive");
		con.setRequestMethod("POST");
		con.setConnectTimeout(5000);
		con .setDoOutput(true);
		con.setDoInput(true);
		String response="";
		
		System.out.println("=== connection intialization===================");
				OutputStream outStream= con.getOutputStream();
				System.out.println("===service call ===getting outputstream");
				outStream.write(encrequest.getBytes("UTF-8"));
				outStream.close();
				
				System.out.println("======service call=====responsecode:" + con.getResponseCode());
				System.out.println("======service call=====ResponseMessage:"+con.getResponseMessage());
				try
				{
				if (200 == con.getResponseCode()) {
	
					String tempStr = "";
					BufferedReader inStream = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
					while ((tempStr = inStream.readLine()) != null) {
						response = response + tempStr;
					}
				}else {
					response=String.valueOf(con.getResponseCode());
				}
				System.out.println("===service call==response:"+response);
			} catch (IOException ioe) {
				ioe.printStackTrace();
				System.out.println("===========service call Error occurred while processing============ ");
			}
		
	///////////////////////////////////////////////
		OutputStream os = con.getOutputStream();
		//os.write(byteArray, 0, byteArray.length);
		os.write(byteArray, 0, byteArray.length);
		os.close();
		
		System.out.println("====after outputStream======");
		//OutputStreamWriter osw = new OutputStreamWriter(os);
		//System.out.println("====after OutputStreamWriter======");
		//osw.write(encrequest);//strRequest);
		
		Date connectionStartTime=new Date();
		System.out.println("::Request Sent At: " + connectionStartTime);
		System.out.println("::Request Data: "+ encrequest);
		
		String line="",strRes="";
//		 StringBuilder response = new StringBuilder();
//		try(BufferedReader br = new BufferedReader(
//				  new InputStreamReader(con.getInputStream(), "utf-8"))) {
//				   
//				    String responseLine = null;
//				    while ((responseLine = br.readLine()) != null) {
//				        response.append(responseLine.trim());
//				        
//				    }
//				    System.out.println("===1111111111111111111111=======@@@@@@@@@@@@@@@@@@@@@@@@==========="+response.toString());
//				}
//		System.out.println("=====111111111111111111====$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$============"+new String(response));
//		
//		
		String plainRequestnew="";
		
		StringWriter strwrt = new StringWriter();
		IOUtils.copy(con.getInputStream(), strwrt,StandardCharsets.UTF_8);
		plainRequestnew= strwrt.toString();
		
		System.out.println("===#################=======@@@@@@@@@@@@@@@@@@@@@@@@==========="+plainRequestnew.toString());
		
		System.out.println("===222222222222222222222222222222=======@@@@@@@@@@@@@@@@@@@@@@@@==========="+new String(plainRequestnew));
		
	//	response=plainRequestnew;
//		String line="",strRes="";
//		InputStreamReader reader = new InputStreamReader(con.getInputStream());
//		BufferedReader in = new BufferedReader(reader);
//		
//		StringBuffer result = new StringBuffer();
//		while ((line = in.readLine()) != null) {
//			result.append(line);
//		}
		
//		log
//		.info("################@@@@@@@@@@@@@ Response @@@@@@@@@@@@@################"
//				+ new String(response));

strRes = plainRequestnew.toString();
System.out.println(strRes);
plainresponse= plainRequestnew.toString();
strResponse=strRes;   
			System.out.println("^^^^^^^^^^^^^^^^^^^^@@@@@@@@@@@@@@@@@======="+strResponse);
			
			 
			 
			 
//			 BASE64Decoder decod=new BASE64Decoder();
//				byte b[]		= decod.decodeBuffer(strResponse);
//					      System.out.println("decodeBuffer:**********************:"+strResponse);
//					      String str	= new String(b);
//					      System.out.println("Before Decripting:+++++++++++++++++++++++++++++++++++:"+str);
//					      
//					      
//					      System.out.println("Before Decripting:+++++++++++++++++++++++++++++++++++:"+str);
//					      
//					      System.out.println("Before Decripting:+++++++++++++++++++++++++++++++++++:"+str);
					      
			 
/*InputStream geek = null;
 geek = new FileInputStream(new String(strResponse));
		 StringWriter strwrt = new StringWriter();
			IOUtils.copy(geek, strwrt,StandardCharsets.UTF_8);
			strResponse= strwrt.toString(); */   
			
//PostSanFirstRes.xml
		/*local file reader*/
		
/*		BufferedReader br1 = null;
		FileReader fr1 = null;
		String ResponseXML="";
		
		fr1 = new FileReader("D:\\API\\decodeapiresponse.txt");//api.txt");//PostSanFirstResEncrption.xml");//PostSanFirstRes.xml");//E:\\PostSanctionapi.xml");
		//br1 = new BufferedReader(fr1);	
		
		
		
//		 Scanner responseReader = new Scanner(br1);
//         StringBuffer buffer = new StringBuffer();
//         while (responseReader.hasNextLine()) {
//            buffer.append(responseReader.nextLine()+"\n");
//         }
         
        
         
       //  try(BufferedReader br = new BufferedReader(
        //		  new InputStreamReader(con.getInputStream(), "utf-8"))) {
        	 
           try(BufferedReader br = new BufferedReader(fr1)){
         		 // new FileReader("D:\\API\\decodeapiresponse.txt", "utf-8"))) {
        		    StringBuilder response = new StringBuilder();
        		    StringBuilder line = new StringBuilder();
        		    String responseLine = null;
        		    while ((responseLine = br.readLine()) != null) {
        		        response.append(responseLine.trim().getBytes("utf-8"));
        		        line.append(responseLine.trim());
        		    }
        		    
        		    System.out.println("*************************"+new String(response));
        		    System.out.println("+++++++++++++++++++================="+response.toString());
        		    
        		    
        		    System.out.println("*************************"+new String(line));
        		    System.out.println("+++++++++++++++++++================="+line.toString());
        		    
        		}
           
         
           
           
         
     //    responseReader.close();
         
         
//           String line="",strRes="";
//  		 StringBuilder response = new StringBuilder();
//  	"	try(BufferedReader br = new BufferedReader(
//  				  new InputStreamReader( "utf-8"))) {
//  				   
//  				    String responseLine = null;
//  				    while ((responseLine = br.readLine()) != null) {
//  				        response.append(responseLine.trim());
//  				        
//  				    }
//  				    System.out.println("====================="+response.toString());
//  				}
         
 		
//           FileReader	fr3 = new FileReader("D:\\API\\decodeapiresponse.txt");//api.txt");//PostSanFirstResEncrption.xml");//PostSanFirstRes.xml");//E:\\PostSanctionapi.xml");
// 		br1 = new BufferedReader(fr3);	
//         
// 		//BufferedInputStream reader = new BufferedInputStream();
//         BufferedOutputStream writer = new BufferedOutputStream(new FileOutputStream("D:\\API\\decodeapiresponsenew.txt"));
//          
//         byte[] buffer1 = new byte[4096];
//         int bytesRead = -1;
//          
//         while ((bytesRead = br1.read()) != -1) {
//             writer.write(buffer1, 0, bytesRead);
//         }
//         
//         writer.close();
         //reader.close();
           
           
           StringBuilder response = new StringBuilder();
           FileReader	fr3 = new FileReader("D:\\API\\decodeapiresponse.txt");//api.txt");//PostSanFirstResEncrption.xml");//PostSanFirstRes.xml");//E:\\PostSanctionapi.xml");
    		br1 = new BufferedReader(fr3);
        		    
        		     String responseLine = null;
        		     while ((responseLine = br1.readLine()) != null) {
        		         response.append(responseLine.trim().getBytes("utf-8"));
        		     }
        		     System.out.println("+++++++++++++++++++++++++++++++++++"+response.toString());
        		     System.out.println("+++++++++++++++++++++++++++++++++++"+new String(response));
        		 
           
           
         //Printing the Response
     /*   byte a[]=new String(buffer).getBytes("UTF-16LE");
        byte bb[]=new String(buffer).getBytes("UTF-8");
        byte c[]=new String(buffer).getBytes("ISO-8859-2");
        byte d[]=new String(buffer).getBytes("ISO-8859-1");  
        
        
        System.out.println("^^^^^^^^^^^^^^UTF-16LE^^^^^^@@@@@@@@@@@@@@@@@======="+new String(a));
         System.out.println("^^^^^^^^^^^^^^UTF-8^^^^^^@@@@@@@@@@@@@@@@@======="+new String(bb));
         System.out.println("^^^^^^^^^ISO-8859-2^^^^^^^^^^^@@@@@@@@@@@@@@@@@======="+new String(c));
         System.out.println("^^^^^^^^^^^ISO-8859-1^^^^^^^^^@@@@@@@@@@@@@@@@@======="+new String(d));  */
         
         
         
        // plainresponse=new String(buffer);
       //s   strResponse=new String(buffer);
		
          
         // plainresponse;//=new String(buffer);
         // strResponse;String(buffer);
		
    /*      System.out.println("^^^^^^^^^^^^^^^^^^^^@@@@@@@@@@@@@@@@@======="+strResponse.getBytes("UTF-8"));
			
			// byte[] decodedBytes = Base64.getDecoder().decode(strResponse);
			 
			// System.out.println("====decodedBytes=====>"+decodedBytes);*/
			 
			 
			
					      
			 	// byte[] decodedBytes1 = Base64.getDecoder().decode(str);
				 
				// System.out.println("====decodedBytes1=====>"+decodedBytes1); 
				 
				 
			      
		// StringWriter strwrt = new StringWriter();
			//IOUtils.copy(inputStream, strwrt,StandardCharsets.UTF_8);
			//strResponse= strwrt.toString(StandardCharsets.UTF_8);
		
		/* byte[] decodedBytes = Base64.getDecoder().decode(strResponse);
		 
		 System.out.println("====decodedBytes=====>"+decodedBytes); */
		 
		 
			     
		/*InputStream geek1 = null;
		 geek1 = new FileInputStream("D:\\API\\decodeapiresponse.txt");
				 StringWriter strwrt1 = new StringWriter();
					IOUtils.copy(geek1, strwrt1,StandardCharsets.UTF_8);
					strResponse= strwrt1.toString();  
					
					System.out.println("####################################"+strResponse);
		byte[] bres=plainresponse.getBytes(StandardCharsets.UTF_8);
		String strResponse1=new String(bres);*/
		
		
		
			
			
//strResponse="�      �����Q(K-*��ϳU2�3PRH�K�O��K�UqӵP���   ���U��F����Q��D�\x`Ŝ��^�9g~�����{��p�]3]S�]3���?�m4���\0��O>���A۶��a?uc�0�@�z��~��I���w�N������_�;�-NM漋?�u֍Ŝ7AB}c@��dBq��,j>B_~��"�$'�Ԧ�7-_�����ߘ�n�o1I���?����.H����qE�L����c��<x���_5�4o��4ӿU���O6Y��N�i��w��H���tL���A?�]��}�����_�`�>OƯ.� A�$_s��Yk�KT����I�k��T���Db��;x��+��jq|n�J�bį�0�}I�0�4�0ђ#��mg�2u���y/�"1bҥ�>�}h�ijn5��&o��>�[B�q6�p&[>]�:ɚUl TO�1y�S{�a��=��8�`���{�Y2�*����WP���.-������M��c��0H��sr����T�H�o�xk��1*����I� �cw�eʷ�TR�AC�xe//o�y"���q<����o��c���~�'7��P��,$����;8���c9��H��3��5CB��<1��b������n����Y����}�$]��$�[6��R<]����v���v����3Ҙ:_�\�y��c���$�BL�9�*������RKf>�Ut�ZX��Jt]��p�r���8U��#G�G4��ki����<�  V����w|AK!�8e8CƇ������P��+��<S�ᓓ�C��䝰(����6��=��?V��ʮ�Jl�]��	8��TL�h:cc��y'�Q$eK�җ�l���Yi��^<�(��̦^I*k�҇EX��,#y[�n�+M眒�1l^�s��ȹ�����LCL���y,��^-o�һ���Ĩ�0m�ʀt���e�zB��P�*ԙc�Q9�]��PZQ�Q��h����Wf���dwV�&}%�>3�SU�3/D�L��)f�ٲB�Q��ZY�Vp��0��'���ya}��t�ل��X�Ȭž���T�-\�ڮ�V��ѯ�+�~��*JnG=_��r�A����K~���l4F�t�*��BD�wu��J?�U�_Đx��,�7��nb�%�>�3x����0n��9#�M"a�6��ƖV)�E��]LL*Ix����3x�D�b6y&zZokZwFE����*_��i�抲�p�|2SD��d=��"�kkjĊA�it�ǦJ[��"@�/3V�3:��sS�M]lP(��g�#X/th�\�a+fb9A{]���kp��S�r��s��Q������\��?n� �!��yZ�.��x�)��&���������{���gL�Y/C�r�����0*��ɡV�Җ�F�'�mR�4���rtDw�����E������cò�'�kᦍ�ޮ$��f���@�Yd\ޑ��i*��]{��8� ��؍�]s}X@�}�c����M4�;y��хdfWnߊ�^\c���#�s�qز��ƈ ���.H���� ��C>�@��ukγ��hy�V׀��N/�<�"5X��z۰mokR#��;D�c�'U�}I�vGc�0�l&��6]O��vd���Vc�)ʢ+1^;({�B��y��k\|B]r�!66��w�]d��dv/R��Zy�ɘ��#;&�M�"$d�&��k˭��߿hg�,�6�L��>87�a���8@7;�ǋĺƢEL���q�9�'�e����G^SH�;�*�\��MT]e!���}M���   �� 6����";  

		System.out.println("====before=====>"+strResponse.getBytes("UTF-8"));
		
		
		
		
		//String privatekey1="", publicKey="",strprivateKeyfile="",strprivate_key_req="";


		 strprivate_key_req = "yes";
		  strprivateKeyfile = "MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDuqhqoOkp/AysN8fnaOIl2pubeCj+HuYvZhnzvYHhwoMgklFv4Jzx8cioDdOMRmVRVGFMt5cOQWt/6JuJqr34h9NE7wYJOepQO2e5DnuwczFy0K1Ad5CXoJrX7v72Fimn/AGJtZ9jUcyu6BzK2ryBYvA4qyI7em7+EnOix/c2TtTHybklXKry2BIV43Cc5EXW7++YCn1TM+qkebXAcRp/ROnWPWx8rR/bO1PfOfDrvNcbS+un7e7EPMFpP90W6nw2euI0n3TSLq/92cI2chmK1B5d0EYXQxqxoNw6IUsZDD9sI6caD8Bf1mHAfEUwLZR/S3uAZHRik5hR7LMa9Gi+lAgMBAAECggEAE7JU3N64AzTJutmQ2zegm1A5lshAZ1J4KOL2hfLvkwFR7eLoltmgyPcgYdn7BhrMtkZ5pudiymkVjwQ32hd9pg5vA4Am4ZSFikGQw7fmmJctF27I/+Pc/68iLxKrRiLJjf1Zd4St2mq0MyLLm/68AVa+fJLCEmZxhIpGkgSg5g2nXY90Zfh8dNuE5WNtXZr5hOsTwwpjIt7Nq4RCo+puIvAh+6GAOHOGgMKgKTgpl7UIxsnUkEMNO1e/DYs9d84tjKzEPA4ezBerRI4NskyeqGifUMkuUFLCnEBzYMv4AAMnCxCJxHlcAlQ+aKe7DyrtmcRGcDBvz/Xg9YGSRpyEQQKBgQD4AH12tF3tH3KQjGueH7cipP/0XH33H4Mfem6ulTQxAG/S2NfcgZAaxckbVGJhCarDI1/T1Qq78BzUGBqV3G1e4BE2dwzqfBkVj63kDXFVojJTIX1ILAyjy67GKtOLBi3ZCRAa+crTFzjOPMuM8aumP5M+XEz6tfKBHwINY+eJHQKBgQD2XIYbrgXnaUJjcmdhcxO/W44SPSx29MhSmEKfMC8U6m60tcelRbwS/UlJEAgcWy3oBW+y0Bhol2jcJIFiUjRVBu36KoiGqqQkG8Wt/cqRtfCTDAgehdjpo+3PdAawFZMincSNa6RxByE273SePdK+vbXVdvEfZcywUw3ctk8CKQKBgQDWspXrTfqCbdcgjHAeVBaXR4DOa8QhTIaXmcZ4HXMxeM9WGaPGoeO/Sbrwjf0dROEwTk+Hc8f3K8fJVZSuaEXG/PPp0ua7mPOeVuSTqY+UMvaeQT/UW04V/x8vL6QzlwXZ/p6Su+17EX98C+Wr/ww6wI8YTY/W++0VG2MLdJHdgQKBgAuU8/UPLFXhu+5C7ZtGNrJzUm2HFLUO8u/3GoKzWDNKhiPWu+kIKzxVTgGyUD9NBg53WvX0FIGuRI685JxDsxQgPEXbhAmYshjEeXmhiclp3UJ8eVE+B6GMRFzRXpMeoIkrE5d2bQenRyd3AGuEColPD+JWMiXAumu7q9Ypd/NpAoGBALKDdzeyzd/swvWCY1bPbSpUp7liskSFPW7RpjxvNWoGVXoer5hares0oj26ylSB/GJEKH8Zf6kxtFnXEa68eXWF9BjUFGVgNJdnheUIU1tzgz7kZ8QXeHxpkhnByMq5UzfGwpgN4TG/K9bnrQTPWsjXKZovKOpdxgnMJ9CBa9Si";
		
 publicKey = "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";
				 strNeslPasswordKey ="ApiUat@12345";  //"Kbl@12345";
		// char[] pwd = "Kbl@12345".toCharArray();	
				 pwd = "ApiUat@12345".toCharArray();	
		  deckeyfile ="D://API//KBLAPIMGMTNEW.pem";
		  deckeypfxfile ="D://API/APIGATEWAY_08-06-2022T102933.pfx";
		// KBLAPIMGMTNEW.crt
		 //strprivateKeyfiles
		 

		  
		  String privateKeyFile1=ApplicationParams.getStrPostSancationDecryptionFile();
		  BASE64Encoder b64 = new BASE64Encoder();
			PrivateKey privateKey = KblEncyrptionDecyrption.getRSAprivaetKeys1(privateKeyFile1, strNeslPasswordKey.toCharArray());
			String privatekey2=(b64.encode(privateKey.getEncoded()));
			byte [] key=privatekey1.getBytes();
			
			
			System.out.println("+++++++++++++++****************++++++++============="+KblEncyrptionDecyrption.decrypt(strResponse, strprivateKeyfile, publicKey));
			
			
			System.out.println("+++++++++++++++++++++++============="+KblEncyrptionDecyrption.getAESDecryptedData(new String(strResponse),key));
			
			
		  
		 
//		  System.out.println("decrypt767757557577575AESKey======1111111111111111111111111222222222222222==========>"+KblEncyrptionDecyrption.signSHA256RSANew(strResponse, strprivateKeyfile));//ApplicationParams.getStrPostSancationEncryptionFile()));// ApplicationParams.getStrPostSancationEncryptionFile()));//(strprivateKeyfile,CipherValue2.getBytes())); //PostSanctionAPIdecyrptfile.decryptAESKey(CipherValue2,ApplicationParams.getStrPostSancationDecryptionFile()));	
//			
//		  String strsignSHA256RSANew=KblEncyrptionDecyrption.signSHA256RSANew(strResponse, strprivateKeyfile);
//		  
//		  System.out.println("strsignSHA256RSANew======strsignSHA256RSANew==========>"+strsignSHA256RSANew);//ApplicationParams.getStrPostSancationEncryptionFile()));// ApplicationParams.getStrPostSancationEncryptionFile()));//(strprivateKeyfile,CipherValue2.getBytes())); //PostSanctionAPIdecyrptfile.decryptAESKey(CipherValue2,ApplicationParams.getStrPostSancationDecryptionFile()));	
//			
//		  System.out.println("decrypt767757557577575AESKey======1111111111111111111111111222222222222222==========>"+KblEncyrptionDecyrption.decryptwhole(strResponse, strprivateKeyfile,publicKey,EncyrptedAesSessionKey));//ApplicationParams.getStrPostSancationEncryptionFile()));// ApplicationParams.getStrPostSancationEncryptionFile()));
//		 // decryptAESKey
//		  System.out.println("decryptAESKeylatnew======decryptAESKeylatnew==========>"+KblEncyrptionDecyrption.decryptAESKeylatnew(EncyrptedAesSessionKey.getBytes(),ApplicationParams.getStrPostSancationDecryptionFile(),strNeslPasswordKey));
//		 //str   strResponse
//		  
//		  System.out.println("getAESDecryptedDatalatnew======getAESDecryptedDatalatnew==========>"+KblEncyrptionDecyrption.getAESDecryptedDatalatnew(strsignSHA256RSANew,KblEncyrptionDecyrption.decryptAESKeylatnew(EncyrptedAesSessionKey.getBytes(),ApplicationParams.getStrPostSancationDecryptionFile(),strNeslPasswordKey)));
//			
//		  
		  
		  
		// System.out.println("decrypt767757557577575AESKey======1111111111111111111111111222222222222222==========>"+KblEncyrptionDecyrption.decryptwhole(strsignSHA256RSANew, strprivateKeyfile,publicKey,EncyrptedAesSessionKey));//ApplicationParams.getStrPostSancationEncryptionFile()));// ApplicationParams.getStrPostSancationEncryptionFile()));//(strprivateKeyfile,CipherValue2.getBytes())); //PostSanctionAPIdecyrptfile.decryptAESKey(CipherValue2,ApplicationParams.getStrPostSancationDecryptionFile()));	
			  
		 
		    
		 
		 System.out.println("decrypt767757557777777777777777777777577575AESKey======1111111111111111111111111222222222222222==========>"+KblEncyrptionDecyrption.decSignSHA256RSA(strResponse,"SHA256withRSA", strprivateKeyfile));
		 
		 
		 
		 System.out.println("decrypt767757557777777777777777777777577575AESKey======1111111111111111111111111222222222222222==========>"+KblEncyrptionDecyrption.signSHA256RSA(strResponse, strprivateKeyfile));//(strprivateKeyfile,CipherValue2.getBytes())); //PostSanctionAPIdecyrptfile.decryptAESKey(CipherValue2,ApplicationParams.getStrPostSancationDecryptionFile()));	
			
		 //String shaval=KblEncyrptionDecyrption.signSHA256RSA(str, strprivateKeyfile);
		 
		// System.out.println("shaval==========>"+shaval);//(strprivateKeyfile,CipherValue2.getBytes())); //PostSanctionAPIdecyrptfile.decryptAESKey(CipherValue2,ApplicationParams.getStrPostSancationDecryptionFile()));	
			
		// public static String getAESDecryptedData(String encryptedText,byte decKey[])
		 
		 //public static byte[] decryptAESKey(byte[] encryptedKey,String privateKeyFile,String filePassword)throws Exception
		 
		 
		/*String strdecyrpteddata=KblEncyrptionDecyrption.decryptAESKey(shaval.getBytes("UTF-8"),ApplicationParams.getStrPostSancationEncryptionFile(), Sessionkey);   //strRequest
			System.out.println("==========strEncyrpteddata============"+strEncyrpteddata);
			 EncyrptedAesSessionKey=KblEncyrptionDecyrption.encryptAESKey(ApplicationParams.getStrPostSancationEncryptionFile(), Sessionkey);
			System.out.println("==========EncyrptedAesSessionKey============"+EncyrptedAesSessionKey);*/
			
		 
			
		/* String deckeyfile ="D://API//KBLAPIMGMTNEW.pem";
		 String deckeypfxfile ="D://API/APIGATEWAY_08-06-2022T102933.pfx";
		// KBLAPIMGMTNEW.crt
		// System.out.println("decryptAESKey==========>"+KblEncyrptionDecyrption.decryptAESKey(shaval.getBytes(StandardCharsets.UTF_8),deckeyfile,strNeslPasswordKey));
		 
		 
		 
		 //System.out.println("decryptAESKeylatest======1111111111111111111111111222222222222222==========>"+KblEncyrptionDecyrption.getAESDecryptedData(EncyrptedAesSessionKey.getBytes("UTF-8"), deckeypfxfile, strNeslPasswordKey));//(strprivateKeyfile,CipherValue2.getBytes())); //PostSanctionAPIdecyrptfile.decryptAESKey(CipherValue2,ApplicationParams.getStrPostSancationDecryptionFile()));	
			
		 
		 //decryptAESKeylatest
		 
		System.out.println("decryptAESKeylatest======1111111111111111111111111222222222222222==========>"+KblEncyrptionDecyrption.decryptAESKeylatest(EncyrptedAesSessionKey.getBytes("UTF-8"), deckeypfxfile, strNeslPasswordKey));//(strprivateKeyfile,CipherValue2.getBytes())); //PostSanctionAPIdecyrptfile.decryptAESKey(CipherValue2,ApplicationParams.getStrPostSancationDecryptionFile()));	
		 	
		 
		 System.out.println("decrypt767757557577575AESKey======1111111111111111111111111222222222222222==========>"+KblEncyrptionDecyrption.decryptwhole(shaval, ApplicationParams.getStrPostSancationDecryptionFile(), ApplicationParams.getStrPostSancationEncryptionFile()));//(strprivateKeyfile,CipherValue2.getBytes())); //PostSanctionAPIdecyrptfile.decryptAESKey(CipherValue2,ApplicationParams.getStrPostSancationDecryptionFile()));	
			
		 
		// System.out.println("decryptAESKey======1111111111111111111111111222222222222222==========>"+KblEncyrptionDecyrption.decSignSHA256RSA(strResponse, "SHA256withRSA", ApplicationParams.getStrPostSancationEncryptionFile()));//(strprivateKeyfile,CipherValue2.getBytes())); //PostSanctionAPIdecyrptfile.decryptAESKey(CipherValue2,ApplicationParams.getStrPostSancationDecryptionFile()));	
			
		 
		 
		 
		System.out.println("decryptAESKey======1111111111111111111111111222222222222222==========>"+KblEncyrptionDecyrption.decryptAESKey(bres, deckeyfile, strNeslPasswordKey));//(strprivateKeyfile,CipherValue2.getBytes())); //PostSanctionAPIdecyrptfile.decryptAESKey(CipherValue2,ApplicationParams.getStrPostSancationDecryptionFile()));	
		//System.out.println("Output================>"+strResponse);
		System.out.println("getAESDecryptedData=====33333333333333333333333333333333===========>"+KblEncyrptionDecyrption.getAESDecryptedData(shaval, Sessionkey));
*/
		
		strResponse=strResponse.replace("xenc:", "");
	    strResponse=strResponse.replace("dsig:", "");
	    strResponse=strResponse.replace("<?xml version=\"1.0\" encoding=\"UTF-8\"?>", "");
	    strResponse=strResponse.replace("Type=\"http://www.w3.org/2001/04/xmlenc#Element\"","");
	    strResponse=strResponse.replace("xmlns:xenc=\"http://www.w3.org/2001/04/xmlenc#\"","");
	    strResponse=strResponse.replace("Algorithm=\"http://www.w3.org/2009/xmlenc11#aes256-gcm\"","");
	    strResponse=strResponse.replace("xmlns:dsig=\"http://www.w3.org/2000/09/xmldsig#\"","");
	    strResponse=strResponse.replace("Algorithm=\"http://www.w3.org/2009/xmlenc11#rsa-oaep\"","");			
	    strResponse=strResponse.replace("Algorithm=\"http://www.w3.org/2001/04/xmlenc#sha256\"","");
	    strResponse=strResponse.replace("Algorithm=\"http://www.w3.org/2009/xmlenc11#mgf1sha256\"","");	
	    strResponse=strResponse.trim();
		System.out.println("====After=====>"+strResponse);
		DocumentBuilderFactory factory1 = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder1 = factory1.newDocumentBuilder();
		 
		InputSource inputSource1 	   = new InputSource(new StringReader(strResponse));
	    Document document1 				   = builder1.parse(inputSource1);
	    
		//Build Document
		//Document document = builder.parse(new InputStream(strResponse)) ;
	    String CipherValue12="", CipherValue2="";
			
		document1.getDocumentElement().normalize();
		
		System.out.println("Root Element :" + document1.getDocumentElement().getNodeName());
		
		NodeList list1 = document1.getElementsByTagName("CipherData");

	    for (int temp = 0; temp < list1.getLength(); temp++) {

	        Node node = list1.item(temp);

	        if (node.getNodeType() == Node.ELEMENT_NODE) {

	            Element element1 = (Element) node;

	            // get staff's attribute
	           // String id = element.getAttribute("id");

	            // get text
	            if(temp==0)
	            {
	             CipherValue2 = element1.getElementsByTagName("CipherValue").item(0).getTextContent();
	             System.out.println("CipherValue2================>"+CipherValue2);
	            }
	            if(temp==1)
	            {
	            	 CipherValue12 = element1.getElementsByTagName("CipherValue").item(0).getTextContent();
	            	System.out.println("CipherValue1================>"+CipherValue12);
	            }
	        }
	    }

	    
	    System.out.println("DecryptDatanew======================1================="+KblEncyrptionDecyrption.DecryptDatanew(CipherValue2,CipherValue12,strprivateKeyfile,publicKey,strNeslPasswordKey));
		
	   
	    System.out.println("decrypsssssssssssssssssssssssssssstAESKey================>"+KblEncyrptionDecyrption.decryptAESKeylatest(EncyrptedAesSessionKey.getBytes(), ApplicationParams.getStrPostSancationDecryptionFile(), strNeslPasswordKey));
		  
	    
	    System.out.println("decrypsssssssssssssssssssssssssssstAESKey================>"+KblEncyrptionDecyrption.decryptAESKeylatest(CipherValue2.getBytes(), ApplicationParams.getStrPostSancationDecryptionFile(), strNeslPasswordKey));
	    System.out.println("decryptAESKeyData================>"+KblEncyrptionDecyrption.getAESDecryptedDatalatest(CipherValue12,KblEncyrptionDecyrption.decryptAESKeylatest(CipherValue2.getBytes(), ApplicationParams.getStrPostSancationDecryptionFile(), strNeslPasswordKey)));

	    //System.out.println("Output================>"+strResponse);

//	String privatekey1="", publicKey="",strprivateKeyfile="",strprivate_key_req="";
//
//
//	 strprivate_key_req = "yes";
//	  strprivateKeyfile = "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";
//	  publicKey = "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";
//	String strNeslPasswordKey ="Kbl@12345";
//	 char[] pwd = "Kbl@12345".toCharArray();	
//	 
//	 //strprivateKeyfile
//	 
//	System.out.println("decryptAESKey================>"+KblEncyrptionDecyrption.decryptAESKey(CipherValue2.getBytes(), ApplicationParams.getStrPostSancationDecryptionFile(), strNeslPasswordKey));//(strprivateKeyfile,CipherValue2.getBytes())); //PostSanctionAPIdecyrptfile.decryptAESKey(CipherValue2,ApplicationParams.getStrPostSancationDecryptionFile()));	
//	//System.out.println("Output================>"+strResponse);
//	System.out.println("getAESDecryptedData================>"+KblEncyrptionDecyrption.getAESDecryptedData(CipherValue12, KblEncyrptionDecyrption.decryptAESKey(CipherValue2.getBytes(), ApplicationParams.getStrPostSancationDecryptionFile(), strNeslPasswordKey)));

		
		
		strResponse=strResponse.replace("xsi:schemaLocation=\"http://www.finacle.com/fixml executeFinacleScript.xsd\" xmlns=\"http://www.finacle.com/fixml\"xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"","");
		
        strResponse=strResponse.trim();
		System.out.println("====After=====>"+strResponse);
		
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = factory.newDocumentBuilder();
		 
		InputSource inputSource 	   = new InputSource(new StringReader(strResponse));
	    Document document 				   = builder.parse(inputSource);
	    
		//Build Document
		//Document document = builder.parse(new InputStream(strResponse)) ;
	    String CipherValue1="", CipherValue="";
			
		document.getDocumentElement().normalize();
		
		System.out.println("Root Element :" + document.getDocumentElement().getNodeName());
		
		NodeList list = document.getElementsByTagName("Body");

        for (int temp = 0; temp < list.getLength(); temp++) {

            Node node = list.item(temp);

            if (node.getNodeType() == Node.ELEMENT_NODE) {

                Element element = (Element) node;

               
                
                if(element.getElementsByTagName("SUCCESS").getLength()>0)
                		{
                	hsh.put("PostSanctionROIflag", Helper.correctNull((String)element.getElementsByTagName("SUCCESS").item(0).getTextContent()));
                	hsh.put("PostSanctionROIStatus", "S");  
                	hsh.put("Status","S");
                	hsh.put("flag",Helper.correctNull((String)element.getElementsByTagName("SUCCESS").item(0).getTextContent()));
                	
                		}
               
                
                if(element.getElementsByTagName("ErrorDesc").getLength()>0)
	                //if(element.getElementsByTagName("ErrorDesc").item(0).getTextContent().length()>=0)
            		{
            	hsh.put("PostSanctionROIflag", Helper.correctNull((String)element.getElementsByTagName("ErrorDesc").item(0).getTextContent()));
            	hsh.put("PostSanctionROIStatus", "F");  
            	
            	hsh.put("Status","F");
            	hsh.put("flag",Helper.correctNull((String)element.getElementsByTagName("ErrorDesc").item(0).getTextContent()));
            	
            	hshQuery =new HashMap();
            	arrValues=new ArrayList();
            	hshQueryValues.put("size", "1");
            	if(sessionModuleType.equalsIgnoreCase("RET"))
            	{
            	    	hshQuery.put("strQueryId", "del_POSTSANCTION_APISTATUS");
            	}
            	if(!sessionModuleType.equalsIgnoreCase("RET"))
            	{
            	    	hshQuery.put("strQueryId", "del_POSTSANCTION_APISTATUScorpagr");
            	}
            	    	arrValues.add(appno);
            	    	if(!sessionModuleType.equalsIgnoreCase("RET"))
            	    	{
            	    		arrValues.add(hidFacSno);
            	    	}
            	    	hshQuery.put("arrValues", arrValues);
            	    	hshQueryValues.put("1", hshQuery);
            	    	EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
            	    			"updatedata");
           		 
           		 
           		hshQuery =new HashMap();
           		arrValues=new ArrayList();
           		hshQueryValues.put("size", "1");
         			hshQuery.put("strQueryId", "ins_POSTSANCTION_APISTATUS");
         			arrValues.add(appno);
         			arrValues.add(parentappno);
         			arrValues.add("F");
         			arrValues.add(strUserId);
         			arrValues.add(Helper.correctNull((String)hsh.get("flag")));
         			arrValues.add("executeFinacleScript");
         			arrValues.add(ServiceReqId);
         			arrValues.add(sessionModuleType);
         			arrValues.add("");
         			arrValues.add("");
         			arrValues.add("LoanAcctInq");   			
         			arrValues.add(hidFacSno);
         		
         			hshQuery.put("arrValues", arrValues);
         			hshQueryValues.put("1", hshQuery);
         			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
         					"updatedata");
            		}
                
                if(element.getElementsByTagName("error").getLength()>0)
                //if(element.getElementsByTagName("ErrorDesc").item(0).getTextContent().length()>=0)
        		{
        	hsh.put("PostSanctionROIflag", Helper.correctNull((String)element.getElementsByTagName("error").item(0).getTextContent()));
        	hsh.put("PostSanctionROIStatus", "F");  
        	
        	hsh.put("Status","F");
        	hsh.put("flag",Helper.correctNull((String)element.getElementsByTagName("error").item(0).getTextContent()));
        	
        	
        	hshQuery =new HashMap();
        	arrValues=new ArrayList();
        	hshQueryValues.put("size", "1");
        	if(sessionModuleType.equalsIgnoreCase("RET"))
        	{
        	    	hshQuery.put("strQueryId", "del_POSTSANCTION_APISTATUS");
        	}
        	if(!sessionModuleType.equalsIgnoreCase("RET"))
        	{
        	    	hshQuery.put("strQueryId", "del_POSTSANCTION_APISTATUScorpagr");
        	}
        	    	arrValues.add(appno);
        	    	if(!sessionModuleType.equalsIgnoreCase("RET"))
        	    	{
        	    		arrValues.add(hidFacSno);
        	    	}
        	    	hshQuery.put("arrValues", arrValues);
        	    	hshQueryValues.put("1", hshQuery);
        	    	EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
        	    			"updatedata");
     			
       		 
       		 
       		hshQuery =new HashMap();
       		arrValues=new ArrayList();
       		hshQueryValues.put("size", "1");
     			hshQuery.put("strQueryId", "ins_POSTSANCTION_APISTATUS");
     			arrValues.add(appno);
     			arrValues.add(parentappno);
     			arrValues.add("F");
     			arrValues.add(strUserId);
     			arrValues.add(Helper.correctNull((String)hsh.get("flag")));
     			arrValues.add("executeFinacleScript");
     			arrValues.add(ServiceReqId);
     			arrValues.add(sessionModuleType);
     			arrValues.add("");
     			arrValues.add("");
     			arrValues.add("LoanAcctInq");   			
     			arrValues.add(hidFacSno);
     		
     			hshQuery.put("arrValues", arrValues);
     			hshQueryValues.put("1", hshQuery);
     			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
     					"updatedata");
        		}
                
            }
        }

	  
		
		
	System.out.println("Output================>"+strResponse);
	
	
	
	if(Helper.correctNull((String)hsh.get("Status")).equalsIgnoreCase("S"))
	{
	

	
	
StrSecondReq="<FIXML xsi:schemaLocation=\"http://www.finacle.com/fixml LoanAcctInq.xsd\" xmlns=\"http://www.finacle.com/fixml\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">"+
	"<Header>"+
	"<RequestHeader>"+
	"<MessageKey>"+
	"<RequestUUID>"+ServiceReqId+"</RequestUUID>"+
	"<ServiceRequestId>LoanAcctInq</ServiceRequestId>"+
	"<ServiceRequestVersion>"+strVersionId+"</ServiceRequestVersion>"+
	"<ChannelId>COR</ChannelId>"+
	"</MessageKey>"+
	"<RequestMessageInfo>"+
	"<BankId>"+BankId+"</BankId>"+
	"<TimeZone></TimeZone>"+
	"<EntityId></EntityId>"+
	"<EntityType></EntityType>"+
	"<ArmCorrelationId></ArmCorrelationId>"+
	"<MessageDateTime>"+Helper.correctDateFinacle()+"</MessageDateTime>"+
	"</RequestMessageInfo>"+
	"<Security>"+
	"<Token>"+
	"<PasswordToken>"+
	"<UserId></UserId>"+
	"<Password></Password>"+
	"</PasswordToken>"+
	"</Token>"+
	"<FICertToken></FICertToken>"+
	"<RealUserLoginSessionId></RealUserLoginSessionId>"+
	"<RealUser></RealUser>"+
	"<RealUserPwd></RealUserPwd>"+
	"<SSOTransferToken></SSOTransferToken>"+
	"</Security>"+
	"</RequestHeader>"+
	"</Header>"+
	"<Body>"+
	"<LoanAcctInqRequest>"+
	"<LoanAcctInqRq>"+
	"<LoanAcctId>"+
	"<AcctId>"+ActNum+"</AcctId>"+
	"</LoanAcctId>"+
	"</LoanAcctInqRq>"+
	"<LoanAcctInq_CustomData/>"+
	"</LoanAcctInqRequest>"+
	"</Body>"+
	"</FIXML>";



System.out.println("==========StrSecondReq============"+StrSecondReq);



URL url2 = new URL(ApplicationParams.getStrPostSanctionNURL2());

System.out.println("==========ApplicationParams.getStrPostSanctionNURL2()============"+ApplicationParams.getStrPostSanctionNURL2());
HttpURLConnection con2 = (HttpURLConnection) url2.openConnection();
con2.setDoInput(true);

con2.setRequestMethod("POST");
con2.setRequestProperty("Content-Type","text/xml; charset=UTF-8");
con2.setConnectTimeout(5000);
con2 .setDoOutput(true);

OutputStream os2 = con2.getOutputStream();
System.out.println("====after outputStream======");
OutputStreamWriter osw2 = new OutputStreamWriter(os2);
System.out.println("====after OutputStreamWriter======");
osw2.write(StrSecondReq);//strRequest);
//osw.flush();


Date connectionStartTime1=new Date();
System.out.println("::StrSecondReq Sent At: " + connectionStartTime1);
System.out.println("::StrSecondReq Data: "+ StrSecondReq);
osw2.close();


String line2="",strRes2="";
InputStreamReader reader2 = new InputStreamReader(con2.getInputStream());
BufferedReader in2 = new BufferedReader(reader2);

StringBuffer result2 = new StringBuffer();
while ((line2 = in2.readLine()) != null) {
	result2.append(line2);
}

log
.info("################@@@@@@@@@@@@@ Response @@@@@@@@@@@@@################"
		+ result2.toString());

strRes2 = result2.toString();
System.out.println(strRes2);
plainresponse2=strRes2;
strResponse2=strRes2;   


/*System.out.println("strResponse2=================="+strResponse2);*/



/*BufferedReader br2 = null;
FileReader fr2 = null;
String ResponseXML2="";

fr2 = new FileReader("D:\\loanAccResponse.xml");//E:\\PostSanctionapi.xml");
br2 = new BufferedReader(fr2);	



Scanner responseReader2 = new Scanner(br2);
StringBuffer buffer2 = new StringBuffer();
while (responseReader2.hasNextLine()) {
buffer2.append(responseReader2.nextLine()+"\n");
}
responseReader2.close();
//Printing the Response
System.out.println(buffer2.toString());
plainresponse2=buffer2.toString();
strResponse2=buffer2.toString();    */


System.out.println("strResponse2=================="+strResponse2);

strResponse2=strResponse2.replace("xsi:schemaLocation=\"http://www.finacle.com/fixml LoanAcctInq.xsd\" xmlns=\"http://www.finacle.com/fixml\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"","");


strResponse=strResponse.trim();
System.out.println("====After=====>"+strResponse);

DocumentBuilderFactory factory2 = DocumentBuilderFactory.newInstance();
DocumentBuilder builder2 = factory2.newDocumentBuilder();

InputSource inputSource2 	   = new InputSource(new StringReader(strResponse2));
Document document2 				   = builder.parse(inputSource2);

//Build Document
//Document document = builder.parse(new InputStream(strResponse)) ;


document.getDocumentElement().normalize();

System.out.println("Root Element :" + document2.getDocumentElement().getNodeName());

NodeList list2 = document2.getElementsByTagName("HostTransaction");

for (int temp = 0; temp < list2.getLength(); temp++) {

Node node2 = list2.item(temp);

if (node2.getNodeType() == Node.ELEMENT_NODE) {

 Element element2 = (Element) node2;

 // get staff's attribute
// String id = element.getAttribute("id");

 // get text
 
 if(element2.getElementsByTagName("Status").getLength()>=0)
 		{
 	hsh.put("flagval", Helper.correctNull((String)element2.getElementsByTagName("Status").item(0).getTextContent()));
 	
 	if(Helper.correctNull((String)element2.getElementsByTagName("Status").item(0).getTextContent()).equalsIgnoreCase("SUCCESS"))
 	{
 	hsh.put("Status", "S");  
 	}
 	
 	
 	if(Helper.correctNull((String)hsh.get("Status")).equalsIgnoreCase("S"))	
 	{
 		
 		NodeList list3 = document2.getElementsByTagName("NetIntRate");

 		 for (int temp3 = 0; temp3 < list3.getLength(); temp3++) {

 		     Node node3 = list3.item(temp3);

 		     if (node3.getNodeType() == Node.ELEMENT_NODE) {

 		         Element element3 = (Element) node3;
 		
 		         
 		        interestrate=Helper.correctNull((String)element3.getElementsByTagName("value").item(0).getTextContent());
 		        douintval=Double.valueOf(interestrate);
 		         
 		     }
 		
 		 }
 		 
 		 
 		hshQuery =new HashMap();
    	arrValues=new ArrayList();
    	hshQueryValues.put("size", "1");
    	if(sessionModuleType.equalsIgnoreCase("RET"))
    	{
    	    	hshQuery.put("strQueryId", "del_POSTSANCTION_APISTATUS");
    	    	hsh.put("successflag", "true");
    	}
    	if(!sessionModuleType.equalsIgnoreCase("RET"))
    	{
    	    	hshQuery.put("strQueryId", "del_POSTSANCTION_APISTATUScorpagr");
    	}
    	    	arrValues.add(appno);
    	    	if(!sessionModuleType.equalsIgnoreCase("RET"))
    	    	{
    	    		arrValues.add(hidFacSno);
    	    	}
    	    	hshQuery.put("arrValues", arrValues);
    	    	hshQueryValues.put("1", hshQuery);
    	    	EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
    	    			"updatedata");
		
 		 
 		 
 		hshQuery =new HashMap();
 		arrValues=new ArrayList();
 		hshQueryValues.put("size", "1");
		hshQuery.put("strQueryId", "ins_POSTSANCTION_APISTATUS");
		arrValues.add(appno);
		arrValues.add(parentappno);
		arrValues.add("S");
		arrValues.add(strUserId);
		arrValues.add("");
		arrValues.add("executeFinacleScript");
		arrValues.add(ServiceReqId);
		arrValues.add(sessionModuleType);
		arrValues.add("");
		arrValues.add("");
		arrValues.add("LoanAcctInq");   			
		arrValues.add(hidFacSno);
	
		hshQuery.put("arrValues", arrValues);
		hshQueryValues.put("1", hshQuery);
		EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
				"updatedata");
		
		if(sessionModuleType.equalsIgnoreCase("RET"))
		{
		hshQuery =new HashMap();
 		arrValues=new ArrayList();
		hshQueryValues.put("size", "1");
		hshQuery.put("strQueryId", "updateROIInFInancle");
		arrValues.add(""+douintval);
		arrValues.add(""+douintval);
		arrValues.add(""+douintval);
		arrValues.add(appno);
		hshQuery.put("arrValues", arrValues);
		hshQueryValues.put("1", hshQuery);
		EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
				"updatedata");
		}
		else
		{
			//updatecorpagrupdroi
			
			hshQuery =new HashMap();
	 		arrValues=new ArrayList();
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId", "updatecorpagrupdroi");
			arrValues.add(""+douintval);
			arrValues.add(appno);
			arrValues.add(hidFacSno);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
					"updatedata");
		}
		
		
		if(sessionModuleType.equalsIgnoreCase("CORP") || sessionModuleType.equalsIgnoreCase("AGR"))
		{
			
			int count=0,counta=0,countb=0;
			String appcount="";
			rs = DBUtils.executeLAPSQuery("sel_postsanctiondateroicorpagrimridetcount^" + appno);
			if (rs.next()) {
				count = rs.getInt("count");
				
			}
			if(rs!=null)
				rs.close();
			
			rs = DBUtils.executeLAPSQuery("sel_postsanctiondateroicorpagrimridet^" + appno);
			while (rs.next()) {
				
				if(!correctNull((String) rs.getString("facility_sancupdroi")).equalsIgnoreCase(""))
				{
				counta+=1;
				}
			}
			if(rs!=null)
				rs.close();
			
			if(count==counta)
			{
				hsh.put("successflag", "true");
			}
			
			else
			{
				ResultSet rs1=null;
			String parentappno1="",ActNum1="";
			strQuery = SQLParser.getSqlQuery("selfaciparentappnodetall^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				parentappno1 = Helper.correctNull((String) rs
						.getString("app_parent_appno"));
			
				
			
		String FACILITY_SNO="";
		strQuery = SQLParser.getSqlQuery("selpostsanroiselectioncorpagrmriparent^" + appno+"^"+parentappno1);
		rs1 = DBUtils.executeQuery(strQuery);
		if (rs1.next()) {
			ActNum1 = Helper.correctNull((String) rs1
					.getString("CBS_ACCOUNTNO"));
		}
			if(ActNum1.equalsIgnoreCase(""))
			{
				hsh.put("successflag", "true");
			}
			}
			}			
			
			
			
		}
		
		if(Helper.correctNull((String)hsh.get("successflag")).equalsIgnoreCase("true"))
		{
String 	strAppno=appno,appstatus1="",application_flag="",strOrgcodenew="",strOrglevelnew="",strappholder="",str_sentorglevelnew="",strOrgHeadnew="";
String strFromflowpoint="",strToflowpoint="";

rs = DBUtils.executeLAPSQuery("commworkflowsel2^" + strAppno);
	if (rs.next()) {
		appstatus1 = correctNull((String) rs.getString("app_status"));
		application_flag = Helper.correctNull((String) rs
				.getString("app_renew_flag"));
		strOrgcodenew=Helper.correctNull((String)rs.getString("APP_ORGCODE"));
		strOrglevelnew=Helper.correctNull((String)rs.getString("app_orglevel"));
	    strappholder=Helper.correctNull((String)rs.getString("APP_APPLNHOLDER"));
	}
	
	if(rs!=null)
		rs.close();
	strQuery=SQLParser.getSqlQuery("selorg_level^"+strOrgcodenew);
	rs=DBUtils.executeQuery(strQuery);
	if(rs.next())
	{
		str_sentorglevelnew = correctNull((String)rs.getString("org_level"));
		strOrgHeadnew = correctNull((String)rs.getString("org_head"));
	}
	
	strFromflowpoint = (String) hshRequestValues.get("mail_fromflowpoint");
	strToflowpoint = (String) hshRequestValues.get("mail_toflowpoint");

	System.out.println("======strOrglevelnew======="+strOrglevelnew);
	
	
	String scodeforallmoduls="";
	String headoforg="";
	
	if(!strOrglevelnew.equalsIgnoreCase("A"))
	{
		if(rs != null)
		{
			rs.close();
		}
		strQuery=SQLParser.getSqlQuery("sel_retmclrresetfreq^"+strAppno);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			scodeforallmoduls=Helper.correctNull(rs.getString("LOAN_PERTAINS_BRANCH"));
		}
		
		
	
	
		if(rs != null)
		{
			rs.close();
		}
		strQuery=SQLParser.getSqlQuery("getorgheadfromorgnisation^"+scodeforallmoduls);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			headoforg=Helper.correctNull(rs.getString("ORG_HEAD"));
		}
		
		strOrgHeadnew=headoforg;
	}
//if(strOrglevelnew.equalsIgnoreCase("A"))
	//{

		String strsms="";
		hshQueryValues = new HashMap();
		hshQuery=new HashMap();
		arrValues=new ArrayList();
		hshQuery.put("strQueryId","commworkflowinsnew3");
		arrValues.add(strAppno);
		arrValues.add(strappholder);
		arrValues.add(strOrgHeadnew);
		arrValues.add(strFromflowpoint);
		//arrValues.add(strToflowpoint);
		arrValues.add("C");
		if(rs != null)
		{
			rs.close();
		}
		strQuery=SQLParser.getSqlQuery("workflowusersanlimit^"+strappholder);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			arrValues.add(Helper.correctNull(rs.getString("org_scode")));
			arrValues.add(Helper.correctNull(rs.getString("usr_department")));
		}
		else
		{
			arrValues.add("");
			arrValues.add("");
		}
		if(rs != null)
		{
			rs.close();
		}
		strQuery=SQLParser.getSqlQuery("workflowusersanlimit^"+strOrgHeadnew);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			arrValues.add(Helper.correctNull(rs.getString("org_scode")));
			arrValues.add(Helper.correctNull(rs.getString("usr_department")));
		}
		else
		{
			arrValues.add("");
			arrValues.add("");
		}
		arrValues.add("Y");
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("1",hshQuery);
		
		hshQuery=new HashMap();
		arrValues=new ArrayList();
		hshQuery.put("strQueryId","updmailbxchkstatus");
		arrValues.add("Y");
		arrValues.add(strOrgHeadnew);
		arrValues.add(strAppno);
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("size","2");
		hshQueryValues.put("2",hshQuery);
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		
	}
		
		
		
 	}

 	else
 	{
 if(element2.getElementsByTagName("error").getLength()>0)
 //if(element.getElementsByTagName("ErrorDesc").item(0).getTextContent().length()>=0)
	{
hsh.put("flag", Helper.correctNull((String)element2.getElementsByTagName("error").item(0).getTextContent()));
hsh.put("Status", "F");  
	}
 
 if(sessionModuleType.equalsIgnoreCase("RET"))
 {
     	hshQuery.put("strQueryId", "del_POSTSANCTION_APISTATUS");
 }
 if(!sessionModuleType.equalsIgnoreCase("RET"))
 {
     	hshQuery.put("strQueryId", "del_POSTSANCTION_APISTATUScorpagr");
 }
     	arrValues.add(appno);
     	if(!sessionModuleType.equalsIgnoreCase("RET"))
     	{
     		arrValues.add(hidFacSno);
     	}
     	hshQuery.put("arrValues", arrValues);
     	hshQueryValues.put("1", hshQuery);
     	EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
     			"updatedata");
	
	 
	 
	hshQuery =new HashMap();
	arrValues=new ArrayList();
	hshQueryValues.put("size", "1");
	hshQuery.put("strQueryId", "ins_POSTSANCTION_APISTATUS");
	arrValues.add(appno);
	arrValues.add(parentappno);
	arrValues.add("F");
	arrValues.add(strUserId);
	arrValues.add(Helper.correctNull((String)hsh.get("flag")));
	arrValues.add("executeFinacleScript");
	arrValues.add(ServiceReqId);
	arrValues.add("");
	arrValues.add("");
	arrValues.add("");
	arrValues.add("LoanAcctInq");   			
	arrValues.add(hidFacSno);

	hshQuery.put("arrValues", arrValues);
	hshQueryValues.put("1", hshQuery);
	EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
			"updatedata");

 		}
 		}
}
}

	}
	}
	catch(Exception e)
	{
		e.printStackTrace();
		hsh.put("Status","F");
    	hsh.put("flag",e.toString());
    	
    	hshQuery =new HashMap();
    	arrValues=new ArrayList();
    	hshQueryValues.put("size", "1");
if(sessionModuleType.equalsIgnoreCase("RET"))
{
    	hshQuery.put("strQueryId", "del_POSTSANCTION_APISTATUS");
}
if(!sessionModuleType.equalsIgnoreCase("RET"))
{
    	hshQuery.put("strQueryId", "del_POSTSANCTION_APISTATUScorpagr");
}
    	arrValues.add(appno);
    	if(!sessionModuleType.equalsIgnoreCase("RET"))
    	{
    		arrValues.add(hidFacSno);
    	}
    	hshQuery.put("arrValues", arrValues);
    	hshQueryValues.put("1", hshQuery);
    	EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
    			"updatedata");
    	
    	 
    	 
    	hshQuery =new HashMap();
    	arrValues=new ArrayList();
    	hshQueryValues.put("size", "1");
 
    	hshQuery.put("strQueryId", "ins_POSTSANCTION_APISTATUS");
    	
    	arrValues.add(appno);
    	arrValues.add(parentappno);
    	arrValues.add("F");
    	arrValues.add(strUserId);
    	arrValues.add(Helper.correctNull((String)hsh.get("flag")));
    	arrValues.add("executeFinacleScript");
    	arrValues.add(ServiceReqId);
    	arrValues.add(sessionModuleType);
    	arrValues.add("");
    	arrValues.add("");
    	arrValues.add("LoanAcctInq"); 
    	arrValues.add(hidFacSno);
    	hshQuery.put("arrValues", arrValues);
    	hshQueryValues.put("1", hshQuery);
    	EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
    			"updatedata");
    	
	}
	finally
	{
		int strsno=0;
		try {
			rs=DBUtils.executeLAPSQuery("sel_max_POSTSANCTION_APISTATUS_LOGGER");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			if(rs.next())
			{
				strsno=Integer.parseInt(rs.getString("TYPE"));
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		
		
		hshQuery= new HashMap();
		arrValues = new ArrayList();
		hshQueryValues.put("size", "1");
		hshQuery.put("strQueryId", "ins_POSTSANCTION_APISTATUS_LOGGER");
		arrValues.add(appno);
		arrValues.add(parentappno);
		arrValues.add(strRequest);
		arrValues.add("");
		arrValues.add(plainresponse);
		arrValues.add("");
		arrValues.add(sessionModuleType);
		arrValues.add(""+strsno);
		arrValues.add(strUserId);
		arrValues.add("");
		arrValues.add("executeFinacleScript");
		arrValues.add(ServiceReqId);
		arrValues.add(StrSecondReq);
		arrValues.add("");
		arrValues.add("");
		arrValues.add("");
		arrValues.add("");
		arrValues.add("LoanAcctInq");
		arrValues.add(plainresponse2);
		arrValues.add(""); 
		arrValues.add(hidFacSno); 
		hshQuery.put("arrValues", arrValues);
		hshQueryValues.put("1", hshQuery);
		try {
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
					"updatedata");
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	return hsh;
}
}
