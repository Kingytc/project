<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />        
<lapschoice:handleerror />
<%
session.setAttribute("CURRENT_TAB","PERSONAL_DETAILS");
ArrayList arrRow = (ArrayList)hshValues.get("arrRow"); 
ArrayList arrCol=new ArrayList();

String Refno=Helper.correctNull((String) hshValues.get("NPAAPD_APP_REF_ID"));
if(Refno.equalsIgnoreCase(""))
{
	Refno= (String) session.getAttribute("Refno");
}
String strSegType=Helper.correctNull((String) hshValues.get("NPAAPD_APP_REF_ID"));

if(strSegType.equalsIgnoreCase("")){
	strSegType= (String) session.getAttribute("strSegType");	
}

session.setAttribute("Refno",Refno);

session.setAttribute("strSegType",strSegType);

%>

<html>
<head>
<title>National Portal - Personal Details</title>
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
<table width="98%" border="0" cellpadding="3" cellspacing="0" class="outertable" align="center">
<tr><td>     
<table width="100%" cellspacing="0" cellpadding="3" align="center" class="outertable">        
<tr class="dataheader" align="center">
	<td >
	<font size="2"> PERSONAL DETAILS </font></td></tr>
	<tr class="datagrid">
		<td>
			<div id="top2">
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td width="20%"> Request </td>
			</tr>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			
		    <tr>
				<td> Application Reference ID </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPD_APP_REF_ID"))%></td>
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
				<td width="20%"> Response </td>
			</tr>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			
			<tr  >
				<td> ID </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPD_ID"))%></td>
				<td> Application Reference Id </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPD_APP_REF_ID"))%></td>
				<td> Salutation Id </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPD_SALUTATION_ID"))%></td>
			</tr>
			<tr></tr>
			<tr  >
				<td> Salutation </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPD_SALUTATION"))%></td>
				<td> First Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPD_FIRST_NAME"))%></td>
				<td> Middle Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPD_MIDDLE_NAME"))%></td>
			</tr>
			<tr></tr>
			<tr  >
				<td> Last Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPD_LAST_NAME"))%></td>
				<td> Date Of Birth </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPD_DATE_OF_BIRTH"))%></td>
				<td> Father Or Husband Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPD_FATHER_OR_HUSBAND_NAME"))%></td>
			</tr>
			<tr></tr>
			<tr  >
				<td> Mother Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPD_MOTHER_NAME"))%></td>
				<td> Mobile Number </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPD_MOBILE"))%></td>
				<td> Email </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPD_EMAIL"))%></td>
			</tr>
			<tr></tr>
			<tr  >
				<td> Education Qualification Id </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPD_EDU_QUALIFICATION_ID"))%></td>
				<td> Education Qualification </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPD_EDU_QUALIFICATION"))%></td>
				<td></td>
				<td></td>
			</tr>
			<tr></tr>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td width="20%"> Aadhaar Address </td>
			</tr>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			
			<tr  >
				<td> Street Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_STREET_NAME"))%></td>
				<td> Land Mark </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_LANDMARK"))%></td>
				<td> Country Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_COUNTRY_NAME"))%></td>
			</tr>
			<tr></tr>
			<tr  >
				<td> State Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_STATE_NAME"))%></td>
				<td> District Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_DISTRICT_NAME"))%></td>
				<td> City Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_CITY_NAME"))%></td>
			</tr>
			<tr></tr>
			<tr  >
				<td> Sub District </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_SUB_DISTRICT"))%></td>
				<td> Village </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_VILLAGE"))%></td>
				<td> Pincode </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_PIN_CODE"))%></td>
			</tr>
			<tr></tr>
			<tr  >
				<td> State Code </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_STATE_CODE"))%></td>
				<td> District Code </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_DISTRICT_CODE"))%></td>
				<td> Sub District Code </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_SUB_DISTRICT_CODE"))%></td>
			</tr>
			<tr></tr>
			<tr  >
				<td> Village Code </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_VILLAGE_CODE"))%></td>
				<td> Block Code </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_BLOCK_CODE"))%></td>
				<td> Block </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_BLOCK"))%></td>
			</tr>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td width="20%"> Current Address </td>
			</tr>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			
			<tr  >
				<td> Street Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_STREET_NAME"))%></td>
				<td> Land Mark </td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_LANDMARK"))%></td>
				<td> Country Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_COUNTRY_NAME"))%></td>
			</tr>
			<tr></tr>
			<tr  >
				<td> State Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_STATE_NAME"))%></td>
				<td> District Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_DISTRICT_NAME"))%></td>
				<td> City Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_CITY_NAME"))%></td>
			</tr>
			<tr></tr>
			<tr  >
				<td> Sub District </td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_SUB_DISTRICT"))%></td>
				<td> Village </td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_VILLAGE"))%></td>
				<td> Pincode </td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_PIN_CODE"))%></td>
			</tr>
			<tr></tr>
			<tr  >
				<td> State Code </td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_STATE_CODE"))%></td>
				<td> District Code </td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_DISTRICT_CODE"))%></td>
				<td> Sub District Code </td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_SUB_DISTRICT_CODE"))%></td>
			</tr>
			<tr></tr>
			<tr  >
				<td> Village Code </td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_VILLAGE_CODE"))%></td>
				<td> Block Code </td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_BLOCK_CODE"))%></td>
				<td> Block </td>
				<td><%=Helper.correctNull((String) hshValues.get("CURR_NPAD_BLOCK"))%></td>
			</tr>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td width="20%"> Institution Address </td>
			</tr>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		
			<tr  >
				<td> Street Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("INST_NPAD_STREET_NAME"))%></td>
				<td> Land Mark </td>
				<td><%=Helper.correctNull((String) hshValues.get("INST_NPAD_LANDMARK"))%></td>
				<td> Country Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("INST_NPAD_COUNTRY_NAME"))%></td>
			</tr>
			<tr></tr>
			<tr  >
				<td> State Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("INST_NPAD_STATE_NAME"))%></td>
				<td> District Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("INST_NPAD_DISTRICT_NAME"))%></td>
				<td> City Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("INST_NPAD_CITY_NAME"))%></td>
			</tr>
			<tr></tr>
			<tr  >
				<td> Sub District </td>
				<td><%=Helper.correctNull((String) hshValues.get("INST_NPAD_SUB_DISTRICT"))%></td>
				<td> Village </td>
				<td><%=Helper.correctNull((String) hshValues.get("INST_NPAD_VILLAGE"))%></td>
				<td> Pincode </td>
				<td><%=Helper.correctNull((String) hshValues.get("INST_NPAD_PIN_CODE"))%></td>
			</tr>
			<tr></tr>
			<tr  >
				<td> State Code </td>
				<td><%=Helper.correctNull((String) hshValues.get("INST_NPAD_STATE_CODE"))%></td>
				<td> District Code </td>
				<td><%=Helper.correctNull((String) hshValues.get("INST_NPAD_DISTRICT_CODE"))%></td>
				<td> Sub District Code </td>
				<td><%=Helper.correctNull((String) hshValues.get("INST_NPAD_SUB_DISTRICT_CODE"))%></td>
			</tr>
			<tr></tr>
			<tr  >
				<td> Village Code </td>
				<td><%=Helper.correctNull((String) hshValues.get("INST_NPAD_VILLAGE_CODE"))%></td>
				<td> Block Code </td>
				<td><%=Helper.correctNull((String) hshValues.get("INST_NPAD_BLOCK_CODE"))%></td>
				<td> Block </td>
				<td><%=Helper.correctNull((String) hshValues.get("INST_NPAD_BLOCK"))%></td>
			</tr>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td width="20%"> Is Current Add Same </td>
			</tr>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			
		    <tr  >
				<td> Marital Status Id </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPD_MARITAL_STATUS_ID"))%></td>
				<td> Marital Status </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPD_MARITAL_STATUS"))%></td>
				<td> Social Category Id </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPD_SOCIAL_CATEGORY_ID"))%></td>
			</tr>
			<tr></tr>
			<tr  >
				<td> Social Category </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPD_SOCIAL_CATEGORY"))%></td>
				<td> Total Experience Year </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPD_TOTAL_EXP_YEAR"))%></td>
				<td> Residential Status Id </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPD_RESIDENTIAL_STATUS_ID"))%></td>
			</tr>
			<tr></tr>
			<tr  >
				<td> Residential Status </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPD_RESIDENTIAL_STATUS"))%></td>
				<td> Institution </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPD_INSTITUTION"))%></td>
				<td> Institution Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPD_INSTITUTION_NAME"))%></td>
			</tr>
			<tr></tr>
			<tr  >
				<td> Marks Obtain </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPD_MARKS_OBTAIN"))%></td>
				<td> Training Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPD_TRAINING_NAME"))%></td>
				<td> Training Id </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPD_TRAINING_ID"))%></td>
			</tr>
			<tr></tr>
			<tr  >
				<td> Training Description </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPD_TRAINING_DESC"))%></td>
				<td> Gender Id </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPD_GENDER_ID"))%></td>
				<td> Gender </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPD_GENDER"))%></td>
			</tr>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td width="20%"> Agri Applicant PAN Details Proxy </td>
			</tr>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			
			
			
			
			
			
		    <tr  >
				<td> Pan </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPDP_PAN"))%></td>
				<td> First Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPDP_FIRST_NAME"))%></td>
				<td> Middle Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPDP_MIDDLE_NAME"))%></td>
			</tr>
			<tr></tr>
			<tr  >
				<td> Last Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPDP_LAST_NAME"))%></td>
				<td> Entity Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPDP_ENTITY_NAME"))%></td>
				<td> Entity Type </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAAPDP_ENTITY_TYPE"))%></td>
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
		<input type="button" name="cmdclose" value="Close" class="buttonClose" onClick="callclose();">
	
            
        </td></tr></table>
</table>
<input type="hidden" name="hidUserId" value="">

</form>
</body>
</html>