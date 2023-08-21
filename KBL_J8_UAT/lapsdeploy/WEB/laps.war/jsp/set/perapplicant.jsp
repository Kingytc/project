<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />


<%
if (objValues instanceof java.util.HashMap) {
	hshValues = (java.util.HashMap) objValues;
}
	boolean boolMandatoryCBSFieldsFilled = ((Boolean) hshValues
			.get("keyBoolMandatoryCBSFieldsFilled")).booleanValue();
		if (!boolMandatoryCBSFieldsFilled) {	
%>
<jsp:forward page="/jsp/share/showLapsMandatoryFields.jsp" />
<%}  %>
<%
String strProfilestatus = Helper.correctNull((String) hshValues.get("strProfilestatus"));
String strCattype=Helper.correctNull(request.getParameter("hidCategoryType"));
String strAppTitle =Helper.correctNull((String)hshValues.get("perapp_title"));

String strCBSID="",strTitle="",strFullName="",strShortName="",strFatherName="",strConstitution="",strPANNo="",strSex="";
String strDOB="01/01/1990",strMartialStatus="",strStatus="",strBorrStatus="",strOrgScode="",strRegNo="",strTaxSlab="";
String strEmployment="",strLineofActivity="",strLoASince="",strBanking="",strBorrowerSince="",strSalaryRouted="";
String strStaffRelation="",strRelationName="",strBloodRelation="",strIntroducerName="",strIntroStatus="",strTradeFinance="";
String strInlandTrade="",strCorpReligion="",strIndustryCode="",strSatisfactory="";
String strResidentStatus="",strCountry="",strisStaff="",strStaffID="",strStaffDOJ="",strReligion="",strCaste="";
String strMinority="",strChildDep="",strOtherDep="",strEarningMem="",strEduQual="",strAreaSpecial="",strSeniorCitizen="";
String strPhysicalChgd="",strExService="",strYearsofService="",strisMinor="",strGuardianCBSID="", strGaurdianName="",strGaurdianReln="";
String strGaurdianAddr="",strSpouseTitle="",strSpouseName="",strSpouseDOB="01/0/1900",strSpouseOcc="",strSpouseQual="";
String strSpousePANNo="",strSpouseEmployer,strSpouseIncome="0.00",strSpouseAddr="";
String strOwnershipType="",strROCNumber="",strCIN="",strIEC="",strGSTIN="",strTIN="",strGroup="",strIndustryType="",strTotalEmployees="",strEmployeeAsonDate="";
String strNBFCLoA="",strNBFCDeposit="",strNBFCInfra="",strNBFCAsset="",strMFI="",strMajority="",strSHGLoc="";
String strMembers="",strBeneficiaries="",strSHGScheme="",strNGOFinance="",strSavingsAcct="",strCommencementDate="",
strIncorporationDate="", strRelateStaffID="", strConstitutionNew="",strNetworth="",strNetworthAson="",strIntrotype=""
,strIntroStaffID="",strIntroCBSID="",PERAPP_INVOCDATE="",EligtoinvocdateEdit="";

strCBSID=Helper.correctNull((String)hshValues.get("perapp_cbsid"));
strTitle=Helper.correctNull((String)hshValues.get("perapp_title"));
strFullName=Helper.correctNull((String)hshValues.get("perapp_fname"));
strShortName=Helper.correctNull((String)hshValues.get("perapp_lname"));
strFatherName=Helper.correctNull((String)hshValues.get("perapp_fatname"));
strConstitution=Helper.correctNull((String)hshValues.get("perapp_constitution"));
strPANNo=Helper.correctNull((String)hshValues.get("perapp_panno"));
strSex=Helper.correctNull((String)hshValues.get("perapp_sex"));
strDOB=Helper.correctNull((String)hshValues.get("perapp_dob"));
strMartialStatus=Helper.correctNull((String)hshValues.get("perapp_marstat"));
strStatus=Helper.correctNull((String)hshValues.get("perapp_istatus"));
strBorrStatus=Helper.correctNull((String)hshValues.get("perapp_status"));
strOrgScode=Helper.correctNull((String)hshValues.get("perapp_branchcode"));
strRegNo=Helper.correctNull((String)hshValues.get("perapp_regno"));
strTaxSlab=Helper.correctNull((String)hshValues.get("perapp_taxslab"));
strEmployment=Helper.correctNull((String)hshValues.get("perapp_employment"));
strLineofActivity=Helper.correctNull((String)hshValues.get("perapp_occupation"));
strLoASince=Helper.correctNull((String)hshValues.get("perapp_borrower_since"));
strBanking=Helper.correctNull((String)hshValues.get("perapp_bank"));
strBorrowerSince=Helper.correctNull((String)hshValues.get("perapp_banksince"));
strSalaryRouted=Helper.correctNull((String)hshValues.get("perapp_salaryrouted"));
strStaffRelation=Helper.correctNull((String)hshValues.get("perapp_relation_bankstaff"));
strRelationName=Helper.correctNull((String)hshValues.get("perapp_relation_staffname"));
strRelateStaffID=Helper.correctNull((String)hshValues.get("perapp_relat_staffid"));
strBloodRelation=Helper.correctNull((String)hshValues.get("perapp_blood_relation"));
strIntroducerName=Helper.correctNull((String)hshValues.get("perapp_introname"));
strIntroStatus=Helper.correctNull((String)hshValues.get("perapp_introstatus"));
strTradeFinance=Helper.correctNull((String)hshValues.get("perapp_tradefinance"));
strInlandTrade=Helper.correctNull((String)hshValues.get("perapp_inlandtrade"));
strIndustryCode=Helper.correctNull((String)hshValues.get("perapp_indcode"));
strCorpReligion=Helper.correctNull((String)hshValues.get("perapp_religion"));
strNetworth=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("PERAPP_NETWORTH"))));
strNetworthAson=Helper.correctNull((String)hshValues.get("PERAPP_NETWORTHASON"));
strIntrotype=Helper.correctNull((String)hshValues.get("PERAPP_INTROTYPE"));
strIntroStaffID = Helper.correctNull((String)hshValues.get("PERAPP_INTROSTAFFID"));
strIntroCBSID = Helper.correctNull((String)hshValues.get("PERAPP_INTROCBSID"));
strConstitutionNew=Helper.correctNull((String)hshValues.get("perapp_constitutionnew"));
strResidentStatus=Helper.correctNull((String)hshValues.get("indinfo_resident_status"));
strCountry=Helper.correctNull((String)hshValues.get("indinfo_resident_country"));
strisStaff=Helper.correctNull((String)hshValues.get("indinfo_is_staff"));
strStaffID=Helper.correctNull((String)hshValues.get("indinfo_staff_id"));
strStaffDOJ=Helper.correctNull((String)hshValues.get("indinfo_dateof_joining"));
strReligion=Helper.correctNull((String)hshValues.get("indinfo_religion"));
strCaste=Helper.correctNull((String)hshValues.get("indinfo_caste"));
strMinority=Helper.correctNull((String)hshValues.get("indinfo_minority"));
strChildDep=Helper.correctNull((String)hshValues.get("indinfo_dependents_child"));
strOtherDep=Helper.correctNull((String)hshValues.get("indinfo_dependents_others"));
strEarningMem=Helper.correctNull((String)hshValues.get("indinfo_earning_member"));
strEduQual=Helper.correctNull((String)hshValues.get("indinfo_edu_qual"));
strAreaSpecial=Helper.correctNull((String)hshValues.get("indinfo_area_specialized"));
strSeniorCitizen=Helper.correctNull((String)hshValues.get("indinfo_senior_citizen"));
strPhysicalChgd=Helper.correctNull((String)hshValues.get("indinfo_physically_challanged"));
strExService=Helper.correctNull((String)hshValues.get("indinfo_exservice_man"));
strYearsofService=Helper.correctNull((String)hshValues.get("indinfo_service_years"));
strisMinor=Helper.correctNull((String)hshValues.get("indinfo_is_minor"));
strGuardianCBSID=Helper.correctNull((String)hshValues.get("indinfo_guardian_appid"));
strGaurdianName=Helper.correctNull((String)hshValues.get("indinfo_guardian_name"));
strGaurdianReln=Helper.correctNull((String)hshValues.get("indinfo_guardian_relation"));
strGaurdianAddr=Helper.correctNull((String)hshValues.get("indinfo_guardian_address"));
strSpouseTitle=Helper.correctNull((String)hshValues.get("indinfo_spouse_title"));
strSpouseName=Helper.correctNull((String)hshValues.get("indinfo_spouse_name"));
strSpouseDOB=Helper.correctNull((String)hshValues.get("indinfo_spouse_dob"));
strSpouseOcc=Helper.correctNull((String)hshValues.get("indinfo_spouse_occupation"));
strSpouseQual=Helper.correctNull((String)hshValues.get("indinfo_spouse_qualification"));
strSpousePANNo=Helper.correctNull((String)hshValues.get("indinfo_spouse_panno"));
strSpouseEmployer=Helper.correctNull((String)hshValues.get("indinfo_spouse_employer"));
strSpouseIncome=Helper.correctNull((String)hshValues.get("indinfo_spouse_income"));
strSpouseAddr=Helper.correctNull((String)hshValues.get("indinfo_spouse_address"));
strCommencementDate=Helper.correctNull((String)hshValues.get("cominfo_commencement_date"));
strIncorporationDate=Helper.correctNull((String)hshValues.get("cominfo_incorporation_date"));
strOwnershipType=Helper.correctNull((String)hshValues.get("cominfo_ownership_type"));
strROCNumber=Helper.correctNull((String)hshValues.get("cominfo_roc_number"));
strCIN=Helper.correctNull((String)hshValues.get("cominfo_cin"));
strTIN=Helper.correctNull((String)hshValues.get("cominfo_tin"));
strIEC=Helper.correctNull((String)hshValues.get("COMINFO_IEC"));
strGSTIN=Helper.correctNull((String)hshValues.get("COMINFO_GSTIN"));
strGroup=Helper.correctNull((String)hshValues.get("cominfo_groupid"));
strIndustryType=Helper.correctNull((String)hshValues.get("cominfo_industry_type"));
strTotalEmployees=Helper.correctNull((String)hshValues.get("cominfo_total_employees"));
strEmployeeAsonDate=Helper.correctNull((String)hshValues.get("cominfo_employees_asondate"));
strNBFCLoA=Helper.correctNull((String)hshValues.get("cominfo_loa_nbfc"));
strNBFCDeposit=Helper.correctNull((String)hshValues.get("cominfo_nbfc_deposit"));
strNBFCInfra=Helper.correctNull((String)hshValues.get("cominfo_nbfc_infra"));
strNBFCAsset=Helper.correctNull((String)hshValues.get("cominfo_nbfc_asset"));
strMFI=Helper.correctNull((String)hshValues.get("cominfo_micro_fin_inst"));
strMajority=Helper.correctNull((String)hshValues.get("cominfo_minority_community"));
strSHGLoc=Helper.correctNull((String)hshValues.get("cominfo_shg_location"));
strMembers=Helper.correctNull((String)hshValues.get("cominfo_shg_members"));
strBeneficiaries=Helper.correctNull((String)hshValues.get("cominfo_shg_beneficiaries"));
strSHGScheme=Helper.correctNull((String)hshValues.get("cominfo_shg_scheme"));
strNGOFinance=Helper.correctNull((String)hshValues.get("cominfo_shg_ngo"));
strSavingsAcct=Helper.correctNull((String)hshValues.get("cominfo_shg_acctno"));
strSatisfactory=Helper.correctNull((String)hshValues.get("perapp_satisfactory"));
String strlending=Helper.correctNull((String)hshValues.get("perapp_lending"));
session.setAttribute("strEmployment",strEmployment);
session.setAttribute("strConstitution",strConstitution);
String hidfacname = Helper.correctNull((String) hshValues.get("strFacname"));
String strBlind=Helper.correctNull((String)hshValues.get("INDINFO_BLIND"));
String strMajormem=Helper.correctNull((String)hshValues.get("COMINFO_MAJORITYMEMBER"));
String strPageName=Helper.correctNull((String)hshValues.get("strIncompletepage"));
String strHeldWomen=Helper.correctNull((String)hshValues.get("perapp_stakeheld_women"));

ArrayList arrAssetDet =(ArrayList)hshValues.get("arrAssetDet");
ArrayList arrcol5 = new ArrayList ();

String Staticdata_constitution=Helper.correctNull((String)hshValues.get("Staticdata_constitution"));
String PERAPP_PARTNERSHIP_DET=Helper.correctNull((String)hshValues.get("PERAPP_PARTNERSHIP_DET"));
String PERAPP_PARTNERSHIP_DEEDDATE=Helper.correctNull((String)hshValues.get("PERAPP_PARTNERSHIP_DEEDDATE"));
String PERAPP_PARTNERSHIP_REGNO=Helper.correctNull((String)hshValues.get("PERAPP_PARTNERSHIP_REGNO"));
String PERAPP_COM_SEARCHREPDATE=Helper.correctNull((String)hshValues.get("PERAPP_COM_SEARCHREPDATE"));
String PERAPP_COM_AUTHCAPTAL=Helper.correctNull((String)hshValues.get("PERAPP_COM_AUTHCAPTAL"));
String PERAPP_COM_PAIDUPCAP=Helper.correctNull((String)hshValues.get("PERAPP_COM_PAIDUPCAP"));
String PERAPP_COM_MOAVERIFIED=Helper.correctNull((String)hshValues.get("PERAPP_COM_MOAVERIFIED"));
String PERAPP_COM_AMENDEDMOA=Helper.correctNull((String)hshValues.get("PERAPP_COM_AMENDEDMOA"));
String PERAPP_TRUST_DEEDDATE=Helper.correctNull((String)hshValues.get("PERAPP_TRUST_DEEDDATE"));
String PERAPP_TRUST_REGTYPE=Helper.correctNull((String)hshValues.get("PERAPP_TRUST_REGTYPE"));
String PERAPP_TRUST_PERMREFNO=Helper.correctNull((String)hshValues.get("PERAPP_TRUST_PERMREFNO"));
String PERAPP_UDYOG_AADHAR=Helper.correctNull((String)hshValues.get("PERAPP_UDYOG_AADHAR"));
String PERAPP_MSE_REGNO=Helper.correctNull((String)hshValues.get("PERAPP_MSE_REGNO"));
String PERAPP_CRITERIA_SALES_TURNOVER=Helper.correctNull((String)hshValues.get("PERAPP_CRITERIA_SALES_TURNOVER"));
PERAPP_INVOCDATE=Helper.correctNull((String)hshValues.get("PERAPP_INVOCDATE"));
EligtoinvocdateEdit =  Helper.correctNull((String)hshValues.get("EligtoinvocdateEdit"));
String strinvocmindate="27/05/2021";
String strinvocmaxdate="30/09/2021";
String invocblockusers=Helper.correctNull((String)hshValues.get("invocblockusers"));
//out.println("Staticdata_constitution"+Staticdata_constitution);
%>
<html>
<head>
<title>Personal - Applicant</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
	<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/customer_profile.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var varinvocdate = "<%=PERAPP_INVOCDATE%>";
var invocmindate = "<%=strinvocmindate%>";
var invocmaxdate = "<%=strinvocmaxdate%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varCatType = "<%=strCattype%>";
var varTitle="<%=Helper.correctNull((String)hshValues.get("perapp_title"))%>";
var varConstitution="<%=Helper.correctNull((String)hshValues.get("perapp_constitution"))%>";
var varSex="<%=Helper.correctNull((String)hshValues.get("perapp_sex"))%>";
var varMartialStatus="<%=Helper.correctNull((String)hshValues.get("perapp_marstat"))%>";
var varStatus="<%=Helper.correctNull((String)hshValues.get("perapp_istatus"))%>";
var varBorrStatus="<%=Helper.correctNull((String)hshValues.get("perapp_status"))%>";
var varTaxSlab="<%=Helper.correctNull((String)hshValues.get("perapp_taxslab"))%>";
var varEmployment="<%=Helper.correctNull((String)hshValues.get("perapp_employment"))%>";
var varLineofActivity="<%=Helper.correctNull((String)hshValues.get("perapp_occupation"))%>";
var varBanking="<%=Helper.correctNull((String)hshValues.get("perapp_bank"))%>";
var varBorrowerSince="<%=Helper.correctNull((String)hshValues.get("perapp_banksince"))%>";
var varSalaryRouted="<%=Helper.correctNull((String)hshValues.get("perapp_salaryrouted"))%>";
var varStaffRelation="<%=Helper.correctNull((String)hshValues.get("perapp_relation_bankstaff"))%>";
var varBloodRelation="<%=Helper.correctNull((String)hshValues.get("perapp_blood_relation"))%>";
var varIntroStatus="<%=Helper.correctNull((String)hshValues.get("perapp_introstatus"))%>";
var varTradeFinance="<%=Helper.correctNull((String)hshValues.get("perapp_tradefinance"))%>";
var varInlandTrade="<%=Helper.correctNull((String)hshValues.get("perapp_inlandtrade"))%>";
var varIndustryCode="<%=Helper.correctNull((String)hshValues.get("perapp_indcode"))%>";
var varCorpReligion="<%=Helper.correctNull((String)hshValues.get("perapp_religion"))%>";
var varResidentStatus="<%=strResidentStatus%>";
var varisStaff="<%=strisStaff%>";
var varReligion="<%=strReligion%>";
var varCaste="<%=strCaste%>";
var varMinority="<%=strMinority%>";
var varEduQual="<%=strEduQual%>";
var varSeniorCitizen="<%=strSeniorCitizen%>";
var varPhysicallyChgd="<%=strPhysicalChgd%>";
var varBlind="<%=strBlind%>";
var varExService="<%=strExService%>";
var varMinor="<%=strisMinor%>";
var varGaurdianReln="<%=strGaurdianReln%>";
var varSpouseTitle="<%=strSpouseTitle%>";
var varSpouseOcc="<%=strSpouseOcc%>";
var varSpouseQual="<%=strSpouseQual%>";
var varOwnershipType="<%=strOwnershipType%>";
var varIndustryType="<%=strIndustryType%>";
var varNBFCLoA="<%=strNBFCLoA%>";
if(varNBFCLoA=="")
{	varNBFCLoA="N";
	}
var varNBFCDeposit="<%=strNBFCDeposit%>";
var varNBFCInfra="<%=strNBFCInfra%>";
var varNBFCAsset="<%=strNBFCAsset%>";
var varMFI="<%=strMFI%>";
if(varMFI==""){
	varMFI="N";
}
var varMajority="<%=strMajority%>";
var varMajormem="<%=strMajormem%>";
if(varMajormem==""){
	varMajormem="N";
}
	
var varSHGLoc="<%=strSHGLoc%>";
var varSHGScheme="<%=strSHGScheme%>";
var varNGOFinance="<%=strNGOFinance%>";
var varSatisfactory="<%=strSatisfactory%>";
var varConstitutionNew="<%=strConstitutionNew%>";
var varIntrotype="<%=strIntrotype%>";
var varIntroStaffID="<%=strIntroStaffID%>";
var varIntroCBSID="<%=strIntroCBSID%>";
var varstrlending="<%=strlending%>";
var varRelationName="<%=strRelationName%>";
var varHeldWomen="<%=strHeldWomen%>";
var Staticdata_constitution="<%=Staticdata_constitution%>";
var PERAPP_PARTNERSHIP_DET="<%=PERAPP_PARTNERSHIP_DET%>";
var PERAPP_COM_MOAVERIFIED="<%=PERAPP_COM_MOAVERIFIED%>";
var PERAPP_TRUST_REGTYPE="<%=PERAPP_TRUST_REGTYPE%>";
var appstatus="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>";
var PERAPP_CRITERIA_SALES_TURNOVER="<%=PERAPP_CRITERIA_SALES_TURNOVER%>";
var varCorpotherfacilities="<%=Helper.correctNull((String)hshValues.get("perapp_facility_othbank"))%>";
function doramdetails()
{
 	var varQryString = appURL+"action/ramparameters.jsp?type=R&hidBeanGetMethod=getrocdetails&hidBeanId=commappmaster&comapp_id="+document.forms[0].hidDemoId.value+"&comapp_companyid="+document.forms[0].hidDemoId.value;
	var title = "Ramdetails";
	var prop = "scrollbars=yes,menubar=yes,width=900,height=550";
	prop = prop + ",left=50,top=150";
    window.open(varQryString,title,prop);	
}


</script>

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">

</head>
<body
	onload="onloadDetails();callcgt();">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>

<div id='imgloading' style="display:none;">
<img src="<%=ApplicationParams.getAppUrl()%>img/processing2.gif"></div>
	<!-- callonLoad();enableSince();showBranch();getlocationvalues();
	showres();showcoun();shownri();showStaffBox();showYearsOfService();"> -->
<form name="appform" method="post" action="" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Customer
		Profile -&gt;Demographics</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="1" cellpadding="3"
			align="left" class="outertable">
			<tr>
		<td  align="center"><jsp:include page="../share/Cusurllink.jsp" flush="true">
			<jsp:param name="pageid" value="1"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="strProfilestatus" value="<%=strProfilestatus%>" />
			<jsp:param name="hidfacname" value="<%=hidfacname%>" />
			<jsp:param name="hidincompletedpagename" value="<%=strPageName%>" />
			</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
</table>






<%@include file="../share/customer_profile.jsp"%>
<br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Modify_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<table border="0" cellspacing="0" cellpadding="3"
	align="center" class="outertable border1">
	<tr>
		<!-- <td>
			<input type="button" name="cmdreferences" value="References"
					class="buttonStyle" onClick="doReferences()">
		</td> -->
		<%if(strResidentStatus.equalsIgnoreCase("Y")){ %>
		<td>
			<input type="button" name="cmdNridetails" value="NRI Details"
					class="buttonStyle" onClick="doNRIDetails()">
		</td>
		<%} %>
	</tr>
</table>


<input type="hidden" name="hidAppType" value='A'> 
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>"> 
<input type="hidden" name="hidCBSId" value="<%=Helper.correctNull((String)hshValues.get("perapp_cbsid"))%>">
<input type="hidden" name="hidappstatus" value="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>"> 
<input type="hidden" name="hidOldAppId" value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>"> 
<input type="hidden" name="OldAppId" value="<%=Helper.correctNull((String)hshValues.get("perapp_oldid"))%>">
<input type="hidden" name="scode" value="yyy"> 
<input type="hidden" name="txt_flag" value="<%=txt_flag%>"> 
<input type="hidden" name="Branch" value="Branch"> 
<input type="hidden" name="hid_comappid1" value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>"> 
<input type="hidden" name="hid_comappid2" value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>"> 
<input type="hidden" name="txt_employment" value="<%=Helper.correctNull((String)hshValues.get("perapp_employment"))%>">
<input type="hidden" name="applnt" value="P"> 
<input type="hidden" name="hidphotoid" value="<%=Helper.correctNull((String)hshValues.get("perapp_photo"))%>">
<input type="hidden" name="hidcity" value="<%=Helper.correctNull((String)hshValues.get("perapp_city_code"))%>">
<input type="hidden" name="hidPermCity" value="<%=Helper.correctNull((String)hshValues.get("perapp_permcity_code"))%>">
<input type="hidden" name="hidcity1" value="<%=Helper.correctNull((String)hshValues.get("perapp_permcity_code"))%>">
<input type="hidden" name="hidstate" value="<%=Helper.correctNull((String)hshValues.get("perapp_state_code"))%>">
<input type="hidden" name="hidstate1" value="<%=Helper.correctNull((String)hshValues.get("perapp_permstate_code"))%>">
<input type="hidden" name="usr_mname" value=""> 
<input type="hidden" name="hidModuleName" value="P"> 
<input type="hidden" name="readFlag" value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>">
<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>">
<input type="hidden" name="txtperapp_appid" value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>"> 

<input type="hidden" name="hidzipcontrol"
	value="<%=Helper.correctNull((String)request.getParameter("hidzipcontrol")) %>">
<input type="hidden" name="hidzipvaildatorcontrol"
	value="<%=Helper.correctNull((String)request.getParameter("hidzipvaildatorcontrol")) %>">
 <input type="hidden" name="hidcitycontrol"
	value="<%=Helper.correctNull((String)request.getParameter("hidcitycontrol")) %>">
<input type="hidden" name="hidstatecontrol"
	value="<%=Helper.correctNull((String)request.getParameter("hidstatecontrol")) %>">

<input type="hidden" name="hidcitycodecontrol"
	value="<%=Helper.correctNull((String)request.getParameter("hidcitycodecontrol")) %>">
<input type="hidden" name="hidstatecodecontrol"
	value="<%=Helper.correctNull((String)request.getParameter("hidstatecodecontrol")) %>">
 <input type="hidden"
	name="hidzip">
	<iframe src="" id="ifrmappid" width="0" height="0"> </iframe>
	<iframe src="" id="ifrmcgtmse" width="0" height="0"> </iframe>
<input type="hidden" name="hidCategory" />
<input type="hidden" name="hid_inwardno"/>
<input type="hidden" name="hidzip1" value="">
<input type="hidden" name="hidzip2" value="">
<input type="hidden" name="hidres1" value="">
<input type="hidden" name="hidres2" value="">
<input type="hidden" name="hidzip" value="<%=Helper.correctNull((String) hshValues.get("state_validatepin"))%>">
<input type="hidden" name="hidfacname" value="<%=hidfacname%>">
<input type="hidden" name="hid_consttype" value="<%=Staticdata_constitution %>">
</form>
</body>
</html>

