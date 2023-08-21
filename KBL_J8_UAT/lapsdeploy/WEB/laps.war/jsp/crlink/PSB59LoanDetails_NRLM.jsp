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
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function callclose()
{
	window.close();
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
      <jsp:include page="PSB59ApplicationDetails.jsp"> </jsp:include>
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
			<td><b>Purpose Of Loan</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			<td><b>Loan Amount</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			<td><b>Own Contribution</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Total Cost</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			<td><b>ULB Name</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			<td><b>ULB Code</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Income Source</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			<td><b>Type Of Employment</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			<td><b>Annual Income</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Annual Expenditure</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			<td><b>Nature Of EnterpriseId</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			<td><b>Nature Of Enterprise</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
		</tr>
		</table>
		</td></tr>
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
			<td width="20%"><b>Business Address</b></td>
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
			<td><b>Landmark</b></td>
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
			<td><b>Area Of Premise</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			<td><b>Micro Enterprise Type Id</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			<td><b>Area Of Premise Id</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Loan Type Id</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			<td><b>Loan Type</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
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

