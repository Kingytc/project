<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />        
<lapschoice:handleerror />
<%
session.setAttribute("CURRENT_TAB","PERSONAL_DETAILS");
ArrayList arrRow = (ArrayList)hshValues.get("arrRow"); 
ArrayList arrCol=new ArrayList();
String Refno=Helper.correctNull((String) hshValues.get("hidRefId"));
String strSegType=Helper.correctNull((String) hshValues.get("SegType"));
String strPOP_SCHEME_ID=Helper.correctNull((String) hshValues.get("POP_SCHEME_ID"));
if(strPOP_SCHEME_ID.equalsIgnoreCase(""))
{
	strPOP_SCHEME_ID=(String) session.getAttribute("POP_SCHEME_ID");
}
if(Refno.equalsIgnoreCase(""))
{
	Refno=Helper.correctNull((String) hshValues.get("Refno"));
}
if(Refno.equalsIgnoreCase(""))
{
	Refno=Helper.correctNull((String) hshValues.get("hidApplicantId"));
}


if(strSegType.equalsIgnoreCase("")){
	strSegType= (String) session.getAttribute("strSegType");	
}
session.setAttribute("Refno",Refno);
session.setAttribute("POP_SCHEME_ID",strPOP_SCHEME_ID);
session.setAttribute("strSegType",strSegType);


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
<tr align="center">
	<td >
	
	<h3 class="head"><B>PERSONAL DETAILS</B></h3>
	
	</td>
	</tr>
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
				<td><%=Helper.correctNull((String) hshValues.get("NPSL_ID"))%></td>
				<td><b>Application Reference ID</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSL_APP_REFID"))%></td>
				<td><b>Industry</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSL_IND"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Sector</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSL_SECTOR"))%></td>
				<td><b>Sub Sector</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSL_SUBSEC"))%></td>
				<td><b>Udyog No</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSL_UDYOGNO"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Business Premises</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSL_BUS_PREM"))%></td>
				<td><b>Promotor Contribution</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSL_PRO_CONTRBN"))%></td>
				<td><b>Product Service Description</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSL_PRD_SER_DES"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Existing Business Activity</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSL_EXIS_BUS_ACT"))%></td>
				<td><b>Proposed Business Activity</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSL_PRO_BUS_ACT"))%></td>
				<td><b>Total Loan Details</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSL_TOT_LOAN"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Total Machine Cost</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSL_TOT_MAC_COST"))%></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			</table>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td width="20%"><b>Std Loan Mapping Response Proxy List</b></td>
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
				<td><%=Helper.correctNull((String) hshValues.get("NPSP_APP_REF_ID"))%></td>
				<td><b>Facility Type</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSP_FAC_TYPE"))%></td>
				<td><b>Required Amount</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSP_REQ_AMT"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Purpose</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSP_PURPOSE"))%></td>
				<td><b>Primary Security Offered</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSP_PRIM_SEC_OFF"))%></td>
				<td><b>Collateral Security Offered</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSP_COLL_OFF"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Collateral Security Offered Id</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSP_COLL_OFF_ID"))%></td>
				<td><b>Collateral Security Details</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td></td>
				<td></td>
			</tr>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td width="20%"><b>Std Machinery Details Response Proxy List</b></td>
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
				<td><%=Helper.correctNull((String) hshValues.get("NPSM_APP_REF_ID"))%></td>
				<td><b>Machine Type</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSM_MAC_TYPE"))%></td>
				<td><b>Requirement Purpose</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSM_REQ_PURP"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Imported Indigenous</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSM_IMP_INDI"))%></td>
				<td><b>Supplier Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSM_SUPP_NAME"))%></td>
				<td><b>Basic Cost</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSM_BASIC_COST"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Freight</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSM_FREIGHT"))%></td>
				<td><b>Insurance</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSM_INSURANCE"))%></td>
				<td><b>Custom Duty</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSM_CUST_DUTY"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Total Machine Cost</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSM_TOT_MAC_COST"))%></td>
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
				<td width="20%"><b>Std Statutory Details Response Proxy List</b></td>
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
				<td><%=Helper.correctNull((String) hshValues.get("NPSS_APP_REF_ID"))%></td>
				<td><b>Type Id</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSS_TYPE_ID"))%></td>
				<td><b>Type Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSS_TYPE_NAME"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Compiled With</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSS_COMP"))%></td>
				<td><b>Registration Date</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSS_REG_DATE"))%></td>
				<td><b>Registration Number</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSS_REG_NO"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Drug License Number</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSS_DRUG_NO"))%></td>
				<td><b>Amount</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPSS_AMOUNT"))%></td>
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