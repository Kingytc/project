<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />        
<lapschoice:handleerror />
<%
session.setAttribute("CURRENT_TAB","PROJLOAN_DETAILS");
ArrayList arrRow = (ArrayList)hshValues.get("arrRow"); 
ArrayList arrCol=new ArrayList();
%>

<html>
<head>
<title>National Portal - Project and Loan Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
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
	<font size="2"><b>PROJECT AND LOAN DETAILS</b></font></td></tr>
	<tr class="datagrid">
		<td>
			<div id="top2">
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td width="20%"><b>Request</b></td>
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
				<td><b>Application Reference ID</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NLD_APP_REF_ID"))%></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td width="20%"><b>Response</b></td>
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
				<td><b>ID</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NLD_ID"))%></td>
				<td><b>Application Reference Id</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NLD_APP_REF_ID"))%></td>
				<td><b>Own Contribution</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NLD_OWNCONTRIBUTION"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Required Loan Amount</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NLD_REQUIREDLOANAMT"))%></td>
				<td><b>Tenure</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NLD_TENURE"))%></td>
				<td><b>Eligible Subsidy</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NLD_ELIGIBLESUBSIDY"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Location True</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NLD_LOCATION"))%></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td width="20%"><b>Project Site Address</b></td>
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
				<td><b>Street Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_STREET_NAME"))%></td>
				<td><b>Land Mark</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_LANDMARK"))%></td>
				<td><b>Country Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_COUNTRY_NAME"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>State Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_STATE_NAME"))%></td>
				<td><b>District Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_DISTRICT_NAME"))%></td>
				<td><b>City Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_CITY_NAME"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Sub District</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_SUB_DISTRICT"))%></td>
				<td><b>Village</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_VILLAGE"))%></td>
				<td><b>Pincode</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_PIN_CODE"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>State Code</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_STATE_CODE"))%></td>
				<td><b>District Code</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_DISTRICT_CODE"))%></td>
				<td><b>Sub District Code</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_SUB_DISTRICT_CODE"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Village Code</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_VILLAGE_CODE"))%></td>
				<td><b>Block Code</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_BLOCK_CODE"))%></td>
				<td><b>Block</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_BLOCK"))%></td>
			</tr>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td width="20%"><b>Total Project Cost</b></td>
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
				<td><b>Land Ownership Id</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NLD_LANDOWNERSHIPID"))%></td>
				<td><b>Land Ownership</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NLD_LANDOWNERSHIP"))%></td>
				<td><b>No Of Owners</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NLD_NOOFOWNERS"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Type Of Project Id</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NLD_TYPEOFPROJECTID"))%></td>
				<td><b>Type Of Project</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NLD_TYPEOFPROJECT"))%></td>
				<td><b>Type Of Business Id</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NLD_TYPEOFBUSINESSID"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Type Of Business</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NLD_TYPEOFBUSINESS"))%></td>
				<td><b>Storage Capacity</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NLD_STORAGECAPACITY"))%></td>
				<td><b>Other Business Type</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NLD_OTHERBUSINESSTYPE"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Investment Plant And Machinery</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NLD_INVESTPLANT_MACH"))%></td>
				<td><b>Owner Names</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NLD_OWNERNAMES"))%></td>
				<td><b>Annual Revenue</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NLD_ANNUALREVENUE"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Is Other Benefited Scheme</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NLD_ISOTHERBEN_SCHEME"))%></td>
				<td><b>Other Benefited Scheme</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NLD_OTHERBEN_SCHEME"))%></td>
				<td></td>
				<td></td>
			</tr>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td width="20%"><b>Project Cost Details</b></td>
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
				<td><b>Application Reference Id</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPD_APP_REF_ID"))%></td>
				<td><b>Type Of Activity Id</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPD_TYPEOFACTIVITYID"))%></td>
				<td><b>Type Of Activity</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPD_TYPEOFACTIVITY"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Financial Outlay</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPD_FINANCIALOUTLAY"))%></td>
				<td><b>Type Id</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPD_TYPEID"))%></td>
				<td><b>Other Activity</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPD_OTHERACTIVITY"))%></td>
			</tr>
			</table>
			</td></tr>
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
</table>
</form>
</body>
</html>