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
<title>National Portal - In Principle Details</title>
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
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_APP_REF_ID"))%></td>
				<td><b>Salutation</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_SALUTATION"))%></td>
				<td><b>First Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_FIRST_NAME"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Last Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_LAST_NAME"))%></td>
				<td><b>Middle Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_MIDDLE_NAME"))%></td>
				<td><b>Pan</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_PAN"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Father Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_FATHER_NAME"))%></td>
				<td><b>Mother Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_MOTHER_NAME"))%></td>
				<td><b>Date Of Birth</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_DOB"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Gender Id</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_GENDER_ID"))%></td>
				<td><b>Gender</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_GENDER"))%></td>
				<td><b>Social Category</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_SOCIAL_CATEGORY"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Educational Qualification</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_EDU_QUALIFCTN"))%></td>
				<td><b>Mobile</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_MOBILE"))%></td>
				<td><b>Email</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_EMAIL"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Marital Status</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_MARITAL_STATUS"))%></td>
				<td><b>Present Monthly Income</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_PRESNT_MONTHLY_INCOME"))%></td>
				<td><b>Is Current Add Same</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_IS_CURRNT_ADD_SAME"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Weaver Card No</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_WEAVER_CARD_NO"))%></td>
				<td><b>Card Issue Date</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_CARD_ISSUE_DATE"))%></td>
				<td><b>Weaving Type</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_WEAVNG_TYPE"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Weaving Type Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_WEAVNG_TYPE_NAME"))%></td>
				<td><b>Owning Handloom</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_OWNG_HANDLOOM"))%></td>
				<td><b>Experience Handloom Weaving Years</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("EXP_HANDLOOM_WEAVNG_YRS"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Experience Handloom Weaving Months</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("EXP_HANDLOOM_WEAVNG_MONTHS"))%></td>
				<td><b>Other Business</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_OTHR_BUSNSS"))%></td>
				<td><b>Marketing Arrangement</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_MARKTNG_ARRANGMNT"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Total Sales</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_TOTAL_SALES"))%></td>
				<td><b>Machinery Cost</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_MACHNRY_COST"))%></td>
				<td><b>Business Prospects</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_BUSNSS_PROSPECTS"))%></td>
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
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_STREET_NAME"))%></td>
				<td><b>Land Mark</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_LANDMARK"))%></td>
				<td><b>Country Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_COUNTRY_NAME"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>State Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_STATE_NAME"))%></td>
				<td><b>District Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_DISTRICT_NAME"))%></td>
				<td><b>City Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_CITY_NAME"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Sub District</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_SUB_DISTRICT"))%></td>
				<td><b>Village</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_VILLAGE"))%></td>
				<td><b>Pincode</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_PIN_CODE"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Block</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_BLOCK"))%></td>
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
				<td><%=Helper.correctNull((String) hshValues.get("NPAA_STREET_NAME"))%></td>
				<td><b>Land Mark</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAA_LAND_MARK"))%></td>
				<td><b>Country Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAA_COUNTRY_NAME"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>State Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAA_STATE_NAME"))%></td>
				<td><b>District Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAA_DISTRICT_NAME"))%></td>
				<td><b>City Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAA_CITY_NAME"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Sub District</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAA_SUB_DISTRICT"))%></td>
				<td><b>Village</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAA_VILLAGE"))%></td>
				<td><b>Pincode</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAA_PIN_CODE"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Block</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td><b>Is DOB from Aadhaar</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_IS_DOB_FRM_AADHAR"))%></td>
				<td></td>
				<td></td>
			</tr>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td width="20%"><b>MSME SWMS Asset Details Proxies</b></td>
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
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_APP_REF_ID"))%></td>
				<td><b>Asset Type Id</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_ASSET_TYPE_ID"))%></td>
				<td><b>Description</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_DESCRIPTION"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Property Count</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_PROPERTY_COUNT"))%></td>
				<td><b>Present Value</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_PRESENT_VALUE"))%></td>
				<td><b>Asset Type</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_ASSET_TYPE"))%></td>
			</tr>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td width="20%"><b>MSME SWMS Buyer Details Proxies</b></td>
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
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_APP_REF_ID"))%></td>
				<td><b>Buyer Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_BUYER_NAME"))%></td>
				<td><b>Address</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_ADDRESS"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Mobile</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_MOBILE"))%></td>
				<td><b>Avg Monthly Receipt</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_AVG_MONTHLY_RECIEPT"))%></td>
				<td><b>MSME SWMS Applicant PAN Details Proxy</b></td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Pan</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_PAN"))%></td>
				<td><b>First Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_FIRST_NAME"))%></td>
				<td><b>Middle Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_MIDDLE_NAME"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td><b>Last Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_LAST_NAME"))%></td>
				<td><b>Entity Name</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_ENTITY_NAME"))%></td>
				<td><b>Entity Type</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("SWMS_ENTITY_TYPE"))%></td>
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

</form>
</body>
</html>