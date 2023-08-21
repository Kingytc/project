<%@include file="../share/directives.jsp"%>
<%ArrayList arrFromUsr = (ArrayList) hshValues.get("arrFromUsr");
			ArrayList arrToUsr = (ArrayList) hshValues.get("arrToUsr");
			ArrayList arrFromflow = (ArrayList) hshValues.get("arrFromflow");
			ArrayList arrToflow = (ArrayList) hshValues.get("arrToflow");
			ArrayList arrDate = (ArrayList) hshValues.get("arrDate");
			String Valuesin = Helper.correctNull((String) request.getParameter("valuesin"));%>

<html>
<head>
<title>BST - Work Flow</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var varappstatus="";
function callOtherTab(val)
{
	if(val=="action")
	{
		document.forms[0].hidBeanGetMethod.value="getBSTAction";
		document.forms[0].hidBeanId.value="broadsancterms";
		document.forms[0].action=appUrl+"action/combst_workflowaction.jsp";
		document.forms[0].submit();
	}
}
function doClose()
{
		if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appUrl+"action/combstpge.jsp";
		document.forms[0].submit();
	}
}  
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form name="frmworkflow" method="post" class="normal">
<lapstab:applurllinkbst
	pageid='9' category='bst' valuesin='<%=Valuesin%>' />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable"><tr><td class="page_flow">
Corporate &amp; SME -&gt; Broad Terms of Proposal -&gt; Workflow -&gt; History
</td>
</tr>
</table>
<lapschoice:BST />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td height="20" width="45%" valign="bottom">
		<table width="30%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr align="center">
				<td width="15%" class="sub_tab_active"><b>History</b></td>
				<td width="15%" id="action" class="sub_tab_inactive"><b><a href="javascript:callOtherTab('action')">Action</a></b></td>
				<td width="15%" style="visibility:hidden" class="sub_tab_inactive"><b><a
					href="javascript:callOtherTab('remarks')">Remarks</a></b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td >
				<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
					<tr>
						<td  valign="top">
						
						<b>History</b><br>
						<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
							<tr>
								<td width="47%" valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable">
									<tr>
										<td valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable linebor">
											<tr class="dataheader">
												<td width="10%" align="center">From Flowpoint</td>
												<td width="23%" align="center">Sent By</td>
												<td width="10%" align="center">Sent On</td>
												<td width="15%" align="center">To Flowpoint</td>
												<td width="21%" align="center">Sent To</td>
											</tr>										
													<%for (int i = 0; i < arrFromUsr.size(); i++) {%>
													<tr class="datagrid">
														<td width="10%" align="center"><%=Helper.correctNull((String) arrFromflow.get(i))%>
														</td>
														<td width="23%"> &nbsp;<%=Helper.correctNull((String) arrFromUsr.get(i))%></td>
														<td width="10%" align="center"><%=Helper.correctNull((String) arrDate.get(i))%>
														</td>
														<td width="15%" align="center"><%=Helper.correctNull((String) arrToflow.get(i))%>
														</td>
														<td width="21%"><%=Helper.correctNull((String) arrToUsr.get(i))%>
														</td>
													</tr>
													<%}%>
												</table>
												</td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table><br>
						</td>
						</tr>
						</table>
						</td>
						</tr>
						</table>
						<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
						<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="button" name="cmdsave" disabled="disabled" style="visibility:hidden">
	</form>
</body>
</html>
