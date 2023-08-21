<%@include file="../share/directives.jsp"%>
<%String stroptions = " ";%>
<html>
<head>
<title>Life Style</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/per/perlifestyle.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/per/CommonFunction.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script>
var editlockflag="<%=hshValues.get("editlock")%>";
var editflag = 1;
var editcheck = "<%=request.getParameter("hideditflag")%>";
var appURL  ="<%=ApplicationParams.getAppUrl()%>"; 
var strvalue="loan_appretail_fin_lifestyle.htm";
var currentdate = "<%=Helper.getCurrentDateTime()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form method="post" class="normal"> <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
<jsp:param name="pageid" value="3" /></jsp:include> <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable"> 
<tr> <td class="page_flow">Home -&gt; Retail -&gt; Securities -&gt; Life 
Style</td></tr> </table><lapschoice:application /> <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable"> 
<tr> <td valign="bottom"> <table width="60%" border="0" cellspacing="1" cellpadding="3" class="outertable"> 
<tr align="center"> <td class="sub_tab_inactive" width="15%"><b><a href="JavaScript:callInvestment()" >Securities
</a></b></td>
<!--<td class="sub_tab_inactive" width="15%"><b><a href="JavaScript:callInsurancePolicy()" >Insurance 
Policies </a></b></td>-->
<td class="sub_tab_inactive" width="15%"><b><a href="JavaScript:callLiabilities()" >Liabilities</a></b></td>
<!--<td class="sub_tab_active" width="15%"><b>LifeStyle</b></td>-->
</tr>
</table></td></tr> </table><table width="100%" border="0" cellspacing="0" cellpadding="3"
	height="340" class="outertable"> <tr> <td valign="top"> <table width="100%" border="0" cellspacing="0" cellpadding="3"
			 height="100%" class="outertable"> <tr> <td valign="top"><br> 
<br> <table border="0" cellspacing="0" cellpadding="3" width="70%" align="center" class="outertable"> 
<tr> <td> <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor"> 
<tr class="dataheader" align="center"> <td width="21%">&nbsp;</td><td width="13%">Available</td><td width="25%">Purchase 
Date</td><td width="21%">Market Value</td><td width="22%">Loan Amount if Any</td></tr> 
<tr class="datagrid"> <td width="21%">Owning a Vehicle/FourWheeler</td><td width="13%" ALIGN="CENTER"><select name="select1"
									OnChange="getSelectedvalue('select1','hidselect1')" disabled="disabled"> 
<%stroptions = Helper.correctNull((String) hshValues.get("lifestyle_car"));%> 
<option value="2" selected="selected">No</option> <%if (stroptions.equals("1")) {%> 
<option value="1" selected="selected">Yes</option> <%} else {%> <option value="1">Yes</option> 
<%}%> </select></td><td width="23%" ALIGN="CENTER"><input type="text" name="txt_date1" size="10"
									maxlength="25"
									onBlur="checkDate(this);checkmaxdate(this,currentdate)"
									value="<%=Helper.correctNull((String)hshValues.get("LIFESTYLE_CAR_DATE"))%>"> 
<a href="#" onClick="callCalender('txt_date1')"
									title="Click to view calender" border="0"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									width="0" border="0" tabindex="23"></a></td><td width="21%" ALIGN="CENTER"><lapschoice:CurrencyTag name="txt_market1"
									size="15" maxlength="9"
									value='<%=Helper.correctNull((String)hshValues.get("LIFESTYLE_CAR_MARKET"))%>' /></td><td width="22%" ALIGN="CENTER"><lapschoice:CurrencyTag name="txt_loanamt1"
									size="15" maxlength="9"
									value='<%=Helper.correctNull((String)hshValues.get("LIFESTYLE_CAR_LOANAMT"))%>' /></td></tr> 
<tr class="datagrid"> <td width="21%">Owning a Vehicle/TwoWheeler</td><td width="13%" ALIGN="CENTER"><select name="select2"
									OnChange="getSelectedvalue('select2','hidselect2')" disabled="disabled"> 
<%stroptions = Helper.correctNull((String) hshValues
					.get("lifestyle_scooter"));%> <option value="2" selected="selected">No</option> 
<%if (stroptions.equals("1")) {%> <option value="1" selected="selected">Yes</option> 
<%}else {%> <option value="1">Yes</option> <%}%> </select></td><td width="23%" ALIGN="CENTER"><input type="text" name="txt_date2" size="10"
									maxlength="25"
									onBlur="checkDate(this);checkmaxdate(this,currentdate)"
									value="<%=Helper.correctNull((String)hshValues.get("LIFESTYLE_SCOOTER_DATE"))%>"> 
<a href="#" onClick="callCalender('txt_date2')"
									title="Click to view calender" border="0"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									width="0" border="0" tabindex="23"></a></td><td width="21%" ALIGN="CENTER"><lapschoice:CurrencyTag name="txt_market2"
									size="15" maxlength="9"
									value='<%=Helper.correctNull((String)hshValues.get("LIFESTYLE_SCOOTER_MARKET"))%>' /></td><td width="22%" ALIGN="CENTER"><lapschoice:CurrencyTag name="txt_loanamt2"
									size="15" maxlength="9"
									value='<%=Helper.correctNull((String)hshValues.get("LIFESTYLE_SCOOTER_LOANAMT"))%>' /></td></tr> 
<tr class="datagrid"> <td width="21%">Fridge</td><td width="13%" ALIGN="CENTER"><select name="select3"
									OnChange="getSelectedvalue('select3','hidselect3')" disabled="disabled"
									style="visibility: "> 
<%stroptions = Helper.correctNull((String) hshValues
					.get("lifestyle_fridge"));%> <option value="2" selected="selected">No</option> 
<%if (stroptions.equals("1")) {%> <option value="1" selected="selected">Yes</option> 
<%} else {%> <option value="1">Yes</option> <%}%> </select></td><td width="23%" ALIGN="CENTER"><input type="text" name="txt_date3" size="10"
									maxlength="25"
									onBlur="checkDate(this);checkmaxdate(this,currentdate)"
									value="<%=Helper.correctNull((String)hshValues.get("LIFESTYLE_FRIDGE_DATE"))%>"> 
<a href="#" onClick="callCalender('txt_date3')"
									title="Click to view calender" border="0"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									width="0" border="0" tabindex="23"></a></td><td width="21%" ALIGN="CENTER"><lapschoice:CurrencyTag name="txt_market3"
									size="15" maxlength="9"
									value='<%=Helper.correctNull((String)hshValues.get("LIFESTYLE_FRIDGE_MARKET"))%>' /></td><td width="22%" ALIGN="CENTER"><lapschoice:CurrencyTag name="txt_loanamt3"
									size="15" maxlength="9"
									value='<%=Helper.correctNull((String)hshValues.get("LIFESTYLE_FRIDGE_LOANAMT"))%>' /></td></tr> 
<tr class="datagrid"> <td width="21%">Telephone</td><td width="13%" ALIGN="CENTER"><select name="select4"
									OnChange="getSelectedvalue('select4','hidselect4')" disabled="disabled"> 
<%stroptions = Helper.correctNull((String) hshValues
					.get("lifestyle_telephone"));%> <option value="2" selected="selected">No</option> 
<%if (stroptions.equals("1")) {%> <option value="1" selected="selected">Yes</option> 
<%} else {%> <option value="1">Yes</option> <%}%> </select></td><td width="23%" ALIGN="CENTER"><input type="text" name="txt_date4" size="10"
									maxlength="25"
									onBlur="checkDate(this);checkmaxdate(this,currentdate)"
									value="<%=Helper.correctNull((String)hshValues.get("LIFESTYLE_TELEPHONE_DATE"))%>"> 
<a href="#" onClick="callCalender('txt_date4')"
									title="Click to view calender" border="0"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									width="0" border="0" tabindex="23"></a></td><td width="21%" ALIGN="CENTER"><lapschoice:CurrencyTag name="txt_market4"
									size="15" maxlength="9"
									value='<%=Helper.correctNull((String)hshValues.get("LIFESTYLE_TELEPHONE_MARKET"))%>' /></td><td width="22%" ALIGN="CENTER"><lapschoice:CurrencyTag name="txt_loanamt4"
									size="15" maxlength="9"
									value='<%=Helper.correctNull((String)hshValues.get("LIFESTYLE_TELEPHONE_LOANAMT"))%>' /></td></tr> 
<tr class="datagrid"> <td width="21%">Computer/Laptop</td><td width="13%" ALIGN="CENTER"><select name="select5"
									OnChange="getSelectedvalue('select5','hidselect5')" disabled="disabled"
									style="visibility: "> 
<%stroptions = Helper.correctNull((String) hshValues
					.get("lifestyle_computer"));%> <option value="2" selected="selected">No</option> 
<%if (stroptions.equals("1")) {%> <option value="1" selected="selected">Yes</option> 
<%} else {%> <option value="1">Yes</option> <%}%> </select></td><td width="23%" ALIGN="CENTER"><input type="text" name="txt_date5" size="10"
									maxlength="25"
									onBlur="checkDate(this);checkmaxdate(this,currentdate)"
									value="<%=Helper.correctNull((String)hshValues.get("LIFESTYLE_COMPUTER_DATE"))%>"> 
<a href="#" onClick="callCalender('txt_date5')"
									title="Click to view calender" border="0"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									width="0" border="0" tabindex="23"></a></td><td width="21%" ALIGN="CENTER"><lapschoice:CurrencyTag name="txt_market5"
									size="15" maxlength="9"
									value='<%=Helper.correctNull((String)hshValues.get("LIFESTYLE_COMPUTER_MARKET"))%>' /></td><td width="22%" ALIGN="CENTER"><lapschoice:CurrencyTag name="txt_loanamt5"
									size="15" maxlength="9"
									value='<%=Helper.correctNull((String)hshValues.get("LIFESTYLE_COMPUTER_LOANAMT"))%>' /></td></tr> 
<tr class="datagrid"> <td width="21%">&nbsp;Cell Phone</td><td width="13%" ALIGN="CENTER"><select name="select6"
									OnChange="getSelectedvalue('select6','hidselect6')" disabled="disabled"
									style="visibility: "> 
<%stroptions = Helper.correctNull((String) hshValues
					.get("lifestyle_mobile"));%> <option value="2" selected="selected">No</option> 
<%if (stroptions.equals("1")) {%> <option value="1" selected="selected">Yes</option> 
<%} else {%> <option value="1">Yes</option> <%}%> </select></td><td width="23%" ALIGN="CENTER"><input type="text" name="txt_date6" size="10"
									maxlength="25"
									onBlur="checkDate(this);checkmaxdate(this,currentdate)"
									value="<%=Helper.correctNull((String)hshValues.get("LIFESTYLE_MOBILE_DATE"))%>"> 
<a href="#" onClick="callCalender('txt_date6')"
									title="Click to view calender" border="0"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									width="0" border="0" tabindex="23"></a></td><td width="21%" ALIGN="CENTER"><lapschoice:CurrencyTag name="txt_market6"
									size="15" maxlength="9"
									value='<%=Helper.correctNull((String)hshValues.get("LIFESTYLE_MOBILE_MARKET"))%>' /></td><td width="22%" ALIGN="CENTER"><lapschoice:CurrencyTag name="txt_loanamt6"
									size="15" maxlength="9"
									value='<%=Helper.correctNull((String)hshValues.get("LIFESTYLE_MOBILE_LOANAMT"))%>' /></td></tr> 
<tr class="datagrid"> <td width="21%">&nbsp;WashingMachine</td><td width="13%" ALIGN="CENTER"><select name="select7"
									OnChange="getSelectedvalue('select7','hidselect7')" disabled="disabled"
									style="visibility: "> 
<%stroptions = Helper.correctNull((String) hshValues
					.get("lifestyle_washing_machine"));%> 
<option value="2" selected="selected">No</option> <%if (stroptions.equals("1")) {%> 
<option value="1" selected="selected">Yes</option> <%} else {%> <option value="1">Yes</option> 
<%}%> </select></td><td width="23%" ALIGN="CENTER"><input type="text" name="txt_date7" size="10"
									maxlength="25"
									onBlur="checkDate(this);checkmaxdate(this,currentdate)"
									value="<%=Helper.correctNull((String)hshValues.get("LIFESTYLE_WASHING_MACHINE_DATE"))%>"> 
<a href="#" onClick="callCalender('txt_date7')"
									title="Click to view calender" border="0"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									width="0" border="0" tabindex="23"></a></td><td width="21%" ALIGN="CENTER"><lapschoice:CurrencyTag name="txt_market7"
									size="15" maxlength="9"
									value='<%=Helper.correctNull((String)hshValues.get("LIFESTYLE_WASHING_MARKET"))%>' /></td><td width="22%" ALIGN="CENTER"><lapschoice:CurrencyTag name="txt_loanamt7"
									size="15" maxlength="9"
									value='<%=Helper.correctNull((String)hshValues.get("LIFESTYLE_WASHING_LOANAMT"))%>' /></td></tr> 
<tr class="datagrid"> <td width="21%">&nbsp;Television</td><td width="13%" ALIGN="CENTER"><select name="select8"
									OnChange="getSelectedvalue('select8','hidselect8')" disabled="disabled"
									style="visibility: "> 
<%stroptions = Helper.correctNull((String) hshValues
					.get("lifestyle_television"));%> <option value="2" selected="selected">No</option> 
<%if (stroptions.equals("1")) {%> <option value="1" selected="selected">Yes</option> 
<%} else {%> <option value="1">Yes</option> <%}%> </select></td><td width="23%" ALIGN="CENTER"><input type="text" name="txt_date8" size="10"
									maxlength="25"
									onBlur="checkDate(this);checkmaxdate(this,currentdate)"
									value="<%=Helper.correctNull((String)hshValues.get("LIFESTYLE_TELEVISION_DATE"))%>"> 
<a href="#" onClick="callCalender('txt_date8')"
									title="Click to view calender" border="0"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									width="0" border="0" tabindex="23"></a></td><td width="21%" ALIGN="CENTER"><lapschoice:CurrencyTag name="txt_market8"
									size="15" maxlength="9"
									value='<%=Helper.correctNull((String)hshValues.get("LIFESTYLE_TELEVISION_MARKET"))%>' /></td><td width="22%" ALIGN="CENTER"><lapschoice:CurrencyTag name="txt_loanamt8"
									size="15" maxlength="9"
									value='<%=Helper.correctNull((String)hshValues.get("LIFESTYLE_TELEVISION_LOANAMT"))%>' /></td></tr> 
</table></td></tr> </table></td></tr> </table></td></tr> </table><br> <%String strappno = request.getParameter("appno");%> 
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<br> <lapschoice:hiddentag pageid='<%=PageId%>'/> <input type="hidden" name="hidappno" value="<%=(String)request.getParameter("appno")%>"> 
<input type="hidden" name="hidselect1" value="<%=((String)hshValues.get("lifestyle_car"))%>"> 
<input type="hidden" name="hidselect2" value="<%=((String)hshValues.get("lifestyle_scooter"))%>"> 
<input type="hidden" name="hidselect3" value="<%=((String)hshValues.get("lifestyle_fridge"))%>"> 
<input type="hidden" name="hidselect4" value="<%=((String)hshValues.get("lifestyle_telephone"))%>"> 
<input type="hidden" name="hidselect5" value="<%=((String)hshValues.get("lifestyle_computer"))%>"> 
<input type="hidden" name="hidselect6" value="<%=((String)hshValues.get("lifestyle_mobile"))%>"> 
<input type="hidden" name="hidselect7" value="<%=((String)hshValues.get("lifestyle_washing_machine"))%>"> 
<input type="hidden" name="hidselect8" value="<%=((String)hshValues.get("lifestyle_television"))%>"> 
<input type="hidden" name="hidAppType"> <input type="hidden" name="radLoan" value="Y"> 
</form>
</body>
</html>
