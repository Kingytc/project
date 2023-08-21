<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	String strStatus = "",strcbsaccno="";
	HashMap hshTemp = new HashMap();
	if (objValues != null && objValues instanceof HashMap) {
		hshTemp = (HashMap) objValues;
		strStatus = Helper.correctNull((String) hshTemp.get("status"));
	}
	ArrayList arrFlowpoint = (ArrayList) hshValues.get("arrFlowpoint");
	ArrayList arrAction = (ArrayList) hshValues.get("arrAction");
	ArrayList arrMaxclass = (ArrayList) hshValues.get("arrMaxclass");
	String strPgDist = Helper.correctNull(request.getParameter("hiPgDist"));
	String strApprovClass = Helper.correctDouble((String) hshValues.get("prd_approval"));
	String strshg_tallied = Helper.correctNull((String) hshValues.get("app_shg_tallied"));
	String strfac_not_tally = Helper.correctNull((String) hshValues.get("fac_not_tally"));
	String strPrdType = Helper.correctNull((String) session.getAttribute("strProductType"));
	String sanction = Helper.correctNull((String) hshValues.get("sanc_amt"));
	String legalcomp = Helper.correctNull((String) hshValues.get("app_legalcomp"));
	String strProposalType = Helper.correctNull((String)session.getAttribute("strAppType"));
	String strstockaudit = Helper.correctNull((String) hshValues.get("app_stockaudit"));
	String COM_BANKSCHEME=Helper.correctNull((String) hshValues.get("COM_BANKSCHEME"));
	String strceditaudit = Helper.correctNull((String)session.getAttribute("app_creditaudit"));
	if (strApprovClass.trim().equals("")) {
		strApprovClass = "0";
	}
	String StrDigiLoanType=Helper.correctNull((String)session.getAttribute("StrDigiLoanType"));
	String strSkipClass = Helper.correctDouble((String) hshValues.get("prd_skip"));
	if (strSkipClass.trim().equals("")) {
		strSkipClass = "0";
	}
	String strUsrClass = Helper.correctNull((String) strUserClass);
	if (strUsrClass.trim().equals("")) {
		strUsrClass = "0"; 
	}
	String strCurFP = Helper.correctNull((String) hshValues.get("strCurrFlowPoint"));
	if (strCurFP.trim().equals("")) {
		strCurFP = "0";	}
	String strWorkflow = Helper.correctNull((String) hshValues.get("workflow"));
	if (strWorkflow.trim().equals("")) {
		strWorkflow = Helper.correctNull((String) session.getAttribute("workflow"));
	}
	String prdcode=Helper.correctNull((String) request.getParameter("prdcode"));
	if(prdcode.equalsIgnoreCase(""))
		prdcode=Helper.correctNull((String) hshValues.get("prdcode"));
	String strPrdtype = Helper.correctNull((String) hshValues.get("prdtype"));
	String strBorrowerType = Helper.correctNull((String) request.getParameter("hidBorrowerType"));
	String loantype = "";
	String loan_type = Helper.correctNull((String) hshValues.get("app_loantype"));
	String strSessionModuleType=Helper.correctNull((String) request.getParameter("hidCategoryType"));
	if(strSessionModuleType.equalsIgnoreCase(""))
		strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	session.setAttribute("sessionModuleType",strSessionModuleType);
	//out.println(hshValues);
	if (loan_type.equalsIgnoreCase("P")) {
		loantype = "Retail";
	}
	if (loan_type.equalsIgnoreCase("A")) {
		loantype = "Agriculture";
	}

	if (loan_type.equalsIgnoreCase("c")) {
		loantype = "Corporate";
	}
	if (loan_type.equalsIgnoreCase("T")) {
		loantype = "Tertiary";
	}
	if (loan_type.equalsIgnoreCase("E")) {
		loantype = "Short Review/Extension";
	}
	ArrayList arrSentFAcility = (ArrayList) hshValues.get("arrSentFAcility");
	int arrsize=0;
	if(arrSentFAcility !=null)
	{
		arrsize=arrSentFAcility.size();
	}
	String strSentfacility="";
	String strClosedfacility=Helper.correctNull((String)hshValues.get("strClosedFac"));
	for(int i=0;i<arrsize;i++)
	{
		strSentfacility=strSentfacility+"@"+Helper.correctNull((String) arrSentFAcility.get(i));
	}
	int facilitycount=Integer.parseInt(Helper.correctInt((String)hshValues.get("sentfacilitycount")));
	String Ratingflag=Helper.correctNull((String)hshValues.get("prd_ratingflag"));
	if(Ratingflag.equalsIgnoreCase(""))
	{
		Ratingflag="N";
	}
	String app_category=Helper.correctNull((String)hshValues.get("apprenewflag"));
	String Staffproduct=Helper.correctNull((String) hshValues.get("staffproduct")).toUpperCase();
	if(Staffproduct.equalsIgnoreCase("")){
		Staffproduct="N";
	}
	String strRatingTabHideCorpAgr=Helper.correctNull((String)session.getAttribute("strRatingTabHide")).trim();
	String Deligated_power=Helper.correctNull((String)hshValues.get("Del_Authority")).trim();
	if(Deligated_power.equalsIgnoreCase(""))
	{
		Deligated_power="N";
	}
	String strAgrSchemeType="";
	strAgrSchemeType=Helper.correctNull((String)hshValues.get("agrKCCFlag")).trim();
	String strPrdLoanType=Helper.correctNull((String)hshValues.get("strPrdLoanType"));
	char StrLodgingRights='0';
	if(Helper.correctNull((String) session.getAttribute("strGroupRights")).length()>26)
	StrLodgingRights=Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(26);
	boolean strdis=Helper.correctNull((String) session.getAttribute("strGroupRights")).length()>26;
	if(strStatus.equalsIgnoreCase(""))
		strStatus=Helper.correctNull((String)hshValues.get("status"));
	strcbsaccno=Helper.correctNull((String)hshValues.get("CBS_ACCOUNTNO"));
	String strParams=Helper.correctNull((String)session.getAttribute("strModifyterms"));	
	String strGovtscheme=Helper.correctNull((String)session.getAttribute("strGovtscheme"));
	String strGuarantor=Helper.correctNull((String)hshValues.get("strGuarantor"));
	String strGuarantor_corp=Helper.correctNull((String)hshValues.get("strGuarantor_corp"));
	ArrayList arrSchemes=(ArrayList)hshValues.get("arrSchemes");
	ArrayList arrBankRow1=(ArrayList)hshValues.get("arrDoc");
	ArrayList arrRevalidation=(ArrayList)hshValues.get("arrRevalidation");
	String cgtmseval=Helper.correctNull((String)session.getAttribute("PRD_CGTMSE"));
	String strFacSno = Helper.correctNull((String)hshValues.get("strFacilitySno"));
	String prd_purpose=Helper.correctNull((String) session
			.getAttribute("prd_purpose"));
	String PRD_STAFFPRD=Helper.correctNull((String)  session
			.getAttribute("PRD_STAFFPRD"));
	String APP_LOANSUBTYPE_DIGI=Helper.correctNull((String)  session
			.getAttribute("APP_LOANSUBTYPE_DIGI"));

	
	String strLoanSubType=Helper.correctNull((String)hshValues.get("APP_LOANSUBTYPE_DIGI"));
	
	String postSanctionFlag=Helper.correctNull((String)hshValues.get("postSanctionFlag"));
	System.out.println("postSanctionFlag-->"+postSanctionFlag);
	String insertedParamters=Helper.correctNull((String)hshValues.get("insertedParamters"));
	System.out.println("insertedParamters-->"+insertedParamters);
	String STRSECCERSAIREFNO= Helper.correctNull((String)hshValues.get("SEC_CERSAIREFNO"));
	String STRSECSEARCHPERFORMDATE= Helper.correctNull((String)hshValues.get("SEC_SEARCHPERFORM_DATE"));
	String strrestgeclmandatorychk=Helper.correctNull((String)  session.getAttribute("restgeclmandatorychk"));
	
	java.text.NumberFormat nf = java.text.NumberFormat
	.getNumberInstance();
	nf.setGroupingUsed(false);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	String gecl1sno25=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl1sno25"))));
	String gecl1maxamount=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("gecl1maxamount"))));
	
	//out.println(hshValues);
	String proposalStatus = Helper.correctNull((String)session.getAttribute("appstatus"));

	//out.println("arrFlowpoint==="+arrFlowpoint);
	//out.println("arrAction====="+arrAction);
	//out.println("Hashvalues"+hshValues);

	String lodgerightstousercheck = Helper.correctNull((String)hshValues.get("lodgerightstousercheck"));
	
	String strLoan_Sanct_STATUS=Helper.correctNull((String)hshValues.get("Loan_Sanct_STATUS"));
	   
	String Post_Loan_Sanct_ERRORSTATUS=Helper.correctNull((String)hshValues.get("Post_Loan_Sanct_ERRORSTATUS"));

String roiflagval=Helper.correctNull((String)hshValues.get("roiflagval"));

String updroiinfin=Helper.correctNull((String)hshValues.get("updroiinfin"));

%>

<html>
<head>
<title>Work Flow</title>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script>
//var varPageType = "<%=Helper.correctNull((String) session.getAttribute("link"))%>";
var usr_class="";
var usr_func = "";
var usr_dept="";
var appclass=<%=strApprovClass%>;
var skipclass=<%=strSkipClass%>;
var userclass=<%=strUsrClass%>;
var currflowpoint=<%=strCurFP%>;
var varstrFacSno="<%=strFacSno%>";
var strRejectReasonsFlag="0";
var strUserId='<%=(String) session.getAttribute("strUserId")%>';
var appno ="<%=Helper.correctNull((String) hshValues.get("appno"))%>";
var workflow ="<%=strWorkflow.trim()%>";
var varStatus="<%=strStatus%>";
var varapptype="<%=Helper.correctNull((String) hshValues.get("app_loantype"))%>";
var varcbsaccno="<%=Helper.correctNull((String) hshValues.get("CBS_ACCOUNTNO"))%>";
var sanction="<%=sanction%>";
var duediligence="<%=Helper.correctNull((String) hshValues.get("duediligence"))%>";
var creditreport="<%=Helper.correctNull((String) hshValues.get("creditreport"))%>";
var strPrdType="<%=Helper.correctNull((String) hshValues.get("prdtype"))%>";
var strinspection_flag="<%=Helper.correctNull((String) hshValues.get("inspection_flag"))%>";
var PrincipalRatio="<%=Helper.correctNull((String) hshValues.get("PrincipalRatio"))%>";
var InterestRatio="<%=Helper.correctNull((String) hshValues.get("InterestRatio"))%>";
var varStaffProduct="<%=Staffproduct%>";
var vargecl1sno25="<%=gecl1sno25%>";
var vardbgecl1maxamount="<%=gecl1maxamount%>";
var vardeviatedapplication="<%=Helper.correctNull((String) hshValues.get("app_isdeviated"))%>";
//var varCGRating="<%=Helper.correctNull((String) hshValues.get("CGRating"))%>";
//var varCreditrating="<%=Helper.correctNull((String) hshValues.get("Creditrating"))%>";
var vardeviationapproved="<%=Helper.correctNull((String) hshValues.get("deviationapproved"))%>";
var varApproverejectBy="<%=Helper.correctNull((String) hshValues.get("ApproveRejectedby"))%>";
var var_rating_pending="<%=Helper.correctNull((String)hshValues.get("app_rating_pending"))%>";
var score_flag="";
var var_loan_recommended="<%=Helper.correctNull((String) hshValues.get("loanrecommended"))%>";
var var_CPAO="<%=Helper.correctNull((String) hshValues.get("CPAFLAG"))%>";
var varusrfunction="<%=Helper.correctNull((String) hshValues.get("usrfunction"))%>";
var varorghead="<%=Helper.correctNull((String) hshValues.get("orghead"))%>";
var varAppraisalQuest="<%=Helper.correctNull((String) hshValues.get("appraisalQuest"))%>";
var varFACCHECK="<%=Helper.correctNull((String) hshValues.get("FACNOTCHECK"))%>";
var varFACAPPROVECHECK="<%=Helper.correctNull((String) hshValues.get("FACAPPROVECHECK"))%>";
var varcreditflag="<%=Helper.correctNull((String) hshValues.get("creditrating_flag"))%>";
var varcreditvalue="<%=Helper.correctNull((String) hshValues.get("creditrating_value"))%>";
var varcreditgrade="<%=Helper.correctNull((String) hshValues.get("creditrating_grade"))%>";
//var varcreditrating="<%=Helper.correctNull((String) hshValues.get("creditrating"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var vardatavetting="<%=Helper.correctNull((String) hshValues.get("app_vetting"))%>";
//var varCreditRepFlag = "<%=Helper.correctNull((String) hshValues.get("CREDITREPORTFLAG"))%>";
var varSendToCBSFlag = "<%=Helper.correctNull((String) hshValues.get("strSendToCBSFlag"))%>";
var strRemarksFlag="0";
var btnenable="<%=Helper.correctNull((String)request.getParameter("btnenable"))%>";
var varCBSACNoFlg="<%=Helper.correctNull((String)hshValues.get("strCBSACNoFlg"))%>";
var varMISDetails="<%=Helper.correctNull((String)hshValues.get("MISDetails"))%>";
var varCBSDetails="<%=Helper.correctNull((String)hshValues.get("CBSDetails"))%>";
var varCreditFreezFlag="<%=Helper.correctNull((String)hshValues.get("strCreditFreezFlag"))%>";
var varCreditRating="<%=Helper.correctNull((String)hshValues.get("strCreditRating"))%>";
var varSourceMargin="<%=Helper.correctNull((String)hshValues.get("SOUREOFMARGIN"))%>";
var varAmtTotal="<%=Helper.correctDouble((String)hshValues.get("AmtTotal")) %>";
var varPowerTotal="<%=Helper.correctDouble((String)hshValues.get("PowerAmt")) %>";
var varNEcheckflag="<%=Helper.correctNull((String)hshValues.get("strNEcheckflag")) %>";
var varNEFacdesc="<%=Helper.correctDouble((String)hshValues.get("strNEFacdesc")) %>";
var varRNEcheckflag="<%=Helper.correctNull((String)hshValues.get("strRNEcheckflag")) %>";
var  str_strmisaparam="<%=Helper.correctDouble((String)hshValues.get("strmisaparam")) %>";
var  strBrief="<%=Helper.correctDouble((String)hshValues.get("strBrief")) %>";
var  varloangross="<%=Helper.correctDouble((String)hshValues.get("Totloangross")) %>";
var  varleasegross="<%=Helper.correctDouble((String)hshValues.get("Totleasegross")) %>";
var varstrFlowDateFlag="<%=Helper.correctNull((String)hshValues.get("strFlowDateFlag"))%>";
var varEligibilitychkflag="<%=Helper.correctNull((String)hshValues.get("APP_ELIGIBILITYCHK"))%>";
var varTakeoverflag="<%=Helper.correctNull((String)hshValues.get("Takeoverflag"))%>";
var varreqamt="<%=Helper.correctNull((String)hshValues.get("AppAmt"))%>";
var varsanctionamt="<%=Helper.correctDouble((String)hshValues.get("Sanctionamt")) %>";
var strSessionModuleType="<%=strSessionModuleType%>";
var varRatingflag="<%=Ratingflag%>";
var varappcategory="<%=app_category%>";
var varRatingTabHideCorpAgr="<%=strRatingTabHideCorpAgr%>";
var varRmdUserCheckFlag="<%=Helper.correctNull((String)hshValues.get("strRmdUserCheckFlag"))%>";
var deligated_power="<%=Deligated_power%>";
var ratinggroup="<%=Helper.correctNull((String)hshValues.get("ratinggroup"))%>";
var varAgrSchemeType="<%=strAgrSchemeType%>";
var strfinalsendflag="<%=Helper.correctNull((String)hshValues.get("strfinalsendflag"))%>";
var varPrdLoanType="<%=strPrdLoanType%>";
var varSecurityFlag="<%=Helper.correctNull((String)hshValues.get("strSecuirtyFlag"))%>";
var varRatingCheck="<%=Helper.correctNull((String)hshValues.get("strRatingCheck"))%>";
var varNonPoolBasedRating="<%=Helper.correctNull((String)hshValues.get("strNonPoolBasedRating"))%>";
var varLodgingRights="<%=StrLodgingRights%>";
var varIntrAmtFlag="<%=Helper.correctNull((String)hshValues.get("strIntrAmtFlag")) %>";
var varCbsaccno="<%=strcbsaccno%>";
var varPropsalSancType="<%=Helper.correctNull((String)hshValues.get("com_proposalsanctype"))%>";
var varUndoFlag="<%=Helper.correctNull((String)hshValues.get("strUndoFlag"))%>";
var varPrdPurpose="<%=Helper.correctNull((String)hshValues.get("strPrdPurpose"))%>";
var varfinalsanction = "<%=Helper.correctNull((String) hshValues.get("app_finalsanction"))%>";
var varAppLevel = "<%=Helper.correctNull((String) hshValues.get("strAppLevel"))%>";
var varSancRefNum = "<%=Helper.correctNull((String) hshValues.get("strSancRefNum"))%>";
var varBaseRateChkFlag = "<%=Helper.correctNull((String) hshValues.get("strBaseRateFlag"))%>";
var varDocumentReceived = "<%=Helper.correctNull((String) hshValues.get("strDocumentReceived"))%>";
var varAppEmployment = "<%=Helper.correctNull((String) session.getAttribute("perapp_employment"))%>";
var varrepaymenttype = "<%=Helper.correctNull((String)  hshValues.get("repaymenttype"))%>";
var varProposalType="<%=strProposalType%>";

var varshg_tallied="<%=strshg_tallied%>";
var varfac_not_tally="<%=strfac_not_tally%>";
var varInwardchk="<%=Helper.correctNull((String)hshValues.get("strInwardCheck"))%>";
var varMISCODEFlag="<%=Helper.correctNull((String)hshValues.get("strMISCODEFlag"))%>";
var varMISCODEDesc="<%=Helper.correctNull((String)hshValues.get("strMISCODEFlagDesc"))%>";
var varReselectprd="<%=Helper.correctNull((String)hshValues.get("strReselectprd"))%>";
var varReselectprdDesc="<%=Helper.correctNull((String)hshValues.get("strReselectprdDesc"))%>";
var varJewelAppraiser="<%=Helper.correctNull((String)hshValues.get("strJewelAppraiser"))%>";
var varExposureChk="<%=Helper.correctNull((String)hshValues.get("strExposureChk"))%>";
var varBorrowerExp="<%=Helper.correctNull((String)hshValues.get("strBorrowerExp"))%>";
var varTakeover="<%=Helper.correctNull((String)hshValues.get("strTakeOver"))%>";
var varTakeOverDetails="<%=Helper.correctNull((String)hshValues.get("strTakeOverDetails"))%>";
var varDocAttach_Flag="<%=Helper.correctNull((String)hshValues.get("strDocAttach_Flag"))%>";
var varRepayComments="<%=Helper.correctNull((String)hshValues.get("strRepayComments"))%>";
var varAppDocuments="<%=Helper.correctNull((String)hshValues.get("strAppDocuments"))%>";
var varBIRFlag="<%=Helper.correctNull((String)hshValues.get("strBIRFlag"))%>";
//var varCFRdev_Classpow="<%//=Helper.correctNull((String)hshValues.get("strCFRdevPower"))%>";
var varCFRverified="<%=Helper.correctNull((String)hshValues.get("strCFR_VERIFIED"))%>";
var varCFRborname="<%=Helper.correctNull((String)hshValues.get("strCFR_BORNAME"))%>";
var varCFRAppjStatus="<%=Helper.correctNull((String)hshValues.get("strSTATUS_VERIFIED"))%>";
var varUpdSecFlag="<%=Helper.correctNull((String)hshValues.get("strUpdSecFlag"))%>";
var varUnapprovedSecFlag="<%=Helper.correctNull((String)hshValues.get("strUnapprovedSecFlag"))%>";
var varShareExceeds="<%=Helper.correctNull((String)hshValues.get("strShareExceeds"))%>";
var varPhyLimitExceeds="<%=Helper.correctNull((String)hshValues.get("strPhyLimitExceeds"))%>";
var varDematLimitExceeds="<%=Helper.correctNull((String)hshValues.get("strDematLimitExceeds"))%>";
var varCGTMSEFlag="<%=Helper.correctNull((String)hshValues.get("strCGTMSEFlag"))%>";
var varPRD_CGTMSE="<%=Helper.correctNull((String)session.getAttribute("PRD_CGTMSE"))%>";
var varMSME="<%=Helper.correctNull((String)hshValues.get("strMSMEFacility"))%>";
var varMSMEFacility="<%=Helper.correctNull((String)hshValues.get("ChkMSMEFacility"))%>";
var varPmayhouse="<%=Helper.correctNull((String)hshValues.get("PMAY_HOUSE_CAT"))%>";
var varPMAYValidFrom="<%=Helper.correctInt((String)hshValues.get("strValidFrom"))%>";
var varPMAYValidTo="<%=Helper.correctInt((String)hshValues.get("strValidTo"))%>";
var varPMAY="<%=Helper.correctInt((String)hshValues.get("strPMAY"))%>";
var varCGTMSEtotintrate="<%=Helper.correctNull((String)hshValues.get("strCGTMSEtotintrate"))%>";
var varparamval_CGTMSEint="<%=Helper.correctNull((String)hshValues.get("paramval_CGTMSEint"))%>";
var varCGTMSEcovLimit="<%=Helper.correctNull((String)hshValues.get("strCGTMSEcovLimit"))%>";
var varmaxcgtmseLimit="<%=Helper.correctNull((String)hshValues.get("strmaxcgtmseLimit"))%>";
var varOwnedHouse="<%=Helper.correctNull((String)hshValues.get("strOwnedHouse"))%>";
var varFemaleownerReq="<%=Helper.correctNull((String)hshValues.get("strFemaleownerReq"))%>";
var varFemaleownerAvail="<%=Helper.correctNull((String)hshValues.get("strFemaleownerAvail"))%>";
var varCarpetAreaReq="<%=Helper.correctNull((String)hshValues.get("strCarpetAreaReq"))%>";
var varCarpetAreaAvail="<%=Helper.correctNull((String)hshValues.get("strCarpetAreaAvail"))%>";
var varTenorAvail="<%=Helper.correctNull((String)hshValues.get("strTenorAvail"))%>";
var varTenorReq="<%=Helper.correctNull((String)hshValues.get("strTenorReq"))%>";
var varGovtscheme="<%=Helper.correctNull((String)hshValues.get("strGovtscheme"))%>";
var varsanction_amount="<%=Double.parseDouble(Helper.correctDouble((String)hshValues.get("sanction_amount")))%>";
var varCGPan="<%=Helper.correctNull((String)hshValues.get("CGPan")).toUpperCase()%>";
var varGuarantor_check="<%=strGuarantor%>";
var varGuarantor_corp="<%=strGuarantor_corp%>";
var varprdbankscheme="<%=Helper.correctNull((String)hshValues.get("strprdbankscheme"))%>";
var varLARbankscheme="<%=Helper.correctNull((String)hshValues.get("strLARbankscheme"))%>";
var varApp_Org_level="<%=Helper.correctNull((String)hshValues.get("strBoolFlag"))%>";
var varQueryStatus="<%=Helper.correctNull((String)hshValues.get("Query_Status"))%>";
var varDigiLoanType="<%=Helper.correctNull((String)hshValues.get("APP_LOANSUBTYPE_DIGI"))%>";
var varTermflag="<%=Helper.correctNull((String)hshValues.get("app_termflag"))%>";
var varLeadstatus="<%=Helper.correctNull((String)hshValues.get("strLeadStatus"))%>";
var varRevalidationFlag="<%=Helper.correctNull((String)hshValues.get("strRevalidationFlag"))%>";
var var_AadharNo="<%=Helper.correctNull((String)hshValues.get("PERAPP_UDYOG_AADHAR"))%>";
var varCGLimit="<%=Helper.correctNull((String)hshValues.get("dblCGTMSELimit"))%>";
var varCropCGTMSE="<%=Helper.correctNull((String)hshValues.get("strCGTMSEAvail"))%>";
var NatureofActivity="<%=Helper.correctNull((String)hshValues.get("kyc_activity"))%>";

var loan_ROIscore="<%=Helper.correctNull((String) hshValues.get("LOAN_ROISCORE"))%>";
var loan_roiType="<%=Helper.correctNull((String) hshValues.get("LOAN_ROITYPE"))%>";
var varscoreVal="<%=Helper.correctNull((String) hshValues.get("LOAN_SetupScore"))%>";
var varDeviationcnt="<%=Helper.correctInt((String) hshValues.get("intDeviationCnt"))%>";
var varBorrExp="<%=Helper.correctInt((String) hshValues.get("strBorrExp"))%>";
var varBureauchk="<%=Helper.correctInt((String) hshValues.get("strCIBILChk"))%>";
var strStandupCheck="<%=Helper.correctNull((String) hshValues.get("strStandupCheck"))%>";
var varDrawDownFlag="<%=Helper.correctNull((String) hshValues.get("strDrawDownFlag"))%>";
var varFacAdhocDet="<%=Helper.correctNull((String) hshValues.get("strFacAdhocDet"))%>";
var varPostSancBranch="<%=Helper.correctNull((String) hshValues.get("strPostSancBranch"))%>";
var varUsrOrgLevel="<%=Helper.correctNull((String)session.getAttribute("strOrgLevel"))%>";

var vargeclavailable="<%=Helper.correctNull((String) hshValues.get("strgeclavailable"))%>";
var varGECLChk="<%=Helper.correctNull((String) hshValues.get("strGECLChk"))%>";
var varGECLFor="<%=Helper.correctNull((String) hshValues.get("strGECLFor"))%>";
var varConstitution="<%=Helper.correctNull((String) hshValues.get("strConstitution"))%>";
var varMMithra="<%=Helper.correctNull((String) hshValues.get("strMMithraChk"))%>";
var strAmount="<%=Helper.correctDouble((String) hshValues.get("strAmount7"))%>";
var strMithraFacTot="<%=Helper.correctDouble((String) hshValues.get("strMithraFacTot"))%>";
var strFIDPNDet="<%=Helper.correctNull((String) hshValues.get("strFIDPNDet"))%>";
var strFIDPNChk="<%=Helper.correctNull((String) hshValues.get("strFIDPNChk"))%>";
var strudyogadhorChk="<%=Helper.correctNull((String) hshValues.get("PERAPP_UDYOG_AADHAR1"))%>";
var strCGTMSEtotintrate1="<%=Helper.correctNull((String) hshValues.get("strCGTMSEtotintrate1"))%>";
var varSvanidhi="<%=Helper.correctNull((String) hshValues.get("strSvanidhi"))%>";
var strSvanidhiTerm="<%=Helper.correctNull((String) hshValues.get("strSvanidhiTerm"))%>";
var varPerCbsId="<%=Helper.correctNull((String) hshValues.get("perCbsId"))%>";


var varFacDesc="<%=Helper.correctNull((String) hshValues.get("strFacName"))%>";
var varcgssdfacdesc="<%=Helper.correctNull((String) hshValues.get("strcgssdFacDesc"))%>";
var varAppraisedFlag="<%=Helper.correctNull((String) hshValues.get("strAppraisedFlag"))%>";
var varSanctionFlag="<%=Helper.correctNull((String) hshValues.get("strSanctionFlag"))%>";
var varVERICHKBOXVALUE="<%=Helper.correctNull((String)hshValues.get("VERI_CHKBOX_VALUE"))%>";
var varVERICHKBOXCOAPPVALUE="<%=Helper.correctNull((String)hshValues.get("VERI_CHKBOX_VALUE_COAPP"))%>";
var varcgssdfacdesc1="<%=Helper.correctNull((String)hshValues.get("strcgssdFacDesc1"))%>";
var varcgssdfacdesc2="<%=Helper.correctNull((String)hshValues.get("strcgssdFacDesc2"))%>";
var varstockaudit="<%=Helper.correctNull((String)hshValues.get("app_stockaudit"))%>";
var varcreditaudit="<%=Helper.correctNull((String)hshValues.get("app_creditaudit"))%>";
var varcbsstatus="<%=Helper.correctNull((String)hshValues.get("ctrcustflag"))%>";
var varRmdUsr="<%=Helper.correctNull((String)hshValues.get("usr_rmdflag"))%>";
var varStagewiseFlag="<%=Helper.correctNull((String)hshValues.get("strStagewiseFlag"))%>";
var insertedParamters="<%=insertedParamters%>"; 
var postSanctionFlag="<%=postSanctionFlag%>";
var varCReditRisk="<%=Helper.correctNull((String)hshValues.get("strCReditRisk")) %>";
var varstakovernorms="<%=Helper.correctNull((String) hshValues.get("strtakeovernorm"))%>";
var vargeclnewchk="<%=Helper.correctNull((String) hshValues.get("strgeclnewchk"))%>";

var varmsmefalg="<%=Helper.correctNull((String) hshValues.get("strmsmeflag"))%>";
var varmsmepanno="<%=Helper.correctNull((String) hshValues.get("perapp_panno"))%>";
var varGSTReg="<%=Helper.correctNull((String) hshValues.get("COMINFO_GSTINREG"))%>";
var varGSTExempted="<%=Helper.correctNull((String) hshValues.get("COMINFO_GST_EXEMPTED"))%>";
var varmsmecertificationdate="<%=Helper.correctNull((String) hshValues.get("PERAPP_CERTIFICATION_DATE"))%>";
var varmsmeclassification="<%=Helper.correctNull((String) hshValues.get("PERAPP_MSME_CLASSIFICATION"))%>";
var varmsmeudyamregno="<%=Helper.correctNull((String) hshValues.get("PERAPP_UDYAM_REGNO"))%>";
var varGECLAssChk="<%=Helper.correctNull((String) hshValues.get("strGECLAssCheck"))%>";
var varmsmepostsancdate="<%=Helper.correctNull((String) hshValues.get("strmsmedate"))%>";
var VARSECCERSAIREFNO= "<%=STRSECCERSAIREFNO%>";
var VARSECSEARCHPERFORMDATE= "<%=STRSECSEARCHPERFORMDATE%>";	
var vargoldloantotsanction_amount="<%=Double.parseDouble(Helper.correctDouble((String)hshValues.get("dblsumgoldloan")))%>";
var vardepositloantotsanction_amount="<%=Double.parseDouble(Helper.correctDouble((String)hshValues.get("dbldepositloan")))%>";
var varsancPowerTotal="<%=Double.parseDouble(Helper.correctDouble((String)hshValues.get("sancPowerAmt"))) %>";
var vardepmetdatechk="<%=Helper.correctNull((String) hshValues.get("depositmaturitydate"))%>";
var vardepostaccno="<%=Helper.correctNull((String) hshValues.get("strdepositaccno"))%>";
var varRoiUpdate="<%=Helper.correctNull((String)hshValues.get("RoiUpdate"))%>";
var varRoiFlag="<%=Helper.correctNull((String)hshValues.get("RoiFlag"))%>";
var varRestructureInvoDate="<%=Helper.correctNull((String)hshValues.get("strRestructureInvoDate"))%>";
var VarSECALREADYMORTG="<%=Helper.correctNull((String)hshValues.get("SEC_ALREADY_MORTG"))%>";
var Varseccroptype="<%=Helper.correctNull((String)hshValues.get("sec_croptype"))%>";
var varbankingarrangemnet="<%=Helper.correctNull((String)hshValues.get("bankingarrangement"))%>";
var varsolechk="<%=Helper.correctNull((String)hshValues.get("strsolechk"))%>";
var varwcmandatorychk="<%=Helper.correctNull((String)hshValues.get("strwcmandatorycheck"))%>";
var vartlmandatorychk="<%=Helper.correctNull((String)hshValues.get("strtlmandatorycheck"))%>";
var varwctype="<%=Helper.correctNull((String)hshValues.get("strwctype"))%>";
var vartltype="<%=Helper.correctNull((String)hshValues.get("strtltype"))%>";
var varsolepropbanktype="<%=Helper.correctNull((String)hshValues.get("strtsoleproptype"))%>";
var vartherthanosolepropbanktype="<%=Helper.correctNull((String)hshValues.get("strothersoletype"))%>";

var varfacrenewflag= "<%=Helper.correctNull((String)hshValues.get("FACILITY_RENEW_FLAG"))%>";
var vartenormonths= "<%=Helper.correctNull((String)hshValues.get("facility_months"))%>";
var varholidayperiod= "<%=Helper.correctNull((String)hshValues.get("FACILITY_HOLIDAYPERIOD"))%>";
var varmissector="<%= Helper.correctNull((String)hshValues.get("app_sector"))%>";
var varsubsector= "<%=Helper.correctNull((String)hshValues.get("app_subsector"))%>";
var varretrestructureval="<%= Helper.correctNull((String)hshValues.get("retrestructureval"))%>";
var varcorprestructureval= "<%=Helper.correctNull((String)hshValues.get("corprestructureval"))%>";
var varrestructurechk="<%= Helper.correctNull((String)hshValues.get("restructurechk"))%>";

var vargecl4count= "<%=Helper.correctNull((String)hshValues.get("gecl4countval"))%>";
var vargelc4exposurecunt="<%= Helper.correctNull((String)hshValues.get("gelc4exposurecuntval"))%>";
var vargecltype="<%= Helper.correctNull((String)hshValues.get("com_gecltype"))%>";
var vargecl4loanamt="<%= Helper.correctNull((String)hshValues.get("gecl4loanamt"))%>";
var vargecl3restructure= "<%=Helper.correctNull((String)hshValues.get("gecl3restructure"))%>";
var varresttenorchk="<%=Helper.correctNull((String)hshValues.get("strTenorRestructureChk"))%>";
var vargecl3restructurebybrw= "<%=Helper.correctNull((String)hshValues.get("strgecl3restpropstatus"))%>";
var vargecl1restructure= "<%=Helper.correctNull((String)hshValues.get("strgecl3brwval"))%>";
var vargecl1restructurecheck= "<%=Helper.correctNull((String)hshValues.get("gecl1restchk"))%>";
var varrestassesmandatory="<%=strrestgeclmandatorychk%>";
var varrestasschk="<%=Helper.correctNull((String)hshValues.get("strGECLRestAssCheck"))%>";
var varbankargmultwcconschk="<%=Helper.correctNull((String)hshValues.get("strwccountchk"))%>";
var varbankargmulttlconschk="<%=Helper.correctNull((String)hshValues.get("strtlcountchk"))%>";
var varwccount="<%=Helper.correctInt((String)hshValues.get("strconswcCountval"))%>";
var vartlcount="<%=Helper.correctInt((String)hshValues.get("strconsTLCountval"))%>";
var varrestchk="<%=Helper.correctNull((String)hshValues.get("strRestructureChk"))%>";
var varrestschemechk="<%=Helper.correctNull((String)hshValues.get("strschemeChk"))%>";
var vardigisubtype="<%=strLoanSubType%>";
var varAHPDet="<%=Helper.correctNull((String)hshValues.get("strAHPDet"))%>";
var varconResType="<%=Helper.correctNull((String)hshValues.get("CON_RESIDENT_TYPE"))%>";
var varAHPResType="<%=Helper.correctNull((String)hshValues.get("AHP_RESIDENT_TYPE"))%>";
var varTotalCost="<%=Helper.correctNull((String)hshValues.get("TOTAL_COST"))%>";
var varAHPCost="<%=Helper.correctNull((String)hshValues.get("AHP_COSTLOANPRD"))%>";
var varGovtScheme="<%=Helper.correctNull((String)hshValues.get("LOAN_GOVT"))%>";
var varSchemeType="<%=Helper.correctNull((String)hshValues.get("GOVT_SCHEME"))%>";
var varRepaymentType="<%=Helper.correctNull((String)hshValues.get("loan_repaymenttype"))%>";
var varpmSvanidhi3="<%=Helper.correctNull((String)hshValues.get("pmSvanidhi3"))%>";
var varpmSvanidhi3Assessment="<%=Helper.correctNull((String)hshValues.get("pmSvanidhi3Assessment"))%>";
var varpmSVanidhi_uniqueno="<%=Helper.correctNull((String)hshValues.get("SVanidhi_uniqueno"))%>";
var varSvanidhiproposed_amt3="<%=Helper.correctNull((String)hshValues.get("Svanidhiproposed_amt3"))%>";
var varproposed_amt3="<%=Helper.correctNull((String)hshValues.get("proposed_amt3"))%>";
var varSvanidhisanc_amt3="<%=Helper.correctNull((String)hshValues.get("Svanidhisanc_amt3"))%>";
var varsanc_amt3="<%=Helper.correctNull((String)hshValues.get("sanc_amt3"))%>";
var varCIN="<%=Helper.correctNull((String)hshValues.get("CIN"))%>";
var varListCompany="<%=Helper.correctNull((String)hshValues.get("Listed_Company"))%>";
var strAppNewid="<%=Helper.correctNull((String)hshValues.get("strAppNewid"))%>";
var varpmSvanidhi2="<%=Helper.correctNull((String)hshValues.get("pmSvanidhi2"))%>";
var varSvanidhi1_completed="<%=Helper.correctNull((String)hshValues.get("Svanidhi1_Completed"))%>";
var varSvanidhi2_completed="<%=Helper.correctNull((String)hshValues.get("Svanidhi2_Completed"))%>";
var varDigiLoanType="<%=StrDigiLoanType%>";
var varPOSTPR = "<%=Helper.correctNull((String)hshValues.get("POSTPR"))%>";

var vargecltype="<%=Helper.correctNull((String)hshValues.get("strgeclident"))%>";

var checkbenower = "<%=Helper.correctNull((String)hshValues.get("checkbenower"))%>";
var cbsBencheckid = "<%=Helper.correctNull((String)hshValues.get("cbsBencheckid"))%>";
var Lov_verification_check="<%=Helper.correctNull((String)hshValues.get("Lov_verification_check"))%>";

var leierrormessage="<%=Helper.correctNull((String)hshValues.get("leierrormessage"))%>";

if(strFIDPNDet!="")
{
	strFIDPNDet=strFIDPNDet.substring(1,strval.length-1);
}
var varVERFIcheckflag="<%=Helper.correctNull((String) hshValues.get("VERFIcheck"))%>";
<%
String VERFIcheck = Helper.correctNull((String) request
		.getParameter("VERFIcheck"));
%>

var varSchemecode="<%=Helper.correctNull((String)hshValues.get("strschemecode"))%>";
var com_facility_emischeme="<%=Helper.correctNull((String)hshValues.get("com_facility_emischeme"))%>";

var gecl3flag="<%=Helper.correctNull((String)hshValues.get("GECL3SANCATIONFLAG"))%>";
var gecl12flag="<%=Helper.correctNull((String)hshValues.get("GECL12SANCATIONFLAG"))%>";


var varproposalStatus ="<%=proposalStatus %>";
var varIntChngeMsg="<%=Helper.correctNull((String)hshValues.get("IntChngeMsg"))%>";

var varEntrepriseError="<%=Helper.correctNull((String)hshValues.get("strEntrepriseError"))%>";
var varFacilitesSNNo="<%=Helper.correctNull((String)hshValues.get("strFacilitesSNNo"))%>";

var parayatanGECLFlag="<%=Helper.correctNull((String)hshValues.get("parayatanGECLFlag"))%>";
var forPostcheck="<%=Helper.correctNull((String) hshValues.get("forPostcheck"))%>";
var appholdercheck= "<%=Helper.correctNull((String) hshValues.get("appholdercheck"))%>";
var perCbsId="<%=Helper.correctNull((String)hshValues.get("PERAPP_INTROCBSID"))%>";
var perFname="<%=Helper.correctNull((String)hshValues.get("PERAPP_FNAME"))%>";
var perJaName="<%=Helper.correctNull((String)hshValues.get("JA_NAME"))%>";
var perJaCbsId="<%=Helper.correctNull((String)hshValues.get("JA_APPRAISERCBSID"))%>";

var varhousingloanchk ="<%=Helper.correctNull((String)hshValues.get("housingloanchk"))%>";
var varhousingloanchkinloanpag ="<%=Helper.correctNull((String)hshValues.get("housingloanchkinloanpag"))%>";
var varhousingloanchkindevpag ="<%=Helper.correctNull((String)hshValues.get("housingloanchkindevpag"))%>";

var varPost_Loan_Sanct_ERRORSTATUS ="<%=Helper.correctNull((String)hshValues.get("Post_Loan_Sanct_ERRORSTATUS"))%>";


var varenwrdetails= "<%=Helper.correctNull((String)hshValues.get("enwrdetails"))%>";
var varenwrassessmentval= "<%=Helper.correctNull((String)hshValues.get("enwrassessmentval"))%>";
var varcbsscodechk="<%=Helper.correctNull((String)hshValues.get("CBSCHKFORPOST"))%>";

var varenwrschemeflag= "<%=Helper.correctNull((String)hshValues.get("enwrschemeflag"))%>";
//vindhya
var varchiefpromotercheck="<%=Helper.correctNull((String)hshValues.get("COMAPP_CHF_PROMOTER"))%>";
var ExposureChklimit= "<%=Helper.correctNull((String)hshValues.get("strdblExplimit"))%>";
var Explimitchk= "<%=Helper.correctNull((String)hshValues.get("strExplimitchk"))%>";
var varPancount="<%=Helper.correctNull((String)hshValues.get("Pancount"))%>";
var varPanCheck="<%=Helper.correctNull((String)hshValues.get("strPanCheck"))%>";
var ExposureChklimitagr= "<%=Helper.correctNull((String)hshValues.get("strdblExplimitagr"))%>";
var Explimitagrchk= "<%=Helper.correctNull((String)hshValues.get("strExplimitagrchk"))%>";
var Expmainactcheck="<%=Helper.correctNull((String)hshValues.get("strmainactcheck"))%>";
//vindhya
var varquerypending="<%=Helper.correctNull((String)hshValues.get("Query_pending"))%>";

function callOnload()
{	
	if(varIntChngeMsg == 'Y' && vardigisubtype=="PC" && varproposalStatus =="op")
	{
		alert("The Rate of interest has been changed Manually.Please confirm the correctness");
	}
	
	if((varProposalType =="P") && (postSanctionFlag =="EOP" || postSanctionFlag =="NEW" )&& (insertedParamters!="" && varstrFacSno!="0")){
	    alert("Post Sanction Parameters "+insertedParamters+"  marked as disabled in setup.Kindly delete the facilitiy and Proceed");
			}
	
	 
     <%if(strProposalType.equalsIgnoreCase("P") && updroiinfin.equalsIgnoreCase("updroiinfin")){%>
     
     <%if(strLoan_Sanct_STATUS.equalsIgnoreCase("S")){%>
     alert("Post Sanction ROI Updated Successfully in financle");
     
     <%}%>
     <%if(!Post_Loan_Sanct_ERRORSTATUS.equalsIgnoreCase("")){%>
     alert("Post Sanction ROI Updated Failed in financle due to "+varPost_Loan_Sanct_ERRORSTATUS);
     
     <%}%>
    <% }%>
	
	if(strSessionModuleType=="AGR"||strSessionModuleType=="CORP")
	{
	   if(varstrFacSno!="")
		{
	document.forms[0].sel_facility.value = "<%=strFacSno%>";
		}
	}
	if(varStatus.toUpperCase()=="SUCCESS")
	{
		alert("Your application has been sent successfully");
			document.forms[0].action=appURL+"action/mainnav.jsp";
			document.forms[0].submit();
	}
	else if(varStatus.toUpperCase()=="REALLOCATE")
	{
		alert("Your application has been reassigned successfully");
			document.forms[0].action=appURL+"action/mainnav.jsp";
			document.forms[0].submit();
	}
	else if(varStatus.toUpperCase()=="LODGE")
	{
		alert("Your application has been lodged successfully");
			document.forms[0].action=appURL+"action/mainnav.jsp";
			document.forms[0].submit();
	}
	else if(varStatus.toUpperCase()=="DISLODGE")
	{
		alert("Your application has been Dislodged successfully");
			document.forms[0].action=appURL+"action/mainnav.jsp";
			document.forms[0].submit();
	}
	if(document.forms[0].readFlag.value.toUpperCase()=="R")
	{
		document.forms[0].cmdsanction.disabled=true;
		document.forms[0].cmddropped.disabled=true;
		document.forms[0].cmdundo.disabled=true;
		document.forms[0].cmdsend.disabled=true;
		document.forms[0].cmdreassign.disabled=true;
		document.forms[0].cmdAdditionalparameter.disabled=true;
	}
	if(vardatavetting!="")
	{
		document.forms[0].sel_datavetting.value=vardatavetting;
	}
	if((strSessionModuleType=="AGR"||strSessionModuleType=="CORP")&&(varProposalType!="P"))
	{
	if(varstockaudit!="")
	{
		document.forms[0].sel_stock_audit.value=varstockaudit;
	}
	if(varcreditaudit!="")
	{
		document.forms[0].sel_credit_audit.value=varcreditaudit;
	}
        }
	/******** for CC mail*****************/
	if(document.forms[0].btnenable.value=="N")
	{
		document.forms[0].cmdsanction.disabled=true;
		document.forms[0].cmddropped.disabled=true;
		document.forms[0].sel_legalcomp.disabled=true;
     if((strSessionModuleType=="AGR"||strSessionModuleType=="CORP")&&(varProposalType!="P"))
	{

		document.forms[0].sel_stock_audit.disabled=true;
		document.forms[0].sel_credit_audit.disabled=true;
    }
		document.forms[0].cmdsend.disabled=true;
		if(document.forms[0].appholder.value==strUserId && document.forms[0].appstatus.value=="Processed/Approved" && varcbsaccno == "")
		{
			document.forms[0].cmdAdditionalparameter.disabled=false;
		}
		else
		{
			document.forms[0].cmdAdditionalparameter.disabled=true;
		}
		if(document.forms[0].appholder.value==strUserId && (document.forms[0].appstatus.value=="Processed/Approved" || document.forms[0].appstatus.value=="Processed/Rejected"))
		{
			document.forms[0].cmdsend.disabled=false;
		}
		if(vardatavetting!="")
		{
			document.forms[0].sel_datavetting.value=vardatavetting;
		}
		if(document.forms[0].hiddatavetting.value=="Y")
		{
			document.forms[0].sel_datavetting.disabled=true;
		}
	}
	if(document.forms[0].btnenable.value=="Y")
	{
		if(document.forms[0].appholder.value==strUserId && (document.forms[0].appstatus.value=="Processed/Approved"))
		{
			document.forms[0].cmdAdditionalparameter.disabled=false;
		}
		else
		{
			document.forms[0].cmdAdditionalparameter.disabled=true;
		}
		if(document.forms[0].appholder.value==strUserId && (document.forms[0].appstatus.value=="Processed/Approved" || document.forms[0].appstatus.value=="Processed/Rejected"))
		{
			document.forms[0].cmdsend.disabled=false;
		}
	}
	
	if(document.forms[0].appstatus.value=="Processed/Approved" && varSendToCBSFlag == "Y" && varcbsaccno == "")
	{
		document.forms[0].cmdUpdateCBS.disabled=false;
	}
	else
	{
		document.forms[0].cmdUpdateCBS.disabled=true;
	}	
	
	if(varSendToCBSFlag=="Y")
	{
		if(strSessionModuleType=="AGR" || strSessionModuleType=="CORP")
		{
			
			//corp and agri
			var sel_facilitylength=document.forms[0].sel_facility;
			if((sel_facilitylength.length-1)<=<%=facilitycount%>)
			{
			document.forms[0].cmdAdditionalparameter.disabled=true;
			document.forms[0].cmdundo.disabled=true;
			}else{
				document.forms[0].cmdAdditionalparameter.disabled=false;
				document.forms[0].cmdundo.disabled=true;
			}
		}
		else
		{
			//retail
			document.forms[0].cmdAdditionalparameter.disabled=true;
			document.forms[0].cmdundo.disabled=true;
		}
		
	}
	if(document.forms[0].org_name.value=="HEAD OFFICE"){

		document.all.deprt1.style.visibility="visible";
		document.all.deprt1.style.position="relative";
		document.all.deprt2.style.visibility="visible";
		document.all.deprt2.style.position="relative";
	}else{
		document.all.deprt1.style.visibility="hidden";
		document.all.deprt1.style.position="absolute";
		document.all.deprt2.style.visibility="hidden";
		document.all.deprt2.style.position="absolute";
	}
	if((varCBSACNoFlg=="Y" && document.forms[0].appstatus.value=="Processed/Approved")||document.forms[0].appstatus.value=="Processed/Rejected")
	{
		//document.forms[0].cmdsave.disabled=false;
	}
	else
	{
		//document.forms[0].cmdsave.disabled=true;
	}
	if(document.forms[0].appstatus.value=="Processed/Approved" || document.forms[0].appstatus.value=="Closed/Approved")
	{
		if(strPrdType!="pG" && strPrdType!="pR")
		{
			document.all.idloanaccount.style.visibility="visible";
			document.all.idloanaccount.style.position="relative";
			document.all.idrestr.style.visibility="visible";
			document.all.idrestr.style.position="relative";
			document.all.idCGTMSEtxn.style.visibility="visible";
			document.all.idCGTMSEtxn.style.position="relative";	
		}
		else
		{
			document.all.idloanaccount.style.visibility="hidden";
			document.all.idloanaccount.style.position="absolute";
			document.all.idrestr.style.visibility="hidden";
 			document.all.idrestr.style.position="absolute";
 			//document.all.idCGTMSEtxn.style.visibility="hidden";
			//document.all.idCGTMSEtxn.style.position="absolute";
		}
		<%if(loan_type.equalsIgnoreCase("C") || loan_type.equalsIgnoreCase("A")){%>
		document.all.idfacdetail.style.visibility="visible";
		document.all.idfacdetail.style.position="relative";
		
		<%}%>
	}
	else
	{
		
		document.all.idloanaccount.style.visibility="hidden";
		document.all.idloanaccount.style.position="absolute";
		document.all.idrestr.style.visibility="hidden";
		document.all.idrestr.style.position="absolute";
		//document.all.idCGTMSEtxn.style.visibility="hidden";
		//document.all.idCGTMSEtxn.style.position="absolute";
		<%if(loan_type.equalsIgnoreCase("C") || loan_type.equalsIgnoreCase("A")){%>
		document.all.idfacdetail.style.visibility="hidden";
		document.all.idfacdetail.style.position="absolute";
		<%}%>
	}
	<%if(StrLodgingRights=='1'||lodgerightstousercheck.equalsIgnoreCase("Y")){%>
	if(document.forms[0].appstatus.value=="Open/Pending")
	{
		document.forms[0].cmdlodge.disabled=false;
		document.forms[0].cmddislodge.disabled=true;
	}
	else if(document.forms[0].appstatus.value=="Open/Lodged")
	{
		document.forms[0].cmdreassign.disabled=true;
		document.forms[0].cmdlodge.disabled=true;
		document.forms[0].cmddislodge.disabled=false;
	}else{
		document.forms[0].cmdlodge.disabled=true;
		document.forms[0].cmddislodge.disabled=true;
	}
	<%}%>

	<%if(strProposalType.equalsIgnoreCase("P")){%>
	if(varPropsalSancType=="P" || strSessionModuleType=="RET")
	{
		document.forms[0].cmdsanction.value="Permit";
	}
	//if(strSessionModuleType!="RET")
	{
		document.forms[0].sel_finalsanction.disabled=true;
		if((document.forms[0].appstatus.value=="Open/Pending") && (varAppLevel=="C" || varAppLevel=="R") && (parseFloat(userclass)>=130))
		{
			document.forms[0].sel_finalsanction.disabled=false;
		}
		<%
		if(!(Helper.correctNull((String)session.getAttribute("strOrgLevel")).equalsIgnoreCase("C")||
				Helper.correctNull((String)session.getAttribute("strOrgLevel")).equalsIgnoreCase("R"))){%>
		//document.forms[0].cmdsanction.disabled=true;
		<%}
		%>
	}
	<%}%>
	if(varUndoFlag=="N")
	{
		document.forms[0].cmdundo.disabled=true;
	}
	if(strSessionModuleType=="RET" && varappcategory=="S")
	{
		document.forms[0].cmdAdditionalparameter.disabled=true;
	}

	if(document.forms[0].appstatus.value=="Closed/Approved")
	{
	    if(document.forms[0].appholder.value==strUserId)
	    {
	    	 document.forms[0].cmdsend.disabled=false;
	    }
	}
	
	<%if(strProposalType.equalsIgnoreCase("P")  && ((Helper.correctNull((String)session.getAttribute("appstatus")).equalsIgnoreCase("pa")) || (Helper.correctNull((String)session.getAttribute("appstatus")).equalsIgnoreCase("ca")))){%>
	<%if(!Helper.correctNull((String) hshValues.get("Loan_Sanct_STATUS")).equalsIgnoreCase("S") && roiflagval.equalsIgnoreCase("S"))
	{ %> 	 
	document.forms[0].cmdundo.disabled=true;	
<%}}%>

	if(varRevalidationFlag=="Y")
	{
		document.forms[0].cmdundo.disabled=true;
		document.forms[0].cmdRevalidate.disabled=false;
	}
	if(varProposalType=="P")
	{
		document.forms[0].cmdRevalidate.disabled=false;
	}
}
function callLoanAccount()
{
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanGetMethod.value="getLoanAccountData";
	document.forms[0].action=appURL+"action/apploanaccount.jsp";
	document.forms[0].submit();
}
function callFacDetail()
{
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanGetMethod.value="getFacilityDetailsData";
	document.forms[0].action=appURL+"action/appfacilitydetails.jsp";
	document.forms[0].submit();
}
function callRemarks()
{
	appno = document.forms[0].appno.value;
	var prop = "scrollbars=no,width=650,height=500,top=25,left=180";
	var url=appURL+"action/workflowcomm.jsp?hidappno="+appno+"&hiduserid="+strUserId+"&hidtoUser="+document.forms[0].mail_tousrid.value+"&editoption="+document.forms[0].hideditoption.value+"&hidtousrid="+document.forms[0].hidmail_tousrid.value;
	window.open(url,"remarks",prop);
}
function doValidateCheck()
{
	var facsno="1";
	
	if((strSessionModuleType=="AGR"||strSessionModuleType=="CORP") && document.forms[0].sel_facility.value=="s")
	{
		alert("Select Facility");
		document.forms[0].sel_facility.focus();
		return;
	}
	if(strSessionModuleType=="AGR"||strSessionModuleType=="CORP")
	{
		facsno=document.forms[0].sel_facility.value;
	}
	var prop = "scrollbars=yes,width=1000,height=600,top=25,left=180";
	var url=appURL+"action/revalidatecomments.jsp?hidBeanGetMethod=getRevalidateComments&hidBeanId=commworkflow&appno="+document.forms[0].appno.value+"&hidFacilitysno="+facsno;
	window.open(url,"Revalidation",prop);
}
function callOrgHelp()
{
	var appno1="<%=Helper.correctNull((String) hshValues.get("appno"))%>";
	if(document.forms[0].readFlag.value.toUpperCase()=="W")
	{
		var prop = "scrollbars=no,width=300,height=300,top=100,left=250";
		var url=appURL+"action/orgnamelist.jsp?&appno="+appno1;
		window.open(url,"",prop);
	}
}
function callUsersHelp()
{
	if(document.forms[0].org_name.value=="HEAD OFFICE")
	{
		if(document.forms[0].usr_department.value=="0")
		{
			ShowAlert(111,"Department");
			document.forms[0].usr_department.focus();
			return;
		}
	}
	usr_dept=document.forms[0].usr_department.value;
	if(document.forms[0].readFlag.value.toUpperCase()=="W")
	{
		if(usr_class=="")
		{
			ShowAlert(111,"Flowpoint");	
			return;
		}
		var prop="scrollbars=no,width=400,height=350,top=100,left=250";
		var url=appURL+"action/wrkflowuserlist.jsp?usr_class="+usr_class+"&org_code="+document.forms[0].org_code.value+"&usr_dept="+usr_dept;
		window.open(url,"hai",prop);
	}
}
function setValues(idx,size)
{	
	if(size>1)
	{
		usr_class=document.forms[0].prd_maxclass[idx].value;	
		document.forms[0].mail_tousrid.value="";
		document.forms[0].mail_toflowpoint.value=document.forms[0].txtmail_toflowpoint[idx].value;
	}
	else
	{
		usr_class=document.forms[0].prd_maxclass.value;	
		document.forms[0].mail_tousrid.value="";
		document.forms[0].mail_toflowpoint.value=document.forms[0].txtmail_toflowpoint.value;
	}
}

function placeValues()
{	
	var arrsize="";
	<%if (arrFlowpoint != null && arrFlowpoint.size() > 0) {%>
	arrsize=<%=arrFlowpoint.size()%>;
	<%}%>

	<%if(strProposalType.equalsIgnoreCase("P") && !strParams.contains("@MODGSS@")){%>
		if(varPMAY=="Y")
		{
			varPMAY="N";
		}
	<%}%>
	var maxclass=<%=hshValues.get("strMaxClass")%>;
	document.forms[0].cmdsanction.disabled=true;
	document.forms[0].cmddropped.disabled=true;
	document.forms[0].cmdundo.disabled=true;
	var varlegalcomp='<%=legalcomp%>';
	if((document.forms[0].appstatus.value=="Open/Pending")&&(strPrdType=="pG"||strPrdType=="pR"))
	{
		document.forms[0].sel_legalcomp.value="N";
	}
	if(varlegalcomp!='')
	{
		document.forms[0].sel_legalcomp.value=varlegalcomp;
	}
	if(varfinalsanction!='')
	{
		document.forms[0].sel_finalsanction.value=varfinalsanction;
	}
	if(parseInt(userclass)>=parseInt(appclass) && document.forms[0].appstatus.value=="Open/Pending")
	{
		document.forms[0].cmdsanction.disabled=false;
		document.forms[0].cmddropped.disabled=false;
		document.forms[0].txt_sanctioncomments.readOnly=false;
	}	
	if(parseInt(userclass)>=parseInt(skipclass) && document.forms[0].appstatus.value=="Open/Pending")
	{
		document.forms[0].cmdsanction.disabled=false;
		document.forms[0].cmddropped.disabled=false;
		document.forms[0].txt_sanctioncomments.readOnly=false;
	}
	if(parseInt(userclass)>=parseInt(appclass) && document.forms[0].appstatus.value=="Open/Pending" && currflowpoint==arrsize)
	{
		document.forms[0].cmdsanction.disabled=false;
		document.forms[0].cmddropped.disabled=false;
		document.forms[0].txt_sanctioncomments.readOnly=false;
	}	
	if(varapptype.toUpperCase()=="C" && var_CPAO=='Y' && (document.forms[0].appstatus.value=="Processed/Approved" || document.forms[0].appstatus.value=="Closed/Approved"))
	{
		//document.forms[0].cmdCPA.disabled=false;
	}
	//else if(varapptype.toUpperCase()=="C")
	//{
		//document.forms[0].cmdCPA.disabled=true;
	//}	
	if(document.forms[0].appstatus.value=="Open/Pending")
	{
	    if(varorghead=='Y' && document.forms[0].btnenable.value.toUpperCase()=='N')
		{
			document.forms[0].cmdreassign.disabled=false;
			document.forms[0].cmdsend.disabled=true;
			document.all["idorgselect"].style.visibility="hidden";
		}
		else
		{
			document.forms[0].cmdreassign.disabled=true;
			if(varusrfunction=="Delegated Authority")
			{
				document.all["idorgselect"].style.visibility="visible";
			}
			else
			{
				document.all["idorgselect"].style.visibility="hidden";
			}
		}
	    if(deligated_power=='Y')
		{
			document.forms[0].cmdreassign.disabled=false;
		}
	}
	else
	{
    	if(varusrfunction=="Delegated Authority")
		{
			document.all["idorgselect"].style.visibility="visible";
		}
		else
		{
			document.all["idorgselect"].style.visibility="hidden";
		}
	}	
	if(document.forms[0].appstatus.value=="Processed/Approved" || document.forms[0].appstatus.value=="Processed/Rejected")
	{
		document.forms[0].txt_sanctioncomments.readOnly=true;
		if(strUserId==varApproverejectBy)
		{
			document.forms[0].cmdundo.disabled=false;
		}
		for(var i=0;i<document.forms[0].optflowpnt.length;i++)
		{
			if(document.forms[0].txtmail_toflowpoint[i].value<9)
			{
				document.forms[0].optflowpnt[i].disabled=true;
			}
		}
		document.forms[0].cmdreassign.disabled=true;
	}	
	if(document.forms[0].appstatus.value=="Closed/Approved")
	{
		document.forms[0].txt_sanctioncomments.readOnly=true;
	    document.forms[0].cmdundo.disabled=true;
	    document.forms[0].cmdsend.disabled=true;
	    document.forms[0].cmdreassign.disabled=true;
	    document.forms[0].cmdAdditionalparameter.disabled=true;
	    document.forms[0].cmdUpdateCBS.disabled=true;
	}
	if(document.forms[0].appstatus.value=="Closed/Rejected")
	{
		document.forms[0].txt_sanctioncomments.readOnly=true;
	    document.forms[0].cmdundo.disabled=true;
	    document.forms[0].cmdsend.disabled=true;
	    document.forms[0].cmdreassign.disabled=true;
	    document.forms[0].cmdAdditionalparameter.disabled=true;
	    document.forms[0].cmdUpdateCBS.disabled=true;
	    //if(varapptype.toUpperCase()=="C")
	    	//document.forms[0].cmdCPA.disabled=true;
	}
	if(document.forms[0].appstatus.value=="Processed/Approved" || document.forms[0].appstatus.value=="Closed/Approved")
	{
	  if('<%=strCategoryType%>'=='CORP' || '<%=strCategoryType%>'=='SRE' || '<%=strCategoryType%>'=='STL' || '<%=strCategoryType%>'=='OPS' || '<%=strCategoryType%>'=='SME')
	  {
		 document.forms[0].txt_reviewdate.readOnly=true;
	  }	
	}
	if(document.forms[0].hidNonPoolFlag.value=="Y")
	{
		document.forms[0].cmdsanction.disabled=true;
		document.forms[0].cmddropped.disabled=true;
		document.forms[0].cmdundo.disabled=true;
		document.forms[0].cmdsend.disabled=true;
		//document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdreassign.disabled=true;
	}
}

function openWindow(pagename)
{
	var url = "<%=ApplicationParams.getAppUrl()%>action/"+pagename;
	window.open(url,"report","scrollbars=no,toolbars=no,menubar=no,width=450,height=300,left=60,top=40");
}
function doSend()
{		
		
	if(strSessionModuleType=="AGR"||strSessionModuleType=="CORP"||strSessionModuleType=="RET")
	{
	if(document.forms[0].appstatus.value=="Open/Pending"){
		
		
		if(leierrormessage=="Y")
		{
			alert("Kindly update Legal Entity Details in Finacle and vist laps customer profile.");
			return;
		}
		if(Lov_verification_check=="Y")
		{
			alert("Kindly enter details in Security Master - Legal Opinion Verification tab");
			return;
		}
	}
	
	}
	<%if(COM_BANKSCHEME.equalsIgnoreCase("052")){%>
	
	if(strSessionModuleType=="AGR" || strSessionModuleType=="CORP" || strSessionModuleType=="RET")
	{
		if((parseInt(userclass)>=50) && varappcategory !="P")	
		{
	      	if(document.forms[0].hidreasonproccchk.value=="N"){
	    	  	alert("Please Enter Values in Appraisal -> Reason For Manual Processing Tab");
				return;
	       	}
		}
	}
	<%}%>

	

	if(parayatanGECLFlag=="Y")
	{
		alert("Only one facility should be availed either GECL 1/3 or ParyaTan");
		return;
	}

//alert("vargecl1sno25"+vargecl1sno25);
	//alert("vardbgecl1maxamount"+vardbgecl1maxamount);
	//alert("vargeclavailable"+vargeclavailable);
	//alert("vargecltype"+vargecltype);

	
	if(vargeclavailable=="Y" && (vargecltype=="GECL -1 extension"||   vargecltype=="GECL -2 extension" ||  vargecltype=="GECL -3 extension")
			&& (!varProposalType =="P"))
	{
		//alert("1");
	//if(vardbgecl1maxamount>vargecl1sno25)
	var gecl25 =parseInt(vargecl1sno25);
		var vadbgecl1maxamount=parseInt(vardbgecl1maxamount);
		//alert("vardbgecl1maxamount"+vadbgecl1maxamount);
		//alert("gecl25"+gecl25);
		
	if(vadbgecl1maxamount>gecl25)
	{
		alert("Facility Sanctioned Amount should not be greater than Recommended field of gecl Assessment");
		return;
	}
	}

if(gecl12flag=="Y" &&  gecl3flag=="Y"  &&  (!varProposalType =="P"))
{
	alert("Once a Borrower has  GECL -3 Extension  facility  Sanctioned ,same borrower cannot be sanctioned  GECL -1 Extension/GECL -2 Extension");
	return;
}	
	
	if((strSessionModuleType=="AGR"||strSessionModuleType=="CORP")&&(varProposalType=="S"))
	{
		if(varresttenorchk=="Y"){
		 alert("Repayment Tenor exceeding the maximum period of 120 months or Holiday period should be not be greater than 24 months");
		 return;
			}
	}
	if(varProposalType=="S" && document.forms[0].appstatus.value=="Open/Pending" && (strSessionModuleType=="AGR"||strSessionModuleType=="CORP"))
	{
		if(varrestschemechk=="Y" && varrestchk =="N"){
			alert("mismatch of activity of the borrower captured in Restructure settlement scheme framework 2.0");
			return;
			}
	}
	if(varEntrepriseError=="Y")
	{
		alert("If in MIS details - Agriculture Industry Service Category is Micro Enterprises, then in CGTMSE Coverage button value in 'Whether the unit Assisted is an Micro Enterprise as per the MSMED Act 2006 definition of MSE' should be Yes or else value should be No for facility:"+varFacilitesSNNo);
		return;
		
	}
	/*if((strSessionModuleType=="AGR"||strSessionModuleType=="CORP")&&(varProposalType=="S"))
	{
		if(varresttenorchk=="Y"){
		 alert("Repayment Tenor exceeding the maximum period of 120 months");
		}
	}*/
	if((strSessionModuleType=="AGR"||strSessionModuleType=="CORP")&&(varProposalType=="S"))
	{
		
		if(document.forms[0].appstatus.value=="Open/Pending"){
			if(varcorprestructureval=="Y" && varrestructurechk=="N"){
				alert("Please enter the details in Assesment for Eligibility under Restructure tab Details.");
				return;
			}
		}
	}
	if((strSessionModuleType=="RET")&&(varProposalType=="S"))
	{
		if(document.forms[0].appstatus.value=="Open/Pending"){
			if(varretrestructureval=="Y" && varrestructurechk=="N"){
				alert("Please Enter Values in Appraisal -> Loan Details ->Eligibility Under Restructure Tab Details");
				return;
			}
		}
	}
	//PAN CHECK FOR RETAIL AND CORPORATE 
	if(varPanCheck=="Y")
	{ 
		if(strSessionModuleType!="AGR" && document.forms[0].appstatus.value=="Open/Pending")
		{
			if(strPrdType!="pG" && strPrdType!="pR")
			{
				if(strSessionModuleType=="CORP")
				{
					if(varConstitution!="183" && varConstitution!="184" && varConstitution!="185" && varConstitution!="186" 
							&& varConstitution!="187" && varConstitution!="188" && varConstitution!="189" && varConstitution!="190" && varConstitution!="192")	
					{
						if(Explimitchk=="F")
						 {
							 if (varPancount=="N")
							{
							 alert("Please obtain PAN number of the Applicants (including co-applicant/Joint borrower/Co-applicant) Co-Obligant/guarantor and capture in CBS for exposure (includes existing and proposed limit) of Rs.50,000/- and above ");
								return;
							}	 
						}
					}
				
				}
				else
				{			
				 if(Explimitchk=="F")
					 {
						 if (varPancount=="N")
						{
						 alert("Please obtain PAN number of the Applicants (including co-applicant/Joint borrower/Co-applicant) Co-Obligant/guarantor and capture in CBS for exposure (includes existing and proposed limit) of Rs.50,000/- and above ");
							return;
						}	 
					}
				}	
			}
			 
		}
		if(strSessionModuleType=="AGR" && document.forms[0].appstatus.value=="Open/Pending")
		{
			if(Expmainactcheck>0)
			{	
			 if(Explimitagrchk=="F")
				 {
					 if (varPancount=="N")
					{
					 	alert("Please obtain PAN number of the Applicants (including co-applicant/Joint borrower/Co-applicant) Co-Obligant/guarantor and capture in CBS for exposure (includes existing and proposed limit) of Rs.10,00,000/- and above ");
						return;
					}	 
				}
			}
		
		}
	}	
	//PAN CHECK FOR RETAIL AND CORPORATE
	if((varProposalType =="P") && (postSanctionFlag =="EOP" || postSanctionFlag =="NEW" )&& (insertedParamters!="" && varstrFacSno!="0")){
	    alert("Post Sanction Parameters "+insertedParamters+"  marked as disabled in setup.Kindly delete the facilitiy and Proceed");
	   return;
			}
	
	if(document.forms[0].appstatus.value=="Open/Pending"){
		
		if(varFacAdhocDet!="")
		{
			//alert(varFacAdhocDet);
			alert("MIS activity Code and Original Investment in Equipments/Cost of Vehicles Used in Business should be same for Regular Limit and Adhoc/Additional Limit");
			return;
		}
		}
	<%if(strParams.equalsIgnoreCase("@CHDCCO@")||strParams.equalsIgnoreCase("@DCCO@"))
	{%>
		if(varDrawDownFlag=="No")
		{
			 alert("Please fill Draw Down Schedule for Project Loans");
			 return;
		}
	<%}else if(!strProposalType.equalsIgnoreCase("P"))
	{%>
		if(varDrawDownFlag=="No")
		{
			 alert("Please fill Draw Down Schedule for Project Loans");
		      return;
		}
	<%}%>
	
	<%if(!strProposalType.equalsIgnoreCase("P")){ %>
	
	if(document.forms[0].appstatus.value=="Open/Pending")
	{
		if(strStandupCheck=="No")
		{
		      alert("Please revisit the customer profile");
		      return;
		}

	if(strSessionModuleType=="RET" || strSessionModuleType=="LAD")
	{
		if(loan_roiType!="" && loan_roiType!="O")
		{
			if(loan_ROIscore!=varscoreVal)
			{
				if(loan_roiType=="RATING")
				{
					alert("Risk Score value changed. Please reselect the product in Loan Particulars tab for Interest Recalculation");
				}
				else
				{
					alert("CIBIL/CRIF Score value modified in Customer Profile. Please reselect the product in Loan Particulars tab for Interest Recalculation");
				}
				return;
			}
		}
	if( varPRD_CGTMSE=="Y"  && (document.forms[0].appstatus.value=="Open/Pending" || document.forms[0].appstatus.value=="Open/Lodged"))
	{
	     if(varCGTMSEtotintrate=="Y")
			{
				alert("Total CGTMSE Interest rate should not exceed "+varparamval_CGTMSEint+"%");
				return;
			}

		if(strudyogadhorChk=="Y")
			{
					alert("Please fill Udyog Aadhaar Number in Customer Profile");
				return;
			}
       }
		
	}
	else
	{
		if(varMMithra=="N")
		{
			alert("Agriculture Industry Service Category should be MICRO (Service/Manufacturing) Enterprises  for Micro Mithra Scheme");
			return;
		}
		if(eval(strAmount)<eval(strMithraFacTot))
		{
			alert("Total of Sanctioned amount under KBL Micro mitra is greater than MPBF amount in Assessment.");
			return;
		}
		if(strFIDPNChk=="N")
		{
			alert("Kindly fill Interest DPN assessment Details for DPN facilities");
			return;
		}
		if(strFIDPNDet!="")
		{
			alert("Sanctioned amount under interest Defernment DPN 2020 is greater than MPBF amount in Assessment\n "+strFIDPNDet);
			return;
		}
	
		<% if(strSessionModuleType.equalsIgnoreCase("CORP"))
		{%>
		
		if(document.forms[0].hidcgssdtypechk.value=="N")
		{
			alert("Please Enter All Facility Related Details in  CGSSD Assessment in Assesment for KBL CGSSD tab Details.");
			return;
		}
		if(document.forms[0].hidcgssdsanchk.value=="N")
		{
			alert("Amount applied for CGSSD  should not be greater than the  Proposed Limit in Assesment for KBL CGSSD tab Details.");
			return;
		}
		if(document.forms[0].appstatus.value=="Open/Pending" ){
			if(document.forms[0].hidcgssdpercchk.value=="N")
			{
				alert("Please re enter the details in Assesment for KBL CGSSD tab Details.");
				return;
			}
			if(document.forms[0].hidmisactivitycodechk.value=="N")
			{
				alert("activity code to be selected for all CGSSD facilities should be - 150599-Personal  Loans to Others only in->Mis Details Tab.");
				return;
			}
			if(vargeclavailable=="Y" && varGECLChk=="Y")
			{
			if(vargecl4loanamt=="Y" && vargecltype=="GECL4"){
				alert("Please re enter the details in Assesment for KBL GECL tab Details.");
			return;
			}
			}
			if(vargeclavailable=="Y" && varGECLChk!="Y")
			{
				alert("Please Fill Assessment -> Eligibility Criteria for KBL GECL scheme tab Details");
				return;
			}
			<%if(!strProposalType.equalsIgnoreCase("S") && !strProposalType.equalsIgnoreCase("P")  )
			{%>
			if(vargeclavailable=="Y" && varGECLAssChk!="Y")
			{
				alert("Please Fill Assessment for KBL GECL scheme tab Details");
				return;
			}
			<%}%>
		}
       <%}%>
   
		if(varSvanidhi=="Y" && strSvanidhiTerm!="Y")
		{
			alert("Please check the declaration details in Customer Profile -> Svanidhi Details tab");
			return;
		}
		/*if(varGECLFor!="" && varGECLFor!="3" && varConstitution=="01")
		{
			alert("Entered KBL GECL scheme Assessment is not Eligible for Individual");
			return;
		}*/
		if(eval(varDeviationcnt)>0)
		{
			if(confirm("Rating/CIBIL/CRIF Details has been modified.Do you agree to Re-enter facilities reference rate tab for those facilities?"))
			{
					document.forms[0].hidSourceUrl.value="/action/appworkflowaction.jsp" 
					document.forms[0].hidBeanId.value="commworkflow";
					document.forms[0].hidBeanMethod.value="updateAction";
					document.forms[0].hidBeanGetMethod.value="getAction";
					document.forms[0].hidAction.value="IntDeviation";
					document.forms[0].action=appURL+"controllerservlet";
					document.forms[0].submit();
			}
			return;
				
		}
	}
	if(strSessionModuleType=="RET"){
		if(document.forms[0].appstatus.value=="Open/Pending"){
			if(varMISCODEFlag=="Y")
			{
			alert("Please Reselect the Activity Code in MIS Details page");
		    return;
			}
		}
	}
   if(strSessionModuleType=="CORP" ||strSessionModuleType=="AGR"){
	if( varPRD_CGTMSE=="Y"  && (document.forms[0].appstatus.value=="Open/Pending" || document.forms[0].appstatus.value=="Open/Lodged"))
	{
	     if(strCGTMSEtotintrate1=="Y")
			{
			
				alert("Total CGTMSE Interest rate should not exceed "+varparamval_CGTMSEint+"%");
				return;
			}

		if(strudyogadhorChk=="Y")
			{
					alert("Please fill Udyog Aadhaar Number in Customer Profile");
					return;
			}
       }
  }
	if(varBureauchk=="No")
	{
		//alert("Please Check bureau for all Applicants");
		//return;
	}
	}
	<%}%>
	if(varTermflag=="Y")
	{
		alert("Changes made in Terms & Conditions. \n Kindly revisit and select appropriate conditions for the proposal.");
		return;
	}

	if(varPMAY=="Y" && varPmayhouse=="N" && document.forms[0].appstatus.value=="Open/Pending")
	{
		alert("Please Enter PMAY Details in Loan Particulars tab")
		return;	
	}
	if(varPMAY=="Y" && document.forms[0].appstatus.value=="Open/Pending")
	{
		if(varOwnedHouse=="Y")
		{
			alert("You cannot forward.The Borrower has owned a house his/her name or family member's name in india.");
			return;
		}
		if(varFemaleownerReq=="Y" && varFemaleownerAvail=="")
		{
			//alert("Female Ownership Required");
			//return;
		}
		if(varGovtscheme=="079")
		{
			if(eval(varCarpetAreaReq)<eval(varCarpetAreaAvail))
			{
				alert("Carpet Area should not be more than "+eval(varCarpetAreaReq)+" Sq.Mts");
				return;
			}
		}
		if(eval(varTenorReq)<eval(varTenorAvail))
		{
			//alert("Loan Tenor should not be more than "+eval(varTenorReq));
			//return;
		}
		if(parseInt(varPMAYValidFrom)<0)
		{
			alert("You cannot forward this Proposal Under PMAY scheme.\n Scheme Yet to Start");
			return;
		}
		if(parseInt(varPMAYValidTo)>0)
		{
			alert("You cannot forward this Proposal Under PMAY scheme.\n Scheme Validity Expired");
			return;
		}
	}
	if(strSessionModuleType=="RET"){
			if(document.forms[0].appstatus.value=="Open/Pending"){
				if(varMISCODEFlag=="Y")
				{
				alert("Please Reselect the Activity Code in MIS Details page");
			    return;
				}
			}
		}
	//Added by Arsath for Loan Product Gross Rent check with Lease Details Gross Rent
	<%if(!strProposalType.equalsIgnoreCase("P")){%>
	if(varQueryStatus=="No" && document.forms[0].org_code.value!="001014001000000" && document.forms[0].org_code.value!="001007001000000" && document.forms[0].org_code.value!="001002001000000")
	{
		alert("Queries raised, kindly close before forwarding");
		return;
	}
	if(varquerypending=="No"&&(document.forms[0].org_code.value=="001014001000000"||document.forms[0].org_code.value=="001007001000000"||document.forms[0].org_code.value=="001002001000000"))
		{
		alert("Some Queries are in Send Status, Please reply before forwarding the proposal");
		return;
		}
	if(varGuarantor_check=="N" && document.forms[0].appstatus.value=="Open/Pending")
	{
		alert("You cannot forward.The Guarantor/Co-Applicant details are not completed fully.");
		return;
	}
	
	if(varUpdSecFlag!="")
	{
		alert("There is a change in the value of security for the following ID("+varUpdSecFlag+").Kindly reattach the security to update the Security value");
		return;
	}
	if(varUnapprovedSecFlag!="")
	{
		alert("Unapproved/Disabled Company shares given as a security. Kindly Detach and Proceed further");
		return;
	}
	if(varPhyLimitExceeds!="")
	{
		alert("Physical form of loan against share limit exceeds for this borrower");
		return;
	}
	if(varDematLimitExceeds!="")
	{
		alert("Demat form of loan against share limit exceeds for this borrower");
		return;
	}
	if(document.forms[0].appstatus.value=="Open/Pending")
	{
		if(varCFRverified=="N" || varCFRverified=="")
		{
			alert("Central Fraud Registry Verification is not done. you cannot proceed further");
			return false;
		}
		if(eval(varBorrExp)>500000 && (varCFRverified=="N" || varCFRverified=="NA"))
		{
			alert("Since Borrower Exposure is more than 5lakhs, Central Fraud Registry verification is mandatory");
			return false;
		}
		if(varCFRverified=="Y" && varCFRborname=="Y" && varCFRAppjStatus=="R")
		{
			alert("You cannot Proceed further. Central Fraud Registry Deviation Rejected");
			return false;
		}
	}

	
	if(strSessionModuleType=="RET" || strSessionModuleType=="LAD")
	{
		if(varReselectprd=="Y" && document.forms[0].appstatus.value=="Open/Pending")
		{
			alert("Product is Not Available \n Please Reselect the Product in Loan Particulars Tab");
			return;
		}
		if(varLARbankscheme!=varprdbankscheme)
		{
			alert("Product Bank Scheme differs from Attached LAR Bank Scheme.");
			return;
		}
		if(varBIRFlag!="Y" && (document.forms[0].appstatus.value=="Open/Pending" || document.forms[0].appstatus.value=="Open/Lodged"))
		{
			alert("Please Fill Appraisal -> Background Information Report (BIR) tab");
			return;
		}
		if( varPRD_CGTMSE=="Y"  && varCGTMSEFlag!="Y" && (document.forms[0].appstatus.value=="Open/Pending" || document.forms[0].appstatus.value=="Open/Lodged"))
		{
			alert("Please Fill CGTMSE COVERAGE in Loan Particulars tab");
			return;
		}
		if( varPRD_CGTMSE=="Y"  && (document.forms[0].appstatus.value=="Open/Pending" || document.forms[0].appstatus.value=="Open/Lodged"))
		{
			/*if(varCGTMSEtotintrate=="Y")
			{
				alert("Total CGTMSE Interest rate should not exceed "+varparamval_CGTMSEint+"%");
				return;
			}*/
			if(varCGTMSEcovLimit=="Y")
			{
				alert("CGTMSE Coverage of the borrower should not exceed "+varmaxcgtmseLimit);
				return;
			}
			if(parseFloat(varsanction_amount)>=parseFloat(500000))
			{
				
				 if(varCGPan=="" || varCGPan=="NOPAN" )
				 {
					 alert("PAN is mandatory for loan amount of Rs.5 lakh and above for coverage under CGTMSE");
					 return;
				 }
			}
			/*if(var_AadharNo=="")
			{
				alert("Please fill Udyog Aadhaar Number in Customer Profile");	
				return false;
			}*/ 
			if(NatureofActivity=="")
			{
				alert("Please fill Nature of Activity in Customer Profile");	
				return;
			} 
			
			if(varConstitution!="01" && varchiefpromotercheck=="N")
			{
				alert("atleast one Cheif Promoter is mandatory.  Kindly select atleast one in Customer Profile-Groups/Management Peoples tab");
				return;
			}
			
			}
		}		
	
	else
	{
		<%if(arrSchemes!=null && arrSchemes.size()>0){
			for(int a=0;a<arrSchemes.size();a++){
			if(Helper.correctNull((String)arrSchemes.get(a)).equalsIgnoreCase("055")){%>
				if(varDocAttach_Flag == "N")
				{
					alert("Please Attach Document in Documents Tab");
					return;	
				}
			<%}}}%>
		if(varReselectprd=="Y" && document.forms[0].appstatus.value=="Open/Pending")
		{
			alert("Facility "+varReselectprdDesc+" is Not Available. \n Please Reselect the Facility in Facilities Tab");
			return;
		}

		if(varBIRFlag!="Y" && (document.forms[0].appstatus.value=="Open/Pending" || document.forms[0].appstatus.value=="Open/Lodged"))
		{
			alert("Please Fill Due Diligence Report / BIR -> Background Information Report (BIR) tab");
			return;
		}
		
		if(varFACCHECK == "N")
		{
			alert("Approve/Reject individual facilities in Workflow -> Proposed Facility Approve/Reject tab");				
			return;
		}

		if( varCropCGTMSE=="Y"  && (document.forms[0].appstatus.value=="Open/Pending" || document.forms[0].appstatus.value=="Open/Lodged"))
		{
if(varCGTMSEFlag!="Y")
		{
			alert("Please Fill CGTMSE COVERAGE in Facilities tab");
			return;
		}
			if(parseFloat(varCGLimit)>=parseFloat(500000))
			{
				 if(varCGPan=="" || varCGPan=="NOPAN" )
				 {
					 alert("PAN is mandatory for loan amount of Rs.5 lakh and above for coverage under CGTMSE");
					 return;
				 }
			}
			if(var_AadharNo=="")
			{
				alert("Please fill Udyog Aadhaar Number in Customer Profile");	
				return false;
			}

			if(NatureofActivity=="")
			{
				alert("Please fill Nature of Activity in Customer Profile");	
				return;
			} 
			
			if(varCGTMSEcovLimit=="Y")
			{
				alert("CGTMSE Coverage of the borrower should not exceed "+varmaxcgtmseLimit);
				return;
			}
			if(varConstitution!="01" && varchiefpromotercheck=="N")
			{
				alert("atleast one Cheif Promoter is mandatory.  Kindly select atleast one in Customer Profile-Groups/Management Peoples tab");
				return;
			}
		}
	}
		if(document.forms[0].appstatus.value=="Open/Pending")
		{
			if(strSessionModuleType=="RET" || strSessionModuleType=="LAD")
			{
				if((varRepayComments!="Y" && varrepaymenttype!="1"))
				{
					<%--if("<%=strPrdType%>"!="pR" && "<%=strPrdType%>"!="pV" && !(("<%=strPrdType%>"=="pM" || "<%=strPrdType%>"=="pI") && varPrdLoanType=="OD"))--%>
					{
						alert("Enter Repayment Comments in Appraisal -> Terms of Repayment tab");
						return;
					}
				}
			}
		if(strPrdType=="pR"||strPrdType=="pG")
		{
			if((varDocumentReceived!="")&&(varDocumentReceived!="4") && (varAppEmployment!="4"))
			{
				alert("You are not Eligible to get Loan under Agriculture Scheme");
				return;
			}
		}
		if(strPrdType=="pL")
		{
			if(parseFloat(varloangross) > parseFloat(varleasegross))
			{
				alert("Monthly gross rent in loan products page and total monthly gross rent in Lease Details page should be equal");
				return;
			}
		}
		if(strPrdType=="pG")
		{
			if(varJewelAppraiser!="Y")
			{
				alert("Please Fill Appraiser details in Gold Ornaments tab");
				return;
			}
		}
		
		<%if(loan_type.equalsIgnoreCase("P")){%>
		<%if(strPrdType.equalsIgnoreCase("pH") || strPrdType.equalsIgnoreCase("pM") || strPrdType.equalsIgnoreCase("pI") || strPrdType.equalsIgnoreCase("pT")){%>
			if(varTakeoverflag=="Y")
			{
				alert("Please Fill Take over details in Loan Particulars -> Proposed/Offered Asset");
				return;
			}
			<%}%>
			if(varMISDetails.toUpperCase()!="Y")
			{
				alert("Please Enter Values in MIS/CBS Details -> MIS Details");
				return;
			}
			if(varCBSDetails.toUpperCase()!="Y")
			{
				alert("Please Enter Values in MIS/CBS Details -> CBS Details");
				return;
			}
			if(document.forms[0].appraisalsanc.value!="Yes")
			{
				alert("Please Enter Values in Appraisal -> Loan Details");
				return;
			}

			if(strPrdType=="pU" && varshg_tallied=="N")
			{
				alert("Proposed Loan Amount is not tallied with the amount shared among the SHG members");
				return;
			}
			if(strPrdType=="pU" && varExposureChk=="F")
			{
				alert("Total Exposure Limit of the Borrower is "+varBorrowerExp+"\nIt should not exceeds 10 Lakhs");
				return;
			}
		<%}%>	
	
		<%if(!(loan_type.equalsIgnoreCase("P"))){%>
		if(varshg_tallied=="N")
		{
			alert("Proposed Loan Amount is not tallied with the amount shared among the SHG members in facility sno "+varfac_not_tally);
			return;
		}
		if(strBrief=="True")
		{
			alert("Please Fill Basic Information Details");
			return;
		}
		if(str_strmisaparam=="True")
		{
			alert("Please Enter All Facility Related Details in MIS / CBS Details Tab");
			return;
		}	
		<%if(!strProposalType.equalsIgnoreCase("P")){%>
		if(!strSessionModuleType=="DIGI")
		{
			if(varTakeOverDetails=="N")
			{
				alert("Please Fill Take Over tab");
				return;
			}
		}	
		if(varTakeover=="N")
		{
			alert("Please Fill Take Over Norms tab");
			return;
		}	
		<%}}%>	
		
		//Repayment non EMI check
		if(varNEcheckflag=="N")
		{
			alert("Repayment EMI Amount does not tally for these facilities"+varNEFacdesc);
			return;	
		}
		<%if((strSessionModuleType.equalsIgnoreCase("RET")||strSessionModuleType.equalsIgnoreCase("LAD"))&& strParams.equalsIgnoreCase("@BRTOMCLR@")){%>
		varSecurityFlag="N";
		<%}%>
if(varSecurityFlag!="N" && ("<%=strPrdType%>"!="pR" && "<%=strPrdType%>"!="pG"))
		{
			alert("Please Attach and freeze the Securities for this Proposal");
			return;
		}
		if(varMSME=="Y" && varMSMEFacility=="")
		{
			alert("Enter Check List for Documents for all KBL MSME schemes");
			return;
		}
		}

		
	<%}else{%>
	if(document.forms[0].appstatus.value=="Open/Pending")
	{
		<%if(!(loan_type.equalsIgnoreCase("P"))){%>
		if(varshg_tallied=="N")
		{
			alert("Proposed Loan Amount is not tallied with the amount shared among the SHG members in facility sno "+varfac_not_tally);
			return;
		}
		if(strBrief=="True")
		{
			alert("Please Fill Basic Information Details");
			return;
		}
		if(str_strmisaparam=="True")
		{
			alert("Please Enter All Facility Related Details in MIS / CBS Details Tab");
			return;
		}	
		if(varNEcheckflag=="N")
		{
			alert("Repayment EMI Amount does not tally for these facilities"+varNEFacdesc);
			return;	
		}
		<%}else{%>
		if(varMISDetails.toUpperCase()!="Y")
		{
			alert("Please Enter Values in MIS/CBS Details -> MIS Details");
			return;	
		}
		if(varCBSDetails.toUpperCase()!="Y")
		{
			alert("Please Enter Values in MIS/CBS Details -> CBS Details");
			return;	
		}
		if(varRNEcheckflag=="N" && ("<%=strPrdType%>"!="pR" && "<%=strPrdType%>"!="pG" && varPrdLoanType!="OD"))
		{
			alert("Loan Amount & Installment amount should be tallied");
			return;	
		}
		if(strPrdType=="pU" && varshg_tallied=="N")
		{
			alert("Proposed Loan Amount is not tallied with the amount shared among the SHG members");
			return;
		}
		<%}%>

		<%if(strParams.contains("@GUAR@")||strParams.contains("@SEC@")||strParams.contains("@MARGIN@")||strParams.contains("@MODSEC@")){%>
		if((parseFloat(userclass)>=130) && (varAppLevel=="C" || varAppLevel=="R") &&(document.forms[0].sel_finalsanction.value==""))
		{
			ShowAlert(111,"Approving the Post sanction Modifications in Security & Guarantor");
			document.forms[0].sel_finalsanction.focus();
			return;
		}
		<%}%>	

		
		}
	<%}%>

	<%if(!strProposalType.equalsIgnoreCase("P")){%>
	if(varAppDocuments!="Y")
	{
		alert("Necessary documents not submitted by customer - Please check and change in Loan Application Register");
		return;
	}
	if(varMISCODEFlag=="Y" && document.forms[0].appstatus.value=="Open/Pending")
	{
		alert("Please Reselect the Activity Code in MIS Details page-->"+varMISCODEDesc);
		return;
	}
	<%}else if(strParams.contains("@MIS@")||strParams.contains("@SLILA@")){%>
	if(varMISCODEFlag=="Y" && document.forms[0].appstatus.value=="Open/Pending")
	{
		alert("Please Reselect the Activity Code in MIS Details page-->"+varMISCODEDesc);
		return;
	}
	<%}%>
    var logUserId=document.forms[0].txt_usrid.value;
    var senId=document.forms[0].hidmail_tousrid.value;
    if(trim(logUserId)==trim(senId))
    {
     alert("From User and Recipient User are Same");
     return false;
    }
	var varvettingrequired="TRUE";
	if(usr_class=="" )
	{
		ShowAlert(111,"Flowpoint");
		return;
	}
	if(document.forms[0].mail_tousrid.value=="")
	{
		ShowAlert(111,"Recipient");
		return;
	}	
	if(parseInt(userclass)<parseInt(skipclass))
	{
		if(parseInt(currflowpoint)+1<parseInt(document.forms[0].mail_toflowpoint.value))
		{
			ShowAlert(132);
			return;
		}
	}
	var touserclass=document.forms[0].mail_touserclass.value;
	if(touserclass!=10 && parseInt(userclass)>10)
	{
		if(vardatavetting!="Y")
		{
			document.forms[0].hidvettingreq.value="TRUE";
			if(document.forms[0].sel_datavetting.value!="Y")
			{
				alert("Initial Vetting of application not done, So cannot be forwarded");
				document.forms[0].sel_datavetting.focus();
				return;
			}
		}
		else
		{
			document.forms[0].hidvettingreq.value="FALSE";
		}
	}
	else
	{
		document.forms[0].hidvettingreq.value="FALSE";
	}

	<%if(!strProposalType.equalsIgnoreCase("P")){%>
		 if((parseInt(userclass)>10 && touserclass!=10 && varapptype.toUpperCase()=="P")&& document.forms[0].appstatus.value=="Open/Pending")	
		{
			if(varAppraisalQuest.toUpperCase()!="Y" && "<%=strPrdType%>"!="pR" && "<%=strPrdType%>"!="pG")
			{
				alert("Please Enter Values in Appraisal -> Check List");
				return;
			} 	
		}
		if((strSessionModuleType=="AGR" || strSessionModuleType=="CORP") && document.forms[0].appstatus.value=="Open/Pending")
		{
			if(varDigiLoanType!="PC")
			{	
				if(varRatingTabHideCorpAgr=="N" && varappcategory !="C")
				{
					if(ratinggroup!="Y")
					{
					if(strfinalsendflag!="Y")
					{
						alert("Please do the rating before Send");
						return;
					}
					}
				}
			}
			if(varInwardchk=="N")
			{
				alert("Govt. Sponser scheme and other related information of the Attached LAR should match with atleast one facility of this proposal");
				return;
			}
		}
		if(document.forms[0].appstatus.value=="Open/Pending" && varAppraisedFlag!="Y")
		{
			alert("Select Appraised by User Details in Proposal Flow tab");
			return;
		}
		if(document.forms[0].appstatus.value=="Open/Pending" && varSanctionFlag!="Y")
		{
			alert("Select Sanctioned by User Details in Proposal Flow tab");
			return;
		}
		if(strRemarksFlag!="1")
		{
			if(confirm("Do you want to enter any remarks"))
			{
				strRemarksFlag="1";
				document.forms[0].hideditoption.value="Y";
				callRemarks();
				return;
			}
		}
	<%}%>	
	<%if(strProposalType.equalsIgnoreCase("P")){%>
		document.forms[0].sel_finalsanction.disabled=false;
	<%}%>
	<% if(strSessionModuleType.equalsIgnoreCase("CORP")||strSessionModuleType.equalsIgnoreCase("AGR"))
	{%>
	if(document.forms[0].appstatus.value=="Open/Pending"){
	if(document.forms[0].hidintsubtypechk.value=="N")
	{	
		
			alert("Please Enter Values Facilities -> Other Interest Rates / Commission -> "+varFacDesc);
			return;
		
	}
	}
	<%}%>
	<%if(strParams.equalsIgnoreCase("@MIS@"))
	{%>
	if(document.forms[0].appstatus.value=="Open/Pending"){
			if(varRmdUsr!="1"&& document.forms[0].mischeck.checked==false)
		{
				ShowAlert(111,"  Kindly verify MIS and its related classification and then tick the check box 'I have checked MIS details and its related classification for all facilities and  found correct' in Workflow - action tab");
			document.forms[0].mischeck.value="";
			document.forms[0].mischeck.focus();
			return;
		}
			else if(varRmdUsr!="1")
		{
			document.forms[0].mischeck.value="Y";
		}
	}
	<%}else if(!strProposalType.equalsIgnoreCase("P"))
	{%>
	if(document.forms[0].appstatus.value=="Open/Pending"){
			if(varRmdUsr!="1"&& document.forms[0].mischeck.checked==false)
		{
				ShowAlert(111,"  Kindly verify MIS and its related classification and then tick the check box 'I have checked MIS details and its related classification for all facilities and  found correct' in Workflow - action tab");
			document.forms[0].mischeck.value="";
			document.forms[0].mischeck.focus();
			return;
		}
			else if(varRmdUsr!="1")
		{
			document.forms[0].mischeck.value="Y";
		}

		if(varStagewiseFlag!="Y" && "<%=strPrdType%>"!="pR" && "<%=strPrdType%>"!="pG")
			{
				alert("Kindly Enter whether TL/DPN is released stage wise in Appraisal - Terms of Repayment tab for Retail module and Repayment Schedule - Terms of Repayment tab for Corporate/Agri Module");
				return;
			}
			
			
	}
			
	<%}%>
	<%if(strSessionModuleType.equalsIgnoreCase("RET")){%>
	<% if(!APP_LOANSUBTYPE_DIGI.equalsIgnoreCase("pR")) {%>
	<%if((strPrdtype.equalsIgnoreCase("pH"))|| (strPrdtype.equalsIgnoreCase("pA")&& (prd_purpose.equalsIgnoreCase("N")||prd_purpose.equalsIgnoreCase("U"))))
	{%>
	<%if(strProposalType.equalsIgnoreCase("F")||strProposalType.equalsIgnoreCase("R")){%>
	
	
	<%}}}}%>
	<%if(strSessionModuleType.equalsIgnoreCase("RET")){%>
	<%if(!strProposalType.equalsIgnoreCase("P")){%>
		if(document.forms[0].appstatus.value=="Open/Pending"){
			 if(document.forms[0].hidmsmeretchk.value=="Y"||document.forms[0].hidcarpetchk.value=="Y"||document.forms[0].hidproposedshgchk.value=="Y"||document.forms[0].hidretmisminority.value=="Y"){
				alert("Please Reselect the Activity Code in MIS Details page");
				return;
		       }
		}
		<%}else if(strParams.contains("@MIS@")){%>
		if(document.forms[0].appstatus.value=="Open/Pending"){
			 if(document.forms[0].hidmsmeretchk.value=="Y"||document.forms[0].hidcarpetchk.value=="Y"||document.forms[0].hidproposedshgchk.value=="Y"||document.forms[0].hidretpostmisminority.value=="Y"){
				alert("Please Reselect the Activity Code in MIS Details page");
				return;
		       }
		}
		<%}
	}%>

		<% if(strSessionModuleType.equalsIgnoreCase("CORP")||strSessionModuleType.equalsIgnoreCase("AGR"))
		{%>
		<%if(!strProposalType.equalsIgnoreCase("P")){%>
		if(document.forms[0].appstatus.value=="Open/Pending"){
			 if(document.forms[0].hidmsmeretchk.value=="Y"||document.forms[0].hidcarpetchk.value=="Y"||document.forms[0].hidproposedshgchk.value=="Y"||document.forms[0].hidcorpmisminority.value=="Y"){
				alert("Please Reselect the Activity Code in MIS Details page");
				return;
		       }
		}
		<%}else if(strParams.contains("@MIS@")){%>
		if(document.forms[0].appstatus.value=="Open/Pending"){
			 if(document.forms[0].hidmsmeretchk.value=="Y"||document.forms[0].hidcarpetchk.value=="Y"||document.forms[0].hidproposedshgchk.value=="Y"||document.forms[0].hidcorppostmisminority.value=="Y"){
				alert("Please Reselect the Activity Code in MIS Details page");
				return;
		       }
		}
		<%}
		}%>	<%if (!strProposalType.equalsIgnoreCase("P")) {%>
	if(varSvanidhi!="Y"){
			if(varmsmefalg=="Y"&& (document.forms[0].appstatus.value=="Open/Pending")){
					if(varmsmepanno=="" || varmsmepanno=="NOPAN" )
					{
						  alert("Please Update PANNO in Customer Profile -> Demographics tab");
						  return;
					}
					
				    if(varmsmeudyamregno=="")
				    {
						alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
				          return;
				   }  
				    else
				    {
				    	var udyamchar = varmsmeudyamregno;
				    	var capudyamchar=udyamchar.toUpperCase();
				    	if(capudyamchar.length==19)
				    	{
				    	for (var i = 0; i < capudyamchar.length; i++) {
				    	
				    		  if(capudyamchar.charAt(0)!='U')
				    		  {
					    		 
				    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
                                    return;
					    		  
				    		  }
				    		  if(capudyamchar.charAt(1)!='D')
				    		  {
				    			 
				    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
                                  return; 
				    			 
				    		  }
				    		  if(capudyamchar.charAt(2)!='Y')
				    		  {
				    			  
				    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
                                     return;
				    			 
				    		  }
				    		  if(capudyamchar.charAt(3)!='A')
				    		  {
				    			  
				    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
                                   return;
				    			 
				    		  }
				    		  if(capudyamchar.charAt(4)!='M')
				    		  {
				    			 
				    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
                                  return;  
				    		  }
				    		  if(capudyamchar.charAt(5)!='-')
				    		  {
				    			 
				    			 alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
                                return;    
				    			 
				    		  }
				    		  if(capudyamchar.charAt(6))
				    		  {
				    			  var code = capudyamchar.charCodeAt(6);
				    			  if(!(code>=65 && code<=90))
				    			  {
				    				 
					    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
	                                   return; 
				    			  }
				    		  }
				    		  if(capudyamchar.charAt(7))
				    		  {
				    			  var code = capudyamchar.charCodeAt(7);
				    			  if(!(code>=65 && code<=90))
				    			  {
				    				  
					    			 alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
	                                return;     
				    			  }
				    		  }
				    		  if(capudyamchar.charAt(8)!='-')
				    		  {
				    			 
				    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
                                   return;
				    			 
				    		  }
				    		  if(capudyamchar.charAt(9))
				    		  {
				    			  var code = capudyamchar.charCodeAt(9);
				    			  if(!(code>=48 && code<=57))
				    			  {
				    				 
					    			 alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
	                                return;    
				    			  }
				    		  }
				    		  if(capudyamchar.charAt(10))
				    		  {
				    			  var code = capudyamchar.charCodeAt(10);
				    			  if(!(code>=48 && code<=57))
				    			  {
				    				  
					    			 alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
	                                  return;  
				    			  }
				    		  }
				    		  if(capudyamchar.charAt(11)!='-')
				    		  {
				    			 
				    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
                                  return;  
				    		  }
				    		  if(capudyamchar.charAt(12))
				    		  {
				    			  var code = capudyamchar.charCodeAt(12);
				    			  if(!(code>=48 && code<=57))
				    			  {
				    				 
					    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
	                                    return;
				    			  }
				    		  }
				    		  if(capudyamchar.charAt(13))
				    		  {
				    			  var code = capudyamchar.charCodeAt(13);
				    			  if(!(code>=48 && code<=57))
				    			  {
				    				  
					    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
	                                  return;   
				    			  }
				    		  }
				    		  if(capudyamchar.charAt(14))
				    		  {
				    			  var code = capudyamchar.charCodeAt(14);
				    			  if(!(code>=48 && code<=57))
				    			  {
				    				 
					    			 alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
	                                 return;   
				    			  }
				    		  }
				    		  if(capudyamchar.charAt(15))
				    		  {
				    			  var code = capudyamchar.charCodeAt(15);
				    			  if(!(code>=48 && code<=57))
				    			  {
				    				 
					    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
	                                  return;  
				    			  }
				    		  }
				    		  if(capudyamchar.charAt(16))
				    		  {
				    			  var code = capudyamchar.charCodeAt(16);
				    			  if(!(code>=48 && code<=57))
				    			  {
				    				
					    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
	                                   return; 
				    			  }
				    		  }
				    		  if(capudyamchar.charAt(17))
				    		  {
				    			  var code = capudyamchar.charCodeAt(17);
				    			  if(!(code>=48 && code<=57))
				    			  {
				    				
					    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
	                                 return;
				    			  }
				    		  }
				    		  if(capudyamchar.charAt(18))
				    		  {
				    			  var code = capudyamchar.charCodeAt(18);
				    			  if(!(code>=48 && code<=57))
				    			  {
				    				 
					    			 alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
	                                  return;  
				    			  }
				    		  }
				    		 
				    		  
				    		  
				    			  
				    		  
				    			  
				    		}
				    	}
				    	else
				    	{
				    	
			    			 alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
                          return;
				    	}
				    }
					if(varmsmeclassification==""||varmsmeclassification=="0" )
					{
						alert("Please Update MSME Classification as per Udyam Registration Certificate in Customer Profile -> Demographics tab");
						return;
					}
					if(varmsmecertificationdate=="" )
					{
					 	 alert("Please Update Udyam Certification Date in Customer Profile -> Demographics tab");
						 return;
				    }
					/*if(!(varGSTReg=="Y" ||(varGSTReg=="N" && varGSTExempted=="Y")))
					{
						alert("Please Update GST Registration No/Exempted Details in Customer Profile -> Demographics tab");
						return;
					}*/
									
				 }
	}
			<%} else if (strParams.contains("@MIS@")) {%>
			if(varSvanidhi!="Y"){
			if(varmsmefalg=="Y" && varmsmepostsancdate=="Y" &&  document.forms[0].appstatus.value=="Open/Pending"){
				if(varmsmepanno=="" || varmsmepanno=="NOPAN" )
				{
					  alert("Please Update PANNO in Customer Profile -> Demographics tab");
					  return;
				}
				
			    if(varmsmeudyamregno=="")
			    {
					alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
			          return;
			   }  
			    else
			    {
			    	var udyamchar = varmsmeudyamregno;
			    	var capudyamchar=udyamchar.toUpperCase();
			    	if(capudyamchar.length==19)
			    	{
			    	for (var i = 0; i < capudyamchar.length; i++) {
			    	
			    		  if(capudyamchar.charAt(0)!='U')
			    		  {
				    		 
			    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
                                return;
				    		  
			    		  }
			    		  if(capudyamchar.charAt(1)!='D')
			    		  {
			    			 
			    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
                              return; 
			    			 
			    		  }
			    		  if(capudyamchar.charAt(2)!='Y')
			    		  {
			    			  
			    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
                                 return;
			    			 
			    		  }
			    		  if(capudyamchar.charAt(3)!='A')
			    		  {
			    			  
			    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
                               return;
			    			 
			    		  }
			    		  if(capudyamchar.charAt(4)!='M')
			    		  {
			    			 
			    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
                              return;  
			    		  }
			    		  if(capudyamchar.charAt(5)!='-')
			    		  {
			    			 
			    			 alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
                            return;    
			    			 
			    		  }
			    		  if(capudyamchar.charAt(6))
			    		  {
			    			  var code = capudyamchar.charCodeAt(6);
			    			  if(!(code>=65 && code<=90))
			    			  {
			    				 
				    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
                                   return; 
			    			  }
			    		  }
			    		  if(capudyamchar.charAt(7))
			    		  {
			    			  var code = capudyamchar.charCodeAt(7);
			    			  if(!(code>=65 && code<=90))
			    			  {
			    				  
				    			 alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
                                return;     
			    			  }
			    		  }
			    		  if(capudyamchar.charAt(8)!='-')
			    		  {
			    			 
			    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
                               return;
			    			 
			    		  }
			    		  if(capudyamchar.charAt(9))
			    		  {
			    			  var code = capudyamchar.charCodeAt(9);
			    			  if(!(code>=48 && code<=57))
			    			  {
			    				 
				    			 alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
                                return;    
			    			  }
			    		  }
			    		  if(capudyamchar.charAt(10))
			    		  {
			    			  var code = capudyamchar.charCodeAt(10);
			    			  if(!(code>=48 && code<=57))
			    			  {
			    				  
				    			 alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
                                  return;  
			    			  }
			    		  }
			    		  if(capudyamchar.charAt(11)!='-')
			    		  {
			    			 
			    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
                              return;  
			    		  }
			    		  if(capudyamchar.charAt(12))
			    		  {
			    			  var code = capudyamchar.charCodeAt(12);
			    			  if(!(code>=48 && code<=57))
			    			  {
			    				 
				    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
                                    return;
			    			  }
			    		  }
			    		  if(capudyamchar.charAt(13))
			    		  {
			    			  var code = capudyamchar.charCodeAt(13);
			    			  if(!(code>=48 && code<=57))
			    			  {
			    				  
				    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
                                  return;   
			    			  }
			    		  }
			    		  if(capudyamchar.charAt(14))
			    		  {
			    			  var code = capudyamchar.charCodeAt(14);
			    			  if(!(code>=48 && code<=57))
			    			  {
			    				 
				    			 alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
                                 return;   
			    			  }
			    		  }
			    		  if(capudyamchar.charAt(15))
			    		  {
			    			  var code = capudyamchar.charCodeAt(15);
			    			  if(!(code>=48 && code<=57))
			    			  {
			    				 
				    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
                                  return;  
			    			  }
			    		  }
			    		  if(capudyamchar.charAt(16))
			    		  {
			    			  var code = capudyamchar.charCodeAt(16);
			    			  if(!(code>=48 && code<=57))
			    			  {
			    				
				    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
                                   return; 
			    			  }
			    		  }
			    		  if(capudyamchar.charAt(17))
			    		  {
			    			  var code = capudyamchar.charCodeAt(17);
			    			  if(!(code>=48 && code<=57))
			    			  {
			    				
				    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
                                 return;
			    			  }
			    		  }
			    		  if(capudyamchar.charAt(18))
			    		  {
			    			  var code = capudyamchar.charCodeAt(18);
			    			  if(!(code>=48 && code<=57))
			    			  {
			    				 
				    			 alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
                                  return;  
			    			  }
			    		  }
			    		 
			    		  
			    		  
			    			  
			    		  
			    			  
			    		}
			    	}
			    	else
			    	{
			    	
		    			 alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
                      return;
			    	}
			    }
			    if(varmsmecertificationdate=="" )
				{
				 	 alert("Please Update Udyam Certification Date in Customer Profile -> Demographics tab");
					 return;
			    }
				if(varmsmeclassification==""||varmsmeclassification=="0" )
				{
					alert("Please Update MSME Classification as per Udyam Registration Certificate in Customer Profile -> Demographics tab");
					return;
				}
				/*if(!(varGSTReg=="Y" ||(varGSTReg=="N" && varGSTExempted=="Y")))
				{
					alert("Please Update GST Registration No/Exempted Details in Customer Profile -> Demographics tab");
					return;
				}*/
					

				 }
			}
			<%}%>
			<%if (!strProposalType.equalsIgnoreCase("P") && !strProposalType.equalsIgnoreCase("S")) {%>
			<% if(strSessionModuleType.equalsIgnoreCase("CORP"))
			{%>
			if((document.forms[0].hidgecl3propstatus.value=="Y" && document.forms[0].hidgecl2propstatus.value=="Y")&& (document.forms[0].appstatus.value=="Open/Pending")){
				alert("Already sanctioned GECL-3 facility exists for this borrower hence user cannot proceed with GECL-1 or GECL-2");
				return;
			}
			if((document.forms[0].hidgecl3propstatus.value=="Y" && document.forms[0].hidgecl1propstatus.value=="Y")&& (document.forms[0].appstatus.value=="Open/Pending")){
				alert("Already sanctioned GECL-3 facility exists for this borrower hence user cannot proceed with GECL-1 or GECL-2");
				return;
			}
			<%}}%>
			<%if (strProposalType.equalsIgnoreCase("S")) {%>
			<% if(strSessionModuleType.equalsIgnoreCase("CORP"))
			{%>
			if((varrestasschk!="Y" && varrestassesmandatory=="Y" && vargecltype=="GECL1") && (document.forms[0].appstatus.value=="Open/Pending")){
				alert("Please  enter the details in Assesment for KBL GECL tab Details.");
					return;
					}

			if(((vargecl3restructure=="Y" || vargecl3restructurebybrw=="Y")&& vargecltype=="GECL1") && (document.forms[0].appstatus.value=="Open/Pending")){
				alert("Already sanctioned GECL-3 facility exists for this borrower hence user cannot proceed with GECL1-Restructure");
				return;
			}
			if(((vargecl1restructure=="Y"|| vargecl1restructurecheck=="Y") && vargecltype=="GECL1") && (document.forms[0].appstatus.value=="Open/Pending")){
				alert("Please re enter the details in Assesment for KBL GECL tab Details.");
				return;
				}
			<%}}%>
			if(strPrdType=="pR" && document.forms[0].appstatus.value=="Open/Pending")
			{
				if(vardepmetdatechk=="Y"){
					alert("Selected deposit due date is already over. Kindly make necessary modifications in FINACLE and then re select the deposit in LAPS->"+vardepostaccno);
					return;
				}
			}
			<% if(strSessionModuleType.equalsIgnoreCase("CORP")||strSessionModuleType.equalsIgnoreCase("AGR"))
			{%>
			if((varbankingarrangemnet=="Y" && varsolechk=="N")&& (document.forms[0].appstatus.value=="Open/Pending")){
				alert(" Proposed Banking arrangement  type is other than sole in facilitied Tab  then  Banking Arrangement Tab Banking Arrangement ment Type also Should be other than sole");
					return;
				} 
			if(varbankingarrangemnet=="Y"){
			if((varwcmandatorychk=="N")&& (document.forms[0].appstatus.value=="Open/Pending")){
				if(varwctype=="C"){
					alert("Please Enter Values in Consortium Details for WC ->Banking Arrangement tab ->Consortium Details for WC Tab");
								return;
					}else if(varwctype=="M"){
					alert("Please Enter Values in Multiple Banking Details for WC ->Banking Arrangement tab ->Multiple Banking Details for WC Tab");
						return;
				}
				} 
			if((vartlmandatorychk=="N")&& (document.forms[0].appstatus.value=="Open/Pending")){
				if(vartltype=="C"){
					alert(" Please Enter Values in Consortium Details for TL ->Banking Arrangement tab ->Consortium Details for TL Tab");
					return;
					}else if(vartltype=="M"){
						alert("Please Enter Values in Multiple Banking Details for TL ->Banking Arrangement tab ->Multiple Banking Details for TL Tab");
						return;
					}
				} 
				}
			if(varbankargmultwcconschk=="Y" && (document.forms[0].appstatus.value=="Open/Pending")){
				alert("\n In Banking arrangement Consortium type number of consortium is given as "+varwccount+"but entry is not available for each consortium type in consortium details tab");

				return;
				}
			if(varbankargmulttlconschk=="Y" && (document.forms[0].appstatus.value=="Open/Pending")){
				alert("\n In Banking arrangement Consortium type number of consortium is given as "+vartlcount+"but entry is not available for each consortium type in consortium details tab");
				return;
				}
			 <%if(strProposalType.equalsIgnoreCase("P")){%>
				
				/*if(document.forms[0].appstatus.value=="Open/Pending")
				{
				if(varbankingarrangemnet=="N" && ((varwctype=="M" ||varwctype=="C") || (vartltype=="M" ||vartltype=="C"))){
							alert("Kindly remove and add the banking arrangement Tab ");
						return;
				}
				if((varbankingarrangemnet=="N") && (varwcmandatorychk=="Y" ||vartlmandatorychk=="Y")){
							alert("Kindly Delete  Multiple Banking Details/Consortium Banking details tab and reenter Multiple Banking Details/Consortium Banking details to proceed further ");
						return;
				}
				
				}*/
				<%}%>
			<%}%>
			if(varListCompany=='Y' && varCIN!="" ){ 
				if(varCIN.charAt(0)=='L' && varCIN.length=="21"){	
			if(document.forms[0].chk_dec.checked==false){
				 alert("Please check the Declaration for Listed Company to proceed");
				 return;
			}}}
			<%if(strSessionModuleType.equalsIgnoreCase("LAD"))
             {%>
             strPrdType=="pG"
			if (perJaCbsId==perCbsId)
			{
				alert("The said "+perFname+" is introduced by Jewel appraisal "+perJaName+" & "+perCbsId);
				
			}
             <%}%>
           /*  if(strSessionModuleType=="AGR")
     		{
            	 
            	if(varSchemecode=="074")
            	{		
     			if(document.forms[0].appstatus.value=="Open/Pending")
     			{
     				if(varenwrdetails=="N"){
     		    	  	alert("Please enter the details in eNWR tab.");
     					return;
     		       	}
     				
     				if(varenwrassessmentval=="N"){
     		    	  	alert("Please enter the details in Assessment for KBL e- Krishik Bhandar tab.");
     					return;
     		       	}
     			}
            	}
     		}*/
     		
            
             
             
             
			
	document.forms[0].cmdsend.disabled=true;
	document.forms[0].hidSourceUrl.value="/action/appworkflowaction.jsp"; 
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanGetMethod.value="getAction";
	document.forms[0].hidBeanMethod.value="updateAction";
	document.forms[0].hidAction.value="send";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doClose()
{
	if("<%=strPgDist%>"=="P")
	{
		if(ConfirmMsg(100))
		{
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/retailpge.jsp";
			document.forms[0].submit();
		}
	}
	var cattype=document.forms[0].cattype.value;
    if(cattype=="OPS")
    {
    	if(ConfirmMsg(100))
	 	{
			document.forms[0].action=appURL+"action/agrborrowersearch.jsp";
		 	document.forms[0].submit();
	 	}
	}
	if((cattype=="SSI")||(cattype=="CORP")||(cattype=="SME")||(cattype=="SRE")||(cattype=="STL")||(cattype=="ADC"))
    {
    	if(ConfirmMsg(100))
	 	{
			document.forms[0].action=appURL+"action/corppge.jsp";
		 	document.forms[0].submit();
	 	}
	}	
}
function doDropped()
{
	
	if(strRejectReasonsFlag=="0")
	{
		strRejectReasonsFlag="1";
		var appno=document.forms[0].appno1.value;
	   	var prop = "scrollbars=no,width=500,height=350,top=100,left=250";
		var url=appURL+"action/rejectreasonslist.jsp?hidBeanGetMethod=getRejectReasonMasterList&hidBeanMethod=updateReject&appno="+appno;
		window.open(url,"",prop);	
		return;	
	}
	showProgress('imgloading');
	window.scrollTo(0, 0);
	document.forms[0].cmddropped.disabled=true;
	document.forms[0].hidAction.value="reject";
	document.forms[0].hidBeanMethod.value="updateAction";
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanGetMethod.value="getHistory";
	document.forms[0].hidSourceUrl.value="/action/appworkflowhistory.jsp"; 
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doUndo()
{
	document.forms[0].hidAction.value="undo";
	document.forms[0].hidBeanMethod.value="updateAction";
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanGetMethod.value="getHistory";
	document.forms[0].hidSourceUrl.value="/action/appworkflowhistory.jsp"; 
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doSanction()
{
	//alert(varDigiLoanType);
	var strReasonStatus="<%=Helper.correctNull((String)hshValues.get("strReasonStatus"))%>";
	if(varDigiLoanType=="" || strSessionModuleType!="DIGI")
	{
		<%if(COM_BANKSCHEME.equalsIgnoreCase("052")){%>	
		if((strSessionModuleType=="AGR" || strSessionModuleType=="CORP" || strSessionModuleType=="RET") && document.forms[0].appstatus.value=="Open/Pending")
		{
			<%if((strPrdtype.equalsIgnoreCase("pH"))|| (strPrdtype.equalsIgnoreCase("pA")&& (prd_purpose.equalsIgnoreCase("N")||prd_purpose.equalsIgnoreCase("U"))))
			{%>
			if(parseFloat(userclass)>=50)
			{
				if(strReasonStatus=="N")
				{
					alert("Please enter Values in Appraisal -> Assessment-Cost -> Reason for Manual Processing");
					return;
				}
			}
			<%}%>
		}
		<%}%>
	}
		
	if(strSessionModuleType=="RET" && document.forms[0].appstatus.value=="Open/Pending")
	{
	if(varhousingloanchk !="0")
		{
		alert("Required margin is inadequate as per the circular HO:CREDIT:CIRCULAR:GF:07:37:2019-20 dated 04.11.2019 Either loan amount to be reduced or borrower has to service the interest during the moratorium");
		return;
		}
	}
	
	var varSchemecode="<%=Helper.correctNull((String)hshValues.get("strschemecode"))%>";
	if(varSchemecode=="069" && document.forms[0].hidaadharchek.value=="N" && document.forms[0].hidmisactivittycodencgtcchk.value=="Y")
	{
		alert("Please fill Udyog Aadhaar Number in Customer Profile");
		return;
	}	
	var varchiefpromotercheck="<%=Helper.correctNull((String)hshValues.get("COMAPP_CHF_PROMOTER"))%>";
	if(varSchemecode=="069" && varchiefpromotercheck=="N")
	{
		alert("For this scheme Cheif Promoter is mandatory.  Kindly select atleast onein Customer Profile-Groups/Management Peoples tab");
		return;
	}
	var metrocheck="";
	metrocheck="<%=Helper.correctNull((String)hshValues.get("CORP_METROPROJECT"))%>";
	if(varSchemecode=="069" && metrocheck=="1")
	{
		alert("This scheme is not available for Metropolitan cities.  Kindly modify the same in KBL Aarogya tab");
		return;
	}
	<% if(strSessionModuleType.equalsIgnoreCase("CORP") || strSessionModuleType.equalsIgnoreCase("AGR"))
	{%>

	if(document.forms[0].sel_facility.value=="s" || document.forms[0].sel_facility.value=="")
	{
		var varSchemecode1="<%=Helper.correctNull((String)hshValues.get("strschemecodevalue"))%>";
		var varmetroflagall="<%=Helper.correctNull((String)hshValues.get("CORP_METROPROJECT_FLAG"))%>";
		if(varSchemecode1=="069" && varmetroflagall=="1")
		{
			alert("This scheme is not available for Metropolitan cities.  Kindly modify the same in KBL Aarogya tab");
			return;
		}
		var varchiefpromotercheck="<%=Helper.correctNull((String)hshValues.get("COMAPP_CHF_PROMOTER"))%>";
	
		if(varSchemecode1=="069" && varchiefpromotercheck=="N")
		{
			alert("For this scheme Cheif Promoter is mandatory.  Kindly select atleast onein Customer Profile-Groups/Management Peoples tab");
			return;
		}
		var aadharchekflag="<%=Helper.correctNull((String)hshValues.get("aadharchekflag"))%>";
	
		var misactivittycodencgtcchkflag="<%=Helper.correctNull((String)hshValues.get("misactivittycodencgtcchkflag"))%>";
		
		if(varSchemecode1=="069" && aadharchekflag=="N")
		{
			alert("Please fill Udyog Aadhaar Number in Customer Profile");
			return;
		}		
	}
	<%}%>
	if(vargecl4count=="N" && vargelc4exposurecunt=="Y"){
		alert("Branch to ensure that atleast one facility is released as on 31/03/2021");
		return;
		}
	if((strSessionModuleType=="AGR"||strSessionModuleType=="CORP")&&(varProposalType=="S"))
	{
		if(varresttenorchk=="Y"){
		 alert("Repayment Tenor exceeding the maximum period of 120 months or Holiday period should be not be greater than 24 months");
			return;
			}
	}
	if(varProposalType=="S" && document.forms[0].appstatus.value=="Open/Pending" && (strSessionModuleType=="AGR"||strSessionModuleType=="CORP"))
	{
		if(varrestschemechk=="Y" && varrestchk =="N"){
			alert("mismatch of activity of the borrower captured in Restructure settlement scheme framework 2.0");
			return;
			}
	}
	/*if((strSessionModuleType=="AGR"||strSessionModuleType=="CORP")&&(varProposalType=="S"))
	{
		if(varresttenorchk=="Y"){
		 alert("Repayment Tenor exceeding the maximum period of 120 months");
		 return;
		}
	}*/
	if((strSessionModuleType=="AGR"||strSessionModuleType=="CORP")&&(varProposalType=="S"))
	{
		if(document.forms[0].appstatus.value=="Open/Pending"){
			if(varcorprestructureval=="Y" && varrestructurechk=="N"){
				alert("Please enter the details in Assesment for Eligibility under Restructure tab Details.");
				return;
			}
		}
	}
	if((strSessionModuleType=="RET")&&(varProposalType=="S"))
	{
		if(document.forms[0].appstatus.value=="Open/Pending"){
			if(varretrestructureval=="Y" && varrestructurechk=="N"){
				alert("Please Enter Values in Appraisal -> Loan Details ->Eligibility Under Restructure Tab Details");
				return;
			}
		}
	}
	if((postSanctionFlag =="EOP" || postSanctionFlag =="NEW" )&& (insertedParamters!="" && varstrFacSno!="0")){
	    alert("Post Sanction Parameters "+insertedParamters+"  marked as disabled in setup.Kindly delete the facilitiy and Proceed");
	   return;
			}
	if(strPrdType=="pG" && document.forms[0].appstatus.value=="Open/Pending")
	{
		if(parseFloat(vargoldloantotsanction_amount)>parseFloat(varsancPowerTotal))
		{
			 
				 alert("Delegated power under Gold Loan per borrower exceeds the maximum limit  -> "+varsancPowerTotal+"  hence cannot be sanctioned");
				 return;
			 
		}
	}
	if(strPrdType=="pR" && document.forms[0].appstatus.value=="Open/Pending")
	{
		if(parseFloat(vardepositloantotsanction_amount)>parseFloat(varsancPowerTotal))
		{
			 
				 alert("Delegated power under Deposit Loan per borrower exceeds the maximum limit -> "+varsancPowerTotal+"  hence cannot be sanctioned");
				 return;
		
		}
	}

	if(varDigiLoanType=="PC"){
			if(varVERICHKBOXVALUE!="Y" || varVERICHKBOXCOAPPVALUE!="Y")
			{
				alert("Please fill Verification Tab");
				return;	
			}
	
			if(varPerCbsId=="")
			{
				alert("Please update CBSId");
				return;
			}
		}
	if(varDigiLoanType=="PC")
	{

	
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanMethod.value="msmeInPrinciple";
		document.forms[0].hidBeanGetMethod.value="getHistory";
		document.forms[0].hidSourceUrl.value="/action/appworkflowhistory.jsp"; 
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
	
	if(document.forms[0].appstatus.value=="Open/Pending"){
	if(varFacAdhocDet!="")
	{
		//alert(varFacAdhocDet);
		alert("MIS activity Code and Original Investment in Equipments/Cost of Vehicles Used in Business should be same for Regular Limit and Adhoc/Additional Limit");
		return;
	}
	}
	<%if(strParams.equalsIgnoreCase("@CHDCCO@")||strParams.equalsIgnoreCase("@DCCO@"))
	{%>
		if(varDrawDownFlag=="No")
		{
			 alert("Please fill Draw Down Schedule for Project Loans");
			    return;
		}
	<%}else if(!strProposalType.equalsIgnoreCase("P"))
	{%>
		if(varDrawDownFlag=="No")
		{
			 alert("Please fill Draw Down Schedule for Project Loans");
			    return;
		}
	<%}%>
			
	<%if(!strProposalType.equalsIgnoreCase("P")){%>

	if(strStandupCheck=="No"){
	    alert("Please reviste the customer profile");
	    return;
	}
	
	if(strSessionModuleType=="RET" || strSessionModuleType=="LAD")
	{
		if(loan_roiType!="" && loan_roiType!="O")
		{
			if(loan_ROIscore!=varscoreVal)
			{
				if(loan_roiType=="RATING")
				{
					alert("Risk Score value changed. Please reselect the product in Loan Particulars tab for Interest Recalculation");
				}
				else
				{
					alert("CIBIL/CRIF Score value modified in Customer Profile. Please reselect the product in Loan Particulars tab for Interest Recalculation");
				}
				return;
			}
		}
	}
	else
	{
		if(varMMithra=="N")
		{
			alert("Agriculture Industry Service Category should be MICRO (Service/Manufacturing) Enterprises  for Micro Mithra Scheme");
			return;
		}
		if(strFIDPNChk=="N")
		{
			alert("Kindly fill Interest DPN assessment Details for DPN facilities");
			return;
		}
		if(strFIDPNDet!="")
		{
			alert("Sanctioned amount under interest Defernment DPN 2020 is greater than MPBF amount in Assessment,\n "+strFIDPNDet);
			return;
		}
		if(eval(strAmount)<eval(strMithraFacTot))
		{
			alert("Total of Sanctioned amount under KBL Micro mitra is greater than MPBF amount in Assessment.");
			return;
		}
		
		<% if(strSessionModuleType.equalsIgnoreCase("CORP"))
		{%>
		if(document.forms[0].hidcgssdtypechk.value=="N")
		{
			alert("Please Enter All Facility Related Details in  CGSSD Assessment in Assessment for KBL CGSSD tab Details.");
			return;
		}
		if(document.forms[0].hidcgssdsanchk.value=="N")
		{
			alert("Amount applied for CGSSD  should not be greater than the  Proposed Limit in Assessment for KBL CGSSD tab Details.");
			return;
		}
		if(document.forms[0].appstatus.value=="Open/Pending" ){
			if(document.forms[0].hidcgssdpercchk.value=="N")
			{
				alert("Please re enter the details in Assessment for KBL CGSSD tab Details.");
				return;
			}
			if(document.forms[0].hidmisactivitycodechk.value=="N")
			{
				alert("activity code to be selected for all CGSSD facilities should be - 150599-Personal  Loans to Others only in->Mis Details Tab.");
				return;
			}
			if(vargeclavailable=="Y" && varGECLChk=="Y")
			{
			if(vargecl4loanamt=="Y" && vargecltype=="GECL4"){
				alert("Please re enter the details in Assesment for KBL GECL tab Details.");
			return;
			}
			}
			if(vargeclavailable=="Y" && varGECLChk!="Y")
			{
				alert("Please Fill Assessment -> Eligibility Criteria for KBL GECL scheme tab Details");
				return;
			}
			
			<%if(!strProposalType.equalsIgnoreCase("S") && !strProposalType.equalsIgnoreCase("P")  )
			{%>
			if(vargeclavailable=="Y" && varGECLAssChk!="Y")
			{
				alert("Please Fill Assessment for KBL GECL scheme tab Details");
				return;
			}
			<%}%>
		}
	<%}%>
		if(varSvanidhi=="Y" && strSvanidhiTerm!="Y")
		{
			alert("Please check the declaration details in Customer Profile -> Svanidhi Details tab");
			return;
		}
		
		/*if(varGECLFor!="" &&  varGECLFor!="3" && varConstitution=="01")
		{
			alert("Entered KBL GECL scheme Assessment is not Eligible for Individual");
			return;
		}*/
		
		if(eval(varDeviationcnt)>0)
		{
			if(confirm("Rating/CIBIL/CRIF Details has been modified.\n Do you agree to Re-enter facilities reference rate tab for those facilities?"))
			{
					showProgress('imgloading');
					window.scrollTo(0, 0);
					document.forms[0].hidSourceUrl.value="/action/appworkflowaction.jsp" 
					document.forms[0].hidBeanId.value="commworkflow";
					document.forms[0].hidBeanMethod.value="updateAction";
					document.forms[0].hidBeanGetMethod.value="getAction";
					document.forms[0].hidAction.value="IntDeviation";
					document.forms[0].action=appURL+"controllerservlet";
					document.forms[0].submit();
			}
			return;
				
		}

		if(varBureauchk=="No")
		{
			//alert("Please Check bureau for all Applicants");
			//return;
		}
	}
	/*if(NatureofActivity=="")
	{
		 alert("Please fill Nature of Activity in Customer Profile");	
		 return;
		
	}*/
	
	<%}%>
	<%if(!strProposalType.equalsIgnoreCase("P")){%>
	if(varLeadstatus=="N")
	{
		alert("Entered Lead no is not available in LMS");
		return;
	}
	else if(varLeadstatus!="" && varLeadstatus!="6")
	{
		alert("Status of the Lead number is not in 'In Process' status in LMS. Please update in LMS and then sanction the proposal.");
		return;
	}
	<%}%>
	if(varTermflag=="Y")
	{
		alert("Changes made in Terms & Conditions. \n Kindly revisit and select appropriate conditions for the proposal.");
		return;
	}
	if(varQueryStatus=="No")
	{
		alert("All the Queries yet to get the reply.Please Ensure all the queries are in Closed status.");
		return;
	}
	if(varPMAY=="Y" && varPmayhouse=="N")
	{
		alert("Please Enter PMAY Details in Loan Particulars tab");
		return;	
	}
	if(varPMAY=="Y")
	{
		if(varOwnedHouse=="Y")
		{
			alert("You cannot sanction.The Borrower has owned a house his/her name or family member's name in india.");
			return;
		}
		if(varFemaleownerReq=="Y" && varFemaleownerAvail=="")
		{
			//alert("Female Ownership Required for this scheme");
			//return;
		}
		if(varGovtscheme=="079")
		{
			if(eval(varCarpetAreaReq)<eval(varCarpetAreaAvail))
			{
				alert("Carpet Area should not be more than "+eval(varCarpetAreaReq)+" Sq.Mts");
				return;
			}
		}
		if(eval(varTenorReq)<eval(varTenorAvail))
		{
			//alert("Loan Tenor should not be more than "+eval(varTenorReq));
			//return;
		}
		if(parseInt(varPMAYValidFrom)<0)
		{
			alert("You cannot sanction this Proposal Under PMAY scheme.\n Scheme Yet to Start");
			return;
		}
		if(parseInt(varPMAYValidTo)>0)
		{
			alert("You cannot sanction this Proposal Under PMAY scheme.\n Scheme Validity Expired");
			return;
		}
	}
	<%if(strProposalType.equalsIgnoreCase("P")){%>
	if(varPostSancBranch=="true" && parseInt(userclass)>=85 && varUsrOrgLevel=="A")
	{
		//Branch sanction permitted
	}	
	else
	{
		if(varApp_Org_level=="false")
		{
			alert("The Authority doesn't have a rights to Sanction the proposal");
			return;
		}
	}
	<%}%>
	<%if(!strProposalType.equalsIgnoreCase("P")){%>
	if(varGuarantor_check=="N")
	{
		alert("You cannot sanction.The Guarantor/Co-Applicant details are not completed fully.");
		return;
	}
	if(varUpdSecFlag!="")
	{
		alert("There is a change in the value of security for the following ID("+varUpdSecFlag+").Kindly reattach the security to update the Security value");
		return;
	}
	if(varUnapprovedSecFlag!="")
	{
		alert("Unapproved/Disabled Company shares given as a security. Kindly Detach and Proceed further");
		return;
	}
	if(varShareExceeds!="")
	{
		alert("Maximum Lending Limit exceeds for the following Share Securities ("+varShareExceeds+").Kindly Detach the securities to proceed further");
		return;
	}
	if(varPhyLimitExceeds!="")
	{
		alert("Physical form of loan against share limit exceeds for this borrower");
		return;
	}
	if(varDematLimitExceeds!="")
	{
		alert("Demat form of loan against share limit exceeds for this borrower");
		return;
	}
	if(document.forms[0].appstatus.value=="Open/Pending")
	{
		if(varCFRverified=="N"||varCFRverified=="")
		{
			alert("Central Fraud Registry Verification is not done. you cannot sanction the proposal");
			return false;
		}
		if(eval(varBorrExp)>500000 && (varCFRverified=="N" || varCFRverified=="NA"))
		{
			alert("Since Borrower Exposure is more than 5lakhs, Central Fraud Registry verification is mandatory");
			return false;
		}
		if(varCFRverified=="Y" && varCFRborname=="Y" && varCFRAppjStatus=="R")
		{
			alert("You cannot sanction the proposal. Central Fraud Registry Deviation Rejected");
			return false;
		}
	}
	if(strSessionModuleType=="RET" || strSessionModuleType=="LAD")
	{
		if(varReselectprd=="Y")
		{
			alert("You aren't allowed for Sanction,Because Product is Not available for Users. \n Please Reselect the Product in Loan Particulars Tab");
			return;
		}
		if(varLARbankscheme!=varprdbankscheme)
		{
			alert("Product Bank Scheme differs from Attached LAR Bank Scheme.");
			return;
		}
		if((varRepayComments!="Y" && varrepaymenttype!="1") )
		{
			<%--if("<%=strPrdType%>"!="pR" && "<%=strPrdType%>"!="pV" && !(("<%=strPrdType%>"=="pM" || "<%=strPrdType%>"=="pI") && varPrdLoanType=="OD"))--%>
			{
				alert("Please Enter Comments in Appraisal -> Terms of Repayment tab");
				return;
			}
		}
		if(varBIRFlag!="Y")
		{
			alert("Please Fill Appraisal -> Background Information Report (BIR) tab");
			return;
		}
		if(varPRD_CGTMSE=="Y")
		{
			if(varCGTMSEFlag!="Y")
			{			
				alert("Please Fill CGTMSE COVERAGE in Loan Particulars tab");
				return;
			}
			if(varCGTMSEtotintrate=="Y")
			{
				alert("Total CGTMSE Interest rate should not exceed "+varparamval_CGTMSEint+"%");
				return;
			}

				if(strudyogadhorChk=="Y"){
					alert("Please fill Udyog Aadhaar Number in Customer Profile");
					return;
				}
			
			if(varCGTMSEcovLimit=="Y")
			{
				alert("CGTMSE Coverage of the borrower should not exceed "+varmaxcgtmseLimit);
				return;
			}
			
			if(parseFloat(varsanction_amount)>=parseFloat(500000))
			{
				 if(varCGPan=="" || varCGPan=="NOPAN")
				 {
					 alert("PAN is mandatory for loan amount of Rs.5 lakh and above for coverage under CGTMSE");
					 return;
				 }
			}
			if(var_AadharNo=="")
			{
				alert("Please fill Udyog Aadhaar Number in Customer Profile");	
				return false;
			} 

			if(NatureofActivity=="")
			{
				alert("Please fill Nature of Activity in Customer Profile");	
				return
			} 
			if(varConstitution!="01" && varchiefpromotercheck=="N")
			{
				alert("atleast one Cheif Promoter is mandatory.  Kindly select atleast one in Customer Profile-Groups/Management Peoples tab");
				return;
			}	

		}
		if(strPrdType=="pU" && varExposureChk=="F")
		{
			alert("Total Exposure Limit of the Borrower is "+varBorrowerExp+"\nIt should not exceeds 10 Lakhs");
			return;
		}
		//document attachment check
		if(strPrdType=="pA")
		{
			if(varDocAttach_Flag == "N")
			{
				alert("Please Attach Document in Documents Tab");
				return;	
			}
		}
	}
	else
	{

		<%if(arrSchemes!=null && arrSchemes.size()>0){
		for(int a=0;a<arrSchemes.size();a++){
		if(Helper.correctNull((String)arrSchemes.get(a)).equalsIgnoreCase("055")){%>
			if(varDocAttach_Flag == "N")
			{
				alert("Please Attach Document in Documents Tab");
				return;	
			}
		<%}}}%>
		if(varReselectprd=="Y")
		{
			alert("You aren't allowed for Sanction,Because Facility "+varReselectprdDesc+" is Not Available. \n Please Reselect the Facility in Facilities Tab");
			return;
		}
		if(!strSessionModuleType=="DIGI")
		{
			if(varTakeOverDetails=="N")
			{
				alert("Please Fill Take Over Tab");
				return;
			}
		}
		if(varTakeover=="N")
		{
			alert("Please Fill Take Over Norms Tab");
			return;
		}

		if(varBIRFlag!="Y" && (document.forms[0].appstatus.value=="Open/Pending" || document.forms[0].appstatus.value=="Open/Lodged"))
		{
			alert("Please Fill Due Diligence Report / BIR -> Background Information Report (BIR) tab");
			return;
		}
		
		if( varCropCGTMSE=="Y"  && (document.forms[0].appstatus.value=="Open/Pending" || document.forms[0].appstatus.value=="Open/Lodged"))
		{
if(varCGTMSEFlag!="Y")
		{
			alert("Please Fill CGTMSE COVERAGE in Facilities tab");
			return;
		}

			if(parseFloat(varCGLimit)>=parseFloat(500000))
			{
				 if(varCGPan=="" || varCGPan=="NOPAN" )
				 {
					 alert("PAN is mandatory for loan amount of Rs.5 lakh and above for coverage under CGTMSE");
					 return;
				 }
			}
			if(var_AadharNo=="")
			{
				alert("Please fill Udyog Aadhaar Number in Customer Profile");	
				return false;
			}

			if(NatureofActivity=="")
			{
				alert("Please fill Nature of Activity in Customer Profile");	
				return
			} 

			if(varCGTMSEcovLimit=="Y")
			{
				alert("CGTMSE Coverage of the borrower should not exceed "+varmaxcgtmseLimit);
				return;
			}
			if(varConstitution!="01" && varchiefpromotercheck=="N")
			{
				alert("atleast one Cheif Promoter is mandatory.  Kindly select atleast one in Customer Profile-Groups/Management Peoples tab");
				return;
			}
		}
	}

	if(strSessionModuleType=="CORP" ||strSessionModuleType=="AGR"){
		if( varPRD_CGTMSE=="Y"  && (document.forms[0].appstatus.value=="Open/Pending" || document.forms[0].appstatus.value=="Open/Lodged"))
		{
		     if(strCGTMSEtotintrate1=="Y")
				{
					alert("Total CGTMSE Interest rate should not exceed "+varparamval_CGTMSEint+"%");
					return;
				}

			if(strudyogadhorChk=="Y")
				{
						alert("Please fill Udyog Aadhaar Number in Customer Profile");
						return;
				}
	       }
	}
	if(varAppDocuments!="Y")
	{
		alert("Necessary documents not submitted by customer - Please check and change in Loan Application Register");
		return;
	}
	if(varMSME=="Y" && varMSMEFacility=="")
	{
		alert("Enter Check List for Documents for all KBL MSME schemes");
		return;
	}
	<%}%>
	if(varGuarantor_corp=="N")
	{
		alert("You cannot sanction.The Guarantor/Co-Applicant details are not completed fully.");
		return;
	}
	
	if(varBaseRateChkFlag == "Y" && varProposalType!="P")
	{
		alert("This Proposal Linked with Base Rate. So you cannot sanction the proposal, please do the necessary modifications.");
		return;
	}
	
	//Added by Guhan
	if(varSancRefNum == "N")
	{
		alert("Please enter the Sanction Reference Number");
		return;
	}
	
	
	//Added by Arsath for Loan Product Gross Rent check with Lease Details Gross Rent
	<%if(!strProposalType.equalsIgnoreCase("P")){%>
	if(varMISCODEFlag=="Y" && document.forms[0].appstatus.value=="Open/Pending")
	{
		alert("Please Reselect the Activity Code in MIS Details page-->"+varMISCODEDesc);
		return;
	}
	<%if (loan_type.equalsIgnoreCase("P")) {%>

	if(strPrdType=="pR"||strPrdType=="pG")
	{
		if((varDocumentReceived!="")&&(varDocumentReceived!="4") && (varAppEmployment!="4"))
		{
			alert("You are not Eligible to get Loan under Agriculture Scheme");
			return;
		}
		
	}
	
	if(strPrdType=="pL")
	{
		if(parseFloat(varloangross) > parseFloat(varleasegross))
		{
			alert("Monthly Gross Rent should not exceed Lease Gross Rent");
			return;
		}
	}
	if(strPrdType=="pG")
	{
		if(varJewelAppraiser!="Y")
		{
			alert("Please Fill Appraiser details in Gold Ornaments tab");
			return;
		}
	}
	if(strPrdType=="pU" && varshg_tallied=="N")
	{
		alert("Proposed Loan Amount is not tallied with the amount shared among the SHG members");
		return;
	}
	if(strPrdType=="pR" && document.forms[0].appstatus.value=="Open/Pending")
	{
		if(vardepmetdatechk=="Y"){
			alert("Selected deposit due date is already over. Kindly make necessary modifications in FINACLE and then re select the deposit in LAPS->"+vardepostaccno);
			return;
		}
	}
/*	if(varEligibilitychkflag=="N")
	{
		if(varStaffProduct!="Y" && strPrdType!="pJ")
		{
			alert("Applicant is not Eligible.Please check Eligibility");
			return;
		}
	}*/
	<%}%>
		<%}else if(strParams.contains("@MIS@")||strParams.contains("@SLILA@")){%>
	if(varMISCODEFlag=="Y" && document.forms[0].appstatus.value=="Open/Pending")
	{
		alert("Please Reselect the Activity Code in MIS Details page-->"+varMISCODEDesc);
		return;
	}
	<%}%>
		<%if(!(loan_type.equalsIgnoreCase("P"))){%>
		if(varshg_tallied=="N")
		{
			alert("Proposed Loan Amount is not tallied with the amount shared among the SHG members in facility sno "+varfac_not_tally);
			return;
		}
		if(strBrief=="True")
		{
			alert("Please Fill Basic Information Details");
			return;
		}	
		if(str_strmisaparam=="True")
		{
			alert("Please Enter All Facility Related Details in MIS / CBS Details Tab");
			return;
		}	
		<%}%>
		<%if(!strProposalType.equalsIgnoreCase("P")){%>
		var hidPage="Y";
		var typeCheck=strPrdType.substring(0,1);
		// For Corporate proposal 
		if(strSessionModuleType=="AGR" || strSessionModuleType=="CORP")
		{	
			if(varDigiLoanType!="PC" && (varDigiLoanType != "PR" && strPrdType !="pM" ))
				{	
					if(ratinggroup!="Y")
					{
			        	if(varRatingTabHideCorpAgr=="N" && varappcategory !="C")
			        	{
			            	if(varCreditFreezFlag=="Y" && varCreditRating!="")
			            	{
			        			if(varRmdUserCheckFlag=="N" && varNonPoolBasedRating=="Y")
			       				{
			        			alert("Please do the RMD rating before Sanction");
			        			return false;
			        			}
			            	}
			            	else
			            	{
			            		alert("Please do the rating before Sanction");
			            		return false;
			            	}
			           	}
			       	 }else{
			        	if(varRatingTabHideCorpAgr=="N" && varappcategory !="C")
			            {
							if(varRmdUserCheckFlag=="N"  && varNonPoolBasedRating=="Y")
							{
								alert("Please do the RMD rating before Sanction");
			        			return false;
							}
							else
							{
								if(varRatingCheck!="Y")
			       				{
			        			alert("Please do the rating before Sanction");
			        			return false;
			        			}
							}
						}
			       	 }
	      		 }
			/*if(parseFloat(varsanction_amount)>=parseFloat(500000))
			{
			if(varCGPan=="" || varCGPan=="NOPAN")
			{
				alert("PAN is mandatory for loan amount of Rs.5 lakh and above for coverage under CGTMSE");
				return;
			}}*/
			if(varInwardchk=="N")
			{
				alert("Govt. Sponser scheme and other related information of the Attached LAR should match with atleast one facility of this proposal");
				return;
			}
	    }
		if(document.forms[0].appstatus.value=="Open/Pending" && varAppraisedFlag!="Y")
		{
			alert("Select Appraised by User Details in Proposal Flow tab");
			return;
		}
		if(document.forms[0].appstatus.value=="Open/Pending" && varSanctionFlag!="Y")
		{
			alert("Select Sanctioned by User Details in Proposal Flow tab");
			return;
		}
	    <%}%>
		if(varapptype.toUpperCase()=="C" || varapptype.toUpperCase()=="A")
		{	
			if(varFACCHECK == "N")
			{
				alert("Approve/Reject individual facilities in Workflow ->  Proposed Facility Approve/Reject tab");				
				return;
			}
			if(varFACAPPROVECHECK != "Y")
			{
			    alert("You cannot Approve this application,Approve atleast one facility in Workflow ->  Proposed Facility Approve/Reject tab");				
				return;
			}
			if(varNEcheckflag=="N")
			{
				alert("Repayment EMI Amount does not tally for these facilities "+varNEFacdesc);
				return;	
			}
		}
		//For adhoc
		else if(varapptype.toUpperCase()=="H")
		{		
			if(varFACCHECK == "N")
			{
				alert("Approve/Reject individual facilities in Workflow ->  Proposed Facility Approve/Reject tab");				
				return;
			}
			if(varFACAPPROVECHECK != "Y")
			{
			    alert("You cannot Approve this application,Approve atleast one facility in Workflow -> Proposed Facility Approve/Reject tab");				
				return;
			}
		}
		//For Short TERM LOAN
		else if(varapptype.toUpperCase()=="U")
		{		
			if(varFACCHECK == "N")
			{
				alert("Approve/Reject individual facilities in Workflow -> Proposed Facility Approve/Reject tab");				
				return;
			}
			if(varFACAPPROVECHECK != "Y")
			{
			    alert("You cannot Approve this application,Approve atleast one facility in Workflow -> Proposed Facility Approve/Reject tab");				
				return;
			}
		}
		else if(varapptype.toUpperCase()=="P")//for Retail applications
		{
			var varAlerts="";
			if(document.forms[0].appraisalsanc.value!="Yes")
			{
				varAlerts="Cannot Approve this Application....\nPlease Enter Values in Appraisal -> Loan Details";
			}
			<%if(!strProposalType.equalsIgnoreCase("P")){%>
				if(varAppraisalQuest.toUpperCase()!="Y")
				{
					varAlerts=varAlerts+"\nPlease Enter Values in Appraisal -> Check List";
				}
			<%}%>
			if(varMISDetails.toUpperCase()!="Y")
			{
				varAlerts=varAlerts+"\nPlease Enter Values in MIS/CBS Details -> MIS Details";
			}
			if(varCBSDetails.toUpperCase()!="Y")
			{
				varAlerts=varAlerts+"\nPlease Enter Values in MIS/CBS Details -> CBS Details";
			}
			<%if(!strProposalType.equalsIgnoreCase("P")){%>
			if((varRatingflag =='Y') && ("<%=strPrdType%>"!="pR" && "<%=strPrdType%>"!="pG")
					 && (varDigiLoanType != "PR" && strPrdType !="pM" ))
			{
				if(ratinggroup!="Y")
				{
					if(varCreditFreezFlag!="Y" && varCreditRating=="")
					{
						varAlerts=varAlerts+"\nPlease do the rating before Sanction";
					}
				}else{
					if(varRatingCheck!="Y")
					{
						varAlerts=varAlerts+"\nPlease do the rating before Sanction";
					}
				}
			}
			if((strPrdType == 'pH' && varPrdPurpose!='T') || (strPrdType == 'pA'))
			{
			if(varSourceMargin != "Y")
			{
				varAlerts=varAlerts+"\nPlease Enter Values in Loan Particulars -> Source of Margin";
			}
			}
			<%}%>
			
			/*if(parseFloat(varsanction_amount)>=parseFloat(500000))
			{
			if(varCGPan=="" || varCGPan=="NOPAN" )
			{
				varAlerts=varAlerts+"\nPAN is mandatory for loan amount of Rs.5 lakh and above for coverage under CGTMSE";
			}}*/
			if(varAlerts!="")
			{
				alert(varAlerts);
				return;
			}

			
	
			if(varRNEcheckflag=="N" && (("<%=strPrdType%>"!="pR" && "<%=strPrdType%>"!="pG" && varPrdLoanType!="OD")||("<%=strPrdType%>"=="pG" && varrepaymenttype=="14")))
			{
				alert("Loan Amount & Installment amount should be tallied");
				return;	
			}
			
	/* By Guhan
	 		if((varIntrAmtFlag=="N")  && (strPrdType == 'pH' || strPrdType == 'pA')&& (varStaffProduct=="Y"))
			{
				alert("Interest Amount  and Installment amount for the Interest should be tallied");
				return;	
			}*/
		}

		<%if((strSessionModuleType.equalsIgnoreCase("RET")||strSessionModuleType.equalsIgnoreCase("LAD"))&& strParams.equalsIgnoreCase("@BRTOMCLR@")){%>
		varSecurityFlag="N";
		<%}%>
		if(varSecurityFlag!="N" && ("<%=strPrdType%>"!="pR" && "<%=strPrdType%>"!="pG"))
		{
			alert("Please Attach and freeze the Securities for this Proposal");
			return;
		}
		if(vardatavetting!="Y")
		{
			document.forms[0].hidvettingreq.value="TRUE";
			if(document.forms[0].sel_datavetting.value!="Y")
			{
				alert("Initial Vetting not done, So application cannot be approved");
				return;
			}
		}
		if(document.forms[0].sel_legalcomp.value=='S')
		{
			alert("Please select Legal Compliance Letter is needed");
			return false;
		}
				<%if(!strProposalType.equalsIgnoreCase("P")){%>
		if((strSessionModuleType=="AGR" || strSessionModuleType=="CORP")&&(document.forms[0].appstatus.value=="Open/Pending")){
		if(document.forms[0].sel_stock_audit.value=="S"||document.forms[0].sel_stock_audit.value=="")
		{
			ShowAlert(111,"Stock Audit");
			return;
		}	
		if(document.forms[0].sel_credit_audit.value=="S"||document.forms[0].sel_credit_audit.value=="")
		{
			ShowAlert(111,"Credit Audit");
			return;
		}
		}		
		
		<%}%>

		if(strSessionModuleType=="AGR" && varAgrSchemeType=="Y")
		{
			if(document.forms[0].txt_reviewdate.value=="")
			{
				alert("Enter Next Review Date");
				document.forms[0].txt_reviewdate.focus();
				return;
			}
		}
		<%if(strProposalType.equalsIgnoreCase("P")){
		if(strParams.contains("@GUAR@")||strParams.contains("@SEC@")||strParams.contains("@MARGIN@")||strParams.contains("@MODSEC@")){%>
		if(document.forms[0].sel_finalsanction.value=="")
		{
			alert("Please get the Approval of delegated authority for modification in Security or Guarantor");
			return;
		}
		else if(document.forms[0].sel_finalsanction.value=="N")
		{
			alert("Concerned authority rejected your proposal for the modification in Security or Guarantor");
			return;
		}
		<%}}%>
		<% if(strSessionModuleType=="CORP"||strSessionModuleType=="AGR")
		{%>
		if(document.forms[0].appstatus.value=="Open/Pending"){
		if(document.forms[0].hidintsubtypechk.value=="N")
		{	
			
				alert("Please Enter Values Facilities -> Other Interest Rates / Commission -> "+varFacDesc);
				return;
			
		}
		}
		<%}%>

		<%if(strParams.equalsIgnoreCase("@MIS@"))
		{%>
		if(document.forms[0].appstatus.value=="Open/Pending")
		{
			if(varRmdUsr!="1"&& document.forms[0].mischeck.checked==false)
			{
					ShowAlert(111,"Kindly verify MIS and its related classification and then tick the check box 'I have checked MIS details and its related classification for all facilities and  found correct' in Workflow - action tab");
				document.forms[0].mischeck.value="";
				document.forms[0].mischeck.focus();
				return;
			}
				else if(varRmdUsr!="1")
			{
				document.forms[0].mischeck.value="Y";
			}
		}
		<%}else if(!strProposalType.equalsIgnoreCase("P"))
		{%>
		if(document.forms[0].appstatus.value=="Open/Pending")
		{
			if(varRmdUsr!="1"&& document.forms[0].mischeck.checked==false)
			{
				ShowAlert(111,"MIS details and its related classification for all facilities and  found correct");
				document.forms[0].mischeck.value="";
				document.forms[0].mischeck.focus();
				return;
			}
			else if(varRmdUsr!="1")
			{
				document.forms[0].mischeck.value="Y";
			}

			if(varStagewiseFlag!="Y" && "<%=strPrdType%>"!="pR" && "<%=strPrdType%>"!="pG")
				{
					alert("Kindly Enter whether TL/DPN is released stage wise in Appraisal - Terms of Repayment tab for Retail module and Repayment Schedule - Terms of Repayment tab for Corporate/Agri Module");
					return;
				}


		}	
		<%}%>
		<%if(COM_BANKSCHEME.equalsIgnoreCase("052")){%>
		<%if(strSessionModuleType.equalsIgnoreCase("RET")){%>
		<% if(!APP_LOANSUBTYPE_DIGI.equalsIgnoreCase("pR")) {%>
		<%if((strPrdtype.equalsIgnoreCase("pH"))|| (strPrdtype.equalsIgnoreCase("pA")&& (prd_purpose.equalsIgnoreCase("N")||prd_purpose.equalsIgnoreCase("U"))))
		{%>
		<%if(strProposalType.equalsIgnoreCase("F")||strProposalType.equalsIgnoreCase("R")){%>
		
		if((parseInt(userclass)>=50) && (document.forms[0].appstatus.value=="Open/Pending"))	
			{
		      if(document.forms[0].hidreasonproccchk.value=="N"){
		    	  alert("Please Enter Values in Appraisal -> Reason For Manual Processing Tab");
					return;
			    	  
		       }
			}
		
		<%}}}}}%>


		

		<%if(strSessionModuleType.equalsIgnoreCase("RET")){%>
		<%if(!strProposalType.equalsIgnoreCase("P")){%>
			if(document.forms[0].appstatus.value=="Open/Pending"){
				 if(document.forms[0].hidmsmeretchk.value=="Y"||document.forms[0].hidcarpetchk.value=="Y"||document.forms[0].hidproposedshgchk.value=="Y"||document.forms[0].hidretmisminority.value=="Y"){
					alert("Please Reselect the Activity Code in MIS Details page");
					return;
			       }
			}
			<%}else if(strParams.contains("@MIS@")){%>
			if(document.forms[0].appstatus.value=="Open/Pending"){
				 if(document.forms[0].hidmsmeretchk.value=="Y"||document.forms[0].hidcarpetchk.value=="Y"||document.forms[0].hidproposedshgchk.value=="Y"||document.forms[0].hidretpostmisminority.value=="Y"){
					alert("Please Reselect the Activity Code in MIS Details page");
					return;
			       }
			}
			<%}
		}%>

			<% if(strSessionModuleType.equalsIgnoreCase("CORP")||strSessionModuleType.equalsIgnoreCase("AGR"))
			{%>
			<%if(!strProposalType.equalsIgnoreCase("P")){%>
			if(document.forms[0].appstatus.value=="Open/Pending"){
				 if(document.forms[0].hidmsmeretchk.value=="Y"||document.forms[0].hidcarpetchk.value=="Y"||document.forms[0].hidproposedshgchk.value=="Y"||document.forms[0].hidcorpmisminority.value=="Y"){
					alert("Please Reselect the Activity Code in MIS Details page");
					return;
			       }
			}
			<%}else if(strParams.contains("@MIS@")){%>
			if(document.forms[0].appstatus.value=="Open/Pending"){
				 if(document.forms[0].hidmsmeretchk.value=="Y"||document.forms[0].hidcarpetchk.value=="Y"||document.forms[0].hidproposedshgchk.value=="Y"||document.forms[0].hidcorppostmisminority.value=="Y"){
					alert("Please Reselect the Activity Code in MIS Details page");
					return;
			       }
			}
			<%}
			}%>
			<%if (!strProposalType.equalsIgnoreCase("P")) {%>
			if(varSvanidhi!="Y"){
					if(varmsmefalg=="Y"&& (document.forms[0].appstatus.value=="Open/Pending")){
							if(varmsmepanno=="" || varmsmepanno=="NOPAN" )
							{
								  alert("Please Update PANNO in Customer Profile -> Demographics tab");
								  return;
							}
						    if(varmsmeudyamregno=="")
						    {
								alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
						          return;
						   }  
						    else
						    {
						    	var udyamchar = varmsmeudyamregno;
						    	var capudyamchar=udyamchar.toUpperCase();
						    	if(capudyamchar.length==19)
						    	{
						    	for (var i = 0; i < capudyamchar.length; i++) {
						    	
						    		  if(capudyamchar.charAt(0)!='U')
						    		  {
							    		 
						    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
		                                    return;
							    		  
						    		  }
						    		  if(capudyamchar.charAt(1)!='D')
						    		  {
						    			 
						    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
		                                  return; 
						    			 
						    		  }
						    		  if(capudyamchar.charAt(2)!='Y')
						    		  {
						    			  
						    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
		                                     return;
						    			 
						    		  }
						    		  if(capudyamchar.charAt(3)!='A')
						    		  {
						    			  
						    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
		                                   return;
						    			 
						    		  }
						    		  if(capudyamchar.charAt(4)!='M')
						    		  {
						    			 
						    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
		                                  return;  
						    		  }
						    		  if(capudyamchar.charAt(5)!='-')
						    		  {
						    			 
						    			 alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
		                                return;    
						    			 
						    		  }
						    		  if(capudyamchar.charAt(6))
						    		  {
						    			  var code = capudyamchar.charCodeAt(6);
						    			  if(!(code>=65 && code<=90))
						    			  {
						    				 
							    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
			                                   return; 
						    			  }
						    		  }
						    		  if(capudyamchar.charAt(7))
						    		  {
						    			  var code = capudyamchar.charCodeAt(7);
						    			  if(!(code>=65 && code<=90))
						    			  {
						    				  
							    			 alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
			                                return;     
						    			  }
						    		  }
						    		  if(capudyamchar.charAt(8)!='-')
						    		  {
						    			 
						    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
		                                   return;
						    			 
						    		  }
						    		  if(capudyamchar.charAt(9))
						    		  {
						    			  var code = capudyamchar.charCodeAt(9);
						    			  if(!(code>=48 && code<=57))
						    			  {
						    				 
							    			 alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
			                                return;    
						    			  }
						    		  }
						    		  if(capudyamchar.charAt(10))
						    		  {
						    			  var code = capudyamchar.charCodeAt(10);
						    			  if(!(code>=48 && code<=57))
						    			  {
						    				  
							    			 alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
			                                  return;  
						    			  }
						    		  }
						    		  if(capudyamchar.charAt(11)!='-')
						    		  {
						    			 
						    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
		                                  return;  
						    		  }
						    		  if(capudyamchar.charAt(12))
						    		  {
						    			  var code = capudyamchar.charCodeAt(12);
						    			  if(!(code>=48 && code<=57))
						    			  {
						    				 
							    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
			                                    return;
						    			  }
						    		  }
						    		  if(capudyamchar.charAt(13))
						    		  {
						    			  var code = capudyamchar.charCodeAt(13);
						    			  if(!(code>=48 && code<=57))
						    			  {
						    				  
							    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
			                                  return;   
						    			  }
						    		  }
						    		  if(capudyamchar.charAt(14))
						    		  {
						    			  var code = capudyamchar.charCodeAt(14);
						    			  if(!(code>=48 && code<=57))
						    			  {
						    				 
							    			 alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
			                                 return;   
						    			  }
						    		  }
						    		  if(capudyamchar.charAt(15))
						    		  {
						    			  var code = capudyamchar.charCodeAt(15);
						    			  if(!(code>=48 && code<=57))
						    			  {
						    				 
							    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
			                                  return;  
						    			  }
						    		  }
						    		  if(capudyamchar.charAt(16))
						    		  {
						    			  var code = capudyamchar.charCodeAt(16);
						    			  if(!(code>=48 && code<=57))
						    			  {
						    				
							    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
			                                   return; 
						    			  }
						    		  }
						    		  if(capudyamchar.charAt(17))
						    		  {
						    			  var code = capudyamchar.charCodeAt(17);
						    			  if(!(code>=48 && code<=57))
						    			  {
						    				
							    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
			                                 return;
						    			  }
						    		  }
						    		  if(capudyamchar.charAt(18))
						    		  {
						    			  var code = capudyamchar.charCodeAt(18);
						    			  if(!(code>=48 && code<=57))
						    			  {
						    				 
							    			 alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
			                                  return;  
						    			  }
						    		  }
						    		 
						    		  
						    		  
						    			  
						    		  
						    			  
						    		}
						    	}
						    	else
						    	{
						    	
					    			 alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
		                          return;
						    	}
						    }
							if(varmsmecertificationdate=="" )
							{
							 	 alert("Please Update Udyam Certification Date in Customer Profile -> Demographics tab");
								 return;
						    }
						    
							if(varmsmeclassification==""||varmsmeclassification=="0" )
							{
								alert("Please Update MSME Classification as per Udyam Registration Certificate in Customer Profile -> Demographics tab");
								return;
							}
							/*if(!(varGSTReg=="Y" ||(varGSTReg=="N" && varGSTExempted=="Y")))
							{
								alert("Please Update GST Registration No/Exempted Details in Customer Profile -> Demographics tab");
								return;
							}*/
											
						 }
			}
					<%} else if (strParams.contains("@MIS@")) {%>
					if(varSvanidhi!="Y"){
					if(varmsmefalg=="Y" && varmsmepostsancdate=="Y" &&  document.forms[0].appstatus.value=="Open/Pending"){
						if(varmsmepanno=="" || varmsmepanno=="NOPAN" )
						{
							  alert("Please Update PANNO in Customer Profile -> Demographics tab");
							  return;
						}
					    if(varmsmeudyamregno=="")
					    {
							alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
					          return;
					   }  
					    else
					    {
					    	var udyamchar = varmsmeudyamregno;
					    	var capudyamchar=udyamchar.toUpperCase();
					    	if(capudyamchar.length==19)
					    	{
					    	for (var i = 0; i < capudyamchar.length; i++) {
					    	
					    		  if(capudyamchar.charAt(0)!='U')
					    		  {
						    		 
					    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
	                                    return;
						    		  
					    		  }
					    		  if(capudyamchar.charAt(1)!='D')
					    		  {
					    			 
					    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
	                                  return; 
					    			 
					    		  }
					    		  if(capudyamchar.charAt(2)!='Y')
					    		  {
					    			  
					    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
	                                     return;
					    			 
					    		  }
					    		  if(capudyamchar.charAt(3)!='A')
					    		  {
					    			  
					    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
	                                   return;
					    			 
					    		  }
					    		  if(capudyamchar.charAt(4)!='M')
					    		  {
					    			 
					    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
	                                  return;  
					    		  }
					    		  if(capudyamchar.charAt(5)!='-')
					    		  {
					    			 
					    			 alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
	                                return;    
					    			 
					    		  }
					    		  if(capudyamchar.charAt(6))
					    		  {
					    			  var code = capudyamchar.charCodeAt(6);
					    			  if(!(code>=65 && code<=90))
					    			  {
					    				 
						    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
		                                   return; 
					    			  }
					    		  }
					    		  if(capudyamchar.charAt(7))
					    		  {
					    			  var code = capudyamchar.charCodeAt(7);
					    			  if(!(code>=65 && code<=90))
					    			  {
					    				  
						    			 alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
		                                return;     
					    			  }
					    		  }
					    		  if(capudyamchar.charAt(8)!='-')
					    		  {
					    			 
					    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
	                                   return;
					    			 
					    		  }
					    		  if(capudyamchar.charAt(9))
					    		  {
					    			  var code = capudyamchar.charCodeAt(9);
					    			  if(!(code>=48 && code<=57))
					    			  {
					    				 
						    			 alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
		                                return;    
					    			  }
					    		  }
					    		  if(capudyamchar.charAt(10))
					    		  {
					    			  var code = capudyamchar.charCodeAt(10);
					    			  if(!(code>=48 && code<=57))
					    			  {
					    				  
						    			 alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
		                                  return;  
					    			  }
					    		  }
					    		  if(capudyamchar.charAt(11)!='-')
					    		  {
					    			 
					    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
	                                  return;  
					    		  }
					    		  if(capudyamchar.charAt(12))
					    		  {
					    			  var code = capudyamchar.charCodeAt(12);
					    			  if(!(code>=48 && code<=57))
					    			  {
					    				 
						    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
		                                    return;
					    			  }
					    		  }
					    		  if(capudyamchar.charAt(13))
					    		  {
					    			  var code = capudyamchar.charCodeAt(13);
					    			  if(!(code>=48 && code<=57))
					    			  {
					    				  
						    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
		                                  return;   
					    			  }
					    		  }
					    		  if(capudyamchar.charAt(14))
					    		  {
					    			  var code = capudyamchar.charCodeAt(14);
					    			  if(!(code>=48 && code<=57))
					    			  {
					    				 
						    			 alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
		                                 return;   
					    			  }
					    		  }
					    		  if(capudyamchar.charAt(15))
					    		  {
					    			  var code = capudyamchar.charCodeAt(15);
					    			  if(!(code>=48 && code<=57))
					    			  {
					    				 
						    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
		                                  return;  
					    			  }
					    		  }
					    		  if(capudyamchar.charAt(16))
					    		  {
					    			  var code = capudyamchar.charCodeAt(16);
					    			  if(!(code>=48 && code<=57))
					    			  {
					    				
						    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
		                                   return; 
					    			  }
					    		  }
					    		  if(capudyamchar.charAt(17))
					    		  {
					    			  var code = capudyamchar.charCodeAt(17);
					    			  if(!(code>=48 && code<=57))
					    			  {
					    				
						    			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
		                                 return;
					    			  }
					    		  }
					    		  if(capudyamchar.charAt(18))
					    		  {
					    			  var code = capudyamchar.charCodeAt(18);
					    			  if(!(code>=48 && code<=57))
					    			  {
					    				 
						    			 alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
		                                  return;  
					    			  }
					    		  }
					    		 
					    		  
					    		  
					    			  
					    		  
					    			  
					    		}
					    	}
					    	else
					    	{
					    	
				    			 alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
	                          return;
					    	}
					    }
						if(varmsmecertificationdate=="" )
						{
						 	 alert("Please Update Udyam Certification Date in Customer Profile -> Demographics tab");
							 return;
					    }
					    
						if(varmsmeclassification==""||varmsmeclassification=="0" )
						{
							alert("Please Update MSME Classification as per Udyam Registration Certificate in Customer Profile -> Demographics tab");
							return;
						}
						/*if(!(varGSTReg=="Y" ||(varGSTReg=="N" && varGSTExempted=="Y")))
						{
							alert("Please Update GST Registration No/Exempted Details in Customer Profile -> Demographics tab");
							return;
						}*/
							

						 }
					}
					<%}%>
					<%if (!strProposalType.equalsIgnoreCase("P") && !strProposalType.equalsIgnoreCase("S")) {%>
					<% if(strSessionModuleType.equalsIgnoreCase("CORP"))
					{%>
					if((document.forms[0].hidgecl3propstatus.value=="Y" && document.forms[0].hidgecl2propstatus.value=="Y")&& (document.forms[0].appstatus.value=="Open/Pending")){
						alert("Already sanctioned GECL-3 facility exists for this borrower hence user cannot proceed with GECL-1 or GECL-2");
						return;
					}
					if((document.forms[0].hidgecl3propstatus.value=="Y" && document.forms[0].hidgecl1propstatus.value=="Y")&& (document.forms[0].appstatus.value=="Open/Pending")){
						alert("Already sanctioned GECL-3 facility exists for this borrower hence user cannot proceed with GECL-1 or GECL-2");
						return;
					}
					<%}}%>
					
					<%if (strProposalType.equalsIgnoreCase("S")) {%>
					<% if(strSessionModuleType.equalsIgnoreCase("CORP"))
					{%>
					if((varrestasschk!="Y" && varrestassesmandatory=="Y" && vargecltype=="GECL1") && (document.forms[0].appstatus.value=="Open/Pending")){
						alert("Please  enter the details in Assesment for KBL GECL tab Details.");
							return;
							}

					if(((vargecl3restructure=="Y" || vargecl3restructurebybrw=="Y")&& vargecltype=="GECL1") && (document.forms[0].appstatus.value=="Open/Pending")){
						alert("Already sanctioned GECL-3 facility exists for this borrower hence user cannot proceed with GECL1-Restructure");
						return;
					}
					if(((vargecl1restructure=="Y"|| vargecl1restructurecheck=="Y") && vargecltype=="GECL1") && (document.forms[0].appstatus.value=="Open/Pending")){
						alert("Please re enter the details in Assesment for KBL GECL tab Details.");
						return;
						}
					<%}}%>

					<% if(strSessionModuleType.equalsIgnoreCase("CORP")||strSessionModuleType.equalsIgnoreCase("AGR"))
					{%>
					if((varbankingarrangemnet=="Y" && varsolechk=="N")&& (document.forms[0].appstatus.value=="Open/Pending")){
						alert(" Proposed Banking arrangement  type is other than sole in facilitied Tab  then  Banking Arrangement Tab Banking Arrangement Type also Should be other than sole");
					} 
					if(varbankingarrangemnet=="Y"){
					if((varwcmandatorychk=="N")&& (document.forms[0].appstatus.value=="Open/Pending")){
						if(varwctype=="C"){
							alert("Please Enter Values in Consortium Details for WC ->Banking Arrangement tab ->Consortium Details for WC Tab");
						}else if(varwctype=="M"){
							alert("Please Enter Values in Multiple Banking Details for WC ->Banking Arrangement tab ->Multiple Banking Details for WC Tab");
							
						}
						} 
					if((vartlmandatorychk=="N")&& (document.forms[0].appstatus.value=="Open/Pending")){
						if(vartltype=="C"){
							alert(" Please Enter Values in Consortium Details for TL ->Banking Arrangement tab ->Consortium Details for TL Tab");
							}else if(vartltype=="M"){
								alert("Please Enter Values in Multiple Banking Details for TL ->Banking Arrangement tab ->Multiple Banking Details for TL Tab");
								
							}
						} 
						}
					if(varbankargmultwcconschk=="Y" && (document.forms[0].appstatus.value=="Open/Pending")){
						alert("\n In Banking arrangement Consortium type number of consortium is given as "+varwccount+"but entry is not available for each consortium type in consortium details tab");

						return;
						}
					if(varbankargmulttlconschk=="Y" && (document.forms[0].appstatus.value=="Open/Pending")){
						alert("\n In Banking arrangement Consortium type number of consortium is given as "+vartlcount+"but entry is not available for each consortium type in consortium details tab");
						return;
						}
					 <%if(strProposalType.equalsIgnoreCase("P")){%>
						
						/*if(document.forms[0].appstatus.value=="Open/Pending")
						{
						if((varbankingarrangemnet=="N") && ((varwctype=="M" ||varwctype=="C") || (vartltype=="M" ||vartltype=="C"))){
									alert("Kindly delete  and reenter the banking arrangement Tab ");
								return;
						}
						if((varbankingarrangemnet=="N" )&& (varwcmandatorychk=="Y" ||vartlmandatorychk=="Y")){
									alert("Kindly Delete  Multiple Banking Details/Consortium Banking details tab and reenter Multiple Banking Details/Consortium Banking details to proceed further ");
								return;
						}
						
						}*/
						<%}%>
					<%}%>
					if(varListCompany=='Y' && varCIN!="" ){
						if(varCIN.charAt(0)=='L' && varCIN.length=="21"){
						if(document.forms[0].chk_dec.checked==false){
							 alert("Please check the Declaration for Listed Company to proceed");
							 return;
						}}}
	if(document.forms[0].txt_usrid.value!="")
	{
		/* ---------------Start For Checking Whether Target Exceeded Or Not--------*/
		 	<%if (loan_type.equalsIgnoreCase("P")
				|| loan_type.equalsIgnoreCase("A")
				|| loan_type.equalsIgnoreCase("C")
				|| loan_type.equalsIgnoreCase("T")) {%>
				var target_exceeded="<%=Helper.correctNull((String) hshValues
							.get("target_exceeded"))%>";
				if(target_exceeded=='Y')
				{
					alert("<%=Helper.correctNull((String) hshValues
							.get("alert_desc"))%>");
				}
			<%}%>
	 	/* ---------------End For Checking Whether Target Exceeded Or Not--------*/
	if(document.forms[0].appraisal)
	{
		if( document.forms[0].appraisal.checked == true)
		{
			if(document.forms[0].sancinti)
			{
				if(document.forms[0].sancinti.checked == true)
				{
					if(document.forms[0].documents)
					{
						if(document.forms[0].documents.checked == true)
						{
					if(trim(document.forms[0].txt_sanctioncomments.value)=="")
					{
						alert("Enter Comments");
						document.forms[0].txt_sanctioncomments.focus();
						return;
			 		}
					<%if(strProposalType.equalsIgnoreCase("P")){%>
						document.forms[0].sel_finalsanction.disabled=false;
					<%}%>



					
					showProgress('imgloading');
					window.scrollTo(0, 0);
					document.forms[0].cmdsanction.disabled=true;
					document.forms[0].Stateflag.value="1";
					document.forms[0].hidAction.value="approve";
					document.forms[0].hidBeanMethod.value="updateAction";
					document.forms[0].hidBeanGetMethod.value="getHistory";
					document.forms[0].action=appURL+"controllerservlet";
					document.forms[0].hidBeanId.value="commworkflow";
					document.forms[0].hidSourceUrl.value="/action/appworkflowhistory.jsp"; 
					document.forms[0].submit();	

					}else {
						alert ( "You have not checked Process Note");
					}
				    }else{
						if(trim(document.forms[0].txt_sanctioncomments.value)=="")
							{
								alert("Enter Comments");
								document.forms[0].txt_sanctioncomments.focus();
								return;
					 		}
						<%if(strProposalType.equalsIgnoreCase("P")){%>
							document.forms[0].sel_finalsanction.disabled=false;
						<%}%>
						showProgress('imgloading');
						window.scrollTo(0, 0);
						document.forms[0].cmdsanction.disabled=true;
						document.forms[0].Stateflag.value="1";
						document.forms[0].hidAction.value="approve";
						document.forms[0].hidBeanMethod.value="updateAction";
						document.forms[0].hidBeanGetMethod.value="getHistory";
						document.forms[0].action=appURL+"controllerservlet";
						document.forms[0].hidBeanId.value="commworkflow";
						document.forms[0].hidSourceUrl.value="/action/appworkflowhistory.jsp"; 
						document.forms[0].submit();					
					}				
				}
				else
				{
					alert ( "You have not checked Presanction Inspection Conducted");
				}
			}
			else
			{
				if(trim(document.forms[0].txt_sanctioncomments.value)=="")
					{
						alert("Enter Comments");
						document.forms[0].txt_sanctioncomments.focus();
						return;
			 		}
				<%if(strProposalType.equalsIgnoreCase("P")){%>
					document.forms[0].sel_finalsanction.disabled=false;
				<%}%>
				document.forms[0].cmdsanction.disabled=true;
				document.forms[0].Stateflag.value="1";
				document.forms[0].hidAction.value="approve";
				document.forms[0].hidBeanMethod.value="updateAction";
				document.forms[0].hidBeanGetMethod.value="getHistory";
				document.forms[0].action=appURL+"controllerservlet";
				document.forms[0].hidBeanId.value="commworkflow";
				document.forms[0].hidSourceUrl.value="/action/appworkflowhistory.jsp"; 
				document.forms[0].submit();					
			}
		}
		else
		{
			alert("You have not checked appraisal");
		}
	}
	else
	{
			if(trim(document.forms[0].txt_sanctioncomments.value)=="")
			{
				alert("Enter Comments");
				document.forms[0].txt_sanctioncomments.focus();
				return;
			}
			<%if(strProposalType.equalsIgnoreCase("P")){%>
				document.forms[0].sel_finalsanction.disabled=false;
			<%}%>
			showProgress('imgloading');
			window.scrollTo(0, 0);
			document.forms[0].cmdsanction.disabled=true;
			document.forms[0].Stateflag.value="1";
			document.forms[0].hidAction.value="approve";
			document.forms[0].hidBeanMethod.value="updateAction";
			document.forms[0].hidBeanGetMethod.value="getHistory";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidBeanId.value="commworkflow";
			document.forms[0].hidSourceUrl.value="/action/appworkflowhistory.jsp"; 
			document.forms[0].submit();					
	}
	}
	if(varDigiLoanType=="PR" && varCReditRisk=="Y")
	{
		alert("Credit risk Premium and Bussiness Strategic premium is zero.Please click Roi Update in loan product");
		return;
	}
	<%if(strSessionModuleType.equalsIgnoreCase("LAD"))
    {%>
	if (perJaCbsId==perCbsId)
	{
		alert("The said "+perFname+" is introduced by Jewel appraisal "+perJaName+" & "+perCbsId);
	}
	<%}%>
	
}
function funSanctionReady()
{
	var varAlert="";
	/*if(strSessionModuleType=="AGR")
	{
		if(document.forms[0].appstatus.value=="Open/Pending"){			
			if(varenwrdetails=="N"){
				varAlert = varAlert +"\nPlease enter the details in eNWR tab.";
	       	}
			
			if(varenwrassessmentval=="N")
			{
				varAlert = varAlert +"\nPlease enter the details in Assessment for KBL e- Krishik Bhandar tab";
			}
		}
	}*/
	
	if(strSessionModuleType=="AGR"||strSessionModuleType=="CORP"||strSessionModuleType=="RET")
	{
	if(document.forms[0].appstatus.value=="Open/Pending"){
		
		if(cbsBencheckid=="Y"&&checkbenower!="")
		{
			varAlert=varAlert + "\n Kindly update Beneficial Owner details in Finacle -CRM- Relationship tab-Relationship Type-Beneficiary";
		}
		if(Lov_verification_check=="Y")
		{
			varAlert=varAlert + "\n Kindly enter details in Security Master - Legal Opinion Verification tab";
		}
		if(leierrormessage=="Y")
		{
			varAlert=varAlert + "\n Kindly update Legal Entity details in Finacle and vist laps customer profile.";
		}
		if(varcbsscodechk=="Y")
			{
			
			varAlert=varAlert + "\n Facility Availing branch cannot be same .";
			
			}
	}
	
	
	
	}
	if(strSessionModuleType=="RET" && document.forms[0].appstatus.value=="Open/Pending")
	{
	 if(varhousingloanchkinloanpag=="Y" || varhousingloanchkindevpag=="Y")
		 {
		 varAlert=varAlert + "\n Required margin is inadequate as per the circular HO:CREDIT:CIRCULAR:GF:07:37:2019-20 dated 04.11.2019 Either loan amount to be reduced or borrower has to service the interest during the moratorium";
		 }
	}
	if(vargecl4count=="N" && vargelc4exposurecunt=="Y"){
		varAlert = varAlert + "\n Branch to ensure that atleast one facility is released as on 31/03/2021";
		}
	if((strSessionModuleType=="AGR"||strSessionModuleType=="CORP")&&(varProposalType=="S"))
	{
		if(varresttenorchk=="Y"){
			varAlert = varAlert +"\nRepayment Tenor exceeding the maximum period of 120 months or Holiday period should be not be greater than 24 months";
		}
	}
	if(varProposalType=="S" && document.forms[0].appstatus.value=="Open/Pending" && (strSessionModuleType=="AGR"||strSessionModuleType=="CORP"))
	{
		if(varrestschemechk=="Y" && varrestchk =="N"){
			varAlert = varAlert + "\n mismatch of activity of the borrower captured in Restructure settlement scheme framework 2.0";
			}
	}
	/*if((strSessionModuleType=="AGR"||strSessionModuleType=="CORP")&&(varProposalType=="S"))
	{
		if(varresttenorchk=="Y"){
			varAlert = varAlert +"\nRepayment Tenor exceeding the maximum period of 120 months or Holiday period should be not be greater than 24 months";
		}
	}*/

	if((strSessionModuleType=="AGR"||strSessionModuleType=="CORP")&&(varProposalType=="S"))
	{
		if(document.forms[0].appstatus.value=="Open/Pending"){
			if(varcorprestructureval=="Y" && varrestructurechk=="N"){

				varAlert = varAlert +"\nPlease enter the details in Assesment for Eligibility under Restructure tab Details.";
			}
		}
	}
	if((strSessionModuleType=="RET")&&(varProposalType=="S"))
	{
		if(document.forms[0].appstatus.value=="Open/Pending"){
			if(varretrestructureval=="Y" && varrestructurechk=="N"){
				varAlert = varAlert +"\nPlease Enter Values in Appraisal -> Loan Details ->Eligibility Under Restructure Tab Details";
			}
		}
	}
	if(varDigiLoanType=="PC")
	{
		if(varRoiFlag == 'Y' || varRoiUpdate == 'Y')
		{
			varAlert = varAlert +"Please click Roi Update in Reference Rate";
		}
	}else if(varDigiLoanType=="PR" || varPOSTPR=="POSTPR"){
		if(varRoiUpdate == 'Y')
		 {
			 varAlert = varAlert +"Please click Roi Update in loan product";
		 }
	}
	<%if(!strProposalType.equalsIgnoreCase("P")){%>
	if(VarSECALREADYMORTG == 'Y')
	{
		varAlert = varAlert +"\n Kindly Select Whether property offered is already mortgaged to our Bank field in Home -> Securities -> Property Details ";
	}
	
	if(Varseccroptype == 'Y')
	{
		varAlert = varAlert +"\n Kindly Select Crop type in Home -> Securities -> Property Details ";
	}
	if(varRestructureInvoDate== "Y" && varappcategory=="S")
	{
		varAlert = varAlert +"\nPlease Enter the Date of Restructure Invocation in Customer Profile";
	}
	/*** SECURITY CERSAI *****/
	var Varcersaidate="<%=Helper.correctNull((String)hshValues.get("cersaidate"))%>";

		if(VARSECCERSAIREFNO == 'N')
		{
			varAlert = varAlert +"Kindly Enter CERSAI Search Ref. No field in Home -> Securities -> Property Details ";
		}
		
	
		if(VARSECSEARCHPERFORMDATE == 'N')
		{
			varAlert = varAlert +"\nKindly Enter CERSAI search Date  field in Home -> Securities -> Property Details ";
		}
		
		if(Varcersaidate == 'Y')
		{
			varAlert = varAlert +"CERSAI search Date for Attached Securities Expired.! please modify in Home -> Securities -> Property Details ";
		}
		
	/*** SECURITY CERSAI ENDS*****/
	if(varQueryStatus=="No")
	{
		varAlert = varAlert + "\nAll the Queries yet to get the reply.Please Ensure all the queries are in Closed status.";
	}
	if(document.forms[0].appstatus.value=="Open/Pending"){
	if(varStagewiseFlag!="Y"  && "<%=strPrdType%>"!="pR" && "<%=strPrdType%>"!="pG")
	{
		varAlert = varAlert + "\nKindly Enter whether TL/DPN is released stage wise in Appraisal - Terms of Repayment tab for Retail module and Repayment Schedule - Terms of Repayment tab for Corporate/Agri Module.";
		
	}
	}
	if(document.forms[0].appstatus.value=="Open/Pending"){
	if(varAHPDet=="Y"   ){
		if(varconResType!=varAHPResType){
			varAlert = varAlert +"\nPlease update Resident Type in AHP tab to match with customer details tab.";
			
		}
	}
	}
	if(document.forms[0].appstatus.value=="Open/Pending"){
		if(varAHPDet=="Y"   ){
			if(varTotalCost!=varAHPCost){
				varAlert = varAlert +"\nTotal Cost of project in AHP tab should match with Loan Particluars tab";
				
			}
		}
		}
	
	if(varGovtScheme=="1"&&(varSchemeType=="080" || varSchemeType=="081" ) && varAHPDet=="Y"){
		  if(varRepaymentType!="1" ){
			  varAlert = varAlert +"\nAHP Loans Eligible for EMI Loans only";
				
		  }
		}
	if(varGovtScheme=="1"&&(varSchemeType=="080" || varSchemeType=="081" )){
		if(varAHPDet!="Y"   ){
			varAlert = varAlert +"\nPlease Enter AHP Details in Loan Particulars tab";
			
		}
	}
	<%if (loan_type.equalsIgnoreCase("P")) {%>
		if(strPrdType=="pL")
		{
			if(parseFloat(varloangross) > parseFloat(varleasegross))
			{
				varAlert = varAlert + "\nMonthly Gross Rent should not exceed Lease Gross Rent";
			}
		}

		if(strPrdType=="pU" && varshg_tallied=="N")
		{
			varAlert = varAlert + "\n Proposed Loan Amount is not tallied with the amount shared among the SHG members";
		}
		if(strPrdType=="pU" && varExposureChk=="F")
		{
			varAlert = varAlert + "\n Total Exposure Limit of the Borrower exceeds 10 Lakhs";
		}
		/*if(varEligibilitychkflag=="N")
		{
			if(varStaffProduct!="Y")
			{
				varAlert = varAlert + "\nApplicant is not Eligible.Please check Eligibility";
			}
		}*/

		//document attachment check
		if(strPrdType=="pA")
		{
			if(varDocAttach_Flag == "N")
			{
				varAlert=varAlert+"\nPlease Attach Document in Documents Tab";
			}
		}

		if((varRepayComments!="Y" && varrepaymenttype!="1"))
		{
			<%--if("<%=strPrdType%>"!="pR" && "<%=strPrdType%>"!="pV" && !(("<%=strPrdType%>"=="pM" || "<%=strPrdType%>"=="pI") && varPrdLoanType=="OD"))--%>
			{
				varAlert=varAlert+"\nPlease Enter Comments in Appraisal -> Terms of Repayment tab";
			}
		}

		if(varBIRFlag!="Y")
		{
			varAlert=varAlert+"\nPlease Fill Appraisal -> Background Information Report (BIR) tab";
		}
		if(varPRD_CGTMSE=="Y" && varCGTMSEFlag!="Y")
		{
			varAlert=varAlert+"\nPlease Fill CGTMSE COVERAGE in Loan Particulars tab";
			
		}
		if(strPrdType=="pR" && document.forms[0].appstatus.value=="Open/Pending")
		{
			if(vardepmetdatechk=="Y"){
				varAlert=varAlert+"\n Selected deposit due date is already over. Kindly make necessary modifications in FINACLE and then re select the deposit in LAPS->"+vardepostaccno;
			}
		}
	<%}}%>
	<%if(!(loan_type.equalsIgnoreCase("P"))){%>
		if(varshg_tallied=="N")
		{
			varAlert = varAlert + "\nLoan Amount is not tallied with amount shared among the SHG members in facility sno "+varfac_not_tally;
		}
		if(strBrief=="True")
		{
			varAlert = varAlert + "\nPlease Fill Basic Information Details";
		}	
		if(str_strmisaparam=="True")
		{
			varAlert = varAlert + "\nPlease Enter All Facility Related Details in MIS / CBS Details Tab";
		}
		
		<%if(!strProposalType.equalsIgnoreCase("P")){%>

		<%if(arrSchemes!=null && arrSchemes.size()>0){
			for(int a=0;a<arrSchemes.size();a++){
			if(Helper.correctNull((String)arrSchemes.get(a)).equalsIgnoreCase("055")){%>
				if(varDocAttach_Flag == "N")
				{
					varAlert = varAlert + "\nPlease Attach Document in Documents Tab";
				}
		<%}}}%>
		if(!strSessionModuleType=="DIGI")
		{
			if(varTakeOverDetails=="N")
			{
				varAlert = varAlert + "\nPlease Fill Take Over Tab";
			}
		}	
		if(varTakeover=="N")
		{
			varAlert = varAlert + "\nPlease Fill Take Over Norms Tab";
		}
		if(varBIRFlag!="Y" && (document.forms[0].appstatus.value=="Open/Pending" || document.forms[0].appstatus.value=="Open/Lodged"))
		{
			varAlert = varAlert + "\nPlease Fill Due Diligence Report / BIR -> Background Information Report (BIR) tab";
		}
if( varCropCGTMSE=="Y"  && (document.forms[0].appstatus.value=="Open/Pending" || document.forms[0].appstatus.value=="Open/Lodged"))
		{
		if(varCGTMSEFlag!="Y")
		{
			varAlert = varAlert + "\nPlease Fill CGTMSE COVERAGE in Facilities tab"; 
		}
}
		/* add digi condition
		if(varVERFIcheckflag=="N")
		{
			varAlert = varAlert + "\nPlease Fill Verification Tab";
		}*/
	<%}}%>
		var hidPage="Y";
		var typeCheck=strPrdType.substring(0,1);

		if(varapptype.toUpperCase()=="C" || varapptype.toUpperCase()=="A")
		{	
			if(varMMithra=="N")
			{
				varAlert = varAlert + "\nAgriculture Industry Service Category should be MICRO (Service/Manufacturing) Enterprises for Micro Mithra Scheme";
			}
			<%if(!strProposalType.equalsIgnoreCase("P")){%>
			if(strFIDPNChk=="N")
			{
				varAlert = varAlert + "\nKindly fill Interest DPN assessment Details for DPN facilities";
			}
			if(strFIDPNDet!="")
			{
				varAlert = varAlert + "\nSanctioned amount under interest Defernment DPN 2020 is greater than MPBF amount in Assessment,\n "+strFIDPNDet;
			}

			if(eval(strAmount)>eval(strMithraFacTot))
			{
				varAlert = varAlert + "\nTotal of Sanctioned amount under KBL Micro mitra is greater than MPBF amount in Assessment.";
			}
			
			<% if(strSessionModuleType.equalsIgnoreCase("CORP"))
		{%>
			
			if(document.forms[0].hidcgssdtypechk.value=="N")
			{
				varAlert = varAlert + "\nPlease Enter All Facility Related Details in  CGSSD Assessment in Assessment for KBL CGSSD tab Details. ";
			}
			if(document.forms[0].hidcgssdsanchk.value=="N")
			{
				varAlert = varAlert + "\nAmount applied for CGSSD  should not be greater than the  Proposed Limit in Assessment for KBL CGSSD tab Details.";
			}
			if(document.forms[0].appstatus.value=="Open/Pending" ){
			if(document.forms[0].hidcgssdpercchk.value=="N")
			{
				varAlert = varAlert + "\nPlease re enter the details in Assessment for KBL CGSSD tab Details.";
			}
			if(document.forms[0].hidmisactivitycodechk.value=="N")
			{
				varAlert = varAlert + "\nactivity code to be selected for all CGSSD facilities should be - 150599-Personal  Loans to Others only in->Mis Details Tab.";
			}


			if(vargeclavailable=="Y" && (vargecltype=="GECL -1 extension" ||   vargecltype=="GECL -2 extension" ||  vargecltype=="GECL -3 extension")
					&& (!varProposalType =="P") ) 
			{
				
			//if(vardbgecl1maxamount>vargecl1sno25)
			var gecl25 =parseInt(vargecl1sno25);
		var vadbgecl1maxamount=parseInt(vardbgecl1maxamount);
		//alert("vardbgecl1maxamount"+vadbgecl1maxamount);
		//alert("gecl25"+gecl25);
		if(vadbgecl1maxamount>gecl25)
			{
				varAlert = varAlert + "\nKindly check Facility Sanctioned Amount should not be greater than Recommended field of gecl Assessment";
			}
			}


			if(gecl12flag=="Y" &&  gecl3flag=="Y" && (!varProposalType =="P") )
			{
				varAlert = varAlert + "\nOnce a Borrower has  GECL -3 Extension  facility  Sanctioned ,same borrower cannot be sanctioned  GECL -1 Extension/GECL -2 Extension";
				
			}

			if(parayatanGECLFlag=="Y")
			{
				varAlert = varAlert + "\nOnly one facility should be availed either GECL 1/3 or ParyaTan";				
			}
			
			if(vargeclavailable=="Y" && varGECLChk=="Y")
			{
			if(vargecl4loanamt=="Y" && vargecltype=="GECL4"){
				varAlert = varAlert + "\nPlease re enter the details in Assessment for KBL GECL tab Details.";
			}
			}
			if(vargeclavailable=="Y" && varGECLChk!="Y")
			{
				varAlert = varAlert + "\nPlease Fill Assessment -> Eligibility Criteria for KBL GECL scheme tab Details";
			}
			<%if(!strProposalType.equalsIgnoreCase("S") && !strProposalType.equalsIgnoreCase("P"))
			{%>
			if(vargeclavailable=="Y" && varGECLAssChk!="Y")
			{
				varAlert = varAlert + "\nPlease Fill Assessment for KBL GECL scheme tab Details";
			}
			<%}%>
			}
			
			<%}%>
			if(varSvanidhi=="Y" && strSvanidhiTerm!="Y")
			{
				varAlert = varAlert + "\nPlease check the declaration details in Customer Profile -> Svanidhi Details tab";
			}

			if(varpmSVanidhi_uniqueno=="N" && varProposalType!="P" ){
				varAlert = varAlert + "\nPlease update the unique Application No. in Customer Profile -> Svanidhi Details tab";	
			}
			if(varpmSvanidhi2=="Y"){
				if(varSvanidhi1_completed!="Y"  ){
					varAlert = varAlert + "\nOnce Borrower sanctioned and close the loan under PM Svanidhi 1.0 can process PM Svanidhi 2.0";
				}
			}
			if(varpmSvanidhi3=="Y"){
				
				if(varSvanidhi1_completed!="Y" || varSvanidhi2_completed!="Y" ){
					varAlert = varAlert + "\nOnce Borrower sanctioned and close the loan under PM Svanidhi 1.0 & PM Svanidhi 2.0, can process PM Svanidhi 3.0";
				}
				if(varpmSvanidhi3Assessment!="Y"){
					varAlert = varAlert + "\nPlease Fill Assessment for PM Svanidhi 3.0  Details tab";
					
				}else{
					if(varSvanidhiproposed_amt3!=varproposed_amt3){
						varAlert = varAlert + "\nPlease update Proposed amount value in PM Svanidhi 3.0  Details tab";
					}
					if(varSvanidhisanc_amt3 !="" && varsanc_amt3!=""){
						if(parseFloat(varsanc_amt3)> parseFloat(varSvanidhisanc_amt3))
						{
							varAlert = varAlert + "\nSanction Amount cannot be greater than Proposed and recommended Loan Amount in PM Svanidhi 3.0 Details tab ";
							
						}
					}
					
					
				}
			}
			
			<%}%>
			
			if(varFACCHECK == "N")
			{
				varAlert = varAlert + "\nApprove/Reject individual facilities in Workflow ->  Proposed Facility Approve/Reject tab";				
			}
			if(varFACAPPROVECHECK != "Y")
			{
				varAlert = varAlert + "\nApprove atleast one facility in Workflow -> Proposed Facility Approve/Reject tab";				
			}
			if(varNEcheckflag=="N")
			{
				varAlert = varAlert + "\nRepayment EMI Amount does not tally for these facilities "+varNEFacdesc;
			}
		}
		
		else if(varapptype.toUpperCase()=="P")//for Retail applications
		{
			if(document.forms[0].appraisalsanc.value!="Yes")
			{
				varAlert = varAlert+"\nPlease Enter Values in Appraisal -> Loan Details";
			}
			<%if(!strProposalType.equalsIgnoreCase("P")){%>
				if(varAppraisalQuest.toUpperCase()!="Y")
				{
					varAlert=varAlert+"\nPlease Enter Values in Appraisal -> Check List";
				}
			<%}%>
			if(varMISDetails.toUpperCase()!="Y")
			{
				varAlert=varAlert+"\nPlease Enter Values in MIS/CBS Details -> MIS Details";
			}
			if(varCBSDetails.toUpperCase()!="Y")
			{
				varAlert=varAlert+"\nPlease Enter Values in MIS/CBS Details -> CBS Details";
			}
			<%if(!strProposalType.equalsIgnoreCase("P")){%>
			if((strPrdType == 'pH' && varPrdPurpose!='T') || (strPrdType == 'pA'))
			{
				if(varSourceMargin != "Y")
				{
					varAlert=varAlert+"\nPlease Enter Values in Loan Particulars -> Source of Margin";
				}
			}
			<%}%>
			if(varRNEcheckflag=="N" && (("<%=strPrdType%>"!="pR" && "<%=strPrdType%>"!="pG" && varPrdLoanType!="OD")||("<%=strPrdType%>"=="pG" && varrepaymenttype=="14")))
			{
				varAlert=varAlert+"\nLoan Amount & Installment amount should be tallied";
			}
		}

		<%if((strSessionModuleType.equalsIgnoreCase("RET")||strSessionModuleType.equalsIgnoreCase("LAD"))&& strParams.equalsIgnoreCase("@BRTOMCLR@")){%>
		varSecurityFlag="N";
		<%}%>
		
		if(varSecurityFlag!="N" && ("<%=strPrdType%>"!="pR" && "<%=strPrdType%>"!="pG"))
		{
			varAlert=varAlert+"\nPlease Attach and freeze the Securities for this Proposal";
		}

		<%if(!strProposalType.equalsIgnoreCase("P")){%>
		if(varAppDocuments!="Y")
		{
			varAlert=varAlert+"\nNecessary documents not submitted by customer - Please check and change in Loan Application Register";
		}

		if(varCFRverified=="N"||varCFRverified=="")
		{
			varAlert=varAlert+"\n Central Fraud Registry Verification is not done.";
		}
		if(eval(varBorrExp)>500000 && (varCFRverified=="N" || varCFRverified=="NA"))
		{
			varAlert=varAlert+"\n Since Borrower Exposure is more than 5lakhs, Central Fraud Registry verification is mandatory.";
		}
		if(varMSME=="Y" && varMSMEFacility=="")
		{
			varAlert=varAlert+"\n Enter Check List for Documents for all KBL MSME schemes";
		}
		
		if( varPRD_CGTMSE=="Y"  && (document.forms[0].appstatus.value=="Open/Pending" || document.forms[0].appstatus.value=="Open/Lodged"))
		{
			if(varCGTMSEtotintrate=="Y")
			{
				varAlert=varAlert+"\nTotal CGTMSE Interest rate should not exceed "+varparamval_CGTMSEint+"%";
				
			}	

			if(strudyogadhorChk=="Y"){
				//varAlert=varAlert+"\nPlease fill Udyog Aadhaar Number in Customer Profile - Udyog Aadhaar Number is mandatory  for coverage under CGTMSE";
				
			}

			if(parseFloat(varsanction_amount)>=parseFloat(500000))
			{
				if(varCGPan=="" || varCGPan=="NOPAN" )
				{
					varAlert=varAlert+"\nPAN is mandatory for loan amount of Rs.5 lakh and above for coverage under CGTMSE";
				}
			}

			if(varCGTMSEcovLimit=="Y")
			{
				varAlert=varAlert+"\nCGTMSE Coverage of the borrower should not exceed "+varmaxcgtmseLimit;
			}
			if(NatureofActivity=="")
			{
				varAlert=varAlert+"\nPlease fill Nature of Activity in Customer Profile";	
				
			} 
			if(varConstitution!="01" && varchiefpromotercheck=="N")
			{
				varAlert=varAlert+"\n atleast one Cheif Promoter is mandatory.  Kindly select atleast one in Customer Profile-Groups/Management Peoples tab";	
			}
		}
		
			
				
		<%}%>
		
		if(varPMAY=="Y")
		{
			if(varPmayhouse=="N")
			{
				varAlert=varAlert+"\n Please Enter PMAY Details in Loan Particulars tab";
			}

			if(varOwnedHouse=="Y")
			{
				varAlert=varAlert+"\nYou cannot forward.The Borrower has owned a house his/her name or family member's name in india.";
			}
			if(varFemaleownerReq=="Y" && varFemaleownerAvail=="")
			{
				//varAlert=varAlert+"\nFemale Ownership Required";
			}
			if(varGovtscheme=="079")
			{
				if(eval(varCarpetAreaReq)<eval(varCarpetAreaAvail))
				{
					varAlert=varAlert+"\nCarpet Area should not be more than "+eval(varCarpetAreaReq)+" Sq.Mts";
				}
			}
			if(false)
			{
				//varAlert=varAlert+"\nLoan Tenor should not be more than "+eval(varTenorReq);
			}
			if(parseInt(varPMAYValidFrom)<0)
			{
				varAlert=varAlert+"\nYou cannot forward this Proposal Under PMAY scheme.\n Scheme Yet to Start";
			}
			if(parseInt(varPMAYValidTo)>0)
			{
				varAlert=varAlert+"\nYou cannot forward this Proposal Under PMAY scheme.\n Scheme Validity Expired";
			}
		}

		<%if(strParams.equalsIgnoreCase("@CHDCCO@")||strParams.equalsIgnoreCase("@DCCO@"))
		{%>
			if(varDrawDownFlag=="No")
			{
				varAlert=varAlert+"\nPlease fill Draw Down Schedule for Project Loans";
			}
			
		<%}else if(!strProposalType.equalsIgnoreCase("P"))
		{%>
			if(varDrawDownFlag=="No")
			{
				varAlert=varAlert+"\nPlease fill Draw Down Schedule for Project Loans";
			}

				
		<%}%>
		

		if(strSessionModuleType=="CORP" || strSessionModuleType=="AGR"){
			if(varPRD_CGTMSE=="Y" && (document.forms[0].appstatus.value=="Open/Pending" || document.forms[0].appstatus.value=="Open/Lodged"))
			{
			     if(strCGTMSEtotintrate1=="Y")
					{
						varAlert=varAlert+"\nTotal CGTMSE Interest rate should not exceed "+varparamval_CGTMSEint+"%";
						//return;
					}

				if(strudyogadhorChk=="Y")
					{
					varAlert=varAlert+"\nPlease fill Udyog Aadhaar Number in Customer Profile";
							
					}

					if(varCGTMSEcovLimit=="Y")
					{
						varAlert=varAlert+"\nCGTMSE Coverage of the borrower should not exceed "+varmaxcgtmseLimit;
					}
					if(NatureofActivity=="")
					{
						varAlert=varAlert+"\nPlease fill Nature of Activity in Customer Profile";	
						
					} 
					if(varConstitution!="01" && varchiefpromotercheck=="N")
					{
						varAlert=varAlert+"\n atleast one Cheif Promoter is mandatory.  Kindly select atleast one in Customer Profile-Groups/Management Peoples tab";	
					}
		       }
		}	
		if(strSessionModuleType=="CORP" || strSessionModuleType=="AGR"){
			if( varCropCGTMSE=="Y"  && (document.forms[0].appstatus.value=="Open/Pending" || document.forms[0].appstatus.value=="Open/Lodged"))
			{
			
				if(parseFloat(varCGLimit)>=parseFloat(500000))
				{
					
					 if(varCGPan=="" || varCGPan=="NOPAN" )
					 {
							varAlert=varAlert+"\nPAN is mandatory for loan amount of Rs.5 lakh and above for coverage under CGTMSE";
						
					 }
				}
		}
		}
		//PAN CHECK FOR RETAIL AND CORPORATE		
		if(varPanCheck=="Y")
		{
			if(strSessionModuleType!="AGR" && document.forms[0].appstatus.value=="Open/Pending")
			{
				if(strPrdType!="pG" && strPrdType!="pR")
				{
					if(strSessionModuleType=="CORP")
					{	
						if(varConstitution!="183" && varConstitution!="184" && varConstitution!="185" && varConstitution!="186" 
							&& varConstitution!="187" && varConstitution!="188" && varConstitution!="189" && varConstitution!="190" && varConstitution!="192")	
						{	
						 if(Explimitchk=="F")
							 {
								 if (varPancount=="N")
								{
								 varAlert=varAlert + "\n Please obtain PAN number of the Applicants (including co-applicant/Joint borrower/Co-applicant) Co-Obligant/guarantor and capture in CBS for exposure (includes existing and proposed limit) of Rs.50,000/- and above ";
								}
								
							}
						}
					}
					else
					{
						if(Explimitchk=="F")
						 {
							 if (varPancount=="N")
							{
							 varAlert=varAlert + "\n Please obtain PAN number of the Applicants (including co-applicant/Joint borrower/Co-applicant) Co-Obligant/guarantor and capture in CBS for exposure (includes existing and proposed limit) of Rs.50,000/- and above ";
							}
							
						}
					}	
				}
			}
			if(strSessionModuleType=="AGR" && document.forms[0].appstatus.value=="Open/Pending")
			{
				if(Expmainactcheck>0)
				{
					if(Explimitagrchk=="F")
						 {
							if (varPancount=="N")
							{
							 varAlert=varAlert + "\n Please obtain PAN number of the Applicants (including co-applicant/Joint borrower/Co-applicant) Co-Obligant/guarantor and capture in CBS for exposure (includes existing and proposed limit) of Rs.10,00,000/- and above ";
							}	 
						}
				}
			}
		}
		//PAN CHECK FOR RETAIL AND CORPORATE

		if(document.forms[0].appstatus.value=="Open/Pending" && varAppraisedFlag!="Y")
		{
			varAlert=varAlert+"\nSelect Appraised by User Details in Proposal Flow tab";
		}
		if(document.forms[0].appstatus.value=="Open/Pending" && varSanctionFlag!="Y")
		{
			varAlert=varAlert+"\nSelect Sanctioned by User Details in Proposal Flow tab";
		}
		if(document.forms[0].appstatus.value=="Open/Pending"){
		if(varFacAdhocDet!="")
		{
			//alert(varFacAdhocDet);
			varAlert=varAlert+"\nMIS activity Code and Original Investment in Equipments/Cost of Vehicles Used in Business should be same for Regular Limit and Adhoc/Additional Limit";
		}
		}
		<% if(strSessionModuleType.equalsIgnoreCase("CORP")||strSessionModuleType.equalsIgnoreCase("AGR"))
		{%>
		
		if(document.forms[0].appstatus.value=="Open/Pending" && document.forms[0].hidintsubtypechk.value=="N")
		{	
			
			varAlert=varAlert+"\nPlease Enter Values Facilities -> Other Interest Rates / Commission -> "+varFacDesc;
			
		}
		<%}%>
		/*if(strSessionModuleType=="RET"){
			if(document.forms[0].appstatus.value=="Open/Pending"){
				if(varMISCODEFlag=="Y")
				{
					varAlert = varAlert + "\Please Reselect the Activity Code in MIS Details page";
				}
			}
		}*/
		<%if(COM_BANKSCHEME.equalsIgnoreCase("052")){%>
		<%if(strSessionModuleType.equalsIgnoreCase("RET") || strSessionModuleType.equalsIgnoreCase("CORP")||strSessionModuleType.equalsIgnoreCase("AGR")){%>
		
		<% if(!APP_LOANSUBTYPE_DIGI.equalsIgnoreCase("pR")) {%>
		
		<%if((strPrdtype.equalsIgnoreCase("pH"))|| (strPrdtype.equalsIgnoreCase("pA")&& (prd_purpose.equalsIgnoreCase("N")||prd_purpose.equalsIgnoreCase("U"))))
		{%>
		
		<%if(strProposalType.equalsIgnoreCase("F")||strProposalType.equalsIgnoreCase("R")){%>
		
		if((parseInt(userclass)>=50) && (document.forms[0].appstatus.value=="Open/Pending"))	
			{
			
		      if(document.forms[0].hidreasonproccchk.value=="N"){
		    	 
		    	 varAlert = varAlert+"\nPlease Enter Values in Appraisal -> Reason For Manual Processing Tab";
		       }
			}
		
		<%}}}}}%>

		<%if(strSessionModuleType.equalsIgnoreCase("RET")){%>
		<%if(!strProposalType.equalsIgnoreCase("P")){%>
	if(document.forms[0].appstatus.value=="Open/Pending"){
		 if(document.forms[0].hidmsmeretchk.value=="Y"||varMISCODEFlag=="Y"||document.forms[0].hidcarpetchk.value=="Y"||document.forms[0].hidproposedshgchk.value=="Y"||document.forms[0].hidretmisminority.value=="Y"){
		varAlert = varAlert + "\Please Reselect the Activity Code in MIS Details page";

	       }
	}
	<%}else if(strParams.contains("@MIS@")){%>
	if(document.forms[0].appstatus.value=="Open/Pending"){
		 if(document.forms[0].hidmsmeretchk.value=="Y"||varMISCODEFlag=="Y"||document.forms[0].hidcarpetchk.value=="Y"||document.forms[0].hidproposedshgchk.value=="Y"||document.forms[0].hidretpostmisminority.value=="Y"){
			varAlert = varAlert + "\Please Reselect the Activity Code in MIS Details page";

	       }
	}
	<%}}%>

	<% if(strSessionModuleType.equalsIgnoreCase("CORP")||strSessionModuleType.equalsIgnoreCase("AGR"))
	{%>
	<%if(!strProposalType.equalsIgnoreCase("P")){%>
	
	if(document.forms[0].appstatus.value=="Open/Pending"){
		 if(document.forms[0].hidmsmeretchk.value=="Y"||varMISCODEFlag=="Y"||document.forms[0].hidcarpetchk.value=="Y"||document.forms[0].hidproposedshgchk.value=="Y"||document.forms[0].hidcorpmisminority.value=="Y"){
			varAlert = varAlert + "\Please Reselect the Activity Code in MIS Details page";

	       }
	}
	<%}else if(strParams.contains("@MIS@")){%>
	if(document.forms[0].appstatus.value=="Open/Pending"){
		 if(document.forms[0].hidmsmeretchk.value=="Y"||varMISCODEFlag=="Y"||document.forms[0].hidcarpetchk.value=="Y"||document.forms[0].hidproposedshgchk.value=="Y"||document.forms[0].hidcorppostmisminority.value=="Y"){
			varAlert = varAlert + "\Please Reselect the Activity Code in MIS Details page";

	       }
	}
	<%}
	}%>
<%if (!strProposalType.equalsIgnoreCase("P")) {%>
if(varSvanidhi!="Y"){
	var intv=0;
			if(varmsmefalg=="Y"&& (document.forms[0].appstatus.value=="Open/Pending")){
					if(varmsmepanno=="" || varmsmepanno=="NOPAN" )
					{
						varAlert = varAlert + "\Please Update PANNO in Customer Profile -> Demographics tab";
					}
					
				    if(varmsmeudyamregno=="")
				    {
						varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
				    }  
				    else
				    {
				    	var udyamchar = varmsmeudyamregno;
				    	var capudyamchar=udyamchar.toUpperCase();
				    	if(capudyamchar.length==19)
				    	{
				    	for (var i = 0; i < capudyamchar.length; i++) {
				    	
				    		  if(capudyamchar.charAt(0)!='U')
				    		  {
					    		  if(intv==0)
					    		  {
				    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
                                     ++intv;
						    	}
					    		  
				    		  }
				    		  if(capudyamchar.charAt(1)!='D')
				    		  {
				    			  if(intv==0)
					    		  {
				    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
                                     ++intv;
						    	}
				    			 
				    		  }
				    		  if(capudyamchar.charAt(2)!='Y')
				    		  {
				    			  if(intv==0)
					    		  {
				    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
                                     ++intv;
						    	}
				    			 
				    		  }
				    		  if(capudyamchar.charAt(3)!='A')
				    		  {
				    			  if(intv==0)
					    		  {
				    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
                                     ++intv;
						    	}
				    			 
				    		  }
				    		  if(capudyamchar.charAt(4)!='M')
				    		  {
				    			  if(intv==0)
					    		  {
				    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
                                     ++intv;
						    	}
				    		  }
				    		  if(capudyamchar.charAt(5)!='-')
				    		  {
				    			  if(intv==0)
					    		  {
				    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
                                     ++intv;
						    	}
				    			 
				    		  }
				    		  if(capudyamchar.charAt(6))
				    		  {
				    			  var code = capudyamchar.charCodeAt(6);
				    			  if(!(code>=65 && code<=90))
				    			  {
				    				  if(intv==0)
						    		  {
					    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
	                                     ++intv;
							    	}
				    			  }
				    		  }
				    		  if(capudyamchar.charAt(7))
				    		  {
				    			  var code = capudyamchar.charCodeAt(7);
				    			  if(!(code>=65 && code<=90))
				    			  {
				    				  if(intv==0)
						    		  {
					    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
	                                     ++intv;
							    	}
				    			  }
				    		  }
				    		  if(capudyamchar.charAt(8)!='-')
				    		  {
				    			  if(intv==0)
					    		  {
				    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
                                     ++intv;
						    	}
				    			 
				    		  }
				    		  if(capudyamchar.charAt(9))
				    		  {
				    			  var code = capudyamchar.charCodeAt(9);
				    			  if(!(code>=48 && code<=57))
				    			  {
				    				  if(intv==0)
						    		  {
					    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
	                                     ++intv;
							    	}
				    			  }
				    		  }
				    		  if(capudyamchar.charAt(10))
				    		  {
				    			  var code = capudyamchar.charCodeAt(10);
				    			  if(!(code>=48 && code<=57))
				    			  {
				    				  if(intv==0)
						    		  {
					    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
	                                     ++intv;
							    	}
				    			  }
				    		  }
				    		  if(capudyamchar.charAt(11)!='-')
				    		  {
				    			  if(intv==0)
					    		  {
				    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
                                     ++intv;
						    	}
				    			 
				    		  }
				    		  if(capudyamchar.charAt(12))
				    		  {
				    			  var code = capudyamchar.charCodeAt(12);
				    			  if(!(code>=48 && code<=57))
				    			  {
				    				  if(intv==0)
						    		  {
					    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
	                                     ++intv;
							    	}
				    			  }
				    		  }
				    		  if(capudyamchar.charAt(13))
				    		  {
				    			  var code = capudyamchar.charCodeAt(13);
				    			  if(!(code>=48 && code<=57))
				    			  {
				    				  if(intv==0)
						    		  {
					    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
	                                     ++intv;
							    	}
				    			  }
				    		  }
				    		  if(capudyamchar.charAt(14))
				    		  {
				    			  var code = capudyamchar.charCodeAt(14);
				    			  if(!(code>=48 && code<=57))
				    			  {
				    				  if(intv==0)
						    		  {
					    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
	                                     ++intv;
							    	}
				    			  }
				    		  }
				    		  if(capudyamchar.charAt(15))
				    		  {
				    			  var code = capudyamchar.charCodeAt(15);
				    			  if(!(code>=48 && code<=57))
				    			  {
				    				  if(intv==0)
						    		  {
					    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
	                                     ++intv;
							    	}
				    			  }
				    		  }
				    		  if(capudyamchar.charAt(16))
				    		  {
				    			  var code = capudyamchar.charCodeAt(16);
				    			  if(!(code>=48 && code<=57))
				    			  {
				    				  if(intv==0)
						    		  {
					    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
	                                     ++intv;
							    	}
				    			  }
				    		  }
				    		  if(capudyamchar.charAt(17))
				    		  {
				    			  var code = capudyamchar.charCodeAt(17);
				    			  if(!(code>=48 && code<=57))
				    			  {
				    				  if(intv==0)
						    		  {
					    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
	                                     ++intv;
							    	}
				    			  }
				    		  }
				    		  if(capudyamchar.charAt(18))
				    		  {
				    			  var code = capudyamchar.charCodeAt(18);
				    			  if(!(code>=48 && code<=57))
				    			  {
				    				  if(intv==0)
						    		  {
					    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
	                                     ++intv;
							    	}
				    			  }
				    		  }
				    		 
				    		  
				    		  
				    			  
				    		  
				    			  
				    		}
				    	}
				    	else
				    	{
				    		if(intv==0)
				    		  {
			    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
                               ++intv;
					    	}
				    	}
				    }
				    if(varmsmecertificationdate=="")
					{
						varAlert = varAlert + "\Please Update Udyam Certification Date in Customer Profile -> Demographics tab";
				    }
					/*if(varmsmeclassification==""||varmsmeclassification=="0")
					{
						varAlert = varAlert + "\Please Update MSME Classification as per Udyam Registration Certificate in Customer Profile -> Demographics tab";
					}
					if(!(varGSTReg=="Y" ||(varGSTReg=="N" && varGSTExempted=="Y")))
					{
						varAlert = varAlert + "\Please Update GST Registration No/Exempted Details in Customer Profile -> Demographics tab";
					}*/
									
				 }
}
			<%} else if (strParams.contains("@MIS@")) {%>
			if(varSvanidhi!="Y"){
				var intv=0;
			if(varmsmefalg=="Y" && varmsmepostsancdate=="Y" && document.forms[0].appstatus.value=="Open/Pending"){
				if(varmsmepanno=="" || varmsmepanno=="NOPAN" )
				{
					varAlert = varAlert + "\Please Update PANNO in Customer Profile -> Demographics tab";
				}
				
			    if(varmsmeudyamregno=="" )
			    {
					varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
			    }  
			    else 
			    {
			    	var udyamchar = varmsmeudyamregno;
			    	var capudyamchar=udyamchar.toUpperCase();
			    	if(capudyamchar.length==19)
			    	{
			    	for (var i = 0; i < capudyamchar.length; i++) {
			    		
			    		  if(capudyamchar.charAt(0)!='U')
			    		  {
			    			  if(intv==0)
				    		  {
			    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
                                 ++intv;
					    	}
			    			 
			    		  }
			    		  if(capudyamchar.charAt(1)!='D')
			    		  {
			    			  if(intv==0)
				    		  {
			    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
                                 ++intv;
					    	}
			    			 
			    		  }
			    		  if(capudyamchar.charAt(2)!='Y')
			    		  {
			    			  if(intv==0)
				    		  {
			    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
                                 ++intv;
					    	}
			    			 
			    		  }
			    		  if(capudyamchar.charAt(3)!='A')
			    		  {
			    			  if(intv==0)
				    		  {
			    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
                                 ++intv;
					    	}
			    			 
			    		  }
			    		  if(capudyamchar.charAt(4)!='M')
			    		  {
			    			  if(intv==0)
				    		  {
			    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
                                 ++intv;
					    	}
			    			 
			    		  }
			    		  if(capudyamchar.charAt(5)!='-')
			    		  {
			    			  if(intv==0)
				    		  {
			    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
                                 ++intv;
					    	}
			    		  }
			    		  if(capudyamchar.charAt(6))
			    		  {
			    			 var code = capudyamchar.charCodeAt(6);
			    			  if(!(code>=65 && code<=90))
			    			  {
			    				  if(intv==0)
					    		  {
				    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
                                     ++intv;
						    	}
			    			  }
			    		  }
			    		  if(capudyamchar.charAt(7))
			    		  {
			    			  var code = capudyamchar.charCodeAt(7);
			    			  if(!(code>=65 && code<=90))
			    			  {
			    				  if(intv==0)
					    		  {
				    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
                                     ++intv;
						    	}
			    			  }
			    		  }
			    		  if(capudyamchar.charAt(8)!='-')
			    		  {
			    			  if(intv==0)
				    		  {
			    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
                                 ++intv;
					    	}
			    			 
			    		  }
			    		  if(capudyamchar.charAt(9))
			    		  {
			    			 var code = capudyamchar.charCodeAt(9);
			    			  if(!(code>=48 && code<=57))
			    			  {
			    				  if(intv==0)
					    		  {
				    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
                                     ++intv;
						    	}
			    			  }
			    		  }
			    		  if(capudyamchar.charAt(10))
			    		  {
			    			  var code = capudyamchar.charCodeAt(10);
			    			  if(!(code>=48 && code<=57))
			    			  {
			    				  if(intv==0)
					    		  {
				    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
                                     ++intv;
						    	}
			    			  }
			    		  }
			    		  if(capudyamchar.charAt(11)!='-')
			    		  {
			    			  if(intv==0)
				    		  {
			    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
                                 ++intv;
					    	}
			    			 
			    		  }
			    		  if(capudyamchar.charAt(12))
			    		  {
			    			 var code = capudyamchar.charCodeAt(12);
			    			  if(!(code>=48 && code<=57))
			    			  {
			    				  if(intv==0)
					    		  {
				    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
                                     ++intv;
						    	}
			    			  }
			    		  }
			    		  if(capudyamchar.charAt(13))
			    		  {
			    			 var code = capudyamchar.charCodeAt(13);
			    			  if(!(code>=48 && code<=57))
			    			  {
			    				  if(intv==0)
					    		  {
				    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
                                     ++intv;
						    	}
			    			  }
			    		  }
			    		  if(capudyamchar.charAt(14))
			    		  {
			    			  var code = capudyamchar.charCodeAt(14);
			    			  if(!(code>=48 && code<=57))
			    			  {
			    				  if(intv==0)
					    		  {
				    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
                                     ++intv;
						    	}
			    			  }
			    		  }
			    		  if(capudyamchar.charAt(15))
			    		  {
			    			  var code = capudyamchar.charCodeAt(15);
			    			  if(!(code>=48 && code<=57))
			    			  {
			    				  if(intv==0)
					    		  {
				    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
                                     ++intv;
						    	}
			    			  }
			    		  }
			    		  if(capudyamchar.charAt(16))
			    		  {
			    			  var code = capudyamchar.charCodeAt(16);
			    			  if(!(code>=48 && code<=57))
			    			  {
			    				  if(intv==0)
					    		  {
				    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
                                     ++intv;
						    	}
			    			  }
			    		  }
			    		  if(capudyamchar.charAt(17))
			    		  {
			    			  var code = capudyamchar.charCodeAt(17);
			    			  if(!(code>=48 && code<=57))
			    			  {
			    				  if(intv==0)
					    		  {
				    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
                                     ++intv;
						    	}
			    			  }
			    		  }
			    		  if(capudyamchar.charAt(18))
			    		  {
			    			  var code = capudyamchar.charCodeAt(18);
			    			  if(!(code>=48 && code<=57))
			    			  {
			    				  if(intv==0)
					    		  {
				    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
                                     ++intv;
						    	}
			    			  }
			    		  }
			    		 
			    		  
			    		  
			    			  
			    		  
			    			  
			    		}
			    	}
			    	else
			    	{
			    		if(intv==0)
			    		  {
		    			  varAlert = varAlert + "\Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.";
                           ++intv;
				    	}
			    	}
			    }
			    if(varmsmecertificationdate=="" )
				{
					
					varAlert = varAlert + "\Please Update Udyam Certification Date in Customer Profile -> Demographics tab";
			    }
				/*if(varmsmeclassification==""||varmsmeclassification=="0" )
				{
					varAlert = varAlert + "\Please Update MSME Classification as per Udyam Registration Certificate in Customer Profile -> Demographics tab";
				}
				if(!(varGSTReg=="Y" ||(varGSTReg=="N" && varGSTExempted=="Y")))
				{
					varAlert = varAlert + "\Please Update GST Registration No/Exempted Details in Customer Profile -> Demographics tab";
				}*/

				 }
			}
			<%}%>
			<%if (!strProposalType.equalsIgnoreCase("P")&& !strProposalType.equalsIgnoreCase("S")) {%>
			<% if(strSessionModuleType.equalsIgnoreCase("CORP"))
			{%>
			if((document.forms[0].hidgecl3propstatus.value=="Y" && document.forms[0].hidgecl2propstatus.value=="Y")&& (document.forms[0].appstatus.value=="Open/Pending")){
				varAlert = varAlert + "\Already sanctioned GECL-3 facility exists for this borrower hence user cannot proceed with GECL-1 or GECL-2";
			}
			if((document.forms[0].hidgecl3propstatus.value=="Y" && document.forms[0].hidgecl1propstatus.value=="Y")&& (document.forms[0].appstatus.value=="Open/Pending")){
				varAlert = varAlert + "\Already sanctioned GECL-3 facility exists for this borrower hence user cannot proceed with GECL-1 or GECL-2";
			}
			<%}}%>
			<%if (strProposalType.equalsIgnoreCase("S")) {%>
			<% if(strSessionModuleType.equalsIgnoreCase("CORP"))
			{%>
			
		
			
			if((varrestasschk!="Y" && varrestassesmandatory=="Y" && vargecltype=="GECL1") && (document.forms[0].appstatus.value=="Open/Pending")){
				varAlert = varAlert + "\Please enter the details in Assesment for KBL GECL tab Details.";
				
			}
			if(((vargecl3restructure=="Y"|| vargecl3restructurebybrw=="Y") && vargecltype=="GECL1") && (document.forms[0].appstatus.value=="Open/Pending")){
				varAlert = varAlert + "\Already sanctioned GECL-3 facility exists for this borrower hence user cannot proceed with GECL1-Restructure";
				
			}
			if(((vargecl1restructure=="Y"|| vargecl1restructurecheck=="Y") && vargecltype=="GECL1") && (document.forms[0].appstatus.value=="Open/Pending")){
				varAlert = varAlert + "\Please re enter the details in Assesment for KBL GECL tab Details.";
				
			}
			<%}}%>
			<% if(strSessionModuleType.equalsIgnoreCase("CORP")||strSessionModuleType.equalsIgnoreCase("AGR"))
			{%>
			if((varbankingarrangemnet=="Y" && varsolechk=="N")&& (document.forms[0].appstatus.value=="Open/Pending")){
				varAlert = varAlert + "\n Proposed Banking arrangement  type is other than sole in facilitied Tab  then  Banking Arrangement Tab Banking Arrangement Type also Should be other than sole";
			} 
			if(varbankingarrangemnet=="Y"){
			if((varwcmandatorychk=="N")&& (document.forms[0].appstatus.value=="Open/Pending")){
				if(varwctype=="C"){
				varAlert = varAlert + "\n Please Enter Values in Consortium Details for WC ->Banking Arrangement tab ->Consortium Details for WC Tab";
				}else if(varwctype=="M"){
					varAlert = varAlert + "\n Please Enter Values in Multiple Banking Details for WC ->Banking Arrangement tab ->Multiple Banking Details for WC Tab";
					
				}
				} 
			if((vartlmandatorychk=="N")&& (document.forms[0].appstatus.value=="Open/Pending")){
				if(vartltype=="C"){
					varAlert = varAlert + "\n Please Enter Values in Consortium Details for TL ->Banking Arrangement tab ->Consortium Details for TL Tab";
					}else if(vartltype=="M"){
						varAlert = varAlert + "\n Please Enter Values in Multiple Banking Details for TL ->Banking Arrangement tab ->Multiple Banking Details for TL Tab";
						
					}
				} 
				}
			if(varbankargmultwcconschk=="Y" && (document.forms[0].appstatus.value=="Open/Pending")){
				varAlert = varAlert + "\n In Banking arrangement Consortium type number of consortium is given as "+varwccount+"but entry is not available for each consortium type in consortium details tab";

				}
			if(varbankargmulttlconschk=="Y" && (document.forms[0].appstatus.value=="Open/Pending")){
				varAlert = varAlert + "\n In Banking arrangement Consortium type number of consortium is given as"+ vartlcount+" but entry is not available for each consortium type in consortium details tab";
				
				}
			 <%if(strProposalType.equalsIgnoreCase("P")){%>
				
				/*if(document.forms[0].appstatus.value=="Open/Pending")
				{
				if((varbankingarrangemnet=="N") && ((varwctype=="M" ||varwctype=="C") || (vartltype=="M" ||vartltype=="C"))){
					varAlert = varAlert + "\n Kindly delete  and reenter the banking arrangement Tab ";
				}
				if((varbankingarrangemnet=="N") && (varwcmandatorychk=="Y" ||vartlmandatorychk=="Y")){
					varAlert = varAlert + "\n Kindly Delete  Multiple Banking Details/Consortium Banking details tab and reenter Multiple Banking Details/Consortium Banking details to proceed further ";
				}
				
				}*/
				<%}%>
			<%}%>
			if(varListCompany =="Y" ){
				 if( varCIN==""){
					 varAlert = varAlert + "\nPlease Enter CIN number in Customer Profile Page "; 
				 }else{
					 if(varCIN.length != "21"){
						 varAlert = varAlert + "\n Entered CIN number length should  be of 21 characters "; 
							 
					 }
				 }
				 
			}
			varSchemecode="<%=Helper.correctNull((String)hshValues.get("strschemecode"))%>";
			if(varSchemecode=="069" && document.forms[0].hidaadharchek.value=="N" && document.forms[0].hidmisactivittycodencgtcchk.value=="Y")
			{
				varAlert=varAlert+"\nPlease fill Udyog Aadhaar Number in Customer Profile";
			}	
			var varchiefpromotercheck="<%=Helper.correctNull((String)hshValues.get("COMAPP_CHF_PROMOTER"))%>";
			if(varSchemecode=="069" && varchiefpromotercheck=="N")
			{
				varAlert=varAlert+"\nFor this scheme Cheif Promoter is mandatory.  Kindly select atleast onein Customer Profile-Groups/Management Peoples tab";
			}
			var metrocheck="";
			metrocheck="<%=Helper.correctNull((String)hshValues.get("CORP_METROPROJECT"))%>";
			if(varSchemecode=="069" && metrocheck=="1")
			{
				varAlert=varAlert+"\nThis scheme is not available for Metropolitan cities.  Kindly modify the same in KBL Aarogya tab";
			}
			<% if(strSessionModuleType.equalsIgnoreCase("CORP") || strSessionModuleType.equalsIgnoreCase("AGR"))
			{%>
			if(document.forms[0].sel_facility.value=="s" || document.forms[0].sel_facility.value=="")
			{
				var varSchemecode1="<%=Helper.correctNull((String)hshValues.get("strschemecodevalue"))%>";
				varmetroflagall="<%=Helper.correctNull((String)hshValues.get("CORP_METROPROJECT_FLAG"))%>";
				if(varSchemecode1=="069" && varmetroflagall=="1")
				{
					varAlert=varAlert+"\nThis scheme is not available for Metropolitan cities.  Kindly modify the same in KBL Aarogya tab";
				}
				varchiefpromotercheck="<%=Helper.correctNull((String)hshValues.get("COMAPP_CHF_PROMOTER"))%>";
			
				if(varSchemecode1=="069" && varchiefpromotercheck=="N")
				{
					varAlert=varAlert+"\nFor this scheme Cheif Promoter is mandatory.  Kindly select atleast onein Customer Profile-Groups/Management Peoples tab";
				}
				var aadharchekflag="<%=Helper.correctNull((String)hshValues.get("aadharchekflag"))%>";
			
				var misactivittycodencgtcchkflag="<%=Helper.correctNull((String)hshValues.get("misactivittycodencgtcchkflag"))%>";
				
				if(varSchemecode1=="069" && aadharchekflag=="N")
				{
					varAlert=varAlert+"\nPlease fill Udyog Aadhaar Number in Customer Profile";
				}		
			}
		<%}%>
		if(varEntrepriseError=="Y")
		{
			varAlert=varAlert + "\n If in MIS details - Agriculture Industry Service Category is Micro Enterprises, then in CGTMSE Coverage button value in 'Whether the unit Assisted is an Micro Enterprise as per the MSMED Act 2006 definition of MSE' should be Yes or else value should be No for facility:"+varFacilitesSNNo;
		}
	if(document.forms[0].appstatus.value=="Processed/Approved"||document.forms[0].appstatus.value=="Closed/Approved")
	{
		varAlert="";
	}
		
	if(varAlert=="")
	{
		document.all.PropInComp.style.display="none";
		document.all.PropComp.style.display="table-cell";
	}
	else
	{
		document.all.PropInComp.style.display="table-cell";
		document.all.PropComp.style.display="none";
		document.forms[0].hidSancAlert.value = varAlert;
	}
	if(varAlert!="")
	{
		if(varListCompany=='Y' && varCIN!="" ){
			if(varCIN.charAt(0)=='L'  && varCIN.length=="21"){
			
			document.forms[0].chk_dec.disabled = true;
		}}
	}else{
        if(varListCompany=='Y' && varCIN!="" ){
        	if(varCIN.charAt(0)=='L' && varCIN.length=="21"){
			document.forms[0].chk_dec.disabled = false;
		}}
	}
	return ;	
}

function doSancCheck()
{

	     alert(document.forms[0].hidSancAlert.value);
}


function doSave()
{
	if(ConfirmMsg(166))
	{
		//document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidSourceUrl.value="/action/appworkflowhistory.jsp"; 
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanMethod.value="getSave";
		document.forms[0].hidBeanGetMethod.value="getHistory";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}
function callOtherTab(val)
{
	 if(val=="history")
	 {
		 document.forms[0].hidBeanGetMethod.value="getHistory";
		 document.forms[0].hidBeanId.value="commworkflow";
		 document.forms[0].action=appURL+"action/appworkflowhistory.jsp";
		 document.forms[0].submit();
	 }
	 
	 if(val=="drawdownschedule")
	 {
		if (varapptype == "C"||true)
		{
		 document.forms[0].hidBeanId.value="commworkflow";
		 document.forms[0].hidBeanGetMethod.value="getDrawDownSchedule";
		 document.forms[0].action=appURL+"action/drawdownschedule.jsp";
		 document.forms[0].submit();
	 	}
		else
		{
                alert("Draw Down Schedule to be Entered only for Project Loans");
                return;
        }
   }
	if(val=="sanction")
	{
		document.forms[0].hidBeanGetMethod.value="getTermsofSanctionFacilityData";
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].action=appURL+"action/com_termsofsanction.jsp";
		document.forms[0].submit();
	}
	if(val=="legcomp")
	{
		document.forms[0].app_loantype.value=varapptype;
		document.forms[0].app_legalcomp.value=varapptype;
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanGetMethod.value="getlegalComplianceData";
		document.forms[0].action=appURL+"action/legalcompliance.jsp";
		document.forms[0].submit();
	}
	if(val=="restrfacdetails")
	{
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanGetMethod.value="getRestrFacilityDetails";
		document.forms[0].action=appURL+"action/apprestructureaccountdetails.jsp";
		document.forms[0].submit();
	}
	if(val=="CGTMSE_TXN")
	{
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanGetMethod.value="getCGTMSE_txndet";
		document.forms[0].action=appURL+"action/app_CGTMSE_txnDet.jsp";
		document.forms[0].submit();
	}
}
function showgeclchk(){
	var date1 =  "<%=Helper.getCurrentDateTime()%>";
	//var date2= "01/10/2021";
	var date2= "31/03/2022";
	var pcgdt=date1.substring(0,2);
	var pcgmon=date1.substring(3,5);
	var pcgyear=date1.substring(6,10);
	var curdate=pcgmon+"/"+pcgdt+"/"+pcgyear;
	
	var ppgdt=date2.substring(0,2);
	var ppgmon=date2.substring(3,5);
	var ppgyear=date2.substring(6,10);
	var harddate=ppgmon+"/"+ppgdt+"/"+ppgyear;
	if(varstakovernorms=="Y"&&vargeclnewchk=="Y"){
		 if(Date.parse(curdate)>Date.parse(harddate))
		  {
			//alert("For KBL GECL Scheme sanctioned on or upto 30/09/2021 disbursement cannot be done after 01/01/2022");
			alert("For KBL GECL Scheme sanctioned on or upto 31/03/2022 disbursement cannot be done after 01/07/2022");
			return;
		  }
	}
}
//added by s.sathya moorthy for finacle interface...23/08/2007
function showSanctionDetails()
{

	
	if(strSessionModuleType=="CORP")
	{
		showgeclchk();
	}
	if(strSessionModuleType=="AGR" || strSessionModuleType=="CORP")
	{
		if(document.forms[0].sel_facility.value=="s")
		{
			alert("Please Choose Any Facility");
			return;
		}
		var varFlag=document.forms[0].hidLADFlag.value;
		if(varFlag!="")
		{
			var arr = varFlag.split("~");
			var arrLength=arr.length;
			if(arr!=null)
			{
				for(var i=0;i<arrLength;i++)
				{
					var arr1 = arr[i].split("@");
					if(arr1[0]==document.forms[0].sel_facility.value)
					{
						if(arr1[1]=="N")
						{
							alert("Please Enter Installment start date in Workflow -> Loan Account Details tab");
							return;
						}
					}
				}
			}
		}
		varFlag=document.forms[0].hidKFSDetails.value;
		var boolflag=false;
		if(varFlag!="")
		{
			var arr = varFlag.split("@");
			var arrLength=arr.length;
			if(arr!=null)
			{
				for(var i=0;i<arrLength;i++)
				{
					if(arr[i]==document.forms[0].sel_facility.value)
					{
						boolflag=true;
					}
				}
			}
		}

		if(!boolflag)
		{
			alert("Please Enter Key Fact Statement Details");
			return;
		}
	}
	else
	{
		if(strPrdType!="pG" && strPrdType!="pR")
		{
			if(varPrdLoanType!="OD" && varstrFlowDateFlag=="N")
			{
				alert("Please Enter Installment start date in Workflow -> Loan Account Details tab");
				return;
			}
		}
		if(document.forms[0].hidKFSDetails.value!="1")
		{
			alert("Please Enter Key Fact Statement Details");
			return;
		}
	}
	if(strSessionModuleType=="AGR" || strSessionModuleType=="CORP")
	{
		
		var sentfacility		=	document.forms[0].sendfacility.value;
		if(sentfacility!="")
		{
			var arr = sentfacility.split("@");
			var arrLength=arr.length;
			if(arr!=null)
			{
				for(var i=0;i<arrLength;i++)
				{
					if(arr[i]==document.forms[0].sel_facility.value)
					{
						alert("The Facility already Sent to CBS ");
						document.forms[0].sel_facility.value="s";
						document.forms[0].sel_facility.focus();
						return;
					}
				}
			}
		}
		
		var closedfacility		=	document.forms[0].closedfacility.value;
		if(closedfacility!="")
		{
			var arr = closedfacility.split("@");
			var arrLength=arr.length;
			if(arr!=null)
			{
				for(var i=0;i<arrLength;i++)
				{
					if(arr[i]==document.forms[0].sel_facility.value)
					{
						alert("This Facility is already Closed");
						document.forms[0].sel_facility.value="s";
						document.forms[0].sel_facility.focus();
						return;
					}
				}
			}
		}
	}
	if(strPrdType!="pG" && strPrdType!="pR")
	{
		<%if(arrBankRow1!=null && arrBankRow1.size()>0)
		{
			if(!arrBankRow1.contains("COCTC"))
			{%>
			if(document.forms[0].hiddoccheck.value=="Y"){
				alert("Please Upload COCTC Document in Documents-->Post sanction Document Attachment tab");
				return;
			}

			<%}if(strLoanSubType.equalsIgnoreCase("PC")){
				if(!arrBankRow1.contains("COCSV")){ %>
					alert("Please Upload COCSV Document in DocumentsPost sanction Document Attachment tab");
					return;
			
		<%}}}else{%>
			alert("Please Upload Attachment in Documents-->Post sanction Document Attachment tab");
			return;
		<%}%>
	}
	if(varListCompany=='Y' && varCIN!="" ){ 
		if(varCIN.charAt(0)=='L' && varCIN.length=="21"){	
	if(document.forms[0].chk_dec.checked==false){
		 alert("Please check the Declaration for Listed Company to proceed");
		 return;
	}}}
	if(ConfirmMsg(159))
	{
		if(strSessionModuleType=="CORP" || strSessionModuleType=="AGR")
		{
			var varcgtmse = document.forms[0].sel_facility.value;
			var varcgtsplit = varcgtmse.split("-");
			if( varCropCGTMSE=="Y")
			{
				alert("Facility is covered under CGTMSE. Kindly complete all the formalities related to CGTMSE on the date of disbursement itself");
			}
			
		}
		if(strSessionModuleType=="CORP")
		{
			//if(varSchemecode=="070" && (com_facility_emischeme!="ODGEN" && com_facility_emischeme!="ODPS"))
		}
		if(strSessionModuleType=="RET")
		{
		   <%if (Helper.correctNull((String)session.getAttribute("PRD_CGTMSE")).equalsIgnoreCase("Y")){ %>
	         alert("Facility is covered under CGTMSE. Kindly complete all the formalities related to CGTMSE on the date of disbursement itself");
	        <%}%>
		}
		
		if((strPrdType=="pG" || strPrdType=="pR")&&(vardigisubtype==""))
		{
			document.forms[0].hidAction.value="manualCBS";
			document.forms[0].hidBeanId.value="commworkflow";
			document.forms[0].hidBeanGetMethod.value="manualloanAccountCreationService";
			document.forms[0].action=appURL+"action/appworkflowhistory.jsp";
			document.forms[0].submit();
		}else{
		    document.forms[0].hidBeanId.value="commworkflow";
			document.forms[0].hidBeanGetMethod.value="getAction";
			document.forms[0].hidAction.value="flatfile";
			document.forms[0].action=appURL+"action/appworkflowaction.jsp";
			document.forms[0].submit();
		}
	}
}

function showTertiarySanctionDetails()
{
	appno=document.forms[0].appno.value;
	var purl ="<%=ApplicationParams.getAppUrl()%>action/TertiarySanctionAdvice.jsp?hidBeanGetMethod=getCorporateSanctionAdvice&hidBeanId=commworkflow&appno="+appno+"&hidAppType=C";
	var prop = 'scrollbars=yes,menubar=yes,width=900,height=520,status=yes';	
	var xpos = (screen.width - 900) / 2;
	var ypos = (screen.height - 520) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'Tertiary_Sanction_Advice',prop);
}

function show_Corp_SanctionDetails()
{
	appno=document.forms[0].appno.value;
	<%if (loan_type.equalsIgnoreCase("C")) {%>
	if(var_CPAO!='Y')
	{
		var purl ="<%=ApplicationParams.getAppUrl()%>action/SanctionDetails_Corporate.jsp?hidBeanGetMethod=checkRating&hidBeanId=additionalParameter&appno="+appno;
		var prop = 'scrollbars=yes,menubar=yes,width=900,height=520,status=yes';
		var xpos = (screen.width - 900) / 2;
		var ypos = (screen.height - 600) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,'Corporate_Sanction_Details',prop);
	}
	else 
	{
		if(document.forms[0].txt_cntflag.value=='Y')
		{
			var purl ="<%=ApplicationParams.getAppUrl()%>action/SanctionDetails_Corporate.jsp?hidBeanGetMethod=checkRating&hidBeanId=additionalParameter&appno="+appno;
			var prop = 'scrollbars=yes,menubar=yes,width=900,height=520,status=yes';
			var xpos = (screen.width - 900) / 2;
			var ypos = (screen.height - 600) / 2;
			prop = prop + ",left="+xpos+",top="+ypos;
			window.open(purl,'Corporate_Sanction_Details',prop);
		}
		else
		{
			alert("Please Enter details in Credit Process Audit");
			return;
		}
	}
	<%}if (loan_type.equalsIgnoreCase("T")) {%>
		var purl ="<%=ApplicationParams.getAppUrl()%>action/ops_sanctiondetails.jsp?hidBeanGetMethod=checkRating&hidBeanId=additionalParameter&com_appno="+appno;	
		var prop = 'scrollbars=yes,menubar=yes,width=900,height=520,status=yes';
		var xpos = (screen.width - 900) / 2;
		var ypos = (screen.height - 600) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,'Tertiary_Sanction_Details',prop);		
	<%}%>
}

function show_CreditProcessAudit()
{
	if(ConfirmMsg(168))
	{
		appno=document.forms[0].appno.value;
		var purl ="<%=ApplicationParams.getAppUrl()%>action/com_creditprocessaudit.jsp?hidBeanGetMethod=getCreditProcessAudit&hidBeanId=commworkflow&appno="+appno;
		var prop = 'scrollbars=yes,menubar=yes,width=900,height=520,status=yes';
		var xpos = (screen.width - 900) / 2;
		var ypos = (screen.height - 600) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,'Credit_Process_Audit',prop);
	}
}
/*
function callDeviation(action)
{
	var appid=document.forms[0].hidapplicantid.value;
	appno=document.forms[0].appno.value;
	var purl ="<%=ApplicationParams.getAppUrl()%>action/perlimitofloan.jsp?Applicationno="+appno+"&btnenable="+btnenable+"&hidapplicantid="+appid;
	var xpos = (screen.width - 900) / 2;
	var ypos = (screen.height - 700) / 2;
	var prop = 'scrollbars=yes,menubar=YES,width=900,height=550,status=yes';
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'Deviation',prop);
}*/
function doReassign()
{
	if(varQueryStatus=="No" && document.forms[0].org_code.value!="001014001000000" && document.forms[0].org_code.value!="001007001000000" && document.forms[0].org_code.value!="001002001000000")
	{
		alert("All the Queries yet to get the reply.Please Ensure all the queries are in Closed status.");
		return;
	}
	if(varquerypending=="No"&&(document.forms[0].org_code.value=="001014001000000"||document.forms[0].org_code.value=="001007001000000"||document.forms[0].org_code.value=="001002001000000"))
	{
	alert("Some Queries are in Send Status. Please reply before reassigning the proposal.");
	return;
	}
	if(var_rating_pending == "Y")
	{
		alert("Proposal is pending in Kalypto. Cannot reassign the Proposal.");
		return;
	}
	if(document.forms[0].mail_tousrid.value=="")
	{
		ShowAlert(111,"Recipient");
		return;
	}
	if(document.forms[0].remarksFlag.value!="true")
	{			
		document.forms[0].hideditoption.value="Y"
	    callRemarks();
		return;
	}
	else
	{
		document.forms[0].hidSourceUrl.value="/action/appworkflowaction.jsp" 
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanMethod.value="updateAction";
		document.forms[0].hidBeanGetMethod.value="getAction";
		document.forms[0].hidAction.value="reallocate";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}
function callComment()
{
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanGetMethod.value="getWorkFlowComments";
	document.forms[0].action=appURL+"action/appworkflowcomment.jsp";
	document.forms[0].submit();
}
function callQueries()
{
		 document.forms[0].hidBeanGetMethod.value="getQueryData";
		 document.forms[0].hidBeanId.value="documentsupport";
		 document.forms[0].action=appURL+"action/appqueryhome.jsp";
		 document.forms[0].submit();
}
function callCalender(val)
{
	showCal(appURL,val);
}
/*function callCBSDetails(action)
{
	appno=document.forms[0].appno.value;
	var purl ="<%=ApplicationParams.getAppUrl()%>action/CBSData.jsp?hidBeanGetMethod=getCBSDetails&hidBeanId=FinacleBean&Applicationno="+appno+"&btnenable="+btnenable;
	var xpos = (screen.width - 900) / 2;
	var ypos = (screen.height - 700) / 2;
	var prop = 'menubar=YES,width=900,height=550,status=yes';
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'Deviation',prop);
}
function callMISDetails()
{
	var purl ="<%=ApplicationParams.getAppUrl()%>action/misdetails.jsp?hidBeanGetMethod=getMISDetails&hidBeanId=mis&Applicationno="+appno+"&btnenable="+btnenable;
	var xpos = (screen.width - 900) / 2;
	var ypos = (screen.height - 700) / 2;
	var prop = 'menubar=YES,scrollbars=YES,width=900,height=550,status=yes';
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'Deviation',prop);
}*/

function UpdateCBS()
{
    document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanGetMethod.value="getAction";
	document.forms[0].hidAction.value="addCBSAccount";
	document.forms[0].action=appURL+"action/appworkflowaction.jsp";
	document.forms[0].submit();
}
function doLodge()
{
	if(var_rating_pending == "Y")
	{
		alert("Proposal is pending in Kalypto. Cannot proceed for Lodging.");
		return;
	}
	if(document.forms[0].txt_lodgedrefno.value=="")
	{
		ShowAlert(121,"Lodged Reference Number");
		document.forms[0].txt_lodgedrefno.focus();
		return;
	}
	document.forms[0].hidSourceUrl.value="/action/appworkflowaction.jsp" 
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanMethod.value="updateAction";
	document.forms[0].hidBeanGetMethod.value="getAction";
	document.forms[0].hidAction.value="Lodge";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doDislodge()
{

	document.forms[0].hidSourceUrl.value="/action/appworkflowaction.jsp" 
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanMethod.value="updateAction";
	document.forms[0].hidBeanGetMethod.value="getAction";
	document.forms[0].hidAction.value="dislodge";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function showupdateroiinfinacle()
{

	document.forms[0].hidSourceUrl.value="/action/appworkflowaction.jsp" 
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanMethod.value="checkLoanInterestModify";
	document.forms[0].hidBeanGetMethod.value="getAction";
	document.forms[0].hidAction.value="updroiinfin";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}


function showupdateroiinfinaclewithouteyc()
{
	
	<% if(strSessionModuleType.equalsIgnoreCase("CORP")  || strSessionModuleType.equalsIgnoreCase("CORP"))
	{%>
	if(document.forms[0].sel_facility.value=="" || document.forms[0].sel_facility.value=="S")
		{
		alert("Please select facility to proceed further!!!")
		return ;
		}
	
		<%}%>
		
	document.forms[0].hidSourceUrl.value="/action/appworkflowaction.jsp" 
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanMethod.value="checkLoanInterestModifyWithoutenc";
	document.forms[0].hidBeanGetMethod.value="getAction";
	document.forms[0].hidAction.value="updroiinfin";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function showpostsancsummary()
{
	appno=document.forms[0].appno.value;
	var purl ="<%=ApplicationParams.getAppUrl()%>action/compostsanctionproposalsummary.jsp?hidBeanGetMethod=getPostSanctionFacDetails&hidBeanId=commworkflow&Applicationno="+appno;
	var xpos = (screen.width - 900) / 2;
	var ypos = (screen.height - 700) / 2;
	var prop = 'scrollbars=yes,menubar=YES,width=900,height=550,status=yes';
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'Deviation',prop);
}
function funLoad()
{
	if((strSessionModuleType=="RET"||strSessionModuleType=="LAD") && !(varappcategory=="S"||varappcategory=="P") && varSendToCBSFlag!="Y")
	{
		<%if(arrRevalidation!=null && arrRevalidation.size()>0)
		{
			for(int i=0;i<arrRevalidation.size();i++)
			{
				long lngDayDiff=0,lngDayDiff1=0;
				ArrayList arrCol=(ArrayList)arrRevalidation.get(i);
				String strProcessDate=Helper.correctNull((String)arrCol.get(3));
				String strRevalidationDate=Helper.correctNull((String)arrCol.get(5));
				if(strProcessDate.equalsIgnoreCase(""))
					strProcessDate=Helper.getCurrentDateTime();
				if(strRevalidationDate.equalsIgnoreCase(""))
					strRevalidationDate=Helper.getCurrentDateTime();
				lngDayDiff=Helper.dateDiff(strProcessDate,Helper.getCurrentDateTime());
				lngDayDiff1=Helper.dateDiff(strRevalidationDate,Helper.getCurrentDateTime());%>
				<%if(lngDayDiff>Integer.parseInt(Helper.correctInt((String)arrCol.get(0)))
						&&(Helper.correctNull((String)arrCol.get(6)).equalsIgnoreCase("Y") && 
								(Helper.correctNull((String)arrCol.get(7)).equalsIgnoreCase("pa")||Helper.correctNull((String)arrCol.get(7)).equalsIgnoreCase("pr")))){%>
						if(document.forms[0].appholder.value==strUserId && (document.forms[0].appstatus.value=="Processed/Approved"))
						{
							<%if(Helper.correctNull((String)arrCol.get(7)).equalsIgnoreCase("pa")){
							if(lngDayDiff1<=Integer.parseInt(Helper.correctInt((String)arrCol.get(1)))){%>
								document.forms[0].cmdAdditionalparameter.disabled=false;
								document.forms[0].cmdRevalidate.disabled=false;
							<%}else{%>
								document.forms[0].cmdAdditionalparameter.disabled=true;
								document.forms[0].cmdRevalidate.disabled=false;
							<%}}else{%>
								document.forms[0].cmdAdditionalparameter.disabled=true;
								document.forms[0].cmdRevalidate.disabled=false;
								<%}%>
						}
						else if("<%=Helper.correctNull((String)arrCol.get(8))%>"==strUserId && (document.forms[0].appstatus.value=="Processed/Approved"))
						{
							document.forms[0].cmdAdditionalparameter.disabled=true;
							document.forms[0].cmdRevalidate.disabled=false;
						}
						else
						{
							document.forms[0].cmdAdditionalparameter.disabled=true;
						}
				<%}else if(lngDayDiff>Integer.parseInt(Helper.correctInt((String)arrCol.get(2)))&& !Helper.correctNull((String)arrCol.get(6)).equalsIgnoreCase("Y"))
				{%>
								document.forms[0].cmdAdditionalparameter.disabled=true;
								document.forms[0].cmdRevalidate.disabled=true;
							
				<%}
				else if(Helper.correctNull((String)arrCol.get(6)).equalsIgnoreCase("Y"))
				{%>
					if((document.forms[0].appholder.value==strUserId || strUserId=="<%=Helper.correctNull((String)arrCol.get(8))%>") && (document.forms[0].appstatus.value=="Processed/Approved"))
					{
						document.forms[0].cmdAdditionalparameter.disabled=true;
						document.forms[0].cmdRevalidate.disabled=false;
					}
				<%}
				else if(lngDayDiff>Integer.parseInt(Helper.correctInt((String)arrCol.get(0))) && lngDayDiff<=Integer.parseInt(Helper.correctInt((String)arrCol.get(2))))
				{%>	
					if(document.forms[0].appholder.value==strUserId && (document.forms[0].appstatus.value=="Processed/Approved"))
					{
						document.forms[0].cmdAdditionalparameter.disabled=true;
						document.forms[0].cmdRevalidate.disabled=false;
					}
					else
					{
			   			document.forms[0].cmdAdditionalparameter.disabled=true;
			   			document.forms[0].cmdRevalidate.disabled=true;
					}
				<%}
				else if(lngDayDiff<=Integer.parseInt(Helper.correctInt((String)arrCol.get(0))))
				{%>
					if(document.forms[0].appholder.value==strUserId && (document.forms[0].appstatus.value=="Processed/Approved"))
					{
						document.forms[0].cmdAdditionalparameter.disabled=false;
						document.forms[0].cmdRevalidate.disabled=true;
					}
					else
					{
						document.forms[0].cmdAdditionalparameter.disabled=true;
						document.forms[0].cmdRevalidate.disabled=true;
					}
				<%}else{%>
					document.forms[0].cmdAdditionalparameter.disabled=true;
					document.forms[0].cmdRevalidate.disabled=true;
				<%}
				}
		}%>
	}
	else if(strSessionModuleType=="AGR" || strSessionModuleType=="CORP")
	{
		//document.forms[0].cmdRevalidate.disabled=false;
	}	
}
function enablesendtoCBS()
{
	if(!(varappcategory=="S"||varappcategory=="P") && varSendToCBSFlag!="Y")
	{
		document.forms[0].cmdAdditionalparameter.disabled=true;
		document.forms[0].cmdRevalidate.disabled=true;
		
		<%if(arrRevalidation!=null && arrRevalidation.size()>0)
		{
			for(int i=0;i<arrRevalidation.size();i++)
			{
				long lngDayDiff=0,lngDayDiff1=0;
				ArrayList arrCol=(ArrayList)arrRevalidation.get(i);%>
				if(document.forms[0].sel_facility.value=="<%=Helper.correctNull((String)arrCol.get(9))%>")
				{
				<%String strProcessDate=Helper.correctNull((String)arrCol.get(3));
				String strRevalidationDate=Helper.correctNull((String)arrCol.get(5));
				if(strProcessDate.equalsIgnoreCase(""))
					strProcessDate=Helper.getCurrentDateTime();
				if(strRevalidationDate.equalsIgnoreCase(""))
					strRevalidationDate=Helper.getCurrentDateTime();
				lngDayDiff=Helper.dateDiff(strProcessDate,Helper.getCurrentDateTime());
				lngDayDiff1=Helper.dateDiff(strRevalidationDate,Helper.getCurrentDateTime());%>
				<%if(lngDayDiff>Integer.parseInt(Helper.correctInt((String)arrCol.get(0)))
						&&(Helper.correctNull((String)arrCol.get(6)).equalsIgnoreCase("Y") && 
								(Helper.correctNull((String)arrCol.get(7)).equalsIgnoreCase("pa")||Helper.correctNull((String)arrCol.get(7)).equalsIgnoreCase("pr")))){%>
						if(document.forms[0].appholder.value==strUserId && (document.forms[0].appstatus.value=="Processed/Approved"))
						{
							<%if(Helper.correctNull((String)arrCol.get(7)).equalsIgnoreCase("pa")){
							if(lngDayDiff1<=Integer.parseInt(Helper.correctInt((String)arrCol.get(1)))){%>
								document.forms[0].cmdAdditionalparameter.disabled=false;
								document.forms[0].cmdRevalidate.disabled=false;
							<%}else{%>
								document.forms[0].cmdAdditionalparameter.disabled=true;
								document.forms[0].cmdRevalidate.disabled=false;
							<%}}else{%>
								document.forms[0].cmdAdditionalparameter.disabled=true;
								document.forms[0].cmdRevalidate.disabled=false;
								<%}%>
						}
						else if("<%=Helper.correctNull((String)arrCol.get(8))%>"==strUserId && (document.forms[0].appstatus.value=="Processed/Approved"))
						{
							document.forms[0].cmdAdditionalparameter.disabled=true;
							document.forms[0].cmdRevalidate.disabled=false;
						}
						else
						{
							document.forms[0].cmdAdditionalparameter.disabled=true;
						}
				<%}else if(lngDayDiff>Integer.parseInt(Helper.correctInt((String)arrCol.get(2)))&& !Helper.correctNull((String)arrCol.get(6)).equalsIgnoreCase("Y"))
				{%>
								document.forms[0].cmdAdditionalparameter.disabled=true;
								document.forms[0].cmdRevalidate.disabled=true;
							
				<%}
				else if(Helper.correctNull((String)arrCol.get(6)).equalsIgnoreCase("Y"))
				{%>
					if((document.forms[0].appholder.value==strUserId || strUserId=="<%=Helper.correctNull((String)arrCol.get(8))%>") && (document.forms[0].appstatus.value=="Processed/Approved"))
					{
						document.forms[0].cmdAdditionalparameter.disabled=true;
						document.forms[0].cmdRevalidate.disabled=false;
					}
				<%}
				else if(lngDayDiff>Integer.parseInt(Helper.correctInt((String)arrCol.get(0))) && lngDayDiff<=Integer.parseInt(Helper.correctInt((String)arrCol.get(2))))
				{%>	
					if(document.forms[0].appholder.value==strUserId && (document.forms[0].appstatus.value=="Processed/Approved"))
					{
						document.forms[0].cmdAdditionalparameter.disabled=true;
						document.forms[0].cmdRevalidate.disabled=false;
					}
					else
					{
			   			document.forms[0].cmdAdditionalparameter.disabled=true;
			   			document.forms[0].cmdRevalidate.disabled=true;
					}
				<%}
				else if(lngDayDiff<=Integer.parseInt(Helper.correctInt((String)arrCol.get(0))))
				{%>
					if(document.forms[0].appholder.value==strUserId && (document.forms[0].appstatus.value=="Processed/Approved"))
					{
						document.forms[0].cmdAdditionalparameter.disabled=false;
						document.forms[0].cmdRevalidate.disabled=true;
					}
					else
					{
						document.forms[0].cmdAdditionalparameter.disabled=true;
						document.forms[0].cmdRevalidate.disabled=true;
					}
				<%}else{%>
					document.forms[0].cmdAdditionalparameter.disabled=true;
					document.forms[0].cmdRevalidate.disabled=true;
				<%}%>
				}
		<%}}%>
	}
}
function callIFrame()

{
	document.forms[0].hidBeanId.value = "commworkflow";
	document.forms[0].hidBeanGetMethod.value = "getAction";
	document.forms[0].action = appURL + "action/appworkflowaction.jsp";
	document.forms[0].submit();
}
function add_history(obj)
{
	if(obj.checked==false)
	{
		alert("Declaration is Required,You cannot untick ");
		obj.checked=true;
		return;
	}else{
	
	    var cust_name="<%=Helper.correctNull((String) hshValues.get("str_cusName"))%>";
	    cust_name=encodeURIComponent(cust_name);
	    document.all.ifrm4.src=appURL+"action/iframeHistory.jsp?hidBeanId=commworkflow&hidBeanGetMethod=setDecHistory&cus_id="+varPerCbsId+"&appno="+appno+"&cus_name="+cust_name+"&strAppNewid="+strAppNewid+"&strCIN="+varCIN;
	     }
}
function showHistoryDetails(){
	
	var purl ="<%=ApplicationParams.getAppUrl()%>action/audittrail_declarations.jsp?hidBeanGetMethod=getAuditTrail_dec&hidBeanId=commworkflow&appno="+appno;
	var xpos = (screen.width - 900) / 2;
	var ypos = (screen.height - 700) / 2;
	var prop = 'scrollbars=yes,menubar=YES,width=900,height=550,status=yes';
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'History',prop);
}

function callNotreadyForSanction(){
	var varSchemecode="<%=Helper.correctNull((String)hshValues.get("strschemecode"))%>";
	var facilityno=document.forms[0].sel_facility.value;
	 document.all.ifrm4.src=appURL+"action/iframe_readyforSanction.jsp?hidBeanId=commworkflow&hidBeanGetMethod=getReadyForSAnctionUsingDBFunction&appno="+appno+"&facilitysno="+facilityno;
}

function showDeclarations(){
	if(varListCompany=='Y' && varCIN!=""  ){
		if(varCIN.charAt(0)=='L' && varCIN.length=="21"){
		document.all.dec_id.style.visibility="visible";
		document.all.dec_id.style.position="relative";
		}else{
			document.all.dec_id.style.visibility="hidden";
			document.all.dec_id.style.position="absolute";
		}
	}else{
		document.all.dec_id.style.visibility="hidden";
		document.all.dec_id.style.position="absolute";
	}
	
}
function checkpostsanctionundo()
{
	if(forPostcheck=="P")
	{
if(document.forms[0].appstatus.value=="Processed/Approved" || document.forms[0].appstatus.value=="Processed/Rejected")
{
	if(strUserId==varApproverejectBy && strUserId==appholdercheck)
	{
		document.forms[0].cmdundo.disabled=false;
	}
	else
	{
		document.forms[0].cmdundo.disabled=true;
	}
	
	<%if((Helper.correctNull((String)session.getAttribute("appstatus")).equalsIgnoreCase("pa")) || (Helper.correctNull((String)session.getAttribute("appstatus")).equalsIgnoreCase("ca")))
		{%>
	<%if(!Helper.correctNull((String) hshValues.get("Loan_Sanct_STATUS")).equalsIgnoreCase("S") && roiflagval.equalsIgnoreCase("S"))
 	{ %> 	 
	document.forms[0].cmdundo.disabled=true;	
<%}}%>
}
	}
}
function showsummaryofproposal()
{
	var url = appURL+"action/proposalSummary.jsp?hidBeanId=lapsReport&hidBeanGetMethod=proposalsummery&appno="+appno;
	var title = "Sanction_Letter";
	var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
	var xpos = (screen.width - 810) / 2;
	var ypos = (screen.height - 668) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}
function showsummaryofproposalforret()
{
	appno=document.forms[0].appno.value;
	alert(appno);
	var url = appURL+"action/proposalSummaryRet.jsp?hidBeanId=lapsReport&hidBeanGetMethod=proposalsummeryRet&appno="+appno;
	var title = "Sanction_Letter";
	var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
	var xpos = (screen.width - 810) / 2;
	var ypos = (screen.height - 668) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body onLoad="placeValues();callOnload();funSanctionReady();funLoad();showDeclarations();checkpostsanctionundo();">
<div id='imgloading' style="display:none;">
<img src="<%=ApplicationParams.getAppUrl()%>img/processing2.gif"></div>
<form name="frmworkflow" method="post" class="normal">
<%if(strProposalType.equalsIgnoreCase("P")){ 
if(!strSessionModuleType.equalsIgnoreCase("RET")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="7" />
			<jsp:param name="subpageid" value="114" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%}else{%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="9" />
			<jsp:param name="subpageid" value="120" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>	
<%}

}else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<%if (strSessionModuleType.equalsIgnoreCase("RET")||strSessionModuleType.equalsIgnoreCase("LAD")) { %> 
<jsp:include page="../share/Applurllinkper.jsp" flush="true">
<jsp:param name="pageid" value="7" /></jsp:include> 
 <%}else if (strSessionModuleType.equalsIgnoreCase("DIGI")) {
		%> <jsp:include page="../share/applurllinkerdigi.jsp" flush="true">
		<jsp:param name="pageid" value="7" />
	</jsp:include>
	<%} else if (loan_type.equalsIgnoreCase("E")
 			|| loan_type.equalsIgnoreCase("U")
 			|| loan_type.equalsIgnoreCase("H")
 			|| loan_type.equalsIgnoreCase("T")) {
 %> <jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="15" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <span style="display: none;"><lapschoice:borrowertype /></span> 
		<%} else if (loan_type.equalsIgnoreCase("C") || loan_type.equalsIgnoreCase("A")) {%> 
		<jsp:include page="../com/proposallinks.jsp" flush="true">
			<jsp:param name="pageid" value="7" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <span style="display: none"><lapschoice:borrowertype /></span> 
		<%}%>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <%if(strSessionModuleType.equals("AGR")){%>
	 <tr>
		<td class="page_flow">Home -&gt; Agriculture-&gt; Proposal -&gt; WorkFlow
		-&gt; Action</td>
	</tr>
	<%}else if (strCategoryType.equalsIgnoreCase("SRE")) {%>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Short
		Review/Extension -&gt; WorkFlow -&gt; Action</td>
	</tr>
	<%} else if (strCategoryType.equalsIgnoreCase("STL")) {%>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Short
		Term Loan -&gt; WorkFlow -&gt; Action</td>
	</tr>
	<%} else if (strCategoryType.equalsIgnoreCase("ADC")) {%>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Ad hoc
		Limit -&gt; WorkFlow -&gt; Action</td>
	</tr>
	<%} else if (strCategoryType.equalsIgnoreCase("OPS")) {%>
	<tr>
		<td class="page_flow">Home -&gt; Tertiary -&gt; Application -&gt; WorkFlow -&gt; Action</td>
	</tr>
	<%} else if (strCategoryType.equals("LAD")) {%>
	<tr><td class="page_flow">Home -&gt; Loan Against Gold Ornaments &amp;
	Deposits -&gt; WorkFlow -&gt; Action</td></tr>
	<%} else if (strCategoryType.equalsIgnoreCase("AGR")) {%>
	<tr>
		<td class="page_flow">Home -&gt; Agriculture -&gt; Application -&gt; WorkFlow -&gt; Action</td>
	</tr>
	<%} else if (strSessionModuleType.equalsIgnoreCase("RET")) {%>
	<tr>
		<td class="page_flow">Home -&gt; Retail(including schematic)  -&gt;Application -&gt; WorkFlow -&gt;
		Action</td>
	</tr> 
	<%} else if (strSessionModuleType.equalsIgnoreCase("DIGI")) {%>
	<tr>
		<td class="page_flow">Home -&gt; Digi Retail -&gt;Application -&gt; WorkFlow -&gt;
		Action</td>
	</tr> 
	<%} else {%>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; WorkFlow
		-&gt; Action</td>
	</tr>
	<%}%>
</table>
<lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="80%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr align="center">
				<td class="sub_tab_inactive"><a href="javascript:callOtherTab('history')">History</a></td>
				<!-- <td class="sub_tab_inactive"><a href="#" onClick="javascript:callComment()">Comments</a></td> -->
				<td class="sub_tab_inactive"><a  href="#" onClick="javascript:callQueries()">Queries</a></td>
				<%if (loan_type.equalsIgnoreCase("C")
							|| loan_type.equalsIgnoreCase("T")
							|| loan_type.equalsIgnoreCase("H")
							|| loan_type.equalsIgnoreCase("U")
							|| loan_type.equalsIgnoreCase("E")
							|| loan_type.equalsIgnoreCase("A")) {%>
				<td class="sub_tab_inactive" id="action" nowrap><a href="#" onClick="javascript:callOtherTab('sanction')"> Proposed facility Approve/Reject</a></td>
				<%}%>
				<td class="sub_tab_active">Action</td>
			<%
			if((Helper.correctNull((String)session.getAttribute("appstatus")).equalsIgnoreCase("pa")) || (Helper.correctNull((String)session.getAttribute("appstatus")).equalsIgnoreCase("ca")))
			{
			if (Helper.correctNull((String)session.getAttribute("PRD_CGTMSE")).equalsIgnoreCase("Y")){ %>
					<td class="sub_tab_inactive" id="idCGTMSEtxn"><a href="javascript:callOtherTab('CGTMSE_TXN')">CGTMSE Transaction Details</a></td>
				<%} else { %>
					<td id="idCGTMSEtxn" style="display: none;"><input type="hidden"></td>
				<% } } %> 
				<td class="sub_tab_inactive"><a
					href="javascript:callOtherTab('drawdownschedule')">Draw Down Schedule</a></td>
				<td class="sub_tab_inactive"><a href="#" onClick="javascript:callRemarks()">Remarks</a></td>
				<%if (Helper.correctNull((String) hshValues.get("app_legalcomp")).equalsIgnoreCase("Y")){ %>
				<td class="sub_tab_inactive" nowrap><a href="#" onClick="javascript:callOtherTab('legcomp')">Legal Compliance Certificate</a></td>
				<% }%>
				<td class="sub_tab_inactive" id="idloanaccount"  nowrap="nowrap"><a href="#" onClick="javascript:callLoanAccount()">Loan Account Details</a></td>
				<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("S")){ %>
				<td id="idrestr" class="sub_tab_inactive" nowrap="nowrap"><a
					href="#" onclick="javascript:callOtherTab('restrfacdetails')">Restructure Effective Date</a></td>
					<%}else{ %>
					<td  style="display: none;"><input type="hidden" id="idrestr"></td>
					<%} %>
				<% if(loan_type.equalsIgnoreCase("C") || loan_type.equalsIgnoreCase("A")) {%>
				<td class="sub_tab_inactive" id="idfacdetail"  nowrap="nowrap"><a href="#" onClick="javascript:callFacDetail()">Facility Details</a></td>
				<% } %>
			</tr>
		</table>
		</td>
	</tr>
</table>
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td width="47%" valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="3"
									class="outertable">
									<%if(strSessionModuleType.equals("AGR")||strSessionModuleType.equals("CORP")){ %>
									<tr>
									<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="3"
											class="outertable">
											<tr class="dataheader">
											<td width="50%" align="center"> Select Facility
											</td>
											<td width="50%">
												<select name="sel_facility" onchange="enablesendtoCBS();callIFrame();">
												<option value="s" selected="selected">--Select--</option>
                									<lapschoice:ComApprovedFacility apptype='<%=Helper.correctNull((String)request.getParameter("appno")) %>'/>
												</select>
											</td>
											</tr>
									</table>
									</td>
									</tr>
									<%} %>
									<tr>
										<td height="161" valign="top">
										<table width="100%" border="0" cellspacing="1" cellpadding="3"
											class="outertable">
											<tr class="dataheader">
												<td width="18%" align="center">Current Flowpoint</td>
												<td width="13%" class="datagrid" align="center">
														<b><%=Helper.correctNull((String) hshValues
							.get("strCurrFlowPoint"))%>&nbsp;</b>
												</td>
												<td width="16%" align="center">Received On</td>
														<td align="center" class="datagrid"><b><%=Helper.correctNull((String) hshValues.get("strDate"))%>&nbsp;</b></td>
												<td width="12%" align="center">Due On</td>
														<td align="center" class="datagrid"><b><%=Helper.correctNull((String) hshValues.get("strDueDate"))%>&nbsp;</b></td>
											</tr>
										</table>
										<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
											<tr>
												<td valign="top">
												<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
													<tr class="dataheader">
														<td width="7%" align="center">Select</td>
														<td width="10%" align="center">Flowpoints</td>
														<td width="10%" align="center">Min. Class</td>
														<td width="73%" align="center">Actions</td>
													</tr>
														   <%if (arrFlowpoint != null && arrFlowpoint.size() > 0) {
																	for (int i = 0; i < arrFlowpoint.size(); i++) {%>
															<tr class="datagrid">
																<td><input type="radio"
																	name="optflowpnt" value="" style="border-style:none"
																	onClick="setValues(<%=i%>,<%=arrFlowpoint.size()%>);"></td>
																<td width="10%" bgcolor="" align="center">
																<%=Helper.correctNull((String) arrFlowpoint.get(i))%>
																<input type="hidden" name="txtmail_toflowpoint" 
																	value="<%=Helper.correctNull((String) arrFlowpoint.get(i))%>">
																</td>
																<td width="10%" align="left">
																<%=Helper.correctNull((String) arrMaxclass.get(i))%>
																<input type="hidden" name="prd_maxclass" value="<%=Helper.correctNull((String) arrMaxclass.get(i))%>">
																<input type="hidden" name="prd_maxclass1" value="<%=Helper.correctNull((String) arrMaxclass.get(i))%>">
																</td>
																<td width="73%" align="left">
																<%=Helper.correctNull((String) arrAction.get(i))%>
																<input type="hidden" name="wrk_flowname" value="<%=Helper.correctNull((String) arrAction.get(i))%>">
																</td>
															</tr>
															<%}			}
															%>
														</table>
														</td>
													</tr>
												</table>
												</td>
											</tr>
										</table>
										<table width="100%" border="0" cellspacing="0" cellpadding="3"
											class="outertable border1">
											<tr>
														<td colspan="2" >
											<table width="60%" border="0" cellspacing="0"
													cellpadding="3" class="outertable">
													<tr>
														<td valign="top">
														Initial Data Entry Vetting done</td>
														<td><select name="sel_datavetting">
															<option value="S">&lt;---select---&gt;</option>
															<option value="Y">Yes</option>
															<option value="N">No</option>
														</select></td>
														
														<td valign="top">
															 Vetting done by</td>
														<td>
															<input type="text" value="<%=Helper.correctNull((String)hshValues.get("app_vettedby"))%>">															
														</td>
													</tr>
												</table>
											</td>
											</tr>
											<%
												if (!strCategoryType.equalsIgnoreCase("SRE")
														&& !strCategoryType.equalsIgnoreCase("STL")
														&& !strCategoryType.equalsIgnoreCase("ADC")) {
											%>
											<tr>
												<td align="center" colspan="3">
												<table width="100%" border="0" cellspacing="0"
													cellpadding="3" class="outertable">
													<tr>
														<td width="27%"><input type="checkbox"
															name="appraisal" value="checkbox" style="border:none">Appraisal
														Checked</td>
														<td width="18%"><input type="checkbox"
															name="documents" value="checkbox" style="border:none">Process Note</td>
														<%
															if (!(strPrdType.equalsIgnoreCase("pR")
																		|| strPrdType.equalsIgnoreCase("aR")
																		|| strPrdType.equalsIgnoreCase("pG") || strPrdType
																		.equalsIgnoreCase("aH"))) {
														%>
														<td width="30%"><input type="checkbox"
															name="sancinti" value="checkbox" style="border:none">Pre Sanction
														Inspection Conducted Checked</td>
														<%
															}
														%>
															<td width="25%" nowrap="nowrap"><input type="checkbox"
															name="mischeck" value="checkbox" style="border:none">I have checked  MIS details and its related classification for all facilities and  found correct</td>
													</tr>
												</table>
												</td>
											</tr>
											<%
												}
											%>
											<tr>
												<td colspan="2">
												<table width="100%" border="0" cellspacing="0"
													cellpadding="3" class="outertable">
													<tr>
														<td valign="top">Whether Legal Compliance Certificate is Applicable</td>
														<td width="18%"><select name="sel_legalcomp">
															<option value="S">&lt;---select---&gt;</option>
															<option value="N">No</option>
															<option value="Y">Yes</option>
														</select></td>
														<%if(strProposalType.equalsIgnoreCase("P")){%>
														<td valign="top">Approving the Post sanction Modifications in Security & Guarantor</td>
														<td width="18%"><select name="sel_finalsanction">
															<option value="">-- Select --</option>
															<option value="Y">Yes</option>
															<option value="N">No</option>
														</select></td>
														<%} %>
													</tr>
												</table>
												</td>
											</tr>
											<tr>
												
                              <td width="42%" valign="top"> 
                                <table width="100%" border="0" cellspacing="0"
													cellpadding="0" class="outertable">
													<tr>
														<td valign="top">
														
                                      <table width="93%" border="0" cellspacing="0"
															cellpadding="3" class="outertable">
                                        <tr>
																<td width="30%" nowrap>Select Organisation</td>
																<td width="70%"><input type="text" name="org_name"
																	size="35" readonly="readonly" value="<%=strOrgName%>"><span
																	id="idorgselect"> <a href="#"
																	onClick="javascript:callOrgHelp()"> <img
																	src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
																	border="0"> </a></span></td>
															</tr>
														</table>
														</td>
													</tr>
												</table>
												</td>
												
                              <td align="right" valign="top" width="58%"> 
                                <table width="100%" border="0" cellspacing="0"
													cellpadding="0" class="outertable">
													<tr>
														<td valign="top">
														<table width="100%" border="0" cellspacing="0"
															cellpadding="3" class="outertable">
															<tr>
																
                                          <td id="deprt1" width="16%">Department<span class="mantatory">*&nbsp;</span> 
                                          </td>
																
                                          <td id="deprt2" width="15%"> 
                                            <select name="usr_department">
																<option value="0">---Select---</option>
									 							<%String apptypecon = "20";%>
                          										<lapschoice:CBSStaticDataNewTag apptype='<%=apptypecon%>' tagType="child"/>
																</select></td>
																
                                          <td width="21%" align="center">Select 
                                            Recipient</td>
																
                                          <td width="48%"> 
                                            <input type="text"
																	name="mail_tousrid" size="37" readonly="readonly"
																	value="<%=Helper.correctNull((String) hshValues
									.get("apprised_by"))%>">
																<input type="hidden" name="hidmail_tousrid"> <a
																	href="#" onClick="javascript:callUsersHelp()"><img
																	src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
																	border="0"> </a></td>
															</tr>
														</table>
														</td>
													</tr>
												</table>
												</td>
											</tr>
											<tr>
												<td colspan="2">
												<table width="100%" border="0" cellspacing="0"
													cellpadding="0" class="outertable">
													<%
														if (strSessionModuleType.equalsIgnoreCase("CORP")
																|| (strSessionModuleType.equalsIgnoreCase("AGR") && strAgrSchemeType.equalsIgnoreCase("Y"))) {
													%>
													<tr>
														<td nowrap>Next Review Date</td>
														<td>
														<table class="outertable">
															<tr>
																<td><input type="text" name="txt_reviewdate"
																	size="12"
																	value="<%=Helper.correctNull((String) hshValues
								.get("app_reviewdate"))%>"
																	maxlength="10"
																	onBlur="checkDate(this);checkmindate(this,currentDate)"></td>
																<td><a alt="Select date from calender" href="#"
																	onClick="callCalender('txt_reviewdate')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border="0" alt="Select date from calender"></a></td>
															</tr>
														</table>
														</td>
													</tr>
													<%
														}else
														{%>
														<input type="hidden" name="txt_reviewdate">
														<%}
													%>
													<tr>
														<td nowrap>Sanctioning Authority Comments</td>
														<td><textarea name="txt_sanctioncomments" cols="150"
															rows="3" <%if(strPrdType.equalsIgnoreCase("pE")){ %> onKeyPress="textlimit(this,3999)" onkeyup="checkTextArealimit(this,3999);textlimit(this,3999)"<%} %>><%=Helper.correctNull((String) hshValues
							.get("Sanction_Comments"))%></textarea></td>
													</tr>
													<%if(StrLodgingRights=='1'||lodgerightstousercheck.equalsIgnoreCase("Y")){ %>
													<tr>
													<td  valign="top" colspan="2"> <br/>
                                <table width="57%" border="0" cellspacing="0"
													cellpadding="0" class="outertable">
													<tr>
																<td width="20%" nowrap>Lodged Reference Number</td>
																<td width="30%"><input type="text" name="txt_lodgedrefno" size="25" maxlength="25" onkeypress="" value="<%=Helper.correctNull((String) hshValues.get("strLodgedRefNo"))%>"></td>
																<td nowrap width="10%" colspan="2">&nbsp;</td>
															</tr>
														</table>
														</td>
													</tr>
													<%} %>
													<%if(strPrdType.equalsIgnoreCase("pU")){ %>
															<tr>
															<td style="color: red;">Total Exposure:&nbsp;<%=Helper.correctNull((String)hshValues.get("strBorrowerExp")) %></td>
															</tr>
															<%} %>
															<br>
															<%
														if ((strSessionModuleType.equalsIgnoreCase("CORP")
																|| (strSessionModuleType.equalsIgnoreCase("AGR")))&&(!strProposalType.equalsIgnoreCase("P"))) {
													%>
													<tr>
														<td colspan="2" >
											<table width="60%" border="0" cellspacing="0"
													cellpadding="3" class="outertable">
													<tr>
														<td valign="top" nowrap="nowrap">
														Whether Stock Audit is Applicable <span
									                        class="mantatory">*</span></td>
														<td><select name="sel_stock_audit">
															<option value="S">&lt;---select---&gt;</option>
															<option value="Y">Yes</option>
															<option value="N">No</option>
														</select></td>
														<td>&nbsp;</td><td>&nbsp;</td>
														<td valign="top" nowrap="nowrap">
															Whether Credit Audit is Applicable <span
											              class="mantatory">*</span></td>
														<td>
															<td><select name="sel_credit_audit">
															<option value="S">&lt;---select---&gt;</option>
															<option value="Y">Yes</option>
															<option value="N">No</option>
														</select></td>
													</tr>
												</table>
											</td>
											</tr>
												<%} %>
												
<%-- 												<%  if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %> --%>
<!-- 	<tr> -->
<!-- 	    <td>Applicable ROI in CBS</td> -->
<%-- 		<td><span id="id_interest6"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("Loan_Applicable_ROI"))))%></span>% --%>
<!-- 		</td> -->
<!-- 		</tr> -->
<!-- 		<tr> -->
<!-- 		<td>Proposed ROI </td> -->
<%-- 		<td><span id="id_interest7"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("Loan_Proposed_ROI"))))%></span>% --%>
<!-- 		</td> -->
<!-- 					</tr> -->
<%-- 	<%} %> --%>
												
												</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		<table id="dec_id" width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable border1" align="center">
	<tr><td colspan="4" class="dataheader"> Declaration for Listed Company </td></tr>		
			
			<tr>
			<td colspan="4"><input type="checkbox" name="chk_dec" style="border: none;" onclick="add_history(this)">
			I am aware that the applicant/borrower is a Listed Company and by virtue of dealing with the Company, I may come into the possession of Unpublished Price Sensitive Information(UPSI) about the company or its securities and I hereby undertake that myself and my immediate relatives will not buy, sell or in any manner deal in the securities of the company during the tenure of the loan facility with the Bank and for the period of six months after the facilities are closed. I also undertake not to share or disclose UPSI that has come into my possession to any other person unless for legitimate purposes.
	</td>
			</tr>
			<tr>
			<td colspan="4" align="center"><input type="button" name="cmdHistory" class="buttonStyle"
			value="Declaration for Listed Company History" onClick="showHistoryDetails()"></td></tr>
	
	</table>
<%
	if (!strCategoryType.equalsIgnoreCase("SRE")
			&& !strCategoryType.equalsIgnoreCase("STL")
			&& !strCategoryType.equalsIgnoreCase("ADC")) {
%>
<table width="0%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
	<tr>
	
	<%if(lodgerightstousercheck.equalsIgnoreCase("Y")&& !Helper.correctNull((String) hshValues.get("forPostcheck")).equalsIgnoreCase("P")){
	if(strSessionModuleType.equalsIgnoreCase("AGR") || strSessionModuleType.equalsIgnoreCase("CORP"))
		{%>
			<td> <input type="button" name="cmdproposalSummary" class="buttonStyle"
			value="Proposal Summary" onClick="showsummaryofproposal()" ></td>
			<%}else if(strSessionModuleType.equalsIgnoreCase("RET")&&!(strPrdType.equalsIgnoreCase("pG")&&!(strPrdType.equalsIgnoreCase("pR")))){ %>
			
			 <td><input type="button" name="cmdproposalSummaryret" class="buttonStyle"
			value="Proposal Summary" onClick="showsummaryofproposalforret()" ></td>
				<%}}%>	
	
	
	<!-- 
		<%
			if (loan_type.equalsIgnoreCase("p")) {
		%>
		<td><input type="button" name="cmdClick" value="Deviations" class="buttonStyle"
			title="Check Deviations"
			onClick="callDeviation('normal')"></td>
		<%
			}
		%>
		-->
		<%if(!strProposalType.equalsIgnoreCase("P")){%>
		<td>
		 <input type="button" name="cmdAdditionalparameter" class="buttonStyle"
			value="Send To CBS" onClick="showSanctionDetails()" >
				&nbsp;<input type="button" name="cmdUpdateCBS" class="buttonStyle"
			value="Update CBS App No " onClick="UpdateCBS()" style="visibility: hidden;position:absolute; ">
						
		</td>
		<%}else{ %>
		<td>
		 <input type="hidden" name="cmdAdditionalparameter">
		<input type="hidden" name="cmdUpdateCBS">
<%--    		<%if(strProposalType.equalsIgnoreCase("P") && ((Helper.correctNull((String)session.getAttribute("appstatus")).equalsIgnoreCase("pa")) || (Helper.correctNull((String)session.getAttribute("appstatus")).equalsIgnoreCase("ca")))   --%>
<%--   		&& Helper.correctNull((String) hshValues.get("POSTSANCTIONAPP_APPROVEDBY")).equalsIgnoreCase(strUserId)  --%>
<%--  				&& (!Helper.correctNull((String) hshValues.get("Loan_Sanct_STATUS")).equalsIgnoreCase("S")) && roiflagval.equalsIgnoreCase("S")){ --%>   
		<input type="button" name="cmdpostsanctionsummary" class="buttonStyle"
			value="Post Sanction Modification Summary" onClick="showpostsancsummary()">
			 <input type="button" name="cmdpostsanctionintratemodifi" class="buttonStyle"
			value="UPDATE ROI IN FINACLE ENC" onClick="showupdateroiinfinacle()" >
		<input type="button" name="cmdpostsanctionintratemodifiwithout" class="buttonStyle"
			value="UPDATE ROI IN FINACLE" onClick="showupdateroiinfinaclewithouteyc()" >
<%--  		<%} %>     --%>
<%-- 		<%else if(strProposalType.equalsIgnoreCase("P")) { %> --%>
<!-- 		 <input type="button" name="cmdpostsanctionsummary" class="buttonStyle" -->
<!-- 			value="Post Sanction Modification Summary" onClick="showpostsancsummary()"> -->
<!-- 			 <input type="button" name="cmdpostsanctionintratemodifi" class="buttonStyle" -->
<!-- 			value="UPDATE ROI IN FINACLE" onClick="showupdateroiinfinacle()" disabled="disabled"> -->
<!-- 		<input type="button" name="cmdpostsanctionintratemodifiwithout" class="buttonStyle" -->
<!-- 			value="UPDATE ROI IN FINACLE NORMAL" onClick="showupdateroiinfinaclewithouteyc()" disabled="disabled"> -->
<%-- 		<%} %> --%>
		
		</td>
		<%} %>
		<td id="PropComp">
		 <input type="button" name="cmdPropComp" class="buttonStyle"  value="Ready for Sanction">					
		</td>
		<td id="PropInComp">
		 <input type="button" name="cmdPropInComp" class="buttonClose" value="Not Ready for Sanction" onClick="doSancCheck()">					
		</td>
		<td id="PropRevalid">
		 <input type="button" name="cmdRevalidate" class="buttonStyle"  value="Revalidate" onClick="doValidateCheck()" disabled="disabled">					
		</td>
	</tr>
	<%}%>
</table>
<%if(StrLodgingRights=='1'||lodgerightstousercheck.equalsIgnoreCase("Y")){ %>
<lapschoice:combuttonnew btnnames='Sanction_Dropped_Undo_Send_Audit Trail_Reassign_Lodge_Dislodge' finalpageflag='Y' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<%}else{ %>
<lapschoice:combuttonnew btnnames='Sanction_Dropped_Undo_Send_Audit Trail_Reassign' finalpageflag='Y' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<%} %>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="mail_touserclass"> 
<INPUT TYPE="hidden" name="hidDemoId" value="<%=Helper.correctNull((String) request.getParameter("hidDemoId"))%>">
 <input type="hidden" name="org_code" value="<%=strOrgCode%>">
 <input type="hidden" name="mail_fromflowpoint" value="<%=Helper.correctNull((String) hshValues.get("strCurrFlowPoint"))%>">
 <input type="hidden" name="mail_toflowpoint"> 
 <input type="hidden" name="hidcurrflowpoint" value="<%=Helper.correctNull((String) hshValues.get("strCurrFlowPoint"))%>">
<input type="hidden" name="radLoan" value="Y"> 
<input type="hidden" name="hideditoption" value="N"> 
<input type="hidden" name="userclass" value="<%=Helper.correctNull((String) strUserClass)%>"> 
<input type="hidden" name="prdtype"	value="<%=Helper.correctNull((String) strPrdtype)%>"> 
<input type="hidden" name="appno1"	value="<%=(String) request.getParameter("appno")%>"> 
<input type="hidden" name="txt_usrid" value="<%=session.getAttribute("strUserId")%>"> 
<input type="hidden" name="prdcode" value="<%=Helper.correctNull((String) hshValues.get("prdcode"))%>"> 
<input type="hidden" name="cattype" value="<%=strCategoryType%>"> 
<input type="hidden" name="ssitype" value="<%=strSSIType%>"> 
<input type="hidden" name="id" value="<%=strBorrowerType%>"> 
<input type="hidden" name="remarksFlag" value="false"> 
<input type="hidden" name="deviationFlag" value="false"> 
<input type="hidden" name="appraisalsanc" value="<%=Helper.correctNull((String) hshValues.get("appraisalsanc"))%>">
<input type="hidden" name="Stateflag"> 
<input type="hidden" name="hidvettingreq">
<input type="hidden" name="hiddatavetting" value="<%=Helper.correctNull((String) hshValues.get("app_vetting"))%>">
<input type="hidden" name="hidValid" value="Y"> 
<input type="hidden" name="app_loantype"> 
<input type="hidden" name="app_legalcomp">
<input type="hidden" name="hidSancAlert">
<input type="hidden" name="cmdsave" disabled="disabled">
<input type="hidden" name="txt_cntflag" value="<%=Helper.correctNull((String) hshValues.get("CNTFLAG"))%>">
<iframe name="ifrm" width="0" height="0"></iframe>
<input type="hidden" name="sendfacility" value="<%=strSentfacility %>">
<input type="hidden" name="closedfacility" value="<%=strClosedfacility %>">
<input type="hidden" name="hidLADFlag" value="<%=Helper.correctNull((String)hshValues.get("strFlowDateFlag"))%>">
<input type="hidden" name="hidKFSDetails" value="<%=Helper.correctNull((String)hshValues.get("strKFSDetails"))%>">
<input type="hidden" name="hidintsubtypechk" value="<%=Helper.correctNull((String)hshValues.get("strIntsubtypechk"))%>">
<input type="hidden" name="hidcgssdtypechk" value="<%=Helper.correctNull((String)hshValues.get("strcgssdchk"))%>">
<input type="hidden" name="hidcgssdsanchk" value="<%=Helper.correctNull((String)hshValues.get("intcgssdsanflag"))%>">
<input type="hidden" name="hidcgssdpercchk" value="<%=Helper.correctNull((String)hshValues.get("perccgssdflag"))%>">
<input type="hidden" name="hidmisactivitycodechk" value="<%=Helper.correctNull((String)hshValues.get("misactivittycodechk"))%>">
<input type="hidden" name="hidmisactivittycodencgtcchk" value="<%=Helper.correctNull((String)hshValues.get("misactivittycodencgtcchk"))%>">
<input type="hidden" name="hidaadharchek" value="<%=Helper.correctNull((String)hshValues.get("aadharchek"))%>">
<input type="hidden" name="hidmsmecorpchk" value="<%=Helper.correctNull((String)hshValues.get("corpmisappchk"))%>">
<input type="hidden" name="hidmsmeretchk" value="<%=Helper.correctNull((String)hshValues.get("retmisappchk"))%>">
<input type="hidden" name="hiddoccheck" value="<%=Helper.correctNull((String)hshValues.get("doccheck"))%>">
<input type="hidden" name="hidFacSno" value="<%=Helper.correctNull((String)hshValues.get("strFacilitySno"))%>">
<input type="hidden" name="hidreasonproccchk" value="<%=Helper.correctNull((String)hshValues.get("strreasonproccchk"))%>">
<input type="hidden" name="hidproposedshgchk" value="<%=Helper.correctNull((String)hshValues.get("proposedshgchk"))%>">
<input type="hidden" name="hidcarpetchk" value="<%=Helper.correctNull((String)hshValues.get("carpetchk"))%>">
<input type="hidden" name="hidcorpmisminority" value="<%=Helper.correctNull((String)hshValues.get("corpmisminority"))%>">
<input type="hidden" name="hidretmisminority" value="<%=Helper.correctNull((String)hshValues.get("retmisminority"))%>">
<input type="hidden" name="hidcorppostmisminority" value="<%=Helper.correctNull((String)hshValues.get("corppostmisminority"))%>">
<input type="hidden" name="hidretpostmisminority" value="<%=Helper.correctNull((String)hshValues.get("retpostmisminoritys"))%>">

<input type="hidden" name="hidgecl3propstatus" value="<%=Helper.correctNull((String)hshValues.get("strgecl3propstatus"))%>">
<input type="hidden" name="hidgecl2propstatus" value="<%=Helper.correctNull((String)hshValues.get("strgecl2propstatus"))%>">
<input type="hidden" name="hidgecl1propstatus" value="<%=Helper.correctNull((String)hshValues.get("strgecl1propstatus"))%>">
<iframe height="0" width="0" id="ifrm4" frameborder="0" style="border: 0"></iframe>
</form>
</body>
</html>
