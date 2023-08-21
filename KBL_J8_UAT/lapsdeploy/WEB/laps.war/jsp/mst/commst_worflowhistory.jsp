<%@include file="../share/directives.jsp"%>
<%ArrayList arrFromUsr = (ArrayList) hshValues.get("arrFromUsr");
			ArrayList arrToUsr = (ArrayList) hshValues.get("arrToUsr");
			ArrayList arrFromflow = (ArrayList) hshValues.get("arrFromflow");
			ArrayList arrToflow = (ArrayList) hshValues.get("arrToflow");
			ArrayList arrDate = (ArrayList) hshValues.get("arrDate");
			String Valuesin = Helper.correctNull((String) request
					.getParameter("valuesin"));

			%>
<html>
<head>
<title>MST - Work Flow</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varappstatus="";

function callOnload()
{

}

function callOtherTab(val)
{
	if(val=="action")
	{
		document.forms[0].hidBeanGetMethod.value="getMSTAction";
		document.forms[0].hidBeanId.value="modsancterms";
		document.forms[0].action=appURL+"action/commst_workflowaction.jsp";
		document.forms[0].submit();
	}
}

function doClose()
{
		if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	}
}
  
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onLoad="callOnload()">
<form name="frmworkflow" method="post" class="normal">
<lapstab:applurllinksmst pageid="8"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1"><tr><td class="page_flow">
Corporate &amp; SME -&gt; Modification in sanction terms -&gt; Workflow -&gt; History
</td>
</tr>
</table>
<lapschoice:MSTApplications />
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
	<tr>
		<td width="45%" valign="bottom">
		<table border="0" cellspacing="1" cellpadding="3" align="left" class="outertable">
			<tr align="center">
				<td width="15%" class="sub_tab_active"><b>History</b></td>
				<td width="15%" id="action" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:callOtherTab('action')" class="blackfont">Action</a></b></td>
				<td width="15%" style="visibility:hidden"><b><a
					href="#" onclick="javascript:callOtherTab('remarks')">Remarks</a></b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr>
						<td valign="top">
						<div align="left"><br>
						<b>History</b><br>
						</div>
						<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
							<tr>
								<td width="47%" valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
									<tr>
										<td valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
											<tr class="dataheader">

												<td width="10%" align="center">From Flowpoint</td>

												<td width="23%" align="center">Sent By</td>

												<td width="10%" align="center">Sent On</td>

												<td width="15%" align="center">To Flowpoint</td>

												<td width="21%" align="center">Sent To</td>

											</tr>
											<tr align="center">
												<td colspan="6">
												<DIV CLASS="cellContainer">
												<table width="100%" border="1" cellspacing="0" cellpadding="0" align="center" class="outertable">
													<%for (int i = 0; i < arrFromUsr.size(); i++) {

				%>
													<tr>
														<td width="10%" align="center"><%=Helper.correctNull((String) arrFromflow.get(i))%>
														</td>
														<td width="23%">&nbsp;<%=Helper.correctNull((String) arrFromUsr.get(i))%></td>
														<td width="10%" align="center"><%=Helper.correctNull((String) arrDate.get(i))%>
														</td>
														<td width="15%" align="center"><%=Helper.correctNull((String) arrToflow.get(i))%>
														</td>
														<td width="21%"><%=Helper.correctNull((String) arrToUsr.get(i))%>
														</td>
													</tr>
													<%}%>
												</table>
												</table>
										</td>
									</tr>
								</table>
								</table><br>
						<table width="0%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
							<tr>
								<td>
								<table width="0%" border="0" cellspacing="0" cellpadding="2" class="outertable">
									<tr valign="top">
										<td align="center"><lapschoice:combuttonnew btnnames="" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' /></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
				</table>
		</table>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>  <input type="button" name="cmdapply" disabled
	style="visibility:hidden"></form>
</body>
</html>
