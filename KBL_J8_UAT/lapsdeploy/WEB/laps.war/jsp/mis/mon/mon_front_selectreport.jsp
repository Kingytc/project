<%@ include file="../../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<html>
<head>
<title>LAPS-Setup Reports Navigation</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="javascript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function callFunction(pagename)
{
  document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename;
  document.forms[0].submit();
}
function callFunction1(pagename,param)
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename+"?annexure="+param;
  	document.forms[0].submit();
}
function calldate()
{
 	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/MonStmt.jsp";
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
}
function closeWindow()
{
	if (ConfirmMsg("100"))
	{
		document.forms[0].hidPage.value="Navigation";
		document.forms[0].hidusr_id.value="<%=session.getAttribute("strUserid")%>";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/repnav.jsp";
		document.forms[0].submit();
	}	
}
function doClose()
{
	callFunction('repnav.jsp');
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style_tab.css" type="text/css">
</head>
<body>
<form method=post name="appReports" class="normal">
<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Reports&nbsp;-&gt;&nbsp;Monitoring
		Reports</td>
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
<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
	<tr>
		<td valign="top">
		<table class="outertable"  width="97%" border="0" cellspacing="0" cellpadding="4">
			<tr>
				<td valign="top">
				<table class="outertable"  width="40%" border="0" cellspacing="0" align="center" cellpadding="0">
					<tr class="dataheader">
						<td valign="top" align="center">Monitoring Reports</td>
						</tr>
						<tr>
						<td>
						<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="8">
							<tr>
								<td class="menubackflow">
								<a href="JavaScript:callFunction1('monitoring_report.jsp','C')">Annexure C</a>
								</td>
							</tr>
							<tr>
								<td class="menubackflow"><a href="javaScript:callFunction1('monitoring_report.jsp','D')">Annexure D</a></td>
							</tr>
							<tr>
								<td class="menubackflow"><a href="JavaScript:callFunction1('monitoring_report.jsp','E')">Annexure E</a></td>
							</tr>
							<tr>
								<td class="menubackflow">
								<a href="JavaScript:callFunction1('mon_sectorwiserpt.jsp','Sector wise')">Annexure for SectorWise</a>
								</td>
							</tr>
							<tr>
								<td class="menubackflow">
								<a href="JavaScript:callFunction1('mon_sectorwiserpt.jsp','Subsector wise')">Annexure for Sub Sector Wise</a>
								</td>
							</tr>
							<tr>
								<td class="menubackflow">
								<a href="JavaScript:callFunction1('mon_sectorwiserpt.jsp','Purpose wise')">Annexure for Purpose of Advance wise</a>
								</td>
							</tr>
							<tr>
								<td class="menubackflow"><a href="JavaScript:callFunction1('monitoring_sanction.jsp','N')">New Limits Sanctioned</a></td>
							</tr>
							<tr>
								<td class="menubackflow"><a href="JavaScript:callFunction1('monmmr_report.jsp','')">Status Of Monthly Monitoring report</a></td>
							</tr>
							<tr>
								<td class="menubackflow"><a href="JavaScript:callFunction1('montermloan_report.jsp','')">Status Of Term Loan Review Note</a></td>
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
</table><table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidPage"> 
<input type="hidden" name="hidusr_id">
</form>
</body>
</html>
