<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="javazoom.upload.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" /> 
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	String strmsg=Helper.correctNull((String)hshValues.get("msg"));
	String strAppno=Helper.correctNull((String)request.getParameter("appno"));
	String strExisting=Helper.correctNull((String)request.getParameter("strExisting"));
	String cmano=Helper.correctNull((String)hshValues.get("cma"));
	if(cmano.equalsIgnoreCase(""))
	{
		cmano=Helper.correctNull((String)request.getParameter("cma"));
	}
	if(strExisting.equalsIgnoreCase(""))
		strExisting = Helper.correctNull((String)hshValues.get("strExisting"));
	String strProposed=Helper.correctNull((String)request.getParameter("strProposed"));
	if(strProposed.equalsIgnoreCase(""))
		strProposed = Helper.correctNull((String)hshValues.get("strProposed"));
	String strDivId=Helper.correctNull((String)request.getParameter("strDivId"));
	if(strDivId.equalsIgnoreCase(""))
		strDivId = Helper.correctNull((String)hshValues.get("strDivId"));
	String hidCMANo=Helper.correctNull((String)request.getParameter("hidcmasno"));
	if(hidCMANo.equalsIgnoreCase(""))
		hidCMANo = Helper.correctNull((String)hshValues.get("hidCMANo"));
	if(strAppno.equalsIgnoreCase(""))
	{
		strAppno=Helper.correctNull((String)hshValues.get("appno"));
	}
%>
<html>
<head>
<title>Financial Uploading</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var msg="<%=strmsg%>";
var freezeaudit="<%=Helper.correctNull((String)request.getParameter("freeze_audit"))%>";
function callClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		var hidfinanceid=document.forms[0].hidfinid.value;
		var hidcmasno=document.forms[0].hidCMANo.value;
		var appid=document.forms[0].appid.value;
		window.opener.document.forms[0].hidBeanId.value="financial";
		window.opener.document.forms[0].hidBeanGetMethod.value="getData";
		window.opener.document.forms[0].hidBeanMethod.value="getData";
		window.opener.document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/com_FinancialTemp.jsp?appno="+appid+"&hidCMANo="+document.forms[0].hidCMANo.value;
		window.opener.document.forms[0].submit();	
		window.close();
	}
}
function doUpload()
{
	
if(freezeaudit!='y'&& freezeaudit!='Y' )
{
	
	var finid=document.forms[0].hidfinid.value;
	var appid=document.forms[0].appid.value;
	var cma=document.forms[0].hidCMANo.value;
	var freeze_audit=document.forms[0].hidfreeze_audit.value;
	document.forms[0].action=appUrl+"action/com_financialupload.jsp?strFinUpload=YES&hidFileType=MULTIPART&hidBeanId=excelfunction&hidBeanGetMethod=getExcelValues&finid="+finid+"&appid="+appid+"&hidappid="+appid+"&hidfinid="+finid+"&cma="+cma+"&hidfreeze_forexcel="+freeze_audit;
	document.all.id_wait.style.visibility="visible";
	document.getElementById("progress").style.visibility="visible";
}
else
{
	var finid=document.forms[0].hidfinid.value;
	var appid=document.forms[0].appid.value;
	var cma=document.forms[0].hidCMANo.value;
	var freeze_audit=document.forms[0].hidfreeze_audit.value;
	document.forms[0].action=appUrl+"action/com_financialupload.jsp?strFinUpload=YES&hidFileType=MULTIPART&hidBeanId=excelfunction&hidBeanGetMethod=getFreezedExcelValues&finid="+finid+"&appid="+appid+"&hidappid="+appid+"&hidfinid="+finid+"&cma="+cma+"&hidfreeze_forexcel="+freeze_audit;
	document.all.id_wait.style.visibility="visible";
	document.getElementById("progress").style.visibility="visible";
	
}
}
function callonload()
{	
	document.all.id_wait.style.visibility="hidden";
	document.getElementById("progress").style.visibility="hidden";
	if(msg!="")
	{
		alert(msg);
	}
}
</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body class="datagrid" text="#000000" leftmargin="0" onload="callonload()">
<form  method="POST" enctype="multipart/form-data" action="<%=ApplicationParams.getAppUrl()%>action/com_financialupload.jsp?strFinUpload=YES&hidType=MULTIPART&hidBeanGetMethod=getExcelValues&hidBeanId=excelfunction">
<br>
<p align="center"><font color="#000000"><b><font size="2" face="Arial">File format must be:CMA MSME_4_companyname.xls</font></b></font></p>
<p align="center"><font color="#000000"><b><font size="2" face="Arial">Upload Financial Excel Sheet Here!!</font></b></font></p>
<p align="center"><font color="red" size="2" face="Arial">Use Close Button to close this window</font></p>
<table width="90%" border="0" cellspacing="0" cellpadding="5" align="center">
<tr>
		<td valign="top">   
		<table  width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
      <td>
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="68" bordercolorlight="#FFFFFF" bordercolordark="#C3CCF3" class="shadow">
	  <tr class="datagrid">
		<td align="center">File : <input type="file" name="fileUpload" ></td>
	</tr>
	<tr id="id_wait">
		<td><b><font style="text-decoration:blink">Please Wait till Excel Sheet gets uploaded</font></b>
		 <div id="progress" style="position:absolute; width:106px; visibility:hidden; height:19px; z-index:1; left: 200px; top: 100px"> 
    <img src="<%=ApplicationParams.getAppUrl()%>img/processing2.gif"> </div></td>
	</tr>
</table>
</td>
</tr>
<tr>
<td align="center">
<input type="submit" value="Upload" class="buttonOthers" onClick="doUpload()">
<input type="button" value="Close" class="buttonclose" onClick="callClose()">
</td>
</tr>
</table>
</td>
</tr>
</table>
<input type="hidden" name="hidFINType" value="MULTIPART">			
<input type="hidden" name="hidBeanGetMethod" value="getExcelValues">
<input type="hidden" name="appno" value="<%=strAppno%>">
<input type="hidden" name="hidBeanId" value="excelfunction">
<input type="hidden" name="hidBeanMethod" value="">
<input type="hidden" name="strExisting" value="<%=strExisting%>">
<input type="hidden" name="strProposed" value="<%=strProposed%>">
<input type="hidden" name="strDivId" value="<%=strDivId%>">
<input type="hidden" name="hidCMANo" value="<%=cmano%>">
<input type="hidden" name="appid" value="<%=Helper.correctNull((String)request.getParameter("appid"))%>">
<input type="hidden" name="hidappid" value="<%=Helper.correctNull((String)request.getParameter("appid"))%>">
<input type="hidden" name="hidfinid" value="<%=Helper.correctNull((String)request.getParameter("finid"))%>">
<input type="hidden" name="hidfreeze_audit" value="<%=Helper.correctNull((String)request.getParameter("freeze_audit"))%>">
</form>
<br>
</body>
</html>
