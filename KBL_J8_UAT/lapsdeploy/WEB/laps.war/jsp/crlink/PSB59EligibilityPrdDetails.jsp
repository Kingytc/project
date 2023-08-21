<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<lapschoice:handleerror />

<%
session.setAttribute("CURRENT_TAB","ELIGIBILITY_DETAILS");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function callclose()
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mainnav.jsp";
	document.forms[0].submit();
}

function callOnLoad()
{
}
</script>
<style>
.mailbox_container
{
	width: 100%;
	height: 350px;
	overflow: auto;
}
</style>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"	type="text/css">
</head>
<body onload=callOnLoad()>
<form>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td valign="top" colSpan="5"> 
       <jsp:include page="../crlink/PSB59ApplicationDetails.jsp" flush="true" /> 
    </td>
  </tr>
</table>
</form>
<form name="appform" method="post" action="">
<table width="98%" border="1" cellpadding="3" cellspacing="0" bordercolorlight="#cccccc" bordercolordark="#FFFFFB" class="shadow" align="center">
<tr><td>     
<table width="90%" cellspacing="0" cellpadding="3" align="center" class="shadow">        
<tr class="dataheader" align="center">
	<td >
	<font size="2"><b>ELIGIBILITY PRODUCT DETAILS</b></font></td></tr>
	<tr class="datagrid">
		<td>
		<div id="top2">
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<col width="6%">
		<col width="10%">
		<col width="6%">
		<col width="10%">
		<col width="6%">
		<col width="10%">
		<tr height="30px">
			<td><b>FP Product Id</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_FPPRODUCTID"))%></td>
			<td><b>Account Balance</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_ACCOUNTBALANCE"))%></td>
			<td><b>Loan Ratio</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_LOANTRATIO"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Net Eligible Finance</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_NETELIGIBLEFINANCE"))%></td>
			<td><b>Required Loan Amount</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_REQUIREDLOANAMT"))%></td>
			<td><b>Max Loan Amount</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_MAXLOANAMT"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Max Loan Cap</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_MAXLOANCAP"))%></td>
			<td><b>Existing Loan Amount</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_EXISTINGLOANAMT"))%></td>
			<td><b>ROI</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_ROI"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Tenure</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_TENURE"))%></td>
			<td><b>Final Loan Amount</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_FINALLOANAMT"))%></td>
			<td><b>EMI</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_EMI"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Application Type</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_APPLICATIONTYPE"))%></td>
			<td><b>Machinery Cost</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_COSTOFMACHINERY"))%></td>
			<td><b>Promoter Contribution</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_PROMOTERCONTRIBUTION"))%></td>
		</tr>
		</table>
		</td></tr>
		</div>
		</td>
	</tr>
</table>
</td></tr>
</table>
<table border="0" cellspacing="0" cellpadding="0"  align="center">
      <tr valign="middle"> 
       <td>  
            <input type="button" name="cmdclose" value="Close" style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="callclose()"> 
        </td>
      </tr>
</table>

<input type="hidden" name="hidAction"> 
<input type="hidden" name="hidBeanMethod">
 <input type="hidden"name="hidBeanId"> 
 <input type="hidden" name="hidSourceUrl"> 
 <input type="hidden" name="hidBeanGetMethod">
</form>
</body>
</html>

