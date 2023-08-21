<%@include file="../share/directives.jsp"%>
<%String strApplicationRefNo=Helper.correctNull((String)hshValues.get("strApplicationRefNo"));
if(strApplicationRefNo.equalsIgnoreCase(""))
	{
		strApplicationRefNo= Helper.correctNull((String) session.getAttribute("strApplicationRefNo"));
	}
	session.setAttribute("strApplicationRefNo", strApplicationRefNo);
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
function callonload(){
	disableFields(true);
	
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

function callDisable(one)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=one;
		}
		if(document.forms[0].elements[i].type=="textarea") 
		
		{
			document.forms[0].elements[i].readOnly=one;
		}
		if(document.forms[0].elements[i].type=="select-one")
		{
		  	document.forms[0].elements[i].disabled=one;
		}
	}
}

</script></head>

<body onLoad="callonload()">
<form class="normal">

<table width="85%" border="0" cellspacing="1" cellpadding="3" class="outertable">
	<tr>
		<td class="sub_tab_active" align="center"><b>Applicant's Details</b></td>
		<!--<td class="sub_tab_inactive" width="150px" align="center"><b>
			<a href="#" onclick="javascript:gotoTab('NationalPortal','getNP_CoApplicantDeatils','NP_coapplicantDetails.jsp')">Co-Applicant's Details1</a></b>
			</td>
		--><td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getNP_CoApplicantDeatils','NP_coapplicantDetails.jsp')" onMouseOut="window.status='';return true;" >Co-Applicant's Details</a></b></td>	
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getNP_Education','NP_Education.jsp')" onMouseOut="window.status='';return true;" >Education Details</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getNP_CourseDetails','NP_CourseDeatils.jsp')" onMouseOut="window.status='';return true;" >Course Details</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getFinancialITRDetails','NP_Financial.jsp')" onMouseOut="window.status='';return true;" >Financial & ITR Details</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getDOCDETAILS','NP_Document.jsp')" onMouseOut="window.status='';return true;" >Documents</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getBREmatch','NP_Brematch.jsp')" onMouseOut="window.status='';return true;" >BRE Match</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getNP_EligibilityDeatils','NP_EligibilityDeatils.jsp')" onMouseOut="window.status='';return true;" >Eligibility Details</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getInprincipleDetails','NP_Inprincipaldet.jsp')" onMouseOut="window.status='';return true;" >Inprinciple Details</a></b></td>		
		</tr>
</table>
 <h3 class="head"><B>Applicant's Details</B></h3>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
	<tr>
	<td>
	
  <table width="96%" border="0" cellspacing="0" cellpadding="5" class="outertable">
    <tbody>
      <tr>
      <td width="12%">ID Salutaion</td>
      <td valign="top"><input type="text" name="txt_idsalu" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPPD_SALUTATION"))%>">
      </td>
      <td width="12%"> Application Reference ID</td>
      <td valign="top"><input type="text" name="txt_apprefid" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPPD_APPLICATION_REFERENCE_ID"))%>">
      </td>
      </tr>
      <tr>
        <td>First Name </td>
        <td valign="top"><input type="text" name="txt_fname" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPPD_FIRST_NAME"))%>">
        </td>
        <td>Middle Name </td>
        <td valign="top"><input type="text" name="txt_mname" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPPD_MIDDLE_NAME"))%>">
        </td>
        <td> Last Name</td>
        <td valign="top"><input type="text" name="txt_lname" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPPD_LAST_NAME"))%>">
        </td>
        </tr>
        <tr>
          <td>Gender</td>
            <td valign="top"><input type="text" name="sel_gender" size="35" maxlength="50" value=" <%=Helper.correctNull((String)hshValues.get("NPPD_GENDER"))%>">
           
          </td>
          <td>Date of Birth </td>
          <td><input id="datepicker" type="text" name="txt_dateofbirth" size="35" maxlength="10" tabindex="9" value="<%=Helper.correctNull((String)hshValues.get("NPPD_DOB")) %>" onblur="checkDate(this);checkmaxdate(this,currentDate);showMinority(this)"> 
         </td>
          <td>Email</td>
          <td valign="top"><input type="text" name="txt_email" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPPD_EMAIL"))%>">
          </td>
          </tr>
          <tr>
            <td>Social Category</td>
            
               <td valign="top"><input type="text" name="sel_socialcat" size="35" maxlength="50" value=" <%=Helper.correctNull((String)hshValues.get("NPPD_SOCIAL_CATEGORY"))%>">
           
            </td>
            <td>Mobile </td>
            <td valign="top"><input type="text" name="txt_mobile" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPPD_MOBILE_NUMBER"))%>">
            </td>
            <td>Marital Status</td>
            
           <td valign="top"><input type="text" name="sel_martialStatus" size="35" maxlength="50" value=" <%=Helper.correctNull((String)hshValues.get("NPPD_MARITAL_STATUS"))%>">
            </td>
            </tr>
    </tbody>
    </table>
    <h3 class="head">Aadhar Address</h3>
    <table width="96%" border="0" cellspacing="0" cellpadding="5" class="outertable">
      <tbody>
        <tr>
          <td width="12%">Street Name</td>
          <td valign="top"><input type="text" name="txt_streetname" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPAA_STREET_NAME"))%>">
          </td>
          <td width="12%">Landmark</td>
          <td valign="top"><input type="text" name="txt_landmark" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPAA_LAND_MARK"))%>">
          </td>
          <td>Village</td>
          <td valign="top"><input type="text" name="txt_village" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPAA_VILLAGE"))%>">
          </td>
          </tr>
          <tr>
            <td>Sub District</td>
            <td valign="top"><input type="text" name="txt_subdist" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPAA_SUB_DISTRICT"))%>">
            </td>
            <td>District Name </td>
            <td valign="top"><input type="text" name="txt_dist" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPAA_DISTRICT_NAME"))%>">
            </td>
            <td>City Name</td>
            <td valign="top"><input type="text" name="txt_city" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPAA_CITY_NAME"))%>">
            </td>
            </tr>
            <tr>
              <td>Pin Code </td>
              <td valign="top"><input type="text" name="txt_pin" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPAA_PIN_CODE"))%>">
              </td>
              <td>State Name </td>
              <td valign="top"><input type="text" name="txt_state" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPAA_STATE_NAME"))%>">
              </td>
              <td>Country Name</td>
              <td valign="top"><input type="text" name="txt_country" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPAA_COUNTRY_NAME"))%>">
              </td>
              </tr>
      </tbody>
    </table>

    <h3 class="head">Office Address</h3>
    <table width="96%" border="0" cellspacing="0" cellpadding="5" class="outertable">
      <tbody>
        <tr>
          <td width="12%">Street Name</td>
          <td valign="top"><input type="text" name="txt_offstrname" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPOA_STREET_NAME"))%>">
          </td>
          <td width="12%">Landmark</td>
          <td valign="top"><input type="text" name="txt_offlanmark" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPOA_LANDMARK"))%>">
          </td>
          <td>Village</td>
          <td valign="top"><input type="text" name="txt_offvillage" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPOA_VILLAGE"))%>">
          </td>
          </tr>
          <tr>
            <td>Sub District</td>
            <td valign="top"><input type="text" name="txt_offsubdist" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPOA_SUB_DISTRICT"))%>">
            </td>
            <td>District Name </td>
            <td valign="top"><input type="text" name="txt_offdist" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPOA_DISTRICT_NAME"))%>">
            </td>
            <td>City Name</td>
            <td valign="top"><input type="text" name="txt_offcity" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPOA_CITY_NAME"))%>">
            </td>
            </tr>
            <tr>
              <td>Pin Code </td>
              <td valign="top"><input type="text" name="txt_offpin" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPOA_PIN_CODE"))%>">
              </td>
              <td>State Name </td>
              <td valign="top"><input type="text" name="txt_offstate" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPOA_STATE_NAME"))%>">
              </td>
              <td>Country Name</td>
              <td valign="top"><input type="text" name="txt_offcountry" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPOA_COUNTRY_NAME"))%>">
              </td>
              </tr>
              <tr>
                <td>IS Chairman </td>
               
                  <td valign="top"><input type="text" name="sel_ischairman" size="35" maxlength="50" value=" <%=Helper.correctNull((String)hshValues.get("NPPD_IS_CHAIRMAN"))%>">
           
                </td>
                <td>Relationship </td>
               
               <td valign="top"><input type="text" name="sel_relationship" size="35" maxlength="50" value=" <%=Helper.correctNull((String)hshValues.get("NPPD_RELATIONSHIP"))%>">
              
                </td>
                <td>Occupation</td>
               
                 
               <td valign="top"><input type="text" name="sel_ocupation" size="35" maxlength="50" value=" <%=Helper.correctNull((String)hshValues.get("NPPD_OCCUPATION"))%>">
                 
                </td>
                </tr>
                <tr>
                  <td>Gross Monthly Income </td>
                  <td valign="top"><input type="text" name="txt_grossincome" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPPD_GROSS_MONTHLY_INCOME"))%>">
                  </td>
                  <td>Residental Status </td>
                  
                   <td valign="top"><input type="text" name="sel_resident" size="35" maxlength="50" value=" <%=Helper.correctNull((String)hshValues.get("NPPD_RESITANT_STATUS"))%>">
                
                  </td>
                  <td>Voter No</td>
                  <td valign="top"><input type="text" name="txt_voterno" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPPD_VOTER_NO"))%>">
                  </td>
                  </tr>
                  <tr>
                    <td>PAN No </td>
                    <td valign="top"><input type="text" name="txt_panno" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPPD_PAN_NO"))%>">
                    </td>
                    <td>Is Current Address Same</td>
                    
                      <td valign="top"><input type="text" name="sel_currentaddrsame" size="35" maxlength="50" value=" <%=Helper.correctNull((String)hshValues.get("NPPD_IS_CURR_ADD_SAME"))%>">
                 
                    </td>
                    </tr>
                    <tr>
                      <td>Education Qualification </td>
                      
                       <td valign="top"><input type="text" name="sel_educationqual" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPPD_EDU_QUALIFICATION"))%>">
                       
                      </td>
                      <td>Marks</td>
                      <td valign="top"><input type="text" name="txt_marks" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPPD_MARKS"))%>">
                      </td>
                      </tr><!--
                      <tr>
                        <td>Remark</td>
                        <td valign="top">
                          <textarea   rows="2" id="comment"><%=Helper.correctNull((String)hshValues.get("NPPD_REMARKS"))%></textarea>
                        </td>
                        </tr>
      --></tbody>
    </table>
    </td>
	</tr>
</table>
<table width="96%" border="0" cellspacing="0" cellpadding="5" class="outertable">
    <h3 class="head"><b>Employment Details</b></h3>
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
     <tr>
          <td>RetirementAge</td>
          <td valign="top"><input type="text" name="txt_retirementage" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPPD_RETIRE_AGE"))%>">
          </td>
        </tr>
     
    </tbody>
</table>
<br><br><br>
</td></tr></table>
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
</td></tr></table>
<INPUT TYPE="hidden" name="strApplicationRefNo" value=<%=strApplicationRefNo%>>
</form>
</body>
</html>

</body>
</html>