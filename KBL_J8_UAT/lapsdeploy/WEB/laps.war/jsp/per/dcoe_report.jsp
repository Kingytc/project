<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%
	String str_report = Helper.correctNull((String) request.getParameter("report"));
	String str_multiple = "";
	if (str_report.equalsIgnoreCase("C")) {
		str_multiple = "multiple";
	} else {
		str_multiple = "";
	}
%>

<html>
<head>
<title>DCOE REPORTS</title>
</head>
<script>
function doRunReport()
{
	
	var fromdt=document.forms[0].txtFromDate.value;
	var todt=document.forms[0].txtToDate.value;

	
	
	if(document.forms[0].txtFromDate.value=="")
	{
		ShowAlert('111','From Date');
		document.forms[0].txtFromDate.focus();
		return;
	}
	if(document.forms[0].txtToDate.value=="")
	{
		ShowAlert('111','To Date');
		document.forms[0].txtToDate.focus();
		return;
	}

	var prop = "scrollbars=yes,width=1100,height=700,top=25,left=180";
	var url=appURL+"action/dcoe_report_run.jsp?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getDCOEReport&txtFromDate="+fromdt+"&txtToDate="+todt;
	window.open(url,"DCOE_REPORT",prop);
	
}
function doReset()
{
	document.forms[0].txtFromDate.value="";
	document.forms[0].txtToDate.value="";

}
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/repnav.jsp";
		document.forms[0].submit();
	}
}
function callCalender(cmdname) {
	showCal(appURL, cmdname);
}
</script>
<body onload="">
<form name="perappstat" method="post" class="normal">
<table class="outertable" width="100%" border="0" cellspacing="0"
	cellpadding="0">
	<tr>
		<td class="page_flow">Home -&gt; Reports -&gt; DCOE
		Reports</td>
	</tr>
	<tr>
		<td align="right">&nbsp;</td>
	</tr>
</table>
<table class="outertable" width="100%" border="0" cellspacing="0"
	cellpadding="20">
	<tr>
		<td valign="middle">
		<table class="outertable" border="1" cellspacing="0" cellpadding="3"
			align="center" width="65%">
				<tr>
												<td width="35%" align="center">Period From &nbsp; <input
													type="text" name="txtFromDate" maxlength="21" readonly
													size="20" onBlur="checkDate(this);checkmaxdate(this,currentDate);checkmaxdate(this,document.forms[0].txtToDate.value);">&nbsp;
													<a alt="Select date from calender" href="#"
																	onClick="callCalender('txtFromDate')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border="0" alt="Select date from calender"
																	tabindex="29"></a></td>
													<td width="21%" align="center">To &nbsp; <input
													type="text" name="txtToDate" maxlength="21" readonly
													size="20" onBlur="checkDate(this);checkmaxdate(this,currentDate);checkmindate(this,document.forms[0].txtFromDate.value);">&nbsp;
													<a alt="Select date from calender" href="#"
																	onClick="callCalender('txtToDate')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border="0" alt="Select date from calender"
																	tabindex="29"></a></td>
			</tr>
		</table>	
		</td>
		</tr>
	</table>	
	<lapschoice:combuttonnew btnnames="Run Report_Reset" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
	</form>
	</body>
	</html>
			
				