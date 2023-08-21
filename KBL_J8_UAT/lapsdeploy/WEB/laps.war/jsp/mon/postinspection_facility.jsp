<%@include file="../share/directives.jsp"%>
<%String strReviewtype = Helper.correctNull((String) request.getParameter("hidreviewtype"));
%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}
function callLink1(page,bean,method)
{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();	
}
</script>
</head>
<body>
<form name="safaeri3" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="45%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr align="center">
				<td class="sub_tab_inactive"><b><%if (strReviewtype.equalsIgnoreCase("R")) { %>
				<a href="JavaScript:callLink1('postinspection_retail_report.jsp','postinspection','getPostInspectionReport')">Inspection Report</a> 
				<%} else if (strReviewtype.equalsIgnoreCase("A")) {%>
				<a href="JavaScript:callLink1('followupInspectionReport.jsp','postinspection','getPostInspectionReport')">Inspection Report</a> 
				<%} else if (strReviewtype.equalsIgnoreCase("C")) {%>
				<a href="JavaScript:callLink1('mon_inspectionreport.jsp','postinspection','getPostInspectionReport')">Inspection Report</a> 
				<%}%></b></td>
				<td class="sub_tab_active">Facility Enjoyed</td>
				<%if (strReviewtype.equalsIgnoreCase("C")) { %>
				<td class="sub_tab_inactive"><a href="JavaScript:callLink1('postinspection_annexure.jsp','postinspection','getPostInspectionAnnexure')"><b>Facility Annexure</b></a></td>
						<%}%>
				<td class="sub_tab_inactive"><a href="JavaScript:callLink1('postinspection_history.jsp','postinspection','getPostInspectionHistory')"><b>Workflow</b></a></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="page_flow">Home -&gt; Post/ Followup Inspection -&gt; Facility Enjoyed</td>
	</tr>
</table>
<lapschoice:PostInspection/>    
<br>    
 <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
    <tr align="center" class="dataheader"> 
      <td><b>S.No</b></td>
      <td><b>Nature of facilities</b></td>
      <td><b>Purpose of Loan</b></td>
      <td><b>Sanctioned limit (Rs)</b></td>
      <td><b>O/s as on (Rs)</b></td>
      <td><b>Overdue, if any (Rs.)</b></td>
    </tr>
    <%ArrayList arrRow = (ArrayList) hshValues.get("arrRow");
			if (arrRow != null && arrRow.size() > 0) {

				for (int i = 0; i < arrRow.size(); i++) {
					ArrayList arrCol = (ArrayList) arrRow.get(i);
					if (arrCol != null) {

						%>
    <tr class="datagrid"> 
      <td><%=i + 1%></td>
      <td><%=Helper.correctNull((String) arrCol.get(1))%> </td>
      <td><%=Helper.correctNull((String) arrCol.get(2))%></td>
      <td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(3))))%></td>
      <td align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(4))))%></td>
      <td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(5))))%></td>
    </tr>
   <%}}} else {%>
   <tr>
   <td colspan="6" align="center">No Data</td>
   </tr>
   <%}%>
  </table>    
<br/>
<lapschoice:combuttonnew btnenable=''/> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="HIDDEN" name="hidreviewtype" value="<%=strReviewtype%>"/>
</form>
</body>
</html>

