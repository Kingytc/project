<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<%
String str_reportmis= Helper.correctNull((String) request.getParameter("hidreportmis"));
%>
<html>
<head>
<title>Gold Loan Reappraisal Pending For Verification</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<SCRIPT LANGUAGE="JavaScript"></script>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var path="<%=ApplicationParams.getAppUrl()%>";
var fromdate="";
var todate="";


function callCalender(cmdname) {
	showCal(appURL, cmdname);
}


function doClose()
{
	if (ConfirmMsg("100"))
	{
		document.forms[0].reset();
		document.forms[0].action = path+"action/repnav.jsp";
		document.forms[0].submit();
	}
}

function runreport()
{
	if(document.forms[0].txtFromDate.value=="")
	{
		alert("Please Fill from and To date fields");
	}
	else if(document.forms[0].txtToDate.value=="")
	{
		alert("Please Fill from and To date fields");
	}

	else{
		fromdate=document.forms[0].txtFromDate.value;
		todate=document.forms[0].txtToDate.value;
		document.forms[0].method="post";
		var purl = appURL+"action/goldreappraisalpendding.jsp?hidBeanId=agrotherassets&hidBeanGetMethod=getgoldpenddingreapp&fromdate="+fromdate+"&todate="+todate;
		var title = "Report";
		var prop = "scrollbars=Yes,toolbars=No,menubar=no ,width=1000 , height=550,top=10,left=0";		
		window.open(purl,title,prop);
	}
	
	
}


</script>
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/style.css"	type="text/css">
</head>

<body>
<form name="custdet" method="post" class="normal">
<div align="center">
<h3></h3></div>


<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="20">
	<tr>
		<td valign="middle">
		<table class="outertable border1 tableBg" border="0" cellspacing="0" cellpadding="3" align="center" width="65%">
			<tr>
				<td>
				<table class="outertable" width="100%" border="0" cellspacing="0"
					cellpadding="5" align="center">
					<tr>
						<td colspan="2" height="30">
						<table class="outertable" width="50%" border="0" cellspacing="0" cellpadding="3" align="center">
							<tr>
												<td width="35%" align="center">Reappraisal Date From</td>
												<td width="20%" align="center">&nbsp; <input
													type="text" name="txtFromDate" maxlength="21" readonly
													size="20" onBlur="checkDate(this);checkmaxdate(this,currentDate);checkmaxdate(this,document.forms[0].txtToDate.value);">&nbsp;
													<a alt="Select date from calender" href="#"
																	onClick="callCalender('txtFromDate')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border="0" alt="Select date from calender"
																	tabindex="29"></a></td>
													<td width="21%" align="center">To</td>
												<td width="20%" align="center">&nbsp; <input
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
			</td>
		</tr>
	</table>
</td>
</tr>
</table>
<br>
<table align="center">
<tr align="center">
<td align="center">
<input type="button" name="cmdreject" onClick="runreport()" value="Run Report" class="buttonStyle">
<input type="button" name="cmdreject" onClick="doClose()" value="Close" class="buttonClose">
</td>
</tr>
</table>
 <input type="hidden" name="hidAction" >
  <input type="hidden" name="hidBeanId">
  <input type="hidden" name="hidBeanMethod">
  <input type="hidden" name="hidBeanGetMethod"  >
  <input type="hidden" name="hidSourceUrl" >
  <input type="hidden" name="hidflag" >
  <input type="hidden" name="hideditflag">
<input type="hidden" name="hidApplicantId">
<input type="hidden" name="hidsno" value="">
<input type="hidden" name="hidkeyid" value="set">
 
</form>
</body>
</html>
