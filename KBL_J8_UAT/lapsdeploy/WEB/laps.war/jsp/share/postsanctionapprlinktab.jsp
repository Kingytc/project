<%@ page import="com.sai.laps.helper.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%int tabid = Integer.parseInt(Helper.correctInt((String)request.getParameter("tabid")));
			String prdtype = Helper.correctNull((String) session
					.getAttribute("strProductType"));
			
			String strPageParam = Helper.correctNull(
					(String) session.getAttribute("strModifyterms")).trim();
			String strSchemeCode = Helper.correctNull((String) session
					.getAttribute("schemeCode"));
			String prd_type = Helper.correctNull((String) session
					.getAttribute("strProductType"));
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
if(tabname=="apptermsandcond.jsp")
	{
	//document.forms[0].hidBeanId.value="apptermscond";		
	//document.forms[0].hidBeanGetMethod.value="getTerms";
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
			<%if(!(prd_type.equalsIgnoreCase("pR")||prd_type.equalsIgnoreCase("pG")||prd_type.equalsIgnoreCase("pE"))
					&& !(strSchemeCode.equalsIgnoreCase("OD"))){ %>
			<%if (tabid == 16) {
			%>
				<td class="sub_tab_active" nowrap="nowrap">Assessment-R/C</td>
				<%}  else { %>
				<td class="sub_tab_inactive" nowrap="nowrap"> <a
					href="JavaScript:gotoLinkTab('per_assessment_repayment_capacity.jsp')" alt=""
					onMouseOut="window.status='';return true;"
					onMouseOver="window.status='Assessment-R/C';return true;"
					>Assessment-R/C</a> </td>
				<%} }
			if (tabid == 117) {
				%>
					<td class="sub_tab_active" nowrap="nowrap">Comments on Assessment</td>
					<%}  else { %>
					<td class="sub_tab_inactive" nowrap="nowrap"> <a
						href="JavaScript:gotoLinkTab('com_Rbicomments.jsp')" alt=""
						onMouseOut="window.status='';return true;"
						onMouseOver="window.status='Comments on Assessment';return true;"
						>Comments on Assessment</a> </td>
					<%}%>
			<%if (tabid == 1) {
			%>
				<td class="sub_tab_active" nowrap="nowrap">Loan Details</td>
				<%} else {%>
				<td class="sub_tab_inactive" nowrap="nowrap"> <a
					href="JavaScript:gotoLinkTab('loandetails.jsp')" alt=""
					onMouseOut="window.status='';return true;"
					onMouseOver="window.status='Loan Details';return true;"
					>Loan Details</a> </td>
				<%}%>

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
				
				<%if (tabid == 101){ %>
				<td class="sub_tab_active" nowrap="nowrap">Proposal Flow</td>
				<%} else {%>
				<td class="sub_tab_inactive" nowrap="nowrap"> <a
					href="JavaScript:gotoLinkTab('com_delegation.jsp')" alt=""
					onMouseOut="window.status='';return true;"
					onMouseOver="window.status='Proposal_Flow';return true;"
					> Proposal Flow</a> </td>
				
				<%}if(false){ %>
				<%if (tabid == 105){%>
				<td class="sub_tab_active" nowrap="nowrap">Key Fact Statement</td>
				<%} else {%>
				<td class="sub_tab_inactive" nowrap="nowrap"> <a
					href="JavaScript:gotoLinkTab('com_keyfactstatement.jsp')" alt=""
					onMouseOut="window.status='';return true;"
					onMouseOver="window.status='Proposal_Flow';return true;"> Key Fact Statement</a> </td>
				<%} %>
				<%}%>

			</tr>
			<%//} %>
		</table>
		</td>
	</tr>

</table>
