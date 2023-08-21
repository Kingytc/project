<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<lapschoice:handleerror />
<%
session.setAttribute("CURRENT_TAB","PROPERTY_DETAILS");
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
</head>
<body onload=callOnLoad()>
<form>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td valign="top" colSpan="5"> 
      <jsp:include page="PSB59ApplicationDetails.jsp"> </jsp:include>
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
	<font size="2">PROPERTY DETAILS</font></td></tr>
	<tr class="datagrid">
		<td>
		<div id="top2">
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="left" class="outertable">
		<col width="6%">
		<col width="10%">
		<col width="6%">
		<col width="10%">
		<col width="6%">
		<col width="10%">
		<tr height="30px">
			<td>ID</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPPRD_ID"))%></td>
			<td>Application Reference ID</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPPRD_APPLICATIONREFERENCEID"))%></td>
			<td>Purpose Of Loan</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPPRD_PURPOSEOFLOAN"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Seller Name</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPPRD_SELLERNAME"))%></td>
			<td>Type Of Property</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPPRD_TYPEOFPROPERTY"))%></td>
			<td>Type Of Area</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPPRD_TYPEOFAREA"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Area Of Property</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPPRD_AREAOFPROPERTY"))%></td>
			<td>Age Of Property</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPPRD_AGEOFPROPERTY"))%></td>
			<td>Cost Of Property</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPPRD_COSTOFPROPERTY"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Resignation Fee</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPPRD_REGISTRATIONFEE"))%></td>
			<td>Stamp Duty</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPPRD_STAMPDUTY"))%></td>
			<td>Loan Amount Required</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPPRD_LOANAMOUNTREQUIRED"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Application Contribution</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPPRD_APPLICANTCONTRIBUTION"))%></td>
			<td>Other Cost</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPPRD_OTHERCOST"))%></td>
			<td>Repayment Mode</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPPRD_REPAYMENTMODE"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Tenure</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPPRD_TENURE"))%></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr></tr>
		</table>
		</td></tr>
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
			<td width="20%">Address Domain</td>
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
			<td>Street Name</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPAD_STREET_NAME"))%></td>
			<td>Landmark</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPAD_LANDMARK"))%></td>
			<td>Village</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPAD_VILLAGE"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Block</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPAD_BLOCK"))%></td>
			<td>Sub District</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPAD_SUB_DISTRICT"))%></td>
			<td>District Name</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPAD_DISTRICT_NAME"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>City Name</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPAD_CITY_NAME"))%></td>
			<td>Pincode</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPAD_PIN_CODE"))%></td>
			<td>State Name</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPAD_STATE_NAME"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Country Name</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPAD_COUNTRY_NAME"))%></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr></tr>
		</table>
		</td></tr>
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
			<td width="20%">Seller's Address Domain</td>
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
			<td>Street Name</td>
			<td><%=Helper.correctNull((String) hshValues.get("SELL_NPAD_STREET_NAME"))%></td>
			<td>Landmark</td>
			<td><%=Helper.correctNull((String) hshValues.get("SELL_NPAD_LANDMARK"))%></td>
			<td>Village</td>
			<td><%=Helper.correctNull((String) hshValues.get("SELL_NPAD_VILLAGE"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Block</td>
			<td><%=Helper.correctNull((String) hshValues.get("SELL_NPAD_BLOCK"))%></td>
			<td>Sub District</td>
			<td><%=Helper.correctNull((String) hshValues.get("SELL_NPAD_SUB_DISTRICT"))%></td>
			<td>District Name</td>
			<td><%=Helper.correctNull((String) hshValues.get("SELL_NPAD_DISTRICT_NAME"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>City Name</td>
			<td><%=Helper.correctNull((String) hshValues.get("SELL_NPAD_CITY_NAME"))%></td>
			<td>Pincode</td>
			<td><%=Helper.correctNull((String) hshValues.get("SELL_NPAD_PIN_CODE"))%></td>
			<td>State Name</td>
			<td><%=Helper.correctNull((String) hshValues.get("SELL_NPAD_STATE_NAME"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Country Name</td>
			<td><%=Helper.correctNull((String) hshValues.get("SELL_NPAD_COUNTRY_NAME"))%></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr></tr>
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
		<input type="button" name="cmdclose" value="Close" class="buttonClose" onClick="callclose();">
	
            
        </td></tr></table>
</table>

<input type="hidden" name="hidAction"> 
<input type="hidden" name="hidBeanMethod">
 <input type="hidden"name="hidBeanId"> 
 <input type="hidden" name="hidSourceUrl"> 
 <input type="hidden" name="hidBeanGetMethod">
</form>
</body>
</html>

