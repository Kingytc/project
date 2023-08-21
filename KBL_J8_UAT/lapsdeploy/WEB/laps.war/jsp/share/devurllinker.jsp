<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.sai.laps.helper.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%
	int pageid = Integer.parseInt(request.getParameter("pageid"));
	String grpRights = Helper.correctNull((String) session.getAttribute("strGroupRights"));
	String strDEV_SUBTYPE = Helper.correctNull((String)  session.getAttribute("DEV_SUB_TYPE"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Permission Module Navigation</title>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript">
var pageid=parseInt("<%=pageid%>");

function gotoPage(pagename)
{	
	
	if(document.forms[0].cmdsave.disabled == false)
	{
		ShowAlert(103);
		return;
	}
	<%if(!strDEV_SUBTYPE.equalsIgnoreCase("7")){%>
		if(document.forms[0].cmdfreeze){
			if(document.forms[0].cmdfreeze.disabled == false)
			{
				alert("Kindly click on freeze button");
				return;
			}
		}
	<%}%>
	if(pagename=="perm_docAttachment.jsp")
	{	
		document.forms[0].hidBeanId.value="perDeviation";
		document.forms[0].hidBeanGetMethod.value="getpermDocumentDetails";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename;
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="permission_gist.jsp")
	{
		document.forms[0].hidBeanId.value="perDeviation";
		document.forms[0].hidBeanGetMethod.value="getPermissionGistData";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename;
		document.forms[0].target="mainFrame";
		document.forms[0].submit()
	}
	else if(pagename=="appqueryhome.jsp")
	{
		document.forms[0].hidBeanId.value="documentsupport";
		document.forms[0].hidBeanGetMethod.value="getQueryData";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename;
		document.forms[0].target="mainFrame";
		document.forms[0].submit()
	}
	else if(pagename=="Perm_TermsandConditions.jsp")
	{
		document.forms[0].hidBeanId.value="perDeviation";
		document.forms[0].hidBeanGetMethod.value="getTerms";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename;
		document.forms[0].target="mainFrame";
		document.forms[0].submit()
	}
	else if(pagename=="permworkflowhistory.jsp")
	{
		document.forms[0].hidBeanId.value="perDeviation";
		document.forms[0].hidBeanGetMethod.value="getHistory";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename;
		document.forms[0].target="mainFrame";
		document.forms[0].submit()
	}
	else if(pagename=="perm_basicinformation.jsp")
	{
		document.forms[0].hidBeanId.value="perDeviation";
		document.forms[0].hidBeanGetMethod.value="getBasicInformation";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename;
		document.forms[0].target="mainFrame";
		document.forms[0].submit()
	}
	else if(pagename=="perm_proposalflow.jsp")
	{
		document.forms[0].hidBeanId.value="perDeviation";
		document.forms[0].hidBeanGetMethod.value="getProposalflow";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename;
		document.forms[0].target="mainFrame";
		document.forms[0].submit()
	}
	
	
}

</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<BODY leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	
	<table width=100% border=0 cellpadding=3 cellspacing=1 class="outertable"> 
		
		<tr align="center"> 
		
		<%if (pageid == 1) {%> 
			<td class="main_tab_active" WIDTH="12%" NOWRAP> <b> Permission Gist </b> </td>
		<%} else {%> 
			<td class="main_tab_inactive" WIDTH="12%" NOWRAP> 
			<a href="javascript:gotoPage('permission_gist.jsp')" 
				onMouseOut="window.status='';return true;" 
				onMouseOver="window.status='Applicant';return true;">
				  <b>Permission Gist </b></a> </td>
		<%} %> 
		
		<%if (pageid == 2) {%> 
			<td class="main_tab_active" WIDTH="12%" NOWRAP> <b> Document attachment </b> </td>
		<%} else {%> 
			<td class="main_tab_inactive" WIDTH="12%" NOWRAP> 
			<a href="javascript:gotoPage('perm_docAttachment.jsp')" 
				onMouseOut="window.status='';return true;" 
				onMouseOver="window.status='Applicant';return true;">
				  <b>Document attachment</b></a> </td>
		<%} %> 
		
		<%if (pageid == 3) {%> 
			<td class="main_tab_active" WIDTH="12%" NOWRAP> <b> Basic information </b> </td>
		<%} else {%> 
			<td class="main_tab_inactive" WIDTH="12%" NOWRAP> 
			<a href="javascript:gotoPage('perm_basicinformation.jsp')" 
				onMouseOut="window.status='';return true;" 
				onMouseOver="window.status='Applicant';return true;">
				  <b> Basic information </b></a> </td>
		<%} %> 
		
		<%if (pageid == 4) {%> 
			<td class="main_tab_active" WIDTH="12%" NOWRAP> <b> Terms and Conditions</b> </td>
		<%} else {%> 
			<td class="main_tab_inactive" WIDTH="12%" NOWRAP> 
			<a href="javascript:gotoPage('Perm_TermsandConditions.jsp')" 
				onMouseOut="window.status='';return true;" 
				onMouseOver="window.status='Applicant';return true;">
				  <b> Terms and Conditions</b></a> </td>
		<%} %> 
		
		<%if (pageid == 5) {%> 
			<td class="main_tab_active" WIDTH="12%" NOWRAP> <b> Proposal Flow/Executive Summary </b> </td>
		<%} else {%> 
			<td class="main_tab_inactive" WIDTH="12%" NOWRAP> 
			<a href="javascript:gotoPage('perm_proposalflow.jsp')" 
				onMouseOut="window.status='';return true;" 
				onMouseOver="window.status='Applicant';return true;">
				  <b> Proposal Flow/Executive Summary</b></a> </td>
		<%} %> 
		
		<%if (pageid == 6) {%> 
			<td class="main_tab_active" WIDTH="12%" NOWRAP> <b> Queries </b> </td>
		<%} else {%> 
			<td class="main_tab_inactive" WIDTH="12%" NOWRAP> 
			<a href="javascript:gotoPage('appqueryhome.jsp')" 
				onMouseOut="window.status='';return true;" 
				onMouseOver="window.status='Applicant';return true;">
				  <b> Queries </b></a> </td>
		<%} %> 
		
		<%if (pageid == 7) {%> 
			<td class="main_tab_active" WIDTH="12%" NOWRAP> <b> Workflow </b> </td>
		<%} else {%> 
			<td class="main_tab_inactive" WIDTH="12%" NOWRAP> 
			<a href="javascript:gotoPage('permworkflowhistory.jsp')" 
				onMouseOut="window.status='';return true;" 
				onMouseOver="window.status='Applicant';return true;">
				  <b> Workflow </b></a> </td>
		<%} %> 
		
		
		</tr>
	</table>
	
	
	
</body>
</html>