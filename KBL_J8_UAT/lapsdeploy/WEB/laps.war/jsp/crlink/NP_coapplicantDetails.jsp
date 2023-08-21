<%@include file="../share/directives.jsp"%>
<%
ArrayList arrRow = new ArrayList();
arrRow = (ArrayList)hshValues.get("arrRow");
ArrayList arrEmpRec = new ArrayList();
arrEmpRec = (ArrayList)hshValues.get("arrEmpRec");

String strApplicationRefNo=Helper.correctNull((String)hshValues.get("strApplicationRefNo"));
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

function disableControls(bcmdEdit,bcmdsave,bcmdCancel,bcmdClose)
{
	document.forms[0].cmdedit.disabled=bcmdEdit;
	document.forms[0].cmdsave.disabled=bcmdsave;
	document.forms[0].cmdcancel.disabled=bcmdCancel;
	document.forms[0].cmdclose.disabled=bcmdClose;
}

</script></head>

<body onLoad="callonload()">
<form class="normal">
<table width="100%" border="0" cellpadding="3" cellspacing="1" class="outertable"><tr><td>
<table width="85%" border="0" cellspacing="1" cellpadding="3" class="outertable">
	<tr>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getNP_ApplicantDeatis','NP_applicantDetails.jsp')" onMouseOut="window.status='';return true;" >Applicant's Details</a></b></td>
		<td class="sub_tab_active" align="center"><b>Co-Applicant's Details</b></td>			
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getNP_Education','NP_Education.jsp')" onMouseOut="window.status='';return true;" >Education Details</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getNP_CourseDetails','NP_CourseDeatils.jsp')" onMouseOut="window.status='';return true;" >Course Details</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getEmplyomentdetails','NP_Employmentdet.jsp')" onMouseOut="window.status='';return true;" >Emplyoment Details</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getFinancialITRDetails','NP_Financial.jsp')" onMouseOut="window.status='';return true;" >Financial & ITR Details</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getDOCDETAILS','NP_Document.jsp')" onMouseOut="window.status='';return true;" >Documents</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getBREmatch','NP_Brematch.jsp')" onMouseOut="window.status='';return true;" >BRE Match</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getNP_EligibilityDeatils','NP_EligibilityDeatils.jsp')" onMouseOut="window.status='';return true;" >Eligibility Details</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getInprincipleDetails','NP_Inprincipaldet.jsp')" onMouseOut="window.status='';return true;" >Inprinciple Details</a></b></td>
			
		</tr>
</table>
<table  width="100%" border="0" cellpadding="3" cellspacing="1" class="outertable">
	<tr>
	<td>
	<%if(arrRow.size()>0 && arrRow!=null){
		for(int i=0;i<arrRow.size();i++){
		ArrayList arrCol = new ArrayList();
		arrCol = (ArrayList)arrRow.get(i);%>
		<h5 class="head"><b>Co-Applicant's Details: <%=i+1 %></b></h5>
	<table width="96%" border="0" cellspacing="0" cellpadding="5" class="outertable">
    <tbody>
      <tr>
      <td width="12%">ID Salutaion</td>
      <td valign="top"><input type="text" name="txt_idsalu" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrCol.get(0))%>">
      </td>
      <td width="12%"> Application Reference ID</td>
      <td valign="top"><input type="text" name="txt_apprefid" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrCol.get(1))%>">
      </td>
      </tr>
      <tr>
        <td>First Name </td>
        <td valign="top"><input type="text" name="txt_fname" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrCol.get(2))%>">
        </td>
        <td>Middle Name </td>
        <td valign="top"><input type="text" name="txt_mname" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrCol.get(3))%>">
        </td>
        <td> Last Name</td>
        <td valign="top"><input type="text" name="txt_lname" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrCol.get(4))%>">
        </td>
        </tr>
        <tr>
          <td>Gender</td>
			<td valign="top"><input type="text" name="sel_gender" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrCol.get(5))%>">
       </td>
          <td>Date of Birth </td>
          <td><input id="datepicker" type="text" name="txt_dateofbirth" size="35" maxlength="10" tabindex="9" value="<%=Helper.correctNull((String)arrCol.get(6)) %>" onblur="checkDate(this);checkmaxdate(this,currentDate);showMinority(this)"> 
         </td>
          <td>Email</td>
          <td valign="top"><input type="text" name="txt_email" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrCol.get(7))%>">
          </td>
          </tr>
          <tr>
            <td>Social Category</td>
            
              <td valign="top"><input type="text" name="txt_socialcat" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrCol.get(8))%>">
           </td>
            <td>Mobile </td>
            <td valign="top"><input type="text" name="txt_mobile" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrCol.get(9))%>">
            </td>
            <td>Marital Status</td>
            
            <td valign="top"><input type="text" name="txt_naritalstat" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrCol.get(10))%>">
           </td>
            </tr>
    </tbody>
    </table>
    <h3 class="head">Aadhar Address</h3>
    <table width="96%" border="0" cellspacing="0" cellpadding="5" class="outertable">
      <tbody>
        <tr>
          <td width="12%">Street Name</td>
          <td valign="top"><input type="text" name="txt_street" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrCol.get(11))%>">
          </td>
          <td width="12%">Landmark</td>
          <td valign="top"><input type="text" name="txt_landmark" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrCol.get(12))%>">
          </td>
          <td>Village</td>
          <td valign="top"><input type="text" name="txt_village" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrCol.get(13))%>">
          </td>
          </tr>
          <tr>
            <td>Sub District</td>
            <td valign="top"><input type="text" name="txt_subdist" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrCol.get(14))%>">
            </td>
            <td>District Name </td>
            <td valign="top"><input type="text" name="txt_dist" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrCol.get(15))%>">
            </td>
            <td>City Name</td>
            <td valign="top"><input type="text" name="txt_city" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrCol.get(16))%>">
            </td>
            </tr>
            <tr>
              <td>Pin Code </td>
              <td valign="top"><input type="text" name="txt_pin" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrCol.get(17))%>">
              </td>
              <td>State Name </td>
              <td valign="top"><input type="text" name="txt_state" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrCol.get(18))%>">
              </td>
              <td>Country Name</td>
              <td valign="top"><input type="text" name="txt_country" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrCol.get(19))%>">
              </td>
              </tr>
      </tbody>
    </table>

    <h3 class="head">Office Address</h3>
    <table width="96%" border="0" cellspacing="0" cellpadding="5" class="outertable">
      <tbody>
        <tr>
          <td width="12%">Street Name</td>
          <td valign="top"><input type="text" name="txt_offstreet" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrCol.get(20))%>">
          </td>
          <td width="12%">Landmark</td>
          <td valign="top"><input type="text" name="txt_offlandmark" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrCol.get(21))%>">
          </td>
          <td>Village</td>
          <td valign="top"><input type="text" name="txt_offvillage" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrCol.get(22))%>">
          </td>
          </tr>
          <tr>
            <td>Sub District</td>
            <td valign="top"><input type="text" name="txt_offsubdist" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrCol.get(23))%>">
            </td>
            <td>District Name </td>
            <td valign="top"><input type="text" name="txt_offdist" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrCol.get(24))%>">
            </td>
            <td>City Name</td>
            <td valign="top"><input type="text" name="txt_offcity" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrCol.get(25))%>">
            </td>
            </tr>
            <tr>
              <td>Pin Code </td>
              <td valign="top"><input type="text" name="txt_offpin" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrCol.get(26))%>">
              </td>
              <td>State Name </td>
              <td valign="top"><input type="text" name="txt_offstate" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrCol.get(27))%>">
              </td>
              <td>Country Name</td>
              <td valign="top"><input type="text" name="txt_offcountry" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrCol.get(28))%>">
              </td>
              </tr>
              <tr>
                <!--<td>IS Chairman </td>
                <td valign="top">
                  <select id="sel1" name="sel_ischairman">
                    <option value="1">Yes</option>
                    <option value="2">No</option>
                  </select>
                </td>
                <td>Relationship </td>
                <td valign="top">
                  <select name="sel_relationship" tabindex="84">
                    <option value="0" selected="">--Select--</option>
                    <option value="1">All Banking done through Bank</option>
                    <option value="2">Good Track record of Banking with our Bank</option>
                    <option value="3">Short term relationship</option>
                    <option value="4">No existing relationship</option>
                  </select>
                </td>
                -->
                </tr>
                <tr>
                  <td>Gross Monthly Income </td>
                  <td valign="top"><input type="text"  name="txt_grossincome" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrCol.get(30))%>">
                  </td>
                  <td>Residental Status </td>
                  
                  <td valign="top"><input type="text" name="txt_residental" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrCol.get(31))%>">
           
                 
                    <td>Is Current Address Same</td>
                    
                     <td valign="top"><input type="text" name="txt_currentaddress" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrCol.get(32))%>">
           
                    </td>
                    </tr>
                    <tr>
                      <td>Education Qualification </td>
                      
                      <td valign="top"><input type="text" name="txt_eduquali" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrCol.get(33))%>">
                      </td>
                      <td>Occupation</td>
	                  <td valign="top"><input type="text" name="txt_offoccupation" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrCol.get(29))%>">
	                  </td>
                      <!--<td>Marks</td>
                      <td valign="top"><input type="text" name="txt_marks" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPPD_MARKS"))%>">
                      </td>
                      --></tr>
                      <tr><!--
                        <td>Remark</td>
                        <td valign="top">
                          <textarea rows="2" id="comment"><%=Helper.correctNull((String)hshValues.get("NPPD_REMARKS"))%></textarea>
                        </td>
                        --></tr>
      </tbody>
    </table>
    </td>
	</tr>
</table>
  <%if(arrEmpRec.size()>0&&arrEmpRec!=null){
    		ArrayList arrEmpCol = new ArrayList();
    		arrEmpCol = (ArrayList) arrEmpRec.get(i);%>
  <table width="96%" border="0" cellspacing="0" cellpadding="5" class="outertable">
    <h3 class="head"><b>Employment Details</b></h3>
    <tbody>
      <tr>
      <td>Employment Type</td>
      
         <td valign="top"><input type="text" name="txt_emptype" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrEmpCol.get(0))%>">
     
      </td>
      <td>RetirementAge</td>
          <td valign="top"><input type="text" name="txt_retirementage" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrEmpCol.get(6))%>">
          </td>
      <td>Organisation Name</td>
      <td valign="top"><input type="text" name="txt_orgname" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrEmpCol.get(2))%>">
      </td>
      </tr>
      <tr>
        <td>Designation</td>
        <td valign="top"><input type="text" name="txt_designation" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrEmpCol.get(3))%>">
        </td>
        <td>Working Since Year</td>
        <td valign="top"><input type="text" name="txt_worksinceyear" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrEmpCol.get(4))%>">
        </td>
        <td>Working Since Month</td>
        <td valign="top"><input type="text" name="txt_worksincemonth" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrEmpCol.get(5))%>">
        </td>
        </tr>
        <tr>
          <td>Business Establishment Year</td>
          <td valign="top"><input type="text" name="txt_bussestablisyear" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrEmpCol.get(7))%>">
          </td>
          <td>Business Establishment Month</td>
          <td valign="top"><input type="text" name="txt_bussestablismonth" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrEmpCol.get(8))%>">
          </td>
          <td>Current Businees Year</td>
          <td valign="top"><input type="text" name="txt_currentbusyearin" size="35" maxlength="50" value="<%=Helper.correctNull((String)arrEmpCol.get(9))%>">
          </td>
          </tr>
    </tbody>
</table>
<%}else{%>
<table width="96%" border="0" cellspacing="0" cellpadding="5" class="outertable">
    <h3 class="head">Employment Details</h3>
    <tbody>
      <tr>
      <td>Employment Type</td>
      
         <td valign="top"><input type="text" name="txt_emptype" size="35" maxlength="50" value="">
     
      </td>
      <td>RetirementAge</td>
          <td valign="top"><input type="text" name="txt_retirementage" size="35" maxlength="50" value="">
          </td>
      <td>Organisation Name</td>
      <td valign="top"><input type="text" name="txt_orgname" size="35" maxlength="50" value="">
      </td>
      </tr>
      <tr>
        <td>Designation</td>
        <td valign="top"><input type="text" name="txt_designation" size="35" maxlength="50" value="">
        </td>
        <td>Working Since Year</td>
        <td valign="top"><input type="text" name="txt_worksinceyear" size="35" maxlength="50" value="">
        </td>
        <td>Working Since Month</td>
        <td valign="top"><input type="text" name="txt_worksincemonth" size="35" maxlength="50" value="">
        </td>
        </tr>
        <tr>
          <td>Business Establishment Year</td>
          <td valign="top"><input type="text" name="txt_bussestablisyear" size="35" maxlength="50" value="">
          </td>
          <td>Business Establishment Month</td>
          <td valign="top"><input type="text" name="txt_bussestablismonth" size="35" maxlength="50" value="">
          </td>
          <td>Current Businees Year</td>
          <td valign="top"><input type="text" name="txt_currentbusyearin" size="35" maxlength="50" value="">
          </td>
          </tr>
    </tbody>
</table>
<%}%>
	<%}}else{%>
	<h3 class="head">Co-Applicant's Details</h3>
	<table width="96%" border="0" cellspacing="0" cellpadding="5" class="outertable">
    <tbody>
      <tr>
      <td width="12%">ID Salutaion</td>
      <td valign="top"><input type="text" name="" size="35" maxlength="50" value="">
      </td>
      <td width="12%"> Application Reference ID</td>
      <td valign="top"><input type="text" name="" size="35" maxlength="50" value="">
      </td>
      </tr>
      <tr>
        <td>First Name </td>
        <td valign="top"><input type="text" name="" size="35" maxlength="50" value="">
        </td>
        <td>Middle Name </td>
        <td valign="top"><input type="text" name="" size="35" maxlength="50" value="">
        </td>
        <td> Last Name</td>
        <td valign="top"><input type="text" name="" size="35" maxlength="50" value="">
        </td>
        </tr>
        <tr>
          <td>Gender</td>
             <td><input id="datepicker" type="text" name="txt_dateofbirth" size="35" maxlength="10" tabindex="9" value="" onblur="checkDate(this);checkmaxdate(this,currentDate);showMinority(this)"> 
          </td>
          <td>Date of Birth </td>
          <td><input id="datepicker" type="text" name="txt_dateofbirth" size="35" maxlength="10" tabindex="9" value="" onblur="checkDate(this);checkmaxdate(this,currentDate);showMinority(this)"> 
          </td>
          <td>Email</td>
          <td valign="top"><input type="text" name="" size="35" maxlength="50" value="">
          </td>
          </tr>
          <tr>
            <td>Social Category</td>
            <td><input id="datepicker" type="text" name="txt_dateofbirth" size="35" maxlength="10" tabindex="9" value="" onblur="checkDate(this);checkmaxdate(this,currentDate);showMinority(this)"> 
            </td>
            <td>Mobile </td>
            <td valign="top"><input type="text" name="" size="35" maxlength="50" value="">
            </td>
            <td>Marital Status</td>
             <td><input id="datepicker" type="text" name="txt_dateofbirth" size="12" maxlength="10" tabindex="9" value="" onblur="checkDate(this);checkmaxdate(this,currentDate);showMinority(this)"> 
            </td>
            </tr>
    </tbody>
    </table>
    <h3 class="head">Aadhar Address</h3>
    <table width="96%" border="0" cellspacing="0" cellpadding="5" class="outertable">
      <tbody>
        <tr>
          <td width="12%">Street Name</td>
          <td valign="top"><input type="text" name="" size="35" maxlength="50" value="">
          </td>
          <td width="12%">Landmark</td>
          <td valign="top"><input type="text" name="" size="35" maxlength="50" value="">
          </td>
          <td>Village</td>
          <td valign="top"><input type="text" name="" size="35" maxlength="50" value="">
          </td>
          </tr>
          <tr>
            <td>Sub District</td>
            <td valign="top"><input type="text" name="" size="35" maxlength="50" value="">
            </td>
            <td>District Name </td>
            <td valign="top"><input type="text" name="" size="35" maxlength="50" value="">
            </td>
            <td>City Name</td>
            <td valign="top"><input type="text" name="" size="35" maxlength="50" value="">
            </td>
            </tr>
            <tr>
              <td>Pin Code </td>
              <td valign="top"><input type="text" name="" size="35" maxlength="50" value="">
              </td>
              <td>State Name </td>
              <td valign="top"><input type="text" name="" size="35" maxlength="50" value="">
              </td>
              <td>Country Name</td>
              <td valign="top"><input type="text" name="" size="35" maxlength="50" value="">
              </td>
              </tr>
      </tbody>
    </table>

    <h3 class="head">Office Address</h3>
    <table width="96%" border="0" cellspacing="0" cellpadding="5" class="outertable">
      <tbody>
        <tr>
          <td width="12%">Street Name</td>
          <td valign="top"><input type="text" name="" size="35" maxlength="50" value="">
          </td>
          <td width="12%">Landmark</td>
          <td valign="top"><input type="text" name="" size="35" maxlength="50" value="">
          </td>
          <td>Village</td>
          <td valign="top"><input type="text" name="" size="35" maxlength="50" value="">
          </td>
          </tr>
          <tr>
            <td>Sub District</td>
            <td valign="top"><input type="text" name="" size="35" maxlength="50" value="">
            </td>
            <td>District Name </td>
            <td valign="top"><input type="text" name="" size="35" maxlength="50" value="">
            </td>
            <td>City Name</td>
            <td valign="top"><input type="text" name="" size="35" maxlength="50" value="">
            </td>
            </tr>
            <tr>
              <td>Pin Code </td>
              <td valign="top"><input type="text" name="" size="35" maxlength="50" value="">
              </td>
              <td>State Name </td>
              <td valign="top"><input type="text" name="" size="35" maxlength="50" value="">
              </td>
              <td>Country Name</td>
              <td valign="top"><input type="text" name="" size="35" maxlength="50" value="">
              </td>
              </tr>
              <tr>
                <!--<td>IS Chairman </td>
                <td valign="top">
                  <select id="sel1" name="sel_ischairman">
                    <option value="1">Yes</option>
                    <option value="2">No</option>
                  </select>
                </td>
                <td>Relationship </td>
                <td valign="top">
                  <select name="sel_relationship" tabindex="84">
                    <option value="0" selected="">--Select--</option>
                    <option value="1">All Banking done through Bank</option>
                    <option value="2">Good Track record of Banking with our Bank</option>
                    <option value="3">Short term relationship</option>
                    <option value="4">No existing relationship</option>
                  </select>
                </td>
                -->
                </tr>
                <tr>
                  <td>Gross Monthly Income </td>
                  <td valign="top"><input type="text" class="form-control text-right" name="" size="35" maxlength="50" value="">
                  </td>
                  <td>Residental Status </td>
                    <td><input id="datepicker" type="text" name="txt_dateofbirth" size="35" maxlength="10" tabindex="9" value="" onblur="checkDate(this);checkmaxdate(this,currentDate);showMinority(this)"> 
                  </td>
                  <td>Voter No</td>
                  <td valign="top"><input type="text" name="" size="35" maxlength="50" value="">
                  </td>
                  </tr>
                  <tr>
                    <td>PAN No </td>
                    <td valign="top"><input type="text" name="" size="35" maxlength="50" value="">
                    </td>
                    <td>Is Current Address Same</td>
                    <td><input id="datepicker" type="text" name="txt_dateofbirth" size="35" maxlength="10" tabindex="9" value="" onblur="checkDate(this);checkmaxdate(this,currentDate);showMinority(this)"> 
                    </td>
                    </tr>
                    <tr>
                      <td>Education Qualification </td>
                         <td><input id="datepicker" type="text" name="txt_dateofbirth" size="35" maxlength="10" tabindex="9" value="" onblur="checkDate(this);checkmaxdate(this,currentDate);showMinority(this)"> 
                      </td>
                      <td>Occupation</td>
	                  <td><input id="datepicker" type="text" name="txt_dateofbirth" size="35" maxlength="10" tabindex="9" value="" onblur="checkDate(this);checkmaxdate(this,currentDate);showMinority(this)"> 
	                  </td>
                    </tr>
      </tbody>
    </table>
    <table width="96%" border="0" cellspacing="0" cellpadding="5" class="outertable">
    <h3 class="head">Employment Details</h3>
    <tbody>
      <tr>
      <td>Employment Type</td>
      
         <td valign="top"><input type="text" name="txt_emptype" size="35" maxlength="50" value="">
     
      </td>
      <td>RetirementAge</td>
          <td valign="top"><input type="text" name="txt_retirementage" size="35" maxlength="50" value="">
          </td>
      <td>Organisation Name</td>
      <td valign="top"><input type="text" name="txt_orgname" size="35" maxlength="50" value="">
      </td>
      </tr>
      <tr>
        <td>Designation</td>
        <td valign="top"><input type="text" name="txt_designation" size="35" maxlength="50" value="">
        </td>
        <td>Working Since Year</td>
        <td valign="top"><input type="text" name="txt_worksinceyear" size="35" maxlength="50" value="">
        </td>
        <td>Working Since Month</td>
        <td valign="top"><input type="text" name="txt_worksincemonth" size="35" maxlength="50" value="">
        </td>
        </tr>
        <tr>
          <td>Business Establishment Year</td>
          <td valign="top"><input type="text" name="txt_bussestablisyear" size="35" maxlength="50" value="">
          </td>
          <td>Business Establishment Month</td>
          <td valign="top"><input type="text" name="txt_bussestablismonth" size="35" maxlength="50" value="">
          </td>
          <td>Current Businees Year</td>
          <td valign="top"><input type="text" name="txt_currentbusyearin" size="35" maxlength="50" value="">
          </td>
          </tr>
    </tbody>
</table>
    </td>
	</tr>
</table>
  <%}%>
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
<input type="hidden" name="strApplicationRefNo" value=<%=strApplicationRefNo%>>
</form>
</body>
</html>

</body>
</html>