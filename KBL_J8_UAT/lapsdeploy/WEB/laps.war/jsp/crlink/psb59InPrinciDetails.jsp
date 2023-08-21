<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />        
<lapschoice:handleerror />
<%
session.setAttribute("CURRENT_TAB","INPRINCIPLE_DETAILS");
ArrayList arrRow = (ArrayList)hshValues.get("arrRow"); 
ArrayList arrCol=new ArrayList();
%>

<html>
<head>
<title>National Portal - In Principle Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";



function callOnLoad()
{

}
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
	<font size="2"><b>IN-PRINCIPLE DETAILS</b></font></td></tr>
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
		    <tr height="30px">
				<td><b>Eligible Amount</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("EL_AMOUNT"))%></td>
				<td><b>Subsidy Amount</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SUBSIDY_AMOUNT"))%></td>
				<td><b>Eligible EMI</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("EL_EMI"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>ROI</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("EL_ROI"))%></td>
				<td><b>Tenure</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("EL_TENURE"))%></td>
				<td><b>Processing Fee</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("EL_PROCESSING_FEE"))%></td>
			</tr>
			<tr height="30px">
				<td><b>Branch Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("BRANCH_NAME"))%></td>
				<td><b>Branch Code</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("BRANCH_CODE"))%></td>
				<td><b>IFSC Code</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("IFSC_CODE"))%></td>
			</tr>
			<tr height="30px">
				<td><b>Address</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("ADDRESS"))%></td>
				<td><b>Contact Number</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("CONTACT_NUMBER"))%></td>
				<td></td>
				<td></td>
			</tr>
			<tr height="30px">
				<td><b>Journey Completion Date</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("JOURNEY_COMPLETION_DATE"))%></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			</table>
		</div>
		</td>
	</tr>
</table>
</td></tr>
</table>

<input type="hidden" name="hidUserId" value="">
<table border="0" cellspacing="0" cellpadding="0"  align="center">
      <tr valign="middle"> 
       <td> 
		<input type="button" name="cmdclose" value="Close" class="buttonClose" onClick="callclose();">
	
            
        </td></tr></table>
</form>
</body>
</html>