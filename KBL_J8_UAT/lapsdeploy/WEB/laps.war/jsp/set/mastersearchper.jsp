<%@include file="../share/directives.jsp"%>
<%String strSessionModuleType="";
strSessionModuleType=Helper.correctNull((String)request.getParameter("hidCategoryType"));
String strsrcPage = Helper.correctNull((String)request.getParameter("srcPage")); %>
<html>
<head>
<title>Master Search Personal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/set/mastersearchper.js"> </script>
	<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
	<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varCategoryType="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>";
var varsrcPage ="<%=Helper.correctNull((String)request.getParameter("srcPage"))%>";
</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>

<body onLoad="rowCount('0');hideProgress('imgloading');">
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
<div id='imgloading' style="display:none;">
<img src="<%=ApplicationParams.getAppUrl()%>img/processing2.gif"></div>
<form name="persearchMast" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
			<td valign="top" class="page_flow">
			<%if(strSessionModuleType.equalsIgnoreCase("COF")){ %>
			Home -&gt; Closure Of Facility -&gt; Customer Search
			<%}else{%>
			Home -&gt; Customer Profile -&gt; Customer Profile Search
			<%} %>
			</td>
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
												
												<td width="3%" style="visibility: hidden;"><input type="radio" name="radiobutton"
													value="SECID" style="border-style:none"
													onClick="onRadioClick()"></td>
													
												<%if(strsrcPage.equalsIgnoreCase("FC")){ %>
												<td width="3%"><input type="radio" name="radiobutton"
													value="APPNO" style="border-style:none"
													onClick="onRadioClick()"></td>
												<td width="13%">Proposal No.</td>
												<%} %>
												
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
											<tr>
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
											<tr>
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
<input type="hidden" name="hidPageType" value="<%=strSessionModuleType %>">
<input type="hidden" name="hidDemoId"> 
<input type="hidden" name="hid_rowcount" value=""> 
<input type="hidden" name="readFlag" value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>">
<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>"> 
</form>
</body>
</html>
