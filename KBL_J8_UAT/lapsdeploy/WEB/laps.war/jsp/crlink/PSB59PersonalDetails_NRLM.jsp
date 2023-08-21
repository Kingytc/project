<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />        
<lapschoice:handleerror />
<%
session.setAttribute("CURRENT_TAB","PERSONAL_DETAILS");
ArrayList arrRow = (ArrayList)hshValues.get("arrRow"); 
ArrayList arrCol=new ArrayList();
%>

<html>
<head>
<title>National Portal - Personal Details</title>
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
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"	type="text/css">
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
<form name="" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td valign="top" colSpan="5"> 
      <jsp:include page="PSB59ApplicationDetails.jsp"> </jsp:include>
    </td>
  </tr>
</table> 
<table width="98%" border="1" cellpadding="3" cellspacing="0" bordercolorlight="#cccccc" bordercolordark="#FFFFFB" class="shadow" align="center">
<tr><td>     
<table width="90%" cellspacing="0" cellpadding="3" align="center" class="shadow">        
<tr class="dataheader" align="center">
	<td >
	<font size="2"><b>PERSONAL DETAILS</b></font></td></tr>
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
				<td><b>ID</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Application Reference ID</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Salutation</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>First Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Middle Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Last Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Father Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Gender</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Date Of Birth</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Social Category</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Minority ID</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Minority</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Mobile Number</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Email</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Marital Status</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Alternate Mobile No</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Handicapped</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>No Of Dependants</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>No Of Children</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Education Qualification</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Is Current Address Same</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Residing Month</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Residing Year</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Is Skill Certification</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Registered With Government</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Has PMSBY</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Marketing Agreement</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Line Trade Experience Year</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Line Trade Experience Month</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td></td>
				<td></td>
			</tr>
			</table>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td width="20%"><b>Other Details</b></td>
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
				<td><b>Other Earning Member</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Saving Balance</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Social Category ID</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Marketing Agreement</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Is SHG Member</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Is Street Vendor</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Educational Qualification</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Marital Status</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td></td>
				<td></td>
			</tr>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td width="20%"><b>Aadhaar Address</b></td>
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
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Land Mark</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Village</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>District Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Sub District</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Village Code</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>District Code</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>City Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Pincode</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Sub District Code</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Village Code</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>State Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>State Code</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Country Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Block</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Block Code</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
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
				<td width="20%"><b>Current Address</b></td>
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
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Land Mark</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Village</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>District Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Sub District</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Village Code</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>District Code</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>City Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Pincode</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Sub District Code</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Village Code</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>State Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>State Code</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Country Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Block</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Block Code</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
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