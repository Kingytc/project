<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Master Search Personal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/com/financialsrch.js"> </script>
	<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
	<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varCategoryType="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>";
</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>

<body onLoad="rowCount('0');disablefinheader()">
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
<form name="persearchMast" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
			<td valign="top" class="page_flow">Home -&gt; Financial / Rating -&gt; Customer
				 Search</td>
				</tr>
		</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable border1 tableBg">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					class="outertable">
					<tr>
						<td valign="top" align="left">
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable">
							<tr>
								<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="3"
									class="outertable">
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
											<tr>
												<td colspan="13" class="setuphead"><b>Search By</b></td>
											</tr>
											<tr>
												<td width="3%"><input type="radio" name="radiobutton"
													value="first" style="border-style:none"
													tabindex="1" onClick="onRadioClick()"></td>
												<td width="9%" nowrap="nowrap">Customer Name</td>

												
												<td width="3%"><input type="radio" name="radiobutton"
													value="CBSID" style="border-style:none"
													onClick="onRadioClick()" checked="checked"></td>
												<td width="13%">CBS Customer ID</td>
												<td width="3%"><input type="radio" name="radiobutton"
													value="LAPSID" style="border-style:none"
													onClick="onRadioClick()"></td>
												<td width="13%">LAPS ID</td>
												
												<td width="3%"><input type="radio" name="radiobutton"
													value="PANNO" style="border-style:none"
													onClick="onRadioClick()"></td>
												<td width="13%">PAN NO.</td>
												
												<td width="3%"><input type="radio" name="radiobutton"
													value="PROPOSALNO" style="border-style:none"
													onClick="onRadioClick()"></td>
												<td width="13%">CBS ID(Old Only For Rating)</td>
												
												
												<td width="13%"><input type="text" name="txtsearch"
													size="20" maxlength="20"
													onKeyPress="notAllowSplChar();" tabindex="2"></td>
												
												<td width="10%"><input type="button" name="cmdOK2"
													value="Search" class="buttonStyle" style="width:75"
													onClick="callExisting()" tabindex="3"></td>
													<td width="18%">&nbsp;</td>
											</tr>
											
											<tr>
												<td colspan="8">
												<table width="100%" border="0" cellspacing="0"
													cellpadding="3" class="outertable">
													<tr>
														<td width="35%"><b>No. of rows to be displayed </b></td>
														<td width="65%"><input type="text" name="txt_noofrows"
															size="4" maxlength="2" value="15" onBlur="setCount()"> <b>(Value
														should be below 100)</b></td>
													</tr>
												</table>
												</td>
											</tr>
											<tr  id="non_finacial">
												<td colspan="13">
												<table width="100%" border="0" cellspacing="1"
													cellpadding="3" class="outertable">
													<tr class="dataheader">
														<td width="35%"  align="center">Applicant Name
														</td>
														<td width="10%"  align="center">CBS Customer ID
														</td>
														<td width="10%"  align="center">Applicant ID
														</td>
														<td width="10%"  align="center">PAN No.
														</td>
														<td width="35%"  align="center">Branch Name
														</td>
													</tr>
															
												</table>
												</td>
											</tr>
											<tr  id="finacial">
												<td colspan="13">
												<table width="100%" border="0" cellspacing="1"
													cellpadding="3" class="outertable">
													<tr class="dataheader" >
														<td width="45%"  align="center">Financial Format
														</td>
														<td width="20%"  align="center">Freezed Date
														</td>
														
													
														
													</tr>
												</table>
												</td>
											</tr>
											<tr class="datagrid">
												<td colspan="13">
												<div align="left"><iframe id="isearch" width="100%"
													height="200"
													src="<%=ApplicationParams.getAppUrl()%>action/blank.jsp"></iframe>
												</div>
												</td>
											</tr>
											
										</table>
										</td>
									</tr>
								</table>

								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
									<tr>
										<td width="9%" nowrap="nowrap"><a href="javascript:rowCount('1')"
											><b>&lt;&lt;Previous</b></a></td>
										<td width="84%">&nbsp;</td>
										<td align="right" width="7%"><a
											href="javascript:rowCount('2')"><b>Next&gt;&gt;</b></a></td>
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
<lapschoice:combuttonnew btnnames='Reset' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<INPUT TYPE="hidden" name="hidAppType" value="P"> 
<input type="hidden" name="hidPageType" value="Fin">
<input type="hidden" name="hidDemoId"> 
<input type="hidden" name="hid_rowcount" value=""> 
<input type="hidden" name="readFlag" value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>">
<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>"> 
</form>
</body>
</html>
