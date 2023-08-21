<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Application Inward Number Search</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
DIV.cellContainer {
	width: 100%;
	height: 200;
	overflow: auto;
}
</style>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentdate = "<%=Helper.getCurrentDateTime()%>";
function on_load()
{
	document.forms[0].txt_fromdate.focus();
}
function callGenerate()
{
	if(document.forms[0].txt_fromdate.value != "" && document.forms[0].txt_todate.value == "")
	{
		alert("Enter the to Date");
		document.forms[0].txt_todate.focus();
		return false;
	}
	if(document.forms[0].txt_fromdate.value == "" && document.forms[0].txt_todate.value == "")
	{
		alert("Enter the Date");
		document.forms[0].txt_fromdate.focus();
		return false;
	}
	
	if(document.forms[0].txt_fromdate.value == "" && document.forms[0].txt_todate.value != "")
	{
		
		var pagedate=document.forms[0].txt_todate.value;
		var pgdt=changeDateformat(pagedate);
		var maxdt=changeDateformat(currentdate);
		if(Date.parse(pgdt) > Date.parse(maxdt))
		{
			alert("Date cannot be greater than " +currentdate );
			document.forms[0].txt_todate.value="";
			document.forms[0].txt_todate.focus();
			return false;
		}
	}
	
	if(window.confirm("Do you want to Create Flat File?"))
	{	   
		var fromdate=document.forms[0].txt_fromdate.value; 
		var todate=document.forms[0].txt_todate.value;
		var FileName='ApplicationStatus'+currentdate.replace('/','').replace('/','');
		var prop = "scrollbars=no,width=650,height=500,top=25,left=180";
		var url=appURL+"action/"+FileName+".txt?hidBeanGetMethod=AppStatusFileGeneration&hidBeanId=FinacleBean&txt_fromdate="+fromdate+"&txt_todate="+todate;
		window.open(url,"remarks",prop);			
	}
}
function doClose()
{
window.close();
}
function callCalender(fname)
{ 	
	showCal("<%=ApplicationParams.getAppUrl()%>", fname);
	}
</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="on_load()">
<form name="appform" method="post" class="normal">
<table class="outertable" width="100%" border="0" cellspacing="0"
	cellpadding="3">
	
	<tr>
		<td>
<b>Application Status - Flat File Generation</b>
</td>
</tr>
</table>
<table class="outertable border1" width="100%" border="0" cellspacing="0"
	cellpadding="1">
	
	<tr>
		<td>
		<table class="outertable" width="100%" border="0" cellspacing="0"
			cellpadding="1">
			<tr>
				<td align="right" width="13%"><b>From </b></td>
				<td width="20%" align="center"><input type="text"
					name="txt_fromdate"
					value="<%//=Helper.correctNull((String)hshValues.get("frmdate"))%>"
					size="13" maxlength="10"
					onBlur="checkDate(this);checkmaxdate(this,currentdate)"
					tabindex="1"> <a alt="Select date from calender"
					href="javascript:callCalender('txt_fromdate')"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a></td>
				<td align="right" width="13%"><b>To</b></td>
				<td width="24%" align="center"><input type="text"
					name="txt_todate"
					value="<%//=Helper.correctNull((String)hshValues.get("todate"))%>"
					size="13" maxlength="10" tabindex="2"
					onBlur="checkDate(this);checkmindate(this,document.forms[0].txt_fromdate.value)">
				<a alt="Select date from calender"
					href="javascript:callCalender('txt_todate')"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a></td>
				<td width="30%" align="right">
				<DIV ALIGN="LEFT"><input type="button" name="cmdgen"
					class="buttonothers" value="Generate" onClick="callGenerate();"></DIV>
				</td>
			</tr>
			
			<%
				if (Helper.correctNull((String) hshValues.get("status")).equals("success")) {
			%>
			<tr>
				<td nowrap colspan="5" align="center"><b>Application
				Status:</b>Flat file is generated</td>
			</tr>
			<%
				} else if (Helper.correctNull((String) hshValues.get("status")).equals("fail")) {
			%>
			<tr>
				<td nowrap colspan="5" align="center"><b>Application
				Status:</b>Flat file is not generated</td>
			</tr>
			<%
				}
			%>
			
		</table>
		</table>
		<br>
		<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
		
<lapschoice:hiddentag pageid='<%=PageId%>' /></form>
</body>
</html>
