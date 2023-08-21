
package com.sai.laps.webservices.rest.services.msme;

import java.sql.ResultSet;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.ejb.EJBException;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sai.laps.helper.Constants;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.webservices.rest.domain.CustomerCreation;
import com.sai.laps.webservices.rest.domain.Response;
import com.sai.laps.webservices.rest.domain.msme.MsmeCustomerCreation;

import com.sai.laps.webservices.rest.domain.msme.MsmeDedupeCheck;

import com.sai.laps.webservices.rest.domain.msme.BasicInformationCust;

import com.sai.laps.webservices.rest.domain.msme.BureauVariable;
import com.sai.laps.webservices.rest.domain.msme.CreditAppraisalModule;
import com.sai.laps.webservices.rest.domain.msme.DigiRating;
import com.sai.laps.webservices.rest.domain.msme.FacilityProposal;
import com.sai.laps.webservices.rest.domain.msme.FinancialDigiRating;
import com.sai.laps.webservices.rest.domain.msme.MsmeLarService;
import com.sai.laps.webservices.rest.domain.msme.RenewalProposals;
import com.sai.laps.webservices.rest.services.InwardDetailServiceImpl;

public class MsmeServiceImpl implements MsmeService{

	private static final Exception JsonProcessingException = null;
	ObjectMapper objectMapper = new ObjectMapper();

	static Logger log = Logger.getLogger(MsmeServiceImpl.class);
	
	public String msmeLarCreation(MsmeLarService msmeLarService)throws JsonProcessingException {
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
		strBranchSolid="",strFname="",strbussnissdate="",strAddchangeFlag="",strInwardAction="",strLARnumber="",strapplProcessLoc="",strschemeDesc="",strdigiAppNo="",strleadGeneratedAgentId="",strleadStaffId="",strleadConvertedBy="",
		strsectorType="",strworkingCapital="",strtermLoan="",strnonFundBased="",strwhetherSSI="",strwhetherTinyInd="";
		
		 		
		
		String strResponseMsg="",strResponseCode="";
		
		try
		{
			
			JSONObject jsonCIFReqObj		= new JSONObject(msmeLarService);
			//JSONObject getCIFReqObj  	    = jsonCIFReqObj.getJSONObject("SysarcLARReq");
			//JSONObject JsonHeader		    = getCIFReqObj.getJSONObject("Header");
			//JSONObject JsonBody		        = jsonCIFReqObj.getJSONObject("Body");
			//JSONObject jsonObject = new JSONObject(strServerResponse);

			if (!jsonCIFReqObj.isNull("firstName"))
				strFname  = jsonCIFReqObj.getString("firstName");
			if (!jsonCIFReqObj.isNull("businessCommencementDate"))
				strbussnissdate    = jsonCIFReqObj.getString("businessCommencementDate");
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
			
			if (!jsonCIFReqObj.isNull("inwardAction"))
				strInwardAction    = jsonCIFReqObj.getString("inwardAction");	
			if (!jsonCIFReqObj.isNull("larNumber"))
				strLARnumber    = jsonCIFReqObj.getString("larNumber");	
		
			if (!jsonCIFReqObj.isNull("applProcessLoc"))
				 strapplProcessLoc  = jsonCIFReqObj.getString("applProcessLoc");	
			
			
			if (!jsonCIFReqObj.isNull("digiAppNo"))
				strdigiAppNo  = jsonCIFReqObj.getString("digiAppNo");		
			
			if (!jsonCIFReqObj.isNull("leadGeneratedId"))
				strleadGeneratedAgentId  = jsonCIFReqObj.getString("leadGeneratedId");

			if (!jsonCIFReqObj.isNull("leadStaffId"))
				strleadStaffId  = jsonCIFReqObj.getString("leadStaffId");

			if (!jsonCIFReqObj.isNull("leadConvertedBy"))
				strleadConvertedBy  = jsonCIFReqObj.getString("leadConvertedBy");
		
			
			if (!jsonCIFReqObj.isNull("termLoan"))
				strtermLoan  = jsonCIFReqObj.getString("termLoan");
			
			if (!jsonCIFReqObj.isNull("nonFundBased"))
				strnonFundBased  = jsonCIFReqObj.getString("nonFundBased");
			
			if (!jsonCIFReqObj.isNull("workingCapital"))
				strworkingCapital  = jsonCIFReqObj.getString("workingCapital");
			
			if (!jsonCIFReqObj.isNull("whetherSSI"))
				strwhetherSSI  = jsonCIFReqObj.getString("whetherSSI");
			
			if (!jsonCIFReqObj.isNull("whetherTinyInd"))
				strwhetherTinyInd  = jsonCIFReqObj.getString("whetherTinyInd");
			
			

			//Mandatory Check
			if( strFname.equals("") || strbussnissdate.equals("") || strappdate.equals("") || strcusttype.equals("") || strcomcustadd1.equals("") ||
				strcomcustadd2.equals("") || strhidcity.equals("") || strhidstate.equals("") || strhiddist.equals("") || strcomcust_zip.equals("") || 
				strcomcust_mobile.equals("") ||	strcomcust_email.equals("") || strcomloanpur.equals("") || 
				 strdocrecd.equals("") || strapplstatus.equals("") || strleadno.equals("") || strBranchSolid.equals("") || strapplProcessLoc.equals("")
				|| strtermLoan.equals("")|| strnonFundBased.equals("") || strworkingCapital.equals("")|| strwhetherSSI.equals("")|| strwhetherTinyInd.equals(""))
			{
				
				return Constants.ERROR_RESPONSE_MANDATORY;

			}
			
			if(!strbussnissdate.equals("") && !strappdate.equals(""))
			{
				SimpleDateFormat sdfrmt = new SimpleDateFormat("dd/mm/yyyy");
			 	try
			 	{
				 	Date javaDate = sdfrmt.parse(strbussnissdate); 
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
			hshJsonValues.put("strbussnissdate",strbussnissdate);
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
			//hshJsonValues.put("txtret_ftf",strret_ftf);
			hshJsonValues.put("txt_receidate",strreceidate);
			hshJsonValues.put("seldocrecd",strdocrecd);
			hshJsonValues.put("hid_dist",strhiddist);
			hshJsonValues.put("selapplstatus",strapplstatus);
			hshJsonValues.put("txt_rejreason",strrejreason);
			//hshJsonValues.put("sel_bankscheme",strbankscheme); 
			hshJsonValues.put("selborrowerstatus",strcusttype);
			hshJsonValues.put("txt_leadno",strleadno);
			//hshJsonValues.put("strAddchangeFlag",strAddchangeFlag);
			hshJsonValues.put("strInwardAction",strInwardAction);
			hshJsonValues.put("strLARnumber",strLARnumber);
			hshJsonValues.put("strapplProcessLoc",strapplProcessLoc);
			//hshJsonValues.put("strschemeDesc",strschemeDesc);
			hshJsonValues.put("strdigiAppNo",strdigiAppNo);
			hshJsonValues.put("strleadGeneratedAgentId",strleadGeneratedAgentId);
			hshJsonValues.put("strleadStaffId",strleadStaffId);
			hshJsonValues.put("strleadConvertedBy",strleadConvertedBy);
			
			hshJsonValues.put("workingCapital",strworkingCapital);
			hshJsonValues.put("termLoan",strtermLoan);
			hshJsonValues.put("nonFundBased",strnonFundBased);
			hshJsonValues.put("whetherSSI",strwhetherSSI);
			hshJsonValues.put("whetherTinyInd",strwhetherTinyInd);
			
			
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
				hshValues = (HashMap) EJBInvoker.executeStateLess("MsmeDigitalAppInterface",hshJsonValues,"updateMsmeLarService");
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
			response.setResp_code("LAPS-3003");
			response.setResp_msg("Invalid request parameters");
			jsonAsString = objectMapper.writeValueAsString(response);
			e.printStackTrace();
			throw new EJBException("Exception in msmeLarCreation ==="+e.getMessage());
		}
		return jsonAsString;	
				
	}
	
	public String msmeRenewalProposals(RenewalProposals RenewalProposals)throws JsonProcessingException {
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
			
			JSONObject jsonCIFReqObj		= new JSONObject(RenewalProposals);
			//JSONObject getCIFReqObj  	    = jsonCIFReqObj.getJSONObject("SysarcLARReq");
			//JSONObject JsonHeader		    = getCIFReqObj.getJSONObject("Header");
			//JSONObject JsonBody		        = jsonCIFReqObj.getJSONObject("Body");
			//JSONObject jsonObject = new JSONObject(strServerResponse);

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
			
			hshValues1 = (HashMap) EJBInvoker.executeStateLess("MsmeDigitalAppInterface",hshJsonValues,"renewalProposal");
			//strRefNo  = Helper.correctNull((String)hshValues.get("strInwardno"));
			
			ArrayList arrayList1 = (ArrayList)hshValues1.get("strrenewalProposals");
			if(arrayList1.size()>0 && arrayList1!=null)
			{
				for(int i=0; i<arrayList1.size(); i++){
					hshValues = (HashMap) arrayList1.get(i);
				
					responseDataMap = new HashMap<String,Object>();
					//if(strApplExists.equals("Y"))
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
						responseDataMap.put("sol_id", Helper.correctNull((String)hshValues.get("sol_id")));
						responseDataMap.put("facilitytype", Helper.correctNull((String)hshValues.get("facilitytype")));
						responseDataMap.put("sublimit",((ArrayList)hshValues.get("sublimit")));
						arrValues.add(responseDataMap);
						
						
					
					}
				}}
			strResponseCode="LAPS-3001";
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
			throw new EJBException("Exception in msmeRenewalProposals ==="+e.getMessage());
		}
		return jsonAsString;	

	}
	

	
	public String basicInformationCust(BasicInformationCust BasicInformationCust)
			throws JsonProcessingException {

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
		String strResponseMsg="",strResponseCode="",strCustomerID="",strProposalID="",strFacilityID="";
		
		try
		{
			
			JSONObject jsonCIFReqObj		= new JSONObject(BasicInformationCust);
			
			if (!jsonCIFReqObj.isNull("customerID"))
				strCustomerID  = jsonCIFReqObj.getString("customerID");
			
			if (!jsonCIFReqObj.isNull("proposalID"))
				strProposalID  = jsonCIFReqObj.getString("proposalID");
			
			if (!jsonCIFReqObj.isNull("facilityID"))
				strFacilityID  = jsonCIFReqObj.getString("facilityID");
			
			if(strCustomerID.equals(""))
				{
					return Constants.ERROR_RESPONSE_MANDATORY;
				}
			

			HashMap hshJson = new HashMap();
			HashMap hshJsonValues = new HashMap();
			hshJsonValues.put("strCustomerID",strCustomerID);
			hshJsonValues.put("strProposalID",strProposalID);
			hshJsonValues.put("strFacilityID",strFacilityID);
			
	
			hshValues1 = (HashMap) EJBInvoker.executeStateLess("MsmeDigitalAppInterface",hshJsonValues,"basicInformationCustomer");
			
			
			responseData.put("AssociateConcerns", hshValues1.get("AssociateConcerns"));
			responseData.put("EnterpriseInformation", hshValues1.get("EnterpriseInformation"));
			responseData.put("IndividualInformation", hshValues1.get("IndividualInformation"));
			responseData.put("ExistingFacilities", hshValues1.get("ExistingFacilities"));
			strResponseCode="LAPS-3005";
			strResponseMsg="Basic Information Fetch service Completed Successfully";
			
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
			throw new EJBException("Exception in basicInformationCust ==="+e.getMessage());
		}
		return jsonAsString;	
	}		

	
	public String msmeCustomerCreationService(MsmeCustomerCreation msmeCustomerCreation)
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
		String strWhrRefCIBIL="",strCIBILscore="",strCIBILdetails="",strWhrRefCRIF="";
		
		//Employment details
		String strcompanyName="",strcompAddress="",strcompCity="",strcompState="",strcompPincode="",strcompPhoneno="",stremployeeID="",
		strexperinceYears="",strdateJoining="",strretirementDate="",strconfirmedEmployee="",strlistedCompany="",strsalaryReceiptDate="",
		strcommencementDate="",stryearsCurrentActivity="";
		
		String strAddressChangeFlag="",strPANflag="",strfiAddressFlag="",strfiEmploymentFlag="",strfiBankStatFlag="",stremandateEmiFlag="";
		String stremanbankacc="",stremanbankname="",strPermAddChangeFlag="",strfathername="",strstafflag="",streduqualification="",
		strItrFlag="",strBusinessProofFlag="",strOfficeAddFlag="";
		
		String  strcompanyIdNo="",strtin="",strtotalEmployees="",strgroupName="",strwhetherFirmMif="",strwhetherBelongsScSt="",strwhetherBelongsMinorityComm="",
		stradminAddress="",stradminvillage="",stradmincity="",stradminDistric="",stradminState="",stradminPinCode="",stradminCountry="",
		stradminPhoneNo="",stradminFaxNo="",stradminwebsite="",strcorpAddress="",strcorpVillage="",strcorpCity="",strcorpDistrict="",strcorpState="",
		strcorpPinCode="",strcorpCountry="",strcorpPhoneNo="",strcorpFaxNo="",strcorpwebsite="", strcorpEMail="",
		strnetworthBorrower="",strshareholdingByWomen="",stridenificationNo="",strleiExpiryDate="",strintroducerType="",strintroducerName="",
		strbankingArrangemnt="",strtradeFinance="",strtypeOfOwnership="",strrocNumber="",strindustryType="";		
		String strincomeYearEnded="",stritrFillingDate="",strudyogAadharNumber="",strgstin="",strmseRegNumber="",strAdminAddressLine2="",strCorpAddressLine2="",
		strPartnershipDetails="", strPartnershipDeed="", strPartnershipRegNo="",strIncomeYearEndPreviousYear="", strItrFillDatePreviousYear="",
		stritrSalaryPreviousYear="",strudyamRegistrationNumber="",strsalesTurnOverApplicant="",strsalesTurnOverDate="",strcriteriaforSalesTurnover="",
		strudyamRegistrationClassification="",strudyamDate="",strcibilDate="";
		
		String strcrifScore="",strcrifDetails="",crifReportedDate="";
		try
		{
			
			JSONObject jsonCIFReqObj= new JSONObject(msmeCustomerCreation);
 
			///demographics
			
			if (!jsonCIFReqObj.isNull("crifScore"))
				strcrifScore    = jsonCIFReqObj.getString("crifScore");
			
			if (!jsonCIFReqObj.isNull("crifDetails"))
				strcrifDetails    = jsonCIFReqObj.getString("crifDetails");
			
			if (!jsonCIFReqObj.isNull("crifReportedDate"))
				crifReportedDate    = jsonCIFReqObj.getString("crifReportedDate");
			
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
			if (!jsonCIFReqObj.isNull("crifReferred"))
				strWhrRefCRIF    = jsonCIFReqObj.getString("crifReferred");
			
			
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
			
			if(!jsonCIFReqObj.isNull("networthBorrower"))
				strnetworthBorrower= jsonCIFReqObj.getString("networthBorrower");
			if(!jsonCIFReqObj.isNull("shareholdingByWomen"))
				strshareholdingByWomen= jsonCIFReqObj.getString("shareholdingByWomen");
			if(!jsonCIFReqObj.isNull("idenificationNo"))
				stridenificationNo= jsonCIFReqObj.getString("idenificationNo");
			if(!jsonCIFReqObj.isNull("leiExpiryDate"))
				strleiExpiryDate= jsonCIFReqObj.getString("leiExpiryDate");
			if(!jsonCIFReqObj.isNull("introducerType"))
				strintroducerType= jsonCIFReqObj.getString("introducerType");
			if(!jsonCIFReqObj.isNull("introducerName"))
				strintroducerName= jsonCIFReqObj.getString("introducerName");
			if(!jsonCIFReqObj.isNull("bankingArrangemnt"))
				strbankingArrangemnt= jsonCIFReqObj.getString("bankingArrangemnt");
			if(!jsonCIFReqObj.isNull("tradeFinance"))
				strtradeFinance= jsonCIFReqObj.getString("tradeFinance");
			if(!jsonCIFReqObj.isNull("typeOfOwnership"))
				strtypeOfOwnership= jsonCIFReqObj.getString("typeOfOwnership");
			if(!jsonCIFReqObj.isNull("rocNumber"))
				strrocNumber= jsonCIFReqObj.getString("rocNumber");
				if(!jsonCIFReqObj.isNull("industryType"))
				strindustryType= jsonCIFReqObj.getString("industryType");
			if(!jsonCIFReqObj.isNull("companyIdNo"))
				strcompanyIdNo= jsonCIFReqObj.getString("companyIdNo");
			if(!jsonCIFReqObj.isNull("tin"))
				strtin= jsonCIFReqObj.getString("tin");
			if(!jsonCIFReqObj.isNull("totalEmployees"))
				strtotalEmployees= jsonCIFReqObj.getString("totalEmployees");
			if(!jsonCIFReqObj.isNull("groupName"))
				strgroupName= jsonCIFReqObj.getString("groupName");
			if(!jsonCIFReqObj.isNull("whetherFirmMif"))
				strwhetherFirmMif= jsonCIFReqObj.getString("whetherFirmMif");
			if(!jsonCIFReqObj.isNull("whetherBelongsScSt"))
				strwhetherBelongsScSt= jsonCIFReqObj.getString("whetherBelongsScSt");
			if(!jsonCIFReqObj.isNull("whetherBelongsMinorityComm"))
				strwhetherBelongsMinorityComm= jsonCIFReqObj.getString("whetherBelongsMinorityComm");
			if(!jsonCIFReqObj.isNull("adminAddress"))
				stradminAddress= jsonCIFReqObj.getString("adminAddress");
			if(!jsonCIFReqObj.isNull("adminvillage"))
				stradminvillage= jsonCIFReqObj.getString("adminvillage");
			if(!jsonCIFReqObj.isNull("admincity"))
				stradmincity= jsonCIFReqObj.getString("admincity");
			if(!jsonCIFReqObj.isNull("adminDistric"))
				stradminDistric= jsonCIFReqObj.getString("adminDistric");
			if(!jsonCIFReqObj.isNull("adminState"))
				stradminState= jsonCIFReqObj.getString("adminState");
			if(!jsonCIFReqObj.isNull("adminPinCode"))
				stradminPinCode= jsonCIFReqObj.getString("adminPinCode");
			
			
			
			if(!jsonCIFReqObj.isNull("adminCountry"))
				stradminCountry= jsonCIFReqObj.getString("adminCountry");
			if(!jsonCIFReqObj.isNull("adminPhoneNo"))
				stradminPhoneNo= jsonCIFReqObj.getString("adminPhoneNo");
			
			if(!jsonCIFReqObj.isNull("adminFaxNo"))
				stradminFaxNo= jsonCIFReqObj.getString("adminFaxNo");
			if(!jsonCIFReqObj.isNull("adminwebsite"))
				stradminwebsite= jsonCIFReqObj.getString("adminwebsite");
			if(!jsonCIFReqObj.isNull("corpAddress"))
				strcorpAddress= jsonCIFReqObj.getString("corpAddress");
			if(!jsonCIFReqObj.isNull("corpVillage"))
				strcorpVillage= jsonCIFReqObj.getString("corpVillage");
			if(!jsonCIFReqObj.isNull("corpCity"))
				strcorpCity= jsonCIFReqObj.getString("corpCity");
			if(!jsonCIFReqObj.isNull("corpDistrict"))
				strcorpDistrict= jsonCIFReqObj.getString("corpDistrict");
			if(!jsonCIFReqObj.isNull("corpState"))
				strcorpState= jsonCIFReqObj.getString("corpState");
			if(!jsonCIFReqObj.isNull("corpPinCode"))
				strcorpPinCode= jsonCIFReqObj.getString("corpPinCode");
			if(!jsonCIFReqObj.isNull("corpCountry"))
				strcorpCountry= jsonCIFReqObj.getString("corpCountry");
			if(!jsonCIFReqObj.isNull("corpPhoneNo"))
				strcorpPhoneNo= jsonCIFReqObj.getString("corpPhoneNo");
			if(!jsonCIFReqObj.isNull("corpFaxNo"))
				strcorpFaxNo= jsonCIFReqObj.getString("corpFaxNo");
			if(!jsonCIFReqObj.isNull("corpwebsite"))
				strcorpwebsite= jsonCIFReqObj.getString("corpwebsite");
			if(!jsonCIFReqObj.isNull("corpEMail"))
				strcorpEMail= jsonCIFReqObj.getString("corpEMail");
			
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
			
			if (!jsonCIFReqObj.isNull("adminAddressLine2"))
				strAdminAddressLine2    = jsonCIFReqObj.getString("adminAddressLine2");
			
			if (!jsonCIFReqObj.isNull("corpAddressLine2"))
				strCorpAddressLine2    = jsonCIFReqObj.getString("corpAddressLine2");
			
			if (!jsonCIFReqObj.isNull("partnershipDetails"))
				strPartnershipDetails    = jsonCIFReqObj.getString("partnershipDetails");
			
			if (!jsonCIFReqObj.isNull("partnershipDeed"))
				strPartnershipDeed    = jsonCIFReqObj.getString("partnershipDeed");
			
			if (!jsonCIFReqObj.isNull("partnershipRegNo"))
				strPartnershipRegNo    = jsonCIFReqObj.getString("partnershipRegNo");
			
			
				if (!jsonCIFReqObj.isNull("incomeYearEndPreviousYear"))
					strIncomeYearEndPreviousYear    = jsonCIFReqObj.getString("incomeYearEndPreviousYear");
				
				if (!jsonCIFReqObj.isNull("itrFillDatePreviousYear"))
					strItrFillDatePreviousYear    = jsonCIFReqObj.getString("itrFillDatePreviousYear");
				
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
				
			JSONArray jsonManagement= new JSONArray();
			 
			if (!jsonCIFReqObj.isNull("managementPeople"))
				jsonManagement=jsonCIFReqObj.getJSONArray("managementPeople");
			
			
			JSONObject jsonMngmnt= new JSONObject();
			
			int managementSize=jsonManagement.length();
			ArrayList arrMngmnt=new ArrayList();
			ArrayList arrMngmntvalues=new ArrayList();
			if(managementSize>0)
			{
				for(int i=0;i<managementSize;i++)
				{
					jsonMngmnt=(JSONObject) jsonManagement.get(i);
					
					String strconcernType=jsonMngmnt.getString("concernType");
					String strconcernSubType=jsonMngmnt.getString("concernSubType");
					String straccOperatedBy=jsonMngmnt.getString("accOperatedBy");
					String strcutomerID=jsonMngmnt.getString("cutomerID");
					String strcbsCustomerId=jsonMngmnt.getString("cbsCustomerId");
					String strconcernName=jsonMngmnt.getString("concernName");
					String straddress=jsonMngmnt.getString("address");
					String strcity=jsonMngmnt.getString("city");
					String strstate=jsonMngmnt.getString("state");
					String strphoneNo=jsonMngmnt.getString("phoneNo");
					String strdistrict=jsonMngmnt.getString("district");
					String strpinCode=jsonMngmnt.getString("pinCode");
					String strfaxNo=jsonMngmnt.getString("faxNo");
					String strchiefPromoter=jsonMngmnt.getString("chiefPromoter");
					String strdocumentExecutant=jsonMngmnt.getString("documentExecutant");
					String strrelationAmongThem=jsonMngmnt.getString("relationAmongThem");
					String strnpaCategory="";
					String strpersonalGuarantee="";
					
					arrMngmntvalues=new ArrayList();
					arrMngmntvalues.add(strconcernType);
					arrMngmntvalues.add(strconcernSubType);
					arrMngmntvalues.add(straccOperatedBy);
					arrMngmntvalues.add(strcutomerID);
					arrMngmntvalues.add(strcbsCustomerId);
					arrMngmntvalues.add(strconcernName);
					arrMngmntvalues.add(straddress);
					arrMngmntvalues.add(strcity);
					arrMngmntvalues.add(strstate);
					arrMngmntvalues.add(strphoneNo);
					arrMngmntvalues.add(strdistrict);
					arrMngmntvalues.add(strpinCode);
					arrMngmntvalues.add(strfaxNo);
					arrMngmntvalues.add(strchiefPromoter);
					arrMngmntvalues.add(strdocumentExecutant);
					arrMngmntvalues.add(strrelationAmongThem);
					arrMngmntvalues.add(strnpaCategory);//
					arrMngmntvalues.add(strpersonalGuarantee);
     				arrMngmnt.add(arrMngmntvalues);
     				
				}
			}
			
			
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
			
			
			//Mandatory Check
			if(strFullName.equals("") || strConstitution.equals("") || strBorrStatus.equals("") || strBanking.equals("") 
				|| strBranchCode.equals("") || strComAddress1.equals("")
				|| strComAddress2.equals("") || strComCity.equals("") || strComDistrict.equals("") || strComState.equals("") || strComCountry.equals("")
				|| strComPincode.equals("")  || strCustomerOccupation.equals("") 
				|| strincomeITR.equals("") || strWhrRefCIBIL.equals("") || strshareholdingByWomen.equals("") || strintroducerType.equals(""))
			
			{
				return Constants.ERROR_RESPONSE_MANDATORY;
			}
			
			if(strWhrRefCIBIL.equals("Y"))
			{
				if(strCIBILscore.equals("") || strCIBILdetails.equals(""))
				{
					return Constants.ERROR_RESPONSE_MANDATORY;
				}
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
			strIDref=strPANNo;
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
			
			/*//strretirementDate="01/01/1900";
			Calendar cal2 = Calendar.getInstance();
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
			hshJsonValues.put("strWhrRefCRIF",strWhrRefCRIF);
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
			
			
			
			hshJsonValues.put("strnetworthBorrower",strnetworthBorrower);
			hshJsonValues.put("strshareholdingByWomen",strshareholdingByWomen);
			hshJsonValues.put("stridenificationNo",stridenificationNo);
			hshJsonValues.put("strleiExpiryDate",strleiExpiryDate);
			hshJsonValues.put("strintroducerType",strintroducerType);
			hshJsonValues.put("strintroducerName",strintroducerName);
			hshJsonValues.put("strbankingArrangemnt",strbankingArrangemnt);
			//hshJsonValues.put("strtradeFinance",strtradeFinance);
			hshJsonValues.put("strtypeOfOwnership",strtypeOfOwnership);
			hshJsonValues.put("strrocNumber",strrocNumber);
			hshJsonValues.put("strindustryType",strindustryType);
			hshJsonValues.put("strcompanyIdNo",strcompanyIdNo);
			hshJsonValues.put("strtin",strtin);
			hshJsonValues.put("strtotalEmployees",strtotalEmployees);
			hshJsonValues.put("strgroupName",strgroupName);
			hshJsonValues.put("strwhetherFirmMif",strwhetherFirmMif);
			hshJsonValues.put("strwhetherBelongsMinorityComm",strwhetherBelongsMinorityComm);
			hshJsonValues.put("strwhetherBelongsScSt",strwhetherBelongsScSt);
			hshJsonValues.put("stradminAddress",stradminAddress);
			hshJsonValues.put("stradminvillage",stradminvillage);
			hshJsonValues.put("stradmincity",stradmincity);
			hshJsonValues.put("stradminDistric",stradminDistric);
			hshJsonValues.put("stradminState",stradminState);
			hshJsonValues.put("stradminPinCode",stradminPinCode);
			hshJsonValues.put("stradminCountry",stradminCountry);
			hshJsonValues.put("stradminPhoneNo",stradminPhoneNo);
			hshJsonValues.put("stradminFaxNo",stradminFaxNo);
			hshJsonValues.put("stradminwebsite",stradminwebsite);
			hshJsonValues.put("strcorpAddress",strcorpAddress);
			hshJsonValues.put("strcorpVillage",strcorpVillage);
			hshJsonValues.put("strcorpCity",strcorpCity);
			hshJsonValues.put("strcorpDistrict",strcorpDistrict);
			hshJsonValues.put("strcorpState",strcorpState);
			hshJsonValues.put("strcorpPinCode",strcorpPinCode);
			hshJsonValues.put("strcorpCountry",strcorpCountry);
			hshJsonValues.put("strcorpPhoneNo",strcorpPhoneNo);
			hshJsonValues.put("strcorpFaxNo",strcorpFaxNo);
			hshJsonValues.put("strcorpwebsite",strcorpwebsite);
			hshJsonValues.put("strcorpEMail",strcorpEMail);
			hshJsonValues.put("arrMngmnt",arrMngmnt);
			hshJsonValues.put("existingFacility",arrExistFaclty);

			hshJsonValues.put("strincomeYearEnded",strincomeYearEnded);
			hshJsonValues.put("stritrFillingDate",stritrFillingDate);
			hshJsonValues.put("strudyogAadharNumber",strudyogAadharNumber);
			hshJsonValues.put("strgstin",strgstin);
			hshJsonValues.put("strmseRegNumber",strmseRegNumber);
			
			hshJsonValues.put("strcrifScore",strcrifScore);
			hshJsonValues.put("strcrifDetails",strcrifDetails);
			hshJsonValues.put("crifReportedDate",crifReportedDate);
			
			hshJsonValues.put("strAdminAddressLine2",strAdminAddressLine2);
			hshJsonValues.put("strCorpAddressLine2",strCorpAddressLine2);
			hshJsonValues.put("strPartnershipDetails",strPartnershipDetails);
			hshJsonValues.put("strPartnershipDeed",strPartnershipDeed);
			hshJsonValues.put("strPartnershipRegNo",strPartnershipRegNo);
			hshJsonValues.put("strIncomeYearEndPreviousYear",strIncomeYearEndPreviousYear);
			hshJsonValues.put("strItrFillDatePreviousYear",strItrFillDatePreviousYear);
			hshJsonValues.put("stritrSalaryPreviousYear",stritrSalaryPreviousYear);
			hshJsonValues.put("strudyamRegistrationNumber",strudyamRegistrationNumber);
			hshJsonValues.put("strsalesTurnOverApplicant",strsalesTurnOverApplicant);
			hshJsonValues.put("strsalesTurnOverDate",strsalesTurnOverDate);
			hshJsonValues.put("strcriteriaforSalesTurnover",strcriteriaforSalesTurnover);
			hshJsonValues.put("strudyamRegistrationClassification",strudyamRegistrationClassification);
			hshJsonValues.put("strudyamDate",strudyamDate);
			hshJsonValues.put("strcibilDate",strcibilDate);

			
			 
			
		/*	stridenificationNo,
			strnetworthBorrower, strshareholdingByWomen,stridenificationNo,strleiExpiryDate,strleiExpiryDate,strintroducerType,strintroducerType,strintroducerName
			strbankingArrangemnt,strtradeFinance,strtypeOfOwnership,strtypeOfOwnership,strrocNumber,strrocNumber,strindustryType,strcompanyIdNo,strtin
			strtotalEmployees,strgroupName,strwhetherFirmMif,strwhetherBelongsMinorityComm,strwhetherBelongsScSt,stradminAddress,stradminvillage,stradmincity
			stradminDistric,stradminState,stradminPinCode,stradminCountry,stradminPhoneNo,stradminFaxNo,stradminwebsite,strcorpAddress,strcorpVillage
			strcorpCity,strcorpDistrict,strcorpState,strcorpPinCode,strcorpPinCode,strcorpCountry,strcorpPhoneNo
			strcorpFaxNo,strcorpwebsite,strcorpEMail
			
			*/
			
			hshValues =(HashMap) EJBInvoker.executeStateLess("MsmeDigitalAppInterface",hshJsonValues,"msmeCustomerCreation");
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
			throw new EJBException("Error in msmeServiceImpl msmecustomerCreation..."+e.toString());
		}
		return jsonAsString;	
	}

public String msmeDedupeCheckService(MsmeDedupeCheck msmeDedupeCheck) throws JsonProcessingException {

Map<String,Object> responseData = new HashMap<String,Object>();
Response response = new Response();
String jsonAsString = "";
JSONObject objOuter        = new JSONObject();
JSONObject PrintObject     = new JSONObject();
HashMap hshValues 		   = new HashMap();
String strApplExists="",strStatus="";
Map<String,Object> responseDataMap = null;
ArrayList arrValues = new ArrayList();
HashMap hshValues1  = new HashMap();
String strResponseMsg="",strResponseCode="",strPANno="", strCBSid="";

try
{
	
	JSONObject jsonCIFReqObj		= new JSONObject(msmeDedupeCheck);
	//JSONObject getCIFReqObj  	    = jsonCIFReqObj.getJSONObject("SysarcLARReq");
	//JSONObject JsonHeader		    = getCIFReqObj.getJSONObject("Header");
	//JSONObject JsonBody		        = jsonCIFReqObj.getJSONObject("Body");
	//JSONObject jsonObject = new JSONObject(strServerResponse);

	if (!jsonCIFReqObj.isNull("panno"))
		strPANno    = jsonCIFReqObj.getString("panno");
	if (!jsonCIFReqObj.isNull("cbsid"))
		strCBSid    = jsonCIFReqObj.getString("cbsid");
	
			
	
	//Mandatory Check
	if(strPANno.equals("")&& strCBSid.equals(""))
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
	
	
	hshValues1 = (HashMap) EJBInvoker.executeStateLess("MsmeDigitalAppInterface",hshJsonValues,"msmeDedupeCheckService");
	//strApplExists  = Helper.correctNull((String)hshValues.get("strApplExist"));
	
	
	ArrayList arrayList1 = (ArrayList)hshValues1.get("strProposals");
	if(arrayList1.size()>0 && arrayList1!=null)
	{
		for(int i=0; i<arrayList1.size(); i++){
			hshValues = (HashMap) arrayList1.get(i);
		
			responseDataMap = new HashMap<String,Object>();
			//if(strApplExists.equals("Y"))
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
				responseDataMap.put("sublimit",((ArrayList)hshValues.get("sublimit")));
				responseDataMap.put("facilityStatus", Helper.correctNull((String)hshValues.get("applicationStatus")));
				responseDataMap.put("facilityDesc", Helper.correctNull((String)hshValues.get("facilityDesc")));
				arrValues.add(responseDataMap);
			
			}}}
	
	 
	strResponseCode="LAPS-3007";
	strResponseMsg="Dedupe Check Completed Successfully";
	responseData.put("dataExist", Helper.correctNull((String)hshValues1.get("dataExist")));
	responseData.put("Proposals", arrValues);
	
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
	throw new EJBException("Error in msmeServiceServiceImpl dedupeCheck..."+e.toString());
}
return jsonAsString;	
}


public String collateralService(BasicInformationCust basicInformationCust) throws JsonProcessingException {
	
	Map<String,Object> responseData = new HashMap<String,Object>();
	Response response = new Response();
	String jsonAsString = "";
	JSONObject objOuter        = new JSONObject();
	JSONObject PrintObject     = new JSONObject();
	HashMap hshValues 		   = new HashMap();
	String strApplExists="",strStatus="",strCbsId="",strResponseCode="",strResponseMsg="";
	Map<String,Object> responseDataMap = null;
	ArrayList arrValues = new ArrayList();
	HashMap hshValues1  = new HashMap();
	
	try
	{
		JSONObject jsonCIFReqObj= new JSONObject(basicInformationCust);

		if (!jsonCIFReqObj.isNull("customerID"))
			strCbsId    = jsonCIFReqObj.getString("customerID");		
		
		//Mandatory Check
		if(strCbsId.equals(""))
		{
			return Constants.ERROR_RESPONSE_MANDATORY;
		}
		HashMap hshJsonValues = new HashMap();
		hshJsonValues.put("strCbsId",strCbsId);
		hshValues1 = (HashMap) EJBInvoker.executeStateLess("MsmeDigitalAppInterface",hshJsonValues,"msmecollateralsecurity");
		
		ArrayList arrayList1 = (ArrayList)hshValues1.get("proposalDetails");
		if(arrayList1.size()>0 && arrayList1!=null)
		{
			for(int i=0; i<arrayList1.size(); i++){
				hshValues = (HashMap) arrayList1.get(i);
			
				responseDataMap = new HashMap<String,Object>();
				//if(strApplExists.equals("Y"))
				
					responseDataMap.put("ProposalNo", Helper.correctNull((String)hshValues.get("proposalNo")));
					responseDataMap.put("facilityDescription", Helper.correctNull((String)hshValues.get("facilityDescription")));
					responseDataMap.put("SerialNo", Helper.correctNull((String)hshValues.get("SerialNo")));
					responseDataMap.put("facilitySanctionLimit", Helper.correctNull((String)hshValues.get("facilitySanctionLimit")));
					responseDataMap.put("liability", Helper.correctNull((String)hshValues.get("liability")));
					responseDataMap.put("cbs_limit", Helper.correctNull((String)hshValues.get("cbs_limit")));
					responseDataMap.put("disbursement", Helper.correctNull((String)hshValues.get("disbursement")));
					responseDataMap.put("FacilityHeadCategory", Helper.correctNull((String)hshValues.get("FacilityHeadCategory")));
					responseDataMap.put("FacilityType", Helper.correctNull((String)hshValues.get("FacilityType")));
					responseDataMap.put("security",((ArrayList)hshValues.get("security")));
					arrValues.add(responseDataMap);
				}}
		
		strResponseCode="LAPS-3010";
		strResponseMsg="ColllateralSecurity Service is Completed Successfully";
		//responseData.put("dataExist", Helper.correctNull((String)hshValues1.get("dataExist")));
		responseData.put("Proposals Details", arrValues);
		
		response.setData(responseData);
		response.setResp_code(strResponseCode);
		response.setResp_msg(strResponseMsg);
		jsonAsString = objectMapper.writeValueAsString(response);	
	}
	catch(Exception e){
		response.setData(responseData);
		response.setResp_code("LAPS-2003");
		response.setResp_msg("Invalid request parameters");
		jsonAsString = objectMapper.writeValueAsString(response);
		e.printStackTrace();
		throw new EJBException("Error in CollateralSecurity...."+e.toString());	
	}
	return jsonAsString;
}



public String msmeRenewalDedupeService(BasicInformationCust BasicInformationCust) throws JsonProcessingException
{
	Map<String,Object> responseData = new HashMap<String,Object>();
	Response response = new Response();
	String jsonAsString = "";
	JSONObject objOuter        = new JSONObject();
	JSONObject PrintObject     = new JSONObject();
	HashMap hshValues 		   = new HashMap();
	Map<String,Object> responseDataMap = null;
	ArrayList arrValues = new ArrayList();
	String strResponseMsg="",strResponseCode="",strProposalID="", strFacilityID="";
	HashMap hshValues1=new HashMap();
	
	try
	{
		JSONObject jsonCIFReqObj		= new JSONObject(BasicInformationCust);

		if (!jsonCIFReqObj.isNull("proposalID"))
			strProposalID    = jsonCIFReqObj.getString("proposalID");
		if (!jsonCIFReqObj.isNull("facilityID"))
			strFacilityID    = jsonCIFReqObj.getString("facilityID");
		
				
		//Mandatory Check
		if(strProposalID.equals("") && strFacilityID.equals(""))
		{
			return Constants.ERROR_RESPONSE_MANDATORY;
		}
		
		HashMap hshJsonValues = new HashMap();
		hshJsonValues.put("strProposalID",strProposalID);
		hshJsonValues.put("strFacilityID",strFacilityID);
		
		hshValues1 = (HashMap) EJBInvoker.executeStateLess("MsmeDigitalAppInterface",hshJsonValues,"msmeRenewalDedupeCheckService");


		ArrayList arrayList1 = (ArrayList)hshValues1.get("strProposals");
		if(arrayList1.size()>0 && arrayList1!=null)
		{
			for(int i=0; i<arrayList1.size(); i++){
				hshValues = (HashMap) arrayList1.get(i);
			
				responseDataMap = new HashMap<String,Object>();
				{
					
					responseDataMap.put("ProposalNumber", Helper.correctNull((String)hshValues.get("ProposalNumber")));
					responseDataMap.put("FacilitySerialNumber", Helper.correctNull((String)hshValues.get("FacilitySerialNumber")));
					responseDataMap.put("FacilityDate", Helper.correctNull((String)hshValues.get("FacilityDate")));
					responseDataMap.put("OldProposalNumber", Helper.correctNull((String)hshValues.get("OldProposalNumber")));
					responseDataMap.put("OldFacilitySerialNumber", Helper.correctNull((String)hshValues.get("OldFacilitySerialNumber")));
					responseDataMap.put("FacilityStatus", Helper.correctNull((String)hshValues.get("FacilityStatus")));
					
					arrValues.add(responseDataMap);
				
				}}}
		
		 
		strResponseCode="LAPS-3008";
		strResponseMsg="Dedupe Check Completed Successfully";
		responseData.put("dataExist", Helper.correctNull((String)hshValues1.get("dataExist")));
		responseData.put("Proposals", arrValues);
		responseData.put("ReferenceProposals", hshValues1.get("strRefProposals"));
		
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
		throw new EJBException("Error in msmeServiceServiceImpl dedupeCheck..."+e.toString());
	}
	return jsonAsString;	
}

public String msmeFinancialCMAService(BasicInformationCust basicInformationCust) throws JsonProcessingException
{
	Map<String,Object> responseData = new HashMap<String,Object>();
	Response response = new Response();
	String jsonAsString = "";
	JSONObject objOuter        = new JSONObject();
	JSONObject PrintObject     = new JSONObject();
	HashMap hshValues 		   = new HashMap();
	Map<String,Object> responseDataMap = null;
	ArrayList arrValues = new ArrayList();
	String strResponseMsg="",strResponseCode="",strProposalID="", strFacilityID="",strCustomerID="",strfinYears="";
	HashMap hshValues1=new HashMap();
	
	try
	{
		JSONObject jsonCIFReqObj		= new JSONObject(basicInformationCust);

		if (!jsonCIFReqObj.isNull("proposalID"))
			strProposalID    = jsonCIFReqObj.getString("proposalID");
		if (!jsonCIFReqObj.isNull("facilityID"))
			strFacilityID    = jsonCIFReqObj.getString("facilityID");
		if (!jsonCIFReqObj.isNull("customerID"))
			strCustomerID    = jsonCIFReqObj.getString("customerID");
		if(!jsonCIFReqObj.isNull("finYears"))
			strfinYears      = jsonCIFReqObj.getString("finYears");
				
		//Mandatory Check
		if(strProposalID.equals("") && strFacilityID.equals("") && strCustomerID.equals(""))
		{
			return Constants.ERROR_RESPONSE_MANDATORY;
		}
		
		HashMap hshJsonValues = new HashMap();
		hshJsonValues.put("strProposalID",strProposalID);
		hshJsonValues.put("strFacilityID",strFacilityID);
		hshJsonValues.put("strCustomerID",strCustomerID);
		hshJsonValues.put("strfinYears", strfinYears);
		
		hshValues1 = (HashMap) EJBInvoker.executeStateLess("MsmeDigitalAppInterface",hshJsonValues,"msmeFinancialCMAService");
	
		//responseData.put("FinancialModel", hshValues1.get("FinancialModel"));
		//responseData.put("Unit", hshValues1.get("Unit"));
		responseData.put("FinancialCMA", hshValues1.get("FinancialCMA"));
		//responseData.put("Values", hshValues1.get("arrval8"));
		strResponseCode="LAPS-3009";
		strResponseMsg="FinancialCMA service Completed Successfully";
		
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
		throw new EJBException("Error in msmeServiceServiceImpl financialCMAService..."+e.toString());
	}
	return jsonAsString;	
}

public String msmeFacilityProposal(FacilityProposal facilityProposal) throws JsonProcessingException
{
	Map<String,Object> responseData = new HashMap<String,Object>();
	Response response = new Response();
	String jsonAsString = "";
	JSONObject objOuter        = new JSONObject();
	JSONObject PrintObject     = new JSONObject();
	HashMap hshValues 		   = new HashMap();
	Map<String,Object> responseDataMap = null;
	ArrayList arrValues = new ArrayList();
	String strResponseMsg="",strResponseCode="",strProposalID="", strFacilityID="",strCustomerID="",
	strlarNo="",strtype="",stradhocType="",strfacilityOfAdhoc="",strinterestType="",strtenor="",strproposedBankArrngmnt="",strpaymentMode="",strperiodInstallment="",
	strmargin="",strdueDate="",strirregularities="",strgovtSponserScheme="",strproopsedLimit="",strsinglePremium="",strinterestSubType="",strinitialHoliday="",strFacilityDescription="",
	strrepaymentType="",strinterestRate="",strpuropse="",strborrowerFreshLimit="",strprocessNoteDesc="",strdetailsAsOn="",strcbsId="",strlapsCustomerId="",strapplicationBranch="",
	stroperativeAccNumber="",managementInfo="", strBirRequired="", strSubmissionDate="", strReceiptDate="", strBirCharges="",  strBirReportDate="";
	String proposalFormat="",processingCharges="",cfrVerified="",cersaiChecked="",prioritysector="",briefHistoryProcesnote="",briefHistoryAnnexure="",briefHistorySourcing="",
	strInsuranceAmntFundedBy="", strInsuranceAmount="", strPremiumTenor="",strLoanAmountCovered="",strCreditRiskPremium="", strFixedSpread="",strReferenceType="",strverification="",
	strfinId="",strAssessComment="",stramberExits="",strotherAssessmentforWCDPNWCTL="",strecsBankName="",strecsAccountType="",strecsOperAccountType="",
	strecsAuthunenticateMode="",strecsIFSCCODE="",strscheme="";
	ResultSet rs=null,rs1=null;
	String strQuery="";
	HashMap hshValues1=new HashMap();
	
	try
	{
		JSONObject jsonCIFReqObj		= new JSONObject(facilityProposal);

	
		if (!jsonCIFReqObj.isNull("larNo"))
			strlarNo    = jsonCIFReqObj.getString("larNo");
		/*if (!jsonCIFReqObj.isNull("type"))
			strtype    = jsonCIFReqObj.getString("type");
		if (!jsonCIFReqObj.isNull("adhocType"))
			stradhocType    = jsonCIFReqObj.getString("adhocType");
		
		if (!jsonCIFReqObj.isNull("facilityOfAdhoc"))
			strfacilityOfAdhoc    = jsonCIFReqObj.getString("facilityOfAdhoc");
		if (!jsonCIFReqObj.isNull("interestType"))
			strinterestType    = jsonCIFReqObj.getString("interestType");
		
		
		if (!jsonCIFReqObj.isNull("tenor"))
			strtenor    = jsonCIFReqObj.getString("tenor");
		if (!jsonCIFReqObj.isNull("proposedBankArrngmnt"))
			strproposedBankArrngmnt    = jsonCIFReqObj.getString("proposedBankArrngmnt");
		if (!jsonCIFReqObj.isNull("paymentMode"))
			strpaymentMode    = jsonCIFReqObj.getString("paymentMode");
		if (!jsonCIFReqObj.isNull("periodInstallment"))
			strperiodInstallment    = jsonCIFReqObj.getString("periodInstallment");
		if (!jsonCIFReqObj.isNull("margin"))
			strmargin    = jsonCIFReqObj.getString("margin");
		if (!jsonCIFReqObj.isNull("dueDate"))
			strdueDate    = jsonCIFReqObj.getString("dueDate");
		if (!jsonCIFReqObj.isNull("irregularities"))
			strirregularities    = jsonCIFReqObj.getString("irregularities");
		if (!jsonCIFReqObj.isNull("govtSponserScheme"))
			strgovtSponserScheme    = jsonCIFReqObj.getString("govtSponserScheme");
		if (!jsonCIFReqObj.isNull("proopsedLimit"))
			strproopsedLimit    = jsonCIFReqObj.getString("proopsedLimit");
		if (!jsonCIFReqObj.isNull("singlePremium"))
			strsinglePremium    = jsonCIFReqObj.getString("singlePremium");*/
		
		JSONArray jsonFacilityDetails = new JSONArray();
		if (!jsonCIFReqObj.isNull("facilityDetails"))
			jsonFacilityDetails=jsonCIFReqObj.getJSONArray("facilityDetails");
		
		JSONObject jsonFacilityDetailsval= new JSONObject();
		int jsonFacilityDetailslength=jsonFacilityDetails.length();
		ArrayList arrayFacilityDetails=new ArrayList();
		ArrayList arrayFacilityDetailsval=new ArrayList();
		ArrayList arrSno = new ArrayList();
		if(jsonFacilityDetailslength>0)
		{
			for(int i=0;i<jsonFacilityDetailslength;i++)
			{
				jsonFacilityDetailsval=(JSONObject)jsonFacilityDetails.get(i);
				arrayFacilityDetailsval=new ArrayList();
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("type"));//2
				String type = jsonFacilityDetailsval.getString("type");
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("adhocType"));//3
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("facilityOfAdhoc"));//4
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("interestType"));//5
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("tenor"));//6
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("proposedBankArrngmnt"));//7
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("paymentMode"));//8
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("periodInstallment"));//9
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("margin"));//10
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("dueDate"));//11
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("irregularities"));//12
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("govtSponserScheme"));//13
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("proopsedLimit"));//14
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("singlePremium"));//15
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("interestSubType"));//16
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("initialHoliday"));//17
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("repaymentType"));//18
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("interestRate"));//19
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("puropse"));//20
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("borrowerFreshLimit"));//21
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("processNoteDesc"));//22
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("detailsAsOn"));//23
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("facilityDescription"));//24
				String strindFacilityDescription = jsonFacilityDetailsval.getString("facilityDescription");//24
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("operativeAccountNo"));//25
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("insuranceAmntFundedBy"));//26
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("insuranceAmount"));//27
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("premiumTenor"));//28
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("loanAmountCovered"));//29
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("facilitySno"));//30
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("facilityGroup"));//31
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("creditRiskPremium"));//32				
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("fixedSpread"));//33				
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("referenceType"));//34		-2
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("cgtmse"));//35	-2	
				
				
				JSONArray jsonRepaymentSchedule=new JSONArray();

			
					jsonRepaymentSchedule=jsonFacilityDetailsval.getJSONArray("repaymentSchedule");
				
				JSONObject jsonRepaySchedule= new JSONObject();
				int repaysize=jsonRepaymentSchedule.length();
				ArrayList arrRepayment=new ArrayList();
				ArrayList arrRepaymentValues=new ArrayList();
				if(repaysize>0)
				{
					for(int j=0;j<repaysize;j++)
					{
						jsonRepaySchedule=(JSONObject) jsonRepaymentSchedule.get(j);
						
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
				arrayFacilityDetailsval.add(arrRepayment); //36 -2
				//arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("installmentPeriodicity"));//37-2
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("interestCollected"));//37  -2
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("renewProposalNumber"));//38	-2	
				arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("renewProposalSno"));//39	-2	
				String renewProposalNumber="",renewProposalSno="";
				renewProposalNumber=jsonFacilityDetailsval.getString("renewProposalNumber");
				renewProposalSno=jsonFacilityDetailsval.getString("renewProposalSno");
				arrayFacilityDetailsval.add("");//39
				arrayFacilityDetailsval.add("");//40
				arrayFacilityDetailsval.add("");//41
				arrayFacilityDetailsval.add("");//42
				arrayFacilityDetailsval.add("");//43
				arrayFacilityDetails.add(arrayFacilityDetailsval);
				
				arrSno.add(jsonFacilityDetailsval.getString("facilitySno"));
			    
				if (rs != null) {
					rs.close();
				}
				if(!renewProposalNumber.equalsIgnoreCase("") && !renewProposalSno.equalsIgnoreCase("") && type.equalsIgnoreCase("2"))
				{
				strQuery = SQLParser.getSqlQuery("selfac_san_intrate^"+renewProposalNumber+"^"+renewProposalSno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					String strrenew  = Helper.correctNull((String)rs.getString("FACILITY_RENEW"));
					String strfacid  = Helper.correctNull((String)rs.getString("FACILITY_ID"));

					if(!strrenew.equalsIgnoreCase("")){
						return Constants.DigiRenew_proposalblock;
					}
					if(!strfacid.equalsIgnoreCase(strindFacilityDescription) && strrenew.equalsIgnoreCase("") && type.equalsIgnoreCase("2")){
						return Constants.Digifacdescmismatchforrenew;
					}

				}
				
				}
			}
		}
		
		 int length = arrSno.size(); 

		    for(int k = 0; k < arrSno.size(); k++) {  
		        for(int j = k + 1; j < arrSno.size(); j++) {  
		            if(arrSno.get(k).equals(arrSno.get(j)))  
		            	return Constants.DupFacilitySno;
		        }  
		    } 
		
		
		/*
		if (!jsonCIFReqObj.isNull("interestSubType"))
			strinterestSubType    = jsonCIFReqObj.getString("interestSubType");
		if (!jsonCIFReqObj.isNull("initialHoliday"))
			strinitialHoliday    = jsonCIFReqObj.getString("initialHoliday");
		if (!jsonCIFReqObj.isNull("repaymentType"))
			strrepaymentType    = jsonCIFReqObj.getString("repaymentType");
		if (!jsonCIFReqObj.isNull("interestRate"))
			strinterestRate    = jsonCIFReqObj.getString("interestRate");
		if (!jsonCIFReqObj.isNull("puropse"))
			strpuropse    = jsonCIFReqObj.getString("puropse");
		if (!jsonCIFReqObj.isNull("borrowerFreshLimit"))
			strborrowerFreshLimit    = jsonCIFReqObj.getString("borrowerFreshLimit");
		if (!jsonCIFReqObj.isNull("processNoteDesc"))
			strprocessNoteDesc    = jsonCIFReqObj.getString("processNoteDesc");
		if (!jsonCIFReqObj.isNull("detailsAsOn"))
			strdetailsAsOn    = jsonCIFReqObj.getString("detailsAsOn");*/
		if (!jsonCIFReqObj.isNull("cbsId"))
			strcbsId    = jsonCIFReqObj.getString("cbsId");
		if (!jsonCIFReqObj.isNull("lapsCustomerId"))
			strlapsCustomerId    = jsonCIFReqObj.getString("lapsCustomerId");
		if (!jsonCIFReqObj.isNull("applicationBranch"))
			strapplicationBranch    = jsonCIFReqObj.getString("applicationBranch");
		if (!jsonCIFReqObj.isNull("facilityDescription"))
			strFacilityDescription    = jsonCIFReqObj.getString("facilityDescription");
		/*if (!jsonCIFReqObj.isNull("operativeAccountNo"))
			stroperativeAccNumber    = jsonCIFReqObj.getString("operativeAccountNo");*/
		
		if (!jsonCIFReqObj.isNull("proposalFormat"))
			proposalFormat    = jsonCIFReqObj.getString("proposalFormat");
		if (!jsonCIFReqObj.isNull("processingCharges"))
			processingCharges    = jsonCIFReqObj.getString("processingCharges");
		if (!jsonCIFReqObj.isNull("cfrVerified"))
			cfrVerified    = jsonCIFReqObj.getString("cfrVerified");
		if (!jsonCIFReqObj.isNull("cersaiChecked"))
			cersaiChecked    = jsonCIFReqObj.getString("cersaiChecked");
		if (!jsonCIFReqObj.isNull("prioritysector"))
			prioritysector    = jsonCIFReqObj.getString("prioritysector");
		if (!jsonCIFReqObj.isNull("briefHistoryProcesnote"))
			briefHistoryProcesnote    = jsonCIFReqObj.getString("briefHistoryProcesnote");
		if (!jsonCIFReqObj.isNull("briefHistoryAnnexure"))
			briefHistoryAnnexure    = jsonCIFReqObj.getString("briefHistoryAnnexure");
		if (!jsonCIFReqObj.isNull("briefHistorySourcing"))
			briefHistorySourcing    = jsonCIFReqObj.getString("briefHistorySourcing");
		
		//tring birRequired,String submissionDate,String receiptDate,String birCharges, String birReportDate
		if (!jsonCIFReqObj.isNull("birRequired"))
			strBirRequired    = jsonCIFReqObj.getString("birRequired");
		
		if (!jsonCIFReqObj.isNull("submissionDate"))
			strSubmissionDate    = jsonCIFReqObj.getString("submissionDate");
		if (!jsonCIFReqObj.isNull("receiptDate"))
			strReceiptDate    = jsonCIFReqObj.getString("receiptDate");
		if (!jsonCIFReqObj.isNull("birCharges"))
			strBirCharges    = jsonCIFReqObj.getString("birCharges");
		if (!jsonCIFReqObj.isNull("birReportDate"))
			strBirReportDate    = jsonCIFReqObj.getString("birReportDate");
		
		if (!jsonCIFReqObj.isNull("loanAmountCovered"))
			strLoanAmountCovered    = jsonCIFReqObj.getString("loanAmountCovered");
		if (!jsonCIFReqObj.isNull("creditRiskPremium"))
			strCreditRiskPremium    = jsonCIFReqObj.getString("creditRiskPremium");
		if (!jsonCIFReqObj.isNull("fixedSpread"))
			strFixedSpread    = jsonCIFReqObj.getString("fixedSpread");
		if (!jsonCIFReqObj.isNull("referenceType"))
			strReferenceType    = jsonCIFReqObj.getString("referenceType");
		
		if (!jsonCIFReqObj.isNull("financialId"))
			strfinId    = jsonCIFReqObj.getString("financialId");
		
		
		if (!jsonCIFReqObj.isNull("assessmentComment"))
			strAssessComment    = jsonCIFReqObj.getString("assessmentComment");
		
		if (!jsonCIFReqObj.isNull("amberExits"))
			stramberExits    = jsonCIFReqObj.getString("amberExits");
		
		if (!jsonCIFReqObj.isNull("otherAssessmentforWCDPNWCTL"))
			strotherAssessmentforWCDPNWCTL    = jsonCIFReqObj.getString("otherAssessmentforWCDPNWCTL");
		
		if (!jsonCIFReqObj.isNull("scheme"))
			strscheme    = jsonCIFReqObj.getString("scheme");
		
		JSONArray jsonCoAppplicant		= new JSONArray();
		if (!jsonCIFReqObj.isNull("coApplicant"))
			jsonCoAppplicant=jsonCIFReqObj.getJSONArray("coApplicant");
		
	
		
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
				String coapplicantCBStype=jsonCoapp.getString("coapplicantCBStype");
				String coapplicantFacsno=jsonCoapp.getString("coapplicantFacsno");
				
				arrcoappvalues=new ArrayList();
				arrcoappvalues.add(coappName);//0
				arrcoappvalues.add(coappType);//1
				arrcoappvalues.add(coappLAPSID);//2
				arrcoappvalues.add(coappCBSID); //3
				arrcoappvalues.add(coappRelation);//4
				arrcoappvalues.add("");//5
				arrcoappvalues.add(coapplicantCBStype);//6
				arrcoappvalues.add(coapplicantFacsno);//7
				arrcoapp.add(arrcoappvalues);
			}
		}
		
		
		JSONArray jsonmanagementInfo = new JSONArray();
		if (!jsonCIFReqObj.isNull("managementInfo"))
			jsonmanagementInfo=jsonCIFReqObj.getJSONArray("managementInfo");
		
		JSONObject jsonmanginfo= new JSONObject();
		int manginfosize=jsonmanagementInfo.length();
		ArrayList arrmanginfo=new ArrayList();
		ArrayList arrmanginfovalues=new ArrayList();
		if(manginfosize>0)
		{
			for(int i=0;i<manginfosize;i++)
			{
				jsonmanginfo=(JSONObject) jsonmanagementInfo.get(i);

				arrmanginfovalues=new ArrayList();
				arrmanginfovalues.add(jsonmanginfo.getString("commentsOn"));
				arrmanginfovalues.add(jsonmanginfo.getString("comments"));
				arrmanginfo.add(arrmanginfovalues);
			}
		}
		
		JSONArray jsonturnovermethod = new JSONArray();
		if (!jsonCIFReqObj.isNull("turnOverMethod"))
			jsonturnovermethod=jsonCIFReqObj.getJSONArray("turnOverMethod");
		
		JSONObject jasonturnover= new JSONObject();
		int turnoverlength=jsonturnovermethod.length();
		ArrayList arrayturnover=new ArrayList();
		ArrayList arrayturnovervalues=new ArrayList();
		if(turnoverlength>0)
		{
			for(int i=0;i<turnoverlength;i++)
			{
				
				jasonturnover=(JSONObject) jsonturnovermethod.get(i);
				arrayturnovervalues=new ArrayList();
				arrayturnovervalues.add(jasonturnover.getString("year"));
				arrayturnovervalues.add(jasonturnover.getString("type"));
				arrayturnovervalues.add(jasonturnover.getString("projectSales"));
				arrayturnovervalues.add(jasonturnover.getString("acceptProjectSale"));
				arrayturnovervalues.add(jasonturnover.getString("acceptSalesPercent25"));
				arrayturnovervalues.add(jasonturnover.getString("minMarginReq"));
				arrayturnovervalues.add(jasonturnover.getString("eligibleFinance"));
				arrayturnovervalues.add(jasonturnover.getString("actualMarginAvailable"));
				arrayturnovervalues.add(jasonturnover.getString("eligibleBankFinance"));
				arrayturnovervalues.add(jasonturnover.getString("permissibleBankFinance"));
				arrayturnovervalues.add(jasonturnover.getString("limitsSoughts"));
				arrayturnovervalues.add(jasonturnover.getString("limitsproposed"));
				arrayturnovervalues.add(jasonturnover.getString("requiredMargin"));
				arrayturnovervalues.add(jasonturnover.getString("surplusRequiredMargin"));
				arrayturnover.add(arrayturnovervalues);
				
				
			}
		}
		
		
		JSONArray jsonexpenditure = new JSONArray();
		if (!jsonCIFReqObj.isNull("expenditureMethod"))
			jsonexpenditure=jsonCIFReqObj.getJSONArray("expenditureMethod");
		
		JSONObject jasonexpenditure= new JSONObject();
		int ependiturelength=jsonexpenditure.length();
		ArrayList arrayexpenditure=new ArrayList();
		ArrayList arrayexpenvalue=new ArrayList();
		if(ependiturelength>0)
		{
			for(int i=0;i<ependiturelength;i++)
			{
				jasonexpenditure=(JSONObject)jsonexpenditure.get(i);
				arrayexpenvalue=new ArrayList();
				arrayexpenvalue.add(jasonexpenditure.getString("year"));
				arrayexpenvalue.add(jasonexpenditure.getString("type"));
				arrayexpenvalue.add(jasonexpenditure.getString("projectExpenditure"));
				arrayexpenvalue.add(jasonexpenditure.getString("acceptprojectExpenditure"));
				arrayexpenvalue.add(jasonexpenditure.getString("operationalCycle"));
				arrayexpenvalue.add(jasonexpenditure.getString("eligibleCycle"));
				arrayexpenvalue.add(jasonexpenditure.getString("permissibleFinance"));
				arrayexpenvalue.add(jasonexpenditure.getString("limitSought"));
				arrayexpenvalue.add(jasonexpenditure.getString("limitProposed"));
				arrayexpenditure.add(arrayexpenvalue);
				
			}
		}
		
		JSONArray jsonapplicant = new JSONArray();
		if (!jsonCIFReqObj.isNull("verificationFlag"))
			jsonapplicant=jsonCIFReqObj.getJSONArray("verificationFlag");
		
		JSONObject objapplicant= new JSONObject();
		int applicantlength=jsonapplicant.length();
		
		ArrayList arrApplicant=new ArrayList();
		ArrayList arrApplicantvalue=new ArrayList();
		
		if(applicantlength>0)
		{
			for(int i=0;i<applicantlength;i++)
			{
				arrApplicantvalue=new ArrayList();
				objapplicant=(JSONObject)jsonapplicant.get(i);
				arrApplicantvalue.add(objapplicant.getString("lapsId"));
				arrApplicantvalue.add(objapplicant.getString("panFlag"));
				arrApplicantvalue.add(objapplicant.getString("residenceVisitFlag"));
				arrApplicantvalue.add(objapplicant.getString("businessVisitFlag"));
				arrApplicantvalue.add(objapplicant.getString("collateralFlag"));
				arrApplicantvalue.add(objapplicant.getString("gstinFlag"));
				arrApplicantvalue.add(objapplicant.getString("uanFlag"));
				arrApplicantvalue.add(objapplicant.getString("itrFlag"));
				arrApplicantvalue.add(objapplicant.getString("bankstatmntFlag"));
				arrApplicantvalue.add(objapplicant.getString("balanceSheetFlag"));
				arrApplicantvalue.add(objapplicant.getString("tradingFlag"));
				arrApplicantvalue.add(objapplicant.getString("financialstmntFlag"));
				arrApplicantvalue.add(objapplicant.getString("litigationCorpFlag"));
				arrApplicantvalue.add(objapplicant.getString("litigationIndFlag"));
				arrApplicantvalue.add(objapplicant.getString("docSubmitted"));
				arrApplicantvalue.add(objapplicant.getString("udhyamCertificateFlag"));
//				arrApplicantvalue.add(objapplicant.getString("fName"));
				arrApplicant.add(arrApplicantvalue);

			}
		}
		
		
		
		JSONArray dscr = new JSONArray();
		if (!jsonCIFReqObj.isNull("dscr"))
			dscr=jsonCIFReqObj.getJSONArray("dscr");
		
		JSONObject jsondscr= new JSONObject();
		int dscrlength=dscr.length();
		ArrayList arraydscr=new ArrayList();
		ArrayList arradscrValue=new ArrayList();
		if(dscrlength>0)
		{
			for(int i=0;i<dscrlength;i++)
			{
				
		
				jsondscr=(JSONObject)dscr.get(i);
				arradscrValue=new ArrayList();
				
				arradscrValue.add(jsondscr.getString("totalSale"));
				arradscrValue.add(jsondscr.getString("increasePercent"));
				arradscrValue.add(jsondscr.getString("netProfit"));
				arradscrValue.add(jsondscr.getString("interestTlExistAdd"));
				arradscrValue.add(jsondscr.getString("interestTlProposedAdd"));
				arradscrValue.add(jsondscr.getString("depreciation"));
				arradscrValue.add(jsondscr.getString("totalAccruals"));
				arradscrValue.add(jsondscr.getString("interestTlExist"));
				arradscrValue.add(jsondscr.getString("interestTlpropose"));
				arradscrValue.add(jsondscr.getString("interestTlExistProposed"));
				arradscrValue.add(jsondscr.getString("installmentTlExist"));
				arradscrValue.add(jsondscr.getString("installmentTlProposed"));
				arradscrValue.add(jsondscr.getString("totalRepayment"));
				arradscrValue.add(jsondscr.getString("dscr"));
				
				arradscrValue.add(jsondscr.getString("year"));//14
				arradscrValue.add(jsondscr.getString("type"));//15
				
				arraydscr.add(arradscrValue);
				
			}
		}
		
		
		
		
		JSONArray dscrSens = new JSONArray();
		if (!jsonCIFReqObj.isNull("sensitivityAnalysis"))
			dscrSens=jsonCIFReqObj.getJSONArray("sensitivityAnalysis");
		
		JSONObject jsondscrSens= new JSONObject();
		int dscrSenslength=dscrSens.length();
		ArrayList arraydscrSens=new ArrayList();
		ArrayList arradscrSensValue=new ArrayList();
		if(dscrSenslength>0)
		{
			for(int i=0;i<dscrSenslength;i++)
			{
				
		
				jsondscrSens=(JSONObject)dscrSens.get(i);
				arradscrSensValue=new ArrayList();
				
				arradscrSensValue.add(jsondscrSens.getString("totalSale"));
				arradscrSensValue.add(jsondscrSens.getString("increasePercent"));
				arradscrSensValue.add(jsondscrSens.getString("netProfit"));
				arradscrSensValue.add(jsondscrSens.getString("interestTlExistAdd"));
				arradscrSensValue.add(jsondscrSens.getString("interestTlProposedAdd"));
				arradscrSensValue.add(jsondscrSens.getString("depreciation"));
				arradscrSensValue.add(jsondscrSens.getString("totalAccruals"));
				arradscrSensValue.add(jsondscrSens.getString("interestTlExist"));
				arradscrSensValue.add(jsondscrSens.getString("interestTlpropose"));
				arradscrSensValue.add(jsondscrSens.getString("interestTlExistProposed"));
				arradscrSensValue.add(jsondscrSens.getString("installmentTlExist"));
				arradscrSensValue.add(jsondscrSens.getString("installmentTlProposed"));
				arradscrSensValue.add(jsondscrSens.getString("totalRepayment"));
				arradscrSensValue.add(jsondscrSens.getString("dscr"));
				
				arradscrSensValue.add(jsondscrSens.getString("year"));//14
				arradscrSensValue.add(jsondscrSens.getString("type"));//15
				
				arraydscrSens.add(arradscrSensValue);
				
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
		arradigiratingValue.add(jsondigirating.getString("findigitype"));
		arradigiratingValue.add(jsondigirating.getString("findigiyear"));
		}
		
		
		JSONArray microMitraAssessment = new JSONArray();
		if (!jsonCIFReqObj.isNull("microMitraAssessment"))
			microMitraAssessment=jsonCIFReqObj.getJSONArray("microMitraAssessment");
		
		JSONObject jsonmicroMitraAssessment= new JSONObject();
		int microMitraAssessmentlength=microMitraAssessment.length();
		ArrayList arraymicroMitraAssessment=new ArrayList();
		ArrayList arraymicroMitraAssessmentValue=new ArrayList();
		
if(microMitraAssessmentlength>0){
			
	jsonmicroMitraAssessment=(JSONObject)microMitraAssessment.get(0);
	arraymicroMitraAssessmentValue.add(jsonmicroMitraAssessment.getString("asOnDate"));
	arraymicroMitraAssessmentValue.add(jsonmicroMitraAssessment.getString("stockValue"));
	arraymicroMitraAssessmentValue.add(jsonmicroMitraAssessment.getString("bookDebtValue"));
	arraymicroMitraAssessmentValue.add(jsonmicroMitraAssessment.getString("creditorsValue"));
	arraymicroMitraAssessmentValue.add(jsonmicroMitraAssessment.getString("total"));
	arraymicroMitraAssessmentValue.add(jsonmicroMitraAssessment.getString("totalOfMPBF75Percent"));
	arraymicroMitraAssessmentValue.add(jsonmicroMitraAssessment.getString("loanAmountApplied"));
	arraymicroMitraAssessmentValue.add(jsonmicroMitraAssessment.getString("leastOfLoanAmountOrMPBF"));
		
	}	
	/*	JSONArray jsonRepaymentSchedule=new JSONArray();

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
		*/
		
		
		
		
		
		
		//Mandatory Check
	
	/*	if( strlarNo.equals("") || strtype.equals("") || strtenor.equals("") || strproposedBankArrngmnt.equals("") ||
				strpaymentMode.equals("") || strperiodInstallment.equals("") || strgovtSponserScheme.equals("") || strproopsedLimit.equals("") || strsinglePremium.equals("") || strinterestSubType.equals("")
				|| strrepaymentType.equals("") || strinterestRate.equals("") || strprocessNoteDesc.equals("") || strlapsCustomerId.equals("") || strinterestType.equals("")) 
		{
			return Constants.ERROR_RESPONSE_MANDATORY;
		}
		
		*/
		
		if( strlarNo.equals("") || strlapsCustomerId.equals(""))
		{
			return Constants.ERROR_RESPONSE_MANDATORY;
		}
		
		
		//BussinessOperation
		JSONArray bussinessOperation = new JSONArray();
		if (!jsonCIFReqObj.isNull("bussinessOperation"))
			bussinessOperation=jsonCIFReqObj.getJSONArray("bussinessOperation");
		
		JSONObject jasonbussinessOperation= new JSONObject();
		int digibussinessOperationlength=bussinessOperation.length();
		ArrayList arraybussinessOperation=new ArrayList();
		ArrayList arraybussinessOperationvalues=new ArrayList();
		if(digibussinessOperationlength>0)
		{
			for(int i=0;i<digibussinessOperationlength;i++)
			{
				
				jasonbussinessOperation=(JSONObject) bussinessOperation.get(i);
				arraybussinessOperationvalues=new ArrayList();
				arraybussinessOperationvalues.add(jasonbussinessOperation.getString("interestEarned"));
				arraybussinessOperationvalues.add(jasonbussinessOperation.getString("otherIncome"));
				arraybussinessOperationvalues.add(jasonbussinessOperation.getString("fromDate"));
				arraybussinessOperationvalues.add(jasonbussinessOperation.getString("toDate"));
				arraybussinessOperationvalues.add(jasonbussinessOperation.getString("recoveryStatus"));
				arraybussinessOperationvalues.add(jasonbussinessOperation.getString("odInterest"));
				arraybussinessOperationvalues.add(jasonbussinessOperation.getString("forexIncome"));
				arraybussinessOperationvalues.add(jasonbussinessOperation.getString("tlInterestIncome"));
				arraybussinessOperationvalues.add(jasonbussinessOperation.getString("otherfacilitiesincome"));
				arraybussinessOperation.add(arraybussinessOperationvalues);
				
				
			}
		}
		
		//OdccLimits
		
		JSONArray OdccLimits = new JSONArray();
		
		if (!jsonCIFReqObj.isNull("odccLimits"))
			OdccLimits=jsonCIFReqObj.getJSONArray("odccLimits");
		
		int digiOdccLimitslength=OdccLimits.length();
		JSONObject jsonOdccLimits= new JSONObject();
		ArrayList arrayOdccLimits=new ArrayList();
		ArrayList arrayOdccLimitsvalues=new ArrayList();
		if(digiOdccLimitslength>0)
		{
			for(int i=0;i<digiOdccLimitslength;i++)
			{
				
				jsonOdccLimits=(JSONObject) OdccLimits.get(i);
				arrayOdccLimitsvalues=new ArrayList();
				arrayOdccLimitsvalues.add(jsonOdccLimits.getString("sanctionedLimit"));//COM_SANCLIMIT
				arrayOdccLimitsvalues.add(jsonOdccLimits.getString("remarks"));
				//arrayOdccLimitsvalues.add(jsonOdccLimits.getString(""));
				arrayOdccLimitsvalues.add(jsonOdccLimits.getString("maxDrBalance"));
				arrayOdccLimitsvalues.add(jsonOdccLimits.getString("minDrBalance"));
				arrayOdccLimitsvalues.add(jsonOdccLimits.getString("maxCrBalance"));
				arrayOdccLimitsvalues.add(jsonOdccLimits.getString("minCrBalance"));
				arrayOdccLimitsvalues.add(jsonOdccLimits.getString("excessPermitted"));
				arrayOdccLimitsvalues.add(jsonOdccLimits.getString("chequeReturn"));
				arrayOdccLimitsvalues.add(jsonOdccLimits.getString("chequeReturnAmount"));
				arrayOdccLimitsvalues.add(jsonOdccLimits.getString("crSummation"));
				arrayOdccLimitsvalues.add(jsonOdccLimits.getString("drSummation"));
				arrayOdccLimitsvalues.add(jsonOdccLimits.getString("comments"));
				arrayOdccLimitsvalues.add(jsonOdccLimits.getString("salesTurnover"));
				arrayOdccLimits.add(arrayOdccLimitsvalues);
				
			}
		}
		
		HashMap hshJsonValues = new HashMap();
		hshJsonValues.put("strlarNo",strlarNo);
		/*hshJsonValues.put("strtype",strtype);
		hshJsonValues.put("stradhocType",stradhocType);
		hshJsonValues.put("strfacilityOfAdhoc",strfacilityOfAdhoc);
		hshJsonValues.put("strinterestType",strinterestType);
		hshJsonValues.put("strtenor",strtenor);
		hshJsonValues.put("strproposedBankArrngmnt",strproposedBankArrngmnt);
		hshJsonValues.put("strpaymentMode",strpaymentMode);
		hshJsonValues.put("strperiodInstallment",strperiodInstallment);
		hshJsonValues.put("strmargin",strmargin);
		hshJsonValues.put("strdueDate",strdueDate);
		hshJsonValues.put("strirregularities",strirregularities);
		hshJsonValues.put("strgovtSponserScheme",strgovtSponserScheme);
		hshJsonValues.put("strproopsedLimit",strproopsedLimit);
		hshJsonValues.put("strsinglePremium",strsinglePremium);
		hshJsonValues.put("strinterestSubType",strinterestSubType);
		hshJsonValues.put("strinitialHoliday",strinitialHoliday);
		hshJsonValues.put("strrepaymentType",strrepaymentType);
		hshJsonValues.put("strinterestRate",strinterestRate);
		hshJsonValues.put("strpuropse",strpuropse);
		hshJsonValues.put("strborrowerFreshLimit",strborrowerFreshLimit);
		hshJsonValues.put("strprocessNoteDesc",strprocessNoteDesc);
		hshJsonValues.put("strdetailsAsOn",strdetailsAsOn);*/
		hshJsonValues.put("strcbsId",strcbsId);
		hshJsonValues.put("strlapsCustomerId",strlapsCustomerId);
		hshJsonValues.put("strapplicationBranch",strapplicationBranch);
		hshJsonValues.put("FacilityDescription",strFacilityDescription);
		//hshJsonValues.put("stroperativeAccNumber",stroperativeAccNumber);
		
		hshJsonValues.put("proposalFormat",proposalFormat);
		hshJsonValues.put("processingCharges",processingCharges);
		hshJsonValues.put("cfrVerified",cfrVerified);
		hshJsonValues.put("cersaiChecked",cersaiChecked);
		hshJsonValues.put("prioritysector",prioritysector);
		hshJsonValues.put("arrcoapp",arrcoapp);
		hshJsonValues.put("briefHistoryProcesnote",briefHistoryProcesnote);
		hshJsonValues.put("briefHistoryAnnexure",briefHistoryAnnexure);
		hshJsonValues.put("briefHistorySourcing",briefHistorySourcing);
		hshJsonValues.put("arrmanginfo",arrmanginfo);
		//strBirRequired="", strSubmissionDate="", strReceiptDate="", strBirCharges="",  strBirReportDate="";
		hshJsonValues.put("strBirRequired",strBirRequired);
		hshJsonValues.put("strSubmissionDate",strSubmissionDate);
		hshJsonValues.put("strReceiptDate",strReceiptDate);
		hshJsonValues.put("strBirCharges",strBirCharges);
		hshJsonValues.put("strBirReportDate",strBirReportDate);
/*		hshJsonValues.put("strInsuranceAmntFundedBy",strInsuranceAmntFundedBy);
		hshJsonValues.put("strInsuranceAmount",strInsuranceAmount);
		hshJsonValues.put("strPremiumTenor",strPremiumTenor);*/
		hshJsonValues.put("strLoanAmountCovered",strLoanAmountCovered);
		hshJsonValues.put("strCreditRiskPremium",strCreditRiskPremium);
		hshJsonValues.put("strFixedSpread",strFixedSpread);
		hshJsonValues.put("strReferenceType",strReferenceType); 
		hshJsonValues.put("arrayturnover",arrayturnover);
		hshJsonValues.put("arrayexpenditure",arrayexpenditure); 
		hshJsonValues.put("arrApplicant",arrApplicant); 
		hshJsonValues.put("strfinId",strfinId); 
		hshJsonValues.put("arrayFacilityDetails",arrayFacilityDetails); 
		hshJsonValues.put("arraydscr",arraydscr); 
		hshJsonValues.put("arraydscrSens",arraydscrSens);  
		hshJsonValues.put("strAssessComment",strAssessComment);
		hshJsonValues.put("arradigiratingValue",arradigiratingValue);
		hshJsonValues.put("arraymicroMitraAssessmentValue",arraymicroMitraAssessmentValue);
		hshJsonValues.put("stramberExits",stramberExits);
		hshJsonValues.put("strotherAssessmentforWCDPNWCTL",strotherAssessmentforWCDPNWCTL);
		hshJsonValues.put("arraybussinessOperation",arraybussinessOperation);
		hshJsonValues.put("arrayOdccLimits",arrayOdccLimits);
		hshJsonValues.put("strscheme",strscheme);
		
		
		boolean proposalcheck=true,proposallimitcheck=true;;
		
		String appno="",STRPERAPPOLDID="";
		strQuery=SQLParser.getSqlQuery("selappnoinwardnowise^"+strlarNo);
		rs=DBUtils.executeQuery(strQuery);	
		if(rs.next())
		{
			appno=Helper.correctNull((String)rs.getString("app_no"));
			proposalcheck=false;
		}
		if(jsonFacilityDetailslength>0)
			{
				for(int i=0;i<jsonFacilityDetailslength;i++)
					{
						jsonFacilityDetailsval=(JSONObject)jsonFacilityDetails.get(i);
						arrayFacilityDetailsval=new ArrayList();
						strtype = jsonFacilityDetailsval.getString("type");
						strFacilityDescription = jsonFacilityDetailsval.getString("facilityDescription");
						
					if(!strcbsId.equals("") && strtype.equals("1")){
					if(rs1!=null)
					{	  rs1.close(); 	}
					strQuery=SQLParser.getSqlQuery("sel_appid_perappoldid^"+strcbsId);
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						STRPERAPPOLDID=Helper.correctNull((String)rs1.getString("PERAPP_OLDID"));
					}
				
					strQuery = SQLParser.getSqlQuery("sel_regularlimitchk_digimsme^"+STRPERAPPOLDID+"^"+strFacilityDescription);
					if (rs != null) {
						rs.close();
					}
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						if(!(appno.equalsIgnoreCase(Helper.correctNull(rs.getString("facility_appno")))))
						{
							strQuery = SQLParser.getSqlQuery("selfacilitysno^"+appno+"^"+Helper.correctNull(rs.getString("facility_appno"))+"^"+Helper.correctInt(rs.getString("facility_sno")));
							if (rs1 != null) {rs1.close();}
							rs1=DBUtils.executeQuery(strQuery);
							if(!rs1.next())
								proposallimitcheck=false;
						}
					}
					if(proposalcheck==false)
					{
						responseData.put("lapsProposalNumber", appno);
						strResponseCode="LAPS-2011";
						strResponseMsg="Proposal is already created for the given LAR";
						
						jsonFacilityDetailslength = 0;
						
					}else if(proposallimitcheck==false)
					{
						responseData.put("lapsProposalNumber", appno);
						strResponseCode="LAPS-2022";
						strResponseMsg="Facility already having regular limit";
						
						jsonFacilityDetailslength = 0;
					}
				}
			}
		}
		if(proposalcheck==true && proposallimitcheck==true)
		{

		hshValues1 = (HashMap) EJBInvoker.executeStateLess("MsmeDigitalAppInterface",hshJsonValues,"CorpProposalCreation");	
		responseData.put("lapsProposalNumber", Helper.correctNull((String)hshValues1.get("appno")));
		strResponseCode="LAPS-3011";
		strResponseMsg="LAPS Application Created Successfully";
		
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
		throw new EJBException("Error in msmeServiceServiceImpl msmeFacilityProposal..."+e.toString());
	}
	return jsonAsString;	



}






		public String msmeFinacialCreation(FacilityProposal facilityProposal) throws JsonProcessingException 
		{
			Map<String,Object> responseData = new HashMap<String,Object>();
			Response response = new Response();
			String jsonAsString = "";
			JSONObject objOuter        = new JSONObject();
			JSONObject PrintObject     = new JSONObject();
			HashMap hshValues 		   = new HashMap();
			Map<String,Object> responseDataMap = null;
			ArrayList arrValues = new ArrayList();
			int jsonPLValueLen=0,jsonLValueLen=0,jsonAValueLen=0;
		
			String 	 strfinancialFormat="",strvaluesAreIn="",strfacilities="",strcbsId="",strResponseCode="",strResponseMsg="";
			try
			{
				JSONObject jsonCIFReqObj= new JSONObject(facilityProposal);
		
				if (!jsonCIFReqObj.isNull("cbsId"))
					strcbsId    = jsonCIFReqObj.getString("cbsId");
				if (!jsonCIFReqObj.isNull("financialFormat"))
					strfinancialFormat    = jsonCIFReqObj.getString("financialFormat");
				if (!jsonCIFReqObj.isNull("valuesAreIn"))
					strvaluesAreIn    = jsonCIFReqObj.getString("valuesAreIn");
				if (!jsonCIFReqObj.isNull("facilities"))
					strfacilities    = jsonCIFReqObj.getString("facilities");
				
				
				if(strcbsId.equals("")&& strfinancialFormat.equals(""))
				{
					return Constants.ERROR_RESPONSE_MANDATORY;
				}
				
				
				
				JSONArray liabilities= new JSONArray();
				
				if (!jsonCIFReqObj.isNull("liabilities"))
					liabilities=jsonCIFReqObj.getJSONArray("liabilities");
				
				JSONObject jsonliabilities= new JSONObject();
				int liabilityLength=liabilities.length();
				ArrayList arrliabilities=new ArrayList();
				ArrayList arrliabilitiesValues= new ArrayList();
				JSONArray jsonliableValue= new JSONArray();
				JSONObject jsonvalues= new JSONObject();
				ArrayList arrliablValues=new ArrayList();
				HashMap liablehshJsonValues = new HashMap();
				HashMap assteshshJsonValues = new HashMap();
				HashMap pandlhshJsonValues = new HashMap();
				if(liabilityLength>0)
				{
				for(int i=0;i<liabilityLength;i++)
				{	
					liablehshJsonValues = new HashMap();
					arrliabilitiesValues= new ArrayList();
					jsonliableValue= new JSONArray();
					jsonliabilities=(JSONObject)liabilities.get(i);
					String strstartingPeriod=jsonliabilities.getString("startingPeriod");
					String strendperiod=jsonliabilities.getString("endingPeriod");
					String strtype=jsonliabilities.getString("type");
					String strtab=jsonliabilities.getString("tab");
					jsonliableValue=jsonliabilities.getJSONArray("values");
					JSONObject jsonValues= new JSONObject();
					jsonLValueLen=jsonliableValue.length();
					ArrayList arrayValues=new ArrayList();
					ArrayList arrayValuesvalue= new ArrayList();
					//String strvalue="",strdesc="";
					if(jsonLValueLen>0)
					{
					for(int j=0;j<jsonLValueLen;j++)
					{
						
						 arrayValuesvalue= new ArrayList();
						jsonValues=	(JSONObject)jsonliableValue.get(j);
						String values=jsonValues.getString("value");
						String mapcode=jsonValues.getString("mappingCode");
						arrayValuesvalue.add(values);
						arrayValuesvalue.add(mapcode);
						arrayValues.add(arrayValuesvalue);
						
					}
					}
					
					liablehshJsonValues.put("startingPeriod",strstartingPeriod);
					liablehshJsonValues.put("endperiod",strendperiod);
					liablehshJsonValues.put("type",strtype);
					liablehshJsonValues.put("tab",strtab);
				/*	arrliabilitiesValues.add(strstartingPeriod);
					arrliabilitiesValues.add(strendperiod);*/
					arrliabilitiesValues.add(liablehshJsonValues);
					arrliabilitiesValues.add(arrayValues);
					arrliabilities.add(arrliabilitiesValues);
					
					}
				
				
					}
				
				
				
				
				JSONArray assets= new JSONArray();
				if (!jsonCIFReqObj.isNull("assets"))
					assets=jsonCIFReqObj.getJSONArray("assets");	
				
				JSONObject jsonassets= new JSONObject();
				int assetslength=assets.length();
				ArrayList arrAssets=new ArrayList();
				ArrayList arrAssetsValues= new ArrayList();
				JSONArray jsonassetsValues= new JSONArray();
				JSONObject jsonAssetsvalue= new JSONObject();
				ArrayList arrmapcodevalues=new ArrayList();
				
				
				if(assetslength>0)
				{
					for(int i=0;i<assetslength;i++)
					{	assteshshJsonValues = new HashMap();
					arrAssetsValues= new ArrayList();
						jsonassetsValues= new JSONArray();
						jsonassets=(JSONObject)assets.get(i);
						String strstartingPeriod=jsonassets.getString("startingPeriod");
						String strendperiod=jsonassets.getString("endingPeriod");
						String strtype=jsonassets.getString("type");
						String strtab=jsonassets.getString("tab");
						jsonassetsValues=jsonassets.getJSONArray("values");
						JSONObject jsonValues= new JSONObject();
						jsonAValueLen=jsonassetsValues.length();
						ArrayList arrayValues=new ArrayList();
						ArrayList arrayValuesvalue= new ArrayList();
						//String strvalue="",strmapcode="";	
						
						if(jsonAValueLen>0)
						{
						for(int j=0;j<jsonAValueLen;j++)
						{	
							arrayValuesvalue= new ArrayList();
							jsonValues=	(JSONObject)jsonassetsValues.get(j);
							String values=jsonValues.getString("value");
							String mapcode=jsonValues.getString("mappingCode");
							arrayValuesvalue.add(values);
							arrayValuesvalue.add(mapcode);
							arrayValues.add(arrayValuesvalue);
						
					}	
				}
					
						assteshshJsonValues.put("startingPeriod",strstartingPeriod);
						assteshshJsonValues.put("endperiod",strendperiod);
						assteshshJsonValues.put("type",strtype);
						assteshshJsonValues.put("tab",strtab);		
						arrAssetsValues.add(assteshshJsonValues);
						arrAssetsValues.add(arrayValues);
						arrAssets.add(arrAssetsValues);		
						
					}
					}	
				
				
				JSONArray profitLossAcc= new JSONArray();
				if (!jsonCIFReqObj.isNull("profitLossAcc"))
					profitLossAcc=jsonCIFReqObj.getJSONArray("profitLossAcc");
				JSONObject jsonprofitLossAcc= new JSONObject();
				int profitLossAccLength=liabilities.length();
				ArrayList arrprofitLossAcc=new ArrayList();
				ArrayList arrprofitLossAccVal=new ArrayList();
				JSONArray jsonPLValues= new JSONArray();
				if(profitLossAccLength>0)
				{
				for(int i=0;i<profitLossAccLength;i++)
				{	jsonPLValues= new JSONArray();
				//arrprofitLossAcc= new ArrayList();
				arrprofitLossAccVal=new ArrayList();
					pandlhshJsonValues = new HashMap();
					jsonprofitLossAcc=(JSONObject)profitLossAcc.get(i);
					String strstartingPeriod=jsonprofitLossAcc.getString("startingPeriod");
					String strendperiod=jsonprofitLossAcc.getString("endingPeriod");
					String strtype=jsonprofitLossAcc.getString("type");
					String strtab=jsonprofitLossAcc.getString("tab");
					jsonPLValues=jsonprofitLossAcc.getJSONArray("values");
					JSONObject jsonValues= new JSONObject();
					jsonPLValueLen=jsonPLValues.length();
					ArrayList arrayValues=new ArrayList();
					ArrayList arrayValuesvalue= new ArrayList();
					if(jsonPLValueLen>0)
					{
					for(int j=0;j<jsonPLValueLen;j++)
					{	arrayValuesvalue= new ArrayList();
						jsonValues=	(JSONObject)jsonPLValues.get(j);
						String values=jsonValues.getString("value");
						String mapcode=jsonValues.getString("mappingCode");
						arrayValuesvalue.add(values);
						arrayValuesvalue.add(mapcode);
						arrayValues.add(arrayValuesvalue);		
					}
					}
					pandlhshJsonValues.put("startingPeriod",strstartingPeriod);
					pandlhshJsonValues.put("endperiod",strendperiod);
					pandlhshJsonValues.put("type",strtype);
					pandlhshJsonValues.put("tab",strtab);		
					arrprofitLossAccVal.add(pandlhshJsonValues);
					arrprofitLossAccVal.add(arrayValues);
					arrprofitLossAcc.add(arrprofitLossAccVal);
				
				}
				}
				
				HashMap hshJsonValues = new HashMap();
				
				hshJsonValues.put("strcbsId",strcbsId);
				hshJsonValues.put("strfinancialFormat",strfinancialFormat );
				hshJsonValues.put("strvaluesAreIn",strvaluesAreIn);
				hshJsonValues.put("strfacilities",strfacilities);
				hshJsonValues.put("arrliabilities",arrliabilities );
				hshJsonValues.put("arrassets",arrAssets );
				hshJsonValues.put("arrprofitLossAcc",arrprofitLossAcc );
				hshJsonValues.put("jsonPLValueLen",Integer.toString(jsonPLValueLen));
				hshJsonValues.put("jsonAValueLen",Integer.toString(jsonAValueLen ));
				hshJsonValues.put("jsonLValueLen",Integer.toString(jsonLValueLen));
				hshValues = (HashMap) EJBInvoker.executeStateLess("MsmeDigitalAppInterface",hshJsonValues,"financialCreation");
				
				
				responseData.put("financeId", Helper.correctNull((String)hshValues.get("financeId")));
				strResponseCode="LAPS-3013";
				strResponseMsg="Financial is Created Successfully";
				
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
				throw new EJBException("Error in msmeServiceServiceImpl facilityCreation... "+e.toString());
			}
			return jsonAsString;	
		}
		
		
		public String msmeRenewalFacilityProposal(FacilityProposal facilityProposal) throws JsonProcessingException
		{
			Map<String,Object> responseData = new HashMap<String,Object>();
			Response response = new Response();
			String jsonAsString = "";
			JSONObject objOuter        = new JSONObject();
			JSONObject PrintObject     = new JSONObject();
			HashMap hshValues 		   = new HashMap();
			Map<String,Object> responseDataMap = null;
			ArrayList arrValues = new ArrayList();
			String strResponseMsg="",strResponseCode="",strProposalID="", strFacilityID="",strCustomerID="",
			strlarNo="",strtype="",stradhocType="",strfacilityOfAdhoc="",strinterestType="",strtenor="",strproposedBankArrngmnt="",strpaymentMode="",strperiodInstallment="",
			strmargin="",strdueDate="",strirregularities="",strgovtSponserScheme="",strproopsedLimit="",strsinglePremium="",strinterestSubType="",strinitialHoliday="",strFacilityDescription="",
			strrepaymentType="",strinterestRate="",strpuropse="",strborrowerFreshLimit="",strprocessNoteDesc="",strdetailsAsOn="",strcbsId="",strlapsCustomerId="",strapplicationBranch="",
			stroperativeAccNumber="",managementInfo="", strBirRequired="", strSubmissionDate="", strReceiptDate="", strBirCharges="",  strBirReportDate="";
			String proposalFormat="",processingCharges="",cfrVerified="",cersaiChecked="",prioritysector="",briefHistoryProcesnote="",briefHistoryAnnexure="",briefHistorySourcing="",
			strInsuranceAmntFundedBy="", strInsuranceAmount="", strPremiumTenor="",strLoanAmountCovered="",strCreditRiskPremium="", strFixedSpread="",strReferenceType="";
			
			
		
			 HashMap hshValues1=new HashMap();
			String strRenewProposalNumber="",strRenewProposalSno="",strfinId="",strQuery="";
			ResultSet rs=null;
			 
			try
			{
				JSONObject jsonCIFReqObj		= new JSONObject(facilityProposal);
			
				if (!jsonCIFReqObj.isNull("larNo"))
					strlarNo    = jsonCIFReqObj.getString("larNo");
				if (!jsonCIFReqObj.isNull("type"))
					strtype    = jsonCIFReqObj.getString("type");
				if (!jsonCIFReqObj.isNull("adhocType"))
					stradhocType    = jsonCIFReqObj.getString("adhocType");
				
				if (!jsonCIFReqObj.isNull("facilityOfAdhoc"))
					strfacilityOfAdhoc    = jsonCIFReqObj.getString("facilityOfAdhoc");
				if (!jsonCIFReqObj.isNull("interestType"))
					strinterestType    = jsonCIFReqObj.getString("interestType");
				
				
				if (!jsonCIFReqObj.isNull("tenor"))
					strtenor    = jsonCIFReqObj.getString("tenor");
				if (!jsonCIFReqObj.isNull("proposedBankArrngmnt"))
					strproposedBankArrngmnt    = jsonCIFReqObj.getString("proposedBankArrngmnt");
				if (!jsonCIFReqObj.isNull("paymentMode"))
					strpaymentMode    = jsonCIFReqObj.getString("paymentMode");
				if (!jsonCIFReqObj.isNull("periodInstallment"))
					strperiodInstallment    = jsonCIFReqObj.getString("periodInstallment");
				if (!jsonCIFReqObj.isNull("margin"))
					strmargin    = jsonCIFReqObj.getString("margin");
				if (!jsonCIFReqObj.isNull("dueDate"))
					strdueDate    = jsonCIFReqObj.getString("dueDate");
				if (!jsonCIFReqObj.isNull("irregularities"))
					strirregularities    = jsonCIFReqObj.getString("irregularities");
				if (!jsonCIFReqObj.isNull("govtSponserScheme"))
					strgovtSponserScheme    = jsonCIFReqObj.getString("govtSponserScheme");
				if (!jsonCIFReqObj.isNull("proopsedLimit"))
					strproopsedLimit    = jsonCIFReqObj.getString("proopsedLimit");
				if (!jsonCIFReqObj.isNull("singlePremium"))
					strsinglePremium    = jsonCIFReqObj.getString("singlePremium");
				
				
				if (!jsonCIFReqObj.isNull("interestSubType"))
					strinterestSubType    = jsonCIFReqObj.getString("interestSubType");
				if (!jsonCIFReqObj.isNull("initialHoliday"))
					strinitialHoliday    = jsonCIFReqObj.getString("initialHoliday");
				if (!jsonCIFReqObj.isNull("repaymentType"))
					strrepaymentType    = jsonCIFReqObj.getString("repaymentType");
				if (!jsonCIFReqObj.isNull("interestRate"))
					strinterestRate    = jsonCIFReqObj.getString("interestRate");
				if (!jsonCIFReqObj.isNull("puropse"))
					strpuropse    = jsonCIFReqObj.getString("puropse");
				if (!jsonCIFReqObj.isNull("borrowerFreshLimit"))
					strborrowerFreshLimit    = jsonCIFReqObj.getString("borrowerFreshLimit");
				if (!jsonCIFReqObj.isNull("processNoteDesc"))
					strprocessNoteDesc    = jsonCIFReqObj.getString("processNoteDesc");
				if (!jsonCIFReqObj.isNull("detailsAsOn"))
					strdetailsAsOn    = jsonCIFReqObj.getString("detailsAsOn");
				if (!jsonCIFReqObj.isNull("cbsId"))
					strcbsId   = jsonCIFReqObj.getString("cbsId");
				if (!jsonCIFReqObj.isNull("lapsCustomerId"))
					strlapsCustomerId    = jsonCIFReqObj.getString("lapsCustomerId");
				if (!jsonCIFReqObj.isNull("applicationBranch"))
					strapplicationBranch    = jsonCIFReqObj.getString("applicationBranch");
				if (!jsonCIFReqObj.isNull("facilityDescription"))
					strFacilityDescription    = jsonCIFReqObj.getString("facilityDescription");
				if (!jsonCIFReqObj.isNull("operativeAccountNo"))
					stroperativeAccNumber    = jsonCIFReqObj.getString("operativeAccountNo");
				
				if (!jsonCIFReqObj.isNull("proposalFormat"))
					proposalFormat    = jsonCIFReqObj.getString("proposalFormat");
				if (!jsonCIFReqObj.isNull("processingCharges"))
					processingCharges    = jsonCIFReqObj.getString("processingCharges");
				if (!jsonCIFReqObj.isNull("cfrVerified"))
					cfrVerified    = jsonCIFReqObj.getString("cfrVerified");
				if (!jsonCIFReqObj.isNull("cersaiChecked"))
					cersaiChecked    = jsonCIFReqObj.getString("cersaiChecked");
				if (!jsonCIFReqObj.isNull("prioritysector"))
					prioritysector    = jsonCIFReqObj.getString("prioritysector");
				if (!jsonCIFReqObj.isNull("briefHistoryProcesnote"))
					briefHistoryProcesnote    = jsonCIFReqObj.getString("briefHistoryProcesnote");
				if (!jsonCIFReqObj.isNull("briefHistoryAnnexure"))
					briefHistoryAnnexure    = jsonCIFReqObj.getString("briefHistoryAnnexure");
				if (!jsonCIFReqObj.isNull("briefHistorySourcing"))
					briefHistorySourcing    = jsonCIFReqObj.getString("briefHistorySourcing");
				
				//tring birRequired,String submissionDate,String receiptDate,String birCharges, String birReportDate
				if (!jsonCIFReqObj.isNull("birRequired"))
					strBirRequired    = jsonCIFReqObj.getString("birRequired");
				
				if (!jsonCIFReqObj.isNull("submissionDate"))
					strSubmissionDate    = jsonCIFReqObj.getString("submissionDate");
				if (!jsonCIFReqObj.isNull("receiptDate"))
					strReceiptDate    = jsonCIFReqObj.getString("receiptDate");
				if (!jsonCIFReqObj.isNull("birCharges"))
					strBirCharges    = jsonCIFReqObj.getString("birCharges");
				if (!jsonCIFReqObj.isNull("birReportDate"))
					strBirReportDate    = jsonCIFReqObj.getString("birReportDate");
				if (!jsonCIFReqObj.isNull("insuranceAmntFundedBy"))
					strInsuranceAmntFundedBy    = jsonCIFReqObj.getString("insuranceAmntFundedBy");
				if (!jsonCIFReqObj.isNull("insuranceAmount"))
					strInsuranceAmount    = jsonCIFReqObj.getString("insuranceAmount");
				if (!jsonCIFReqObj.isNull("premiumTenor"))
					strPremiumTenor    = jsonCIFReqObj.getString("premiumTenor");
				if (!jsonCIFReqObj.isNull("loanAmountCovered"))
					strLoanAmountCovered    = jsonCIFReqObj.getString("loanAmountCovered");
				if (!jsonCIFReqObj.isNull("creditRiskPremium"))
					strCreditRiskPremium    = jsonCIFReqObj.getString("creditRiskPremium");
				if (!jsonCIFReqObj.isNull("fixedSpread"))
					strFixedSpread    = jsonCIFReqObj.getString("fixedSpread");
				if (!jsonCIFReqObj.isNull("referenceType"))
					strReferenceType    = jsonCIFReqObj.getString("referenceType");
				
				if (!jsonCIFReqObj.isNull("RenewProposalNumber"))
					strRenewProposalNumber    = jsonCIFReqObj.getString("RenewProposalNumber");
				if (!jsonCIFReqObj.isNull("RenewProposalSno"))
					strRenewProposalSno    = jsonCIFReqObj.getString("RenewProposalSno");

				if (!jsonCIFReqObj.isNull("financialId"))
					strfinId   = jsonCIFReqObj.getString("financialId");	
				
				
				
				JSONArray jsonCoAppplicant		= new JSONArray();
				if (!jsonCIFReqObj.isNull("coApplicant"))
					jsonCoAppplicant=jsonCIFReqObj.getJSONArray("coApplicant");
				
				
				
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
						String coapplicantCBStype=jsonCoapp.getString("coapplicantCBStype");
						String coapplicantFacsno=jsonCoapp.getString("coapplicantFacsno");
						
						arrcoappvalues=new ArrayList();
						arrcoappvalues.add(coappName);//0
						arrcoappvalues.add(coappType);//1
						arrcoappvalues.add(coappLAPSID);//2
						arrcoappvalues.add(coappCBSID); //3
						arrcoappvalues.add(coappRelation);//4
						arrcoappvalues.add("");//5
						arrcoappvalues.add(coapplicantCBStype);//6
						arrcoappvalues.add(coapplicantFacsno);//7
						arrcoapp.add(arrcoappvalues);
					}
				}
				
				
				JSONArray jsonmanagementInfo		= new JSONArray();
				if (!jsonCIFReqObj.isNull("managementInfo"))
					jsonmanagementInfo=jsonCIFReqObj.getJSONArray("managementInfo");
				
				JSONObject jsonmanginfo= new JSONObject();
				int manginfosize=jsonmanagementInfo.length();
				ArrayList arrmanginfo=new ArrayList();
				ArrayList arrmanginfovalues=new ArrayList();
				if(manginfosize>0)
				{
					for(int i=0;i<manginfosize;i++)
					{
						jsonmanginfo=(JSONObject) jsonmanagementInfo.get(i);

						arrmanginfovalues=new ArrayList();
						arrmanginfovalues.add(jsonmanginfo.getString("commentsOn"));
						arrmanginfovalues.add(jsonmanginfo.getString("comments"));
						arrmanginfo.add(arrmanginfovalues);
					}
				}
				
				JSONArray jsonturnovermethod		= new JSONArray();
				if (!jsonCIFReqObj.isNull("turnOverMethod"))
					jsonturnovermethod=jsonCIFReqObj.getJSONArray("turnOverMethod");
				
				JSONObject jasonturnover= new JSONObject();
				int turnoverlength=jsonturnovermethod.length();
				ArrayList arrayturnover=new ArrayList();
				ArrayList arrayturnovervalues=new ArrayList();
				if(turnoverlength>0)
				{
					for(int i=0;i<turnoverlength;i++)
					{
						
						jasonturnover=(JSONObject) jsonturnovermethod.get(i);
						arrayturnovervalues=new ArrayList();
						arrayturnovervalues.add(jasonturnover.getString("year"));
						arrayturnovervalues.add(jasonturnover.getString("type"));
						arrayturnovervalues.add(jasonturnover.getString("projectSales"));
						arrayturnovervalues.add(jasonturnover.getString("acceptProjectSale"));
						arrayturnovervalues.add(jasonturnover.getString("acceptSalesPercent25"));
						arrayturnovervalues.add(jasonturnover.getString("minMarginReq"));
						arrayturnovervalues.add(jasonturnover.getString("eligibleFinance"));
						arrayturnovervalues.add(jasonturnover.getString("actualMarginAvailable"));
						arrayturnovervalues.add(jasonturnover.getString("eligibleBankFinance"));
						arrayturnovervalues.add(jasonturnover.getString("permissibleBankFinance"));
						arrayturnovervalues.add(jasonturnover.getString("limitsSoughts"));
						arrayturnovervalues.add(jasonturnover.getString("limitsproposed"));
						arrayturnovervalues.add(jasonturnover.getString("requiredMargin"));
						arrayturnovervalues.add(jasonturnover.getString("surplusRequiredMargin"));
						arrayturnover.add(arrayturnovervalues);
						
						
					}
				}
				
				
				JSONArray jsonexpenditure = new JSONArray();
				if (!jsonCIFReqObj.isNull("expenditureMethod"))
					jsonexpenditure=jsonCIFReqObj.getJSONArray("expenditureMethod");
				
				JSONObject jasonexpenditure= new JSONObject();
				int ependiturelength=jsonexpenditure.length();
				ArrayList arrayexpenditure=new ArrayList();
				ArrayList arrayexpenvalue=new ArrayList();
				if(ependiturelength>0)
				{
					for(int i=0;i<ependiturelength;i++)
					{
						jasonexpenditure=(JSONObject)jsonexpenditure.get(i);
						arrayexpenvalue=new ArrayList();
						arrayexpenvalue.add(jasonexpenditure.getString("year"));
						arrayexpenvalue.add(jasonexpenditure.getString("type"));
						arrayexpenvalue.add(jasonexpenditure.getString("projectExpenditure"));
						arrayexpenvalue.add(jasonexpenditure.getString("acceptprojectExpenditure"));
						arrayexpenvalue.add(jasonexpenditure.getString("operationalCycle"));
						arrayexpenvalue.add(jasonexpenditure.getString("eligibleCycle"));
						arrayexpenvalue.add(jasonexpenditure.getString("permissibleFinance"));
						arrayexpenvalue.add(jasonexpenditure.getString("limitSought"));
						arrayexpenvalue.add(jasonexpenditure.getString("limitProposed"));
						arrayexpenditure.add(arrayexpenvalue);
						
					}
				}
				
				
				//facilityDetails
				
				JSONArray jsonFacilityDetails = new JSONArray();
				if (!jsonCIFReqObj.isNull("facilityDetails"))
					jsonFacilityDetails=jsonCIFReqObj.getJSONArray("facilityDetails");
				
				JSONObject jsonFacilityDetailsval= new JSONObject();
				int jsonFacilityDetailslength=jsonFacilityDetails.length();
				ArrayList arrayFacilityDetails=new ArrayList();
				ArrayList arrayFacilityDetailsval=new ArrayList();
				if(jsonFacilityDetailslength>0)
				{
					for(int i=0;i<jsonFacilityDetailslength;i++)
					{
						jsonFacilityDetailsval=(JSONObject)jsonFacilityDetails.get(i);
						arrayFacilityDetailsval=new ArrayList();
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("renewProposalNumber"));//0
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("renewProposalSno"));//1
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("type"));//2
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("adhocType"));//3
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("facilityOfAdhoc"));//4
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("interestType"));//5
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("tenor"));//6
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("proposedBankArrngmnt"));//7
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("paymentMode"));//8
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("periodInstallment"));//9
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("margin"));//10
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("dueDate"));//11
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("irregularities"));//12
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("govtSponserScheme"));//13
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("proopsedLimit"));//14
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("singlePremium"));//15
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("interestSubType"));//16
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("initialHoliday"));//17
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("repaymentType"));//18
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("interestRate"));//19
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("puropse"));//20
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("borrowerFreshLimit"));//21
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("processNoteDesc"));//22
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("detailsAsOn"));//23
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("facilityDescription"));//24
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("operativeAccountNo"));//25
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("insuranceAmntFundedBy"));//26
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("insuranceAmount"));//27
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("premiumTenor"));//28
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("loanAmountCovered"));//29
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("creditRiskPremium"));//30				
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("fixedSpread"));//31				
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("referenceType"));//32		
						arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("cgtmse"));//33
						arrayFacilityDetails.add(arrayFacilityDetailsval);
					}
				}
				
								
				JSONArray jsonapplicant = new JSONArray();
				if (!jsonCIFReqObj.isNull("verificationFlag"))
					jsonapplicant=jsonCIFReqObj.getJSONArray("verificationFlag");
				
				JSONObject objapplicant= new JSONObject();
				int applicantlength=jsonapplicant.length();
				
				ArrayList arrApplicant=new ArrayList();
				ArrayList arrApplicantvalue=new ArrayList();
				
				if(applicantlength>0)
				{
					for(int i=0;i<applicantlength;i++)
					{
						arrApplicantvalue=new ArrayList();
						objapplicant=(JSONObject)jsonapplicant.get(i);
						arrApplicantvalue.add(objapplicant.getString("lapsId"));
						arrApplicantvalue.add(objapplicant.getString("panFlag"));
						arrApplicantvalue.add(objapplicant.getString("residenceVisitFlag"));
						arrApplicantvalue.add(objapplicant.getString("businessVisitFlag"));
						arrApplicantvalue.add(objapplicant.getString("collateralFlag"));
						arrApplicantvalue.add(objapplicant.getString("gstinFlag"));
						arrApplicantvalue.add(objapplicant.getString("uanFlag"));
						arrApplicantvalue.add(objapplicant.getString("itrFlag"));
						arrApplicantvalue.add(objapplicant.getString("bankstatmntFlag"));
						arrApplicantvalue.add(objapplicant.getString("balanceSheetFlag"));
						arrApplicantvalue.add(objapplicant.getString("tradingFlag"));
						arrApplicantvalue.add(objapplicant.getString("financialstmntFlag"));
						arrApplicantvalue.add(objapplicant.getString("litigationCorpFlag"));
						arrApplicantvalue.add(objapplicant.getString("litigationIndFlag"));
						arrApplicantvalue.add(objapplicant.getString("docSubmitted"));
						arrApplicantvalue.add(objapplicant.getString("udhyamCertificateFlag"));
						//arrApplicantvalue.add(objapplicant.getString("fName"));
						arrApplicant.add(arrApplicantvalue);					
					}
				}
				
				
			
				
				//Mandatory Check
			
				if( strlarNo.equals("") && strlapsCustomerId.equals("")) 
				{
					return Constants.ERROR_RESPONSE_MANDATORY;
				}
					
				
				HashMap hshJsonValues = new HashMap();		
				
				hshJsonValues.put("strlarNo",strlarNo);
				hshJsonValues.put("strtype",strtype);
				hshJsonValues.put("stradhocType",stradhocType);
				hshJsonValues.put("strfacilityOfAdhoc",strfacilityOfAdhoc);
				hshJsonValues.put("strinterestType",strinterestType);
				hshJsonValues.put("strtenor",strtenor);
				hshJsonValues.put("strproposedBankArrngmnt",strproposedBankArrngmnt);
				hshJsonValues.put("strpaymentMode",strpaymentMode);
				hshJsonValues.put("strperiodInstallment",strperiodInstallment);
				hshJsonValues.put("strmargin",strmargin);
				hshJsonValues.put("strdueDate",strdueDate);
				hshJsonValues.put("strirregularities",strirregularities);
				hshJsonValues.put("strgovtSponserScheme",strgovtSponserScheme);
				hshJsonValues.put("strproopsedLimit",strproopsedLimit);
				hshJsonValues.put("strsinglePremium",strsinglePremium);
				hshJsonValues.put("strinterestSubType",strinterestSubType);
				hshJsonValues.put("strinitialHoliday",strinitialHoliday);
				hshJsonValues.put("strrepaymentType",strrepaymentType);
				hshJsonValues.put("strinterestRate",strinterestRate);
				hshJsonValues.put("strpuropse",strpuropse);
				hshJsonValues.put("strborrowerFreshLimit",strborrowerFreshLimit);
				hshJsonValues.put("strprocessNoteDesc",strprocessNoteDesc);
				hshJsonValues.put("strdetailsAsOn",strdetailsAsOn);
				hshJsonValues.put("strcbsId",strcbsId);
				hshJsonValues.put("strlapsCustomerId",strlapsCustomerId);
				hshJsonValues.put("strapplicationBranch",strapplicationBranch);
				hshJsonValues.put("FacilityDescription",strFacilityDescription);
				hshJsonValues.put("stroperativeAccNumber",stroperativeAccNumber);
				
				hshJsonValues.put("proposalFormat",proposalFormat);
				hshJsonValues.put("processingCharges",processingCharges);
				hshJsonValues.put("cfrVerified",cfrVerified);
				hshJsonValues.put("cersaiChecked",cersaiChecked);
				hshJsonValues.put("prioritysector",prioritysector);
				hshJsonValues.put("arrcoapp",arrcoapp);
				hshJsonValues.put("briefHistoryProcesnote",briefHistoryProcesnote);
				hshJsonValues.put("briefHistoryAnnexure",briefHistoryAnnexure);
				hshJsonValues.put("briefHistorySourcing",briefHistorySourcing);
				hshJsonValues.put("arrmanginfo",arrmanginfo);
				//strBirRequired="", strSubmissionDate="", strReceiptDate="", strBirCharges="",  strBirReportDate="";
				hshJsonValues.put("strBirRequired",strBirRequired);
				hshJsonValues.put("strSubmissionDate",strSubmissionDate);
				hshJsonValues.put("strReceiptDate",strReceiptDate);
				hshJsonValues.put("strBirCharges",strBirCharges);
				hshJsonValues.put("strBirReportDate",strBirReportDate);
				hshJsonValues.put("strInsuranceAmntFundedBy",strInsuranceAmntFundedBy);
				hshJsonValues.put("strInsuranceAmount",strInsuranceAmount);
				hshJsonValues.put("strPremiumTenor",strPremiumTenor);
				hshJsonValues.put("strLoanAmountCovered",strLoanAmountCovered);
				hshJsonValues.put("strCreditRiskPremium",strCreditRiskPremium);
				hshJsonValues.put("strFixedSpread",strFixedSpread);
				hshJsonValues.put("strReferenceType",strReferenceType); 
				hshJsonValues.put("arrayturnover",arrayturnover);
				hshJsonValues.put("arrayexpenditure",arrayexpenditure); 
				hshJsonValues.put("strRenewProposalSno",strRenewProposalSno); 
				hshJsonValues.put("strRenewProposalNumber",strRenewProposalNumber);
				hshJsonValues.put("arrayFacilityDetails",arrayFacilityDetails);
				hshJsonValues.put("arrApplicant",arrApplicant);
				hshJsonValues.put("strfinId",strfinId);
				
				
				
				
				boolean proposalcheck=true;
				
				String appno="";
				strQuery=SQLParser.getSqlQuery("selappnoinwardnowise^"+strlarNo);
				rs=DBUtils.executeQuery(strQuery);	
				if(rs.next())
				{
					appno=Helper.correctNull((String)rs.getString("app_no"));
					proposalcheck=false;
				}
				
				if(proposalcheck=true)
				{
				hshValues1 = (HashMap) EJBInvoker.executeStateLess("MsmeDigitalAppInterface",hshJsonValues,"CorpRenewalProposalCreation");
				
				responseData.put("lapsProposalNumber", Helper.correctNull((String)hshValues1.get("appno")));
				strResponseCode="LAPS-3021";
				strResponseMsg="LAPS Application Created Successfully";
				}
				else
				{
					responseData.put("lapsProposalNumber",appno);
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
				throw new EJBException("Error in msmeServiceServiceImpl financialCMAService..."+e.toString());
			}
			return jsonAsString;	
		}

		public String camService(CreditAppraisalModule creditAppraisalModule) throws JsonProcessingException 
		{	
			
			Map<String,Object> responseData = new HashMap<String,Object>();
			Response response = new Response();
			String jsonAsString = "";
			
			HashMap hshValues = new HashMap();
			Map<String,Object> responseDataMap = null;
			String strcustomerName="",	strconstitution="",	strindustry ="",	streTBorNTB="",	streTBYearOfRelationWithKBL="",	strcreditScore="",	strproposedFacilityRequestType="",	stroverDraft="",	strcreditLetter="",	strbankGuarantee="",	strwcdpn="",	strcustomerExposerWithKBL="",	strproposedLimitRequested="",
					strproposedNPAStatus="",	strproposedLimitUtilisation="",		strcustomerMSMEexposure="",	strotherFacilityRequestType="",	strotherNPAStatus="",
					strotherPreLimitUtilisation="",	strotherLimitrequest="",	strappRefNo="",	strpanNo="",	strcustId="",	strappDate="",	strtransitionDate="",	strincorporateBusinessDate="",		strcmrRank="",	strwilfulDafaulter="",	strsuitFiledProgress="",	strsuitfiledLessThan3Years="",	strlast5MonthNPA="",
					strcurrentRatio="",	strnetWorkingCapital="",	strtOLOrTNW="",	strdaysReceivable="",	strcashAccrual="",	strnetWorth="",	strinterestorEBIT="",	strcashBankBalance="",	strcurrentLiabilities="",	strdebitOrEquity="",	strsalesOrPAT="",	strreturnAssets="",	strreturnCapitalEmployeed="",	
					strreturnEquity="",	strsalesWorkCapitalLimit="",	strbusinessCreditDeviationFresh="",	strbusinessDebitDeviationFresh="",	strchequeReturnLast9Month="",	strvariationcreditCountt6Month="",	strcredtDebitRatio6Months="",	strbusinessCreditDeviationRenewal="",	strbusinessDebitDeviationRenewal="",
					strchequeReturnLast12Month="",	strvariationCreditMonthly="",	strvariationDebitMonthly="",	strdaysOverutilisation6Months="",	strCommercialScoreCardSummary="",	strConsumerScorecardSummary="",	strbankODScoreCardSummary="",	strfinancialScoreSummary="",	strdemogScoreCardSummary="",strAppno="",
					strUtilisationODLimit="";
					
					
			
			try{
			
				JSONObject jsonCIFReqObj= new JSONObject(creditAppraisalModule);
				
				if (!jsonCIFReqObj.isNull("customerName"))   
					strcustomerName= jsonCIFReqObj.getString("customerName");
						if (!jsonCIFReqObj.isNull("constitution"))   
							strconstitution= jsonCIFReqObj.getString("constitution");
						if (!jsonCIFReqObj.isNull("industry"))   
							strindustry= jsonCIFReqObj.getString("industry");
						if (!jsonCIFReqObj.isNull("etbOrNTB"))   
							streTBorNTB= jsonCIFReqObj.getString("etbOrNTB");
						if (!jsonCIFReqObj.isNull("etbYearOfRelationWithKBL"))   
							streTBYearOfRelationWithKBL= jsonCIFReqObj.getString("etbYearOfRelationWithKBL");
						if (!jsonCIFReqObj.isNull("creditScore"))   
							strcreditScore= jsonCIFReqObj.getString("creditScore");
						if (!jsonCIFReqObj.isNull("proposedFacilityRequestType"))   
							strproposedFacilityRequestType= jsonCIFReqObj.getString("proposedFacilityRequestType");
						if (!jsonCIFReqObj.isNull("overDraft"))   
							stroverDraft= jsonCIFReqObj.getString("overDraft");
						if (!jsonCIFReqObj.isNull("creditLetter"))   
							strcreditLetter= jsonCIFReqObj.getString("creditLetter");
						if (!jsonCIFReqObj.isNull("bankGuarantee"))   
							strbankGuarantee= jsonCIFReqObj.getString("bankGuarantee");
						if (!jsonCIFReqObj.isNull("wcdpn"))   
							strwcdpn= jsonCIFReqObj.getString("wcdpn");
						if (!jsonCIFReqObj.isNull("customerExposerWithKBL"))   
							strcustomerExposerWithKBL= jsonCIFReqObj.getString("customerExposerWithKBL");
						if (!jsonCIFReqObj.isNull("proposedLimitRequested"))   
							strproposedLimitRequested= jsonCIFReqObj.getString("proposedLimitRequested");
						if (!jsonCIFReqObj.isNull("proposedNPAStatus"))   
							strproposedNPAStatus	= jsonCIFReqObj.getString("proposedNPAStatus");
						if (!jsonCIFReqObj.isNull("proposedLimitUtilisation"))   
							strproposedLimitUtilisation= jsonCIFReqObj.getString("proposedLimitUtilisation");	
						if (!jsonCIFReqObj.isNull("customerMSMEexposure"))   
							strcustomerMSMEexposure= jsonCIFReqObj.getString("customerMSMEexposure");
						if (!jsonCIFReqObj.isNull("otherFacilityRequestType"))   
							strotherFacilityRequestType= jsonCIFReqObj.getString("otherFacilityRequestType");
						if (!jsonCIFReqObj.isNull("otherNPAStatus"))   
							strotherNPAStatus= jsonCIFReqObj.getString("otherNPAStatus");
						if (!jsonCIFReqObj.isNull("otherPreLimitUtilisation"))   
							strotherPreLimitUtilisation= jsonCIFReqObj.getString("otherPreLimitUtilisation");
						if (!jsonCIFReqObj.isNull("otherLimitrequest"))   
							strotherLimitrequest= jsonCIFReqObj.getString("otherLimitrequest");
						if (!jsonCIFReqObj.isNull("appRefNo"))   
							strappRefNo= jsonCIFReqObj.getString("appRefNo");
						if (!jsonCIFReqObj.isNull("panNo"))   
							strpanNo= jsonCIFReqObj.getString("panNo");
						if (!jsonCIFReqObj.isNull("custId"))   
							strcustId= jsonCIFReqObj.getString("custId");
						if (!jsonCIFReqObj.isNull("appDate"))   
							strappDate= jsonCIFReqObj.getString("appDate");
						if (!jsonCIFReqObj.isNull("transitionDate"))   
							strtransitionDate= jsonCIFReqObj.getString("transitionDate");
						if (!jsonCIFReqObj.isNull("incorporateBusinessDate"))   
							strincorporateBusinessDate= jsonCIFReqObj.getString("incorporateBusinessDate");	
						if (!jsonCIFReqObj.isNull("cmrRank"))   
							strcmrRank= jsonCIFReqObj.getString("cmrRank");
						if (!jsonCIFReqObj.isNull("wilfulDafaulter"))   
							strwilfulDafaulter= jsonCIFReqObj.getString("wilfulDafaulter");
						if (!jsonCIFReqObj.isNull("suitFiledProgress"))   
							strsuitFiledProgress= jsonCIFReqObj.getString("suitFiledProgress");
						if (!jsonCIFReqObj.isNull("suitfiledLessThan3Years"))   
							strsuitfiledLessThan3Years= jsonCIFReqObj.getString("suitfiledLessThan3Years");
						if (!jsonCIFReqObj.isNull("last5MonthNPA"))   
							strlast5MonthNPA= jsonCIFReqObj.getString("last5MonthNPA");
						if (!jsonCIFReqObj.isNull("currentRatio"))   
							strcurrentRatio= jsonCIFReqObj.getString("currentRatio");
						if (!jsonCIFReqObj.isNull("netWorkingCapital"))   
							strnetWorkingCapital= jsonCIFReqObj.getString("netWorkingCapital");
						if (!jsonCIFReqObj.isNull("tolOrTNW"))   
							strtOLOrTNW= jsonCIFReqObj.getString("tolOrTNW");
						if (!jsonCIFReqObj.isNull("daysReceivable"))   
							strdaysReceivable= jsonCIFReqObj.getString("daysReceivable");
						if (!jsonCIFReqObj.isNull("cashAccrual"))   
							strcashAccrual= jsonCIFReqObj.getString("cashAccrual");
						if (!jsonCIFReqObj.isNull("netWorth"))   
							strnetWorth= jsonCIFReqObj.getString("netWorth");
						if (!jsonCIFReqObj.isNull("interestorEBIT"))   
							strinterestorEBIT= jsonCIFReqObj.getString("interestorEBIT");
						if (!jsonCIFReqObj.isNull("cashBankBalance"))   
							strcashBankBalance= jsonCIFReqObj.getString("cashBankBalance");
						if (!jsonCIFReqObj.isNull("currentLiabilities"))   
							strcurrentLiabilities= jsonCIFReqObj.getString("currentLiabilities");
						if (!jsonCIFReqObj.isNull("debitOrEquity"))   
							strdebitOrEquity= jsonCIFReqObj.getString("debitOrEquity");
						if (!jsonCIFReqObj.isNull("salesOrPAT"))   
							strsalesOrPAT= jsonCIFReqObj.getString("salesOrPAT");
						if (!jsonCIFReqObj.isNull("returnAssets"))   
							strreturnAssets= jsonCIFReqObj.getString("returnAssets");
						
						if (!jsonCIFReqObj.isNull("returnCapitalEmployeed"))   
							strreturnCapitalEmployeed= jsonCIFReqObj.getString("returnCapitalEmployeed");
						if (!jsonCIFReqObj.isNull("returnEquity"))   
							strreturnEquity= jsonCIFReqObj.getString("returnEquity");
						if (!jsonCIFReqObj.isNull("salesWorkCapitalLimit"))   
							strsalesWorkCapitalLimit= jsonCIFReqObj.getString("salesWorkCapitalLimit");
						if (!jsonCIFReqObj.isNull("businessCreditDeviationFresh"))   
							strbusinessCreditDeviationFresh= jsonCIFReqObj.getString("businessCreditDeviationFresh");
						if (!jsonCIFReqObj.isNull("businessDebitDeviationFresh"))   
							strbusinessDebitDeviationFresh= jsonCIFReqObj.getString("businessDebitDeviationFresh");
						if (!jsonCIFReqObj.isNull("chequeReturnLast9Month"))   
							strchequeReturnLast9Month= jsonCIFReqObj.getString("chequeReturnLast9Month");
						if (!jsonCIFReqObj.isNull("variationcreditCount6Month"))   
							strvariationcreditCountt6Month= jsonCIFReqObj.getString("variationcreditCount6Month");
						if (!jsonCIFReqObj.isNull("credtDebitRatio6Months"))   
							strcredtDebitRatio6Months= jsonCIFReqObj.getString("credtDebitRatio6Months");
						if (!jsonCIFReqObj.isNull("businessCreditDeviationRenewal"))   
							strbusinessCreditDeviationRenewal= jsonCIFReqObj.getString("businessCreditDeviationRenewal");
						if (!jsonCIFReqObj.isNull("businessDebitDeviationRenewal"))   
							strbusinessDebitDeviationRenewal= jsonCIFReqObj.getString("businessDebitDeviationRenewal");
						if (!jsonCIFReqObj.isNull("chequeReturnLast12Month"))   
							strchequeReturnLast12Month= jsonCIFReqObj.getString("chequeReturnLast12Month");
						if (!jsonCIFReqObj.isNull("variationCreditMonthly"))   
							strvariationCreditMonthly= jsonCIFReqObj.getString("variationCreditMonthly");
						if (!jsonCIFReqObj.isNull("variationDebitMonthly"))   
							strvariationDebitMonthly= jsonCIFReqObj.getString("variationDebitMonthly");
						if (!jsonCIFReqObj.isNull("daysOverutilisation6Months"))   
							strdaysOverutilisation6Months= jsonCIFReqObj.getString("daysOverutilisation6Months");
						if (!jsonCIFReqObj.isNull("commercialScoreCardSummary"))   
							strCommercialScoreCardSummary= jsonCIFReqObj.getString("commercialScoreCardSummary");
						if (!jsonCIFReqObj.isNull("consumerScorecardSummary"))   
							strConsumerScorecardSummary= jsonCIFReqObj.getString("consumerScorecardSummary");
						if (!jsonCIFReqObj.isNull("bankODScoreCardSummary"))   
							strbankODScoreCardSummary= jsonCIFReqObj.getString("bankODScoreCardSummary");
						if (!jsonCIFReqObj.isNull("financialScoreSummary"))   
							strfinancialScoreSummary= jsonCIFReqObj.getString("financialScoreSummary");
						if (!jsonCIFReqObj.isNull("demogScoreCardSummary"))   
							strdemogScoreCardSummary= jsonCIFReqObj.getString("demogScoreCardSummary");
						if (!jsonCIFReqObj.isNull("applicationNo"))   
							strAppno= jsonCIFReqObj.getString("applicationNo");
						
						if (!jsonCIFReqObj.isNull("utilisationODLimit"))   
							strUtilisationODLimit= jsonCIFReqObj.getString("utilisationODLimit");
						
						
						JSONArray jsonBureauRenewal		= new JSONArray();
						if (!jsonCIFReqObj.isNull("bureauRenewal"))
							jsonBureauRenewal=jsonCIFReqObj.getJSONArray("bureauRenewal");
						
								
						JSONObject renewal= new JSONObject();
						
						int renSize=jsonBureauRenewal.length();
						ArrayList arrrenwal=new ArrayList();
						ArrayList arrrenvalues=new ArrayList();
						if(renSize>0)
						{
							
								renewal=(JSONObject) jsonBureauRenewal.get(0);
								
								String lastWrittenOffMonth=renewal.getString("lastWrittenOffMonth");
								String writtenOffAmount=renewal.getString("writtenOffAmount");
								String lastNPAMonth=renewal.getString("lastNPAMonth");
								String lastNPAAmount=renewal.getString("lastNPAAmount");
								String last60DPDMonth=renewal.getString("last60DPDMonth");
								String last60DPDAmount=renewal.getString("last60DPDAmount");
								
								String creditVintageYears=renewal.getString("creditVintageYears");
								String oneYearEnquiries=renewal.getString("oneYearEnquiries");
								String accountOpenedOneYear=renewal.getString("accountOpenedOneYear");
								String noOfActiveLoans=renewal.getString("noOfActiveLoans");
								JSONArray reltdName	= new JSONArray();
								//ArrayList arrrltdName=new ArrayList();
								ArrayList arrrltdNameValues=new ArrayList();
								JSONObject relobj= new JSONObject();
								 reltdName=renewal.getJSONArray("relatedPartyName");
								 relobj=(JSONObject)reltdName.get(0);
								 arrrltdNameValues.add(relobj.getString("party1"));
								 arrrltdNameValues.add(relobj.getString("party2"));
								 arrrltdNameValues.add(relobj.getString("party3"));
								 arrrltdNameValues.add(relobj.getString("party4"));
								 arrrltdNameValues.add(relobj.getString("party5"));
								 arrrenvalues.add(arrrltdNameValues);
								 
								
								 	JSONArray arrAge	= new JSONArray();
									//ArrayList arrrltdName=new ArrayList();
									ArrayList arrageValues=new ArrayList();
									JSONObject ageobj= new JSONObject();
									arrAge=renewal.getJSONArray("age");
									ageobj=(JSONObject)arrAge.get(0);
									arrageValues.add(ageobj.getString("party1"));
									arrageValues.add(ageobj.getString("party2"));
									arrageValues.add(ageobj.getString("party3"));
									arrageValues.add(ageobj.getString("party4"));
									arrageValues.add(ageobj.getString("party5"));
									arrrenvalues.add(arrageValues);
		

							 	JSONArray arrworth	= new JSONArray();
								//ArrayList arrrltdName=new ArrayList();
								ArrayList arrworthValues=new ArrayList();
								JSONObject networthobj= new JSONObject();
								arrworth=renewal.getJSONArray("netWorth");
								networthobj=(JSONObject)arrworth.get(0);
								arrworthValues.add(networthobj.getString("party1"));
								arrworthValues.add(networthobj.getString("party2"));
								arrworthValues.add(networthobj.getString("party3"));
								arrworthValues.add(networthobj.getString("party4"));
								arrworthValues.add(networthobj.getString("party5"));
								arrrenvalues.add(arrageValues);
								
								
								
								
								JSONArray arrisRelatedKBLStaff	= new JSONArray();
								//ArrayList arrrltdName=new ArrayList();
								ArrayList isRelatedKBLStaffValues=new ArrayList();
								JSONObject isRelatedKBLStaffObj= new JSONObject();
								arrisRelatedKBLStaff=renewal.getJSONArray("isRelatedKBLStaff");
								isRelatedKBLStaffObj=(JSONObject)arrisRelatedKBLStaff.get(0);
								isRelatedKBLStaffValues.add(isRelatedKBLStaffObj.getString("party1"));
								isRelatedKBLStaffValues.add(isRelatedKBLStaffObj.getString("party2"));
								isRelatedKBLStaffValues.add(isRelatedKBLStaffObj.getString("party3"));
								isRelatedKBLStaffValues.add(isRelatedKBLStaffObj.getString("party4"));
								isRelatedKBLStaffValues.add(isRelatedKBLStaffObj.getString("party5"));
								arrrenvalues.add(arrageValues);
								
								
								JSONArray arrcibilScore	= new JSONArray();
								ArrayList arrcibilScoreValues=new ArrayList();
								JSONObject cibilScoreObj= new JSONObject();
								arrcibilScore=renewal.getJSONArray("cibilScore");
								cibilScoreObj=(JSONObject)arrcibilScore.get(0);
								
								arrcibilScoreValues.add(cibilScoreObj.getString("party1"));
								arrcibilScoreValues.add(cibilScoreObj.getString("party2"));
								arrcibilScoreValues.add(cibilScoreObj.getString("party3"));
								arrcibilScoreValues.add(cibilScoreObj.getString("party4"));
								arrcibilScoreValues.add(cibilScoreObj.getString("party5"));
								arrrenvalues.add(arrageValues);
								
								
								
								JSONArray arrlastWriteOffMonthCredit	= new JSONArray();
								ArrayList lastWriteOffMonthCreditValue=new ArrayList();
								JSONObject lastWriteOffMonthCreditObj= new JSONObject();
								arrlastWriteOffMonthCredit=renewal.getJSONArray("lastWriteOffMonthCredit");
								lastWriteOffMonthCreditObj=(JSONObject)arrlastWriteOffMonthCredit.get(0);
								
								
								lastWriteOffMonthCreditValue.add(lastWriteOffMonthCreditObj.getString("party1"));
								lastWriteOffMonthCreditValue.add(lastWriteOffMonthCreditObj.getString("party2"));
								lastWriteOffMonthCreditValue.add(lastWriteOffMonthCreditObj.getString("party3"));
								lastWriteOffMonthCreditValue.add(lastWriteOffMonthCreditObj.getString("party4"));
								lastWriteOffMonthCreditValue.add(lastWriteOffMonthCreditObj.getString("party5"));
								arrrenvalues.add(arrageValues);
								
								
								JSONArray arrlastWriteOffAmount	= new JSONArray();
								ArrayList lastWriteOffAmountValue=new ArrayList();
								JSONObject lastWriteOffAmountObj= new JSONObject();
								arrlastWriteOffAmount=renewal.getJSONArray("lastWriteOffAmount");
								lastWriteOffAmountObj=(JSONObject)arrlastWriteOffMonthCredit.get(0);
								
								
								lastWriteOffAmountValue.add(lastWriteOffAmountObj.getString("party1"));
								lastWriteOffAmountValue.add(lastWriteOffAmountObj.getString("party2"));
								lastWriteOffAmountValue.add(lastWriteOffAmountObj.getString("party3"));
								lastWriteOffAmountValue.add(lastWriteOffAmountObj.getString("party4"));
								lastWriteOffAmountValue.add(lastWriteOffAmountObj.getString("party5"));
								arrrenvalues.add(arrageValues);
								
								
								JSONArray arrlastWriteOffMonthNonCredit	= new JSONArray();
								ArrayList lastWriteOffMonthNonCreditValue=new ArrayList();
								JSONObject lastWriteOffMonthNonCreditObj= new JSONObject();
								arrlastWriteOffMonthNonCredit=renewal.getJSONArray("lastWriteOffMonthNonCredit");
								lastWriteOffMonthNonCreditObj=(JSONObject)arrlastWriteOffMonthNonCredit.get(0);
								
								
								lastWriteOffMonthNonCreditValue.add(lastWriteOffMonthNonCreditObj.getString("party1"));
								lastWriteOffMonthNonCreditValue.add(lastWriteOffMonthNonCreditObj.getString("party2"));
								lastWriteOffMonthNonCreditValue.add(lastWriteOffMonthNonCreditObj.getString("party3"));
								lastWriteOffMonthNonCreditValue.add(lastWriteOffMonthNonCreditObj.getString("party4"));
								lastWriteOffMonthNonCreditValue.add(lastWriteOffMonthNonCreditObj.getString("party5"));
								arrrenvalues.add(arrageValues);
								
								
								
								JSONArray arrwriteOffAmountNonCredit	= new JSONArray();
								ArrayList writeOffAmountNonCreditValue=new ArrayList();
								JSONObject writeOffAmountNonCreditObj= new JSONObject();
								arrwriteOffAmountNonCredit=renewal.getJSONArray("writeOffAmountNonCredit");
								writeOffAmountNonCreditObj=(JSONObject)arrwriteOffAmountNonCredit.get(0);
																
								writeOffAmountNonCreditValue.add(writeOffAmountNonCreditObj.getString("party1"));
								writeOffAmountNonCreditValue.add(writeOffAmountNonCreditObj.getString("party2"));
								writeOffAmountNonCreditValue.add(writeOffAmountNonCreditObj.getString("party3"));
								writeOffAmountNonCreditValue.add(writeOffAmountNonCreditObj.getString("party4"));
								writeOffAmountNonCreditValue.add(writeOffAmountNonCreditObj.getString("party5"));
								arrrenvalues.add(writeOffAmountNonCreditValue);
								
								JSONArray arrnoOfLoansWithSMA1	= new JSONArray();
								ArrayList noOfLoansWithSMA1Value=new ArrayList();
								JSONObject noOfLoansWithSMA1Obj= new JSONObject();
								arrnoOfLoansWithSMA1=renewal.getJSONArray("noOfLoansWithSMA1");
								noOfLoansWithSMA1Obj=(JSONObject)arrnoOfLoansWithSMA1.get(0);
																
								noOfLoansWithSMA1Value.add(noOfLoansWithSMA1Obj.getString("party1"));
								noOfLoansWithSMA1Value.add(noOfLoansWithSMA1Obj.getString("party2"));
								noOfLoansWithSMA1Value.add(noOfLoansWithSMA1Obj.getString("party3"));
								noOfLoansWithSMA1Value.add(noOfLoansWithSMA1Obj.getString("party4"));
								noOfLoansWithSMA1Value.add(noOfLoansWithSMA1Obj.getString("party5"));
								arrrenvalues.add(noOfLoansWithSMA1Value);	
								
								
								JSONArray arrlastSMA1Month	= new JSONArray();
								ArrayList lastSMA1MonthValue=new ArrayList();
								JSONObject lastSMA1MonthObj= new JSONObject();
								arrlastSMA1Month=renewal.getJSONArray("lastSMA1Month");
								lastSMA1MonthObj=(JSONObject)arrlastSMA1Month.get(0);
																
								lastSMA1MonthValue.add(lastSMA1MonthObj.getString("party1"));
								lastSMA1MonthValue.add(lastSMA1MonthObj.getString("party2"));
								lastSMA1MonthValue.add(lastSMA1MonthObj.getString("party3"));
								lastSMA1MonthValue.add(lastSMA1MonthObj.getString("party4"));
								lastSMA1MonthValue.add(lastSMA1MonthObj.getString("party5"));
								arrrenvalues.add(lastSMA1MonthValue);
								
								
								
								
								JSONArray arryearEnquiries	= new JSONArray();
								ArrayList yearEnquiriesValue=new ArrayList();
								JSONObject yearEnquiriesObj= new JSONObject();
								arryearEnquiries=renewal.getJSONArray("lastOneYearEnquiriesConsumer");
								yearEnquiriesObj=(JSONObject)arryearEnquiries.get(0);
																
								yearEnquiriesValue.add(yearEnquiriesObj.getString("party1"));
								yearEnquiriesValue.add(yearEnquiriesObj.getString("party2"));
								yearEnquiriesValue.add(yearEnquiriesObj.getString("party3"));
								yearEnquiriesValue.add(yearEnquiriesObj.getString("party4"));
								yearEnquiriesValue.add(yearEnquiriesObj.getString("party5"));
								arrrenvalues.add(yearEnquiriesValue);
								
								
								
								JSONArray arraccOpenOneYear	= new JSONArray();
								ArrayList accOpenOneYearValues=new ArrayList();
								JSONObject accOpenOneYearObj= new JSONObject();
								arraccOpenOneYear=renewal.getJSONArray("accOpenOneYearConsumer");
								accOpenOneYearObj=(JSONObject)arraccOpenOneYear.get(0);
																
								accOpenOneYearValues.add(accOpenOneYearObj.getString("party1"));
								accOpenOneYearValues.add(accOpenOneYearObj.getString("party2"));
								accOpenOneYearValues.add(accOpenOneYearObj.getString("party3"));
								accOpenOneYearValues.add(accOpenOneYearObj.getString("party4"));
								accOpenOneYearValues.add(accOpenOneYearObj.getString("party5"));
								arrrenvalues.add(accOpenOneYearValues);
								
								
								
								
								
								JSONArray arrnoActiveLoansConsumer	= new JSONArray();
								ArrayList noActiveLoansConsumerValue=new ArrayList();
								JSONObject noActiveLoansConsumerObj= new JSONObject();
								arrnoActiveLoansConsumer=renewal.getJSONArray("noActiveLoansConsumer");
								noActiveLoansConsumerObj=(JSONObject)arrnoActiveLoansConsumer.get(0);
																
								noActiveLoansConsumerValue.add(noActiveLoansConsumerObj.getString("party1"));
								noActiveLoansConsumerValue.add(noActiveLoansConsumerObj.getString("party2"));
								noActiveLoansConsumerValue.add(noActiveLoansConsumerObj.getString("party3"));
								noActiveLoansConsumerValue.add(noActiveLoansConsumerObj.getString("party4"));
								noActiveLoansConsumerValue.add(noActiveLoansConsumerObj.getString("party5"));
								arrrenvalues.add(accOpenOneYearValues);
								
								arrrenvalues.add(lastWrittenOffMonth);
								arrrenvalues.add(writtenOffAmount);
								arrrenvalues.add(lastNPAMonth);
								arrrenvalues.add(lastNPAAmount);
								arrrenvalues.add(last60DPDMonth);
								arrrenvalues.add(last60DPDAmount);
								arrrenvalues.add(creditVintageYears);
								arrrenvalues.add(oneYearEnquiries);
								arrrenvalues.add(accountOpenedOneYear);
								arrrenvalues.add(noOfActiveLoans);
								
								
								arrrenwal.add(arrrenvalues);
								
						}
						
						JSONArray jsonbureauFresh		= new JSONArray();						
						if (!jsonCIFReqObj.isNull("bureauFresh"))
							jsonbureauFresh=jsonCIFReqObj.getJSONArray("bureauFresh");	
						
						JSONObject fresh= new JSONObject();
						
						int freshSize=jsonbureauFresh.length();
						ArrayList arrfresh=new ArrayList();
						ArrayList arrfreshvalues=new ArrayList();
						if(freshSize>0)
						{
							
								fresh=(JSONObject) jsonbureauFresh.get(0);
								
								String lastWrittenOffMonth=fresh.getString("lastWrittenOffMonth");
								String writtenOffAmount=fresh.getString("writtenOffAmount");
								String commercialScoreCard=fresh.getString("commercialScoreCard"); 
								String lastNPAMonth=fresh.getString("lastNPAMonth");
								String lastNPAAmount=fresh.getString("lastNPAAmount");
								String last60DPDMonth=fresh.getString("last60DPDMonth");
								String last60DPDAmount=fresh.getString("last60DPDAmount");
								String creditVintageYears=fresh.getString("creditVintageYears");
								String oneYearEnquiries=fresh.getString("oneYearEnquiries");							
								String accountOpenedOneYear=fresh.getString("accountOpenedOneYear");
								String noOfActiveLoans=fresh.getString("noOfActiveLoans"); 
								JSONArray reltdName	= new JSONArray();
								//ArrayList arrrltdName=new ArrayList();
								ArrayList arrrltdNameValues=new ArrayList();
								JSONObject relobj= new JSONObject();
								 reltdName=fresh.getJSONArray("relatedPartyName");
								 relobj=(JSONObject)reltdName.get(0);
								 arrrltdNameValues.add(relobj.getString("party1"));
								 arrrltdNameValues.add(relobj.getString("party2"));
								 arrrltdNameValues.add(relobj.getString("party3"));
								 arrrltdNameValues.add(relobj.getString("party4"));
								 arrrltdNameValues.add(relobj.getString("party5"));
								 arrfreshvalues.add(arrrltdNameValues);
								 
								
								 	JSONArray arrAge	= new JSONArray();
									//ArrayList arrrltdName=new ArrayList();
									ArrayList arrageValues=new ArrayList();
									JSONObject ageobj= new JSONObject();
									arrAge=fresh.getJSONArray("age");
									ageobj=(JSONObject)arrAge.get(0);
									arrageValues.add(ageobj.getString("party1"));
									arrageValues.add(ageobj.getString("party2"));
									arrageValues.add(ageobj.getString("party3"));
									arrageValues.add(ageobj.getString("party4"));
									arrageValues.add(ageobj.getString("party5"));
									 arrfreshvalues.add(arrageValues);
		

							 	JSONArray arrworth	= new JSONArray();
								//ArrayList arrrltdName=new ArrayList();
								ArrayList arrworthValues=new ArrayList();
								JSONObject networthobj= new JSONObject();
								arrworth=fresh.getJSONArray("netWorth");
								networthobj=(JSONObject)arrworth.get(0);
								arrworthValues.add(networthobj.getString("party1"));
								arrworthValues.add(networthobj.getString("party2"));
								arrworthValues.add(networthobj.getString("party3"));
								arrworthValues.add(networthobj.getString("party4"));
								arrworthValues.add(networthobj.getString("party5"));
								arrfreshvalues.add(arrworthValues);
								
								
								
								
								JSONArray arrisRelatedKBLStaff	= new JSONArray();
								//ArrayList arrrltdName=new ArrayList();
								ArrayList isRelatedKBLStaffValues=new ArrayList();
								JSONObject isRelatedKBLStaffObj= new JSONObject();
								arrisRelatedKBLStaff=fresh.getJSONArray("isRelatedKBLStaff");
								isRelatedKBLStaffObj=(JSONObject)arrisRelatedKBLStaff.get(0);
								isRelatedKBLStaffValues.add(isRelatedKBLStaffObj.getString("party1"));
								isRelatedKBLStaffValues.add(isRelatedKBLStaffObj.getString("party2"));
								isRelatedKBLStaffValues.add(isRelatedKBLStaffObj.getString("party3"));
								isRelatedKBLStaffValues.add(isRelatedKBLStaffObj.getString("party4"));
								isRelatedKBLStaffValues.add(isRelatedKBLStaffObj.getString("party5"));
								arrfreshvalues.add(isRelatedKBLStaffValues);
								
								
								JSONArray arrcibilScore	= new JSONArray();
								ArrayList arrcibilScoreValues=new ArrayList();
								JSONObject cibilScoreObj= new JSONObject();
								arrcibilScore=fresh.getJSONArray("cibilScore");
								cibilScoreObj=(JSONObject)arrcibilScore.get(0);
								
								arrcibilScoreValues.add(cibilScoreObj.getString("party1"));
								arrcibilScoreValues.add(cibilScoreObj.getString("party2"));
								arrcibilScoreValues.add(cibilScoreObj.getString("party3"));
								arrcibilScoreValues.add(cibilScoreObj.getString("party4"));
								arrcibilScoreValues.add(cibilScoreObj.getString("party5"));
								arrfreshvalues.add(isRelatedKBLStaffValues);
								
								
								
								JSONArray arrlastWriteOffMonthCredit	= new JSONArray();
								ArrayList lastWriteOffMonthCreditValue=new ArrayList();
								JSONObject lastWriteOffMonthCreditObj= new JSONObject();
								arrlastWriteOffMonthCredit=fresh.getJSONArray("lastWriteOffMonthCredit");
								lastWriteOffMonthCreditObj=(JSONObject)arrlastWriteOffMonthCredit.get(0);
								
								
								lastWriteOffMonthCreditValue.add(lastWriteOffMonthCreditObj.getString("party1"));
								lastWriteOffMonthCreditValue.add(lastWriteOffMonthCreditObj.getString("party2"));
								lastWriteOffMonthCreditValue.add(lastWriteOffMonthCreditObj.getString("party3"));
								lastWriteOffMonthCreditValue.add(lastWriteOffMonthCreditObj.getString("party4"));
								lastWriteOffMonthCreditValue.add(lastWriteOffMonthCreditObj.getString("party5"));
								arrfreshvalues.add(lastWriteOffMonthCreditValue);
								
								
								JSONArray arrlastWriteOffAmount	= new JSONArray();
								ArrayList lastWriteOffAmountValue=new ArrayList();
								JSONObject lastWriteOffAmountObj= new JSONObject();
								arrlastWriteOffAmount=fresh.getJSONArray("lastWriteOffAmount");
								lastWriteOffAmountObj=(JSONObject)arrlastWriteOffMonthCredit.get(0);
								
								
								lastWriteOffAmountValue.add(lastWriteOffAmountObj.getString("party1"));
								lastWriteOffAmountValue.add(lastWriteOffAmountObj.getString("party2"));
								lastWriteOffAmountValue.add(lastWriteOffAmountObj.getString("party3"));
								lastWriteOffAmountValue.add(lastWriteOffAmountObj.getString("party4"));
								lastWriteOffAmountValue.add(lastWriteOffAmountObj.getString("party5"));
								arrfreshvalues.add(lastWriteOffAmountValue);	
								
								
								JSONArray arrlastWriteOffMonthNonCredit	= new JSONArray();
								ArrayList lastWriteOffMonthNonCreditValue=new ArrayList();
								JSONObject lastWriteOffMonthNonCreditObj= new JSONObject();
								arrlastWriteOffMonthNonCredit=fresh.getJSONArray("lastWriteOffMonthNonCredit");
								lastWriteOffMonthNonCreditObj=(JSONObject)arrlastWriteOffMonthNonCredit.get(0);
								
								
								lastWriteOffMonthNonCreditValue.add(lastWriteOffMonthNonCreditObj.getString("party1"));
								lastWriteOffMonthNonCreditValue.add(lastWriteOffMonthNonCreditObj.getString("party2"));
								lastWriteOffMonthNonCreditValue.add(lastWriteOffMonthNonCreditObj.getString("party3"));
								lastWriteOffMonthNonCreditValue.add(lastWriteOffMonthNonCreditObj.getString("party4"));
								lastWriteOffMonthNonCreditValue.add(lastWriteOffMonthNonCreditObj.getString("party5"));
								arrfreshvalues.add(lastWriteOffMonthNonCreditValue);
								
								
								
								JSONArray arrwriteOffAmountNonCredit	= new JSONArray();
								ArrayList writeOffAmountNonCreditValue=new ArrayList();
								JSONObject writeOffAmountNonCreditObj= new JSONObject();
								arrwriteOffAmountNonCredit=fresh.getJSONArray("writeOffAmountNonCredit");
								writeOffAmountNonCreditObj=(JSONObject)arrwriteOffAmountNonCredit.get(0);
																
								writeOffAmountNonCreditValue.add(writeOffAmountNonCreditObj.getString("party1"));
								writeOffAmountNonCreditValue.add(writeOffAmountNonCreditObj.getString("party2"));
								writeOffAmountNonCreditValue.add(writeOffAmountNonCreditObj.getString("party3"));
								writeOffAmountNonCreditValue.add(writeOffAmountNonCreditObj.getString("party4"));
								writeOffAmountNonCreditValue.add(writeOffAmountNonCreditObj.getString("party5"));
								arrfreshvalues.add(writeOffAmountNonCreditValue);
								
								JSONArray arrnoOfLoansWithSMA1	= new JSONArray();
								ArrayList noOfLoansWithSMA1Value=new ArrayList();
								JSONObject noOfLoansWithSMA1Obj= new JSONObject();
								arrnoOfLoansWithSMA1=fresh.getJSONArray("noOfLoansWithSMA1");
								noOfLoansWithSMA1Obj=(JSONObject)arrnoOfLoansWithSMA1.get(0);
																
								noOfLoansWithSMA1Value.add(noOfLoansWithSMA1Obj.getString("party1"));
								noOfLoansWithSMA1Value.add(noOfLoansWithSMA1Obj.getString("party2"));
								noOfLoansWithSMA1Value.add(noOfLoansWithSMA1Obj.getString("party3"));
								noOfLoansWithSMA1Value.add(noOfLoansWithSMA1Obj.getString("party4"));
								noOfLoansWithSMA1Value.add(noOfLoansWithSMA1Obj.getString("party5"));
								arrfreshvalues.add(noOfLoansWithSMA1Value);	
								
								
								JSONArray arrlastSMA1Month	= new JSONArray();
								ArrayList lastSMA1MonthValue=new ArrayList();
								JSONObject lastSMA1MonthObj= new JSONObject();
								arrlastSMA1Month=fresh.getJSONArray("lastSMA1Month");
								lastSMA1MonthObj=(JSONObject)arrlastSMA1Month.get(0);
																
								lastSMA1MonthValue.add(lastSMA1MonthObj.getString("party1"));
								lastSMA1MonthValue.add(lastSMA1MonthObj.getString("party2"));
								lastSMA1MonthValue.add(lastSMA1MonthObj.getString("party3"));
								lastSMA1MonthValue.add(lastSMA1MonthObj.getString("party4"));
								lastSMA1MonthValue.add(lastSMA1MonthObj.getString("party5"));
								arrfreshvalues.add(lastSMA1MonthValue);	
								
								
								
								
								JSONArray arryearEnquiries	= new JSONArray();
								ArrayList yearEnquiriesValue=new ArrayList();
								JSONObject yearEnquiriesObj= new JSONObject();
								arryearEnquiries=fresh.getJSONArray("lastOneYearEnquiriesConsumer");
								yearEnquiriesObj=(JSONObject)arryearEnquiries.get(0);
																
								yearEnquiriesValue.add(yearEnquiriesObj.getString("party1"));
								yearEnquiriesValue.add(yearEnquiriesObj.getString("party2"));
								yearEnquiriesValue.add(yearEnquiriesObj.getString("party3"));
								yearEnquiriesValue.add(yearEnquiriesObj.getString("party4"));
								yearEnquiriesValue.add(yearEnquiriesObj.getString("party5"));
								arrfreshvalues.add(yearEnquiriesValue);
								
								
								
								JSONArray arraccOpenOneYear	= new JSONArray();
								ArrayList accOpenOneYearValues=new ArrayList();
								JSONObject accOpenOneYearObj= new JSONObject();
								arraccOpenOneYear=fresh.getJSONArray("accOpenOneYearConsumer");
								accOpenOneYearObj=(JSONObject)arraccOpenOneYear.get(0);
																
								accOpenOneYearValues.add(accOpenOneYearObj.getString("party1"));
								accOpenOneYearValues.add(accOpenOneYearObj.getString("party2"));
								accOpenOneYearValues.add(accOpenOneYearObj.getString("party3"));
								accOpenOneYearValues.add(accOpenOneYearObj.getString("party4"));
								accOpenOneYearValues.add(accOpenOneYearObj.getString("party5"));
								arrfreshvalues.add(accOpenOneYearValues);
								
								
								
								
								
								JSONArray arrnoActiveLoansConsumer	= new JSONArray();
								ArrayList noActiveLoansConsumerValue=new ArrayList();
								JSONObject noActiveLoansConsumerObj= new JSONObject();
								arrnoActiveLoansConsumer=fresh.getJSONArray("noActiveLoansConsumer");
								noActiveLoansConsumerObj=(JSONObject)arrnoActiveLoansConsumer.get(0);
																
								noActiveLoansConsumerValue.add(noActiveLoansConsumerObj.getString("party1"));
								noActiveLoansConsumerValue.add(noActiveLoansConsumerObj.getString("party2"));
								noActiveLoansConsumerValue.add(noActiveLoansConsumerObj.getString("party3"));
								noActiveLoansConsumerValue.add(noActiveLoansConsumerObj.getString("party4"));
								noActiveLoansConsumerValue.add(noActiveLoansConsumerObj.getString("party5"));
								arrfreshvalues.add(noActiveLoansConsumerValue);
								
								arrfreshvalues.add(lastWrittenOffMonth);
								arrfreshvalues.add(writtenOffAmount);
								arrfreshvalues.add(lastNPAMonth);
								arrfreshvalues.add(lastNPAAmount);
								arrfreshvalues.add(last60DPDMonth);
								arrfreshvalues.add(last60DPDAmount);
								arrfreshvalues.add(creditVintageYears);
								arrfreshvalues.add(oneYearEnquiries);
								arrfreshvalues.add(accountOpenedOneYear);
								arrfreshvalues.add(commercialScoreCard);					
								arrfreshvalues.add(noOfActiveLoans);
								
								arrfresh.add(arrfreshvalues);
						
						}
					
						
						HashMap hshJsonValues = new HashMap();
						
						hshJsonValues.put("arrrenwal",arrrenvalues);
						
						hshJsonValues.put("arrfresh",arrfreshvalues);
						
						hshJsonValues.put("strcustomerName",strcustomerName);
						
						hshJsonValues.put("strconstitution",strconstitution);
						
						hshJsonValues.put("strindustry",strindustry);
					
						hshJsonValues.put("streTBorNTB",streTBorNTB);
						
						hshJsonValues.put("streTBYearOfRelationWithKBL",streTBYearOfRelationWithKBL);
						
						hshJsonValues.put("strcreditScore",strcreditScore);
						
						hshJsonValues.put("strproposedFacilityRequestType",strproposedFacilityRequestType);
						
						hshJsonValues.put("stroverDraft",stroverDraft);
						
						
						hshJsonValues.put("strcreditLetter",strcreditLetter);
						
						hshJsonValues.put("strbankGuarantee",strbankGuarantee);
						
						hshJsonValues.put("strwcdpn",strwcdpn);
						
						hshJsonValues.put("strcustomerExposerWithKBL",strcustomerExposerWithKBL);
						
						hshJsonValues.put("strproposedLimitRequested",strproposedLimitRequested);
						
						hshJsonValues.put("strproposedNPAStatus",strproposedNPAStatus);

						
						hshJsonValues.put("strproposedLimitUtilisation",strproposedLimitUtilisation);
						
						hshJsonValues.put("strcustomerMSMEexposure",strcustomerMSMEexposure);
						
						hshJsonValues.put("strotherFacilityRequestType",strotherFacilityRequestType);
						
						hshJsonValues.put("strotherNPAStatus",strotherNPAStatus);
						
						hshJsonValues.put("strotherPreLimitUtilisation",strotherPreLimitUtilisation);

						
						hshJsonValues.put("strotherLimitrequest",strotherLimitrequest);
						
						hshJsonValues.put("strappRefNo",strappRefNo);
						
						hshJsonValues.put("strpanNo",strpanNo);
						
						hshJsonValues.put("strcustId",strcustId);
						
						hshJsonValues.put("strappDate",strappDate);
						
						hshJsonValues.put("strtransitionDate",strtransitionDate);
						
						hshJsonValues.put("strincorporateBusinessDate",strincorporateBusinessDate);
						
						hshJsonValues.put("strcmrRank",strcmrRank);
						
						hshJsonValues.put("strwilfulDafaulter",strwilfulDafaulter);
						
						hshJsonValues.put("strsuitFiledProgress",strsuitFiledProgress);
						
						hshJsonValues.put("strsuitfiledLessThan3Years",strsuitfiledLessThan3Years);
						
						hshJsonValues.put("strlast5MonthNPA",strlast5MonthNPA);
						
						hshJsonValues.put("strcurrentRatio",strcurrentRatio);

						
						hshJsonValues.put("strnetWorkingCapital",strnetWorkingCapital);
						
						hshJsonValues.put("strtOLOrTNW",strtOLOrTNW);
						
						hshJsonValues.put("strdaysReceivable",strdaysReceivable);
						
						hshJsonValues.put("strcashAccrual",strcashAccrual);
						
						hshJsonValues.put("strnetWorth",strnetWorth);
						
						hshJsonValues.put("strinterestorEBIT",strinterestorEBIT);
						
						hshJsonValues.put("strcashBankBalance",strcashBankBalance);
						
						hshJsonValues.put("strcurrentLiabilities",strcurrentLiabilities);
						
						hshJsonValues.put("strdebitOrEquity",strdebitOrEquity);
						
						hshJsonValues.put("strsalesOrPAT",strsalesOrPAT);
						
						hshJsonValues.put("strreturnAssets",strreturnAssets);
						
						hshJsonValues.put("strreturnCapitalEmployeed",strreturnCapitalEmployeed);
						
						hshJsonValues.put("strreturnEquity",strreturnEquity);
						
						hshJsonValues.put("strsalesWorkCapitalLimit",strsalesWorkCapitalLimit);
						
						hshJsonValues.put("strbusinessCreditDeviationFresh",strbusinessCreditDeviationFresh);
						
						hshJsonValues.put("strbusinessDebitDeviationFresh",strbusinessDebitDeviationFresh);
						
						hshJsonValues.put("strchequeReturnLast9Month",strchequeReturnLast9Month);
						
						hshJsonValues.put("strvariationcreditCountt6Month",strvariationcreditCountt6Month);
						
						hshJsonValues.put("strcredtDebitRatio6Months",strcredtDebitRatio6Months);
						
						hshJsonValues.put("strbusinessCreditDeviationRenewal",strbusinessCreditDeviationRenewal);
						
						hshJsonValues.put("strbusinessDebitDeviationRenewal",strbusinessDebitDeviationRenewal);
						
						hshJsonValues.put("strchequeReturnLast12Month",strchequeReturnLast12Month);
						
						hshJsonValues.put("strvariationCreditMonthly",strvariationCreditMonthly);
						
						hshJsonValues.put("strvariationDebitMonthly",strvariationDebitMonthly);
						
						hshJsonValues.put("strdaysOverutilisation6Months",strdaysOverutilisation6Months);
						
						hshJsonValues.put("strCommercialScoreCardSummary",strCommercialScoreCardSummary);
//						
						hshJsonValues.put("strConsumerScorecardSummary",strConsumerScorecardSummary);
						
						hshJsonValues.put("strbankODScoreCardSummary",strbankODScoreCardSummary);
						
						hshJsonValues.put("strfinancialScoreSummary",strfinancialScoreSummary);
						
						hshJsonValues.put("strdemogScoreCardSummary",strdemogScoreCardSummary);
						
						hshJsonValues.put("appNo",strAppno);
						hshJsonValues.put("strUtilisationODLimit",strUtilisationODLimit);
						
						hshValues = (HashMap) EJBInvoker.executeStateLess("MsmeDigitalAppInterface",hshJsonValues,"CAMService");
								

			}
			
			catch (Exception e)
			{
				response.setData(responseData);
				response.setResp_code("LAPS-2009");
				response.setResp_msg("Invalid request parameters");
				jsonAsString = objectMapper.writeValueAsString(response);
				e.printStackTrace();
				throw new EJBException("Error in CAMService ..."+e.toString());
			}
			return jsonAsString;
		}
		public String msmeFinacialDigiRatingCreation(FinancialDigiRating financialDigiRating) throws JsonProcessingException 
		{
			Map<String,Object> responseData = new HashMap<String,Object>();
			Response response = new Response();
			String jsonAsString = "";
			JSONObject objOuter        = new JSONObject();
			JSONObject PrintObject     = new JSONObject();
			HashMap hshValues 		   = new HashMap();
			Map<String,Object> responseDataMap = null;
			ArrayList arrValues = new ArrayList();
			int jsonPLValueLen=0,jsonLValueLen=0,jsonAValueLen=0;
		
			String 	strLapsProposalNumber="",strfindigitype="",strfindigiyear="",strcommercialBureauScore="",strconsumerIndScore="",strconsumerPartyScore="",
			strodAccountScore="",strcurrentAccountScore="",strfsaScore="",strbandRating="",strbandPath=""
				,strkbRating="",strCbsId="",strFinanceId="",strUserId="",strCMAMastId="",strFinComments="",strFinAppHolder="",strFinAppname="",strorgscode="",strFinPartyFile=""
					,strFinProcessedOn="",strFinProcessBy="",strFinStatus="";
			try
			{
				JSONObject jsonratReqObj= new JSONObject(financialDigiRating);
				
				if (!jsonratReqObj.isNull("lapsProposalNumber"))
					strLapsProposalNumber    = Helper.correctNull(jsonratReqObj.getString("lapsProposalNumber"));
				
				if (!jsonratReqObj.isNull("commercialBureauScore"))
					strcommercialBureauScore    = jsonratReqObj.getString("commercialBureauScore");
				
				if (!jsonratReqObj.isNull("consumerIndScore"))
					strconsumerIndScore    = jsonratReqObj.getString("consumerIndScore");
				
				if (!jsonratReqObj.isNull("consumerPartyScore"))
					strconsumerPartyScore   = jsonratReqObj.getString("consumerPartyScore");
				
				if (!jsonratReqObj.isNull("odAccountScore"))
					strodAccountScore   = jsonratReqObj.getString("odAccountScore");
				
				if (!jsonratReqObj.isNull("currentAccountScore"))
					strcurrentAccountScore   = jsonratReqObj.getString("currentAccountScore");
				
				if (!jsonratReqObj.isNull("fsaScore"))
					strfsaScore    = jsonratReqObj.getString("fsaScore");
				
				if (!jsonratReqObj.isNull("bandRating"))
					strbandRating    = jsonratReqObj.getString("bandRating");
				
				if (!jsonratReqObj.isNull("bandPath"))
					strbandPath    = jsonratReqObj.getString("bandPath");
				
				if (!jsonratReqObj.isNull("kbRating"))
					strkbRating    = jsonratReqObj.getString("kbRating");
				
				if (!jsonratReqObj.isNull("findigitype"))
					strfindigitype    = jsonratReqObj.getString("findigitype");
				
				if (!jsonratReqObj.isNull("findigiyear"))
					strfindigiyear    = jsonratReqObj.getString("findigiyear");
				
				

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
						
						if (!jsonratReqObj.isNull("lapsCBSid"))
							strCbsId    = Helper.correctNull(jsonratReqObj.getString("lapsCBSid"));
						
						
						if (!jsonratReqObj.isNull("lapsFinanceId"))
							strFinanceId    = Helper.correctNull(jsonratReqObj.getString("lapsFinanceId"));
						
						if (!jsonratReqObj.isNull("lapsUserId"))
							strUserId    = Helper.correctNull(jsonratReqObj.getString("lapsUserId"));
						
						if (!jsonratReqObj.isNull("lapsCMAmastId"))
							strCMAMastId    = Helper.correctNull(jsonratReqObj.getString("lapsCMAmastId"));
						
						if (!jsonratReqObj.isNull("finComments"))
							strFinComments    = Helper.correctNull(jsonratReqObj.getString("finComments"));
						
						if (!jsonratReqObj.isNull("finAppHOlder"))
							strFinAppHolder    = Helper.correctNull(jsonratReqObj.getString("finAppHOlder"));
						
						if (!jsonratReqObj.isNull("finAppName"))
							strFinAppname    = Helper.correctNull(jsonratReqObj.getString("finAppName"));
						
						if (!jsonratReqObj.isNull("orgScode"))
							strorgscode    = Helper.correctNull(jsonratReqObj.getString("orgScode"));
						
						if (!jsonratReqObj.isNull("finPartyFile"))
							 strFinPartyFile   = Helper.correctNull(jsonratReqObj.getString("finPartyFile"));
						
						if (!jsonratReqObj.isNull("finProcessedBy"))
							strFinProcessBy    = Helper.correctNull(jsonratReqObj.getString("finProcessedBy"));
						
						if (!jsonratReqObj.isNull("finProcessedOn"))
							strFinProcessedOn    = Helper.correctNull(jsonratReqObj.getString("finProcessedOn"));
						
						if (!jsonratReqObj.isNull("finStatus"))
							strFinStatus    = Helper.correctNull(jsonratReqObj.getString("finStatus"));
						
						if(strCbsId.equals("") || strLapsProposalNumber.equals("") || strFinanceId.equals(""))
						{
							return Constants.ERROR_RESPONSE_MANDATORY;
						}
						
						HashMap hshJsonValues = new HashMap();
						hshJsonValues.put("strLapsProposalNumber",strLapsProposalNumber);
						hshJsonValues.put("strcommercialBureauScore",strcommercialBureauScore);
						hshJsonValues.put("strconsumerIndScore",strconsumerIndScore);
						hshJsonValues.put("strconsumerPartyScore",strconsumerPartyScore);
						hshJsonValues.put("strodAccountScore",strodAccountScore);
						hshJsonValues.put("strcurrentAccountScore",strcurrentAccountScore);
						hshJsonValues.put("strfsaScore",strfsaScore);
						hshJsonValues.put("strbandRating",strbandRating);
						hshJsonValues.put("strbandPath",strbandPath);
						hshJsonValues.put("strkbRating",strkbRating);
						hshJsonValues.put("strfindigitype",strfindigitype);
						hshJsonValues.put("strfindigiyear",strfindigiyear);
						hshJsonValues.put("strCbsId",strCbsId);
						hshJsonValues.put("strFinanceId",strFinanceId);
						hshJsonValues.put("strUserId",strUserId);
						hshJsonValues.put("strCMAMastId",strCMAMastId);
						hshJsonValues.put("strFinComments",strFinComments);
						hshJsonValues.put("strFinAppHolder",strFinAppHolder);
						hshJsonValues.put("strFinAppname",strFinAppname);
						hshJsonValues.put("strorgscode",strorgscode);
						hshJsonValues.put("strFinPartyFile",strFinPartyFile);
						hshJsonValues.put("strFinProcessedOn",strFinProcessedOn);
						hshJsonValues.put("strFinProcessBy",strFinProcessBy);
						hshJsonValues.put("strFinStatus",strFinStatus);

						
						boolean larcheck=true;
						
						ResultSet rs=null;
						String fin_ratappno="",strQuery="",strRefNo="",strResponseCode="",strResponseMsg="";
						strQuery=SQLParser.getSqlQuery("sel_digifinappno^"+strLapsProposalNumber);
						rs=DBUtils.executeQuery(strQuery);	
						if(rs.next())
						{
							fin_ratappno=Helper.correctNull((String)rs.getString("fin_ratappno"));
							larcheck=false;
						}
						
						if(larcheck==true)
						{
							hshValues = (HashMap) EJBInvoker.executeStateLess("MsmeDigitalAppInterface",hshJsonValues,"financialdigiratingCreation");
							strResponseCode=Helper.correctNull((String)hshValues.get("strResponseCode"));
							strResponseMsg=Helper.correctNull((String)hshValues.get("strResponseMsg"));
						}
						else
						{
							strRefNo=strLapsProposalNumber;
							strResponseCode="LAPS-2013";
							strResponseMsg="Financial is already created for the given Digi application number";
						}
						
						
						if(!strRefNo.equals("")){
						responseData.put("FINANCEIAL NUMBER", strRefNo);
						}
						response.setData(responseData);
						response.setResp_code(strResponseCode);
						response.setResp_msg(strResponseMsg);
						
						jsonAsString = objectMapper.writeValueAsString(response);
			}
			
			catch (Exception e)
			{
				response.setData(responseData);
				response.setResp_code("LAPS-2013");
				response.setResp_msg("Invalid request parameters");
				jsonAsString = objectMapper.writeValueAsString(response);
				e.printStackTrace();
				throw new EJBException("Error in msmeServiceServiceImpl msmeFinacialDigiRatingCreation... "+e.toString());
			}
			return jsonAsString;	
		}

public String basicInfoffromLaps(BasicInformationCust basicInformationCust) throws JsonProcessingException 
		{

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
			String strResponseMsg="",strResponseCode="",strCustomerID="",strProposalID="",strFacilityID="";
			
			try
			{
				
				JSONObject jsonCIFReqObj		= new JSONObject(basicInformationCust);
				
				if (!jsonCIFReqObj.isNull("customerID"))
					strCustomerID  = jsonCIFReqObj.getString("customerID");
				
				if (!jsonCIFReqObj.isNull("proposalID"))
					strProposalID  = jsonCIFReqObj.getString("proposalID");
				
				if (!jsonCIFReqObj.isNull("facilityID"))
					strFacilityID  = jsonCIFReqObj.getString("facilityID");
				
				if(strCustomerID.equals(""))
					{
						return Constants.ERROR_RESPONSE_MANDATORY;
					}
				

				HashMap hshJson = new HashMap();
				HashMap hshJsonValues = new HashMap();
				hshJsonValues.put("strCustomerID",strCustomerID);
				hshJsonValues.put("strProposalID",strProposalID);
				hshJsonValues.put("strFacilityID",strFacilityID);
				hshJsonValues.put("strFlag","LAPS");
		
				hshValues1 = (HashMap) EJBInvoker.executeStateLess("MsmeDigitalAppInterface",hshJsonValues,"basicInformationCustomer");
				
				responseData.put("AssociateConcerns", hshValues1.get("AssociateConcerns"));
				responseData.put("EnterpriseInformation", hshValues1.get("EnterpriseInformation"));
				responseData.put("IndividualInformation", hshValues1.get("IndividualInformation"));
				responseData.put("ExistingFacilities", hshValues1.get("ExistingFacilities"));
				strResponseCode="LAPS-3020";
				strResponseMsg="Laps Basic Information Fetch service Completed Successfully";
				
				response.setData(responseData);
				response.setResp_code(strResponseCode);
				response.setResp_msg(strResponseMsg);
				jsonAsString = objectMapper.writeValueAsString(response);
			}
			catch (Exception e)
			{
				response.setData(responseData);
				response.setResp_code("LAPS-2121");
				response.setResp_msg("Invalid request parameters");
				jsonAsString = objectMapper.writeValueAsString(response);
				e.printStackTrace();
				throw new EJBException("Exception in basicInfoffromLaps ==="+e.getMessage());
			}
			return jsonAsString;	
		
		}		

}

