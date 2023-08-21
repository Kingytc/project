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
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/NationalPortal.css" type="text/css">

</head>
<body onload=callOnLoad()>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td valign="top" colSpan="5"> 
      <jsp:include page="../crlink/PSB59ApplicationDetails.jsp" flush="true" /> 
    </td>
  </tr>
</table>

<form name="docVerForm" method="post" action="" class="normal">
<table width="98%" border="0" cellpadding="3" cellspacing="0" bordercolorlight="#cccccc" bordercolordark="#FFFFFB" class="shadow" align="center">
<tr><td>     
<table width="100%" cellspacing="0" cellpadding="3" align="center" class="shadow">        
<tr class="dataheader" align="center">
	<td >
	<font size="2">BASIC ELIGIBILITY & ELIGIBILITY PRODUCT DETAILS</font></td></tr>
	<tr class="datagrid">
		<td>
		<div id="top2">
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
			<td width="20%">Basic Eligibility</td>
		</tr>
		</table>
		</td></tr>
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="left" class="outertable">
		<col width="6%">
		<col width="10%">
		<col width="6%">
		<col width="10%">
		<col width="6%">
		<col width="10%">
		<tr height="30px">
			<td>Application Reference ID</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPBE_APPLICATION_REFERENCE_ID"))%></td>
			<td>Question</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPBE_QUESTION"))%></td>
			<td>Answer</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPBE_ANSWER"))%></td>
		</tr>
		</table>
		</td></tr>
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
			<td width="20%">Eligibility Product Details</td>
		</tr>
		</table>
		</td></tr>
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<col width="6%">
		<col width="10%">
		<col width="6%">
		<col width="10%">
		<col width="6%">
		<col width="10%">
		<tr height="30px">
			<td>Application Reference ID</td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_APPLICATIONREFID"))%></td>
			<td>Foproduct Id</td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_FPPRODUCTID"))%></td>
			<td>Gross Monthly Income</td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_GROSSMONTHLYINCOME"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Net Monthly Income</td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_NETMONTLYINCOME"))%></td>
			<td>Margin</td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_MARGIN"))%></td>
			<td>Income for EMI</td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_INCOMEFOREMI"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Existing EMI</td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_EXISTINGEMI"))%></td>
			<td>Available Income For New Loan</td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_AVAINCOMEFORNEWLOAN"))%></td>
			<td>ROI</td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_ROI"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Tenure</td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_TENURE"))%></td>
			<td>Per Lakh EMI</td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_PERLAKHEMI"))%></td>
			<td>Value To Consider For Loan Amount</td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_VALTOCONSIDERFORLOANAMT"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Lender NMI Months</td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_LENDERNMIMONTHS"))%></td>
			<td>Loan On NMI</td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_LOANONNMI"))%></td>
			<td>EMI NMI Rate</td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_EMINMIRATE"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Loan On EMI NMI</td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_LOANONEMINMI"))%></td>
			<td>Available Loan Amount</td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_AVALOANAMT"))%></td>
			<td>Required Loan Amount</td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_REQUIREDLOANAMT"))%></td>
		</tr>
		<tr></tr>
		<tr height="10px">
			<td>Fp Max Loan</td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_FPMAXLOAN"))%></td>
			<td>Final Loan Amount</td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_FINALLOANAMT"))%></td>
			<td>Proposed Final EMI</td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_PROPOSEDFINALEMI"))%></td>
		</tr>
		<tr></tr>
		<tr height="10px">
			<td>Final EMI</td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_FINALEMI"))%></td>
			<td>Final EMI NMI</td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_FINALEMINMI"))%></td>
			<td>Application Type</td>
			<td><%=Helper.correctNull((String) hshValues.get("EPD_APPLICATIONTYPE"))%></td>
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
      <!--  <td>  
            <input type="button" name="cmdsave" value="Save" style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="callsave()"> 
        </td>--> 
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

