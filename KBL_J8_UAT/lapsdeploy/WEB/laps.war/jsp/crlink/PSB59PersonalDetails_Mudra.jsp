<%@include file="../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%response.setHeader("X-Frame-Options","SAMEORIGIN");%>
<html>
<head>
<title>Document Attach</title>
<STYLE>
DIV.cellContainer {	
  width: 100%; height: 300;
  overflow: auto;
}

</STYLE>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>

<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<% session.setAttribute("CURRENT_TAB","PERSONAL_DETAILS");
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
<script>

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
</head>
 <%-- <link rel="stylesheet"href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">  --%>
  <link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/NationalPortal.css" type="text/css">  
<body onload="onLoad();">
<form name="docVerForm" method="post" action="" class="normal">

<form name="" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td valign="top" colSpan="5"> 
      <jsp:include page="../crlink/PSB59ApplicationDetails.jsp" flush="true" /> 
    </td>
  </tr>
</table> 

<table width="100%"  cellspacing="0" cellpadding="0" class ="outertable border1">

	<tr>
<tr class="dataheader" align="center">
	<td >
	<!-- <h4 ><B>PERSONAL DETAILS</B></h4> -->
	<font size="2"><b>PERSONAL DETAILS</b></font></td></tr>
	</td></tr>
	
	
	<tr class="datagrid">
		<td>
		<div id="top2">
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		 
		 
		 
		 
		 
		 
		    <tr >
				<td> Application Reference ID </td>
				<td><%=Helper.correctNull((String) hshValues.get("SPD_APPLN_REF_ID"))%></td>
				<td> No Of Employees Or Workers Id </td>
				<td><%=Helper.correctNull((String) hshValues.get("SPD_NO_EMP_OR_WORKERS_ID"))%></td>
				<td> No Of Employees Or Workers </td>
				<td><%=Helper.correctNull((String) hshValues.get("SPD_NO_EMP_OR_WORKERS"))%></td>
			</tr>
			<tr></tr>
			<tr >
				<td> Operating Business Since Year </td>
				<td><%=Helper.correctNull((String) hshValues.get("SPD_OPERATING_BUSINESS_YEAR"))%></td>
				<td> Operating Business Since Month </td>
				<td><%=Helper.correctNull((String) hshValues.get("SPD_OPERATING_BUSINESS_MONTH"))%></td>
				<td></td>
				<td></td>
			</tr>
			</table>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td width="20%"> <b>Business Address</b> </td>
			</tr>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			 
			 
			 
			 
			 
			 
			<tr >
				<td> Street Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_STREET_NAME"))%></td>
				<td> Landmark </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_LANDMARK"))%></td>
				<td> Country Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_COUNTRY_NAME"))%></td>
			</tr>
			<tr></tr>
			<tr >
				<td> State Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_STATE_NAME"))%></td>
				<td> District Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_DISTRICT_NAME"))%></td>
				<td> City Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_CITY_NAME"))%></td>
			</tr>
			<tr></tr>
			<tr >
				<td> Sub District </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_SUB_DISTRICT"))%></td>
				<td> Village </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_VILLAGE"))%></td>
				<td> Pincode </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_PIN_CODE"))%></td>
			</tr>
			<tr></tr>
			<tr >
				<td> Block </td>
				<td><%=Helper.correctNull((String) hshValues.get("NPAD_BLOCK"))%></td>
				<td> Have Any Pension Plan True </td>
				<td><%=Helper.correctNull((String) hshValues.get("SPD_ANY_PENSION_PLAN"))%></td>
				<td> Pension Plan Or Insurance Schemes </td>
				<td><%=Helper.correctNull((String) hshValues.get("SPD_PENSION_PLAN_OR_INS_SCH"))%></td>
			</tr>
			<tr></tr>
			<tr >
				<td> Specify Other Pension Plan </td>
				<td><%=Helper.correctNull((String) hshValues.get("SPD_SPECIFY_OTH_PENSION_PLAN"))%></td>
				<td> Inputs Labour Raw Materials </td>
				<td><%=Helper.correctNull((String) hshValues.get("SPD_INPUT_LABOUR_RAW_MAT"))%></td>
				<td> Is Related Party Select True </td>
				<td><%=Helper.correctNull((String) hshValues.get("SPD_IS_RELATED_PARTY_SELECT"))%></td>
			</tr>
			<tr></tr>
			<tr >
				<td> Business Enterprises </td>
				<td><%=Helper.correctNull((String) hshValues.get("SPD_BUSINESS_ENTERPRISES"))%></td>
				<td> First Time Enterpreneur </td>
				<td><%=Helper.correctNull((String) hshValues.get("SPD_FIRST_TYM_ENTERPRENEUR"))%></td>
				<td> GST No </td>
				<td><%=Helper.correctNull((String) hshValues.get("SPD_GST_NO"))%></td>
			</tr>
			<tr></tr>
			<tr >
				<td> Commencement Date </td>
				<td><%=Helper.correctNull((String) hshValues.get("SPD_COMMENCEMENT_DATE"))%></td>
				<td> Is Unit Registered True </td>
				<td><%=Helper.correctNull((String) hshValues.get("SPD_IS_UNIT_REGISTRD"))%></td>
				<td> Registration Number </td>
				<td><%=Helper.correctNull((String) hshValues.get("SPD_REG_NO"))%></td>
			</tr>
			<tr></tr>
			<tr >
				<td> Registration Act </td>
				<td><%=Helper.correctNull((String) hshValues.get("SPD_REG_ACT"))%></td>
				<td> Voter Id </td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td> Driving License </td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			</tr>
			<tr></tr>
			<tr >
				<td> Email Id </td>
				<td><%=Helper.correctNull((String) hshValues.get("SPD_EMAIL_ID"))%></td>
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
				<td width="20%"><b> Mudra Partner Details Proxies </b></td>
			</tr>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			 
			 
			 
			 
			 
			 
			<tr >
				<td> Application Reference Id </td>
				<td><%=Helper.correctNull((String) hshValues.get("MPDP_APPLN_REF_ID"))%></td>
				<td> Relationship Type </td>
				<td><%=Helper.correctNull((String) hshValues.get("MPDP_RELATIONSHIP_TYPE"))%></td>
				<td> Ownership </td>
				<td><%=Helper.correctNull((String) hshValues.get("MPDP_OWNERSHIP"))%></td>
			</tr>
			<tr></tr>
			<tr >
				<td> First Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("MPDP_FIRST_NAME"))%></td>
				<td> Middle Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("MPDP_MIDDLE_NAME"))%></td>
				<td> Last Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("MPDP_LAST_NAME"))%></td>
			</tr>
			<tr></tr>
			<tr >
				<td> Father Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("MPDP_FATHERS_NAME"))%></td>
				<td> Date Of Birth </td>
				<td><%=Helper.correctNull((String) hshValues.get("MPDP_DOB"))%></td>
				<td> Mobile </td>
				<td><%=Helper.correctNull((String) hshValues.get("MPDP_MOBILE"))%></td>
			</tr>
			<tr></tr>
			<tr >
				<td> Gender </td>
				<td><%=Helper.correctNull((String) hshValues.get("MPDP_GENDER"))%></td>
				<td> Total Experience </td>
				<td><%=Helper.correctNull((String) hshValues.get("MPDP_TOTAL_EXP"))%></td>
				<td> NetWorth </td>
				<td><%=Helper.correctNull((String) hshValues.get("MPDP_NET_WORTH"))%></td>
			</tr>
			<tr></tr>
			<tr >
				<td> Visually Impaired </td>
				<td><%=Helper.correctNull((String) hshValues.get("MPDP_VISUALLY_IMPAIRED"))%></td>
				<td> Physically Handicapped </td>
				<td><%=Helper.correctNull((String) hshValues.get("MPDP_PHYSICALLY_CHALLENGED"))%></td>
				<td></td>
				<td></td>
			</tr>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td width="20%"> <b>Aadhaar Address</b></td>
			</tr>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			 
			 
			 
			 
			 
			 
			<tr >
				<td> Street Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("AAD_NPAD_STREET_NAME"))%></td>
				<td> Land Mark </td>
				<td><%=Helper.correctNull((String) hshValues.get("AAD_NPAD_LANDMARK"))%></td>
				<td> Country Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("AAD_NPAD_COUNTRY_NAME"))%></td>
			</tr>
			<tr></tr>
			<tr >
				<td> State Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("AAD_NPAD_STATE_NAME"))%></td>
				<td> District Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("AAD_NPAD_DISTRICT_NAME"))%></td>
				<td> City Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("AAD_NPAD_CITY_NAME"))%></td>
			</tr>
			<tr></tr>
			<tr >
				<td> Sub District </td>
				<td><%=Helper.correctNull((String) hshValues.get("AAD_NPAD_SUB_DISTRICT"))%></td>
				<td> Village </td>
				<td><%=Helper.correctNull((String) hshValues.get("AAD_NPAD_VILLAGE"))%></td>
				<td> Pincode </td>
				<td><%=Helper.correctNull((String) hshValues.get("AAD_NPAD_PIN_CODE"))%></td>
			</tr>
			<tr></tr>
			<tr >
				<td> Block </td>
				<td><%=Helper.correctNull((String) hshValues.get("AAD_NPAD_BLOCK"))%></td>
				<td> Is Current Address Same True </td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td></td>
				<td></td>
			</tr>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td width="20%"><b> Current Address</b> </td>
			</tr>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			 
			 
			 
			 
			 
			 
			<tr >
				<td> Street Name </td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td> Land Mark </td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td> Country Name </td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			</tr>
			<tr></tr>
			<tr >
				<td> State Name </td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td> District Name </td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td> City Name </td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			</tr>
			<tr></tr>
			<tr >
				<td> Sub District </td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td> Village </td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td> Pincode </td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			</tr>
			<tr></tr>
			<tr >
				<td> Block </td>
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
				<td width="20%"> <b>Residence Status Id</b> </td>
			</tr>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			 
			 
			 
			 
			 
			 
			<tr >
				<td> Residence Status </td>
				<td><%=Helper.correctNull((String) hshValues.get("MPDP_RESIDENCE_STS"))%></td>
				<td> Pan </td>
				<td><%=Helper.correctNull((String) hshValues.get("MPDP_PAN"))%></td>
				<td> Educational Status </td>
				<td><%=Helper.correctNull((String) hshValues.get("MPDP_EDU_STS"))%></td>
			</tr>
			<tr></tr>
			<tr >
				<td> Main Partner </td>
				<td><%=Helper.correctNull((String) hshValues.get("MPDP_MAIN_PARTNER"))%></td>
				<td> Is Main Partner True </td>
				<td><%=Helper.correctNull((String) hshValues.get("MPDP_IS_MAIN_PARTNER"))%></td>
				<td> Owning A House </td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<%-- <td><%=Helper.correctNull((String) hshValues.get("MPDP_OWNING_HOUSE"))%></td> --%>
			</tr>
			<tr></tr>
			<tr >
				<td> Assessed For Income Tax </td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td> Have Life Insurance Policy </td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td> Marital Status </td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			</tr>
			<tr></tr>
			<tr >
				<td> Spouse Name </td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td> Spouse Detail </td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td> No Of Children </td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			</tr>
			<tr></tr>
			<tr >
				<td> Category </td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td> Minority Category </td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td> No Of Dependent </td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			</tr>
			<tr></tr>
			<tr >
				<td> Number Of Earning Members </td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td> Active Partner True </td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td> Salutation </td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			</tr>
			<tr></tr>
			<tr >
				<td> Email </td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td> Is Dob From Aadhar True </td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td></td>
				<td></td>
			</tr>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td width="20%"><b> Mudra Applicant PAN Details Proxy </b></td>
			</tr>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			 
			 
			 
			 
			 
			<tr >
				<td> Pan </td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td> First Name </td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td> Middle Name </td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			</tr>
			<tr></tr>
			<tr >
				<td> Last Name </td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td> Entity Name </td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
				<td> Entity Type </td>
				<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
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
            <input type="button" name="cmdclose" value="Close" class="buttonClose" onClick="callclose()"> 
        </td>
      </tr>
</table>

<INPUT TYPE="hidden" name="radLoan" value="Y">

<input type="hidden" name="hidAppDoc">  
<input type="hidden" name="hidDocId"> 
<input type="hidden" name="hidAction">
<input type="hidden" name="hidAppType"> 

<input type="hidden" name="applino" value="<%=Helper.correctNull((String)request.getParameter("applino"))%>">
<input type="hidden" name ="hidstatus">

</form>
</body>
</html>