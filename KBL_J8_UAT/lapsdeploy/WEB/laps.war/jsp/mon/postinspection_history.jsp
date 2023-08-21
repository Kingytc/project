<%@include file="../share/directives.jsp"%>
<%ArrayList arrFromUsr = (ArrayList) hshValues.get("arrFromUsr");
			ArrayList arrToUsr = (ArrayList) hshValues.get("arrToUsr");
			ArrayList arrDate = (ArrayList) hshValues.get("arrDate");
			String strReviewtype = Helper.correctNull((String) request
					.getParameter("hidreviewtype"));%>
<html>
<head>
<title>Postinspection - Work Flow</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varstatus="<%=Helper.correctNull((String)hshValues.get("status"))%>";
function callOnload()
{
	if(varstatus=="send")
	{
		alert('Inspection Report has been sent sucessfully');
		document.forms[0].action=appURL+"action/mon_borrowersearch.jsp?hidmontype=POSTINSPEC";
		document.forms[0].submit();
	}
	if(varstatus=="closed")
	{
		alert('Inspection Report has been closed');
		document.forms[0].action=appURL+"action/mon_borrowersearch.jsp?hidmontype=POSTINSPEC";
		document.forms[0].submit();
	}
}

function callOtherTab(val)
{
	if(val=="action")
	{
		document.forms[0].hidBeanGetMethod.value="getMONAction";
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].action=appURL+"action/mon_appworkflowaction.jsp";
		document.forms[0].submit();
	}
}

function callLink(page,bean,method)
{
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action=appURL+"action/"+page;
	document.forms[0].submit();
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/mon_borrowersearch.jsp?hidmontype=POSTINSPEC";
		document.forms[0].submit();
	}
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="callOnload()">
<form name="frmworkflow" method="post" class="normal">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="45%" border="0" cellspacing="1" cellpadding="3" class="outertable">
					<tr align="center">
						<td class="sub_tab_inactive"><b><%if (strReviewtype.equalsIgnoreCase("R")) {%>
				<a href="JavaScript:callLink('postinspection_retail_report.jsp','postinspection','getPostInspectionReport')">Inspection Report</a> 
					<%} else if (strReviewtype.equalsIgnoreCase("A")) {%>
				<a href="JavaScript:callLink('followupInspectionReport.jsp','postinspection','getPostInspectionReport')">Inspection Report</a> 
				<%} else if (strReviewtype.equalsIgnoreCase("C")) {%>
				<a href="JavaScript:callLink('mon_inspectionreport.jsp','postinspection','getPostInspectionReport')">Inspection Report</a> 
				<%}%></b></td>
				<td class="sub_tab_inactive">
				<a href="JavaScript:callLink('postinspection_facility.jsp','postinspection','getPostInspectionFaclity')"><b>Facility Enjoyed</b></a></td>
						<%if (strReviewtype.equalsIgnoreCase("C")) {%>
				<td class="sub_tab_inactive">
				<a href="JavaScript:callLink('postinspection_annexure.jsp','postinspection','getPostInspectionAnnexure')"><b>Facility Annexure</b></a></td>
						<%}%>
						<td class="sub_tab_active"><b>Workflow</b></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
			<td class="page_flow">Home -&gt; Post/ Followup Inspection -&gt; Workflow -&gt; History</td>
		 </tr>
		</table>
		
<lapschoice:PostInspection />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
			<tr>
				<td width="50%" valign="bottom">
				<table width="20%" border="0" cellspacing="1" cellpadding="3" class="outertable">
					<tr align="center">
						<td class="sub_tab_active"><b>History</b></td>
						<td class="sub_tab_inactive"><b><a href="JavaScript:callLink('postinspection_action.jsp','postinspection','getPostInspectionAction')">Action</a></b></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		<br>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td>
								<b>History</b> <br>
								<table width="98%" border="0" cellspacing="0" cellpadding="2" align="center" class="outertable">
									<tr>
										<td width="100%" valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
											<tr>
												<td valign="top">
												<table width="100%" border="0" cellspacing="0" class="outertable linebor" cellpadding="0" align="center">
													<tr class="dataheader">
														<td width="33%" align="center">Sent By</td>
														<td width="33%" align="center">Sent On</td>
														<td width="33%" align="center">Sent To</td>
													</tr>													
															<%if (arrFromUsr != null && arrFromUsr.size() > 0) {
																for (int i = 0; i < arrFromUsr.size(); i++) {%>
															<tr class="datagrid">
																<td width="33%">&nbsp;<%=Helper.correctNull((String) arrFromUsr.get(i))%></td>
																<td width="33%" align="center"><%=Helper.correctNull((String) arrDate.get(i))%></td>
																<td width="33%"><%=Helper.correctNull((String) arrToUsr.get(i))%></td>
															</tr>
															<%}}%>
														</table>
														</td>
													</tr>
												</table>
												</td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
		<br>
		<lapschoice:combuttonnew btnenable=''/> 
		<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="HIDDEN" name="hidreviewtype" value="<%=strReviewtype%>" />
</form>
</body>
</html>
