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
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/mainnav.jsp";	
		document.forms[0].submit();
	}
}
function onload(){
	disableFields(true);
}
function gotoTab( beanid,getmethod, page)
{

		document.forms[0].hidBeanId.value=beanid;		
		document.forms[0].hidBeanGetMethod.value=getmethod;
		document.forms[0].action=appURL+"action/"+page;	
		document.forms[0].submit();

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
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getFinancialITRDetails','NP_Financial.jsp')" onMouseOut="window.status='';return true;" >Financial & ITR Details</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getDOCDETAILS','NP_Document.jsp')" onMouseOut="window.status='';return true;" >Documents</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getBREmatch','NP_Brematch.jsp')" onMouseOut="window.status='';return true;" >BRE Match</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getNP_EligibilityDeatils','NP_EligibilityDeatils.jsp')" onMouseOut="window.status='';return true;" >Eligibility Details</a></b></td>
		<td class="sub_tab_active" align="center"><b>Inprinciple Details</b></td>		
		</tr>
</table>
  <table width="96%" border="0" cellspacing="0" cellpadding="5" class="outertable">
    <h3 class="head"><B>Inprinciple Details</B></h3>
    <tbody>
      <tr>
      <td>Loan Amount</td>
      <td valign="top"><input type="text" name="txt_loanamt" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPID_LOAN_AMT"))%>">
      </td>
      <td> Subsidy Amount</td>
      <td valign="top"><input type="text" name="txt_subsidyamt" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPID_SUBSIDY_AMT"))%>">
      </td>
      <td>Monthly EMI </td>
      <td valign="top"><input type="text" name="txt_monthlyemi" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPID_EMI"))%>">
      </td>
      </tr>
      <tr>  

        <td>ROI </td>
        <td valign="top"><input type="text" name="txt_roi" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPID_ROI"))%>">
        </td>
        <td>Loan Tenure</td>
        <td valign="top"><input type="text" name="txt_loantenure" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPID_TENOR"))%>">
        </td>
        <td>Processing Fee </td>
        <td valign="top"><input type="text" name="txt_processfee" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPID_PROCESS_FEE"))%>">
        </td>
        </tr>
        <tr>
         
          </tr>
          <tr>
            <td>Branch Name </td>
            <td valign="top"><input type="text" name="txt_branchname" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPID_BRANCH_NAME"))%>">
            </td>
            <td>Branch Code </td>
            <td valign="top"><input type="text" name="txt_branchcode" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPID_BRANCH_CODE"))%>">
            </td>
            <td>IFSC Code </td>
            <td valign="top"><input type="text" name="txt_ifsccode" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPID_IFSC_CODE"))%>">
            </td>
            </tr>
            <tr>
             
              <td>Contact Number </td>
              <td valign="top"><input type="text" name="txt_contactno" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPID_CONTACT_NUM"))%>">
              </td>
              <td>Address </td>
              <td valign="top"><input type="text" name="txt_address" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPID_ADDRESS"))%>">
              </td>
              <td>Journey Completion Date</td>
               
              <td><input id="datepicker" type="text" name="txtperapp_dob" size="12" maxlength="10" tabindex="9" value="<%=Helper.correctNull((String)hshValues.get("NPID_JOURNEY_CMPLT_DT"))%>" onblur="checkDate(this);checkmaxdate(this,currentDate);showMinority(this)"> </td>
              </tr>
              <tr>

                     
                    </tr>
                  
              </tr>
    </tbody>
</table>
<br><br><br>
  <lapschoice:hiddentag pageid="<%=PageId%>"/>
<table class="footer-btn" align="center">
  <tbody>
    <tr>
      <td>
        
       <lapschoice:combuttonnew	
       btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
      </td>
    </tr>
  </tbody>
</table>
<input type="hidden" name="strApplicationRefNo" value=<%=strApplicationRefNo%>>
</form>
</body>
</html> 
