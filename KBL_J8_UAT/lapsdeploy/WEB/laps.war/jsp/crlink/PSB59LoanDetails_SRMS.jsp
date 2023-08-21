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
<table width="100%" cellspacing="0" cellpadding="3" align="center" class="shadow">        
<tr class="dataheader" align="center">
	<td >
	<font size="2"><b>LOAN DETAILS</b></font></td></tr>
	<tr class="datagrid">
		<td>
		<div id="top2">
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr >
			<td><b>Purpose Of Loan</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("NPSL_EQUIP_PURPOSE"))%></td>
			<td><b>Loan Amount</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("NPSL_LOAN_AMT"))%></td>
			<td><b>Previous Loan</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("NPSL_PREV_LOAN"))%></td>
			
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Total Cost</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("NPSL_EQUIP_COST"))%></td>
			<td><b>Repayment Period</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("NPSL_REPAY_PERIOD"))%></td>
			<td><b>Purpose Of Loan</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("NPSL_EQUIP_PURPOSE"))%></td>
			
			
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Purpose Id</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("NPSL_EQUIP_PURPOSE_ID"))%></td>
			<td><b>Contact No</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("NPSL_CONTACT_NO"))%></td>
			<td><b>Mechanize Name</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("NPSL_MECHANIZE_NAME"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Procurement Mechanism</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("NPSL_PROCUR_MECHANISM"))%></td>
			<td><b>Procurement Mechanism Id</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("NPSL_PROCUR_MECHANISM_ID"))%></td>
			<td><b>Status</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("NPSL_STATUS"))%></td>
			
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

