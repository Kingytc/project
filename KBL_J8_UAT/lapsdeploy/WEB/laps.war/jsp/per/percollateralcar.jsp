<%@include file="../share/directives.jsp"%>
<%String strAppValue = Helper.correctNull((String) hshValues.get("strAppValue"));
			String strcat = Helper.correctNull((String) hshValues.get("auto_category"));
			String strpricetype = Helper.correctNull((String) hshValues.get("auto_price_type"));
			String strage = Helper.correctNull((String) hshValues.get("auto_age"));
			ArrayList vecRow = null;
			ArrayList vecCol = new ArrayList();%>
<html>
<head>
<title>Personal - Collateral</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/per/percollateralcar.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script language="JavaScript">
var appURL="<%=ApplicationParams.getAppUrl()%>";
var selappvalue = "<%=strAppValue%>";
var strvalue="loan_appretail_colsec_vec.htm";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var varrecordflag="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";
var vartaxpd="<%=Helper.correctNull((String)hshValues.get("auto_lifetaxpd"))%>";
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callOnload()">
<form name="colForm" method="post" class="normal">
<jsp:include page="../share/Applurllinkper.jsp"
			flush="true">
			<jsp:param name="pageid" value="4" />
		</jsp:include>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Retail -&gt; Collateral Security -&gt; Vehicle</td>
	</tr>
</table>
<lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="bottom">
		<table width="45%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr align="center">
				<td class="sub_tab_inactive" width="15%"><a href="JavaScript:callhome()"><b>Immovable Property</b></a></td>
				<td class="sub_tab_active" width="15%"><b>Vehicle</b></td>
				<td class="sub_tab_inactive" width="15%"><a href="JavaScript:callotherassets()"><b>Other assets</b></a></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr>
						<td valign="top" align="center">
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td>
								<table width="60%" border="0" cellspacing="3" cellpadding="3" align="center" class="outertable">
									<tr>
										<td align="right"><a href="JavaScript:callApplicant()"> </a>Applicant Type</td>
										<td><select name="selapptype"
											onChange="getCollData()">
											<option value="">&lt;---- Select ----&gt;</option>
											<lapschoice:fincoappguarantor />
										</select></td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td valign="top" align="center">
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
									<tr>
										<td valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
											<tr>
												<td width="61%" valign="top">
												<table width="100%" border="1" cellspacing="0" cellpadding="3" class="outertable">
													<tr>
														<td valign="middle">
														<table width="94%" border="0" cellspacing="0"
															cellpadding="3" align="center" class="outertable">
															<tr>
																<td width="14%">Category <b><font size="1"
																	face="MS Sans Serif" color="#FF0000">*</font></b></td>
																<td width="27%"><select name="cmbauto_category">
																	<option value="s" selected>&lt;----Select----&gt;</option>
																	<%if (strcat.equals("new")) {%>
																	<option value="new" selected>New Vehicle</option>
																	<%} else {%>
																	<option value="new">New Vehicle</option>
																	<%}if (strcat.equals("used")) {%>
																	<option value="used" selected>Used Vehicle</option>
																	<%} else {%>
																	<option value="used">Used Vehicle</option>
																	<%}%>
																</select></td>
																<td width="15%">Make &amp; Model</td>
																<td width="4%">&nbsp;</td>
																<td width="18%"><input type="text" name="txtauto_make"
																	size="20" maxlength="15"
																	value="<%=Helper.correctNull((String)hshValues.get("auto_model"))%>"
																	onKeyPress="notAllowSingleQuote()"></td>
																<td width="22%"><input type="text" name="txtauto_model"
																	size="20" maxlength="20"
																	value="<%=Helper.correctNull((String)hshValues.get("auto_make"))%>"
																	onKeyPress="notAllowSingleQuote()"></td>
															</tr>
															<tr>
																<td width="14%">Name of the Dealer / Seller</td>
																<td width="27%"><input type="text" name="txtauto_dealer"
																	size="25"
																	value="<%=Helper.correctNull((String)hshValues.get("auto_dealer"))%>"
																	onKeyPress="notAllowSingleQuote()" maxlength="30"></td>
																<td width="15%">Serial No.</td>
																<td width="4%">&nbsp;</td>
																<td width="18%"><input type="text"
																	name="txtauto_serialno" size="20"
																	value="<%=Helper.correctNull((String)hshValues.get("auto_serialno"))%>"
																	onKeyPress="allowNumber(this)" maxlength="15"></td>
																<td width="22%">&nbsp;</td>
															</tr>
															<tr>
																<td width="14%">Approx. serviceable age of Vehicle</td>
																<td width="27%"><input type="text"
																	name="txtauto_ser_age" size="5" maxlength="2"
																	value="<%=Helper.correctNull((String)hshValues.get("auto_ser_age"))%>"
																	onKeyPress="allowInteger()"></td>
																<td width="15%">Cost of Vehicle</td>
																<td width="4%"><%=ApplicationParams.getCurrency()%></td>
																<td width="18%"><lapschoice:CurrencyTag
																	name="txtauto_cost" size="20" maxlength="15"
																	value='<%=Helper.correctNull((String)hshValues.get("auto_cost"))%>' /></td>
															</tr>
															<tr>
																<td width="14%">Type of Vehicle <b><font size="1"
																	face="MS Sans Serif" color="#FF0000">*</font> </b></td>
																<td width="27%"><select name="cmbauto_price_type">
																	<option value="s1" selected>&lt;----Select----&gt;</option>
																	<%if (strpricetype.equals("1")) {%>
																	<option value="1" selected>Two Wheeler</option>
																	<%} else {%>
																	<option value="1">Two Wheeler</option>
																	<%}if (strpricetype.equals("2")) {%>
																	<option value="2" selected>Three Wheeler</option>
																	<%} else {%>
																	<option value="2">Three Wheeler</option>
																	<%}if (strpricetype.equals("3")) {%>
																	<option value="3" selected>Four Wheeler</option>
																	<%} else {%>
																	<option value="3">Four Wheeler</option>
																	<%}%>
																</select></td>
																<td width="15%">Valuation as per garage certificate</td>
																<td width="4%"><%=ApplicationParams.getCurrency()%></td>
																<td width="18%"><lapschoice:CurrencyTag
																	name="txtauto_valuation" size="20" maxlength="15"
																	value='<%=Helper.correctNull((String)hshValues.get("auto_valuation"))%>' />
																</td>
															</tr>
															<tr>
																<td width="14%">Age of Vehicle</td>
																<td width="27%"><select name="cmbauto_age">
																	<option value="" selected>&lt;----Select----&gt;</option>
																	<%if (strage.equals("1")) {%>
																	<option value="1" selected>&lt;1 Year</option>
																	<%} else {%>
																	<option value="1">&lt;1 Year</option>
																	<%}if (strage.equals("2")) {%>
																	<option value="2" selected>Between 1 to 3 Years</option>
																	<%} else {%>
																	<option value="2">Between 1 to 3 Years</option>
																	<%}if (strage.equals("3")) {%>
																	<option value="3" selected>Between 3 to 5 Years</option>
																	<%} else {%>
																	<option value="3">Between 3 to 5 Years</option>
																	<%}%>
																</select></td>
																<td width="15%">Life Tax Paid</td>
																<td width="4%">&nbsp;</td>
																<td width="18%"><select name="sel_taxpaid"
																	onChange="showtaxpaid()">
																	<option value="n" selected>No</option>
																	<option value="y">Yes</option>
																</select></td>
																<td width="22%">&nbsp;</td>
															</tr>
															<tr id="t1">
																<td width="14%">Last Tax Paid upto</td>
																<td width="27%"><input type="text"
																	name="txtauto_lasttax" size="12" maxlength="10"
																	value="<%=Helper.correctNull((String)hshValues.get("auto_lasttax"))%>"
																	onBlur="checkDate(this)" readOnly> <a
																	alt="Select date from calender" href="#"
																	onClick="callCalender('txtauto_lasttax')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border=0 alt="Select date from calender"></a></td>
																<td width="15%">&nbsp;</td>
																<td width="4%">&nbsp;</td>
																<td>&nbsp;</td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td width="14%">&nbsp;</td>
																<td width="27%">&nbsp;</td>
																<td colspan="3">&nbsp;</td>
																<td width="22%">&nbsp;</td>
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
<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail'
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
	<br>
	<table width="94%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
		<tr>
			<td valign="top">
			<table width="100%" align="center" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
				<tr align="center" class="dataheader">
					<td width="4%">&nbsp;</td>
					<td width="12%" ><b>Category</b></td>
					<td width="12%"  ><b>Serial No.</b></td>
					<td width="12%" ><b> Cost of Vehicle</b></td>
					<td width="12%"><b>Type of Vehicle</b></td>
					<td width="12%"><b>Age of Vehicle</b></td>
					<td width="16%"><b>Last Tax Paid upto</b></td>
				</tr>
				<%vecRow = (ArrayList) hshValues.get("vecRow");
			if (vecRow != null && vecRow.size() > 0) {
				for (int i = 0; i < vecRow.size(); i++) {
					vecCol = (ArrayList) vecRow.get(i);%>
				<tr class="datagrid">
					<td width="4%" align=center><input type="radio"
						style="border:none" name="radiobutton" value="radiobutton"
						onClick="selectValues('<%=Helper.correctNull((String)vecCol.get(2))%>','<%=Helper.correctNull((String)vecCol.get(3))%>',
'<%=Helper.correctNull((String)vecCol.get(4))%>','<%=Helper.correctNull((String)vecCol.get(5))%>',
'<%=Helper.correctNull((String)vecCol.get(6))%>','<%=Helper.correctNull((String)vecCol.get(7))%>',
'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(14))))%>','<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(8))))%>',			
'<%=Helper.correctNull((String)vecCol.get(9))%>','<%=Helper.correctNull((String)vecCol.get(10))%>',
'<%=Helper.correctNull((String)vecCol.get(15))%>',
'<%=Helper.correctNull((String)vecCol.get(12))%>','<%=Helper.correctNull((String)vecCol.get(16))%>')">
					</td>
					<%String category = Helper.correctNull((String) vecCol
							.get(2));
					String categorytype = "";
					if (category.equalsIgnoreCase("new")) {
						categorytype = "New Vechicle";
					} else if (category.equalsIgnoreCase("used")) {
						categorytype = "Used Vechicle";
					}
					String vechicle = Helper.correctNull((String) vecCol.get(9));
					String vechicletype = "";
					if (vechicle.equalsIgnoreCase("1")) {
						vechicletype = "Two Wheeler";
					} else if (vechicle.equalsIgnoreCase("2")) {
						vechicletype = "Three Wheeler";
					} else if (vechicle.equalsIgnoreCase("3")) {
						vechicletype = "Four Wheeler";
					}
					String age = Helper.correctNull((String) vecCol.get(10));
					String agetype = "";
					if (age.equalsIgnoreCase("1")) {
						agetype = " < 1 Year";
					} else if (age.equalsIgnoreCase("2")) {
						agetype = "Between 1 to 3 Years";
					} else if (age.equalsIgnoreCase("3")) {
						agetype = "Between 3 to 5 Years";
					}%>
					<td width="12%" align="center">&nbsp;<%=categorytype%></td>
					<td width="12%" align="center">&nbsp;<%=Helper.correctNull((String) vecCol.get(6))%></td>
					<td width="12%" align="right">&nbsp;<%=Helper.correctNull((String) vecCol.get(14))%></td>
					<td width="12%" align="center">&nbsp;<%=vechicletype%></td>
					<td width="12%" align="center">&nbsp;<%=agetype%></td>
					<td width="16%" align="center">&nbsp;<%=Helper.correctNull((String) vecCol.get(12))%></td>
				</tr>
				<%}} else {%>
				<tr class="datagrid">
					<td align=center colspan="10">No Data Found</td>
				</tr>
				<%}%>
			</table>
	</td>
	</tr>
	</table>
	<br>
	<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<INPUT TYPE="hidden" name="hidauto_type" value="C"> 
<INPUT TYPE="hidden" name="radLoan" value="Y"> 
<input type="hidden" name="hid_strsno" value="<%=Helper.correctNull((String)hshValues.get("auto_sno"))%>" />
<input type="hidden" name="selapptype1"> 
<input type="hidden" name="cmbauto_category1"> 
<input type="hidden" name="cmbauto_price_type1"> 
<input type="hidden" name="cmbauto_age1">
</form>
</body>
</html>
