<%
/**
*@author Arunkumar Subramaniam 08-JAN-2008
*@FileName  rbiupload.jsp
*@purpose  uploading  RBI Defaulter List Excelsheet 
*/
%><%@include file="../share/directives.jsp"%>
<%@ page import="javazoom.upload.*"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<html>
<head>
<title>RBI Defaulter Entery</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
function callClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appUrl+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form method="POST" enctype="multipart/form-data" action="<%=ApplicationParams.getAppUrl()%>action/rbiupload.jsp?&hidFileType=MULTIPART&hidBeanGetMethod=excelParser&hidBeanId=ExcelReader&txtsheetname="&javascript:document.forms[0].txtsheetname.value>
<p>&nbsp;</p>
<p align="center"><font size=2 ><strong>Upload RBI Defaulter List Excel sheet here!</strong></font></p>
<table width="80%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
	<tr>
		<td valign="top" >   
		<table  width="100%" cellpadding="0" cellspacing="0" border="0" class="outertable">		
		<tr>
      <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td align="center">File : <input type="file" name="fileUpload" ></td>	
	</tr>
</table>
</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
<td align="center">
<input type=submit value="Upload" class="buttonStyle">
<input type=submit value="Close" class="buttonClose" onClick="callClose()">
</td>
</tr>
</table>
</td>
</tr>
</table>
<input type="hidden" name="hidFileType" value="MULTIPART">	
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
<br>
<center>
  <font color=red ><strong><%=Helper.correctNull((String)hshValues.get("status")) %></strong></font> 
</center>
</body>
</html>
