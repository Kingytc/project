<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />    
<lapschoice:handleerror />
<%ArrayList arrRow = (ArrayList)hshValues.get("arrRow"); 
ArrayList arrCol=new ArrayList();%>
<html>
<head>
<title>NP Application - Reallocation</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var varStatus="<%=Helper.correctNull((String)hshValues.get("status"))%>";

function doSearch()
{
	var txtval=trim(document.forms[0].txtsearch.value);
	var txtlen=txtval.length;
	var rdovalue="";
	if(document.forms[0].rad[0].checked == true || document.forms[0].rad[1].checked == true)
	{
		if(txtlen=="")
		{
			alert("Please Enter Search Value");
			document.forms[0].txtsearch.value="";
		    document.forms[0].txtsearch.focus();
		    return;
		}
	}
	for(var i=0;i<document.forms[0].rad.length;i++)
	{
		if(document.forms[0].rad[i].checked==true)
		{
			rdovalue=document.forms[0].rad[i].value;
		}
	}

	document.all.isearch.src= appUrl+"action/np_reallocation_search.jsp?hidBeanId=PSB59&hidBeanGetMethod=getReallocationList&hidapprefid="+txtval+"&hid_np_refid="+rdovalue;
}

function callclose()
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/npInbox.jsp";
	document.forms[0].submit();
}

function callOnLoad()
{
	
}
 
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<style>
.mailbox_container {
	width: 100%;
	height: 350px;
	overflow: auto;
}
</style>
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"	type="text/css">
</head>
<body onload="callOnLoad()">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="path">Home -&gt; National Portal -&gt; National Portal Reallocation</td>
	</tr>
</table>
<form name="mails" metdod="post">
<table width="98%" border="1" cellpadding="3" cellspacing="0"
	bordercolorlight="#cccccc" bordercolordark="#FFFFFB"
	class="shadow" align="center">
	<tr><td>
<table width="95%" border="0" cellspacing="0" cellpadding="0"
	align="center">
	<tr>
	<td>
	<table width="100%" border="0" cellspacing="0" cellpadding="3"  class="shadow">
	<tr class="dataHeadColor">
		<td colspan="6">Customer Profile Search</td>
	</tr>
	<tr>
	<tr>
		<td><input type="radio" name="rad" style="border: none;" value="np_refid" onClick="onRadioClick()" checked></td>
		<td>Reference ID</td>
		<td><input type="hidden" name="rad" style="border: none;" value="np_appid" onClick="onRadioClick()" disabled></td>
		<td><input type="text" name="txtsearch" size="15" maxlength="20" onkeypress="allowAlphabetsandNumeric();notAllowSpace();"></td>
		<td><input type="button" name="cmdsearch" value="search" onclick="doSearch()" style="width:75" class="buttoncolor"></td>
	</tr>
	</table>
	</td>
	</tr>
	<tr>
	<td>
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="shadow">
	<tr class="tabactive">
	<td width="15%" nowrap="nowrap" align="center">Reference Id</td>
	<td width="10%" nowrap="nowrap" align="center">Applicant Name</td>
	<td width="10%" nowrap="nowrap" align="center">Scheme ID</td>
	<td width="10%" nowrap="nowrap" align="center">Scheme Name</td>
	<td width="10%" nowrap="nowrap" align="center">Organisation</td>
	<td width="15%" nowrap="nowrap" align="center">Organisation</td>
	<td width="10%" nowrap="nowrap" align="center">Reallocate</td>
	</tr>
	</table>
	</td>
	</tr>
	<tr>
	<td>
	<tr>
	<td><iframe id="isearch" width="100%" height="200"
		style="border: none"
		src="<%=ApplicationParams.getAppUrl()%>action/blank.jsp" align="middle"></iframe></td>
</tr>
</table>
</td>
</tr></table>
<br>
<table border="0" cellspacing="0" cellpadding="0" align="center">
	<tr valign="middle">
		<td><input type="button" name="cmdclose" value="Close"
			style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="callclose();"></td>
	</tr>
</table>
<input type="hidden" name="org_code" value="">
<input type="hidden" name="org_alphacode" value="">
<input type="hidden" name="hidBeanGetMethod" value="">
<input type="hidden" name="hidBeanId" value=""> 
<input type="hidden" name="hidBeanMethod" value=""> 
<input type="hidden" name="hidSourceUrl" value="">
<input type="hidden" name="hidReferId" value="">
</form>
</body>
</html>
