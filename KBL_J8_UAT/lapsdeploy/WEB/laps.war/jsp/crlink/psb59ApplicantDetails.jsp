<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />        
<lapschoice:handleerror />
<%
//String Id = request.getParameter("Id");
//String referId = request.getParameter("RefId");
%>
<%
session.setAttribute("CURRENT_TAB","APPLICANT_DETAILS");
ArrayList arrCol=new ArrayList();
ArrayList arrRow=new ArrayList();

if(hshValues!=null && hshValues.size()>0)
{
	arrRow=(ArrayList)(hshValues.get("arrRow"));
	
}
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
<title>National Portal - Applicants Details</title>
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
      <jsp:include page="PSB59ApplicationDetails.jsp"> </jsp:include>
    </td>
  </tr>
</table> 
<table width="98%" border="0" cellpadding="3" cellspacing="0" bordercolorlight="#cccccc" bordercolordark="#FFFFFB" class="shadow" align="center">
<tr><td>     
<table width="100%" cellspacing="0" cellpadding="3" align="center" class="shadow">        
<tr class="dataheader" align="center">
	<td >
	<font size="2">APPLICANT DETAILS</font></td></tr>
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
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_ROW_ID"))%></td>
				<td>Application Reference ID</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_APPLICATION_REFERENCE_ID"))%></td>
				<td></td>
				<td></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td>Salutation</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_SALUTATION"))%></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr height="30px">
				<td>First Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_FIRST_NAME"))%></td>
				<td>Middle Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_MIDDLE_NAME"))%></td>
				<td>Last Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_LAST_NAME"))%></td>
			</tr>
			<tr height="30px">
				<td>Gender</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_GENDER"))%></td>
				<td>Date Of Birth</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_DOB"))%></td>
				<td>Email</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_EMAIL"))%></td>
			</tr>
			<tr height="30px">
				<td>Social Category</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_SOCIAL_CATEGORY"))%></td>
				<td>Mobile</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_MOBILE_NUMBER"))%></td>
				<td>Marital Status</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_MARITAL_STATUS"))%></td>
			</tr>
			<tr height="30px">
				<td>Father's Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_FATHERS_NAME"))%></td>
				<td>Mother's Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_MOTHERS_NAME"))%></td>
				<td>Is Chairman</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_IS_CHAIRMAN"))%></td>
			</tr>
			<tr height="30px">
				<td>Relationship</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_RELATIONSHIP"))%></td>
				<td>Occupation</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_OCCUPATION"))%></td>
				<td>Remark</td>
				<td>&nbsp;</td>
			</tr>
			<tr height="30px">
				<td>Gross Monthly Income</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_GROSS_MONTHLY_INCOME"))%></td>
				<td>Residential Status</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_RESITANT_STATUS"))%></td>
				<td>Voter No</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_VOTER_NO"))%></td>
			</tr>
			<tr height="30px">
				<td>PAN Number</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_PAN_NO"))%></td>
				<td>Is Current Address Same</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_IS_CURR_ADD_SAME"))%></td>
				<td></td>
				<td></td>
			</tr>
			<tr height="30px">
				<td>Education Qualification</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_EDU_QUALIFICATION"))%></td>
				<td>Marks</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPPD_MARKS"))%></td>
				<td></td>
				<td></td>
			</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td width="20%">Current Address</td>
			</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<col width="6%">
			<col width="10%">
			<col width="6%">
			<col width="10%">
			<col width="6%">
			<col width="10%">
			<tr height="30px">
				<td>Street Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCA_STREET_NAME"))%></td>
				<td>LandMark</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCA_LAND_MARK"))%></td>
				<td>Village</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCA_VILLAGE"))%></td>
			</tr>
			<tr height="30px">
				<td>Sub District</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCA_SUB_DISTRICT"))%></td>
				<td>District Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCA_DISTRICT_NAME"))%></td>
				<td>City Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCA_CITY_NAME"))%></td>
			</tr>
			<tr height="30px">
				<td>Pin Code</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCA_PIN_CODE"))%></td>
				<td>State Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCA_STATE_NAME"))%></td>
				<td>Country Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCA_COUNTRY_NAME"))%></td>
			</tr>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td width="20%">Aadhaar Address</td>
			</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<col width="6%">
			<col width="10%">
			<col width="6%">
			<col width="10%">
			<col width="6%">
			<col width="10%">
			<tr height="30px">
				<td>Street Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAA_STREET_NAME"))%></td>
				<td>LandMark</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAA_LAND_MARK"))%></td>
				<td>Village</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAA_VILLAGE"))%></td>
			</tr>
			<tr height="30px">
				<td>Sub District</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAA_SUB_DISTRICT"))%></td>
				<td>District Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAA_DISTRICT_NAME"))%></td>
				<td>City Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAA_CITY_NAME"))%></td>
			</tr>
			<tr height="30px">
				<td>Pin Code</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAA_PIN_CODE"))%></td>
				<td>State Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAA_STATE_NAME"))%></td>
				<td>Country Name</td>
				<td<%=Helper.correctNull((String) hshValues.get("NPAA_COUNTRY_NAME"))%>></td>
			</tr>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td width="20%">Office Address</td>
			</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<col width="6%">
			<col width="10%">
			<col width="6%">
			<col width="10%">
			<col width="6%">
			<col width="10%">
			<tr height="30px">
				<td>Street Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPOA_STREET_NAME"))%></td>
				<td>LandMark</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPOA_LANDMARK"))%></td>
				<td>Village</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPOA_VILLAGE"))%></td>
			</tr>
			<tr height="30px">
				<td>Sub District</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPOA_SUB_DISTRICT"))%></td>
				<td>District Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPOA_DISTRICT_NAME"))%></td>
				<td>City Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPOA_CITY_NAME"))%></td>
			</tr>
			<tr height="30px">
				<td>Pin Code</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPOA_PIN_CODE"))%></td>
				<td>State Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPOA_STATE_NAME"))%></td>
				<td>Country Name</td>
				<td<%=Helper.correctNull((String) hshValues.get("NPOA_COUNTRY_NAME"))%>></td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
	<tr class="dataheader" align="center">
	<td >
	<font size="2">CO-APPLICANT DETAILS</font></td></tr>
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
				<td>Salutation</td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr height="30px">
				<td>First Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_FNAME"))%></td>
				<td>Middle Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_MNAME"))%></td>
				<td>Last Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_LNAME"))%></td>
			</tr>
			<tr height="30px">
				<td>Mobile</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_MOBILE"))%></td>
				<td>Email</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_EMAIL"))%></td>
				<td>Driving License</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_DRIVING_LIC"))%></td>

			</tr>
			<tr height="30px">
				<td>Name as Per Aadhaar</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_AADHAR_NAME"))%></td>
				<td>Father / Husband Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_FATORHUSB_NAME"))%></td>
				<td>Mother Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_MOTHER_NAME"))%></td>
			</tr>
			<tr height="30px">
				<td>Name Of Company</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_COMPANY_NAME"))%></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
				<tr height="30px">
				<td>Relation With</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_RELATION"))%></td>
				<td>Gender</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_GENDER"))%></td>
				<td>Date Of Birth</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_DOB"))%></td>
			</tr>
			<tr height="30px">
				<td>Social Category</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_SOCIAL_CAT"))%></td>
				<td>Marital Status</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_MARITAL_STAT"))%></td>
				<td>No of Children</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_NOOF_CHILD"))%></td>
			</tr>
			<tr height="30px">
				<td>No of Dependent</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_NOOF_DEPENDENT"))%></td>
				<td>Education Qualification</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_EDU_QUALIFY"))%></td>
				<td>Type Of Residence</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_RESI_TYPE"))%></td>
			</tr>
			<tr height="30px">
				<td>Residence Since</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_RESI_SINCE"))%></td>
				<td>Residence Since Month</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_RESI_SINCE_MON"))%></td>
				<td>Is Current Address Same</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_IS_CUR_ADDR"))%></td>
			</tr>
			<tr height="30px">
				<td>Type Of Employment</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_EMPLOY_TYPE"))%></td>
				<td>Name of Organization</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_ORG_NAME"))%></td>
				<td>Designation</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_DESIGNATION"))%></td>
			</tr>
			<tr height="30px">
				<td>Working With</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_WORK_WITH"))%></td>
				<td>Working Since</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_WORK_SINCE"))%></td>
				<td>Working Since Month</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_WORK_SINCE_MON"))%></td>
			</tr>
			<tr height="30px">
				<td>Age Of Retirement</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_RETIRE_AGE"))%></td>
				<td>Business Establishment Year</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_BUSI_EST_YR"))%></td>
				<td>Years in Current Business</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_YRS_CUR_BUSI"))%></td>
			</tr>
			<tr height="30px">
				<td>Gross Monthly Income</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_MON_INCOME"))%></td>
				<td>Is Guarantor</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_ISGUARANTOR"))%></td>
				<td>Date Of Retirement</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_DOR"))%></td>
			</tr>
			<tr height="30px">
				<td>Business Establishment Month</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_BUSI_EST_MON"))%></td>
				<td>Month in Current Business</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_CUR_BUSI_MON"))%></td>
				<td>Residential Status</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_RESI_STAT"))%></td>
			</tr>
			<tr height="30px">
				<td>Is Income Consider</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_INCOME_CONSIDER"))%></td>
				<td>Is DOB From Aadhaar</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPCD_IS_AADHAR_DOB"))%></td>
				<td></td>
				<td></td>
			</tr>
			</table>
			
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td width="20%">Aadhaar Address ID</td>
			</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<col width="6%">
			<col width="10%">
			<col width="6%">
			<col width="10%">
			<col width="6%">
			<col width="10%">
			<tr height="30px">
				<td>Street Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAA_STREET_NAME"))%></td>
				<td>LandMark</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAA_LAND_MARK"))%></td>
				<td>City Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAA_CITY_NAME"))%></td>
			</tr>
			<tr height="30px">
				<td>Village</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAA_VILLAGE"))%></td>
				<td>Sub District</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAA_SUB_DISTRICT"))%></td>
				<td>District Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAA_DISTRICT_NAME"))%></td>
			</tr>
			<tr height="30px">
				<td>Pin Code</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAA_PIN_CODE"))%></td>
				<td>State Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAA_STATE_NAME"))%></td>
				<td>Country Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAA_COUNTRY_NAME"))%></td>
			</tr>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td width="20%">Current Address ID</td>
			</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<col width="6%">
			<col width="10%">
			<col width="6%">
			<col width="10%">
			<col width="6%">
			<col width="10%">
			<tr height="30px">
				<td>Street Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("CU_NPAA_STREET_NAME"))%></td>
				<td>LandMark</td>
				<td><%=Helper.correctNull((String) hshValues.get("CU_NPAA_LAND_MARK"))%></td>
				<td>City Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("CU_NPAA_CITY_NAME"))%></td>
			</tr>
			<tr height="30px">
				<td>Village</td>
				<td><%=Helper.correctNull((String) hshValues.get("CU_NPAA_VILLAGE"))%></td>
				<td>Sub District</td>
				<td><%=Helper.correctNull((String) hshValues.get("CU_NPAA_SUB_DISTRICT"))%></td>
				<td>District Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("CU_NPAA_DISTRICT_NAME"))%></td>
			</tr>
			<tr height="30px">
				<td>Pin Code</td>
				<td><%=Helper.correctNull((String) hshValues.get("CU_NPAA_PIN_CODE"))%></td>
				<td>State Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("CU_NPAA_STATE_NAME"))%></td>
				<td>Country Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("CU_NPAA_COUNTRY_NAME"))%></td>
			</tr>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td width="20%">Office Address ID</td>
			</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<col width="6%">
			<col width="10%">
			<col width="6%">
			<col width="10%">
			<col width="6%">
			<col width="10%">
			<tr height="30px">
				<td>Street Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("off_NPAA_STREET_NAME"))%></td>
				<td>LandMark</td>
				<td><%=Helper.correctNull((String) hshValues.get("off_NPAA_LAND_MARK"))%></td>
				<td>City Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("off_NPAA_CITY_NAME"))%></td>
			</tr>
			<tr height="30px">
				<td>Village</td>
				<td><%=Helper.correctNull((String) hshValues.get("off_NPAA_VILLAGE"))%></td>
				<td>Sub District</td>
				<td><%=Helper.correctNull((String) hshValues.get("off_NPAA_SUB_DISTRICT"))%></td>
				<td>District Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("off_NPAA_DISTRICT_NAME"))%></td>
			</tr>
			<tr height="30px">
				<td>Pin Code</td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAA_PIN_CODE"))%></td>
				<td>State Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("off_NPAA_STATE_NAME"))%></td>
				<td>Country Name</td>
				<td><%=Helper.correctNull((String) hshValues.get("off_NPAA_COUNTRY_NAME"))%></td>
			</tr>
		
		</table>
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