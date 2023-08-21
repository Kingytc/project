package com.sai.laps.webservices.rest.services;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.URL;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.ejb.EJBException;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathFactory;
import org.apache.log4j.Logger;
import org.jfree.util.Log;
import org.json.JSONArray;
import org.json.JSONObject;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sai.laps.ejb.DigitalAppInterface.DigitalAppInterfaceBean;
import com.sai.laps.ejb.FinacleBean.FinacleInterfaceBean;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.Constants;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.DataAccess;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.webservices.rest.domain.CustomerCreation;
import com.sai.laps.webservices.rest.domain.DedupeCheck;
import com.sai.laps.webservices.rest.domain.FetchProposals;
import com.sai.laps.webservices.rest.domain.FetchUserDetails;
import com.sai.laps.webservices.rest.domain.FinalInPrinciple;
import com.sai.laps.webservices.rest.domain.GenDmsUpd;
import com.sai.laps.webservices.rest.domain.GetGoldRate;
import com.sai.laps.webservices.rest.domain.GoldReappraiser;
import com.sai.laps.webservices.rest.domain.OrganisationDetails;
import com.sai.laps.webservices.rest.domain.PreApprovedOffer;
import com.sai.laps.webservices.rest.domain.ProposalCreation;
import com.sai.laps.webservices.rest.domain.Response;
import com.sai.laps.webservices.rest.domain.InwardDetails;
import com.sai.laps.webservices.rest.domain.SecurityCreation;
import com.sai.laps.webservices.rest.domain.ServerStatus;
import com.sai.laps.webservices.rest.domain.StatusCheck;
import com.sai.laps.webservices.rest.domain.UserClosure;
import com.sai.laps.webservices.rest.domain.UserCreation;
import com.sai.laps.webservices.rest.domain.UserUpdation;
import com.sai.laps.webservices.rest.domain.Userdesignation;
import com.sai.laps.webservices.rest.domain.ValuerList;
import com.sai.laps.webservices.rest.domain.msme.RenewalProposals;
import com.sai.laps.webservices.rest.domain.Birdata;

public class InwardDetailServiceImpl implements InwardDetailService{

	private static final Exception JsonProcessingException = null;
	ObjectMapper objectMapper = new ObjectMapper();
	
	static Logger log = Logger.getLogger(InwardDetailServiceImpl.class);


	//@Override
	public String saveInwardDetails(InwardDetails inwarddetails)throws JsonProcessingException {
		Map<String,Object> responseData = new HashMap<String,Object>();
		Response response = new Response();
		String jsonAsString = "";
		JSONObject objOuter        = new JSONObject();
		JSONObject PrintObject     = new JSONObject();
		HashMap hshValues 		   = new HashMap();
		String strCorpId="",strRefNo="",strStatus="";
		
		String strappdate="",strcusttype="",strcbscustid="",strcomcustadd1="",strcomcustadd2="",strhidcity="",strhidstate="",
		strcomcust_zip="",strcomcust_phone="",strcomcust_mobile="",strcomcust_email="",strcomcust_pan="",strcomloanpur="",strret_ftf="",
		strreceidate="",strdocrecd="",strhiddist="",strapplstatus="",strrejreason="",strbankscheme="",strleadno="",
		strBranchSolid="",strFname="",strDOB="",strAddchangeFlag="",strInwardAction="",strLARnumber="",strapplProcessLoc="",strschemeDesc="",strdigiAppNo="",strleadGeneratedAgentId="",strleadStaffId="",strleadConvertedBy="";
		
		String strResponseMsg="",strResponseCode="",strgovtSponserScheme="",strschemeType="",strsponsorAgency="",stragencyName="",strsubsidyAmount="",strsubsidyType="",strloanType="",strdocRecAgri="",strappraiserName="",strappraiseon="";

		
		try
		{
			
			JSONObject jsonCIFReqObj		= new JSONObject(inwarddetails);
			//JSONObject getCIFReqObj  	    = jsonCIFReqObj.getJSONObject("SysarcLARReq");
			//JSONObject JsonHeader		    = getCIFReqObj.getJSONObject("Header");
			//JSONObject JsonBody		        = jsonCIFReqObj.getJSONObject("Body");
			//JSONObject jsonObject = new JSONObject(strServerResponse);

			if (!jsonCIFReqObj.isNull("firstName"))
				strFname  = jsonCIFReqObj.getString("firstName");
			if (!jsonCIFReqObj.isNull("dob"))
				strDOB    = jsonCIFReqObj.getString("dob");
			if (!jsonCIFReqObj.isNull("applicationdate"))
				strappdate    = jsonCIFReqObj.getString("applicationdate");
			if (!jsonCIFReqObj.isNull("customerType"))
				strcusttype    = jsonCIFReqObj.getString("customerType");
			if (!jsonCIFReqObj.isNull("cbsid"))
				strcbscustid    = jsonCIFReqObj.getString("cbsid");
			if (!jsonCIFReqObj.isNull("custAddress1"))
				strcomcustadd1    = jsonCIFReqObj.getString("custAddress1");
			if (!jsonCIFReqObj.isNull("custAddress2"))
				strcomcustadd2    = jsonCIFReqObj.getString("custAddress2");
			if (!jsonCIFReqObj.isNull("custCity"))
				strhidcity    = jsonCIFReqObj.getString("custCity");
			if (!jsonCIFReqObj.isNull("custState"))
				strhidstate    = jsonCIFReqObj.getString("custState");
			if (!jsonCIFReqObj.isNull("custDistrict"))
				strhiddist    = jsonCIFReqObj.getString("custDistrict");
			if (!jsonCIFReqObj.isNull("custZip"))
				strcomcust_zip    = jsonCIFReqObj.getString("custZip");
			if (!jsonCIFReqObj.isNull("custPhone"))
				strcomcust_phone    = jsonCIFReqObj.getString("custPhone");
			if (!jsonCIFReqObj.isNull("custMobile"))
				strcomcust_mobile    = jsonCIFReqObj.getString("custMobile");
			if (!jsonCIFReqObj.isNull("custEmail"))
				strcomcust_email    = jsonCIFReqObj.getString("custEmail");
			if (!jsonCIFReqObj.isNull("panno"))
				strcomcust_pan    = jsonCIFReqObj.getString("panno");
			if (!jsonCIFReqObj.isNull("loanPurpose"))
				strcomloanpur    = jsonCIFReqObj.getString("loanPurpose");
			if (!jsonCIFReqObj.isNull("loanAmount"))
				strret_ftf    = jsonCIFReqObj.getString("loanAmount");
			if (!jsonCIFReqObj.isNull("documentReceived"))
				strdocrecd    = jsonCIFReqObj.getString("documentReceived");
			if (!jsonCIFReqObj.isNull("addlDocumentRecDate"))
				strreceidate    = jsonCIFReqObj.getString("addlDocumentRecDate");
			if (!jsonCIFReqObj.isNull("inwardStatus"))
				strapplstatus    = jsonCIFReqObj.getString("inwardStatus");
			if (!jsonCIFReqObj.isNull("rejectionReason"))
				strrejreason    = jsonCIFReqObj.getString("rejectionReason");
			if (!jsonCIFReqObj.isNull("leadNumber"))
				strleadno    = jsonCIFReqObj.getString("leadNumber");			
			if (!jsonCIFReqObj.isNull("branchSOLID"))
				strBranchSolid    = jsonCIFReqObj.getString("branchSOLID");			
			if (!jsonCIFReqObj.isNull("addressChangeFlag"))
				strAddchangeFlag    = jsonCIFReqObj.getString("addressChangeFlag");			
			if (!jsonCIFReqObj.isNull("inwardAction"))
				strInwardAction    = jsonCIFReqObj.getString("inwardAction");	
			if (!jsonCIFReqObj.isNull("larNumber"))
				strLARnumber    = jsonCIFReqObj.getString("larNumber");	
			if (!jsonCIFReqObj.isNull("bankScheme"))
				strbankscheme   = jsonCIFReqObj.getString("bankScheme");	
			if (!jsonCIFReqObj.isNull("applProcessLoc"))
				 strapplProcessLoc  = jsonCIFReqObj.getString("applProcessLoc");	
			if (!jsonCIFReqObj.isNull("schemeDesc"))
				strschemeDesc  = jsonCIFReqObj.getString("schemeDesc");	
			
			if (!jsonCIFReqObj.isNull("digiAppNo"))
				strdigiAppNo  = jsonCIFReqObj.getString("digiAppNo");		
			
			if (!jsonCIFReqObj.isNull("leadGeneratedId"))
				strleadGeneratedAgentId  = jsonCIFReqObj.getString("leadGeneratedId");

			if (!jsonCIFReqObj.isNull("leadStaffId"))
				strleadStaffId  = jsonCIFReqObj.getString("leadStaffId");

			if (!jsonCIFReqObj.isNull("leadConvertedBy"))
				strleadConvertedBy  = jsonCIFReqObj.getString("leadConvertedBy");
			
			
			if (!jsonCIFReqObj.isNull("govtSponserScheme"))
				strgovtSponserScheme  = jsonCIFReqObj.getString("govtSponserScheme");
			if (!jsonCIFReqObj.isNull("schemeType"))
				strschemeType  = jsonCIFReqObj.getString("schemeType");
			if (!jsonCIFReqObj.isNull("sponsorAgency"))
				strsponsorAgency  = jsonCIFReqObj.getString("sponsorAgency");
			if (!jsonCIFReqObj.isNull("agencyName"))
				stragencyName  = jsonCIFReqObj.getString("agencyName");
			if (!jsonCIFReqObj.isNull("subsidyAmount"))
				strsubsidyAmount  = jsonCIFReqObj.getString("subsidyAmount");
			if (!jsonCIFReqObj.isNull("subsidyType"))
				strsubsidyType  = jsonCIFReqObj.getString("subsidyType");
			if (!jsonCIFReqObj.isNull("loanType"))
				strloanType  = jsonCIFReqObj.getString("loanType");
			
			

			//Mandatory Check
			if( strFname.equals("") || strDOB.equals("") || strappdate.equals("") || strcusttype.equals("") || strcomcustadd1.equals("") ||
				strcomcustadd2.equals("") || strhidcity.equals("") || strhidstate.equals("") || strhiddist.equals("") || strcomcust_zip.equals("") || 
				strcomcust_mobile.equals("") ||	strcomcust_email.equals("") || strcomloanpur.equals("") || 
				strret_ftf.equals("") || strdocrecd.equals("") || strapplstatus.equals("") || strleadno.equals("") ||
				strBranchSolid.equals("") || strAddchangeFlag.equals("") || strbankscheme.equals("") || strapplProcessLoc.equals(""))
			{
				
				return Constants.ERROR_RESPONSE_MANDATORY;

			}
			
			if(!strDOB.equals("") && !strappdate.equals(""))
			{
				SimpleDateFormat sdfrmt = new SimpleDateFormat("dd/mm/yyyy");
			 	try
			 	{
				 	Date javaDate = sdfrmt.parse(strDOB); 
				 	Date javaDate2 = sdfrmt.parse(strappdate); 
 	
			 	}
		    	catch (ParseException e)
			    {
					return Constants.ERROR_RESPONSE_INVALID_DATEFORMAT;
			    }
			}
			
			if(strInwardAction.equals("M"))
			{
				if(strLARnumber.equals(""))
				{
					return Constants.ERROR_RESPONSE_LARmandtory;
				}
			}
			
			if(strcusttype.equals("E"))
			{
				if(strcbscustid.equals(""))
				{
					return Constants.ERROR_RESPONSE_MANDATORY;
				}
			}
				
			
			HashMap hshJsonValues = new HashMap();
			hshJsonValues.put("strFname",strFname);
			hshJsonValues.put("strDOB",strDOB);
			hshJsonValues.put("strSolid",strBranchSolid);
			hshJsonValues.put("txt_appdate",strappdate);
			hshJsonValues.put("selcusttype",strcusttype);
			hshJsonValues.put("txt_cbscustid",strcbscustid);
			hshJsonValues.put("txt_comcustadd1",strcomcustadd1);
			hshJsonValues.put("txt_comcustadd2",strcomcustadd2);
			hshJsonValues.put("hidcity",strhidcity);
			hshJsonValues.put("hid_state",strhidstate);
			hshJsonValues.put("txtcomcust_zip",strcomcust_zip);
			hshJsonValues.put("txtcomcust_phone",strcomcust_phone);
			hshJsonValues.put("txtcomcust_mobile",strcomcust_mobile);
			hshJsonValues.put("txtcomcust_email",strcomcust_email);
			hshJsonValues.put("txtcomcust_pan",strcomcust_pan);
			hshJsonValues.put("txt_comloanpur",strcomloanpur);
			hshJsonValues.put("txtret_ftf",strret_ftf);
			hshJsonValues.put("txt_receidate",strreceidate);
			hshJsonValues.put("seldocrecd",strdocrecd);
			hshJsonValues.put("hid_dist",strhiddist);
			hshJsonValues.put("selapplstatus",strapplstatus);
			hshJsonValues.put("txt_rejreason",strrejreason);
			hshJsonValues.put("sel_bankscheme",strbankscheme); 
			hshJsonValues.put("selborrowerstatus",strcusttype);
			hshJsonValues.put("txt_leadno",strleadno);
			hshJsonValues.put("strAddchangeFlag",strAddchangeFlag);
			hshJsonValues.put("strInwardAction",strInwardAction);
			hshJsonValues.put("strLARnumber",strLARnumber);
			hshJsonValues.put("strapplProcessLoc",strapplProcessLoc);
			hshJsonValues.put("strschemeDesc",strschemeDesc);
			hshJsonValues.put("strdigiAppNo",strdigiAppNo);
			hshJsonValues.put("strleadGeneratedAgentId",strleadGeneratedAgentId);
			hshJsonValues.put("strleadStaffId",strleadStaffId);
			hshJsonValues.put("strleadConvertedBy",strleadConvertedBy);
		
			hshJsonValues.put("strgovtSponserScheme",strgovtSponserScheme);
			hshJsonValues.put("strschemeType",strschemeType);
			hshJsonValues.put("strsponsorAgency",strsponsorAgency);
			hshJsonValues.put("stragencyName",stragencyName);
			hshJsonValues.put("strsubsidyAmount",strsubsidyAmount);
			hshJsonValues.put("strsubsidyType",strsubsidyType);
			hshJsonValues.put("strloanType",strloanType);
			
			
			boolean larcheck=true;
			
			ResultSet rs=null;
			String INWARD_NO="",strQuery="";
			strQuery=SQLParser.getSqlQuery("sel_digiappno_inw^"+strdigiAppNo);
			rs=DBUtils.executeQuery(strQuery);	
			if(rs.next())
			{
				INWARD_NO=Helper.correctNull((String)rs.getString("INWARD_NO"));
				larcheck=false;
			}
			
			if(larcheck==true)
			{
				hshValues = (HashMap) EJBInvoker.executeStateLess("DigitalAppInterface",hshJsonValues,"updateInwardDetails");
				strRefNo  = Helper.correctNull((String)hshValues.get("strInwardno"));
				strResponseCode=Helper.correctNull((String)hshValues.get("strResponseCode"));
				strResponseMsg=Helper.correctNull((String)hshValues.get("strResponseMsg"));
			}
			else
			{
				strRefNo=INWARD_NO;
				strResponseCode="LAPS-2012";
				strResponseMsg="LAR is already created for the given Digi application number";
			}
			
			
			responseData.put("LAPSLARnumber", strRefNo);
			response.setData(responseData);
			response.setResp_code(strResponseCode);
			response.setResp_msg(strResponseMsg);
			
			jsonAsString = objectMapper.writeValueAsString(response);
		}
		catch (Exception e)
		{
			response.setData(responseData);
			response.setResp_code("LAPS-2003");
			response.setResp_msg("Invalid request parameters");
			jsonAsString = objectMapper.writeValueAsString(response);
			e.printStackTrace();
			throw new EJBException("Exception in saveInwardDetails ==="+e.getMessage());
		}
		return jsonAsString;	
				
	}



	//@Override
	public String dedupeCheck(DedupeCheck DedupeCheck)
			throws JsonProcessingException {
		// TODO Auto-generated method stub
				
		
		Map<String,Object> responseData = new HashMap<String,Object>();
		Response response = new Response();
		String jsonAsString = "";
		JSONObject objOuter        = new JSONObject();
		JSONObject PrintObject     = new JSONObject();
		HashMap hshValues 		   = new HashMap();
		String strApplExists="",strStatus="";
		
		String strResponseMsg="",strResponseCode="",strPANno="", strCBSid="";
		
		
		try
		{
			
			JSONObject jsonCIFReqObj		= new JSONObject(DedupeCheck);
			//JSONObject getCIFReqObj  	    = jsonCIFReqObj.getJSONObject("SysarcLARReq");
			//JSONObject JsonHeader		    = getCIFReqObj.getJSONObject("Header");
			//JSONObject JsonBody		        = jsonCIFReqObj.getJSONObject("Body");
			//JSONObject jsonObject = new JSONObject(strServerResponse);

			if (!jsonCIFReqObj.isNull("panno"))
				strPANno    = jsonCIFReqObj.getString("panno");
			if (!jsonCIFReqObj.isNull("cbsid"))
				strCBSid    = jsonCIFReqObj.getString("cbsid");
			
					
			
			//Mandatory Check
			if(strPANno.equals("") && strCBSid.equals("") )
			{
				return Constants.ERROR_RESPONSE_MANDATORY;
			}
			
			if(!strPANno.equals(""))
			{
				Pattern pattern = Pattern.compile("[A-Z]{5}[0-9]{4}[A-Z]{1}");
				Matcher matcher = pattern.matcher(strPANno);
				if (!matcher.matches()) 
				{
					return Constants.ERROR_RESPONSE_INVALID_PANNO;
				}
			}
			
			HashMap hshJsonValues = new HashMap();
			hshJsonValues.put("strPANno",strPANno);
			hshJsonValues.put("strCBSid",strCBSid);
			
			
			hshValues = (HashMap) EJBInvoker.executeStateLess("DigitalAppInterface",hshJsonValues,"dedupeCheck");
			strApplExists  = Helper.correctNull((String)hshValues.get("strApplExist"));
			
			
			if(strApplExists.equals("Y"))
			{
				responseData.put("ApplicationExist", "Yes");
				responseData.put("CBSID", Helper.correctNull((String)hshValues.get("strCusCBSID")));
				responseData.put("CustomerName", Helper.correctNull((String)hshValues.get("strCusName")));
				responseData.put("CustomerFatherName", Helper.correctNull((String)hshValues.get("strCusFatherName")));
				responseData.put("CustomerDOB", Helper.correctNull((String)hshValues.get("strCustDOB")));
				responseData.put("CustomerPANNumber", Helper.correctNull((String)hshValues.get("strCustPANno")));
				responseData.put("LAPSProposalNumber", Helper.correctNull((String)hshValues.get("strAppno")));
				responseData.put("LAPSProposalStatus", Helper.correctNull((String)hshValues.get("strAppStatus")));
				responseData.put("CustomerMobileNumber", Helper.correctNull((String)hshValues.get("strmobileno")));
				responseData.put("birDate", Helper.correctNull((String)hshValues.get("strBIRdate")));
				
				strResponseCode="LAPS-1003";
				strResponseMsg="Dedupe Check Completed Successfully";
			}
			else
			{
				responseData.put("ApplicationExist", "No");
				responseData.put("birDate", Helper.correctNull((String)hshValues.get("strBIRdate")));
				responseData.put("LAPSProposalNumber", Helper.correctNull((String)hshValues.get("strAppno")));
				responseData.put("applicationDate", Helper.correctNull((String)hshValues.get("strappcreatedate")));
				strResponseCode="LAPS-1004";
				strResponseMsg="Dedupe Check Completed Successfully";
			}
			
			response.setData(responseData);
			response.setResp_code(strResponseCode);
			response.setResp_msg(strResponseMsg);
			
			jsonAsString = objectMapper.writeValueAsString(response);
		}
		catch (Exception e)
		{
			response.setData(responseData);
			response.setResp_code("LAPS-2003");
			response.setResp_msg("Invalid request parameters");
			jsonAsString = objectMapper.writeValueAsString(response);
			e.printStackTrace();
			throw new EJBException("Error in inwardDetailServiceImpl dedupeCheck..."+e.toString());
		}
		return jsonAsString;	
	}



	//@Override
	public String customerCreation(CustomerCreation CustomerCreation)
			throws JsonProcessingException {
		// TODO Auto-generated method stub
				
		
		Map<String,Object> responseData = new HashMap<String,Object>();
		Response response = new Response();
		String jsonAsString = "";
		JSONObject objOuter        = new JSONObject();
		JSONObject PrintObject     = new JSONObject();
		HashMap hshValues 		   = new HashMap();
		
		String strResponseMsg="",strResponseCode="",strNewLAPSid;
		
		//demographics
		String strCBSID="",strTitle="",strFullName="",strShortName="",strConstitution="",strDOB="01/01/1900",strPANNo="",strGender="";
		String strMaritalStatus="",strStatus="",strTaxSlab="",strBorrStatus="",strEmployment="",strBanking="",strBorrowerSince="";
		String strSatisfactory="",strStaffRelation="",strIntroStatus="",strResidentStatus="",strReligion="",strCaste="",strChildDep="",strOtherDep="";
		String strEarningMem="",strFamilyIncome="",strPhysicalChgd="",strsel_Blind="",strBranchCode="";
		
		//communication
		String strComAddress1="",strComAddress2="",strComCity="",strComDistrict="",strComState="",strComCountry="",
		strComPincode="",strResidentType="",strNoofYearsPresAdd="",mobileNumber="",customerEmail="";
		
		//kyc norms
		String strCustomerOccupation="",strIDprooftype="",strIDref="",strRiskCat="",strResidentProof="",strResidentIDref="",strNatureActivity="",
		strResidentIDdate="",stridProoofExpDate="";

		//inc and exp
		String strPrimaryIncome="",strGrossIncome="",strIncomeTaxDet="",strincomeITR="",strDocCollected="";
		
		//rating defaulter
		String strWhrRefCIBIL="",strCIBILscore="",strCIBILdetails="";
		
		//Employment details
		String strcompanyName="",strcompAddress="",strcompCity="",strcompState="",strcompPincode="",strcompPhoneno="",stremployeeID="",
		strexperinceYears="",strdateJoining="",strretirementDate="",strconfirmedEmployee="",strlistedCompany="",strsalaryReceiptDate="",
		strcommencementDate="",stryearsCurrentActivity="";
		
		String strAddressChangeFlag="",strPANflag="",strfiAddressFlag="",strfiEmploymentFlag="",strfiBankStatFlag="",stremandateEmiFlag="";
		String stremanbankacc="",stremanbankname="",strPermAddChangeFlag="",strfathername="",strstafflag="",streduqualification="",
		strItrFlag="",strBusinessProofFlag="",strOfficeAddFlag="",strcommunity="",strnetworthBorrower="",strproforma="",strResidenceProof="";
		
		String strincomeYearEnded="",stritrFillingDate="",strudyogAadharNumber="",strgstin="",strmseRegNumber="";
		String strcrifScore="",strcrifDetails="",crifReportedDate="",strSpouseName="",strMotherName="",strComAddressLine2="", strComAddressLine3="",
		strIncomeYearEndPreviousYear="",itrFillDatePreviousYear="", stritrSalaryPreviousYear="",strudyamRegistrationNumber="",
		strsalesTurnOverApplicant="",strsalesTurnOverDate="",strcriteriaforSalesTurnover="",strudyamRegistrationClassification="",strudyamDate="",strcibilDate="";
		
		try
		{
			
			JSONObject jsonCIFReqObj		= new JSONObject(CustomerCreation);
 
			///demographics
			if (!jsonCIFReqObj.isNull("cbsid"))
				strCBSID    = jsonCIFReqObj.getString("cbsid");
			if (!jsonCIFReqObj.isNull("customerTitle"))
				strTitle    = jsonCIFReqObj.getString("customerTitle");
			if (!jsonCIFReqObj.isNull("customerFullName"))
				strFullName    = jsonCIFReqObj.getString("customerFullName");	
			if (!jsonCIFReqObj.isNull("customerShortName"))
				strShortName    = jsonCIFReqObj.getString("customerShortName");
			if (!jsonCIFReqObj.isNull("customerConstitution"))
				strConstitution    = jsonCIFReqObj.getString("customerConstitution");
			if (!jsonCIFReqObj.isNull("customerDOB"))
				strDOB    = jsonCIFReqObj.getString("customerDOB");
			if (!jsonCIFReqObj.isNull("customerPANNO"))
				strPANNo    = jsonCIFReqObj.getString("customerPANNO");
			if (!jsonCIFReqObj.isNull("gender"))
				strGender    = jsonCIFReqObj.getString("gender");
			if (!jsonCIFReqObj.isNull("maritalStatus"))
				strMaritalStatus    = jsonCIFReqObj.getString("maritalStatus");
			if (!jsonCIFReqObj.isNull("customerStatus"))
				strStatus    = jsonCIFReqObj.getString("customerStatus");
			if (!jsonCIFReqObj.isNull("taxSlab"))
				strTaxSlab    = jsonCIFReqObj.getString("taxSlab");
			if (!jsonCIFReqObj.isNull("borrowerStatus"))
				strBorrStatus    = jsonCIFReqObj.getString("borrowerStatus");
			if (!jsonCIFReqObj.isNull("employmentType"))
				strEmployment    = jsonCIFReqObj.getString("employmentType");
			if (!jsonCIFReqObj.isNull("bankingwithus"))
				strBanking    = jsonCIFReqObj.getString("bankingwithus");
			if (!jsonCIFReqObj.isNull("borrowerSince"))
				strBorrowerSince    = jsonCIFReqObj.getString("borrowerSince");
			if (!jsonCIFReqObj.isNull("satisfactoryDealing"))
				strSatisfactory    = jsonCIFReqObj.getString("satisfactoryDealing");
			if (!jsonCIFReqObj.isNull("staffRelation"))
				strStaffRelation    = jsonCIFReqObj.getString("staffRelation");
			if (!jsonCIFReqObj.isNull("introducerStatus"))
				strIntroStatus    = jsonCIFReqObj.getString("introducerStatus");
			if (!jsonCIFReqObj.isNull("residentStatus"))
				strResidentStatus    = jsonCIFReqObj.getString("residentStatus");
			if (!jsonCIFReqObj.isNull("religion"))
				strReligion    = jsonCIFReqObj.getString("religion");
			if (!jsonCIFReqObj.isNull("caste"))
				strCaste    = jsonCIFReqObj.getString("caste");
			if (!jsonCIFReqObj.isNull("childDependent"))
				strChildDep    = jsonCIFReqObj.getString("childDependent");
			if (!jsonCIFReqObj.isNull("otherDependent"))
				strOtherDep    = jsonCIFReqObj.getString("otherDependent");
			if (!jsonCIFReqObj.isNull("earningMember"))
				strEarningMem    = jsonCIFReqObj.getString("earningMember");
			if (!jsonCIFReqObj.isNull("familyIncome"))
				strFamilyIncome    = jsonCIFReqObj.getString("familyIncome");
			if (!jsonCIFReqObj.isNull("physicallyChallenged"))
				strPhysicalChgd    = jsonCIFReqObj.getString("physicallyChallenged");
			if (!jsonCIFReqObj.isNull("blind"))
				strsel_Blind    = jsonCIFReqObj.getString("blind");
			if (!jsonCIFReqObj.isNull("branchCode"))
				strBranchCode    = jsonCIFReqObj.getString("branchCode");
			
			//communication details
			if (!jsonCIFReqObj.isNull("addressLine1"))
				strComAddress1    = jsonCIFReqObj.getString("addressLine1");
			if (!jsonCIFReqObj.isNull("addressLine2"))
				strComAddress2    = jsonCIFReqObj.getString("addressLine2");
			if (!jsonCIFReqObj.isNull("city"))
				strComCity    = jsonCIFReqObj.getString("city");
			if (!jsonCIFReqObj.isNull("district"))
				strComDistrict    = jsonCIFReqObj.getString("district");
			if (!jsonCIFReqObj.isNull("state"))
				strComState    = jsonCIFReqObj.getString("state");
			if (!jsonCIFReqObj.isNull("country"))
				strComCountry    = jsonCIFReqObj.getString("country");
			if (!jsonCIFReqObj.isNull("pincode"))
				strComPincode    = jsonCIFReqObj.getString("pincode");
			if (!jsonCIFReqObj.isNull("residentType"))
				strResidentType    = jsonCIFReqObj.getString("residentType");
			if (!jsonCIFReqObj.isNull("yearsPresentAddress"))
				strNoofYearsPresAdd    = jsonCIFReqObj.getString("yearsPresentAddress");
		
			//kyc norms
			if (!jsonCIFReqObj.isNull("occupation"))
				strCustomerOccupation    = jsonCIFReqObj.getString("occupation");
			if (!jsonCIFReqObj.isNull("proofType"))
				strIDprooftype    = jsonCIFReqObj.getString("proofType");
			if (!jsonCIFReqObj.isNull("idReference"))
				strIDref    = jsonCIFReqObj.getString("idReference");
			if (!jsonCIFReqObj.isNull("riskCategory"))
				strRiskCat    = jsonCIFReqObj.getString("riskCategory");
			if (!jsonCIFReqObj.isNull("residentProof"))
				strResidentProof    = jsonCIFReqObj.getString("residentProof");
			if (!jsonCIFReqObj.isNull("residentIdProof"))
				strResidentIDref    = jsonCIFReqObj.getString("residentIdProof");
			if (!jsonCIFReqObj.isNull("natureActivity"))
				strNatureActivity    = jsonCIFReqObj.getString("natureActivity");
			if (!jsonCIFReqObj.isNull("residentIdDate"))
				strResidentIDdate    = jsonCIFReqObj.getString("residentIdDate");
			if (!jsonCIFReqObj.isNull("idProofExpDate"))
				stridProoofExpDate    = jsonCIFReqObj.getString("idProofExpDate");
			
			
			//defaulter
			if (!jsonCIFReqObj.isNull("cibilReferred"))
				strWhrRefCIBIL    = jsonCIFReqObj.getString("cibilReferred");
			if (!jsonCIFReqObj.isNull("cibilScore"))
				strCIBILscore    = jsonCIFReqObj.getString("cibilScore");
			if (!jsonCIFReqObj.isNull("cibilDetails"))
				strCIBILdetails    = jsonCIFReqObj.getString("cibilDetails");
			
			//inc & exp
			if (!jsonCIFReqObj.isNull("primaryIncome"))
				strPrimaryIncome    = jsonCIFReqObj.getString("primaryIncome");
			if (!jsonCIFReqObj.isNull("grossIncome"))
				strGrossIncome    = jsonCIFReqObj.getString("grossIncome");
			if (!jsonCIFReqObj.isNull("incomeTaxDetail"))
				strIncomeTaxDet    = jsonCIFReqObj.getString("incomeTaxDetail");
			if (!jsonCIFReqObj.isNull("incomeITR"))
				strincomeITR    = jsonCIFReqObj.getString("incomeITR");
			if (!jsonCIFReqObj.isNull("docCollected"))
				strDocCollected    = jsonCIFReqObj.getString("docCollected");
			
			//employment
			if (!jsonCIFReqObj.isNull("companyName"))
				strcompanyName    = jsonCIFReqObj.getString("companyName");
			if (!jsonCIFReqObj.isNull("compAddress"))
				strcompAddress    = jsonCIFReqObj.getString("compAddress");
			if (!jsonCIFReqObj.isNull("compCity"))
				strcompCity    = jsonCIFReqObj.getString("compCity");
			if (!jsonCIFReqObj.isNull("compState"))
				strcompState    = jsonCIFReqObj.getString("compState");
			if (!jsonCIFReqObj.isNull("compPincode"))
				strcompPincode    = jsonCIFReqObj.getString("compPincode");
			if (!jsonCIFReqObj.isNull("compPhoneno"))
				strcompPhoneno    = jsonCIFReqObj.getString("compPhoneno");
			if (!jsonCIFReqObj.isNull("employeeID"))
				stremployeeID    = jsonCIFReqObj.getString("employeeID");
			if (!jsonCIFReqObj.isNull("experinceYears"))
				strexperinceYears    = jsonCIFReqObj.getString("experinceYears");
			if (!jsonCIFReqObj.isNull("dateJoining"))
				strdateJoining    = jsonCIFReqObj.getString("dateJoining");
			if (!jsonCIFReqObj.isNull("retirementDate"))
				strretirementDate    = jsonCIFReqObj.getString("retirementDate");
			if (!jsonCIFReqObj.isNull("confirmedEmployee"))
				strconfirmedEmployee    = jsonCIFReqObj.getString("confirmedEmployee");
			if (!jsonCIFReqObj.isNull("listedCompany"))
				strlistedCompany    = jsonCIFReqObj.getString("listedCompany");
			if (!jsonCIFReqObj.isNull("salaryReceiptDate"))
				strsalaryReceiptDate    = jsonCIFReqObj.getString("salaryReceiptDate");
			if (!jsonCIFReqObj.isNull("commencementDate"))
				strcommencementDate    = jsonCIFReqObj.getString("commencementDate");
			if (!jsonCIFReqObj.isNull("yearsCurrentActivity"))
				stryearsCurrentActivity    = jsonCIFReqObj.getString("yearsCurrentActivity");
			
			if (!jsonCIFReqObj.isNull("addressChangeFlag"))
				strAddressChangeFlag    = jsonCIFReqObj.getString("addressChangeFlag");
			if (!jsonCIFReqObj.isNull("panFlag"))
				strPANflag    = jsonCIFReqObj.getString("panFlag");
			if (!jsonCIFReqObj.isNull("fiAddressFlag"))
				strfiAddressFlag    = jsonCIFReqObj.getString("fiAddressFlag");
			if (!jsonCIFReqObj.isNull("fiEmploymentFlag"))
				strfiEmploymentFlag    = jsonCIFReqObj.getString("fiEmploymentFlag");
			if (!jsonCIFReqObj.isNull("fiBankStatementFlag"))
				strfiBankStatFlag    = jsonCIFReqObj.getString("fiBankStatementFlag");
			if (!jsonCIFReqObj.isNull("emandateEmiFlag"))
				stremandateEmiFlag    = jsonCIFReqObj.getString("emandateEmiFlag");
			
			if (!jsonCIFReqObj.isNull("emanBankAccountNo"))
				stremanbankacc    = jsonCIFReqObj.getString("emanBankAccountNo");
			if (!jsonCIFReqObj.isNull("emanBankName"))
				stremanbankname    = jsonCIFReqObj.getString("emanBankName");
			if (!jsonCIFReqObj.isNull("permanentaddressChangeFlag"))
				strPermAddChangeFlag    = jsonCIFReqObj.getString("permanentaddressChangeFlag");
			if(!jsonCIFReqObj.isNull("fatherName"))
				strfathername= jsonCIFReqObj.getString("fatherName");
			
			if(!jsonCIFReqObj.isNull("staffFlag"))
				strstafflag= jsonCIFReqObj.getString("staffFlag");
			
			if(!jsonCIFReqObj.isNull("educationQualification"))
				streduqualification= jsonCIFReqObj.getString("educationQualification");
			 
			if(!jsonCIFReqObj.isNull("mobileNumber"))
				mobileNumber= jsonCIFReqObj.getString("mobileNumber");
		
			if(!jsonCIFReqObj.isNull("customerEmail"))
				customerEmail= jsonCIFReqObj.getString("customerEmail");
			
			if(!jsonCIFReqObj.isNull("itrflag"))
				strItrFlag= jsonCIFReqObj.getString("itrflag");
			
			if(!jsonCIFReqObj.isNull("businessProofFlag"))
				strBusinessProofFlag= jsonCIFReqObj.getString("businessProofFlag");
			
			if(!jsonCIFReqObj.isNull("officeAddFlag"))
				strOfficeAddFlag= jsonCIFReqObj.getString("officeAddFlag");
			
			if(!jsonCIFReqObj.isNull("community"))
				strcommunity= jsonCIFReqObj.getString("community");
		
			
			if(!jsonCIFReqObj.isNull("networthBorrower"))
				strnetworthBorrower= jsonCIFReqObj.getString("networthBorrower");
			
			if (!jsonCIFReqObj.isNull("proformaInvoice"))
				strproforma    = jsonCIFReqObj.getString("proformaInvoice");
			if (!jsonCIFReqObj.isNull("ownResidenceProof"))
				strResidenceProof    = jsonCIFReqObj.getString("ownResidenceProof");
			
			if (!jsonCIFReqObj.isNull("incomeYearEnded"))
				strincomeYearEnded    = jsonCIFReqObj.getString("incomeYearEnded");
			if (!jsonCIFReqObj.isNull("itrFillingDate"))
				stritrFillingDate    = jsonCIFReqObj.getString("itrFillingDate");
			if (!jsonCIFReqObj.isNull("udyogAadharNumber"))
				strudyogAadharNumber    = jsonCIFReqObj.getString("udyogAadharNumber");
			if (!jsonCIFReqObj.isNull("gstin"))
				strgstin    = jsonCIFReqObj.getString("gstin");
			if (!jsonCIFReqObj.isNull("mseRegNumber"))
				strmseRegNumber    = jsonCIFReqObj.getString("mseRegNumber");
			
			if (!jsonCIFReqObj.isNull("comAddressLine2"))
				strComAddressLine2    = jsonCIFReqObj.getString("comAddressLine2");
			
			if (!jsonCIFReqObj.isNull("comAddressLine3"))
				strComAddressLine3    = jsonCIFReqObj.getString("comAddressLine3");
			
			
			if (!jsonCIFReqObj.isNull("incomeYearEndPreviousYear"))
				strIncomeYearEndPreviousYear    = jsonCIFReqObj.getString("incomeYearEndPreviousYear");
			
			if (!jsonCIFReqObj.isNull("itrFillDatePreviousYear"))
				itrFillDatePreviousYear    = jsonCIFReqObj.getString("itrFillDatePreviousYear");
			
			if (!jsonCIFReqObj.isNull("itrSalaryPreviousYear"))
				stritrSalaryPreviousYear    = jsonCIFReqObj.getString("itrSalaryPreviousYear");
			
			if (!jsonCIFReqObj.isNull("udyamRegistrationNumber"))
				strudyamRegistrationNumber    = jsonCIFReqObj.getString("udyamRegistrationNumber");
			
			if (!jsonCIFReqObj.isNull("salesTurnOverApplicant"))
				strsalesTurnOverApplicant    = jsonCIFReqObj.getString("salesTurnOverApplicant");
			
			if (!jsonCIFReqObj.isNull("salesTurnOverDate"))
				strsalesTurnOverDate    = jsonCIFReqObj.getString("salesTurnOverDate");
			
			if (!jsonCIFReqObj.isNull("criteriaforSalesTurnover"))
				strcriteriaforSalesTurnover    = jsonCIFReqObj.getString("criteriaforSalesTurnover");
			
			if (!jsonCIFReqObj.isNull("udyamRegistrationClassification"))
				strudyamRegistrationClassification    = jsonCIFReqObj.getString("udyamRegistrationClassification");
			
			if (!jsonCIFReqObj.isNull("udyamDate"))
				strudyamDate    = jsonCIFReqObj.getString("udyamDate");
			
			if (!jsonCIFReqObj.isNull("cibilDate"))
				strcibilDate    = jsonCIFReqObj.getString("cibilDate");
			
			JSONArray existingafcility= new JSONArray();
			if (!jsonCIFReqObj.isNull("existingFacility"))
				existingafcility=jsonCIFReqObj.getJSONArray("existingFacility");
			JSONObject jasonExistFaclty= new JSONObject();
			int existFacLenth=existingafcility.length();
			ArrayList arrExistFaclty=new ArrayList();
			ArrayList arrExistFacltyValues=new ArrayList();
			if(existFacLenth>0)
			{
			for(int i=0;i<existFacLenth;i++)
				{
					jasonExistFaclty=(JSONObject)existingafcility.get(i);
				
					String strnameOfBank=jasonExistFaclty.getString("nameOfBank");
					String strType=jasonExistFaclty.getString("type");	
					String strfacility=jasonExistFaclty.getString("facility");	
					String strpurposeOfLaon=jasonExistFaclty.getString("purposeOfLaon");	
					String strtypeOfFacility=jasonExistFaclty.getString("typeOfFacility");	
					String strlimit=jasonExistFaclty.getString("limit");	
					String stroutstanding=jasonExistFaclty.getString("outstanding");	
					String stroutstandingDate=jasonExistFaclty.getString("outstandingDate");	
					String strbankingType=jasonExistFaclty.getString("bankingType");	
					String strInterestType=jasonExistFaclty.getString("interestType");	
					String strspreadValue=jasonExistFaclty.getString("spreadValue");	
					String strRepaymentType=jasonExistFaclty.getString("repaymentType");	
					String strDueDate=jasonExistFaclty.getString("dueDate");	
					String strsecurityDesc=jasonExistFaclty.getString("securityDesc");	
					String strsecurityValue=jasonExistFaclty.getString("securityValue");	
					String strwhetherLitigation=jasonExistFaclty.getString("whetherLitigation");
					String strnatureOfLitigation=jasonExistFaclty.getString("natureOfLitigation");
					String strdateOfLitigation=jasonExistFaclty.getString("dateOfLitigation");	
					String strclaimAmount=jasonExistFaclty.getString("claimAmount");	
					String strotherClaim=jasonExistFaclty.getString("otherClaim");	
					String strpresentPosition=jasonExistFaclty.getString("presentPosition");	
					
					arrExistFacltyValues=new ArrayList();
					
					arrExistFacltyValues.add(strnameOfBank);
					arrExistFacltyValues.add(strType);
					arrExistFacltyValues.add(strfacility);
					arrExistFacltyValues.add(strpurposeOfLaon);
					arrExistFacltyValues.add(strtypeOfFacility);
					arrExistFacltyValues.add(strlimit);
					arrExistFacltyValues.add(stroutstanding);
					arrExistFacltyValues.add(stroutstandingDate);
					arrExistFacltyValues.add(strbankingType);
					arrExistFacltyValues.add(strInterestType);
					arrExistFacltyValues.add(strspreadValue);
					arrExistFacltyValues.add(strRepaymentType);
					arrExistFacltyValues.add(strDueDate);	
					arrExistFacltyValues.add(strsecurityDesc);	
					arrExistFacltyValues.add(strsecurityValue);
					arrExistFacltyValues.add(strwhetherLitigation);
					arrExistFacltyValues.add(strnatureOfLitigation);
					arrExistFacltyValues.add(strdateOfLitigation);
					arrExistFacltyValues.add(strclaimAmount);
					arrExistFacltyValues.add(strotherClaim);
					arrExistFacltyValues.add(strpresentPosition);
					arrExistFaclty.add(arrExistFacltyValues);
				}
			}
			
			if (!jsonCIFReqObj.isNull("crifScore"))
				strcrifScore    = jsonCIFReqObj.getString("crifScore");
			
			if (!jsonCIFReqObj.isNull("crifDetails"))
				strcrifDetails    = jsonCIFReqObj.getString("crifDetails");
			
			if (!jsonCIFReqObj.isNull("crifReportedDate"))
				crifReportedDate    = jsonCIFReqObj.getString("crifReportedDate");
			
			if (!jsonCIFReqObj.isNull("spouseName"))
				strSpouseName    = jsonCIFReqObj.getString("spouseName");
			
			if (!jsonCIFReqObj.isNull("motherName"))
				strMotherName    = jsonCIFReqObj.getString("motherName");
			
			
			JSONArray landHolding= new JSONArray();
			if (!jsonCIFReqObj.isNull("landHolding"))
			landHolding=jsonCIFReqObj.getJSONArray("landHolding");
			
			JSONObject jasonlandHolding= new JSONObject();
			int landHoldingLenth=landHolding.length();
			ArrayList arrLandHold=new ArrayList();
			ArrayList arrLandHoldValues=new ArrayList();
			if(landHoldingLenth>0)
			{
			for(int i=0;i<landHoldingLenth;i++)
				{
					jasonlandHolding=(JSONObject)landHolding.get(i);		
					String landhold=jasonlandHolding.getString("landHold");
					String surveyNo=jasonlandHolding.getString("surveyNo");
					String ownedOrLeased=jasonlandHolding.getString("ownedOrLeased");
					String farmercategory=jasonlandHolding.getString("farmerCategory");
					String landlesslabour=jasonlandHolding.getString("landLessLabourType");
					
					arrLandHoldValues=new ArrayList();			
					arrLandHoldValues.add(landhold);
					arrLandHoldValues.add(surveyNo);
					arrLandHoldValues.add(ownedOrLeased);
					arrLandHoldValues.add(farmercategory);
					arrLandHoldValues.add(landlesslabour);
					arrLandHold.add(arrLandHoldValues);
				}
			}
			//Mandatory Check
			if(strFullName.equals("") || strConstitution.equals("") || strGender.equals("") || strMaritalStatus.equals("") 
				|| strBorrStatus.equals("") || strBanking.equals("") || strReligion.equals("") || strCaste.equals("")
				|| strOtherDep.equals("") || strPhysicalChgd.equals("") || strsel_Blind.equals("") || strBranchCode.equals("") || strComAddress1.equals("")
				|| strComAddress2.equals("") || strComCity.equals("") || strComDistrict.equals("") || strComState.equals("") || strComCountry.equals("")
				|| strComPincode.equals("") || strResidentType.equals("") || strCustomerOccupation.equals("") || strGrossIncome.equals("")
				|| strincomeITR.equals("") || strWhrRefCIBIL.equals("") || strCIBILscore.equals("") || strCIBILdetails.equals("")
					)
			
			{
				return Constants.ERROR_RESPONSE_MANDATORY;
			}

			if(strEmployment.equals("1"))
			{
					if(strcompanyName.equals("") || strcompAddress.equals("") || strcompCity.equals("") || strcompState.equals("") || strcompPincode.equals("")
						|| strcompPhoneno.equals("") || strexperinceYears.equals("") )
					{
						return Constants.ERROR_RESPONSE_MANDATORY;
					}
			}
			
			SimpleDateFormat sdfrmt = new SimpleDateFormat("dd/mm/yyyy");

			if(!strDOB.equals(""))
			{
			 	try
			 	{
				 	Date javaDate = sdfrmt.parse(strDOB); 
			 	}
		    	catch (ParseException e)
			    {
					return Constants.ERROR_RESPONSE_INVALID_DATEFORMAT;
			    }
			}
			if(!strBorrowerSince.equals(""))
			{
			 	try
			 	{
				 	Date javaDate1 = sdfrmt.parse(strBorrowerSince); 
			 	}
		    	catch (ParseException e)
			    {
					return Constants.ERROR_RESPONSE_INVALID_DATEFORMAT;
			    }
			}
			
			
			
			if(!strPANNo.equals(""))
			{
				Pattern pattern = Pattern.compile("[A-Z]{5}[0-9]{4}[A-Z]{1}");
				Matcher matcher = pattern.matcher(strPANNo);
				if (!matcher.matches()) 
				{
					return Constants.ERROR_RESPONSE_INVALID_PANNO;
				}
			}
			
			if(strGender.equals("M"))
			{
				strTitle="MR";
			}
			else if(strGender.equals("F") && strMaritalStatus.equals("MARID"))
			{
				strTitle="MRS";
			}
			else if(strGender.equals("F") && strMaritalStatus.equals("SINGL"))
			{
				strTitle="MS";
			}
			
			String[] strShortNameTemp=strFullName.trim().split(" ");
			if(strShortNameTemp.length>0)
			{
				strShortName=strShortNameTemp[0];
			}
			else
			{
				strShortName="";
			}
			
			if(strFullName.length()>6)
			{
				strShortName=strFullName.substring(0, 6);
			}
			else
			{
				strShortName=strFullName;
			}
			
			int cusAge=Integer.parseInt(Helper.calculateAGE(strDOB));
			if(cusAge>60)
			{
				strStatus="100";
			}
			else 
			{
				strStatus="001";
			}
			
			//default values
			strSatisfactory="Y";
			strIntroStatus="3";
			strResidentStatus="N";
			strChildDep="0";
			strEarningMem="0";
			strFamilyIncome="0.00";
			strconfirmedEmployee="1";
			strlistedCompany="1";
			//strNoofYearsPresAdd="0~0";
			//strIDprooftype="01";
			//strIDref=strPANNo;
			strRiskCat="1";
			strNatureActivity="N";
			//strIncomeTaxDet="1";
			//strDocCollected="I";
			stremployeeID="NA";
			if(strDocCollected.equals(""))
			{
				strDocCollected="B";
			}
			
			int expinyears= Integer.parseInt(Helper.correctInt((String)strexperinceYears));
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.YEAR, -expinyears);
			strdateJoining=(cal.get(Calendar.DATE) + "/"+ (cal.get(Calendar.MONTH)+1) + "/" + cal.get(Calendar.YEAR));
			
			//strretirementDate="01/01/1900";
		/*	Calendar cal2 = Calendar.getInstance();
			strsalaryReceiptDate=("07/"+ (cal2.get(Calendar.MONTH)) + "/" + cal2.get(Calendar.YEAR));
			*/
			
			
			
			HashMap hshJsonValues = new HashMap();
			hshJsonValues.put("strCBSID",strCBSID);
			hshJsonValues.put("strTitle",strTitle);
			hshJsonValues.put("strFullName",strFullName);
			hshJsonValues.put("strShortName",strShortName);
			hshJsonValues.put("strConstitution",strConstitution);
			hshJsonValues.put("strDOB",strDOB);
			hshJsonValues.put("strPANNo",strPANNo);
			hshJsonValues.put("strGender",strGender);
			hshJsonValues.put("strMaritalStatus",strMaritalStatus);
			hshJsonValues.put("strStatus",strStatus);
			hshJsonValues.put("strTaxSlab",strTaxSlab);
			hshJsonValues.put("strBorrStatus",strBorrStatus);
			hshJsonValues.put("strEmployment",strEmployment);
			hshJsonValues.put("strBanking",strBanking);
			hshJsonValues.put("strBorrowerSince",strBorrowerSince);
			hshJsonValues.put("strSatisfactory",strSatisfactory);
			hshJsonValues.put("strStaffRelation",strStaffRelation);
			hshJsonValues.put("strIntroStatus",strIntroStatus);
			hshJsonValues.put("strResidentStatus",strResidentStatus);
			hshJsonValues.put("strReligion",strReligion);
			hshJsonValues.put("strCaste",strCaste);
			hshJsonValues.put("strChildDep",strChildDep);
			hshJsonValues.put("strOtherDep",strOtherDep);
			hshJsonValues.put("strEarningMem",strEarningMem);
			hshJsonValues.put("strFamilyIncome",strFamilyIncome);
			hshJsonValues.put("strPhysicalChgd",strPhysicalChgd);
			hshJsonValues.put("strsel_Blind",strsel_Blind);
			hshJsonValues.put("strBranchCode",strBranchCode);
			
			hshJsonValues.put("strComAddress1",strComAddress1);
			hshJsonValues.put("strComAddress2",strComAddress2);
			hshJsonValues.put("strComCity",strComCity);
			hshJsonValues.put("strComDistrict",strComDistrict);
			hshJsonValues.put("strComState",strComState);
			hshJsonValues.put("strComCountry",strComCountry);
			hshJsonValues.put("strComPincode",strComPincode);
			hshJsonValues.put("strResidentType",strResidentType);
			hshJsonValues.put("strNoofYearsPresAdd",strNoofYearsPresAdd);

			hshJsonValues.put("strCustomerOccupation",strCustomerOccupation);
			hshJsonValues.put("strIDprooftype",strIDprooftype);
			hshJsonValues.put("strIDref",strIDref);
			hshJsonValues.put("strRiskCat",strRiskCat);
			hshJsonValues.put("strResidentProof",strResidentProof);
			hshJsonValues.put("strResidentIDref",strResidentIDref);
			hshJsonValues.put("strNatureActivity",strNatureActivity);
			hshJsonValues.put("strResidentIDdate",strResidentIDdate);
			hshJsonValues.put("stridProoofExpDate",stridProoofExpDate);
			
			hshJsonValues.put("strWhrRefCIBIL",strWhrRefCIBIL);
			hshJsonValues.put("strCIBILscore",strCIBILscore);
			hshJsonValues.put("strCIBILdetails",strCIBILdetails);

			hshJsonValues.put("strPrimaryIncome",strPrimaryIncome);
			hshJsonValues.put("strGrossIncome",strGrossIncome);
			hshJsonValues.put("strIncomeTaxDet",strIncomeTaxDet);
			hshJsonValues.put("strincomeITR",strincomeITR);
			hshJsonValues.put("strDocCollected",strDocCollected);

			hshJsonValues.put("strcompanyName",strcompanyName);
			hshJsonValues.put("strcompAddress",strcompAddress);
			hshJsonValues.put("strcompCity",strcompCity);
			hshJsonValues.put("strcompState",strcompState);
			hshJsonValues.put("strcompPincode",strcompPincode);
			hshJsonValues.put("strcompPhoneno",strcompPhoneno);
			hshJsonValues.put("stremployeeID",stremployeeID);
			hshJsonValues.put("strexperinceYears",strexperinceYears);
			hshJsonValues.put("strdateJoining",strdateJoining);
			hshJsonValues.put("strretirementDate",strretirementDate);
			hshJsonValues.put("strconfirmedEmployee",strconfirmedEmployee);
			hshJsonValues.put("strlistedCompany",strlistedCompany);
			hshJsonValues.put("strsalaryReceiptDate",strsalaryReceiptDate);
			hshJsonValues.put("strcommencementDate",strcommencementDate);
			hshJsonValues.put("stryearsCurrentActivity",stryearsCurrentActivity);
		
			hshJsonValues.put("strAddressChangeFlag",strAddressChangeFlag);
			hshJsonValues.put("strPANflag",strPANflag);
			hshJsonValues.put("strfiAddressFlag",strfiAddressFlag);
			hshJsonValues.put("strfiEmploymentFlag",strfiEmploymentFlag);
			hshJsonValues.put("strfiBankStatFlag",strfiBankStatFlag);
			hshJsonValues.put("stremandateEmiFlag",stremandateEmiFlag);
			hshJsonValues.put("stremanbankacc",stremanbankacc);
			hshJsonValues.put("stremanbankname",stremanbankname);
			hshJsonValues.put("strPermAddChangeFlag",strPermAddChangeFlag);
			hshJsonValues.put("strfathername",strfathername);
			hshJsonValues.put("strstafflag",strstafflag);
			hshJsonValues.put("streduqualification",streduqualification);
			hshJsonValues.put("strItrFlag",strItrFlag);
			hshJsonValues.put("strBusinessProofFlag",strBusinessProofFlag);
			hshJsonValues.put("strOfficeAddFlag",strOfficeAddFlag);			
			hshJsonValues.put("mobileNumber",mobileNumber);
			hshJsonValues.put("customerEmail",customerEmail);
			hshJsonValues.put("strcommunity",strcommunity);
			hshJsonValues.put("strnetworthBorrower",strnetworthBorrower);
			hshJsonValues.put("strproforma",strproforma);
			hshJsonValues.put("strResidenceProof",strResidenceProof);
			hshJsonValues.put("existingFacility",arrExistFaclty);
			
			hshJsonValues.put("strincomeYearEnded",strincomeYearEnded);
			hshJsonValues.put("stritrFillingDate",stritrFillingDate);
			hshJsonValues.put("strudyogAadharNumber",strudyogAadharNumber);
			hshJsonValues.put("strgstin",strgstin);
			hshJsonValues.put("strmseRegNumber",strmseRegNumber);
			
			hshJsonValues.put("strcrifScore",strcrifScore);
			hshJsonValues.put("strcrifDetails",strcrifDetails);
			hshJsonValues.put("crifReportedDate",crifReportedDate);
			
			hshJsonValues.put("strSpouseName",strSpouseName);
			hshJsonValues.put("strMotherName",strMotherName);
			hshJsonValues.put("landHolding",arrLandHold);
			hshJsonValues.put("strComAddressLine2",strComAddressLine2);
			hshJsonValues.put("strComAddressLine3",strComAddressLine3); 
			hshJsonValues.put("strIncomeYearEndPreviousYear",strIncomeYearEndPreviousYear);
			hshJsonValues.put("itrFillDatePreviousYear",itrFillDatePreviousYear); 
			hshJsonValues.put("stritrSalaryPreviousYear",stritrSalaryPreviousYear); 
			hshJsonValues.put("strudyamRegistrationNumber",strudyamRegistrationNumber);
			hshJsonValues.put("strsalesTurnOverApplicant",strsalesTurnOverApplicant);
			hshJsonValues.put("strsalesTurnOverDate",strsalesTurnOverDate);
			hshJsonValues.put("strcriteriaforSalesTurnover",strcriteriaforSalesTurnover);
			hshJsonValues.put("strudyamRegistrationClassification",strudyamRegistrationClassification);
			hshJsonValues.put("strudyamDate",strudyamDate);
			hshJsonValues.put("strcibilDate",strcibilDate);
			
			hshValues = (HashMap) EJBInvoker.executeStateLess("DigitalAppInterface",hshJsonValues,"customerCreation");
			strNewLAPSid  = Helper.correctNull((String)hshValues.get("strNewLAPSid"));
			strResponseCode=Helper.correctNull((String)hshValues.get("strResponseCode"));
			strResponseMsg=Helper.correctNull((String)hshValues.get("strResponseMsg"));
			
			String strDedupeFlag=Helper.correctNull((String)hshValues.get("strDedupeFlag"));
			
			if(strDedupeFlag.equals("Y"))
			{
				responseData.put("LAPSCustomerID_Exist", strNewLAPSid);
			}
			else
			{
				responseData.put("LAPSCustomerID", strNewLAPSid);
			}
			
			response.setData(responseData);
			response.setResp_code(strResponseCode);
			response.setResp_msg(strResponseMsg);
			
			jsonAsString = objectMapper.writeValueAsString(response);
		}
		catch (Exception e)
		{
			response.setData(responseData);
			response.setResp_code("LAPS-2003");
			response.setResp_msg("Invalid request parameters");
			jsonAsString = objectMapper.writeValueAsString(response);
			e.printStackTrace();
			throw new EJBException("Error in inwardDetailServiceImpl customerCreation..."+e.toString());
		}
		return jsonAsString;	
	}



	//@Override
	public String proposalCreation(ProposalCreation proposalCreation)
			throws JsonProcessingException {
		// TODO Auto-generated method stub
		
		Map<String,Object> responseData = new HashMap<String,Object>();
		Response response = new Response();
		String jsonAsString = "";
		JSONObject objOuter        = new JSONObject();
		JSONObject PrintObject     = new JSONObject();
		HashMap hshValues 		   = new HashMap();
		String strApplExists="",strStatus="";
		
		String strResponseMsg="",strResponseCode="",strPANno="", strCustomerID="",strlapsID="",strloanType="",strEMIamount="",strmclrType="";
		
		String strLARno="",strAmountRequested="",strSinglePremium="",strProjectCost="",strLoanTenor="",strHolidayPeriod="",strPurposeLoan="",strApplicationBranch="";
		
		String strPartyFileno="",strLoanProduct="",strInterestType="",strInterestRate="",strPeriodicityInstallments=""
								,strGovtSponserScheme="",strTakeover="",strRepaymentType="",strProcessingFee=""
								,strWhetherSecured="",strPaymentMode="",strProposalType="",strApplicationHolder=""
								,strmisActivityCode="", strprocesssingFeeCollected = "",strsanctionStatus="",strResidualvalue="",strGSTyear1="",strGSTyear2="",strGSTyear1amnt="",strGSTyear2amnt="",
								strcommercialBureauScore="",strconsumerIndScore="",strconsumerPartyScore="",strodAccountScore="",strcurrentAccountScore="",strfsaScore="",strbandRating="",strbandPath=""
									,strkbRating="";
		
		String strdeviation="",strapplicationScore="",strappscoredeviation="",strcategoryLoanPurpose="",strpremisesAge="",strtermCond="",strcreditRiskPremium="",strbusinessStrategicPremium="",
		strInsuranceAmntFundedBy="", strInsuranceAmount="", strPremiumTenor="",strLoanAmountCovered="",strmargin="",strinterestCollected="";
		String strOperativeAccNo="",strcustomerBackgroundComments="";
		String strgovtSponserScheme="",strschemeType="",strsponsorAgency="",stragencyName="",strsubsidyAmount="",strsubsidyType="",digiNMI="",digiMaxEmi="",digiFOIR="",digiNMImultiplier="";
		String hunterScore="", hunterRuleMatch="", jocatamatch="", CFRmatch="", thickScore="",	thinScore="",deviationROI="", deviationFOIR="",	deviationLoanAmount="";
		String   strLoanFromBank="",
		  strReasonShiftBank="",
		  strLoanAmntTransferBank="",
		  strLateOfAvailing="",
		  strInstallmentTrnsBank="",
		  strInstallmentStartDate="",
		  strInstallmentLastDate="",
		  strHolidayperiod="",
		  strRepaymentPeriod="",
		  strInterestRateTakeOver="",
		  strTotalLiability="",
		  strAsOnDateLiability="",
		  strNoOfInstallmentPaid="",
		  strUptoDate="",
		  strRegularLoanAcc="",
		  strOverdueAmount="",
		  strAsOnDateOvrdue="",
		  strAmountPaidTransfer="",
		  strOpinionDetails="",
		  straccountStatementFrom="",
		  straccountStatementTo="",
		  strComments="",
		  //strtakeOver="",
		  strStallmentStipulated="",
		  strScheme="",strappraiserName="",strappraiseon="",strappraisercomments="",strappraisercbsid="",strdocRecAgri="",
		  strInstallmentPeriod="",strProdctDesc="",strPrdIdentification="",strpenalInterest="",strinterestConcession="",strudyamRegistrationNumber="",
		  strsalesTurnOverApplicant="",strsalesTurnOverDate="",strcriteriaforSalesTurnover="",strrenewType="",strrenewProposalsNo="",strDigiAppNo="",strfindigitype="",
		  strfindigiyear="",strecsBankName="",strecsAccountType="",strecsOperAccountType="",strecsAuthunenticateMode="",strecsIFSCCODE="",strupfrontfee=""
				  ,stramrtOverrideLoanAmount="",stramrtOverride="",strupfrontFeeCollected="",strmaxEligibleEMI="",strstpType="",strIntType="";
		  String strinttype="",strcfr_verified="",strCFR_borname="",strcersai_check="",strDRAWING_PWR_IND="",strGLSUBHEADCODE="",strGISTOFSECURITUES="",
		  strloanSecure="",strSANCLEVEL="",strSANCAUTH="",strrepaymentterms="",strflowdata="",strSchemecode="",strAppriasedBy="",strSanctionedBy="",strappraisaldepartment="";
				  
		   
		try
		{
			JSONObject jsonCIFReqObj		= new JSONObject(proposalCreation);

			if (!jsonCIFReqObj.isNull("larNumber"))
				strLARno    = jsonCIFReqObj.getString("larNumber");
			if (!jsonCIFReqObj.isNull("customerID"))
				strCustomerID    = jsonCIFReqObj.getString("customerID");
			if (!jsonCIFReqObj.isNull("lapsID"))
				strlapsID    = jsonCIFReqObj.getString("lapsID");
			if (!jsonCIFReqObj.isNull("loanType"))
				strloanType    = jsonCIFReqObj.getString("loanType");
			if (!jsonCIFReqObj.isNull("amountRequested"))
				strAmountRequested    = jsonCIFReqObj.getString("amountRequested");
			if (!jsonCIFReqObj.isNull("residualValue"))
				strResidualvalue    = jsonCIFReqObj.getString("residualValue");
			if (!jsonCIFReqObj.isNull("singlePremium"))
				strSinglePremium    = jsonCIFReqObj.getString("singlePremium");
			if (!jsonCIFReqObj.isNull("projectCost"))
				strProjectCost    = jsonCIFReqObj.getString("projectCost");
			if (!jsonCIFReqObj.isNull("loanTenor"))
				strLoanTenor    = jsonCIFReqObj.getString("loanTenor");
			if (!jsonCIFReqObj.isNull("holidayPeriod"))
				strHolidayPeriod    = jsonCIFReqObj.getString("holidayPeriod");
			if (!jsonCIFReqObj.isNull("loanPurpose"))
				strPurposeLoan    = jsonCIFReqObj.getString("loanPurpose");
			if (!jsonCIFReqObj.isNull("applicationBranch"))
				strApplicationBranch    = jsonCIFReqObj.getString("applicationBranch");
			if (!jsonCIFReqObj.isNull("interestRate"))
				strInterestRate    = jsonCIFReqObj.getString("interestRate");
			if (!jsonCIFReqObj.isNull("emiAmount"))
				strEMIamount    = jsonCIFReqObj.getString("emiAmount");
			if (!jsonCIFReqObj.isNull("misActivityCode"))
				strmisActivityCode    = jsonCIFReqObj.getString("misActivityCode");
			if (!jsonCIFReqObj.isNull("mclrType"))
				strmclrType    = jsonCIFReqObj.getString("mclrType");
			if (!jsonCIFReqObj.isNull("paymentMode"))
				strPaymentMode    = jsonCIFReqObj.getString("paymentMode");
			if (!jsonCIFReqObj.isNull("processingFee"))
				strProcessingFee    = jsonCIFReqObj.getString("processingFee");
			if (!jsonCIFReqObj.isNull("processsingFeeCollected"))
				strprocesssingFeeCollected    = jsonCIFReqObj.getString("processsingFeeCollected");
			
			if (!jsonCIFReqObj.isNull("deviation"))
				strdeviation   = jsonCIFReqObj.getString("deviation");
			if (!jsonCIFReqObj.isNull("applicationScore"))
				strapplicationScore    = jsonCIFReqObj.getString("applicationScore");
			if (!jsonCIFReqObj.isNull("applicationScore"))
				strapplicationScore    = jsonCIFReqObj.getString("applicationScore");
			if (!jsonCIFReqObj.isNull("appScoreDeviation"))
				strappscoredeviation    = jsonCIFReqObj.getString("appScoreDeviation"); 
			if (!jsonCIFReqObj.isNull("sanctionStatus"))
				strsanctionStatus    = jsonCIFReqObj.getString("sanctionStatus");
			if (!jsonCIFReqObj.isNull("categoryLoanPurpose"))
				strcategoryLoanPurpose    = jsonCIFReqObj.getString("categoryLoanPurpose");
			if (!jsonCIFReqObj.isNull("premisesAge"))
				strpremisesAge    = jsonCIFReqObj.getString("premisesAge");
			if (!jsonCIFReqObj.isNull("termAndCondition"))
				strtermCond    = jsonCIFReqObj.getString("termAndCondition");
			
			if (!jsonCIFReqObj.isNull("creditRiskPremium"))
				strcreditRiskPremium    = jsonCIFReqObj.getString("creditRiskPremium");
			if (!jsonCIFReqObj.isNull("businessStrategicPremium"))
				strbusinessStrategicPremium    = jsonCIFReqObj.getString("businessStrategicPremium");
			if (!jsonCIFReqObj.isNull("operativeAccountNo"))
				strOperativeAccNo    = jsonCIFReqObj.getString("operativeAccountNo");
			

			 
			if (!jsonCIFReqObj.isNull("insuranceAmntFundedBy"))
				strInsuranceAmntFundedBy    = jsonCIFReqObj.getString("insuranceAmntFundedBy");
			if (!jsonCIFReqObj.isNull("insuranceAmount"))
				strInsuranceAmount    = jsonCIFReqObj.getString("insuranceAmount");
			if (!jsonCIFReqObj.isNull("premiumTenor"))
				strPremiumTenor    = jsonCIFReqObj.getString("premiumTenor");
			if (!jsonCIFReqObj.isNull("loanAmountCovered"))
				strLoanAmountCovered    = jsonCIFReqObj.getString("loanAmountCovered");
			if (!jsonCIFReqObj.isNull("margin"))
				strmargin    = jsonCIFReqObj.getString("margin");
			
			
			if (!jsonCIFReqObj.isNull("interestCollected"))
				strinterestCollected   = jsonCIFReqObj.getString("interestCollected");
			//------------------------------------------new object ---------------------------------//
			
			if (!jsonCIFReqObj.isNull("inttype"))
				strinttype   = jsonCIFReqObj.getString("inttype");
			if (!jsonCIFReqObj.isNull("cfr_verified"))
				strcfr_verified   = jsonCIFReqObj.getString("cfr_verified");
			if (!jsonCIFReqObj.isNull("CFR_borname"))
				strCFR_borname   = jsonCIFReqObj.getString("CFR_borname");
			if (!jsonCIFReqObj.isNull("cersai_check"))
				strcersai_check   = jsonCIFReqObj.getString("cersai_check");
			if (!jsonCIFReqObj.isNull("DRAWING_PWR_IND"))
				strDRAWING_PWR_IND   = jsonCIFReqObj.getString("DRAWING_PWR_IND");
			if (!jsonCIFReqObj.isNull("GLSUBHEADCODE"))
				strGLSUBHEADCODE   = jsonCIFReqObj.getString("GLSUBHEADCODE");
			if (!jsonCIFReqObj.isNull("GISTOFSECURITUES"))
				strGISTOFSECURITUES   = jsonCIFReqObj.getString("GISTOFSECURITUES");
			if (!jsonCIFReqObj.isNull("loanSecure"))
				strloanSecure   = jsonCIFReqObj.getString("loanSecure");
			if (!jsonCIFReqObj.isNull("SANCLEVEL"))
				strSANCLEVEL   = jsonCIFReqObj.getString("SANCLEVEL");
			if (!jsonCIFReqObj.isNull("SANCAUTH"))
				strSANCAUTH   = jsonCIFReqObj.getString("SANCAUTH");
			if (!jsonCIFReqObj.isNull("repaymentterms"))
				strrepaymentterms   = jsonCIFReqObj.getString("repaymentterms");
			if (!jsonCIFReqObj.isNull("schemecode"))
				strSchemecode   = jsonCIFReqObj.getString("schemecode");
			if(!jsonCIFReqObj.isNull("sanctionedBy"))
				strSanctionedBy = jsonCIFReqObj.getString("sanctionedBy");
			if(!jsonCIFReqObj.isNull("appriasedBy"))
				strAppriasedBy = jsonCIFReqObj.getString("appriasedBy");
			if(!jsonCIFReqObj.isNull("flowdata"))
				strflowdata =jsonCIFReqObj.getString("flowdata");
			if(!jsonCIFReqObj.isNull("appraisaldepartment"))
				strappraisaldepartment = jsonCIFReqObj.getString("appraisaldepartment");
			

			JSONArray jsonCoAppplicant		= new JSONArray();
 
			if (!jsonCIFReqObj.isNull("coApplicant"))
				jsonCoAppplicant=jsonCIFReqObj.getJSONArray("coApplicant");
			
			if (!jsonCIFReqObj.isNull("customerBackgroundComments"))
				strcustomerBackgroundComments   = jsonCIFReqObj.getString("customerBackgroundComments");

			if (!jsonCIFReqObj.isNull("govtSponserScheme"))
				strgovtSponserScheme  = jsonCIFReqObj.getString("govtSponserScheme");
			if (!jsonCIFReqObj.isNull("schemeType"))
				strschemeType  = jsonCIFReqObj.getString("schemeType");
			if (!jsonCIFReqObj.isNull("sponsorAgency"))
				strsponsorAgency  = jsonCIFReqObj.getString("sponsorAgency");
			if (!jsonCIFReqObj.isNull("agencyName"))
				stragencyName  = jsonCIFReqObj.getString("agencyName");
			if (!jsonCIFReqObj.isNull("subsidyAmount"))
				strsubsidyAmount  = jsonCIFReqObj.getString("subsidyAmount");
			if (!jsonCIFReqObj.isNull("subsidyType"))
				strsubsidyType  = jsonCIFReqObj.getString("subsidyType");
			
			if (!jsonCIFReqObj.isNull("hunterScore"))
				hunterScore  = jsonCIFReqObj.getString("hunterScore");
			if (!jsonCIFReqObj.isNull("hunterRuleMatch"))
				hunterRuleMatch  = jsonCIFReqObj.getString("hunterRuleMatch");
			if (!jsonCIFReqObj.isNull("jocatamatch"))
				jocatamatch  = jsonCIFReqObj.getString("jocatamatch");
			if (!jsonCIFReqObj.isNull("cfrMatch"))
				CFRmatch  = jsonCIFReqObj.getString("cfrMatch");
			if (!jsonCIFReqObj.isNull("thickScore"))
				thickScore  = jsonCIFReqObj.getString("thickScore");
			if (!jsonCIFReqObj.isNull("thinScore"))
				thinScore  = jsonCIFReqObj.getString("thinScore");
			if (!jsonCIFReqObj.isNull("deviationROI"))
				deviationROI  = jsonCIFReqObj.getString("deviationROI");
			if (!jsonCIFReqObj.isNull("deviationFOIR"))
				deviationFOIR  = jsonCIFReqObj.getString("deviationFOIR");
			if (!jsonCIFReqObj.isNull("deviationLoanAmount"))
				deviationLoanAmount  = jsonCIFReqObj.getString("deviationLoanAmount");
			if (!jsonCIFReqObj.isNull("digiNMI"))
				digiNMI  = jsonCIFReqObj.getString("digiNMI");
			if (!jsonCIFReqObj.isNull("digiMaxEmi"))
				digiMaxEmi  = jsonCIFReqObj.getString("digiMaxEmi");
			
			if (!jsonCIFReqObj.isNull("digiFOIR"))
				digiFOIR  = jsonCIFReqObj.getString("digiFOIR");
			if (!jsonCIFReqObj.isNull("digiNMImultiplier"))
				digiNMImultiplier  = jsonCIFReqObj.getString("digiNMImultiplier");			
			
			
			if (!jsonCIFReqObj.isNull("loanFromBank"))
				strLoanFromBank    = jsonCIFReqObj.getString("loanFromBank");
			
			if (!jsonCIFReqObj.isNull("reasonShiftBank"))
				strReasonShiftBank    = jsonCIFReqObj.getString("reasonShiftBank");
			if (!jsonCIFReqObj.isNull("loanAmntTransferBank"))
				strLoanAmntTransferBank    = jsonCIFReqObj.getString("loanAmntTransferBank");
			
			if (!jsonCIFReqObj.isNull("dateOfAvailing"))
				strLateOfAvailing    = jsonCIFReqObj.getString("dateOfAvailing");
			
			if (!jsonCIFReqObj.isNull("installmentTrnsBank"))
				strInstallmentTrnsBank    = jsonCIFReqObj.getString("installmentTrnsBank");
			
			if (!jsonCIFReqObj.isNull("installmentStartDate"))
				strInstallmentStartDate    = jsonCIFReqObj.getString("installmentStartDate");
			
			if (!jsonCIFReqObj.isNull("installmentLastDate"))
				strInstallmentLastDate    = jsonCIFReqObj.getString("installmentLastDate");
			
			if (!jsonCIFReqObj.isNull("holidayperiod"))
				strHolidayperiod    = jsonCIFReqObj.getString("holidayperiod");
			
			if (!jsonCIFReqObj.isNull("repaymentPeriod"))
				strRepaymentPeriod    = jsonCIFReqObj.getString("repaymentPeriod");
			
			if (!jsonCIFReqObj.isNull("interestRateTakeOver"))
				strInterestRateTakeOver    = jsonCIFReqObj.getString("interestRateTakeOver");
			
			if (!jsonCIFReqObj.isNull("totalLiability"))
				strTotalLiability    = jsonCIFReqObj.getString("totalLiability");
			
			if (!jsonCIFReqObj.isNull("asOnDateLiability"))
				strAsOnDateLiability    = jsonCIFReqObj.getString("asOnDateLiability");
			
			if (!jsonCIFReqObj.isNull("noOfInstallmentPaid"))
				strNoOfInstallmentPaid    = jsonCIFReqObj.getString("noOfInstallmentPaid");
			
			if (!jsonCIFReqObj.isNull("uptoDate"))
				strUptoDate    = jsonCIFReqObj.getString("uptoDate");
			
			if (!jsonCIFReqObj.isNull("regularLoanAcc"))
				strRegularLoanAcc    = jsonCIFReqObj.getString("regularLoanAcc");
			
			if (!jsonCIFReqObj.isNull("overdueAmount"))
				strOverdueAmount    = jsonCIFReqObj.getString("overdueAmount");
			
			if (!jsonCIFReqObj.isNull("asOnDateOvrdue"))
				strAsOnDateOvrdue    = jsonCIFReqObj.getString("asOnDateOvrdue");
			
			if (!jsonCIFReqObj.isNull("amountPaidTransfer"))
				strAmountPaidTransfer    = jsonCIFReqObj.getString("amountPaidTransfer");
			
			if (!jsonCIFReqObj.isNull("opinionDetails"))
				strOpinionDetails    = jsonCIFReqObj.getString("opinionDetails");
			
			if (!jsonCIFReqObj.isNull("accountStatementFrom"))
				straccountStatementFrom    = jsonCIFReqObj.getString("accountStatementFrom");
			if (!jsonCIFReqObj.isNull("accountStatementTo"))
				straccountStatementTo   = jsonCIFReqObj.getString("accountStatementTo");
			
			if (!jsonCIFReqObj.isNull("comments"))
				strComments    = jsonCIFReqObj.getString("comments");
			
			if (!jsonCIFReqObj.isNull("takeOver"))
				strTakeover    = jsonCIFReqObj.getString("takeOver");
			
			if (!jsonCIFReqObj.isNull("stallmentStipulated"))
				strStallmentStipulated    = jsonCIFReqObj.getString("stallmentStipulated");
			
			if (!jsonCIFReqObj.isNull("repaymentType"))
				strRepaymentType    = jsonCIFReqObj.getString("repaymentType");
			
			if (!jsonCIFReqObj.isNull("scheme"))
				strScheme    = jsonCIFReqObj.getString("scheme");
			
			if (!jsonCIFReqObj.isNull("installmentPeriodicity"))
				strInstallmentPeriod   = jsonCIFReqObj.getString("installmentPeriodicity");
			
			if (!jsonCIFReqObj.isNull("productDesc"))
				strProdctDesc   = jsonCIFReqObj.getString("productDesc");
			
			if (!jsonCIFReqObj.isNull("productIdentification"))
				strPrdIdentification   = jsonCIFReqObj.getString("productIdentification");
			
			if (!jsonCIFReqObj.isNull("gstyear1"))
				strGSTyear1    = jsonCIFReqObj.getString("gstyear1");
			
			if (!jsonCIFReqObj.isNull("gstyear1amnt"))
				strGSTyear1amnt    = jsonCIFReqObj.getString("gstyear1amnt");
			
			if (!jsonCIFReqObj.isNull("gstyear2"))
				strGSTyear2    = jsonCIFReqObj.getString("gstyear2");
			
			if (!jsonCIFReqObj.isNull("gstyear2amnt"))
				strGSTyear2amnt    = jsonCIFReqObj.getString("gstyear2amnt");
			
			if (!jsonCIFReqObj.isNull("commercialBureauScore"))
				strcommercialBureauScore    = jsonCIFReqObj.getString("commercialBureauScore");
			
			if (!jsonCIFReqObj.isNull("consumerIndScore"))
				strconsumerIndScore    = jsonCIFReqObj.getString("consumerIndScore");
			
			if (!jsonCIFReqObj.isNull("consumerPartyScore"))
				strconsumerPartyScore   = jsonCIFReqObj.getString("consumerPartyScore");
			
			if (!jsonCIFReqObj.isNull("odAccountScore"))
				strodAccountScore   = jsonCIFReqObj.getString("odAccountScore");
			
			if (!jsonCIFReqObj.isNull("currentAccountScore"))
				strcurrentAccountScore   = jsonCIFReqObj.getString("currentAccountScore");
			
			if (!jsonCIFReqObj.isNull("fsaScore"))
				strfsaScore    = jsonCIFReqObj.getString("fsaScore");
			
			if (!jsonCIFReqObj.isNull("bandRating"))
				strbandRating    = jsonCIFReqObj.getString("bandRating");
			
			if (!jsonCIFReqObj.isNull("bandPath"))
				strbandPath    = jsonCIFReqObj.getString("bandPath");
			
			if (!jsonCIFReqObj.isNull("kbRating"))
				strkbRating    = jsonCIFReqObj.getString("kbRating");
			
			if(!jsonCIFReqObj.isNull("penalInterest"))
				strpenalInterest = jsonCIFReqObj.getString("penalInterest");
			
			if(!jsonCIFReqObj.isNull("interestConcession"))
				strinterestConcession = jsonCIFReqObj.getString("interestConcession");
			
			if (!jsonCIFReqObj.isNull("udyamRegistrationNumber"))
				strudyamRegistrationNumber    = jsonCIFReqObj.getString("udyamRegistrationNumber");
			
			if (!jsonCIFReqObj.isNull("salesTurnOverApplicant"))
				strsalesTurnOverApplicant    = jsonCIFReqObj.getString("salesTurnOverApplicant");
			
			if (!jsonCIFReqObj.isNull("salesTurnOverDate"))
				strsalesTurnOverDate    = jsonCIFReqObj.getString("salesTurnOverDate");
			
			if (!jsonCIFReqObj.isNull("criteriaforSalesTurnover"))
				strcriteriaforSalesTurnover    = jsonCIFReqObj.getString("criteriaforSalesTurnover");
			
			if (!jsonCIFReqObj.isNull("renewType"))
				strrenewType    = jsonCIFReqObj.getString("renewType");
			
			if (!jsonCIFReqObj.isNull("renewProposalsNo"))
				strrenewProposalsNo    = jsonCIFReqObj.getString("renewProposalsNo");
			
			if (!jsonCIFReqObj.isNull("digiAppNo"))
				strDigiAppNo    = jsonCIFReqObj.getString("digiAppNo");
			
			if (!jsonCIFReqObj.isNull("findigitype"))
				strfindigitype    = jsonCIFReqObj.getString("findigitype");
			
			if (!jsonCIFReqObj.isNull("findigiyear"))
				strfindigiyear    = jsonCIFReqObj.getString("findigiyear");
				
			if (!jsonCIFReqObj.isNull("ecsBankName"))
				strecsBankName    = jsonCIFReqObj.getString("ecsBankName");
			
			if (!jsonCIFReqObj.isNull("ecsAccountType"))
				strecsAccountType    = jsonCIFReqObj.getString("ecsAccountType");
			
			if (!jsonCIFReqObj.isNull("ecsOperAccountType"))
				strecsOperAccountType   = jsonCIFReqObj.getString("ecsOperAccountType");
			
			if (!jsonCIFReqObj.isNull("ecsAuthunenticateMode"))
				strecsAuthunenticateMode    = jsonCIFReqObj.getString("ecsAuthunenticateMode");
			
			if (!jsonCIFReqObj.isNull("ecsIFSCCODE"))
				strecsIFSCCODE   = jsonCIFReqObj.getString("ecsIFSCCODE");
			
			
			if (!jsonCIFReqObj.isNull("upfrontfee"))
				strupfrontfee   = jsonCIFReqObj.getString("upfrontfee");
			
			if (!jsonCIFReqObj.isNull("docRecAgri"))
				strdocRecAgri  = jsonCIFReqObj.getString("docRecAgri");
			if (!jsonCIFReqObj.isNull("appraiserName"))
				strappraiserName  = jsonCIFReqObj.getString("appraiserName");
			if (!jsonCIFReqObj.isNull("appraiseon"))
				strappraiseon  = jsonCIFReqObj.getString("appraiseon");
			if (!jsonCIFReqObj.isNull("appraisercomments"))
				strappraisercomments  = jsonCIFReqObj.getString("appraisercomments");
			if (!jsonCIFReqObj.isNull("appraisercbsid"))
				strappraisercbsid  = jsonCIFReqObj.getString("appraisercbsid");
			if (!jsonCIFReqObj.isNull("amrtOverrideLoanAmount"))
				stramrtOverrideLoanAmount  = jsonCIFReqObj.getString("amrtOverrideLoanAmount");
			
			if (!jsonCIFReqObj.isNull("amrtOverride"))
				stramrtOverride  = jsonCIFReqObj.getString("amrtOverride");
			
			if (!jsonCIFReqObj.isNull("upfrontFeeCollected"))
				strupfrontFeeCollected  = jsonCIFReqObj.getString("upfrontFeeCollected");
			
			if (!jsonCIFReqObj.isNull("maxEligibleEMI"))
				strmaxEligibleEMI  = jsonCIFReqObj.getString("maxEligibleEMI");
			
			if (!jsonCIFReqObj.isNull("stpType"))
				strstpType  = jsonCIFReqObj.getString("stpType");
			

			
			JSONObject jsonCoapp= new JSONObject();
			
			int coappsize=jsonCoAppplicant.length();
			ArrayList arrcoapp=new ArrayList();
			ArrayList arrcoappvalues=new ArrayList();
			if(coappsize>0)
			{
				for(int i=0;i<coappsize;i++)
				{
					jsonCoapp=(JSONObject) jsonCoAppplicant.get(i);
					
					String coappName=jsonCoapp.getString("coapplicantName");
					String coappType=jsonCoapp.getString("coapplicantType");
					String coappLAPSID=jsonCoapp.getString("coapplicantLAPSID");
					String coappCBSID=jsonCoapp.getString("coapplicantCBSID");
					String coappRelation=jsonCoapp.getString("coapplicantRelation");
					String coappIncome=jsonCoapp.getString("coaplicantIncome");
					
					arrcoappvalues=new ArrayList();
					arrcoappvalues.add(coappName);
					arrcoappvalues.add(coappType);
					arrcoappvalues.add(coappLAPSID);
					arrcoappvalues.add(coappCBSID);
					arrcoappvalues.add(coappRelation);
					arrcoappvalues.add(coappIncome);
					arrcoapp.add(arrcoappvalues);
				}
			}
			
			
			//For DocumentDetails
			JSONArray jsonArrDocumentDetails	= new JSONArray();
			if (!jsonCIFReqObj.isNull("documentDetails"))
				jsonArrDocumentDetails=jsonCIFReqObj.getJSONArray("documentDetails");
			
			JSONObject jsonObjDocDetail= new JSONObject();
			
			int docDetailsize=jsonArrDocumentDetails.length();
			ArrayList arrdocDetail = new ArrayList();
			ArrayList arrdocDetailvalues = new ArrayList();
			if(docDetailsize>0)
			{
				for(int i=0;i<docDetailsize;i++)
				{
					jsonObjDocDetail=(JSONObject) jsonArrDocumentDetails.get(i);
					
					String strDocumentId = jsonObjDocDetail.getString("documentId");
					String strDocumentCode=jsonObjDocDetail.getString("documentCode");
					String strReferenceNumber=jsonObjDocDetail.getString("referenceNumber");
					
					
					arrdocDetailvalues=new ArrayList();
					arrdocDetailvalues.add(strDocumentId);
					arrdocDetailvalues.add(strDocumentCode);
					arrdocDetailvalues.add(strReferenceNumber);
					
					arrdocDetail.add(arrdocDetailvalues);
				}
			}
			
			JSONArray jsonDeviationDetails 	= new JSONArray();
			if (!jsonCIFReqObj.isNull("deviationDetails"))
				jsonDeviationDetails=jsonCIFReqObj.getJSONArray("deviationDetails");
			
			
			JSONObject jsondevdet= new JSONObject();
			
			int devdet=jsonDeviationDetails.length();
			ArrayList arrdevdet=new ArrayList();
			ArrayList arrdevdetvalues=new ArrayList();
			if(devdet>0)
			{
				for(int i=0;i<devdet;i++)
				{
					jsondevdet=(JSONObject) jsonDeviationDetails.get(i);
					
					arrdevdetvalues=new ArrayList();
					arrdevdetvalues.add("");
					arrdevdetvalues.add(Helper.correctNull(jsondevdet.getString("applicantLapsid")));
					arrdevdetvalues.add("");
					arrdevdetvalues.add("");
					arrdevdetvalues.add("");
					arrdevdetvalues.add("");
					arrdevdetvalues.add("");
					
					JSONArray arramberRules=new JSONArray();
					String ambertemp="";
					
					if (!jsondevdet.isNull("amberRules"))
						arramberRules = jsondevdet.getJSONArray("amberRules");
					
					int amberlength=arramberRules.length();
					if(amberlength>0) 
					{
						for(int j=0;j<amberlength;j++)
						{
							String temp1= arramberRules.getString(j);
							ambertemp=ambertemp+"@"+temp1;
						}
					}
					arrdevdetvalues.add(ambertemp); //7
					arrdevdetvalues.add(Helper.correctNull(jsondevdet.getString("hunterScore"))); //8
					arrdevdetvalues.add(Helper.correctNull(jsondevdet.getString("hunterRuleMatch"))); //9
					arrdevdetvalues.add(Helper.correctNull(jsondevdet.getString("jocatamatch"))); //10
					arrdevdetvalues.add(Helper.correctNull(jsondevdet.getString("thickScore"))); //11
					arrdevdetvalues.add(Helper.correctNull(jsondevdet.getString("thinScore"))); //12
					arrdevdetvalues.add(Helper.correctNull(jsondevdet.getString("cfrMatch"))); //13
					
					arrdevdet.add(arrdevdetvalues);
					
				}
			}

			
			JSONArray jsonRepaymentSchedule=new JSONArray();

			if (!jsonCIFReqObj.isNull("repaymentSchedule"))
				jsonRepaymentSchedule=jsonCIFReqObj.getJSONArray("repaymentSchedule");
			
			JSONObject jsonRepaySchedule= new JSONObject();
			int repaysize=jsonRepaymentSchedule.length();
			ArrayList arrRepayment=new ArrayList();
			ArrayList arrRepaymentValues=new ArrayList();
			if(repaysize>0)
			{
				for(int i=0;i<repaysize;i++)
				{
					jsonRepaySchedule=(JSONObject) jsonRepaymentSchedule.get(i);
					
					String frequency=jsonRepaySchedule.getString("frequency");
					String installAmount=jsonRepaySchedule.getString("installmentAmount");
					String noInstall=jsonRepaySchedule.getString("noInstallment");
					String totalAmnt=jsonRepaySchedule.getString("totalAmount");
					
					
					arrRepaymentValues=new ArrayList();
					arrRepaymentValues.add(frequency);
					arrRepaymentValues.add(installAmount);
					arrRepaymentValues.add(noInstall);
					arrRepaymentValues.add(totalAmnt);
					
					arrRepayment.add(arrRepaymentValues);
				}
			}
			
			// goldOrnaments 
			JSONArray goldOrnaments = new JSONArray();
			if (!jsonCIFReqObj.isNull("goldOrnaments"))
				goldOrnaments=jsonCIFReqObj.getJSONArray("goldOrnaments");
			
			JSONObject jsongoldOrnaments= new JSONObject();
			int intgoldOrnaments=goldOrnaments.length();
			ArrayList arrgoldOrnaments=new ArrayList();
			ArrayList arrgoldOrnamentsValues=new ArrayList();
			if(intgoldOrnaments>0)
			{
				for(int i=0;i<intgoldOrnaments;i++)
				{
					jsongoldOrnaments=(JSONObject) goldOrnaments.get(i);
						
					String articleType=jsongoldOrnaments.getString("articleType");
					String grossWeight=jsongoldOrnaments.getString("grossWeight");
					String netWeight=jsongoldOrnaments.getString("netWeight");
					String purity=jsongoldOrnaments.getString("purity");
					String lastMarkertRate=jsongoldOrnaments.getString("lastMarkertRate");
					String closingGoldRate=jsongoldOrnaments.getString("closingGoldRate");
					String estimatedValue=jsongoldOrnaments.getString("estimatedValue");
					String quantity=jsongoldOrnaments.getString("quantity");
					String netValue=jsongoldOrnaments.getString("netValue");
					String articleTypeGO=jsongoldOrnaments.getString("articleTypeGO");
					
					
					
					arrgoldOrnamentsValues=new ArrayList();
					arrgoldOrnamentsValues.add(articleType);
					arrgoldOrnamentsValues.add(grossWeight);
					arrgoldOrnamentsValues.add(netWeight);
					arrgoldOrnamentsValues.add(purity);
					arrgoldOrnamentsValues.add(lastMarkertRate);
					arrgoldOrnamentsValues.add(closingGoldRate);
					arrgoldOrnamentsValues.add(estimatedValue);
					arrgoldOrnamentsValues.add(quantity);
					arrgoldOrnamentsValues.add(netValue);
					arrgoldOrnamentsValues.add(articleTypeGO);
					
					arrgoldOrnaments.add(arrgoldOrnamentsValues);
				}
			}
			
			JSONArray termsAndCondition = new JSONArray();
			if (!jsonCIFReqObj.isNull("termsAndCondition"))
				termsAndCondition=jsonCIFReqObj.getJSONArray("termsAndCondition");
			
			int inttermsAndCondition=termsAndCondition.length();
			ArrayList arrtermsAndCondition=new ArrayList();
			ArrayList arrtermsAndConditionValues=new ArrayList();
			if(inttermsAndCondition>0)
			{
				for(int i=0;i<inttermsAndCondition;i++)
				{
					String jsontermsAndCondition=termsAndCondition.getString(i);
					arrtermsAndConditionValues=new ArrayList();
					arrtermsAndConditionValues.add(jsontermsAndCondition);
					arrtermsAndCondition.add(arrtermsAndConditionValues);
				}
			}
			
			
			JSONArray depositdet = new JSONArray();
			if (!jsonCIFReqObj.isNull("depositdetails"))
			{
				depositdet=jsonCIFReqObj.getJSONArray("depositdetails");
			}
			JSONObject jsondepost= new JSONObject();
			int intdepdet=depositdet.length();
			ArrayList arrdepositdetails=new ArrayList();
			ArrayList arrdepositdetailsval=new ArrayList();
			if(intdepdet>0)
			{
				for(int i=0;i<intdepdet;i++)
				{
					jsondepost=(JSONObject) depositdet.get(i);
						
					arrdepositdetailsval=new ArrayList();
					arrdepositdetailsval.add(jsondepost.getString("issuebranch"));
					arrdepositdetailsval.add(jsondepost.getString("standname"));
					arrdepositdetailsval.add(jsondepost.getString("accno"));
					arrdepositdetailsval.add(jsondepost.getString("dateofissue"));
					arrdepositdetailsval.add(jsondepost.getString("faceval"));
					arrdepositdetailsval.add(jsondepost.getString("rateofint"));
					arrdepositdetailsval.add(jsondepost.getString("presentos"));
					arrdepositdetailsval.add(jsondepost.getString("presentason"));
					arrdepositdetailsval.add(jsondepost.getString("maturityval"));
					arrdepositdetailsval.add(jsondepost.getString("tenure"));
					arrdepositdetailsval.add(jsondepost.getString("matdate"));
					arrdepositdetailsval.add(jsondepost.getString("rateincharges"));
					arrdepositdetailsval.add(jsondepost.getString("margin"));
					arrdepositdetailsval.add(jsondepost.getString("banktype"));
					arrdepositdetailsval.add(jsondepost.getString("secid"));
					arrdepositdetailsval.add(jsondepost.getString("loan_updflag"));
					arrdepositdetailsval.add(jsondepost.getString("loan_entryflag"));
					
					arrdepositdetails.add(arrdepositdetailsval);
				}
			}



			
			
			if(strLARno.equalsIgnoreCase("") || strlapsID.equalsIgnoreCase(""))
			{
				return Constants.ERROR_RESPONSE_MANDATORY;
			}
			if(strPaymentMode.equalsIgnoreCase("C"))
			{
				if(strecsBankName.equalsIgnoreCase("")||strecsAccountType.equalsIgnoreCase("")||strecsOperAccountType.equalsIgnoreCase("")
						||strecsAuthunenticateMode.equalsIgnoreCase("")||strecsIFSCCODE.equalsIgnoreCase(""))
				{
					return Constants.ERROR_RESPONSE_MANDATORY;
				}
			}
			
			//default values
			//strInterestRate="";
			/*if(strRepaymentType.equals("1"))
				strPeriodicityInstallments="m";
			else
				strPeriodicityInstallments="y";*/

			//strGovtSponserScheme="2";
			//strTakeover="N";
			strWhetherSecured="";
			strProposalType="F";
			strApplicationHolder="";	
			
			ResultSet rs=null,rs1=null;
			String strQuery="";
			//party file no
			strQuery=SQLParser.getSqlQuery("sel_partyfileno_ETB^"+strlapsID);
			if(rs!=null)
			{ rs.close(); }
			rs=DBUtils.executeQuery(strQuery);	
			if(rs.next())
			{
				strPartyFileno=Helper.correctNull((String) rs.getString("LOAN_FILENO"));
			}
			else
			{
				String strOrgShortCode=strApplicationBranch;
				int intLen=0;
				long longAppno=0;
				strOrgShortCode = strOrgShortCode.trim();
				int scodeLength=strOrgShortCode.length();
				java.text.NumberFormat nf=java.text.NumberFormat.getNumberInstance();
				nf.setMinimumIntegerDigits(7);
				nf.setGroupingUsed(false);
				
				if(scodeLength==1){
					strOrgShortCode="000"+strOrgShortCode;
				}
				if(scodeLength==2){
					strOrgShortCode="00"+strOrgShortCode;
				}
				if(scodeLength==3){
					strOrgShortCode="0"+strOrgShortCode;
				}
				
				intLen=strOrgShortCode.length();
				if(rs!=null)
				{	rs.close(); 	}
				strQuery=SQLParser.getSqlQuery("sel_getMaxPartyFileno^"+(intLen+1)+"^"+intLen+"^"+strOrgShortCode);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					longAppno=(rs.getLong(1));
				}
				longAppno++;
				strPartyFileno=strOrgShortCode+nf.format(longAppno);
			}
			
			//Reatail Digi Rating for PB
			

			
			if(strbandRating.equalsIgnoreCase("Band 1")||strbandRating.equalsIgnoreCase("Band1")||
					strbandRating.equalsIgnoreCase("Band 2")||strbandRating.equalsIgnoreCase("Band2"))
					strkbRating="KB1";		
					
					if(strbandRating.equalsIgnoreCase("Band 3")||strbandRating.equalsIgnoreCase("Band3"))
						strkbRating="KB2";
					
					if(strbandRating.equalsIgnoreCase("Band 4")||strbandRating.equalsIgnoreCase("Band4")||
						strbandRating.equalsIgnoreCase("Band 5")||strbandRating.equalsIgnoreCase("Band5"))
						strkbRating="KB3";
					
					if(strbandRating.equalsIgnoreCase("Band 6")||strbandRating.equalsIgnoreCase("Band6")||
						strbandRating.equalsIgnoreCase("Band 7")||strbandRating.equalsIgnoreCase("Band7"))
						strkbRating="KB4";
					
					if(strbandRating.equalsIgnoreCase("Band 8")||strbandRating.equalsIgnoreCase("Band8"))
						strkbRating="KB5";
					
					if(strbandRating.equalsIgnoreCase("Band 9")||strbandRating.equalsIgnoreCase("Band9"))
						strkbRating="KB7";

					
			// loan Product
			if(rs!=null)
			{ rs.close(); }
			String strProductType="";
			if(strloanType.equals("PL"))
			{	
				strProductType="pC";
				strInterestType="1";
				
				if(strPrdIdentification.equals(""))
				{
				
				strQuery=SQLParser.getSqlQuery("sel_digiproduct_code_pl^"+strProductType);
				rs=DBUtils.executeQuery(strQuery);	
				if(rs.next())
				{
					strLoanProduct=Helper.correctNull((String)rs.getString("PRD_CODE"));
				}
				}else{
					
					strQuery=SQLParser.getSqlQuery("sel_digiprd_code_pl_identification^"+strProductType+"^"+strPrdIdentification);
					rs=DBUtils.executeQuery(strQuery);	
					if(rs.next())
					{
						strLoanProduct=Helper.correctNull((String)rs.getString("PRD_CODE"));
					}
					
				}
			}
			else if(strloanType.equals("HL"))
			{
				strProductType="pH";
				strInterestType="2";
				if(strcategoryLoanPurpose.equals("HC"))
				{
					strInterestType="1";	
				}
				if(strPrdIdentification.equals(""))
				{
				strQuery=SQLParser.getSqlQuery("sel_digiproduct_code^"+strProductType+"^"+strcategoryLoanPurpose+"^"+strAmountRequested+"^"+strRepaymentType);
				rs=DBUtils.executeQuery(strQuery);	
				if(rs.next())
				{
					strLoanProduct=Helper.correctNull((String)rs.getString("PRD_CODE"));
				}
				}
				else{
					
					strQuery=SQLParser.getSqlQuery("sel_digiprd_code_identification^"+strProductType+"^"+strcategoryLoanPurpose+"^"+strAmountRequested+"^"+strRepaymentType+"^"+strPrdIdentification);
					rs=DBUtils.executeQuery(strQuery);	
					if(rs.next())
					{
						strLoanProduct=Helper.correctNull((String)rs.getString("PRD_CODE"));
					}
				}
			
			}
			else if(strloanType.equals("PB"))
			{	
				if(strrenewType.equalsIgnoreCase("2"))
				{
					if(strrenewProposalsNo.equalsIgnoreCase(""))
					{
						return Constants.ERROR_RESPONSE_MANDATORY;
					}
				}
				
				if (rs != null) {
					rs.close();
				}
				if(!strrenewProposalsNo.equalsIgnoreCase("") && strrenewType.equalsIgnoreCase("2"))
				{
				strQuery = SQLParser.getSqlQuery("applications_select^"+strrenewProposalsNo);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					String strrenew  = Helper.correctNull((String)rs.getString("app_renew_status"));
					if(!strrenew.equalsIgnoreCase("")){
						return Constants.DigiRenew_proposalblock;
					}

				}
				}
				
				strProductType="pB";
				strInterestType="2";
				if(strPrdIdentification.equals(""))
					{
					strQuery=SQLParser.getSqlQuery("sel_digiproduct_code_PB^"+strProductType+"^"+strAmountRequested+"^"+strRepaymentType);
					rs=DBUtils.executeQuery(strQuery);	
					if(rs.next())
					{
						strLoanProduct=Helper.correctNull((String)rs.getString("PRD_CODE"));
					}
				}else{
					
					strQuery=SQLParser.getSqlQuery("sel_digiprd_code_identification_PB^"+strProductType+"^"+strAmountRequested+"^"+strRepaymentType+"^"+strPrdIdentification);
					rs=DBUtils.executeQuery(strQuery);	
					if(rs.next())
					{
						strLoanProduct=Helper.correctNull((String)rs.getString("PRD_CODE"));
					}
				}
			}else if(strloanType.equals("PM"))
			{
				strProductType="pM";
				strInterestType="2";
				if(strPrdIdentification.equals(""))
				{
				strQuery=SQLParser.getSqlQuery("sel_digiproduct_code_PM^"+strProductType+"^"+strAmountRequested+"^"+strRepaymentType);
				rs=DBUtils.executeQuery(strQuery);	
				if(rs.next())
				{
					strLoanProduct=Helper.correctNull((String)rs.getString("PRD_CODE"));
				}
				}
				else{
					
					strQuery=SQLParser.getSqlQuery("sel_digiprd_code_identification_PB^"+strProductType+"^"+strcategoryLoanPurpose+"^"+strAmountRequested+"^"+strRepaymentType+"^"+strPrdIdentification);
					rs=DBUtils.executeQuery(strQuery);	
					if(rs.next())
					{
						strLoanProduct=Helper.correctNull((String)rs.getString("PRD_CODE"));
					}
				}
			
			}else if(strloanType.equals("PJ"))
			{
				strProductType="pG";
				strInterestType="2";
				if(strPrdIdentification.equals(""))
				{
				strQuery=SQLParser.getSqlQuery("sel_digiproduct_code_PJ^"+strProductType+"^"+strAmountRequested+"^"+strRepaymentType+"^"+strflowdata);  
				rs=DBUtils.executeQuery(strQuery);	
				if(rs.next())
				{
					strLoanProduct=Helper.correctNull((String)rs.getString("PRD_CODE"));
				}
				}
				else{
					
					strQuery=SQLParser.getSqlQuery("sel_digiprd_code_identification_PB^"+strProductType+"^"+strcategoryLoanPurpose+"^"+strAmountRequested+"^"+strRepaymentType+"^"+strPrdIdentification);
					rs=DBUtils.executeQuery(strQuery);	
					if(rs.next())
					{
						strLoanProduct=Helper.correctNull((String)rs.getString("PRD_CODE"));
					}
				}
			
			}
			else if(strloanType.equals("PD"))
			{
				strProductType="pJ";
				strInterestType="1";
				
				String chkstaff="";
				if(rs1!=null)
				{ rs1.close(); }
				strQuery=SQLParser.getSqlQuery("checkforStaff^"+strlapsID);
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					chkstaff=Helper.correctNull((String)rs1.getString("INDINFO_IS_STAFF"));
				}

				if(rs1!=null)
				{ rs1.close(); }
				if(chkstaff.equalsIgnoreCase("02"))
				{
				strQuery=SQLParser.getSqlQuery("getproductcode_staff^"+strProductType+"^"+strAmountRequested+"^"+strRepaymentType);
				rs=DBUtils.executeQuery(strQuery);	
				if(rs.next())
				{
					strLoanProduct=Helper.correctNull((String)rs.getString("PRD_CODE"));
				}
				}
				else{
					
					strQuery=SQLParser.getSqlQuery("getproductcode_general^"+strProductType+"^"+strAmountRequested+"^"+strRepaymentType);
					rs=DBUtils.executeQuery(strQuery);	
					if(rs.next())
					{
						strLoanProduct=Helper.correctNull((String)rs.getString("PRD_CODE"));
					}
				}
			}
			
			
		
			
			
			HashMap hshJsonValues = new HashMap();
			hshJsonValues.put("strLARno",strLARno);
			hshJsonValues.put("strCustomerID",strCustomerID);
			hshJsonValues.put("strAmountRequested",strAmountRequested);
			hshJsonValues.put("strSinglePremium",strSinglePremium);
			hshJsonValues.put("strProjectCost",strProjectCost);
			hshJsonValues.put("strLoanTenor",strLoanTenor);
			hshJsonValues.put("strHolidayPeriod",strHolidayPeriod);
			hshJsonValues.put("strPurposeLoan",strPurposeLoan);
			hshJsonValues.put("strApplicationBranch",strApplicationBranch);
			hshJsonValues.put("strPartyFileno",strPartyFileno);
			hshJsonValues.put("strLoanProduct",strLoanProduct);
			hshJsonValues.put("strInterestType",strInterestType);
			hshJsonValues.put("strInterestRate",strInterestRate);
			hshJsonValues.put("strPeriodicityInstallments",strInstallmentPeriod);
			hshJsonValues.put("strTakeover",strTakeover);
			hshJsonValues.put("strRepaymentType",strRepaymentType);
			hshJsonValues.put("strProcessingFee",strProcessingFee);
			hshJsonValues.put("strWhetherSecured",strWhetherSecured);
			hshJsonValues.put("strPaymentMode",strPaymentMode);
			hshJsonValues.put("strProposalType",strProposalType);
			hshJsonValues.put("strApplicationHolder",strApplicationHolder);
			hshJsonValues.put("strlapsID",strlapsID);
			hshJsonValues.put("strloanType",strloanType);
			hshJsonValues.put("strEMIamount",strEMIamount);
			hshJsonValues.put("arrcoapp",arrcoapp);
			hshJsonValues.put("arrdocDetail",arrdocDetail);
			hshJsonValues.put("strmisActivityCode",strmisActivityCode);
			hshJsonValues.put("strmclrType",strmclrType);
			hshJsonValues.put("arrdevdet", arrdevdet);
			hshJsonValues.put("strapplicationScore", strapplicationScore);
			hshJsonValues.put("strappscoredeviation", strappscoredeviation);
			hshJsonValues.put("strsanctionStatus", strsanctionStatus);
			hshJsonValues.put("strprocesssingFeeCollected",strprocesssingFeeCollected);
			hshJsonValues.put("strcategoryLoanPurpose",strcategoryLoanPurpose);
			hshJsonValues.put("strpremisesAge",strpremisesAge);
			hshJsonValues.put("strtermCond",strtermCond);
			hshJsonValues.put("strcreditRiskPremium",strcreditRiskPremium);
			hshJsonValues.put("strbusinessStrategicPremium",strbusinessStrategicPremium);

			hshJsonValues.put("strInsuranceAmntFundedBy",strInsuranceAmntFundedBy);
			hshJsonValues.put("strInsuranceAmount",strInsuranceAmount);
			hshJsonValues.put("strPremiumTenor",strPremiumTenor);
			hshJsonValues.put("strLoanAmountCovered",strLoanAmountCovered);
			hshJsonValues.put("strmargin",strmargin);

			hshJsonValues.put("strOperativeAccNo",strOperativeAccNo);
			hshJsonValues.put("strinterestCollected",strinterestCollected);				
			hshJsonValues.put("strcustomerBackgroundComments",strcustomerBackgroundComments);				
			
			hshJsonValues.put("strgovtSponserScheme",strgovtSponserScheme);
			hshJsonValues.put("strschemeType",strschemeType);
			hshJsonValues.put("strsponsorAgency",strsponsorAgency);
			hshJsonValues.put("stragencyName",stragencyName);
			hshJsonValues.put("strsubsidyAmount",strsubsidyAmount);
			hshJsonValues.put("strsubsidyType",strsubsidyType);
			hshJsonValues.put("strdeviation",strdeviation);
			
			hshJsonValues.put("hunterScore",hunterScore);
			hshJsonValues.put("hunterRuleMatch",hunterRuleMatch);
			hshJsonValues.put("jocatamatch",jocatamatch);
			hshJsonValues.put("CFRmatch",CFRmatch);
			hshJsonValues.put("thickScore",thickScore);
			hshJsonValues.put("thinScore",thinScore);
			hshJsonValues.put("deviationROI",deviationROI);
			hshJsonValues.put("deviationFOIR",deviationFOIR);
			hshJsonValues.put("deviationLoanAmount",deviationLoanAmount);
			hshJsonValues.put("digiNMI",digiNMI);
			hshJsonValues.put("digiMaxEmi",digiMaxEmi);

			hshJsonValues.put("digiFOIR",digiFOIR);
			hshJsonValues.put("digiNMImultiplier",digiNMImultiplier);
			
			hshJsonValues.put("strLoanFromBank",strLoanFromBank);
			hshJsonValues.put("strReasonShiftBank",strReasonShiftBank);
			hshJsonValues.put("strLoanAmntTransferBank",strLoanAmntTransferBank);
			hshJsonValues.put("strLateOfAvailing",strLateOfAvailing);
			hshJsonValues.put("strInstallmentTrnsBank",strInstallmentTrnsBank);
			hshJsonValues.put("strInstallmentStartDate",strInstallmentStartDate);
			hshJsonValues.put("strInstallmentLastDate",strInstallmentLastDate);
			hshJsonValues.put("strHolidayperiod",strHolidayperiod);
			hshJsonValues.put("strRepaymentPeriod",strRepaymentPeriod);
			hshJsonValues.put("strRepaymentPeriod",strRepaymentPeriod);
			hshJsonValues.put("strInterestRateTakeOver",strInterestRateTakeOver);
			hshJsonValues.put("strTotalLiability",strTotalLiability);
			hshJsonValues.put("strAsOnDateLiability",strAsOnDateLiability);
			hshJsonValues.put("strAsOnDateLiability",strAsOnDateLiability);
			hshJsonValues.put("strNoOfInstallmentPaid",strNoOfInstallmentPaid);
			hshJsonValues.put("strUptoDate",strUptoDate);
			hshJsonValues.put("strRegularLoanAcc",strRegularLoanAcc);
			hshJsonValues.put("strOverdueAmount",strOverdueAmount);
			hshJsonValues.put("strAsOnDateOvrdue",strAsOnDateOvrdue);
			hshJsonValues.put("strAmountPaidTransfer",strAmountPaidTransfer);
			hshJsonValues.put("strOpinionDetails",strOpinionDetails);
			hshJsonValues.put("strAccountStatementFrom",straccountStatementFrom);
			hshJsonValues.put("strAccountStatementTo",straccountStatementTo);
			hshJsonValues.put("strComments",strComments);
			hshJsonValues.put("strtakeOver",strTakeover);
			hshJsonValues.put("strStallmentStipulated",strStallmentStipulated);
			hshJsonValues.put("strScheme",strScheme);
			hshJsonValues.put("arrRepaymentSchedule",arrRepayment);
			hshJsonValues.put("strProdctDesc",strProdctDesc);
			hshJsonValues.put("strResidualvalue",strResidualvalue);
			hshJsonValues.put("strProductType",strProductType);
			hshJsonValues.put("strGSTyear1",strGSTyear1);
			hshJsonValues.put("strGSTyear1amnt",strGSTyear1amnt);
			hshJsonValues.put("strGSTyear2",strGSTyear2);
			hshJsonValues.put("strGSTyear2amnt",strGSTyear2amnt);
			hshJsonValues.put("strcommercialBureauScore",strcommercialBureauScore);
			hshJsonValues.put("strconsumerIndScore",strconsumerIndScore);
			hshJsonValues.put("strconsumerPartyScore",strconsumerPartyScore);
			hshJsonValues.put("strodAccountScore",strodAccountScore);
			hshJsonValues.put("strcurrentAccountScore",strcurrentAccountScore);
			hshJsonValues.put("strfsaScore",strfsaScore);
			hshJsonValues.put("strbandRating",strbandRating);
			hshJsonValues.put("strbandPath",strbandPath);
			hshJsonValues.put("strkbRating",strkbRating);
			hshJsonValues.put("strpenalInterest",strpenalInterest); 
			hshJsonValues.put("strinterestConcession",strinterestConcession);
			hshJsonValues.put("strudyamRegistrationNumber",strudyamRegistrationNumber);
			hshJsonValues.put("strsalesTurnOverApplicant",strsalesTurnOverApplicant);
			hshJsonValues.put("strsalesTurnOverDate",strsalesTurnOverDate);
			hshJsonValues.put("strcriteriaforSalesTurnover",strcriteriaforSalesTurnover);
			hshJsonValues.put("strrenewType",strrenewType);
			hshJsonValues.put("strrenewProposalsNo",strrenewProposalsNo);
			hshJsonValues.put("strDigiAppNo",strDigiAppNo);
			hshJsonValues.put("strfindigitype",strfindigitype);
			hshJsonValues.put("strfindigiyear",strfindigiyear);
			hshJsonValues.put("strecsBankName",strecsBankName);
			hshJsonValues.put("strecsAccountType",strecsAccountType);
			hshJsonValues.put("strecsOperAccountType",strecsOperAccountType);
			hshJsonValues.put("strecsAuthunenticateMode",strecsAuthunenticateMode);
			hshJsonValues.put("strecsIFSCCODE",strecsIFSCCODE);
			hshJsonValues.put("strupfrontfee",strupfrontfee);
			hshJsonValues.put("arrgoldOrnaments",arrgoldOrnaments);
			hshJsonValues.put("strdocRecAgri",strdocRecAgri);
			hshJsonValues.put("strappraiserName",strappraiserName);
			hshJsonValues.put("strappraiseon",strappraiseon);
			hshJsonValues.put("strappraisercomments",strappraisercomments);
			hshJsonValues.put("strappraisercbsid",strappraisercbsid);
			hshJsonValues.put("stramrtOverrideLoanAmount",stramrtOverrideLoanAmount);
			hshJsonValues.put("arrtermsAndCondition",arrtermsAndCondition);
			hshJsonValues.put("stramrtOverride",stramrtOverride);
			hshJsonValues.put("strupfrontFeeCollected",strupfrontFeeCollected);
			hshJsonValues.put("strmaxEligibleEMI",strmaxEligibleEMI);
			hshJsonValues.put("strstpType",strstpType);
			hshJsonValues.put("arrdepositdetails",arrdepositdetails);
			
			//--------------------------------newly added data---------------------------------------//
			hshJsonValues.put("strinttype",strinttype);
			hshJsonValues.put("strcfr_verified",strcfr_verified);
			hshJsonValues.put("strCFR_borname",strCFR_borname);
			hshJsonValues.put("strcersai_check",strcersai_check);
			hshJsonValues.put("strDRAWING_PWR_IND",strDRAWING_PWR_IND);
			hshJsonValues.put("strSchemecode",strSchemecode);
			hshJsonValues.put("strGLSUBHEADCODE",strGLSUBHEADCODE);
			hshJsonValues.put("strGISTOFSECURITUES",strGISTOFSECURITUES);
			hshJsonValues.put("strloanSecure",strloanSecure);
			hshJsonValues.put("strSANCLEVEL",strSANCLEVEL);
			hshJsonValues.put("strSANCAUTH",strSANCAUTH);
			hshJsonValues.put("strrepaymentterms",strrepaymentterms);
			
			hshJsonValues.put("strSanctionedBy",strSanctionedBy);
			hshJsonValues.put("strAppriasedBy",strAppriasedBy);
			hshJsonValues.put("strflowdata", strflowdata);
			hshJsonValues.put("strappraisaldepartment", strappraisaldepartment);
			
			boolean proposalcheck=true;
			
			String appno="";
			strQuery=SQLParser.getSqlQuery("selappnoinwardnowise^"+strLARno);
			rs=DBUtils.executeQuery(strQuery);	
			if(rs.next())
			{
				appno=Helper.correctNull((String)rs.getString("app_no"));
				proposalcheck=false;
			}
			
			if(proposalcheck==true)
			{
				if(strloanType.equals("PL")) //personal loan 
				{
					hshValues = (HashMap) EJBInvoker.executeStateLess("DigitalAppInterface",hshJsonValues,"ProposalCreation");
					String strApplication  = Helper.correctNull((String)hshValues.get("strApplication"));
					responseData.put("lapsProposalNumber", strApplication);
					responseData.put("sanctionReferenceno", Helper.correctNull((String)hshValues.get("strReferenceno")));
					responseData.put("sanctionDate", Helper.correctNull((String)hshValues.get("strSanctionDate")));
					strResponseCode=Helper.correctNull((String)hshValues.get("strResponseCode"));
					strResponseMsg=Helper.correctNull((String)hshValues.get("strResponseMsg"));
				}
				else if(strloanType.equals("HL")) //house loan
				{
					DigitalAppInterfaceBean digitalAppInterfaceBean= new DigitalAppInterfaceBean();
					
					hshValues=digitalAppInterfaceBean.proposalCreationForHL(hshJsonValues);
					//hshValues = (HashMap) EJBInvoker.executeStateLess("DigitalAppInterface",hshJsonValues,"proposalCreationForHL");
					String strApplication  = Helper.correctNull((String)hshValues.get("strApplication"));
					responseData.put("lapsProposalNumber", strApplication);
					responseData.put("sanctionReferenceno", Helper.correctNull((String)hshValues.get("strReferenceno")));
					responseData.put("sanctionDate", Helper.correctNull((String)hshValues.get("strSanctionDate")));
					strResponseCode=Helper.correctNull((String)hshValues.get("strResponseCode"));
					strResponseMsg=Helper.correctNull((String)hshValues.get("strResponseMsg"));
				}
				else if(strloanType.equals("PB")) //BQL
				{
					DigitalAppInterfaceBean digitalAppInterfaceBean= new DigitalAppInterfaceBean();
					
					hshValues=digitalAppInterfaceBean.proposalCreationForPB(hshJsonValues);
					//hshValues = (HashMap) EJBInvoker.executeStateLess("DigitalAppInterface",hshJsonValues,"proposalCreationForHL");
					String strApplication  = Helper.correctNull((String)hshValues.get("strApplication"));
					responseData.put("lapsProposalNumber", strApplication);
					responseData.put("sanctionReferenceno", Helper.correctNull((String)hshValues.get("strReferenceno")));
					responseData.put("sanctionDate", Helper.correctNull((String)hshValues.get("strSanctionDate")));
					strResponseCode=Helper.correctNull((String)hshValues.get("strResponseCode"));
					strResponseMsg=Helper.correctNull((String)hshValues.get("strResponseMsg"));
				}
				else if(strloanType.equals("PM")) //MORTGAGE LOAN
				{
					DigitalAppInterfaceBean digitalAppInterfaceBean= new DigitalAppInterfaceBean();
					
					hshValues=digitalAppInterfaceBean.proposalCreationForPM(hshJsonValues);
					String strApplication  = Helper.correctNull((String)hshValues.get("strApplication"));
					responseData.put("lapsProposalNumber", strApplication);
					responseData.put("sanctionReferenceno", Helper.correctNull((String)hshValues.get("strReferenceno")));
					responseData.put("sanctionDate", Helper.correctNull((String)hshValues.get("strSanctionDate")));
					strResponseCode=Helper.correctNull((String)hshValues.get("strResponseCode"));
					strResponseMsg=Helper.correctNull((String)hshValues.get("strResponseMsg"));
				}
				else if(strloanType.equals("PJ"))	//JEWEL LOAN
				{
					
					DigitalAppInterfaceBean digitalAppInterfaceBean= new DigitalAppInterfaceBean();
					
					hshValues=digitalAppInterfaceBean.proposalCreationForPJ(hshJsonValues);
					String strApplication  = Helper.correctNull((String)hshValues.get("strApplication"));
					responseData.put("lapsProposalNumber", strApplication);
					responseData.put("sanctionReferenceno", Helper.correctNull((String)hshValues.get("strReferenceno")));
					responseData.put("sanctionDate", Helper.correctNull((String)hshValues.get("strSanctionDate")));
					strResponseCode=Helper.correctNull((String)hshValues.get("strResponseCode"));
					strResponseMsg=Helper.correctNull((String)hshValues.get("strResponseMsg"));
				}
				else if(strloanType.equals("PD")) //
				{
					DigitalAppInterfaceBean digitalAppInterfaceBean= new DigitalAppInterfaceBean();
					
					hshValues=digitalAppInterfaceBean.proposalCreationForPD(hshJsonValues);
					String strApplication  = Helper.correctNull((String)hshValues.get("strApplication"));
					responseData.put("lapsProposalNumber", strApplication);
					responseData.put("sanctionReferenceno", Helper.correctNull((String)hshValues.get("strReferenceno")));
					responseData.put("sanctionDate", Helper.correctNull((String)hshValues.get("strSanctionDate")));
					strResponseCode=Helper.correctNull((String)hshValues.get("strResponseCode"));
					strResponseMsg=Helper.correctNull((String)hshValues.get("strResponseMsg"));
				}

			
			}
			else
			{
				responseData.put("lapsProposalNumber", appno);
				strResponseCode="LAPS-2011";
				strResponseMsg="Proposal is already created for the given LAR";
				
			}
			

			response.setData(responseData);
			response.setResp_code(strResponseCode);
			response.setResp_msg(strResponseMsg);
			
			jsonAsString = objectMapper.writeValueAsString(response);
		}
		catch (Exception e)
		{
			response.setData(responseData);
			response.setResp_code("LAPS-2003");
			response.setResp_msg("Invalid request parameters");
			jsonAsString = objectMapper.writeValueAsString(response);
			e.printStackTrace();
			throw new EJBException("Exception in proposalCreation ==="+e.getMessage());
		
		}
		return jsonAsString;	
		
	}
	
	
	//@Override
	public String preApprovedOfferServiceApp(PreApprovedOffer preApprovedOffer)
			throws com.fasterxml.jackson.core.JsonProcessingException {

		Map<String,Object> responseDataMap = new HashMap<String,Object>();
		Response response = new Response();
		String jsonAsString = "";
		HashMap hshValues = new HashMap();
		String strApplExists="", strStatus="";
		
		String strResponseMsg="",strResponseCode="", strCustomerID="", strAccountNo="";
				   
		try
		{
			JSONObject jsonObj = new JSONObject(preApprovedOffer);

			if (!jsonObj.isNull("accountNo"))
				strAccountNo    = jsonObj.getString("accountNo");
			if (!jsonObj.isNull("customerID"))
				strCustomerID    = jsonObj.getString("customerID");
			
			if(strAccountNo.equals("") || strCustomerID.equals(""))
			{
				return Constants.ERROR_RESPONSE_MANDATORY;
			}
			
			
			HashMap hshJsonValues = new HashMap();
			hshJsonValues.put("strAccountNo",strAccountNo);
			hshJsonValues.put("strCustomerID",strCustomerID);
			
			Log.info("PreApproved Offer API service request -----"+hshJsonValues);
				
			hshValues = (HashMap) EJBInvoker.executeStateLess("DigitalAppInterface",hshJsonValues,"preApprovedOfferServiceApp");
			strApplExists  = Helper.correctNull((String)hshValues.get("strApplExist"));
			
			if(strApplExists.equals("Y"))
			{
				responseDataMap.put("DataExist", "Yes");
				responseDataMap.put("CustId", Helper.correctNull((String)hshValues.get("strCustID")));
				responseDataMap.put("AccountNo", Helper.correctNull((String)hshValues.get("strAccNo")));
				responseDataMap.put("LoanAmount", Helper.correctNull((String)hshValues.get("strCustLoanAmt")));
				responseDataMap.put("CustomerROI", Helper.correctNull((String)hshValues.get("strCustROI")));
				responseDataMap.put("CustomerTenure", Helper.correctNull((String)hshValues.get("strCustTenure")));
				responseDataMap.put("ProcessingFee", Helper.correctNull((String)hshValues.get("strProcessingFee")));
				responseDataMap.put("BureauScore", Helper.correctNull((String)hshValues.get("strBureauScore")));
				responseDataMap.put("BREScore", Helper.correctNull((String)hshValues.get("strBreScore")));
				responseDataMap.put("kblEmiLimit", Helper.correctNull((String)hshValues.get("strEMIlimit")));
				responseDataMap.put("salary", Helper.correctNull((String)hshValues.get("strSalary")));
				responseDataMap.put("debitScore", Helper.correctNull((String)hshValues.get("strdebitscore")));
				responseDataMap.put("birDate", Helper.correctNull((String)hshValues.get("strbirdate")));
				
				strResponseCode="LAPS-1010";
				strResponseMsg="Pre Approved Offer Completed Successfully";
			}
			else
			{
				responseDataMap.put("DataExist", "No");
				responseDataMap.put("debitScore", Helper.correctNull((String)hshValues.get("strdebitscore")));
				responseDataMap.put("birDate", Helper.correctNull((String)hshValues.get("strbirdate")));
				strResponseCode="LAPS-1011";
				strResponseMsg="Pre Approved Offer Completed Successfully";
			}
			
			response.setData(responseDataMap);
			response.setResp_code(strResponseCode);
			response.setResp_msg(strResponseMsg);
			 
			jsonAsString = objectMapper.writeValueAsString(response);
		}
		catch (Exception e)
		{
			response.setData(responseDataMap);
			response.setResp_code("LAPS-2003");
			response.setResp_msg("Invalid request parameters");
			jsonAsString = objectMapper.writeValueAsString(response);
			e.printStackTrace();
			throw new EJBException("Exception in preApprovedOfferServiceApp ==="+e.getMessage());
		}
		return jsonAsString;
	}
	
	

	public String handleSecurityDetails(SecurityCreation securityCreation)
			throws com.fasterxml.jackson.core.JsonProcessingException {
		
		Map<String,Object> responseDataMap = new HashMap<String,Object>();
		Response response = new Response();
		String jsonAsString = "";
		HashMap hshValues = new HashMap();
		
		
		String strSecurityType="",strSecurityClassification="",strAlChrgdToOtherBanks="",strNatureOfCharge="",strValuerName="",
		strDateOfSubmissionForValuation="", strDateOfReceiptOfValuation="",
		strDateOfValuation="",strSecurityDescription="",strCollateralStartDate="",strCollateralEndDate="",strTotalSecurityValue="",strLapsId="",strCBSId="",
		strPropertyType="",strPlotNo="",strStreetNo="",strWardNo="",strAddress="",strCity="",strDistrict="",
		strState="",strPinCode="",strTotalArea="",strExtentOfBuilding="",strValueAsPerValuation="",strForcedSaleValue="",strTitleDeedsBranch="",strSurveyNo="",
		strPropertyAcquisition="",strLegalAdviserName="",strDateOfSubmissionForLegalOpinion="",strDateOfReceiptOfLegalOpinion="",strDateOfLegalOpinion="",
		strFlowOfTitle="", strECObtained="", strLatestTaxPaidYear="", strFlowOfTitleSearchFromProp="", strPeriodOfEC="",
	    strvehicleType="",strvehicleCatogery="",strmodel="",strvehicleAge="",strbookValue="",strpurchasePrice="",strengineNo="",
		strregState="",strdealerName="",strcontactNo="",strdealerAddress="",strdealerCity="",strdealerState="",strdealerDistrict="",strdealerCountry="",
		strdealerpinCode="",strdealerMailId="",strdealerCode="",strdealerGstNo="",strbelongingTo="",strdoorNo="",strparkingAddress="",strparkingCity="",
		strparkingState="",strparkingDistrict="",strparkingCountry="",strparkingPinCode="",strcompany="",strMake="",strOwneraddress2="",
		strDealeraddress2="",strOwnersalutation="",strsolID="";
		
		
		ResultSet rs=null;
		String strResponseMsg="",strResponseCode="", strSecurityId="",strQuery="";
		
		try
		{
			JSONObject jsonObj		= new JSONObject(securityCreation);
			
			
			if (!jsonObj.isNull("securityType"))
				strSecurityType  = jsonObj.getString("securityType");
			if (!jsonObj.isNull("securityClassification"))
				strSecurityClassification  = jsonObj.getString("securityClassification");
			if (!jsonObj.isNull("alChrgdToOtherBanks"))
				strAlChrgdToOtherBanks    = jsonObj.getString("alChrgdToOtherBanks");
			if (!jsonObj.isNull("natureOfCharge"))
				strNatureOfCharge   = jsonObj.getString("natureOfCharge");
			if (!jsonObj.isNull("valuerName"))
				strValuerName    = jsonObj.getString("valuerName");
			if (!jsonObj.isNull("dateOfSubmissionForValuation"))
				strDateOfSubmissionForValuation    = jsonObj.getString("dateOfSubmissionForValuation");
			if (!jsonObj.isNull("dateOfReceiptOfValuation"))
				strDateOfReceiptOfValuation    = jsonObj.getString("dateOfReceiptOfValuation");
			if (!jsonObj.isNull("dateOfValuation"))
				strDateOfValuation    = jsonObj.getString("dateOfValuation");
			if (!jsonObj.isNull("securityDescription"))
				strSecurityDescription    = jsonObj.getString("securityDescription");
			if (!jsonObj.isNull("collateralStartDate"))
				strCollateralStartDate    = jsonObj.getString("collateralStartDate");
			if (!jsonObj.isNull("collateralEndDate"))
				strCollateralEndDate    = jsonObj.getString("collateralEndDate");
			if (!jsonObj.isNull("totalSecurityValue"))
				strTotalSecurityValue    = jsonObj.getString("totalSecurityValue");
			if (!jsonObj.isNull("lapsId"))
				strLapsId    = jsonObj.getString("lapsId");
			if (!jsonObj.isNull("cbsId"))
				strCBSId    = jsonObj.getString("cbsId");
			if (!jsonObj.isNull("propertyType"))
				strPropertyType    = jsonObj.getString("propertyType");
			if (!jsonObj.isNull("plotNo"))
				strPlotNo    = jsonObj.getString("plotNo");
			if (!jsonObj.isNull("streetNo"))
				strStreetNo    = jsonObj.getString("streetNo");
			if (!jsonObj.isNull("wardNo"))
				strWardNo    = jsonObj.getString("wardNo");
			if (!jsonObj.isNull("address"))
				strAddress    = jsonObj.getString("address");
			if (!jsonObj.isNull("city"))
				strCity    = jsonObj.getString("city");
			if (!jsonObj.isNull("district"))
				strDistrict    = jsonObj.getString("district");
			if (!jsonObj.isNull("state"))
				strState    = jsonObj.getString("state");			
			if (!jsonObj.isNull("pinCode"))
				strPinCode    = jsonObj.getString("pinCode");			
			if (!jsonObj.isNull("totalArea"))
				strTotalArea    = jsonObj.getString("totalArea");			
			if (!jsonObj.isNull("extentOfBuilding"))
				strExtentOfBuilding    = jsonObj.getString("extentOfBuilding");	
			if (!jsonObj.isNull("valueAsPerValuation"))
				strValueAsPerValuation    = jsonObj.getString("valueAsPerValuation");	
			if (!jsonObj.isNull("forcedSaleValue"))
				strForcedSaleValue   = jsonObj.getString("forcedSaleValue");	
			if (!jsonObj.isNull("titleDeedsBranch"))
				strTitleDeedsBranch  = jsonObj.getString("titleDeedsBranch");	
			if (!jsonObj.isNull("surveyNo"))
				strSurveyNo  = jsonObj.getString("surveyNo");	
			if (!jsonObj.isNull("propertyAcquisition"))
				strPropertyAcquisition    = jsonObj.getString("propertyAcquisition");	
			if (!jsonObj.isNull("legalAdviserName"))
				strLegalAdviserName   = jsonObj.getString("legalAdviserName");	
			if (!jsonObj.isNull("dateOfSubmissionForLegalOpinion"))
				strDateOfSubmissionForLegalOpinion  = jsonObj.getString("dateOfSubmissionForLegalOpinion");	
			if (!jsonObj.isNull("dateOfReceiptOfLegalOpinion"))
				strDateOfReceiptOfLegalOpinion  = jsonObj.getString("dateOfReceiptOfLegalOpinion");	
			if (!jsonObj.isNull("dateOfLegalOpinion"))
				strDateOfLegalOpinion    = jsonObj.getString("dateOfLegalOpinion");	
			if (!jsonObj.isNull("flowOfTitle"))
				strFlowOfTitle   = jsonObj.getString("flowOfTitle");	
			if (!jsonObj.isNull("ecObtained"))
				strECObtained  = jsonObj.getString("ecObtained");	
			
			if (!jsonObj.isNull("latestTaxPaidYear"))
				strLatestTaxPaidYear  = jsonObj.getString("latestTaxPaidYear");
			if (!jsonObj.isNull("flowOfTitleSearchFromProp"))
				strFlowOfTitleSearchFromProp  = jsonObj.getString("flowOfTitleSearchFromProp");
			if (!jsonObj.isNull("periodOfEC"))
				strPeriodOfEC  = jsonObj.getString("periodOfEC");
			
			
			
			if (!jsonObj.isNull("vehicleType"))
				strvehicleType  = jsonObj.getString("vehicleType");
			if (!jsonObj.isNull("company"))
				strcompany  = jsonObj.getString("company");
			if (!jsonObj.isNull("vehicleCatogery"))
				strvehicleCatogery  = jsonObj.getString("vehicleCatogery");
			if (!jsonObj.isNull("model"))
				strmodel  = jsonObj.getString("model");
			if (!jsonObj.isNull("vehicleAge"))
				strvehicleAge  = jsonObj.getString("vehicleAge");
			if (!jsonObj.isNull("bookValue"))
				strbookValue  = jsonObj.getString("bookValue");
			if (!jsonObj.isNull("purchasePrice"))
				strpurchasePrice  = jsonObj.getString("purchasePrice");
			if (!jsonObj.isNull("engineNo"))
				strengineNo  = jsonObj.getString("engineNo");
			if (!jsonObj.isNull("regState"))
				strregState  = jsonObj.getString("regState");
				
			if (!jsonObj.isNull("dealerName"))
				strdealerName  = jsonObj.getString("dealerName");
			if (!jsonObj.isNull("contactNo"))
				strcontactNo  = jsonObj.getString("contactNo");
			if (!jsonObj.isNull("dealerAddress"))
				strdealerAddress  = jsonObj.getString("dealerAddress");
			if (!jsonObj.isNull("dealerCity"))
				strdealerCity  = jsonObj.getString("dealerCity");
			if (!jsonObj.isNull("dealerState"))
				strdealerState  = jsonObj.getString("dealerState");
			if (!jsonObj.isNull("dealerDistrict"))
				strdealerDistrict  = jsonObj.getString("dealerDistrict");
			if (!jsonObj.isNull("dealerCountry"))
				strdealerCountry  = jsonObj.getString("dealerCountry");
			if (!jsonObj.isNull("dealerpinCode"))
				strdealerpinCode  = jsonObj.getString("dealerpinCode");
			if (!jsonObj.isNull("dealerMailId"))
				strdealerMailId  = jsonObj.getString("dealerMailId");
			if (!jsonObj.isNull("dealerCode"))
				strdealerCode  = jsonObj.getString("dealerCode");
			if (!jsonObj.isNull("dealerGstNo"))
				strdealerGstNo  = jsonObj.getString("dealerGstNo");
			if (!jsonObj.isNull("ownerName"))
				strbelongingTo  = jsonObj.getString("ownerName");
			/*
			private String ownerName;
		private String doorNo;
		private String ownerAddress;
		private String ownerCity;
		private String ownerState;
		private String ownerDistrict;
		private String ownerCountry;
		private String ownergPinCode;
			*/
				
			if (!jsonObj.isNull("doorNo"))
				strdoorNo  = jsonObj.getString("doorNo");
			if (!jsonObj.isNull("ownerAddress"))
				strparkingAddress  = jsonObj.getString("ownerAddress");
			if (!jsonObj.isNull("ownerCity"))
				strparkingCity  = jsonObj.getString("ownerCity");
			if (!jsonObj.isNull("ownerState"))
				strparkingState  = jsonObj.getString("ownerState");
			if (!jsonObj.isNull("ownerDistrict"))
				strparkingDistrict  = jsonObj.getString("ownerDistrict");
			if (!jsonObj.isNull("ownerCountry"))
				strparkingCountry  = jsonObj.getString("ownerCountry");
			if (!jsonObj.isNull("ownergPinCode"))
				strparkingPinCode  = jsonObj.getString("ownergPinCode");
			
			if (!jsonObj.isNull("make"))
				strMake  = jsonObj.getString("make");
			if (!jsonObj.isNull("owneraddress2"))
				strOwneraddress2  = jsonObj.getString("owneraddress2");
			if (!jsonObj.isNull("dealeraddress2"))
				strDealeraddress2  = jsonObj.getString("dealeraddress2");
			if (!jsonObj.isNull("ownerSalutation"))
				strOwnersalutation  = jsonObj.getString("ownerSalutation");	
			if (!jsonObj.isNull("solID"))
				strsolID  = jsonObj.getString("solID");	
			
			/*
			 * 
			 * ||	strPropertyType.equals("") || strPlotNo.equals("") || strStreetNo.equals("") || strWardNo.equals("") 
				|| strAddress.equals("") || strCity.equals("") || strDistrict.equals("") || strState.equals("") || strPinCode.equals("") 
				|| strTotalArea.equals("") || strExtentOfBuilding.equals("")|| strValueAsPerValuation.equals("")|| strForcedSaleValue.equals("")
				|| strTitleDeedsBranch.equals("")|| strSurveyNo.equals("")|| strPropertyAcquisition.equals("")|| strLegalAdviserName.equals("")
				|| strDateOfSubmissionForLegalOpinion.equals("")|| strDateOfReceiptOfLegalOpinion.equals("")|| strDateOfLegalOpinion.equals("")
				|| strFlowOfTitle.equals("") || strECObtained.equals("") || strLatestTaxPaidYear.equals("") || strFlowOfTitleSearchFromProp.equals("") 
				|| strPeriodOfEC.equals("")
			*/		
			
			//Mandatory Check
			if( strSecurityType.equals("") || strSecurityClassification.equals("") || strAlChrgdToOtherBanks.equals("") || strNatureOfCharge.equals("") || 
				strDateOfSubmissionForValuation.equals("") || strDateOfReceiptOfValuation.equals("") || strDateOfValuation.equals("") 
				|| strSecurityDescription.equals("") || strCollateralStartDate.equals("") || strCollateralEndDate.equals("") || 
				strTotalSecurityValue.equals("")|| strLapsId.equals(""))
			{
				
				return Constants.ERROR_RESPONSE_MANDATORY;

			}
			
			strQuery = SQLParser.getSqlQuery("findBorrowerOrgCom^"+strLapsId);
			rs = DBUtils.executeQuery(strQuery);
			if(!rs.next())
			{
				return Constants.ERROR_INVALID_LAPS_ID;
			}
			
			if(!strDateOfSubmissionForValuation.equals("") && !strDateOfReceiptOfValuation.equals("") && !strDateOfValuation.equals("")
					&& !strCollateralStartDate.equals("")  && !strCollateralEndDate.equals("") 
					&& !strDateOfSubmissionForLegalOpinion.equals("") && !strDateOfReceiptOfLegalOpinion.equals("") && !strDateOfLegalOpinion.equals(""))
			{
				SimpleDateFormat sdfrmt = new SimpleDateFormat("dd/mm/yyyy");
			 	try
			 	{
				 	Date javaDateOfSubmissionForValuation = sdfrmt.parse(strDateOfSubmissionForValuation); 
				 	Date javaDateOfReceiptOfValuation = sdfrmt.parse(strDateOfReceiptOfValuation);
				 	Date javaDateOfValuation = sdfrmt.parse(strDateOfValuation);
				 	Date javaCollateralStartDate = sdfrmt.parse(strCollateralStartDate);
				 	Date javaCollateralEndDate = sdfrmt.parse(strCollateralEndDate);
				 	Date javaDateOfSubmissionForLegalOpinion = sdfrmt.parse(strDateOfSubmissionForLegalOpinion);
				 	Date javaDateOfReceiptOfLegalOpinion = sdfrmt.parse(strDateOfReceiptOfLegalOpinion);
				 	Date javaDateOfLegalOpinion = sdfrmt.parse(strDateOfLegalOpinion);
 	
			 	}
		    	catch (ParseException e)
			    {
					return Constants.ERROR_RESPONSE_INVALID_DATEFORMAT;
			    }
			}
				
			
			HashMap hshJsonValues = new HashMap();
			//Security Details
			hshJsonValues.put("strSecurityType",strSecurityType);
			hshJsonValues.put("strSecurityClassification",strSecurityClassification);
			hshJsonValues.put("strAlChrgdToOtherBanks",strAlChrgdToOtherBanks);
			hshJsonValues.put("strNatureOfCharge",strNatureOfCharge);
			hshJsonValues.put("strValuerName",strValuerName);
			hshJsonValues.put("strDateOfSubmissionForValuation",strDateOfSubmissionForValuation);
			hshJsonValues.put("strDateOfReceiptOfValuation",strDateOfReceiptOfValuation);
			hshJsonValues.put("strDateOfValuation",strDateOfValuation);
			hshJsonValues.put("strSecurityDescription",strSecurityDescription);
			hshJsonValues.put("strCollateralStartDate",strCollateralStartDate);
			hshJsonValues.put("strCollateralEndDate",strCollateralEndDate);
			hshJsonValues.put("strTotalSecurityValue",strTotalSecurityValue);
			hshJsonValues.put("strLapsId",strLapsId);
			hshJsonValues.put("strCBSId",strCBSId);
			//Property Details
			/*hshJsonValues.put("strPropertyType",strPropertyType);
			hshJsonValues.put("strPlotNo",strPlotNo);
			hshJsonValues.put("strStreetNo",strStreetNo);
			hshJsonValues.put("strWardNo",strWardNo);
			hshJsonValues.put("strAddress",strAddress);
			hshJsonValues.put("strCity",strCity);
			hshJsonValues.put("strDistrict",strDistrict);
			hshJsonValues.put("strState",strState);
			hshJsonValues.put("strPinCode",strPinCode); 
			hshJsonValues.put("strTotalArea",strTotalArea);
			hshJsonValues.put("strExtentOfBuilding",strExtentOfBuilding);
			hshJsonValues.put("strValueAsPerValuation",strValueAsPerValuation);
			hshJsonValues.put("strForcedSaleValue",strForcedSaleValue);
			hshJsonValues.put("strTitleDeedsBranch",strTitleDeedsBranch);
			hshJsonValues.put("strSurveyNo",strSurveyNo);
			hshJsonValues.put("strPropertyAcquisition",strPropertyAcquisition);
			//Legal Opinion
			hshJsonValues.put("strLegalAdviserName",strLegalAdviserName);
			hshJsonValues.put("strDateOfSubmissionForLegalOpinion",strDateOfSubmissionForLegalOpinion);
			hshJsonValues.put("strDateOfReceiptOfLegalOpinion",strDateOfReceiptOfLegalOpinion);
			hshJsonValues.put("strDateOfLegalOpinion",strDateOfLegalOpinion);
			hshJsonValues.put("strFlowOfTitle",strFlowOfTitle);
			hshJsonValues.put("strECObtained",strECObtained);
			hshJsonValues.put("strLatestTaxPaidYear",strLatestTaxPaidYear);
			hshJsonValues.put("strFlowOfTitleSearchFromProp",strFlowOfTitleSearchFromProp);
			hshJsonValues.put("strPeriodOfEC",strPeriodOfEC);*/
			
		
			
			hshJsonValues.put("strvehicleType",strvehicleType);
			hshJsonValues.put("strvehicleCatogery",strvehicleCatogery);
			hshJsonValues.put("strmodel",strmodel);
			hshJsonValues.put("strvehicleAge",strvehicleAge);
			hshJsonValues.put("strbookValue",strbookValue);
			hshJsonValues.put("strpurchasePrice",strpurchasePrice);
			hshJsonValues.put("strengineNo",strengineNo);
			hshJsonValues.put("strregState",strregState);
			hshJsonValues.put("strdealerName",strdealerName);
			hshJsonValues.put("strcontactNo",strcontactNo);
			hshJsonValues.put("strdealerAddress",strdealerAddress);
			hshJsonValues.put("strdealerCity",strdealerCity);
			hshJsonValues.put("strdealerDistrict",strdealerDistrict);
			hshJsonValues.put("strdealerCountry",strdealerCountry);
			hshJsonValues.put("strdealerpinCode",strdealerpinCode);
			hshJsonValues.put("strdealerCode",strdealerCode);
			hshJsonValues.put("strdealerGstNo",strdealerGstNo);
			hshJsonValues.put("strbelongingTo",strbelongingTo);
			hshJsonValues.put("strdoorNo",strdoorNo);
			hshJsonValues.put("strparkingAddress",strparkingAddress);
			hshJsonValues.put("strparkingCity",strparkingCity);
			hshJsonValues.put("strparkingState",strparkingState);
			hshJsonValues.put("strparkingCountry",strparkingCountry);
			hshJsonValues.put("strparkingPinCode",strparkingPinCode);
			hshJsonValues.put("strcompany",strcompany);
			hshJsonValues.put("strMake",strMake);
			hshJsonValues.put("strOwnersalutation",strOwnersalutation);
			hshJsonValues.put("strDealeraddress2",strDealeraddress2);
			hshJsonValues.put("strOwneraddress2",strOwneraddress2);
			hshJsonValues.put("strdealerState",strdealerState);
			hshJsonValues.put("strsolID",strsolID);

			
			
			hshValues = (HashMap) EJBInvoker.executeStateLess("DigitalAppInterface",hshJsonValues,"updateSecurityDetails");
			strSecurityId  = Helper.correctNull((String)hshValues.get("strSecurityId"));
			strResponseCode=Helper.correctNull((String)hshValues.get("strResponseCode"));
			strResponseMsg=Helper.correctNull((String)hshValues.get("strResponseMsg"));
			
			responseDataMap.put("SecurityId", strSecurityId);
			response.setData(responseDataMap);
			response.setResp_code(strResponseCode);
			response.setResp_msg(strResponseMsg);
			
			jsonAsString = objectMapper.writeValueAsString(response);
		}
		catch (Exception e)
		{
			response.setData(responseDataMap);
			response.setResp_code("LAPS-2003");
			response.setResp_msg("Invalid request parameters");
			jsonAsString = objectMapper.writeValueAsString(response);
			e.printStackTrace();
			throw new EJBException("Exception in handleSecurityDetails ==="+e.getMessage());
		
		}
		return jsonAsString;
	}
	
	//@Override
	public String preApprovedOfferService(PreApprovedOffer preApprovedOffer)
			throws com.fasterxml.jackson.core.JsonProcessingException {

		Map<String,Object> responseDataMap = null;
		
		Response response = new Response();
		String jsonAsString = "";
		ArrayList arrValues = new ArrayList();
		HashMap hshValues = new HashMap();
		HashMap hshValue = new HashMap();
		HashMap responseData = new HashMap();
		String strApplExists="", strStatus="";
		
		String strResponseMsg="",strResponseCode="", strCustomerID="", strAccountNo="";
				   
		try
		{
			JSONObject jsonObj = new JSONObject(preApprovedOffer);

			
			if (!jsonObj.isNull("customerID"))
				strCustomerID    = jsonObj.getString("customerID");
			
			if(strCustomerID.equals(""))
			{
				return Constants.ERROR_RESPONSE_MANDATORY;
			}
			
			
			HashMap hshJsonValues = new HashMap();
			
			hshJsonValues.put("strCustomerID",strCustomerID);
			
				
			hshValue = (HashMap) EJBInvoker.executeStateLess("DigitalAppInterface",hshJsonValues,"preApprovedOfferService");
			if(hshValue!=null){
				
			
			ArrayList arrayList1 = (ArrayList)hshValue.get("arrValue");
				
			if(arrayList1.size()>0 && arrayList1!=null)
			{
				for(int i=0; i<arrayList1.size(); i++){
					hshValues = (HashMap) arrayList1.get(i);
					strApplExists  = Helper.correctNull((String)hshValues.get("strApplExist"));
					responseDataMap = new HashMap<String,Object>();
					//if(strApplExists.equals("Y"))
					{
						responseDataMap.put("CustId", Helper.correctNull((String)hshValues.get("strCustID")));
						responseDataMap.put("AccountNo", Helper.correctNull((String)hshValues.get("strAccNo")));
						responseDataMap.put("LoanAmount", Helper.correctNull((String)hshValues.get("strCustLoanAmt")));
						responseDataMap.put("CustomerROI", Helper.correctNull((String)hshValues.get("strCustROI")));
						responseDataMap.put("CustomerTenure", Helper.correctNull((String)hshValues.get("strCustTenure")));
						responseDataMap.put("ProcessingFee", Helper.correctNull((String)hshValues.get("strProcessingFee")));
						responseDataMap.put("BureauScore", Helper.correctNull((String)hshValues.get("strBureauScore")));
						responseDataMap.put("BREScore", Helper.correctNull((String)hshValues.get("strBreScore")));
						responseDataMap.put("kblEmiLimit", Helper.correctNull((String)hshValues.get("strEMIlimit")));
						responseDataMap.put("salary", Helper.correctNull((String)hshValues.get("strSalary")));
						responseDataMap.put("debitScore", Helper.correctNull((String)hshValue.get("strdebitscore")));
						responseDataMap.put("birDate", Helper.correctNull((String)hshValue.get("strbirdate")));
						arrValues.add(responseDataMap);
						
					}
					
				}
				strResponseCode="LAPS-1010";
				strResponseMsg="Pre Approved Offer Completed Successfully";
				responseData.put("preApprovedOffer", arrValues);
			}
			else
			{
				responseData.put("DataExist", "No");
				responseData.put("debitScore", Helper.correctNull((String)hshValue.get("strdebitscore")));
				responseData.put("birDate", Helper.correctNull((String)hshValue.get("strbirdate")));
				strResponseCode="LAPS-1011";
				strResponseMsg="Pre Approved Offer Completed Successfully";
			}
				
			}
			response.setData(responseData);
			response.setResp_code(strResponseCode);
			response.setResp_msg(strResponseMsg);
			 
			jsonAsString = objectMapper.writeValueAsString(response);
		}
		catch (Exception e)
		{
			response.setData(responseDataMap);
			response.setResp_code("LAPS-2003");
			response.setResp_msg("Invalid request parameters");
			jsonAsString = objectMapper.writeValueAsString(response);
			e.printStackTrace();
			throw new EJBException("Exception in preApprovedOfferService ==="+e.getMessage());
			
		}
		return jsonAsString;
	}
	
	//@Override
	public String handleStatusDetails(StatusCheck StatusCheck) throws JsonProcessingException {
		
		Map<String,Object> responseDataMap = new HashMap<String, Object>();
		
		Response response = new Response();
		String jsonAsString = "";
		ArrayList arrValues = new ArrayList();
		HashMap hshValues = new HashMap();
		HashMap hshValue = new HashMap();
		HashMap responseData = new HashMap();
		String strApplExists="", strStatus="";
		
		String strResponseMsg="",strResponseCode="", strLapsProposalNumber="", strAppReferenceNumber="";
				   
		try
		{
			JSONObject jsonObj = new JSONObject(StatusCheck);

			
			if (!jsonObj.isNull("lapsProposalNumber"))
				strLapsProposalNumber    = Helper.correctNull(jsonObj.getString("lapsProposalNumber"));
			if (!jsonObj.isNull("appReferenceNumber"))
				strAppReferenceNumber    = Helper.correctNull(jsonObj.getString("appReferenceNumber"));
			
			/*if(strLapsApplicationNumber.equals("") || strAppReferenceNumber.equals(""))
			{
				return Constants.ERROR_RESPONSE_MANDATORY;
			}*/
			
			
			
			HashMap hshJsonValues = new HashMap();
			
			if(!strLapsProposalNumber.equals(""))
			{
				hshJsonValues.put("strLapsProposalNumber",strLapsProposalNumber);
			}
			
			if(!strAppReferenceNumber.equals(""))
			{
				hshJsonValues.put("strAppReferenceNumber",strAppReferenceNumber);
			}
			
			
			
			
				
			hshValue = (HashMap) EJBInvoker.executeStateLess("DigitalAppInterface",hshJsonValues,"handleStatusDetails");
			
			if(hshValue!=null){
				
				System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$ hshValue.size() &&&&&&&&&&&&&&&&&&&&&&&    "+hshValue.size());
				
				strApplExists  = Helper.correctNull((String)hshValue.get("strApplExists"));
				
				if(strApplExists.equals("Y"))
				{
					
					responseDataMap.put("sanctionRefNumber", Helper.correctNull((String)hshValue.get("strSantionRefNumber")));
					responseDataMap.put("sanctionDate", Helper.correctNull((String)hshValue.get("strSantionDate")));
					responseDataMap.put("accNumber", Helper.correctNull((String)hshValue.get("strAccNumber")));
					responseDataMap.put("cbsId", Helper.correctNull((String)hshValue.get("strCBSId")));
					responseDataMap.put("accountOpeningDate", Helper.correctNull((String)hshValue.get("strAccountOpeningDate")));
					responseDataMap.put("status", Helper.correctNull((String)hshValue.get("strAppstatus")));
					responseDataMap.put("statusCode",Helper.correctNull((String)hshValue.get("strAppstatusCode")));
					responseDataMap.put("lastBIRreportDate",Helper.correctNull((String)hshValue.get("BIR_reportdate")));
					responseDataMap.put("mclrBaseRate",Helper.correctNull((String)hshValue.get("mclrbaserate")));
					responseDataMap.put("proceedSanction",Helper.correctNull((String)hshValue.get("proceedSanction")));
					responseDataMap.put("mandateCheck",Helper.correctNull((String)hshValue.get("strEman")));
					
					strResponseCode="LAPS-1015";
					strResponseMsg="Status Check Completed Successfully";
				}
				else
				{
					responseDataMap.put("DataExist", "No");
					
					strResponseCode="LAPS-1016";
					strResponseMsg="Status Check Completed Successfully";
				}
				
			}//if
			
			response.setData(responseDataMap);
			response.setResp_code(strResponseCode);
			response.setResp_msg(strResponseMsg);
			 
			jsonAsString = objectMapper.writeValueAsString(response);
		}
		catch (Exception e)
		{
			response.setData(responseDataMap);
			response.setResp_code("LAPS-2003");
			response.setResp_msg("Invalid request parameters");
			jsonAsString = objectMapper.writeValueAsString(response);
			e.printStackTrace();
			throw new EJBException("Exception in handleStatusDetails ==="+e.getMessage());
		}
		return jsonAsString;
	}
	
	//@Override
	public String accountOpeningTriggerService(StatusCheck StatusCheck)throws JsonProcessingException {
			
			Map<String,Object> responseDataMap = new HashMap<String, Object>();
			
			Response response = new Response();
			String jsonAsString = "";
			ArrayList arrValues = new ArrayList();
			HashMap hshValues = new HashMap();
			HashMap hshValue = new HashMap();
			HashMap responseData = new HashMap();
			HashMap accountFlat = new HashMap();
			HashMap hshJsonValues = new HashMap();
			HashMap laonAccCreation = new HashMap();
			ResultSet rs= null,rs1=null,rs3=null,rs2=null;
			String strResponseMsg="",strResponseCode="", strLapsProposalNumber="", strAppReferenceNumber="",strresultmsg="",strQuery="";
			String mobilebankingtype="";
			try
			{
				
				/*DocumentBuilderFactory factory = DocumentBuilderFactory
						.newInstance();
				DocumentBuilder builder = factory.newDocumentBuilder();
				InputSource inputSource = new InputSource(
						new StringReader(result.toString()));
				Document doc = builder.parse(inputSource);
				NodeList children = doc
						.getElementsByTagName("LoanAcctAddRs");
				XPath xpath = XPathFactory.newInstance().newXPath();*/
				
				JSONObject jsonObj = new JSONObject(StatusCheck);

				
				if (!jsonObj.isNull("lapsProposalNumber"))
				{
				strLapsProposalNumber    = Helper.correctNull(jsonObj.getString("lapsProposalNumber"));
				}
				if (!jsonObj.isNull("mobilebanking"))
				{
					mobilebankingtype    = Helper.correctNull(jsonObj.getString("mobilebanking"));
				}
				
				hshValues.put("appno", strLapsProposalNumber);
				hshValues.put("strmobilebankingtype", mobilebankingtype);
				hshValues.put("moduleType", "RETDIGI");
				strQuery=SQLParser.getSqlQuery("sel_depositmanualcreation^"+strLapsProposalNumber);
				rs2=DBUtils.executeQuery(strQuery);
				if(rs2.next())
				{//aif
					hshValues.put("strPrdType", Helper.correctNull((String)rs2.getString("prd_type")));
					hshValues.put("strdigiType", Helper.correctNull((String)rs2.getString("APP_LOANSUBTYPE_DIGI")));			
					}
				if(rs2!=null){
					rs2.close();
				}
				int count=0,count1=0;
				strQuery=SQLParser.getSqlQuery("sel_AccountHandOffDetails^"+strLapsProposalNumber);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{//aif
					count =1;
				}
				
				strQuery=SQLParser.getCBSSqlQuery("sel_cbs_accno_fromfinacle_newconnection^"+strLapsProposalNumber);
				rs1=DBUtils.executeQueryCBSConnection(strQuery);
				if(rs1.next())
				{//cbs
					count1 =1;
				}
				
				//if(!(rs.next() || rs1.next()))
				if(count!=1 && count1!=1 )
				{
				FinacleInterfaceBean getAccountFlatFileReportObj=new FinacleInterfaceBean();
				accountFlat=getAccountFlatFileReportObj.getOtherFlatFileReport(hshValues);
				
				log.info("Loan Account Trigger Service ========== Data Pushed to Staging Table");
				}
				else if(count==1 && count1!=1 ){
					HashMap	hshQuery=new HashMap();
					HashMap	hshQueryValues=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "deleteAccountHandOffDetails");
					arrValues.add(strLapsProposalNumber);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					
					strQuery=SQLParser.getSqlQuery("sel_AccountHandOffDetails^"+strLapsProposalNumber);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						count =1;
					}
					
					strQuery=SQLParser.getCBSSqlQuery("sel_cbs_accno_fromfinacle_newconnection^"+strLapsProposalNumber);
					rs1=DBUtils.executeQueryCBSConnection(strQuery);
					if(rs1.next())
					{
						count1 =1;
					}
					//if(!(rs.next()&& rs1.next()))
					if(count!=1 &&	 count1!=1 )
					{
						hshValues.put("moduleType", "RETDIGI");
						FinacleInterfaceBean getAccountFlatFileReportObj=new FinacleInterfaceBean();
						accountFlat=getAccountFlatFileReportObj.getOtherFlatFileReport(hshValues);
						
						log.info("Loan Account Trigger Service ========== Data Pushed to Staging Table");
					}
					
				}else{
					log.info("");
					
				}
				DigitalAppInterfaceBean digitalAppInterfaceBean=new DigitalAppInterfaceBean();
				laonAccCreation=digitalAppInterfaceBean.loanAccountCreationService(hshValues);	
				responseDataMap.put("resultMSG", Helper.correctNull((String)laonAccCreation.get("resultmsg")));
				responseDataMap.put("status", Helper.correctNull((String)laonAccCreation.get("strstatus")));
				responseDataMap.put("accountNumber", Helper.correctNull((String)laonAccCreation.get("strAccountno")));
				
				if(!strLapsProposalNumber.equals(""))
				{
					hshJsonValues.put("strLapsProposalNumber",strLapsProposalNumber);
				}
			
				strResponseCode="LAPS-1018";
				strResponseMsg="Account Trigger Service completed successfully";
				response.setData(responseDataMap);
				response.setResp_code(strResponseCode); 
				response.setResp_msg(strResponseMsg);
				
				jsonAsString = objectMapper.writeValueAsString(response);
		
			
			}
			
			catch (Exception e)
			{
				response.setData(responseDataMap);
				response.setResp_code("LAPS-2003");
				response.setResp_msg("Invalid request parameters");
				jsonAsString = objectMapper.writeValueAsString(response);
				e.printStackTrace();
				throw new EJBException("Exception in accountOpeningTriggerService ==="+e.getMessage());
			}
			return jsonAsString;
		}
	



//@Override
public String mclrService(StatusCheck StatusCheck)throws JsonProcessingException {
		
		Map<String,Object> responseDataMap = new HashMap<String, Object>();
		
		Response response = new Response();
		String jsonAsString = "";
		ArrayList arrValues = new ArrayList();
		HashMap hshValues = new HashMap();
		HashMap hshValue = new HashMap();
		HashMap responseData = new HashMap();
		HashMap accountFlat = new HashMap();
		HashMap hshJsonValues = new HashMap();
		HashMap laonAccCreation = new HashMap();
		String strmclrtype="",strResponseMsg="",strResponseCode="";
		
		try
		{
			
			
		/*DigitalAppInterfaceBean obj=new DigitalAppInterfaceBean();
			obj.cbsBreService(hshValues);
			*/
			
			JSONObject jsonObj = new JSONObject(StatusCheck);
			if (!jsonObj.isNull("mclrtype"))
			{
				strmclrtype= Helper.correctNull(jsonObj.getString("mclrtype"));	
				
				ResultSet rs=null;
				String strQuery="",strbaserated="";
				strQuery=SQLParser.getSqlQuery("sel_mclrmaster_type^"+strmclrtype);
				rs=DBUtils.executeQuery(strQuery);	
				if(rs.next())
				{
					//strLoanProduct=Helper.correctNull((String)rs.getString("PRD_CODE"));
				strbaserated=Helper.correctNull((String)rs.getString("MCLR_BASERATESPREAD"));
				}	
				
				responseDataMap.put("mclrRate",strbaserated );	
			}
		
			strResponseCode="LAPS-1020";
			strResponseMsg="Mclr Service completed successfully";
			response.setData(responseDataMap);
			response.setResp_code(strResponseCode); 
			response.setResp_msg(strResponseMsg);
			
			jsonAsString = objectMapper.writeValueAsString(response);
		}
		
		catch (Exception e)
		{
			response.setData(responseDataMap);
			response.setResp_code("LAPS-2003");
			response.setResp_msg("Invalid request parameters");
			jsonAsString = objectMapper.writeValueAsString(response);
			e.printStackTrace();
			throw new EJBException("Exception in MclrService==="+e.getMessage());
		}
		return jsonAsString;



}

//@Override
public String dosanction(StatusCheck StatusCheck)throws JsonProcessingException {
		
		Map<String,Object> responseDataMap = new HashMap<String, Object>();
		HashMap dosanction = new HashMap();
		Response response = new Response();
		String jsonAsString = "";
		ArrayList arrValues = new ArrayList();
		HashMap hshValues = new HashMap();
		HashMap hshValue = new HashMap();
		HashMap responseData = new HashMap();
		
		HashMap hshJsonValues = new HashMap();
		
		String strResponseMsg="",strResponseCode="", strLapsProposalNumber="", strAppReferenceNumber="",result="",strQuery="",strSanctioncheck="",manualcheck="",strUserId="";
		ResultSet rs=null;

		try
		{
			
			
			
			JSONObject jsonObj = new JSONObject(StatusCheck);
			
			
			hshValues.put("hidAction", "submit");
			if (!jsonObj.isNull("lapsProposalNumber"))
				strLapsProposalNumber= Helper.correctNull(jsonObj.getString("lapsProposalNumber"));
			if(!jsonObj.isNull("userId"))
				strUserId = Helper.correctNull(jsonObj.getString("userId"));
			
			hshValues.put("strappno", strLapsProposalNumber);
			hshValues.put("strUserId", strUserId);  
			
			
			if(rs!=null)
				{ rs.close(); }
			String strAppStatus="",app_processdate="";
			strQuery=SQLParser.getSqlQuery("sel_productcode^"+strLapsProposalNumber);
			rs=DBUtils.executeQuery(strQuery);	
			if(rs.next())
			{
				strAppStatus=Helper.correctNull((String)rs.getString("app_status"));
				app_processdate=Helper.correctNull((String)rs.getString("app_processdate"));
			}
			
			if(rs!=null)
			{ rs.close(); }
			String sancrefno="";
			strQuery=SQLParser.getSqlQuery("sel_SancRefNo^"+strLapsProposalNumber);
			rs=DBUtils.executeQuery(strQuery);	
			if(rs.next())
			{
				sancrefno=Helper.correctNull((String)rs.getString("sanctionrefno"));
			}
			
			
			rs=DBUtils.executeLAPSQuery("sel_statuscheckAPI^"+strLapsProposalNumber);
			if(rs.next())
			{
				
				strSanctioncheck=Helper.correctNull((String)rs.getString("PERAPP_CBSCUSTFLAG"));
			
			}
			
			/*rs = DBUtils.executeLAPSQuery("select_verifydocument^" + strLapsProposalNumber);
			if(rs.next())
			{
					
				manualcheck = Helper.correctNull((String)rs.getString("VERI_MANCHECK_COMPLETED"));						
			}
			
			if(!manualcheck.equalsIgnoreCase("on"))
			{
				strSanctioncheck="N";
			}*/
			
			//String strproceedSanction = Helper.correctNull((String)hshValues.get("proceedSanction"));
			if(strSanctioncheck.equals("N"))
			{
				
				strResponseCode="LAPS-1023";
				strResponseMsg="Customer Creation/Modification is not completed";
			
			}
			else	
			{	
			if(strAppStatus.equals("op"))
			{
				hshValues.put("apisanc", "Y");
				DigitalAppInterfaceBean digitalAppInterfaceBean= new DigitalAppInterfaceBean();
				dosanction= digitalAppInterfaceBean.updateSanctionDetails(hshValues);
				responseDataMap.put("appReferenceNumber", Helper.correctNull((String)dosanction.get("strReferenceno")));
				responseDataMap.put("sanctionDate", Helper.correctNull((String)dosanction.get("strSanctionDate")));
				responseDataMap.put("proposalNumber", strLapsProposalNumber);
				
				strResponseCode="LAPS-1021";
				strResponseMsg="Sanction Service completed successfully";
			}
			else
			{
				responseDataMap.put("appReferenceNumber", sancrefno);
				responseDataMap.put("sanctionDate", app_processdate);
				responseDataMap.put("proposalNumber",strLapsProposalNumber);
				strResponseCode="LAPS-1022";
				strResponseMsg="Proposal is already Sanctioned/Invalid Proposal Number";
			}
			
			}
			
			response.setData(responseDataMap);
			response.setResp_code(strResponseCode); 
			response.setResp_msg(strResponseMsg);		
			
			jsonAsString = objectMapper.writeValueAsString(response);
			
			
		}
		
		catch (Exception e)
		{
			response.setData(responseDataMap);
			response.setResp_code("LAPS-2003");
			response.setResp_msg("Invalid request parameters");
			jsonAsString = objectMapper.writeValueAsString(response);
			e.printStackTrace();
			throw new EJBException("Exception in dosSanction Service ==="+e.getMessage());
		}
		return jsonAsString;
	}
	

	
	//@Override
	public String cbsBreService(PreApprovedOffer hshValues) throws com.fasterxml.jackson.core.JsonProcessingException
	
	{
		JSONObject jsonObj = new JSONObject(hshValues);
		String strCbsID="";
		Map<String,Object> responseDataMap = new HashMap<String, Object>();
		HashMap breService = new HashMap();
		Response response = new Response();
		HashMap responseData = new HashMap();
		JSONObject data = new JSONObject();
		JSONObject objTable = new JSONObject();
		JSONObject dateofsavingdata = new JSONObject();
		
		HashMap hshVal = new HashMap();
		ArrayList arrValue = null;
		
		ArrayList atmwitwralarrValues=null;
		HashMap hshValue = new HashMap();
		HashMap hshValue1 = new HashMap();
		
	
	
		
	HashMap hshRecord=new HashMap();	
	ResultSet rs=null,rs1=null;
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = new HashMap();
	ArrayList arrValues = new ArrayList();
	String strRequestUUID, strServiceRequestVersion,strChannelId,RetCustAdd,strBankId,strMessageDateTime,strRequestId,strInputVal,
	strInputXMLRequest="",strStatus="", line="",jsonAsString ="";
	
	
	try
	{
		
	if (!jsonObj.isNull("customerID"))
	strCbsID = Helper.correctNull(jsonObj.getString("customerID"));
	hshValue.put("strCustomerID", strCbsID);
	DigitalAppInterfaceBean digitalAppInterfaceBean= new DigitalAppInterfaceBean();
	breService=digitalAppInterfaceBean.cbsBreService(hshValue);
	
	
	
	
	
	}
	catch (Exception e)
	{
		response.setData(responseDataMap);
		response.setResp_code("LAPS-");
		response.setResp_msg("Invalid request parameters");
		jsonAsString = objectMapper.writeValueAsString(response);
		e.printStackTrace();
		throw new EJBException("Exception in Bre Service ==="+e.getMessage());
	}
	
	return jsonAsString;
	}
	
	public String autoloanDedupeCheck(DedupeCheck DedupeCheck)throws JsonProcessingException {
	// TODO Auto-generated method stub
		
	
	Map<String,Object> responseData = new HashMap<String,Object>();
	Response response = new Response();
	String jsonAsString = "";
	JSONObject objOuter        = new JSONObject();
	JSONObject PrintObject     = new JSONObject();
	HashMap hshValues 		   = new HashMap();
	String strApplExists="",strStatus="";
	
	String strResponseMsg="",strResponseCode="",strPANno="", strCBSid="";
	
	try
	{
	
	JSONObject jsonCIFReqObj= new JSONObject(DedupeCheck);
	
	
	if (!jsonCIFReqObj.isNull("panno"))
		strPANno    = jsonCIFReqObj.getString("panno");
	if (!jsonCIFReqObj.isNull("cbsid"))
		strCBSid    = jsonCIFReqObj.getString("cbsid");
	
	//Mandatory Check
	if(strPANno.equals("") && strCBSid.equals("") )
	{
		return Constants.ERROR_RESPONSE_MANDATORY;
	}
	
	if(!strPANno.equals(""))
	{
		Pattern pattern = Pattern.compile("[A-Z]{5}[0-9]{4}[A-Z]{1}");
		Matcher matcher = pattern.matcher(strPANno);
		if (!matcher.matches()) 
		{
			return Constants.ERROR_RESPONSE_INVALID_PANNO;
		}
	}
	
	HashMap hshJsonValues = new HashMap();
	hshJsonValues.put("strPANno",strPANno);
	hshJsonValues.put("strCBSid",strCBSid);
	
	
	hshValues = (HashMap) EJBInvoker.executeStateLess("DigitalAppInterface",hshJsonValues,"autoLoanDedupeCheck");
	strApplExists  = Helper.correctNull((String)hshValues.get("strApplExist"));
	
	if(strApplExists.equals("Y"))
	{
		responseData.put("ApplicationExist", "Yes");
		responseData.put("CBSID", Helper.correctNull((String)hshValues.get("strCusCBSID")));
		responseData.put("CustomerName", Helper.correctNull((String)hshValues.get("strCusName")));
		responseData.put("CustomerFatherName", Helper.correctNull((String)hshValues.get("strCusFatherName")));
		responseData.put("CustomerDOB", Helper.correctNull((String)hshValues.get("strCustDOB")));
		responseData.put("CustomerPANNumber", Helper.correctNull((String)hshValues.get("strCustPANno")));
		responseData.put("LAPSProposalNumber", Helper.correctNull((String)hshValues.get("strAppno")));
		responseData.put("LAPSProposalStatus", Helper.correctNull((String)hshValues.get("strAppStatus")));
		responseData.put("CustomerMobileNumber", Helper.correctNull((String)hshValues.get("strmobileno")));
		//responseData.put("birDate", Helper.correctNull((String)hshValues.get("strBIRdate")));
		responseData.put("DigiAppNo", Helper.correctNull((String)hshValues.get("strdigiappno")));

		strResponseCode="LAPS-1009";
		strResponseMsg="Dedupe Check Completed Successfully";
	}
	else
	{
		responseData.put("ApplicationExist", "No");
		//responseData.put("birDate", Helper.correctNull((String)hshValues.get("strBIRdate")));
		responseData.put("LAPSProposalNumber", Helper.correctNull((String)hshValues.get("strAppno")));
		responseData.put("applicationDate", Helper.correctNull((String)hshValues.get("strappcreatedate")));
		strResponseCode="LAPS-1004";
		strResponseMsg="Dedupe Check Completed Successfully";
	}
	
	response.setData(responseData);
	response.setResp_code(strResponseCode);
	response.setResp_msg(strResponseMsg);
	
	jsonAsString = objectMapper.writeValueAsString(response);
	}
	catch (Exception e)
	{
	response.setData(responseData);
	response.setResp_code("LAPS-2003");
	response.setResp_msg("Invalid request parameters");
	jsonAsString = objectMapper.writeValueAsString(response);
	e.printStackTrace();
	throw new EJBException("Error in inwardDetailServiceImpl dedupeCheck..."+e.toString());
	}
	return jsonAsString;	
	}


public String autoLoanproposalCreation(ProposalCreation proposalCreation)
		throws JsonProcessingException {
	// TODO Auto-generated method stub
	
	Map<String,Object> responseData = new HashMap<String,Object>();
	Response response = new Response();
	String jsonAsString = "";
	JSONObject objOuter        = new JSONObject();
	JSONObject PrintObject     = new JSONObject();
	HashMap hshValues 		   = new HashMap();
	String strApplExists="",strStatus="";
	
	String strResponseMsg="",strResponseCode="",strPANno="", strCustomerID="",strlapsID="",strloanType="",strEMIamount="",strmclrType="";
	
	String strLARno="",strAmountRequested="",strSinglePremium="",strProjectCost="",strLoanTenor="",strHolidayPeriod="",strPurposeLoan="",strApplicationBranch="";
	
	String strPartyFileno="",strLoanProduct="",strInterestType="",strInterestRate="",strPeriodicityInstallments=""
							,strGovtSponserScheme="",strTakeover="",strRepaymentType="",strProcessingFee=""
							,strWhetherSecured="",strPaymentMode="",strProposalType="",strApplicationHolder=""
							,strmisActivityCode="", strprocesssingFeeCollected = "",strsanctionStatus="";
	
	String strdeviation="",strapplicationScore="",strappscoredeviation="",strcategoryLoanPurpose="",strpremisesAge="",strsecurityId="",strOperativeAccNo="",
	 strInsuranceAmntFundedBy="", strInsuranceAmount="", strPremiumTenor="",strLoanAmountCovered="",strMargin="",strVehiclePurchase="", strVehicleCost="", strTax="",
	 strOtherCharges="", strAccessoriesPrice="",strInsurance="", strDiscount="",strTotalCost="",strVerificationDoneBy="",strCostAlreadyIncurred="", strOwnSavingAndDisposalInvest="",strinterestCollected="";
	String strtermCond="",strcreditRiskPremium="",strbusinessStrategicPremium="",strfuelUsed="",strcustomerBackgroundComments="",strDigiAppno="",strPerRefNo="",strScheme="",
	strPrdctDesc="",strPrdIdentification="",strpenalInterest="",strinterestConcession="",strecsBankName="",strecsAccountType="",strecsOperAccountType="",strecsAuthunenticateMode="",strecsIFSCCODE="",strgstVerification=""
		,strupfrontfee="";

	try
	{
		JSONObject jsonCIFReqObj		= new JSONObject(proposalCreation);
		
		
		if (!jsonCIFReqObj.isNull("larNumber"))
			strLARno    = jsonCIFReqObj.getString("larNumber");
		if (!jsonCIFReqObj.isNull("customerID"))
			strCustomerID    = jsonCIFReqObj.getString("customerID");	
		if (!jsonCIFReqObj.isNull("lapsID"))
			strlapsID    = jsonCIFReqObj.getString("lapsID");
		if (!jsonCIFReqObj.isNull("loanType"))
			strloanType    = jsonCIFReqObj.getString("loanType");
		if (!jsonCIFReqObj.isNull("amountRequested"))
			strAmountRequested    = jsonCIFReqObj.getString("amountRequested");
		if (!jsonCIFReqObj.isNull("singlePremium"))
			strSinglePremium    = jsonCIFReqObj.getString("singlePremium");
		if (!jsonCIFReqObj.isNull("projectCost"))
			strProjectCost    = jsonCIFReqObj.getString("projectCost");
		if (!jsonCIFReqObj.isNull("loanTenor"))
			strLoanTenor    = jsonCIFReqObj.getString("loanTenor");
		if (!jsonCIFReqObj.isNull("holidayPeriod"))
			strHolidayPeriod    = jsonCIFReqObj.getString("holidayPeriod");
		if (!jsonCIFReqObj.isNull("loanPurpose"))
			strPurposeLoan    = jsonCIFReqObj.getString("loanPurpose");
		if (!jsonCIFReqObj.isNull("applicationBranch"))
			strApplicationBranch    = jsonCIFReqObj.getString("applicationBranch");
		if (!jsonCIFReqObj.isNull("interestRate"))
			strInterestRate    = jsonCIFReqObj.getString("interestRate");
		if (!jsonCIFReqObj.isNull("emiAmount"))
			strEMIamount    = jsonCIFReqObj.getString("emiAmount");
		if (!jsonCIFReqObj.isNull("misActivityCode"))
			strmisActivityCode    = jsonCIFReqObj.getString("misActivityCode");
		if (!jsonCIFReqObj.isNull("mclrType"))
			strmclrType    = jsonCIFReqObj.getString("mclrType");
		if (!jsonCIFReqObj.isNull("paymentMode"))
			strPaymentMode    = jsonCIFReqObj.getString("paymentMode");
		if (!jsonCIFReqObj.isNull("processingFee"))
			strProcessingFee    = jsonCIFReqObj.getString("processingFee");
		if (!jsonCIFReqObj.isNull("processsingFeeCollected"))
			strprocesssingFeeCollected    = jsonCIFReqObj.getString("processsingFeeCollected");
		
		if (!jsonCIFReqObj.isNull("deviation"))
			strdeviation   = jsonCIFReqObj.getString("deviation");
		if (!jsonCIFReqObj.isNull("applicationScore"))
			strapplicationScore    = jsonCIFReqObj.getString("applicationScore");
		if (!jsonCIFReqObj.isNull("applicationScore"))
			strapplicationScore    = jsonCIFReqObj.getString("applicationScore");
		if (!jsonCIFReqObj.isNull("appScoreDeviation"))
			strappscoredeviation    = jsonCIFReqObj.getString("appScoreDeviation"); 
		if (!jsonCIFReqObj.isNull("sanctionStatus"))
			strsanctionStatus    = jsonCIFReqObj.getString("sanctionStatus");
		if (!jsonCIFReqObj.isNull("categoryLoanPurpose"))
			strcategoryLoanPurpose    = jsonCIFReqObj.getString("categoryLoanPurpose");
		if (!jsonCIFReqObj.isNull("premisesAge"))
			strpremisesAge    = jsonCIFReqObj.getString("premisesAge");
		/*if (!jsonCIFReqObj.isNull("securityId"))
			strsecurityId    = jsonCIFReqObj.getString("securityId");
		*/
		//if(strPaymentMode.equalsIgnoreCase("E"))
		{
			if (!jsonCIFReqObj.isNull("operativeAccountNo"))
				strOperativeAccNo    = jsonCIFReqObj.getString("operativeAccountNo");
		}
		 
		if (!jsonCIFReqObj.isNull("insuranceAmntFundedBy"))
			strInsuranceAmntFundedBy    = jsonCIFReqObj.getString("insuranceAmntFundedBy");
		if (!jsonCIFReqObj.isNull("insuranceAmount"))
			strInsuranceAmount    = jsonCIFReqObj.getString("insuranceAmount");
		if (!jsonCIFReqObj.isNull("premiumTenor"))
			strPremiumTenor    = jsonCIFReqObj.getString("premiumTenor");
		if (!jsonCIFReqObj.isNull("loanAmountCovered"))
			strLoanAmountCovered    = jsonCIFReqObj.getString("loanAmountCovered");
		if (!jsonCIFReqObj.isNull("margin"))
			strMargin    = jsonCIFReqObj.getString("margin");
		if (!jsonCIFReqObj.isNull("vehiclePurchase"))
			strVehiclePurchase    = jsonCIFReqObj.getString("vehiclePurchase");
		if (!jsonCIFReqObj.isNull("vehicleCost"))
			strVehicleCost    = jsonCIFReqObj.getString("vehicleCost");
		if (!jsonCIFReqObj.isNull("tax"))
			strTax    = jsonCIFReqObj.getString("tax");
		if (!jsonCIFReqObj.isNull("otherCharges"))
			strOtherCharges    = jsonCIFReqObj.getString("otherCharges");
		if (!jsonCIFReqObj.isNull("accessoriesPrice"))
			strAccessoriesPrice    = jsonCIFReqObj.getString("accessoriesPrice");
		if (!jsonCIFReqObj.isNull("insurance"))
			strInsurance    = jsonCIFReqObj.getString("insurance");
		if (!jsonCIFReqObj.isNull("discount"))
			strDiscount    = jsonCIFReqObj.getString("discount");
		if (!jsonCIFReqObj.isNull("totalCost"))
			strTotalCost    = jsonCIFReqObj.getString("totalCost");
		if (!jsonCIFReqObj.isNull("verificationDoneBy"))
			strVerificationDoneBy    = jsonCIFReqObj.getString("verificationDoneBy");
		if (!jsonCIFReqObj.isNull("costAlreadyIncurred"))
			strCostAlreadyIncurred    = jsonCIFReqObj.getString("costAlreadyIncurred");
		if (!jsonCIFReqObj.isNull("ownSavingAndDisposalInvest"))
			strOwnSavingAndDisposalInvest   = jsonCIFReqObj.getString("ownSavingAndDisposalInvest");
		
		if (!jsonCIFReqObj.isNull("interestCollected"))
			strinterestCollected   = jsonCIFReqObj.getString("interestCollected");
		
		if (!jsonCIFReqObj.isNull("installmentPeriodicity"))
			strPeriodicityInstallments   = jsonCIFReqObj.getString("installmentPeriodicity");
		
		JSONArray jsonCoAppplicant		= new JSONArray();

		if (!jsonCIFReqObj.isNull("coApplicant"))
			jsonCoAppplicant=jsonCIFReqObj.getJSONArray("coApplicant");

		if (!jsonCIFReqObj.isNull("termAndCondition"))
			strtermCond    = jsonCIFReqObj.getString("termAndCondition");
		
		if (!jsonCIFReqObj.isNull("creditRiskPremium"))
			strcreditRiskPremium    = jsonCIFReqObj.getString("creditRiskPremium");
		if (!jsonCIFReqObj.isNull("businessStrategicPremium"))
			strbusinessStrategicPremium    = jsonCIFReqObj.getString("businessStrategicPremium");
		
		if (!jsonCIFReqObj.isNull("fuelUsed"))
			strfuelUsed    = jsonCIFReqObj.getString("fuelUsed");
		
		if (!jsonCIFReqObj.isNull("customerBackgroundComments"))
			strcustomerBackgroundComments   = jsonCIFReqObj.getString("customerBackgroundComments");
		
		if (!jsonCIFReqObj.isNull("digiAppNo"))
			strDigiAppno   = jsonCIFReqObj.getString("digiAppNo");
		
		if (!jsonCIFReqObj.isNull("permissionRefNo"))
			strPerRefNo   = jsonCIFReqObj.getString("permissionRefNo");
		
		if (!jsonCIFReqObj.isNull("repaymentType"))
			strRepaymentType=jsonCIFReqObj.getString("repaymentType");
		
		if (!jsonCIFReqObj.isNull("scheme"))
			strScheme=jsonCIFReqObj.getString("scheme");
		
		if (!jsonCIFReqObj.isNull("productDesc"))
			strPrdctDesc=jsonCIFReqObj.getString("productDesc");
		
		if (!jsonCIFReqObj.isNull("productIdentification"))
			strPrdIdentification=jsonCIFReqObj.getString("productIdentification");
		
		if (!jsonCIFReqObj.isNull("penalInterest"))
			strpenalInterest=jsonCIFReqObj.getString("penalInterest");
		
		if (!jsonCIFReqObj.isNull("interestConcession"))
			strinterestConcession=jsonCIFReqObj.getString("interestConcession");
		
		if (!jsonCIFReqObj.isNull("ecsBankName"))
			strecsBankName    = jsonCIFReqObj.getString("ecsBankName");
		
		if (!jsonCIFReqObj.isNull("ecsAccountType"))
			strecsAccountType    = jsonCIFReqObj.getString("ecsAccountType");
		
		if (!jsonCIFReqObj.isNull("ecsOperAccountType"))
			strecsOperAccountType   = jsonCIFReqObj.getString("ecsOperAccountType");
		
		if (!jsonCIFReqObj.isNull("ecsAuthunenticateMode"))
			strecsAuthunenticateMode    = jsonCIFReqObj.getString("ecsAuthunenticateMode");
		
		if (!jsonCIFReqObj.isNull("ecsIFSCCODE"))
			strecsIFSCCODE   = jsonCIFReqObj.getString("ecsIFSCCODE");
		
		if (!jsonCIFReqObj.isNull("gstVerification"))
			strgstVerification   = jsonCIFReqObj.getString("gstVerification");
		
		if (!jsonCIFReqObj.isNull("upfrontfee"))
			strupfrontfee   = jsonCIFReqObj.getString("upfrontfee");
		
		JSONObject jsonCoapp= new JSONObject();
		
		int coappsize=jsonCoAppplicant.length();
		ArrayList arrcoapp=new ArrayList();
		ArrayList arrcoappvalues=new ArrayList();
		if(coappsize>0)
		{
			for(int i=0;i<coappsize;i++)
			{
				jsonCoapp=(JSONObject) jsonCoAppplicant.get(i);
				
				String coappName=jsonCoapp.getString("coapplicantName");
				String coappType=jsonCoapp.getString("coapplicantType");
				String coappLAPSID=jsonCoapp.getString("coapplicantLAPSID");
				String coappCBSID=jsonCoapp.getString("coapplicantCBSID");
				String coappRelation=jsonCoapp.getString("coapplicantRelation");
				String coappIncome=jsonCoapp.getString("coaplicantIncome");
				
				arrcoappvalues=new ArrayList();
				arrcoappvalues.add(coappName);
				arrcoappvalues.add(coappType);
				arrcoappvalues.add(coappLAPSID);
				arrcoappvalues.add(coappCBSID);
				arrcoappvalues.add(coappRelation);
				arrcoappvalues.add(coappIncome);
				arrcoapp.add(arrcoappvalues);
			}
		}
		
		JSONArray jsonRepaymentSchedule=new JSONArray();

		if (!jsonCIFReqObj.isNull("repaymentSchedule"))
			jsonRepaymentSchedule=jsonCIFReqObj.getJSONArray("repaymentSchedule");
		
		JSONObject jsonRepaySchedule= new JSONObject();
		int repaysize=jsonRepaymentSchedule.length();
		ArrayList arrRepayment=new ArrayList();
		ArrayList arrRepaymentValues=new ArrayList();
		if(repaysize>0)
		{
			for(int i=0;i<repaysize;i++)
			{
				jsonRepaySchedule=(JSONObject) jsonRepaymentSchedule.get(i);
				
				String frequency=jsonRepaySchedule.getString("frequency");
				String installAmount=jsonRepaySchedule.getString("installmentAmount");
				String noInstall=jsonRepaySchedule.getString("noInstallment");
				String totalAmnt=jsonRepaySchedule.getString("totalAmount");
				
				
				arrRepaymentValues=new ArrayList();
				arrRepaymentValues.add(frequency);
				arrRepaymentValues.add(installAmount);
				arrRepaymentValues.add(noInstall);
				arrRepaymentValues.add(totalAmnt);
				
				arrRepayment.add(arrRepaymentValues);
			}
		}
		
		
		JSONArray jsonSecId=new JSONArray();

		if (!jsonCIFReqObj.isNull("securityId"))
			jsonSecId=jsonCIFReqObj.getJSONArray("securityId");
		String strSecID="";
		int secIdLen=jsonSecId.length();
		ArrayList arrSecID=new ArrayList();
		
		if(secIdLen>0)
		{
			for(int i=0;i<secIdLen;i++)
			{
				arrSecID.add(jsonSecId.get(i));
			}
			}
		/*JSONObject jsonRepaySchedule= new JSONObject();
		int repaysize=jsonRepaymentSchedule.length();
		ArrayList arrRepayment=new ArrayList();
		ArrayList arrRepaymentValues=new ArrayList();*/
		
		if(secIdLen<1)
		{
			return Constants.ERROR_RESPONSE_MANDATORY;
		}
		
		//default values
		//strInterestRate="";
		/*if(strRepaymentType.equals("1"))
			strPeriodicityInstallments="m";
		else
			strPeriodicityInstallments="y";*/
		strGovtSponserScheme="2";
		strTakeover="N";
		strWhetherSecured="";
		strProposalType="F";
		strApplicationHolder="";	
		
		ResultSet rs=null,rs1=null;
		String strQuery="";
		//party file no
		strQuery=SQLParser.getSqlQuery("sel_partyfileno_ETB^"+strlapsID);
		if(rs!=null)
		{ rs.close(); }
		rs=DBUtils.executeQuery(strQuery);	
		if(rs.next())
		{
			strPartyFileno=Helper.correctNull((String) rs.getString("LOAN_FILENO"));
		}
		else
		{
			String strOrgShortCode=strApplicationBranch;
			int intLen=0;
			long longAppno=0;
			strOrgShortCode = strOrgShortCode.trim();
			int scodeLength=strOrgShortCode.length();
			java.text.NumberFormat nf=java.text.NumberFormat.getNumberInstance();
			nf.setMinimumIntegerDigits(7);
			nf.setGroupingUsed(false);
			
			if(scodeLength==1){
				strOrgShortCode="000"+strOrgShortCode;
			}
			if(scodeLength==2){
				strOrgShortCode="00"+strOrgShortCode;
			}
			if(scodeLength==3){
				strOrgShortCode="0"+strOrgShortCode;
			}
			
			intLen=strOrgShortCode.length();
			if(rs!=null)
			{	rs.close(); 	}
			strQuery=SQLParser.getSqlQuery("sel_getMaxPartyFileno^"+(intLen+1)+"^"+intLen+"^"+strOrgShortCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				longAppno=(rs.getLong(1));
			}
			longAppno++;
			strPartyFileno=strOrgShortCode+nf.format(longAppno);
		}
		
		// loan Product
		if(rs!=null)
		{ rs.close(); }
		String strProductType="";

			strProductType="pA";
			strInterestType="2";
			if(strPrdIdentification.equals("")){
			strQuery=SQLParser.getSqlQuery("sel_digiproduct_code^"+strProductType+"^"+strcategoryLoanPurpose+"^"+strAmountRequested+"^"+strRepaymentType);
			rs=DBUtils.executeQuery(strQuery);	
			if(rs.next())
			{
				strLoanProduct=Helper.correctNull((String)rs.getString("PRD_CODE"));
			}
			}else{
				
				strQuery=SQLParser.getSqlQuery("sel_digiprd_code_identification^"+strProductType+"^"+strcategoryLoanPurpose+"^"+strAmountRequested+"^"+strRepaymentType+"^"+strPrdIdentification);
				rs=DBUtils.executeQuery(strQuery);	
				if(rs.next())
				{
					strLoanProduct=Helper.correctNull((String)rs.getString("PRD_CODE"));
				}
				
			}

		
			JSONArray digiRating = new JSONArray();
			if (!jsonCIFReqObj.isNull("digiRating"))
				digiRating=jsonCIFReqObj.getJSONArray("digiRating");
			
			JSONObject jsondigirating= new JSONObject();
			int digiRatinglength=digiRating.length();
			ArrayList arraydigirating=new ArrayList();
			ArrayList arradigiratingValue=new ArrayList();
			String kbRating="";
			if(digiRatinglength>0){
				
				jsondigirating=	(JSONObject)digiRating.get(0);
				arradigiratingValue.add(jsondigirating.getString("commercialBureauScore"));
				arradigiratingValue.add(jsondigirating.getString("consumerIndScore"));
				arradigiratingValue.add(jsondigirating.getString("consumerPartyScore"));
				arradigiratingValue.add(jsondigirating.getString("odAccountScore"));
				arradigiratingValue.add(jsondigirating.getString("currentAccountScore"));
				arradigiratingValue.add(jsondigirating.getString("fsaScore"));
				arradigiratingValue.add(jsondigirating.getString("bandRating"));
				arradigiratingValue.add(jsondigirating.getString("bandPath"));
				//arradigiratingValue.add(jsondigirating.getString("kbRating"));
				
			if(jsondigirating.getString("bandRating").equalsIgnoreCase("Band 1")||jsondigirating.getString("bandRating").equalsIgnoreCase("Band1")||
			jsondigirating.getString("bandRating").equalsIgnoreCase("Band 2")||jsondigirating.getString("bandRating").equalsIgnoreCase("Band2"))
			    kbRating="KB1";		
			
			if(jsondigirating.getString("bandRating").equalsIgnoreCase("Band 3")||jsondigirating.getString("bandRating").equalsIgnoreCase("Band3"))
				kbRating="KB2";
			
			if(jsondigirating.getString("bandRating").equalsIgnoreCase("Band 4")||jsondigirating.getString("bandRating").equalsIgnoreCase("Band4")||
				jsondigirating.getString("bandRating").equalsIgnoreCase("Band 5")||jsondigirating.getString("bandRating").equalsIgnoreCase("Band5"))
				kbRating="KB3";
			
			if(jsondigirating.getString("bandRating").equalsIgnoreCase("Band 6")||jsondigirating.getString("bandRating").equalsIgnoreCase("Band6")||
				jsondigirating.getString("bandRating").equalsIgnoreCase("Band 7")||jsondigirating.getString("bandRating").equalsIgnoreCase("Band7"))
				kbRating="KB4";
			
			if(jsondigirating.getString("bandRating").equalsIgnoreCase("Band 8")||jsondigirating.getString("bandRating").equalsIgnoreCase("Band8"))
				kbRating="KB5";
			
			if(jsondigirating.getString("bandRating").equalsIgnoreCase("Band 9")||jsondigirating.getString("bandRating").equalsIgnoreCase("Band9"))
				kbRating="KB7";

			arradigiratingValue.add(kbRating);
			
			}
			
			
		
		HashMap hshJsonValues = new HashMap();
		hshJsonValues.put("strLARno",strLARno);
		hshJsonValues.put("strCustomerID",strCustomerID);
		hshJsonValues.put("strAmountRequested",strAmountRequested);
		hshJsonValues.put("strSinglePremium",strSinglePremium);
		hshJsonValues.put("strProjectCost",strProjectCost);
		hshJsonValues.put("strLoanTenor",strLoanTenor);
		hshJsonValues.put("strHolidayPeriod",strHolidayPeriod);
		hshJsonValues.put("strPurposeLoan",strPurposeLoan);
		hshJsonValues.put("strApplicationBranch",strApplicationBranch);
		hshJsonValues.put("strPartyFileno",strPartyFileno);
		hshJsonValues.put("strLoanProduct",strLoanProduct);
		hshJsonValues.put("strInterestType",strInterestType);
		hshJsonValues.put("strInterestRate",strInterestRate);
		hshJsonValues.put("strPeriodicityInstallments",strPeriodicityInstallments);
		hshJsonValues.put("strGovtSponserScheme",strGovtSponserScheme);
		hshJsonValues.put("strTakeover",strTakeover);
		hshJsonValues.put("strRepaymentType",strRepaymentType);
		hshJsonValues.put("strProcessingFee",strProcessingFee);
		hshJsonValues.put("strWhetherSecured",strWhetherSecured);
		hshJsonValues.put("strPaymentMode",strPaymentMode);
		hshJsonValues.put("strProposalType",strProposalType);
		hshJsonValues.put("strApplicationHolder",strApplicationHolder);
		hshJsonValues.put("strlapsID",strlapsID);
		hshJsonValues.put("strloanType",strloanType);
		hshJsonValues.put("strEMIamount",strEMIamount);
		hshJsonValues.put("arrcoapp",arrcoapp);
		hshJsonValues.put("strmisActivityCode",strmisActivityCode);
		hshJsonValues.put("strmclrType",strmclrType);
		hshJsonValues.put("strapplicationScore", strapplicationScore);
		hshJsonValues.put("strappscoredeviation", strappscoredeviation);
		hshJsonValues.put("strsanctionStatus", strsanctionStatus);
		hshJsonValues.put("strprocesssingFeeCollected",strprocesssingFeeCollected);
		hshJsonValues.put("strcategoryLoanPurpose",strcategoryLoanPurpose);
		hshJsonValues.put("strpremisesAge",strpremisesAge);
		hshJsonValues.put("strsecurityId",strsecurityId);
		hshJsonValues.put("strInsuranceAmntFundedBy",strInsuranceAmntFundedBy);
		hshJsonValues.put("strInsuranceAmount",strInsuranceAmount);
		hshJsonValues.put("strPremiumTenor",strPremiumTenor);
		hshJsonValues.put("strLoanAmountCovered",strLoanAmountCovered);
		hshJsonValues.put("strMargin",strMargin);
		hshJsonValues.put("strVehiclePurchase",strVehiclePurchase);
		hshJsonValues.put("strVehicleCost",strVehicleCost);
		hshJsonValues.put("strTax",strTax);
		hshJsonValues.put("strOtherCharges",strOtherCharges);
		hshJsonValues.put("strAccessoriesPrice",strAccessoriesPrice);
		hshJsonValues.put("strInsurance",strInsurance);
		hshJsonValues.put("strDiscount",strDiscount);
		hshJsonValues.put("strTotalCost",strTotalCost);
		hshJsonValues.put("strVerificationDoneBy",strVerificationDoneBy);
		hshJsonValues.put("strCostAlreadyIncurred",strCostAlreadyIncurred);
		hshJsonValues.put("strOwnSavingAndDisposalInvest",strOwnSavingAndDisposalInvest);
		hshJsonValues.put("strinterestCollected",strinterestCollected);
		hshJsonValues.put("strfuelUsed",strfuelUsed);
		hshJsonValues.put("strcustomerBackgroundComments",strcustomerBackgroundComments);
		

		hshJsonValues.put("strOperativeAccNo",strOperativeAccNo);
		hshJsonValues.put("strcreditRiskPremium",strcreditRiskPremium);
		hshJsonValues.put("strbusinessStrategicPremium",strbusinessStrategicPremium);
		
		hshJsonValues.put("strDigiAppno",strDigiAppno);
		hshJsonValues.put("strPerRefNo",strPerRefNo);
		hshJsonValues.put("arrRepaymentSchedule",arrRepayment);
		hshJsonValues.put("strScheme",strScheme); 
		hshJsonValues.put("strPrdctDesc",strPrdctDesc); 
		hshJsonValues.put("arrSecID",arrSecID); 
		hshJsonValues.put("strpenalInterest",strpenalInterest); 
		hshJsonValues.put("strinterestConcession",strinterestConcession);
		hshJsonValues.put("arradigiratingValue",arradigiratingValue);
		hshJsonValues.put("strecsBankName",strecsBankName);
		hshJsonValues.put("strecsAccountType",strecsAccountType);
		hshJsonValues.put("strecsOperAccountType",strecsOperAccountType);
		hshJsonValues.put("strecsAuthunenticateMode",strecsAuthunenticateMode);
		hshJsonValues.put("strecsIFSCCODE",strecsIFSCCODE);
		hshJsonValues.put("strgstVerification",strgstVerification);
		hshJsonValues.put("strupfrontfee",strupfrontfee);
		
		boolean proposalcheck=true;
		
		String appno="";
		strQuery=SQLParser.getSqlQuery("selappnoinwardnowise^"+strLARno);
		rs=DBUtils.executeQuery(strQuery);	
		if(rs.next())
		{
			appno=Helper.correctNull((String)rs.getString("app_no"));
			proposalcheck=false;
		}
		
		if(proposalcheck==true)
		{
			DigitalAppInterfaceBean digitalAppInterfaceBean= new DigitalAppInterfaceBean();
			hshValues= (HashMap)digitalAppInterfaceBean.autoLoanproposalCreation(hshJsonValues);
			
		//	hshValues = (HashMap) EJBInvoker.executeStateLess("DigitalAppInterface",hshJsonValues,"autoloanproposalCreation");
				String strApplication  = Helper.correctNull((String)hshValues.get("strApplication"));
				responseData.put("lapsProposalNumber", strApplication);
				responseData.put("sanctionReferenceno", Helper.correctNull((String)hshValues.get("strReferenceno")));
				responseData.put("sanctionDate", Helper.correctNull((String)hshValues.get("strSanctionDate")));
				strResponseCode=Helper.correctNull((String)hshValues.get("strResponseCode"));
				strResponseMsg=Helper.correctNull((String)hshValues.get("strResponseMsg"));
		}
		else
		{
			responseData.put("lapsProposalNumber", appno);
			strResponseCode="LAPS-2011";
			strResponseMsg="Proposal is already created for the given LAR";
			
		}
		

		
	//	DigitalAppInterfaceBean digitalAppInterfaceBean= new DigitalAppInterfaceBean();
	//	hshValues= (HashMap)digitalAppInterfaceBean.autoLoanproposalCreation(hshJsonValues);
		
	//	hshValues = (HashMap) EJBInvoker.executeStateLess("DigitalAppInterface",hshJsonValues,"autoloanproposalCreation");
		//	String strApplication  = Helper.correctNull((String)hshValues.get("strApplication"));
		//	responseData.put("lapsProposalNumber", strApplication);
		//	responseData.put("sanctionReferenceno", Helper.correctNull((String)hshValues.get("strReferenceno")));
		//	responseData.put("sanctionDate", Helper.correctNull((String)hshValues.get("strSanctionDate")));
		//	strResponseCode=Helper.correctNull((String)hshValues.get("strResponseCode"));
		//	strResponseMsg=Helper.correctNull((String)hshValues.get("strResponseMsg"));
		

		response.setData(responseData);
		response.setResp_code(strResponseCode);
		response.setResp_msg(strResponseMsg);
		
		jsonAsString = objectMapper.writeValueAsString(response);
	}
	catch (Exception e)
	{
		response.setData(responseData);
		response.setResp_code("LAPS-2003");
		response.setResp_msg("Invalid request parameters");
		jsonAsString = objectMapper.writeValueAsString(response);
		e.printStackTrace();
		throw new EJBException("Exception in proposalCreation ==="+e.getMessage());
	
	}
	return jsonAsString;	
	
}
	
	//@Override
	public String userOrganisationDetail(StatusCheck statusCheck) throws JsonProcessingException 
	{
		
		Map<String,Object> responseData = new HashMap<String,Object>();
		Response response = new Response();
		String jsonAsString = "";
		JSONObject objOuter        = new JSONObject();
		JSONObject PrintObject     = new JSONObject();
		HashMap hshValues 		   = new HashMap();
		String strApplExists="",strStatus="";
		
		String strResponseMsg="",strResponseCode="",strloginUserID="";
		
		try
		{
			
			JSONObject jsonCIFReqObj= new JSONObject(statusCheck);
			
			
			if (!jsonCIFReqObj.isNull("userID"))
				strloginUserID    = jsonCIFReqObj.getString("userID");
			
			//Mandatory Check
			if(strloginUserID.equals("") )
			{
				return Constants.ERROR_RESPONSE_MANDATORY;
			}
			
			HashMap hshJsonValues = new HashMap();
			hshJsonValues.put("strloginUserID",strloginUserID);
			
			hshValues = (HashMap) EJBInvoker.executeStateLess("DigitalAppInterface",hshJsonValues,"userOrganisationDetail");
			
			responseData.put("user_details", hshValues.get("user_details"));
			responseData.put("RO_users", hshValues.get("RO_users"));
			responseData.put("RLPC_users", hshValues.get("RLPC_users"));
			responseData.put("HO_users", hshValues.get("HO_users"));
			responseData.put("Branch_details", hshValues.get("Branch_details"));
	
				
				
				strResponseCode="LAPS-1014";
				strResponseMsg="User Information service Completed Successfully";
			 
			response.setData(responseData);
			response.setResp_code(strResponseCode);
			response.setResp_msg(strResponseMsg);
			
			jsonAsString = objectMapper.writeValueAsString(response);
		}
		catch (Exception e)
		{	
			response.setData(responseData);
			response.setResp_code("LAPS-2003");
			response.setResp_msg("Invalid request parameters");
			jsonAsString = objectMapper.writeValueAsString(response);
			e.printStackTrace();
			throw new EJBException("Error in inwardDetailServiceImpl dedupeCheck..."+e.toString());
		}
		return jsonAsString;	
	}

	
	public String hunterService( ) throws JsonProcessingException 
	{
		
		Map<String,Object> responseData = new HashMap<String,Object>();
		Response response = new Response();
		String jsonAsString = "",strResponseCode="",strResponseMsg="";
		HashMap hshValues = new HashMap();
		HashMap hshJsonValues = new HashMap();
		
		try
		{
		hshValues = (HashMap) EJBInvoker.executeStateLess("DigitalAppInterface",hshJsonValues,"hunterService");	
			
		strResponseCode="LAPS-1015";
		strResponseMsg=".... service Completed Successfully";
		 
		response.setData(responseData);
		response.setResp_code(strResponseCode);
		response.setResp_msg(strResponseMsg);
		
		jsonAsString = objectMapper.writeValueAsString(response);
		
		}
		catch(Exception e)
		{	
			response.setData(responseData);
			response.setResp_code("LAPS-2003");
			response.setResp_msg("Invalid request parameters");
			jsonAsString = objectMapper.writeValueAsString(response);
			e.printStackTrace();
			throw new EJBException("Error in inwardDetailServiceImpl dedupeCheck..."+e.toString());
		}
		
		
		return jsonAsString;
	}
	
	
	public String valuerListService(ValuerList valuerList) throws JsonProcessingException 
	{
		
		Map<String,Object> responseData = new HashMap<String,Object>();
		Response response = new Response();
		String jsonAsString = "",strResponseCode="",strResponseMsg="";
		HashMap hshValues = new HashMap();
		
		String strValuerLoc="";
		
		try
		{
			JSONObject jsonCIFReqObj= new JSONObject(valuerList);
			
			
			if (!jsonCIFReqObj.isNull("valuedLoc"))
				strValuerLoc    = jsonCIFReqObj.getString("valuedLoc");
			
			if(strValuerLoc.equals("") )
			{
				return Constants.ERROR_RESPONSE_MANDATORY;
			}
			
			
			
			HashMap hshJsonValues = new HashMap();
			hshJsonValues.put("strValuerLoc",strValuerLoc);
			
			hshValues = (HashMap) EJBInvoker.executeStateLess("DigitalAppInterface",hshJsonValues,"valuerListService");	
			responseData.put("ValuationDetails",hshValues.get("ValuationDetails"));
			
		strResponseCode="LAPS-1019";
		strResponseMsg="ValuationList service Completed Successfully";
		 
		response.setData(responseData);
		response.setResp_code(strResponseCode);
		response.setResp_msg(strResponseMsg);
		
		jsonAsString = objectMapper.writeValueAsString(response);
		
		}
		catch(Exception e)
		{	
			response.setData(responseData);
			response.setResp_code("LAPS-2003");
			response.setResp_msg("Invalid request parameters");
			jsonAsString = objectMapper.writeValueAsString(response);
			e.printStackTrace();
			throw new EJBException("Error in inwardDetailServiceImpl valuationList Service..."+e.toString());
		}
		
		
		return jsonAsString;
	}

	
	public String larInwardreg(ProposalCreation proposalCreation) throws JsonProcessingException 
	{
		
		Map<String,Object> responseData = new HashMap<String,Object>();
		Response response = new Response();
		String jsonAsString = "",strResponseCode="",strResponseMsg="";
		HashMap hshValues = new HashMap();
		
		String strLarNo="";
		
		try
		{
			JSONObject jsonCIFReqObj= new JSONObject(proposalCreation);
			
			
			if (!jsonCIFReqObj.isNull("larNumber"))
				strLarNo    = jsonCIFReqObj.getString("larNumber");
			
			if(strLarNo.equals("") )
			{
				return Constants.ERROR_RESPONSE_MANDATORY;
			}
			
			
			
			HashMap hshJsonValues = new HashMap();
			hshJsonValues.put("strLarNo",strLarNo);
			
			hshValues = (HashMap) EJBInvoker.executeStateLess("DigitalAppInterface",hshJsonValues,"larInwardreg");	
			responseData.put("InwardDetails",hshValues.get("InwardDetails"));
			
		strResponseCode="LAPS-1031";
		strResponseMsg="larInwardDetails service Completed Successfully";
		 
		response.setData(responseData);
		response.setResp_code(strResponseCode);
		response.setResp_msg(strResponseMsg);
		
		jsonAsString = objectMapper.writeValueAsString(response);
		
		}
		catch(Exception e)
		{	
			response.setData(responseData);
			response.setResp_code("LAPS-2003");
			response.setResp_msg("Invalid request parameters");
			jsonAsString = objectMapper.writeValueAsString(response);
			e.printStackTrace();
			throw new EJBException("Error in LarinwardDetailServiceImpl larInwardReg Service..."+e.toString());
		}
		
		
		return jsonAsString;
	}


	public String renewalProposalsRetails(RenewalProposals RenewalProposals)throws JsonProcessingException {
		Map<String,Object> responseData = new HashMap<String,Object>();
		Response response = new Response();
		String jsonAsString = "";
		JSONObject objOuter        = new JSONObject();
		JSONObject PrintObject     = new JSONObject();
		HashMap hshValues 		   = new HashMap();
		HashMap hshValues1 		   = new HashMap();
		String strCorpId="",strRefNo="",strStatus="",strresponseData="";
		Map<String,Object> responseDataMap = null;
		ArrayList arrValues = new ArrayList();
		String strResponseMsg="",strResponseCode="",strrenwaldate="",strcustId="";
		
		try
		{
			
			JSONObject jsonCIFReqObj	= new JSONObject(RenewalProposals);		

			if (!jsonCIFReqObj.isNull("renewalDate"))
				strrenwaldate  = jsonCIFReqObj.getString("renewalDate");
			
			if (!jsonCIFReqObj.isNull("custId"))
				strcustId  = jsonCIFReqObj.getString("custId");
			
			if(strrenwaldate.equals("") && strcustId.equals(""))
				{
					return Constants.ERROR_RESPONSE_MANDATORY;
				}
			
			
			HashMap hshJson = new HashMap();
			HashMap hshJsonValues = new HashMap();
			hshJsonValues.put("strrenwaldate",strrenwaldate);
			hshJsonValues.put("strcustId",strcustId);
	
			hshValues1 = (HashMap) EJBInvoker.executeStateLess("DigitalAppInterface",hshJsonValues,"renewalProposalRetails");
			
			
			ArrayList arrayList1 = (ArrayList)hshValues1.get("strrenewalProposals");
			if(arrayList1.size()>0 && arrayList1!=null)
			{
				for(int i=0; i<arrayList1.size(); i++){
					hshValues = (HashMap) arrayList1.get(i);
				
					responseDataMap = new HashMap<String,Object>();
					
					{
						responseDataMap.put("customerID", Helper.correctNull((String)hshValues.get("strcustomerID")));
						responseDataMap.put("proposalID", Helper.correctNull((String)hshValues.get("proposalID")));
						responseDataMap.put("facilityID", Helper.correctNull((String)hshValues.get("facilityID")));
						responseDataMap.put("productCode", Helper.correctNull((String)hshValues.get("productCode")));
						responseDataMap.put("sanctionedDate", Helper.correctNull((String)hshValues.get("sanctionedDate")));
						responseDataMap.put("accountOpeningDate", Helper.correctNull((String)hshValues.get("accountOpeningDate")));
						responseDataMap.put("tenor", Helper.correctNull((String)hshValues.get("tenor")));
						responseDataMap.put("dueDate", Helper.correctNull((String)hshValues.get("dueDate")));
						responseDataMap.put("sanctionedAmount", Helper.correctNull((String)hshValues.get("sanctionedAmount")));
						responseDataMap.put("companyName", Helper.correctNull((String)hshValues.get("companyName")));
						responseDataMap.put("facilitytype", Helper.correctNull((String)hshValues.get("facilitytype")));
						responseDataMap.put("solId", Helper.correctNull((String)hshValues.get("sol_id")));
						arrValues.add(responseDataMap);					
					
					}
				}}
			strResponseCode="LAPS-3002";
			strResponseMsg="Renewal Proposal Fetch service Completed Successfully";
			responseData.put("dataExist", Helper.correctNull((String)hshValues1.get("dataExist")));
			responseData.put("renewalProposals", arrValues);
			
			response.setData(responseData);
			response.setResp_code(strResponseCode);
			response.setResp_msg(strResponseMsg);
			jsonAsString = objectMapper.writeValueAsString(response);
		}
		catch (Exception e)
		{
			response.setData(responseData);
			response.setResp_code("LAPS-2003");
			response.setResp_msg("Invalid request parameters");
			jsonAsString = objectMapper.writeValueAsString(response);
			e.printStackTrace();
			throw new EJBException("Exception in RenewalProposalsRetails ==="+e.getMessage());
		}
		return jsonAsString;	
	}

	public String FetchProposalsService(FetchProposals fetchProposals) throws JsonProcessingException 
	{
		
		Map<String,Object> responseData = new HashMap<String,Object>();
		Response response = new Response();
		HashMap hshValues = new HashMap();
		String jsonAsString="",strResponseCode="",strResponseMsg="";
		
		try
		{
			String strpanno="",strstartDate="",strmobileNumber="",strcbscustid="";
			JSONObject jsonCIFReqObj= new JSONObject(fetchProposals);
			
			
			if (!jsonCIFReqObj.isNull("panNumber"))
				strpanno   = jsonCIFReqObj.getString("panNumber");
			
			if (!jsonCIFReqObj.isNull("startDate"))
				strstartDate   = jsonCIFReqObj.getString("startDate");
			
			if (!jsonCIFReqObj.isNull("mobileNumber"))
				strmobileNumber   = jsonCIFReqObj.getString("mobileNumber");
			
			if (!jsonCIFReqObj.isNull("cbscustid"))
				strcbscustid   = jsonCIFReqObj.getString("cbscustid");
			
			if(strcbscustid.equals("")){
				
				if((strpanno.equals("") && strstartDate.equals("")) || (strmobileNumber.equals("") && strstartDate.equals("")))
				{
				return Constants.ERROR_RESPONSE_MANDATORY;
				}
			}else if(!strpanno.equals("") && !strcbscustid.equals("") || !strmobileNumber.equals("") && !strcbscustid.equals("") || !strstartDate.equals("") && !strcbscustid.equals("")){
				
				String strReport ="{\"data\":{ Customer Id : "+strcbscustid+"},\"resp_code\":\"LAPS-2021\",\"resp_msg\":\"provide Cbsid or PAN and Mobile number\"}";
				return strReport;
			}
			
			HashMap hshJsonValues = new HashMap();
			hshJsonValues.put("strpanno",strpanno);
			hshJsonValues.put("strstartDate",strstartDate);
			hshJsonValues.put("strmobileNumber",strmobileNumber);
			hshJsonValues.put("strcbscustid",strcbscustid);

			hshValues = (HashMap) EJBInvoker.executeStateLess("DigitalAppInterface",hshJsonValues,"fetchProposalsService");	
			responseData.put("ProposalDetails",hshValues.get("PanProposalDetails"));
			
			strResponseCode="LAPS-1041";
			strResponseMsg="Fetch Proposals Service Completed Successfully";
			
			response.setData(responseData);
			response.setResp_code(strResponseCode);
			response.setResp_msg(strResponseMsg);
			
			jsonAsString = objectMapper.writeValueAsString(response);
		}
		catch(Exception e)
		{	
			response.setData(responseData);
			response.setResp_code("LAPS-2003");
			response.setResp_msg("Invalid request parameters");
			jsonAsString = objectMapper.writeValueAsString(response);
			e.printStackTrace();
			throw new EJBException("Error in inwardDetailServiceImpl FetchProposals Service..."+e.toString());
		}
		
		
		return jsonAsString;
	
	}

	public String FetchUserDetailsService(FetchUserDetails fetchUserDetails) throws JsonProcessingException 
	{
		
		Map<String,Object> responseData = new HashMap<String,Object>();
		Response response = new Response();
		HashMap hshValues = new HashMap();
		String jsonAsString="",strResponseCode="",strResponseMsg="",strorgCode="";
		
		try
		{
			JSONObject jsonCIFReqObj= new JSONObject(fetchUserDetails);
			
			if (!jsonCIFReqObj.isNull("orgCode"))
				strorgCode    = jsonCIFReqObj.getString("orgCode");
			
			if(strorgCode.equals("") )
			{
				return Constants.ERROR_RESPONSE_MANDATORY;
			}
			
			HashMap hshJsonValues = new HashMap();
			hshJsonValues.put("strorgCode",strorgCode);
			
			hshValues = (HashMap) EJBInvoker.executeStateLess("DigitalAppInterface",hshJsonValues,"fetchUserDetails");
			
			responseData.put("users", hshValues.get("users"));
			
			strResponseCode="LAPS-1014";
			strResponseMsg="User Information service Completed Successfully";
		 
			response.setData(responseData);
			response.setResp_code(strResponseCode);
			response.setResp_msg(strResponseMsg);
			
			jsonAsString = objectMapper.writeValueAsString(response);
			
		}
		catch(Exception e)
		{	
			response.setData(responseData);
			response.setResp_code("LAPS-2003");
			response.setResp_msg("Invalid request parameters");
			jsonAsString = objectMapper.writeValueAsString(response);
			e.printStackTrace();
			throw new EJBException("Error in inwardDetailServiceImpl FetchUserDetails Service..."+e.toString());
		}
		
		
		return jsonAsString;
	
	}
	public String FetchUserOrganisationsDetailsService(StatusCheck statusCheck) throws JsonProcessingException 
	{

		Map<String,Object> responseData = new HashMap<String,Object>();
		Response response = new Response();
		HashMap hshValues = new HashMap();
		String jsonAsString="",strResponseCode="",strResponseMsg="",strloginUserID="";
		
		try
		{
			JSONObject jsonCIFReqObj= new JSONObject(statusCheck);
			
			
			if (!jsonCIFReqObj.isNull("userID"))
				strloginUserID    = jsonCIFReqObj.getString("userID");
			
			if(strloginUserID.equals("") )
			{
				return Constants.ERROR_RESPONSE_MANDATORY;
			}
			
			HashMap hshJsonValues = new HashMap();
			hshJsonValues.put("strloginUserID",strloginUserID);
			
			hshValues = (HashMap) EJBInvoker.executeStateLess("DigitalAppInterface",hshJsonValues,"fetchUserOrganisationsDetails");
						
			responseData.put("user_details", hshValues.get("user_details"));
			responseData.put("RO_users", hshValues.get("RO_users"));
			responseData.put("RLPC_users", hshValues.get("RLPC_users"));
			responseData.put("HO_users", hshValues.get("HO_users"));
				
				
				strResponseCode="LAPS-1014";
				strResponseMsg="User Information service Completed Successfully";
			 
			response.setData(responseData);
			response.setResp_code(strResponseCode);
			response.setResp_msg(strResponseMsg);
			
			jsonAsString = objectMapper.writeValueAsString(response);
			
		}
		catch(Exception e)
		{	
			response.setData(responseData);
			response.setResp_code("LAPS-2003");
			response.setResp_msg("Invalid request parameters");
			jsonAsString = objectMapper.writeValueAsString(response);
			e.printStackTrace();
			throw new EJBException("Error in inwardDetailServiceImpl FetchUserDetails Service..."+e.toString());
		}
		
		
		return jsonAsString;
	
	}	
	public String CronServerStatus(ServerStatus serverStatus) throws JsonProcessingException 
	{

		Map<String,Object> responseData = new HashMap<String,Object>();
		Response response = new Response();
		String jsonAsString="",strResponseMsg="",strserverIp="",strResponseCode="",strserverType="",strserverExp="";
		int intserverPort=0;
		try
		{
			
			JSONObject jsonCIFReqObj= new JSONObject(serverStatus);

			JSONArray jsonservers= new JSONArray();

			if (!jsonCIFReqObj.isNull("servers"))
				jsonservers=jsonCIFReqObj.getJSONArray("servers");
			
			
			JSONObject jsoserver= new JSONObject();
			
			int servercount=jsonservers.length();
			ArrayList arrMngmnt=new ArrayList();
			ArrayList arrMngmntvalues=new ArrayList();
			if(servercount>0)
			{
				for(int i=0;i<servercount;i++)
				{
					jsoserver=(JSONObject) jsonservers.get(i);
					
					 strserverIp=jsoserver.getString("serverIp");
					 intserverPort=Integer.parseInt(jsoserver.getString("serverPort"));
					 strserverType=jsoserver.getString("serverType");
						 
					 if(strserverIp.equals("") && intserverPort==0 && strserverType.equals(""))
						{
							return Constants.ERROR_RESPONSE_MANDATORY;
						}
					 
			 		boolean isAlive = true;
					try{
						InetSocketAddress sa = new InetSocketAddress(strserverIp, intserverPort);
				        Socket ss = new Socket();
				        ss.connect(sa, 1);            
				        ss.close();
						
					}catch(Exception e)
					{
						isAlive = false;
					}
					if(isAlive==true){
					strserverExp = strserverType+" Server is working";
					}else{
						strserverExp = strserverType+" Server is down please try after some time...";
					}
					
					arrMngmntvalues=new ArrayList();
					arrMngmntvalues.add(strserverExp);
     				arrMngmnt.add(arrMngmntvalues);
							 
				}
			}
			
			responseData.put("server_status", arrMngmnt);
	        strResponseCode="LAPS-3012";
	        response.setData(responseData);
			response.setResp_code(strResponseCode);
			response.setResp_msg(strResponseMsg);
			jsonAsString = objectMapper.writeValueAsString(response);
			
		}
		catch(Exception e)
		{	
			throw new EJBException("Error in CronServerStatus "+e.getMessage());
		    	 	
		}
		
		
		return jsonAsString;
	
	}
	
	public String FinalinPrinciple(FinalInPrinciple finalinprinciple) throws JsonProcessingException 
	{
		String jsonAsString="",strprocessFromDate="",strSchemeCode="",strResponseCode="",strResponseMsg="",strmodule="",strdigiAppno="",strprocessToDate="";
		HashMap hshValues = new HashMap();
		Map<String,Object> responseData = new HashMap<String,Object>();
		Map<String,Object> responseDataMap = null;
		ArrayList arrValues = new ArrayList();
		Response response = new Response();

		try{
			

			JSONObject jsonFIPReqObj= new JSONObject(finalinprinciple);
			
			if (!jsonFIPReqObj.isNull("processfromDate"))
				strprocessFromDate   = jsonFIPReqObj.getString("processfromDate");
			
			if (!jsonFIPReqObj.isNull("schemeCode"))
				strSchemeCode   = jsonFIPReqObj.getString("schemeCode");
			
			if (!jsonFIPReqObj.isNull("module"))
				strmodule   = jsonFIPReqObj.getString("module");
			
			if (!jsonFIPReqObj.isNull("digiAppno"))
				strdigiAppno   = jsonFIPReqObj.getString("digiAppno");
			
			if (!jsonFIPReqObj.isNull("processToDate"))
				strprocessToDate   = jsonFIPReqObj.getString("processToDate");
			
			if(strprocessFromDate.equals("") || strprocessToDate.equals("") || strSchemeCode.equals(""))
			{
				if(strdigiAppno.equals("")){
				return Constants.ERROR_RESPONSE_MANDATORY;
				}
			}
			
			if(!strprocessFromDate.equals("") && !strprocessToDate.equals(""))
			{
				 	String Pattern="dd/MM/yyyy";
					DateFormat df=new SimpleDateFormat(Pattern);
					Date processFromDate=df.parse(strprocessFromDate);
					Date processToDate=df.parse(strprocessToDate);
					
					long time_difference = processToDate.getTime() - processFromDate.getTime();  
		            long days_difference = (time_difference / (1000*60*60*24)) % 365;   
		            long years_difference = (time_difference / (1000l*60*60*24*365));   

		            if(days_difference>8 ||years_difference>0 )
		            {
		            	return Constants.Date_validation;
		            }
			}
			
			HashMap hshJsonValues = new HashMap();
			hshJsonValues.put("strprocessFromDate",strprocessFromDate);
			hshJsonValues.put("strprocessToDate",strprocessToDate);
			hshJsonValues.put("strSchemeCode",strSchemeCode);
			hshJsonValues.put("strdigiAppno",strdigiAppno);
			
			hshValues = (HashMap) EJBInvoker.executeStateLess("DigitalAppInterface",hshJsonValues,"FinalInPrinciple");
			
			String flag = (String) hshValues.get("FINALINPRICPAL");
			
			if(flag.equals("Data not found"))
			{
				responseData.put("FinalInpricplevalues", "No Data found");
			}else{
				responseData.put("FinalInpricplevalues", hshValues.get("user_details"));
			}
			
			strResponseCode="LAPS-1015";
			strResponseMsg="Final Inpricple values";
		 
			response.setData(responseData);
			response.setResp_code(strResponseCode);
			response.setResp_msg(strResponseMsg);
			
			jsonAsString = objectMapper.writeValueAsString(response);
			
		
			
		}catch(Exception e){
			throw new EJBException("Error in FinalinPrinciple "+e.getMessage());
		}
		return jsonAsString;
	}
	public String GenDmsupd(GenDmsUpd gendmsupd) throws JsonProcessingException 
	{
		String jsonAsString="",strlarNumber="",strdmsRferenceNumber="",strResponseCode="",strResponseMsg="";
		HashMap hshValues = new HashMap();
		Map<String,Object> responseData = new HashMap<String,Object>();
		Response response = new Response();

		try{
			

			JSONObject jsonFIPReqObj= new JSONObject(gendmsupd);
			
			if (!jsonFIPReqObj.isNull("larNumber"))
				strlarNumber   = jsonFIPReqObj.getString("larNumber");
			
			if (!jsonFIPReqObj.isNull("dmsRferenceNumber"))
				strdmsRferenceNumber   = jsonFIPReqObj.getString("dmsRferenceNumber");
			
			
			if(strlarNumber.equals("") || strdmsRferenceNumber.equals(""))
			{
				return Constants.ERROR_RESPONSE_MANDATORY;
			}
			
			HashMap hshJsonValues = new HashMap();
			hshJsonValues.put("larNumber",strlarNumber);
			hshJsonValues.put("dmsRferenceNumber",strdmsRferenceNumber);
			
			hshValues = (HashMap) EJBInvoker.executeStateLess("DigitalAppInterface",hshJsonValues,"GenDmsUpd");
			
			
			
			strResponseCode="LAPS-1016";
			strResponseMsg="DMS REFERENCE NUMBER UPDATED";
			responseData.put("LARNUMBER", strlarNumber);
			
			response.setData(responseData);
			response.setResp_code(strResponseCode);
			response.setResp_msg(strResponseMsg);
			
			
			
			jsonAsString = objectMapper.writeValueAsString(response);
			
		
			
		}catch(Exception e){
			throw new EJBException("Error in FinalinPrinciple "+e.getMessage());
		}
		return jsonAsString;
	}
	public String organisationDetails(OrganisationDetails organisationDetails) throws JsonProcessingException 
	{
		String jsonAsString="",strorganisationCode="",strResponseCode="",strResponseMsg="";
		HashMap hshValues = new HashMap();
		Map<String,Object> responseData = new HashMap<String,Object>();
		Response response = new Response();

		try{
			

			JSONObject jsonFIPReqObj= new JSONObject(organisationDetails);
			
			if (!jsonFIPReqObj.isNull("organisationCode"))
				strorganisationCode   = jsonFIPReqObj.getString("organisationCode");
			
			if(strorganisationCode.equals(""))
			{
				return Constants.ERROR_RESPONSE_MANDATORY;
			}
			
			HashMap hshJsonValues = new HashMap();
			hshJsonValues.put("strorganisationCode",strorganisationCode);
			
			hshValues = (HashMap) EJBInvoker.executeStateLess("DigitalAppInterface",hshJsonValues,"organisationDetails");
			
			responseData.put("ORGDETAILS", hshValues.get("org_details"));
			responseData.put("RODETAILS", hshValues.get("RO_org"));
			responseData.put("CLPHDETAILS", hshValues.get("CLPC_org"));
			responseData.put("BRANCHDETAILS", hshValues.get("BRANCH_org"));
			responseData.put("HODETAILS", hshValues.get("HO_org"));
			
			strResponseCode="LAPS-1017";
			strResponseMsg="ORGANISATION DETAILS";
			
			response.setData(responseData);
			response.setResp_code(strResponseCode);
			response.setResp_msg(strResponseMsg);
			
			
			
			jsonAsString = objectMapper.writeValueAsString(response);
			
		
			
		}catch(Exception e){
			response.setData(responseData);
			response.setResp_code("LAPS-2007");
			response.setResp_msg("Invalid request parameters");
			jsonAsString = objectMapper.writeValueAsString(response);
			e.printStackTrace();
			throw new EJBException("Error in organisationDetails "+e.getMessage());
		}
		return jsonAsString;
	}
	
	public String BsaDsaMaster(ArrBsadsaMaster arrBsadsaMaster) throws JsonProcessingException 
	{
		String jsonAsString="",strResponseCode="",strResponseMsg="";
		HashMap hshValues = new HashMap();
		Map<String,Object> responseData = new HashMap<String,Object>();
		Map<String,Object> responseDataMap = null;
		Response response = new Response();
			

		try{
			
			String strtype="",strname="",straddress1="",
			straddress2="",strcity="",strstate="",strcountry="",strpincode="",strconstitution="",strnonindvname="",strmobilenum="",
			strtelephoneno="",stremailid="",strpan="",strkeyperson="",strdesignkeyperson="",stracctype="",strbankname="",strbankbranch="",
			strifsccode="",straccountnum="",strempaneldet="",strempaneldate="",strempanelsince="",strexpirydate="",straction="",strreferencename="",
			strdob="",strreraregno="",strwhtemp="",strempbankname="",strservicename="",strpastexp="",strofficepermisson="",strregstatutory="",
			strrefcontactno="",strscode="",strothtype="",strdealershipno="",strregnovalidfrom="",strregnovalidto="",strtextfield1="",strtextfield2="",
			strtextfield3="",strtextfield4="",strtextfield5="",strmasterfield1="",strmasterfield2="",strmasterfield3="",strmasterfield4="",
			strmasterfield5="",strtextfieldval1="",strtextfieldval2="",strtextfieldval3="",strtextfieldval4="",strtextfieldval5="",
			strmasterfieldval1="",strmasterfieldval2="",strmasterfieldval3="",strmasterfieldval4="",strmasterfieldval5="",strid="";
			
			JSONObject jsonBsaDsaReqObj		= new JSONObject(arrBsadsaMaster);
			JSONArray jsonArrBsaDsaReqObj		= new JSONArray();

			
			if (!jsonBsaDsaReqObj.isNull("bsadsaMaster"))
				jsonArrBsaDsaReqObj   = jsonBsaDsaReqObj.getJSONArray("bsadsaMaster");

			JSONObject jsonmaster= new JSONObject();
			int arrsize=jsonArrBsaDsaReqObj.length();
			ArrayList arrMaster=new ArrayList();
			ArrayList arrMastervalues=new ArrayList();
			if(arrsize>0)
			{
				for(int i=0;i<arrsize;i++)
				{
					jsonmaster=(JSONObject) jsonArrBsaDsaReqObj.get(i);
					
					strtype   = jsonmaster.getString("type");
					strname   = jsonmaster.getString("name");
					straddress1   = jsonmaster.getString("address1");
					straddress2   = jsonmaster.getString("address2");
					strcity  = jsonmaster.getString("city");
					strstate   = jsonmaster.getString("state");
					strcountry   = jsonmaster.getString("country");
					strpincode   = jsonmaster.getString("pincode");
					strconstitution   = jsonmaster.getString("constitution");
					strnonindvname   = jsonmaster.getString("nonindvname");
					strmobilenum   = jsonmaster.getString("mobilenum");
					strtelephoneno   = jsonmaster.getString("telephoneno");
					stremailid   = jsonmaster.getString("emailid");
					strpan   = jsonmaster.getString("pan");
					strkeyperson   = jsonmaster.getString("keyperson");
					strdesignkeyperson   = jsonmaster.getString("designkeyperson");
					stracctype   = jsonmaster.getString("acctype");
					strbankname   = jsonmaster.getString("bankname");
					strbankbranch   = jsonmaster.getString("bankbranch");
					strifsccode   = jsonmaster.getString("ifsccode");
					straccountnum   = jsonmaster.getString("accountnum");
					strempaneldet   = jsonmaster.getString("empaneldet");
					strempaneldate   = jsonmaster.getString("empaneldate");
					strempanelsince   = jsonmaster.getString("empanelsince");
					strexpirydate   = jsonmaster.getString("expirydate");
					straction   = jsonmaster.getString("action");
					strreferencename   = jsonmaster.getString("referencename");
					strdob   = jsonmaster.getString("dob");
					strreraregno   = jsonmaster.getString("reraregno");
					strwhtemp   = jsonmaster.getString("whtemp");
					strempbankname   = jsonmaster.getString("empbankname");
					strservicename   = jsonmaster.getString("servicename");
					strpastexp   = jsonmaster.getString("pastexp");
					strofficepermisson   = jsonmaster.getString("officepermisson");
					strregstatutory   = jsonmaster.getString("regstatutory");
					strrefcontactno   = jsonmaster.getString("refcontactno");
					strscode   = jsonmaster.getString("scode");
					strothtype   = jsonmaster.getString("othtype");
					strdealershipno   = jsonmaster.getString("dealershipno");
					strregnovalidfrom   = jsonmaster.getString("regnovalidfrom");
					strregnovalidto   = jsonmaster.getString("regnovalidto");
					strtextfield1   = jsonmaster.getString("textfield1");
					strtextfield2   = jsonmaster.getString("textfield2");
					strtextfield3   = jsonmaster.getString("textfield3");
					strtextfield4   = jsonmaster.getString("textfield4");
					strtextfield5   = jsonmaster.getString("textfield5");
					strmasterfield1   = jsonmaster.getString("masterfield1");
					strmasterfield2   = jsonmaster.getString("masterfield2");
					strmasterfield3   = jsonmaster.getString("masterfield3");
					strmasterfield3  = jsonmaster.getString("masterfield4");
					strmasterfield5   = jsonmaster.getString("masterfield5");
					strtextfieldval1   = jsonmaster.getString("textfieldval1");
					strtextfieldval2   = jsonmaster.getString("textfieldval2");
					strtextfieldval3   = jsonmaster.getString("textfieldval3");
					strtextfieldval4   = jsonmaster.getString("textfieldval4");
					strtextfieldval5   = jsonmaster.getString("textfieldval5");
					strmasterfieldval1   = jsonmaster.getString("masterfieldval1");
					strmasterfieldval2   = jsonmaster.getString("masterfieldval2");
					strmasterfieldval3   = jsonmaster.getString("masterfieldval3");
					strmasterfieldval4   = jsonmaster.getString("masterfieldval4");
					strmasterfieldval5   = jsonmaster.getString("masterfieldval5");
					strid   = jsonmaster.getString("id");
					
					if(strtype.equals("") || strname.equals("") || strcity.equals("") || 
							strstate.equals("") || strcountry.equals("") || strpincode.equals("") || strconstitution.equals("") || 
							strmobilenum.equals("") || stremailid.equals("") || strpan.equals("") || stracctype.equals("") || strbankname.equals("") || 
							strbankbranch.equals("") || strifsccode.equals("") 	|| straccountnum.equals("") || strempaneldet.equals("") || 
							strempaneldate.equals("") || strexpirydate.equals("") || straction.equals(""))
					{
						return Constants.ERROR_RESPONSE_MANDATORY;
					}
					
					if(strtype.equals("BSA") && strwhtemp.equals(""))
					{
						return Constants.ERROR_RESPONSE_MANDATORY;
					}
					
					if(strtype.equals("OTH") && (strdealershipno.equals("")||(strregnovalidfrom.equals("")||(strregnovalidto.equals("")))))
					{
						return Constants.ERROR_RESPONSE_MANDATORY;
					}
					
					arrMastervalues=new ArrayList();
					arrMastervalues.add(strtype);
					 arrMastervalues.add(strname);//BSADSA_NAME
					 arrMastervalues.add(straddress1);//BSADSA_ADDRESS1
					 arrMastervalues.add(straddress2);//BSADSA_ADDRESS2
					 arrMastervalues.add(strcity);//BSADSA_CITY
					 arrMastervalues.add(strstate);//BSADSA_STATE
					 arrMastervalues.add(strcountry);//BSADSA_COUNTRY
					 arrMastervalues.add(strpincode);//BSADSA_PINCODE
					 arrMastervalues.add(strconstitution);//BSADSA_CONSTITUTION
					 arrMastervalues.add(strnonindvname);//BSADSA_NONINDVNAME
					 arrMastervalues.add(strmobilenum);//BSADSA_MOBILENON
					 arrMastervalues.add(strtelephoneno);//BSADSA_TELEPHONENO
					 arrMastervalues.add(stremailid);//BSADSA_EMAILID
					 arrMastervalues.add(strpan);//BSADSA_PAN
					 arrMastervalues.add(strkeyperson);//BSADSA_KEYPERSON
					 arrMastervalues.add(strdesignkeyperson);//BSADSA_DESIGN_KEYPERSON
					 arrMastervalues.add(stracctype);//BSADSA_ACCTYPE
					 arrMastervalues.add(strbankname);//BSADSA_BANKNAME
					 arrMastervalues.add(strbankbranch);//BSADSA_BANKBRANCH
					 arrMastervalues.add(strifsccode);//BSADSA_IFSC
					 arrMastervalues.add(straccountnum);//BSADSA_ACCNO
					 arrMastervalues.add(strempaneldet);//BSADSA_EMPANEL_DET
					 arrMastervalues.add(strempaneldate);//BSADSA_EMPANEL_DATE
					 arrMastervalues.add(strempanelsince);//BSADSA_EMPANEL_SINCE
					 arrMastervalues.add(strexpirydate);//BSADSA_EXPIRY_DATE
					 arrMastervalues.add(straction);//BSADSA_ACTION
					 arrMastervalues.add(strreferencename);//BSA_REF_NAME
					 arrMastervalues.add(strdob);//BSA_DOB
					 arrMastervalues.add(strreraregno);//BSA_RERA_REGNO
					 arrMastervalues.add(strwhtemp);//BSA_WHTEMP
					 arrMastervalues.add(strempbankname);//BSA_EMP_BANKNAME
					 arrMastervalues.add(strservicename);//DSA_SERVICE_BANK
					 arrMastervalues.add(strpastexp);//DSA_PAST_EXP
					 arrMastervalues.add(strofficepermisson);//DSA_OFFICE_PREMISES
					 arrMastervalues.add(strregstatutory);//DSA_REG_STATUTORY
					 arrMastervalues.add(strrefcontactno);//bsa_ref_contactno
					 arrMastervalues.add(strscode);//BSADSA_SCODE
					 arrMastervalues.add(strothtype);//bsadsa_othtype
					 arrMastervalues.add(strdealershipno);//bsadsa_dealershipno
					 arrMastervalues.add(strregnovalidfrom);//bsadsa_regnovalidfrom
					 arrMastervalues.add(strregnovalidto);//bsadsa_regnovalidto
					 arrMastervalues.add(strtextfield1);//bsadsa_textfield1
					 arrMastervalues.add(strtextfield2);//bsadsa_textfield2
					 arrMastervalues.add(strtextfield3);//bsadsa_textfield3
					 arrMastervalues.add(strtextfield4);//bsadsa_textfield4
					 arrMastervalues.add(strtextfield5);//bsadsa_textfield5
					 arrMastervalues.add(strmasterfield1);//bsadsa_masterfield1
					 arrMastervalues.add(strmasterfield2);//bsadsa_masterfield2
					 arrMastervalues.add(strmasterfield3);//bsadsa_masterfield3
					 arrMastervalues.add(strmasterfield4);//bsadsa_masterfield4
					 arrMastervalues.add(strmasterfield5);//bsadsa_masterfield5
					 arrMastervalues.add(strtextfieldval1);//bsadsa_textfieldval1
					 arrMastervalues.add(strtextfieldval2);//bsadsa_textfieldval2
					 arrMastervalues.add(strtextfieldval3);//bsadsa_textfieldval3
					 arrMastervalues.add(strtextfieldval4);//bsadsa_textfieldval4
					 arrMastervalues.add(strtextfieldval5);//bsadsa_textfieldval5
					 arrMastervalues.add(strmasterfieldval1);//bsadsa_masterfieldval1
					 arrMastervalues.add(strmasterfieldval2);//bsadsa_masterfieldval2
					 arrMastervalues.add(strmasterfieldval3);//bsadsa_masterfieldval3
					 arrMastervalues.add(strmasterfieldval4);//bsadsa_masterfieldval4
					 arrMastervalues.add(strmasterfieldval5);//bsadsa_masterfieldval5
					 arrMastervalues.add(strid);//BSADSA_ID
					arrMaster.add(arrMastervalues);
				}
			}
			
			HashMap hshJsonValues = new HashMap();
			hshJsonValues.put("arrMaster",arrMaster);

			hshValues = (HashMap) EJBInvoker.executeStateLess("staticdata",hshJsonValues,"updateBSADmasterapi");
			
			strResponseCode=Helper.correctNull((String)hshValues.get("strResponseCode"));
			strResponseMsg=Helper.correctNull((String)hshValues.get("strResponseMsg"));
			responseData.put("MasterId", hshValues.get("masterId"));
			response.setData(responseData);
			response.setResp_code(strResponseCode);
			response.setResp_msg(strResponseMsg);
			
			jsonAsString = objectMapper.writeValueAsString(response);
			
		}catch(Exception e){
			throw new EJBException("Error in InwardDetailServiceImpl->BsaDsaMaster "+e.getMessage());
		}
		return jsonAsString;
	}
	public String getgoldrate(GetGoldRate goldrate) throws JsonProcessingException 
	{
		String jsonAsString="",strdate="",strResponseCode="",strResponseMsg="";
		HashMap hshValues = new HashMap();
		Map<String,Object> responseData = new HashMap<String,Object>();
		Response response = new Response();

		try{
			

			JSONObject jsonFIPReqObj= new JSONObject(goldrate);
			
			if (!jsonFIPReqObj.isNull("date"))
				strdate   = jsonFIPReqObj.getString("date");
			
			
			if(strdate.equals(""))
			{
				return Constants.ERROR_RESPONSE_MANDATORY;
			}
			
			SimpleDateFormat sdfrmt = new SimpleDateFormat("dd/mm/yyyy");

			if(!strdate.equals(""))
			{
			 	try
			 	{
				 	Date javaDate = sdfrmt.parse(strdate); 
			 	}
		    	catch (ParseException e)
			    {
					return Constants.ERROR_RESPONSE_INVALID_DATEFORMAT;
			    }
			}
			
			HashMap hshJsonValues = new HashMap();
			hshJsonValues.put("date",strdate);
			
			
			hshValues = (HashMap) EJBInvoker.executeStateLess("DigitalAppInterface",hshJsonValues,"goldratedetails");
			
			
			
			responseData.put("GOLD_RATE", hshValues.get("goldrate"));
			responseData.put("GOLD_AVG_RATE", hshValues.get("goldavgrate"));

				
			
				
				strResponseCode="LAPS-2008";
				strResponseMsg="GOLD RATE GET SUCCESSFULLY";
			 
			response.setData(responseData);
			response.setResp_code(strResponseCode);
			response.setResp_msg(strResponseMsg);
	
			responseData.put("DATE", strdate);
			
			response.setData(responseData);
			response.setResp_code(strResponseCode);
			response.setResp_msg(strResponseMsg);
			
			
			
			jsonAsString = objectMapper.writeValueAsString(response);
			
		
			
		}catch(Exception e){
			throw new EJBException("Error in getgoldrate "+e.getMessage());
		}
		return jsonAsString;
	}
	public String getjewelappraiserslist(OrganisationDetails orgcode) throws JsonProcessingException 
	{
		String jsonAsString="",strcode="",strResponseCode="",strResponseMsg="";
		HashMap hshValues = new HashMap();
		Map<String,Object> responseData = new HashMap<String,Object>();
		Response response = new Response();

		try{
			

			JSONObject jsonFIPReqObj= new JSONObject(orgcode);
			
			if (!jsonFIPReqObj.isNull("organisationCode"))
				strcode   = jsonFIPReqObj.getString("organisationCode");
			
			
			if(strcode.equals(""))
			{
				return Constants.ERROR_RESPONSE_MANDATORY;
			}
		
			
			HashMap hshJsonValues = new HashMap();
			hshJsonValues.put("strcode",strcode);
			
			
			hshValues = (HashMap) EJBInvoker.executeStateLess("DigitalAppInterface",hshJsonValues,"fetchjewelappraiserlist");
			
			
            responseData.put("AppraisersList", hshValues.get("users"));
			
			strResponseCode="LAPS-011923";
			strResponseMsg="Jewel appraisers List get Successfully"; 
		 
			response.setData(responseData);
			response.setResp_code(strResponseCode);
			response.setResp_msg(strResponseMsg);
			
			jsonAsString = objectMapper.writeValueAsString(response);
			
		
			
		}catch(Exception e){
			
			response.setData(responseData);
			response.setResp_code("LAPS-404");
			response.setResp_msg("Invalid request parameters");
			jsonAsString = objectMapper.writeValueAsString(response);
			e.printStackTrace();
			throw new EJBException("Error in getjewelappraiserslist "+e.getMessage());
		}
		return jsonAsString;
	}
	
	public String dogoldreappraiser(GoldReappraiser golddetails) throws JsonProcessingException 
	{
		String jsonAsString="",strcbsid="",strResponseCode="",strResponseMsg="",strAppno="",strreappraisedon="";
		HashMap hshValues = new HashMap();
		Map<String,Object> responseData = new HashMap<String,Object>();
		Response response = new Response();
		String orgcode="",appraiserid="",appraisedon=""; 
		String reappraisername="";

		try{


			
			

			JSONObject jsonFIPReqObj= new JSONObject(golddetails);
			
			if (!jsonFIPReqObj.isNull("cbsId"))
				strcbsid   = jsonFIPReqObj.getString("cbsId");
			
			if (!jsonFIPReqObj.isNull("appno"))
				strAppno   = jsonFIPReqObj.getString("appno");
			
			if (!jsonFIPReqObj.isNull("reappraisedon"))
				strreappraisedon   = jsonFIPReqObj.getString("reappraisedon");
			
			
			if(strcbsid.equals("") || strAppno.equals("") || strreappraisedon.equals("") )
			{
				return Constants.ERROR_RESPONSE_MANDATORY;
			}
			SimpleDateFormat sdfrmt = new SimpleDateFormat("dd/MM/yyyy");

			if(!strreappraisedon.equals(""))
			{
			 	try
			 	{
				 	Date javaDate = sdfrmt.parse(strreappraisedon); 
			 	}
		    	catch (ParseException e)
			    {
					return Constants.ERROR_RESPONSE_INVALID_DATEFORMAT;
			    }
			}
			ResultSet rs=null;
			String strQuery="";
			
			strQuery=SQLParser.getSqlQuery("chkproposalisgoldloan^"+strAppno);
			if(rs!=null)
			{ rs.close(); }
			rs=DBUtils.executeQuery(strQuery);	
			if(rs.next())
			{
				orgcode=Helper.correctNull((String) rs.getString("APP_ORGCODE"));
			}
			else
			{
				return Constants.goldpropsalchk;
			}
			if(rs!=null)
			{ rs.close(); }
			String appraisername="";
			strQuery=SQLParser.getSqlQuery("sel_appraiserdet^"+strAppno);
			if(rs!=null)
			{ rs.close(); }
			rs=DBUtils.executeQuery(strQuery);	
			if(rs.next())
			{
				appraiserid=Helper.correctNull((String) rs.getString("ja_appraisercbsid"));
				appraisedon=Helper.correctNull((String) rs.getString("ja_appraiseon"));
				appraisername=Helper.correctNull((String) rs.getString("ja_name"));
			}
			else
			{
				return Constants.goldpropsalchk;
			}
			
			if(appraiserid.equalsIgnoreCase(strcbsid))
			{
				return Constants.goldreappraiserchk;
			}
			Date d1= sdfrmt.parse(strreappraisedon); 
			Date d2= sdfrmt.parse(appraisedon);
			String todate=Helper.getCurrentDateTime();
			Date d3= sdfrmt.parse(todate);
			if ((d1.compareTo(d2) < 0)||(d1.compareTo(d3) > 0)) {
				return Constants.goldreappraiserchk;
			}
			strQuery=SQLParser.getSqlQuery("chkcbsidforreappraiser^"+strcbsid+"^"+orgcode);
			if(rs!=null)
			{ rs.close(); }
			rs=DBUtils.executeQuery(strQuery);	
			if(!rs.next())
			{
				return Constants.goldreappraiserchk;
			}
			else
			{
				reappraisername=Helper.correctNull((String) rs.getString("VALUERS_NAME"));
			}
			
			if(rs!=null)
			{ rs.close(); }
			strQuery=SQLParser.getSqlQuery("chkforpastatus^"+strAppno);
			
			rs=DBUtils.executeQuery(strQuery);	
			if(rs.next())
			{
				if(Helper.correctNull((String) rs.getString("STATUS")).equalsIgnoreCase("pa"))
				{
					return Constants.Goldreappraiserstatus;
				}
			}
			
			JSONArray golddetailss = new JSONArray();
			if (!jsonFIPReqObj.isNull("golddetails"))
			{
				golddetailss=jsonFIPReqObj.getJSONArray("golddetails");
			}
			JSONObject jsondepost= new JSONObject();
			int intdepdet=golddetailss.length();
			ArrayList arrgolddetails=new ArrayList();
			ArrayList arrgolddetailsval=new ArrayList();
			if(intdepdet>0)
			{
				for(int i=0;i<intdepdet;i++)
				{
					jsondepost=(JSONObject) golddetailss.get(i);
						
					arrgolddetailsval=new ArrayList();
					arrgolddetailsval.add(jsondepost.getString("article_no"));
					arrgolddetailsval.add(jsondepost.getString("description_of_articles"));
					arrgolddetailsval.add(jsondepost.getString("quantity"));
					arrgolddetailsval.add(jsondepost.getString("gross"));
					arrgolddetailsval.add(jsondepost.getString("net"));
					arrgolddetailsval.add(jsondepost.getString("purity"));
					arrgolddetailsval.add(jsondepost.getString("last_market_rate"));
					arrgolddetailsval.add(jsondepost.getString("average_rate"));
					arrgolddetailsval.add(jsondepost.getString("estimated_val"));
					
					arrgolddetails.add(arrgolddetailsval);
				}
			}
			
			HashMap hshJsonValues = new HashMap();
			hshJsonValues.put("strcbsid",strcbsid);
			hshJsonValues.put("strAppno",strAppno);
			hshJsonValues.put("orgcode",orgcode);
			hshJsonValues.put("strreappraisedon",strreappraisedon);
			hshJsonValues.put("reappraisername",reappraisername);
			hshJsonValues.put("arrgolddetails",arrgolddetails);
			
			
			
			hshValues = (HashMap) EJBInvoker.executeStateLess("DigitalAppInterface",hshJsonValues,"dogoldreappraiser");
			
			
           // responseData.put("AppraisersList", hshValues.get("users"));
          
            responseData.put("Gold_Appraiser_Name",appraisername);
            responseData.put("Gold_Appraiser_CBSID",appraiserid);
            responseData.put("Gold_Appraised_on ",appraisedon);
            
            responseData.put("Gold_ReAppraiser_Name",reappraisername);
            responseData.put("Gold_ReAppraiser_CBSID",strcbsid);
            responseData.put("Gold ReAppraised on ",strreappraisedon);
            
            responseData.put("Latest_Market_value", hshValues.get("Latest_Market_value"));
            responseData.put("Gold_Details", hshValues.get("Gold_Details"));
			
			strResponseCode="LAPS-012023";
			strResponseMsg=" Gold Reappraiser done Successfully"; 
		 
			response.setData(responseData);
			response.setResp_msg(strResponseMsg);
			response.setResp_code(strResponseCode);
			
			
			jsonAsString = objectMapper.writeValueAsString(response);
			
		
			
		}catch(Exception e){
			
			//response.setData(responseData);
			response.setResp_code("LAPS-404");
			response.setResp_msg("Invalid request parameters");
			jsonAsString = objectMapper.writeValueAsString(response);
			e.printStackTrace();
			throw new EJBException("Error in getjewelappraiserslist "+e.getMessage());
		}
		return jsonAsString;
	}
	public String Birdata(Birdata Birdata)throws JsonProcessingException {     //Birdata Api
		Map<String,Object> responseData = new HashMap<String,Object>();
		Response response = new Response();
		String jsonAsString = "";
		JSONObject objOuter        = new JSONObject();
		JSONObject PrintObject     = new JSONObject();
		HashMap hshValues 		   = new HashMap();
		HashMap hshValues1 		   = new HashMap();
		String strStatus="",strresponseData="";
		Map<String,Object> responseDataMap = null;
		ArrayList arrValues = new ArrayList();
		String strResponseMsg="",strResponseCode="",strregioncode="";
		
		try
		{
			
			JSONObject jsonCIFReqObj	= new JSONObject(Birdata);		

			if (!jsonCIFReqObj.isNull("regioncode"))
				strregioncode  = jsonCIFReqObj.getString("regioncode");
			
			if(strregioncode.equals(""))
				{
					return Constants.ERROR_RESPONSE_MANDATORY;
				}
			
			
			HashMap hshJson = new HashMap();
			HashMap hshJsonValues = new HashMap();
			hshJsonValues.put("strregioncode",strregioncode);
	
			hshValues1 = (HashMap) EJBInvoker.executeStateLess("DigitalAppInterface",hshJsonValues,"Birdataapi");
			
			
			ArrayList arrayList1 = (ArrayList)hshValues1.get("BIR_DATA");
			if(arrayList1.size()>0 && arrayList1!=null)
			{
				for(int i=0; i<arrayList1.size(); i++){
					hshValues = (HashMap) arrayList1.get(i);
				
					responseDataMap = new HashMap<String,Object>();
					
					{
						responseDataMap.put("strId", Helper.correctNull((String)hshValues.get("strId")));
						responseDataMap.put("strName", Helper.correctNull((String)hshValues.get("strName")));
						responseDataMap.put("strScode", Helper.correctNull((String)hshValues.get("strScode")));
						responseDataMap.put("stremailid", Helper.correctNull((String)hshValues.get("stremailid")));
						responseDataMap.put("strmobileno", Helper.correctNull((String)hshValues.get("strmobileno")));
						responseDataMap.put("strtelephone", Helper.correctNull((String)hshValues.get("strtelephone")));
						responseDataMap.put("strbranch", Helper.correctNull((String)hshValues.get("strbranch")));
						responseDataMap.put("strIfsc", Helper.correctNull((String)hshValues.get("strIfsc")));
						responseDataMap.put("strexpirydate", Helper.correctNull((String)hshValues.get("strexpirydate")));
						responseDataMap.put("strpincode", Helper.correctNull((String)hshValues.get("strpincode")));
						arrValues.add(responseDataMap);					
					
					}
				}}
			strResponseCode="LAPS-3002";
			strResponseMsg="BIR_DATA_API Fetch service Completed Successfully";
			responseData.put("dataExist", Helper.correctNull((String)hshValues1.get("dataExist")));
			responseData.put("BIR_DATA", arrValues);
			
			response.setData(responseData);
			response.setResp_code(strResponseCode);
			response.setResp_msg(strResponseMsg);
			jsonAsString = objectMapper.writeValueAsString(response);
		}
		catch (Exception e)
		{
			response.setData(responseData);
			response.setResp_code("LAPS-2003");
			response.setResp_msg("Invalid request parameters");
			jsonAsString = objectMapper.writeValueAsString(response);
			e.printStackTrace();
			throw new EJBException("Exception in RenewalProposalsRetails ==="+e.getMessage());
		}
		return jsonAsString;	
	}
	//vindhya begin
	public String usertransfer(UserUpdation usertransferdetails) throws JsonProcessingException 
	{
	HashMap hshValues = new HashMap();
	Map<String,Object> responseData = new HashMap<String,Object>();
	Response response = new Response();
	String jsonAsString="",struserid="",strsol_id="",strResponseCode="",strResponseMsg="",strorg_code="";
	try
		{
			JSONObject jsonReqObj= new JSONObject(usertransferdetails);
			
			if (!jsonReqObj.isNull("userid"))
				struserid   = jsonReqObj.getString("userid");
			if (!jsonReqObj.isNull("sol_id"))
				strsol_id   = jsonReqObj.getString("sol_id");
			
			if(struserid.equals("") || strsol_id.equals(""))			
			{
				return Constants.ERROR_RESPONSE_MANDATORY;
			}
			String strQuery="";
			ResultSet rs=null;
			strQuery=SQLParser.getSqlQuery("sel_organisationcode^"+strsol_id);
			if(rs!=null)
			{ rs.close(); }
			rs=DBUtils.executeQuery(strQuery);	
			if(!rs.next())
			{
				return Constants.organisationchk;
			}
			else
			{
				strorg_code=Helper.correctNull((String) rs.getString("org_code"));
			}	
			HashMap hshJsonValues=new HashMap();			
			hshJsonValues.put("struserid",struserid);			
			hshJsonValues.put("strorg_code",strorg_code);
			hshJsonValues.put("strsol_id",strsol_id);
			
			hshValues = (HashMap) EJBInvoker.executeStateLess("DigitalAppInterface",hshJsonValues,"usertransfer"); 
			responseData.put("Userid", hshValues.get("Userid"));
			strResponseCode="LAPS-042023";
			strResponseMsg=" User Sol ID modified Successfully for "+hshValues.get("Userid"); 
		 
			response.setData(responseData);
			response.setResp_msg(strResponseMsg);
			response.setResp_code(strResponseCode);
			jsonAsString = objectMapper.writeValueAsString(response);
		}
		catch (Exception e)
		{
			response.setData(responseData);
			response.setResp_code("LAPS-2023");
			response.setResp_msg("Invalid request parameters");
			jsonAsString = objectMapper.writeValueAsString(response);
			e.printStackTrace();
			throw new EJBException("Exception in usertransfer ==="+e.getMessage());
		}
		return jsonAsString;
	}
	//for making user unavailable
	public String useravailability(UserClosure useravailabilitydetails) throws JsonProcessingException 
	{
	HashMap hshValues = new HashMap();
	Map<String,Object> responseData = new HashMap<String,Object>();
	Response response = new Response();
	String jsonAsString="",struserid="",stravailability="",strResponseCode="",strResponseMsg="",strorg_code="";
	try
		{
			JSONObject jsonReqObj= new JSONObject(useravailabilitydetails);
			
			if (!jsonReqObj.isNull("userid"))
				struserid   = jsonReqObj.getString("userid");
			
			if(struserid.equals(""))			
			{
				return Constants.ERROR_RESPONSE_MANDATORY;
			}
			String strQuery="";
			ResultSet rs=null;
			strQuery=SQLParser.getSqlQuery("setuserssel^"+struserid);
			if(rs!=null)
			{ rs.close(); }
			rs=DBUtils.executeQuery(strQuery);	
			if(!rs.next())
			{
				return Constants.userchk;
			}
				
			HashMap hshJsonValues=new HashMap();			
			hshJsonValues.put("struserid",struserid);			
			
			hshValues = (HashMap) EJBInvoker.executeStateLess("DigitalAppInterface",hshJsonValues,"useravailability"); 
			responseData.put("Userid", hshValues.get("Userid"));
			strResponseCode="LAPS-042023";
			strResponseMsg=" User availability modified Successfully for "+hshValues.get("Userid"); 
		 
			response.setData(responseData);
			response.setResp_msg(strResponseMsg);
			response.setResp_code(strResponseCode);
			jsonAsString = objectMapper.writeValueAsString(response);
		}
		catch (Exception e)
		{
			response.setData(responseData);
			response.setResp_code("LAPS-2023");
			response.setResp_msg("Invalid request parameters");
			jsonAsString = objectMapper.writeValueAsString(response);
			e.printStackTrace();
			throw new EJBException("Exception in userclosure ==="+e.getMessage());
		}
		return jsonAsString;
	}
	//for designation updation
	public String userDesignationupdate(Userdesignation Designationdetails) throws JsonProcessingException 
	{
	HashMap hshValues = new HashMap();
	Map<String,Object> responseData = new HashMap<String,Object>();
	Response response = new Response();
	String jsonAsString="",struserid="",strdesignationcode="",strgroupcode="",strclasscode="",strResponseCode="",strResponseMsg="";
	try
		{
			JSONObject jsonReqObj= new JSONObject(Designationdetails);
			
			if (!jsonReqObj.isNull("userid"))
				struserid   = jsonReqObj.getString("userid");
			if (!jsonReqObj.isNull("designationcode"))
				strdesignationcode   = jsonReqObj.getString("designationcode");
			if (!jsonReqObj.isNull("usergroupcode"))
				strgroupcode   = jsonReqObj.getString("usergroupcode");
			
			
			if(struserid.equals("")||strdesignationcode.equals("")||strgroupcode.equals(""))			
			{
				return Constants.ERROR_RESPONSE_MANDATORY;
			}
			String strQuery="";
			ResultSet rs=null;
			strQuery=SQLParser.getSqlQuery("setuserssel^"+struserid);
			if(rs!=null)
			{ rs.close(); }
			rs=DBUtils.executeQuery(strQuery);	
			if(!rs.next())
			{
				return Constants.userchk;
			}
			String strQuery1="";
			ResultSet rs1=null;
			strQuery1=SQLParser.getSqlQuery("setgroupssel_audit^"+strgroupcode);
			if(rs1!=null)
			{ rs1.close(); }
			rs1=DBUtils.executeQuery(strQuery1);	
			if(!rs1.next())
			{
				return Constants.groupidchk;
			}
			String strQuery2="";
			ResultSet rs2=null;
			strQuery2=SQLParser.getSqlQuery("getdesignationdetails^"+strdesignationcode);
			if(rs2!=null)
			{ rs2.close(); }
			rs2=DBUtils.executeQuery(strQuery2);	
			if(!rs2.next())
			{
				return Constants.designatechk;
			}
			HashMap hshJsonValues=new HashMap();			
			hshJsonValues.put("struserid",struserid);			
			hshJsonValues.put("strdesignationcode",strdesignationcode);
			hshJsonValues.put("strgroupcode",strgroupcode);
			
			
			hshValues = (HashMap) EJBInvoker.executeStateLess("DigitalAppInterface",hshJsonValues,"userDesignationupdate"); 
			responseData.put("Userid", hshValues.get("Userid"));
			strResponseCode="LAPS-042023";
			strResponseMsg=" User Designation modified Successfully for "+hshValues.get("Userid"); 
		 
			response.setData(responseData);
			response.setResp_msg(strResponseMsg);
			response.setResp_code(strResponseCode);
			jsonAsString = objectMapper.writeValueAsString(response);
		}
		catch (Exception e)
		{
			response.setData(responseData);
			response.setResp_code("LAPS-2023");
			response.setResp_msg("Invalid request parameters");
			jsonAsString = objectMapper.writeValueAsString(response);
			e.printStackTrace();
			throw new EJBException("Exception in userclosure ==="+e.getMessage());
		}
		return jsonAsString;
	}
	//User creation 			
				public String usercreation(UserCreation userdetails) throws JsonProcessingException 
				{
				HashMap hshValues = new HashMap();
				Map<String,Object> responseData = new HashMap<String,Object>();
				Response response = new Response();
				String jsonAsString="", struserid="",strorg_code="", strusergroupcode="",struser_solid="",strfirstname="",strlastname="",strpassword="",strclasscode="", strdesignationcode="",stremailid="",strdepartmentcode="",strResponseMsg="",strResponseCode="";
				try
					{
						JSONObject jsonReqObj= new JSONObject(userdetails);
						
						if (!jsonReqObj.isNull("userid"))
							struserid   = jsonReqObj.getString("userid");
						if (!jsonReqObj.isNull("usergroupcode"))
							strusergroupcode   = jsonReqObj.getString("usergroupcode");
						if (!jsonReqObj.isNull("user_solid"))
							struser_solid   = jsonReqObj.getString("user_solid");
						if (!jsonReqObj.isNull("firstname"))
							strfirstname   = jsonReqObj.getString("firstname");	
						if (!jsonReqObj.isNull("lastname"))
							strlastname   = jsonReqObj.getString("lastname");		
						if (!jsonReqObj.isNull("password"))
							strpassword = jsonReqObj.getString("password");	
						if (!jsonReqObj.isNull("classcode"))
							strclasscode  = jsonReqObj.getString("classcode");	
						if (!jsonReqObj.isNull("designationcode"))
							strdesignationcode  = jsonReqObj.getString("designationcode");
						if (!jsonReqObj.isNull("emailid"))
							stremailid  = jsonReqObj.getString("emailid");	
						if (!jsonReqObj.isNull("departmentcode"))
							strdepartmentcode  = jsonReqObj.getString("departmentcode");
						
						
						if(struserid.equals("")||strusergroupcode.equals("")||struser_solid.equals("")||strfirstname.equals("")
						||strlastname.equals("")||strpassword.equals("")||strclasscode.equals("")||
						strdesignationcode.equals(""))
						{	
							return Constants.ERROR_RESPONSE_MANDATORY;
						}
						
						String strQuery="";
						ResultSet rs=null;
						strQuery=SQLParser.getSqlQuery("sel_organisationcode^"+struser_solid);
						if(rs!=null)
						{ rs.close(); }
						rs=DBUtils.executeQuery(strQuery);	
						if(!rs.next())
						{
							return Constants.organisationchk;
						}
						else
						{
							strorg_code=Helper.correctNull((String) rs.getString("org_code"));
						}	
						
						if(strorg_code.equals("001000000000000") && !strusergroupcode.equals("1"))
						{
							if(strdepartmentcode.equals(""))
							{
								return Constants.ERROR_RESPONSE_MANDATORY;
							}
						}
						strQuery=SQLParser.getSqlQuery("setuserssel^"+struserid);
						if(rs!=null)
						{ rs.close(); }
						rs=DBUtils.executeQuery(strQuery);	
						while (rs.next())
						{
							return Constants.USERVALID;
						}
						
						String strQuery1="";
						ResultSet rs1=null;
						strQuery1=SQLParser.getSqlQuery("setgroupssel_audit^"+strusergroupcode);
						if(rs1!=null)
						{ rs1.close(); }
						rs1=DBUtils.executeQuery(strQuery1);	
						if(!rs1.next())
						{
							return Constants.groupidchk;
						}
						String strQuery2="";
						ResultSet rs2=null;
						strQuery2=SQLParser.getSqlQuery("getdesignationdetails^"+strdesignationcode);
						if(rs2!=null)
						{ rs2.close(); }
						rs2=DBUtils.executeQuery(strQuery2);	
						if(!rs2.next())
						{
							return Constants.designatechk;
						}
						HashMap hshJsonValues=new HashMap();			
						hshJsonValues.put("struserid",struserid);			
						hshJsonValues.put("strusergroupcode",strusergroupcode);
						hshJsonValues.put("struser_solid",struser_solid);
						hshJsonValues.put("strorg_code",strorg_code);
						hshJsonValues.put("strfirstname",strfirstname);
						hshJsonValues.put("strlastname",strlastname);
						hshJsonValues.put("strpassword",strpassword);
						hshJsonValues.put("strclasscode",strclasscode);
						hshJsonValues.put("strdesignationcode",strdesignationcode);
						hshJsonValues.put("stremailid",stremailid);
						hshJsonValues.put("strdepartmentcode",strdepartmentcode);
						
						
						hshValues = (HashMap) EJBInvoker.executeStateLess("DigitalAppInterface",hshJsonValues,"Usercreation"); 
						responseData.put("Userid", hshValues.get("Userid"));
						strResponseCode="LAPS-042023";
						strResponseMsg=" User created Successfully for "+hshValues.get("Userid"); 
					 
						response.setData(responseData);
						response.setResp_msg(strResponseMsg);
						response.setResp_code(strResponseCode);
						jsonAsString = objectMapper.writeValueAsString(response);
					}
					catch (Exception e)
					{
						response.setData(responseData);
						response.setResp_code("LAPS-2023");
						response.setResp_msg("Invalid request parameters");
						jsonAsString = objectMapper.writeValueAsString(response);
						e.printStackTrace();
						throw new EJBException("Exception in usercreation ==="+e.getMessage());
					}
					return jsonAsString;
				}
	//vindhya end
	
	
	//@Override
	public String perappid(CustomerCreation CustomerCreation)
			throws JsonProcessingException {
		// TODO Auto-generated method stub
				
		
		Map<String,Object> responseData = new HashMap<String,Object>();
		Response response = new Response();
		String jsonAsString = "";
		JSONObject objOuter        = new JSONObject();
		JSONObject PrintObject     = new JSONObject();
		HashMap hshValues 		   = new HashMap();
		
		String strResponseMsg="",strResponseCode="",strNewLAPSid;
		
		//demographics
		String strCBSID="",strTitle="",strFullName="",strShortName="",strConstitution="",strDOB="01/01/1900",strPANNo="",strGender="";
		String strMaritalStatus="",strStatus="",strTaxSlab="",strBorrStatus="",strEmployment="",strBanking="",strBorrowerSince="";
		String strSatisfactory="",strStaffRelation="",strIntroStatus="",strResidentStatus="",strReligion="",strCaste="",strChildDep="",strOtherDep="";
		String strEarningMem="",strFamilyIncome="",strPhysicalChgd="",strsel_Blind="",strBranchCode="";
		
		//communication
		String strComAddress1="",strComAddress2="",strComCity="",strComDistrict="",strComState="",strComCountry="",
		strComPincode="",strResidentType="",strNoofYearsPresAdd="",mobileNumber="",customerEmail="";
		
		//kyc norms
		String strCustomerOccupation="",strIDprooftype="",strIDref="",strRiskCat="",strResidentProof="",strResidentIDref="",strNatureActivity="",
		strResidentIDdate="",stridProoofExpDate="";

		//inc and exp
		String strPrimaryIncome="",strGrossIncome="",strIncomeTaxDet="",strincomeITR="",strDocCollected="";
		
		//rating defaulter
		String strWhrRefCIBIL="",strCIBILscore="",strCIBILdetails="";
		
		//Employment details
		String strcompanyName="",strcompAddress="",strcompCity="",strcompState="",strcompPincode="",strcompPhoneno="",stremployeeID="",
		strexperinceYears="",strdateJoining="",strretirementDate="",strconfirmedEmployee="",strlistedCompany="",strsalaryReceiptDate="",
		strcommencementDate="",stryearsCurrentActivity="";
		
		String strAddressChangeFlag="",strPANflag="",strfiAddressFlag="",strfiEmploymentFlag="",strfiBankStatFlag="",stremandateEmiFlag="";
		String stremanbankacc="",stremanbankname="",strPermAddChangeFlag="",strfathername="",strstafflag="",streduqualification="",
		strItrFlag="",strBusinessProofFlag="",strOfficeAddFlag="",strcommunity="",strnetworthBorrower="",strproforma="",strResidenceProof="";
		
		String strincomeYearEnded="",stritrFillingDate="",strudyogAadharNumber="",strgstin="",strmseRegNumber="";
		String strcrifScore="",strcrifDetails="",crifReportedDate="",strSpouseName="",strMotherName="",strComAddressLine2="", strComAddressLine3="",
		strIncomeYearEndPreviousYear="",itrFillDatePreviousYear="", stritrSalaryPreviousYear="",strudyamRegistrationNumber="",
		strsalesTurnOverApplicant="",strsalesTurnOverDate="",strcriteriaforSalesTurnover="",strudyamRegistrationClassification="",strudyamDate="",strcibilDate="";
		
		try
		{
			
			JSONObject jsonCIFReqObj		= new JSONObject(CustomerCreation);
 
			///demographics
			if (!jsonCIFReqObj.isNull("cbsid"))
				strCBSID    = jsonCIFReqObj.getString("cbsid");
//			if (!jsonCIFReqObj.isNull("customerTitle"))
//				strTitle    = jsonCIFReqObj.getString("customerTitle");
//			if (!jsonCIFReqObj.isNull("customerFullName"))
//				strFullName    = jsonCIFReqObj.getString("customerFullName");	
//			if (!jsonCIFReqObj.isNull("customerShortName"))
//				strShortName    = jsonCIFReqObj.getString("customerShortName");
//			if (!jsonCIFReqObj.isNull("customerConstitution"))
//				strConstitution    = jsonCIFReqObj.getString("customerConstitution");
//			if (!jsonCIFReqObj.isNull("customerDOB"))
//				strDOB    = jsonCIFReqObj.getString("customerDOB");
//			if (!jsonCIFReqObj.isNull("customerPANNO"))
//				strPANNo    = jsonCIFReqObj.getString("customerPANNO");
//			if (!jsonCIFReqObj.isNull("gender"))
//				strGender    = jsonCIFReqObj.getString("gender");
//			if (!jsonCIFReqObj.isNull("maritalStatus"))
//				strMaritalStatus    = jsonCIFReqObj.getString("maritalStatus");
//			if (!jsonCIFReqObj.isNull("customerStatus"))
//				strStatus    = jsonCIFReqObj.getString("customerStatus");
//			if (!jsonCIFReqObj.isNull("taxSlab"))
//				strTaxSlab    = jsonCIFReqObj.getString("taxSlab");
//			if (!jsonCIFReqObj.isNull("borrowerStatus"))
//				strBorrStatus    = jsonCIFReqObj.getString("borrowerStatus");
//			if (!jsonCIFReqObj.isNull("employmentType"))
//				strEmployment    = jsonCIFReqObj.getString("employmentType");
//			if (!jsonCIFReqObj.isNull("bankingwithus"))
//				strBanking    = jsonCIFReqObj.getString("bankingwithus");
//			if (!jsonCIFReqObj.isNull("borrowerSince"))
//				strBorrowerSince    = jsonCIFReqObj.getString("borrowerSince");
//			if (!jsonCIFReqObj.isNull("satisfactoryDealing"))
//				strSatisfactory    = jsonCIFReqObj.getString("satisfactoryDealing");
//			if (!jsonCIFReqObj.isNull("staffRelation"))
//				strStaffRelation    = jsonCIFReqObj.getString("staffRelation");
//			if (!jsonCIFReqObj.isNull("introducerStatus"))
//				strIntroStatus    = jsonCIFReqObj.getString("introducerStatus");
//			if (!jsonCIFReqObj.isNull("residentStatus"))
//				strResidentStatus    = jsonCIFReqObj.getString("residentStatus");
//			if (!jsonCIFReqObj.isNull("religion"))
//				strReligion    = jsonCIFReqObj.getString("religion");
//			if (!jsonCIFReqObj.isNull("caste"))
//				strCaste    = jsonCIFReqObj.getString("caste");
//			if (!jsonCIFReqObj.isNull("childDependent"))
//				strChildDep    = jsonCIFReqObj.getString("childDependent");
//			if (!jsonCIFReqObj.isNull("otherDependent"))
//				strOtherDep    = jsonCIFReqObj.getString("otherDependent");
//			if (!jsonCIFReqObj.isNull("earningMember"))
//				strEarningMem    = jsonCIFReqObj.getString("earningMember");
//			if (!jsonCIFReqObj.isNull("familyIncome"))
//				strFamilyIncome    = jsonCIFReqObj.getString("familyIncome");
//			if (!jsonCIFReqObj.isNull("physicallyChallenged"))
//				strPhysicalChgd    = jsonCIFReqObj.getString("physicallyChallenged");
//			if (!jsonCIFReqObj.isNull("blind"))
//				strsel_Blind    = jsonCIFReqObj.getString("blind");
//			if (!jsonCIFReqObj.isNull("branchCode"))
//				strBranchCode    = jsonCIFReqObj.getString("branchCode");
//			
//			//communication details
//			if (!jsonCIFReqObj.isNull("addressLine1"))
//				strComAddress1    = jsonCIFReqObj.getString("addressLine1");
//			if (!jsonCIFReqObj.isNull("addressLine2"))
//				strComAddress2    = jsonCIFReqObj.getString("addressLine2");
//			if (!jsonCIFReqObj.isNull("city"))
//				strComCity    = jsonCIFReqObj.getString("city");
//			if (!jsonCIFReqObj.isNull("district"))
//				strComDistrict    = jsonCIFReqObj.getString("district");
//			if (!jsonCIFReqObj.isNull("state"))
//				strComState    = jsonCIFReqObj.getString("state");
//			if (!jsonCIFReqObj.isNull("country"))
//				strComCountry    = jsonCIFReqObj.getString("country");
//			if (!jsonCIFReqObj.isNull("pincode"))
//				strComPincode    = jsonCIFReqObj.getString("pincode");
//			if (!jsonCIFReqObj.isNull("residentType"))
//				strResidentType    = jsonCIFReqObj.getString("residentType");
//			if (!jsonCIFReqObj.isNull("yearsPresentAddress"))
//				strNoofYearsPresAdd    = jsonCIFReqObj.getString("yearsPresentAddress");
//		
//			//kyc norms
//			if (!jsonCIFReqObj.isNull("occupation"))
//				strCustomerOccupation    = jsonCIFReqObj.getString("occupation");
//			if (!jsonCIFReqObj.isNull("proofType"))
//				strIDprooftype    = jsonCIFReqObj.getString("proofType");
//			if (!jsonCIFReqObj.isNull("idReference"))
//				strIDref    = jsonCIFReqObj.getString("idReference");
//			if (!jsonCIFReqObj.isNull("riskCategory"))
//				strRiskCat    = jsonCIFReqObj.getString("riskCategory");
//			if (!jsonCIFReqObj.isNull("residentProof"))
//				strResidentProof    = jsonCIFReqObj.getString("residentProof");
//			if (!jsonCIFReqObj.isNull("residentIdProof"))
//				strResidentIDref    = jsonCIFReqObj.getString("residentIdProof");
//			if (!jsonCIFReqObj.isNull("natureActivity"))
//				strNatureActivity    = jsonCIFReqObj.getString("natureActivity");
//			if (!jsonCIFReqObj.isNull("residentIdDate"))
//				strResidentIDdate    = jsonCIFReqObj.getString("residentIdDate");
//			if (!jsonCIFReqObj.isNull("idProofExpDate"))
//				stridProoofExpDate    = jsonCIFReqObj.getString("idProofExpDate");
//			
//			
//			//defaulter
//			if (!jsonCIFReqObj.isNull("cibilReferred"))
//				strWhrRefCIBIL    = jsonCIFReqObj.getString("cibilReferred");
//			if (!jsonCIFReqObj.isNull("cibilScore"))
//				strCIBILscore    = jsonCIFReqObj.getString("cibilScore");
//			if (!jsonCIFReqObj.isNull("cibilDetails"))
//				strCIBILdetails    = jsonCIFReqObj.getString("cibilDetails");
//			
//			//inc & exp
//			if (!jsonCIFReqObj.isNull("primaryIncome"))
//				strPrimaryIncome    = jsonCIFReqObj.getString("primaryIncome");
//			if (!jsonCIFReqObj.isNull("grossIncome"))
//				strGrossIncome    = jsonCIFReqObj.getString("grossIncome");
//			if (!jsonCIFReqObj.isNull("incomeTaxDetail"))
//				strIncomeTaxDet    = jsonCIFReqObj.getString("incomeTaxDetail");
//			if (!jsonCIFReqObj.isNull("incomeITR"))
//				strincomeITR    = jsonCIFReqObj.getString("incomeITR");
//			if (!jsonCIFReqObj.isNull("docCollected"))
//				strDocCollected    = jsonCIFReqObj.getString("docCollected");
//			
//			//employment
//			if (!jsonCIFReqObj.isNull("companyName"))
//				strcompanyName    = jsonCIFReqObj.getString("companyName");
//			if (!jsonCIFReqObj.isNull("compAddress"))
//				strcompAddress    = jsonCIFReqObj.getString("compAddress");
//			if (!jsonCIFReqObj.isNull("compCity"))
//				strcompCity    = jsonCIFReqObj.getString("compCity");
//			if (!jsonCIFReqObj.isNull("compState"))
//				strcompState    = jsonCIFReqObj.getString("compState");
//			if (!jsonCIFReqObj.isNull("compPincode"))
//				strcompPincode    = jsonCIFReqObj.getString("compPincode");
//			if (!jsonCIFReqObj.isNull("compPhoneno"))
//				strcompPhoneno    = jsonCIFReqObj.getString("compPhoneno");
//			if (!jsonCIFReqObj.isNull("employeeID"))
//				stremployeeID    = jsonCIFReqObj.getString("employeeID");
//			if (!jsonCIFReqObj.isNull("experinceYears"))
//				strexperinceYears    = jsonCIFReqObj.getString("experinceYears");
//			if (!jsonCIFReqObj.isNull("dateJoining"))
//				strdateJoining    = jsonCIFReqObj.getString("dateJoining");
//			if (!jsonCIFReqObj.isNull("retirementDate"))
//				strretirementDate    = jsonCIFReqObj.getString("retirementDate");
//			if (!jsonCIFReqObj.isNull("confirmedEmployee"))
//				strconfirmedEmployee    = jsonCIFReqObj.getString("confirmedEmployee");
//			if (!jsonCIFReqObj.isNull("listedCompany"))
//				strlistedCompany    = jsonCIFReqObj.getString("listedCompany");
//			if (!jsonCIFReqObj.isNull("salaryReceiptDate"))
//				strsalaryReceiptDate    = jsonCIFReqObj.getString("salaryReceiptDate");
//			if (!jsonCIFReqObj.isNull("commencementDate"))
//				strcommencementDate    = jsonCIFReqObj.getString("commencementDate");
//			if (!jsonCIFReqObj.isNull("yearsCurrentActivity"))
//				stryearsCurrentActivity    = jsonCIFReqObj.getString("yearsCurrentActivity");
//			
//			if (!jsonCIFReqObj.isNull("addressChangeFlag"))
//				strAddressChangeFlag    = jsonCIFReqObj.getString("addressChangeFlag");
//			if (!jsonCIFReqObj.isNull("panFlag"))
//				strPANflag    = jsonCIFReqObj.getString("panFlag");
//			if (!jsonCIFReqObj.isNull("fiAddressFlag"))
//				strfiAddressFlag    = jsonCIFReqObj.getString("fiAddressFlag");
//			if (!jsonCIFReqObj.isNull("fiEmploymentFlag"))
//				strfiEmploymentFlag    = jsonCIFReqObj.getString("fiEmploymentFlag");
//			if (!jsonCIFReqObj.isNull("fiBankStatementFlag"))
//				strfiBankStatFlag    = jsonCIFReqObj.getString("fiBankStatementFlag");
//			if (!jsonCIFReqObj.isNull("emandateEmiFlag"))
//				stremandateEmiFlag    = jsonCIFReqObj.getString("emandateEmiFlag");
//			
//			if (!jsonCIFReqObj.isNull("emanBankAccountNo"))
//				stremanbankacc    = jsonCIFReqObj.getString("emanBankAccountNo");
//			if (!jsonCIFReqObj.isNull("emanBankName"))
//				stremanbankname    = jsonCIFReqObj.getString("emanBankName");
//			if (!jsonCIFReqObj.isNull("permanentaddressChangeFlag"))
//				strPermAddChangeFlag    = jsonCIFReqObj.getString("permanentaddressChangeFlag");
//			if(!jsonCIFReqObj.isNull("fatherName"))
//				strfathername= jsonCIFReqObj.getString("fatherName");
//			
//			if(!jsonCIFReqObj.isNull("staffFlag"))
//				strstafflag= jsonCIFReqObj.getString("staffFlag");
//			
//			if(!jsonCIFReqObj.isNull("educationQualification"))
//				streduqualification= jsonCIFReqObj.getString("educationQualification");
//			 
//			if(!jsonCIFReqObj.isNull("mobileNumber"))
//				mobileNumber= jsonCIFReqObj.getString("mobileNumber");
//		
//			if(!jsonCIFReqObj.isNull("customerEmail"))
//				customerEmail= jsonCIFReqObj.getString("customerEmail");
//			
//			if(!jsonCIFReqObj.isNull("itrflag"))
//				strItrFlag= jsonCIFReqObj.getString("itrflag");
//			
//			if(!jsonCIFReqObj.isNull("businessProofFlag"))
//				strBusinessProofFlag= jsonCIFReqObj.getString("businessProofFlag");
//			
//			if(!jsonCIFReqObj.isNull("officeAddFlag"))
//				strOfficeAddFlag= jsonCIFReqObj.getString("officeAddFlag");
//			
//			if(!jsonCIFReqObj.isNull("community"))
//				strcommunity= jsonCIFReqObj.getString("community");
//		
//			
//			if(!jsonCIFReqObj.isNull("networthBorrower"))
//				strnetworthBorrower= jsonCIFReqObj.getString("networthBorrower");
//			
//			if (!jsonCIFReqObj.isNull("proformaInvoice"))
//				strproforma    = jsonCIFReqObj.getString("proformaInvoice");
//			if (!jsonCIFReqObj.isNull("ownResidenceProof"))
//				strResidenceProof    = jsonCIFReqObj.getString("ownResidenceProof");
//			
//			if (!jsonCIFReqObj.isNull("incomeYearEnded"))
//				strincomeYearEnded    = jsonCIFReqObj.getString("incomeYearEnded");
//			if (!jsonCIFReqObj.isNull("itrFillingDate"))
//				stritrFillingDate    = jsonCIFReqObj.getString("itrFillingDate");
//			if (!jsonCIFReqObj.isNull("udyogAadharNumber"))
//				strudyogAadharNumber    = jsonCIFReqObj.getString("udyogAadharNumber");
//			if (!jsonCIFReqObj.isNull("gstin"))
//				strgstin    = jsonCIFReqObj.getString("gstin");
//			if (!jsonCIFReqObj.isNull("mseRegNumber"))
//				strmseRegNumber    = jsonCIFReqObj.getString("mseRegNumber");
//			
//			if (!jsonCIFReqObj.isNull("comAddressLine2"))
//				strComAddressLine2    = jsonCIFReqObj.getString("comAddressLine2");
//			
//			if (!jsonCIFReqObj.isNull("comAddressLine3"))
//				strComAddressLine3    = jsonCIFReqObj.getString("comAddressLine3");
//			
//			
//			if (!jsonCIFReqObj.isNull("incomeYearEndPreviousYear"))
//				strIncomeYearEndPreviousYear    = jsonCIFReqObj.getString("incomeYearEndPreviousYear");
//			
//			if (!jsonCIFReqObj.isNull("itrFillDatePreviousYear"))
//				itrFillDatePreviousYear    = jsonCIFReqObj.getString("itrFillDatePreviousYear");
//			
//			if (!jsonCIFReqObj.isNull("itrSalaryPreviousYear"))
//				stritrSalaryPreviousYear    = jsonCIFReqObj.getString("itrSalaryPreviousYear");
//			
//			if (!jsonCIFReqObj.isNull("udyamRegistrationNumber"))
//				strudyamRegistrationNumber    = jsonCIFReqObj.getString("udyamRegistrationNumber");
//			
//			if (!jsonCIFReqObj.isNull("salesTurnOverApplicant"))
//				strsalesTurnOverApplicant    = jsonCIFReqObj.getString("salesTurnOverApplicant");
//			
//			if (!jsonCIFReqObj.isNull("salesTurnOverDate"))
//				strsalesTurnOverDate    = jsonCIFReqObj.getString("salesTurnOverDate");
//			
//			if (!jsonCIFReqObj.isNull("criteriaforSalesTurnover"))
//				strcriteriaforSalesTurnover    = jsonCIFReqObj.getString("criteriaforSalesTurnover");
//			
//			if (!jsonCIFReqObj.isNull("udyamRegistrationClassification"))
//				strudyamRegistrationClassification    = jsonCIFReqObj.getString("udyamRegistrationClassification");
//			
//			if (!jsonCIFReqObj.isNull("udyamDate"))
//				strudyamDate    = jsonCIFReqObj.getString("udyamDate");
//			
//			if (!jsonCIFReqObj.isNull("cibilDate"))
//				strcibilDate    = jsonCIFReqObj.getString("cibilDate");
			
//			JSONArray existingafcility= new JSONArray();
//			if (!jsonCIFReqObj.isNull("existingFacility"))
//				existingafcility=jsonCIFReqObj.getJSONArray("existingFacility");
//			JSONObject jasonExistFaclty= new JSONObject();
//			int existFacLenth=existingafcility.length();
//			ArrayList arrExistFaclty=new ArrayList();
//			ArrayList arrExistFacltyValues=new ArrayList();
//			if(existFacLenth>0)
//			{
//			for(int i=0;i<existFacLenth;i++)
//				{
//					jasonExistFaclty=(JSONObject)existingafcility.get(i);
//				
//					String strnameOfBank=jasonExistFaclty.getString("nameOfBank");
//					String strType=jasonExistFaclty.getString("type");	
//					String strfacility=jasonExistFaclty.getString("facility");	
//					String strpurposeOfLaon=jasonExistFaclty.getString("purposeOfLaon");	
//					String strtypeOfFacility=jasonExistFaclty.getString("typeOfFacility");	
//					String strlimit=jasonExistFaclty.getString("limit");	
//					String stroutstanding=jasonExistFaclty.getString("outstanding");	
//					String stroutstandingDate=jasonExistFaclty.getString("outstandingDate");	
//					String strbankingType=jasonExistFaclty.getString("bankingType");	
//					String strInterestType=jasonExistFaclty.getString("interestType");	
//					String strspreadValue=jasonExistFaclty.getString("spreadValue");	
//					String strRepaymentType=jasonExistFaclty.getString("repaymentType");	
//					String strDueDate=jasonExistFaclty.getString("dueDate");	
//					String strsecurityDesc=jasonExistFaclty.getString("securityDesc");	
//					String strsecurityValue=jasonExistFaclty.getString("securityValue");	
//					String strwhetherLitigation=jasonExistFaclty.getString("whetherLitigation");
//					String strnatureOfLitigation=jasonExistFaclty.getString("natureOfLitigation");
//					String strdateOfLitigation=jasonExistFaclty.getString("dateOfLitigation");	
//					String strclaimAmount=jasonExistFaclty.getString("claimAmount");	
//					String strotherClaim=jasonExistFaclty.getString("otherClaim");	
//					String strpresentPosition=jasonExistFaclty.getString("presentPosition");	
//					
//					arrExistFacltyValues=new ArrayList();
//					
//					arrExistFacltyValues.add(strnameOfBank);
//					arrExistFacltyValues.add(strType);
//					arrExistFacltyValues.add(strfacility);
//					arrExistFacltyValues.add(strpurposeOfLaon);
//					arrExistFacltyValues.add(strtypeOfFacility);
//					arrExistFacltyValues.add(strlimit);
//					arrExistFacltyValues.add(stroutstanding);
//					arrExistFacltyValues.add(stroutstandingDate);
//					arrExistFacltyValues.add(strbankingType);
//					arrExistFacltyValues.add(strInterestType);
//					arrExistFacltyValues.add(strspreadValue);
//					arrExistFacltyValues.add(strRepaymentType);
//					arrExistFacltyValues.add(strDueDate);	
//					arrExistFacltyValues.add(strsecurityDesc);	
//					arrExistFacltyValues.add(strsecurityValue);
//					arrExistFacltyValues.add(strwhetherLitigation);
//					arrExistFacltyValues.add(strnatureOfLitigation);
//					arrExistFacltyValues.add(strdateOfLitigation);
//					arrExistFacltyValues.add(strclaimAmount);
//					arrExistFacltyValues.add(strotherClaim);
//					arrExistFacltyValues.add(strpresentPosition);
//					arrExistFaclty.add(arrExistFacltyValues);
//				}
//			}
//			
//			if (!jsonCIFReqObj.isNull("crifScore"))
//				strcrifScore    = jsonCIFReqObj.getString("crifScore");
//			
//			if (!jsonCIFReqObj.isNull("crifDetails"))
//				strcrifDetails    = jsonCIFReqObj.getString("crifDetails");
//			
//			if (!jsonCIFReqObj.isNull("crifReportedDate"))
//				crifReportedDate    = jsonCIFReqObj.getString("crifReportedDate");
//			
//			if (!jsonCIFReqObj.isNull("spouseName"))
//				strSpouseName    = jsonCIFReqObj.getString("spouseName");
//			
//			if (!jsonCIFReqObj.isNull("motherName"))
//				strMotherName    = jsonCIFReqObj.getString("motherName");
//			
//			
//			JSONArray landHolding= new JSONArray();
//			if (!jsonCIFReqObj.isNull("landHolding"))
//			landHolding=jsonCIFReqObj.getJSONArray("landHolding");
//			
//			JSONObject jasonlandHolding= new JSONObject();
//			int landHoldingLenth=landHolding.length();
//			ArrayList arrLandHold=new ArrayList();
//			ArrayList arrLandHoldValues=new ArrayList();
//			if(landHoldingLenth>0)
//			{
//			for(int i=0;i<landHoldingLenth;i++)
//				{
//					jasonlandHolding=(JSONObject)landHolding.get(i);		
//					String landhold=jasonlandHolding.getString("landHold");
//					String surveyNo=jasonlandHolding.getString("surveyNo");
//					String ownedOrLeased=jasonlandHolding.getString("ownedOrLeased");
//					String farmercategory=jasonlandHolding.getString("farmerCategory");
//					String landlesslabour=jasonlandHolding.getString("landLessLabourType");
//					
//					arrLandHoldValues=new ArrayList();			
//					arrLandHoldValues.add(landhold);
//					arrLandHoldValues.add(surveyNo);
//					arrLandHoldValues.add(ownedOrLeased);
//					arrLandHoldValues.add(farmercategory);
//					arrLandHoldValues.add(landlesslabour);
//					arrLandHold.add(arrLandHoldValues);
//				}
//			}
//			//Mandatory Check
//			if(strFullName.equals("") || strConstitution.equals("") || strGender.equals("") || strMaritalStatus.equals("") 
//				|| strBorrStatus.equals("") || strBanking.equals("") || strReligion.equals("") || strCaste.equals("")
//				|| strOtherDep.equals("") || strPhysicalChgd.equals("") || strsel_Blind.equals("") || strBranchCode.equals("") || strComAddress1.equals("")
//				|| strComAddress2.equals("") || strComCity.equals("") || strComDistrict.equals("") || strComState.equals("") || strComCountry.equals("")
//				|| strComPincode.equals("") || strResidentType.equals("") || strCustomerOccupation.equals("") || strGrossIncome.equals("")
//				|| strincomeITR.equals("") || strWhrRefCIBIL.equals("") || strCIBILscore.equals("") || strCIBILdetails.equals("")
//					)
//			
//			{
//				return Constants.ERROR_RESPONSE_MANDATORY;
//			}
//
//			if(strEmployment.equals("1"))
//			{
//					if(strcompanyName.equals("") || strcompAddress.equals("") || strcompCity.equals("") || strcompState.equals("") || strcompPincode.equals("")
//						|| strcompPhoneno.equals("") || strexperinceYears.equals("") )
//					{
//						return Constants.ERROR_RESPONSE_MANDATORY;
//					}
//			}
//			
//			SimpleDateFormat sdfrmt = new SimpleDateFormat("dd/mm/yyyy");
//
//			if(!strDOB.equals(""))
//			{
//			 	try
//			 	{
//				 	Date javaDate = sdfrmt.parse(strDOB); 
//			 	}
//		    	catch (ParseException e)
//			    {
//					return Constants.ERROR_RESPONSE_INVALID_DATEFORMAT;
//			    }
//			}
//			if(!strBorrowerSince.equals(""))
//			{
//			 	try
//			 	{
//				 	Date javaDate1 = sdfrmt.parse(strBorrowerSince); 
//			 	}
//		    	catch (ParseException e)
//			    {
//					return Constants.ERROR_RESPONSE_INVALID_DATEFORMAT;
//			    }
//			}
//			
//			
//			
//			if(!strPANNo.equals(""))
//			{
//				Pattern pattern = Pattern.compile("[A-Z]{5}[0-9]{4}[A-Z]{1}");
//				Matcher matcher = pattern.matcher(strPANNo);
//				if (!matcher.matches()) 
//				{
//					return Constants.ERROR_RESPONSE_INVALID_PANNO;
//				}
//			}
//			
//			if(strGender.equals("M"))
//			{
//				strTitle="MR";
//			}
//			else if(strGender.equals("F") && strMaritalStatus.equals("MARID"))
//			{
//				strTitle="MRS";
//			}
//			else if(strGender.equals("F") && strMaritalStatus.equals("SINGL"))
//			{
//				strTitle="MS";
//			}
//			
//			String[] strShortNameTemp=strFullName.trim().split(" ");
//			if(strShortNameTemp.length>0)
//			{
//				strShortName=strShortNameTemp[0];
//			}
//			else
//			{
//				strShortName="";
//			}
//			
//			if(strFullName.length()>6)
//			{
//				strShortName=strFullName.substring(0, 6);
//			}
//			else
//			{
//				strShortName=strFullName;
//			}
//			
//			int cusAge=Integer.parseInt(Helper.calculateAGE(strDOB));
//			if(cusAge>60)
//			{
//				strStatus="100";
//			}
//			else 
//			{
//				strStatus="001";
//			}
//			
//			//default values
//			strSatisfactory="Y";
//			strIntroStatus="3";
//			strResidentStatus="N";
//			strChildDep="0";
//			strEarningMem="0";
//			strFamilyIncome="0.00";
//			strconfirmedEmployee="1";
//			strlistedCompany="1";
//			//strNoofYearsPresAdd="0~0";
//			//strIDprooftype="01";
//			//strIDref=strPANNo;
//			strRiskCat="1";
//			strNatureActivity="N";
//			//strIncomeTaxDet="1";
//			//strDocCollected="I";
//			stremployeeID="NA";
//			if(strDocCollected.equals(""))
//			{
//				strDocCollected="B";
//			}
//			
//			int expinyears= Integer.parseInt(Helper.correctInt((String)strexperinceYears));
//			Calendar cal = Calendar.getInstance();
//			cal.add(Calendar.YEAR, -expinyears);
//			strdateJoining=(cal.get(Calendar.DATE) + "/"+ (cal.get(Calendar.MONTH)+1) + "/" + cal.get(Calendar.YEAR));
//			
//			//strretirementDate="01/01/1900";
//		/*	Calendar cal2 = Calendar.getInstance();
//			strsalaryReceiptDate=("07/"+ (cal2.get(Calendar.MONTH)) + "/" + cal2.get(Calendar.YEAR));
//			*/
//			
//			
//			
//			HashMap hshJsonValues = new HashMap();
//			hshJsonValues.put("strCBSID",strCBSID);
//			hshJsonValues.put("strTitle",strTitle);
//			hshJsonValues.put("strFullName",strFullName);
//			hshJsonValues.put("strShortName",strShortName);
//			hshJsonValues.put("strConstitution",strConstitution);
//			hshJsonValues.put("strDOB",strDOB);
//			hshJsonValues.put("strPANNo",strPANNo);
//			hshJsonValues.put("strGender",strGender);
//			hshJsonValues.put("strMaritalStatus",strMaritalStatus);
//			hshJsonValues.put("strStatus",strStatus);
//			hshJsonValues.put("strTaxSlab",strTaxSlab);
//			hshJsonValues.put("strBorrStatus",strBorrStatus);
//			hshJsonValues.put("strEmployment",strEmployment);
//			hshJsonValues.put("strBanking",strBanking);
//			hshJsonValues.put("strBorrowerSince",strBorrowerSince);
//			hshJsonValues.put("strSatisfactory",strSatisfactory);
//			hshJsonValues.put("strStaffRelation",strStaffRelation);
//			hshJsonValues.put("strIntroStatus",strIntroStatus);
//			hshJsonValues.put("strResidentStatus",strResidentStatus);
//			hshJsonValues.put("strReligion",strReligion);
//			hshJsonValues.put("strCaste",strCaste);
//			hshJsonValues.put("strChildDep",strChildDep);
//			hshJsonValues.put("strOtherDep",strOtherDep);
//			hshJsonValues.put("strEarningMem",strEarningMem);
//			hshJsonValues.put("strFamilyIncome",strFamilyIncome);
//			hshJsonValues.put("strPhysicalChgd",strPhysicalChgd);
//			hshJsonValues.put("strsel_Blind",strsel_Blind);
//			hshJsonValues.put("strBranchCode",strBranchCode);
//			
//			hshJsonValues.put("strComAddress1",strComAddress1);
//			hshJsonValues.put("strComAddress2",strComAddress2);
//			hshJsonValues.put("strComCity",strComCity);
//			hshJsonValues.put("strComDistrict",strComDistrict);
//			hshJsonValues.put("strComState",strComState);
//			hshJsonValues.put("strComCountry",strComCountry);
//			hshJsonValues.put("strComPincode",strComPincode);
//			hshJsonValues.put("strResidentType",strResidentType);
//			hshJsonValues.put("strNoofYearsPresAdd",strNoofYearsPresAdd);
//
//			hshJsonValues.put("strCustomerOccupation",strCustomerOccupation);
//			hshJsonValues.put("strIDprooftype",strIDprooftype);
//			hshJsonValues.put("strIDref",strIDref);
//			hshJsonValues.put("strRiskCat",strRiskCat);
//			hshJsonValues.put("strResidentProof",strResidentProof);
//			hshJsonValues.put("strResidentIDref",strResidentIDref);
//			hshJsonValues.put("strNatureActivity",strNatureActivity);
//			hshJsonValues.put("strResidentIDdate",strResidentIDdate);
//			hshJsonValues.put("stridProoofExpDate",stridProoofExpDate);
//			
//			hshJsonValues.put("strWhrRefCIBIL",strWhrRefCIBIL);
//			hshJsonValues.put("strCIBILscore",strCIBILscore);
//			hshJsonValues.put("strCIBILdetails",strCIBILdetails);
//
//			hshJsonValues.put("strPrimaryIncome",strPrimaryIncome);
//			hshJsonValues.put("strGrossIncome",strGrossIncome);
//			hshJsonValues.put("strIncomeTaxDet",strIncomeTaxDet);
//			hshJsonValues.put("strincomeITR",strincomeITR);
//			hshJsonValues.put("strDocCollected",strDocCollected);
//
//			hshJsonValues.put("strcompanyName",strcompanyName);
//			hshJsonValues.put("strcompAddress",strcompAddress);
//			hshJsonValues.put("strcompCity",strcompCity);
//			hshJsonValues.put("strcompState",strcompState);
//			hshJsonValues.put("strcompPincode",strcompPincode);
//			hshJsonValues.put("strcompPhoneno",strcompPhoneno);
//			hshJsonValues.put("stremployeeID",stremployeeID);
//			hshJsonValues.put("strexperinceYears",strexperinceYears);
//			hshJsonValues.put("strdateJoining",strdateJoining);
//			hshJsonValues.put("strretirementDate",strretirementDate);
//			hshJsonValues.put("strconfirmedEmployee",strconfirmedEmployee);
//			hshJsonValues.put("strlistedCompany",strlistedCompany);
//			hshJsonValues.put("strsalaryReceiptDate",strsalaryReceiptDate);
//			hshJsonValues.put("strcommencementDate",strcommencementDate);
//			hshJsonValues.put("stryearsCurrentActivity",stryearsCurrentActivity);
//		
//			hshJsonValues.put("strAddressChangeFlag",strAddressChangeFlag);
//			hshJsonValues.put("strPANflag",strPANflag);
//			hshJsonValues.put("strfiAddressFlag",strfiAddressFlag);
//			hshJsonValues.put("strfiEmploymentFlag",strfiEmploymentFlag);
//			hshJsonValues.put("strfiBankStatFlag",strfiBankStatFlag);
//			hshJsonValues.put("stremandateEmiFlag",stremandateEmiFlag);
//			hshJsonValues.put("stremanbankacc",stremanbankacc);
//			hshJsonValues.put("stremanbankname",stremanbankname);
//			hshJsonValues.put("strPermAddChangeFlag",strPermAddChangeFlag);
//			hshJsonValues.put("strfathername",strfathername);
//			hshJsonValues.put("strstafflag",strstafflag);
//			hshJsonValues.put("streduqualification",streduqualification);
//			hshJsonValues.put("strItrFlag",strItrFlag);
//			hshJsonValues.put("strBusinessProofFlag",strBusinessProofFlag);
//			hshJsonValues.put("strOfficeAddFlag",strOfficeAddFlag);			
//			hshJsonValues.put("mobileNumber",mobileNumber);
//			hshJsonValues.put("customerEmail",customerEmail);
//			hshJsonValues.put("strcommunity",strcommunity);
//			hshJsonValues.put("strnetworthBorrower",strnetworthBorrower);
//			hshJsonValues.put("strproforma",strproforma);
//			hshJsonValues.put("strResidenceProof",strResidenceProof);
//			hshJsonValues.put("existingFacility",arrExistFaclty);
//			
//			hshJsonValues.put("strincomeYearEnded",strincomeYearEnded);
//			hshJsonValues.put("stritrFillingDate",stritrFillingDate);
//			hshJsonValues.put("strudyogAadharNumber",strudyogAadharNumber);
//			hshJsonValues.put("strgstin",strgstin);
//			hshJsonValues.put("strmseRegNumber",strmseRegNumber);
//			
//			hshJsonValues.put("strcrifScore",strcrifScore);
//			hshJsonValues.put("strcrifDetails",strcrifDetails);
//			hshJsonValues.put("crifReportedDate",crifReportedDate);
//			
//			hshJsonValues.put("strSpouseName",strSpouseName);
//			hshJsonValues.put("strMotherName",strMotherName);
//			hshJsonValues.put("landHolding",arrLandHold);
//			hshJsonValues.put("strComAddressLine2",strComAddressLine2);
//			hshJsonValues.put("strComAddressLine3",strComAddressLine3); 
//			hshJsonValues.put("strIncomeYearEndPreviousYear",strIncomeYearEndPreviousYear);
//			hshJsonValues.put("itrFillDatePreviousYear",itrFillDatePreviousYear); 
//			hshJsonValues.put("stritrSalaryPreviousYear",stritrSalaryPreviousYear); 
//			hshJsonValues.put("strudyamRegistrationNumber",strudyamRegistrationNumber);
//			hshJsonValues.put("strsalesTurnOverApplicant",strsalesTurnOverApplicant);
//			hshJsonValues.put("strsalesTurnOverDate",strsalesTurnOverDate);
//			hshJsonValues.put("strcriteriaforSalesTurnover",strcriteriaforSalesTurnover);
//			hshJsonValues.put("strudyamRegistrationClassification",strudyamRegistrationClassification);
//			hshJsonValues.put("strudyamDate",strudyamDate);
//			hshJsonValues.put("strcibilDate",strcibilDate);
			HashMap hshJsonValues = new HashMap();
			hshJsonValues.put("strCBSID",strCBSID);
			hshValues = (HashMap) EJBInvoker.executeStateLess("DigitalAppInterface",hshJsonValues,"perappidcreation");
			strNewLAPSid  = Helper.correctNull((String)hshValues.get("strNewLAPSid"));
			String strmandatorymissing  = Helper.correctNull((String)hshValues.get("mandatorymissing"));
			strResponseCode=Helper.correctNull((String)hshValues.get("strResponseCode"));
			strResponseMsg=Helper.correctNull((String)hshValues.get("strResponseMsg"));
			
			if(strmandatorymissing.equalsIgnoreCase("Y"))
			{
				responseData.put("MandatoryfieldsMissing",hshValues.get("keyArrCBSNotFilledMandatoryFields") );
			}
			else
			{
				responseData.put("LAPSCustomerID", strNewLAPSid);
			}
			
			
			response.setData(responseData);
			response.setResp_code(strResponseCode);
			response.setResp_msg(strResponseMsg);
			
			jsonAsString = objectMapper.writeValueAsString(response);
		}
		catch (Exception e)
		{
			response.setData(responseData);
			response.setResp_code("LAPS-2003");
			response.setResp_msg("Invalid request parameters");
			jsonAsString = objectMapper.writeValueAsString(response);
			e.printStackTrace();
			throw new EJBException("Error in inwardDetailServiceImpl customerCreation..."+e.toString());
		}
		return jsonAsString;	
	}
	
	
	
}








