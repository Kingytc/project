<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<lapschoice:handleerror />
<%
session.setAttribute("CURRENT_TAB","ASSOCON_DETAILS");
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
	<font size="2">ASSOCIATE CONCERN DETAILS</font></td></tr>
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
			<td>Any Associate Concern True</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPACD_ANY_ASSOCIATE_CONCERN"))%></td>
			<td>No Of Associate Concern</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPACD_NOOF_ASSOCIATE_CONCERN"))%></td>
			<td>Associate Name</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPACD_ASSOCIATE_NAME"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Banking With</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPACD_BANKING_WITH"))%></td>
			<td>Stake</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPACD_STAKE"))%></td>
			<td>Association Constitution</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPACD_CONSTITUTION"))%></td>
		</tr>
		</table>
		</td></tr>
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
			<td width="20%">Association Address Master</td>
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
			<td>Id</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPAD_ID"))%></td>
			<td>Street Name</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPAD_STREET_NAME"))%></td>
			<td>Landmark</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPAD_LANDMARK"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Country Name</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPAD_COUNTRY_NAME"))%></td>
			<td>State Name</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPAD_STATE_NAME"))%></td>
			<td>District Name</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPAD_DISTRICT_NAME"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>City Name</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPAD_CITY_NAME"))%></td>
			<td>Sub District</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPAD_SUB_DISTRICT"))%></td>
			<td>Village</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPAD_VILLAGE"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Pincode</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPAD_PIN_CODE"))%></td>
			<td>Block</td>
			<td><%=Helper.correctNull((String) hshValues.get("NPAD_BLOCK"))%></td>
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

