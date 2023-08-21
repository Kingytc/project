<%@include file="../share/directives.jsp"%>

<%
String strLoanType=Helper.correctNull((String)request.getParameter("apploantype"));
session.setAttribute("strSessionMisFlag",Helper.correctNull((String)hshValues.get("strDataFlag")));
String strcategorytype=Helper.correctNull((String)request.getParameter("hidCategoryType"));
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String strfacilityno=Helper.correctNull((String)hshValues.get("strFacilitySno"));
String strBankncgtcScheme=Helper.correctNull((String)hshValues.get("strBankncgtcScheme"));
String strPageParam = Helper.correctNull((String) session.getAttribute("strModifyterms")).trim();

String PRD_CGTMSE=Helper.correctNull((String)hshValues.get("PRD_CGTMSE"));
HashMap  hsh=new HashMap();

if(strSessionModuleType.equalsIgnoreCase("RET"))
{
	
	hsh=(HashMap)hshValues.get("hshQueryValues11");
	
}
String strprdbankscheme="";
	
	if(strSessionModuleType.equalsIgnoreCase("RET"))
	{
		strprdbankscheme=Helper.correctNull((String) session.getAttribute("strprdbankscheme"));
	}
	
if(strSessionModuleType.equalsIgnoreCase("CORP")||strSessionModuleType.equalsIgnoreCase("AGR")){
	if(!strfacilityno.equals("")){
		
	    hsh=(HashMap)hshValues.get("hshQueryValues11");
	    
	}
}
//out.println(hshValues);
//out.println("strfacilityno=="+strfacilityno);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>MIS Details</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/mis/misdetails.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script>
var appid="<%=Helper.correctNull((String) request.getParameter("hidapplicantid"))%>";
var varLoanType="<%=Helper.correctNull((String)request.getParameter("strLoanType"))%>";
var varBankScheme="<%=Helper.correctNull((String)hshValues.get("strBankScheme"))%>"
//alert(varBankScheme);
var varRestructure="<%=Helper.correctNull((String)hshValues.get("app_whetherrestructure"))%>"
var varService="<%=Helper.correctNull((String)hshValues.get("app_whetherservice"))%>"
var varResUnder="<%=Helper.correctNull((String)hshValues.get("app_resunder"))%>"
var varPlace="<%=Helper.correctNull((String)hshValues.get("app_place"))%>"
var varRepayment="<%=Helper.correctNull((String)hshValues.get("app_repayment"))%>"
var varSourceOfRepay="<%=Helper.correctNull((String)hshValues.get("app_sourceofrepay"))%>"
var varGuarantee="<%=Helper.correctNull((String)hshValues.get("app_guarantee"))%>"
var varNewFacility="<%=Helper.correctNull((String)hshValues.get("app_whethernewfac"))%>"
var varMainAct="<%=Helper.correctNull((String)hshValues.get("app_mainactivity"))%>"
var varSubAct="<%=Helper.correctNull((String)hshValues.get("app_subactivity"))%>"
var varPurpose="<%=Helper.correctNull((String)hshValues.get("app_purpose"))%>"
var varBSRCode="<%=Helper.correctNull((String)hshValues.get("app_bsrcode"))%>"
var varBSR1Code="<%=Helper.correctNull((String)hshValues.get("app_bsr1code"))%>"
var varIndustryType="<%=Helper.correctNull((String)hshValues.get("app_industrytype"))%>"
var varAsset="<%=Helper.correctNull((String)hshValues.get("app_assetclassifcation"))%>"
var varFarmerCat="<%=Helper.correctNull((String)hshValues.get("app_farmercategory"))%>"
var varCropIns="<%=Helper.correctNull((String)hshValues.get("app_whethercropins"))%>"
var varKrishiCard="<%=Helper.correctNull((String)hshValues.get("app_whetherkrishicard"))%>"
var varPAIS="<%=Helper.correctNull((String)hshValues.get("app_whetherpais"))%>"
var varAccDep="<%=Helper.correctNull((String)hshValues.get("app_whetheraccdep"))%>"
var varAgri="<%=Helper.correctNull((String)hshValues.get("app_agriculture"))%>"
var varSector="<%=Helper.correctNull((String)hshValues.get("app_sector"))%>"
var varSubSector="<%=Helper.correctNull((String)hshValues.get("app_subsector"))%>"
var varSensitiveSector="<%=Helper.correctNull((String)hshValues.get("app_sensitivesector"))%>"
var varWeakerSec="<%=Helper.correctNull((String)hshValues.get("app_weakersec"))%>"
var varTwentyPntPgm="<%=Helper.correctNull((String)hshValues.get("app_twentypointpgm"))%>"
var varInfraCode="<%=Helper.correctNull((String)hshValues.get("app_infrastrcode"))%>"
var varDataFlag="<%=Helper.correctNull((String)hshValues.get("strDataFlag"))%>"
var varSectorType="<%=Helper.correctNull((String)hshValues.get("strPriorityType"))%>"
var varSubSectorType="<%=Helper.correctNull((String)hshValues.get("strPrioritySubsector"))%>"
var varSubSectorWeakerType="<%=Helper.correctNull((String)hshValues.get("strWeakerSectionSubSector"))%>"
var varSensitiveSectorType="<%=Helper.correctNull((String)hshValues.get("strSensitiveSector"))%>"
var varTwentyPointPgmType="<%=Helper.correctNull((String)hshValues.get("strTwentyPointPgm"))%>"
var varInfraStructureCreditType="<%=Helper.correctNull((String)hshValues.get("strInfracode"))%>"
var varGovtAnnounceScheme="<%=Helper.correctNull((String)hshValues.get("strGovtAnnounceScheme"))%>"
var varAgriIndustryType="<%=Helper.correctNull((String)hshValues.get("strAgriIndConfig"))%>"
var varLoanType="<%=strLoanType%>";
var varFacilitysno="<%=strfacilityno%>";
var varFacilityType="<%=Helper.correctNull((String)hshValues.get("facilitytype"))%>";
var varShareBroker="<%=Helper.correctNull((String)hshValues.get("app_sharebroker"))%>"
var varstrSessionModuleType="<%=strSessionModuleType%>";
var varMeritoriousStatus="<%=Helper.correctNull((String)hshValues.get("app_meritorious_status"))%>";
var varLoanAmount="<%=Helper.correctDouble((String)hshValues.get("strLoanAmt"))%>";
var varTotalServiceLimit="<%=Helper.correctDouble((String)hshValues.get("app_totlimser"))%>";
var varTotalAgriLimit="<%=Helper.correctDouble((String)hshValues.get("app_totlimagri"))%>";
var varSocialInfra="<%=Helper.correctDouble((String)hshValues.get("app_socialinfra"))%>";
var varAgriAnci="<%=Helper.correctDouble((String)hshValues.get("app_agri_anci"))%>";
var varAgriInfra="<%=Helper.correctDouble((String)hshValues.get("app_agri_infra"))%>";
var varRenewEner="<%=Helper.correctDouble((String)hshValues.get("app_renewenergy"))%>";
var varRenewEnerIndv="<%=Helper.correctDouble((String)hshValues.get("app_renewenergy_indv"))%>";

var varStrSectorCount="<%=Helper.correctInt((String)hshValues.get("strAppSectorCount"))%>";

var varAuthUser="<%=Helper.correctNull((String)hshValues.get("AuthUser"))%>";
var varPostSanc="<%=Helper.correctNull((String)session.getAttribute("strAppType"))%>";
var varEditFlag="<%=Helper.correctNull((String) hshValues.get("strEditFlag"))%>";
var varAgriSchemeFlag="<%=Helper.correctNull((String) hshValues.get("strAgriSchemeFlag"))%>";
var varProductType="<%=Helper.correctNull((String)session.getAttribute("strProductType"))%>";
var PRD_CGTMSE="<%=PRD_CGTMSE%>";
var activitycgtmsecode="<%=Helper.correctNull((String)hshValues.get("stractcodecgtmse"))%>";


var varmaj_member="<%=Helper.correctNull((String)hshValues.get("majority_member"))%>";
var varstake_held="<%=Helper.correctNull((String)hshValues.get("stake_held"))%>";
var varconstitut="<%=Helper.correctNull((String)hshValues.get("constitutionnew"))%>";

var varcaste="<%=Helper.correctNull((String)hshValues.get("indinfo_caste"))%>";
var vargender="<%=Helper.correctNull((String)hshValues.get("perapp_sex"))%>";
var varStandUpIndia="<%=Helper.correctNull((String)hshValues.get("strStandUpIndia"))%>";
var varFreezeflag="<%=Helper.correctNull((String)hshValues.get("strFreezeflag"))%>";
var varempasondate="<%=Helper.correctNull((String)hshValues.get("strempasondate"))%>";
var vartotalemp="<%=Helper.correctNull((String)hshValues.get("strtotalemp"))%>";
var varGSTReg="<%=Helper.correctNull((String)hshValues.get("COMINFO_GSTINREG"))%>";
var varGSTExempted="<%=Helper.correctNull((String)hshValues.get("COMINFO_GST_EXEMPTED"))%>";
var varMISFlag = "<%=Helper.correctNull((String)hshValues.get("strMisFlag"))%>";
var appraisalsanc1="<%=Helper.correctNull((String)hsh.get("appraisalsanc"))%>";
var varMinorty="<%=Helper.correctNull((String)hshValues.get("indinfo_minority"))%>";
var varFACCHECK="<%=Helper.correctNull((String) hsh.get("FACNOTCHECK"))%>";
var varcatageorysales="<%=Helper.correctNull((String) hshValues.get("PERAPP_CRITERIA_SALES_TURNOVER"))%>";
var varstateCode="<%=Helper.correctNull((String) hshValues.get("app_state"))%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var varcriteriainvest="<%=Helper.correctNull((String)hshValues.get("APP_CRITERIA_INVESTMENT"))%>";
var varministryindustry="<%=Helper.correctNull((String)hshValues.get("APP_MINISTRY_INDUSTRY"))%>";
var varareaofindvhouse="<%=Helper.correctNull((String)hshValues.get("APP_AREA_INDV_HOUSE"))%>";
var vrshgpurposeloan="<%=Helper.correctNull((String)hshValues.get("purposeofloan"))%>";
var vartotexitbuild="<%=Helper.correctDouble((String)hshValues.get("dbltotalextbuild"))%>";
var varminority="<%=Helper.correctNull((String)hshValues.get("INDINFO_MINORITY"))%>";
var varindstate="<%=Helper.correctNull((String)hshValues.get("app_stateminority"))%>";
var varindreligion="<%=Helper.correctNull((String)hshValues.get("indinfo_religion"))%>";
var varcommunityminority="<%=Helper.correctNull((String)hshValues.get("cominfo_minority_community"))%>";
var nonindreligion="<%=Helper.correctNull((String)hshValues.get("perapp_religion"))%>";
var varminorityindustry="<%=Helper.correctNull((String)hshValues.get("PERAPP_MINORITYINDUSTRY"))%>";
var varstartupconstitution="<%=Helper.correctNull((String)hshValues.get("StartupConstitution"))%>";
var varBankScheme="<%=Helper.correctNull((String)hshValues.get("strBankScheme"))%>";
var varSvanidhiType="<%=Helper.correctNull((String)hshValues.get("strSvanidhiType"))%>";
var varProposedAmt="<%=Helper.correctNull((String)hshValues.get("strProposedAmt"))%>";
var varfacilityhead="<%=Helper.correctNull((String)hshValues.get("COM_HEADFAC"))%>";
var varfacilitysubhead="<%=Helper.correctNull((String)hshValues.get("COM_SUBFAC"))%>";
var varplantval="<%=Helper.correctNull((String)hshValues.get("strPlant_val"))%>";
var varsalesval="<%=Helper.correctNull((String)hshValues.get("PERAPP_SALES_TURNOVER"))%>";
var strBankScheme="<%=Helper.correctNull((String)hshValues.get("COM_BANKSCHEME"))%>";
var varBankncgtcScheme="<%=strBankncgtcScheme%>";
var varstrprdbankscheme="<%=strprdbankscheme%>";
var varagrigoldproduct="<%=Helper.correctNull((String)hshValues.get("agrigoldproduct"))%>";

function callOnLoad() 
{
	if(varBankncgtcScheme=="069" || varBankncgtcScheme=="071")
	{
		document.forms[0].txt_GuarAmount.value=roundVal(varLoanAmount);
	}
	if(varBankScheme=="065"||varBankScheme=="061")
	{
		document.forms[0].txt_GuarAmount.value=roundVal(varLoanAmount);
	}
	//alert(varFacilitysno);
	if(varBankncgtcScheme=="069" || varBankncgtcScheme=="071")
	{
		document.all.id_GuarCovered1.style.visibility = "visible";
		document.all.id_GuarCovered2.style.visibility = "visible";
		document.all.id_GuarCovered3.style.visibility = "visible";
	}
	if(varstrSessionModuleType=="RET")
	{
		if(varMISFlag=="N")
		{	
			alert("Please Fill Appraisal -> Loan Details TAB");
			document.forms[0].hidBeanId.value = "appraisal";
			document.forms[0].hidBeanGetMethod.value = "getloandetails";
			document.forms[0].action = appURL + "action/loandetails.jsp";
			document.forms[0].submit();
		}
	}
	if(varstrSessionModuleType=="CORP"||varstrSessionModuleType=="AGR")
	{
		if((varFacilitysno!="" && varLoanType=="C") || (varFacilitysno!="" && varLoanType=="A"))
		{
			if(varFACCHECK == "N")
			{
				alert("Approve/Reject individual facilities in Workflow -> Proposed Facility Approve/Reject tab");				
				document.forms[0].hidBeanId.value = "commworkflow";
				document.forms[0].hidBeanGetMethod.value = "getTermsofSanctionFacilityData";
				document.forms[0].action = appURL + "action/com_termsofsanction.jsp";
				document.forms[0].submit();
			}
		}
	}
	
	if(varconstitut!="01")
	{
		if(varstake_held!="")
		{
			document.forms[0].sel_heldwomen.value=varstake_held;
		}else{
			document.forms[0].sel_heldwomen.value="S";
		}
		if(varmaj_member!="")
		{
			document.forms[0].sel_majoritymem.value=varmaj_member;
		}else{
			document.forms[0].sel_majoritymem.value="0";
		}
		if(varcommunityminority!="")
		{
			document.forms[0].sel_firm_minority.value=varcommunityminority;
		}
		else
		{
			document.forms[0].sel_firm_minority.value="0";
		}
		if(nonindreligion!="")
		{
			document.forms[0].sel_corp_religion.value=nonindreligion;
		}
		else
		{
			document.forms[0].sel_corp_religion.value="0";
		}
		/*if(varminorityindustry!="")
		{
			document.forms[0].sel_minIndustry.value=varminorityindustry;
		}else{
			document.forms[0].sel_minIndustry.value="0";
		}*/
	
		document.forms[0].sel_majoritymem.disabled=true;
		document.forms[0].sel_heldwomen.disabled=true;
		document.forms[0].sel_firm_minority.disabled=true;
		document.forms[0].sel_corp_religion.disabled=true;
		//document.forms[0].sel_minIndustry.disabled=true;
		document.all.maj3.style.display = "none";
		document.all.maj4.style.display = "none";
		document.all.id_ind.style.display = "none";
	
	}
	else if(varconstitut=="01")
	{
		if(varcaste!="")
		{
			document.forms[0].sel_caste.value=varcaste;
		}else{
			document.forms[0].sel_caste.value="0";
		}
		
		if(vargender!="")
		{
			document.forms[0].sel_applt_sex.value=vargender;
		}else{
			document.forms[0].sel_applt_sex.value="0";
		}
		if(varMinorty!="")
		{
			document.forms[0].sel_minority.value=varMinorty;
		}else{
			document.forms[0].sel_minority.value="";
		}
		
		if(varindreligion!="")
		{
			document.forms[0].sel_religion.value=varindreligion;
		}else{
			document.forms[0].sel_religion.value="0";
		}
		
		document.forms[0].sel_applt_sex.disabled=true;
		document.forms[0].sel_caste.disabled=true;
		document.forms[0].sel_religion.disabled=true;
		document.forms[0].sel_minority.disabled=true;
		document.all.maj1.style.display = "none";
		document.all.maj2.style.display = "none";
		document.all.id_nonind.style.display = "none";
	}	

	if((varFacilitysno=="0" && varLoanType=="C") || (varFacilitysno=="0" && varLoanType=="A") )
	{
		document.forms[0].sel_facilitysno.value="";
	}
	else if((varFacilitysno!="" && varLoanType=="C") || (varFacilitysno!="" && varLoanType=="A"))
	{
		document.forms[0].sel_facilitysno.value=varFacilitysno;
	}
	else if(varLoanType=="C" || varLoanType=="A")
	{
		document.forms[0].sel_facilitysno.value="";
	}
	
	
	disableFields(true);
	setSelValues();
	callRestructure();
	callAssetFinanced();
	callGuarCovered('N');
	callNewProjectFac();
	callIndustryType();
	callKrishiScheme();
	callWhetherTLorDL();
	changeIrrigationCultivationMode();
	showMISClassification();
	setSubActCode(varSubAct);
	callDisplayScreenChange();
	setFarmerCategory();
	callMISClassification();
	callShareBroker();
	checkSvanidhi();
	if(varLoanType=="C" || varLoanType=="A")
	{
		document.forms[0].sel_facilitysno.disabled=false;
	}
	if(varStrSectorCount=="2")
	{
		alert("This Proposal Contains both Priority and Non-Priority Sector classified facilities");
	}
	if(varAuthUser=="Y")
	{
		document.forms[0].cmdedit.disabled=false;
	}
	if(((varLoanType=="C" || varLoanType=="A" || varLoanType=="P") && (varPostSanc=="P")) && (document.forms[0].btnenable.value=="Y"))
	{
		var boolflag=false;
	
		var varPSterms = document.forms[0].hidPostSancParams.value.split("@");
	
		for(var i=0;i<varPSterms.length;i++)
		{
			if(varPSterms[i] == "MIS"||varPSterms[i] == "SLILA")
			{
				boolflag=true;
			}
		}
	
		if(varEditFlag=="N" && document.forms[0].hidPostSancParams.value=="" && document.forms[0].sel_facilitysno.value!="")
		{
			boolflag=true;
		}
		if(boolflag)
		{
			document.forms[0].cmdedit.disabled=false;
		}
		else
		{
			document.forms[0].cmdedit.disabled=true;
		}
	}
	if(varProductType=="pG" && varAgriSchemeFlag=="Y" && varSectorType=="02")
	{
		alert("Agriculture Gold Loan cannot be classified under Non-Priority Sector");
	}

	if(varstrSessionModuleType=="DIGI" && document.forms[0].hidPrdType.value=="pC")
	{
		document.forms[0].cmdedit.disabled=true;
	}
	
	if(varFacilitysno!="")
	{
		document.forms[0].sel_facilitysno.value=varFacilitysno;
	}

	//alert("strBankScheme==="+strBankScheme);
	//alert("varBankncgtcScheme==="+varBankncgtcScheme);
	if(varBankncgtcScheme=="069" || varBankncgtcScheme=="071")
	{
		document.forms[0].sel_GuarCovered.disabled=false;
		document.forms[0].sel_GuarCovered.value="16";
		document.forms[0].txt_GuarAmount.value=roundVal(varLoanAmount);
		document.forms[0].txt_GuarAmount.readOnly=true;
		document.forms[0].sel_GuarCovered.disabled=true;
	}
	if(varstrSessionModuleType=="RET")
	{
		if(varstrprdbankscheme!="")
		{
			document.forms[0].sel_BankScheme.value=varstrprdbankscheme;
		}
	}
}

function checkLoanAmt()
{
	
	if(eval(document.forms[0].txt_GuarAmount.value)>eval(document.forms[0].txt_LoanAmt.value))
	{
		alert("Guarantee Amount should not greater than Loan Amount");
		document.forms[0].txt_GuarAmount.value="";
		document.forms[0].hid_gvtgamt.value="N";
		return;
	}
}

function checkSvanidhi()
{
	if(varBankScheme=="064" &&(varSvanidhiType=="1" || varSvanidhiType=="2" || varSvanidhiType=="3" ))
	{
		varGuar="11";			
		document.forms[0].sel_GuarCovered.value=varGuar;
		document.all.id_GuarCovered1.style.visibility = "visible";
		document.all.id_GuarCovered2.style.visibility = "visible";
		document.all.id_GuarCovered3.style.visibility = "visible";
		document.forms[0].txt_GuarAmount.value=varLoanAmount;			
	}
}

function checkplvalue(){
	if(varplantval != "" && document.forms[0].txt_OrigInvest.value !=""){
		if(document.forms[0].txt_OrigInvest.value != varplantval){
			alert("In one proposal different amount in Investment in Plant & Machineries/Equipments are not allowed for different facilities");
			document.forms[0].txt_OrigInvest.value="";
			document.forms[0].txt_OrigInvest.focus();
			}
	}
	  
}

function checksalesvalue(){
	if(varsalesval != "" && document.forms[0].txt_sales_turnover.value !=""){
		if(document.forms[0].txt_sales_turnover.value != varsalesval){
			alert("In one proposal different amount in Sales Turnover of applicant are not allowed for different facilities");
			document.forms[0].txt_sales_turnover.value="";
			document.forms[0].txt_sales_turnover.focus();
			}
	}
	  
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callOnLoad();">
<form name="misdet" method="post" class="normal">
<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){
if(!strSessionModuleType.equalsIgnoreCase("RET")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="26" />
			<jsp:param name="subpageid" value="110" />
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
			<jsp:param name="pageid" value="8" />
			<jsp:param name="subpageid" value="117" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>

<table width="30%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
	<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="3" align="left" class="outertable">
		<tr align="center">
			<td width="50%" class="sub_tab_active" nowrap="nowrap">MIS Details</td>
			<%//if (strPageParam.contains("@CHBRANCH@")
		//&& (strPageParam.contains("@DLA@")
				//|| strPageParam.contains("@DLP@")
				//|| strPageParam.contains("@MIS@"))) { %>
			<td width="50%" class="sub_tab_inactive">
				<a href="JavaScript:callCBSDetails();" onMouseOut="window.status='';return true;" onMouseOver="window.status='CBSDetails';return true;">CBS Details</a>
			</td>
			<%//} %>
		</tr>
		</table>
	</td>
</tr>
</table>
<%}
}else{ %>
<%if(strSessionModuleType.equalsIgnoreCase("RET")||strSessionModuleType.equalsIgnoreCase("LAD")) 
{%>
	<jsp:include page="../share/Applurllinkper.jsp" flush="true">
	<jsp:param name="pageid" value="11" /></jsp:include>
<%}else if(strSessionModuleType.equalsIgnoreCase("DIGI"))
{%>
	<jsp:include page="../share/applurllinkerdigi.jsp" flush="true">
	<jsp:param name="pageid" value="11" /></jsp:include>
<%}
else
{ %>
	<jsp:include page="../com/proposallinks.jsp" flush="true"> 
            <jsp:param name="pageid" value="26" />
	  <jsp:param name="cattype" value="<%=strCategoryType%>" />
	  <jsp:param name="ssitype" value="<%=strSSIType%>" />		
	</jsp:include> 
<%} %>
 
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("RET")||strSessionModuleType.equalsIgnoreCase("LAD")) 
		{%>
		<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; MIS/CBS Details -&gt; MIS Details</td>
		<%}else if(strSessionModuleType.equalsIgnoreCase("CORP"))  {%>
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Corporate &amp; SME -&gt;&nbsp;Proposal&nbsp;-&gt;&nbsp;MIS/CBS Details -&gt; MIS Details</td>
		<%}else  if(strSessionModuleType.equalsIgnoreCase("AGR"))  {%>
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Agriculture -&gt;&nbsp;Proposal&nbsp;-&gt;&nbsp;MIS/CBS Details -&gt; MIS Details</td>
		<%}else  if(strSessionModuleType.equalsIgnoreCase("DIGI"))  {%>
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Digi Retail -&gt;&nbsp;Proposal&nbsp;-&gt;&nbsp;MIS/CBS Details -&gt; MIS Details</td>
	<%} %>
	</tr>
</table>
<lapschoice:application />
<table width="30%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
	<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="3" align="left" class="outertable">
		<tr align="center">
			<td width="50%" class="sub_tab_active" nowrap="nowrap">MIS Details</td>
			<td width="50%" class="sub_tab_inactive">
				<a href="JavaScript:callCBSDetails();" onMouseOut="window.status='';return true;" onMouseOver="window.status='CBSDetails';return true;">CBS Details</a>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<%} %>
<br>
<table align="center" border="0" cellpadding="3" cellspacing="3" class="outertable" width="98%">
<tr>
	<td>
		<table align="center" border="0" cellpadding="0" cellspacing="0" class="outertable border1" width="98%">
		<tr>
			<td>
				<table align="center" border="0" cellpadding="1" cellspacing="0" class="outertable" width="100%">
				<%if(strLoanType.equalsIgnoreCase("C") || strLoanType.equalsIgnoreCase("A"))
				{ %>
				<tr>
				<td>
				Facility &nbsp; &nbsp;
				<select name="sel_facilitysno" tabindex="1" onchange="callIFrame();">
				<option value="" selected="selected">--Select--</option>
                <lapschoice:ComMisDetailsTag apptype='<%=Helper.correctNull((String)request.getParameter("appno")) %>' page='mis'/>
				</select>
				</td>
				</tr>
				<%}else{ %>
				<input type="hidden" name="sel_facilitysno" value="1">
				<%} %>
				<tr>
					<td class="dataheader">&nbsp;<b>Facility Details</b></td>
				</tr>
				<tr>
					<td>
						<table align="center" border="0" cellpadding="5" cellspacing="5" class="outertable" width="100%">
						<tr>
							<td colspan="2">Bank's Scheme<b><span class="mantatory">&nbsp;*</span></b></td>
							<td colspan="4">
								<select name="sel_BankScheme" style="width: 70%" tabindex="1">
									<option value="" selected="selected">--Select--</option>
                            		<lapschoice:BanksSchemeStaticDataNewTag apptype="1" />
								</select>
							</td>
						</tr>
						<tr>
							<td width="25%">Loan Amount<b><span class="mantatory">&nbsp;*</span></b></td>
							<td width="5%"><%=ApplicationParams.getCurrency()%></td>
							<td width="20%">
								<lapschoice:CurrencyTag name="txt_LoanAmt" tabindex="2" value='<%=Helper.correctDouble((String)hshValues.get("strLoanAmt"))%>' />
							</td>
							<td width="25%">Total Limit of the Borrower<b><span class="mantatory">&nbsp;*</span></b></td>
							<td width="5%"><%=ApplicationParams.getCurrency()%></td>
							<td width="20%">
								<lapschoice:CurrencyTag name="txt_TotLimit" maxlength="15" tabindex="3" value='<%=Helper.correctDouble((String)hshValues.get("app_totlim"))%>' />
							</td>
						</tr>
						<tr>
							<td>Total Limit of the Borrower(Under Service Category)<b><span class="mantatory">&nbsp;*</span></b></td>
							<td><%=ApplicationParams.getCurrency()%></td>
							<td>
								<lapschoice:CurrencyTag name="txt_TotLimitService" maxlength="15" tabindex="4" value='<%=Helper.correctDouble((String)hshValues.get("app_totlimser"))%>' />
							</td>
							<td>Total Limit of the Borrower(Under Agriculture Category)<b><span class="mantatory">&nbsp;*</span></b></td>
							<td><%=ApplicationParams.getCurrency()%></td>
							<td>
								<lapschoice:CurrencyTag name="txt_TotLimitAgri" maxlength="15" tabindex="5" value='<%=Helper.correctDouble((String)hshValues.get("app_totlimagri"))%>' />
							</td>
						</tr>
						<tr>
<!--							<td colspan="2">Whether this facility is by restructuring of any existing accounts<b><span class="mantatory">&nbsp;*</span></b></td>-->
<!--							<td>-->
<!--								<select name="sel_RestructFac" onChange="callRestructure()" tabindex="6">-->
<!--									<option value="" selected="selected">--Select--</option>-->
<!--									<option value="Y">Yes</option>-->
<!--									<option value="N">No</option>-->
<!--								</select>-->
<!--							</td>-->
							<td colspan="3"><input type="hidden" name="sel_RestructFac" value=""></td>
							<td colspan="2">Whether under Service Area Approach</td>
							<td>
								<select name="sel_ServiceArea" tabindex="7">
									<option value="Y">Yes</option>
									<option value="N" selected="selected">No</option>
								</select>
							</td>
						</tr>
						<tr id="id_Restructure1">
							<td colspan="2">Restructured Under<b><span class="mantatory">&nbsp;*</span></b></td>
							<td>
								<select name="sel_RestructUnder" style="width: 80%" tabindex="8">
									<option value="" selected="selected">--Select--</option>
									<lapschoice:BanksSchemeStaticDataNewTag apptype="14" />
								</select>
							</td>
							<td colspan="3">
								Reason for entering into reschedule/rephase<b><span class="mantatory">&nbsp;*</span></b>
							</td>
						</tr>
						<tr id="id_Restructure2">
							<td colspan="2">Settlement Ref. No<b><span class="mantatory">&nbsp;*</span></b></td>
							<td>
								<input type="text" name="txt_SettlementRefNo" maxlength="30" tabindex="9" value="<%=Helper.correctNull((String)hshValues.get("app_settlementno"))%>">
							</td>
							<td colspan="3" rowspan="3"><textarea name="txtarea_Reason" rows="5" cols="60" tabindex="12" onKeyPress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.replaceForJavaScriptString((String)hshValues.get("app_resreason"))%></textarea></td>
						</tr>
						<tr id="id_Restructure3">
							<td colspan="2">Settlement Date<b><span class="mantatory">&nbsp;*</span></b></td>
							<td>
								<input type="text" name="txt_SettlementDate" onblur="checkDate(this);" size="15%" value="<%=Helper.correctNull((String)hshValues.get("app_settlementdate"))%>">
								<a alt="Select date from calender" href="javascript:callCalender('txt_SettlementDate')" tabindex="10">
									<img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0">
								</a>
							</td>
						</tr>
						<tr id="id_Restructure4">
							<td colspan="2">Old Facility ID/Account Number of account to be restructured<b><span class="mantatory">&nbsp;*</span></b></td>
							<td>
								<input type="text" name="txt_OldFacID" value="<%=Helper.correctNull((String)hshValues.get("app_oldfacid"))%>">
								<a href="#" onClick="callApplicationSearch('txt_OldFacID')" style="cursor: hand" tabindex="11">
								<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0"></a>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="dataheader">&nbsp;<b>Utilization of Credit</b></td>
				</tr>
				<tr>
					<td>
						<table align="center" border="0" cellpadding="5" cellspacing="5" class="outertable" width="100%">
						<tr>
							<td width="30%">City<b><span class="mantatory">&nbsp;*</span></b></td>
							<td width="20%">
								<input type="text" name="txt_City" value="<%=Helper.correctNull((String)hshValues.get("strCity"))%>">
								<a href="#" onClick="showCitySearch1('MIS');" style="cursor: hand" tabindex="13">
									<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
								</a>
							</td>
							<td width="30%">State<b><span class="mantatory">&nbsp;*</span></b></td>
							<td width="20%">
								<input type="text" name="txt_State" value="<%=Helper.correctNull((String)hshValues.get("strState"))%>">
							</td>
						</tr>
						<tr>
							<td>District<b><span class="mantatory">&nbsp;*</span></b></td>
							<td>
								<input type="text" name="txt_District" value="<%=Helper.correctNull((String)hshValues.get("strDistrict"))%>">
								<a href="#" onClick="callDistrict();" style="cursor: hand" tabindex="14">
									<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
								</a>
							</td>
							<td>Place<b><span class="mantatory">&nbsp;*</span></b></td>
							<td>
							<select name="sel_Place" tabindex="15">
								<option value="" selected="selected">--Select--</option>
								<lapschoice:StaticDataNewTag apptype="128" />
							</select>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="dataheader">&nbsp;<b>Other Details</b></td>
				</tr>
				<tr>
					<td>
						<table align="center" border="0" cellpadding="5" cellspacing="5" class="outertable" width="100%">
						<tr>
							<td width="30%">Does repayment depend purely on the asset financed<b><span class="mantatory">&nbsp;*</span></b></td>
							<td width="20%">
								<select name="sel_AssetFinanced" onChange="callAssetFinanced();" tabindex="16">
									<option value="" selected="selected">--Select--</option>
									<option value="Y">Yes</option>
									<option value="N">No</option>
								</select>
							</td>
							<td width="30%" id="id_RepaySource1" colspan="2">Source of repayment<b><span class="mantatory">&nbsp;*</span></b></td>
							<td width="20%" id="id_RepaySource2">
								<select name="sel_RepaySource" tabindex="17">
									<option value="" selected="selected">--Select--</option>
									<lapschoice:BanksSchemeStaticDataNewTag apptype="15" />
								</select>
							</td>
						</tr>
						<tr>
							<td>Guarantee Covered by<b><span class="mantatory">&nbsp;*</span></b></td>
							<td>
								<select name="sel_GuarCovered" onChange="callGuarCovered('Y');" style="width: 80%" tabindex="18">
									<option value="" selected="selected">--Select--</option>
									<lapschoice:BanksSchemeStaticDataNewTag apptype="17" />
								</select>
							</td>
							<td id="id_GuarCovered1">Govt. Agency Guaranteed Amount</td>
							<td id="id_GuarCovered2" width="5%"><%=ApplicationParams.getCurrency()%></td>
							<td id="id_GuarCovered3">
								<lapschoice:CurrencyTag name="txt_GuarAmount" maxlength="15" tabindex="19" value='<%=Helper.correctDouble((String)hshValues.get("app_guaranteeamt"))%>'  onBlur="checkLoanAmt();"/>
							</td>
						</tr>
						<tr id="id_FacilityForNew">
							<td>Whether the proposed facility is for New Project<b><span class="mantatory">&nbsp;*</span></b></td>
							<td>
								<select name="sel_NewProjectFac" onChange="callNewProjectFac();" tabindex="20">
									<option value="" selected="selected">--Select--</option>
									<option value="Y">Yes</option>
									<option value="N">No</option>
								</select>
							</td>
							<td id="id_NewProjectFac1" colspan="2">Proposed date of Commencement of Commercial Operation (DCCO)<b><span class="mantatory">&nbsp;*</span></b></td>
							<td id="id_NewProjectFac2">
								<input type="text" name="txt_DCCO" onblur="checkDate(this);" size="15%" value="<%=Helper.correctNull((String)hshValues.get("app_commencementdate"))%>">
								<a alt="Select date from calender" href="javascript:callCalender('txt_DCCO')" tabindex="21">
									<img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0">
								</a>
							</td>
						</tr>
						<tr id="id_sharebroker">
							<td colspan="3" nowrap="nowrap">Whether Guarantee is issued on behalf of share broker and Market maker in favour of stock exchange (or) connected to capital market <b><span class="mantatory">&nbsp;*</span></b></td>
							<td align="left"><select name="sel_sharebroker">
							<option value="0" selected="selected">-- Select --</option>
							<option value="1">Yes</option>
							<option value="2">No</option>
							</select></td>
						</tr>
						
						<tr id="maj1">
							<td>Whether majority of shareholding & controlling stake held by women</td>
              				<td><select name="sel_heldwomen">
		                    <option value="S" selected="selected">--Select--</option>
		                    <option value="Y">Yes</option>
		                    <option value="N">No</option>
		                    </select>
		                    </td>
		                </tr>
					
						 <tr id="maj2">
		                      <td>Whether majority of members belongs to SC/ST</td>
		                      <td><select name="sel_majoritymem">
		                      <option value="0" selected="selected">--Select--</option>
		                      <option value="Y">Yes</option>
		                      <option value="N">No</option>
		                     </select>
		                     </td>	
	                    </tr>
						<tr id="maj3">
							 <td>Gender</td>
			                 <td><select name="sel_applt_sex">
			                    <option value="0">--Select--</option>
			                    <option value="M">Male</option>
			                    <option value="F">Female</option>
			                    <option value="O">Others</option>
			                  </select>
	               			 </td>
						</tr>
						<tr id="maj4">
							<td>Caste/Tribe&nbsp;</td>
		                    <td><select name="sel_caste">
		                          <option value="0">&lt;--Select--&gt;</option>
		                          <%String apptype = "7";%>
		                          <lapschoice:CBSStaticDataNewTag apptype='<%=apptype%>' />
		                        </select>
		                    </td>
						  <tr id="id_nonind">
                      <td >Whether majority of members/owners belong to minority community</td>
                      <td><select name="sel_firm_minority" style="background: #FFFFCC; font-weight: bold;text-align: right;">
                          <option value="0" selected="selected">--Select--</option>
                          <option value="Y">Yes</option>
                          <option value="N">No</option>
                        </select>
                      </td>
                      <td>Religion</td>
                      <td><select name="sel_corp_religion" style="background: #FFFFCC; font-weight: bold;text-align: right;">
                          <option value="0">&lt;--Select--&gt;</option>
                          <%apptype = "11";%>
                          <lapschoice:CBSStaticDataNewTag apptype='<%=apptype%>' />
                        </select>
                      </td>
                    </tr>
                   <!--  <tr  id="id_nonind3">
                     <td width="12%" nowrap="nowrap">Whether start up as per definition of Ministry of commerce and Industry<b><span class="mantatory">*&nbsp;</span></td>
                      <td width="15%"><select name="sel_minIndustry" tabindex="81">
                      <option value="0" >--Select--</option>
                          <option value="Y">Yes</option>
                          <option value="N" selected>No</option>
                        </select></td>
                        </tr> -->
					 <tr id="id_ind">
					   <td>Minority</td>
                      <td ><select name="sel_minority" style="background: #FFFFCC; font-weight: bold;text-align: right;">
                          <option value="Y">Yes</option>
                          <option value="N" selected>No</option>
                        </select></td>
					  
                      <td width="18%">Religion</td>
                      <td width="22%"><select name="sel_religion"  style="background: #FFFFCC; font-weight: bold;text-align: right;">
                          <option value="0">&lt;--Select--&gt;</option>
                          <%apptype = "11";%>
                          <lapschoice:CBSStaticDataNewTag apptype='<%=apptype%>'/>
                        </select></td>
                    
                    </tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="dataheader">&nbsp;<b>Activity / Purpose for which loan is given</b></td>
				</tr>
				<tr>
					<td>
						<table align="center" border="0" cellpadding="5" cellspacing="5" class="outertable" width="100%">
						<tr>
							<td width="30%">Activity Code<b><span class="mantatory">&nbsp;*</span></b></td>
							<td width="70%">
								<input type="text" name="txt_ActivityCode" onKeyPress="notAllowSplChar();" value="<%=Helper.correctNull((String)hshValues.get("app_activitycode"))%>">
								<a href="#" onClick="callMISActvityHelp()" style="cursor: hand">
									<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" tabindex="22">
								</a>
							</td>
						</tr>
						<tr>
							<td>Main Activity</td>
							<td>
								<select name="sel_MainActivity" style="width: 80%">
									<option value="" selected="selected">--Select--</option>
									<lapschoice:MISDataTag apptype="2"/>
								</select>
							</td>
						</tr>
						<tr>
							<td>Sub Activity</td>
							<td>
								<select name="sel_SubActivity" style="width: 80%">
									<option value="" selected="selected">--Select--</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>Purpose</td>
							<td>
								<select name="sel_Purpose" style="width: 80%">
									<option value="" selected="selected">--Select--</option>
									<lapschoice:MISPurposeDataTag apptype="3"/>
								</select>
							</td>
						</tr>
						<tr>
							<td>BSR Code</td>
							<td>
								<select name="sel_BSRCode" style="width: 80%">
									<option value="" selected="selected">--Select--</option>
									<lapschoice:BSRCodeTag apptype="1" />
								</select>
							</td>
						</tr>
						<tr>
							<td>BSR1 Code</td>
							<td>
								<select name="sel_BSR1Code" style="width: 80%">
									<option value="" selected="selected">--Select--</option>
									<lapschoice:MISDataTag apptype="6"/>
								</select>
							</td>
						</tr>
						<tr id="id_IndustryType">
							<td>Industry Type</td>
							<td>
								<select name="sel_IndustryType" style="width: 80%">
									<option value="" selected="selected">--Select--</option>
									<lapschoice:MISDataTag apptype="5"/>
								</select>
							</td>
						</tr>
						<tr>
							<td>Asset Classification</td>
							<td>
								<select name="sel_AssetClassification" style="width: 80%">
									<option value="" selected="selected">--Select--</option>
									<lapschoice:BanksSchemeStaticDataNewTag apptype="16" />
								</select>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
			<jsp:include page="../mis/misdisplayscreen.jsp"  />
			</td>
		</tr>
		<tr id="id_misclassification">
			<td>
				<table align="center" border="0" cellpadding="1" cellspacing="0" class="outertable" width="100%">
				<tr>
					<td class="dataheader">&nbsp;<b>MIS Classification</b></td>
				</tr>
				<tr>
					<td>
						<table align="center" border="0" cellpadding="5" cellspacing="5" class="outertable" width="100%">
						<tr>
							<td width="30%">Agriculture/Industry/Service Category type</td>
							<td width="70%">
								<select name="sel_CategoryType" style="width: 80%">
									<option value="" selected="selected">--Select--</option>
									<lapschoice:BanksSchemeStaticDataNewTag apptype="12" />
								</select>
							</td>
						</tr>
						<tr>
							<td>Sector</td>
							<td>
								<select name="sel_Sector" style="width: 80%">
									<option value="" selected="selected">--Select--</option>
									<option value="01">Priority Sector</option>
									<option value="02">Non Priority Sector</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>Sub sector</td>
							<td>
								<select name="sel_SubSector" style="width: 80%">
									<option value="" selected="selected">--Select--</option>
									<lapschoice:BanksSchemeStaticDataNewTag apptype="7" />
									<lapschoice:BanksSchemeStaticDataNewTag apptype="8" />
								</select>
							</td>
						</tr>
						<tr>
							<td>Sensitive sector</td>
							<td>
								<select name="sel_SensitiveSector" style="width: 80%">
									<option value="0" selected="selected">--Select--</option>
									<lapschoice:BanksSchemeStaticDataNewTag apptype="11" />
								</select>
							</td>
						</tr>
						<tr>
							<td>Weaker Section</td>
							<td>
								<select name="sel_WeakerSection" style="width: 80%">
									<option value="" selected="selected">--Select--</option>
									<lapschoice:BanksSchemeStaticDataNewTag apptype="9" />
								</select>
							</td>
						</tr>
						<tr>
							<td>Twenty Point Program</td>
							<td>
								<select name="sel_TwentyPointPgm" style="width: 80%">
									<option value="" selected="selected">--Select--</option>
									<lapschoice:BanksSchemeStaticDataNewTag apptype="10" />
								</select>
							</td>
						</tr>
						<tr>
							<td>Infrastructure Credit Type</td>
							<td>
								<select name="sel_InfraCreditType" style="width: 80%">
									<option value="" selected="selected">--Select--</option>
									<lapschoice:BanksSchemeStaticDataNewTag apptype="22" />
								</select>
							</td>
						</tr>
						<tr>
							<td>Government announced scheme</td>
							<td>
								<select name="sel_GovtAnnounceScheme" style="width: 80%">
									<option value="" selected="selected">--Select--</option>
									<lapschoice:BanksSchemeStaticDataNewTag apptype="23" />
								</select>
							</td>
						</tr>
						<tr>
							<td>Stand Up India</td>
							<td>
								<select name="sel_StandupIndia" style="width: 80%">
									<option value="" selected="selected">--Select--</option>
									<option value="Y">Yes</option>
									<option value="N">No</option>
								</select>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<%if(!Helper.correctNull((String)hshValues.get("msme_reclassif_date")).equalsIgnoreCase("")){ %>
				<tr>
				<td><span class="mantatory">MSME Existing proposals reclassification done with effect from <%=Helper.correctNull((String)hshValues.get("msme_reclassif_date")) %> and verified on  <%=Helper.correctNull((String)hshValues.get("msme_reclassif_verifiedon")) %></span></td>
				</tr>
				<%} %>
				</table>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br>
<iframe height="0" width="0" id="ifrm" frameborder="0" style="border: 0"></iframe>
<iframe height="0" width="0" id="ifrm1" frameborder="0" style="border: 0"></iframe>
<input type="hidden" name="hidSlNo" value="<%=Helper.correctNull((String)hshValues.get("app_activitysno"))%>">
<input type="hidden" name="hid_District" value="<%=Helper.correctNull((String)hshValues.get("app_district"))%>">
<input type="hidden" name="sel_DisplayScreen" value="<%=Helper.correctNull((String)hshValues.get("app_dispscreen"))%>">
<input type="hidden" name="hid_City" value="<%=Helper.correctNull((String)hshValues.get("app_city"))%>">
<input type="hidden" name="hid_State" value="<%=Helper.correctNull((String)hshValues.get("app_state"))%>">
<input type="hidden" name="hidPageFrom" value="MIS">
<input type="hidden" name="hidPrdType" value="<%=Helper.correctNull((String)hshValues.get("strPrdType"))%>">
<input type="hidden" name="Applicationno" value="<%=Helper.correctNull((String)hshValues.get("strAppNo"))%>">
<input type="hidden" name="hid_FarmCat" value="">
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<iframe height="0" width="0" id="ifrmpropFac" frameborder=0 style="border: 0"></iframe>
<input type="hidden" name="hidappno" value="<%=Helper.correctNull((String)hshValues.get("appno")) %>">
<input type="hidden" name="hidapplno" value="<%=Helper.correctNull((String)request.getParameter("appno")) %>">
<input type="hidden" name="hidCorpProdCode" value="<%=Helper.correctInt((String)hshValues.get("CorpProductCode"))%>">
<input type="hidden" name="hidLoanType" value="<%=strLoanType%>">
<input type="hidden" name="sel_busruleid">
<input type="hidden" name="hidFacSno" value="<%=Helper.correctNull((String)hshValues.get("strFacilitySno"))%>">
<input type="hidden" name="hidPostSancParams" value="<%=Helper.correctNull((String)hshValues.get("strPostSancParam"))%>">
<input type="hidden" name="hidmisdataflag" value="<%=Helper.correctNull((String)hshValues.get("app_MISdataflag"))%>">
<input type="hidden" name="hid_prd_cgtmse" value="<%=PRD_CGTMSE%>">
<input type="hidden" name="hid_gvtgamt" value="Y">
<input type="hidden" name="app_totlimser" value="<%=Helper.correctNull((String)hshValues.get("app_totlimser"))%>">
<input type="hidden" name="app_totlimagri" value="<%=Helper.correctNull((String)hshValues.get("app_totlimagri"))%>">
<input type="hidden" name="hidconstitution" value="<%=Helper.correctNull((String)hshValues.get("constitutionnew"))%>">
<input type="hidden" name="hidmajority_member" value="<%=Helper.correctNull((String)hshValues.get("majority_member"))%>">
<input type="hidden" name="hidstake_held" value="<%=Helper.correctNull((String)hshValues.get("stake_held"))%>">
<input type="hidden" name="hidcaste" value="<%=Helper.correctNull((String)hshValues.get("indinfo_caste"))%>">
<input type="hidden" name="hidgender" value="<%=Helper.correctNull((String)hshValues.get("perapp_sex"))%>">
<!-- <input type="hidden" name="hidMinorityIndustry" value="<//%=Helper.correctNull((String)hshValues.get("PERAPP_MINORITYINDUSTRY"))%>"> -->

</form>
</body>
</html>