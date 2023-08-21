<%@include file="../share/directives.jsp"%>
<%ArrayList arryCol = null;
ArrayList arryRow = (ArrayList) hshValues.get("arryRow");%>
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
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script><script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function callclose()
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mainnav.jsp";
	document.forms[0].submit();
}
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
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/mainnav.jsp";	
		document.forms[0].submit();
	}
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
		<td class="sub_tab_active" align="center"><b>BRE Match</b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getNP_EligibilityDeatils','NP_EligibilityDeatils.jsp')" onMouseOut="window.status='';return true;" >Eligibility Details</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getInprincipleDetails','NP_Inprincipaldet.jsp')" onMouseOut="window.status='';return true;" >Inprinciple Details</a></b></td>		
		</tr>
</table>
<h3 class="head"><b>BRE Match</b></h3>
 
<table width="100%" align="center" cellspacing="0" cellpadding="0" border="0" class="outertable border mt20">
  <tbody>
    <tr class="dataheader padtdlr3">
    <th width="11%" align="center">Application Reference Id</th>
    <th width="16%" align="center">Id</th>
    <th align="center" width="13%">Parameter Name as Per BRE</th>
      <th align="center" width="13%">Borrower Value</th>
        <th align="center" width="13%">Product Value</th>
          <th align="center" width="13%">Applicant Type</th>
            <th align="center" width="13%">Mandatory</th>
              <th align="center" width="13%">Matched</th>
              

  </tr>
  
  
  
  <%if (arryRow != null && arryRow.size() > 0) {
				for (int i = 0; i < arryRow.size(); i++) {
					arryCol = (ArrayList) arryRow.get(i);%>
					<tr valign="top" class="datagrid">
					
					
						<td><%=Helper.correctNull((String) arryCol.get(0))%>&nbsp;</td>
						<td><%=Helper.correctNull((String) arryCol.get(1))%>&nbsp;</td>
						<td><%=Helper.correctNull((String) arryCol.get(2))%>&nbsp;</td>
						<td><%=arryCol.get(3)%>&nbsp;</td>
						<td><%= arryCol.get(4)%>&nbsp;</td>
						<td><%=Helper.correctNull((String) arryCol.get(5))%>&nbsp;</td>
						<td><%=Helper.correctNull((String) arryCol.get(6))%>&nbsp;</td>
						<td><%=Helper.correctNull((String) arryCol.get(7))%>&nbsp;</td>
						
					</tr>
					<%}
			}%>
</tbody></table>
<br><br><br>
  <lapschoice:hiddentag pageid="<%=PageId%>"/>
<table border="0" cellspacing="0" cellpadding="0"  align="center">
      <tr valign="middle"> 
       <td> 
		<input type="button" name="cmdclose" value="Close" class="buttonClose" onClick="callclose();">
	
            
        </td></tr></table>
<input type="hidden" name="strApplicationRefNo" value=<%=strApplicationRefNo%>>
</form>
</body>
</html> 

