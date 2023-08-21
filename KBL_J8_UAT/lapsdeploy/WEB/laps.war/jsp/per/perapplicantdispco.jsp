<%@include file="../share/directives.jsp"%>
<%
String appid = Helper.correctNull((String)hshValues.get("perapp_id"));		
String pageid = request.getParameter("pageid");
String strCategory=Helper.correctNull((String)request.getParameter("hidCategoryType"));
String strProfilestatus = Helper.correctNull((String) hshValues.get("strProfilestatus"));
String strapptype = Helper.correctNull((String)request.getParameter("corp"));
String tempProfile = "";
if (strProfilestatus.equalsIgnoreCase("Y")) {
	tempProfile = "Completed";
} else {
	tempProfile = " Not Completed";
}
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
String strOwnershipType="",strROCNumber="",strCIN="",strTIN="",strGroup="",strIndustryType="",strTotalEmployees="",strEmployeeAsonDate="";
String strNBFCLoA="",strNBFCDeposit="",strNBFCInfra="",strNBFCAsset="",strMFI="",strMajority="",strSHGLoc="";
String strMembers="",strBeneficiaries="",strSHGScheme="",strNGOFinance="",strSavingsAcct="",strCommencementDate="",
strIncorporationDate="",strRelateStaffID="", strConstitutionNew="",strNetworth="",strNetworthAson="",strIntrotype=""
,strIntroStaffID="",strIntroCBSID="",strIEC="",strGSTIN="",PERAPP_INVOCDATE="",EligtoinvocdateEdit="";

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
strNetworth=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("PERAPP_NETWORTH"))));
strNetworthAson=Helper.correctNull((String)hshValues.get("PERAPP_NETWORTHASON"));
strIntrotype=Helper.correctNull((String)hshValues.get("PERAPP_INTROTYPE"));
strIntroStaffID = Helper.correctNull((String)hshValues.get("PERAPP_INTROSTAFFID"));
strIntroCBSID = Helper.correctNull((String)hshValues.get("PERAPP_INTROCBSID"));
strTradeFinance=Helper.correctNull((String)hshValues.get("perapp_tradefinance"));
strInlandTrade=Helper.correctNull((String)hshValues.get("perapp_inlandtrade"));
strIndustryCode=Helper.correctNull((String)hshValues.get("perapp_indcode"));
strCorpReligion=Helper.correctNull((String)hshValues.get("perapp_religion"));
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
String strMajormem=Helper.correctNull((String)hshValues.get("COMINFO_MAJORITYMEMBER"));
session.setAttribute("strNewEmployment",strEmployment);
session.setAttribute("strConstitution",strConstitution);
String strlending=Helper.correctNull((String)hshValues.get("perapp_lending"));
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String strHeldWomen=Helper.correctNull((String)hshValues.get("perapp_stakeheld_women"));
String strBlind=Helper.correctNull((String)hshValues.get("INDINFO_BLIND"));
String strPageName=Helper.correctNull((String)hshValues.get("strIncompletepage"));
strIEC=Helper.correctNull((String)hshValues.get("COMINFO_IEC"));
strGSTIN=Helper.correctNull((String)hshValues.get("COMINFO_GSTIN"));
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
PERAPP_INVOCDATE=Helper.correctNull((String)hshValues.get("PERAPP_INVOCDATE"));
EligtoinvocdateEdit =  Helper.correctNull((String)hshValues.get("EligtoinvocdateEdit"));
String strinvocmindate="27/05/2021";
String strinvocmaxdate="30/09/2021";
String invocblockusers=Helper.correctNull((String)hshValues.get("invocblockusers"));
%>
<html>
<head>
<title>Personal - Applicant</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/per/perapplicantdispco.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var strapplnt="<%=request.getParameter("applnt")%>";
var strapplntvalue = "Applicant/ Guarantor";
var appURL = "<%=ApplicationParams.getAppUrl()%>";

var id="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>";
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
if(varNBFCLoA==""){
	varNBFCLoA="N";
}
var varNBFCDeposit="<%=strNBFCDeposit%>";
var varNBFCInfra="<%=strNBFCInfra%>";
var varNBFCAsset="<%=strNBFCAsset%>";
var varMFI="<%=strMFI%>";
if(varMFI==""){
	varMFI="N";
}
var varMajority="<%=strMajority%>";
var varSHGLoc="<%=strSHGLoc%>";
var varSHGScheme="<%=strSHGScheme%>";
var varNGOFinance="<%=strNGOFinance%>";
var varSatisfactory="<%=strSatisfactory%>";
var varConstitutionNew="<%=strConstitutionNew%>";
var varIntrotype="<%=strIntrotype%>";
var varMajormem="<%=strMajormem%>";
if(varMajormem==""){
	varMajormem="N";
}
var varIntroStaffID="<%=strIntroStaffID%>";
var varIntroCBSID="<%=strIntroCBSID%>";
var varstrlending="<%=strlending%>";
var varRelationName="<%=strRelationName%>";
var varHeldWomen="<%=strHeldWomen%>";
var Staticdata_constitution="<%=Staticdata_constitution%>";
var PERAPP_PARTNERSHIP_DET="<%=PERAPP_PARTNERSHIP_DET%>";
var PERAPP_COM_MOAVERIFIED="<%=PERAPP_COM_MOAVERIFIED%>";
var PERAPP_TRUST_REGTYPE="<%=PERAPP_TRUST_REGTYPE%>";
var PERAPP_CRITERIA_SALES_TURNOVER="<%=Helper.correctNull((String)hshValues.get("PERAPP_CRITERIA_SALES_TURNOVER"))%>";
var varmsmeclassification="<%=Helper.correctNull((String)hshValues.get("PERAPP_MSME_CLASSIFICATION"))%>";
var varminorityindustry="<%=Helper.correctNull((String)hshValues.get("PERAPP_MINORITYINDUSTRY"))%>";
function callLoad()
{	
	onloadDetails();
	document.forms[0].txt_applt_title.disabled=true;
	<%if(!strapptype.equalsIgnoreCase("C")){%>
	document.forms[0].hidDemoId.disabled=false;
	if(id!="")
	{
	document.forms[0].hidDemoId.value=id;
	}
	<%}%>
}

function showDemographics()
{
	if(document.forms[0].hidDemoId.value!="")
	{
		if(strapplnt=="C")
		{
		document.forms[0].action=appURL+"action/perapplicantdispco.jsp?applnt=C&pageid=2&corp=R";
		}
		else
		{
		document.forms[0].action=appURL+"action/perapplicantdispco.jsp?applnt=G&pageid=2&corp=R";
		}
		document.forms[0].hidBeanGetMethod.value="getDemographics";			
		document.forms[0].method="post";
		document.forms[0].hidAppType.value="";
		document.forms[0].submit();
	}
}

</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callLoad();">
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
<form name="appform" method="post" class="normal">
<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ 
if(!strSessionModuleType.equalsIgnoreCase("RET")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="subpageid" value="115" />
			<jsp:param name="subsubpageid" value="21" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<% }else{%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="2" />
			<jsp:param name="subsubpageid" value="21"/>
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%} %>
<jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value=""/>
			<jsp:param name="subsubpageid" value="21"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include>
<%}else{ %>
     <%if(strapptype.equalsIgnoreCase("C")){ %>
  <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="cattype" value="CORP" />
			<jsp:param name="ssitype" value="" />
			<jsp:param name="applevel" value="A" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
  <%
if(strSessionModuleType.equalsIgnoreCase("AGR")){
%>
	<tr>
		<td class="page_flow">Home -&gt;Agriculture -&gt; Applicant -&gt; customer profile -&gt; Demographics</td>
	</tr>
 
  
     <%}else
     {
     %>
     <tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Application -&gt; Applicant-&gt; customer profile -&gt; Demographics</td>
	</tr>
      </table>
     <%}}else if(strSessionModuleType.equalsIgnoreCase("LAD") || strSessionModuleType.equalsIgnoreCase("RET")){ %> 
        <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="<%=pageid%>" />
        </jsp:include>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"  class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; 
       Retail(including schematic) -&gt; Application -&gt; Applicant/Guarantor -&gt; Demographics</td>
    </tr>
  </table>
 <%}else if(strSessionModuleType.equalsIgnoreCase("DIGI")){ %> 
        <jsp:include page="../share/applurllinkerdigi.jsp" flush="true"> 
        <jsp:param name="pageid" value="<%=pageid%>" />
        </jsp:include>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"  class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; 
       Digi Retail -&gt; Application -&gt; Applicant/Guarantor -&gt; Demographics</td>
    </tr>
  </table>
  <%} %>
<lapschoice:application />
  <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="1" cellpadding="3"
			align="left" class="outertable">
			<tr>
		<td>
		<%if(strapptype.equalsIgnoreCase("C")){ %>
		<lapstab:ComfacilityTab tabid="2" />
		<%}if(strapptype.equalsIgnoreCase("C") || strapptype.equalsIgnoreCase("R")){%>
		<jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value="21"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include>
		</td>
			</tr>
		</table>

		</td>
	</tr>
</table>
<%}} %>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
    <tr> 
      <td valign="top"> 
      <%if(strapptype.equalsIgnoreCase("C")){ %>
      <%}else{ %>
        <table width="60%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr> 
           <td nowrap align="center">Select  Applicant/ Guarantor</td>
            <td> 
              <select name="hidDemoId" onChange="showDemographics()">
                <option selected value="">&lt;--Select--&gt;</option>
                <%
                	String strAppType="A','C','G','O','P";
                %>
				<lapschoice:coappguarantor apptype="<%=strAppType%>" />
              </select>
            </td>
           </tr>       
        </table>
         <%} %>
      </td>
    </tr>
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="1"  class="outertable">
                <tr> 
                  <td valign="top" colspan="4"> 
                    
                      <table width="100%" border="0" cellspacing="0" cellpadding="4"  class="outertable">
                        <tr> 
                          <td valign="top"> 
                          <script>
                          var coflag=1;
                          </script>
                         <%@include file="/jsp/share/customer_profile.jsp" %>
                          </td>
                          </tr>
  			 </table>
  			 </td>
  			 </tr>
  			 <tr>
  			 <td>
          <table border="1" cellspacing="0" cellpadding="0"  align="center"  class="outertable">
    <tr> <td>
      <table width="43%" border="0" cellspacing="0" cellpadding="2" class="outertable">
          <tr valign="top"> 
            <td style="visibility:hidden;position:absolute"> 
              <input type="button" name="cmdedit" value="Edit" tabindex="79"
					class="buttonStyle"
					onClick="callEdit()" disabled="disabled">
            </td>
            <td style="visibility:hidden;position:absolute"> 
              <input type="button" name="cmdsave" value="Save" tabindex="80"
					class="buttonStyle"
					onClick="doSave()" disabled="disabled">
            </td>
            <td style="visibility:hidden;position:absolute"> 
              <input type="button" name="cmdcancel" value="Cancel" tabindex="81"
					class="buttonStyle"
					onClick="callCancel()">
            </td>
            <td style="visibility:hidden;position:absolute"> 
              <input type="button" name="cmddelete" value="Delete" tabindex="82"
					class="buttonStyle"
					onClick="callDelete()">
            </td>
            <td style="visibility:hidden;position:absolute"> 
              <input type="button" name="cmdmodify" value="Modify" tabindex="83"
					class="buttonStyle"
					onClick="callModify()" disabled>
            </td>
            <td style="visibility:hidden;position:absolute" > 
              <input type="button" name="cmdHelp" value="Help" tabindex="84"
					class="buttonHelp"
					onClick="dohlp()">
            </td>
            <td id="n1"  style="visibility:hidden;position:absolute" > 
              <input type="button" name="cmdNridetails" value="NRI Details" tabindex="86"
					onClick="doNRIDetails()"
					 class="buttonStyle"> 
            </td>
           <td style="visibility:hidden;position:absolute" >
              <input type="button" name="cmdReferences" value="References" tabindex="87"
					onClick="doReferences()"
					 class="buttonStyle"> 
            </td>
            <td id="m1" width="0" style="visibility:hidden;position:absolute" > 
              <input type="button" name="cmdDirectors" tabindex="88"
					value="Partners/Co- Partners /HUF/Directors" onClick="doPartners()" 
					 class="buttonStyle"> 
            </td>
            <td style="visibility:hidden;position:absolute" > 
            
              <input type="hidden" name="cmdAdditionalparameter" value="CBS Customer Data" tabindex="87"
					onClick="ShowAdditionalParameter('additionalParameter.jsp')"
					 class="buttonStyle"> 
            </td>
          
         </tr>                     
          </table>
    </td>
    </tr>
  </table>
  </td>
  </tr> 
  </table>
  </td>
  </tr>
  </table>
  </td>
  </tr>
  </table>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable" align="center">
  	<tr>
  		<td align="center"> 
             <input type="button" name="cmdclose" value="Close" tabindex="85"
					onClick="doClose()"  class="buttonClose"> 
  <INPUT TYPE="hidden" name="hidApp_type" value='A'>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
   <INPUT TYPE="hidden" name="page" value="ep">
  <INPUT TYPE="hidden" name="radLoan" value="Y">
  <!-- <INPUT TYPE="hidden" name="hidDemoId" value="<%=(String)request.getParameter("strApplicationNo")%>">-->
  <INPUT TYPE="hidden" name="hidAppType">
  <INPUT TYPE="hidden" name="hiPgDist" value="P">
  <INPUT TYPE="hidden" name="pageid" value="<%=pageid%>">
  <INPUT TYPE="hidden" name="hidPage" value="<%=pageid%>">
  <INPUT TYPE="hidden" name="applntype" value="<%=Helper.correctNull((String)request.getParameter("applnt"))%>" >
   <input type="hidden" name="hidcity" value="<%=Helper.correctNull((String)hshValues.get("perapp_city_code"))%>">
  <input type="hidden" name="hidPermCity" value="<%=Helper.correctNull((String)hshValues.get("perapp_permcity_code"))%>"> 
  <input type="hidden" name="hidcity1" value="<%=Helper.correctNull((String)hshValues.get("perapp_permcity_code"))%>">
  <input type="hidden" name="hidstate" value="<%=Helper.correctNull((String)hshValues.get("perapp_state_code"))%>">
  <input type="hidden" name="hidstate1" value="<%=Helper.correctNull((String)hshValues.get("perapp_permstate_code"))%>">
    <input type="hidden" name="hid_comappid2" value="">
    <input type="hidden" name="hid_comappid1" value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>"> 
       <input type="hidden" name="hidCBSId" value="">
   <input type="hidden" name="txtperapp_appid" value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>">
   <input type="hidden" name="hidEmployment" value="<%=Helper.correctNull((String)hshValues.get("perapp_employment"))%>">
  </td></tr>
  </table> 
</form>
</body>
</html>
 