<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />        
<lapschoice:handleerror />
<%
session.setAttribute("CURRENT_TAB","EDU_DETAILS");
ArrayList arrRow = (ArrayList)hshValues.get("arrRow"); 
ArrayList arrCol = new ArrayList();
ArrayList arrInsRow = (ArrayList)hshValues.get("arrInsRow"); 
ArrayList arrInsCol = new ArrayList();
ArrayList arrSecRow = (ArrayList)hshValues.get("arrSecRow"); 
ArrayList arrSecCol = new ArrayList();
ArrayList arrSchRow = (ArrayList)hshValues.get("arrSchRow"); 
ArrayList arrSchCol = new ArrayList();
%>

<html>
<head>
<title>National Portal - Education & Course Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>

<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/NationalPortal.css" type="text/css">

<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<link rel="stylesheet"href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";



function callOnLoad()
{

}
function callclose()
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mainnav.jsp";
	document.forms[0].submit();
}
</script>

</head>
<body onload="callOnLoad()">


<form name="docVerForm" method="post" action="" class="normal">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td valign="top" colSpan="5"> 
      <jsp:include page="PSB59ApplicationDetails.jsp"> </jsp:include>
    </td>
  </tr>
</table> 
<table width="100%" border="0" cellpadding="3" cellspacing="0"  class="shadow" align="center">
<tr><td>     
<table width="100%"  cellspacing="0" cellpadding="0" class ="outertable border1">

	        
<tr class="dataheader" align="center">
	<td >
	<font size="2"> EDUCATION & COURSE DETAILS </font></td></tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		 <tr class="dataheader">
        	<td width="10%"    align="center"> Institute Name</td>
			<td width="10%"    align="center"> Year</td>
			<td width="10%"    align="center"> No of Attempts</td>
			<td width="10%"    align="center"> Marks</td>
			<td width="10%"    align="center"> Obtain Of Class</td>
			<td width="10%"    align="center"> Specialization</td>
		  </tr>
		  <% if(arrInsRow != null && arrInsRow.size() > 0){
       for(int i = 0; i < arrInsRow.size(); i++){
			arrInsCol = (ArrayList) arrInsRow.get(i);
			if (arrInsCol != null && arrInsCol.size() > 0) {%>
			<tr height="30px">
				<td align="center"><%=Helper.correctNull((String)arrInsCol.get(3)) %></td>
				<td align="center"><%=Helper.correctNull((String)arrInsCol.get(4)) %></td>
				<td align="center"><%=Helper.correctNull((String)arrInsCol.get(6)) %></td>
				<td align="center"><%=Helper.correctNull((String)arrInsCol.get(5)) %></td>
				<td align="center"><%=Helper.correctNull((String)arrInsCol.get(7)) %></td>
				<td align="center"><%=Helper.correctNull((String)arrInsCol.get(8)) %></td>
			</tr>
			<%}}%>
			<%}else{ %>
			<tr  height="50px">
				<td colspan="8" align="center">-- No Record Found --&nbsp;</td>
			</tr>
			<%} %>
		</table>
		</td></tr>
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td width="20%"> Course Details </td>
			</tr>
		</table>
		</td></tr>
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<col width="6%">
		<col width="10%">
		<col width="6%">
		<col width="10%">
		<col width="6%">
		<col width="10%">
			<tr height="30px">
				<td  > Quota Selection </td>
				<td><%=Helper.correctNull((String) hshValues.get("QUOTA_SELECTION"))%></td>
				<td> Institute Name </td>
				<td><%=Helper.correctNull((String) hshValues.get("INSTITUTE_NAME"))%></td>
				<td> Institute Location </td>
				<td><%=Helper.correctNull((String) hshValues.get("INSTITUTE_LOCATION"))%></td>
			</tr>
			<tr></tr>
			<tr height="30px">
				<td> Type Of Course </td>
				<td><%=Helper.correctNull((String) hshValues.get("TYPE_OF_COURSE"))%></td>
				<td> Course Start Date </td>
				<td><%=Helper.correctNull((String) hshValues.get("COURSE_START_DATE"))%></td>
				<td> Course End Date </td>
				<td><%=Helper.correctNull((String) hshValues.get("COURSE_END_DATE"))%></td>
			</tr>
			<tr height="30px">
				<td> Course Duration </td>
				<td><%=Helper.correctNull((String) hshValues.get("COURSE_DURATION"))%></td>
				<td> Applicants Contribution </td>
				<td><%=Helper.correctNull((String) hshValues.get("APPLICANTS_CONTRIBUTION"))%></td>
				<td> Loan Amount Required </td>
				<td><%=Helper.correctNull((String) hshValues.get("LOAN_AMOUNT_REQUIRED"))%></td>
			</tr>
			<tr height="30px">
				<td> Is Repay Interest </td>
				<td><%=Helper.correctNull((String) hshValues.get("IS_REPAY_INTEREST"))%></td>
				<td> Is Security </td>
				<td><%=Helper.correctNull((String) hshValues.get("IS_SECURITY"))%></td>
				<td> Proposed Repayment By </td>
				<td><%=Helper.correctNull((String) hshValues.get("PROPOSED_REPAYMENT_BY"))%></td>
			</tr>
			<tr height="30px">
				<td> Proposed Repayment Tenure </td>
				<td><%=Helper.correctNull((String) hshValues.get("PROPOSED_REPAYMENT_TENURE"))%></td>
				<td> Proposed Repayment Amount </td>
				<td><%=Helper.correctNull((String) hshValues.get("PROPOSED_REPAYMENT_AMOUNT"))%></td>
				<td> Is Passport Obtained </td>
				<td><%=Helper.correctNull((String) hshValues.get("IS_PASSPORT_OBTAINED"))%></td>
			</tr>
			<tr height="30px">
				<td> Passport No </td>
				<td><%=Helper.correctNull((String) hshValues.get("PASSPORT_NO"))%></td>
				<td> Is Part Time Employment </td>
				<td><%=Helper.correctNull((String) hshValues.get("IS_PART_TIME_EMPLOYMENT"))%></td>
				<td> Employment Description </td>
				<td><%=Helper.correctNull((String) hshValues.get("EMPLOYEMENT_DESCRIPTION"))%></td>
			</tr>
			<tr height="30px">
				<td> Is Scholarship Availed </td>
				<td><%=Helper.correctNull((String) hshValues.get("IS_SCHOLARSHIP_AVAILED"))%></td>
			</tr>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td width="20%"> Security Details </td>
			</tr>
			<tr></tr>
		   </table>
		   </td></tr>
		   <tr><td>
		   <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			 <tr class="dataheader">
	        	<td width="10%"    align="center"> Type Name</td>
				<td width="10%"    align="center"> Amount</td>
			  </tr>
			  <% if(arrSecRow != null && arrSecRow.size() > 0){
	       for(int i = 0; i < arrSecRow.size(); i++){
				arrSecCol = (ArrayList) arrSecRow.get(i);
				if (arrSecCol != null && arrSecCol.size() > 0) {%>
			  <tr height="30px">
				<td align="center"><%=Helper.correctNull((String)arrSecCol.get(2)) %></td>
				<td align="center"><%=Helper.correctNull((String)arrSecCol.get(3)) %></td>
			  </tr>
			 <%}}%>
			<%}else{ %>
			<tr  height="50px">
				<td colspan="8" align="center">-- No Record Found --&nbsp;</td>
			</tr>
			<%} %>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td width="20%"> Scholarship Details List </td>
			</tr>
			<tr></tr>
		   </table>
		   </td></tr>
		   <tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			 <tr class="dataheader">
	        	<td width="10%"    align="center"> Field</td>
				<td width="10%"    align="center"> Name</td>
				<td width="10%"    align="center"> Amount</td>
				<!-- <td width="10%"    align="center"> Is Scholarship Availed</td>-->
			  </tr>
			  <% if(arrSchRow != null && arrSchRow.size() > 0){
	       for(int i = 0; i < arrSchRow.size(); i++){
				arrSchCol = (ArrayList) arrSchRow.get(i);
				if (arrSchCol != null && arrSchCol.size() > 0) {%>
			  <tr height="30px">
				<td align="center"><%=Helper.correctNull((String)arrSchCol.get(2)) %></td>
				<td align="center"><%=Helper.correctNull((String)arrSchCol.get(4)) %></td>
				<td align="center"><%=Helper.correctNull((String)arrSchCol.get(5)) %></td>
			  </tr>
			   <%}}%>
			<%}else{ %>
			<tr  height="50px">
				<td colspan="8" align="center">-- No Record Found --&nbsp;</td>
			</tr>
			<%} %>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td width="20%"> Cost Of Course </td>
			</tr>
			<tr></tr>
		</table>
		</td></tr>
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
        	<td width="10%"    align="center"> Amount</td>
			<td width="10%"    align="center"> Type</td>
			<td width="10%"    align="center"> Year</td>
			<td width="10%"    align="center"> Course Name</td>
			<td width="10%"    align="center"> University Name</td>
	  </tr>
	  <% if(arrRow != null && arrRow.size() > 0){
       for(int i = 0; i < arrRow.size(); i++){
			arrCol = (ArrayList) arrRow.get(i);
			if (arrCol != null && arrCol.size() > 0) {%>
		<tr height="30px">
			<td align="center"><%=Helper.correctNull((String)arrCol.get(1)) %></td>
			<td align="center"><%=Helper.correctNull((String)arrCol.get(2)) %></td>
			<td align="center"><%=Helper.correctNull((String)arrCol.get(3)) %></td>
			<td align="center"><%=Helper.correctNull((String)arrCol.get(4)) %></td>
		</tr>
		<%}}%>
			<%}else{ %>
			<tr  height="50px">
				<td colspan="8" align="center">-- No Record Found --&nbsp;</td>
			</tr>
			<%} %>
	</table>
	</td></tr>
	</table>
</td></tr>
</table>
<input type="hidden" name="hidUserId" value="">
<table border="0" cellspacing="0" cellpadding="0"  align="center">
      <tr valign="middle"> 
       <td> 
		<input type="button" name="cmdclose" value="Close" class="buttonClose" onClick="callclose();">
	
            
        </td></tr></table>
</form>
</body>
</html>