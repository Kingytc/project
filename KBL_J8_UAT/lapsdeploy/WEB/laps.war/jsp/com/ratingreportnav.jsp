<%@include file="../share/directives.jsp"%><html>
<head>
<title>LAPS-Rating Reports Navigation</title>
<script language="javascript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function callFunction(pagename)
{
  document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename;
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
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style_tab.css" type="text/css">
</head>
<body>
<form class="normal" method=post name="appReports">
<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" colSpan=5>
				<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="page_flow">Home&nbsp;-&gt;&nbsp;Rating&nbsp;-&gt;&nbsp;Reports</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
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
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>

		<table class="outertable border1 tableBg" width="20%" border="0" cellspacing="0" align="center" cellpadding="4">
			<tr>
				<td valign="top">
				<table class="outertable" width="100%" border="0" align="center" cellspacing="0" cellpadding="0">
					<tr class="dataheader">
						<td valign="top" align="center">Rating Reports</td>
						</tr>
						<tr>
						<td>
						<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="8">
							<tr>
							<td class="menubackflow"><a href="javascript:callFunction('corporateratingreports.jsp')">Corporate Rating Reports</a></td>
					</tr>
					<tr>
							<td class="menubackflow"><a href="javascript:callFunction('poolbasedratingreports.jsp')">Pool based Rating Reports</a></td>
					</tr>
					<tr>
							<td class="menubackflow"><a href="javascript:callFunction('comonlyforrating_report.jsp')">Only For Rating</a></td>
					</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
				</tr>
		</table>
<table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>
