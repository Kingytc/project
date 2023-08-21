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
	String strprdtype = Helper.correctNull((String) hshValues.get("prd_staffprd"));
	String strSessionModuleType = Helper.correctNull((String) session.getAttribute("sessionModuleType")).trim();
	String SOL_APPL_NO = Helper.correctNull((String) hshValues.get("SOL_APPL_NO"));
	if (SOL_APPL_NO.equalsIgnoreCase("")) {
		SOL_APPL_NO = Helper.correctNull((String) request.getParameter("hidapplno"));
	}
	String Appstatus = Helper.correctNull((String) session.getAttribute("strappstatus"));
%>
<html>
<head>
<title>Personal - Work Flow</title>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var solid="<%=Helper.correctNull((String) hshValues.get("SOL_APPID"))%>";
var varsolid="<%=Helper.correctNull((String) request.getParameter("hidDemoId"))%>";


function callOtherTab(val)
{
	if(val=="action")
	{
		document.forms[0].action = appURL + "action/ControllerServlet";
		document.forms[0].hidBeanId.value="comsolvency";
		document.forms[0].hidBeanGetMethod.value="getsolworkflow";  //changed as getAction
		document.forms[0].action=appURL+"action/solvencyworkflowaction.jsp";
		document.forms[0].submit();
	}
}

function doClose()
{
	if (ConfirmMsg(100)) {
		document.forms[0].action = appURL + "action/mainnav.jsp";
		document.forms[0].submit();
	}
}

function callSolvency()
{
		//document.forms[0].action = appURL + "action/ControllerServlet";
		document.forms[0].hidBeanId.value = "comsolvency";
		document.forms[0].hidBeanGetMethod.value = "getSolvencyData";
		document.forms[0].action = appURL+"action/com_solvency.jsp?hidid="+varsolid;
		document.forms[0].submit();
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

<table>
	<tr>
		<td width="50%" align="center" class="sub_tab_inactive"><a
			href="javascript:callSolvency();"
			onMouseOut="window.status='';return true;"
			onMouseOver="window.status='Applicant';return true;"> <b>
		Solvency </b></a></td>

		<td width="50%" align="center" class="sub_tab_active">Solvency
		WorkFlow</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -> Solvency Workflow -> History</td>
	</tr>
</table>

<lapschoice:ApplSolHeaderTag/>

<table width="100%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable">
	<tr>
		<td valign="bottom">
		<table border="0" cellspacing="1" cellpadding="3" class="outertable"
			width="70%">
			<tr align="center">
				<td width="10%" class="sub_tab_active">History</td>
				<td width="10%" class="sub_tab_inactive"><a
					href="javascript:callOtherTab('action')">Action</a></td>
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
						<td valign="top">History
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

				<!--
						<table width="0%" border="0" cellspacing="0" cellpadding="3"
							align="center" class="outertable">
							
							<tr>
								<td><input type="button" name="cmdprocessprint"
									value="Letter of Sanction to Borrower"
									onClick="ShowReport4('sanctionletter_GL.jsp')" class="buttonOthers">
								</td>
							</tr>
								
							<tr>
								<td><input type="hidden" name="cmdprocessprint"
									value="Letter of Sanction to Borrower">
								</td>
							</tr>
								
							<tr>
								<td><input type="button" name="cmdprocessprint"
									value="Letter of Sanction to Borrower"
									onClick="ShowReport4('sanctionletter.jsp')" class="buttonOthers">
								</td>
							</tr>
									
						</table>
					
							<table width="0%" border="0" cellspacing="0" cellpadding="2" align="center" class="outertable">
							<tr>
								<td><input type="button" name=""
									value="Sanction Letter to Branch" class="buttonOthers" 
									onClick="doCorpSancletter('br');"></td>
								<td><input type="button" name=""
									value="Sanction Letter to Borrower" class="buttonOthers"
									onClick="doCorpSancletter('bo');"></td>
							</tr>
						</table>
						
						-->
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
<INPUT TYPE="hidden" name="hidAppNo" VALUE=<%=Helper.correctNull((String) request.getParameter("appno"))%>>
<INPUT TYPE="hidden" name="radLoan" value="Y"> 
<input type="hidden" name="cattype" value="<%=strCategoryType%>">
<input type="hidden" name="hidapplno" value="<%=SOL_APPL_NO%>">
<input type="hidden" name="hidapplname" value="<%=Helper.correctNull((String) request.getParameter("hidapplname"))%>">
<input type="hidden" name="hidapplholder" value="<%=Helper.correctNull((String) request.getParameter("hidapplholder"))%>">
<input type="hidden" name="hidOrgname" value="<%=Helper.correctNull((String) request.getParameter("hidOrgname"))%>">
<!--<input type="hidden" name="hidappstatus" value="<%=(String) request.getParameter("hidappstatus") %>">

-->
</form>
</body>

</html>
