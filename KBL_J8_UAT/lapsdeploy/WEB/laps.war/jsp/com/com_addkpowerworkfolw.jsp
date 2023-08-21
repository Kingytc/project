<%@include file="../share/directives.jsp"%>
<%
    ArrayList arrFromUsr = (ArrayList) hshValues.get("arrFromUsr");
	ArrayList arrToUsr = (ArrayList) hshValues.get("arrToUsr");
	ArrayList arrFromflow = (ArrayList) hshValues.get("arrFromflow");
	ArrayList arrToflow = (ArrayList) hshValues.get("arrToflow");
	ArrayList arrDate = (ArrayList) hshValues.get("arrDate");
	ArrayList arrMailtype = (ArrayList) hshValues.get("arrMailType");
	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = (ArrayList) hshValues.get("arrRow");
	%>
<html>
<head>
<title>Kpower - Work Flow</title>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varAppid="<%=Helper.correctNull((String) request.getParameter("hidDemoId"))%>";

function callKpower()
{
	document.forms[0].hidBeanId.value="comsolvency";
	document.forms[0].hidBeanGetMethod.value="getKpowerdetailsData";
	document.forms[0].action=appURL+"action/com_addkpowerdetails.jsp";
	document.forms[0].submit();
}

function callActionTab()
{
	 document.forms[0].hidBeanId.value="comsolvency";
	 document.forms[0].hidBeanGetMethod.value="getKpowAction";
	 document.forms[0].action=appURL+"action/com_addkpoweraction.jsp";
	 document.forms[0].submit(); 
}

function doClose()
{
	if (ConfirmMsg(100)) {
		document.forms[0].action = appURL + "action/mainnav.jsp";
		document.forms[0].submit();
	}
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../htm/link.css" type="text/css">
<STYLE>
DIV.cellContainer {
	width: 100%;
	height: 250;
	overflow: auto;
}
</STYLE>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="frmworkflow" method="post" class="normal">

<table style="border-collapse: collapse;">
	<tr>
		<td width="50%" align="center" class="sub_tab_inactive"><a
			href="javascript:callKpower();"
			onMouseOut="window.status='';return true;"
			onMouseOver="window.status='Applicant';return true;"> <b>
		K-Power Details </b></a></td>

		<td width="50%" align="center" class="sub_tab_active">
		K-Power WorkFlow</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -> K-Power Workflow -> History</td>
	</tr>
</table>
<lapschoice:ApplKpowHeaderTag/>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable">
	<tr>
		<td valign="bottom">
		<table border="0" cellspacing="0" cellpadding="0" class="outertable"
			width="70%">
			<tr align="center">
				<td width="10%" class="sub_tab_active">History</td>
				<td width="10%" class="sub_tab_inactive"><a
					href="javascript:callActionTab()">Action</a></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5"
	class="outertable" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="5"
					class="outertable border1">
					<tr>
						<td valign="top" class="setuphead">History
						<table width="100%" border="0" cellspacing="0" cellpadding="2"
							class="outertable">
							<tr>
								<td width="47%" valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="3"
									class="outertable">
									<tr>
										<td valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="outertable">
											<tr class="dataheader">
												<td width="15%" align="center">From Flowpoint</td>
												<td width="19%" align="center">Sent By</td>
												<td width="16%" align="center">Sent On</td>
												<td width="15%" align="center">To Flowpoint</td>
												<td width="20%" align="center">Sent To</td>
												<td width="15%" align="center">Mail Type</td>
											</tr>
											<%
												if (arrRow != null && arrRow.size() > 0) {
													for (int i = 0; i < arrRow.size(); i++) {
														arrCol = (ArrayList) arrRow.get(i);
											%>
											<tr class="datagrid">
												<td width="15%" align="center"><%=arrCol.get(4)%></td>
												<td width="19%" align="center"><%=arrCol.get(0)%></td>
												<td width="16%" align="center"><%=arrCol.get(1)%></td>
												<td width="15%" align="center"><%=arrCol.get(5)%></td>
												<td width="20%" align="center"><%=arrCol.get(2)%></td>
												<td width="15%" align="center"><%=arrCol.get(3)%>
												&nbsp;</td>
											</tr>
											<%
												}
												}
											%>
											
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
				<table width="0%" border="0" cellspacing="0" cellpadding="0"
					class="outertable" align="center">
					<tr>
						<td>
						<table width="0%" border="0" cellspacing="0" cellpadding="2"
							class="outertable">
							<tr valign="top">
								<td height="2" align="center"><lapschoice:combuttonnew
									btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
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
<lapschoice:hiddentag pageid='<%=PageId%>'/>
 <input	type="button" name="cmdsave" disabled="disabled" style="visibility: hidden"> 
 <input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String) request.getParameter("hidDemoId"))%>">
<input type="hidden" name="hidAppNo" value="<%=Helper.correctNull((String) request.getParameter("appno"))%>">
<input type="hidden" name="hidAppno" value="<%=Helper.correctNull((String) request.getParameter("hidAppno"))%>">
<input type="hidden" name="hidAppnmae" value="<%=Helper.correctNull((String) request.getParameter("hidAppnmae"))%>">
<input type="hidden" name="hidStatus" value="<%=Helper.correctNull((String) request.getParameter("hidStatus"))%>">
<input type="hidden" name="hidAppholder" value="<%=Helper.correctNull((String) request.getParameter("hidAppholder"))%>">
<input type="hidden" name="hidRecdfrom" value="<%=Helper.correctNull((String) request.getParameter("hidRecdfrom"))%>">



</body>
</form>
</html>
