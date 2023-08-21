<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />        
<lapschoice:handleerror />
<%
session.setAttribute("CURRENT_TAB","EMP_DETAILS");
ArrayList arrRow = (ArrayList)hshValues.get("arrRow"); 
ArrayList arrCol=new ArrayList();
%>

<html>
<head>
<title>National Portal - Employment Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>

<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/NationalPortal.css" type="text/css">

<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<link rel="stylesheet"href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";


function callOnLoad()
{

}function callclose()
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mainnav.jsp";
	document.forms[0].submit();
}

</script>


</head>
<body onload="callOnLoad()">
<form name="docVerForm" method="post" action="" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td valign="top" colSpan="5"> 
      <jsp:include page="PSB59ApplicationDetails.jsp"> </jsp:include>
    </td>
  </tr>
</table> 
<table width="98%" border="0" cellpadding="3" cellspacing="0" bordercolorlight="#cccccc" bordercolordark="#FFFFFB" class="shadow" align="center">
<tr><td>     
<table width="100%" cellspacing="0" cellpadding="3" align="center" class="shadow">        
<tr class="dataheader" align="center">
	<td >
	<font size="2">EMPLOYMENT DETAILS</font></td></tr>
	<tr class="datagrid">
		<td>
		<div id="top2">
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<col width="6%">
		<col width="10%">
		<col width="6%">
		<col width="10%">
		<col width="6%">
		<col width="10%">
		    <tr >
				<td>Employment Type</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_OCCUPATION"))%></td>
				<td>Organization Type</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_ORG_TYPE"))%></td>
				<td>Organization Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_ORG_NAME"))%></td>
			</tr>
			<tr></tr>
			<tr >
				<td>Designation</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_DESIGNATION"))%></td>
				<td>Working Since Year</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_WORKING_SINCE_YEAR"))%></td>
				<td>Working Since Month</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_WORKING_SINCE_MONTH"))%></td>
			</tr>
			<tr >
				<td>Retirement Age</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_RETIRE_AGE"))%></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr >
				<td>Business Establishment Year</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_BUSS_ESTA_YEAR"))%></td>
				<td>Business Establishment Month</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_BUSS_ESTA_MONTH"))%></td>
				<td>Current Business Year1</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_CURR_BUSS_YEAR"))%></td>
			</tr>
			</table>
		</div>
		</td>
	</tr>
</table>
</td></tr>
<table border="0" cellspacing="0" cellpadding="0"  align="center">
      <tr valign="middle"> 
       <td> 
		<input type="button" name="cmdclose" value="Close" class="buttonClose" onClick="callclose();">
	
            
        </td></tr>
 </table>
</table>
<input type="hidden" name="hidUserId" value="">

</form>
</body>
</html>