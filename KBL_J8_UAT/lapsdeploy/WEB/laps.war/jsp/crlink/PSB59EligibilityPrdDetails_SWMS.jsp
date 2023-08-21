<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<lapschoice:handleerror />
<%
session.setAttribute("CURRENT_TAB","ELIGIBILITY_DETAILS");
ArrayList arryCol = null;
ArrayList arryRow = (ArrayList) hshValues.get("arryRow");%>

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
<%-- <link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"> --%>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/NationalPortal.css" type="text/css">
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
	<font size="2"><b>BASIC ELIGIBILITY & ELIGIBILITY PRODUCT DETAILS</b></font></td></tr>
	<tr class="datagrid">
		<td>
		<div id="top2">
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
			<td width="50%"><font size="2"><b>Basic Eligibility</b></font></td>
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
		
		  
     <tr align="center" >
      <td width="50%"><font size="2"><b>Questions</b></font></td>
      <td valign="top" width="50%"><font size="2"><b>Answer</b></font></td>
      </tr>
       <%if (arryRow != null && arryRow.size() > 0) {
				for (int i = 0; i < arryRow.size(); i++) {
					arryCol = (ArrayList) arryRow.get(i);%>
					<tr valign="top" align="center">
					
					      <td width="50%"><font size="2"><%=i+1%>.&nbsp;<%=Helper.correctNull((String) arryCol.get(3))%>&nbsp;</font></td>
					      <td valign="top" width="50%"><font size="2"><%=Helper.correctNull((String) arryCol.get(2))%>&nbsp;</font></td>
					</tr>
					<%}
			}%>
			</table>
		</td></tr>
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
			<td width="20%"><font size="2"><b>Eligibility Product Details</b></font></td>
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
			<td><font size="2"><b>Id</b></font></td>
			<td><font size="2"><%=Helper.correctNull((String) hshValues.get(""))%></font></td>
			<td><font size="2"><b>Application Reference Id</b></font></td>
			<td><font size="2"><%=Helper.correctNull((String) hshValues.get("EPD_APPLICATIONREFID"))%></font></td>
			<td><font size="2"><b>FP Product Id</b></font></td>
			<td><font size="2"><%=Helper.correctNull((String) hshValues.get("EPD_FPPRODUCTID"))%></font></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><font size="2"><b>Final Estimated Sales</b></font></td>
			<td><font size="2"><%=Helper.correctNull((String) hshValues.get("EPD_FINALESTIMATEDSALES"))%></font></td>
			<td><font size="2"><b>Working Capital Requirement</b></font></td>
			<td><font size="2"><%=Helper.correctNull((String) hshValues.get("EPD_WORKINGCAPITALREQ"))%></font></td>
			<td><font size="2"><b>Total Finance</b></font></td>
			<td><font size="2"><%=Helper.correctNull((String) hshValues.get("EPD_TOTFINANCE"))%></font></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><font size="2"><b>Promoter Contribution</b></font></td>
			<td><font size="2"><%=Helper.correctNull((String) hshValues.get("EPD_PROMOTERCONTRIBUTION"))%></font></td>
			<td><font size="2"><b>Net Eligible Finance</b></td>
			<td><font size="2"><%=Helper.correctNull((String) hshValues.get("EPD_NETELIGIBLEFINANCE"))%></font></td>
			<td><font size="2"><b>Required Loan Amount</b></font></td>
			<td><font size="2"><%=Helper.correctNull((String) hshValues.get("EPD_REQUIREDLOANAMT"))%></font></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><font size="2"><b>Max Loan Amount</b></font></td>
			<td><font size="2"><%=Helper.correctNull((String) hshValues.get("EPD_MAXLOANAMT"))%></font></td>
			<td><font size="2"><b>Max Loan Cap</b></font></td>
			<td><font size="2"><%=Helper.correctNull((String) hshValues.get("EPD_MAXLOANCAP"))%></font></td>
			<td><font size="2"><b>Existing Loan Amount</b></font></td>
			<td><font size="2"><%=Helper.correctNull((String) hshValues.get("EPD_EXISTINGLOANAMT"))%></font></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><font size="2"><b>Final Loan Amount</b></font></td>
			<td><font size="2"><%=Helper.correctNull((String) hshValues.get("EPD_FINALLOANAMT"))%></font></td>
			<td><font size="2"><b>EMI</b></font></td>
			<td><font size="2"><%=Helper.correctNull((String) hshValues.get("EPD_EMI"))%></font></td>
			<td><font size="2"><b>Tenure</b></font></td>
			<td><font size="2"><%=Helper.correctNull((String) hshValues.get("EPD_TENURE"))%></font></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><font size="2"><b>ROI</b></font></td>
			<td><font size="2"><%=Helper.correctNull((String) hshValues.get("EPD_ROI"))%></font></td>
			<td><font size="2"><b>Cost Of Machinery</b></font></td>
			<td><font size="2"><%=Helper.correctNull((String) hshValues.get("EPD_COSTOFMACHINERY"))%></font></td>
			<td><font size="2"><b>Application Type</b></font></td>
			<td><font size="2"><%=Helper.correctNull((String) hshValues.get("EPD_APPLICATIONTYPE"))%></font></td>
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

