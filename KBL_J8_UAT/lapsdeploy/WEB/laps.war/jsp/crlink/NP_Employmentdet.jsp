<%@include file="../share/directives.jsp"%>
<%String strApplicationRefNo=Helper.correctNull((String)hshValues.get("strApplicationRefNo"));
if(strApplicationRefNo.equalsIgnoreCase(""))
{
	strApplicationRefNo= Helper.correctNull((String) session.getAttribute("strApplicationRefNo"));
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/NationalPortal.css" type="text/css">
		<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var emptype= "<%=Helper.correctNull((String) hshValues.get("NPPD_EMP_TYPE"))%>";
var orgtype= "<%=Helper.correctNull((String) hshValues.get("NPPD_ORG_TYPE"))%>";
function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			if(document.forms[0].elements[i].type=="select-one")
			{
			  document.forms[0].elements[i].disabled=val;		  
			}
		}
		
	}
function onload(){
	disableFields(true);
	document.forms[0].orgtype.value=emptype;
	document.forms[0].emptype.value=orgtype;
}
function gotoTab( beanid,getmethod, page)
{

		document.forms[0].hidBeanId.value=beanid;		
		document.forms[0].hidBeanGetMethod.value=getmethod;
		document.forms[0].action=appURL+"action/"+page;	
		document.forms[0].submit();

}
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/mainnav.jsp";	
		document.forms[0].submit();
	}
}
</script></head>

<body onLoad="onload()">
<form class="normal">
<table width="85%" border="0" cellspacing="1" cellpadding="3" class="outertable">
	<tr>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getNP_ApplicantDeatis','NP_applicantDetails.jsp')" onMouseOut="window.status='';return true;" >Applicant's Details</a></b></td>		
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getNP_CoApplicantDeatils','NP_coapplicantDetails.jsp')" onMouseOut="window.status='';return true;" >Co-Applicant's Details</a></b></td>		
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getNP_Education','NP_Education.jsp')" onMouseOut="window.status='';return true;" >Education Details</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getNP_CourseDetails','NP_CourseDeatils.jsp')" onMouseOut="window.status='';return true;" >Course Details</a></b></td>
		<td class="sub_tab_active" align="center"><b>Emplyoment Details</b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getFinancialITRDetails','NP_Financial.jsp')" onMouseOut="window.status='';return true;" >Financial & ITR Details</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getNP_Document','NP_Document.jsp')" onMouseOut="window.status='';return true;" >Documents</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getBREmatch','NP_Brematch.jsp')" onMouseOut="window.status='';return true;" >BRE Match</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getNP_EligibilityDeatils','NP_EligibilityDeatils.jsp')" onMouseOut="window.status='';return true;" >Eligibility Details</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getInprincipleDetails','NP_Inprincipaldet.jsp')" onMouseOut="window.status='';return true;" >Inprinciple Details</a></b></td>		
		</tr>
</table>
  <table width="96%" border="0" cellspacing="0" cellpadding="5" class="outertable">
    <h3 class="head">Employment Details</h3>
    <tbody>
      <tr>
      <td>Employment Type</td>
      
         <td valign="top"><input type="text" name="txt_emptype" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPPD_EMP_TYPE"))%>">
     
      </td>
      <td>Organisation Type</td>
      
     
       <td valign="top"><input type="text" name="txt_orgtype" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPPD_ORG_TYPE"))%>">
     
      </td>
      <td>Organisation Name</td>
      <td valign="top"><input type="text" name="txt_orgname" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPPD_ORG_NAME"))%>">
      </td>
      </tr>
      <tr>
        <td>Designation</td>
        <td valign="top"><input type="text" name="txt_designation" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPPD_DESIGNATION"))%>">
        </td>
        <td>Working Since Year</td>
        <td valign="top"><input type="text" name="txt_worksinceyear" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPPD_WORKING_SINCE_YEAR"))%>">
        </td>
        <td>Working Since Month</td>
        <td valign="top"><input type="text" name="txt_worksincemonth" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPPD_WORKING_SINCE_MONTH"))%>">
        </td>
        </tr>

        <tr>
          <td>RetirementAge</td>
          <td valign="top"><input type="text" name="txt_retirementage" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPPD_RETIRE_AGE"))%>">
          </td>
        </tr>

        <tr>
          <td>Business Establishment Year</td>
          <td valign="top"><input type="text" name="txt_bussestablisyear" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPPD_BUSS_ESTA_YEAR"))%>">
          </td>
          <td>Business Establishment Month</td>
          <td valign="top"><input type="text" name="txt_bussestablismonth" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPPD_BUSS_ESTA_MONTH"))%>">
          </td>
          <td>Current Businees Year</td>
          <td valign="top"><input type="text" name="txt_currentbusyearin" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPPD_CURR_BUSS_YEAR"))%>">
          </td>
          </tr>
     
    </tbody>
</table>
<br><br><br>
  <lapschoice:hiddentag pageid="<%=PageId%>"/>
<table class="footer-btn" align="center">
  <tbody>
    <tr>
      <td>
        
        <input type="button" name="cmdsave" value="Close" class="buttonClose">
      </td>
    </tr>
  </tbody>
</table>
<INPUT TYPE="hidden" name="strApplicationRefNo" value=<%=strApplicationRefNo%>>
</form>
</body>
</html> 
