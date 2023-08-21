<%@ include file="../../share/directives.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<script>
var path="<%=ApplicationParams.getAppUrl()%>";
</script>
<script type="text/javascript">
function doReset()
{
	document.forms[0].txtFromDate.value="";
	document.forms[0].txtToDate.value="";
}
function doClose()
{
	if (ConfirmMsg("100"))
	{
//	document.forms[0].hidBeanId.disabled=true;
	document.forms[0].action=path+"action/repnav.jsp";
	document.forms[0].submit();
	}
}
function callCalender(cmdname) {
	showCal(appURL, cmdname);
}
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
	window.open(path+"action/runInterestReport.jsp?hidBeanId=perrepapptrack&hidBeanGetMethod=getData&hidMethod=getinterestreport&txtFromDate="+fromdt+"&txtToDate="+todt,"stat","scrollbars=Yes,toolbars=No,menubar=yes ,width=900 , height=600,top=10,left=10");
	
}

</script>
<body>
<form method="post" class="normal">
<table class="outertable" width="100%" border="0" cellspacing="0"
	cellpadding="0">
	<tr>
		<td class="page_flow">Home -&gt; Reports -&gt; Interest Report</td>
	</tr>
	<tr>
		<td align="right">&nbsp;</td>
	</tr>
</table>
<table class="outertable" width="69%" border="0" cellspacing="0"
	cellpadding="3" align="center">
	<tr>
		<td>
		<table class="outertable border1 tableBg" width="69%" border="0" cellspacing="0"
			cellpadding="3" align="center">
			<tr>
				<td>
				<table class="outertable" width="100%" border="0" cellspacing="0"
					cellpadding="3" align="center">
					<tr><td colspan="3">&nbsp;</td></tr>
					<tr>
						<td width="35%" align="center">Period From</td>
						<td width="20%" align="center">&nbsp; <input type="text"
							name="txtFromDate" maxlength="21" readonly size="20"
							onBlur="checkDate(this);checkmaxdate(this,currentDate);checkmaxdate(this,document.forms[0].txtToDate.value);">&nbsp;
						<a alt="Select date from calender" href="#"
							onClick="callCalender('txtFromDate')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>
						<td width="21%" align="center">To</td>
						<td width="20%" align="center">&nbsp; <input type="text"
							name="txtToDate" maxlength="21" readonly size="20"
							onBlur="checkDate(this);checkmindate(this,document.forms[0].txtFromDate.value);checkmaxdate(this,currentDate);">&nbsp;
						<a alt="Select date from calender" href="#"
							onClick="callCalender('txtToDate')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>
					</tr>
					<tr><td colspan="3">&nbsp;</td></tr>
				</table>
				</td>
			</tr>
			</table>
			
			<tr>
				<td><lapschoice:combuttonnew btnnames="Run Report_Reset"
					btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
				</td>
			</tr>
		</table>
<input type="hidden" name="hidBeanId"></form>
</body>
</html>