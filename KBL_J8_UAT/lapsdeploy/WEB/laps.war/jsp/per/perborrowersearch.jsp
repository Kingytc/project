<%@include file="../share/directives.jsp"%>
<%
	ArrayList glp = null;

	glp = (ArrayList) hshValues.get("arr");

	//FOR CLEARING SESSION 23-AUG-07
	session.setAttribute("TotalLandHolding", "");
	session.setAttribute("strappno", "");
	session.setAttribute("perapp_employment", "");
	session.setAttribute("perapp_dob", "");
	session.setAttribute("perapp_status", "");
	session.setAttribute("perapp_eduothers", "");
	session.setAttribute("Salaryrouted", "");
	session.setAttribute("bowname", "");
	session.setAttribute("MarginPercent", "");
	session.setAttribute("strProductType", "");
	session.setAttribute("prdcode", "");
	session.setAttribute("InterestCharged", "");
	//-END CLEARING OF SESSION
	String strCategorytype = Helper.correctNull((String) request
			.getParameter("hidCategoryType"));
%>
<html>
<head>
<title>Borrower Master Search</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/per/perborrowersearch.js"> </script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var level = "<%=session.getAttribute("strOrgCode")%>";
var orglevel = "<%=session.getAttribute("strOrgLevel")%>";
var currentDate="<%=Helper.getCurrentDateTime()%>";
</script>

<STYLE>
DIV.cellContainer {
	width: 100%;
	height: 100%;
	overflow: auto;
}
</STYLE>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="rowCount('0')">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form name="loanHistory" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td valign="top" class="page_flow">Home -&gt; <%
 	if (Helper.correctNull(
 			(String) session.getAttribute("hidCategoryType"))
 			.equalsIgnoreCase("RET")) {
 %> Retail <%
 	} else if (Helper.correctNull(
 			(String) session.getAttribute("hidCategoryType"))
 			.equalsIgnoreCase("AGR")) {
 %> Agriculture <%
 	} else if (Helper.correctNull(
 			(String) session.getAttribute("hidCategoryType"))
 			.equalsIgnoreCase("LAD")) {
 %> Loan Against Gold Ornaments &amp; Deposits <%
 	}
 %> (Borrower Search)</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	height="400" align="center" class="outertable">
	<tr>
		<td valign="top" height="397">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			height="100%" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="1" cellspacing="0" cellpadding="5"
					height="100%" class="outertable">
					<tr>
						<td valign="top" align="left" class="setuphead"><b>Borrower Search</b><br>
						<table width="100%" border="0" cellspacing="2" cellpadding="5"
							height="100%" class="outertable">
							<tr>
								<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									class="outertable">
									<tr>
										<td valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="1"
											class="outertable">
											<tr>
												<td width="76%" valign="top">
												<table width="100%" border="0" cellspacing="1"
													cellpadding="0" class="outertable">
													<tr>
														<%
															int initial = 0;
															String level = (String) session.getAttribute("strOrgLevel");
															if (level.equalsIgnoreCase("C")) {
																initial = 2;
															} else if (level.equalsIgnoreCase("R")) {
																initial = 3;
															} else if (level.equalsIgnoreCase("D")) {
																initial = 4;
															} else if (level.equalsIgnoreCase("A")) {
																initial = 5;
															} else if (level.equalsIgnoreCase("B")) {
																initial = 6;
															}
															for (int y = initial; y <= glp.size() - 1; y++) {
																if (!glp.get(y).equals("")) {
														%>
														<td width="8%" nowrap="nowrap"><%=glp.get(y)%></td>
														<td width="25%"><input type="text" name="area<%=y%>"
															size='30'> <input type="hidden"
															name="hidarea<%=y%>"> <b><span
															onClick="showSystem('<%=y%>','<%=glp.size() - initial%>')"
															style="cursor: hand"><img
															src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
															border="0"></span></b> &nbsp;&nbsp;&nbsp;&nbsp;</td>
														<%
															}
															}
														%>

													</tr>
												</table>
												</td>

											</tr>
										</table>
										</td>
									</tr>
									<tr><td>&nbsp;</td></tr>
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="1"
											class="outertable">
										<tr>
												<td ><input type="radio" name="radiobutton"
													value="NAME" style="border-style:none"
													tabindex="1" onClick="onRadioClick()"></td>
												<td td width="13%">Borrower Name</td>

												
												<td ><input type="radio" name="radiobutton"
													value="CBSID" style="border-style:none"
													onClick="onRadioClick()" checked="checked"></td>
												<td td width="13%">CBS Customer ID</td>
												<td ><input type="radio" name="radiobutton"
													value="INWARDNO" style="border-style:none"
													onClick="onRadioClick()"></td>
												<td width="13%">Application No.</td>
												
												<td width="3%"><input type="radio" name="radiobutton"
													value="APPLICATIONNO" style="border-style:none"
													onClick="onRadioClick()"></td>
												<td width="13%">Proposal No.</td>
												
												<td width="3%"><input type="radio" name="radiobutton"
													value="DIGIAPPNO" style="border-style:none"
													onClick="onRadioClick()"></td>
												<td width="13%">Digi ApppNo.</td>
																							
												<td width="13%"><input type="text" name="txtsearch"
													size="20" maxlength="20"
													onKeyPress="notAllowSplChar();" tabindex="2"></td>
												
												<td width="10%"><input type="button" name="cmdOK2"
													value="Search" class="buttonStyle" style="width:75"
													onClick="callExisting()" tabindex="3"></td>
												<!--  <td width="18%"><input type="button" name="cmdOK22"
													value="New Applicant" class="buttonStyle" style="width:100"
													onClick="callNew()"></td>-->
													<td width="18%">&nbsp;</td>
											</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td colspan="8">
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="outertable">
											<tr>
												<td width="19%" nowrap="nowrap"><b>No. of rows to
												be displayed </b></td>
												<td width="81%"><input type="text" name="txt_noofrows"
													size="4" maxlength="2" value="15"
													onKeyPress="allowInteger()" onBlur="setCount()"> <b>(Value
												should be below 100)</b></td>
											</tr>
										</table>
										</td>
									</tr>
									<tr>
										<td colspan="8">
										<table width="100%" border="0" cellspacing="1" cellpadding="5"
											align="center" class="outertable">
											<tr class="dataheader">

												<td width="35%" align="center">Borrower Name</td>
												<td width="12%" align="center">CBS Customer ID</td>
												<td width="10%" align="center">Applicant ID</td>
												<td width="10%" align="center">PAN No.</td>
												<td width="33%" align="center">Organisation</td>
											</tr>
										</table>
										<!-- next and  previous --></td>
									</tr>


									<tr align="center">
										<td colspan="8"><iframe id="result" src="" width="100%"
											height="240" border="no"></iframe></td>
									</tr>
									<tr align="center">
										<td colspan="8">&nbsp;</td>
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
<table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable">
			<tr>
				<td width="10%" nowrap="nowrap"><a
					href="javascript:rowCount('1')"><b>&lt;&lt;Previous</b></a></td>
				<td width="80%" align="center"><lapschoice:combuttonnew btnnames='Reset' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' /></td>
				<td align="right" width="10%"><a href="javascript:rowCount('2')"><b>Next&gt;&gt;</b></a></td>
			</tr>
		</table>
	

<lapschoice:hiddentag pageid='<%=PageId%>' /> 
<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String) request.getParameter("hidCategoryType"))%>">
<input type="hidden" name="hidBeanMethod" value="getBorrowerDetails" />
<input type="hidden" name="hid_rowcount" value="" />
</form>
</body>
</html>
