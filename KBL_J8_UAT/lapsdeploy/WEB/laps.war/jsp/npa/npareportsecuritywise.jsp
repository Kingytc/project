<%@include file="../share/directives.jsp"%>
<%
%>
<html>
<head>
<title>NPA Report(OLD)-Security wise</title>
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
var currentDate="<%=Helper.getCurrentDateTime()%>";
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}
function callCalender(cmdname) {
	showCal(appURL, cmdname);
}
function doExcelReport1()
{
	if(document.forms[0].txtToDate.value == ""||document.forms[0].npaorghelp.value == "")
	{
		if(document.forms[0].txtToDate.value == "")
		{
			alert("Please select the date");
			document.forms[0].txtToDate.focus();
			return;
		}
		else
		{
			alert("Please select Organisation");
			document.forms[0].npaorghelp.focus();
			return;
		}
		
	}
	else
	{
		var FileName="NPAEXE_"+document.forms[0].txtToDate.value;
		var qryString=appURL+"action/"+FileName+".xlsx?hidBeanId=excelfunction&hidBeanGetMethod=doExportNPAProvReport1&txtdate="+document.forms[0].txtToDate.value+"&npaorg="+document.forms[0].npaorghelp.value;
		var prop="scrollbars=yes,menubar=yes,width=20, height=20";
		window.open(qryString,"NPAprovisioning",prop);
	}
}
function allowalwysOldDate(obj,mindate)
{
	var pagedate=obj.value;
	var pgdt=changeDateformat(pagedate);
	var mindt=changeDateformat(mindate);
	if(obj.value!="")
	{
		if(Date.parse(pgdt) >= Date.parse(mindt))
		{
			alert("Date always be less than " +mindate );
			obj.value="";
			obj.focus();
			return false;
		}
	}
	return true;
}
</script>

<STYLE>
DIV.cellContainer {
	width: 100%;
	height: 100%;
	overflow: auto;
}
</STYLE>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form name="loanHistory" method="post" class="normal">
<table width="50%" align="center">
<tr>
<td>
<table>
<tr>

<td width="45%" valign="top" ><b>Select Date :</b>&nbsp;
<input
													type="text" name="txtToDate" maxlength="21" readonly
													size="20" onBlur="allowalwysOldDate(this,currentDate);checkDate(this);checkmaxdate(this,currentDate);checkmindate(this,document.forms[0].txtFromDate.value);">&nbsp;
													<a alt="Select date from calender" href="#"
																	onClick="callCalender('txtToDate')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border="0" alt="Select date from calender"
																	tabindex="29"></a></td>
<td width="45%">
<select name="npaorghelp">
										<option value="" selected>----Select Organization----</option>
												<%
													String s1 = "001" + "^R";
												%>
												<lapschoice:choiceOrg value='<%=s1%>' />
										</select>
</td>																	
</tr>
</table>
</td>
</tr>
</table>
<table width="50%" align="center">
<tr>
<td align="center">
	<input type="button" onClick="doExcelReport1()" value="NPA Provisioning Report Excel Format"  class="buttonStyle" >
	</td>
<td style="position: relative;right:100px">
<input type="button" name="cmdreject" onClick="doClose()" value="Close" class="buttonClose">
	</td>
	
	</tr>
	</table> <input type="hidden" name="hidCategoryType"
	value="<%=Helper.correctNull((String) request
							.getParameter("hidCategoryType"))%>">
<input type="hidden" name="hid_rowcount" value="" /> 
</form>
</body>
</html>
