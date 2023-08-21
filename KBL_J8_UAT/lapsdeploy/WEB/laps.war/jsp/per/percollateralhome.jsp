<%@include file="../share/directives.jsp" %>
<%
	ArrayList g1 = new ArrayList();
	String strAppValue = Helper.correctNull((String) hshValues.get("strAppValue"));
	ArrayList v = new ArrayList();
%>
<html>
<head>
<title>Personal - Collateral - Home</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT
	src="<%=ApplicationParams.getAppUrl()%>js/per/percollateralhome.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>		
<script>
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var strvalue="loan_appretail_colsec_imoprop.htm";
var selappvalue="<%=strAppValue%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";

function showCitySearch(varTextControl,varTextControl1,varHidControl,varHidControl1,varTextControl2,varHidControl2)
{
	if(document.forms[0].cmdsave.disabled==false)
		{
		var varQryString = "<%=ApplicationParams.getAppUrl()%>action/searchCity.jsp?hidcitycontrol="+varTextControl+"&hidstatecontrol="+varTextControl1+"&hidcitycodecontrol="+varHidControl+"&hidstatecodecontrol="+varHidControl1+"&hidzipcontrol="+varTextControl2+"&hidzipvaildatorcontrol="+varHidControl2;
		var title = "City";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
		}
}	
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body onload="callOnload()">
<form name="colForm" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td colspan="2"><jsp:include page="../share/Applurllinkper.jsp"
			flush="true">
			<jsp:param name="pageid" value="4" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">Home -&gt; Retail
		-&gt; Collateral
		Security -&gt; Immovable Property</td>
	</tr>
</table>
<lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="45%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="left">
			<tr align="center">
				<td class="sub_tab_active" width="15%"><b>Immovable Property</b></td>
				<td class="sub_tab_inactive" width="15%"><b><a href="JavaScript:callCar()">Vehicle</a></b></td>
				<td class="sub_tab_inactive" width="15%"><a href="JavaScript:callotherassets()"> <b>Other assets</b> </a></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
							<tr>
								<td>
								<table width="50%" border="0" cellspacing="3" cellpadding="3" class="outertable" align="left">
									<tr>
										<td align="right" id="prm" width="48%">Applicant
										Type</td>
										<td width="52%" id="com3"><select
											name="selapptype" onChange="getCollData()">
											<option value="" selected>&lt;---- Select ----&gt;</option>
											<lapschoice:fincoappguarantor />
										</select></td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
											<tr>
												<td width="35%">
												<table width="100%" border="1" cellspacing="0"
													cellpadding="0" class="outertable">
													<tr>
														<td>
														<table width="100%" border="0" cellspacing="0"
															cellpadding="4" class="outertable">
															<tr>
																<td colspan="6"><b>Location of Asset </b></td>
															</tr>
															<tr>
																<td width="27%">First Title Holder<font color="#CC0000"><b>(*)</b></font>
																</td>
																<td width="73%"><input type="text"
																	name="txthome_contperson" size="75" maxlength="50"
																	value="<%=Helper.correctNull((String)hshValues.get("home_contperson"))%>"
																	onKeyPress="notAllowSingleQuote()" tabindex="1"></td>
															</tr>
															<tr>
																<td width="27%">Second Title Holder</td>
																<td colspan="5" width="73%"><input type="text"
																	name="txthome_contperson2" size="75" maxlength="50"
																	value="<%=Helper.correctNull((String)hshValues.get("home_contperson"))%>"
																	onKeyPress="notAllowSingleQuote()" tabindex="2"></td>
															</tr>
															<tr>
																<td width="27%">Third Title Holder</td>
																<td colspan="5" width="73%"><input type="text"
																	name="txthome_contperson3" size="75" maxlength="50"
																	value="<%=Helper.correctNull((String)hshValues.get("home_contperson"))%>"
																	onKeyPress="notAllowSingleQuote()" tabindex="3"></td>
															</tr>
															<tr>
																<td width="27%">Address</td>
																<td colspan="5" width="73%"><input type="text"
																	name="txthome_titleadd1" size="45" maxlength="45"
																	value="<%=Helper.correctNull((String)hshValues.get("home_titleadd1"))%>"
																	onKeyPress="notAllowSingleQuote()" tabindex="4"></td>
															</tr>
															<tr>
																<td width="27%">&nbsp;</td>
																<td colspan="5" width="73%"><input type="text"
																	name="txthome_titleadd2" size="45" maxlength="45"
																	value="<%=Helper.correctNull((String)hshValues.get("home_titleadd2"))%>"
																	onKeyPress="notAllowSingleQuote()" tabindex="5"></td>
															</tr>
															<tr>
																<td width="27%">City</td>
																<td colspan="5" width="73%"><input type="text"
																	name="txthome_titlecity" size="45" maxlength="45"
																	value="<%=Helper.correctNull((String)hshValues.get("home_titlecity"))%>"
																	onKeyPress="notAllowSingleQuote()"> &nbsp; <b><span
																	onClick="showCitySearch('txthome_titlecity','txthome_titlestate','hidcity','hidstate','txthome_titlezip','hidzip')"
																	style="cursor:hand" tabindex="6"><img
																	src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
																	border="0"></span></b></td>
															</tr>
															<tr>
																<td width="27%">State</td>
																<td colspan="5" width="73%"><input type="text"
																	name="txthome_titlestate" size="45" maxlength="45"
																	value="<%=Helper.correctNull((String)hshValues.get("home_titlestate"))%>"
																	onBlur="changecase(this)"
																	onKeyPress="notAllowSingleQuote()" tabindex="7"></td>
															</tr>
															<tr>
																<td width="27%"><%=ApplicationParams.getZipName()%></td>
																<td colspan="5" width="73%"><input type="text"
																	name="txthome_titlezip" size="10"
																	maxlength="<%=ApplicationParams.getZipValue()%>"
																	value="<%=Helper.correctNull((String)hshValues.get("home_titlezip"))%>"
																	onKeyPress="allowInteger()"
																	onBlur="zipvalidate(this,'<%=ApplicationParams.getZipValue()%>')"
																	tabindex="8"></td>
															</tr>
															<tr>
																<td nowrap width="27%">Other Informations</td>
																<td colspan="5" width="73%"><input type="text"
																	name="txthome_other" size="80" maxlength="200"
																	value="<%=Helper.correctNull((String)hshValues.get("home_other"))%>"
																	onKeyPress="" tabindex="9"></td>
															</tr>
														</table>
														</td>
													</tr>
												</table>
												</td>
												<td width="39%" rowspan="2" valign="top">
												<table width="100%" border="0" cellspacing="0"
													cellpadding="0" class="outertable">
													<tr>
														<td valign="top">
														<table width="100%" border="1" cellspacing="0"
															cellpadding="0" class="outertable">
															<tr>
																<td valign="top">
																<table width="100%" border="0" cellspacing="0"
																	cellpadding="4" class="outertable">
																	<tr>
																		<td colspan="2"><b>Other Details</b></td>
																		<td width="45%">&nbsp;</td>
																	</tr>
																	<tr>
																		<td width="35%">Year Built</td>
																		<td width="5%">&nbsp;</td>
																		<td width="60%"><input type="text"
																			name="txthome_yrbuilt" size="9" maxlength="4"
																			value="<%=Helper.correctNull((String)hshValues.get("home_yrbuilt"))%>"
																			onBlur="checkcurrentyear(this,currdate)" onKeyPress="notAllowSpace();allowInteger()"
																			tabindex="11"></td>
																	</tr>
																	<tr>
																		<td width="35%">Immovable property Extent (Sq.ft)</td>
																		<td width="5%">&nbsp;</td>
																		<td width="60%"><input type="text"
																			name="txthome_extent" size="15" maxlength="9"
																			value="<%=Helper.correctNull((String)hshValues.get("home_extent"))%>"
																			onKeyPress="notAllowSpace();allowInteger()"
																			tabindex="12"></td>
																	</tr>
																	<tr>
																		<td width="35%">Survey No</td>
																		<td width="5%">&nbsp;</td>
																		<td width="60%"><input type="text"
																			name="txthome_surveyno" size="15" maxlength="10"
																			value="<%=Helper.correctNull((String)hshValues.get("home_surveyno"))%>"
																			onKeyPress="notAllowSplChar()" tabindex="13"></td>
																	</tr>
																	<tr>
																		<td width="35%" nowrap>Purchase Price</td>
																		<td width="5%"><%=ApplicationParams.getCurrency()%></td>
																		<td width="60%"><input type="text"
																			name="txthome_purchaseval" size="15" maxlength="12"
																			style="text-align:right"
																			value="<%=Helper.correctNull((String)hshValues.get("home_purchaseval"))%>"
																			onKeyPress="notAllowSpace();allowNumber(document.forms[0].txthome_purchaseval)"
																			onBlur="roundtxt(document.forms[0].txthome_purchaseval)"
																			tabindex="14"></td>
																	</tr>
																	<tr>
																		<td width="35%" nowrap>Mortgage Bal. (if any)</td>
																		<td width="5%"><%=ApplicationParams.getCurrency()%></td>
																		<td width="60%"><input type="text"
																			name="txthome_mortval" size="15" maxlength="12"
																			style="text-align:right"
																			value="<%=Helper.correctNull((String)hshValues.get("home_mortval"))%>"
																			onKeyPress="notAllowSpace();allowNumber(document.forms[0].txthome_mortval)"
																			onBlur="roundtxt(document.forms[0].txthome_mortval)"
																			tabindex="15"></td>
																	</tr>
																	<tr>
																		<td width="35%">Description</td>
																		<td width="5%">&nbsp;</td>
																		<td width="60%"><textarea name="txthome_desc"
																			cols="50" rows="4"
																			onKeyPress="checkEnter();textlimit(txthome_desc,180);notAllowSingleQuote()" onKeyUp="textlimit(this,180)"
																			tabindex="16"><%=Helper.correctNull((String) hshValues.get("home_desc"))%></textarea>
																		</td>
																	</tr>
																	<tr>
																		<td width="35%">&nbsp;</td>
																		<td width="5%">&nbsp;</td>
																		<td width="60%">&nbsp;</td>
																	</tr>
																</table>
																</td>
															</tr>
														</table>
														</td>
													</tr>
													<tr>
														<td valign="top">
														<table width="100%" border="1" cellspacing="0"
															cellpadding="0" class="outertable">
															<tr>
																<td>
																<table width="100%" border="0" cellpadding="3"
																	cellspacing="0" class="outertable">
																	<tr>
																		<td width="35%" nowrap>&nbsp;</td>
																		<td width="5%">&nbsp;</td>
																		<td width="60%">&nbsp;</td>
																	</tr>
																	<tr>
																		<td width="35%" nowrap>Last Property Tax Paid Upto
																		(dd/mm/yyyy)</td>
																		<td width="5%">&nbsp;</td>
																		<td width="60%">
																		<table width="20%" border="0" cellspacing="0"
																			cellpadding="3" class="outertable">
																			<tr>
																				<td><input type="text" name="txthome_propertytax"
																					size="11"
																					value="<%=Helper.correctNull((String)hshValues.get("home_propertytax"))%>"
																					onBlur="checkDate(this)" readOnly></td>
																				<td><a alt="Select date from calender" href="#"
																					onClick="callCalender('txthome_propertytax')"
																					onMouseOver="window.status='Date Picker';return true;"
																					onMouseOut="window.status='';return true;"
																					tabindex="17"><img
																					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																					border=0 alt="Select date from calender"></a></td>
																			</tr>
																		</table>
																		</td>
																	</tr>
																	<tr>
																		<td width="35%">Water Tax Paid Upto (dd/mm/yyyy)</td>
																		<td width="5%">&nbsp;</td>
																		<td width="60%">
																		<table width="20%" border="0" cellspacing="0"
																			cellpadding="3" class="outertable">
																			<tr>
																				<td><input type="text" name="txthome_watertax"
																					size="11"
																					value="<%=Helper.correctNull((String)hshValues.get("home_watertax"))%>"
																					onBlur="checkDate(this)" readOnly></td>
																				<td><a alt="Select date from calender" href="#"
																					onClick="callCalender('txthome_watertax')"
																					onMouseOver="window.status='Date Picker';return true;"
																					onMouseOut="window.status='';return true;"
																					tabindex="18"><img
																					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																					border=0 alt="Select date from calender"></a></td>
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
											<tr>
												<td width="35%" valign="top">
												<table width="100%" border="1" cellspacing="0"
													cellpadding="0" class="outertable">
													<tr>
														<td>
														<table width="100%" border="0" cellspacing="0"
															cellpadding="2" class="outertable">
															<tr>
																<td width="22%">&nbsp;</td>
																<td width="5%">&nbsp;</td>
																<td width="73%">&nbsp;</td>
															</tr>
															<tr>
																<td width="22%">Market Value</td>
																<td width="5%"><%=ApplicationParams.getCurrency()%></td>
																<td width="73%"><input type="text" name="txthome_appval"
																	size="15" maxlength="12" style="text-align:right"
																	value="<%=Helper.correctNull((String)hshValues.get("home_appval"))%>"
																	onKeyPress="allowNumber(document.forms[0].txthome_appval)"
																	onBlur="roundtxt(document.forms[0].txthome_appval)"
																	tabindex="10"></td>
															</tr>
															<tr>
																<td width="22%">&nbsp;</td>
																<td width="5%">&nbsp;</td>
																<td width="73%">&nbsp;</td>
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
<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<br>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
					<tr class="dataheader" align="center">
						<td width="6%">&nbsp;</td>
						<td width="24%"><b>TitleHolder</b></td>
						<td width="35%"><b>City</b></td>
						<td width="35%"><b>State</b></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td valign="top" align="center">
				<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
					<%v = (ArrayList) hshValues.get("vecData");
			//String inside = "N";
			if (v != null) {
				int vecsize = v.size();
				for (int l = 0; l < vecsize; l++) {
					g1 = (ArrayList) v.get(l);

					%>
					<tr class="datagrid">
						<td width="6%"><input type="radio" name="radiobutton"
							value="radiobutton" style="border-style:none"
							onClick="selectValues('<%=Helper.correctNull((String)g1.get(0))%>',
										'<%=Helper.correctNull((String)g1.get(1))%>',
										'<%=Helper.correctNull((String)g1.get(2))%>',
										'<%=Helper.correctNull((String)g1.get(3))%>',
										'<%=Helper.correctNull((String)g1.get(4))%>',
										'<%=Helper.correctNull((String)g1.get(5))%>',
										'<%=Helper.correctNull((String)g1.get(6))%>',
										'<%=Helper.correctNull((String)g1.get(7))%>',
										'<%=Helper.correctNull((String)g1.get(8))%>',
										'<%=Helper.correctNull((String)g1.get(9))%>',
										'<%=Helper.correctNull((String)g1.get(10))%>',
										'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) g1.get(11))))%>',
										'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) g1.get(12))))%>',
										'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) g1.get(13))))%>',
										'<%=Helper.correctNull((String)g1.get(14))%>',
										'<%=Helper.correctNull((String)g1.get(15))%>',
										'<%=Helper.correctNull((String)g1.get(16))%>',
										'<%=Helper.correctNull((String)g1.get(17))%>',
										'<%=Helper.replaceForJavaScriptString((String)g1.get(18))%>',
										'<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString((String)g1.get(19)))%>',
										'<%=Helper.correctNull((String)g1.get(20))%>',
										'<%=Helper.correctNull((String)g1.get(21))%>',
										'<%=Helper.correctNull((String)g1.get(22))%>',
										'<%=Helper.correctNull((String)g1.get(23))%>')">
						</td>
						<td width="24%"><%=Helper.correctNull((String) g1
											.get(4))%></td>
						<td width="35%"><%=Helper.correctNull((String) g1.get(20))%></td>
						<td width="35%"><%=Helper.correctNull((String) g1.get(21))%></td>
					</tr>
					<%}
			} else {

			%>
					<tr class="datagrid">
						<td width="6%">&nbsp;</td>
						<td width="24%">&nbsp;</td>
						<td width="35%">&nbsp;</td>
						<td width="35%">&nbsp;</td>
					</tr>
					<tr class="datagrid">
						<td width="6%">&nbsp;</td>
						<td width="24%">&nbsp;</td>
						<td width="35%">&nbsp;</td>
						<td width="35%">&nbsp;</td>
					</tr>
					<tr class="datagrid">
						<td width="6%">&nbsp;</td>
						<td width="24%">&nbsp;</td>
						<td width="35%">&nbsp;</td>
						<td width="35%">&nbsp;</td>
					</tr>
					<tr class="datagrid">
						<td width="6%">&nbsp;</td>
						<td width="24%">&nbsp;</td>
						<td width="35%">&nbsp;</td>
						<td width="35%">&nbsp;</td>
					</tr>
					<%}

			%>
				</table>
				</td>
			</tr>
		</table>
		<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/> <input type="hidden" name="hid_sino" value="">
<input type="hidden" name="hidDemoId"
	value="<%=request.getParameter("hidDemoId")%>"> <input type="hidden"
	name="radLoan" value="Y"> <input type="hidden" name="hidcity"> <input
	type="hidden" name="hidstate"> <input type="hidden" name="selapptype1">
	 <input type="hidden" name="hidzip" value="<%=Helper.correctNull((String) hshValues.get("state_validatepin"))%>">
</form>
</body>
</html>
