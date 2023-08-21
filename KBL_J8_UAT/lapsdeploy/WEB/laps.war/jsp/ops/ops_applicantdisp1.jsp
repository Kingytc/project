<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*,java.io.*"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<%
if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
				
			}
	//session.setAttribute("perapp_employment", Helper.correctNull(request.getParameter("perapp_eduothers")));
	String strProfilestatus=Helper.correctNull((String)hshValues.get("strProfilestatus"));
	String tempProfile="";
	if(strProfilestatus.equalsIgnoreCase("Y"))
	{
		tempProfile="Completed";
	}
	else
	{
		tempProfile=" Not Completed";
	}
	String strModuleName=Helper.correctNull(request.getParameter("hidModuleName"));
	String strSSIType = Helper.correctNull((String) request.getParameter("hidSSIType"));
	String strCategoryType = Helper.correctNull((String) request.getParameter("hidCategoryType"));
		
			if (strCategoryType.equals("CORPORATE")) {
				strCategoryType = "CORP";
			}
	     else if (strCategoryType.equals("")) {
				strCategoryType = Helper.correctNull((String) hshValues
						.get("categorytype"));
			}
			
			
			String strhidfacilities=Helper.correctNull((String)request.getParameter("hidfacilities"));			
			
			String strconstitution=Helper.correctNull((String) hshValues
					.get("perapp_constitution"));
			
			
			%>
<html>
<head>
<title>Personal - Applicant</title>
<script>
function callApplicantTab(page)
{
	if(page=="facilities")
	{
		document.forms[0].hidBeanMethod.value="getOPSFacilityData";
		document.forms[0].hidBeanId.value="facilities";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/ops_facilities.jsp";
	}	  
	if(page=="subsidy")
	{
			document.forms[0].hidBeanId.value="comssiaboveten";
			document.forms[0].hidBeanGetMethod.value="getDataSubsidy";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/ops_subsidy.jsp";
	}
	if(page=="ops_incomeexpenses")
	{
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].hidBeanGetMethod.value="getIncome";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/ops_incomeexpenses.jsp";
	}
	if(page=="ops_employment")
	{
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].hidBeanGetMethod.value="getEmployer";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/ops_employment.jsp";
	}
	if(page=="accountdetails")
	{
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].hidBeanGetMethod.value="getAccountDetails";
		document.forms[0].action=appURL+"action/ops_accountdetails.jsp";
		document.forms[0].submit();
	}
	document.forms[0].submit();
}
function callLink(page,bean,method)
	{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/set/perapplicant.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var currentDate = "<%=Helper.getCurrentDateTime()%>";
</script>

<STYLE>

DIV.cellContainer {	
  width: 100%; height: 100%;
  overflow: auto;
}

</STYLE>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
	
	
	
	
</head>
<body onload="callonLoad();enableSince();showBranch();getlocationvalues();
	showres();showcoun();shownri();showStaffBox()">

<form name="appform" method="post" >
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr> 
        <td><jsp:include page="../share/help.jsp" flush="true"/>
		 <jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
      </tr>
      <tr><td class="page_flow">
      Home
		-&gt; Tertiary-&gt; Existing Application-&gt; Applicant -&gt;  Customer Profile
      </td></tr>
     </table>
    

<span style="display:none"><lapschoice:borrowertype /></span><lapschoice:application />

   <table width="100%" border="0" cellspacing="0" cellpadding="0"
	bgcolor="#DEDACF">
      <tr> 
        <td colspan="2" valign="bottom"> 
          <table width="100%" border="0" cellspacing="3" cellpadding="3">
            <tr align="center"> 
            		<td width="15%" class="tabinactivenew"><b><a href="javascript:callApplicantTab('facilities')"
							class="blackfont">Facilities</a></b></td>
					<td width="15%" class="tabinactivenew"><a
							href="javascript:callApplicantTab('subsidy')" class="blackfont"><b>Subsidy </b></a></td>
					<td width="15%" class="tabinactivenew"><a
							href="javascript:callApplicantTab('accountdetails')" class="blackfont"><b>Account Details </b></a></td>								
					<td width="15%" class="tabactivenew"><b>Customer Profile </b></td>	
							<%if(strconstitution.equalsIgnoreCase("01")||strconstitution.equalsIgnoreCase("02"))
							{%>
					<td width="15%" class="tabinactivenew"><a
							href="javascript:callApplicantTab('ops_incomeexpenses')" class="blackfont"><b>Income &amp; Expenses </b></a></td>
					<td width="15%" class="tabinactivenew"><a
							href="javascript:callApplicantTab('ops_employment')" class="blackfont"><b>Employment </b></a></td>	
							<%}%>
            </tr>
          </table>
        </td>
      </tr>
    </table>
      
         
  
    <%@include file="../per/per_commoncustdemographics.jsp"%> 
	
  <table width="20%" border="1" cellspacing="0" cellpadding="0"
	align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"
	bgcolor="#DEDACF">
    <tr> 
      <td> 
        <table width="43%" border="0" cellspacing="0" cellpadding="2">
          <tr valign="top"> 
            <td> 
              <input type="button" name="cmdEdit" value="Edit" tabindex="89"
					class="buttonStyle"
					onClick="callEdit()" style="visibility:hidden">
            </td>
            <td> 
              <input type="button" name="cmdapply" value="Save" tabindex="95"
					class="buttonStyle"
					onClick="doSave()" style="visibility:hidden">
            </td>
            <td> 
              <input type="button" name="cmdCancel" value="Cancel" tabindex="96"
					class="buttonStyle"
					onClick="callCancel()" style="visibility:hidden">
            </td>
            <td> 
              <input type="button" name="cmdDelete" value="Delete" tabindex="97"
					class="buttonStyle"
					onClick="callDelete()" style="visibility:hidden">
            </td>
            <td> 
              <input type="button" name="cmdModify" value="Modify" tabindex="93"
					class="buttonStyle"
					onClick="callModify()" disabled style="visibility:hidden">
            </td>
            <td> 
           <!--    <input type="button" name="cmdHelp" value="Help" tabindex="98"
					class="buttonHelp"
					onClick="doHelp('loan_appretail_custpro_demo.htm')">
            </td> -->
            <td> 
              <input type="button" name="cmdClose" value="Close" tabindex="99"
					onClick="callClose()"

					class="buttonClose"> 
            </td>
            <td id="n1"> 
              <input type="button" name="cmdNridetails" value="NRI Details" tabindex="100"
					onClick="callNRI()"
					class="buttonStyle" style="width:100;visibility:hidden"> 
            </td>
            <td> 
              <input type="button" name="cmdReferences" value="References" tabindex="101"
					onClick="callReferences()"
					class="buttonStyle" style="width:100;visibility:hidden"> 
            </td>
            <td id="m1" width="0"> 
              <input type="button" name="cmdDirectors" tabindex="102"
					value="Partners/Co- Parceners/HUF/Directors" onClick="callDirectors()" 
					class="buttonStyle" style="width:240;visibility:hidden"> 
            </td>
			<td width=0> 
              <input type="button" name="ramdetails" value="SEND TO RAM" tabindex="87"
					onClick="doramdetails()"
					style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:0;visibility:hidden"> 
            </td>
           </tr>
        </table>
      </td>
    </tr>
  </table>
<input type="hidden" name="hidAppType" value='A'>
<laps:hiddentag/>
<input type="hidden" name="comapp_id" value="<%=request.getParameter("comapp_id")%>"> 
<input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>">
<input type="hidden" name="hidCBSId" value="<%=Helper.correctNull((String)hshValues.get("perapp_cbsid"))%>">
<input type="hidden" name="hidappstatus" value="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>">
<input type="hidden" name="hidOldAppId" value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>">
<input type="hidden" name="OldAppId" value="<%=Helper.correctNull((String)hshValues.get("perapp_oldid"))%>">
<input type="hidden" name="scode" value="yyy">
<input type="hidden" name="txt_flag" value="<%=txt_flag%>">
<input type="hidden" name="Branch" value="Branch">
<input type="hidden" name="hid_comappid1" value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>">
<input type="hidden" name="hid_comappid2"	value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>">
<input type="hidden" name="txt_employment" value="<%=Helper.correctNull((String)hshValues.get("perapp_employment"))%>">
<input type="hidden" name="applnt" value="T">
<input type="hidden" name="hidphotoid" value="<%=Helper.correctNull((String)hshValues.get("perapp_photo"))%>">
<input type="hidden" name="hidcity" value="<%=Helper.correctNull((String)hshValues.get("perapp_city_code"))%>">
<input type="hidden" name="hidPermCity" value="<%=Helper.correctNull((String)hshValues.get("perapp_permcity_code"))%>"> 
<input type="hidden" name="hidcity1" value="<%=Helper.correctNull((String)hshValues.get("perapp_permcity_code"))%>">
<input type="hidden" name="hidstate" value="<%=Helper.correctNull((String)hshValues.get("perapp_state_code"))%>">
<input type="hidden" name="hidstate1" value="<%=Helper.correctNull((String)hshValues.get("perapp_permstate_code"))%>">
<input type="hidden" name="usr_mname" value="">
<input type="hidden" name="hidModuleName" value="T">
<input type="hidden" name="hidpromoter" value="">
</form>
</body>
</html>

