<%@include file="../share/directives.jsp"%>
<%String strApplicationRefNo=Helper.correctNull((String)hshValues.get("strApplicationRefNo"));
%>
<%
ArrayList arrRec = new ArrayList();
ArrayList arrRec1 = new ArrayList();
ArrayList arrRow =  new ArrayList(); 
arrRec = (ArrayList) hshValues.get("arrRec");
arrRec1 = (ArrayList) hshValues.get("arrRec1");
arrRow = (ArrayList) hshValues.get("arrRow");
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


</script></head>

<body onLoad="callonload()">
<form class="normal">
<table width="85%" border="0"   cellspacing="1" cellpadding="3" class="outertable">
	<tr>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getNP_ApplicantDeatis','NP_applicantDetails.jsp')" onMouseOut="window.status='';return true;" >Applicant's Details</a></b></td>		
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getNP_CoApplicantDeatils','NP_coapplicantDetails.jsp')" onMouseOut="window.status='';return true;" >Co-Applicant's Details</a></b></td>		
		<td class="sub_tab_active" align="center"><b>Education Details</b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getNP_CourseDetails','NP_CourseDeatils.jsp')" onMouseOut="window.status='';return true;" >Course Details</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getFinancialITRDetails','NP_Financial.jsp')" onMouseOut="window.status='';return true;" >Financial & ITR Details</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getDOCDETAILS','NP_Document.jsp')" onMouseOut="window.status='';return true;" >Documents</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getBREmatch','NP_Brematch.jsp')" onMouseOut="window.status='';return true;" >BRE Match</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getNP_EligibilityDeatils','NP_EligibilityDeatils.jsp')" onMouseOut="window.status='';return true;" >Eligibility Details</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getInprincipleDetails','NP_Inprincipaldet.jsp')" onMouseOut="window.status='';return true;" >Inprinciple Details</a></b></td>		
		</tr>
</table>
<h3 class="head"><B>Education Details</B></h3>
	<table align="center" width="100%" >
	   <tr>
		<td>
		<table width="100%" align="center" cellspacing="0" cellpadding="0" border="0" class="outertable border mt20">
		
	  <tbody>
	    <tr class="dataheader padtdlr3">
	    <th width="20%" align="left">Institute Name</th>
	    <th width="10%" align="left">Year</th>
	    <th width="15%" align="left">Number of Attempts</th>
	    <th width="10%" align="left">Marks</th>
	    <th width="15%" align="left">Obtain of Class</th>
	    <th width="20%" align="left">Specialization</th>
	  </tr>
	  <%if(arrRow.size()>0){
	  for(int i=0; i<arrRow.size();i++){
		  ArrayList arrCol = new ArrayList();
		  arrCol = (ArrayList) arrRow.get(i);
	  %>
	  <tr>
	    <td><%=Helper.correctNull((String)arrCol.get(0))%></td>
	    <td><%=Helper.correctNull((String)arrCol.get(1))%></td>
	    <td><%=Helper.correctNull((String)arrCol.get(3))%></td>
	    <td><%=Helper.correctNull((String)arrCol.get(2))%></td>
	    <td><%=Helper.correctNull((String)arrCol.get(4))%></td>
	    <td><%=Helper.correctNull((String)arrCol.get(5))%></td>
	  </tr>
	  <%}}%>
	</tbody>
	</table>
	<h3 class="head"><B>Security Details</B></h3>
	<table width="50%" align="center" cellspacing="0" cellpadding="0" border="0" class="outertable">
	  <tbody>
	    <tr class="dataheader padtdlr3">
	    <th  align="center" >Type of Security</th>
	    <th align="center" >Amount</th>
	  </tr>
	  <%if(arrRec.size()>0){
	  for(int i=0; i<arrRec.size();i++){
		  ArrayList arrCol = new ArrayList();
		  arrCol = (ArrayList) arrRec.get(i);
	  %>
	  <tr>
	    <td align="center" ><%=Helper.correctNull((String)arrCol.get(0))%></td>
	    <td align="center" ><%=Helper.correctNull((String)arrCol.get(1))%></td>
	  </tr>
	  <%}}%>
	</tbody>
	</table>
	
	<h3 class="head"><B>Scholarship Details List</B></h3>
	<table width="100%" cellspacing="0" align="center"  cellpadding="0" border="0" class="outertable">
	  <tbody>
	    <tr class="dataheader padtdlr3">
	    <th  align="center">Field of scholarship</th>
	    <th  align="center">Name of scholarship</th>
	    <th  align="center">Amount of scholarship</th>
	    <th  align="center">Any scholarship availed for this course</th>
	  </tr>
	  <%if(arrRec1.size()>0){
	  for(int i=0; i<arrRec1.size();i++){
		  ArrayList arrCol = new ArrayList();
		  arrCol = (ArrayList) arrRec1.get(i);
	  %>
	  <tr>
	    <td align="center"><%=Helper.correctNull((String)arrCol.get(0))%></td>
	    <td align="center"><%=Helper.correctNull((String)arrCol.get(1))%></td>
	    <td align="center"><%=Helper.correctNull((String)arrCol.get(2))%></td>
	    <td align="center"><%=Helper.correctNull((String)arrCol.get(4))%></td>
	  </tr>
	  <%}}%>
	</tbody>
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
	</form>
	</body>
	</html>

