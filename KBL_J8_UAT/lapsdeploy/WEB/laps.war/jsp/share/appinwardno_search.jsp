<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%
	ArrayList glp = null;
	glp = (ArrayList) hshValues.get("arr");
	String grpRights = String
			.valueOf(Helper.correctNull(
					(String) session.getAttribute("strGroupRights"))
					.charAt(18));
%>
<html>
<head>
<title>Borrower Application Inward No. Search</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/menudropdown.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/appinwardno_search.js"></script>
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var level = "<%=session.getAttribute("strOrgCode")%>";
var orglevel = "<%=session.getAttribute("strOrgLevel")%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var vargrprights="<%=grpRights%>";
var varRLPFUser="<%=Helper.correctNull((String)session.getAttribute("strRLPFUser"))%>";
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
<body onLoad="onloading();rowCount('0')" style="overflow: hidden;">
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
<form class="normal" name="loanHistory" method="post">
<span class="page_flow">Home -&gt; Application Number Search</span>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					class="outertable border1 tableBg">
					<tr>
						<td valign="top" align="left" class="setuphead"><b>Application
						Number Search</b><br>
						<table width="100%" border="0" cellspacing="1" cellpadding="5">
							<tr>
								<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="1"
											class="outertable">
											<tr>
												<td valign="top">
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
																	double size=glp.size();
																	double width=100/size;
														%>
														<td width="5%" nowrap="nowrap"><%=glp.get(y)%></td>
														<td width="<%=width%>%"><input type="text" name="area<%=y%>"
															size='25'> <input type="hidden"
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
										<td valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="1"
											class="outertable">
											<tr>
												<td valign="top">

												<table width="100%" border="0" cellspacing="1"
													cellpadding="0" class="outertable">
													<tr>
														<td align="right" width="5%"><INPUT TYPE="radio"
															NAME="radiobutton" VALUE="bname"
															STYLE="border-style: none" ONCLICK="onRadioClick()"></td>
														<td width="10%"><b>Applicant Name</b></td>
														<td align="right" width="5%"><INPUT TYPE="radio"
															NAME="radiobutton" VALUE="bid" STYLE="border-style: none"
															ONCLICK="onRadioClick();"></td>
														<td width="10%"><b>Application No.</b></td>
														
														<td align="right" width="5%"><INPUT TYPE="radio"
															NAME="radiobutton" VALUE="CBSID" STYLE="border-style: none"
															ONCLICK="onRadioClick();"></td>
														<td width="10%"><b>CBS Customer ID</b></td>
														
														<td width="20%" align="left"><input type="text"
															name="txt_value" size="25" maxlength="70"
															onKeyPress="checkRadioButton('txt_value')"></td>

														<td width="10%"><input type="button" name="cmdsearch"
															value="Search" class="buttonStyle" onClick="doSearch()"></td>
														<td width="10%" align="left"><input type="reset"
															name="search2" value="Reset" class="buttonStyle"
															onClick="resetme()"></td>

														<td width="10%" align="left"><input type="button"
															name="cmdnew" value="New" class="buttonStyle"
															onClick="callNew()"></td>
													</tr>
													<tr>
													<td colspan="10">&nbsp;</td>
													</tr>
												</table>
												</td>
											</tr>
										</table>
										</td>
									</tr>
									<!-- for no of rows to be displayed -->
									<tr>
										<td colspan="8">
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="outertable">
											<tr>
												<td width="19%" nowrap="nowrap"><b>No. of rows to be
												displayed </b></td>
												<td width="81%"><input type="text" name="txt_noofrows"
													size="4" maxlength="2" value="15"
													onKeyPress="allowInteger()" onBlur="setCount()"> <b>(Value
												should be below 100)</b></td>
											</tr>
										</table>
										</td>
									</tr>
									<tr id="id_app">
										<td colspan="8">
										<table width="98.7%" border="0" cellspacing="1" cellpadding="5" align="" class="outertable">
											<tr class="dataheader">

												<td width="15%" align="center">Application No.</td>

												<td width="31%" align="center">Applicant Name</td>

												<td width="8%" align="center">Sector</td>
												<td width="25%" align="center">Organisation Name</td>

												<td width="21%" align="center">Status</td>
											</tr>
										</table>
										<!-- next and  previous --></td>
									</tr>


									<tr align="center">
										<td colspan="8"><iframe id="result" src="" width="100%"
											height="240"></iframe></td>
									</tr>
									<tr align="center">
										<td colspan="8">&nbsp;</td>
									</tr>
								</table>
								<table width="100%" border="0" cellspacing="0" cellpadding="3"
									class="outertable">
									<tr>
										<td width="9%" nowrap="nowrap"><a
											href="javascript:rowCount('1')" class="blackfont"><b>&lt;&lt;Previous</b></a></td>
										<td width="84%" align="center"><input type="button"
													name="cmdClose" class="buttonClose" value="Close"
													onClick="doClose()"></td>
										<td align="right" width="7%"><a
											href="javascript:rowCount('2')" class="blackfont"><b>Next&gt;&gt;</b></a></td>
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
<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>">
<input type="hidden" name="hid_rowcount" value="" /> 
<input type="hidden" name="hidBeanGetMethod" value=""> 
<input type="hidden" name="hidBeanId" value=""> 
<input type="hidden" name="hidvalue" value="">
</form>
</body>
</html>