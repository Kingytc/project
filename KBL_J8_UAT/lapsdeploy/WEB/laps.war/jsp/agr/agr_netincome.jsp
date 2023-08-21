<%@include file="../share/directives.jsp"%>
<%
String schemetype = Helper.correctNull((String)request.getParameter("schemetype"));
String strAppno=Helper.correctNull((String)request.getParameter("appno")) ;
if(schemetype. trim().equalsIgnoreCase(""))
{
	schemetype="0";
}
%>
<html>
<head>
<title>Net Income</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL="<%=ApplicationParams.getAppUrl()%>";  
var schemetype="<%=schemetype%>";
function dobtnClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/corppge.jsp";
		document.forms[0].submit();
	}
}
function onload()
{
	document.forms[0].cmdsave.disabled=true;
	document.all.savid.style.visibility="hidden";
	document.all.savid.style.position="absolute";
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=schemetype;
}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onload();">	
 
<form name="appform" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="999" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<lapschoice:borrowertype /> 
<lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
      <td><i><b>Home -> Agriculture -> Net Income</b></i></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="211" />
			<jsp:param name="pageid" value="<%=schemetype%>"/>
		</jsp:include></td>
	</tr>
</table>	
<br/>
	<table width="90%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" align="center">
	<tr> 
	<td>							
	<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
	<tr class="dataheader">
	<td  width="40%" style="text-align: center">Particulars</td>
	<td  width="15%" style="text-align: center">Year 1</td>
	<td  width="15%" style="text-align: center">Year 2</td>
	<td  width="15%" style="text-align: center">Year 3</td>
	<td  width="15%" style="text-align: center">Year 4</td>
	</tr>
	<tr class="datagrid">
	<td  width="40%">Gross Income (A)</td>
	<td  width="15%" style="text-align: right;"><%=Helper.correctDouble((String)hshValues.get("income_year1")) %></td>
	<td  width="15%" style="text-align: right;"><%=Helper.correctDouble((String)hshValues.get("income_year2")) %></td>
	<td  width="15%" style="text-align: right;"><%=Helper.correctDouble((String)hshValues.get("income_year3")) %></td>
	<td  width="15%" style="text-align: right;"><%=Helper.correctDouble((String)hshValues.get("income_year4")) %></td>
	</tr>
	<tr class="datagrid">
	<td  width="40%">Expenditure (B)</td>
	<td  width="15%" style="text-align: right;"><%=Helper.correctDouble((String)hshValues.get("expyear1")) %></td>
	<td  width="15%" style="text-align: right;"><%=Helper.correctDouble((String)hshValues.get("expyear2")) %></td>
	<td  width="15%" style="text-align: right;"><%=Helper.correctDouble((String)hshValues.get("expyear3")) %></td>
	<td  width="15%" style="text-align: right;"><%=Helper.correctDouble((String)hshValues.get("expyear4")) %></td>
	</tr>
	<tr class="datagrid">
	<td width="40%">Net Income (A-B)</td>
	<td  width="15%" style="text-align: right;"><%=Helper.correctDouble((String)hshValues.get("netyear1")) %></td>
	<td  width="15%" style="text-align: right;"><%=Helper.correctDouble((String)hshValues.get("netyear2")) %></td>
	<td  width="15%" style="text-align: right;"><%=Helper.correctDouble((String)hshValues.get("netyear3")) %></td>
	<td  width="15%" style="text-align: right;"><%=Helper.correctDouble((String)hshValues.get("netyear4")) %></td>
	</tr>
	</table>
	</td>
	</tr>
	</table>	
	<br>
	<br>
	<table border="0" cellspacing="0" cellpadding="1" class=" " align="center">
	<table border="0" cellspacing="0" cellpadding="1" class="outertable border1" align="center">
<tr><td align="center">
<input type="button" name="cmdclose" value="Close" onClick="dobtnClose()" class="buttonClose">
<input type="button" id="savid" name="cmdsave" value="Save">
</td>
</tr>
</table>
<lapschoice:hiddentag pageid="<%=PageId%>"/>
</form>
</body>
</html>
