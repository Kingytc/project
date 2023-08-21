<%@include file="../share/directives.jsp"%>
<%String grpRights = (String) session.getAttribute("strGroupRights");%>
<HTML>
<HEAD>
<TITLE>Laps Retail Navigation</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<script language="JavaScript">
var grpRights = "<%=session.getAttribute("strGroupRights")%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function callFunction(pagename)
{
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].hidBeanGetMethod.value="getCusGroupMgmt";	
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
}
function callPage(pagename)
{
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
}
function doClose()
{
	document.forms[0].action = appURL+"action/mainnav.jsp";
	document.forms[0].submit();
}
</script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style_tab.css" type="text/css">
</HEAD>
<BODY>
<form name="navigation" class="normal">
<table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td class="lightbandcolor">&nbsp;</td>
	</tr>
	<tr>
		<td class="darkbandcolor">&nbsp;</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" height="150">
		<tr>
		<td>&nbsp;</td>
	</tr>
			<tr>
				<td width="33%" valign="middle">
				<TABLE WIDTH="20%" BORDER="0" CELLSPACING="0" CELLPADDING="4" class="outertable">
					<TR>
						<TD class="menubackflow"><A HREF="javascript:callFunction('setcusgroupcreation.jsp')">Customer Group Creation</A></TD> 
					</TR>
					<tr>						
						<TD class="menubackflow" nowrap="nowrap"><a href="javascript:callPage('setcusgroupmem_mgt.jsp')">Addition &amp; Deletion of Group Members </a></td> 
					</TR>
					<tr>
		<td>&nbsp;</td>
	</tr>
				</TABLE>
				</td>				
			</tr>
		</table>
		</td>
	</tr>	
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td class="darkbandcolor">&nbsp;</td>
	</tr>
	<tr>
		<td class="lightbandcolor">&nbsp;</td>
	</tr>
</table><br>
<lapschoice:combuttonnew btnenable=''/> 
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</BODY>
</HTML>
