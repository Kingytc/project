<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<lapschoice:handleerror />
<%
session.setAttribute("CURRENT_TAB","LOAN_DETAILS");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>

<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/NationalPortal.css" type="text/css">

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
<form name="docVerForm" method="post" action="" class="normal">
<table width="98%" border="0" cellpadding="3" cellspacing="0" bordercolorlight="#cccccc" bordercolordark="#FFFFFB" class="shadow" align="center">
<tr><td>     
<table width="100%" cellspacing="0" cellpadding="3" align="center" class="shadow">        
<tr class="dataheader" align="center">
	<td >
	<font size="2"><b>LOAN DETAILS</b></font></td></tr>
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
			<td><b>Application Reference ID</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("MUDRA_APP_REF_ID"))%></td>
			<td><b>Industry</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("MUDRA_INDUSTRY"))%></td>
			<td><b>Sector</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("MUDRA_SECTOR"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Sub Sector</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("MUDRA_SUBSECTOR"))%></td>
			<td><b>Product Service Description</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("MUDRA_PRD_SERVCE_DESC"))%></td>
			<td><b>Registration Number</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("MUDRA_REGN_NO"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Udyog Aadhar Memorandum No</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("UDYOG_AADHAR_MEMORANDUMNO"))%></td>
			<td><b>Business Premises</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("MUDRA_BUSINESS_PREMISIES"))%></td>
			<td><b>Any Marketing Arrangements</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("ANY_MARKETING_ARRANGMNT"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Business Activity Existing</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("BUSINESS_ACTIVITY_EXISTNG"))%></td>
			<td><b>Business Activity Proposed</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("BUSINESS_ACTIVITY_PROPOSD"))%></td>
			<td><b>Loan Amount Required</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("LOAN_AMNT_REQURD"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Promoter Contribution</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("MUDRA_PROMOTR_CONTRIBUTION"))%></td>
			<td><b>Purpose Of Loan</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("MUDRA_PURPOSE_OF_LOAN"))%></td>
			<td><b>Avg Monthly Sales</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("MUDRA_AVG_MONTHLY_SALES"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Raw Materials</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("MUDRA_RAW_MATERIALS"))%></td>
			<td><b>Wages</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("MUDRA_WAGES"))%></td>
			<td><b>Drawings Sustenance</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("MUDRA_DRAWINGS_SUSTENANCE"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Other Expenses</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("MUDRA_OTHER_EXPENSES"))%></td>
			<td><b>Total Expenses Of Working Capital</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("TOT_EXPNS_OF_WORKING_CAPTL"))%></td>
			<td><b>Monthly Sales</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("MUDRA_MONTHLY_SALES"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Projected Turnover</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("PROJECTD_TURNOVR"))%></td>
			<td><b>Projected Profit</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("PROJECTED_PROFIT"))%></td>
			<td><b>Commercial Operation Date</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("COMMERCIAL_OPERATN_DATE"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Id Drug License True</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("MUDRA_ID_DRUG_LICENSE"))%></td>
			<td><b>Is Statutory Dues True</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("IS_STATUTORY_DUES"))%></td>
			<td><b>Total Expenses Of Asset Acquisition</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("TOT_EXPNS_OF_ASTS_ACQT"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Tenure</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("MUDRA_TENURE"))%></td>
			<td><b></b></td>
			<td></td>
			<td><b></b></td>
			<td></td>
		</tr>
		</table>
		</td></tr>
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
			<td width="20%"><b>Mudra Asset Acquistion Details Proxies</b></td>
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
			<td><b>Type Of Machine</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("MUDRA_MACHINE_TYPE"))%></td>
			<td><b>Purpose Of Required</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("MUDRA_PURPOSE_OF_REQUIRMNT"))%></td>
			<td><b>Name Of Supplier</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("MUDRA_SUPPLIER_NAME"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Cost Of Machine</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("MUDRA_MACHINE_COST"))%></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
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

