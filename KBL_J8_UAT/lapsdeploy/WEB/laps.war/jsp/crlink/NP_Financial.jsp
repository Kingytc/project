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
function selectValues(val1,val2,val3,val4,val5,val6,val7,val8,val9)
{
	document.forms[0].hidsno.value=val1
	document.forms[0].txt_grossannualincome.value=val2
	document.forms[0].txt_salaryincome.value=val3
	document.forms[0].txt_houseincome.value=val4
	document.forms[0].txt_business.value=val5
	document.forms[0].txt_sourcesincome.value=val6
	document.forms[0].txt_grossincome.value=val7
	document.forms[0].txt_taxincome.value=val9;
	document.forms[0].sel_manual.value=val8;
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
		<td class="sub_tab_active" align="center"><b>Financial & ITR Details</b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getDOCDETAILS','NP_Document.jsp')" onMouseOut="window.status='';return true;" >Documents</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getBREmatch','NP_Brematch.jsp')" onMouseOut="window.status='';return true;" >BRE Match</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getNP_EligibilityDeatils','NP_EligibilityDeatils.jsp')" onMouseOut="window.status='';return true;" >Eligibility Details</a></b></td>		
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getInprincipleDetails','NP_Inprincipaldet.jsp')" onMouseOut="window.status='';return true;" >Inprinciple Details</a></b></td>		
		</tr>
</table>
  <table width="96%" border="0" cellspacing="0" cellpadding="5" class="outertable">
    <h3 class="head"><b>Financial & ITR Details</b></h3>
    <tbody>
      <tr>
      <td>Gross Annual Income</td>
				
      <td valign="top"><input type="text" name="txt_grossannualincome" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPFD_GROSS_MONTHLY_INCOME"))%>">
      </td>
      <td> Salary Income</td>
      <td valign="top"><input type="text" name="txt_salaryincome" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPFD_SALARY_INCOME"))%>">
      </td></tr>
      <tr><td>House Property Income </td>
        <td valign="top"><input type="text" name="txt_houseincome" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPFD_HOUSE_PROPERTY"))%>">
        </td>
        <td>Profits & Gains from Business/Profession </td>
        <td valign="top"><input type="text" name="txt_business" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPFD_PGBP"))%>">
        </td>
        </tr>
        <tr>
          <td>Other Sources Income </td>
          <td valign="top"><input type="text" name="txt_sourcesincome" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPFD_OTHER_SOURCE"))%>">
          </td>
          <td>Gross Income </td>
          <td valign="top"><input type="text" name="txt_grossincome" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPFD_GROSS_INCOME"))%>">
          </td>
          </tr>
          <tr>
            <td>Taxable Income </td>
            <td valign="top"><input type="text" name="txt_taxincome" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPFD_TAXABLE_INCOME"))%>">
            </td>
            <td>Filled Manual Or Not </td>
            
               <td valign="top"><input type="text" name="sel_manual" size="35" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("NPFD_IS_MANUALLY_FILLED"))%>">
           
            </td>
            </tr>
    </tbody>
</table>
<table width="100%" border="0" cellspacing="1" cellpadding="2"
									class="outertable">
									
									<tr class="dataheader">
										<td >&nbsp;</td>
										<td align="center">Applicant / Co-Applicant</td>
										<td align="center">Gross Annual Income</td>
										<td align="center" >Salary Income</td>
										<td align="center" ><p>Profits & Gains from Business/Profession</p></td>
										
									</tr>
									<%
										if (arrData != null) {
									
										vecsize = arrData.size();
										}for (int i = 0; i < vecsize; i++) {
											arrRow = (ArrayList) arrData.get(i);
											
											if (arrRow != null) {
											String 	strSno = Helper.correctNull((String) arrRow.get(0));
									%>
									<tr class="datagrid">
										<td align="center"><input type="radio" name="sno" style="border-style: none"
											onClick="selectValues('<%=strSno%>','<%=Helper.correctNull((String) arrRow.get(1))%>',
											'<%=Helper.correctNull((String) arrRow.get(2))%>',
											'<%=Helper.correctNull((String) arrRow.get(3))%>',
											'<%=Helper.correctNull((String) arrRow.get(4))%>',
											'<%=Helper.correctNull((String) arrRow.get(5))%>',
											'<%=Helper.correctNull((String) arrRow.get(6))%>',
											'<%=Helper.correctNull((String) arrRow.get(7))%>',
											'<%=Helper.correctNull((String) arrRow.get(8))%>')"></td>
										<td align="center"><%=Helper.correctNull((String) arrRow.get(9))%></td>
										<td align="center"><%=Helper.correctNull((String) arrRow.get(1))%></td>
										<td align="center">&nbsp;<%=Helper.correctNull((String) arrRow.get(2))%></td>
										<td align="center">&nbsp; <%=Helper.correctNull((String) arrRow.get(4))%></td>
										</tr>
									<%
										}
										}
									%>
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
<INPUT TYPE="hidden" name="strApplicationRefNo" value=<%=strApplicationRefNo%>>
<INPUT TYPE="hidden" name="hidsno" value="">
</form>
</body>
</html> 
