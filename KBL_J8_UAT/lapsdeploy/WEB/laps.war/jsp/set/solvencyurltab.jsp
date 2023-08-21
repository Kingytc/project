<%@include file="../share/directives.jsp"%>
<%@ page import="com.sai.laps.helper.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%int tabid = Integer.parseInt(Helper.correctInt((String)request.getParameter("tabid")));
%>

<HTML>
<HEAD>
<TITLE>Solvency link tab</TITLE>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript">
function gotoLinkTab(tabname)
{	
	if(document.forms[0].cmdsave.disabled == false)
	{
		ShowAlert(103);
		return;
	}
if(tabname=="solvencyprodprocesscharges.jsp")
	{
	document.forms[0].hidBeanGetMethod.value="comsolvency";
	document.forms[0].hidBeanId.value="";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+tabname;	
	document.forms[0].submit();
	}	
if(tabname=="solvencydelegatedpower.jsp")
	{	
	document.forms[0].hidBeanId.value="comsolvency";
	document.forms[0].hidBeanGetMethod.value="getDelegateData";		
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

	<%if(tabid==01)
	{
	%>
	<td class="sub_tab_active" WIDTH="12%" nowrap="nowrap"><b>Processing Charges</b></td>
	<%
	}
	else
	{
	%>
	<td class="sub_tab_inactive" WIDTH="12%" nowrap="nowrap">
	<a href="javascript:gotoLinkTab('solvencyprodprocesscharges.jsp')" onMouseOut="window.status='';return true;" 
			onMouseOver="window.status='Workflow';return true;"><b>Processing Charges</b></a></td>
	<%
	}	
	
	%>
	
	<%if(tabid==06)
	{
	%>
	<td class="sub_tab_active" WIDTH="12%" nowrap="nowrap"><b>Delegated Power</b></td>
	<%
	}
	else
	{
	%>
	<td class="sub_tab_inactive" WIDTH="12%" nowrap="nowrap">
	<a href="javascript:gotoLinkTab('solvencydelegatedpower.jsp')" onMouseOut="window.status='';return true;" 
			onMouseOver="window.status='Workflow';return true;"><b>Delegated Power</b></a></td>
	<%
	}	
	
	%>
	
				</tr>
		</table>
		</td>
	</tr>

</table>
