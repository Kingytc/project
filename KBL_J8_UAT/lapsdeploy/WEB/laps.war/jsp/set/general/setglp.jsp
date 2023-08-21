<%@include file="../../share/directives.jsp"%>
<html>
<head>
<title>LAPS(Global Options)</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/set/setglp.js"></script>
<script language="javascript">
var appurl = '<%=ApplicationParams.getAppUrl()%>';
var appURL = '<%=ApplicationParams.getAppUrl()%>';
var choglp_country = "<%=Helper.correctNull((String)hshValues.get("choglp_country"))%>";
var txtglp_currency = "<%=Helper.correctNull((String)hshValues.get("txtglp_currency"))%>";
var choglp_orglevel = "<%=Helper.correctNull((String)hshValues.get("choglp_orglevel"))%>";
var txtglp_orgname1 = "<%=Helper.correctNull((String)hshValues.get("txtglp_orgname1"))%>";
var txtglp_orgname2 = "<%=Helper.correctNull((String)hshValues.get("txtglp_orgname2"))%>";
var txtglp_orgname3 = "<%=Helper.correctNull((String)hshValues.get("txtglp_orgname3"))%>";
var txtglp_orgname4 = "<%=Helper.correctNull((String)hshValues.get("txtglp_orgname4"))%>";
var txtglp_orgname5 = "<%=Helper.correctNull((String)hshValues.get("txtglp_orgname5"))%>";
var choglp_level = "<%=Helper.correctNull((String)hshValues.get("intLevel"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="makedisable();placevalues();">
<form name="glpoption" method="post" class="normal">
<input type="hidden" name="optsave" value="">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Setup&nbsp;-&gt;&nbsp;Global&nbsp;Options</td>
	</tr>
</table>
<table width="95%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="5"
			align="center" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
					<tr>
						<td valign="top">
						<table width="90%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable border1 tableBg">
							<tr>
								<td valign="middle">
								<table width="100%" border="0" cellspacing="0" cellpadding="5"
									align="center" class="outertable">
									<tr>
										<td colspan="4" class="setuphead"><b>&nbsp;Organisation:</b>
										</td>
									</tr>
									<tr>
										<td width="25%">&nbsp;&nbsp;Organisation Level</td>
										<td width="27%"><select name="choglp_orglevel"
											style="width:103;border-style:groove"
											onChange="chgorglevel()" tabindex="1">
											<option value="2">2</option>
											<option value="3">3</option>
											<option value="4">4</option>
											<option value="5">5</option>
										</select></td>
										<td width="18%">Level 1</td>
										<td width="30%"><input type="text" name="txtglp_orgname1"
											maxlength="25" size="18" onKeyPress="notAllowSplChar()"
											style="border-style:groove" tabindex="2"></td>
									</tr>
									<tr>
										<td width="25%">&nbsp;&nbsp;Level 2</td>
										<td width="27%"><input type="text" name="txtglp_orgname2"
											maxlength="25" size="18" onKeyPress="notAllowSplChar()"
											style="border-style:groove" tabindex="3"></td>
										<td width="18%">Level 3</td>
										<td width="30%"><input type="text" name="txtglp_orgname3"
											maxlength="25" size="18" onKeyPress="notAllowSplChar()"
											style="border-style:groove" tabindex="4"></td>
									</tr>
									<tr>
										<td width="25%">&nbsp;&nbsp;Level 4</td>
										<td width="27%"><input type="text" name="txtglp_orgname4"
											maxlength="25" size="18" onKeyPress="notAllowSplChar()"
											style="border-style:groove" tabindex="5"></td>
										<td width="18%">Level 5</td>
										<td width="30%"><input type="text" name="txtglp_orgname5"
											maxlength="25" size="18" onKeyPress="notAllowSplChar()"
											style="border-style:groove" tabindex="6"></td>
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
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidkeyid" value="set">
</form>
</body>
</html>

