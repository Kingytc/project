<%@include file="../share/directives.jsp"%><html>
<head>
<title>LAPS-Setup Reports Navigation</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function callFunction_1(pagename)
{
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
}

function doClose()
{
	if (ConfirmMsg("100"))
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/repnav.jsp";
		document.forms[0].submit();
	}

}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style_tab.css"
	type="text/css">
</head>
<body>
<form class="normal">
<table class="outertable" width="100%" border="0" cellspacing="0"
	cellpadding="0">
	<tr>
		<td>
		<table class="outertable" width="100%" border="0" cellspacing="0"
			cellpadding="0">
			<tr>
				<td valign="top" colSpan=5>
				<table class="outertable" width="100%" border="0" cellspacing="0"
					cellpadding="0">
					<tr>
						<td class="page_flow">Home&nbsp;-&gt;&nbsp;Monitoring&nbsp;-&gt;&nbsp;Reports</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="0"
	class="outertable" align="center">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="0"
	class="outertable" align="center">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>

<table class="outertable" width="20%" border="0" cellspacing="0"
	align="center" cellpadding="4">
	<tr>
		<td valign="top">
		<table class="outertable border1 tableBg" width="100%" border="0" align="center"
			cellspacing="0" cellpadding="0">
			<tr class="dataheader">
				<td valign="top" align="center">Online Reports</td>
			</tr>
			<tr>
				<td>
				<table class="outertable" width="100%" border="0" cellspacing="0"
					cellpadding="8">
					<tr>
						<td class="menubackflow"><a href="javascript:callFunction_1('onlineReportsannexure1.jsp')">Annexure-1</a></td>
					</tr>
					<tr>
						<td class="menubackflow"><a href="javascript:callFunction_1('MSME_Reports.jsp')">Annexure-2</a></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="0"
	class="outertable" align="center">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<lapschoice:combuttonnew
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' /></form>
</body>
</html>
