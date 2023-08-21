<%@include file="../share/directives.jsp"%>
<%String strApplicationRefNo=Helper.correctNull((String)hshValues.get("strApplicationRefNo"));
if(strApplicationRefNo.equalsIgnoreCase(""))
{
	strApplicationRefNo= Helper.correctNull((String) session.getAttribute("strApplicationRefNo"));
}
ArrayList arrData = new ArrayList();
ArrayList arrRow = new ArrayList();
int vecsize = 0;
if (hshValues != null) {
	arrData = (ArrayList) hshValues.get("arrRow");
}
int NPCD_APPLICANT_CONTRIBUTION=0,NPCD_LOAN_AMT_REQ=0;
String val1=Helper.correctNull((String)hshValues.get("NPCD_APPLICANT_CONTRIBUTION"));
String val2=Helper.correctNull((String)hshValues.get("NPCD_LOAN_AMT_REQ"));
if(val1.equalsIgnoreCase(""))
{
	val1="0";
}
if(val2.equalsIgnoreCase(""))
{
	val2="0";
}

 NPCD_APPLICANT_CONTRIBUTION=Integer.parseInt((val1));
 NPCD_LOAN_AMT_REQ=Integer.parseInt((val2));

int amount=NPCD_APPLICANT_CONTRIBUTION+NPCD_LOAN_AMT_REQ;




String NPCD_IS_PART_TIME_EMP= Helper.correctNull((String)hshValues.get("NPCD_IS_PART_TIME_EMP"));
String NPCD_IS_REPAY_INTEREST= Helper.correctNull((String)hshValues.get("NPCD_IS_REPAY_INTEREST"));
String NPCD_IS_SECURITY=  Helper.correctNull((String)hshValues.get("NPCD_IS_SECURITY"));
String NPCD_PASSPORT_OBTAINED=  Helper.correctNull((String)hshValues.get("NPCD_PASSPORT_OBTAINED"));

if(NPCD_IS_REPAY_INTEREST.equalsIgnoreCase("true")){
	NPCD_IS_REPAY_INTEREST="Yes";
}else{
	NPCD_IS_REPAY_INTEREST="No";
}
if(NPCD_IS_SECURITY.equalsIgnoreCase("true")){
	NPCD_IS_SECURITY="Yes";
}else{
	NPCD_IS_SECURITY="No";
}
if(NPCD_PASSPORT_OBTAINED.equalsIgnoreCase("true")){
	NPCD_PASSPORT_OBTAINED="Yes";
}else{
	NPCD_PASSPORT_OBTAINED="No";
}
if(NPCD_IS_PART_TIME_EMP.equalsIgnoreCase("true")){
	NPCD_IS_PART_TIME_EMP="Yes";
}else{
	NPCD_IS_PART_TIME_EMP="No";
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
function selectValues(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,
		val11,val12,val13,val14,val15,val16,val17,val18,val19,val20,val21,val22,val23)
{

	document.forms[0].sel_type.value=val1;
	document.forms[0].txt_yearcourse.value=val2;
	document.forms[0].txt_totlamtyear.value=val3;
	document.forms[0].txt_coursename.value=val4;
	document.forms[0].txt_universityname.value=val5;
	document.forms[0].sel_quotasel.value=val6;
	document.forms[0].txt_institute.value=val7;
	document.forms[0].txt_locationinst.value=val8;
	document.forms[0].sel_typeofcourse.value=val9;
	document.forms[0].txt_coursestatdate.value=val10;

	document.forms[0].txt_coursecopldate.value=val11;
	document.forms[0].txt_courseduration.value=val12;
	document.forms[0].txt_appcontribution.value=val13;
	document.forms[0].txt_loanamt.value=val14;
	document.forms[0].sel_repay.value=val15;
	document.forms[0].sel_secprovide.value=val16;
	document.forms[0].txt_repayment.value=val17;
	document.forms[0].txt_tenure.value=val18;
	document.forms[0].txt_amount.value=val19;
	document.forms[0].sel_passportobtain.value=val20;


	document.forms[0].txt_passportno.value=val21;
	document.forms[0].sel_parttime.value=val22;
	document.forms[0].comment.value=val23;
	
}
</script></head>

<body onLoad="callonload()">
<form class="normal">
<table width="85%" border="0" cellspacing="1" cellpadding="3" class="outertable">
	<tr>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getNP_ApplicantDeatis','NP_applicantDetails.jsp')" onMouseOut="window.status='';return true;" >Applicant's Details</a></b></td>		
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getNP_CoApplicantDeatils','NP_coapplicantDetails.jsp')" onMouseOut="window.status='';return true;" >Co-Applicant's Details</a></b></td>		
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getNP_Education','NP_Education.jsp')" onMouseOut="window.status='';return true;" >Education Details</a></b></td>
		<td class="sub_tab_active" align="center">Course Details</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getFinancialITRDetails','NP_Financial.jsp')" onMouseOut="window.status='';return true;" >Financial & ITR Details</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getDOCDETAILS','NP_Document.jsp')" onMouseOut="window.status='';return true;" >Documents</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getBREmatch','NP_Brematch.jsp')" onMouseOut="window.status='';return true;" >BRE Match</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getNP_EligibilityDeatils','NP_EligibilityDeatils.jsp')" onMouseOut="window.status='';return true;" >Eligibility Details</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getInprincipleDetails','NP_Inprincipaldet.jsp')" onMouseOut="window.status='';return true;" >Inprinciple Details</a></b></td>		
		</tr>
</table>
<h3 class="head"><B>Cost of Course</B></h3>
<table>
		<tr>
	<td>


<table width="96%" border="0" cellspacing="0" cellpadding="5" class="outertable">
  <tbody><!--
    <tr>
      <td>Type</td>
      <td valign="top"><input type="text" name="sel_type" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPCC_COURSE_TYPE"))%>">
        
      </td>
      <td>Year of Course</td>
      <td valign="top"><input type="text" name="txt_yearcourse" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPCC_COURSE_YEAR"))%>">
      </td> </tr>
      --><tr>
        <!--<td>Total amount of above year</td>
        <td valign="top"><input type="text" name="txt_totlamtyear" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPCC_COURSE_AMOUNT"))%>">
        </td>
        --><td>Course Name</td>
        <td valign="top"><input type="text" name="txt_coursename" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPCD_COURSE_NAME"))%>">
        </td>
        <td>University Name</td>
        <td valign="top"><input type="text" name="txt_universityname" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPCD_UNIV_NAME"))%>">
        </td>
        </tr>
        <tr>
          <td>Quota Selection</td>
     <td valign="top"><input type="text" name="sel_quotasel" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPCD_QUOTA_SELE"))%>">
       
          </td>
          <td>Institute Name</td>
          <td valign="top"><input type="text" name="txt_institute" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPCD_INSIT_NAME"))%>">
          </td>
          <td>Location of institution/university</td>
          <td valign="top"><input type="text" name="txt_locationinst" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPCD_INSIT_LOC"))%>">
          </td>
          </tr>
          <tr>
            <td>Type of Course</td>
    		<td valign="top"><input type="text" name="sel_typeofcourse" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPCD_TYPE_OF_COURSE"))%>">
           
            </td>
            <td>Course Start Date</td>
            <td valign="top"><input type="text" name="txt_coursestatdate" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPCD_COURSE_START_DATE"))%>">
            </td>
            <td>Course Complete Date</td>
            <td valign="top"><input type="text" name="txt_coursecopldate" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPCD_COURSE_END_DATE"))%>">
            </td>
            </tr>
            <tr>
              <td>Course Duration</td>
              <td valign="top"><input type="text" name="txt_courseduration" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPCD_COURSE_DURATION"))%>">
              </td>
               <td>Will you take part time employment during the course</td>
                    
                       <td valign="top"><input type="text" name="sel_parttime" size="35" maxlength="50" value="<%=NPCD_IS_PART_TIME_EMP%>">
                   
                    </td>
                    <td>Description</td>
                    <td valign="top">
                      <textarea rows="2" name="comment"><%=Helper.correctNull((String)hshValues.get("NPCD_EMPLOYEMENT_DESC"))%></textarea>
                    </td>
              </tr>

              <tr>
                <td>Are you willing to repay interest during the course period</td>
               	  <td valign="top"><input type="text" name="sel_repay" size="35" maxlength="50" value="<%=NPCD_IS_REPAY_INTEREST%>">
             
                </td>
                <td>Do you have any security to Provide</td>
               
                   <td valign="top"><input type="text" name="sel_secprovide" size="35" maxlength="50" value="<%=NPCD_IS_SECURITY%>">
             
                </td>
                <td>Repayment By</td>
                <td valign="top"><input type="text" name="txt_repayment" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPCD_REPAYMENT_BY"))%>">
                </td>
                </tr>

                <tr>
                  <td>Tenure</td>
                  <td valign="top"><input type="text" name="txt_tenure" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPCD_TENURE"))%>">
                  </td>
                 
                  <td>Passport obtained</td>
               <td valign="top"><input type="text" name="sel_passportobtain" size="35" maxlength="50" value="<%=NPCD_PASSPORT_OBTAINED%>">
                   
                  </td>
                   <td>Passport Number</td>
                    <td valign="top"><input type="text" name="txt_passportno" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPCD_PASSPORT_NO"))%>">
                    </td>
                  </tr>

                  <tr>
                     <td>Applicant's contribution</td>
		              <td valign="top"><input type="text" name="txt_appcontribution" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPCD_APPLICANT_CONTRIBUTION"))%>">
		              </td>
		              <td>Loan Amount Required</td>
		              <td valign="top"><input type="text" name="txt_loanamt" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPCD_LOAN_AMT_REQ"))%>">
		              </td>
		               <td>Amount</td>
                 		<td valign="top"><input type="text" name="txt_amount" size="35" maxlength="50" value="<%=amount%>">
                  </td>
                    </tr>
              
  </tbody>
</table>
<br><br>
<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
									<tr class="dataheader">
										<td colspan='2' align='center'>Cost of Estimates</td>
										<td colspan='2' align="center">Year of Study</td>
									</tr>
									<tr class="dataheader">
										<td width="4%" align="center">S No.</td>
										<td width="20%" align="center">Item of Expenses</td>
										<td width="10%" align="center">Year</td>
										<td width="20%" align="center">Expenses</td>
									</tr>
									<%
										if (arrData != null) {
									
										vecsize = arrData.size();
											//out.println("vecsize"+vecsize);
										}for (int i = 0; i < vecsize; i++) {
											arrRow = (ArrayList) arrData.get(i);
											
											if (arrRow != null) {
											String 	strSno = Helper.correctNull((String) arrRow.get(0));
									%>
									<tr class="datagrid">
										
										<td align="center">&nbsp;<%=Helper.correctNull((String) arrRow.get(0))%></td>
										<td align="center">&nbsp;<%=Helper.correctNull((String) arrRow.get(1))%></td>
										<td align="center">&nbsp; <%=Helper.correctNull((String) arrRow.get(2))%></td>
										<td align="center">&nbsp; <%=Helper.correctNull((String) arrRow.get(3))%></td>
										
										</tr>
									<%
										}
										}
									%>
								</table>
								

	 </td>
	</tr>
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
<input type="hidden" name="strApplicationRefNo" value=<%=strApplicationRefNo%>>
<input type="hidden" name="hidsno" value="">
</form>


</body>
</html>