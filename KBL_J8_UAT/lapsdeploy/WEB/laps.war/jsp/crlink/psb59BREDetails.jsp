<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />        
<lapschoice:handleerror />
<%
session.setAttribute("CURRENT_TAB","BRE_DETAILS");
ArrayList arryRow = (ArrayList)hshValues.get("arryRow"); 
ArrayList arryCol = new ArrayList();
String strCurrTabe= (String) session.getAttribute("CURRENT_TAB");
String strApplicationRefNo=Helper.correctNull((String)hshValues.get("strApplicationRefNo"));
if(strApplicationRefNo.equalsIgnoreCase(""))
{
	strApplicationRefNo= Helper.correctNull((String) session.getAttribute("strApplicationRefNo"));
}
%>
<html>
<head>
<title>National Portal - BRE Match Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function callclose()
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mainnav.jsp";
	document.forms[0].submit();
}
</script>
<%-- <link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"> --%>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/NationalPortal.css" type="text/css">
<style>
.mailbox_container
{
	width: 100%;
	height: 350px;
	overflow: auto;
}
</style>

</head>
<body onload="callOnLoad()">
<form name="docVerForm" method="post" action="" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td valign="top" colSpan="5"> 
       <jsp:include page="../crlink/PSB59ApplicationDetails.jsp" flush="true" /> 
    </td>
  </tr>
</table> 
<table width="98%" border="0" cellpadding="3" cellspacing="0" bordercolorlight="#cccccc" bordercolordark="#FFFFFB" class="shadow" align="center">
<tr><td>     
<table width="100%" cellspacing="0" cellpadding="3" align="center" class="shadow">        
<tr class="dataheader" align="center">
	<td >
	<font size="2"><b>BRE MATCH DETAILS</b></font></td></tr>
	<tr></tr>
	<tr>
	<td>
	
<table width="100%" align="center" cellspacing="0" cellpadding="0" border="0" class="outertable border mt20">
  <tbody>
    <tr class="dataheader padtdlr3">
    <th width="11%" align="center">Application Reference Id</th>
    <th width="16%" align="center">Id</th>
    <th align="center" width="13%">Parameter Name as Per BRE</th>
    <th align="center" width="13%">Applicant Type</th>
            <th align="center" width="13%">Mandatory</th>
              <th align="center" width="13%">Matched</th>
  </tr>
	
  
  
  <%if (arryRow != null && arryRow.size() > 0) {
				for (int i = 0; i < arryRow.size(); i++) {
					arryCol = (ArrayList) arryRow.get(i);%>
					<tr valign="top" class="datagrid">
					
					
						<td><%=Helper.correctNull((String) arryCol.get(1))%>&nbsp;</td>
						<td><%=Helper.correctNull((String) arryCol.get(0))%>&nbsp;</td>
						<td><%=Helper.correctNull((String) arryCol.get(2))%>&nbsp;</td>
						<td><%=Helper.correctNull((String) arryCol.get(5))%>&nbsp;</td>
						<td><%=Helper.correctNull((String) arryCol.get(6))%>&nbsp;</td>
						<td><%=Helper.correctNull((String) arryCol.get(7))%>&nbsp;</td>
						
					</tr>
					<%}
			}%>
</tbody></table>
<br><br><br> 

<input type="hidden" name="hidUserId" value="">
<table border="0" cellspacing="0" cellpadding="0"  align="center">
      <tr valign="middle"> 
       <td> 
		<input type="button" name="cmdclose" value="Close" class="buttonClose" onClick="callclose();">
	
            
        </td></tr></table>
</form>
</body>
</html>