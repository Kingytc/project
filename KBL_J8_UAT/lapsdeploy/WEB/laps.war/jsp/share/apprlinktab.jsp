<%@include file="../share/directives.jsp"%>
<%@ page import="com.sai.laps.helper.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%int tabid = Integer.parseInt(Helper.correctInt((String)request.getParameter("tabid")));
			String strSponsor = Helper.correctNull((String) session.getAttribute("loan_govt"));
			String prdtype = Helper.correctNull((String) session
					.getAttribute("strProductType"));
			String schemeCode = Helper.correctNull((String) session
					.getAttribute("schemeCode"));
			String strApplevel = Helper.correctNull((String) request
					.getParameter("applevel"));
			String strRepayType=Helper.correctNull((String) request
					.getParameter("hidRepayType"));
			String Employmentstatus=Helper.correctNull((String) session
					.getAttribute("perapp_employment"));
			String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String str=Helper.correctNull((String)hshValues.get("prd_purpose"));
String prd_purpose=Helper.correctNull((String) session
		.getAttribute("prd_purpose"));
String PRD_STAFFPRD=Helper.correctNull((String)  session
		.getAttribute("PRD_STAFFPRD"));
String APP_LOANSUBTYPE_DIGI=Helper.correctNull((String)  session
		.getAttribute("APP_LOANSUBTYPE_DIGI"));
String retrestructureval=Helper.correctNull((String)  session
		.getAttribute("retrestructureval"));
String strloantype	=Helper.correctNull((String)session.getAttribute("strAppType"));
%>

<HTML>
<HEAD>
<TITLE>Appraisal link tab</TITLE>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript">
var varProdType="<%=prdtype%>";
function gotoLinkTab(tabname)
{	

	if(document.forms[0].cmdsave.disabled == false)
	{
		ShowAlert(103);
		return;
	}
if(tabname=="loandetails.jsp")
	{
	document.forms[0].hidBeanGetMethod.value="getloandetails";
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+tabname;	
	document.forms[0].submit();
	}	
if(tabname=="incomeexpenses.jsp")
	{	
	//document.forms[0].chk_apptype.value="0";
	//document.forms[0].hid_pagename.value="0";	
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].hidBeanGetMethod.value="getAppraisalData";		
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+tabname;	
	document.forms[0].submit();
	}
	
if(tabname=="experienceservices.jsp")
	{
	//document.forms[0].hid_pagename.value="ES";	
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].hidBeanGetMethod.value="getAppraisalData";		
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+tabname;	
	document.forms[0].submit();
	}
if(tabname=="confidentialopinion.jsp")
	{
	//document.forms[0].hid_pagename.value="CO";		
	document.forms[0].hidBeanId.value="appraisal";		
	document.forms[0].hidBeanGetMethod.value="getAppraisalData";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+tabname;	
	document.forms[0].submit();
	}	
if(tabname=="apptermsandcond.jsp")
	{
	document.forms[0].hidBeanId.value="apptermscond";		
	document.forms[0].hidBeanGetMethod.value="getTerms";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+tabname;	
	document.forms[0].submit();
	}	
	
if(tabname=="appraisalconfirm.jsp")
	{
	document.forms[0].hidBeanId.value="appraisal";		
	document.forms[0].hidBeanGetMethod.value="getDataQuestParameters";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+tabname;
	document.forms[0].submit();
	}

if(tabname=="appraisalconfirmgovt.jsp")
	{
	document.forms[0].hidBeanId.value="govtsponschklist";		
	document.forms[0].hidBeanGetMethod.value="getgovtQuestParameters";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+"appraisalconfirmgovt.jsp";
	document.forms[0].submit();
	}		
	
if(tabname=="recommenauthority.jsp")
	{
	//document.forms[0].hid_pagename.value="RA";		
	document.forms[0].hidBeanId.value="appraisal";		
	document.forms[0].hidBeanGetMethod.value="getAppraisalData";
	
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+tabname;
	document.forms[0].submit();
	}
	
if(tabname=="presanctionvisit.jsp")
	{
	document.forms[0].hidBeanId.value="Inspection";		
	document.forms[0].hidBeanGetMethod.value="getPDCCharges";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+tabname;
	document.forms[0].submit();
	}

if(tabname=="due_report.jsp")
	{
	document.forms[0].hidBeanId.value="documentsupport";		
	document.forms[0].hidBeanGetMethod.value="getdueReport";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+tabname;
	document.forms[0].submit();
	}
if(tabname=="creditreport1.jsp")
	{
	document.forms[0].hidBeanId.value="lapsReport";		
	document.forms[0].hidBeanGetMethod.value="getCreditreportforRetail";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+tabname;
	document.forms[0].submit();
	}
if(tabname=="facilityrecmdforsanc.jsp")
	{
	document.forms[0].hidBeanId.value="inwardRegister";		
	document.forms[0].hidBeanGetMethod.value="getbrrecmdfacility";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+tabname;
	document.forms[0].submit();
	}	
if(tabname=="per_common_assessment.jsp")
	{
	document.forms[0].hidBeanGetMethod.value="getCommonAssessment";
	document.forms[0].hidBeanId.value="retailassessment";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+tabname;	
	document.forms[0].submit();
	}	
if(tabname=="per_assessment_repayment_capacity.jsp")
	{
	document.forms[0].hidBeanGetMethod.value="getRepaymentCapacity";
	document.forms[0].hidBeanId.value="retailassessment";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+tabname;	
	document.forms[0].submit();
	}
  if(tabname=="com_Rbicomments.jsp")
  {
    document.forms[0].hidBeanGetMethod.value="getcom_Rbicommentsdata";
	document.forms[0].hidBeanId.value="compro";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+tabname;	
	document.forms[0].submit();
  }
  if(tabname=="com_delegation.jsp")
  {
    document.forms[0].hidBeanGetMethod.value="getDelegationData";
	document.forms[0].hidBeanId.value="executive";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+tabname;	
	document.forms[0].submit();
  }
  if(tabname=="com_keyfactstatement.jsp")
  {
    document.forms[0].hidBeanGetMethod.value="getKeyFactFeesdata";
	document.forms[0].hidBeanId.value="documentresults";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+tabname;	
	document.forms[0].submit();
  }
  if(tabname=="per_bir.jsp")
  {
    document.forms[0].hidBeanGetMethod.value="getBIRData";
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+tabname;	
	document.forms[0].submit();
  }
  if(tabname=="app_creditsales.jsp")
  {
    document.forms[0].hidBeanGetMethod.value="getCreditSalesData";
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+tabname;	
	document.forms[0].submit();
  }
  if(tabname=="app_restructure_assessment.jsp")
  {
    document.forms[0].hidBeanGetMethod.value="getRestruceAssessment";
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+tabname;	
	document.forms[0].submit();
  }
}
function menuOptionDivMouseDown (url) 
{
	if(document.forms[0].cmdapply.disabled == true)
	{
		document.currentMenu.style.display='none';
		document.currentMBarOpt.style.border='1px solid lightgrey';
		document.menuIsActive = false;
		document.forms[0].action=url;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">

<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="3"
			align="left" class="outertable">
			<tr align="center">
			
				<%if (!(prdtype.equalsIgnoreCase("pP") || prdtype.equalsIgnoreCase("pC") || prdtype.equalsIgnoreCase("pN")|| prdtype.equalsIgnoreCase("pJ"))){
				if (tabid == 15) {
			%>
				<td class="sub_tab_active" nowrap="nowrap">Assessment-Cost</td>
				<%} else {%>
				<td class="sub_tab_inactive" nowrap="nowrap"> <a
					href="JavaScript:gotoLinkTab('per_common_assessment.jsp')" alt=""
					onMouseOut="window.status='';return true;"
					onMouseOver="window.status='Assessment-Cost';return true;"
					>Assessment-Cost</a> </td>
				<%}}else if((prdtype.equalsIgnoreCase("pP"))&&
						(Employmentstatus.equalsIgnoreCase("1")|| Employmentstatus.equalsIgnoreCase("9"))){
					if (tabid == 15) {
				%>
				<td class="sub_tab_active" nowrap="nowrap">Assessment-Cost</td>
				<%} else {%>
				<td class="sub_tab_inactive" nowrap="nowrap"> <a
					href="JavaScript:gotoLinkTab('per_common_assessment.jsp')" alt=""
					onMouseOut="window.status='';return true;"
					onMouseOver="window.status='Assessment-Cost';return true;"
					>Assessment-Cost</a> </td>
			<%}}%>
	
		
			<%
if(!(prdtype.equalsIgnoreCase("pR")||prdtype.equalsIgnoreCase("pV")) && !((prdtype.equalsIgnoreCase("pM")||prdtype.equalsIgnoreCase("pI")||prdtype.equalsIgnoreCase("pB")) && schemeCode.equalsIgnoreCase("OD")))
{
if((!(strRepayType.equalsIgnoreCase("1")) && !strRepayType.equalsIgnoreCase("") && !prdtype.equalsIgnoreCase("pG")) || (prdtype.equalsIgnoreCase("pG") &&strRepayType.equalsIgnoreCase("14") ))
{
	if(tabid==50)
	{
	%>
	<td class="sub_tab_active" WIDTH="12%" nowrap="nowrap"><b>Repayment Schedule</b></td>
	<%
	}
	else
	{
	%>
	<td class="sub_tab_inactive" WIDTH="12%" nowrap="nowrap">
	<a href="javascript:gotoPage('per_RepaymentSchedulenonemi.jsp')" onMouseOut="window.status='';return true;" 
			onMouseOver="window.status='Workflow';return true;"><b>Repayment Schedule</b></a></td>
	<%
	}	
	
	%>
	
	
<%}}%>
<%if(true){ 
	if(tabid==52)
	{
	%>
	<td class="sub_tab_active" WIDTH="12%" nowrap="nowrap"><b>Terms of Repayment</b></td>
	<%
	}
	else
	{
	%>
	<td class="sub_tab_inactive" WIDTH="12%" nowrap="nowrap">
	<a href="javascript:gotoPage('com_repaycomment.jsp')"><b>Terms of Repayment</b></a></td>
	<%
	}} %>
	
	<% if(!strSessionModuleType.equalsIgnoreCase("DIGI")) { %>	
			<%if (!(prdtype.equalsIgnoreCase("pU")||prdtype.equalsIgnoreCase("pR") || prdtype
					.equalsIgnoreCase("pG") || prdtype.equalsIgnoreCase("pE")|| prdtype.equalsIgnoreCase("pL")|| prdtype.equalsIgnoreCase("pM")|| prdtype.equalsIgnoreCase("pV")|| prdtype.equalsIgnoreCase("pB")))
			{
				if(prdtype.equalsIgnoreCase("pI")||prdtype.equalsIgnoreCase("pJ")) {
					if(strRepayType.equalsIgnoreCase("1")) {
			if (tabid == 16) {
			%>
				<td class="sub_tab_active" nowrap="nowrap">Assessment-R/C</td>
				<%}  else { %>
				<td class="sub_tab_inactive" nowrap="nowrap"> <a
					href="JavaScript:gotoLinkTab('per_assessment_repayment_capacity.jsp')" alt=""
					onMouseOut="window.status='';return true;"
					onMouseOver="window.status='Assessment-R/C';return true;"
					>Assessment-R/C</a> </td>
				<%} } } else { if (tabid == 16) {
				
			%>
				<td class="sub_tab_active" nowrap="nowrap">Assessment-R/C</td>
				<%}  else { %>
				<td class="sub_tab_inactive" nowrap="nowrap"> <a
					href="JavaScript:gotoLinkTab('per_assessment_repayment_capacity.jsp')" alt=""
					onMouseOut="window.status='';return true;"
					onMouseOver="window.status='Assessment-R/C';return true;"
					>Assessment-R/C</a> </td>
					<%}} }else if(prdtype.equalsIgnoreCase("pM")) {
				if(!schemeCode.equalsIgnoreCase("OD")) { 
				if (tabid == 16) {
			%>
				<td class="sub_tab_active" nowrap="nowrap">Assessment-R/C</td>
				<%}  else { %>
				<td class="sub_tab_inactive" nowrap="nowrap"> <a
					href="JavaScript:gotoLinkTab('per_assessment_repayment_capacity.jsp')" alt=""
					onMouseOut="window.status='';return true;"
					onMouseOver="window.status='Assessment-R/C';return true;"
					>Assessment-R/C</a> </td>
				<%} }
				}%>
			<% if(retrestructureval.equalsIgnoreCase("Y")){
			if ( tabid ==216) {%>
			<td class="sub_tab_active" nowrap="nowrap">Eligibility under Restructure</td>
			<%} else {%>
			<td class="sub_tab_inactive" nowrap="nowrap"> <a
				href="JavaScript:gotoLinkTab('app_restructure_assessment.jsp')"
				onMouseOut="window.status='';return true;"
				onMouseOver="window.status='ELIGIBLITY UNDER RESOLUTION FRAMEWOR';return true;"
				>Eligibility under resolution framework</a> </td>
			<%}}%>
			<% if (tabid == 117){ %>
				<td class="sub_tab_active" nowrap="nowrap">Comments on Assessment</td>
				<%} else {%>
				<td class="sub_tab_inactive" nowrap="nowrap"> <a
					href="JavaScript:gotoLinkTab('com_Rbicomments.jsp')" alt=""
					onMouseOut="window.status='';return true;"
					onMouseOver="window.status='Assessment-R/C';return true;"
					> Comments on Assessment</a> </td>
				
				<%} %>
				
		<%}else{ 	
			if(prdtype.equalsIgnoreCase("pB")){
		if (tabid == 117){ %>
				<td class="sub_tab_active" nowrap="nowrap">Comments on Assessment</td>
				<%} else {%>
				<td class="sub_tab_inactive" nowrap="nowrap"> <a
					href="JavaScript:gotoLinkTab('com_Rbicomments.jsp')" alt=""
					onMouseOut="window.status='';return true;"
					onMouseOver="window.status='Assessment-R/C';return true;"
					> Comments on Assessment</a> </td>
				
				<%}}} %>
				
				<%if (tabid == 1) {

			%>
				<td class="sub_tab_active" nowrap="nowrap" width="10%">Loan Details</td>
				<%} else {%>
				<td class="sub_tab_inactive" nowrap="nowrap"  width="10%"> <a
					href="JavaScript:gotoLinkTab('loandetails.jsp')" alt=""
					onMouseOut="window.status='';return true;"
					onMouseOver="window.status='Loan Details';return true;"
					>Loan Details</a> </td>
				<%}%>
			
			<% if(!strSessionModuleType.equalsIgnoreCase("DIGI")) { %>
				
				<%if (!(prdtype.equalsIgnoreCase("pR") || prdtype
					.equalsIgnoreCase("pG"))) {

				%>

				<%if (tabid == 2) {

				%>
				<td class="sub_tab_active" nowrap="nowrap">Comments</td>
				<%} else {%>
				<td class="sub_tab_inactive" nowrap="nowrap"> <a
					href="JavaScript:gotoLinkTab('incomeexpenses.jsp')"
					onMouseOut="window.status='';return true;"
					onMouseOver="window.status='Comments';return true;"
					>Comments</a> </td>
				<%}%>

				<%}

			%>
			<%} else { %>
				
				<%if (prdtype.equalsIgnoreCase("pB")) {
					if(!schemeCode.equalsIgnoreCase("OD")){
				%>

				<%if (tabid == 2) {

				%>
				<td class="sub_tab_active" nowrap="nowrap">Comments</td>
				<%} else {%>
				<td class="sub_tab_inactive" nowrap="nowrap"> <a
					href="JavaScript:gotoLinkTab('incomeexpenses.jsp')"
					onMouseOut="window.status='';return true;"
					onMouseOver="window.status='Comments';return true;"
					>Comments</a> </td>
				<%}%>

				<%}
			}}
			%>
			
				<%if (tabid == 5) {

			%>
				<td width="17%" class="sub_tab_active" nowrap="nowrap">Terms and Conditions</td>
				<%} else {%>
				<td width="17%" class="sub_tab_inactive"> <a
					href="JavaScript:gotoLinkTab('apptermsandcond.jsp')"
					onMouseOut="window.status='';return true;"
					onMouseOver="window.status='Terms and Conditions';return true;"
					>Terms and Conditions</a> </td>
				<%}%>
		 
		 <% if(!strSessionModuleType.equalsIgnoreCase("DIGI")) { %>

				<%if (tabid == 7) {

			%>
				<td class="sub_tab_active" nowrap="nowrap">Check List</td>
				<%} else {%>
				<td class="sub_tab_inactive"  nowrap="nowrap"> <a
					href="JavaScript:gotoLinkTab('appraisalconfirm.jsp')"
					onMouseOut="window.status='';return true;"
					onMouseOver="window.status='Check List';return true;"
					>Check List</a> </td>
				<%}%>
				<%if (strSponsor.equalsIgnoreCase("1")) {
				if (tabid == 8) {

				%>
				<td class="sub_tab_active" nowrap="nowrap">Sponsor Check List</td>
				<%} else {%>
				<td class="sub_tab_inactive" nowrap="nowrap"> <a
					href="JavaScript:gotoLinkTab('appraisalconfirmgovt.jsp')"
					onMouseOut="window.status='';return true;"
					onMouseOver="window.status='Sponsor Check List';return true;"
					>Sponsor Check List</a> </td>
				<%}
			}

			%>
			
			<%} else {
			if (prdtype.equalsIgnoreCase("pB")|| prdtype.equalsIgnoreCase("pM")) {
						if (tabid == 7) {
					%>
			<td class="sub_tab_active" nowrap="nowrap">Check List</td>
				<%} else {%>
				<td class="sub_tab_inactive"  nowrap="nowrap"> <a
					href="JavaScript:gotoLinkTab('appraisalconfirm.jsp')"
					onMouseOut="window.status='';return true;"
					onMouseOver="window.status='Check List';return true;"
					>Check List</a> </td>
				<%}%>
			<%}
			}
			%>
			
</tr></table></td></tr>
				<tr><td>
				<table width="45%" border="0" cellspacing="1" cellpadding="3"
			align="left" class="outertable">
				<tr align="center">
			
			 <% if(!strSessionModuleType.equalsIgnoreCase("DIGI")) { %>
			
				<% if(false && !prdtype.equals("pR")&& !prdtype.equals("pG")){if ( tabid == 9) {

			%>
				<td class="sub_tab_active" nowrap="nowrap"> Pre Sanction Report</td>
				<%} else {%>
				<td class="sub_tab_inactive" nowrap="nowrap"> <a
					href="JavaScript:gotoLinkTab('presanctionvisit.jsp')"
					onMouseOut="window.status='';return true;"
					onMouseOver="window.status='Pre Sanction Report';return true;"
					>Pre Sanction Report</a> </td>
				<%}}%>
			<%} %>
				
				<%if(!prdtype.equals("pR")&& !prdtype.equals("pG")){ if(tabid == 10) {

			%>
				<td class="sub_tab_active" nowrap="nowrap"> Due Diligence Report</td>
				<%} else {%>
				<td class="sub_tab_inactive" nowrap="nowrap"> <a
					href="JavaScript:gotoLinkTab('due_report.jsp')"
					onMouseOut="window.status='';return true;"
					onMouseOver="window.status='Duediligence Report';return true;"
					>Due Diligence Report</a> </td>
				<%}}%>
				<%if(false && !prdtype.equals("pR")&& !prdtype.equals("pG")){if (tabid == 11) {

			%>
				<td class="sub_tab_active" nowrap="nowrap"> Credit Report</td>
				<%} else {%>
				<td class="sub_tab_inactive" nowrap="nowrap"> <a
					href="JavaScript:gotoLinkTab('creditreport1.jsp')"
					onMouseOut="window.status='';return true;"
					onMouseOver="window.status='Credit Information Report';return true;"
					>Credit Report</a> </td>
				<%}}%>
		
		 <% if(!strSessionModuleType.equalsIgnoreCase("DIGI")) { %>
		
				<%if (strApplevel.equals("S") && (tabid == 12)) {

			%>
				<td class="sub_tab_active" nowrap="nowrap">Recommendations</td>
				<%} else if (strApplevel.equals("S")) {%>
				<td class="sub_tab_inactive" nowrap="nowrap"> <a
					href="JavaScript:gotoLinkTab('facilityrecmdforsanc.jsp')"
					);
		 			onMouseOut="window.status='';return true;"
					onMouseOver="window.status='Credit Information Report';return true;"
					>Recommendations</a> </td>
				<%} }
				if (tabid == 101){ %>
				<td class="sub_tab_active" nowrap="nowrap">Proposal Flow</td>
				<%} else {%>
				<td class="sub_tab_inactive" nowrap="nowrap"> <a
					href="JavaScript:gotoLinkTab('com_delegation.jsp')" alt=""
					onMouseOut="window.status='';return true;"
					onMouseOver="window.status='Proposal_Flow';return true;"
					> Proposal Flow</a> </td>
				
				<%}if (tabid == 102){ %>
				<td class="sub_tab_active" nowrap="nowrap">Background Information Report(BIR)</td>
				<%} else {%>
				<td class="sub_tab_inactive" nowrap="nowrap"> <a
					href="JavaScript:gotoLinkTab('per_bir.jsp')" alt=""
					onMouseOut="window.status='';return true;"
					onMouseOver="window.status='Proposal_Flow';return true;"> Background Information Report(BIR)</a> </td>
				
				<%}if(Helper.correctNull((String) request.getParameter("appstatus")).equalsIgnoreCase("Processed/Approved")){ %>
				<%if (tabid == 105){%>
				<td class="sub_tab_active" nowrap="nowrap">Key Fact Statement</td>
				<%} else {%>
				<td class="sub_tab_inactive" nowrap="nowrap"> <a
					href="JavaScript:gotoLinkTab('com_keyfactstatement.jsp')" alt=""
					onMouseOut="window.status='';return true;"
					onMouseOver="window.status='Proposal_Flow';return true;"> Key Fact Statement</a> </td>
				<%} %>
				<%}%>

<% if(!APP_LOANSUBTYPE_DIGI.equalsIgnoreCase("PR")) {%>
			
				<%if((prdtype.equalsIgnoreCase("pH"))|| (prdtype.equalsIgnoreCase("pA")&& (prd_purpose.equalsIgnoreCase("N")||prd_purpose.equalsIgnoreCase("U")))){

			%>
			<%if(strloantype.equalsIgnoreCase("F")||strloantype.equalsIgnoreCase("R")){ %>
					<%if ( tabid ==215) {%>
				<td class="sub_tab_active" nowrap="nowrap">Reason For Manual Processing</td>
				<%} else {%>
				<td class="sub_tab_inactive" nowrap="nowrap"> <a
					href="JavaScript:gotoLinkTab('app_creditsales.jsp')"
					onMouseOut="window.status='';return true;"
					onMouseOver="window.status='Reason For Manual Processing';return true;"
					>Reason For Manual Processing</a> </td>
				<%}%>
			<%} }}%>
				
			
			</tr>
			<%//} %>
		</table>
		</td>
	</tr>

</table>
