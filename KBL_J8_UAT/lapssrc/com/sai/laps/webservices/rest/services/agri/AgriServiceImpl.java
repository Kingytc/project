package com.sai.laps.webservices.rest.services.agri;

import java.sql.ResultSet;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
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
import com.sai.laps.webservices.rest.domain.Response;
import com.sai.laps.webservices.rest.domain.agri.AgriLarService;
import com.sai.laps.webservices.rest.domain.msme.FacilityProposal;

import com.sai.laps.webservices.rest.domain.agri.AgriFacilityProposal;



public class AgriServiceImpl implements AgriService {
	
	private static final Exception JsonProcessingException = null;
	ObjectMapper objectMapper = new ObjectMapper();

	static Logger log = Logger.getLogger(AgriServiceImpl.class);
	
	public String AgriLarService(AgriLarService AgriLarService)throws JsonProcessingException {
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
			
			JSONObject jsonCIFReqObj		= new JSONObject(AgriLarService);
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
				hshValues = (HashMap) EJBInvoker.executeStateLess("AgriDigitalAppInterface",hshJsonValues,"UpdateAgriLarService");  
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
			throw new EJBException("Exception in AgriLarCreation ==="+e.getMessage());
		}
		return jsonAsString;	
		
	}
	
	//AGRICULTURE PROPOSAL CREATION
	
public String AgriFacilityProposal(AgriFacilityProposal AgriFacilityProposal) throws JsonProcessingException{
	
Map<String,Object> responseData = new HashMap<String,Object>();
	
	String jsonAsString = "";
	JSONObject objOuter        = new JSONObject();
	JSONObject PrintObject     = new JSONObject();
	HashMap hshValues 		   = new HashMap();
	Map<String,Object> responseDataMap = null;
	Response response = new Response();
	ArrayList arrValues = new ArrayList();
	HashMap hshValues1=new HashMap();
	
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
			
	try {

		JSONObject jsonCIFReqObj		= new JSONObject(AgriFacilityProposal);

	
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
				//arrApplicantvalue.add(objapplicant.getString("fName"));
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
		
		
		
		
		
		
		// Mandatory Check
	
//		if( strlarNo.equals("") || strtype.equals("") || strtenor.equals("") || strproposedBankArrngmnt.equals("") ||
//				strpaymentMode.equals("") || strperiodInstallment.equals("") || strgovtSponserScheme.equals("") || strproopsedLimit.equals("") || strsinglePremium.equals("") || strinterestSubType.equals("")
//				|| strrepaymentType.equals("") || strinterestRate.equals("") || strprocessNoteDesc.equals("") || strlapsCustomerId.equals("") || strinterestType.equals("")) 
//		{
//			return Constants.ERROR_RESPONSE_MANDATORY;
//		}
		
		
		
		if( strlarNo.equals("") || strlapsCustomerId.equals(""))
		{
			return Constants.ERROR_RESPONSE_MANDATORY;
		}
		
		
		// BussinessOperation
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
		
		// OdccLimits
		
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
//		hshJsonValues.put("strtype",strtype);
//		hshJsonValues.put("stradhocType",stradhocType);
//		hshJsonValues.put("strfacilityOfAdhoc",strfacilityOfAdhoc);
//		hshJsonValues.put("strinterestType",strinterestType);
//		hshJsonValues.put("strtenor",strtenor);
//		hshJsonValues.put("strproposedBankArrngmnt",strproposedBankArrngmnt);
//		hshJsonValues.put("strpaymentMode",strpaymentMode);
//		hshJsonValues.put("strperiodInstallment",strperiodInstallment);
//		hshJsonValues.put("strmargin",strmargin);
//		hshJsonValues.put("strdueDate",strdueDate);
//		hshJsonValues.put("strirregularities",strirregularities);
//		hshJsonValues.put("strgovtSponserScheme",strgovtSponserScheme);
//		hshJsonValues.put("strproopsedLimit",strproopsedLimit);
//		hshJsonValues.put("strsinglePremium",strsinglePremium);
//		hshJsonValues.put("strinterestSubType",strinterestSubType);
//		hshJsonValues.put("strinitialHoliday",strinitialHoliday);
//		hshJsonValues.put("strrepaymentType",strrepaymentType);
//		hshJsonValues.put("strinterestRate",strinterestRate);
//		hshJsonValues.put("strpuropse",strpuropse);
//		hshJsonValues.put("strborrowerFreshLimit",strborrowerFreshLimit);
//		hshJsonValues.put("strprocessNoteDesc",strprocessNoteDesc);
//		hshJsonValues.put("strdetailsAsOn",strdetailsAsOn);
		hshJsonValues.put("strcbsId",strcbsId);
		hshJsonValues.put("strlapsCustomerId",strlapsCustomerId);
		hshJsonValues.put("strapplicationBranch",strapplicationBranch);
		hshJsonValues.put("FacilityDescription",strFacilityDescription);
//		hshJsonValues.put("stroperativeAccNumber",stroperativeAccNumber);
		
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
//		strBirRequired="", strSubmissionDate="", strReceiptDate="", strBirCharges="",  strBirReportDate="";
		hshJsonValues.put("strBirRequired",strBirRequired);
		hshJsonValues.put("strSubmissionDate",strSubmissionDate);
		hshJsonValues.put("strReceiptDate",strReceiptDate);
		hshJsonValues.put("strBirCharges",strBirCharges);
		hshJsonValues.put("strBirReportDate",strBirReportDate);
//		hshJsonValues.put("strInsuranceAmntFundedBy",strInsuranceAmntFundedBy);
//		hshJsonValues.put("strInsuranceAmount",strInsuranceAmount);
//		hshJsonValues.put("strPremiumTenor",strPremiumTenor);
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
		
		
		boolean proposalcheck=true,proposallimitcheck=true;
		
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

		hshValues1 = (HashMap) EJBInvoker.executeStateLess("AgriDigitalAppInterface",hshJsonValues,"AgriProposalCreation");	
		responseData.put("lapsProposalNumber", Helper.correctNull((String)hshValues1.get("appno")));
		strResponseCode="LAPS-3011";
		strResponseMsg="LAPS Application Created Successfully";
		
		}
		
		response.setData(responseData);
		response.setResp_code(strResponseCode);
		response.setResp_msg(strResponseMsg);
		
		jsonAsString = objectMapper.writeValueAsString(response);
		
	
		
	} catch (Exception e) {
		response.setData(responseData);
		response.setResp_code("LAPS-2003");
		response.setResp_msg("Invalid request parameters");
		jsonAsString = objectMapper.writeValueAsString(response);
		e.printStackTrace();
		throw new EJBException("Error in Agri ServiceServiceImpl Agri FacilityProposal..."+e.toString());
	}
	return jsonAsString;
	
}

}	


