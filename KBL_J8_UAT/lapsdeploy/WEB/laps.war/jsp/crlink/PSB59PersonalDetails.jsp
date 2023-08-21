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
if(Refno.equalsIgnoreCase(""))
{
	Refno=Helper.correctNull((String) hshValues.get("Refno"));
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



function callOnLoad()
{

}
function callclose()
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mainnav.jsp";
	document.forms[0].submit();
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
</style>

 <link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/NationalPortal.css" type="text/css">
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
	<font size="2">PERSONAL DETAILS</font></td></tr>
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
				<td>ID</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_APPID"))%></td>
				<td>Application Reference ID</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_APP_REF_ID"))%></td>
				<td>Salutation</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_SALUTION"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td>First Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_LHPD_F_NAME"))%></td>
				<td>Middle Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_LHPD_M_NAME"))%></td>
				<td>Last Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_LHPD_L_NAME"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td>Father Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_FATHER_NAME"))%></td>
				<td>Gender</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_GENDER"))%></td>
				<td>Date Of Birth</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_DATE_OF_BIRTH"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td>Social Category</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_SOCI_CATE"))%></td>
				<td>Minority ID</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_MINORITYID"))%></td>
				<td>Minority</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_MINORITY"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td>Mobile Number</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_MOBILE"))%></td>
				<td>Email</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_EMAIL"))%></td>
				<td>Marital Status</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_MARITAL_STATUS"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td>Alternate Mobile No</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_ALT_MOB"))%></td>
				<td>Handicapped</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_IS_HANDICAP"))%></td>
				<td>No Of Dependants</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_NO_DEPENDANTS"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td>No Of Children</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_NO_CHILDREN"))%></td>
				<td>Education Qualification</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_EDU_QUAL"))%></td>
				<td>Is Current Address Same</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_IS_CURR_ADD_SAME"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td>Residing Month</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_RESI_MONTH"))%></td>
				<td>Residing Year</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_RESI_YEAR"))%></td>
				<td>Is Skill Certification</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_IS_SKILL_CERT"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td>Registered With Government</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_IS_REG_GOV"))%></td>
				<td>Has PMSBY</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_HAS_PMSBY"))%></td>
				<td>Marketing Agreement</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_MARK_ARRANGE"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td>Line Trade Experience Year</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_LT_EXP_YEAR"))%></td>
				<td>Line Trade Experience Month</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_LT_EXP_MONTH"))%></td>
				<td></td>
				<td></td>
			</tr>
			</table>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td width="20%">Other Details</td>
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
				<td>Other Earning Member</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_OTH_EARNING_MEM"))%></td>
				<td>Saving Balance</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_SAVING_BAL"))%></td>
				<td>Social Category ID</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_SOC_CAT_ID"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td>Marketing Agreement</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_MARK_ARRANGE"))%></td>
				<td>Is SHG Member</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_IS_SHG_MEM"))%></td>
				<td>Is Street Vendor</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_IS_STREET_VEND"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td>Educational Qualification</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_EDU_QUAL"))%></td>
				<td>Marital Status</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPLPD_MARITAL_STATUS"))%></td>
				<td></td>
				<td></td>
			</tr>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td width="20%">Aadhaar Address</td>
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
				<td>Land Mark</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_LANDMARK"))%></td>
				<td>Village</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_VILLAGE"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td>District Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_DISTRICT_NAME"))%></td>
				<td>Sub District</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_SUB_DISTRICT"))%></td>
				<td>Village Code</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_VILLAGE_CODE"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td>District Code</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_DISTRICT_CODE"))%></td>
				<td>City Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_CITY_NAME"))%></td>
				<td>Pincode</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_PIN_CODE"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td>Sub District Code</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_SUB_DISTRICT_CODE"))%></td>
				<td>Village Code</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_VILLAGE_CODE"))%></td>
				<td>State Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_STATE_NAME"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td>State Code</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_STATE_CODE"))%></td>
				<td>Country Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_COUNTRY_NAME"))%></td>
				<td>Block</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_BLOCK"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td>Block Code</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_BLOCK_CODE"))%></td>
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
				<td width="20%">Current Address</td>
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
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_STREET_NAME"))%></td>
				<td>Land Mark</td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_LANDMARK"))%></td>
				<td>Village</td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_VILLAGE"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td>District Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_DISTRICT_NAME"))%></td>
				<td>Sub District</td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_SUB_DISTRICT"))%></td>
				<td>Village Code</td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_VILLAGE_CODE"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td>District Code</td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_DISTRICT_CODE"))%></td>
				<td>City Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_CITY_NAME"))%></td>
				<td>Pincode</td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_PIN_CODE"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td>Sub District Code</td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_SUB_DISTRICT_CODE"))%></td>
				<td>Village Code</td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_VILLAGE_CODE"))%></td>
				<td>State Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_STATE_NAME"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td>State Code</td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_STATE_CODE"))%></td>
				<td>Country Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_COUNTRY_NAME"))%></td>
				<td>Block</td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_BLOCK"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td>Block Code</td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_BLOCK_CODE"))%></td>
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
<table border="0" cellspacing="0" cellpadding="0"  align="center">
      <tr valign="middle"> 
       <td> 
		<input type="button" name="cmdclose" value="Close" class="buttonClose" onClick="callclose();">
	
            
        </td></tr></table>
</table>

<input type="hidden" name="hidUserId" value="">

</form>
</body>
</html>